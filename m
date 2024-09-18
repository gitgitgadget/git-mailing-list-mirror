Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DF177999
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652355; cv=none; b=PZxt0XezW0yNCwPGfe/HjoPNQeBWYoCYopWX1LxREzBUblwwV3P9S1OW0cazhun0aWXw0tbflmY7TUfAqmoyMKR2uC76KCYs5SlMPGN9qMm9CRK+NdW8tlUskAbdY+QGx0dl7/Bo33jzHo5K0DacceOd6+xM4TR/CnzeCUnmZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652355; c=relaxed/simple;
	bh=FT1jXzvcLFv1z64eOLbKu6/uNL4K+bMp95eGDaRX9T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPmGRwLuInQSUHjb4vqsG42yK7YRXJ5fMKcRbJMkudu1xCFFQZvdqZUDUynZPCqXEqsh8gSxuzHmWs64u0LCXDxncBbmUsTqwXD6CmlxA/E0lwe6rQRZNXTpKmMcPZbwXc4Bgt2yyKOmXbxXLLPpj18pu6DCeO3jp4GIlfkwv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nCQyTEfC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MU9wAo2P; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nCQyTEfC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MU9wAo2P"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DC541380289;
	Wed, 18 Sep 2024 05:39:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 05:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726652352; x=1726738752; bh=L9VYnPtDDd
	XJyfYJf9rr6uGSOqF3lxCK+ywijcDWA+g=; b=nCQyTEfCtuRPe+ZHkjVialmM29
	5k81P+3zV0F1bI0GD4PIP126/GbkOBeCuUA3F08MT6Wc3QcvlUXpjKTPUY+sUYYK
	gdkujpG8ZhaapL46rlC/tr7v1zsxNSfy1A5KsUiAvhVCKCwXvR3ahH16PIb79yBq
	Rtj/SQhpVGdTqyBmom/2u+wXHdcR52SiU1LMUiNtgc8s/1UXOY6j6VrAfEU2HNzu
	758vrJzi/YArcqxubcHMNVmKTjW9jZEUJp7+SxyL3R/vRb8Y3jUhMESAvOqSrFoa
	My/meKbnLDDOvTsWWesgfwDSIlcwKGnrfSUG7lB3t30SrZAYAikd9L606RkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726652352; x=1726738752; bh=L9VYnPtDDdXJyfYJf9rr6uGSOqF3
	lxCK+ywijcDWA+g=; b=MU9wAo2PuDYpBYG9GWq5Ayl/UNPHxlDm0FkzD7BEcTuI
	HFzs4fohyvXGK2+0lmwLHEeirqxA0xgksMF8Xd10XOmIilEHSr17+TfZbqaBn6qA
	7NUOom8iVQRnPGuME5mOMvSJHORiEhPZJBWPUc2Ity+nDbW0WbNIgIndP2H1aQZB
	wuhVxGpHEenbii/zrvyAUNqqddkSVUvRZuUIpyaE7ZthXXoLLDRNjjtfh1FtEggG
	vsc9msgaR1Dk5sif0DJOkwC57BF64DKghq4QaiTrkGJYEu5T3NvjSIKJnuH0rot2
	HMXk33P+M8z0xpPh8VeJ7Y/V6qXoEmlTf3Lc3Y+n6A==
X-ME-Sender: <xms:wJ_qZgYs3Zum1ZHmZFAVT0fHGf51M9GB-WCijz9-oQLFT9njFeigDw>
    <xme:wJ_qZrY-NyTT0clLErhmuYlCX7SUHldMuteEZnbqelh8mXj50b9EeUwf3pclwOurG
    zefNOIR8-yNkdJ3lw>
X-ME-Received: <xmr:wJ_qZq-PBamjACpOtn3zyyip9hbSvPZQoXCyOlYHa_-gu_cl5MSp-ae30pba2C47mezyBR89wVGWfBAGnpZY3zpYWf4gms5RjI0LC_pVqot1SZIP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wJ_qZqrTrHKhgdUEX2ylbi48uzyzfO5ZInkNYonrpUaZma2W0pGtBQ>
    <xmx:wJ_qZrqfvOICevVPeL2zBl1-i_BXP-OLSbTJCmS0GYz5r8r8ZCaR9A>
    <xmx:wJ_qZoS6Lw5AMCskp8m1IK3CR1nWbpXHVps9wwgoKGAmeiPKYEANUA>
    <xmx:wJ_qZrqTMsiS3X4ibm06h_0lzPi1B1R0bs85Lhkps9p8hjBTg0Z2FA>
    <xmx:wJ_qZskfGW0tuS1Abe2wI3cuLKNxPH4xGc5749m12lY2CWP6e1ZYsvhI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:39:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 319f1e0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 09:38:50 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:39:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] reftable/stack: allow locking of outdated stacks
