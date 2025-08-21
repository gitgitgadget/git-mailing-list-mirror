Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C42DC322
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788131; cv=none; b=TeV908VU7o4E8NEXwqMmOlU37zcTMbL9IBGR5VDFaJGZSnJWXostIYYgqWjtsYRmvVZVAH1sZmXBBLjbz50UhsPYVvDdKNFuGoH/kxC91Ht6RqalbIjhRSOUzcv6p22FTFTpE4g2j0VDXWEOgUGbuHGZwUYhmz2Tt3aujJR6g6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788131; c=relaxed/simple;
	bh=Kj2T4pXK7sYLrSiqX5IanVH1zztK31h/inMPIUzwXmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMLHpjoWpodq/MNmRpmww1SVgQ1cEG12sWH1/H2raN2AZWFLBqQ+KKWtyEYe79Qn8wvGNeJsonGTC7Nv7QV9DCKHHGnnyDD3jOyhU9gHEsnApk9VdQjv2fhnI3+bO/EOOziQimnZoMRLOPQD/YEHKRAYv+dnTvDQGPfVQuYcX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HBs22SXM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4wikxDu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HBs22SXM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4wikxDu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 937DD7A019A;
	Thu, 21 Aug 2025 10:55:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 21 Aug 2025 10:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755788127; x=1755874527; bh=GLnPQRQiv0
	+pUWztnkYS2m9BWzZRE8DZfH1Ys1osmTc=; b=HBs22SXMgTAAff1MKNkM1zSaqv
	6FdS53Sd7XF/eTXXhdsZQwX8/eHeBFRKAZLI0H1eDMs82pRLgdHmkizywGb1esi6
	HValH/s6/KpeIp5wtVdilzeHve5IDn9gcgqR6fbjbWb/SxTPluayG/ule6BUJ70y
	HxI0Hfsgnggmilio9LhL5eqVNDnDZ5etUkhUWXFhgikpfJEmZKFIbdBYoMJWbF7v
	vF2WyuvSjEV8HsDqnwCOSCIZoDy3UMb4lMCJIBHvyuZjJ7UeJqFFwjQ7AX5+aFLx
	R9Ma0JyVy6A2L52mXYiWoasSMeiB2Gt2xLvK3vPSqzADXUN/R90+3aMCdOEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755788127; x=1755874527; bh=GLnPQRQiv0+pUWztnkYS2m9BWzZRE8DZfH1
	Ys1osmTc=; b=L4wikxDuDP2hBtvhi5Y53ckAEuYsqBqQlRXgZMnXAUGLYtB0dnB
	Uwm2zALz4Eu/+MDWAjxhotdRdIiDu517xty8H1ApPzDCkkgdbBElSKwvew5Yv2Yh
	i/VLd2hiBQ6cPJJfaWGrCrdeh4HM5/LoRlYPIA8CYHPkFZhEEsAsEXZ8qAr8J4tB
	hMSzhRveiK5xXomfnceqtVjZ042iu/bYAdqQ7FTa1PY7LZOfC5WVmabut50mJaaF
	RSs5hwGUPcS01lcuayfxhOPr0ASVkPW/4eCU0kt24oAr5uvtbm/FYAMQrqpK5+1q
	vZQGprfz1cl5LLiY6vYrpXRgZ+zcHIgiZ0w==
X-ME-Sender: <xms:XzOnaOpwXTYxsG590xIymQRMulGG96fAH2zPs_5g1a6Itxeoz9_dXg>
    <xme:XzOnaP5XcVHHHTugVimGPNEeJIiXGcbSbH3NFur8ATBHkbKLsyU4V30MeluuczGz_
    II5gSL3D-flaF8WZg>
X-ME-Received: <xmr:XzOnaMouQ82Gz-2yZBfX35FZHEhQTq57GZy-XsUnOBkRQJjALR6EUApRRRPAVfwZhcXJOdcxkZbG4LtGBPr6XIWXcW38vr4pgB5wkwmteA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrg
    hsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XzOnaJjjPXp7tEBq_hTiegdlqe_L7aelFsef88sGjmhAt1XHoZnrVQ>
    <xmx:XzOnaOL4hVElH_rwKsFifbOyvBCuT-FxgAaJiy9lCAIGVarV7kmC9A>
    <xmx:XzOnaBAO0e0eP1pClsCrRdUo01zWsS7VWWdI1TKV2WivpAkId8lgBQ>
    <xmx:XzOnaGgdlE42L9DfiQ_TwmhQdrGpEb3Pxb0VcfgVBu4AAHszIMHwmA>
    <xmx:XzOnaA1ihY6TFm3OSW3a6q5YfHogTIhN97NveKS_4EvaZuTREheZm_OW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 10:55:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 547b6ec7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 14:55:24 +0000 (UTC)
Date: Thu, 21 Aug 2025 16:55:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
Message-ID: <aKczWVw1HafaKZNW@pks.im>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <aKb1AfeIWB_SfJiI@pks.im>
 <2AE1A298-97D9-411A-A3B4-AB0A48D71536@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2AE1A298-97D9-411A-A3B4-AB0A48D71536@gmail.com>

On Thu, Aug 21, 2025 at 10:23:29AM -0300, Lucas Seiki Oshiro wrote:
> 
> > What this cover letter doesn't mention is the base of the topic. I
> > assume it's v2.51.0 with lo/repo-info merged into it?
> 
> I was assuming next, but I'll make it more clear in the next
> version.

You shouldn't base your patch series on next, as next may be rewritten
under your feet and it would hold any patch series that you built on
hostage.

So the recommendation is rather to build on `master` with the specific
patch series you depend on merged into it.

Patrick
