Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998021D3D9
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682735; cv=none; b=bnOimQzktwoBlsmpd3lan5iuTzvPS698efl1oOewELnKlC/ezXCf8WcARJN8wCTLTY+csQnwSPpWwslz54ST8lIv7FV9wGPfYFkIFvpc+WeAfbOjgFqoDH8wM0jtTgbBoO6McjfXn/SSMdjy0L3t5bl/9UMxiIkTNSCHUf3ueTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682735; c=relaxed/simple;
	bh=FbSBAVe2fcBK2v+1f3NEx5g/1oncF/uWgdLUPA1bfEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szc1luxDqrx2FEDGMdSkafUe1G7cXBv6hY6Sbvscfdh2xUafhIRL4dinCsrThzqdv822NBZu10CDQY5nhr2DlUt0h+fFP7izqDuL+KHUkaggdQcDWVQWMqH+xLJtO5+DFt8StyweNXj9qaF5dS+ine4KPu9n+IytKnsytL2HyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YTrE9qTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FwAvmqTy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YTrE9qTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FwAvmqTy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C69B7A012E;
	Mon, 28 Jul 2025 02:05:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 28 Jul 2025 02:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753682731; x=1753769131; bh=12grglAW99
	J+fz7RXzo6FKcLv3a2qTLBN+Rcghovzig=; b=YTrE9qTpFilHR9JnYNKxgeZZFY
	EdXV/ins5Rm5eOgPvN5WKoebhsdaZOtt0zimLYHPJbTBToyqArpm8svpuDoBX98l
	2g3+oDWccbirw4CYSIVGRoDinGhLcKm5cuDmWOGEet39e2GzulXXCbU2rqeNvjVK
	57ldjpftb5mXHcxSI+Zavh4ycSPbvwdIXD3i7FighltaNKbFUEdTzFyzuY+/0n70
	m0h3UoKovTh6pRnO5YbIj3kXjsstsRe1BARyuvBStYbs2roUdL6/G+KQaJ05sdyf
	RikMeeEayoUVJXZb1hAiXBvFX45Cj0vnj7ZaFni8AI0Q6ipMPveHykrdfxkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753682731; x=1753769131; bh=12grglAW99J+fz7RXzo6FKcLv3a2qTLBN+R
	cghovzig=; b=FwAvmqTykZd+qG3rj+qVWge4/5yGuy9Xulpn1ZdkVHQWg+yAm1F
	+9TG/AXQKW9EY5vGJMgpau1LFmxgX4aIJNyJcx6MJ1y2uhIQhDM/pLjH7kWaweCt
	vKYvOOFma9ruEEGk/AR+cp+P5lifD8ulHjhQDvQNe3NOmnUaLTKbmJKcSE64C3K4
	7p55YzqCGFmnDRuP3swS2SaenQgpSBMuROhKELrS9NPKEqG1ml9UH5P0WlFWGT1H
	t/djAGppSIkTsV6vq29H0Gq3CSzeB1DtqXpPeCx45SXfavspDgCK6Hb9mCcNDJ8/
	4chnIB7LFYRuMh389JjBs3Z2ceVik+Tx3mQ==
X-ME-Sender: <xms:KxOHaNtTtXoQ0N4vqYhUFFzrFs4o3XbDDyiBLXJTWw8CAv6yfkZg-A>
    <xme:KxOHaJt-7ZRtt9NaEt6Drp0Aav43BmydAgSbFGsH2jhqORtP2GhrSFJyOqGSNYFgl
    LiUBy27fURzgQ_zmg>
X-ME-Received: <xmr:KxOHaKOtjNISe4HQQvM959wSlTVZtpbQX4jn-2WJBR3FyfAWlUE6KESh06j1IRdBsQBXWxPR_ZFkUS00ZVd24s-EFW4DfsT6botu4rkB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KxOHaP3bi-A-YiFwARkDeVus1FY5HYLbXVBlbpUuRjiaYpcykKeZxg>
    <xmx:KxOHaON5_4AjxBVTBQULlxiX8eTtN4TIhcgXJ-7TwM3lhbdxBX-kag>
    <xmx:KxOHaH3hXxmcYQm_dgUMruqsyjfixI3fzadzflbZ4GRHnjY7px6UfA>
    <xmx:KxOHaNEQ1JqnyIv32OTh2Ydwup1Km_TXmGckKTvD-Xf6lQkhd3tgTQ>
    <xmx:KxOHaKVgcuUZqdF94GH5h-AuKNXhk3S4OEw6i6zlEpjupJQHi43x2Zj0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 02:05:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58e322ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 06:05:30 +0000 (UTC)
Date: Mon, 28 Jul 2025 08:05:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <aIcTJilNAGvfroV-@pks.im>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
 <aIIf7S5iPspktxdw@pks.im>
 <aIIvHxR8wXLTCgMW@pks.im>
 <20250725110243.GA3014187@coredump.intra.peff.net>
 <20250725111308.GC3014187@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725111308.GC3014187@coredump.intra.peff.net>

On Fri, Jul 25, 2025 at 07:13:08AM -0400, Jeff King wrote:
> On Fri, Jul 25, 2025 at 07:02:43AM -0400, Jeff King wrote:
> 
> > On Thu, Jul 24, 2025 at 03:03:27PM +0200, Patrick Steinhardt wrote:
> > 
> > > I've quickly hacked something together now, see the work-in-progress
> > > patch below. The patch does not yet handle reflogs, but that isn't too
> > > hard to implement.
> > > 
> > > And these changes indeed speed up things by quite a lot: instead of
> > > hours it now takes 7 seconds :) I'll polish this patch series and will
> > > likely send it in tomorrow.
> > 
> > Cool. I agree with all of the pain points you outlined, and the general
> > direction. There was one other sub-optimal thing I noticed, which was...
> 
> Oh, and I meant to say: I am very happy if you want to pick up this bug
> and fix it. In the original I mentioned also that the new
> remote.*.followRemoteHEAD=create logic was kicking in for an unborn
> branch. And I've verified that this is the case and am working on a fix.
> But I think the two are orthogonal and we can fix them independently.

I actually missed this one, so I'm happy to leave it to you. Thanks!

Patrick
