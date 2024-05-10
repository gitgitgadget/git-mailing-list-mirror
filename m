Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5914170888
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341640; cv=none; b=ext0KFNfz8SmVoo63J/Bof+5ZHAvQ4SulLMrYQ8d5CN/sEwEf+zI4edJHFXC82H6fySTciUi1QLCZ5mjo9TFkNgp1OoKGbJlROvIn6pwBEWpadWcpdmH/0tPxJITTLdJ0eEtE0MnMoTvYVYtl6qNDJAPdEV2v6P7/Ceqrf5/ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341640; c=relaxed/simple;
	bh=bT/Q3Bsa6zqyyi4hzuCZsSefN9IeZmTv1mcAGMCHnaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdnDHBrC3isssoua9zIEtyTzND8TyJqZ8n9gfEM3j0hBc6YvMoGx7ejDYV0PZMzcIWFVNti2k4S1SkyofpU00hihzK7YEMwiA3ruWFJvdsZDBK+4LD+BMrSt9iB3qu+FANoNAFjRs/NpjdlLJJTO14woz2gCQepBsjMGhglBhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K1Zgvlfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FI3Z8tpG; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K1Zgvlfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FI3Z8tpG"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id A6E001C000C4;
	Fri, 10 May 2024 07:47:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 May 2024 07:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715341637; x=1715428037; bh=bT/Q3Bsa6z
	qyyi4hzuCZsSefN9IeZmTv1mcAGMCHnaM=; b=K1ZgvlfluNbT04M6gulhjCYtYh
	zSH9ntdtKP+xlu+CKgP0NnSDaBnamd5OTNayXDwhBu0VJGhDJVbUeOuKNjoQgrLF
	4YDpsYjPNo30YVWzep/XPbOVGLqGp8gN5/q1s1HUO4voVcVJjDoI9SOB728K4fO9
	uKJxgbckdp90aXEcPeKPdaJuKwzaCveyycOqEd3+G1L9A1enzw2+0t7oHHmU98PB
	eqySXEIB3LXxhWVmYl1Xjdqre0W5YGovW7XESHRKHFaBUxXk7l66Q9RsZENBZtuO
	Kcn/Sx1cMwBKR8qWC4k7M++8Y5ptmiCPbvaY3sXKT/OUd/AYJ3X3R8OjyNyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715341637; x=1715428037; bh=bT/Q3Bsa6zqyyi4hzuCZsSefN9Ie
	ZmTv1mcAGMCHnaM=; b=FI3Z8tpGfJFUyPIZ+RQ/lkVUeK4rf20Ng1ttoeVB/Y7B
	2wzueOuAUskDCd+b1UmPfmLseicAJcc+GWHD2aeNUrdqhEKHr767zgPHHaFTZyf6
	24MxP0L8bS/rkPXIxr662vCHeB4MaZMI8uEbUuc5iMvKIfAja/y1CdLS+b6MkSEL
	wreDCSb7PofPWJOt+uLY2vcvoBau6koN4WzwnYCv3Z7n4tzIPFOz4Ca2ORYocWqF
	Q9Ro2rK8iM1gTFmnTDzLKqeqQV5IygZu5BnFm4+jGAhPmZ+iKOUeqZzr9/fHHgAT
	7XYUMO9zYPDOdF0mimPblrAJ7yGosWMHLz+S9ck+iA==
X-ME-Sender: <xms:RQk-Zsj-TrOkI4GwVbNqRKJlcJ2IEv_jsBqD2z43xH1UlKWIYe8Z5g>
    <xme:RQk-ZlBH4OlfjWcc40iFJuz_vsSc8p_5jl-1DX1f72hrHp85-23QCUWJ7r4PCwZ-a
    HuL8nxt0XC02EAVvQ>
