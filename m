Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223C145B18
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754401; cv=none; b=kAKWU3ZxCOCsLeEecnOFsutgFXRcAUIgBkjACOiFak6rnXZEIsxN3kNcbaZVdy+o4l7s4YC5JxA2lf4+gQWOHI2wzkj1J1mFfaEYdsEVTcrywJCGJ3DxMNKAUMuqrimDeirrfM0kKY65XR4jNf1ebNyi2mu49Ocs8QCWhmJ4smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754401; c=relaxed/simple;
	bh=KTR97f228qXR5HElFhmnVTvyCCZYo/ycfk51X39oRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTokZmuhKBtNgWtDMnKQNJMQWhSsNipYFcQ8/RwnQoqF8e1FLpJlvzSj+r758BEG8viuMf2pf8aIsvLTO8TN+dfaN0waYLdt22B1JJGGSaRKarvi1GOD3zfytqVYeQjawiSuxAOjbknuRnQdCF5PyKGw8xrXxnNeaNpjnuejOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gh76gkVw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5s5aqBD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gh76gkVw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5s5aqBD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA9011140206;
	Thu, 24 Oct 2024 03:19:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 24 Oct 2024 03:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729754397; x=1729840797; bh=4CWJajsiSW
	mg6XTNF7VfbI04BpRVy48g/en/ZxmaGqU=; b=Gh76gkVwh+rk0pLi6xSusvjn+9
	67qJiUMohlIw3PW31am4D0/oue5XJFhNb8zR3E8M0DhFshoZft117R011HscOn2/
	HxloH9d2RuGwb3qohhiJX/KD2aVUtQxWxvfxzTZRLaY7FjbukVUFWAoYvZn4BZeI
	h0QDhxX4McbEMAfyaxIJVdEgHW5iczJy5F7OJ17lUxRQIM2qUPqPlRGh7mDxrtmL
	Y8W/Gn8aAmuKE3mfOFl7U6Lfe121BtcW/aeQ6DHURCZrBm7EhXCy1izQERKd381s
	iJlBH2We6o7anZdUbxaQC1pThKtSKtYPDgO2fUqBH+Q+ll5/hMxotxwhpsCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729754397; x=1729840797; bh=4CWJajsiSWmg6XTNF7VfbI04BpRV
	y48g/en/ZxmaGqU=; b=h5s5aqBDTWodim8r3xBeK+VpEpOq6Sg4I4YjxCSgrxsC
	Zvqa1jhQatZ+1Rxei8pr4Ff0i5pwEoTVbaGnnyhmAC05YZwwupynJbG8RuSNm48C
	1nqBzQkhRb/+Ic0vYAt4XvYN8jt1ZgWxdTJLsN2riIN90eKcuEYcJHU1eGQZA71U
	NFhlDECdPe9F6Kdes8nFwpTXfO7j9N5NHVAIPHuzbk/cPZTpYr1Zh1Gav2JliRce
	+zRYaXKRo+Nvnlm7RhnBiRs956loni+Ps4IupAEW2UqPSEQdfEdxV45X0xLPec4o
	BqybpY6aPYCC6PDKDlfsJnfISG6dBVuQAZnDFwvunw==
X-ME-Sender: <xms:HfUZZ7JoXodg0vNjrA2g0MPrKuS1Qa1aLdnVZJa9apoAxP0IwwwgDg>
    <xme:HfUZZ_KbUJ3mCwZsNNonlS9dhLUEaEa-vYiemDT0vmFCZnrt8FaJgYQFTmbIilC7-
    cnl5hW-At1d-ncdVA>
X-ME-Received: <xmr:HfUZZzsq5v0Y9cVPOxCDlcoUh3RYzDYmrOZVJihltRj-AkHKZEJUqv_N28Z4wA4SDx6Fv2TbkYdQ6VG2XjC_l4wMtEINiRRipjRfeW5Y6Z0QzADq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:HfUZZ0ZpOEKoqVPOMduOVS485KBjQQECTGpyLjUt1ShR6Bz5-qZbjA>
    <xmx:HfUZZyZ7Zd1DgqfMs7ahLEvJ8YbrZMTCKVmnQqbP9Rx6VNNwVv-nww>
    <xmx:HfUZZ4AvyGx9SB5QWZDebIzQ4chp7YgBmt5YDHUHLXagnarYUj0Pbw>
    <xmx:HfUZZwbLhmhd7pyc_mw87gpT9qq_C88xXXqpGMOxefHbCd89IILvEQ>
    <xmx:HfUZZ3Ne3_dcN7vj0zGjCwnpuy-UTN7W3tMB0iMnj5BHDyaW9c0h8ly1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 03:19:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82664bd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 07:19:56 +0000 (UTC)
Date: Thu, 24 Oct 2024 09:19:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <Zxn1EUykid2alh6X@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
 <6883a8d4-7e2e-4988-b57f-89b7c0aacadc@gentoo.org>
 <b1ab6c1a-54ce-4adb-8977-ef376fdb48f1@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ab6c1a-54ce-4adb-8977-ef376fdb48f1@ramsayjones.plus.com>

On Thu, Oct 24, 2024 at 02:43:40AM +0100, Ramsay Jones wrote:
> > You can pass any command-line options in as default_options, including
> > prefix. Defaulting to $HOME is somewhat unconventional regardless of
> > whether it's done in a Makefile or a configure.ac or a meson.build or a
> > CMakeLists.txt, but given the Makefile does indeed do that I suppose
> > it's not incredibly bizarre to do it in meson.build as well. :)
> 
> I don't have any strong feelings either way, it's just that people are
> used to doing a 'make install' and having the git build installed in
> their home directory (including me). But it is not a huge effort to
> add the '-Dprefix=$HOME', it simply needs to be documented.

For now I'll leave it as-is, but if people feel strongly about it I
don't mind changing the default value.

> I think I need to go away and RTFM at this point and not annoy you (and
> others) with such noob questions! :)

I find your input to be highly valuable, so thanks for testing things!

Patrick
