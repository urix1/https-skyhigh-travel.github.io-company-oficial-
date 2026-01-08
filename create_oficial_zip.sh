#!/usr/bin/env bash
set -euo pipefail

# Script para crear oficial.zip con la estructura lista para subir a:
# https://<tu-org>.github.io/company/oficial/
# Ejecutar en Linux/macOS/WSL.

OUTDIR="oficial"
ZIPNAME="oficial.zip"

rm -rf "$OUTDIR" "$ZIPNAME"
mkdir -p "$OUTDIR/asset/css" "$OUTDIR/asset/js" "$OUTDIR/asset/images"

cat > "$OUTDIR/index.html" <<'HTML'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Skyhighdooficial | Aviación Privada de Clase Mundial</title>
  <meta name="description" content="Skyhighdooficial — Experiencia de aviación privada de lujo. Alquiler de jets, vuelos chárter y servicios ejecutivos con seguridad y puntualidad." />
  <meta name="keywords" content="vuelos privados, alquiler de jets, aviación ejecutiva, Skyhighdo" />
  <link rel="icon" href="asset/images/favicon.svg" />
  <link rel="stylesheet" href="asset/css/style.css" />
  <script defer src="asset/js/main.js"></script>
</head>
<body>
  <header class="site-header">
    <div class="container header-inner">
      <a id="logo" class="logo" href="/" aria-label="Skyhighdo - Inicio">
        <img src="asset/images/logo.svg" alt="Skyhighdooficial" width="220" height="56">
      </a>
      <nav class="main-nav" aria-label="Navegación principal">
        <ul>
          <li><a href="#servicios">Servicios</a></li>
          <li><a href="#flota">Flota</a></li>
          <li><a href="#contacto" class="btn-primary">Contactar</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main id="root">
    <section class="hero">
      <div class="container hero-inner">
        <div class="hero-copy">
          <h1>Viaja con discreción, lujo y puntualidad</h1>
          <p>Skyhighdooficial ofrece servicios de aviación privada y chárter personalizados para clientes que exigen lo mejor.</p>
          <div class="hero-ctas">
            <a class="btn-primary" href="#contacto">Reservar Jet</a>
            <a class="btn-secondary" href="#flota">Nuestra Flota</a>
          </div>
        </div>
        <div class="hero-media">
          <img src="asset/images/hero-jet.svg" alt="Jet privado Skyhighdo" loading="lazy">
        </div>
      </div>
    </section>

    <section id="servicios" class="section">
      <div class="container">
        <h2>Nuestros Servicios</h2>
        <div class="grid services-grid">
          <article><h3>Alquiler de Jets</h3><p>Flota moderna y tripulación certificada para vuelos nacionales e internacionales.</p></article>
          <article><h3>Chárter Corporativo</h3><p>Itinerarios flexibles y atención premium para viajes de negocio.</p></article>
          <article><h3>Servicios a Medida</h3><p>Traslados VIP y logística de eventos para clientes exclusivos.</p></article>
        </div>
      </div>
    </section>

    <section id="flota" class="section alt">
      <div class="container">
        <h2>Nuestra Flota</h2>
        <div class="grid fleet-grid">
          <figure><img src="asset/images/plane-1.svg" alt="Jet ejecutivo" loading="lazy"></figure>
          <figure><img src="asset/images/plane-2.svg" alt="Cabina de lujo" loading="lazy"></figure>
          <figure><img src="asset/images/plane-3.svg" alt="Exterior de jet" loading="lazy"></figure>
        </div>
      </div>
    </section>

    <section id="contacto" class="section contact">
      <div class="container">
        <h2>Contacto</h2>
        <div class="contact-grid">
          <form id="contactForm" aria-label="Formulario de contacto">
            <label for="name">Nombre</label><input id="name" name="name" required>
            <label for="email">Correo</label><input id="email" name="email" type="email" required>
            <label for="message">Mensaje</label><textarea id="message" name="message" rows="5" required></textarea>
            <button type="submit" class="btn-primary">Enviar</button>
          </form>
          <div class="contact-info">
            <h3>Contacta con nosotros</h3>
            <p>Email: <a href="mailto:skyhighdoagency@gmail.com">skyhighdoagency@gmail.com</a></p>
            <p>Tel: <a href="tel:+14323161990">+1 432 316 1990</a></p>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer class="site-footer">
    <div class="container"><small>© <span id="year"></span> Skyhighdooficial. Todos los derechos reservados.</small></div>
  </footer>

  <!-- Floating FABs -->
  <div id="floating-actions" aria-hidden="false">
    <div class="fab fab-whatsapp" id="fabWhats" title="Contactar por WhatsApp">
      <button id="whatsappMain" aria-haspopup="true" aria-expanded="false"><span class="fab-icon">🟢</span></button>
      <div class="fab-menu" id="whatsappMenu" role="menu" aria-hidden="true">
        <button data-number="+14323161990" role="menuitem">US +1 432 316 1990</button>
        <button data-number="+17862954684" role="menuitem">US +1 786 295 4684</button>
      </div>
    </div>
    <div class="fab fab-mail" id="fabMail" title="Contactar por correo">
      <a id="mailLink" href="mailto:skyhighdoagency@gmail.com?subject=Solicitud%20de%20Informaci%C3%B3n%20-%20Skyhighdooficial"><span class="fab-icon">✉️</span></a>
    </div>
  </div>

  <!-- Admin modal (triple-click logo) -->
  <div id="adminModal" class="modal" aria-hidden="true">
    <div class="modal-content" role="dialog" aria-modal="true" aria-labelledby="adminTitle">
      <button class="modal-close" id="adminClose" title="Cerrar panel">✕</button>
      <h2 id="adminTitle">Panel de Control — Skyhighdooficial</h2>
      <form id="adminLogin" class="admin-form" autocomplete="off" novalidate>
        <label for="adminUser">Usuario</label><input id="adminUser" name="user" autocomplete="username" required>
        <label for="adminPass">Contraseña</label><input id="adminPass" name="pass" type="password" autocomplete="current-password" required>
        <div class="admin-actions"><button type="submit" class="btn-primary">Entrar</button></div>
        <div id="adminMsg" class="admin-msg" role="status" aria-live="polite"></div>
      </form>
      <div id="adminPanel" class="admin-panel" hidden>
        <h3>Acciones rápidas</h3>
        <p>Usuario: <strong>urix</strong></p>
        <button id="flushCache" class="btn-secondary">Vaciar caché (simulado)</button>
        <button id="logout" class="btn-secondary">Cerrar sesión</button>
      </div>
    </div>
  </div>

  <script>document.getElementById('year').textContent = new Date().getFullYear();</script>
