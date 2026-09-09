Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775937C0FC
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980170; cv=none; b=oDxEDaD3Drf0KKi/+s1HCAI81v0xilFrcNroYCMOm4V1yI+6lEYIX/XS2LN71FvskadkV7eIA5IfkO/YlQ9pLX7qqcoLaCI1FXz0jdnyBkcn+nglnioPIJEI4H3eohKze+4dNag7JtxCu8mHtwD8SI0NqGqYsyVmxnRq/gVj0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980170; c=relaxed/simple;
	bh=LHdjdMkZDt49pz66ttpprznWZ3/FMktL8Nogow/lEFk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fUNSaUgCsQXWV1UUyr+HJR+9haJUaoIC+7570Pc1v/AJwy7VfMQS6e0FeUs1OFTaRtXNHVGY6/xSz2XowCkoUQd1LdJxx1mTyLk0l00bUr+/YwlLXG9I6Q/RJ3D9oDgbPqsfti/5YpburBQiQltx0dZzRTMiBlsgJsMdIE91ZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=YkN0rMHk; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="YkN0rMHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788980164; x=1789584964;
	i=johannes.schindelin@gmx.de;
	bh=B7S3h2JBWQwnEqlgVbzZ7L+hfz2+V7epD8rxuMf4Zrk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YkN0rMHkWe/9t5OexHcb9hBVWmhb/v+ZMmsy84ceLom+RrtsD0wITyc+q89vRvbL
	 syfRP3VKVRcpX98g3WDCrBJ5XZpLNDloPh65F+UR4arq2Qy9Vque0aKe7t5LeaYS2
	 uWxSLUntKhHpHzVffRzPBqkm3deuD3EpSjLfITCiD++tQigp/Zj3BYJpwKLXAR+dY
	 oqzKLEXnjwyboLV9r3i5EAY0Q9g4qHekwsaL8BH+o8HAq3sr5JsZG7ZnnB1a/tEcV
	 hNG9zVVpsNG03He1oy7AyDhXyUshPzRHX5ZKV8tD4qot4grnZuSkV1WmGqM42KlzN
	 bjWJLv+SgX9nwaNgJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1xS77K2mhy-00MvKt; Wed, 09
 Sep 2026 20:56:04 +0200
Date: Wed, 9 Sep 2026 20:56:04 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH v2 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <4f4129df-681f-4e99-8b1f-8bb96e206a2d@kdbg.org>
Message-ID: <a5ffcb9c-b223-af4b-7aa7-1a3db31a5f59@gmx.de>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com> <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com> <9de4ea7fc1d250e8e9dfae386424451242cb3daa.1786521173.git.gitgitgadget@gmail.com> <4f4129df-681f-4e99-8b1f-8bb96e206a2d@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:2AYiB8eS3PMBhqGIZE5jG/Hw6PvDNMsHkwqWG33mHxrEMyriz13
 Mh+Q5SuD0rAfaLOuWU1L+6neD0TqOgmK6H6yvdVWxmttX/imbtXBDzJLMfaY3ircTedtMF6
 s3osyhD68/iOiGAHygH6Pn9sDn85Xc4ICApKZ1n7b8ebrTLdGAZ7GDQ9YEt8jEJBqkybJh3
 3aUL3Cm89bKmVGJcON1SQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:20HGGFvFnLg=;Pj81BktbaHR3atnufKAnXU1/IEc
 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
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Sat, 15 Aug 2026, Johannes Sixt wrote:

> Am 12.08.26 um 09:52 schrieb Johannes Schindelin via GitGitGadget:
> > diff --git a/config.mak.uname b/config.mak.uname
> > index 21f53e3f7e..3a90995587 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -465,14 +465,8 @@ ifeq ($(uname_S),Windows)
> >  	GIT_VERSION :=3D $(GIT_VERSION).MSVC
> >  	pathsep =3D ;
> >  	# Assume that this is built in Git for Windows' SDK
> > -        ifeq (MINGW32,$(MSYSTEM))
> > -		prefix =3D /mingw32
> > -        else
> > -                ifeq (CLANGARM64,$(MSYSTEM))
> > -			prefix =3D /clangarm64
> > -                else
> > -			prefix =3D /mingw64
> > -                endif
> > +        ifneq (,$(MSYSTEM))
> > +		prefix =3D $(MINGW_PREFIX)
> >          endif
> >  	# Prepend MSVC 64-bit tool-chain to PATH.
> >  	#
> > @@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
> >  		BASIC_LDFLAGS +=3D -Wl,--dynamicbase
> >          endif
> >          ifneq (,$(MSYSTEM))
> > +                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)=
))
> > +			# Override if empty or does not start with a slash
> > +			MINGW_PREFIX :=3D /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
> > +                endif
> >  		prefix =3D $(MINGW_PREFIX)
> >  		HOST_CPU =3D $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
> >  		BASIC_LDFLAGS +=3D -Wl,--pic-executable
>=20
> At this point, MINGW_PREFIX is only used to set prefix.
>=20
> Only in 12/12 is the variable (and ENSURE_MSYSTEM_IS_SET) used to drive
> C code. Therefore, it seems that the following hunks concerning the
> CMake and meson build systems do not belong in this patch, yet, but only
> in 12/12.

