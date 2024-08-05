Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EA14F104
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850932; cv=none; b=tK+OhCK9EqsYFL2VhenOoeEw1Zd9RYkbETaiSkGpBkB6F8UgdftUL/Z7hdNP+q1BjcnUpBLPA0Pmjva7M74MAIEarjpkUixFrCSdPVa22VeGtBt590jLs1EkT1IFTUYTc4I9rTqlPmJwBNhOukt089BhzpLBkuh+jJnfQxz3jIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850932; c=relaxed/simple;
	bh=zstIPFRJuOks1Lo/EYiyxvnImuMGiF18KNHBeBq51go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujBHPmB3qDH+kU0kmGv8N+/vd8HhfloHRJJ6yzhWmde+1WyqFByflMomHQtGuF+51SunTDHyMMWFjF787uBedcDxn7nfg28eMcHl68sDl1s5PNbLVj/IHpStd3wtklfZtBex6oyMWMFf+w48L0sq1KpS1AKsa74qhX9IA/5XWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFvONuRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6+R40zt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFvONuRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6+R40zt"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EFB551151B08;
	Mon,  5 Aug 2024 05:42:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 05:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722850929; x=1722937329; bh=+oXtGlP6m3
	BYixvKXE7LqMoxQ5S8s4PsEU+smG4ioWE=; b=RFvONuRTfBcSTGhBKoAAb9HqLg
	cxbbuaGO9sAdai9fBu5Z0kUqb6qcczjg7idk2Sb9Vm0pMfOM9iunywxVJGxMF6vx
	iwv+R2t/AruGvIO2atbWku1bHB9KsBxqRFKqCSwIegEEpcq0k/6TU4nDkkoiU1tI
	gCoDJkhJeKgJm4w+5R4JmgPcbwyMMNXex4XveVsdTN4Jl0L9q1TlPsONx+EmZ4hb
	uOY6jmV7Mm65W7q601oiO/qlIS2Z2k3pTrnJm8EA90/lIqqgVqaiL3tBy3wpMR7H
	BCWu/f1azr7ItmaPcBTevYJiGeQfqIAjkwFNtFbKYyejPEjs6Vkss+sXEd9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722850929; x=1722937329; bh=+oXtGlP6m3BYixvKXE7LqMoxQ5S8
	s4PsEU+smG4ioWE=; b=n6+R40ztdkuTg7Jhcvf9r8QkJ9TUXbkNR2Y8DIe2F7mH
	M4X6GLvzrL1nvRqOLhR/rcy0+sLy7W9Vzb62WIySYBXfFCNXihZQlg18IQzzECA+
	ia/ZHZG579q+P1HU+WIbb71UZMpilvfAXYpx8TOJT4tJwWXpzAmnzQrfYW0TPsh9
	49Yi/zfhPlBM0CURKBiAS9DFtujthBHAUOEumKboL8W3Ub6bwmDfNHylL+an1+XV
	E0eTzm9aSWZVRASFv2ov3O75B/ImgQ49t5uPYBwKRx6cJ197Y4zaQK/pOI8ms2R7
	/14ClC0AI3/izEusTJZvLLabjJ9tOUoGVlbs4tmBYQ==
X-ME-Sender: <xms:cZ6wZhP7ct0zqtnDpDJredPObEC3F_Rxy6IqRmyq7BN2WIY5ND2YTA>
    <xme:cZ6wZj8VAs-ixck3B3X7tALhWU-ek1p91aV4aUvMBc7Yx44foe9tB0mL04fMEPM9s
    AosT-7tEgOqCqPfDg>
X-ME-Received: <xmr:cZ6wZgT-bTJ3oJ-ZzQQiPSHmKSxop6OUF16kpJVmn4ZlLUtO_Vwb0PY4HHpLaxflORegIuY48C03dr_N811wIRdZl3SjJn2Xd2Z6lnOdh54I0GfwZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:cZ6wZtsroDMPI0OLHVkS_PhDhRs0Xk6J7j1WOxtRn4OMrMRR6Fuv4g>
    <xmx:cZ6wZpcywXaT3QZ0nCMIy1kb5TPdxPk6MuG2dIriX75ccIL6YbMfxQ>
    <xmx:cZ6wZp3Q0DnJA4ohS0iuxcdA8EZm51oLyzWYha_Y7zj5Y2vyLrsrcg>
    <xmx:cZ6wZl9yryKd_2rWbZUQjKa0f0gdEqVwN6R3xk9K_sBgkxE5e0iiVQ>
    <xmx:cZ6wZqpb8SKSfNuVbMmVm1Xcft3ksbDiqZDUJXjKfrmMp-fILI7MOAQW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 05:42:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7c9e60c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 09:42:08 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:42:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] [Newcomer] t7004-tag: description on the same
 line as test_expect_success
Message-ID: <ZrCebm52L16N2Agu@tanuki>
References: <20240804071137.30326-1-abdobngad@gmail.com>
 <20240804071137.30326-7-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2o4PnUiK70TqsjKa"
Content-Disposition: inline
In-Reply-To: <20240804071137.30326-7-abdobngad@gmail.com>


--2o4PnUiK70TqsjKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2024 at 10:11:37AM +0300, AbdAlRahman Gad wrote:
> changed test_expect_success that are seperated from its name like:

We do not say "changed something to something", but rather use
imperative wording as if we were instructing the code itself to change.
So maybe something like the following:

    There are several tests in t7004 where the test description that
    follows `test_expect_success` is on a separate line, violating our
    coding style. Adapt these to be on the same line.

Patrick

--2o4PnUiK70TqsjKa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawnm0ACgkQVbJhu7ck
PpRTvQ/6A3rYKVrFlYV0Z4d3tIDZ96XTZlQvX0Cz3BfDFEbjk+Z97UbNXIco4+oS
kYwVCSr9l8AW9Qv0qLZERcZonFGWJbZELY0N/s/2yrOZKAEOftGMmB8+jDKwtwDX
/DW/t2iobZPxy12G/pzhtBPufwWigEWzmB53ZO7FxLZEMnQSkFXDyFIhbPEjUMrd
1x1MDaYcB5s3dbcjXJ+834IaN0v0SJzkVgZvBplRWilkhC4nRqIcgUqWpQxUmVx+
l/SbMqje+ZwcTpYTu0zgKiAjoakZefyJKQO+Z+pDXiyWFRqXMWTRpQacWOP2jCmB
TnRrC1Rv8j00ZtolwPGamGTDUnm+TW1UAlY0y0VR2SWKtbsB6G2826hclBPIINF2
8BPfjMjD5pqM3z1nmKURMMe9KcnnmBwfggbHXImQNYnIc1Jn0m5/XB+/jldZ5W+h
+tYKPl2FuCObDkFBaMA979Oec2qGYz1X1FhxjOP9KCwfq3JH3JHdkZVG96hLMQBd
JpyJAvQOZyHybkQ8oPzdgYeYWpZupRDxCE7/pUGeaMmU4Kv/9C95yRdXdUCI0/Fl
zvzf7hKbFm8I8htQ9QLVmqXpzWEa8XeAazaqpAXFSEoJN5xKkHSUOEZe2OHFg+2g
oTF1pA4RQQkENRnDfkxvbCO1LDaIecux34s3jBxkXV6+cfPYaLU=
=MWMo
-----END PGP SIGNATURE-----

--2o4PnUiK70TqsjKa--
