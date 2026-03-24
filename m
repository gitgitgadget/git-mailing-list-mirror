Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2D3BB9F9
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774335057; cv=none; b=GBcN2z1wXjI7MgpJgnuu2EvlBJeQX14lzGRhogDLCeuGjGRLYwH1J3KhyAoKWFvnj+00AN3sAqSoskWvB8D2S966IMYPCwwmOnAWZjr+pHqRC7rFPR2IZnae9De5R3wfxH5zWR+TsLlHosQl4rceYwpYdfKKqlB8+nNEdqbxdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774335057; c=relaxed/simple;
	bh=NIRzBqN6NtSdBUvbuoQU03DEBfX9MgNIltc4g4/v/d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwNE2nXujVOJIQT6J4cvbs8IiG/UWv33MRSRabcX7qfyN4QIBB8KBuo8Pg3QRJBU13B82m7E4/7GAVmfDdlfuCcVZ0PXjwKsbyYigMl6L4PpZshcerQWyKdoJ2Bf0mP1i6r8lf2gje0Q0GKZFAuevhYBDlRMNqp5bKlExdv7vhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZwJxWCns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8JBksAA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZwJxWCns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8JBksAA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAD2E1400174;
	Tue, 24 Mar 2026 02:50:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 02:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774335043; x=1774421443; bh=FaGXJscMd3
	tPVHqQSQU60NxD0LnXd44XTjlQiPbw3Z8=; b=ZwJxWCnscK2NpOP2QvIvMjOyfc
	HvydfMzIYEAtU3WNpKveNk5lNu5U7FiMEb+wxy7iymxXAP8qmk663EgZoEwIniK3
	01X0QPbxvfWFLOmuy2W55/P9YY4+USSBVso2v6ZhSLlxiBRbwuNwBpo9cifU+8Fh
	zfHS5F/+DVMPCbublhMT6RYz98ZeSi/81p/qf/YKbr3urdw5t+7wrQj3pKf3vFde
	pkvOJqh2l7AVo4i9CtbW9XZL/1JeNRlYbq0BD32gjC9jFL8mDeEl/7C79KXHGYd6
	/Nfje71NqBUpBzUQZzn/wxKhrereEx8WXGys3WD4ZtJ7HQKNR+bpCkaWIPQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774335043; x=1774421443; bh=FaGXJscMd3tPVHqQSQU60NxD0LnXd44XTjl
	QiPbw3Z8=; b=R8JBksAALANjsyK370TgSEEOKJPkFg3GAvI6Lr0+LxCBu22Ae+N
	skJ2yYjV12PdFUpzNB9FccGcwUXT86MasJe1hcOFp8rZfK9vRAii1ybEvXGaXzQl
	6T647RJ2hN8ouxV/sZe9SOEnBfIJjqYf7Rdb68F9FPuphl58R1WBaOD906A58G8N
	04avFo32QtI8+TmJKsjCnX2RoX234zLw8T2vSnSZ+ZSWPniZQfxQH1IEBpPnegKO
	0SFA8Oii/B0QNMb4AZfNXBtSS1VlS/7kiOeIzNEP6SA5WS+PXX1UAa4N6dDIgcVl
	1OavfbGG4WWx+7ho+0ODJCz+qz9+URfCNiw==
X-ME-Sender: <xms:QzTCadUtqCCN-9yX-gIMMYKM1CthOHqNSWnlMcWAfWsN8Y7sF52ZvA>
    <xme:QzTCaUfIURJNcwp3NYskYvJUV8XCSwuhJKbHXJkpfQpn8ZfDSgUpUDCypVxCuCHet
    x2djQWC9BXShkeJ63uLjM8LOdqpO3oPWvVmHrk-mwHPfCUlp1j6Cg>
X-ME-Received: <xmr:QzTCaRujSB1UtBdDwRKCvN58IpefMte5t5B0c8khf890SoeW0Z29fOAD_VNqm8IiZ9jvZORWzUmlvZOQ5oCQEiNW-PjTuMSHbMgP7XdoaMNS4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprgefvddtheduheefgeduieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsh
    gtohhtthesphgvrhhtuhhrsgdrohhrgh
X-ME-Proxy: <xmx:QzTCab_e_AY-e-AsHLOZ4-tsjH68QfOZyoz8upaj-7RBBnKurJVB7w>
    <xmx:QzTCaU0u9Fg9vBiOuSmDT67bW55vWUPwVx0kh_S_d_AW1NkL7EgM0A>
    <xmx:QzTCaYA-ibpi2b5JWezrGfkuukohia5CQT-NGtRRHgh0ZlfEoH1Nhw>
    <xmx:QzTCaYfkz64ytCJUSkWpx3bVX5krysGhSyzCx4UJI84mScTaj6YY8w>
    <xmx:QzTCadDO5poKB4CkWZ7CP55x4lKJREL8xv8jPnl_iBza-abvEN3860-d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 02:50:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5df294c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 06:50:40 +0000 (UTC)
Date: Tue, 24 Mar 2026 07:50:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Tian Yuchen <a3205153416@gmail.com>,
	Scott Baker <scott@perturb.org>
Subject: Re: [PATCH v2 0/8] some diff-highlight tweaks
Message-ID: <acI0PcVF2wbjvGva@pks.im>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260323060139.GA10215@coredump.intra.peff.net>
 <xmqqfr5q5wm7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr5q5wm7.fsf@gitster.g>

On Mon, Mar 23, 2026 at 09:38:56AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Here's a re-roll based on the review from Yuchen. The two changes are:
> >
> >   1. Added a missing &&-chain in patch 3 (which cascades into patch 6).
> >
> >   2. Avoid length(undef), since old perl versions will warn about it.
> >
> > Patch list and range diff below.
> 
> Everything looks as expected from watching the discussion from
> the sideline.  Looking good.
> 
> Will queue and mark the topic for 'next'.

I just read through the series and couldn't find anything wrong. That
being said, my Perl skills are severely lacking, so my assessment may
not be worth much :)

Thanks!

Patrick
