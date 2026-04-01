Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891A39DBCB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051218; cv=none; b=qDPXNaxRG2pWxyzOYIsbYpLWOmM4+T9CdOane3inOsLaIXVv5vGAVqv75prM9NGcC5vdR6WISxp04T64xTe8KIcIqn8Gii2/I9mm907keRkosN5Sneolsm17yNFoN0anUSjwwUOasz7rnLrsssCuW80CNR0gRzDybznnWoHMk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051218; c=relaxed/simple;
	bh=z5Ox8nlYUobCRi9p2NR4Gi28GvdtZfJQ/V3OATvO/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4KqB+t+BtQGD+SDdmgVA6gkhcDQEEIQRYXUgY3KbYDAwSH1y+lPQC/fFUtyYY7Bd1hOr8orGiXHWqbib8Ul912IWGk2mDwBik4yKdR8EqG6NimM32EBGm9cY4sYdNsD1bcubTsc5vhu9q6RTpV6O7gNoiwOPISRO/UNGXSP80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NMRudFLE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y7NP0PGw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NMRudFLE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7NP0PGw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07ECC1400326;
	Wed,  1 Apr 2026 09:46:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 09:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775051216; x=1775137616; bh=2jtY0hhvFq
	78ATCrwnimPRDdWugtHmCGpmKfXmD/h6E=; b=NMRudFLENWNMLbwGBuCnRNWrA1
	fbYFo/OcJRFpqAZgBXZw3ogYbTKa+msvfP1atM+1gx3gUpqHJr2tkOJ6by3zL5+4
	Y6Wh/gY0lTO+FUqwdxTk0raNAhGGa46uN9ZpAiOaWSz90YVcSfTnEUb+bDugP8/6
	zi9Rs53M6RwFnfxHXDSjbVXYPM2f7k8TGyPbBmHFkwriaTNjfbIPj//sBtWr2NpD
	l/kNqtCHCY19/ynk7fLEKasp34nFQdHA91Rmd0mGz15uk0RSKRBkFYsKz6MnvkOE
	zqkQnEWCTTFiIBqDJR8N1cy/Rwl3GHOwwXG9H1oRfqdVbIveCMx1L7yZd4dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775051216; x=1775137616; bh=2jtY0hhvFq78ATCrwnimPRDdWugtHmCGpmK
	fXmD/h6E=; b=Y7NP0PGw3xBYnz5oDsBbr1JDqwtSnhvWQZaKuUZwMpZfqu4OhGg
	4E/lzj30DahP/oteX3psHms4RRs7k5Lc2YO7Nh8wUzd/8mudCq/GFIuog/idpmcX
	SiZs+3T6KSWA2wb1Rlqx0MznTrOwO/DIngaypcNH/XREjrYgM5mD7lkZ8jozqzUH
	+qErNHLxd4VZkJwsQULEOvRIHNJpcLLhHtCQf3jhoMAnXaB8uqr0/AqBkbaCQajK
	FO1VjDBIX2JIW977o86/TVYXI9zix4oEcN7x2DeWmDDz79eeSA+03VlLmanU7g4a
	HNfiO2nscDvua/m/muDVmiMdOXNWpaemJkQ==
X-ME-Sender: <xms:zyHNaStZaPT9o1_uVmYuQOMmItM3ykeEs6C98wCmaH4e4RfewHNV-Q>
    <xme:zyHNaedZXbEx30p_-cxGBcyiw3OKXuceVf_OMdgg_uL2kPFF9qdbnwKmqcwDUgybq
    OVXfIiItVDvhEc5CQGHaIGK4ykXz-UntDP3b3TUlQ6cJgQ_4UHeEw>
X-ME-Received: <xmr:zyHNaSzfYgRmPU8P_cPzLU5A6EvzUxymVBu1ufK-AWg2j5ZSxZDpqGYhJ29QAWCifzLDuIqtaaZ6ueuEA5igdgfNS2C_w-hyijHhXzpdSKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgtphhtthhopegt
    ohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zyHNacGbSnBfp3GjgXK0FYzvWB-cfFDIT5q0ZQwfa5Ja7ABMcAstjg>
    <xmx:zyHNaezs4HjYGfMc2Qx9BRJaqkaUGW41kLfsxD3yiKWgYOHgn2TIpw>
    <xmx:zyHNaVs2x-zjohHAe_dLzkpxG3DvsmST1op4Y9oEY-oyIq_oYikGgA>
    <xmx:zyHNaT36dlmmQyyXXJ-dEKl-QAysuLwezLRZhl_lv3nbZL6MQBCxWQ>
    <xmx:0CHNaWUbR_scXr5pYvHJ4nQm5I0Ca1xp0n1AGypC2gptAlzzSY8pSFsh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 09:46:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9266138b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 13:46:52 +0000 (UTC)
Date: Wed, 1 Apr 2026 15:46:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 03/12] transport-helper: drop const to fix strchr()
 warnings
Message-ID: <ac0hyTqMvHriS_yf@pks.im>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331234148.GC2328529@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331234148.GC2328529@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:41:48PM -0400, Jeff King wrote:
> We implicitly drop the const from our "key" variable when we do:
> 
>   char *p = strchr(key, ' ');
> 
> which causes compilation with some C23 versions of libc (notably recent
> glibc) to complain.
> 
> We need "p" to remain writable, since we assign NULL over the space we

You probably mean NUL, not NULL.

Patrick
