Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CF22301
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622802; cv=none; b=b9rOLr6SiMo/l+uGtpVY6bT9sFeGRKkxbv2+SpHZcsC8hQLTzvF+CzRJMZCMpNLMnUKGJc8box6cN0m5zAdIM2j3YHftbcl52QtGMExBRBIQMgJ6K3u44pnGOPYoDT6J9McpGqrgoZVWbYpTCgbgzSxqUYyS5vRbPqE237WkCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622802; c=relaxed/simple;
	bh=cu4nwcOczIHPvwYcax4JexmVFytSmw9gj+8cfADh758=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzQzJFTSfHFHug0cWYoYOQZyhWsV3p7OL34h4fIMWE55L1QF17hWjoY+2d0lErv98Ese68mvXtfjnTvXe0/4bWVqJ+kSXATwpFsRKI9uSFI1NVj2ox1wueUbuEjYQ4hl2PTO80TvX+AniToOUaJ4AaBZw5/Ya1HMinAZC+cD2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tlg86EeJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwdRlu19; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tlg86EeJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwdRlu19"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FC127A001F;
	Fri, 27 Mar 2026 10:46:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774622799; x=1774709199; bh=uSrXvKnC/x
	tisJduEaKwm/rRwtXXd+jhzLULhnBbNyY=; b=Tlg86EeJfijuSIsjcljdVi+mIV
	QM/Qcg/veCIYchAekk6yp82qFC3YhxMaTD/m+Zuxnr/m6Aj+SLNfueLlJ8yMM7YQ
	GXscIHXICzRsz3F6L3uwJ8VYgqEOKQ0Gngu9sUdtpiQj8bTs7/JUVI+rRZ6iPuN6
	sqmO3Iw8bd5zxuXOAJupSSOQp7uZ6GXshgqJTRUzgE8FGG0MqCtlihPBYdzV2UF0
	cs22rgKpRBecZwoOYbrJGduxwxAMlLCpRRGzcVeciaC50ViCFP2z1Qf7vAhlGiGK
	WKjjliEIJGEVggOwE28Ki398ul57nLGtNoFAicPzwrLR6EUt8+78tD+b7XCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774622799; x=1774709199; bh=uSrXvKnC/xtisJduEaKwm/rRwtXXd+jhzLU
	LhnBbNyY=; b=mwdRlu1945PlzczeDB2CDeQZa54Ee3uGaf9LLD03BDXIrFyq5hm
	U8QWGCi6NN+1zUsjlVz4KFp3TJXnXiR/Qn1hmWs8lXUvmV3lkQx+M3Gmi0a5PvJ3
	e7iweRkFprWU7X3wXkxDbRbTiGsZEL9PcyKUl0UuSelQg8CIO/YlpZwjdXmc3krM
	r9wjInPolcZuw9Qx5l+5RB3wP9xA8jSad9QYaWq7RbD84/H6ljSN+no/lH0V0hYW
	bVtV0j3xhwtqRhgWail9pbeSCApldZGO2EtwHjjSMSxiI02f/lP7ph9oKR+avBsb
	tiX8zoLKbrXA1jQPKLcH57E88RhtK3MeAtQ==
X-ME-Sender: <xms:T5jGaUB8ggPCqcXqGKBohBMzZJrF5FCwb1Pk7FYFZPFjpvUM_0R89Q>
    <xme:T5jGaVlimVMTjyJwvjxH5EQrP4AtgSnlmvnuNk68epdp7JRERj554iKNDlO3a63q3
    OgwjYAibYSYorrejPt7zqWZ0rtDZu03DNLMEqsd-ORytkNm8UKPMQ>
X-ME-Received: <xmr:T5jGadyTQ9LBL4u0P6HH-PAsqNGRYPcUZn1fREIXlr62cGQZL3CHiv6a7h8SFZgkPYfn0XIRJQElAN8NH4npUm9hnDkHGG1vqGL4rbRYxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfffkeeuteehleekjeelkefhveehkedvgfetieelhfetleduieekgfdtteffudehnecu
    ffhomhgrihhnpehpohhsthdqrhgvtggvihhvvgdrjhhosghsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghmihhlhihshh
    grfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:T5jGaXS6VsnSyWbguDJ5qWh_3YHdc9d3QI7Yf5Wq9TwhX4lbDe09qg>
    <xmx:T5jGad8poEgn5BPbS6ZO6mowyo8xrrFCqAQOPfs0vSFztE7ccmRDJg>
    <xmx:T5jGadsrHK5I6-AMs0QGI8xQ5Yds9y6zxJxkgFrj8-2_36M3HOiD8Q>
    <xmx:T5jGadO-DEzcd9eSipkY1xQZ7Di_PgslUMiooovxAde6CRrbWFhYNA>
    <xmx:T5jGadUrQMqLFysmTsxJBANjyimjhmNwTYZcKtJKzurIyAzF6_9qwJRp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 10:46:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89307a02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 14:46:37 +0000 (UTC)
Date: Fri, 27 Mar 2026 15:46:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 09/12] hook: warn when hook.<friendly-name>.jobs is set
Message-ID: <acaYS-p1muabeUqX@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-10-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326101819.1307742-10-adrian.ratiu@collabora.com>

On Thu, Mar 26, 2026 at 12:18:16PM +0200, Adrian Ratiu wrote:
> diff --git a/hook.c b/hook.c
> index d98b011563..0493993bbe 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -279,6 +279,44 @@ void hook_cache_clear(struct strmap *cache)
>  	strmap_clear(cache, 0);
>  }
>  
> +/*
> + * Return true if `name` is a hook friendly-name, i.e. it has at least one of
> + * .command, .event, or .parallel configured. These are the reliable clues
> + * that distinguish a friendly-name from an event name. Note: .enabled is
> + * deliberately excluded because it can appear under both namespaces.
> + */
> +static int is_friendly_name(struct hook_all_config_cb *cb, const char *name)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +
> +	if (strmap_get(&cb->commands, name) || strmap_get(&cb->parallel_hooks, name))
> +		return 1;
> +
> +	strmap_for_each_entry(&cb->event_hooks, &iter, e) {
> +		if (unsorted_string_list_lookup(e->value, name))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Warn if any name in event_jobs is also a hook friendly-name. */
> +static void warn_jobs_on_friendly_names(struct hook_all_config_cb *cb_data)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *e;
> +
> +	strmap_for_each_entry(&cb_data->event_jobs, &iter, e) {
> +		if (is_friendly_name(cb_data, e->key))
> +			warning(_("hook.%s.jobs is set but '%s' looks like a "
> +				  "hook friendly-name, not an event name; "
> +				  "hook.<event>.jobs uses the event name "
> +				  "(e.g. hook.post-receive.jobs), so this "
> +				  "setting will be ignored"), e->key, e->key);
> +	}
> +}

Makes sense. The bigger question of course is whether we should properly
separate those namespaces, so that this confusion cannot even happen in
the first place. I won't push for such a change though.

Patrick
