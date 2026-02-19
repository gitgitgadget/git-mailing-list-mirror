Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF115539A
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537645; cv=none; b=I1JNKVyHkFpbZAlrwCNwRDH3+Bx5D6sEoET5/CLs+VNtQFvFfKQOnqMAwnfqP9nxREWVVYsw7/mO/j70DqgesR6HwtqAKVNFCv5G/kncvLciQ1cVQkzP7olWVkkJ8uMz7vl4W6AaCw87uar2DlWGJbwXZjnAq+odi52zhqTXueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537645; c=relaxed/simple;
	bh=Ldbv74HZEd2pOjKcQfJBwTIYwyumL51TsnbMn6IxX/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhFFaDvVp3QoQVSroS4o7lgXDGk2zN4WxXLU6yjWVOOlSFHwjquDlrc0SRiVFg5wwXphg5XspkvRuosY9jLr/wTHhXnKzyfVpR0VgIe1ZH+8HPBCDzcqYwG0n1EWie+lgTh99IjyfrFrXTl8l97Zj4UoO0APLUF9DGWrPq/B9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CGZGz9Bp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmdfFp1n; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGZGz9Bp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmdfFp1n"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 72BB7EC0295;
	Thu, 19 Feb 2026 16:47:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 16:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771537643; x=1771624043; bh=kQ6nnGpWpB
	AVm/bwxnQ9tR4Fmji8VJgnmBKIO+Ayyug=; b=CGZGz9BpdyTxHzjQXJq7ckiQIB
	uRlWaB38BWldIz45mVgRr6gZvKBko6xdARPYYyF43iZ0sVaN+h3LO5REGbeieh4C
	kMpH6UdfcbDmOPRIq+K1p79f2hO3610RLzfmaHtemn0cKaWGJJjqxA7puoH7sUia
	NXR6i+7DeqvNKasUkxC2cBtSpMPyTD76ZT0OltbLn8UTgoTif540e6QI2tbaQVUX
	p1C1jE+TAwDU2KdUEKf6y/fLJ24GcnCrrN8YUteLFRCX3iivkIhbz9W4DTFswqEZ
	AYb7a1PZ+pzbsMxPyOVnZ7xRB5RW+nxnHVFbPSrzqNc0+X9LyIp+AFfPdt3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771537643; x=1771624043; bh=kQ6nnGpWpBAVm/bwxnQ9tR4Fmji8VJgnmBK
	IO+Ayyug=; b=KmdfFp1no/Uxyoo08dOhYorLlNkObZXD0ZYOhsfK82f77XzbdAq
	wl713/6v5113pdkDYftiryf4mqKDUiH3SHka9mKuy7m4oqWPJo6/Ip7zPTmiKpPV
	D1XalQw9SHuplkNIFYtBvr0SlorLWvfWCWWxUvmtKjnfQzMWyRbtxzVVro8XXr2L
	OoIoftsXXH5B/o4ygQbHPKl7itIsGY7gAPo+RIcbyXBs5RHOIY8kcYsoW8nfarnC
	Kp7dvGIBa4LPn8m5oV2T/8XvEzUe+gqTFOg32zMbVdcL/9Q/Yg6AR0egXFoinVB+
	Z12bDCQ6xB3+tGSr0wsuGfhqRu7KgFC9q9g==
X-ME-Sender: <xms:64SXaVBQ2it-h7Z0fp_yL_TADziopFixFDOWqnn0ST7E_TuimhJ5Yw>
    <xme:64SXaSkNRchmCYCXA4vAFeasIGY1cdMUbT9P3ZRIICWapdmJI_BiH8ljeM8ebcvmU
    CCx1qls9W6jMVs5k3PR6AXLOWZV_bGaOrN1494dEEMABB1XnzBQgDY>
X-ME-Received: <xmr:64SXaWwukpK11jAvD-Fz1kMW53SL231OauI2aD_u2ICNYxgr514EjG0WWocwfgE_l2388lMNkWoYMMzFfDDS4Y4mG6d-K-NwPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:64SXacTpa6ZqfisM3MGDpYh35OdW4ymdCYEbm7917lisj2Q5VoGMgA>
    <xmx:64SXae8u53AhZ9VAMPZEHAYNHy94zRgidG7fMMaV4CJkhkkRVTst6A>
    <xmx:64SXaauzpS2oKk9e0VVqLnP0ohAxRqUcyE8y-Nw_k_dGqF6KVa9kmA>
    <xmx:64SXaWNyYL2VDTeiBKwZwDIWAf2Yw8a0KJuiVvVEtWcfluurJGoECA>
    <xmx:64SXaYGlIArPuadbyHWd0XckK2pdz5r8skRK2iBOKJ2W-OUYPrAil-Ci>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 16:47:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
