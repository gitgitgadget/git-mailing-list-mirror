Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFB315775
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936708; cv=none; b=QIAFaFASpG60sVtwj+e0qCTcCwDlwQAvojRsEdpEP77MliN1zZ1WxkIexKf2kanbSSDfIN1TNLULWTUSEe2L7I4CnkWFm2/J9YfpL/jWvA43ns+oDVFYtjUvNy9ApbfviXWNDHRG+rROHJUAqmES3h4xTVaQ+B5hV04dskuL0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936708; c=relaxed/simple;
	bh=bL/XHbRU2d2QZnN9/VZZHDfI7ze/z4f5f4zaT9tADBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfotc/hfCdYehh+dcMN9CwfAApqD5ckIXdhj3zCBBxLok9/6iPfwHCvqx5435Da7VQNvaCNL5lZukdUyjWCQy2qbBwQE35JJnwOXpzR/mdMEA/gNmQOrwpcmtpG4DOSLRmix5S5eq+07K37EKHXD5TTsNZvSs3oiKf1R4+bPFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=X2IquhUJ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="X2IquhUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764936701; x=1765541501; i=l.s.r@web.de;
	bh=m1ZZYD9kGrhbtj6jm49Pd9r/s/4Pv6dnInV5EmeHaW8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X2IquhUJTMZ7VN7vlCAM0KCZ8NtrF75IiDjK7Ago12eaEZFYy+b1gxRfaeU5bZAC
	 UyJUHUSE081eWFMwySaDc7iQMQ2j8IvIn/uszRcNbP2/w9A3XzUo2inRdbL5pu2gr
	 rFjZVe4duBwg9qWEZjFVC991F4NiYeXk/BPZklB8rZT4fZVk0Jq/YBBRnbJFqA+rf
	 uYCP8rPgNthtmuqOkWPQglv8NB1CLjgNBaQleTLtILQ/lbaT3Efvum5xLeTSwUusU
	 5M1VZx79jvF5bPyHIaLoWrBTLdMq58gqZcNEDdqLjTE9jKSE3a3fQi1Wv0bTbSw78
	 MqG3P5vXrCqL+iQWHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.229]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1vngBI1V57-00juW6; Fri, 05
 Dec 2025 13:11:41 +0100
Message-ID: <aebd0ffe-7914-4731-8f79-830bd3b5a147@web.de>
Date: Fri, 5 Dec 2025 13:11:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] compat: use git_mkdtemp()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <4c70b527-9c40-4396-8c8c-95177c5d92f0@web.de>
 <20251203161154.GA44940@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251203161154.GA44940@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G4rFiZKLJoqpMGYqpMhk9QMD7HR9W97yYISgMGWXVRZFlnUspWv
 ZZraX1dQ9BMWOWeFqWvZi1c8iMPEA+NUhdmLSZPZP5g+b3D4eLju/OoWqOt/AdtmfDgr+Df
 Q+w23nrYe+CAX8GIJo1mM28c+3JIujzamtqWFaq4kNy5kBZBXluGnex36whhx1Y0wUXSflt
 HTkf6+B5ihepyP310ejWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZTyBP+pGTGM=;Iqimz4Q39qNoy4HihEXGrzkuDda
 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

On 12/3/25 5:11 PM, Jeff King wrote:
> On Wed, Dec 03, 2025 at 11:52:30AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>> A file might appear at the path returned by mktemp(3) before we call
>> mkdir(2).  Use the more robust git_mkdtemp() instead, which retries a
>> number of times and doesn't need to call lstat(2).
>=20
> This seems like a good idea. At least one of the mkdtemp() callers was
> using $TMPDIR, so this was a potential security-sensitive race.
>=20
>> diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
>> index 1136119592..fcdd4e01e1 100644
>> --- a/compat/mkdtemp.c
>> +++ b/compat/mkdtemp.c
>> @@ -2,7 +2,5 @@
>> =20
>>  char *gitmkdtemp(char *template)
>>  {
>> -	if (!*mktemp(template) || mkdir(template, 0700))
>> -		return NULL;
>> -	return template;
>> +	return git_mkdtemp(template);
>>  }
>=20
> OK, so now we have gitmkdtemp() and git_mkdtemp(), which are also now
> the exact same thing. That seems overly complicated. ;)
>=20
> This one is a conditionally-compiled wrapper for NO_MKDTEMP. But since
> we always have git_mkdtemp() available (as of your first patch), can't
> we just point at it directly with the macro?

A worthwhile cleanup if we stop at this point, but complicated by
targeting three build systems, the CMake build being broken on macOS and
me only knowing how to fake NO_MKDEMP for make, leaving half the build
space untestable for me.

