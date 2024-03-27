Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABD38382
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531000; cv=none; b=V7t3yq/nM14XqRTvL7kjD3wPi7vB/32lAuBQXR85DDQdjNgLVVF/AwxSgjKCXnvyWTt1qTkUIZF5lPoZhajJn9AUSp+v8tdEZUiUY/gB+vXy4vhmj4iQqtC/IaOS/9+SKJnCOJZGwvKzthMp4r+AqHHTRJ7m5iUPHs0E+iuuzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531000; c=relaxed/simple;
	bh=kcbThmhFBdgO2i/y6MGE6+vHg4Popphsx9FF3IPIdWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6ievxoyJfQn0tJ6fqdg2P8k2khqkkKSxQf62vgG2mAEu1KhXCOpotnU6RsAnXQpvuE5ZsZhI2+FLGk0TLF4ALi0Mz3m5qt1h5KOi2cMznv0SvtdZjgcowYLnXL1VCVCkP5Bwmo9zEQR+L9RTbFtml8gp8N1EJyHe8OyCrn0dCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JfIEDOAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JF2QfEUc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JfIEDOAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JF2QfEUc"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A3C771140077;
	Wed, 27 Mar 2024 05:16:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Mar 2024 05:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711530997; x=1711617397; bh=H1P9e973KM
	rO5twznf99crhW2MYbArvMmTSGkhBI03U=; b=JfIEDOAm8FuRSdjcekcuCf++TJ
	W4neChLUA6b9gcXeuZeLwAJQX+VYxsfQx319+xJG6gmT5QAl0qwK7UlmOInYNbQU
	Ikjw0ZiG80ydYry+IhjS7CSQF7r8qlncS1xn3bqd11KYmPUKaJFHkK1pm/QGCrRG
	AEEy9nIErrALhiMFoe+biYhEfoyiKNimYBup7aNQ8ZzppraVXsxXyyOOIlFSo0+X
	rtQbO/jM0uGhT0TA0796oUeBLrsDb9GSb/JFrSnh+oMK8cd40fSpWB9sIHdBHMfA
	vqAmC3llHXqLIek4kzQoF9sx0USg1b4hEJ0g3J7ywvT/6n6kT2vqODAFhaRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711530997; x=1711617397; bh=H1P9e973KMrO5twznf99crhW2MYb
	ArvMmTSGkhBI03U=; b=JF2QfEUcjvEkfRNOWppO48xLJI2XDNPgv01iDsPtlPw8
	bR9I++PAdXvuiEsd5UeLhWW8gIx3jI67eUP1rOwGpxPP9lNfGadwkeK/lFfjuJjv
	4D6djfGINWnY4zp//SsMgBJVLYgNRvf5r/Ru0xfZD4b/LO7S26s+XAtwZwH3wXXj
	yR6p0L9KzK4JdA87QV3pZhgqFshhC35DrwAzm/Y8Y8rQ7R+vHPzIu1NbAmLHRXuU
	yGQLXpiT3del/WD1pOKT/pTPN0OkakRE4Ca3VQ3g3Wy+WTRXlyOzLxsp2yrCKvI4
	Zp+8s+p/rCMLcyixbNd5s4H6v8SOS8sqovBcRZaX5w==
X-ME-Sender: <xms:9eMDZjXDfVJpBVq79FdTCwMvDg5F1iTpG16p2nh3mBybOzAmRRc1Zw>
    <xme:9eMDZrnXv0_DwL_cIOv1SxxLgZsRnIYDFVtUiaSJg5ouBH_8Ai0N6t7hUbHJTNXSW
    NZ-TA43sp4RsAL5kg>
