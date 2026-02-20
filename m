Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E3189F30
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591573; cv=none; b=D02ukkVRN8JjqDhLE4DvXmH7CsIVZczCkM38/fc3VwzwjqaaPPqN+v0OlMdEs6fEtsiuPrrY0QlV1dtIeKjBPUMKpn33l1tG3g+kHGL5kyL01cTlPB+z4sewLDLRpA5maITisF22IZTPm9wxI9IxAguwj0KwCG9hJzIgPK4PnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591573; c=relaxed/simple;
	bh=trIL4j8Rqlayr1BtROrvEiIeuXPz8X0thg/6M0+kBbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL5S6Pkpfm2y7QCdThKG4C/RY4CLcw5h0MT80wcuo8NzOP98+JP4t+R+pVhTPuPcev6bNW4B4aQYRWcBvPR9MCcmdnCOz+bgVABPflOUS/C4OVCxZt/tyFrgoVyvolYi5SUZqpFNKoRfPH19I4kdd1ywQWdtjfAzl4YrRyF+pmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ixYYDB2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bR7/HG+e; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ixYYDB2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bR7/HG+e"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 59B0C7A01EC;
	Fri, 20 Feb 2026 07:46:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 07:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771591570; x=1771677970; bh=qrgdOkx0Ph
	yNPlRHsbcVok6oAYJnDZhoUcUcLLzZxWE=; b=ixYYDB2+rREUezvhaJiigi4Y2T
	GzlwYLQKqNS7r2es1bbF++XTWeyw0UNa1+12nrKxtpPTfBMNvkm3yV0Fz5yUGE7X
	QKRTVMPwXApcwY+44ust8rEXNy0bYeUELS2WGKLubvowqFrmZP5a7INVRbg3LoP9
	rbbfEKuxmyNfTmit8kx3qbbKiviXf0NSWDcZH0BGNstlT2O8WXptL8Vx4F3RFqbT
	DzRW5oO/c7h3NaEsJBuaDrWQJ5ld/ekNVVi0GwA8zgupEKr0/jWvaDMK/uR1AOpS
	CaNrUGki2egtu7zb8wP8VyyMQ4AnFpvQzNmO+A4yjNUf6INwhdkOnIdxzGkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771591570; x=1771677970; bh=qrgdOkx0PhyNPlRHsbcVok6oAYJnDZhoUcU
	cLLzZxWE=; b=bR7/HG+eI8qgytcwW0YPNjI+GpCrnj81gsC3+EYJdtyLmMLBfDc
	k/mts/l2J6v10j0hPfHsxEJduuzX1Q9CPG2qai0NDN4CjMiOfJfqdZ/09iGehOIR
	xTiweDlFwXSNGYYE6lTsJCT7/jSm9DAWGN6v/y9YBQpCrP8dlAJDSKE17yFGNZpe
	Qv+dGKAF2KKpJTKtV0swbGy2tk5ItZfkpokwSEbXysh6voMrMaSsraxCMO3GUY/O
	u4bP8p6d+sK+RjXFvBkCp4X/ntuV2UYoizjCoK8rq0xfm9aTfGnOY9jOmpnoj4+x
	zvq1y/k7QLOgBIBrkuZ7kg6lfriguGqiKFA==
X-ME-Sender: <xms:kVeYaSGMWMFY1pmsYtHPRTqvLzKBNNNMlqzeZFn5dO8CdlJBpBe6DQ>
    <xme:kVeYaVlU06scCBXkDpSKil412qnuCnCUha1ivp0gV9rRWvzH1vc6JM5mbJ_SjMciT
    gERl84TC18IE8gWd_GAhkqmCTzo9z067KJgfWZr1Oxg_cRlHJfrzA>
X-ME-Received: <xmr:kVeYaea7EuJiV2TOBFlgYYYgmSuEXrETasZCaXdyxYbq2V1yM81Tbaizo9gnjrEUGDUZMcoOUfl4SQnjpDSrZ8PLCV8fkLO5YHi6KrDNN7f->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsthgv
    rggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kVeYaSETglErbanyYbVAimP2Rws3-Mrlfk-1NY-eQpQp3SKNrbUjcA>
    <xmx:kVeYaXKfshl5Ix3ohhIlkcohtMGNHdK5AQjNBaAc0_1QhCDRO3OV_A>
    <xmx:kVeYaVOvs5fUzqinId94uTszyF1718xse7aKXqX1UpGyuSTR0AfnGQ>
    <xmx:kVeYafmTZBU0aV8nWpyhANHeIA15xXtcdU2wlDvu43Wj7fKrAssaHA>
    <xmx:kleYaaYR8JELH4lUNxkt-VUoHHdL7Uu_SfOqnTT069K2kmMhYu2MKmHY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 07:46:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ffcf294 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 12:46:06 +0000 (UTC)
