Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8961607A0
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634740; cv=none; b=gK4TjfjvIJKjPTtpSd525gLHNR4LNgQvMRdc5yGn6o4ZxAP2PO/r0ASC+zOw7621s2ScvajbOC1eUG5I+iKGPV4ye8xk4j84wLt5lSfuZN1utv3fOoSO2/NHsNtblNUdtwerIX8N/AD2yWOwL07MetC1dOfyGGkxu4FKojoS668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634740; c=relaxed/simple;
	bh=BH6HO/BP/SzNl50twwKKc+RnAyqwtKRZqN05TikwdQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT+rUgKMWxmNtBa5JMMCBZke18oOhYZvHplszKwHshe1UL0PnaPHl1N79/rSmshGJoUsbTnWtJ/AZWLZ8RKKlkqajYpw8cgU2WGeheaQ2Jaca9SrUkxgvujExN8i/GRwfhi+Iqo2vD84EcVTZLKPlzioipTtQekDRsN8QQZNBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pxzLbyMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hv7IVc5w; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pxzLbyMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hv7IVc5w"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B2ABA114020A;
	Mon, 22 Jul 2024 03:52:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 22 Jul 2024 03:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721634737; x=1721721137; bh=7BTVfy1+wt
	V1Ta/BayYOrcHoMe7Dea4uvpz1qkqp8mU=; b=pxzLbyMQI7ROOBOqZJk4zl5+DL
	WSmOawG4UF2nsgK1xk05kFKPk+KLz4KS54rjHxAnnm9P1JcIalMZlnAMM6zjBELk
	pP6P8rirAMpfNWJpyDhDqQC1yCcI/Wbk0ofmAoig1DtbJ5ytRl5go9iJGp3qUVYq
	F42Gco2lwCiRssNEW0eTF5yufMCMwhLP95Xmwcdi6hk7f+0kK0c2c/6Kim3z+OQ/
	12P4fJPHH2X05F70qgI/k7F+LsI6aClPv/LHcvt9Z0whASWOcUKaQVOZtiOF0hR8
	5dOtG1DfPEtrPCptjGQJLIMLnPSutaH97jj+AYotsk0ywoUTsmPPpumRL8ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721634737; x=1721721137; bh=7BTVfy1+wtV1Ta/BayYOrcHoMe7D
	ea4uvpz1qkqp8mU=; b=Hv7IVc5wJZT8+HM0k8SZIhdEMDH6duEhWVlouMC6jUN7
	1wq8BBBudy1QQung3gGvLw2cIGi9x57iBDAAFaqqPVkAiKai2dfCsE5E6vEVJOQy
	SLSodZGf8i8/Mt6VCoe8j/HlXZkdOaSr1wiXLhZMa84m2l/0bR1K3gIwAvlTOLi2
	P91MNyqotO6phTVd/ukg2BaCRHiGGX5PVYr9zJF8wVd02ehLVrGMbogT0kkeCIfz
	VZvhx3DWk6zUWyjPlZXBlSrcJCEolPWdadK+4gXNvTglCkUMgeg6+OpaUk6TNHgM
	VGB7XsRHSPZzrDssH0DmqEogMYrdiBBuaJ9TPGX2wA==
X-ME-Sender: <xms:sQ-eZtNSa10o8qR5HXCRrPMxRRsFZchyeYLVMptf-zXstcEHLVm34Q>
    <xme:sQ-eZv_xlc9onLooU43GXzcEOVa5l_AI8wZPwcddfCl7pJTDM6JPcXmJJvE24pINN
    K8tWcUDGy6dZStzow>
