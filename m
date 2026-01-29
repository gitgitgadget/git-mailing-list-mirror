Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82C2D46B3
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709720; cv=none; b=RYDPp3kneXLEwjir7TEoks9aL/tnfIZX+vzEdRw3pyzv3VAW1ie2AvbZKjQtcvBOnHX83eYJtojI7+u5eyzpgfWdaevEaj0cS5ymw+xpBpdFF4VZ1uuouYIMgUjZsVCcYMiQd2wEf9w+FNz701Mb+cRQVs5A2G3DRM4CogdHxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709720; c=relaxed/simple;
	bh=w2UAYhZHyAe9mFbIpbMTTNOyEqahwz8NDNtHZx1xtjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYzTUv4qONcualwpnGE5YBwAahrcuSvHVGyzmPvQl8BBC/pRxEtZCBjTa5GWcyMb6rbxNz2JTXCBWDKb1pPtDkSDtT+W/cbxgb6gpttbIzZuTdcgQtPExJb6Lo/2PnMZ4EmJuZItiWQuOv6+PJjsIemw1zISJEOKZ6U+9bpTzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TW7VroNq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjAJ6l5X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TW7VroNq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjAJ6l5X"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4530F1400151;
	Thu, 29 Jan 2026 13:01:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 29 Jan 2026 13:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769709718; x=1769796118; bh=xfkwyKpZSm
	i8svyCbSX1oR/W3S/eMsV3RytzR7UC4Gg=; b=TW7VroNqj8i9UCO7H2DLF5ztUS
	o8AjRrNiN6FFTSe9wFMOYkqEHl+bA7DB7JrjbRuIdlWrtni/FPWepFMP8/PESkTA
	9G+qRx6IQwZNTA3dHlQymiqTQhogS75rS1qIhZkd5zP16qKk+BLsol1ynFEsRqzx
	0C0Yk2PLkDEe6NY3oBAiyABBzLeSoM0uiUY0ALr+PU5qQgRvLD7RYN8v2a53MQ5m
	C9og7lKKKFb4wmrW7AisVCwq9fUXtnIRpo8fAQfOcKbBnY5cKFoooxUM8TBwZ3af
	6Qdj4++bsNQkc6eEvJR0BVMKSfrmT99yxLJAD8HROnFbfQCdPNTEZBGkxHoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769709718; x=1769796118; bh=xfkwyKpZSmi8svyCbSX1oR/W3S/eMsV3Ryt
	zR7UC4Gg=; b=jjAJ6l5X5vBbFsen80qCm+UYrajl61LyWC366EuFziblPnRDu4i
	vp5O08WqLt4t6iKplhT78BdBiXzKMomh6FUk3bP/jpQA8/Dv6bQ/cL0WojJsI79U
	W3El9ZtrKdnGXOH1OdDC7a2NPB08nlAQ9Rs4IqPsoCmASenJgbeQrfi9/b6mnl8A
	To7rYJC4X2EvGcBJhZcMBSKe+s2cesna3/3UCo+4TcP+hsQUhzcy29gNFteFKgOx
	S+HsMGll1q9cx7Qo0bpV5BD6swnJFgrcWqjNzHPVEqjBi/8qWXaJOc4Ad82iUV4c
	HxLtzZcMNQaJD72xFSAMipdzz5JMrfVC5dg==
X-ME-Sender: <xms:laB7adkBR9vwDoVFsnA7mFUEuJMgVk9-aD9om_YGdjZPbQvl8K__TQ>
    <xme:laB7aVamvILYGwoIRtJRnSL0gJ12yavfybyu1iMal_g4rKGu5bXPjezK_fjTj5KKn
    eOomZBfEa6EHpOgF0V_IDlQEn-m1XmVyViTC6HY3OLJlmlQQ2nC37c>
X-ME-Received: <xmr:laB7aYFPsoZhtRNiN4yHFkGhz6gVLeNNcsKUTg2_VdFqYbyMKbX2e9xffjrndETYi4eq9zQzg2NeFE_UtY3roZLE_2hxrh8ZLqpTOn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhk
    ihguleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhs
    mhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrg
    hrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:laB7aUbBuuap0TN5SCtxUdzsbDJS5h2XjVf3gRwL0Ewf8jD1KFeSpw>
    <xmx:laB7acwGz0NM7jzmqtXCBatEUuuJn8BdyIB99KkOipW4UVwofwXD3Q>
    <xmx:laB7aWSkU-T_vA6uGkIu5gnVfwh25Sa7rcYGGZYRQZARMjKdkDNh2A>
    <xmx:laB7aZI_PzW8VzbPvM_5n7MFrGgo6mfYEROZtQ_hbEPXSOkAODFhpw>
    <xmx:lqB7aYINK1BKEckG49oajZ1bRg30sxpHyJDstIchGCbXmcylKWUq0cGj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 13:01:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v5 1/3] environment: stop storing
 `core.attributesFile` globally
