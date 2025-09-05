Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06A2F5495
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071808; cv=none; b=kU6jSu5Zd3dYfJgZVrMWX1SGE7NNCDiIO6eiDaXnOj+M+X92hCf7J7c+KdbLU2Nlv68dKrMp+Ml/hMIqP6wafMU9ldOjnwYUWky8JiFGMTy3eMdjZaDwQmb3oSqtXhHmd3YuTc72H4wEJYdOSPJyNEwRe/nZ+7TydJrFxixB1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071808; c=relaxed/simple;
	bh=49V8j7eqhZpAZMZGG7W2omPXRfPReA0nJffPSKwu0vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYchI7x0owkMHYzY8xKOU5L/ZkmI96XppoYcNj/hXeN5FpniLvmZIqbUD75fXwn50p3/NIBJbIhrygd0TLFCZ8Sn4t2RjMCs6vlkWphxnZ8/obgh6z+ApbG5L/pYuVS+OQ4H+Ws2gXaqIIgcXMZ5iGG7M4OsqlPMZ9FJJR2UsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mWmKJ53k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9bkPhQz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mWmKJ53k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9bkPhQz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 25D141D004FE;
	Fri,  5 Sep 2025 07:30:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 07:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757071804; x=1757158204; bh=Ijv7jY87JR
	fBuFRmDRches4E7nBMPaiHbK/3a041u2M=; b=mWmKJ53kow7qNX4ZTC+zj9WbZK
	h9fMsHKO26m1y1s4Gl7C3Kl4yNm7+ZET6/7TcSgfQWGPKq6YrZ4Zbc9/kfVSwwPc
	ORK+XMhI0+oBiWYy+/lZ3QG1azbmPYfIPnEVOHeOvy48q1rUCjF7txPpIcyKak3O
	Pf9ptOzqSniZ1cJWtqtZkC15ByDABleXyHyvzKlFTyjb5jlKlfJRvgUeR6A53zZK
	/od37HNjVdCVmvM9OPjY1ALKrfzF5rMfsfrsMKFP5HiMJHXSANZmD4tZ5RLDnoh4
	G0ihxIe//JRnXVA9qjvExBYLGrHWdSYq6nWteNL8sNQIwlGyETVp70xdRPaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757071804; x=1757158204; bh=Ijv7jY87JRfBuFRmDRches4E7nBMPaiHbK/
	3a041u2M=; b=h9bkPhQzJ1sZ5HD6lfUphZLeoEoHEgUXNIcerFX5WUF1pHxLmD8
	s/9Jz7HKyLMSPanQlDB7oVE+UehGA8otjuCvwr97OegCC4egUfFkne7bi4cZ7hTm
	1XR2Otsi/wqtnDamQ0XqWCAC7PRsXG+O1WO/k+44CaF7tC3BE6Cz0Fhijc7v0Lxa
	IkdTTQ4VhTdT/YXDEmfBydlyjKReQN3UEwFrszy72GId33LBHstcevMF7p/5Oldh
	KYy+OrOjzM1MRYoHAJlLUoalMMVVDCTLxeh7c+9pA4sjspjilbdfO1K7++8nPmI3
	x6QKlToZ0BTRpWVa3QsuZKeFZwBefUv+Vuw==
X-ME-Sender: <xms:u8m6aLLNXwtD0V7au2DyMmYEa9L3nubs0_aQbI3M9iZaXIVGZksAPw>
    <xme:u8m6aMtc9NHtbZAKpPrafLjzmjiG6ClguJ7fqg-BSia5SSvMxxxpqqJ7Woq_grkqK
    nS2MZY8AlNnqv0SvA>
X-ME-Received: <xmr:u8m6aKJSPRT4eQbOV31gx3UhO6wgCYH9cSR775yF97C-2CQxfBUZxH3qTyvFHskcPzTeBuCpX2wPZMVPUXGr0RDTbd8L3xcuKJ8jYSYX-Hvd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdr
    rghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorh
    hgrghnohhvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:u8m6aF-PZqeJsoFJPlRI5Zw_ePqU2p5e0DihqhsQZ_ncofYUahMfxA>
    <xmx:u8m6aDzFW0v7qdiVU5qeq_xiY0cOMA4PLbe8zdlrjG_pc5hOVd4SHg>
    <xmx:u8m6aC4-cdgBKJHTZ0rcfqj2qS4d9wU49qwK2mvHUhjZOpogVnICNg>
    <xmx:u8m6aK_I5ar6nwayC1CFN7HefArI-VabvuZa0Tqrz1NJTB4TvaymGg>
    <xmx:u8m6aClmo8rMP3Bx104VWa01mgh8Q2WofYiNez_P-87U1BrP1iaLkmcc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:30:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3ad3f07 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:29:59 +0000 (UTC)
Date: Fri, 5 Sep 2025 13:29:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
Message-ID: <aLrJs5ONF0Foi6er@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <83d36c12-64c0-44e1-a5d3-dd7a5575ad65@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d36c12-64c0-44e1-a5d3-dd7a5575ad65@app.fastmail.com>

On Fri, Sep 05, 2025 at 12:29:55PM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Sep 4, 2025, at 16:27, Patrick Steinhardt wrote:
> > Hi,
> >[snip]
> > I thus had a look at implementing some of these commands in Git itself,
> > where the result is this patch series. Specifically, the following
> > commands are introduced by this patch series:
> >
> >   - `git history drop` to drop a specific commit. This is basically the
> >     same as jj-abandon(1).
> >
> >   - `git history reorder` to reorder a specific commit before or after
> >     another commit. This is inspired by jj-new(1).
> >
> >   - `git history split` takes a commit and splits it into two. This is
> >     basically the same as jj-split(1).
> >
> > If this is something we want to have I think it'd be just a starting
> > point. There's other commands that I think are quite common and that
> > might make sense to introduce eventually:
> >
> >   - An equivalent to jj-absorb(1) would be awesome to have.
> >
> >   - `git history reword` to change only the commit message of a specific
> >     commit.
> 
> The cover letter is a bit outdated. Reword has been here since v2.

Good point, addressed locally.

Patrick