Ah, right, the following hunks do touch the ENSURE_MSYSTEM_IS_SET stuff.
But they _also_ add the `MINGW_PREFIX` stuff.

Will disentangle.

Ciao,
Johannes

>=20
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index a57c4b464f..7285bd9ac2 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -256,7 +256,14 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
> >  				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=3D".exe"  NO_SYMLINK_HEA=
D UNRELIABLE_FSTAT
> >  				NOGDI OBJECT_CREATION_MODE=3D1 __USE_MINGW_ANSI_STDIO=3D0
> >  				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
> > -				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
> > +				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
> > +	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
> > +		add_compile_definitions(ENSURE_MSYSTEM_IS_SET=3D"MINGW64" MINGW_PRE=
FIX=3D"mingw64")
> > +	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
> > +		add_compile_definitions(ENSURE_MSYSTEM_IS_SET=3D"CLANGARM64" MINGW_=
PREFIX=3D"clangarm64")
> > +	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")
> > +		add_compile_definitions(ENSURE_MSYSTEM_IS_SET=3D"MINGW32" MINGW_PRE=
FIX=3D"mingw32")
> > +	endif()
> >  	list(APPEND compat_SOURCES
> >  		compat/mingw.c
> >  		compat/winansi.c
> > diff --git a/meson.build b/meson.build
> > index 7073d5844d..a8aba81e29 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1318,7 +1318,6 @@ elif host_machine.system() =3D=3D 'windows'
> > =20
> >    libgit_c_args +=3D [
> >      '-DDETECT_MSYS_TTY',
> > -    '-DENSURE_MSYSTEM_IS_SET',
> >      '-DNATIVE_CRLF',
> >      '-DNOGDI',
> >      '-DNO_POSIX_GOODIES',
> > @@ -1328,6 +1327,20 @@ elif host_machine.system() =3D=3D 'windows'
> >      '-D__USE_MINGW_ANSI_STDIO=3D0',
> >    ]
> > =20
> > +  msystem =3D get_option('msystem')
> > +  if msystem !=3D ''
> > +    mingw_prefix =3D get_option('mingw_prefix')
> > +    if mingw_prefix =3D=3D ''
> > +      mingw_prefix =3D msystem.to_lower()
> > +    elif mingw_prefix.startswith('/')
> > +      mingw_prefix =3D mingw_prefix.substring(1)
> > +    endif
> > +    libgit_c_args +=3D [
> > +      '-DENSURE_MSYSTEM_IS_SET=3D"' + msystem + '"',
> > +      '-DMINGW_PREFIX=3D"' + mingw_prefix + '"'
> > +    ]
> > +  endif
> > +
> >    libgit_dependencies +=3D compiler.find_library('ntdll')
> >    libgit_include_directories +=3D 'compat/win32'
> >    if compiler.get_id() =3D=3D 'msvc'
> > diff --git a/meson_options.txt b/meson_options.txt
> > index dc88f130d7..becf4689bf 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -21,6 +21,10 @@ option('runtime_prefix', type: 'boolean', value: fa=
lse,
> >    description: 'Resolve ancillary tooling and support files relative =
to the location of the runtime binary instead of hard-coding them into the=
 binary.')
> >  option('sane_tool_path', type: 'array', value: [],
> >    description: 'An array of paths to pick up tools from in case the n=
ormal tools are broken or lacking.')
> > +option('msystem', type: 'string', value: '',
> > +  description: 'Fall-back on Windows when MSYSTEM is not set.')
> > +option('mingw_prefix', type: 'string', value: '',
> > +  description: 'Fall-back on Windows when MINGW_PREFIX is not set.')
> > =20
> >  # Build information compiled into Git and other parts like documentat=
ion.
> >  option('build_date', type: 'string', value: '',
>=20
> -- Hannes
>=20
>=20