In-Reply-To: <d28850bcdb5677ad0c81cf4bfa51ae1c056aabd3.1769256839.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Sat, 24 Jan 2026 13:21:11 +0100")
References: <cover.1769256839.git.belkid98@gmail.com>
	<d28850bcdb5677ad0c81cf4bfa51ae1c056aabd3.1769256839.git.belkid98@gmail.com>
Date: Thu, 29 Jan 2026 10:01:56 -0800
Message-ID: <xmqqv7gkb8mj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

>  const char *git_attr_global_file(void)
>  {
> -	if (!git_attributes_file)
> -		git_attributes_file = xdg_config_home("attributes");
> +	struct repo_config_values *cfg = &the_repository->config_values;

Here, the_repository, being defined in repository.c as the address
of a singleton "the_repo" instance, cannot be NULL even outside a
repository, so taking the address of its config_values member is
always safe.  OK.

> +	if (!cfg->attributes_file)
> +		cfg->attributes_file = xdg_config_home("attributes");
>  
> -	return git_attributes_file;
> +	return cfg->attributes_file;
>  }

> diff --git a/repository.h b/repository.h
> index 6063c4b846..638a142577 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -3,6 +3,7 @@
>  
>  #include "strmap.h"
>  #include "repo-settings.h"
> +#include "environment.h"
>  
>  struct config_set;
>  struct git_hash_algo;
> @@ -148,6 +149,9 @@ struct repository {
>  	/* Repository's compatibility hash algorithm. */
>  	const struct git_hash_algo *compat_hash_algo;
>  
> +	/* Repository's config values parsed by git_default_config() */
> +	struct repo_config_values config_values;
> +
>  	/* Repository's reference storage format, as serialized on disk. */
>  	enum ref_storage_format ref_storage_format;

And because this new config_values member is directly embedded in
the repository structure, and "the_repo" instance is a global in
BSS, its members are initialized exactly the same way as the
global variables like git_attributes_file were initialized.  Good.


> diff --git a/environment.c b/environment.c
> index a770b5921d..72735d9e4b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -53,7 +53,6 @@ char *git_commit_encoding;
>  char *git_log_output_encoding;
>  char *apply_default_whitespace;
>  char *apply_default_ignorewhitespace;
> -char *git_attributes_file;

And we lose this global, that used to be zero-initialized for being
in BSS.

> @@ -327,6 +326,8 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
>  static int git_default_core_config(const char *var, const char *value,
>  				   const struct config_context *ctx, void *cb)
>  {
> +	struct repo_config_values *cfg = &the_repository->config_values;
> +
>  	/* This needs a better name */
>  	if (!strcmp(var, "core.filemode")) {
>  		trust_executable_bit = git_config_bool(var, value);
> @@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "core.attributesfile")) {
> -		FREE_AND_NULL(git_attributes_file);
> -		return git_config_pathname(&git_attributes_file, var, value);
> +		FREE_AND_NULL(cfg->attributes_file);
> +		return git_config_pathname(&cfg->attributes_file, var, value);
>  	}
>  
>  	if (!strcmp(var, "core.bare")) {
> @@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
>  	/* Add other config variables here and to Documentation/config.adoc. */
>  	return 0;
>  }

And instead of assigning to the global git_attributes_file, we
assign to the config_values.attributes_file member via the global
"the_repository".  No functional changes.  OK.

> +void repo_config_values_init(struct repo_config_values *cfg)
> +{
> +	cfg->attributes_file = NULL;
> +}

This is not strictly needed, as git_attributes_file is left to be
zero-initialized for being in BSS; its replacement, i.e.,
the_repo.config_values.attributes_file, will be zero-initialized the
same way.

But other members we may want add later to the struct may need a
place to initialize them.  Or we can do a static initialization for
the_repo in repository.c then we do not have to have this function
and we do not have to call it.  Either would work fine, as long as
everybody calls initialize_repository() function, which is the only
caller of this helper.

> diff --git a/environment.h b/environment.h
> index 51898c99cd..0c0dcc6847 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -84,6 +84,11 @@ extern const char * const local_repo_env[];
>  
>  struct strvec;
>  
> +struct repo_config_values {
> +	/* section "core" config values */
> +	char *attributes_file;
> +};

OK.

> diff --git a/repository.c b/repository.c
> index c7e75215ac..d308cd78bf 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
>  	ALLOC_ARRAY(repo->index, 1);
>  	index_state_init(repo->index, repo);
>  	repo->check_deprecated_config = true;
> +	repo_config_values_init(&repo->config_values);
>  
>  	/*
>  	 * When a command runs inside a repository, it learns what

Continuing the discussion on repo_config_values_init(), currently,
initialize_repository() is called by init_git(), which is called
from "main()", so it should be fairly safe to assume that all in Git
codebase will call repo_config_values_init().

But those who replace "main()" for their own libified use of Git
code may not call init_git() hence initialize_repository() hence
your repo_config_values_init().  In that sense, this is less safe
than the other alternative.
