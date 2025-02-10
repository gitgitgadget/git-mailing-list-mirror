Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B01B87EF
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173289; cv=none; b=p7G3/7NnMNtc435KFI5b1Ryi6+OGRD49sGgyESJiLGlXUl0ZmDTcbGvlst7UsNUvWroldQdkLG+n2lBwgEOXlS+2BbTyQIxIJzA0JJ4Oc4yREXhuJAcfccBfZxUDo4578HORIPrKNTelGNj83sC43puz8IvklJ9GN8+6eS8lLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173289; c=relaxed/simple;
	bh=VQH5t9G8Vab+AIbmDrYDafvJC3bGxAv0q7PWl3gL4Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxx+gOPoBiBiW1j/rNhXNOOq+Z8twfsAAykjt72yj7yJ0hJ25Ey1kWOa0nwiDnndBRn3pCKzMAj3UBTc29L+jfsFaQNhbX/A8cEi/E1/F91+8chSOUMDOBXkKPQG+VODFD1q4CF/BufsLXJVzZ3A1DItzyUuL9hf0kpDHwTZnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RHaY1nGX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sWD9pwCz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RHaY1nGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sWD9pwCz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 15FCD13805F7;
	Mon, 10 Feb 2025 02:41:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 02:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739173286; x=1739259686; bh=D4LNup6+xQ
	kzYVCciKv4I9A90hw6cck4Z7Gae97pltQ=; b=RHaY1nGXbWlQcGlfJV1UDxO1zQ
	ZD4uyX+sDp1Qz+LMyzVfy5VgxA56trr4VASHG015Jc455pFrKNH0qV/3hIHn1pyV
	jVZausx8zcBaAfhNtFb1UpdUZlRLqBLQSlDMwKK7NNPnDtP4GRMaA8ybO2U7h/aH
	BgV52F7sz35cRoz8YoZooVQGCIRSUjUUwzhFRv27RBVCeM8j4gbpzn0KZK1HMPl9
	+UiPPltmtKiS3dQhJJYtu7GP3816Mzr6xkm4Dayoi+YKw+0DRD1nTklgVrcGgMPv
	e0NsCbLs37VRH6yFWnx+Jvl/v2yNv5Tu0fK4fYBKNYIC/5H4HAb8hZHzUQvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739173286; x=1739259686; bh=D4LNup6+xQkzYVCciKv4I9A90hw6cck4Z7G
	ae97pltQ=; b=sWD9pwCzqtQiiwCDic2KUnBO1O1TcvmApPKM9h47/OHYg7klW8e
	16DSemorxpMI1IN/C8gneafsN+Hj6fot6cVD/8nIwBAyr73eUO2oS9te7C2JEEfC
	hYh0Uf59zasWtiPHq64gW6KHF5max6hFDSNPDOzB7bKMcdxicWdgU0ojhyLl2a49
	SGdqQ87a+Pi58IX0PVOXFgOprvWAREC5PuKZ0C3ER2BrRaHRg54aJjYatWQkLQvj
	EB/r1FmGjfLytobuY2k4bfEPShqWSIF9U8k44oZIXJdP/4AWqFPGmdUfKkhro9lp
	Px5VwBQRsDVNomJ5nhLVPT2FVB1mi6z5edQ==
X-ME-Sender: <xms:pa2pZ_gyQ_vNg4TuaI6QUmmd0sQr3L8fZiwnoHEgTf76lZB-djgAyg>
    <xme:pa2pZ8Cf_a_5oNCIFlLGEKdAPTZOrgedsDpnKBQOVF3K_fdHVPi2Xy0qwca6xwCkb
    OtQ8OBaQWasCPmy1A>
X-ME-Received: <xmr:pa2pZ_Hc44iMTjTR378dGNo4TFR27R5LejpJ6Cy_6q-OBaFvHpF656MtP_OKUky-6nqv8zWVT7k5nyfg82rPxYxi3BUw7-DXL6PGjsUwsloYZu-L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsrdhr
    vghpohhrthesghhmgidrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:pa2pZ8QElfJaZa2ixSxz9QyUNQJHvcd76cqjYWZYiND43v00N3HHQQ>
    <xmx:pa2pZ8zjrsSD_YIuAfm7nE07ALRS64zB3TIKoJvU5bMyy08fnRap0w>
    <xmx:pa2pZy7iFkjgoaSng1bsNfAgaL0_X_NoiKHLuBQzQ3lREKjDEIDi8g>
    <xmx:pa2pZxwz-Rny5mZlj_bKbMmJs64uT_xaihe_CntK-MUZDXkqxCJXNw>
    <xmx:pq2pZ38eTldBR6uGmVoOIocd8d0i9iLj878S57tNwnHFxGGJ9Ggd9tpx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 02:41:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 79f7237c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 07:41:23 +0000 (UTC)
Date: Mon, 10 Feb 2025 08:41:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peter Seiderer <ps.report@gmx.net>
Cc: git@vger.kernel.org
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
Message-ID: <Z6mtnmvKMsIOEVz5@pks.im>
References: <20250209133027.64a865aa@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209133027.64a865aa@gmx.net>

