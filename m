Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8D175A8B
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020654; cv=none; b=IAbncW5aJY6MjPAX60xm4o6R+0LWKD3rKFmVKHBOVcl+8Peu/NBMJrwPR2qOP7BH/i+tU8iEb/0nCNYbDN4DCS98FXSQ1qoat5eb1SZq1zFDp+4rv5HZX+iuTpDp1gJAwHIBf4mgfiQcv1JE8pzMIqsB5gQjoawqcEZ42n6lRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020654; c=relaxed/simple;
	bh=ZktNezBiCXgVs54vyNHAaoKGGtLEjmJHaR+7GH92tiQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rw79M09S5bce2dbeWZz6QmFxe4kLKPRBWntGkHqOe5CZUgfW0F3P2QnLZsn5gge3HaZ2GpiKO15C/NJhcrBZRg9cesFFsmxJw0kTYN4wdz0x/6YJfEHySNS/5DwdC7VvWbfyy9Dw5f33h79GbL5V7xcLBAirxic7JqPeRzAgMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=oIKX8t46; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="oIKX8t46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786020647; x=1786625447;
	i=johannes.schindelin@gmx.de;
	bh=uTkroM3BnkFcvNZcvqt+Vi1TVvtykdFCuGQ3b7HyQPg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oIKX8t46UnFDHjDI01sjNH7t7Ot9wkLjrK8DLFQaabpEiCWfDL3p9dSQqu9dleGH
	 NssUP7kxitZPyoi+ovnzm6YA91hxoUfUuMx1+Nr9l9AC8Ts8xk2GdDGIbA5m5aDqn
	 OTzSRO3pvJmOQETlTRVzgq/KH+Aj7ZRHodxDAjKOy1Zi/8l7lfCN1mq1Dm+sf4l31
	 Wf0NXMVsPeSweiHAOjYRe7zwIqvFBPuPgUCxA8pnQmGV1tn6Cj/ckleX2mzONR/68
	 2IqVeP/eO5/XUyNe+cMJ0K5hAspJZF/SakRyl9mEB0hOyfzp3f50GOL+B8Mmz73OR
	 vFI+Yw/m+Er5mVHvKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1xRqGy126F-00pFlD; Thu, 06
 Aug 2026 14:50:47 +0200
Date: Thu, 6 Aug 2026 14:50:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <xmqq7bm4qxv6.fsf@gitster.g>
Message-ID: <9f905100-003b-8ef2-3e2e-2f9ed57dda1b@gmx.de>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com> <1593d1d1a0dceb58640cfa56b49bf30d8a2c6365.1785939999.git.gitgitgadget@gmail.com> <xmqq7bm4qxv6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:iRo9PqI9YSIaLh3IF2i602xVYUnTnKUIeUf0hG/XJDxNL3trLjo
 vF17GpwhIxKEetUnQv16NUG3bsxb8cBgNdeqZO3F0yRNz7znFzbn1g/EtZ4Spj6cItoZ+zA
 hGVAA8sdH8x2xHWo6Lp6p4dXYo9C4Fli7HDkMAJ6uU1gIiPHVLb6m2WRfUMuE940XEkCMV4
 k2DiyNA0MGULkeGWdZtZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A+44iEQoEyA=;/Os9vw88LpeItV5R3C0+wrO8qB9
 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
 RtXdAwoxEFjchjcwdAY=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 5 Aug 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> [...]
> > diff --git a/meson.build b/meson.build
> > index 7073d5844d..6ddc461873 100644
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
> > @@ -1328,6 +1327,18 @@ elif host_machine.system() =3D=3D 'windows'
> >      '-D__USE_MINGW_ANSI_STDIO=3D0',
> >    ]
> > =20
> > +  msystem =3D get_option('msystem')
> > +  if msystem !=3D ''
> > +    mingw_prefix =3D get_option('mingw_prefix')
> > +    if mingw_prefix =3D=3D ''
> > +      mingw_prefix =3D '/' + msystem.to_lower()
> > +    endif
> > +    libgit_c_args +=3D [
> > +      '-DENSURE_MSYSTEM_IS_SET=3D"' + msystem + '"',
> > +      '-DMINGW_PREFIX=3D"' + mingw_prefix + '"'
> > +    ]
> > +  endif
>=20
> Lowercase mingw_prefix in Meson world corresponds to MINGW_PREFIX in
> Make world, I guess.  -DMINGW_PRFIX gets mingw_prefix which begins
> with a slash.
>=20
> I do not do Windows or Meson, but doesn't this contradict with what
> we have in [12/12], part of which says:
>=20
> diff --git a/config.mak.uname b/config.mak.uname
> index 2f7d445eb3..0b63be10b7 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -535,7 +535,9 @@ endif
>  		compat/win32/pthread.o compat/win32/syslog.o \
>  		compat/win32/trace2_win32_process_info.o \
>  		compat/win32/dirent.o
> -	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAV=
E_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=3D\".e=
xe\"
> +	COMPAT_CFLAGS =3D -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY \
> +		-DENSURE_MSYSTEM_IS_SET=3D"\"$(MSYSTEM)\"" -DMINGW_PREFIX=3D"\"$(pats=
ubst /%,%,$(MINGW_PREFIX))\"" \
> +		-DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRI=
P_EXTENSION=3D\".exe\"
>  	BASIC_LDFLAGS =3D -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTSta=
rtup -SUBSYSTEM:CONSOLE
>  	# invalidcontinue.obj allows Git's source code to close the same file
>  	# handle twice, or to access the osfhandle of an already-closed stdout
>=20
>=20
> IOW, -DMINGW_PREFIX passed to the compiler strips leading slash from
> $(MINGW_PREFIX).
>=20
> Isn't it necessary to strip the leading slash from ming_prefix also
> on the Meson side?

Correct. Since Git for Windows does not use Meson to build the project,
and since the Visual C-based builds (including CI's `windows-meson-build`)
do not use `MSYSTEM`, this was not caught earlier. The next iteration will
have the fix.

Ciao,
Johannes
