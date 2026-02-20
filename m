Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD63112C0
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591587; cv=none; b=Su7jAGum7E8ZPav7ZnACbrK+Ze2OR/sijgaAtEE/v5j9TpNzE9GVsY3XmXkSCwJUlswc9mj3EyqOubHR4Bg1FryxHclH15d+uoRiAntliTMXYAEwrD+LX6ettAmBDYQ9cgJDYql299B9aeEwOYfQze6aJlpbiFPk+wGVsqnjuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591587; c=relaxed/simple;
	bh=pM+8fjKkS1+YKrDVoDhgz/Qj0XYmz2KhQQGSEpX1QKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acY6COmRjqk7166US4h6/yN/D5deSFoEirrE+Ji+N30bSM00wqd1kFj2dHTOWNU8BRryzzcnGfSs9y4rDaqn3g2yB/TaQc81GCuSx01Ugmo80/PoIvjfP4ZKrqmeZW4OyCkf2fb3Gm43xk12NLnq0s6/GWNeuatPaDRUC/4wJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LHZCcRT5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVq7Y7N2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LHZCcRT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVq7Y7N2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB0A97A01EE;
	Fri, 20 Feb 2026 07:46:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 07:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771591584; x=1771677984; bh=+02OCSVxA9
	lJFPnZ2AXAbIy95TytoYaIq4hajQ8E7bg=; b=LHZCcRT5MBks3iI6mrCNa9HAeo
	ESC5xFW50MAkVwK86n3ViUc9PKRaUQVE36RAfgyZ/xHIpvxK9wDcbH1AHH/2BuMy
	E/WNYinIHcNNlmFBbQGaTfYngD1XlYHvfPFeyOnEn80fuWMESKwMfeomIgFIPNYr
	uX5xZW1BD/2CkiIsdw4SVYEHw9e7KEC2m6ctWHu3Vf7dBoqNeNQO8fMkhRxGB/9i
	zUi6BD4/ctme+yvpUS0QY076CEasVX2JeKsZFwXlcKXSbawKf1yxFSlJNe539vE7
	l5sKoHicx8SZ2KZhLtIPhZWQdI0Xxd8cfFoj0QEg4ha6pCnAA2EzSTwnHKow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771591584; x=1771677984; bh=+02OCSVxA9lJFPnZ2AXAbIy95TytoYaIq4h
	ajQ8E7bg=; b=CVq7Y7N2+Y40h1Ug+2/P8QhrdFCejLrCjBH96Ft/eYhTbymgxdS
	IfCMta+ua2PGsV63f+M+iNdE0QA0Ezrr3qkIydT/LY6sF2PIxRcwYhhek1PvErve
	vX3wTlb/meNbRJh16iJinMUuMwiFfPxW/ACruTsIObAwJng6WfCs826dpJ7+KcgE
	5s4X3mPFcx5dsbZbPys0isKQ9Mj72o5zrFM6EC4nMhGFKhHqSZhvSDLK4Pc234kQ
	j1WFUGT8h57rKhY02RKjn+/PF8nLrm2O6lkYSQUgJWWKQcYHK9IFuFNKAorTXZkk
	DW5EGtm0loIBahzzG86lL9ZVkcteFZ8kCwg==
X-ME-Sender: <xms:oFeYadUGr3v-oXOg46XJ3IY-Sk5Wg0T1HwI-MVv8bLtrtwPqb_1Z9w>
    <xme:oFeYaf1K0-pQTHOcvnBFpRtc6kpbrcFboBaoJ-ty72piZvazmSjm7cqMoxLNLl73l
    ah9to5iBb5ifS6-7OvGIYX73rm1usEKM63Kbu0OxEIE-ARtl0cE_GA>
X-ME-Received: <xmr:oFeYaboX1kNHoQj1Cg5tskwHjSjHtt664iQwII_F2bzUzZBG57TJXAXJXLUKt0UPP91TbADURUMOgPzmGjrvtaxHHy5U7ZBRk7yYXPwFblwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oFeYaWWkoPUIjpyGD3X99MdfyDJ4SgNkplrNMGTEiyrO1e-V311QsQ>
    <xmx:oFeYaWaR6VPx8YqQazgv6UFAvarHcuX8Z77vrtdh79TGdYXM8gcm6g>
    <xmx:oFeYaTfsaWOgXakg9CWcqumYVzsM89Jxh7Ll89EQEWoSEk7dO-u-tA>
    <xmx:oFeYaQ1Z4WZwdy0haFcYa295JXTooiVt-PWnLdq36kh6DGWbhOthiw>
    <xmx:oFeYaYrS18QJpkGL0KXma-aKwJeuZuoq0IqlTIz1tzBX1LOoAU392kDF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 07:46:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26b33708 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 12:46:22 +0000 (UTC)
