Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DEA48
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392609; cv=none; b=mLQDmd4VQsYkXDuP6xotb6XojFB7u251cSlwv26FlNmncUsO/GUjUykpRVoQh6+EKtrmyP6FdUUza4kQya5hBucMciq17fDxdHxWYIgj/TNIJvqskk9uwlNN8E6ODAOKXv9kWayf0zRJsImQCdlhiQoiCd+hhefADpAEi7z4+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392609; c=relaxed/simple;
	bh=TMhPMkGQmXE4qfOjk0/ss1xBVubRW2G1uiSFTKKKyNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DKBlRSpNrsfvJhkOiNawiCBzho5uja2m84so+PTbVpOQSDE81Q047EgHmwPcl+Zgd3ujtyKv9XksGqYkmAvEQaXMX4lNBeBN05CR0OI7Qmxp7ujy1zZNuJ4s1Q2dYsaAqWbOAP0X2ikr2Owy85M5YJcDK3uXDfVZN4Nae2d3FGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f49GFFGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9k+gIe7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f49GFFGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9k+gIe7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C8DD1140089;
	Fri,  7 Mar 2025 19:10:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 07 Mar 2025 19:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741392605; x=1741479005; bh=NELAgys6rC
	DRZ21S1TqtFEmanUA/h1PvsdbglQoiXwk=; b=f49GFFGwbwp5t1wXmAMOj4EnNJ
	HK9bHT+q8uJ4nZH4nspbvKC+75Onc1fvgLljrUHdvFPtQeg0KLRayh7MsEAnB4ag
	kAcZCjR7kl+0Q/YcFP2uPRNFjUOQxTL10r/2lOgNLcFu3JqPcPqY4VLEYpyAYUXE
	fY11pKpfls/2o8m9RIdD/CJaGa8FHvSZNHecQGNK1uYAHEc4Kcg/jJ6Wr9dLf2iL
	VnrDLXFyv63I4ILNrGnO1GryhyVsIOyCpcHlwrrorWIryFPwm0g2jdwyNbLvfl8Z
	ORbYCeDFNQ5mTp+Dh+yngzpKuA2vW5mQVtSqkyHsZJMBVtTK90GmMvo3a5uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741392605; x=1741479005; bh=NELAgys6rCDRZ21S1TqtFEmanUA/h1Pvsdb
	glQoiXwk=; b=s9k+gIe77BZLdy5alfL9SIeDGsEGDhwRUQ108qWclYHQzgSFX/h
	RqVY5nTDcbvSe9tVt/bgDIsAal+kiDsNhReWD77DqbTaiyLzwt+53K/10kqHW2AD
	HTZMfS85B07fu8U4yp0YXJHAgsoLu5Oar0wt5YYbaXYr5ztCePkKm6BYxBedjM1x
	JC4pb99i2DNlU6IF1GZcOrimvBzPT0akSupsaNKq13wZbyC0eOOc1NFhLW/z0dCU
	pQI9RKHvTp9vFfQcF9VjGf4mKUUaz4OOC/RSHRLdJiaWotuJHvJW/PUUKoOA2X+8
	zBQAOhy6tyaCu7luz/oSJr7wXcbavE2XmYw==
X-ME-Sender: <xms:3IrLZ-auEzPDEbQVVCBtCgWN66McN_hbZ00V-wQl_oMM-LmZK0V-cg>
    <xme:3IrLZxY4gmauZRdSFM6nCGO9gK8dEdeJ8YJDocnwajS5kfpL_IG8JHetJBhwCF9qj
    TD1qX04eDjGILZ41w>
X-ME-Received: <xmr:3IrLZ4_9fWPVGZYB19V6n8bCp0olZ9dC3d3zAbAxb4OQ5wieDeP_4LBYplm3lBQJ444zvsAUzFRFGg9zRwORg_ivwIKEQftQfVl6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3IrLZwrcKpV5aXhbt3Jr7KBJzIEkvJYs99sLLvdglbce2aSZIVzq5w>
    <xmx:3IrLZ5pwbMZw-K1EassLUwnq1uLmEbI2GkJVmQBii4VVrA2QSN-rcQ>
    <xmx:3IrLZ-TpNMQWpfihQdLmKMffOWJqQXw5Zmk7NCWVaiGOYw7k4cl0ZQ>
    <xmx:3IrLZ5r_d91HVlhz-P-1J5vZ2tO-UeTInNQxXAYmTllCAuCZzcpwsA>
    <xmx:3YrLZ6eZAktgUxievT0YOyUaDyM3TauouiXfeu-v-Ox90g8rZgdfIfJo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 19:10:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH] fetch: fix following tags when fetching specific OID
In-Reply-To: <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 7 Mar 2025 18:27:03 -0500")
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
	<61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
Date: Fri, 07 Mar 2025 16:10:02 -0800
Message-ID: <xmqqsenobcx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Fix this by only adding "HEAD" to the ref prefixes when we know that we
> are already limiting the advertisement. In either case we'll learn about
> HEAD (either through the limited advertisement, or implicitly through a
> full advertisement).

Good.  "implicitly through a full advertisement" is a good thing to
explicitly state here ;-)

> Reported-by: Igor Todorovski <itodorov@ca.ibm.com>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> Peff and I talked about this today, and neither of us could find any
> reasons not to pursue the approach listed in the footnote of
>
>   <20250221072558.GA572877@coredump.intra.peff.net>
>
> , but this is a more conservative approach that should fix the issue and
> apply cleanly on top of 'maint'. It may be worth picking this into 2.49,
> even though we are already quite late into the -rc cycle, this is a
> fairly nasty bug.

Thanks, both.
