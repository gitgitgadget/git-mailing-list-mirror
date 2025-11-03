Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13922765ED
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178435; cv=none; b=nkShdw3W6/a6SZh6H3aXwJdBk1W732KiND9bboRSF2OzAcEirHYjH4QjFsaSz2WH7WSV2ZVUaBasu1T8POGlOe7SjTuK/ita5mdJD5feIbOqB6mLOLPYM6m82F6QBCorAKZett0hbU7Xg+yWMOX7pHcLf3IOqFRc2NmeOXTDq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178435; c=relaxed/simple;
	bh=/Ln1Ydou7s1v8fPKd1QHZwH0uEJp3cWo3OSw+aGB+0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhTXz29YGocoQuJ4kg8M9dCtm7BFePb+fSmA8O4L/HWZOQLQSjVQFlf0A9Y62OuwPKVLl3cl6yhtO21xQrMV0EC8Fh5J7fReET7ryHl+ixQUl4rPe8bvC/fC8C9wN9jiqx4se3z3G7KdNLsG9+yMytMwhBK0KP7UJVQaWvzQ1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Za/XKWFH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuqTDX/a; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Za/XKWFH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuqTDX/a"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id EA7241D001A9;
	Mon,  3 Nov 2025 09:00:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 03 Nov 2025 09:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762178432; x=1762264832; bh=EAs9CDkyyR
	fk/2hLPVG5G5yoxIM/9bebqLKvx5a9Wow=; b=Za/XKWFHDqZcBvvXpehd1CJ8D0
	RzyKv+8EfIWE6lY8GZOJ20vpoIRfU/9RoZCIVOjruoUOXcVtM4URaSjY/kn1QQRF
	D1Jg31NuCDlozVmkstyV6JkvXpWI+czFhcS/HBNVPg9MczfBx011ppBajOER5ihp
	AIIvdRIcNtcIO0guAGUHUL64fjCoUcMBIsvLOeke44yl2+SbAHDn+AAQv5Mg55tk
	/FjPQsSpB7m7QNAI2aPJ0qyhZYacIjxCWAztHL729uGr/zwva5zuPkrSjuu1D2sy
	Zzs6cZTYnp+UEJp9I9l6TVIlY6D4cz7TesO2XqRlQPPCsglYYsANpkCOpetw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762178432; x=1762264832; bh=EAs9CDkyyRfk/2hLPVG5G5yoxIM/9bebqLK
	vx5a9Wow=; b=EuqTDX/aJNu4ew78sGxofBG8icOFd1kY59Bg6AmDNbHx/TQFkkq
	7R5yN2lYutUMXL3lDi864E/ZjzkDgpRXr2H7G8vQbPIfZqF+77B8mURlLrOEz9DD
	we+mT64LusfAyqls0NzRANrr5+FzAI/E3oBzotfZpXnYWgyTnkDDGSpz4s0Xz3dQ
	bXFS+iptP7C0P+MRShDBc5kdtLMmW6Rw7guC+i6obPAMxmt5bG1Gy+ta1xV7kbhF
	cbW4nqOArPvORt12aCPHE9rVlJIYfg4xiyk1ct8cqKen5Z8z61VK9SdzAlAlByzC
	jPLiMCYanALLOXAcW1bFpjgPT+4VXLUiUxQ==
X-ME-Sender: <xms:gLUIaQv9i3zViL1pZvQyrKIFVJD6pTDR0Q2F9m6ZD9SqvhMqjcGUkQ>
    <xme:gLUIaTc_qnXggvoBr5rBpOPPYtVhhpsZXNMBRZbnfT0fHcMm2foEYpq8rGoB_mf-K
    hftgYSbGJPOVPqzifugXVQRGPMG8aTf0MrxEtrkw8K6qfP0qeu1-40>
