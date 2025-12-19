Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280D1E1DE9
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147935; cv=none; b=Xw49W+iU3yc2+mC0EEbSWd6h6JbHpATXqPVqvyXfSWmK5Okfo3INOJsk/Ql8D4bIrI9Adj4dSMkGTTofDqvc48vfA40cK3+CQuNEgV3IU4GjBgIBeZZjRu8w+QCalXpuYK7frb37Var6vGgQ85tAk8rfV4MDiqHTH0gQDQoK7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147935; c=relaxed/simple;
	bh=qPplAU9ApemMlcOldNttfModNXW/Uz5h6N0fs8op/ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWvzo1KhuvNWRcwMCvcIVZZ6rqLHEi/mx6KKY6AF48myQ3ewkcTWHO6cYhywRudJoWlQ65JeszX4TONdy1C8uZjjkn34th/qzE8fxZ3iahCCE4CGdKuTzlA4zFtGPnKqe94mj90Nz5xxTs92v/Awoy4KwSPU+BPufKUToSnexkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MSmCenEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hs7XEiB/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MSmCenEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hs7XEiB/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2719014000D2;
	Fri, 19 Dec 2025 07:38:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 19 Dec 2025 07:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766147932; x=1766234332; bh=sXxSl0Or5m
	UVaEvG3Zgo5UlXMvUE7891k6hO2rury/c=; b=MSmCenEJCzEK7fsGEfRMpmr9ND
	rgiSYW+nMBheBX2aqzyrpcGTiyev70Jh9lOOJgND396wYs1hi/kVoKZobi49LKZ1
	OMHKozHb/puWJ/CdRKem7DoTycidyqRQxabl9ur605wLhjotuR5lCA40Uzid9lKp
	DVqitc9q1q6RQhisybzN6UvQheZOMeTg1UFYUBS7pekAGfFFRvKpjZ6pv/Ief+sH
	toCYWyMnS6JpkCTIMLl6MW9wo8pdl2fHi3rc8M87exOxjrjWWlJ4IFG5/479Vu2+
	ugA0msS3kWJftHtPRf/qrtSMx9/feP9L7jeLAqMNBjlPPJJ2CKhw5oOPn6IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766147932; x=1766234332; bh=sXxSl0Or5mUVaEvG3Zgo5UlXMvUE7891k6h
	O2rury/c=; b=hs7XEiB/LjgTGD3HQ+9wAiNKFlv4sGMDHo4HvGKf+p58Em1DxEp
	YGrH/cZ4vh9OgENb96WHpzWJIz6gG9a2e/iKfoEfmmNhty0ob5QTLIcinFTIw2NE
	H7V56jVahdB0GASkSScYpftBxrXoLGh+Q0OpJlrZRSV1JLFaXeZT2LScp4e3U7QW
	FURKWgVQeY24xaPRdTsjtRPQLfXT9BJfHyc2r9Jd1SDYKzBe5MArv77ICAJKx8X/
	AMlGKhiSW/yeHZYl/qkaSX3ZqsVoYyhdf9IQSGWvzlAdKxg0hfTfSuke0IdGNZax
	5uC4jqpXbwwIbgi4NkLQAqWeVE3fozDPDnw==
X-ME-Sender: <xms:XEdFabW-XxgzF-HMaXKCjbY7wT0hq1g1ZVWoS6Q2R_MrJBAXCfUc8g>
    <xme:XEdFaQK4wqIZBLKITzqRZA2EZfuWfg3blocJTJHghH4-kkr33dv0o0yqcMa7_053d
    b0j0vyzyP9s3quDNjzA9fXoKffLOdomwJyUOBMO-xdZaTnqFprjDg>
