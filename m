Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CD3FA5ED
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044263; cv=none; b=L06wGq1vcJITD3Y6p9vGZuf1wcINt8xCu2Q7gheVYhY1cLWufwjjtV9XZJWo5WbizkP5R4nKKUTRoo3DhqqPf3r3AWt+m+52UbOYmXbfHPpzdgEdbWzmEB0buDgQvbJOClq6dwI32aIlNUzT0G6qCpMZFC+uVhF1vtyofYepSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044263; c=relaxed/simple;
	bh=9yGJw/w7WfYnV4lJLCn798hQ83ak2Uog9judlU49v00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1+iCBfuZ9d9STs43XXMRoFvC8t+zBBahUgWRHZ4KSGUdTi4ONXl5n1xDSvHP6WYWaoe4GUHgahhIRCy1Z3E7VAIrNjrPYzlw7T8PwnoBofJZvqTgfaZzVnEs/gFNaKdQHBGrZ4xvoV+nZ74tZLip0WoisuwGjnoSAL9k/MKv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dBoxnUo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNecRhCc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dBoxnUo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNecRhCc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C07BC7A032E;
	Wed,  1 Apr 2026 07:51:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 07:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775044260; x=1775130660; bh=JYbipfkBpR
	yHBSZGYMRDbQznQDhsr5lB8eBsuMvPuaA=; b=dBoxnUo4CzvIaZk4GBs36xPg+B
	LUODw+uGpdp410xCjQHG9d/tb4/zb4zfkNnRUebT0iXfv78kw84MMLOUXmNyady5
	XYgZiZVGOA/K1/rAYf7KBpm6Vb+VIBHLCghEDomgL/5wjliBP+t+NQKIBz7fpCxL
	FLFF3/LBC3pDmBwjRun4hZaXA9+hOFvau8O2VHlexnbHx9b1ZknEqwluTxXXtw3g
	KrpXINS1QxIqsm9GyL7iGhBzte0nQTi4aW3scvtxd2cnTAqz7VGGHuD3pvact+Zc
	NGrZAsR37oYPVDfjEOClQQ7szPZhb8bDtF+JZ3g0cyT2leOqFC3SywhHhcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775044260; x=1775130660; bh=JYbipfkBpRyHBSZGYMRDbQznQDhsr5lB8eB
	suMvPuaA=; b=MNecRhCcxZfhTaig+K9zCUfLwDwnN2QsuzShPBlsrzROTtnP/vt
	jJ3nBIlytm6MYXEZk4gbljBkOWOuxk8dqomlXmVcC0vUNSHy4LgCLWvts1zLLy/R
	Y/AmznIq+hO+kC84dJYbAfn3STSP4nuCupQreC7X9UKPfsgT4a1SRI4vVJO+jnx0
	+Efa959CK5GxIfrrTi9EEyXxj6TUAG5Yp6XZQWJgML4qv08DHIMon+TYXQS4Wnfl
	1j8NKBlJHq+40Tj7U4qev1t9gqQCWoIbPXxA6rpLt0f7HKq8PwDrjsa4ilcfZuYP
	gWnmxp5IziNRVNlqLBoFUBWbnFEFTPV7kBw==
X-ME-Sender: <xms:pAbNaUvjtgG4fdjjhFexfalskhYj3TRxs1KDJ1mWKH3pF8Ojrc_f7Q>
    <xme:pAbNaXfIy3bDKunAcOgZ5DYqEQUf_ZC5d3nUutgdKSUz9KFWw2aItO2BxR0dkjUVj
    xys_1vtvEONqFDoWmD7PpcwyBhzujyTi2HMG--Rr2Y4OKCnCsZjVQ>
X-ME-Received: <xmr:pAbNadY63N6Ccp4J995vEEu38FyMVyLzzzPzht43F93ecMXgYgLD7AnPfvkjsrWHpfHYmrRoT4wFGyBLUsG9aLQAa1OhbCCva3FPrW1QPP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvhhikhhinhhgthgtgeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pAbNaSWaw7mHMuuqQ12jsAP4jAgyacU-IVJX_aH7xwruwz8KNPI1IQ>
    <xmx:pAbNaXhdqO4GO1d4dfzfBPb5X7DokdJ-8Zdhnmcy8lMhyRXunni0EA>
    <xmx:pAbNaYWH4bnSczKZJ00QTwECqbWReCS3wdZJv_RPMH9FYYdJ1HViWQ>
    <xmx:pAbNaWPk-OQ4_HWzkb1RfmIQKwJgwfy6jz7qBC7mJxquZymYIVU_5Q>
    <xmx:pAbNaffaNQY3XcnmcEWhgKNppC84CQQ_SC-8iSV4HaBgaZFb9oOp_1tm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 07:50:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bb38e1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 11:50:58 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:50:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC GSoC PATCH] backfill: skip downloading for empty batches
