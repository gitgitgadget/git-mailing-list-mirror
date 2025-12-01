Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9A2ED84A
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595105; cv=none; b=l7ClEWO4hUbawrAYjygZ3nZd7nIzrCE8qFw75q9vvZCL8K4FLv0ax9xfi9yLt/i4HqtL5HmRsTw2t5/JMv1qMAaUCazz7FoHmOgoYA8NBIXDmUWIO55Xl+GKT6DV0cUxgt8L4tMl1WB+b4bVWu1fb9Cz1xrY7Txn3w5Ua8pYqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595105; c=relaxed/simple;
	bh=i2RdvDoeQDvLAygV7sCd3O1brDl4jVzpT36LYTqapAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TqapYyQa4xxsNmJP1igevEXa1KwUKHg4CRMpP9KuQT+bV8sWeuf2+Y7AY3F9Hsja8kOmY45zqwhn/9ALZ2I4yHGFxMA14r9X237SGKct8UdtFOnWef7jKEX8vA09BhOmwymCjsScArNF2fc/1XrQ53UTlzELbBfqkeOzkVJWKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SUzVczLQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SUzVczLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764595099; x=1765199899;
	i=johannes.schindelin@gmx.de;
	bh=ub5+NyqBktd4ViCHWYAGJXLHXzUczkEO0UkObOjA7S4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SUzVczLQqurRpJmjQJ2x0NGqrFKf8kdoZHLMFYhBkieOFmHOJ/o9UghrZ2fzObmx
	 2dR8657/axlFKPlF5zDwWUyUzf9lRaHmzZZNyAbbif3O5E1QOFUeFbWPnvOS4SyfP
	 ge6HCoMd/vpPvRt6fqOS9BogkAs0N6E2Zb1HVZ7cuxt92zhs2Kc01+8sJ0YFZq2JA
	 7Mr4wvOicLhdsTGcIvI1aXYUqRQjGHDaiOznrf1+aY4GEKZWOJzVRSRfbP8GpVZO6
	 XECAEc/8V4znYHTmln9d6q1bFw2uuxUClrUd0qa3Uhb+yyPvIl7shTfeIg0tOd9oC
	 BFLMcsYZw04OEj72EA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1vv0tk2XY3-00pDod; Mon, 01
 Dec 2025 14:18:19 +0100
Date: Mon, 1 Dec 2025 14:18:17 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 03/10] mingw: special-case `open(symlink, O_CREAT |
 O_EXCL)`
In-Reply-To: <xmqqecpgc8wd.fsf@gitster.g>
Message-ID: <4cf1c638-3b0b-a36a-ce35-41d55e9fae12@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <96e279f50ebc26084095e781cf58db233fa05b74.1764440906.git.gitgitgadget@gmail.com> <xmqqecpgc8wd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hH93A9lG2ZfRKOF3FZAxwGG+Fc9tcmOk63g7JU7od3pNsto5S0u
 HVfvWjHBStIEKjSGmUljKBVs6KNJhdXABTEY4U3oaQe0ztBqKJBawZaGM3Q2jaZ/WNfZsf5
 7/8GLmVKm2p/4Fs3m+saO0VBb6u+qsn/S/5Z5Cn3xSs+X7nswmjGjG1Qg6KoS+IIGGYBFI7
 QcT/KOE+0StVPh1H8C5SA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yDpuEXSZsYw=;k5k989803DiTO28pm9EeFIDDKkk
 +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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 29 Nov 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `_wopen()` function would gladly follow a symbolic link to a
> > non-existent file and create it when given above-mentioned flags.
> >
> > Git expects the `open()` call to fail, though. So let's add yet anothe=
r
> > work-around to pretend that Windows behaves like Linux.
>=20
> "like Linux" -> "as POSIX expects"?
>=20
> cf. https://pubs.opengroup.org/onlinepubs/007904875/functions/open.html#=
:~:text=3DIf%20O_CREAT%20and%20O_EXCL%20are,set%2C%20the%20result%20is%20u=
ndefined.

You are both correct and incorrect. The behavior I described indeed is not
limited to Linux, insofar you are correct. The behavior I wanted to
imitate is Linux', though, not POSIX.

I noticed that there was a recent shift, mostly by one particular
contributor on this list, who pushes for POSIX compliance to be the gold
standard Git lives by. However, that does not match my understanding of
what the Git project agreed upon, as documented in
https://gitlab.com/git-scm/git/-/blob/v2.52.0/Documentation/CodingGuidelin=
es?ref_type=3Dtags#L4-6
(and there was no attempt to change this).

As such, I still deem it more appropriate to keep the commit message as I
wrote it, as it matches my intent.

You're of course free to edit the commit message to your liking, as you
have done in the past. It just would not match my intent anymore.

Ciao,
Johannes

> > This is required to let t4115.8(--reject removes .rej symlink if it
> > exists) pass on Windows when enabling the MSYS2 runtime's symbolic lin=
k
> > support.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/mingw.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 736a07a028..9fbf12a3d3 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -627,6 +627,7 @@ int mingw_open (const char *filename, int oflags, =
...)
> >  	int fd, create =3D (oflags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O=
_EXCL);
> >  	wchar_t wfilename[MAX_PATH];
> >  	open_fn_t open_fn;
> > +	WIN32_FILE_ATTRIBUTE_DATA fdata;
> > =20
> >  	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, vo=
id);
> > =20
> > @@ -651,6 +652,19 @@ int mingw_open (const char *filename, int oflags,=
 ...)
> >  	else if (xutftowcs_path(wfilename, filename) < 0)
> >  		return -1;
> > =20
> > +	/*
> > +	 * When `symlink` exists and is a symbolic link pointing to a
> > +	 * non-existing file, `_wopen(symlink, O_CREAT | O_EXCL)` would
> > +	 * create that file. Not what we want: Linux would say `EEXIST`
> > +	 * in that instance, which is therefore what Git expects.
> > +	 */
>=20
> "Linux" -> "open() on POSIX-compliant systems".
>=20
> IOW, _wopen() does not have to behave like POSIX open() and the compat/
> layer is how the emulation goes.
>=20
> FWIW, this is not limited to symbolic links but anything that exists
> at the path specified should cause the same EEXIST failure.  The
> O_CREAT|O_EXCL combination asks the system to atomically create the
> thing anew (or fail).
>=20
>     O_EXCL
>         If O_CREAT and O_EXCL are set, open() shall fail if the file
>         exists. The check for the existence of the file and the creation=
 of
>         the file if it does not exist shall be atomic with respect to ot=
her
>         threads executing open() naming the same filename in the same
>         directory with O_EXCL and O_CREAT set. If O_EXCL and O_CREAT are
>         set, and path names a symbolic link, open() shall fail and set e=
rrno
>         to [EEXIST], regardless of the contents of the symbolic link. If
>         O_EXCL is set and O_CREAT is not set, the result is undefined.
>=20
> > +	if (create &&
> > +	    GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata) &=
&
> > +	    (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT)) {
> > +		errno =3D EEXIST;
> > +		return -1;
> > +	}
> > +
> >  	fd =3D open_fn(wfilename, oflags, mode);
> > =20
> >  	/*
>=20
