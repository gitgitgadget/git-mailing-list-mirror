Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4E3FD1
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574208; cv=none; b=ueqp0olzsFD0iOu2WOOcYyXZwgEukxv9kTL3uaNpwy1ynlIS6ZPKVAXbhlYqnTkfb73ZyZfZewXl7uUJzikPXrq/67kHKt9LVOUe1uzMSx4gH0VoOu9HvGLLrSQ3fUdNWTcjY7O5RTPOV+gaBEOfm8eiYcIpGoHWddvx+8Hg1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574208; c=relaxed/simple;
	bh=2Q5HI65zHjB5IILShp6eiqiJMf2E+1uGTartI5FXdnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p12M99tydHHXlxJJDuBtzap+8T3/Ri92eFw13YxdSzE/l/2wXqATaQkrVjcd0xg4QR/zeIpVYrFciOLnhR0GCTPKtwH8qC6w4NPEdl5tHr8WMZHzorWcUxaocRSYQD0i7tTwLALRlWSVHO5fvT14mvHEUPdpZ3S+g1Oq7bhjwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXMP+ZwV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXMP+ZwV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so3472975ad.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 18:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734574207; x=1735179007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq4r+pWt389PS3HhGvqWKgsb562Z+dH6Fzb67T1ggVA=;
        b=CXMP+ZwVu5WoTqxQrwa8xQkL027lxkwwnyO4jd8eIEOrENVlzTQTyVjQHb6brsHQPW
         jGCGnSqZJZ4QhE232s0RGBGX5pnvtldJ7OvHRqA/RpYOj+VKXl4Qy1B6vLOtAGF8V5xr
         UtwTmVXuUMEJG9hxAoO+u4DlqXxBC/CsH0l0OqEf3Vv+VkLXTG698rM23s/Y4GHrezsa
         UGUHYPyY5elwUVZkGzwdkTc9ulbc+yPU6oXdSRkpSHnwTSQcLUemArvZjDYhqEVTXp51
         1yuP0FSeXJZ6vgv1FDWB/U1q56KqMxGP9jRRcQS7mRLMXbDwTGpGQzvpDD+Le8+/g/dg
         lCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734574207; x=1735179007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq4r+pWt389PS3HhGvqWKgsb562Z+dH6Fzb67T1ggVA=;
        b=ZcM9TrH9JBvua4dpp9nbEiZ3T85lKMC7XBypFwWj5174ejampDh+GBTDgU87Y9nCSr
         sAegXgfNGu+kmDMg7VfGfoNY1C6B/PmlYuENWf3DStWJCf06TW91koQII7Rtvch9m3Bs
         PUl9UUQZb4iR5JMLXDvi4HlktGMil4KKfQo0s6q2MFgRzqH6Gzv9zziZswy7kR8hD0QX
         SZRlijWXjaAuhNqM8ydvUxOBLY9DYybbbSuPCyuJCAMWao/Z4gXPzm+PAS/aATD2LBfc
         9UcW1R770AyAJIswLFduYCCJM0ORe8y00hH7Xh1pboTzZFVS1t/BmHPJPNd9p0giXGTM
         WTjg==
X-Gm-Message-State: AOJu0YyBKKoDS/7aTTqjR41MOTDGba6PvTyzY5Jew8PdfrM0uL9Y5xNP
	sKFf51v1HJASAxIKfl8PdeooWM3WtBWHEegnEjM2/jJc8/xjiTRQ
X-Gm-Gg: ASbGncv0ZFGLFS7JO3ZjrccOdVRMkXbUEgq1cj1XmSiz3FjFQ38cPRKIRS3vuPqfS2V
	tuuvSTSNEv2CEZQH71Jfeft3am4slWSEJ5Sfe5Fg0mEV8CqsnnMQZXN5aDDS2Hr+I/iY4pMxch6
	Z0YQi46SgzHS99msc9IlW5XyW+923MtCDLSPKr8PmOMi5d97vjLji9m5fDpGz3vK6eXwf9ogL2L
	9SXbihBNg3eMEHCtFMeih/ENJYSEROPwb0if4sl80U78WqGcpClLSJs
X-Google-Smtp-Source: AGHT+IG2r4BVOHgzwNb91wbV2nwcffqhd0hUIOCns27FY/PDFvUNSh9zLEA4Hgv+dTTuFFPQOuLauA==
X-Received: by 2002:a17:902:f681:b0:216:45b9:43ad with SMTP id d9443c01a7336-219d968cd9cmr24774485ad.34.1734574206580;
        Wed, 18 Dec 2024 18:10:06 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962ca2sm2088305ad.5.2024.12.18.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 18:10:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 52B2D44DA0D3; Thu, 19 Dec 2024 09:10:01 +0700 (WIB)
Date: Thu, 19 Dec 2024 09:10:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
Message-ID: <Z2OAebI4pQ2K57vA@archie.me>
References: <Z2KfIl87JOWdcGR3@archie.me>
 <xmqqzfktujuk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZrjDo2Md5wm+djw4"
Content-Disposition: inline
In-Reply-To: <xmqqzfktujuk.fsf@gitster.g>


--ZrjDo2Md5wm+djw4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 06:49:39AM -0800, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > So I'm interested in GPG-sign my commits (that is, ``git commit -S``) f=
or l10n
> > pull request (which I should submit in this cycle). Is it OK to do that?
> > Drawbacks?
>=20
> Instead of talking first about drawbacks, we should consider the
> upsides.  Why would we even want to see your GPG signature, when
> most of us do not even have your GPG public key in our keychains?
>=20
> What are we trying to achieve by doing this?

Just to ensure that PR commits are really from the respective authors.

--=20
An old man doll... just what I always wanted! - Clara

--ZrjDo2Md5wm+djw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZ2OAaAAKCRB7tWyQc2rT
CArkAP9TRp6EqxeSpVBMzbu5T+9MG8SU4mn+4pqKpMjqB1tVjAEAv3LAp/zhgad+
YERRj/ziISDbuN5lKsMZ2UGqcBKXfA0=
=w/sl
-----END PGP SIGNATURE-----

--ZrjDo2Md5wm+djw4--
