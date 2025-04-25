Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEE235C01
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569569; cv=none; b=gqeci4Kb21N+G70+jmPeUn/8zAwq/2JtZ+GDPQN9ae7cYBTEJWwkgjqjOzHBkA6MgfGHYqcAYHV20inFlL9G69RvEu0TFKqfKcDsx4iYu22FoeV+j7xDjTy7NZYm4x3Wj6rk9VhJd2XSKcCdgmJK2W7qiFV8uhx673si2V08blU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569569; c=relaxed/simple;
	bh=zS1HCSiM/MTVQ1KeMmA66kd5eQzZhVS/7SPDU7Vnm9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li5AHoE9AQZFrXfjAXAVV5+Jzw9/kBZfx8WppslpHGxdurDhOg5AjMrG1q1QQSIZvAYBPNRF3ejoooIWtLql8lwfZdlcoEhMiV3Ujb2JDhggMK9kKj5xxipIupFWK56au1oqkQm1C8ORBnFVa17hrpGgj3eD78vqoKsjw6xgS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M01ZQ9CP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsWf6T4s; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M01ZQ9CP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsWf6T4s"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80B1211401DD;
	Fri, 25 Apr 2025 04:26:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 04:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745569566;
	 x=1745655966; bh=8WqYcPK95In+Zq2HwZrQz0JEkNz8l6I14fVPYt0V0Dw=; b=
	M01ZQ9CP+7lOdzD26o1j0kjuqIWE4FYJDbpUnA1hXhS+j95snuUe/lIfOmj2Lpdl
	eTnszQDw0Ac3qMnISMGyu445RisYqYtvE8kuv0ehaAnI4ABY5542US2bdlawp45G
	s0HX8wJkGUSXmFpW3cjQTY8Vi4eeyrPk68OHgOZsL29iolnmTs1mAd/qGHVZJaNU
	wUCG69D9xj9sx7OxWRBx6VGfEoduDLiykG9WqZCY/5Am0Y0WRI0Al61gfCs9NBB6
	m/G9Wuy4uOkPmB5NbraD59NHVqRwfxuB4+Rdd8G2micJ9HEKTUfWsKmUX4gg5SS7
	oUe4sa3sZruPxue8gL9I8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745569566; x=
	1745655966; bh=8WqYcPK95In+Zq2HwZrQz0JEkNz8l6I14fVPYt0V0Dw=; b=G
	sWf6T4sd5eVRGw9b9ZpsC+0ffTVEZxuPYj4v+FaJw3FUAnp+rnkaAON2kTfR533f
	IWOBAW0apGwO+MzGM7pCq354o6SY2lwVg/XqlqmrQPszTdmVYz685QgimdZMHVjt
	3hg85Ut+8hKqGSXNjXGMK+fdkPNFVDkPCfOdmVVXP1NKWGf6zwy43gq0IfIoLiQw
	+Hpp7pxWUcmWMKnJC4aBDrOaz5uKfHz+YQobMzyea/qDKUS9k4eiYE//IhmHG8TL
	SnAXrsL/XCX5w1k89sqiZPgE6HMixSp6HlrT8mNce6SvouFsHnUpcRPmyiPGUJo0
	j2ehANJsmLy80zwEy8OHg==
X-ME-Sender: <xms:HkcLaNdHKYqXqaOliaGa6-qDu1eWtyFk-fSQk9iY2WaJ-Nijvr4r8w>
    <xme:HkcLaLPcSN6QVWRaVjOlH0Sxu-H9Y1emwr74H8QVStX28xujxru1QKBFpRR-bJHre
    MO6psdjaTuK4qZudw>
X-ME-Received: <xmr:HkcLaGgis8GvgimPe0YvqFYS3m6IfGddDmEF4aPUG65M2z3g0hSuzXzMiurlEYhuK8IIuj0Lzr8_kKrfV2RKnm-xbHOxrAysaw77UzJ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedukeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdeg
    ueeukeetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstgho
    ohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:HkcLaG-C8pakzNnB7fs2T0xUQ4K0A_tJVAfcrwPgx5G-sViJ6NJCnw>
    <xmx:HkcLaJsHCePWUMq321Ecwi0n4YIVkP12piOpP4x8KtzlDz5Pc1ingg>
    <xmx:HkcLaFEbeLUVAdmqvOSu7yQ5_GBuQQPIXWk1VUf8yFhukBglziAm5Q>
    <xmx:HkcLaAP59wv0VN9eTQtM2jrTIiYT_ecwMEI65Okmlvh9j14ukvX_GQ>
    <xmx:HkcLaAxc0bJR9t1OAFltO5CZhFTKaFHEr9nImo7YcagHWylLLhghLLW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 04:26:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 046dfc93 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 08:26:04 +0000 (UTC)
Date: Fri, 25 Apr 2025 10:26:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/5] meson: wire up support for benchmarks
Message-ID: <aAtHG38GPdbhOCop@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
 <CAP8UFD1ovdQdfvLMvfPi8fz5S82n+8mfjK7ECqoQUMW2p-khjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1ovdQdfvLMvfPi8fz5S82n+8mfjK7ECqoQUMW2p-khjA@mail.gmail.com>

On Fri, Apr 25, 2025 at 10:06:12AM +0200, Christian Couder wrote:
> On Fri, Apr 25, 2025 at 9:28 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Range-diff versus v3:
> >
> > 1:  2375a16c2c0 = 1:  174804805c2 t/perf: fix benchmarks with alternate repo formats
> > 2:  69782035246 = 2:  41faa3d9b3b t/perf: use configured PERL_PATH
> > 3:  cca40e9dd0e = 3:  87ea3ab1a45 t/perf: fix benchmarks with out-of-tree builds
> 
> In https://lore.kernel.org/git/aAc8f52rJ8ATncVc@pks.im/ you said you
> would try to paraphrase some explanations about how GIT_BUILD_DIR is
> computed, but it looks like there aren't any changes in the patch
> since the previous version :-(

There were, but not in this version:

3:  d03ca0c0630 ! 3:  a66bc5aaf51 t/perf: fix benchmarks with out-of-tree builds
    @@ Commit message
         assumption breaks with both CMake and Meson, where the build directory
         can be located in an arbitrary place.

    -    Adapt the script so that it works with out-of-tree builds. This prepares
    -    us for wiring up benchmarks in Meson.
    +    Adapt the script so that it works with out-of-tree builds. Most
    +    importantly, this requires us to figure out the location of the build
    +    directory:
    +
    +      - When running benchmarks via our Makefile the build directory is the
    +        same as the source directory. We already know to derive the test
    +        directory ("t/") via `$(pwd)/..`, which works because we chdir into
    +        "t/perf" before executing benchmarks. We can thus derive the build
    +        directory by appending another "/.." to that path.
    +
    +      - When running benchmarks via Meson the build directory is located at
    +        an arbitrary location. The build system thus has to make the path
    +        known by exporting the `GIT_BUILD_DIR` environment variable.
    +
    +    This change prepares us for wiring up benchmarks in Meson.

The changes were already part of v3, so you have to look at the diff
versus v2.

Patrick