Message-ID: <ac0GnzQgZMfu8aGL@pks.im>
References: <20260331121204.787826-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331121204.787826-1-vikingtc4@gmail.com>

On Tue, Mar 31, 2026 at 09:12:04PM +0900, Trieu Huynh wrote:
> When git backfill finishes its object walk, it unconditionally calls
> download_batch to process any remaining objects. If the repository
> is already up-to-date (no missing objects found), this call still
> performs an unnecessary directory scan via odb_reprepare.
> 
> Fix it by adding a check in do_backfill to ensure download_batch is only
> called if the current batch actually contains objects (nr > 0).
> 
> To facilitate testing and provide better telemetry, add a trace2 data
> event for batches_requested. This allows us to verify that no batches
> are processed when the command is run on an up-to-date repository.
> 
> Add a test case in t5620-backfill.sh to ensure silence and efficiency
> when no objects are missing.
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
> Need discussion:
> 1. Is adding trace2_data_intmax() the preferred way to verify this 
>    behavior in our test suite, or should we rely on redirection of 
>    stderr to check for progress messages when the progress option
>    is supported?

I think adding a call to trace2 only for the test itself doesn't make a
lot of sense if we already have another way to verify. But would we
actually see any progress messages? `promisor_remote_get_direct()` knows
to bail out early in case there is nothing to be downloaded, so the only
difference really is the call to `odb_reprepare()`.

Or is it? This part here...

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 0f31844ce7..67f9f28daf 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -58,6 +58,7 @@ static void download_batch(struct backfill_context *ctx)
>  	 */
>  	odb_reprepare(ctx->repo->objects);
>  	display_progress(ctx->progress, ++ctx->batches_requested);
> +	trace2_data_intmax("backfill", ctx->repo, "batches_requested", ctx->batches_requested);
>  }
>  
>  static int fill_missing_blobs(const char *path UNUSED,

... looks different. What commit is this patch based on? There is no
call to `display_progress()` on "master", and you didn't mention any
other dependency in your cover letter. Please note such dependencies
when you post a patch that has any requirements.

But in any case, this here would cause us to print "batches_requested"
events repeatedly, which doesn't make a lot of sense.

> @@ -109,7 +110,7 @@ static int do_backfill(struct backfill_context *ctx)
>  	ret = walk_objects_by_path(&info);
>  
>  	/* Download the objects that did not fill a batch. */
> -	if (!ret)
> +	if ( (!ret) && (ctx->current_batch.nr > 0) )
>  		download_batch(ctx);
>  
>  	path_walk_info_clear(&info);

Please pay attention to our coding guidlines, see
"Documentation/CodingGuidelines".

I guess a more robust fix would add the check in `download_batch()`
itself, but I guess both alternatives work. But overall, it's sensible
to avoid repreparing the ODB in case we know nothing has changed.

> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index a1a8d736db..d3cc4022bf 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -221,6 +221,22 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
>  	test_line_count = 12 missing
>  '
>  
> +test_expect_success 'backfill does not request batches when up-to-date' '
> +	git clone --no-checkout --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" backfill-up-to-date &&
> +
> +	# First trigger to have a full download
> +	git -C backfill-up-to-date backfill &&
> +
> +	# Second trigger to verify when already have a full download previously
> +	GIT_TRACE2_EVENT="$(pwd)/up-to-date-trace" git \
> +		-C backfill-up-to-date backfill &&
> +
> +	# Verify no  batches_request occurr
> +	test_grep ! "batches_requested" up-to-date-trace
> +'

I'm ultimately not sure whether this change even needs a test. We're not
changing any user-visible behaviour, we're simply skipping some
pointless busywork that doesn't do much, but that shouldn't really hurt
much, either.

Patrick
