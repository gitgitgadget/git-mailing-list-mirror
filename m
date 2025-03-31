Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3D1DDC2A
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410006; cv=none; b=dmqQ0l3x43CojpVpkYVx1v+GmFQr8dOS+avrY7m3OQNniF8HcldS7mXcR3tRM2gy/r3VGoZjE5xDFbc1VBojNgRgtnrSmXspVk/4pNxSA3I4JbbRTDfg26i5xZtfCzpcI5tWJ1P2CSOn0vl6jGI+98EtOO5aSmjkeqtyZiDD4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410006; c=relaxed/simple;
	bh=J+pEa1ide/Se74jdpvRyLrNUDtn4wWvJGmy1LCoQtTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2EUPozSjugfgyim8ohgAMmMafzZ4wg9hm1MRllWMguTizY7k5IuW27BWb8YDJORLEhQtF9qFMopoA+0HcWSQOHjyZJEYz9jRsG/CQxYxATM7ulbQ9OmI1ci9cCrOhRSvmCTILVzPVAreeTvVMNm15JfVGsMrq5+fEXCMCJK6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PbuWyhM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmTBtCfx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PbuWyhM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmTBtCfx"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FC89114008F;
	Mon, 31 Mar 2025 04:33:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 31 Mar 2025 04:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410003;
	 x=1743496403; bh=ln3+rGRrZN+7eClGfI1lSUDarKZ06mgvSovSFUKIISk=; b=
	PbuWyhM632wwOG9xz5N5Nls19EpJgTLbXK7VOi+VbOOZOro2kZzowjBS19vuLZOo
	g2+lQ2tZWTUl+lQBhYDC63C2DEN1HfwPInC9mV8JQlxkGUx3hl0iGGUBoQVjDbfb
	thhkVEgibJLsPNpvw/xHLjdSTB3C5AEznKNfIcyvmKVJd5fClKYn6/GebGoXfbCG
	ESI/ha9ZmWeQQRBdUBDywTJ6JdliWz49rrHjjDtBajzbeVLZVyUhrRBWAL/ae7m7
	pzAK/a0ZutX16pPca0nLI1xa4Nwiom4LIjvQws6Iq8ojw6SD0Uhw2sqdT5b2QQXD
	V/d1+ZJbLum86GuLxdOFWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410003; x=
	1743496403; bh=ln3+rGRrZN+7eClGfI1lSUDarKZ06mgvSovSFUKIISk=; b=W
	mTBtCfxbmaOqaTfhkhj7uersRl7gt5p8oGJhIVBeNo4vPXO7vogR7JztHhZHW69i
	8cb+yfmIFdQe4nCaTMSGFqT+0pmsY+pJJWkrZCt8Pt8NMSy3bE3Km9kYqi6tydB6
	OKpg6mVStY2RYmiHa7KezsH1fxq9ydAJ19saDiNY6yjPzwAZSf1AP/N0ZLKjFFPv
	7xvK9ORdwMRQOTkvR+VEW7Vx1d2tb12Jrsg4iSyGt7ypXWPlh6ikYEsZCjKKAvqq
	m19I4h6WmV4LnXfCCrrDMsYMx736RXSre+cUJ2vUrCQudqesuwojnfKRoEJP1xDo
	QE3rT+FK0muQABeW3xqIw==
X-ME-Sender: <xms:UlPqZz2-lcPRe0izca5MBmpzuoW11twiLfHriD7p56Rmb_6PXFkdWA>
    <xme:UlPqZyHq3l3NPtCwtuxhzV_g4s3944tO3Nenbt8lvv1BE-gYygcPnU5t8uX6dsQPX
    Ph5VxGZWJZQa8sztw>
