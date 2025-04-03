Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7F221DB7
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669487; cv=none; b=VLN7NQt3AtrTvYEE/9NUZNhWOxwrume0IpbiGxoz7pnzeT08UZjXsERnGxF/YwdI0JZ5oQQAVLChqkk1JNWzAaEYKMf3xT6dqE2nFljFk0QF1N/JBcuwntPwZ5Wi+cW+WUiGpBuuckv3MC/E8Wax1uNDszCVzouuJaL/t3J6VE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669487; c=relaxed/simple;
	bh=RSEhaEn4O/7+/GrpDaiqozswMEs/nFwTwSfyVmpxPsw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFvkxW7lVEu03LaTh5yJ1NhTJo5VV3HfaZ7kanu4Yz/KMMCG/ZBPbKIISLse/+x+Zm6BQToSNEr9wWOmKyUxRQBg1WguRlVTltPUscEOUfMgtRaToia+BydfyKHsU8orknNx5x1V/dKdV9JX1+r8MN2oSEO08FNQILHlLHeUSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gISiLUfd; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gISiLUfd"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-524038ba657so722703e0c.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743669485; x=1744274285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T1d4c+8aRFAMfTVZhgYXvQITSlqC3Ww4AbLhLB6Ias=;
        b=gISiLUfd7F9/A2suJ4Y7+JUb3c+UutlETLRnhx3GLq4nEL4bx3+fyaf/JYwBwck7Pe
         aFJ1JW4u+xyBan2h3FtEyTHylvfg9aMzGaCnQCayhrBGmrquEZ4IDhOX9K8mTKgjNcKy
         zM+iz5M4OO+PrDLnvKF2qpz+jiIX4Q7h5b7E3ryCzNJgggV1Cwf4jMO0VEHG9LL1uWfd
         8M/RjSG94p0YIFnziRX/rtj0UTqajBr0+pmDSFO/0pQLqKfl3yFLF2kCoIBkhbsRMJ1r
         pD8mAvqrvhD/i5uWn8GsqOyJz062DNxBFhKFY6LSqw9yfJJh+UDTZHSehOnHof0lU4j8
         mc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743669485; x=1744274285;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8T1d4c+8aRFAMfTVZhgYXvQITSlqC3Ww4AbLhLB6Ias=;
        b=Nu82dytlFwvmbswvYJgxhQ4VNMsKtajzOX5IgR8XKIUH/XgfxH4bVvxODD6Qd1E/Y6
         5aYyCs43vRKGl1z+SSUrYVfsr/nZmTznH0liIMsPBhZztruwpByWLvEGjMj8qLFZJd2K
         LCCRGegCyOO/NtsnXuu+vsmmMQJ2PgxHEGGo/xXuOQJxvRshp7pmPNa+LVgzcjZR/Ntg
         cwSHUkjH1iKI7FlES+WI8wihdO5q51Gu2H8L6Dyr2Q2lqtkAqTuiltMxmMKJzFJ5k/MY
         kq9QLJQMzmJ8wMkkZjDYljJK4ngef5+dAFsQja8dyVaA762BkgRRixM7LxxZJ1KJRno2
         ZYOg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+PghrfCBG4A3iXVsbGmfWHGJ8pwlfQyda71Y2+CXF19KdNc3q6g9eQUXoBbVhymUHLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoas5vkJPzAv10XgK+TeBOSmiT/Sw/etzZ+S5hvVHjxQoAnXqg
	Buw+kFn0zMI0hVmdsJdGhvxB2gsEG9xPbfHkWTJFFf8/nVlcP7TpxrEIa1hefK2uirYNn96rwO6
	/PCwtIRAfU3koTIVB7E8BU7QynPd87YNW
X-Gm-Gg: ASbGncud0swhxuN7tX4gwc4Pg//jvMtcRyTqN0YgFWWgArqAzYoecnXboxfWIjYjSre
	M7whYPdc4aKDEd+/baAmPJUZ/bW8XM9mB8z+n2a2HzPlVr17nc/v+qvRWpof+oMnhZrYUGginSM
	Y9uxF5RxdObbLfMq62HY3ETCE/kseZDmXzv8x7DXa+BkoLpVPFnOSGcRhiERtNeA/rKM/z
X-Google-Smtp-Source: AGHT+IFdjNP+ozgylt8UgtwtZQGVU8/bcKlump+QYnH8H0NCDGhCYF8uTldyuHFncHvO/kzI/NXwTiqOVsTiSgszZF4=
X-Received: by 2002:a05:6122:1686:b0:523:eb47:2884 with SMTP id
 71dfb90a1353d-52756b4d089mr1756029e0c.6.1743669484642; Thu, 03 Apr 2025
 01:38:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 17:38:03 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-4-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im> <20250331-b4-pks-collect-build-fixes-v2-4-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 17:38:03 +0900
