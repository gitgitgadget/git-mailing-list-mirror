Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECC288531
	for <git@vger.kernel.org>; Thu, 15 May 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297383; cv=none; b=LF2t6NFKJdwSpKY1dLl6JhSGX2069K5vkPGwYOmoa/sHnfK/s/rhJSJtVdMs26q6Hje1o31CSzW3YVF1S66BBzssLfAcEjJsnZA9rBPRa+JMelMUqOVMjvGv1gM3HAatKtKebcYUJ+/+CuFf5XV76J10AjEhbNwfBCmDl7/q5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297383; c=relaxed/simple;
	bh=LZflIv8jH+8w782sLHgjVFPGu3HX0FmQEJFVUoCGuKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmqtujZDarfVhlqqNn+lbdn1B2J8hPSFY3hFLy8vwMgZt+zu6CG1EeOmgTI78ktpM0KLfrioOc5BlGn5s1JGHvV3K4Nlt65JjH+rT7+2n1VK6Eslk4Uh0Vuof1Nlg+fq0aduWSTOmdxzGL1erMjPTiV3Dl0hUdL3Lr5VnBUc48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n36hKBy9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdAbt1Dm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n36hKBy9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdAbt1Dm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37F3511400CE;
	Thu, 15 May 2025 04:23:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 May 2025 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747297380; x=1747383780; bh=LZflIv8jH+
	8w782sLHgjVFPGu3HX0FmQEJFVUoCGuKY=; b=n36hKBy9gPPZC4fHSepvuq+ObN
	HewHENm1y6XOU9MhHpzTvTY+MWeAZbo/waehHnKo5pkl22TwweXiL4G/nAiGphlU
	PFcFlNv6r0FYek1OqyGwj+tuoAu406jR0OT9beqAIv2utZicMZLenZeCO8fthF8x
	DgM+irddIrPld4ofdku4e1kvf7XJikQd5GPqMN18MZX6d1SlLMsMSuGkYlTfLIyk
	z/gCpVuKHAuLjmmNFUJ2IWjEaqA6IWsYvEOdbWdrSFP3RRR88VX2cLxwW8ktCRYX
	MavsO3uvBeunIg9HN/MoFSAJghVHbifD6iscXwEbzLl+T7uka8uI3UWFv1ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747297380; x=1747383780; bh=LZflIv8jH+8w782sLHgjVFPGu3HX0FmQEJF
	VUoCGuKY=; b=fdAbt1Dm8ZN2ny2LUtMLPBnYo45I6eyT4bFtWES/6mYOUdjgEYY
	gxlRK12xsnPxUp8hGc0DIUG0v9hvxmm+QbyTZlC620nfSeMHl8HYjbhd3S8LChfa
	C4Lg6+YWTHhjGas6ZZHpqiZ5WqUIa8HIrTkkbNCmMigcSAXC1dQ44YzNBoQGHXQQ
	ttZOYNublrmbvIXbugsNiMyMdRONs2tG/wETQvNP/KEd1laCFh6HU/udbE+/B+Jv
	4xUWj7vWFV4xsBzk3HPBXNQG8U5eGR6hLBOBW7XxYK1aLylnXN9NsG1qIfY0bhnx
	6mbKZZJYNPJcEp9cLHP3GQvi4XhSlSl52Vg==
X-ME-Sender: <xms:Y6QlaEt5Iv8JhkXs7lVLllvnrGVzHKJP0n5KDmTn83UER1bRfX_13Q>
    <xme:Y6QlaBcjwb2Otct4YZjona_6jKBh8ZpU2LlDxzr8oohqepC4truRduvhAqvB8qGrq
    ahu1I9GL4koejRZOQ>
X-ME-Received: <xmr:Y6QlaPzyVpPi6Yver7fshRWVtgthEKBTbapIofmHElRVqT6t0ig94tSR-sxgrBlAXY-LBc0zCu0wn69H2DPoc1vc8WaZYUqzXCTGiPRHCBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:Y6QlaHNJh6f3YC2av_EuNZyn7pSsNItJh10p_Fk-x-vUrfv4619fCA>
    <xmx:Y6QlaE9c34y6Yb559iWQqNdzYYG1d3YSHNKZYAs_4sJjtv2a8V-eYw>
    <xmx:Y6QlaPXjw8O3jslZg2tEiFtr5XCJG7XpPfL4I5mZtQ1R7a55wraGbg>
    <xmx:Y6QlaNe-r2e2cSW4XS5cWSpacD2zlmxz_9yUjLOd1fl1WJGnj5IQtg>
    <xmx:ZKQlaAjm1s-5y8uH51JeYHivjFd8LEYpdZETiUJFrnJaRy1qo0dHDnFF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 04:22:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7138f12 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 15 May 2025 08:22:58 +0000 (UTC)
Date: Thu, 15 May 2025 10:22:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/17] object-store: carve out the object database
 subsystem
Message-ID: <aCWkYdRN1B__oYZ5@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <871psrjlio.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871psrjlio.fsf@iotcl.com>

On Wed, May 14, 2025 at 04:48:47PM +0200, Toon Claes wrote:
> Only one small question though, what's the point of the compatibility
> layer in the last 5(-ish) commits? I mean if we add temp wrappers for
> other topics in flight, then when/how do we convert that new code to
> stop using the wrappers? Won't we remain having issues because there's
> always something in flight?

As mentioned in the comment for those wrappers the expectation is that
those will be removed once Git 2.50 is out. This is a common approach we
have used in the past, as well: for global changes to functions with a
lot of users we introduce wrappers that remain for the current release
cycle.

Patrick
