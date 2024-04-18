Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45415F418
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442601; cv=none; b=Gep6P2QSd9zeiz7vHoBB4aXF0CmdJ3ws+h48kZEcooA3B8au5z3tL9P7RcpIXp1j/MDLrl5/Zb3HO5gZ6fNgjSdOkDgABoadzhvhVx3d9oz4MmFifTaNwILBRSTWjbJLFQ13Wf0HrbKWZdEyJkfegTc6jblMYV4zNTL/ZqTuL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442601; c=relaxed/simple;
	bh=SDkl9beF3rBHX3NPqmsbpJSdxmKF45fb37Xc7+dVxwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quxFJx8sOLPO2gG7kMAP5mGdf7O/jUMiBSSSh/T46K9CjX3uwbpoGXxBbxJGyY+rhYBB0tEKIx0PhQS2Tc53kAFewKhgAeBA9FhPswzPPuoGAv4f6u43IMdn0+h4Mjr8FWXRypejPOEUUCQno6OyRuEPFV2nrZjWtX9aLBZxkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OuvWFHtB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=POkwmf6t; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OuvWFHtB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="POkwmf6t"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 495F91380236;
	Thu, 18 Apr 2024 08:16:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Apr 2024 08:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442598; x=1713528998; bh=29dvzBuHUr
	hZOzS20wGz05nIIWQpkD+vJ8sP5RUavgo=; b=OuvWFHtBU3MW3g8u1mQiOpoorg
	RM8eVqSNvN+sBlfLHSXsJHA5uArOIaJUCy4MFGRew7+f0teuuYi+VWibH5hf26Xe
	lxC6XvX4Ejb+BBV4CE0xeg59Ex1GFDGmP6SR0UzrdospRHicARdCQ+bb1JZwkiQZ
	B13zYgS0j8lFPE7XGpcnJ54drawREGVwAUWKh9e89n/B35il2HB1jJK9HDcFGahD
	SntUHjfP+AImjNGmJpxcmRUIAjeag1a1xGMgS9wcWjwxBXhnow9yxn/4TtBRKWDA
	7dNbcVksc4o+NvS6NUL9dQCnJt46In/oSiDXoQ0dWgff9W6SWMbRRZld/mdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442598; x=1713528998; bh=29dvzBuHUrhZOzS20wGz05nIIWQp
	kD+vJ8sP5RUavgo=; b=POkwmf6tnyp+Siweco9A35lXOyeW6tHIMyj3QWp9Vybj
	XGm9lrVhdbucKmm/T6cXHI/71F1Gw842W6PkW4SopL5jsvfOgkt0K7bKqkOYzNqz
	Dt8t/+M/UgXwz6F9T3YCuOkW+JeFBRIALDIRh2HD0KuDFysYzW+8a1yPuYqKc6yx
	CI+ACZ9yo54QiwH+qD3Pn50W3k7kB/eawruhBzNouDyJX6yPjZbrh/ARMJW9wTdP
	e5h0Plxo0oVgk2kNonEnyy97CwYEXy2PyB6Oce8mDbNHqksRY90ORrjgHGUwfpa6
	RsLjlPiuP/hr8thE+RQro2Ow9v9Vwo/II23yP83Tgw==
X-ME-Sender: <xms:Jg8hZhFZ8TJGPVH5lyO7YBI-xGR_ejwdi-cbdBZvLyxL3FhNSfm8rA>
    <xme:Jg8hZmVOaqimwmyOX8EI3GkXmITw8dWjk_oZ_c41Byj2nNAe97_FG8IYVGo4neUKk
    66VJdVv7ydHrZBJfA>
X-ME-Received: <xmr:Jg8hZjJ3LgqYolnT47icLe8KRTNPG298z7rAXf-u1haf4c9SaUrZ_ocag_QBtopm1xwpNQI8hFaITw3wJJ-4w-_9WHnF-3jduBHnnNS4a_SvAexKKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Jg8hZnEY25dI3mDssAAV2SuUG8bNtwp3_GZa2qc02wk-pMPilSH3IQ>
    <xmx:Jg8hZnWyrkKisKwVOurJNzfsc_F2TP2mqAY_Y7vsaHG5gXTV0fNV2A>
    <xmx:Jg8hZiO2edNn3LrlJkmzi09tSa0h7q287f2_YtAoGTFoqC-wVM3cTA>
    <xmx:Jg8hZm2QVxlBiLi66WGUTyFSc8SOpQfePgtFBHqg_gxyCd8rAJ_y7Q>
    <xmx:Jg8hZki5D0zxHVy4Fs0N1-DXrNoyIdIEVKCwuyYYrpX8xAkqmbJXb5pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:16:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f4a95f8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:16:12 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:16:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] builtin: stop using `the_index`
Message-ID: <ZiEPI-ef8qXD3SqR@tanuki>
References: <cover.1713180749.git.ps@pks.im>
 <9d5f2eff8ab2a9d7a994a2031a31d4fa6f4791d2.1713180749.git.ps@pks.im>
 <CAOLa=ZS2S4=bC=s=vFnSfgvB0jZoKmH2Pi00V1Asyxo_yKSHPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0nsSfVoW7OQLexAp"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS2S4=bC=s=vFnSfgvB0jZoKmH2Pi00V1Asyxo_yKSHPA@mail.gmail.com>


--0nsSfVoW7OQLexAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 05:32:50PM +0000, Karthik Nayak wrote:
> [snip]
>=20
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 0c948f40fb..fe873807ed 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -3,7 +3,6 @@
> >   *
> >   * Copyright (C) Linus Torvalds, 2005
> >   */
> > -#define USE_THE_INDEX_VARIABLE
>=20
> Nit: The other changes have a newline after the header.

Good catch.

Patrick

--0nsSfVoW7OQLexAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDyIACgkQVbJhu7ck
PpRQyhAAju2rtrS48Z3Oz6tYgUAyelZklxdjYE2sbjzvkgAvl2+J2UWoTjfhtrJ5
N3fcnLIy8vCOOPDO8tEJGPp5j5ZHjArNT4fMnr4fQSHuEKJaa/gwxwcWArbRDcOh
0XiDx+sRhY3CTxVMsAvLXvkuJ9kwe3VmHO2D4kWeFcFIyAzy/f3tyj8yGVuURFHt
LD8jUtuELOMaCvtxCWzTZXzvGqCwt8a0wcZY6i+7xh5XbQw+W3E3IgcjFLQcl7w3
2wGAmlStGhOXocRCvnrVgQWokZ3T7iT65fYqkc3/BILUwXFIL1wBJPg3W3VoxvZn
set9aFO6m0WGLSV3MFqQCgk1M/oL0g9fWMYs4oJDSLcFkgy/wjNr+ZFpYB14VPVy
Eb2OnNbfccFwe2zazVUzmqZpd6/QkG+ZPTJ4nV5C0fsl4wqe01u0Y/43/vrKhVln
hi/aJkjFtpfP/BJMj668f/Plt8ELsoS2sFNLSTD8rHwOYQjTAckRkRaoREUXRcWr
RhcOlFRjrzMWuq5C2PdEcfa+RyLa4/CKu0dgdxd4k6zgjgMx2DIjiqT2R+lUx7nG
kE81jOgeVdIgMpCnbGhh9tTcqcN+pAKvHb2TvUPxyBgkCfV+X9jT2KxMq8bd8kJl
OqvtyckZ/ckv5C6JgP+SRFYYgwBM39KWrN4mv3s/nvmRCj2nWs0=
=nisY
-----END PGP SIGNATURE-----

--0nsSfVoW7OQLexAp--