X-ME-Received: <xmr:9eMDZvZna5R2524WH_AQvHYluv0haPf3Q-3inYiQhQw9rE9Q9IX3ZKYrSaCSzyT4_JKv60bISbCaafD8ABKqqwurm7xg9zmFOIvGRZB5VS4lHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduhedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdeiffelledvfffgtdejgfevvefhleetjeduhfeuhfeiledvleetiefgkeejueff
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:9eMDZuWzzSD07PgIZr89vFLv-_bwmiRhmiL2N6ZDnm4GB3PQZn4N9Q>
    <xmx:9eMDZtkalXAPHx3QQpRwv4D4hIjjLVr38-QDnIu1WyJ5YlLuNnupzQ>
    <xmx:9eMDZrcAjlTbPHBLw2JoZJjoWC5bMjqr_8ATOIneSekcivcnjciIxg>
    <xmx:9eMDZnFJbGJ53HTvKx2GcA5KP6AkNVyIenHIfO0SP_ycI2dOfnhuOw>
    <xmx:9eMDZjXCotHSzuLa9KHasqqLA-dYV43Umn8zQGyPSOimPqIhjD8UaA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 05:16:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae1bfe1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 09:16:20 +0000 (UTC)
Date: Wed, 27 Mar 2024 10:16:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/13] builtin/config: introduce subcommands
Message-ID: <ZgPj7_QaiIqD0yiS@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
 <CAPig+cTX72Jrc2=9jo23rJfnNK4VKdOuKrCeo9YQPfELBHn1YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V26lqRQkRMTj86FD"
Content-Disposition: inline
In-Reply-To: <CAPig+cTX72Jrc2=9jo23rJfnNK4VKdOuKrCeo9YQPfELBHn1YQ@mail.gmail.com>


--V26lqRQkRMTj86FD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 04:53:35AM -0400, Eric Sunshine wrote:
> On Wed, Mar 27, 2024 at 4:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > this is the third version of my patch series that aims to add
> > subcommands to git-config(1) in a backwards-compatible manner.
> >
> > There's only been a few changes compared to v2 based on Eric's comments:
> >
> >  7:  8ceced0fc5 !  7:  eee1fae50c builtin/config: introduce "get" subco=
mmand
> >     -+  With "get", Return all values for a multi-valued key.
> >     ++  With `get`, Return all values for a multi-valued key.
>=20
> Better. This fixes the typesetting problem but misses the
> s/Return/return/ mentioned earlier[1].
>=20
> [1]: https://lore.kernel.org/git/CAPig+cRwh4HCi=3DQ01tGJ0WOb59iE18HWSCNxG=
ogcreOz+2w1WA@mail.gmail.com/

Ah, sorry, I missed that one. Fixed locally, will send out with the
inevitable v4 of this patch series. Thanks!

Patrick

--V26lqRQkRMTj86FD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD4+4ACgkQVbJhu7ck
PpRq8BAAidBTm/oXyP6VOsOmQ2c01kXtbLzEx0wSx0rFzZPkfqRMdHzEydYDhsOU
sYfFp8RRSVuHM+dDQJFUsjsLKfZG7YNNMoUrpuGMUiAFcBmLbeM4cEbiBYNVkl3W
gpr+dOVzjpN1nXmomhlPRG0DtKBLN1JyxseV7w6JFjIo73OnrAHlc6Bkmd4ct0rw
XsRulcYbW7xZC9qepi4ouQrCJ0l+WIPOOswFZeAbV8b/uLDPwXSSilIKV0USiNqJ
QQryz+qJMnA3bSt9YnS6i+PtuzPYAXFBDJjPthCYvKHcUI0PN0VtW1Q1r7wZ3UR6
jNxLvA8KTD3o30P3PxQ8257wUKVTyStMczDlf2CFpVP3HmUM6r4Hu4DhYECwFays
KvisWHBAEZza1e+Kbp3eNjZphVzHZQffxO0NWAsXSum7dMEDEtzWdpdVYhu7AuWx
utoodmF0NQZLLbaNiF96IKFnxm5NPJNhrUxGTPEL/4+v5lB1IGO8CIrtyQFEGIzn
IOsyP4N2Jj5ep1qjA3+0dYSmSrlpm1EvmlTAaNljUuleqGBL7Arrd9/zg8o8i0YH
2sr8SSjI/ATAZrzNh0nf/d+RtKDzBun8uY85di6f07RklVadFBwTd6yXVy33dRRx
BNO/1lPDc1mJqsIsdi9T4OvXRIyrTLJviEBxjWw8EvDCM4ReblU=
=Ppq1
-----END PGP SIGNATURE-----

--V26lqRQkRMTj86FD--
