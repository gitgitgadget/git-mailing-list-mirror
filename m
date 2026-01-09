Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41A1F151C
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989086; cv=none; b=Ea8KygXUwJhrLmhyNqo2BEuOeJb4AC4pZJkdsmVamuR2vh+cFklTD9kB2lz675aArUAjM8K1n+3c0Z1rIIfLnszmS+c7HjaBKMQzD9/RQTKdFO9ug4qicVj1ePAkK9Km+6DCRsq3yWx6n/Cbh7h18tvQ44J0mE4A7hwgP2Dk3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989086; c=relaxed/simple;
	bh=/IThReXohyh1jOloPsRVUMEA5pdpttURkh8shVNT8wc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hcOf8oZAeg5gp9iZSER/uqz/NStzxnBIZ63EZHq6r0m1Jf2DLJj1mESe53yNuvoau7gX9yt/UsBYKfLywvR23n+vBCn14hoSEP/4oeiOYbAy5bw3NKmqvikc0MgrHhjFK6sq0PyN+IE1Evf+QZ85ribcWvqAyRs9MV3tABiNH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rxK28ty+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rxK28ty+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767989082; x=1768593882;
	i=johannes.schindelin@gmx.de;
	bh=JGdLsN+B2GbXuM4jwVLLZd1m4DrNwkYpjKOXwkleYDY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rxK28ty+Ppm0dyr4DrwoSjkcwXTlc57KIBDtCWMHY1QdvJQnlOgEFoaUcKJH7cTt
	 XVC2HIvCPldSZwY0FIrXc1tna118t6GRbsvMw+9pF0812DYAfxVX7eQfB9g7530ol
	 pytCwGAIiNDAc3uJDs3PPAcwTjtEkEx2Mj20vnGw0QwFAoRIYsHz1P9tTGAFIPhay
	 Eo3/fk785dCtTF4shEZAXnbfKRG2wasOof7uFivFXGha8j7ty0kKvXbK0dlUK/hZE
	 CcJHA6/pqoZ7wApkJ1IV4EsZrzS/sjuondYZsI6OWYn09r+tS7MYicRW549I97rMO
	 Hwki5HBqsLWvWZ+cXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1vjVFf2otB-000il3; Fri, 09
 Jan 2026 21:04:42 +0100
Date: Fri, 9 Jan 2026 21:04:40 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 11/18] mingw: support renaming symlinks
In-Reply-To: <02fa15af-5a57-4557-b016-fd14b9107c6e@kdbg.org>
Message-ID: <99570ae3-d34d-c917-e218-ebbf3f9d7b6c@gmx.de>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com> <5cb3b10500339fec403b84e30721e4f6a68e42f6.1765980535.git.gitgitgadget@gmail.com> <02fa15af-5a57-4557-b016-fd14b9107c6e@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YSzTd0U8OYqJFOfH1KgNKCBGTWScHg+Q3LiLC428f++2tOo63g0
 Gu9KFo+XMAdLuFiq8HEXbLr+raF+Y1T42+Mpzmcqb5dgtLcHrnaykxuJYQFlsBBCni52feL
 Na1agHkO1J+tbaS2zJ8i5oxszC+Zur4XDxJYW8hmEsxwVbd5j0DNPdLh+awNsO4QTdzCFdv
 J40rw+ieAUXWmzfr2ZSdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u5Qn0d9+uA0=;Qv34jZqq8S/JqqqhYMzSyWYidcI
 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
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Thu, 18 Dec 2025, Johannes Sixt wrote:

> Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> > From: Karsten Blees <blees@dcon.de>
> >=20
> > Older MSVCRT's `_wrename()` function cannot rename symlinks over
> > existing files: it returns success without doing anything. Newer
> > MSVCR*.dll versions probably do not share this problem: according to C=
RT
> > sources, they just call `MoveFileEx()` with the `MOVEFILE_COPY_ALLOWED=
`
> > flag.
> >=20
> > Avoid the `_wrename()` call, and go with directly calling
> > `MoveFileEx()`, with proper error handling of course.
> >=20
> > Signed-off-by: Karsten Blees <blees@dcon.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/mingw.c | 38 ++++++++++++++++----------------------
> >  1 file changed, 16 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index b1cc30d0f1..55f0bb478e 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -2275,7 +2275,7 @@ int mingw_accept(int sockfd1, struct sockaddr *s=
a, socklen_t *sz)
> >  int mingw_rename(const char *pold, const char *pnew)
> >  {
> >  	static int supports_file_rename_info_ex =3D 1;
> > -	DWORD attrs, gle;
> > +	DWORD attrs =3D INVALID_FILE_ATTRIBUTES, gle;
> >  	int tries =3D 0;
> >  	wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
> >  	int wpnew_len;
> > @@ -2286,15 +2286,6 @@ int mingw_rename(const char *pold, const char *=
pnew)
> >  	if (wpnew_len < 0)
> >  		return -1;
> > =20
> > -	/*
> > -	 * Try native rename() first to get errno right.
> > -	 * It is based on MoveFile(), which cannot overwrite existing files.
> > -	 */
> > -	if (!_wrename(wpold, wpnew))
> > -		return 0;
> > -	if (errno !=3D EEXIST)
> > -		return -1;
> > -
> >  repeat:
> >  	if (supports_file_rename_info_ex) {
> >  		/*
> > @@ -2370,13 +2361,22 @@ repeat:
> >  		 * to retry.
> >  		 */
> >  	} else {
> > -		if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
> > +		if (MoveFileExW(wpold, wpnew,
> > +				MOVEFILE_REPLACE_EXISTING | MOVEFILE_COPY_ALLOWED))
> >  			return 0;
> >  		gle =3D GetLastError();
> >  	}
> > =20
> > -	/* TODO: translate more errors */
> > -	if (gle =3D=3D ERROR_ACCESS_DENIED &&
> > +	/* revert file attributes on failure */
> > +	if (attrs !=3D INVALID_FILE_ATTRIBUTES)
> > +		SetFileAttributesW(wpnew, attrs);
> > +
> > +	if (!is_file_in_use_error(gle)) {
> > +		errno =3D err_win_to_posix(gle);
> > +		return -1;
> > +	}
> > +
> > +	if (attrs =3D=3D INVALID_FILE_ATTRIBUTES &&
> >  	    (attrs =3D GetFileAttributesW(wpnew)) !=3D INVALID_FILE_ATTRIBUT=
ES) {
> >  		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
> >  			DWORD attrsold =3D GetFileAttributesW(wpold);
> > @@ -2388,16 +2388,10 @@ repeat:
> >  			return -1;
> >  		}
> >  		if ((attrs & FILE_ATTRIBUTE_READONLY) &&
> > -		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
> > -			if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
> > -				return 0;
> > -			gle =3D GetLastError();
> > -			/* revert file attributes on failure */
> > -			SetFileAttributesW(wpnew, attrs);
> > -		}
> > +		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY))
> > +			goto repeat;
> >  	}
> > -	if (gle =3D=3D ERROR_ACCESS_DENIED &&
> > -	       retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
> > +	if (retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
> >  		       "Should I try again?", pold, pnew))
> >  		goto repeat;
> > =20
>=20
> The logic in this function is incredibly convoluted. It does look
> somewhat reasonable, at least on the non-error path, but whether the
> variable attr is changed and reset as needed after 'goto repeat' and the
> various failure modes, I cannot tell. I give up and trust that this code
> has been battle-tested during the past decade and works as desired.

I do agree that the logic is quite convoluted. Historically grown, like.
But as you suspect: This has been battle-hardened, and I am loathe to
introduce a regression by making it prettier at this point. This is tried
and tested code, and that counts for something.

Ciao,
Johannes