Message-ID: <Zuqfvp_vaALkuERP@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
 <f4be0966e17600602b1057a6ae219711994df128.1726633812.git.ps@pks.im>
 <D49AWUZ2NCNC.11D23I38TRE0B@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D49AWUZ2NCNC.11D23I38TRE0B@jamesliu.io>

On Wed, Sep 18, 2024 at 07:26:49PM +1000, James Liu wrote:
> I just want to check my understanding of this test, since I think it's
> the first time I've reviewed anything using this test harness:
> 
> On Wed Sep 18, 2024 at 2:32 PM AEST, Patrick Steinhardt wrote:
> > diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> > index d62a9c1bed5..a37cc698d87 100644
> > --- a/t/unit-tests/t-reftable-stack.c
> > +++ b/t/unit-tests/t-reftable-stack.c
> > @@ -271,7 +271,7 @@ static void t_reftable_stack_transaction_api(void)
> >  
> >  	reftable_addition_destroy(add);
> >  
> > -	err = reftable_stack_new_addition(&add, st);
> > +	err = reftable_stack_new_addition(&add, st, 0);
> >  	check(!err);
> >  
> >  	err = reftable_addition_add(add, write_test_ref, &ref);
> > @@ -292,6 +292,68 @@ static void t_reftable_stack_transaction_api(void)
> >  	clear_dir(dir);
> >  }
> >  
> > +static void t_reftable_stack_transaction_with_reload(void)
> > +{
> > +	char *dir = get_tmp_dir(__LINE__);
> > +	struct reftable_stack *st1 = NULL, *st2 = NULL;
> > +	int err;
> > +	struct reftable_addition *add = NULL;
> > +	struct reftable_ref_record refs[2] = {
> > +		{
> > +			.refname = (char *) "refs/heads/a",
> > +			.update_index = 1,
> > +			.value_type = REFTABLE_REF_VAL1,
> > +			.value.val1 = { '1' },
> > +		},
> > +		{
> > +			.refname = (char *) "refs/heads/b",
> > +			.update_index = 2,
> > +			.value_type = REFTABLE_REF_VAL1,
> > +			.value.val1 = { '1' },
> > +		},
> > +	};
> > +	struct reftable_ref_record ref = { 0 };
> > +
> 
> Create two reftable stacks that provide a view into the reftable tables
> inside "dir".

Yup.

> > +	err = reftable_new_stack(&st1, dir, NULL);
> > +	check(!err);
> > +	err = reftable_new_stack(&st2, dir, NULL);
> > +	check(!err);
> > +
> 
> Successfully add refs[0] to the first stack using the transactional API.

Here we only open the stacks without doing anything with them yet. This
is preparation for being able to read/write them.

> > +	err = reftable_stack_new_addition(&add, st1, 0);
> > +	check(!err);
> > +	err = reftable_addition_add(add, write_test_ref, &refs[0]);
> > +	check(!err);
> > +	err = reftable_addition_commit(add);
> > +	check(!err);
> > +	reftable_addition_destroy(add);
> > +
> > +	/*
> > +	 * The second stack is now outdated, which we should notice. We do not
> > +	 * create the addition and lock the stack by default, but allow the
> > +	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
> > +	 */
> 
> We try to open a transaction via the second reftable stack, but the
> this stack is outdated because we've written to "dir" when the previous
> stack addition was committed.

Yup.

> > +	err = reftable_stack_new_addition(&add, st2, 0);
> > +	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
> 
> Try again, but supply the flag so it performs a reload internally. Write
> refs[1] to "dir" by committing the transaction. 

Yup.

> > +	err = reftable_stack_new_addition(&add, st2, REFTABLE_STACK_NEW_ADDITION_RELOAD);
> > +	check(!err);
> > +	err = reftable_addition_add(add, write_test_ref, &refs[1]);
> > +	check(!err);
> > +	err = reftable_addition_commit(add);
> > +	check(!err);
> > +	reftable_addition_destroy(add);
> > +
> 
> Asserts.

Exactly.

Patrick