On Sun, Feb 09, 2025 at 01:30:27PM +0100, Peter Seiderer wrote:
[snip]
>   The meson build tries to execute the non-existent '/usr/bin/sh' (instead of
>   '/bin/sh' as the autoconf build), 'which sh' on the host returns
>   '/usr/bin/sh'...
> 
>   From meson.build
> 
>    [...]
>    186 shell = find_program('sh', dirs: program_path)
>    [...]
>    685   '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
> 
>   Do not use the result of 'find_program('sh',...)' for '-DSHELL_PATH='
>   (at least not for cross-compile), use fix '/bin/sh' instead or make it
>   configurable via a meson option?

Hm, very true. We're mixing up concerns here by treating the build
environment and the target environment the same.

I guess the proper fix is to wire up the "native:" parameter when we
call `find_program()`, which allows us to tell Meson whether it should
find an executable for the build or the target host. And then, for those
binaries where we actually need to know about both the build and target
host's locations, we'd end up calling `find_program()` twice.

For executables that are supposed to be used on the target host Meson
would then know to first consult the cross file, which could look like
this:

    [binaries]
    sh = '/target/path/to/sh'
    perl = '/target/path/to/perl'

Meson would then pick up that file via `meson setup --cross-file
<CROSSFILE_PATH> <BUILDDIR>`.

The patch should look somewhat like the attached patch, but it conflicts
with my in-flight patch series at [1]. I'll wait for that series to be
merged to `next` before sending out the fix.

Thanks for your report!

Patrick

[1]: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>

-- >8 --

diff --git a/Documentation/meson.build b/Documentation/meson.build
index c6117366ff..b033f4a93a 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -206,9 +206,9 @@ manpages = {
 
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
@@ -216,7 +216,7 @@ if docs_backend == 'auto'
 endif
 
 if docs_backend == 'asciidoc'
-  asciidoc = find_program('asciidoc', dirs: program_path)
+  asciidoc = find_program('asciidoc', native: true, dirs: program_path)
   asciidoc_html = 'xhtml11'
   asciidoc_docbook = 'docbook'
   xmlto_extra = [ ]
@@ -245,7 +245,7 @@ if docs_backend == 'asciidoc'
     asciidoc_conf,
   ]
 elif docs_backend == 'asciidoctor'
-  asciidoctor = find_program('asciidoctor', dirs: program_path)
+  asciidoctor = find_program('asciidoctor', native: true, dirs: program_path)
   asciidoc_html = 'xhtml5'
   asciidoc_docbook = 'docbook5'
   xmlto_extra = [
@@ -283,7 +283,7 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-xmlto = find_program('xmlto', dirs: program_path)
+xmlto = find_program('xmlto', dirs: program_path, native: true)
 
 cmd_lists = [
   'cmds-ancillaryinterrogators.txt',
@@ -404,7 +404,7 @@ if get_option('docs').contains('html')
     pointing_to: 'git.html',
   )
 
-  xsltproc = find_program('xsltproc', dirs: program_path)
+  xsltproc = find_program('xsltproc', dirs: program_path, native: true)
 
   user_manual_xml = custom_target(
     command: asciidoc_common_options + [
diff --git a/gitweb/meson.build b/gitweb/meson.build
index 89b403dc9d..88a54b4dc9 100644
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
index e153a43918..5a5662bc02 100644
--- a/meson.build
+++ b/meson.build
@@ -173,7 +173,7 @@ project('git', 'c',
   # The version is only of cosmetic nature, so if we cannot find a shell yet we
   # simply don't set up a version at all. This may be the case for example on
   # Windows systems, where we first have to bootstrap the host environment.
-  version: find_program('sh', required: false).found() ? run_command(
+  version: find_program('sh', native: true, required: false).found() ? run_command(
     'GIT-VERSION-GEN', meson.current_source_dir(), '--format=@GIT_VERSION@',
     capture: true,
     check: true,
@@ -198,16 +198,18 @@ elif host_machine.system() == 'windows'
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
@@ -758,6 +760,7 @@ endif
 build_options_config.set_quoted('X', executable_suffix)
 
 python = import('python').find_installation('python3', required: get_option('python'))
+target_python = find_program('python3', native: false, required: python.found())
 if python.found()
   build_options_config.set('NO_PYTHON', '')
 else
@@ -775,7 +778,8 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
+perl = find_program('perl', version: '>=5.8.1', dirs: program_path, native: true, required: perl_required)
+target_perl = find_program('perl', version: '>=5.8.1', native: false, required: perl.found())
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
   build_options_config.set('NO_PERL', '')
@@ -825,7 +829,7 @@ else
   build_options_config.set('NO_PTHREADS', '1')
 endif
 
-msgfmt = find_program('msgfmt', dirs: program_path, required: false)
+msgfmt = find_program('msgfmt', dirs: program_path, native: true, required: false)
 gettext_option = get_option('gettext').disable_auto_if(not msgfmt.found())
 if not msgfmt.found() and gettext_option.enabled()
   error('Internationalization via libintl requires msgfmt')
@@ -1954,9 +1958,9 @@ foreach key, value : {
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
index 1faf9a44ce..986c2e03be 100644
--- a/templates/meson.build
+++ b/templates/meson.build
@@ -1,6 +1,6 @@
 template_config = configuration_data()
-template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
-template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
+template_config.set('PERL_PATH', perl.found() ? fs.as_posix(target_perl.full_path()) : '')
+template_config.set('SHELL_PATH', fs.as_posix(target_shell.full_path()))
 template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
 configure_file(
