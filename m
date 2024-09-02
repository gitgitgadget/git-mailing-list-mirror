Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC817184D
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284489; cv=none; b=LG4WLnpSdvSNKN1v6ELtyDjiDSiWVC5ap+zoqxPcS2K8dN9Pj3Ipg86fzQktuNjgIHjyKofVYySuPSwFtu9wZqB/7MEBmoKybv9XDGWMjQP/frvzy6kmYWaSINnfyr3ZVffYCduYZd+nNg17MGC2wY3U4Qtykzzcal1WOtnXguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284489; c=relaxed/simple;
	bh=nA6ArW9uP8CCPgioOeuGyKHf5xVOnFMrWQcH3rtuVuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUqfpSsHT8yFHFNBYs2hVdmuR7ixhOLZIy/eEhmWtMKYZNjDL6DdOLoB6GbPPMx/2JHajNXESWeE8NBTpF1jM/kNtG+5fXuduVKgP0rZ6nLGptl/x99yV0fK9E7k9Ol+4Qrpf2ZxjxlFGXq/zukjX6fv6denpUlGRxU/vWu+loQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BWLYkGFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZn0wBFc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BWLYkGFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZn0wBFc"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id BA5F413801CB;
	Mon,  2 Sep 2024 09:41:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Sep 2024 09:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725284486; x=1725370886; bh=zXnyq5qSBt
	PNYJE2GgOwpzJ5Nt3rKstEWNJQZc8wbWQ=; b=BWLYkGFRqWtdXl5kGRWp4FccxH
	0+vb3VJxnaLp5hXmQapJQuR3og2oPwR1egSSnXp5mDdTZIkawajhq4RdUFk7ewnf
	dnxAz/9F8/sTnKXrGbyoBWFtrLj9zejobP4RrKMYPVZg+xfSDnu6IR5J+VUdOsiy
	LkTkDd3t2PCNG+cfSYu/BkcfO0wA5DqSuqeg+61pfuxpWW3yTmkr3Mv6ZlUlb3gL
	0zLEoEgrGcrXEaTOfMsjWx/HI0GOdikUKtPhabk1IWfi8QPoglto6O7emU/uq+xO
	3QOMLseRBOOzn6R9/ta9ZzAPAM4hXh8ktEOdjIMwcOqdpXxlaqIwdJyADXTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725284486; x=1725370886; bh=zXnyq5qSBtPNYJE2GgOwpzJ5Nt3r
	KstEWNJQZc8wbWQ=; b=AZn0wBFcMeLqZIN0YxrzqW7Yjb3/tg/rP8207ApOz28I
	fzFBiAt4ZAyiQmuBfbPWKOFDInvBoX5g0yZXrTIrHM/YUTYRXG7ZWadx7k4d3YZ1
	j+ohV3EyuD132Ws0pTMaPAiXE59Gip6Qs3afdg6vhSLeepjm7bGgvjxz5ehq1zWZ
	UsmclHzpyVV1eR82H2DoiFogTv7vCTzsVdj9pIWpqTfUqB5h+0Xlqq3yyycn/Z43
	KyDofR9UGIudJq5MuxQWQJpy18mWkXL24M1XPvG+5+8ENmawrUxtidvouZcx6TFr
	Bip7HqAJRestXwR3wCBs5WV1guFbfxOD4OnFO6kMxw==
X-ME-Sender: <xms:hsDVZieqTZGFrJazQzX849TE4qMWMJR_6E5sDItyktWA1Z2FoY52hQ>
    <xme:hsDVZsOY2poVypgqgxuZ-VuUqzojpGyo6BP-q3sgOs-pg6Mi3gJ76BU7KCkaHth2t
    vRHY4S9Hu2yz39ibQ>
X-ME-Received: <xmr:hsDVZjiVdjnlDlrjyeZq0v-83GWllgdky-MNrPZqa58bpyAIxQ6p_kEbFcYl7HC8CBdUuBhM8kC1VMBNxOttSj1OC_b8qpwweYVylxcXd-8QiTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hsDVZv9EEWbL8Nnfjb5EUaERaD8uuNIFnwECi8YxNdjnqhuD2FTiCA>
    <xmx:hsDVZus-r_If2RpofR_hFgCCyb8_lEACdOkP_a-lOHqKfXvolqxnOA>
    <xmx:hsDVZmGIrxKRjCgW8xIYrh77JEmUbcqPG_cAgxGYreimtaWP7Swlkg>
    <xmx:hsDVZtPITfO_UfY7zOoGYqeHlC7ZABUrRgx0dadwcAvUHElhS8pxBQ>
    <xmx:hsDVZijnJeXUJa2MVaMA8EcwnWbs94ZPP7Y9-4ISJZqICWwP2ZGNitV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 09:41:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b33a6705 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:41:20 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:41:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <ZtXAhP69zu7cDnsA@tanuki>
