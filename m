Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD420188CC9
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523217; cv=none; b=rxz2ymj3qI1HkXK5jqTNs0Izq5rwH0prg9xrAvJ4mr2xCHgATp2BXhWAXGl4VnaDG2I/kmg0MO5jWUrIOA1iI+Jg/im576OIKR6pa//KdD5JKZzag8Sx/c9tKRClZnMMBHH7ReHkjokE76gnCakl6RwsZ6P/30lHS8H0Bmn4MhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523217; c=relaxed/simple;
	bh=vlBMh5p72ti2GhD0ZxUL/8hi8GQM88QoSZCHmz+gnu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIgDTv9QV0rXIcBOJKT1T3/52LYeFSuhhh+pwmCOYqcyRfrbKiTNoy/ji9f23HnTOefMFC4LidzKCcqa+y4DPs4vxxC19xLHBoXOy11RLXEWRaxA6kF4B/YDN7VWyX5nw4jnd0gJY5lovqhcTfjYIAsPwVfpx+7kghJKCO1kBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y43R05Vb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFaYd7q0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y43R05Vb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFaYd7q0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C398A2540071;
	Mon, 25 Nov 2024 03:26:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 03:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732523214; x=1732609614; bh=CjYlWFQizx
	rMDrv+k2KLQbB8kt/KMYkS56qdGx5wkUU=; b=y43R05Vbn8BQulxTTZ9LVnf5+H
	JUbclYsikpG2yJDbEbVbl0zzMJ3/fIhWD5ksHYVKK4Rh82o4yTmTwxRm8/GWOrAt
	uCriRnUoOVZbNa2EPCjd5mvj7C2mQMdQF8yDMaUFRuM51la852XJ1o8XevWRDOho
	wSYhs3nDRDB6z8ELYsOvL22MwmnjD3K5jblbsXl0DRpVwUk7FIm3ns94xC7LHllT
	wpw5VZwt69LNaXs+FOksE7UsOtgCAYHQ03CTVva8Kt2kSDg+6ldPShVsj8g14vTt
	Pab7dY0q7EbrzWh+QvWUwcoxhHG6caspH8MYw384pNH9SnscDz0JgEGeiA3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732523214; x=1732609614; bh=CjYlWFQizxrMDrv+k2KLQbB8kt/KMYkS56q
	dGx5wkUU=; b=lFaYd7q0aU0ru6clVHTcQxkyAOx0UQmrRqX3ltnLtaX6fOKwnxO
	K1QIvJ0nIDAzHBtEhmpi2+6WueTYKBlZmI7NNdO0UkFTnFZvUfX+EZeRhDgaoKyG
	/py6xER70lLzYjDoyPakUiSqGBnqjAq43scePEk+M4A+9bpDRlTsCCyze9zhnz4C
	HkXIiOX2OI95Je4x+s8BXjr4oDJkeEvKGK4EBnzqRr3MeT6pcyHCVZcPlfkM6nXm
	dE0vR4oU9t34e9LbkKuOsA8pvWfUAzpsHyRjp1A3J+FJsoEI0NBht+uMhiAEstE2
	rLcaQO6K4LAoHcb7+jCDFA3GhsgN3xg7lWw==
X-ME-Sender: <xms:zjREZ1q5H4wW8g56Mz2O5DfosPVyb-yyc8GwD5_JB6ghe-8W9D2vjg>
    <xme:zjREZ3rj9lzzzcRGyPvNdCn9zdVMWrwuF6VplAXc3uqV8hoBkKWMKEieE6RVnKawy
    gF-K8R2vCSEy0DVDA>
X-ME-Received: <xmr:zjREZyPPVt1wx-k6HgSrA00Fm97E-Qy3JhOfI_76s7tOmPBVQCTIUR5mLumgwCKN36WrgYtpoxmZRGltr5pbxf8rVGe7WLnOZgGVzNn-4uMOSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehlrghrrhihsegvlhguvghrqdhgohgushdrohhrghdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zjREZw4QN88IU5mCSXqtDqC5Sg3Gt7QDbMHsLit8O8XN2xkr8CwVzQ>
    <xmx:zjREZ04uCuAchpQFUVvZit7fxBaPVmNj_pMFCN1w-S33gntQMrK60Q>
    <xmx:zjREZ4hnvl5IC_F77C7VBCoFL80EwGnbgXcNm_w33sH71c-9zrb4uA>
    <xmx:zjREZ27WEzzHKQOopTMsrWeTb6g5Xeu7qD5C9lLrRPatunyZ3FGtjw>
    <xmx:zjREZ-TjPPN8PYNM5eslTijXuafF1ktnxsb6zSM5ntAsVcz2O7YEd0no>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:26:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe839633 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 08:25:52 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:26:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>, git@vger.kernel.org,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH 2/2] transport: don't ignore git-receive-pack(1) exit
 code on atomic push
Message-ID: <Z0Q0wfSTk_cUXH0F@pks.im>
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
 <20241113-pks-push-atomic-respect-exit-code-v1-2-7965f01e7f4e@pks.im>
 <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
 <xmqqsert5qx7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsert5qx7.fsf@gitster.g>

On Fri, Nov 15, 2024 at 08:36:20AM +0900, Junio C Hamano wrote:
> Jiang Xin <worldhello.net@gmail.com> writes:
> 
> > If we want to print "Done" in porcelain mode when there are no
> > errors. (In dry run mode, ref-update-errors should not be
> > considered as errors, but the opposite should be regarded as errors).
> 
> Hmph, should we allow dry-run to deliberately behave differently
> from the for-real execution?  Wouldn't it discard the primary value
> of dry-run, to see if it is likely that an operation will succeed
> (or fail)?

I agree, I don't think that this is a good idea. "--dry-run" should
behave as close as possible to the same command executed without that
flag, the only change should be that the underlying operation is not
actually applied in the end. But other than that both the output and the
return values should ideally match exactly so that the user can actually
tell what would happen.

Patrick