X-ME-Received: <xmr:XEdFab1duA8z88mccgMRAUWeSIShR7Wl-6xSeZopbIiC9u9o10GW9E_X3nXs0guMaqwLqTZBvgXryZ2hwNeTjdHZefhaK71xoKbd3uP0ihHPFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegv
    mhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtoh
    hllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XEdFadK4aNYOhVTHvRufzXxe9H_Fc-0GGuVQe0i3b0BAp4v6RZnw6A>
    <xmx:XEdFaWg1WToIzY5jGcN96tv2cVx7mpo4ENA5HRMhMKT-WW4NZSC2Lg>
    <xmx:XEdFadCk2UIjI1qYvM5LvSS2qsXYNim5cB5lgaAu43H6jzuEIKeyzg>
    <xmx:XEdFaY51PuQfBxlvYiIjRqcUOuKHsubbMNbk78kLGawaxAt5ohZxZQ>
    <xmx:XEdFafbhqkeS6Nlt62bSnIDMt8zxa-kHfTuc6Bm9TmElLZaCUxeIMQ5e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 07:38:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e8f24f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 12:38:48 +0000 (UTC)
Date: Fri, 19 Dec 2025 13:38:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 11/11] receive-pack: convert receive hooks to hook API
Message-ID: <aUVHVMNTFWWn2xjZ@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251218171126.588066-1-adrian.ratiu@collabora.com>
 <20251218171126.588066-12-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218171126.588066-12-adrian.ratiu@collabora.com>

On Thu, Dec 18, 2025 at 07:11:25PM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index d1c40a768d..f22d975879 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -933,20 +878,51 @@ static int run_receive_hook(struct command *commands,
>  			    int skip_broken,
>  			    const struct string_list *push_options)
>  {
> -	struct receive_hook_feed_state state;
> -	int status;
> -
> -	strbuf_init(&state.buf, 0);
> -	state.cmd = commands;
> -	state.skip_broken = skip_broken;
> -	state.report = NULL;
> -	if (feed_receive_hook(&state, NULL, NULL))
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	struct command *iter = commands;
> +	struct receive_hook_feed_state *feed_state;
> +	int ret;
> +
> +	/* if there are no valid commands, don't invoke the hook at all. */
> +	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
> +		iter = iter->next;
> +	if (!iter)
>  		return 0;
> -	state.cmd = commands;
> -	state.push_options = push_options;
> -	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
> -	strbuf_release(&state.buf);
> -	return status;
> +
> +	if (push_options) {
> +		int i;

Nit: this variable could be declared in the loop.

> +		for (i = 0; i < push_options->nr; i++)
> +			strvec_pushf(&opt.env, "GIT_PUSH_OPTION_%d=%s", i,
> +				     push_options->items[i].string);
> +		strvec_pushf(&opt.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
> +					     (uintmax_t)push_options->nr);
> +	} else
> +		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");

Nit: this should also use curly braces according to our modern coding
guidelines:

	- When there are multiple arms to a conditional and some of them
	  require braces, enclose even a single line block in braces for
	  consistency.

> +	if (tmp_objdir)
> +		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
> +
> +	prepare_push_cert_sha1(&opt);
> +
> +	/* set up sideband printer */
> +	if (use_sideband)
> +		opt.consume_output = hook_output_to_sideband;
> +
> +	/* set up stdin callback */
> +	feed_state = xmalloc(sizeof(struct receive_hook_feed_state));

It feels somewhat unnecessary to allocate this structure as it could
have just as well be allocated on the stack.

> +	feed_state->cmd = commands;
> +	feed_state->skip_broken = skip_broken;
> +	feed_state->report = NULL;
> +	strbuf_init(&feed_state->buf, 0);
> +	opt.feed_pipe_cb_data = feed_state;
> +	opt.feed_pipe = feed_receive_hook_cb;
> +
> +	ret = run_hooks_opt(the_repository, hook_name, &opt);
> +
> +	strbuf_release(&feed_state->buf);
> +	FREE_AND_NULL(opt.feed_pipe_cb_data);
> +
> +	return ret;
>  }

All of these are nits, and the remaining patches all look good to me.
I'll leave it to you to decide whether you want to do one more (and
hopefully last) reroll.

Thanks!

Patrick