X-ME-Received: <xmr:sQ-eZsR7t0qQlmhoZWLILtBfqUth5I-WpNQeboC_Y9cpKK_s6JXDhdkVvaDzfWt8xnirJFs1JYQ9MGbANOdAfF9N0UN29WDImvysSuHctPPyqjdN8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheeigdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sQ-eZps25f70t8vZj0TqN_5NJ-ZICGT7GmcdXzdkcuYUHkRaKod6hg>
    <xmx:sQ-eZldGz3MUbm07X2r0ZUy_8IEPOB30R4-AcrmuzGkIkvXxW-tAjg>
    <xmx:sQ-eZl25jVPYHVrZS3LQKTK99Nl-aR1tFe-DRMXVM9pqPDj8IPQ-kg>
    <xmx:sQ-eZh8MO-KxF1sfppy3QbUONv0_P26sKw6DcWVIR_2hLo6rgYryFg>
    <xmx:sQ-eZp4Nfz4tOdbnH_T-SpZzPILGdVlwgcl9L9Fq4e8ivvhc1iAu6UXl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 03:52:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ae0bc83a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jul 2024 07:51:02 +0000 (UTC)
Date: Mon, 22 Jul 2024 09:52:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
Message-ID: <Zp4Pq-adl2mwA8ql@tanuki>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
 <20240710011206.GC1526498@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sC378RLJiYj3FeAM"
Content-Disposition: inline
In-Reply-To: <20240710011206.GC1526498@coredump.intra.peff.net>


--sC378RLJiYj3FeAM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 09:12:06PM -0400, Jeff King wrote:
> On Wed, Jul 10, 2024 at 02:51:58AM +0200, Rub=C3=A9n Justo wrote:
>=20
> > As we describe in t/README, it can happen that:
> >=20
> >     Some tests run "git" (or "test-tool" etc.) without properly checking
> >     the exit code, or git will invoke itself and fail to ferry the
> >     abort() exit code to the original caller.
> >=20
> > Therefore, GIT_TEST_SANITIZE_LEAK_LOG must be set to true to capture all
> > memory leaks triggered by the tests when SANITIZE=3Dleak.
> >=20
> > Set it to true by default, and stop worrying about someone checking for
> > leaks who isn't aware of this option and might be missing some leaks.
>=20
> I'm obviously in favor of this direction, but...why stop here? Do we
> expect somebody to set it to false? If not, then can't we just get rid
> of it entirely?

I'd also be strongly in favor of just removing this variable altogether.
I found it quite tedious to remember setting it when working on the
memory leak fixes recently, and I'm not aware of any downsides.

Patrick

--sC378RLJiYj3FeAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaeD6oACgkQVbJhu7ck
PpTlDhAAi0ZBWXqZJP5H+PF0z/y+GKdGCb6dN40rTn6n+rXxcwt04ixTfEy4XW6O
rXHrEC8hT9jABHJYRe8eiGjyanSjcJ1MmqqQ1yQAamqyGBDDw/mP+dheBO1d3GLd
b5cCTBB8OuWeqXdsQavClR5KJenWezkLguuLqg20MITzai9xvA4ELUHkJbsyG3ew
JVMKJXh00FwTAHy+u47HK5eVutZ7iHVLZgK6yA+T2Q1fn3rwmBqdlTqcNK4HcWlr
fe9lDC92UUPbfI1HjRgDl+3UJcQO4DS4MlEwi8+HnxGOoe0/rSLJptrfEfcNrIND
Uet4M0HsPFN8ylGvsbrPEbkUSo5XR425HGArmHsiv1E397eGIhQXcy1olOJmVNaa
cXoQKYbA3YFemE80gvc6mUOwa3woq0+LboqToCE7VRsp20XpNFTyOIixWEaomL4e
ug2l9tkIZLLPqGyXTYH1oJK3zJbbpD3njaGv7s3nc4dwUO7T18SP3dmeILeH27ej
Eo0PvF5f72bI3anYxtoGw8pot1d3RjCbi0vdmhWfkFwJMvzd9nwKtlPQYTvP7kvx
kFez7axSjnAU6hcrjvux79oLIzVFk5umwzuUMWISig1BzCRco8L2cphLyxzJkkAC
zpgoLoRVSvMbxzje2p7lwpEhCDvhI5ia2U7lyiWzfZLJdWrjLf4=
=3Z3d
-----END PGP SIGNATURE-----

--sC378RLJiYj3FeAM--
