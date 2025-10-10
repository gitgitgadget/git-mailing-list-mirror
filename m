Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFE54654
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095382; cv=none; b=L0hgfRtkS2cgPk+nP09PyJn6b4i3w2KO6NH3paUMWBacbGGaov54bNQQWFeTVvzkizj6IW6u+c2jTHpSMwN+nz8/DFEVWRjJ3jDNI9j+pgfzXrC4jydKPTJLQgF5HncHiTlofS13k/G/UhTPj8oTvXRqqmCiwwCX7n0nn7WQL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095382; c=relaxed/simple;
	bh=WWIobo24DusNfdoNSRGwiZov/zLsJUFnc4DPhVcfxxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB6ZNDNZc/Zw6SiPe9HEDM/RxdDHJR+ecAk/Kr7TrcNrs2b9qFEJ6RkLq8xBJvi0tE8kMYQuy74mTnq7l84VvTGkeWyxDVAqOQzsM71cYyu9hnWjyz4xnjOzPdR05BP+kk5GEAOYmPNYj5Hxrc8zstMlXDTsAIjBCT+CrR03IXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fiUCb+Xc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I++4I48b; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fiUCb+Xc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I++4I48b"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A45AEC0128;
	Fri, 10 Oct 2025 07:22:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Oct 2025 07:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095379; x=1760181779; bh=VD3OuhDZmd
	Tsm1jcHYTsJ3z8Qi6T6TY9MnhCuz8RDkU=; b=fiUCb+Xc0FfAnCOozjRcXYUsyN
	WLpulikujrDGnX+GOgmdoECbf+KsNwzbnPoeFK9g8RZxM0NahcWrYnMnc4hq5PJM
	fcJc6ZamY+bNxTp/KoPMgJCbZPgzPPEgssMZ0OZzQiEf/o9QUDt/uRNef/UVsZ7N
	Qokb8zlRXZZDMMcgaC3nZ2oujjl6SrtKZ7Tag/94r10FH/WHqAnG0Z10oAuzpfpx
	M9WofdLcnYsTRYIL3JGR4X1HOtccG62f38btkQbJkSq5hi9DTZRWyV3t25LV4km5
	zkNmx2hDB4muUk8zWYN1ijnonbjicw1C6QerEu3FIL6KtAxxXl0+OQbMQJ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095379; x=1760181779; bh=VD3OuhDZmdTsm1jcHYTsJ3z8Qi6T6TY9Mnh
	Cuz8RDkU=; b=I++4I48bWri0RAQb/bm/maWVho8GXDKGuimehKopP63O3ppAi00
	5UJvYE3Telqdj9XsCDdW/BY5m57AO6upvs16dyVExqbDfFuBXmo+3gPZi00ZHBmf
	w7HGV/Q3mkIKVTNtl+PouhkwU0NbIkmOi13oNySmfLNMT07TpNaMauwtDUeKVfTR
	27SJFLYpFQxcyb2+vR74NxxVwpak1shnk/OOpyFZixR3sAq/rg9CeWi7OhQidO/m
	WZNpl1Vse02/yaWyb1U9VTWGySgMB9688g5xggCWReWNIvkTXPhhuQSd/3TUbwk/
	08mKxXQW+VmLz1BvH0MjBpoetW1yCp2e53Q==
X-ME-Sender: <xms:k-zoaHRL2mf9I6l4kKS38FetGcd2mPq2e3OFHWPRjE63nzofEhTHrQ>
    <xme:k-zoaOz3P1dekUZXbuN3mk8zw644WjpIxfJPGIrzQ-LvRuJZz7Zt5M5lvlgrwjnQn
    FJfwlal5yTT5hp9pOAtIx_ztg1cTmH9VxA-FDGCUhNK-nhulONUpQ>
X-ME-Received: <xmr:k-zoaKeN0wizstNCigsQJepmFtK-G9pYfGpVQ3tma_RewEBnzjqtRNE_pwseqLLWdNSLj20Z2-2MR7eTHL2ZYjK6xF3aY-euDdkZjGCYWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:k-zoaCKjJWPVh7O9LgRHRaFEwfnAyPBfrPWCGSJUNKHTLGCfrMAEgQ>
    <xmx:k-zoaDF_tdASR5CMcHCkkTxnHUfL3DU7qfp1ZqvsoSOQsMSo72LYYw>
    <xmx:k-zoaEoZUUqx6awMY-32PCz5WFkyLzUPZxEQUnFQU01qP_uneeaEFg>
    <xmx:k-zoaETzDNkLMQE8RaxaS33q_zaZYaLTYYmj2nnMPZiPbaD6P_QsnQ>
    <xmx:k-zoaLDdJRC7YA-fpu5rFOoanZoRm6cdWVfOjnS3pHe_m0ZGIZ6oNMPo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5097dc34 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:57 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
