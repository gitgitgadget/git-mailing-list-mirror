Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E4223330
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609391; cv=none; b=qNx5XMeC1ZEerl1bbP6FxTNM0Y13NSXA0LgZiU6ajOJtGVvBEJs/uGDIAmuigrZRoZJti1uP+MKptX2ULhazDWZTWAWkjtLUNJQNQlc2mahgyjVBhXGPinpENFtIV16ffvMmcCHcrIhhlbW4NM6TA86v755n6GsbEWlCHXdo9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609391; c=relaxed/simple;
	bh=gD2nmkT+egWhwADSmiXJY2ZwNsfJPAZwnUdkBjczgkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpkMYze+EFaZZzzDexM2WxMUkFXzynFn5qxwzA9bT7Fz8qc2JIYZuDzM9LYpLHCRlY1E3VnfO5OF//9Kg3tWSO0FriciAAMTALuP7m4Q9SObAUNRg3soqzRfmRP7pmX/aNIjEhp7jIG6IBZ1CYEmL8w9z38gefhSSW6NcwkvHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2AwedKR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2AwedKR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216401de828so5962945ad.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2024 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734609389; x=1735214189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IH662ndsONv6G8buHr2dQD1EmZ3kWlPMq2XdwC0HUlA=;
        b=O2AwedKROLFsaNas6yNMr1AiCEYi5G4uMSWQ1YKeg4oaLQtv0NYCqpALOw9CfD0Caf
         3kzSNwfARnOQbglYrdgraPUg2ROBT5P76KPGzcXDX974/rtbIzeLO4Zo4PxomM5GTqaH
         oE+gfw3LsnjAyJN49qYdHYqRQePb5iC+4RAzHHBnWFcUNfmuB+OpqrVFwnI4z264wFjh
         GWISq8+IqhRU3IWBxemQJHFgwlkrQxQqu7pT/advfnabnAZ9Z6oKluoKG6XmGUuKpBYr
         dFN91HWGmkvoG6QpTMTwqHbGrLNbVNlFYyzC658tX/kDfMEu2F8yy1kXOC8DmtZ+S0Dc
         XrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734609389; x=1735214189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH662ndsONv6G8buHr2dQD1EmZ3kWlPMq2XdwC0HUlA=;
        b=o7XmfuemEhHJzqi8ntdBkB5yk0JRnPA8JpItBX6Uc/CVBgqZohD8sOizHUNvUxC6+5
         BJre0Oz5LpYLdClxP4L3UxTI2xLpxvG3FGGLREXqxAJdR+sbKzI+zKUkQ6qF86GRjatN
         Iqhv8l8Qb+5ec2rMwdcTqwSOff8UGZb/zon/ouDqpvittm595JaW2LGFtGjbB/V70qpm
         u3phcreSHDn9QbHwunI0wIZg2dIDsqFWVk2fOek65LBODJhUWZMmmjyxwRAtSfhNXq2k
         eJJ/EPm9mCQhAxitG0u1s1rd4VCOSJovRFZWYlX1N0BbXZKe0rnhHRDSR0/vM/kZXsjq
         Xivg==
X-Gm-Message-State: AOJu0Yz7zt3pG76AbfoAVIYw/JukTG9VNL8vmxiFoaKzmH2lsEV95s5O
	OVcpsn5xZeXqR7uvQ4GhKNr9/YTqAKBW3iR0alEfEtNGycobed8e
X-Gm-Gg: ASbGncufZWiveclSR/reMHA/yhiYembg6MCbTflQd6ccfRoqUBu3STo/npihbgudKIB
	ToyLgm6iSEjuEA47s3Zw+WUAD3ar1bU8VHf35FXjlGt8Css4aIh4P92a9m2JR8B7xUND7+NmeCw
	sISK3UhDqAu2p6/qBr040FiWCglCfbS3m1bTRbSg2V5Wv9poCP6nivWsVyZfInvQEo+hip70/VB
	7JUPz41L8BVZX/XSqeRgBBq7a7HRKmYpy4wOMaQcNEa89ke9p3CnOy2
X-Google-Smtp-Source: AGHT+IFtLJX1pxqSmq1uWCMhxGcj1ES41kWnCp8TQtxx5Ye0hf/SKMzzfiODr3Ktop1djfWXP7WMcA==
X-Received: by 2002:a17:903:1211:b0:215:5240:bb3d with SMTP id d9443c01a7336-219d96ff2cbmr40322425ad.42.1734609389118;
        Thu, 19 Dec 2024 03:56:29 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ea8fsm10766915ad.89.2024.12.19.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:56:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6AF41420AB14; Thu, 19 Dec 2024 18:56:24 +0700 (WIB)
Date: Thu, 19 Dec 2024 18:56:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
Message-ID: <Z2QJ6CEbHyOObeEl@archie.me>
References: <Z2KfIl87JOWdcGR3@archie.me>
 <xmqqzfktujuk.fsf@gitster.g>
 <Z2OAebI4pQ2K57vA@archie.me>
 <xmqqh670nrb9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zE9+vdi2nzhTgalt"
Content-Disposition: inline
In-Reply-To: <xmqqh670nrb9.fsf@gitster.g>


--zE9+vdi2nzhTgalt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:02:34PM -0800, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > On Wed, Dec 18, 2024 at 06:49:39AM -0800, Junio C Hamano wrote:
> >> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >>=20
> >> > So I'm interested in GPG-sign my commits (that is, ``git commit -S``=
) for l10n
> >> > pull request (which I should submit in this cycle). Is it OK to do t=
hat?
> >> > Drawbacks?
> >>=20
> >> Instead of talking first about drawbacks, we should consider the
> >> upsides.  Why would we even want to see your GPG signature, when
> >> most of us do not even have your GPG public key in our keychains?
> >>=20
> >> What are we trying to achieve by doing this?
> >
> > Just to ensure that PR commits are really from the respective authors.
>=20
> Yeah, but my point was that it would not ensure, because practically
> nobody has ways to validate the signature was created with your
> private key, and public keyservers have been tainted long time ago
> with fake keys with the same fingerprint, so would not work as a
> good way to obtain your public key and be sure it is yours.
>=20
> If this were "because we would want to eat our own dogfood", and if
> we find bugs in our code when different person sign their commit
> with their own signature scheme (i.e. you may sign yours with your
> GPG key, somebody else may use their SSH key, and yet other people
> use their X.509 certs, it might give us valuable insights, but the
> resulting history may be irrevocably tainted if the bug is on the
> signing side (if the bug is on the verification side, that is OK).
>=20
> Thanks.

OK, thanks! I will stick to unsigned commits then.

--=20
An old man doll... just what I always wanted! - Clara

--zE9+vdi2nzhTgalt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ2QJ3wAKCRD2uYlJVVFO
o7THAQCrgIQ/rZAa4q5SIdcPoZSiQDhloF3Z5WR3MKelYlpG7wD/RKttdQ3ygAU7
Zc84f6ed7wYCS/HMMLKTzClASBO6IAw=
=bS7f
-----END PGP SIGNATURE-----

--zE9+vdi2nzhTgalt--
