Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D91A2630
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990889; cv=none; b=SpPR78x1+8TP7YRTLNHL/Clx8k9lXMyi6T04A8hA5o8fEru99H2uYFvdBJg93nM+eMnLaiyTlonWch1U5p+gN3Okpu0HclNAEfhCOoPb3Hg7SoC+xYKMRbabs1aQ3WaqoB/nSOp3MMvyqXWPga0PA9xAqRwpWmJd4xgcRJKMWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990889; c=relaxed/simple;
	bh=2d4j25pa9tvfRDUJGbv8sz43RbWa5vojCALu+BdUiV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeOOPT6iRZ07VJywnMVDvX6tbhPlBpzv8epwnXFzeIqlfZO7/cZrQe3zZBRedbm4PGP54MnB1sT38vEvr7ycyn0MU+C5i7BxdhltHja9reZqtiM4JdiuusH6QlpmXN2+h4p+1c/zduXTeSBsVB5l8QAJecA3iTZja4iiyrSB1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RnUsKp7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fT6BsBCZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RnUsKp7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fT6BsBCZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2071140016F;
	Tue, 12 Aug 2025 05:28:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 05:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754990886; x=1755077286; bh=dir8bxbnvm
	nC3aAHFpoItL/uRWurdCtx4d8X4ilYKTc=; b=RnUsKp7ds1xj4KBTvTyeolqIEh
	S6COwfr9C8yWWYIlTZdu9naZBVG/3/WF0Izf0gcWrJEmwrS/DU9VPm/jZASNAcfj
	wNKWP7hjjXZsZNwR/+xcUzsuvLsgYs0txjSBnRAVClwigUQZnOUwAsAp1Am+Hs8r
	759B+EEfw6/AnOfo7MVS2ekmB5m1ibEZeTy3nUkjlqkm5w6v2bNy/cLzEuHb6ILk
	bTa+3M2SC907aXAHgQpG4N3Sk6a4ZJd2nJuPx8nTsPxWoBiWiA3pp+PptY4RR3Pv
	0bBcW5XVsgJCAi+dPWbUME3KeLCi38glW6WnyyeP5jc8vWTu75BBxYhXDZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754990886; x=1755077286; bh=dir8bxbnvmnC3aAHFpoItL/uRWurdCtx4d8
	X4ilYKTc=; b=fT6BsBCZ53GF9aBTey6ozPZX1i8ZgK2w4Pd/K8cx9KvIGZ4Ey2u
	lF0wiSq8vTJFvACt81ZdUbwSAN+qLVo0Kj5arPjGiJYc1LZiLPvz+mGD5b0CyvMu
	bA/nb4gUW+pJ9f4gFM6nGZTQhAVBWI4RHLEeSPg13qnUxpvJo/gEF6Ip6UHUribF
	NU/KyT1d2ZKGdW7LX3Y9Sf57o3BaoZBsCD+H2g5rIuR2IFNsz27mrhrdpt5/IgRp
	ekAsxpPo+n4sEiAHSKfUutj7sQ4K2oF4cxkOPBPrc/wBnyZyIcm1KfquFDdic+tC
	DAutTKx0KVtlylLO+0+XZRaCsdIFdBVHHUg==
X-ME-Sender: <xms:JgmbaF4VF1s73aDUK6ud4DYBfhXMOp-b0Hj3QI6L_XO-xkCBlD-1DA>
    <xme:JgmbaGKVLPEyiP9GalyJ0KVLd6dIF8BZv_WlkseFI7vBEqTOSfC8_EYjrLaZ90XJj
    P9z7C__RzGw7Co9_g>
X-ME-Received: <xmr:JgmbaF4qVFm6C0nrOc11iHigC1Sjak6sOxkB4wCNIlYhiREVQYLB7MlFklqKkMwcTmt8x9Md7sVe39aqhJsfImVKeNs5xhZZYM7GtRg1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JgmbaJz576N3f2wBF57SIs1bJGKd3khvX6s1DgrLxbJlqpNYzDYmVQ>
    <xmx:JgmbaJbw0NX9-PDRsw1PC8DxfG_z1GZBs41F6Di_JapAHnCQk-_9Fg>
    <xmx:JgmbaLQ9OA4WjCvn0rSdkZ7QwcJg6IqWvJdhsV8L2xtK8WL_KhE5NQ>
    <xmx:JgmbaDy-gPLWYWfJt7f2APHiO9Af1Fq8m90IbJKw6IQ-yIQY-MSPkw>
    <xmx:JgmbaH2NEtz4uV1eDUUqBBvmsszlxK39m9DPV2sHIHCljE526OgBOXG1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:28:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6fb813ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:28:04 +0000 (UTC)
Date: Tue, 12 Aug 2025 11:28:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 6/6] reftable/stack: handle outdated stacks when
 compacting
Message-ID: <aJsJIjzOnfNiD6km@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
 <20250804-pks-reftable-fixes-for-libgit2-v2-6-fef06209a984@pks.im>
 <3vkwdsqcas22um2djaic43ntapedwz4wqnrrnhvhngqdul2vmj@2rwfqngzyuup>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3vkwdsqcas22um2djaic43ntapedwz4wqnrrnhvhngqdul2vmj@2rwfqngzyuup>

On Mon, Aug 11, 2025 at 03:04:05PM -0500, Justin Tobler wrote:
> On 25/08/04 11:40AM, Patrick Steinhardt wrote:
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index f77d7f58e8..effa2fc8cb 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1215,9 +1220,24 @@ static int stack_compact_range(struct reftable_stack *st,
> >  		goto done;
> >  	}
> >  
> > +	/*
> > +	 * Check whether the stack is up-to-date. We unfortunately cannot
> > +	 * handle the situation gracefully in case it's _not_ up-to-date
> > +	 * because the range of tables that the user has requested us to
> > +	 * compact may have been changed. So instead we abort.
> > +	 *
> > +	 * We could in theory improve the situation by having the caller not
> > +	 * pass in a range, but instead the list of tables to compact. If so,
> > +	 * we could check that relevant tables still exist. But for now it's
> > +	 * good enough to just abort.
> > +	 */
> >  	err = stack_uptodate(st);
> > -	if (err)
> > +	if (err < 0)
> >  		goto done;
> > +	if (err > 0) {
> > +		err = REFTABLE_OUTDATED_ERROR;
> > +		goto done;
> > +	}
> 
> I was thinking that maybe `stack_uptodate()` could maybe handle
> returning the `REFTABLE_OUTDATED_ERROR` directly so we could avoid
> having to map the error here. This could require callers to check for
> `err == REFTABLE_OUTDATED_ERROR` instead of `err > 0`. Probably not a
> big deal either way though.

We probably could, but I don't see a strong-enough reason to do so now.

Patrick
