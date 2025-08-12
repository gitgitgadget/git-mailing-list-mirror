Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE52E9726
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990881; cv=none; b=JpnQaCHbRfT8o76wxkWnUmAQxQ67k4W/CJ8pBBw3gMCtlbkkUHo5gF4WGPauoxQhD51MrJQ4xbr3TF3Oz2Xd+uZj3OWb1qyY5GUKQpKd4NoeOphQLrES/D9wTrwbnnbbphgorgQITKfx/L5eFkrYa1pjTQc0MmcYt7ozetOf1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990881; c=relaxed/simple;
	bh=SEC5dZYbA7g2RjB1fbvBLqqAI56fOvhl+fcaO01WQYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmA2GZp2jyLtPb0k0VpJpEpZBgceGsSuCN53khra/8mr7HBpLOyH7eO5qhRK66MhqnBjUHIhdgkhI3YMbt07p9Gy88tfs2dPfpN3GUvo+nT0jd303tptAHOwuvOnROdmvC2L4ZPNldNllPtr1JX5AjeUGU2jYkMVgZor4TV5UrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d+w8dP77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klewi5GP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d+w8dP77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klewi5GP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E900014001C7;
	Tue, 12 Aug 2025 05:27:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 05:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754990878; x=1755077278; bh=fXdqFm5PGR
	j3aGBgqUOkOyNd+WlDS7vbNP9kQ3G5jWo=; b=d+w8dP77onJRWvVz1ZrTOSosK7
	wlbcCmctOgrmN4EkZtqJIPql7xOqael9Jv/Xuj71nTZ8xCiFBRqxZHlEU9fdOAsK
	Ok7a2/sNtgmtpzGmWk8FweZl6XoVEaSn2NBvxK4WW6jh6ISVJGTaxCqq0cEbv2pI
	rELgcCpkCjBMydwoPDN4rwqQ/OPgFlsyfYYXIefJN77PEOzP/1GDUI6jnaAsFlPJ
	C5z4OBN8AGLBykOZmUtVGBaZRVxpL3zvWzJSaEdiwyFJdZ5OTt+RKs6aDcIjIP/Q
	8CNP94NPclJv0wydnLbU/74FPAIXjqZQQpcoMIAiJG32iZgw9KrmAcIZdIhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754990878; x=1755077278; bh=fXdqFm5PGRj3aGBgqUOkOyNd+WlDS7vbNP9
	kQ3G5jWo=; b=klewi5GPUG/AMiOjBUHtxxnKR/C9GfzbJ334NGe1S7DI5w2/n5X
	F0ZWCKjI288Zijrwo7bSIGegofL71GMFoKax6D96VO46ifNIw0Q2P3Q6M/D6o3Pj
	sh0DpCz9+c9nVvqdRm9yWSVtkSaUstI5qhRR4nTtIkpcG5RadRX3PzYyy5Z9Q6MJ
	83VolE378NcZNQPm17iZ6IBA/nihbpKeb9XeuovxFGvrOWt09y6ewj5atT5zTd0l
	IECKZGDhABFnS5R6WdyO9+ahBimv7DTYNzlVnhdE9nS0nVeP8DyI3ait9acY79yf
	3k9d12Y/waZSAAbwNbf96vJuWC3TDpWYb1g==
X-ME-Sender: <xms:HgmbaAZoREYRROo7TmYr31HDLprVw9wKEumpWUk7HJv1dFJqydMxfg>
    <xme:HgmbaOq2m66YRqnwDZkBBctWF7uoBOHVBIrnPCbwWphyZOzWc_f2grNrMDMp9rJu4
    DRuTKlCGVq-emRHnw>
X-ME-Received: <xmr:HgmbaEahJbN3CC5YQyRbSjrSfNPfaEcOhp9b86HwUbBboamh64orGznVe4nxxNIcBw9ocVV8LxcQA7cObH479cNQuDFZAgExG6vyC5Lt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhm
X-ME-Proxy: <xmx:HgmbaGQK1OB_bmxIol6rKk-rVx2nc6bnKQMSYsxQgxDMe22_kuq4vQ>
    <xmx:HgmbaL7FX5IdqGj7ZFBG6A9VYbVvz23pZRZYSP8Xxf55tTe3S4Rc0g>
    <xmx:HgmbaLzvatt0wpS7fD5W2okWWOP6EG6qofyvT1tPUZLmTkASGfPP7w>
    <xmx:HgmbaKS7aeyM7DhbtnWaHeuFcDfonXP7RODPzeZPaA4Y-BVHFkYRSw>
    <xmx:HgmbaPQzWBX4aSB4UIxAVK23HLRiIMEAU5CoqmVH4pwGIMWRZHtPgQg0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:27:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28744426 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:27:57 +0000 (UTC)
Date: Tue, 12 Aug 2025 11:27:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 5/6] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Message-ID: <aJsJGgw-XdeYZ_xZ@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
 <20250804-pks-reftable-fixes-for-libgit2-v2-5-fef06209a984@pks.im>
 <6gcuu35ey34nrxtsgpelfykvgxo7vqqhgsq3obnbducmplaymv@blgaxqyp6low>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6gcuu35ey34nrxtsgpelfykvgxo7vqqhgsq3obnbducmplaymv@blgaxqyp6low>

On Mon, Aug 11, 2025 at 02:34:49PM -0500, Justin Tobler wrote:
> On 25/08/04 11:40AM, Patrick Steinhardt wrote:
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index d6e4ea93a37..f77d7f58e8e 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -737,10 +737,10 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
> >  static int stack_try_add(struct reftable_stack *st,
> >  			 int (*write_table)(struct reftable_writer *wr,
> >  					    void *arg),
> > -			 void *arg)
> > +			 void *arg, unsigned flags)
> >  {
> >  	struct reftable_addition add = REFTABLE_ADDITION_INIT;
> > -	int err = reftable_stack_init_addition(&add, st, 0);
> > +	int err = reftable_stack_init_addition(&add, st, flags);
> 
> Ok, so now if the `REFTABLE_STACK_NEW_ADDITION_RELOAD` flag is provided,
> reftable_stack_init_addition() will attempt to reload the stack if it is
> outdated before locking the stack. I assume Git itself hasn't needed
> this because it just uses reftable_stack_new_addition() directly when
> neccessary.

Not in all code paths, and arguably Git should pass the flag in those
code paths that don't yet. We already perform all verification under the
lock anyway, so this would be the right thing to do.

In this patch series I wanted to focus on improvements to the library
for now, not to the backend. But honestly, there isn't really a good
reason to not already fix this while we're working on this.

Patrick