X-ME-Received: <xmr:UlPqZz6uD6oOTWygTwLa6e7g-k6jYr3OQMtYBK1QpARTBW1bwbbYrCS3vcTzU9YoQjP6gNRs5fe8Jhq6yepjSRkH8qn7UPRgz1UsQOIss9lbtk7t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepthhgseguvggsihgrnhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:UlPqZ41QRClE09u2yp9yu4sy1F5MOjVnxdBbjh8KQDMrgiwYba1Nuw>
    <xmx:UlPqZ2G-tLYg6AsA6e3l04Q-gZN2OVvz81GveRntdVo7eLjrIDwVmg>
    <xmx:UlPqZ5_RUk4-l96bNYnT7E8Mcy86clwCr7_HMc0wkcPgqOUXvzVBbA>
    <xmx:UlPqZzmsyVShCQ1_5mNV3o-wOlMctZEYpyOPdA0S9Xwtmn0RGthUqg>
    <xmx:U1PqZ50-y_wM4Pv3ztyFKLewdS2JByyy4vdankJ9zE_jUt00o8PvVVFw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:33:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6035dd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 08:33:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:33:10 +0200
Subject: [PATCH v2 4/5] meson: distinguish build and target host binaries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-b4-pks-collect-build-fixes-v2-4-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Peter Seiderer <ps.report@gmx.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Almost all of the tools we discover during the build process need to be
native programs. There are only a handful of exceptions, which typically
are programs whose paths we need to embed into the resulting executable
so that they can be found on the target system when Git executes. While
this distinction typically doesn't matter, it does start to matter when
considering cross-compilation where the build and target machines are
different.

Meson supports cross-compilation via so-called machine files. These
machine files allow the user to override parameters for the build
machine, but also for the target machine when cross-compiling. Part of
the machine file is a section that allows the user to override the
location where binaries are to be found in the target system. The
following machine file would for example override the path of the POSIX
shell:

    [binaries]
    sh = '/usr/xpg4/bin/sh'

It can be handed over to Meson via `meson setup --cross-file`.

We do not handle this correctly right now though because we don't know
to distinguish binaries for the build and target hosts at all. Address
this by explicitly passing the `native:` parameter to `find_program()`:

  - When set to `true`, we get binaries discovered on the build host.

  - When set to `false`, we get either the path specified in the
    machine file. Or, if no machine file exists or it doesn't specify
    the binary path, then we fall back to the binary discovered on the
    build host.

As mentioned, only a handful of binaries are not native: only the system
shell, Python and Perl need to be treated specially here.

Reported-by: Peter Seiderer <ps.report@gmx.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 12 ++++-----
 gitweb/meson.build        |  2 +-
 meson.build               | 66 ++++++++++++++++++++++++++++++++++++-----------
 templates/meson.build     |  4 +--
 4 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 594546d68b1..32f0c5de12a 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -207,9 +207,9 @@ manpages = {
 
 docs_backend = get_option('docs_backend')
 if docs_backend == 'auto'
-  if find_program('asciidoc', dirs: program_path, required: false).found()
+  if find_program('asciidoc', dirs: program_path, native: true, required: false).found()
     docs_backend = 'asciidoc'
-  elif find_program('asciidoctor', dirs: program_path, required: false).found()
+  elif find_program('asciidoctor', dirs: program_path, native: true, required: false).found()
     docs_backend = 'asciidoctor'
   else
     error('Neither asciidoc nor asciidoctor were found.')
@@ -217,7 +217,7 @@ if docs_backend == 'auto'
 endif
 
 if docs_backend == 'asciidoc'
-  asciidoc = find_program('asciidoc', dirs: program_path)
+  asciidoc = find_program('asciidoc', dirs: program_path, native: true)
   asciidoc_html = 'xhtml11'
   asciidoc_docbook = 'docbook'
   xmlto_extra = [ ]
@@ -246,7 +246,7 @@ if docs_backend == 'asciidoc'
     asciidoc_conf,
   ]
 elif docs_backend == 'asciidoctor'