X-ME-Received: <xmr:RQk-ZkGVsCl-TGJQKpAYVapXyf5yIA0c3Mw5JB97jTsrpfGuPZNaj8zHJoIbtt-HWoTqWLkyOXBmCWcyezgHTFdHZ0vpPuYdfH_GRii5R90ah8efBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RQk-ZtReF6GGAoO9Mw4lgrIOlwYqjV-HuhP6Vyi1jH3eoOuwhTLNTg>
    <xmx:RQk-Zpyc2RWMkjM-5UYR0clQ4BI-qEH70SrOdQgUhKRhm4McTCkX7w>
    <xmx:RQk-Zr5yEvnAvbj_PL6E-eEBXmYPbm2445t9E3hbM9ECPYjIk3xkeQ>
    <xmx:RQk-Zmwgt50jIwfJT6cT4zXa0vxj8_uyLQM0SaHULWVvXGp3-pTDag>
    <xmx:RQk-ZsrXfOpmI3jqnk5RflTUp6qKTz2ZdBPx-4jDBY453P5j6rDVMZJZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 07:47:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ef0b6712 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 11:47:03 +0000 (UTC)
Date: Fri, 10 May 2024 13:47:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/23] pack-bitmap-write.c: select pseudo-merge commits
Message-ID: <Zj4JQQa0aBHkgXSn@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <12b432e3a8adcda6228beae2b41b2363a6ce82a0.1714422410.git.me@ttaylorr.com>
 <ZjjEo8XU5hPPQSYf@tanuki>
 <Zjk4EqblA5M6BbFV@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wD0460h8cBh80mBz"
Content-Disposition: inline
In-Reply-To: <Zjk4EqblA5M6BbFV@nand.local>


--wD0460h8cBh80mBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 04:05:38PM -0400, Taylor Blau wrote:
> On Mon, May 06, 2024 at 01:53:07PM +0200, Patrick Steinhardt wrote:
> > I think the same is true for most of the other parts of the docs here,
> > as well. We explain what those configs do, but basically leave the
> > reader on their own to figure out what the real-world consequences are
> > and why they would even want to configure those in the first place.
>=20
> I think that's a fair point, and I'm in the same boat as you are to a
> large extent. I have an idea of what these settings do and why you
> might want to set them, but since there is no real-world deployment of
> this series, I don't have any solid guidelines on when you
> should/shouldn't set these settings.
>=20
> My hope is that there are enough knobs to tweak here that anyone
> deploying this feature could find a configuration that works for them.
>=20
> But I'll try and add some general guidance on why you would want to
> change certain settings, etc.

Fair enough, I can certainly relate to that. It's also the same for me
in my patch series that introduces config knobs for the reftable writer
[1]. I have of course benchmarked things, but benchmarking only goes so
far and thus isn't quite reflective of the real world.

Patrick

[1]: https://lore.kernel.org/git/cover.1714630191.git.ps@pks.im/

--wD0460h8cBh80mBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+CUAACgkQVbJhu7ck
PpT88A//ReeDv/wFLJz6gr5E2RDAbSAAfYWqqyK84z4bAd2u0iNLssigF7r4MHkd
FXtDNJ7aD11Lc2IibKsWRD2Avf4S3ej/cakemGRRkOp7Nohx8eexNvo6dBOVMj4V
kkdTMkU8z4ZuQTy7PlVPSgHrJ2eZ35UF3qZQ4ktwk4t+l7l6JMs0QUQkt0YjwveM
qr6B6d5Yjs305S8wr928dYtic4wE8wf7B0tzqM08TuxrbjtobzRXKKCDyYaeuIPJ
7/YIclyabtg2OUHRsr5Q7xj78D2dTSHJUpiB40W9ZAX/ZOxsNTLT8CMJ5/GEygqu
5NJMMSpP1x68W7BSnOboGZHMJcG4U9PRrLWRUFLPHyDztIFqjWEx2wk1LelDfg9r
PFMN0rStw4T1s9/PJFwg9mYyLC/zFjU6iWzwG+pCjqs4HDO5mm74uRCD9xE3b96g
Qp8p0jGFd4CLcMoiIPFvaOHkzikYOCpum18EhV6g3Z5fWbCOy7pwu7tlYNx8R5Gu
XA5MQlXbmeHtMemj4aPuecmNGGz2O10Rlflvf/mVZLc7ZFscadbBZGmExbr599QS
O/2Q9FYgKxG7dKO+ESTlLEiNAGcpkZHYrEvaSuUqV0QFS3ki1xIa2IhLo3COALR2
qi/LP1KLAtMrKlrrIzPBtFkJOv5bpsJpBxjEla2o3iWU6qUIeqg=
=qOEb
-----END PGP SIGNATURE-----

--wD0460h8cBh80mBz--
