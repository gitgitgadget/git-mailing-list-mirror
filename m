Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722461DBB2E
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161944; cv=none; b=mpeX0K5ngWL7M2ZuAUiMBs6muyPu31D9cHp3zfvhDRkIdGg6NsAraaAHGFDsL6Po7Mac3ds6MnMtwzKxlibirJqZ9IGWIpqRzZhE+5uATwVwiocOIbeDSET5BA59o6pLKtVjBdpL4A+Lg5WqPjNZ7KJwzlNDKdaJRorxD2yTAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161944; c=relaxed/simple;
	bh=ol01gXKE55zH2JtddlXkI1p4czlczAKzCnrq+w4iaR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkt7GFsxDt6XWjk+JZ8egv7UwTmgJePSj6OmiOLLYmRlipsO4MhipWpFkDRRHtNNGd7grmAuVnL7HN/6iCNr05kVn+st+2YhEqGgz1JWoLIpFC23kZUDAcjTPkwQszLuf8b7gPk6Ukg2wvGNCPhaGKGNDuMhQluddWpNbwIVlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cs1Y6iAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ju1/kkMc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cs1Y6iAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ju1/kkMc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C7E513800D3;
	Mon,  6 Jan 2025 06:12:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 06:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736161941; x=1736248341; bh=MO1G9jeJxf
	YOE8GOBhR4dY+sV5VrwO9PeK/6dVpj9xA=; b=cs1Y6iABvo6iGb3BzZRep2hb+T
	B4R4p1f9DU5w53fQ/ijc7mI9x3NTFpsL+WHKTIbuYfdME7ePBpocZpbTasU899aB
	WRnFyZNt22QLqj5dQyXBMYWY8rkGPZvlSGE7wTJLp8yQkr8RmAW14dXUnIDLWDLe
	m0yTnSaDOd0JrON/6r/OU/Dbh8yB2ej+vtBJzeZWpCDdXYr4YSGO5iK7Ul+BFTy2
	yi5n2nuqC0o66tOz5BuUv5rnUoPeTWeWpI0xhlTR/zsVZJsXFvPMTtqXWuKBxFzC
	py/OEPXgQ0HrBnj+v1cqekspJz7xn4O5fUXqeBxhgaNAjw5cniKcVK9uUWcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736161941; x=1736248341; bh=MO1G9jeJxfYOE8GOBhR4dY+sV5VrwO9PeK/
	6dVpj9xA=; b=Ju1/kkMcDg6oqRuXLJ5FXrkZVdI0/2cLydguOABjwm9mzjO8cq5
	QNsSvior0jUREIBPo1HrmsDb82RkWoYjelF6SgMt4Lf05kiCE5FjqvVaT5cOJywX
	ZP8cag7UYfC7ZdN2Pt9r/R7C6bh64utEs+XG04MP1FPETetVNe4hBCanfIgtAiCn
	34GKxP3peaZchNAlYp2Cd8Xp16DtDwcTYK07r/iA3ab0boOWfJQDLXGUjU9La3zv
	eZA2NcTRGqzVZlyzXpMuINlteH1CQjV5c/CyeQOf0gqmnxYQNamsbHNfIYQGF8Rh
	qfV5Bvl/Nrl8wBjyZFOYh6DQuvG3fzS2YvA==
X-ME-Sender: <xms:lbp7Z3aSavsMJhJYBE7Bt72AIh8as31XsqKIgfwT1QTxo3toINMvrg>
    <xme:lbp7Z2Z8tGx0DwZmRY5Zf1vk22AoTr_xJ7GmUPoigynBsU_qFqmH6Uzwh0cT0toot
    holH2R9sV9yRIsMzg>
X-ME-Received: <xmr:lbp7Z5_zBIoUoG2B1-OdjTZNuwp0f6PNQwF5Jgq_09ZbZ_SYHvP3jg2YQ4tVACTTC2dj8hxGjUV2b-YErWAWMGBgQmWiC0O-suOvXOPI4Yl-TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhiefgvdffvd
    dtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:lbp7Z9oAdPRAg0VOmSYMOVQj-a5V9vm1C68n0fj2g090Q7WOiPvdQQ>
    <xmx:lbp7Zyr9Y19z5xXU9TUQrKx0xHRsqoAsQcf94TLDpBCY6ecFg81qFA>
    <xmx:lbp7ZzQjpcKdTbBr7RrAHuDPcDGhZIsFk_hSy6msXOC-FgVLZ1XXUA>
    <xmx:lbp7Z6pGfjz-1ZLn8sBjiQSJOUeHyMPGm8AuA6cRTkKdAFsUVz3LSQ>
    <xmx:lbp7Z53F_c8F0-xGEgB5ZOToFZnbfCgcyqHA7jWunUvyuE5Vs63i3NS2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:12:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30cf9cda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:12:19 +0000 (UTC)
Date: Mon, 6 Jan 2025 12:12:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] github: convert all Linux jobs to be containerized
Message-ID: <Z3u6kvJNlFB7obry@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im>
 <20250103185640.GA3208749@coredump.intra.peff.net>
 <20250103190659.GC3208749@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103190659.GC3208749@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 02:06:59PM -0500, Jeff King wrote:
> On Fri, Jan 03, 2025 at 01:56:40PM -0500, Jeff King wrote:
> 
> > I do wonder if it will affect run times. Presumably GitHub has made it
> > pretty fast to get things started on the bare runner image. Now we're
> > pulling docker images. That is hopefully pretty optimized and cached,
> > but it is extra work. Might be worth measuring.
> 
> Just peeking at your CI run here:
> 
>   https://github.com/git/git/actions/runs/12597967146
> 
> versus the latest run on Junio's master:
> 
>   https://github.com/git/git/actions/runs/12589300693
> 
> I see:
> 
>   job                 |  old | new
>   --------------------|------|------
>   linux-TEST-vars      11m30s 10m54s
>   linux-asan-ubsan     30m26s 31m14s
>   linux-gcc             9m47s 10m6s
>   linux-gcc-default     9m47s  9m41s
>   linux-leaks          25m50s 25m21s
>   linux-meson          10m36s 10m41s
>   linux-reftable       10m25s 10m23s
>   linux-reftable-leaks 27m18s 27m28s
>   linux-sha256          9m54s 10m31s
> 
> So it looks like any change is lost in the noise (sha256 is noticeably
> slower, but most jobs aren't, and some are even faster).

Thanks for verifying my claims!

Patrick