X-Gm-Features: ATxdqUGVf6SS_2aHexp8XqcUGyI508b_1_c4zKKjUyoF7m7bPcWos0TwVA9nB6k
Message-ID: <CAOLa=ZQkrFepBOQrgxForphncUPkiJ7QXpRmLsDQB5EG--Kj0A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] meson: distinguish build and target host binaries
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
	Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="0000000000003d08cc0631dbb08e"

--0000000000003d08cc0631dbb08e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Almost all of the tools we discover during the build process need to be
> native programs. There are only a handful of exceptions, which typically
> are programs whose paths we need to embed into the resulting executable
> so that they can be found on the target system when Git executes. While
> this distinction typically doesn't matter, it does start to matter when
> considering cross-compilation where the build and target machines are
> different.
>
> Meson supports cross-compilation via so-called machine files. These
> machine files allow the user to override parameters for the build
> machine, but also for the target machine when cross-compiling. Part of
> the machine file is a section that allows the user to override the
> location where binaries are to be found in the target system. The
> following machine file would for example override the path of the POSIX
> shell:
>
>     [binaries]
>     sh = '/usr/xpg4/bin/sh'
>
> It can be handed over to Meson via `meson setup --cross-file`.
>
> We do not handle this correctly right now though because we don't know
> to distinguish binaries for the build and target hosts at all. Address
> this by explicitly passing the `native:` parameter to `find_program()`:
>
>   - When set to `true`, we get binaries discovered on the build host.
>
>   - When set to `false`, we get either the path specified in the
>     machine file. Or, if no machine file exists or it doesn't specify
>     the binary path, then we fall back to the binary discovered on the
>     build host.
>
> As mentioned, only a handful of binaries are not native: only the system
> shell, Python and Perl need to be treated specially here.
>

These are not native because they'll be run onthe target machine, while
the rest are run on the host machine. Makes sense.

