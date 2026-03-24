Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CB3D902F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343275; cv=none; b=Jpa7M2X+/GAI1/BW0E8hM1ajEMl/DK18lb4y68ZaR7Q4mo7JijFLpWVGJ7BMve71BTlaK2YiYuJdMm4r1i/DXmKCcSQ9Upv6lI9tiEGmB1WEv6OuZoU/PVNcVEgppe6z0DIQz6AYxtIbuEwixFCMMjqhCLcXRrzhn6pbcVb1e68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343275; c=relaxed/simple;
	bh=C/5MIUG64Z8CZym7QXZnjDuA0XfQAHaDDGW7U4oZ7qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNUU5LcReAU6UECfBbMKD/7aBfqZUrdeCM55pzbQOClaol2cZ/hZkIz1JK++iwP0fNHD9ZnjYGvDXJGmGoFJRDW/UE0UeXEuOsKclqZrDtpCR7GOsfxNGCfj+9JfHfAYT9IgnMvniOquRSkWH+A3OTQQ6B1oCPJUJPqDo+2saFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G9LvtuVB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XhmAgu0K; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G9LvtuVB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XhmAgu0K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 70192EC0185;
	Tue, 24 Mar 2026 05:07:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 05:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343273; x=1774429673; bh=EYADpcpqGc
	5LojOquqECdSpmG13+DV6X/F7OhE2r//k=; b=G9LvtuVBb2fkcb+W5qlLBN2rDr
	Z3P2O7i77kyTkbRWuPArLsc/RfMCQJyFrn8P5QsMIGUkLkGmB+hRouJdzkx3h+Vg
	hMLexzsu855cfIHWUOXL75xdDYgnIzD8lFl46p0thPACjNL1q4VzvH4fKr93Al1c
	z8TipMJptkAwKlshCVYrm/c76llP5L6D30yxMtcc6euW4toaas6zEFCZIOCPaiH3
	pdrfe906dDAPr2ZeBt8NDBQfBh7T+J8Tv61yHEdS5/Za5OEv+iWi0cLVUWtnLEeE
	D0e+k6z25CAbAyV8uz0wa4tRaeWDmM3kkUVlrl9tzUgzMhlLx4oG5sINC85Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343273; x=1774429673; bh=EYADpcpqGc5LojOquqECdSpmG13+DV6X/F7
	OhE2r//k=; b=XhmAgu0KcFzlyK2Lu96TVP8Ij6EN+6kLRAx2oP206bPpQs84kW/
	n3sj+6cZoI/Zevj1dS2g8l0QHWZKYUPW79k/tpOqWQUzAR1oq21S9WYurvT4tVXs
	bQ1Qz4lArClxf2bKV+joH35h8UL9kpdCDje3IPhtymkm146u3+8mA22hwIqt4ggB
	8KD2k23Dlx+rq6tai87PoyUN5I4xImzEapAt59ngZgjRarC46g6/8PXqgHSCg+x5
	+RU/judA6ePVuGrtJq8O/dUFXsSHQLIQGmkY/RTqoDXJ8LihUkmNQexpchv4KLFC
	/GWsJijgaSUxi6GWeOYlAzJKep4qCnoH+zQ==
X-ME-Sender: <xms:aVTCaUhWLzduTPf3oRliSYKnp-5qwRuxLeDktPAOo7YXBjAENIA2Ag>
    <xme:aVTCaZlT2HhPOtAYJExx6k-iCftWjWX3q8XfIQ8Q3mJJF9LQWJGXZ7jAKWrrpcu7h
    9RRVKaMJ5iSBzG86NhU4vinJRial44NE6HRuROuPInSZTb-LmaXqQ>
X-ME-Received: <xmr:aVTCaQhH6QFngaVniytUJdemooc9J3rh9RjWwXvG7v80vjNZwcZcYo6Z0tO42x6nc5jH8_g2QbGbkBZreMtHMsDg5WIbHAM95JR9lswPRvsqOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    nhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegrvhgrrhgrsges
    ghhmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:aVTCacFv-QGRwsYXRUeMuvU2VeIUhHwNz7qWU7O1ERsE2rkkmUXn1g>
    <xmx:aVTCaSvTpbHSOwTOQXKrAaTAtVqwa2Kr4ni57HgTvLN4cDo7cWd5Mw>
    <xmx:aVTCadcC-m2RgPe_P2WW8N3b05MjrHUIksMYnjxykWBtIgLxusjBtA>
    <xmx:aVTCaYnI9BWYGRLXFSC_xbUbs59721TaICfISOz77hbeX00QHEyOyA>
    <xmx:aVTCaRGFqMAwYQEVRavSVBJ84AVq-NLHU4VSykjUkpbhiI2g6e_raBSd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:07:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 508df5b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:07:50 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:07:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 3/9] hook: allow parallel hook execution