-  asciidoctor = find_program('asciidoctor', dirs: program_path)
+  asciidoctor = find_program('asciidoctor', dirs: program_path, native: true)
   asciidoc_html = 'xhtml5'
   asciidoc_docbook = 'docbook5'
   xmlto_extra = [
@@ -288,7 +288,7 @@ if get_option('breaking_changes')
    asciidoc_common_options += ['--attribute', 'with-breaking-changes']
 endif
 
-xmlto = find_program('xmlto', dirs: program_path)
+xmlto = find_program('xmlto', dirs: program_path, native: true)
 
 cmd_lists = [
   'cmds-ancillaryinterrogators.adoc',
@@ -409,7 +409,7 @@ if get_option('docs').contains('html')
     pointing_to: 'git.html',
   )
 
-  xsltproc = find_program('xsltproc', dirs: program_path)
+  xsltproc = find_program('xsltproc', dirs: program_path, native: true)
 
   user_manual_xml = custom_target(
     command: asciidoc_common_options + [
diff --git a/gitweb/meson.build b/gitweb/meson.build
index 89b403dc9de..88a54b4dc99 100644
--- a/gitweb/meson.build
+++ b/gitweb/meson.build
@@ -1,5 +1,5 @@
 gitweb_config = configuration_data()
-gitweb_config.set_quoted('PERL_PATH', perl.full_path())
+gitweb_config.set_quoted('PERL_PATH', target_perl.full_path())
 gitweb_config.set_quoted('CSSMIN', '')
 gitweb_config.set_quoted('JSMIN', '')
 gitweb_config.set_quoted('GIT_BINDIR', get_option('prefix') / get_option('bindir'))
diff --git a/meson.build b/meson.build
index a8d1e63ccc6..79a50599ba8 100644
--- a/meson.build
+++ b/meson.build
@@ -155,6 +155,37 @@
 # These machine files can be passed to `meson setup` via the `--native-file`
 # option.
 #
+# Cross compilation
+# =================
+#
+# Machine files can also be used in the context of cross-compilation to
+# describe the target machine as well as the cross-compiler toolchain that
+# shall be used. An example machine file could look like the following:
+#
+#   [binaries]
+#   c = 'x86_64-w64-mingw32-gcc'
+#   cpp = 'x86_64-w64-mingw32-g++'
+#   ar = 'x86_64-w64-mingw32-ar'
+#   windres = 'x86_64-w64-mingw32-windres'
+#   strip = 'x86_64-w64-mingw32-strip'
+#   exe_wrapper = 'wine64'
+#   sh = 'C:/Program Files/Git for Windows/usr/bin/sh.exe'
+#
+#   [host_machine]
+#   system = 'windows'
+#   cpu_family = 'x86_64'
+#   cpu = 'x86_64'
+#   endian = 'little'
+#
+# These machine files can be passed to `meson setup` via the `--cross-file`
+# option.
+#
+# Note that next to the cross-compiler toolchain, the `[binaries]` section is
+# also used to locate a couple of binaries that will be built into Git. This
+# includes `sh`, `python` and `perl`, so when cross-compiling Git you likely
+# want to set these binary paths in addition to the cross-compiler toolchain
+# binaries.
+#
 # Subproject wrappers
 # ===================
 #
@@ -173,7 +204,7 @@ project('git', 'c',
   # The version is only of cosmetic nature, so if we cannot find a shell yet we
   # simply don't set up a version at all. This may be the case for example on
   # Windows systems, where we first have to bootstrap the host environment.
-  version: find_program('sh', required: false).found() ? run_command(
+  version: find_program('sh', native: true, required: false).found() ? run_command(
     'GIT-VERSION-GEN', meson.current_source_dir(), '--format=@GIT_VERSION@',
     capture: true,
     check: true,
@@ -198,16 +229,18 @@ elif host_machine.system() == 'windows'
   program_path = [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
 endif
 
-cygpath = find_program('cygpath', dirs: program_path, required: false)
-diff = find_program('diff', dirs: program_path)
-git = find_program('git', dirs: program_path, required: false)
-sed = find_program('sed', dirs: program_path)
-shell = find_program('sh', dirs: program_path)
-tar = find_program('tar', dirs: program_path)
+cygpath = find_program('cygpath', dirs: program_path, native: true, required: false)
+diff = find_program('diff', dirs: program_path, native: true)
+git = find_program('git', dirs: program_path, native: true, required: false)
+sed = find_program('sed', dirs: program_path, native: true)
+shell = find_program('sh', dirs: program_path, native: true)
+tar = find_program('tar', dirs: program_path, native: true)
+
+target_shell = find_program('sh', dirs: program_path, native: false)
 
 # Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
-  find_program(tool, dirs: program_path)
+  find_program(tool, dirs: program_path, native: true)
 endforeach
 
 script_environment = environment()
@@ -706,7 +739,7 @@ libgit_c_args = [
   '-DGIT_LOCALE_PATH="' + get_option('localedir') + '"',
   '-DGIT_MAN_PATH="' + get_option('mandir') + '"',
   '-DPAGER_ENV="' + get_option('pager_environment') + '"',
-  '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
+  '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
 ]
 libgit_include_directories = [ '.' ]
 libgit_dependencies = [ ]
@@ -761,6 +794,7 @@ endif
 build_options_config.set_quoted('X', executable_suffix)
 
 python = import('python').find_installation('python3', required: get_option('python'))
+target_python = find_program('python3', native: false, required: python.found())
 if python.found()
   build_options_config.set('NO_PYTHON', '')
 else
@@ -790,9 +824,11 @@ endif
 # which we can do starting with Meson 1.5.0 and newer, or we have to
 # match against the minor version.
 if meson.version().version_compare('>=1.5.0')
-  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=5.26.0', version_argument: '-V:version')
+  perl = find_program('perl', dirs: program_path, native: true, required: perl_required, version: '>=5.26.0', version_argument: '-V:version')
+  target_perl = find_program('perl', dirs: program_path, native: false, required: perl.found(), version: '>=5.26.0', version_argument: '-V:version')
 else
-  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=26')
+  perl = find_program('perl', dirs: program_path, native: true, required: perl_required, version: '>=26')
+  target_perl = find_program('perl', dirs: program_path, native: false, required: perl.found(), version: '>=26')
 endif
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
@@ -843,7 +879,7 @@ else
   build_options_config.set('NO_PTHREADS', '1')
 endif
 
-msgfmt = find_program('msgfmt', dirs: program_path, required: false)
+msgfmt = find_program('msgfmt', dirs: program_path, native: true, required: false)
 gettext_option = get_option('gettext').disable_auto_if(not msgfmt.found())
 if not msgfmt.found() and gettext_option.enabled()
   error('Internationalization via libintl requires msgfmt')
@@ -1974,9 +2010,9 @@ foreach key, value : {
   'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
   'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
   'PAGER_ENV': get_option('pager_environment'),
-  'PERL_PATH': perl.found() ? perl.full_path() : '',
-  'PYTHON_PATH': python.found () ? python.full_path() : '',
-  'SHELL_PATH': shell.full_path(),
+  'PERL_PATH': target_perl.found() ? target_perl.full_path() : '',
+  'PYTHON_PATH': target_python.found () ? target_python.full_path() : '',
+  'SHELL_PATH': target_shell.full_path(),
   'TAR': tar.full_path(),
   'TEST_OUTPUT_DIRECTORY': test_output_directory,
   'TEST_SHELL_PATH': shell.full_path(),
diff --git a/templates/meson.build b/templates/meson.build
index 1faf9a44cea..02e6eebe80b 100644
--- a/templates/meson.build
+++ b/templates/meson.build
@@ -1,6 +1,6 @@
 template_config = configuration_data()
-template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
-template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
+template_config.set('PERL_PATH', target_perl.found() ? fs.as_posix(target_perl.full_path()) : '')
+template_config.set('SHELL_PATH', fs.as_posix(target_shell.full_path()))
 template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
 configure_file(

-- 
2.49.0.604.gff1f9ca942.dirty

