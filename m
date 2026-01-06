Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B3322B8D
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698191; cv=none; b=VkJw8dg+H0NiWb6mgZEkN4ubQdm9ZylZcL3EJPfiEGWvnyD6Up4PMM9vFb7HlHKeYSLlILI4KcqXgiHQQXu7XVjDc4TR5Xm8zZxraDoZgwZ9yS0zp6u7gnhnei1Pf8DeBff1eurozlkSHnLchKI387zfmUsA5rcW6W7iQlmKJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698191; c=relaxed/simple;
	bh=ppRr2rAUTQYzUvRKfykPdB1ixklMDUbh+N3u2uPc7Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWZyLUnwX68vFcFx+rEFlVGobYwYXdXNcPTqxZMVllTbhk8TtEwvE1HzbVOztYnIZ2so2cA/k1bT5u/enUIQiaolGXVUNzKEjPLd81Ny/F0F+o3vLSiA0wUJ89zaNtFmppKLLjRUYWO/+wPvPKeGaVsB8jJnC41Ora4+qU3UQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NLY8wPjP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nRax8LMj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NLY8wPjP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nRax8LMj"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE1737A0124;
	Tue,  6 Jan 2026 06:16:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 06:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767698188; x=1767784588; bh=ER25jvk5I2
	+KOC6LgZVz0tCuHEMVlGKuMfM71UmgTNw=; b=NLY8wPjPMqIg0tNT7vqpWh2rP2
	7nPYWVkP1/f76DZdp3Usfs0skGjRMIFGsYQNqPR3FSsIVxJkZYg56OZA85R/HBVy
	KqZNx3IJgJwpfoOnZI8OhQZkfIKM6N3wDDFGKO1CVT8fXDQFjtsUeJkQ/trOdYEh
	TOenMwD4wbhTjsxQUuCOsv3BUiiOPlXr0fxG6nXZyk8FE7SJQQKZ/E0yhhri2THc
	1DiSEXDd5uMIf1xxASbVJNKVVWwaMw71LYU1zzqUalsmqdZ8HP9RhdDU5R/XfJ3Z
	7XLP6a0Stv5QcZN+T9j7/U/xR8BI2Vi1lg7fezdgYy62SKatt6LdAFFGdMFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767698188; x=1767784588; bh=ER25jvk5I2+KOC6LgZVz0tCuHEMVlGKuMfM
	71UmgTNw=; b=nRax8LMjrHQAUzBXzt/Lgqd5XGplZyJGqe/I9ki+5Qz/UBmCbxx
	n2XjwBBhmXXMM+ZsEe4/pXiQb3ksYh/bubL5jg3I2X+SgtBSk7wWLKkkHuyfz390
	20tJig2J7UPjTw2jGvX/Z3fIO2dLdM7lpDx5YlUkBENytNy4MmfDXhyGqcJ7N2H4
	fyUkVFTLCXBbqlDMCY9nR06RkkVvY5MPFKx6hXEimKSDgkJZ7iGJurCPPEXKEo48
	RK2qlHSFxVpq2sSUhscTQ1AxXNxmmlJH0pEMLN9bptxMnysWVhWSngCBEGBaL3y7
	1EGjxIHef57iIuzSbDUqpDSqmlSK3Yl29BA==
X-ME-Sender: <xms:DO9caZpM6haTtcCAfR9KMzuG9iotCd_J8_wJhI4HCBCMqkg5NoNAEg>
    <xme:DO9caSjguYcK5FRIPHYhloP7KqOUc2MabdrWeQj1IGhsqcTvFePyLtke5NsyIvGpt
    zvNm3VIC-BpV-8NNUbLcbfwPMFZBSGlt4MnR5U-G5Jdae6opKF_Cw>
X-ME-Received: <xmr:DO9caejzesE2T0vNYVrNBsuqc_Xyft-f8X7GQDdbBPN1Ugzf35hmhuflOUM6sz4B4Lx5lMA7yNeu4rbQxYeOski4YTvnGMCgjVHtICSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:DO9caQh0_Wffa6OzxcNAzel23JN8Pe9veDmTjpb7aivJK-f4Mnyrkw>
    <xmx:DO9caWJUnxnVCVeo1LzDxlttQIpf4ry_zpE1hsQx8cMmkr_Bmun4sA>
    <xmx:DO9caXFT-9h-fTxgMVcZEynGq-3u9YtmHaEZ9nnE1HcwUKp9WDfo4A>
    <xmx:DO9caSRVX3AYCJPCkKY2A8hLzK7btzhX6tOJe5pcjK6Vz8Tl4zQqoQ>
    <xmx:DO9caRDBrIEuBH3dvQc2ykIjRs3IStVteSJp2bpX9ePMjoQTZnKnamQa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 06:16:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a853a263 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 11:16:25 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:16:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Update clar for improved integer handling
Message-ID: <aVzvBnwsuPB_zd3_@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
 <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
 <CAOLa=ZQrx2T=mPC58oSW=1Y4i1cOCtneN+U7rDUmKAke9ifp7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQrx2T=mPC58oSW=1Y4i1cOCtneN+U7rDUmKAke9ifp7g@mail.gmail.com>

On Tue, Jan 06, 2026 at 03:01:51AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series updates clar. Most importantly, the update contains
> > properly typed handling of integers as well as a set of new asserts that
> > perform relative comparisons, like "less than" or "greater or equal".
> >
> > Thanks!
> >
> 
> I went through the changes and they look good. I didn't know about
> double evaluation of arguments in macros before, so that was good to
> read about. Thanks
> 
> > Patrick
> >
> > ---
> > Changes in v2:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v1: https://lore.kernel.org/r/20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im
> >
> 
> Easter egg? :)

Oops :) Thanks for your review!

Patrick
