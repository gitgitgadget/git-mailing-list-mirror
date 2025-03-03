Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C820B818
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003876; cv=none; b=XYx6aYYiGTUCVCsQfNpApR0JtQXAjBH5/mmVDwAGI3kXUL5BO+kYuJWPVvBMfMrAhvNUvORr8ickf7nonEpwB+r5fcr30msFMkgym/eO9CdZYH6VlFwzWoxP7Nz8eku3Wn6Dh1WJU3MOVOWUBMboBSOy4vNHewcTDAQ7pM+E3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003876; c=relaxed/simple;
	bh=qL3z7tJycHeOXYXv5ufhgoSuUgra45WinVDJuUiZGao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y55j3ki1yT1Uxkd7g0jAwbxyIDoZBX0CLndJc6rkWScduZVb2iotCaaoHQ/Uq4ugpDm1CC7XAKdn+Ld8vIQYvZ/6g4AXd7FCPf5oqQw3lwa+kzMiTWMpIzPluOT51Chgjk1oO7Kh8pdonAjhhW4Rz1pe/lO9xI7Gfd1fV8jPGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bwvd+dTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8UPr95tU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bwvd+dTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8UPr95tU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3137A138016A;
	Mon,  3 Mar 2025 07:11:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 07:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1741003872; x=1741090272; bh=fNuYh8alqx
	sEUEeRzcFGoV030JyOSV7aY+P72DHpMWY=; b=bwvd+dTOCNjKzZskdcy4H0MtcO
	c//K7h/vZoiNZnpy3KlM1z301ZugKVtNUx6o/5W/MTFDdu6BtG+q3jtZZKcFTfw6
	CTO9gDEFgtXCyGCOCu/dN0yyHMu0k/9BkiIRlbDfeoNOm0FdS1u/vMIRTYwIVP0P
	N3Md4OPVOyjMImyPLQmWpQHixv7Gs8Qac52AvkpfyhZJyTZU0uufEN6ylThcyCrT
	lERZJa6TNVLKJDaW8ouXeALKQUrn3iutn1ewdntaNTsy385JcZjYro+cIjQ1NPuD
	nnW+BvUAvP+/fCu5NEDrtMYwJHusxbQZahXNTYNOTdy8q+rO4SUKk+ii34YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741003872; x=1741090272; bh=fNuYh8alqxsEUEeRzcFGoV030JyO
	SV7aY+P72DHpMWY=; b=8UPr95tU+WAcNCMlwvTMyTbw514L2qjHSfPr0xCAJ+oR
	puYpghc1mdvXs6naoTnLSyxOa4GGtD9lUmtkYTGSf0QQWS6qERG6odkPGwuY79YN
	T5MOgU1BIaJYDUuiZDJj4yh7GdOGrrFRiGJ8AyjW1mcTkNYAZ2mJKm0/V22zyw8n
	NgUWk82nufg8TjOaYH5pJVxyu1HvrWgDj7Kt32GOGuZ6S2znU5Kh5bRwhQ5gU7lg
	R0u68FSbHjoZqzjEv+idd7AIuzHuNYCpoEZwZetC3z7I1wWeoEEuMn2XZ8fO7CZ5
	Adv8+VV6oovHcZcy83AyOREx9xwHNY+BT+0ad36A+w==
X-ME-Sender: <xms:X5zFZy72wdfGmIVX3Lq8jW_sl9L0AnlNFFasPuGZpWUxdgUV5vBH8g>
    <xme:X5zFZ75BIT-_gZiYQ0TcsjbibkEKLI1A5l1fJimuH9eOVczt2ySjSm8Iz_zBkeu_1
    shBoGr5lPA1yuDGpw>
X-ME-Received: <xmr:X5zFZxcKwhhD8Lp5-0U9SexH2A4IIwfM4orOe9fX65HNcC6bxI-NxzI-IeyP2XBtsY7HVrxqmRCNpNnBlWEdFGwJSyQnMMq_xgsRpLfnObiGnfWK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelledutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhheekkeeg
    gefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehpshdrrhgvphhorhhtsehgmhigrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrgh
X-ME-Proxy: <xmx:X5zFZ_JhxmOJuUbyBwJ8hfCrI1Z-HpL2uzKn1EA5Up8rRwMMF7Wh1w>
    <xmx:X5zFZ2Lk0hrVIK5JVfxDBUmfBf8cKEMLLf0JrdaYm396RICzXRXcug>
    <xmx:X5zFZwzmOeyz55f6Ro6o41mLyPTr6h9Gx6uagpcBmVyhAPlWLbBTbA>
    <xmx:X5zFZ6JMA4fQABUIZ3OFpM5p9tpY8K6uuNV4UU6Vwx-TOYrlc5l-AA>
    <xmx:YJzFZ7ENYXr7bOK78vIQEXew8HZPetLZhZCuINF0L88OTdDztm_pdxQh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 07:11:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc53cabc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 12:11:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 13:10:59 +0100
Subject: [PATCH] meson: distinguish build and target host binaries
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>
X-B4-Tracking: v=1; b=H4sIAFKcxWcC/x3MQQqAIBBA0avErBuwJKyuEi3KJhsqFQciiO6et
 HyL/x8QSkwCffFAoouFg8+oygLsNnlHyEs21KpulFYa4y54kgSPNgURtOGMfLB3aOZp0cq0c0c
 t5D4mWvn+38P4vh8Y6TPyawAAAA==
X-Change-ID: 20250303-pks-meson-cross-compiling-7bad3078b9e8
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 Peter Seiderer <ps.report@gmx.net>
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch addresses the issue reported at [1], where it is impossible
to specify the shell, Python and Perl paths during cross-compilation
when using Meson.

The series is built on top of master at cb0ae672aea (A bit more post
-rc0, 2025-02-27) with junio/ps/build-meson-fixes-0130 at 9350423982a
(gitlab-ci: restrict maximum number of link jobs on Windows, 2025-02-26)
merged into it.

Thanks!

Patrick

[1]: <20250209133027.64a865aa@gmx.net>
---
 Documentation/meson.build | 12 ++++-----
 gitweb/meson.build        |  2 +-
 meson.build               | 66 ++++++++++++++++++++++++++++++++++++-----------
 templates/meson.build     |  4 +--
 4 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 0a0f2bfa14a..63891fb4455 100644
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
@@ -284,7 +284,7 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-xmlto = find_program('xmlto', dirs: program_path)
+xmlto = find_program('xmlto', dirs: program_path, native: true)
 
 cmd_lists = [
   'cmds-ancillaryinterrogators.adoc',
@@ -405,7 +405,7 @@ if get_option('docs').contains('html')
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
index 516207f9cfe..0a229f44199 100644
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
@@ -1975,9 +2011,9 @@ foreach key, value : {
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

---
base-commit: af208620eecbe9b4655e06a28d5146a40738150e
change-id: 20250303-pks-meson-cross-compiling-7bad3078b9e8