Message-ID: <aOjsjpE1vuFUXXbh@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:13PM +0200, Karthik Nayak wrote:
> The 'git pack-refs' and 'git refs optimize' commands allow users to
> optimize their reference backends. However they provide no functionality
> to check if optimization is required without performing it.
> 
> Add a '--required' flag to these commands to do that. This is useful
> on the server side where this information can be utilized to perform
> more targetted maintenance runs of the repository.

s/targetted/targeted/

> Add a corresponding test for the files backend. For the reftable
> backend, this cannot be tested easily as it performs auto-compaction.
> However, an earlier commit ensured the functionality was covered by
> unit test.

You can disable auto-compaction via the
"GIT_TEST_REFTABLE_AUTOCOMPACTION" environment variable, so it should be
rather easy to add a test.

> diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
> index fde9f2f294..62bc01b29b 100644
> --- a/Documentation/git-pack-refs.adoc
> +++ b/Documentation/git-pack-refs.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
> +                [--required]

Hm, I'm not a huge fan of that name. "--dry-run" might be a better name,
but on the other hand one might expect that such a command also yields
information about what happens or that the compaction should be
successful. So I cannot come up with a better name, either.

> diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
> index 0b11282941..66d69530b9 100644
> --- a/Documentation/pack-refs-options.adoc
> +++ b/Documentation/pack-refs-options.adoc
> @@ -50,3 +50,8 @@ the provided `--exclude` patterns.
>  +
>  When used with `--include`, refs provided to `--include`, minus refs that are
>  provided to `--exclude` will be packed.
> +
> +--required::
> +
> +Check if pack-refs is required to run, without actually performing the changes.

Let's not say "pack-refs" here anymore, as we're migrating away from
that name towards more generic terminology. Maybe:

    Check whether the reference store needs to be optimized without
    actually performing the changes.

> diff --git a/pack-refs.c b/pack-refs.c
> index fee77fbf9f..5d4d4266de 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -21,6 +21,7 @@ int pack_refs_core(int argc,
>  	};
>  	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
>  	struct string_list_item *item;
> +	bool check_required = false;
>  	int pack_all = 0;
>  	int ret;
>  
> @@ -28,6 +29,7 @@ int pack_refs_core(int argc,
>  		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
>  		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), OPTIMIZE_REFS_PRUNE),
>  		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), OPTIMIZE_REFS_AUTO),
> +		OPT_BOOL(0, "required", &check_required, N_("check if optimization is required")),
>  		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
>  			N_("references to include")),
>  		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
> @@ -47,7 +49,14 @@ int pack_refs_core(int argc,
>  	if (!pack_refs_opts.includes->nr)
>  		string_list_append(pack_refs_opts.includes, "refs/tags/*");
>  
> -	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
> +	if (check_required) {
> +		bool required = false;
> +		ret = refs_optimize_required(get_main_ref_store(repo), &pack_refs_opts,
> +					     &required);
> +		ret |= !required;

I think we shouldn't use `|=` here, and furthermore I think we need to
define semantics more specifically. E.g.:

    - Return 0 in case optimization is required.

    - Return 2 in case no optimization is required. I mostly shy away
      from `1` here because it might already be used? We'll have to
      double check though.

    - Return any other non-zero error code in case an error occurs.

This also needs to be documented.

> diff --git a/refs.c b/refs.c
> index 514fb85af2..59a48b36b7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2317,6 +2317,13 @@ int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts)
>  	return refs->be->optimize(refs, opts);
>  }
>  
> +int refs_optimize_required(struct ref_store *refs,
> +			   struct optimize_refs_opts *opts,
> +			   bool *required)
> +{
> +	return refs->be->optimize_required(refs, opts, required);
> +}
> +

I feel like this should be introduced in a preceding commit.

Patrick