X-ME-Received: <xmr:gLUIaZZKRTtZhhTYf_rNLJjPq3wpclsQDRmAdfLumctpWI7kVan0XXVy120dBjbVQxT7nQ5xa5qbapVsH58Y8HPDjzu3KwZ5GqSFo_UpwIjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gLUIaeXOpXui6FTB6VtXywSc81Bn14pAwNyDD9LURazMlDWzXl_lTA>
    <xmx:gLUIaThTXdijgXZJGhXKxPq2rImCRS0TH2oBMCoCTksefT-sJoHtZQ>
    <xmx:gLUIaUWquN24DPRexwE2J1im9BusPJmhP3xVQzeElRWb3vFbXQX1Ng>
    <xmx:gLUIaSMwy_lr-Kqul79NLncOpUlTCN1MKmAxPT2HLafKh0POfirgwQ>
    <xmx:gLUIabeQNh1RtZtPoltLo8ujT3ERgehTVnQXxl6m6nAcAcJECHfGoDzs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 09:00:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e7682e63 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 14:00:30 +0000 (UTC)
Date: Mon, 3 Nov 2025 15:00:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] maintenance: add checking logic in
 `pack_refs_condition()`
Message-ID: <aQi1e0zWfRaxSKtz@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-4-a03d53e28d0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-4-a03d53e28d0e@gmail.com>

On Fri, Oct 31, 2025 at 03:22:24PM +0100, Karthik Nayak wrote:
> The 'git-maintenance(1)' command support an '--auto' flag. Usage of the

s/support/&s/

> flag ensures to run maintenance tasks only if certain thresholds are
> met. The heuristic is defined on a task level, wherein each task defines
> a 'auto_condition', which states if the task should be run.

s/a/an/

> The 'pack-refs' task is hard-coded to return 1 as:
> 1. There was never a way to check if the reference backend needs to be
> optimized without actually performing the optimization.
> 2. We can pass in the '--auto' flag to 'git-pack-refs(1)' which would
> optimize based on heuristics.
> 
> The previous commit added a `refs_optimize_required()` function, which
> can be used to check if a reference backend required optimization. Use
> this within `pack_refs_condition()`.
> 
> This allows us to add a 'git maintenance is-needed' subcommand which can
> notify the user if maintenance is needed without actually performing the
> optimization, without this change, the reference backend would always

s/optimize, without/optimize. Without/

> state that optimization is needed.
> 
> Since we import 'revision.h', we need to remove the definition for
> 'SEEN' which is duplicated in the included header.

Quite weird that it was redefined in the first place. Feels like a nice
side effect.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c6d62c74a7..72177305ff 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -285,12 +286,26 @@ static void maintenance_run_opts_release(struct maintenance_run_opts *opts)
>  
>  static int pack_refs_condition(UNUSED struct gc_config *cfg)
>  {
> -	/*
> -	 * The auto-repacking logic for refs is handled by the ref backends and
> -	 * exposed via `git pack-refs --auto`. We thus always return truish
> -	 * here and let the backend decide for us.
> -	 */
> -	return 1;
> +	struct string_list included_refs = STRING_LIST_INIT_NODUP;
> +	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
> +	struct refs_optimize_opts optimize_opts = {
> +		.exclusions = &excludes,
> +		.includes = &included_refs,

A bit weird that we have to declare these two fields even though we
don't really care for either of them. But I don't mind that too much.

> +		.flags = REFS_OPTIMIZE_PRUNE | REFS_OPTIMIZE_AUTO,
> +	};
> +	bool required;
> +
> +	// Check for all refs, similar to 'git refs optimize --all'.

Style: this should use `/* */` comments.

> +	string_list_append(optimize_opts.includes, "*");
> +
> +	if (refs_optimize_required(get_main_ref_store(the_repository),
> +				   &optimize_opts, &required))
> +		return 0;
> +
> +	clear_ref_exclusions(&excludes);
> +	string_list_clear(&included_refs, 0);
> +
> +	return required;

You return a boolean, but the function is declared to return an integer.
This works, but it feels wrong.

Patrick
