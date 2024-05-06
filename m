Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690C44C66
	for <git@vger.kernel.org>; Mon,  6 May 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000582; cv=none; b=hSLsMjT+Q2aZ941dLaUEAge6OOIXvfcbPDLl7sWeP9PGSTIyFZadACVk8sqxcr/FHaki/YRI/6utLJymuD3ktvqEYHVqfR67GTAuyuAlc7RPUGQVqgWfnEfbDsSd8L24qJ3OkkilDTVNb3fQ8Tijn14O3cb7lpLUj8giNYByVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000582; c=relaxed/simple;
	bh=GKPD595I22SrbUvYHnXnhoxI4jneIMbmQuIz817XiV0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZuKKfS2iDR1/71JqBGPu8cP+uS3HB9z/XPCdlNJRW39VYqCSKzPi5z9R0Cvw2jGqLfhZg+Ov9oAYbRSllK4lbCyIRcJMjDAQ0Wx76sXM5BLzT6jJLGgPzSSY64R+Hwi/Nrf9VZP6nhAvCwUlD/5wejmsPpTa0hHJf4NsFHgZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jmWn2j6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Px/6O7Og; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jmWn2j6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Px/6O7Og"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 25F4E1380954;
	Mon,  6 May 2024 09:02:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 06 May 2024 09:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715000579; x=1715086979; bh=xDhtfHJnWT
	M5hN6L6zahCJZnHVgSt0pqEKFpGGCQnnc=; b=jmWn2j6YMCPpL8Ng5spXrrNqYO
	JCHZEBfycJH7WYjDL1Rr+sXNFwnqgeZdYfsFyuD1IZUyogfmDLpjDCbPYLwsGTTS
	nhC6vpIwSFnTmxX74tEOHtCMZeN7To4JAZmyRRPfIrMQURm2nMg8UpmmOcU/i1f1
	m8wnGZFYsNEIca6UxgKZq1PMl+DTZescvu6trU1xV6ezcf6uJX47rcPCL0URRhue
	zLJrUurtGZVRccqAFrw/DYzG1+IfLoQuY17y1rvnOeQIJmB1L2J40pr/JXr3beMe
	xBg4Tycm8EWD40ZVMy51zjhqhQU5+rvXRgx8+Y9rMGiqOsSrYaLdGaXsVAbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715000579; x=1715086979; bh=xDhtfHJnWTM5hN6L6zahCJZnHVgS
	t0pqEKFpGGCQnnc=; b=Px/6O7Og568VMITZRrCeRfeI2+Vb+GJ4Gp547CxpB+eC
	5DlcuhwxkTw0v9pQwhEvmGW/hlwZ9uD4buWgeK27f7rqL7q4+keKqO6+Qx7s6V/e
	aMy5fPu/3+T69OpBVf55vPy1BYWCeTviJguqegiL4yCQMQ+f+UeVEkDhznK2ZSAR
	LrkXiqnHgd4bQHcP/9xXQWgVs4EK0OK6Nsy7zVOHPrmIxnH9cRIaV11U/3twFHoR
	FXuV6YlGwmfV/0BharOyUinsfaOe3TbsWb9YL4ik07w/pFL3WS8Vd6/EtVp2S4Bi
	y2SB3WVVhX9MsGXQbm/fXPKU74lGeDAkhXgumkQNNA==
X-ME-Sender: <xms:AtU4ZpDzNUoj4DtbHpVjLG7YmibjGM_dr7NF0TOEcfr3D34CjIy5Kg>
    <xme:AtU4ZngwgsKSSsREHcVyiLmmegTTtqNp4b1sE14LPqRlXtz0oVSNlEmmweQqGRHjl
    daywHBQCkwbzBDo5g>
X-ME-Received: <xmr:AtU4ZknL-n6tD0ZdIwqmSFAs_bHWZF1t_3_Q92gwHFlCO_iJWHBhQ5datsHTMapX7RmlW_srdMmD5z53Phfgd9JiR-oLgEpU3Guiavx_I0iMPRNq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:AtU4ZjyQm13LTDeQYgDy69oPBESEY2NdYxeK9tkCchuGIbiypth70w>
    <xmx:AtU4ZuQVZtoeKMGzWBvfBuUIulMFHAro6wFkjHGVcJ9qRfsBQ_FzBg>
    <xmx:AtU4ZmbGOBz_NoR7a05Rrp2dH3WNO62aoiEf2wDH-Zneno8bxYWCaw>
    <xmx:AtU4ZvSuEdONdSmZygFZOK_YlgxnT5yESGK85UMwMIT52-5ZPYb2dw>
    <xmx:A9U4ZsdS8dK89aPGavghm2KLN-gis5O9ABm07mjXmrxudxwDThvF1zP8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 09:02:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 964f4f0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 13:02:49 +0000 (UTC)