</body>
</html>
HTML

cat > "$OUTDIR/asset/css/style.css" <<'CSS'
:root{
  --navy:#071a2b;
  --gold:#d4a900;
  --platinum:#eef2f6;
  --muted:#6b7280;
  --white:#ffffff;
  --radius:10px;
  --max-width:1200px;
}
*{box-sizing:border-box}
body{font-family:Inter,system-ui,-apple-system,Segoe UI,Roboto,"Helvetica Neue",Arial;line-height:1.45;color:#0b1220;margin:0;background:var(--white)}
.container{max-width:var(--max-width);margin:0 auto;padding:1rem}
.header-inner{display:flex;align-items:center;justify-content:space-between;padding:1rem 0}
.logo img{display:block;transform-style:preserve-3d;transition:transform .45s cubic-bezier(.2,.9,.2,1),box-shadow .35s}
.logo:hover img{transform: translateZ(10px) rotateY(6deg) translateY(-2px); box-shadow: 0 18px 40px rgba(10,20,30,.18)}
.main-nav ul{list-style:none;margin:0;padding:0;display:flex;gap:1rem;align-items:center}
.main-nav a{color:var(--navy);text-decoration:none;padding:.35rem .5rem;border-radius:6px}
.btn-primary{background:var(--navy);color:var(--white);padding:.65rem 1rem;border-radius:8px;text-decoration:none;display:inline-block}
.btn-secondary{background:transparent;border:1px solid rgba(11,18,32,.06);padding:.5rem .9rem;border-radius:8px}
.hero{padding:3rem 0;display:flex;align-items:center}
.hero-inner{display:flex;gap:2rem;align-items:center}
.hero-copy{flex:1}
.hero-media img{max-width:520px;border-radius:12px;box-shadow:0 12px 30px rgba(10,20,30,.12)}
.grid{display:grid;gap:1rem}
.services-grid{grid-template-columns:repeat(auto-fit,minmax(220px,1fr))}
.fleet-grid{grid-template-columns:repeat(auto-fit,minmax(180px,1fr))}
.section{padding:2.4rem 0}
.section.alt{background:linear-gradient(180deg,#fafbfd,#ffffff)}
.contact-grid{display:grid;grid-template-columns:1fr 320px;gap:1.5rem}
@media(max-width:900px){.hero-inner{flex-direction:column}.contact-grid{grid-template-columns:1fr} .main-nav{display:none}}

/* Floating action buttons */
#floating-actions{position:fixed;right:20px;bottom:20px;display:flex;flex-direction:column;align-items:end;gap:12px;z-index:1200}
.fab{position:relative;display:flex;align-items:center;justify-content:center}
.fab button, .fab a{display:flex;align-items:center;justify-content:center;width:56px;height:56px;border-radius:50%;border:0;background:var(--navy);color:var(--white);cursor:pointer;box-shadow:0 12px 26px rgba(2,6,23,.18)}
.fab .fab-icon{font-size:20px}
.fab-whatsapp button{animation:fabPulse 4000ms ease-in-out infinite}
@keyframes fabPulse{
  0%{transform:scale(1)}
  50%{transform:scale(1.06)}
  100%{transform:scale(1)}
}
.fab-mail a{animation:fabRotate 8000ms linear infinite}
@keyframes fabRotate{0%{transform:rotate(0deg)}50%{transform:rotate(6deg)}100%{transform:rotate(0deg)}}
.fab-menu{position:absolute;right:70px;bottom:0;display:flex;flex-direction:column;gap:6px;padding:8px;background:#fff;border-radius:10px;box-shadow:0 10px 24px rgba(10,20,30,.12);opacity:0;transform:translateY(6px);pointer-events:none;transition:opacity .18s,transform .18s}
.fab-menu button{background:transparent;border:0;padding:.45rem .65rem;border-radius:8px;cursor:pointer}
.fab.open .fab-menu{opacity:1;transform:translateY(0);pointer-events:auto}

/* Modal / admin panel */
.modal{position:fixed;inset:0;display:grid;place-items:center;background:rgba(2,6,23,.45);z-index:2000;visibility:hidden;opacity:0;transition:opacity .18s,visibility .18s}
.modal[aria-hidden="false"]{visibility:visible;opacity:1}
.modal-content{background:#fff;padding:1.25rem;border-radius:12px;max-width:520px;width:95%;box-shadow:0 20px 60px rgba(2,6,23,.28)}
.modal-close{position:absolute;right:16px;top:16px;border:0;background:transparent;font-size:18px;cursor:pointer}

/* small helpers */
.lead{color:var(--muted)}
.admin-msg{margin-top:.6rem;color:#c0392b}
CSS

cat > "$OUTDIR/asset/js/main.js" <<'JS'
// Main interactions: floating FABs, whatsapp menu, admin panel (triple-click), contact form (simulated)
// NOTE: No external telemetry; no third-party badges. Replace credentials with secure auth in production.

document.addEventListener('DOMContentLoaded', function() {
  // Floating WhatsApp menu
  const fab = document.getElementById('fabWhats');
  const menu = document.getElementById('whatsappMenu');
  const mainBtn = document.getElementById('whatsappMain');

  function toggleMenu(open) {
    if(open === undefined) open = !fab.classList.contains('open');
    fab.classList.toggle('open', open);
    menu.setAttribute('aria-hidden', (!open).toString());
    mainBtn.setAttribute('aria-expanded', open.toString());
  }

  mainBtn.addEventListener('click', function(e){
    e.stopPropagation();
    toggleMenu();
  });

  menu.querySelectorAll('button').forEach(btn => {
    btn.addEventListener('click', function(){
      const num = btn.getAttribute('data-number');
      const txt = encodeURIComponent('Hola, ¿me puedes dar información sobre los vuelos con Skyhighdooficial?');
      // Open WhatsApp (web or app)
      const url = `https://api.whatsapp.com/send?phone=${num.replace(/\D/g,'')}&text=${txt}`;
      window.open(url, '_blank', 'noopener');
    });
  });

  // Close menu on outside click
  document.addEventListener('click', function(e){
    if(!fab.contains(e.target)) toggleMenu(false);
  });

  // Mail FAB already uses mailto in HTML - add slight aria behaviour
  const mailLink = document.getElementById('mailLink');
  mailLink.addEventListener('click', function(){ /* native mailto handles compose */ });

  // Admin panel: open on triple-click of logo (three clicks within 700ms)
  const logo = document.getElementById('logo');
  const adminModal = document.getElementById('adminModal');
  const adminForm = document.getElementById('adminLogin');
  const adminPanel = document.getElementById('adminPanel');
  const adminMsg = document.getElementById('adminMsg');
  const adminClose = document.getElementById('adminClose');

  (function setupTripleClick() {
    let clicks = 0, timer = 0;
    logo.addEventListener('click', function(e){
      clicks++;
      if(clicks === 1) {
        timer = setTimeout(()=>{ clicks = 0; }, 700);
      } else if(clicks === 3) {
        clearTimeout(timer); clicks = 0;
        openAdmin();
      }
    });
  })();

  function openAdmin() {
    adminModal.setAttribute('aria-hidden','false');
    document.body.style.overflow = 'hidden';
  }
  function closeAdmin() {
    adminModal.setAttribute('aria-hidden','true');
    document.body.style.overflow = '';
    adminForm.reset();
    adminPanel.hidden = true;
    adminMsg.textContent = '';
  }
  adminClose.addEventListener('click', closeAdmin);
  adminModal.addEventListener('click', function(e){ if(e.target === adminModal) closeAdmin(); });

  // NOTE: Authentication here is client-side to satisfy the requested behavior.
  // Credentials are provided as requested: user: urix, pass: 18058008
  // SECURITY: Replace this with server-side auth for production.
  const AUTH = { user: 'urix', pass: '18058008' };

  adminForm.addEventListener('submit', function(e){
    e.preventDefault();
    const user = adminForm.user.value.trim();
    const pass = adminForm.pass.value;
    if(user === AUTH.user && pass === AUTH.pass) {
      adminMsg.textContent = '';
      adminForm.hidden = true;
      adminPanel.hidden = false;
    } else {
      adminMsg.textContent = 'Credenciales incorrectas.';
    }
  });

  // Example admin actions (simulated)
  document.getElementById('flushCache')?.addEventListener('click', function(){
    alert('Simulación: Caché vaciada.');
  });
  document.getElementById('logout')?.addEventListener('click', function(){
    adminForm.hidden = false;
    adminPanel.hidden = true;
    adminForm.user.value = '';
    adminForm.pass.value = '';
  });

  // Contact form: simulate submit (no server). Replace with server endpoint or Formspree, Netlify forms, etc.
  const contactForm = document.getElementById('contactForm');
  contactForm?.addEventListener('submit', function(e){
    e.preventDefault();
    // Basic validation shown here; implement real submit later
    alert('Gracias. Su mensaje ha sido recibido (simulado).');
    contactForm.reset();
  });
});
JS

cat > "$OUTDIR/asset/images/logo.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150">
  <rect width="100%" height="100%" fill="none" />
  <text x="50%" y="55%" font-family="Georgia, serif" font-size="46" fill="#071a2b" text-anchor="middle">Skyhighdooficial</text>
</svg>
SVG

cat > "$OUTDIR/asset/images/favicon.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64">
  <rect width="64" height="64" rx="10" fill="#071a2b"/>
  <circle cx="32" cy="32" r="12" fill="#d4a900" />
</svg>
SVG

cat > "$OUTDIR/asset/images/hero-jet.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
  <rect width="100%" height="100%" fill="#f6f8fb"/>
  <text x="50%" y="50%" font-family="Arial, sans-serif" font-size="24" fill="#9aa4b2" text-anchor="middle">Imagen de hero — reemplazar por foto real</text>
</svg>
SVG

cat > "$OUTDIR/asset/images/plane-1.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200"><rect width="100%" height="100%" fill="#ffffff"/><text x="50%" y="50%" font-size="18" text-anchor="middle" fill="#9aa4b2">Plane 1 — placeholder</text></svg>
SVG

cat > "$OUTDIR/asset/images/plane-2.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200"><rect width="100%" height="100%" fill="#ffffff"/><text x="50%" y="50%" font-size="18" text-anchor="middle" fill="#9aa4b2">Plane 2 — placeholder</text></svg>
SVG

cat > "$OUTDIR/asset/images/plane-3.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200"><rect width="100%" height="100%" fill="#ffffff"/><text x="50%" y="50%" font-size="18" text-anchor="middle" fill="#9aa4b2">Plane 3 — placeholder</text></svg>
SVG

cat > "$OUTDIR/README.md" <<'MD'
# Oficial — Skyhighdooficial (paquete listo)

Carpeta: oficial/

Contenido inicial:
- index.html
- asset/css/style.css
- asset/js/main.js
- asset/images/* (placeholders SVG)

Cómo publicar (ejemplo con SSH):
1. Clona tu repo:
   git clone git@github.com:skyhigh-travel/company.git
   cd company

2. Crea branch:
   git checkout -b feature/oficial

3. Copia la carpeta 'oficial' desde este ZIP al repo (o descomprime y mueve).
   git add oficial
   git commit -m "feat: add landing oficial (initial)"
   git push origin feature/oficial

4. Abre PR contra main y revisa antes de merge.

AVISO: El panel admin incluido usa autenticación client-side con credenciales en claro (usuario: urix, pass: 18058008). Elimina o protege esto antes de publicar en un repo público.
MD

# create zip
zip -r "$ZIPNAME" "$OUTDIR" >/dev/null

echo "Creado: $ZIPNAME"
echo "Contenido:"
unzip -l "$ZIPNAME" | sed -n '4,200p'
echo ""
echo "Para extraer: unzip $ZIPNAME"