> Reported-by: Peter Seiderer <ps.report@gmx.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/meson.build | 12 ++++-----
>  gitweb/meson.build        |  2 +-
>  meson.build               | 66 ++++++++++++++++++++++++++++++++++++-----------
>  templates/meson.build     |  4 +--
>  4 files changed, 60 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 594546d68b1..32f0c5de12a 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -207,9 +207,9 @@ manpages = {
>
>  docs_backend = get_option('docs_backend')
>  if docs_backend == 'auto'
> -  if find_program('asciidoc', dirs: program_path, required: false).found()
> +  if find_program('asciidoc', dirs: program_path, native: true, required: false).found()
>      docs_backend = 'asciidoc'
> -  elif find_program('asciidoctor', dirs: program_path, required: false).found()
> +  elif find_program('asciidoctor', dirs: program_path, native: true, required: false).found()
>      docs_backend = 'asciidoctor'
>    else
>      error('Neither asciidoc nor asciidoctor were found.')
> @@ -217,7 +217,7 @@ if docs_backend == 'auto'
>  endif
>
>  if docs_backend == 'asciidoc'
> -  asciidoc = find_program('asciidoc', dirs: program_path)
> +  asciidoc = find_program('asciidoc', dirs: program_path, native: true)
>    asciidoc_html = 'xhtml11'
>    asciidoc_docbook = 'docbook'
>    xmlto_extra = [ ]
> @@ -246,7 +246,7 @@ if docs_backend == 'asciidoc'
>      asciidoc_conf,
>    ]
>  elif docs_backend == 'asciidoctor'
> -  asciidoctor = find_program('asciidoctor', dirs: program_path)
> +  asciidoctor = find_program('asciidoctor', dirs: program_path, native: true)
>    asciidoc_html = 'xhtml5'
>    asciidoc_docbook = 'docbook5'
>    xmlto_extra = [
> @@ -288,7 +288,7 @@ if get_option('breaking_changes')
>     asciidoc_common_options += ['--attribute', 'with-breaking-changes']
>  endif
>
> -xmlto = find_program('xmlto', dirs: program_path)
> +xmlto = find_program('xmlto', dirs: program_path, native: true)
>
>  cmd_lists = [
>    'cmds-ancillaryinterrogators.adoc',
> @@ -409,7 +409,7 @@ if get_option('docs').contains('html')
>      pointing_to: 'git.html',
>    )
>
> -  xsltproc = find_program('xsltproc', dirs: program_path)
> +  xsltproc = find_program('xsltproc', dirs: program_path, native: true)
>
>    user_manual_xml = custom_target(
>      command: asciidoc_common_options + [
> diff --git a/gitweb/meson.build b/gitweb/meson.build
> index 89b403dc9de..88a54b4dc99 100644
> --- a/gitweb/meson.build
> +++ b/gitweb/meson.build
> @@ -1,5 +1,5 @@
>  gitweb_config = configuration_data()
> -gitweb_config.set_quoted('PERL_PATH', perl.full_path())
> +gitweb_config.set_quoted('PERL_PATH', target_perl.full_path())
>  gitweb_config.set_quoted('CSSMIN', '')
>  gitweb_config.set_quoted('JSMIN', '')
>  gitweb_config.set_quoted('GIT_BINDIR', get_option('prefix') / get_option('bindir'))
> diff --git a/meson.build b/meson.build
> index a8d1e63ccc6..79a50599ba8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -155,6 +155,37 @@
>  # These machine files can be passed to `meson setup` via the `--native-file`
>  # option.
>  #
> +# Cross compilation
> +# =================
> +#
> +# Machine files can also be used in the context of cross-compilation to
> +# describe the target machine as well as the cross-compiler toolchain that
> +# shall be used. An example machine file could look like the following:
> +#
> +#   [binaries]
> +#   c = 'x86_64-w64-mingw32-gcc'
> +#   cpp = 'x86_64-w64-mingw32-g++'
> +#   ar = 'x86_64-w64-mingw32-ar'
> +#   windres = 'x86_64-w64-mingw32-windres'
> +#   strip = 'x86_64-w64-mingw32-strip'
> +#   exe_wrapper = 'wine64'
> +#   sh = 'C:/Program Files/Git for Windows/usr/bin/sh.exe'
> +#
> +#   [host_machine]
> +#   system = 'windows'
> +#   cpu_family = 'x86_64'
> +#   cpu = 'x86_64'
> +#   endian = 'little'
> +#
> +# These machine files can be passed to `meson setup` via the `--cross-file`
> +# option.
> +#
> +# Note that next to the cross-compiler toolchain, the `[binaries]` section is
> +# also used to locate a couple of binaries that will be built into Git. This
> +# includes `sh`, `python` and `perl`, so when cross-compiling Git you likely
> +# want to set these binary paths in addition to the cross-compiler toolchain
> +# binaries.
> +#
>  # Subproject wrappers
>  # ===================
>  #
> @@ -173,7 +204,7 @@ project('git', 'c',
>    # The version is only of cosmetic nature, so if we cannot find a shell yet we
>    # simply don't set up a version at all. This may be the case for example on
>    # Windows systems, where we first have to bootstrap the host environment.
> -  version: find_program('sh', required: false).found() ? run_command(
> +  version: find_program('sh', native: true, required: false).found() ? run_command(

While we generally want a target shell, this one is simply to get the
verson during build time. Makes sense.

>      'GIT-VERSION-GEN', meson.current_source_dir(), '--format=@GIT_VERSION@',
>      capture: true,
>      check: true,
> @@ -198,16 +229,18 @@ elif host_machine.system() == 'windows'
>    program_path = [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
>  endif
>
> -cygpath = find_program('cygpath', dirs: program_path, required: false)
> -diff = find_program('diff', dirs: program_path)
> -git = find_program('git', dirs: program_path, required: false)
> -sed = find_program('sed', dirs: program_path)
> -shell = find_program('sh', dirs: program_path)
> -tar = find_program('tar', dirs: program_path)
> +cygpath = find_program('cygpath', dirs: program_path, native: true, required: false)
> +diff = find_program('diff', dirs: program_path, native: true)
> +git = find_program('git', dirs: program_path, native: true, required: false)
> +sed = find_program('sed', dirs: program_path, native: true)
> +shell = find_program('sh', dirs: program_path, native: true)
> +tar = find_program('tar', dirs: program_path, native: true)
> +
> +target_shell = find_program('sh', dirs: program_path, native: false)
>
>  # Sanity-check that programs required for the build exist.
>  foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
> -  find_program(tool, dirs: program_path)
> +  find_program(tool, dirs: program_path, native: true)
>  endforeach
>
>  script_environment = environment()
> @@ -706,7 +739,7 @@ libgit_c_args = [
>    '-DGIT_LOCALE_PATH="' + get_option('localedir') + '"',
>    '-DGIT_MAN_PATH="' + get_option('mandir') + '"',
>    '-DPAGER_ENV="' + get_option('pager_environment') + '"',
> -  '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
> +  '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
>  ]
>  libgit_include_directories = [ '.' ]
>  libgit_dependencies = [ ]
> @@ -761,6 +794,7 @@ endif
>  build_options_config.set_quoted('X', executable_suffix)
>
>  python = import('python').find_installation('python3', required: get_option('python'))
> +target_python = find_program('python3', native: false, required: python.found())
>  if python.found()
>    build_options_config.set('NO_PYTHON', '')
>  else
> @@ -790,9 +824,11 @@ endif
>  # which we can do starting with Meson 1.5.0 and newer, or we have to
>  # match against the minor version.
>  if meson.version().version_compare('>=1.5.0')
> -  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=5.26.0', version_argument: '-V:version')
> +  perl = find_program('perl', dirs: program_path, native: true, required: perl_required, version: '>=5.26.0', version_argument: '-V:version')
> +  target_perl = find_program('perl', dirs: program_path, native: false, required: perl.found(), version: '>=5.26.0', version_argument: '-V:version')
>  else
> -  perl = find_program('perl', dirs: program_path, required: perl_required, version: '>=26')
> +  perl = find_program('perl', dirs: program_path, native: true, required: perl_required, version: '>=26')
> +  target_perl = find_program('perl', dirs: program_path, native: false, required: perl.found(), version: '>=26')
>  endif
>  perl_features_enabled = perl.found() and get_option('perl').allowed()
>  if perl_features_enabled
> @@ -843,7 +879,7 @@ else
>    build_options_config.set('NO_PTHREADS', '1')
>  endif
>
> -msgfmt = find_program('msgfmt', dirs: program_path, required: false)
> +msgfmt = find_program('msgfmt', dirs: program_path, native: true, required: false)
>  gettext_option = get_option('gettext').disable_auto_if(not msgfmt.found())
>  if not msgfmt.found() and gettext_option.enabled()
>    error('Internationalization via libintl requires msgfmt')
> @@ -1974,9 +2010,9 @@ foreach key, value : {
>    'GIT_TEST_TEMPLATE_DIR': meson.project_build_root() / 'templates',
>    'GIT_TEST_TEXTDOMAINDIR': meson.project_build_root() / 'po',
>    'PAGER_ENV': get_option('pager_environment'),
> -  'PERL_PATH': perl.found() ? perl.full_path() : '',
> -  'PYTHON_PATH': python.found () ? python.full_path() : '',
> -  'SHELL_PATH': shell.full_path(),
> +  'PERL_PATH': target_perl.found() ? target_perl.full_path() : '',
> +  'PYTHON_PATH': target_python.found () ? target_python.full_path() : '',
> +  'SHELL_PATH': target_shell.full_path(),
>    'TAR': tar.full_path(),
>    'TEST_OUTPUT_DIRECTORY': test_output_directory,
>    'TEST_SHELL_PATH': shell.full_path(),
> diff --git a/templates/meson.build b/templates/meson.build
> index 1faf9a44cea..02e6eebe80b 100644
> --- a/templates/meson.build
> +++ b/templates/meson.build
> @@ -1,6 +1,6 @@
>  template_config = configuration_data()
> -template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
> -template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
> +template_config.set('PERL_PATH', target_perl.found() ? fs.as_posix(target_perl.full_path()) : '')
> +template_config.set('SHELL_PATH', fs.as_posix(target_shell.full_path()))
>  template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
>
>  configure_file(
>
> --
> 2.49.0.604.gff1f9ca942.dirty

Looks good!

--0000000000003d08cc0631dbb08e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9112e46fe79c9e6a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdVNPb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVlzQy85OGl2KzBBMWY4V0gyV2tlZVpLbWZRR25jRApCY0J3aDY1Nzh5
SHdyZFkxK1Irbk96L2xHeE9sUFZaeXJpL1FOUTVxeGhsR2FyRFhzTVRFWnZzSFR1TGxpankwCmxH
M21vR3JtMDdyLzlUdnpGbXRaaWEzNXgwZzVITnZRRE96dllKOHdSV0VYaGhwN0pHVlRFM2VVWkVM
UzRJRTIKd3lKNmoxYUZqRzdFeEJCNWJjQXFNK3JtbCtmREpaTlcxbi9KZVl2ZGc0M1Nxa2V2a1BZ
N2ovZmNOSjUwOHVxMwpRKzVNQTAxNGdpODJsMFdsaGFucmk1T3BkaUtyWFMxTkIxTjArOFB3bHpp
S0trUmNYN25ZcHV6Lzl5OGdIZ3NxCjh1OVk4NktBZkg4dmVtQmFRamNzeDJTWU96RFM5dTFwbTRZ
Y0JYdy9qMnliZk1saWdudFVuRmt0Wk95b2N2ZDEKUm9qa0dQYWErWXlrTDIvaWJ5aFA1Vy9NV3Ax
WDNZaFJxU2lMcUtpRkY5UldLTDMvalVpNDdacnljREQzc1BOOAoyQktSN0dnaktYSHQxTmhoZzZH
OThCVGNPY1hpa2xHM2xCMFFUbit1VHhzYm5rVlFaK2MwbDFTZmdFTWdxQ3pUCkI4UUZTUnplQnlM
UVptVERnUjVLKzJwNmdKQko1Sk01SjBjbmE5az0KPUhsNUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003d08cc0631dbb08e--
