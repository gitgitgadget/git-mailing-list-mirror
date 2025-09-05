Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6941D5CC9
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078609; cv=none; b=SEuQYmk0vXxlm+lbjLLHpUdQ/L+B+opyp5Y6bOYcXceUqgEgb/NdCdqNDnQNA6RKg1GfJaH1bF2f1EzlLa6ZhcPHwVA9RNrC+VUpZlkzvk0GwzspeqgNQdqERBdlIQkS0LFS0pJSl68Z8CDgdAZe6sU/j6TGACmS9m4QcIvQbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078609; c=relaxed/simple;
	bh=BJWdR67NS5CpO0IgkIvPrXJkPPt/TnA3qhF8JUuyyz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJPrUat30noxW+Ny+sA8OZnwGgQEitx6ifokf1d7GkSRnbuiPRNnLqX/MfPVBrVbvx0SKCewkoXimSHSc+x8uKhfXqviwTSiF1Vaq4xuinauU7B8YK8MPcWYbazUCHWuuYe3oEYZxYlPiTG1e3AG9DHzU+ZazNmjnpAGj7igydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IpynS/BP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3yrLFWy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IpynS/BP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3yrLFWy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AF6BAEC0207;
	Fri,  5 Sep 2025 09:23:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 09:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757078606; x=1757165006; bh=cSL4PNN+M3
	VgwGAP/1e6epMUasVypNJbJL6ievpQgog=; b=IpynS/BPrflpoUbdhwVsFo0WNp
	oxyQr0e1wYhqkY/+UgXRKE/3rfMzy65ZC65ytbnQQcsReOTATzKbo9SWXh/fRLPl
	Ofw1xzbSi3GYMTW6jOWiaDxKE4QmTDnY+P1jumSGzDDswlXDxuublkdi/ZJMk7ZG
	zmgyWeZIdgIZveKoAn9pdTgDFStnXEVVUXqRSi6NL+oEhHmq2XEkcj5A4zRhzO3g
	ZKtP8SLGPmyRIj4J/1g9xmYRR/P8jNKpZt4uY4QApt3QDfmJJuln/Vf8XhTXUCJh
	k55gNRKeJBmBSoINz/grzFpfEZuerZFZq/E3cr38w+qmp0AsbGSvhlz8w6sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757078606; x=1757165006; bh=cSL4PNN+M3VgwGAP/1e6epMUasVypNJbJL6
	ievpQgog=; b=m3yrLFWyLigPX6W3Ip4Icf3bTg3nS4FBcCr4LjeHNeq7z8oZkDD
	WCPuiS+F82C5OrUkztVeWSc9FoH8B0fkOdtqqbS4QsW4cm/R06v68yF/XDIT8rgD
	H8JYwqAGcAkrduGPbxF8aeHZXuijmMai6vzXfe5P0GnrzBiIK+e8ZPyznFmimHs5
	ld8b7j+C9Skmlex/Ta+3rGNhaam8GTeFzt0kzUXrkBEDeYKQRU15SRlVHgGEMTG6
	AgIWQbNv4X0rRfmMfyVYa8gfyWrGVol29IJrJO9DVanLGv9oRuqhKtM6HgbUYP9M
	0nQMPixZ7Hfh6zKUOPWr85iA8/oDPH2C74A==
X-ME-Sender: <xms:TeS6aNvmqzoHAV4TnDhhio0Lde_z7YUXysk0vTPLMLGOk0JFVJxNwg>
    <xme:TeS6aJ_yP4-9JsuCbyWPqpZSaN7_z98_otnZubMWeALlgq5gNRWmBQfCfgc_KCI9T
    S4deFUoVq4MJ8V-0g>
X-ME-Received: <xmr:TeS6aJTO2sSjnWD87YwpwIK954jHfJEAdu6ittqGLhqa7TFMtF0KzJ7-nefneXV317m_Z73YJRl8R2QuoHHeKx0Wc62U-wV6h77RcFahoodN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeltddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegtsgesvdehiegsihhtrd
    horhhgpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhssggvtg
    hkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:TeS6aHCJLf3-r18NsNvuv6hd50VtGO4KRHMmWspmee9V-GXBS-4Fxw>
    <xmx:TeS6aCYYb4uaMDLjrGUBV-8hejwrguF6vaEeffxtzi8xZRTattaasQ>
    <xmx:TeS6aAJ9M71U82JvEns3EKqY_RMU6XHAPHsf4Y7gZT2s_jQU7yzb2A>
    <xmx:TeS6aL3VttdLP_7tOC_Pam7U6wnS-RuPyyBs4Uphe6fROrTU-Tny5w>
    <xmx:TuS6aM6vlUAuUrw2yenC1xfVDH6Xncshtb_k-quwasJ0f3J2h6sXl01t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 09:23:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccd98446 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 13:23:20 +0000 (UTC)
Date: Fri, 5 Sep 2025 15:23:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren <newren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Christian Brabandt <cb@256bit.org>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLrkRS_EuGN9FfVE@pks.im>
References: <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
 <ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com>

On Fri, Sep 05, 2025 at 02:14:43PM +0100, Phillip Wood wrote:
> On 05/09/2025 11:31, Phillip Wood wrote:
> > 
> > I would like us to adopt rust but I am concerned about the implications
> > for platforms without rust and think we should give some notice in the
> > form a clear announcement in the release notes once we have a concrete
> > plan. That plan should include a decision on what commitment we can
> > realistically offer with regard to security updates for platforms
> > without a rust compiler so maintainers on those platforms have a clear
> > idea of how long they will be supported.
> 
> Here's what such an announcement might look like
> 
>     This release introduces an optional dependency on rust that is
>     enabled by default. Platforms without a rust compiler can continue
>     to build git by passing NO_RUST=1. In six months time we plan to
>     make rust mandatory for building git. From that point git 2.x.y (the
>     last version that can be built without rust) will continue to
>     receive security updates for three years.
> 
> To me the important elements are:
> 
> 1) There is a short period where rust is optional. This allows
>    (i) Distributors on platforms without a rust compiler time to notify
>        their users that in the future they will only be able to offer
>        security updates.
>   (ii) Distributors on platforms with a rust compiler time to adjust
>        their build procedures to include rust.
>  (iii) The git project time to gain experience of using rust and writing
>        the necessary bindings while building with it is optional.
> 
> 2) Rust is enabled by default so platforms without a rust compiler are
>    made aware of the problem but have an easy way to continue to build
>    git while rust is optional.
> 
> 3) There is a period of a small number of years where we continue to
>    provide security updates for a version of git that can be built
>    without rust. This is intended to  allow a realistic time for
>    distributors on platforms without a rust compiler to port one or make
>    other arrangements for providing future security updates without
>    placing an undue burden on the project to provide security updates
>    for niche platforms indefinitely.

Something like this is part of the BreakingChanges document I'm
proposing in [1]. I think we should also highlight this upcoming change
in the next release notes, with a pointer to that document.

Patrick

[1]: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