Date: Mon, 6 May 2024 15:02:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Justin Tobler <jtobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: fix Python dependency on Ubuntu 24.04
Message-ID: <ZjjU_Gaum8iYLks8@tanuki>
References: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
 <c2dyqdqge3ypc7syissjm3mh6fqftojvincu4qizkuravc5ll6@bjgjlcas7n4k>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t46lUTpvKJDwJMHK"
Content-Disposition: inline
In-Reply-To: <c2dyqdqge3ypc7syissjm3mh6fqftojvincu4qizkuravc5ll6@bjgjlcas7n4k>


--t46lUTpvKJDwJMHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 07:55:25AM -0500, Justin Tobler wrote:
> On 24/05/06 07:35AM, Patrick Steinhardt wrote:
> > Newer versions of Ubuntu have dropped Python 2 starting with Ubuntu
> > 23.04. By default though, our CI setups will try to use that Python
> > version on all Ubuntu-based jobs except for the "linux-gcc" one.
>=20
> Naive question, why were the "linux-gcc" jobs the only ones using
> Python 3?

This has been introduced in 6bb40ed20a (ci: use python3 in linux-gcc and
osx-gcc and python2 elsewhere, 2020-01-23). It's been a first step
towards exercising Python 3 in our CI pipeline. The jobs were basically
picked at random, there is no inherent reason.

So ultimately, it does not matter which jobs use what. But what does
matter is whether the image even supports Python 2. And as we nowadays
do have a fair split of jobs using "ubuntu:20.04" and "ubuntu:latest",
I'd just use that the the criterium to pick the Python version.

Once we drop support for Ubuntu 20.04, we can then more forward and stop
supporting Python 2 altogether. Or maybe even earlier than that -- I do
not think it is reasonable to ask Git to maintain compatibility with a
project that is end of life already.

[snip]
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 473a2d0348..273f3540a6 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -325,9 +325,13 @@ ubuntu-*)
> >  		break
> >  	fi
> > =20
> > -	PYTHON_PACKAGE=3Dpython2
> > -	if test "$jobname" =3D linux-gcc
>=20
> With this change, "linux-gcc" jobs using ubuntu 20.04 will now use
> Python 2. Is that what we want?

Well, as explained above, the selection was arbitrary in the first
place. Now it's less so as the choice is mandated by what is actually
supported.

Patrick

--t46lUTpvKJDwJMHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY41PwACgkQVbJhu7ck
PpRrjw//fV7Jl58hzA95+JdXzKiOjeBjDdqYOSIum9R1cH2e7pzWpnkeGuIREcwg
qpe53D9var1gPvmtMj0htxBGUgiHg8JHQCvuvrydMfDeqVMK8glA1QllqTTRhSYX
zXS5mXCWV4uVpX1kJKMzmhfnXFpGQresyo8hBg/xU2ICj6V4RoqHuULZtqFUGdmn
Y24OmxVGmKe4fqXUBTX1petvmtfma6wVkJq6f3QOGKfqsUIMEwhdfMVKC7EegKR0
bJ/5bbogWh4e/iyJhk32ce51oUxfxY89dCRsaMXMnXiawI5m04iSWOY5TZ6VI0Ry
GjjdO1nTNS9acMvGpw52XZSJEMqVEjkzYlUeQ//WqaHNjNgGwNeqTMrUAPp1KORh
27+jWIGY3IgJsPSWMQ2MTlK0nwgoGdeQfBQWvy/829fTvr6kMTVB2RC51Jgej7W8
u0rGkZHiAoM7GvuFhZKCocj/zTde4ZDyJUu3RLV6WRAGBwM2PnswABeDWO93ZRM6
2FYfNcDRy8z5fww9kOWUK0CMIKDYc5b55S45MZWHnyYKoXrKIKc/ESwGDaNoE6rH
2+C1K/dfz68jjqR6vjC3RQURIcWR+W981chsCiFr1elelQGUqshvH0r5r8utD0RC
SMIohWnp2RpnyE4cP/J8VTy4jDwPbVkw1jpOOqFgeF5JhetkTKM=
=PqLT
-----END PGP SIGNATURE-----

--t46lUTpvKJDwJMHK--