In-Reply-To: <20260218222352.55393-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 19 Feb 2026 00:23:45 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-2-adrian.ratiu@collabora.com>
Date: Thu, 19 Feb 2026 13:47:21 -0800
Message-ID: <xmqq4inc2yom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +	/*
> +	 * Ensure cb_data copy and free functions are either provided together,
> +	 * or neither one is provided.
> +	 */
> +	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
> +	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
> +		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");

A way to avoid being repetitious may be to say

	if (!!options->feed_pipe_cb_data_alloc != !!options->feed_pipe_cb_data_free)

or

	if (!!options->feed_pipe_cb_data_alloc ^ !!options->feed_pipe_cb_data_free)

but it (especially the latter) might be a bit too cute for some
people's taste.

> diff --git a/refs.c b/refs.c
> index d432cfb78f..3c124fab29 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2514,24 +2514,38 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
>  	return 0; /* no more input to feed */
>  }
>  
> +static void *transaction_feed_cb_data_alloc(void *feed_pipe_ctx UNUSED)
> +{
> +	struct transaction_feed_cb_data *data = xmalloc(sizeof(*data));
> +	strbuf_init(&data->buf, 0);
> +	data->index = 0;
> +	return data;
> +}
> +
> +static void transaction_feed_cb_data_free(void *data)
> +{
> +	struct transaction_feed_cb_data *d = data;
> +	if (!d)
> +		return;
> +	strbuf_release(&d->buf);
> +	free(d);
> +}
> +
>  static int run_transaction_hook(struct ref_transaction *transaction,
>  				const char *state)
>  {
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> -	struct transaction_feed_cb_data feed_ctx = { 0 };
>  	int ret = 0;
>  
>  	strvec_push(&opt.args, state);
>  
>  	opt.feed_pipe = transaction_hook_feed_stdin;
>  	opt.feed_pipe_ctx = transaction;
> -	opt.feed_pipe_cb_data = &feed_ctx;

So, as the proposed log message promised, our stack lost the
callback data, and instead uses an allocated piece of memory
pointed by the same opt.feed_pipe_cb_data member as before.

> -
> -	strbuf_init(&feed_ctx.buf, 0);
> +	opt.feed_pipe_cb_data_alloc = transaction_feed_cb_data_alloc;
> +	opt.feed_pipe_cb_data_free = transaction_feed_cb_data_free;
>  
>  	ret = run_hooks_opt(transaction->ref_store->repo, "reference-transaction", &opt);
>  
> -	strbuf_release(&feed_ctx.buf);

As the run_hooks_opt() machinery internally manages the
feed_pipe_cb_data, starting from the call to the custom alloc
function and concliding with the call to the custom free function,
this function no longer need to manage resources.  Instead, the
custom alloc/free functions take care of all the associated
resources, like the feed_ctx.buf strbuf, as we have seen earlier.

Nice.

> diff --git a/transport.c b/transport.c
> index ecf9e1f21c..1581aa0886 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1357,21 +1357,36 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
>  	return 0;
>  }
>  
> +static void *pre_push_hook_data_alloc(void *feed_pipe_ctx)
> +{
> +...
> +}
> +
> +static void pre_push_hook_data_free(void *data)
> +{
> +...
> +}
> +
>  static int run_pre_push_hook(struct transport *transport,
>  			     struct ref *remote_refs)
>  {
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> -	struct feed_pre_push_hook_data data;
>  	int ret = 0;
>  
>  	strvec_push(&opt.args, transport->remote->name);
>  	strvec_push(&opt.args, transport->url);
>  
> -	strbuf_init(&data.buf, 0);
> -	data.refs = remote_refs;
> -
>  	opt.feed_pipe = pre_push_hook_feed_stdin;
> -	opt.feed_pipe_cb_data = &data;
> +	opt.feed_pipe_ctx = remote_refs;
> +	opt.feed_pipe_cb_data_alloc = pre_push_hook_data_alloc;
> +	opt.feed_pipe_cb_data_free = pre_push_hook_data_free;

The same structure is used here.  Nice.
