Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C78272816
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539397; cv=none; b=TAPOAgVQqVxFNk2AcqrrgjFnWuYf5pDA5/906KtX5A/IEBGPWq3AA/pRYqsy8rOHZXEp7TW0eFbGnezxhHHyGFMii8+TvJWx3kw6vByAM3oyIQIUF+xzqonTgzq7C4uO163/aBWWlLY0eO26LWyybHP/398PRTMUDONRQsFI+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539397; c=relaxed/simple;
	bh=fzhzHgcKvtBUk0Orijm+zAhyNOfNBV+2x51aGIg4BBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9FN1UycywRqIUVnLi8EAmCN9C3e9BXWyww3RkqxRlsIYkqNFG1u+S0bG9cxXMzSOV5ju6ULsn7isemwyU3ZGAFmlkc4Eq9kGAvrVkpW13Rb1Gfxm/w+9EBtXC9lSpqmMSLpwtCzA6IdhQ7V/yqKIrZWEsL9FuJz2ppM9NoIduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t2nuPnqW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Axr3UsRR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t2nuPnqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Axr3UsRR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 86119EC02FF;
	Thu, 19 Feb 2026 17:16:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 19 Feb 2026 17:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771539395; x=1771625795; bh=HqBd0aNzMh
	/kIdP8mHVlzMjXmkE3Faon/NcY5lhRUQQ=; b=t2nuPnqWUOZxtUxelKN+P68K2s
	WhITnDRqDozXBVlXr4i/8hA3DaZI98elwXOIvZr/BszQmMC1KQBr1irr0jtD3aDx
	1Nos+H6VjOtE9jTU0us+PZKah+fbvzlVhFoecwwK/0XVh5eqhzJKAjDTHW2VlLzY
	YTtDl+Gd/5+6HXzovZnnZAzOROcXv5Bu6ICXGYh/cK6EMBDuk5T9IFgvhtYBMR/x
	l74tNRApzJjSkNJSZMM7skZpfPySzn3ZRHZDDYeOUgKKXV12gii3F7Qvz4ZNWfTC
	siZHiaEaPLS/4/oFh0mN9i2VuVTM6QThl7Va9TtwD+edsFWWkDafUzlMw3wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771539395; x=1771625795; bh=HqBd0aNzMh/kIdP8mHVlzMjXmkE3Faon/Nc
	Y5lhRUQQ=; b=Axr3UsRRrtw6plCf3TFNqfx1Qe2Eb9A/eTfSpqX0Vbs2KELknBf
	8Sap1pN/u03VGClUUg3HzxXrbH1XJTvYfONlC4KdNpQEjF+hTAFbauMjO433BXv1
	mBl+SjSoSamxM7x7Bw2b8N/vzWi1nXR9BxD6GmBZSFBnVKwkoc2P6iO56K5LnvSF
	7WlC9jK5ITTi2qIp3OJcaOjnvfGVeHFumpzfybzPmZu9ZGhvyB3eMxtjFNnGV4nO
	xEgiZgbdpas12CU4x+HB5m6EifJKez15K+kIyMN68Zg+DJ0j8EI1kIzKO5Y0eYl7
	nJ85S/8G8OiUBBxuZruAtpzPeEuXEYoLJYw==
X-ME-Sender: <xms:w4uXaV9uHtW-t5M6sGa9D3pDHRdmXm3lMMYcupbfRXEpQA9vpcxKuA>
    <xme:w4uXaYxTG8VcbxsWA9vWzxu1zRMIuT_ivNFxHBKZc3Fop2MKBbB4dPLhvVaerNi64
    QosNb285O72DSYlUArftutc7iwuW1izx5suZXjQVChThWIVAOXeoW8>
X-ME-Received: <xmr:w4uXaZMYT3o5WNSn2mlgYGbHKeDqjvI6NP3HiEudCBLdLZYEeBy_wZYsEGAcDq0JlYnlgL_6pPE14RnHpy-Hit3hIAjE8UF9qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeijedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:w4uXaV-mLro3VJ3q5gjjT-r-PR95n_Gb3f-2wpW9XMr2FIJjii1kbQ>
    <xmx:w4uXae6-KBmJxxYHf4h4aU35QqEmhtt53kI6segqzi5693M1bHjhuw>
    <xmx:w4uXaT4dA5pgW1Fqulm8_zoP6RhwqlNCwMX0fm0r_GOc896RVLt35w>
    <xmx:w4uXafp3hJuv_Q6hS_MFGDAAwvzMK7RRPzDnwXcg198dh5nPUsy8mQ>
    <xmx:w4uXaRia4QLvh94jZg-ZYUTmVloaVFEe3PyyftJDl8Shd_p0XkOfGFop>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 17:16:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 4/8] hook: include hooks from the config
In-Reply-To: <20260218222352.55393-5-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 19 Feb 2026 00:23:48 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-5-adrian.ratiu@collabora.com>
Date: Thu, 19 Feb 2026 14:16:33 -0800
Message-ID: <xmqqy0ko1iri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Examples:
>
>   $ git config --get-regexp "^hook\."
>   hook.bar.command=~/bar.sh
>   hook.bar.event=pre-commit

This is all good when you know where you defined your pre-commit
hook, but you would want to know in which scope the configuration is
made, wouldn't you, especially when you are trying to diagnose why
some command that you do not necessarily recognise when you run a
Git command?

> @@ -10,17 +11,22 @@ struct repository;
>   * Represents a hook command to be run.
>   * Hooks can be:
>   * 1. "traditional" (found in the hooks directory)
> - * 2. "configured" (defined in Git's configuration, not yet implemented).
> + * 2. "configured" (defined in Git's configuration via hook.<name>.event).

Wouldn't it be easier to understand if we do "<name>" -> "<friendly-name>"
to match the member name used in the struct below?

>   * The 'kind' field determines which part of the union 'u' is valid.
>   */
>  struct hook {
>  	enum {
>  		HOOK_TRADITIONAL,
> +		HOOK_CONFIGURED,
>  	} kind;
>  	union {
>  		struct {
>  			const char *path;
>  		} traditional;
> +		struct {
> +			const char *friendly_name;
> +			const char *command;

If we wanted to report which config scope defined a particular hook
we need to record where the configured hook came from in this
struct, right?

> +		} configured;
>  	} u;

> +	if (repo->hook_config_cache) {
> +		hook_cache_clear(repo->hook_config_cache);
> +		FREE_AND_NULL(repo->hook_config_cache);
> +	}

It is a minor point, but after applying the hole series, there are
only two calls to hook_cachje_clear(X) and they both are followed by
free(X) or FREE_AND_NULL(X).  I wonder if we simply want
hook_cache_free() instead of _clear()?

