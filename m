Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA857186E54
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674355; cv=none; b=ew11lvbL/MttSyvElcSdjch498j+hZ+k2cprY1SdEj0X3JsPkXshIyiCvk2UQ69RPoX3+cKg3xzxl13HK5EHaYhaDG7BVBCh0krNM4qNs4mG/xQoqEj7cYfM5WWVraGfD0TVSxPT2sZvuE52Qo6qCHrsQwsSbncpo4mUs7H9sTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674355; c=relaxed/simple;
	bh=NLBFVEAM5ruV+2md/GLk2aqEakcNJsJfBZuFJFJW1rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc6auTA8+KaMxtB/NIwoKjxhCs/Vr58kH6FDxntM9/ftOM2qteOn7qbGe/8rp8rn+sDJJEqgU03q9F2Q4y1S2A5XM72MJYZKoqMnzPCCJfHgpxmOVWKlriwqTwxXj1RwVsjHfxw1UzBYU7g4VTNJJFPAzDnIc6yWjzSp8Z63fY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LvUBWi55; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xGV7d31Q; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LvUBWi55";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xGV7d31Q"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A1F525401D6;
	Thu,  3 Apr 2025 05:59:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 03 Apr 2025 05:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743674351; x=1743760751; bh=E0tEFuNtpN
	Tzj3tM2drufY20UOC6qa9El2azCp/PcgE=; b=LvUBWi55ho37E62fDGzCxzh0F4
	VgLxpZQTDfkWERjL4pfU68J3wU6udbhwyB1Lmkq1uR6KJc9RHw/kQ635OZTuovlG
	dXslDaN8oATbJ+qrQbNFBDss2g+gICBalBTaA3I5hr99qSpXZnARmi8ZzYw/F4/j
	Rzchp5ihqml2/Cep0vgQHmXwID1d/w+5W4nQmOVpRsHgAdkzhbR7hC7DCXuTB/j1
	bt7fHoGijkCoFsjXE0G7Sf1l2tH+Dd8oUQLh1J5dncErI4+d/8DhAt/pQBFUEFcB
	lhwkuKUNk9iTtW4GPPengH9kK0t2akcYexMab+zfqP5JVLsgx/fMY3zcyszA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743674351; x=1743760751; bh=E0tEFuNtpNTzj3tM2drufY20UOC6qa9El2a
	zCp/PcgE=; b=xGV7d31Qllon1/BaFhB2WcDz3zVzNbJn1XIgOuHeqc43mJ1xUby
	6str1uSClCIYbaYngnBTugJkuQlTo49yfBcwAcc/n1E4u9NUTWPj6k6BNRtk9Qie
	YngSRCT/iqv3fBmblkz23BRVxzqn4ssTPJHZGe9y6EKjZS6bLOYy7ePunJhHArSR
	VSnnNLPxzM4afb4POiiwDYE217LFL5K5q+5y9f9XnP39LnFnQjnJ/YK9XjRNKSBp
	/MQoqxH30BjKzjecSqFLV70dAUIRpzS2DrQk4b44bqNgX+G/9MGP8eCFIdpsTjvQ
	X3R65mggy5FLpJknbLSk3iesQ2FNExE76pA==
X-ME-Sender: <xms:71vuZ7g09PoGgdeYjc6MzFeBIVCi2h6mHa-8AN9a_l-Ih3QTFXQA8Q>
    <xme:71vuZ4De7bKuuYMDnVPAoMbRjyWtILmCrXRoHwpa86TTJ4th6fk4Cg-X_noxJSLbp
    lmJZTSFEOxs16ItYQ>
X-ME-Received: <xmr:71vuZ7EUj_rIYeMCcHDDphvgeMaB-_kDOCmLezr_t-q-3hUABJX9-YBxe9BCrF44S2jFg7WkOk-9uocAA2rI7SRs3vmYholt9ZuDx3dEb1ySDS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:71vuZ4RBkhEaO1-bPAM3JJ2zoEXv0ZD_j4zSuBWH6xnimcsL45bSWg>
    <xmx:71vuZ4xBFvyhv_8qhiGCYTHYo11zPMLuo01Wl5hYRt0lBuXds7lkiQ>
    <xmx:71vuZ-5MVKpbTqHzYd_4cOSv2sv7XyX6WWdewNyezJeIu-o5OIfOgQ>
    <xmx:71vuZ9wmCAXJLzsATkaExIPH-nzBHdJmxS79gv7cZKe8scv-S2q-KQ>
    <xmx:71vuZwOWOF0wUcSSxcmXolgyRA3gmLhP8WlQzTeqPD3NaRtBsx6u0ZKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 05:59:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f38d9317 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 09:59:08 +0000 (UTC)
Date: Thu, 3 Apr 2025 11:59:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PROPOSAL v1] =?utf-8?Q?Refactori?=
 =?utf-8?Q?ng_in_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <Z-5b6INZXiXbEuU2@pks.im>
References: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>

On Wed, Apr 02, 2025 at 11:44:12PM +0530, Arnav Bhate wrote:
[snip]
> ## Proposed Plan
> 
> - Identifying all occurences of `the_repository` and updating them to
>   use a `struct repository` passed to the function.

I think that might be overly ambituous :) After all we're talking about
~3500 occurrences, and it won't be feasible to replace them all in the
couple of months. This is rather a multi-year project, and one that has
already been going on for quite a while.

> - Identifying global variables that should be moved and identifying
>   suitable locations, some could be moved directly into
>   `struct repository`, some in its sub-structs that already exist and
>   some in newly created sub-structs.

Likewise, I would recommend to properly scope _which_ variables you want
to replace. There's a ton of global state, so you should try to limit
the project to a reasonable workload.

> - Identifying and updating occurences of these variables to reference
>   their new locations.
> 
> It makes sense that all the variables need not be in the same struct, as
> separation would keep the codebase organised, and thus easier to
> maintain. It would also make it easier to introduce these changes
> systematically, as a group of related variables, combined together in a
> struct, could be introduced in a single patch series.
> 
> ### Timeline
> 
> #### Pre-GSoC (Until May 8)
> 
> - Explore the codebase, identifying global variables and how they are
>   used.
> 
> - Start to identify suitable locations for global variables.
> 
> #### Community Bonding Period (May 8 - June 1)
> 
> - Interact with mentor, discussing best ways to refactor various
>   variables and make a plan based on that.
> 
> - If time is left, start coding early, as my summer break will have
>   started.
> 
> #### Coding Period (June 2 - August 25)
> 
> - Modify functions to add an `struct repository` argument where they
>   depend on `the_repository` and replace all occurences of it.
> 
> - Move global variables to their new locations in various structs,
>   and refactor functions that depend on them to use their new locations.

In large-scale projects like these it typically makes sense to work in
batches. Instead of having three separate phases to "define the
problem", "develop the solution" and "deploy the improvement" I would
strongly encourage you to define and tie together smaller batches of
work.

Thanks!

Patrick