Date: Fri, 20 Feb 2026 13:46:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 4/8] hook: include hooks from the config
Message-ID: <aZhXm1-jw_Mi8-vL@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218222352.55393-5-adrian.ratiu@collabora.com>

On Thu, Feb 19, 2026 at 12:23:48AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 51660c4941..e151bb2cd1 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -54,6 +56,10 @@ static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
>  
>  	if (h->kind == HOOK_TRADITIONAL)
>  		free((void *)h->u.traditional.path);
> +	else if (h->kind == HOOK_CONFIGURED) {
> +		free((void *)h->u.configured.friendly_name);
> +		free((void *)h->u.configured.command);
> +	}

The `if` branch also needs curly braces now.

> @@ -101,6 +107,187 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>  	string_list_append(hook_list, hook_path)->util = h;
>  }
>  
> +static void unsorted_string_list_remove(struct string_list *list,
> +					const char *str)
> +{
> +	struct string_list_item *item = unsorted_string_list_lookup(list, str);
> +	if (item)
> +		unsorted_string_list_delete_item(list, item - list->items, 0);
> +}

This looks like a function that could reasonably be added to
"string-list.{c,h}".

> +/*
> + * Callback struct to collect all hook.* keys in a single config pass.
> + * commands: friendly-name to command map.
> + * event_hooks: event-name to list of friendly-names map.
> + * disabled_hooks: set of friendly-names with hook.name.enabled = false.
> + */
> +struct hook_all_config_cb {
> +	struct strmap commands;
> +	struct strmap event_hooks;

Hm, curious that we've got two maps. I'd have expected to have a single
map from "friendly name" or "hook name" to `struct hook`. But maybe
we'll assemble these structs for those maps later on.

> +	struct string_list disabled_hooks;
> +};

We don't have support for disabled hooks yet. I assume this'll be added
by a later commit, only.

[snip]
> +/* Populate `cache` with the complete hook configuration */
> +static void build_hook_config_map(struct repository *r, struct strmap *cache)
> +{
> +	struct hook_all_config_cb cb_data;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +
> +	strmap_init(&cb_data.commands);
> +	strmap_init(&cb_data.event_hooks);
> +	string_list_init_dup(&cb_data.disabled_hooks);
> +
> +	/* Parse all configs in one run. */
> +	repo_config(r, hook_config_lookup_all, &cb_data);
> +
> +	/* Construct the cache from parsed configs. */
> +	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
> +		struct string_list *hook_names = e->value;
> +		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
> +
> +		string_list_init_dup(hooks);
> +
> +		for (size_t i = 0; i < hook_names->nr; i++) {
> +			const char *hname = hook_names->items[i].string;
> +			char *command;
> +
> +			command = strmap_get(&cb_data.commands, hname);
> +			if (!command)
> +				die(_("'hook.%s.command' must be configured or "
> +				      "'hook.%s.event' must be removed;"
> +				      " aborting."), hname, hname);
> +
> +			/* util stores the command; owned by the cache. */
> +			string_list_append(hooks, hname)->util =
> +				xstrdup(command);
> +		}
> +
> +		strmap_put(cache, e->key, hooks);
> +	}
> +
> +	strmap_clear(&cb_data.commands, 1);
> +	string_list_clear(&cb_data.disabled_hooks, 0);
> +	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
> +		string_list_clear(e->value, 0);
> +		free(e->value);
> +	}
> +	strmap_clear(&cb_data.event_hooks, 0);
> +}

Okay, this is where we assemble the hooks. Still curious that the result
isn't a `struct hook` for each configured hook.

[snip]
> +static void list_hooks_add_configured(struct repository *r,
> +				      const char *hookname,
> +				      struct string_list *list,
> +				      struct run_hooks_opt *options)
> +{
> +	struct strmap *cache = get_hook_config_cache(r);
> +	struct string_list *configured_hooks = strmap_get(cache, hookname);
> +
> +	/* Iterate through configured hooks and initialize internal states */
> +	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
> +		const char *friendly_name = configured_hooks->items[i].string;
> +		const char *command = configured_hooks->items[i].util;
> +		struct hook *hook = xcalloc(1, sizeof(struct hook));
> +
> +		if (options && options->feed_pipe_cb_data_alloc)
> +			hook->feed_pipe_cb_data =
> +				options->feed_pipe_cb_data_alloc(
> +					options->feed_pipe_ctx);
> +
> +		hook->kind = HOOK_CONFIGURED;
> +		hook->u.configured.friendly_name = xstrdup(friendly_name);
> +		hook->u.configured.command = xstrdup(command);
> +
> +		string_list_append(list, friendly_name)->util = hook;
> +	}
> +}

Okay, here we finally create the hook structures. Is there any specific
reason why we don't cache these structures directly?

Patrick