Message-ID: <acJUY9N4oplsTgFY@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320135311.331463-4-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 03:53:05PM +0200, Adrian Ratiu wrote:
> From: Emily Shaffer <nasamuffin@google.com>
> 
> Hooks always run in sequential order due to the hardcoded jobs == 1
> passed to run_process_parallel(). Remove that hardcoding to allow
> users to run hooks in parallel (opt-in).
> 
> Users need to decide which hooks to run in parallel, by specifying
> "parallel = true" in the config, because git cannot know if their

s/git/Git/

Sorry to be pedantic :)

> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index b7847f9338..21800db648 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -23,6 +23,19 @@ hook.<friendly-name>.enabled::
>  	in a system or global config file and needs to be disabled for a
>  	specific repository. See linkgit:git-hook[1].
>  
> +hook.<friendly-name>.parallel::
> +	Whether the hook `hook.<friendly-name>` may run in parallel with other hooks
> +	for the same event. Defaults to `false`. Set to `true` only when the
> +	hook script is safe to run concurrently with other hooks for the same
> +	event. If any hook for an event does not have this set to `true`,
> +	all hooks for that event run sequentially regardless of `hook.jobs`.
> +	Only configured (named) hooks need to declare this. Traditional hooks
> +	found in the hooks directory do not need to, and run in parallel when
> +	the effective job count is greater than 1. See linkgit:git-hook[1].

Thanks for adding this setting, this addresses my most important concern
with this patch series.

>  hook.jobs::
>  	Specifies how many hooks can be run simultaneously during parallelized
>  	hook execution. If unspecified, defaults to 1 (serial execution).
> ++
> +This setting has no effect unless all configured hooks for the event have
> +`hook.<friendly-name>.parallel` set to `true`.

I guess that's a fair constraint for now. We can still iterate going
forward and have those marked as parallelizable run in parallel, while
running the others sequentially.

> diff --git a/hook.c b/hook.c
> index c4872d8707..a60dac5a60 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -120,6 +120,7 @@ struct hook_config_cache_entry {
>  	char *command;
>  	enum config_scope scope;
>  	unsigned int disabled:1;
> +	unsigned int parallel:1;
>  };

I'd recommend to use a proper bool here.

> @@ -223,6 +226,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
>  		default:
>  			break; /* ignore unrecognised values */
>  		}
> +	} else if (!strcmp(subkey, "parallel")) {
> +		int v = git_parse_maybe_bool(value);
> +		if (v >= 0)
> +			strmap_put(&data->parallel_hooks, hook_name, (void *)(uintptr_t)v);

Do we want to warn on unparseable values?

> @@ -541,21 +553,75 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
>  	strvec_clear(&options->args);
>  }
>  
> +/* Determine how many jobs to use for hook execution. */
> +static unsigned int get_hook_jobs(struct repository *r,
> +				  struct run_hooks_opt *options,
> +				  struct string_list *hook_list)
> +{
> +	/*
> +	 * Hooks needing separate output streams must run sequentially.
> +	 * Next commit will allow parallelizing these as well.
> +	 */
> +	if (!options->stdout_to_stderr)
> +		return 1;
> +
> +	/*
> +	 * An explicit job count overrides everything else: this covers both
> +	 * FORCE_SERIAL callers (for hooks that must never run in parallel)
> +	 * and the -j flag from the CLI. The CLI override is intentional: users
> +	 * may want to serialize hooks declared parallel or to parallelize more
> +	 * aggressively than the default.
> +	 */
> +	if (options->jobs)
> +		return options->jobs;

Hm, okay. I feel like this behaviour is somewhat surprising given that
it now operates different compared to the config value. But arguably,
there is no reason why a caller of git-hook(1) should explicitly set
this flag as it should be under control of the user, unless they have a
very good reason to override the number of jobs.

So maybe this is fine, but I think it needs to be called out explicitly
in our docs.

> +	/*
> +	 * Use hook.jobs from the already-parsed config cache (in-repo), or
> +	 * fallback to a direct config lookup (out-of-repo).
> +	 * Default to 1 (serial execution) on failure.
> +	 */
> +	if (r && r->gitdir && r->hook_config_cache)
> +		/* Use the already-parsed cache (in-repo) */
> +		options->jobs = r->hook_jobs ? r->hook_jobs : 1;
> +	else
> +		/* No cache present (out-of-repo call), use direct cfg lookup */
> +		if (repo_config_get_uint(r, "hook.jobs", &options->jobs))
> +			options->jobs = 1;

We first have a check for `r != NULL`, but if I'm not mistaken
`repo_config_get_uint()` will cause us to unconditionally deref `r`.

> diff --git a/hook.h b/hook.h
> index 7c8c3d471e..494f74345f 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -35,6 +35,13 @@ struct hook {
>  		} configured;
>  	} u;
>  
> +	/**
> +	 * Whether this hook may run in parallel with other hooks for the same
> +	 * event. Only useful for configured (named) hooks. Traditional hooks
> +	 * always default to 0 (serial). Set via `hook.<name>.parallel = true`.
> +	 */
> +	unsigned int parallel:1;
> +
>  	/**
>  	 * Opaque data pointer used to keep internal state across callback calls.
>  	 *

This should likely also be a boolean.

Patrick
