Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1029D29F
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519441; cv=none; b=N0PuvZ8SMBLIVcP9mSm7CyBjf/Zf7kRqzJIXNgT5Jpi8lBnbuCZe67NpmsxbCo290NyK/+1dfinqlCjvxVPyl8cleItnqd7y5xhwe1pN53oneLQBXls0QOZcAgdCU9sEu4HNWSQYDRwswdwj9NlCvukoaS6gbjMS99gmfRFI0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519441; c=relaxed/simple;
	bh=bC0M28E7V3vFzSNiBM2Zi/1V9r+Io3uIrwyOb84y+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFg4VF36qroAT/AVqRSh9CZLyCUfqaNNaZ+poHvgwUtBPW6m0/FHx2bodEO5uPgaU6MHwE7Df7GZPbEdarOy3tRSPNfOyNBEiB8oHxUZA8YLoWYMdab1CRd6rAt6tWrvu+e03zTUkoa1lM2xcfyHSrZv0jEOd8wOBQdnk5gND3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jdgJnwob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdpzNwU3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jdgJnwob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdpzNwU3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4881F7A028A;
	Tue,  3 Mar 2026 01:30:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 01:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772519439;
	 x=1772605839; bh=DxPXR04/rHJeBIMxecQQHcQuKFbwpQhIMK3Nx/BT7Wo=; b=
	jdgJnwobZhactwnuP+BfOPVJdlAyeGj3Pza2l9B8/BejiVX+JDJnYmpC+5uHGcAq
	uUNFnW2pwp7LbTr6PORnCKJ1dbEqMJKNZuUI7RxnHK55lb92r8LhahWI/l3aG18p
	3JehalTqK6HI6EuNfvPwnNqFFvNl0dJoMgQPUUYKgV2+JXbtoykiao4Ng4kezr82
	gYSg4Z9J9PEs9vbAxxj9RtwpcNSS6twSXsG+pzhFETB/zA1ge/aJudm58yq1V7aZ
	0sYe1MhxpLKKb9yjRy1wQSihkPTjAHDDri/kbjqY6Zr2VPMYLvfygXvQnqEIMgm3
	ysx+aa8lZUD/WPFn1BPBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772519439; x=
	1772605839; bh=DxPXR04/rHJeBIMxecQQHcQuKFbwpQhIMK3Nx/BT7Wo=; b=E
	dpzNwU3lu44bvnr0JOSeo5R2bYpDURhjURN9l+gH0EABt6t0kCtU34vyT0OH/x3w
	iT2M1VWx7jrOVJkxuZiylWZ+kKOQ+9Jbj5isWD2sqQzjyPe7Qt3QbATj7Ee4hFpU
	zq8mROeIbnV9XCUh6VivMq7fiTpAFe6hTYVncU/M0IoGXAlz1eibRmA7cGaJkMgo
	INjULF+hjAuMwjyy0j8OdHpjOSxkrUZHcah5oXuUgUkU82f9pTsCEOehgRzA4AjL
	APVMm9lk4Nr+0P4TIC+6PCXFXIVv/KgF/C96sX2JcZ+3KkIgnAeG2Y+fmGthR6OY
	eedSDaDIuFxmRWtGwNCZg==
X-ME-Sender: <xms:DoCmaWmVrlM6FcC0N1FAOfhHJHhrQSSUAozaUN9aCOAX9YMS3MDRYQ>
    <xme:DoCmaQH4K0X3FfUSM6W6b7P6G1ZpBOpXPxwMgfKW-Dn8HELd4KBcB4bK5zITEHFoc
    pkDBm9zSuW4euXhJhWf1LhUWZmedSvxHyE4VosnmSXrYkjYBbizuB4>
X-ME-Received: <xmr:DoCmaW5auV6oBZMYo5sDvhmYbRcl87nUqvz2Q1EGqvVfcEAwmU97zXbg5JKN84nTtDycb18xCOL2lKMpLxC7wCZensO_gcYeSJvr7oaiWNzC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekfedtudelveefveelvedufeelueduieehgfffteehkefgudduvdduffeikeejueen
    ucffohhmrghinhepvgigrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprghlrghnsegsrhgrihhthhifrghith
    gvrdguvghvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:DoCmaQnDQSyfI2zGjixfKz3dYLrm8rGR2na8TND4BEVVu7eggjhZNA>
    <xmx:DoCmaTr1Os8OKuJmDJBucRO6gr0_tx7lbOn-nW266kV9PgoITC_J2g>
    <xmx:DoCmaXvlMeSHSo7jik32X2Ww28HBdxl7JANQkFY1w8HVcXYciAN9wQ>
    <xmx:DoCmaQGTqag5GvXV2Jw53bLUwF-ave-A1s8vXsIoCVB6L6rqLcmYyA>
    <xmx:D4CmaSUpGHyYOfkz4OFzPOSg_ilDLxsiyFHAFSKJ6iZvk5gAALRneEBE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 01:30:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50b6b0ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 06:30:35 +0000 (UTC)
Date: Tue, 3 Mar 2026 07:30:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Alan Braithwaite <alan@braithwaite.dev>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Message-ID: <aaaACBJVAZPypVtn@pks.im>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im>
 <xmqq342i12ky.fsf@gitster.g>
 <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>

On Mon, Mar 02, 2026 at 01:36:40PM -0800, Alan Braithwaite wrote:
> Peff wrote:
> > We actually can do blob:limit filters with bitmaps. See
> > 84243da129 (pack-bitmap: implement BLOB_LIMIT filtering,
> > 2020-02-14).
> 
> Good to know. I'm not positive, but my understanding is that
> this patch only touches client code, and the server sees an
> identical request to what `git clone --filter=blob:limit=1m`
> already sends today. If that's correct, anyone can already
> impose that cost — this patch just makes it easier to opt in.

Ah, right, that's something I forgot. I've seen too many performance
issues recently with blob:limit fetches, so I jumped the gun.

> Junio wrote:
> > As to this extra variable, it can already be done with
> > existing remote.*.partialCloneFilter, it seems, so I do not
> > know why we want to add it.
> 
> I may not understand the config as well as you do, but my
> reading is that remote.*.partialCloneFilter requires a specific
> remote name and only takes effect on subsequent fetches from an
> already-registered promisor remote — not the initial clone. You
> would also need remote.origin.promisor=true set globally, which
> seems odd. If I'm understanding correctly, there is currently
> no way to say "all new clones should use a blob size filter"
> via config alone. But please correct me if I'm wrong.

No, you're right about this one, and I think this is a sensible thing to
want. But what I'd like to see is a bit more nuance, I guess:

  - It should be possible to specify the configuration per URL. If you
    know that git.example.com knows object filters you may want to turn
    them on for that domain specifically. So the mechanism would work
    similar to "url.<base>.insteadOf" or "http.<url>.*" settings.

  - The infrastructure shouldn't cast any specific filter into stone.
    Instead, it should be possible to specify a default filter.

I'd assume that these settings should only impact the initial clone to
use a default filter in case the cloned URL matches the configured URL.
For existing repositories it shouldn't have any impact, as we should
continue to respect the ".git/config" there when it comes to promisors
and filters.

> Separately — is my understanding correct that partial clone
> with blob:limit works today without server-side changes,
> assuming uploadpack.allowFilter is enabled? If so, I'm happy
> to maintain this as a local client patch for my own workflow.

Yes, blob:limit filters are supported by many forges nowadays.

Patrick