References: <cover.1725206584.git.me@ttaylorr.com>
 <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>

On Sun, Sep 01, 2024 at 12:03:24PM -0400, Taylor Blau wrote:
> Git's default SHA-1 implementation is collision-detecting, which hardens
> us against known SHA-1 attacks against Git objects. This makes Git
> object writes safer at the expense of some speed when hashing through
> the collision-detecting implementation, which is slower than
> non-collision detecting alternatives.
> 
> Prepare for loading a separate "fast" SHA-1 implementation that can be
> used for non-cryptographic purposes, like computing the checksum of
> files that use the hashwrite() API.
> 
> This commit does not actually introduce any new compile-time knobs to
> control which implementation is used as the fast SHA-1 variant, but does
> add scaffolding so that the "git_hash_algo" structure has five new
> function pointers which are "fast" variants of the five existing
> hashing-related function pointers:
> 
>   - git_hash_init_fn fast_init_fn
>   - git_hash_clone_fn fast_clone_fn
>   - git_hash_update_fn fast_update_fn
>   - git_hash_final_fn fast_final_fn
>   - git_hash_final_oid_fn fast_final_oid_fn
> 
> The following commit will introduce compile-time knobs to specify which
> SHA-1 implementation is used for non-cryptographic uses.

While the property we care about in the context of this patch series
indeed is that the second hash is faster, I think the more important
property is that it's insecure. If I were seeing two APIs, one labelled
fast and one labelled slow, I would of course pick the fast one. So I
wonder whether we should rename things accordingly so that developers
aren't intrigued to pick the fast one without thinking, and also to have
a more useful signal that stands out to reviewers.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  hash.h        | 42 ++++++++++++++++++++++++++++++++++++++++++
>  object-file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/hash.h b/hash.h
> index 72ffbc862e5..f255e5c1e8a 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -44,14 +44,32 @@
>  #define platform_SHA1_Final    	SHA1_Final
>  #endif
>  
> +#ifndef platform_SHA_CTX_fast
> +#define platform_SHA_CTX_fast	  platform_SHA_CTX
> +#define platform_SHA1_Init_fast	  platform_SHA1_Init
> +#define platform_SHA1_Update_fast platform_SHA1_Update
> +#define platform_SHA1_Final_fast  platform_SHA1_Final
> +#ifdef platform_SHA1_Clone
> +#define platform_SHA1_Clone_fast  platform_SHA1_Clone
> +#endif
> +#endif

We may want to apply our new coding guidelines around nested
preprocessor directives, which should also use indenting.

> @@ -222,6 +249,21 @@ struct git_hash_algo {
>  	/* The hash finalization function for object IDs. */
>  	git_hash_final_oid_fn final_oid_fn;
>  
> +	/* The fast hash initialization function. */

Providing some context here why there are two sets of functions would
help future readers.

> @@ -219,6 +256,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
>  		.update_fn = git_hash_sha256_update,
>  		.final_fn = git_hash_sha256_final,
>  		.final_oid_fn = git_hash_sha256_final_oid,
> +		.fast_init_fn = git_hash_sha256_init,
> +		.fast_clone_fn = git_hash_sha256_clone,
> +		.fast_update_fn = git_hash_sha256_update,
> +		.fast_final_fn = git_hash_sha256_final,
> +		.fast_final_oid_fn = git_hash_sha256_final_oid,
>  		.empty_tree = &empty_tree_oid_sha256,
>  		.empty_blob = &empty_blob_oid_sha256,
>  		.null_oid = &null_oid_sha256,

I was briefly wondering whether we'd rather want to have automatic
fallbacks to the secure alternative when the fast one isn't set. I guess
in the end that's not really worth it though, as it saves us one branch
when not having such a fallback. And we only have so many hashes, so
it's not like this would be a huge pain to maintain.

Patrick
