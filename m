Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51A7081E
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243838; cv=none; b=pjcTk7stJzr4Uf1KQZxL9KzsG2CgQEXR97X/PSqVLNGxR4pO/ZxaWcplzFqXfTw/nGGQBid/um/Xn37y8Xx1JJUFkIH2JU+RLMscf7WiFkuAl4Y/iaOtNjeo51tl5IVe2w+lg6DArWmFazLW0p4iYK96jGlwpD79Aci2FFrgIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243838; c=relaxed/simple;
	bh=b6XKVJudzlGAJcCos8XKLuPjwDkdmGeD7IG9Qv9xvmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwnhRVZQIeHWnRSVVdKrI6eN1B0ZFCQ6GhqCqCYsYtSnUemmqy7IX6XUKHJbmr6sSwQA/NXXBlawJga892pdFRYBAytvQ4rwBQm9deTl4OEOqyftRN0IZT9ucztbwpCacs6OGADtdL/jjHh3ch8uTERkoNCz9YdRrfPv1d44660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t8ALLlwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KG9y7geY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t8ALLlwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KG9y7geY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7553C1380214;
	Tue,  7 Jan 2025 04:57:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 04:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736243833; x=1736330233; bh=C9QGrBEise
	oh57capBEixGr1JJlMEmYQrNHhd6HbAO0=; b=t8ALLlwZjdR1yysSh5jVcatQVg
	ecnvOxBooLsavSYVumZA4vbz4Q22Hfg9agyf3oGkn4n1F3smVo1EVLDC7qPuMwJM
	d/PPVS3m5PRhPJi4VeMF7H5UYzZJm+hB2TfL7pAvCj+kk+UzOLbzH4vTKgXbh0y/
	w/edzQsqHsgc0slRufzbMBnnuPvjMdB6F9jnPeQIGOORBaQTGbJttWaWqVerxfSo
	bXZIbIpyZybg78vtx6fONKbdhvSzd3SwVapSbDXdSIF1+ni7bOgJnPv8TO/etDht
	rBnTPM8LowP+pjrrTbW7xm6AtgYYfim5DTRFFsaPAeiDx9cfP9YI+SHfLlJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736243833; x=1736330233; bh=C9QGrBEiseoh57capBEixGr1JJlMEmYQrNH
	hd6HbAO0=; b=KG9y7geYz3g6l5LUQ8VDbCkESe6P8K6QES3FmBvR2I/5uZujJap
	eoTO64DTmCken8Ha8sLCYBQsjdx6hDcCYkcY5NHqcNKnZGfEz3OMzwhHV7my1dqB
	ZPsCtQ6C4lthGs7wW2Djp0AM6KDjKZJRsc74NM9x7J3nNedg8OstyQAV1d3S9d7a
	uCA5CX9pAEKJbIj5AhF3FvQ63MjhpT1AgOaWFNntzQ5pepeW3ZKFK0dgwWrxwoNx
	4HljwgUawNIGcc2aflGmcwuBM2hDOOA/Q+JPvm2J6zLJNsbvjOrWe4yulm52F7FT
	a3h/fFBJpCdC5YIB6MEA+iB5H1is6q/fsCA==
X-ME-Sender: <xms:efp8Z4s7TBE0NVFvifIwl09nle7bGwIJa6vJxteIR6in5XGZUxuq9w>
    <xme:efp8Z1dYDpFD7zESw1J3ey7qpGMQwXDcUPb-Sweyfk4_nqidbiu5XCDs5oQAa98dr
    Z0Is50kMWVHSA4Fkw>
X-ME-Received: <xmr:efp8ZzwfDoCIdLbc8N3oArK1B9phZjvzW7cCYjHfqd4W9SBrzV0XtegqfWJSuEtM2mgZRSG2in61mp5fnYXKOe4UH00yP6GxV3_dFdh8G81zdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:efp8Z7OgRk6Hd8kIZB7qFS9r3TnngBJY2K_n_TRFHPptwa2zKiM3MQ>
    <xmx:efp8Z48Cu2Odq7a3Dcl5cUwlQ8rSDejrXsYQOYsRJm9NN1FLZw4X9g>
    <xmx:efp8ZzUtp1klNS0B6rfCHS3PmTSY0Ik6AWt1uJyNccrXIt7Su_KLCQ>
    <xmx:efp8ZxdvRXQWF6iJQvR6IH54bIuKEZhXkV4mPD4gMAkf4w0R_vCKIQ>
    <xmx:efp8Z6IyKO4qUe1un6eKiBGO_bbQF3r8cYqpxyqZwV2zb7EHS4cbYDRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 04:57:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f17e217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 09:57:09 +0000 (UTC)
Date: Tue, 7 Jan 2025 10:57:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t7407: use test_grep
Message-ID: <Z3z6dKBRjQlsrwjZ@pks.im>
References: <20250107071824.GA594237@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107071824.GA594237@coredump.intra.peff.net>

On Tue, Jan 07, 2025 at 02:18:24AM -0500, Jeff King wrote:
> There are a few grep calls here that can benefit from test_grep, which
> produces more user-friendly output when it fails.
> 
> One of these calls also passes "-sq", which is curious. The "-q" option
> suppresses the matched output. But test output is either already
> redirected to /dev/null in non-verbose mode, and in verbose mode it's
> better to see the output. The "-s" option suppresses errors opening
> files, but we are just grepping in the "expected" file we just
> generated, so it should not be needed. Neither of these was really
> hurting anything, but they are not a style we'd like to see emulated. So
> get rid of them.
> 
> (It is also curious to grep in the expected file in the first place, but
> that is because we are auto-generating the expectation from a Git
> command. So this is double-checking it did what we wanted).
> 
> Signed-off-by: Jeff King <peff@peff.net>

Thanks, both of these look obviously good to me.

Patrick
