Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAC1F3B8A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027688; cv=none; b=sbrV0rGwTbJMf9s6810Xy6X70t98SXFbJdDjCSZGpio9pl3VZCWlsmUuUG8LkslE4c2+LeZf2Crefk8XwIgYX5/fXCZ0mHE1MrREZI3/9MU+N2zOQkV74OibZNEKo0GPFtq4s5cKoOukjqnLB1Ug85CwyKmA+gGiz82rPhMpyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027688; c=relaxed/simple;
	bh=FXBVWKWj7CGArrK7QqYu65UGkF2lSnuufBCJMg6Bbfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOGjh1b3sxXK9jKLUXSX+Hk5pkQK2vDiRxY1janIJt6Ej2PvzZUJ0vpE3S5deSkaoW7YI5UANgzMZvuBkQHmho5JGkvkwJGXRABeYcQWKZCM5HROzeBMJOzbgJe4T1Rwix/2LMM8oJ/pzqvhzOIMVGDDudTSUBSjugHoLfmeSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JPdHswDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ec+k20b7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JPdHswDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ec+k20b7"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 33BBD1D00B10;
	Fri,  1 Aug 2025 01:54:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 01:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754027686; x=1754114086; bh=2uxJPo8bRe
	ebFcev1OrydZL/f9jTv+H76GKxs5jrc6Q=; b=JPdHswDOA7Eu7nSNtEnNI4S0gb
	uJLkGFRRVJSianZIUlZTyn5AeNx++MkSixWK4gnBnKL4gT9aqpAnhhl2rkR3if6q
	rztIN4mMas8yVfYRGcDVDzqi0pMqPxGWv4QGOIKNMrRdlqjvDPD1FkE6Ez9fgOJA
	HDcTFlXeCkpUFTvdzJhVTJCpll8N1bUV0y3prFYXih38QaX1442l3y+mI7Ju6Bm6
	T/eKOGfQTG/82BwkR3oTTc1R5Q/0OKsHnK8v5TDb32YcMkbGFSeRJhZOekzI5J3E
	9GIzKve1Tu+CFNAY8IRh6QY5PayAnMdOLUk7/qYNmxfFajkMztgcVVDF5Abg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754027686; x=1754114086; bh=2uxJPo8bReebFcev1OrydZL/f9jTv+H76GK
	xs5jrc6Q=; b=Ec+k20b7pcnE/6NrG+k4QKwBP0u3/0v2xpvs3T39Agftds3uDiT
	BjmoBEvUfspAkU3w4DCUXXRXFbKH/s1RMF27JFNZ9wbCwP1Hxhuxk09KK6DVCm8L
	rxONjDsPoYeWQLvXK8P3HW5l/abci0Kt5m3pTHiyH7+JANyfyA6lGm5aAGUjLGIH
	nnTCpWbckQyIHQ8ZdgbHHqAiGnGGo8BAkmgud5YuzMfO4u0EY+c4pyj+uhj0rSk0
	c3UO+ErITYmRxmVkW1C1RfmLyhE2dDHwGO3evPnTY5rf41RNX/+PkGRXLGxEdWR0
	8dp6GK7A3zWkTxXRPFB08RqkF/kYXaqsz4w==
X-ME-Sender: <xms:pVaMaJC6p0P-61ZhzJz-TRLkbh5qqFqv06CfIrMma3kdKr17bQJSOQ>
    <xme:pVaMaP8pi6XUIcfcA3GUhN_7TdrZltcz0y-D43eXXt258JvjNphm6hzRB1HUfpYqL
    dh-EzlcyfWDqYW-1g>
X-ME-Received: <xmr:pVaMaFBr_UC3GncXZdpFhTy_nEjqrJuyncIzHrSbj74Uq8DehmzOnktR56uHkbeeCVK2OHt74LeKlKKCLiBej5z2Hv1X9oVVv-vONcBuMnZH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pVaMaERghg7ZkyqychAQq66KwkpWyaZjBbXnb17puAFXNyj32jdhTg>
    <xmx:pVaMaMszlC9B34ZRdEp97CT4F5Ik-nxiw6KEtTtLikH-IXK63hSb5Q>
    <xmx:pVaMaA3mzj9tN3K4sfGOr1CjgbzmEgTX7YmXgQINm7MUQaqt4AR9BQ>
    <xmx:pVaMaNWlkWYyk9DdSJkbMcJuEpAR1cSG8Yo0zrLKKfnkR3fYo6HRmA>
    <xmx:plaMaJjXgxh4db9O5nc5yoDF4JZx9cf1MJPtNiLh50zTitvoZA63SAVo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 01:54:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6cfc19ec (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 05:54:44 +0000 (UTC)
Date: Fri, 1 Aug 2025 07:54:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [GSoC][RFC PATCH v4 0/5] Add refs list subcommand
Message-ID: <aIxWocMpvHJ7bL0V@pks.im>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731090040.1625303-1-meetsoni3017@gmail.com>

On Thu, Jul 31, 2025 at 02:30:35PM +0530, Meet Soni wrote:
> Hello everyone,
> 
> This is the fourth version of the patch series that introduces the git
> refs list subcommand.
> 
> Changes in v4:
> 
>   - Implemented architectural refactoring. The core logic of
>     for-each-ref now resides in a shared helper function, and both
>     for-each-ref and refs list have been simplified to thin wrappers
>     around it.
> 
>   - The usage strings have also been refactored. The common options
>     are now defined in a shared macro in a new for-each-ref.h header.
> 
>   - The patch series has been further split to cleanly separate the
>     preparatory refactoring commits (for both the C code and the
>     AsciiDoc documentation) from the commit that introduces the new
>     feature.
> 
>   - As a beneficial side-effect of unifying the usage strings, this
>     series now fixes a pre-existing inconsistency between the --help
>     output and the man page for for-each-ref. This allows a known
>     breakage for it in the t0450 documentation test to be removed.

I've only got some minor nits that should be quick to address,
everything else looks quite sensible to me. So I think this is almost
ready to be merged.

Thanks!

Patrick