Date: Fri, 20 Feb 2026 13:45:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
Message-ID: <aZhXh6aqlY0VMgEG@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218222352.55393-2-adrian.ratiu@collabora.com>

On Thu, Feb 19, 2026 at 12:23:45AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 2d2b33d73d..f23772bc56 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -901,6 +901,26 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
>  	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
>  }
>  
> +static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
> +{
> +	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
> +	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));

Tiny nit, not worth addressing: we often use `CALLOC_ARRAY(data, 1)`
nowadays.

> +	data->report = init_state->report;
> +	data->cmd = init_state->cmd;
> +	data->skip_broken = init_state->skip_broken;
> +	strbuf_init(&data->buf, 0);
> +	return data;
> +}

Okay, this basically creates the new instance by creating a deep copy of
the "template" structure.

One could split this up so that we have a "configuration" struct and a
"data" struct, where we then provide a pointer to the configuration into
the data structure, as only the buffer needs to change between the
individual hook invocations. That would avoid some copying around, but
it feels a bit unnecessary.

> +static void receive_hook_feed_state_free(void *data)
> +{
> +	struct receive_hook_feed_state *d = data;
> +	if (!d)
> +		return;
> +	strbuf_release(&d->buf);
> +	free(d);
> +}

I would expect that the hook interfaces know to not call `free()` in
case `alloc()` wasn't called, but I guess it doesn't hurt to be
defensive here anyway.

> @@ -908,7 +928,7 @@ static int run_receive_hook(struct command *commands,
>  {
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  	struct command *iter = commands;
> -	struct receive_hook_feed_state feed_state;
> +	struct receive_hook_feed_state feed_init_state = { 0 };
>  	struct async sideband_async;
>  	int sideband_async_started = 0;
>  	int saved_stderr = -1;
> @@ -938,16 +958,15 @@ static int run_receive_hook(struct command *commands,
>  	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
>  
>  	/* set up stdin callback */
> -	feed_state.cmd = commands;
> -	feed_state.skip_broken = skip_broken;
> -	feed_state.report = NULL;
> -	strbuf_init(&feed_state.buf, 0);
> -	opt.feed_pipe_cb_data = &feed_state;
> +	feed_init_state.cmd = commands;
> +	feed_init_state.skip_broken = skip_broken;

As far as I can see all of the data that we pass to the state struct is
static, so we might just as well initialize it right away, right?

    struct receive_hook_feed_state feed_init_state = {
        .cmd = commands,
        .skip_broken = skip_broken,
        .buf = STRBUF_INIT,
    };

> diff --git a/hook.c b/hook.c
> index cde7198412..83ff658866 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -133,6 +133,8 @@ static int notify_hook_finished(int result,
>  
>  static void run_hooks_opt_clear(struct run_hooks_opt *options)
>  {
> +	if (options->feed_pipe_cb_data_free)
> +		options->feed_pipe_cb_data_free(options->feed_pipe_cb_data);
>  	strvec_clear(&options->env);
>  	strvec_clear(&options->args);
>  }

I guess this here would be where we could skip `free` in case the data
wasn't even allocated. But as I said further up, I don't care all that
much.

> diff --git a/hook.h b/hook.h
> index 20eb56fd63..a6bdc6f90f 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -5,6 +5,9 @@
>  
>  struct repository;
>  
> +typedef void (*cb_data_free_fn)(void *data);
> +typedef void *(*cb_data_alloc_fn)(void *init_ctx);
> +
>  struct run_hooks_opt
>  {
>  	/* Environment vars to be set for each hook */

Do we maybe want to scope these function typedefs to the hooks subsystem
by calling the `hook_data_free_fn` and `hook_data_alloc_fn`, or
something like that?

Patrick