> Like this:
>=20
> diff --git a/Makefile b/Makefile
> index 237b56fc9d..8226aed443 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1919,7 +1919,6 @@ ifdef NO_SETENV
>  endif
>  ifdef NO_MKDTEMP
>  	COMPAT_CFLAGS +=3D -DNO_MKDTEMP
> -	COMPAT_OBJS +=3D compat/mkdtemp.o
>  endif
>  ifdef MKDIR_WO_TRAILING_SLASH
>  	COMPAT_CFLAGS +=3D -DMKDIR_WO_TRAILING_SLASH
> diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
> deleted file mode 100644
> index fcdd4e01e1..0000000000
> --- a/compat/mkdtemp.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#include "../git-compat-util.h"
> -
> -char *gitmkdtemp(char *template)
> -{
> -	return git_mkdtemp(template);
> -}
> diff --git a/compat/posix.h b/compat/posix.h
> index 067a00f33b..245386fa4a 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -329,8 +329,7 @@ int gitsetenv(const char *, const char *, int);
>  #endif
> =20
>  #ifdef NO_MKDTEMP
> -#define mkdtemp gitmkdtemp
> -char *gitmkdtemp(char *);
> +#define mkdtemp git_mkdtemp
>  #endif
> =20
>  #ifdef NO_UNSETENV
> diff --git a/meson.build b/meson.build
> index f1b3615659..090b1911ca 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1401,7 +1401,6 @@ checkfuncs =3D {
>    'strlcpy' : ['strlcpy.c'],
>    'strtoull' : [],
>    'setenv' : ['setenv.c'],
> -  'mkdtemp' : ['mkdtemp.c'],
>    'initgroups' : [],
>    'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
>    'pread' : ['pread.c'],

We need to keep that dictionary entry to still define NO_MKDTEMP, and
just empty the array of filenames.

contrib/buildsystems/CMakeLists.txt needs to be updated as well, like
you do below (keep in function_checks, remove from compat_SOURCES).

At the very least this cleanup should be done in a separated patch, as
it's harder than it looks.

> We could even take it a step further and just always use git_mkdtemp(),
> like we were discussing elsewhere for mkstemp(). And then the makefile
> knobs can go away, too, like:
>=20
> diff --git a/Makefile b/Makefile
> index 8226aed443..8ef5497c10 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -68,8 +68,6 @@ include shared.mak
>  #
>  # Define NO_UNSETENV if you don't have unsetenv in the C library.
>  #
> -# Define NO_MKDTEMP if you don't have mkdtemp in the C library.
> -#
>  # Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with traili=
ng slash.
>  #
>  # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
> diff --git a/compat/posix.h b/compat/posix.h
> index 245386fa4a..c49d67e653 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -328,9 +328,7 @@ ssize_t git_pread(int fd, void *buf, size_t count, o=
ff_t offset);
>  int gitsetenv(const char *, const char *, int);
>  #endif
> =20
> -#ifdef NO_MKDTEMP
>  #define mkdtemp git_mkdtemp
> -#endif
> =20
>  #ifdef NO_UNSETENV
>  #define unsetenv gitunsetenv
> diff --git a/configure.ac b/configure.ac
> index cfb50112bf..8e61186f18 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1140,12 +1140,6 @@ GIT_CHECK_FUNC(unsetenv,
>  [NO_UNSETENV=3DYesPlease])
>  GIT_CONF_SUBST([NO_UNSETENV])
>  #
> -# Define NO_MKDTEMP if you don't have mkdtemp in the C library.
> -GIT_CHECK_FUNC(mkdtemp,
> -[NO_MKDTEMP=3D],
> -[NO_MKDTEMP=3DYesPlease])
> -GIT_CONF_SUBST([NO_MKDTEMP])
> -#
>  # Define NO_INITGROUPS if you don't have initgroups in the C library.
>  GIT_CHECK_FUNC(initgroups,
>  [NO_INITGROUPS=3D],
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 479163ab5c..d28de227f5 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -374,7 +374,7 @@ endif()
>  #function checks
>  set(function_checks
>  	strcasestr memmem strlcpy strtoimax strtoumax strtoull
> -	setenv mkdtemp poll pread memmem)
> +	setenv poll pread memmem)
> =20
>  #unsetenv,hstrerror are incompatible with windows build
>  if(NOT WIN32)
> @@ -411,10 +411,6 @@ if(NOT HAVE_SETENV)
>  	list(APPEND compat_SOURCES compat/setenv.c)
>  endif()
> =20
> -if(NOT HAVE_MKDTEMP)
> -	list(APPEND compat_SOURCES compat/mkdtemp.c)
> -endif()
> -
>  if(NOT HAVE_PREAD)
>  	list(APPEND compat_SOURCES compat/pread.c)
>  endif()

Right.  Dropping this dependency and then deep cleaning the compat code
is attractive and mostly sidesteps the build system complications.
That's for a later series.

Ultimately you'd prefer banning mkdtemp(3) instead of automatically
redirecting to git_mkdtemp(), though, no?

Ren=C3=A9

