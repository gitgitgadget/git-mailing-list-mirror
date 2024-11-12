Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A5154456
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401623; cv=none; b=FVcur17YIeSv2rVyjVWeqXSYT8dRSHO7DTum0KIKI6ptzxbmA9T74XKgSN3GZ1v5z19vykJkwwy2eQ4lx8KCe+DZvjSdSOCoglS7W1f0YmQ9W6fnKTKPei8CSU1fKPhanlNJ+1f3jNLYiW4OqRcSP5aq/26swjgEisGXaYT0spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401623; c=relaxed/simple;
	bh=jV9G8egWU8uXgZ20lhrJldx4cq55P12ZgASCKYQIOF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1PBMRmbvAEMTnbHu5tSLihSmEjcfTpH3uJaiQHw9O145ULr3Q3sSe/+OZ6PlMy7RsrRV6CFms/+eWwoRGpeVLzoIdsPLeOuMlnn4aCpHg2XY5x2BGuRFmGfJV/Ai93cCUdyDthlI4v/ml1sxIivr/q/t1S+g0PmcqVKGduMtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p6cPECa+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kSYYSkjj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p6cPECa+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kSYYSkjj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94B652540143;
	Tue, 12 Nov 2024 03:53:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 03:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731401620; x=1731488020; bh=ZnAEmHBLRC
	SntJABoSjNr6zwcuji2JDiEQlwbT/rCT0=; b=p6cPECa+5ffQfZRW2ht1NYpa8E
	Q6QYOnCBWa/XFpFEkhz0lQpV9anBqnGO77Zt7xT1M5vpHgr1GOWlJMHmBGs8uosZ
	V3WDuO6qeomTVNvNx5fNk7WS4BRe8fMqPswR2a81jFT630+gqi9iICAIc+uTk7hM
	QfiCLBbwcPcOpktXiOb4ow/uDunsOKEx8QBtjEbKJte47ZiKHhEFttbH5x/QsAoJ
	YRWgt/BjEPeEMXwnoWofZmFRtilF8nNdhdCXTVAWvTlGR7sUgq+nivV5nodKzOva
	1vOubyIJJM3ehcqao3K4ZB9DueaROV/n9Z8ejmmwWdYA+Flu+geTgfJx3S+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731401620; x=1731488020; bh=ZnAEmHBLRCSntJABoSjNr6zwcuji2JDiEQl
	wbT/rCT0=; b=kSYYSkjjcerRHS+FQij6FCvgQS4CPBNnCjiwCojp59R2mP1FWTK
	e4UzRDtNHKjJVFluWoTPpAbwBPqW63zzs1ZWGBWS+mkF2jJisqYWnCT8KyJNLagW
	7KWSV6MZCzPqAzNVmj4V1pEekV+soxI8DRnuZUgPdRJJoUjbI4O1mPveO6G6Io3r
	/KmYme+rY0WDPhOZ2Q3YgC0deTnrkRUyOjmt3e9LEg+f1ORWvHz2+ppOqf3lrAWO
	p+jIFZl54KibdLUmKBuw8wuU0hiv9Co02lVvUfPTb/BkN1z3P+sWnr6HHu8kjrgr
	i/Ff19Nw+Iu+ha/yoWdWDJwV6zGo6FKZGQg==
X-ME-Sender: <xms:lBczZ8o2HUt3F7NxUYCyhGj1Th4g0BDjP8Pv3FXw8WVwJ_61NC-hbw>
    <xme:lBczZyrs1zBsbAZFISvNQzekdJtXmvuDQSON5ojlxIIazKhb1p8vjNULBkXHdzS4_
    yOL_6CcdvZrYygd_A>
X-ME-Received: <xmr:lBczZxOiNeS4q2gxuAlvZHLCPs6q6fA7yif1juVgrcqpBvpn1H87bbJXQxmC2kopDwNe-kKG470r8uIOFrxQwGZe1102fxmymJXnGyMQvQSIMbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lBczZz6A2oJqiCKq0nU3LxSIqRsa7O9FPXefbwijR8UR_WlLBicqMw>
    <xmx:lBczZ74SrD_74wusJgc_ohgHkCykQbjdE09Vwv58UOHvH4AUuGaSSA>
    <xmx:lBczZzhLKUFOEdY3ACpUIfTsh2-3uCYYD2IcMHH24mVtOOjDEERoAA>
    <xmx:lBczZ17oZjKbGwdy2HNThFxPNAOqyFOlnK4f1Ydzli-RTFjUIQ1YAQ>
    <xmx:lBczZ9nfypgR0GQ-vLR51u2UaPQ9bbi0GRtRZoCeIRYZTu_psuc4J2fA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 03:53:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b4225d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 08:53:00 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:53:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 21/27] global: drop `UNLEAK()` annotation
Message-ID: <ZzMXh-Pcb4SMSno0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-21-6154bf91f0b0@pks.im>
 <20241112082609.GA3166560@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112082609.GA3166560@coredump.intra.peff.net>

On Tue, Nov 12, 2024 at 03:26:09AM -0500, Jeff King wrote:
> On Mon, Nov 11, 2024 at 11:38:50AM +0100, Patrick Steinhardt wrote:
> > This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
> > easy for the annotation to become stale. A second issue is that its
> > whole intent is to paper over leaks. And while that has been a necessary
> > evil in the past, because Git was leaking left and right, it isn't
> > really much of an issue nowadays where our test suite has no known leaks
> > anymore.
> 
> I do agree that stale annotations are a weakness (they do not hurt the
> leak-checker if they exist, but they are an eye-sore).
> 
> I'm not sure I would agree that the intent was to paper over leaks. The
> point was to avoid noise from the leak-checker about memory that was
> intentionally held until program exit and released by returning from
> main(). I think the main thing that made it obsolete is that we decided
> it was worth it to spend the cycles freeing that memory rather than
> ignoring it.
> 
> But it's possible I'm just splitting hairs. :)

Yeah, I know that this was also used to mark memory that intentionally
leaks because we're about to exit anyway. I basically consider that as
some form of "papering over" it, but I get your comment that this may be
a bit too strongly worded.

Do you want me to reformulate this, or do we just go with the current
description?

Patrick
