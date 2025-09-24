Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563718E20
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690176; cv=none; b=Ddw92W9Vamg1lqae6ss1hjgz95kJbWUN3P4nnUtXiBmsNUzXnNG8nXaZ6/rw+0KpoEphivE+XjmLdANG1hsqfJfxNsAMbVUHHSIGuFvb2GSjTO+IFGSX4ZKNE4j73T/3x1gSiyQda7QvOO098NeOhYC3ZcOLeyC9kPNPGH4T/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690176; c=relaxed/simple;
	bh=7XJpLyz6j0XmbbLJOmgDTT8Gca+87R75Txjzsuy8kQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRH9K9h6VNFmqzSAS9hVfAZgp5v2/Mjw/atPpBYKRg2YjLu5GzSi3u0Y00Z/sXB8B/mm88LmuysPrgmkG+uLi47k+fWQzXTQj8c54LdoiohMussdYL+Y+StHkg2q/nD7/MTtT+XxLMRM1T2ds7LF9we+YJ1SuMmPIX1SKYModLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKmDd/HW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgjbiJ6p; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKmDd/HW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgjbiJ6p"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B1FE140007E;
	Wed, 24 Sep 2025 01:02:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758690173;
	 x=1758776573; bh=mpzgvp5qjGulxAtxIaysNXf7Q9kjzxfE4uhs/n4CW4Y=; b=
	bKmDd/HWa2doTEbcof4jy+2K7zmyu/A+fXIDdmAPRSqn8Bnhm26pKScfHgGhfCw6
	khx8ddm/z7t4HTxLzzo2C51VpaJQW5EYvmjh7PWn4gmCfRT6IbAEXHD5kmimz/0N
	wKxJ3V628J2FQlTRSa4TeRs+DgJtdbGijV5wo07i+OTCHd6VpU28A3/qnC4kFlPF
	Nox9mKeGBAO3AyDikHq8EZ/FLdNpDft/jKJyy/FRtKgeobf6nKcukagOhpBUiep0
	J25IkqwZmMc4DtZAXuyA0j0PKYbe92YLJqmp7MRzq7F3FFCcH9+pphW+fLcgI//W
	f4iIBzCeg78zLgulqEv/NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758690173; x=
	1758776573; bh=mpzgvp5qjGulxAtxIaysNXf7Q9kjzxfE4uhs/n4CW4Y=; b=X
	gjbiJ6pg+2X1ZRLFlayJByDLJeDCheZFNNeV4ROMb2/Hv5/S2A3KRgFLsqFVHsBe
	8I5KiBbBjv1ItyiUhIt/hyC2nhLiDiQhk71+JQSDchXMh/NX1Au09CGtR240hkh+
	Ho0Ux8HitiStCnGEOJHmZcMo/FDcgzb0Np6c0zjAE6rfKKuASM0V/6kFZNdM65YF
	Gl+PXw84aauGneXlp/7tawaR0UEwPibKzAJ9eauPy1hPPt5V5xRn1b0YrUgd1EHM
	UJv95IxxrvS9kQpSfibLjzRTISVS2xWRC/tDe5IHl9ZyE1nCuPDQRs8sO0Q0i4zk
	K1nUyOY5Fz2+0/8t0YsAg==
X-ME-Sender: <xms:fHvTaFXeBamPvdG_2WTT_gRrEyFvcmwvHjKNqJbEv9gzC4V7dNH3Yg>
    <xme:fHvTaGB7Rh3auP4jBq1Ad8s5cvoc8jVURZxDo5QcWbPKf-bOw8UdxKHydgCr0MuxF
    s1y8EWq5uUNmybipsmIMb3wyYg6w-tzm_QgmjiDb-axRp3r8Dd7>
X-ME-Received: <xmr:fHvTaBI4PictxsW9hL50Y0CnwDhvLULj9U0d782nwKSfXdAxW5REGKtiSqBD6rh-og9ykS4S2mA_oUF3Lcjmi2dwrtByGqg5GrLqGfnNuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepvgii
    vghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhi
    shdrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:fHvTaEvbBz8VoFApHtqKUcFWBuqM1BqZJxiW40DNNRPy_2FxchNt3Q>
    <xmx:fHvTaJXLLDPOW6lXfBD7PoEXyHF1W4nEnTAoj1O7ztkilXg7zkeEkA>
    <xmx:fHvTaPLrCaBOogh42T4esNI6WXWH9bAFMgYCLCF02ZKW220y0Yne9A>
    <xmx:fHvTaO9pnoFBWuzIlFafViSBfcyecpR0MEDnlaeS2j-7HlJtLl-Wtw>
    <xmx:fXvTaMNbUudnkfTdG4VCQAdUL2wl2SbX8x9MQQT5ue3Du5QOmsLYEAxt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:02:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07ae7984 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 05:02:47 +0000 (UTC)
Date: Wed, 24 Sep 2025 07:02:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 0/9] Introduce Rust and announce that it will become
 mandatory
Message-ID: <aNN7dG6oLrv2Mokq@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
 <CAH=ZcbALjKY+=TQfv1L4PsAyC=-fxNdi8PhSFnXq9G5zcVtkCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbALjKY+=TQfv1L4PsAyC=-fxNdi8PhSFnXq9G5zcVtkCQ@mail.gmail.com>

On Tue, Sep 23, 2025 at 02:15:35PM -0600, Ezekiel Newren wrote:
> On Tue, Sep 23, 2025 at 3:45 AM Patrick Steinhardt <ps@pks.im> wrote:
> Your patch series has 2 critical problems:
>   * meson doesn't check for "is windows and using msvc" -> <crate>.lib
> else lib<crate>.a

I didn't wire Windows up yet, so this is a known omission. It's not
handled in the Makefile yet, either. My plan here was to tackle Windows
support as the immediate next step once this patch series lands.

Would that be fine with you?

>   * Using the name "git" for the crate is problematic because both
> Make and Meson already produce libgit.a which is different from the
> libgit.a that cargo is producing. Change the name in Cargo.toml from
> "git" to "gitcore".

I wasn't quite happy with the "git" name anyway, so I'll happily take
"gitcore" instead.

Thanks!

Patrick
