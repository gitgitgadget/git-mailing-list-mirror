Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB525A2B2
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032299; cv=none; b=CQ//TqHBOM4G46fYQaH0/lxXQ/H5Z7e4YM0Sf+xuEhq1luxLpycADAuQfODopTe1JWyffwT3mo2isZ1QOgDw/M8rG0poxzSmsMHxituP0dzY5zYGqeYJgByPcPkqfA4YGww2VvBiJvGJP/1QN8f9Ehf7nPZ6e/9CVSg0Sr+pAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032299; c=relaxed/simple;
	bh=4Ubb/QA2SuVCXbYX3V5qmQGyYLwCK3Kwszk1WFjaJwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=losN/Td/JuAGqS1Taaa8LnO55sa4Q80ZXg7qL1jk47m1x6FUiWh9zv5KTqZ1stL9i3auy3YOped6pSRKdJ15ubUgtlTDskmQ3bGonfbNYOa5bwwj5NZjiYpZN6OANE8v59VrE93edR1dvyy/DTh6H5DzGZjLfVRK9EdAjqcKMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HN9fVFlw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbF1B7PK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HN9fVFlw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbF1B7PK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DDF0F11401D8;
	Wed, 30 Apr 2025 12:58:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 30 Apr 2025 12:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746032295; x=1746118695; bh=fVvp89T/Cf
	MY0ZOQDwmkDyuh8gZEqCnXpyPlj+a6pzc=; b=HN9fVFlwdXzANAP24HSdP5XCNL
	S8gSbo9i+Y828yjXleyAANe6FtiLIpwae3DfkJ1li6cTjOQp585Om4TGrV2rGPZu
	UWCIv08jsfFFDfuaUVV9txZ/+fbjF8RIwPo+kg7FgapMOz6RpDm2FgU5KPKPzgUK
	ky1DSNnz/7cg4kShAQE61F74KvyQBelN/deMspnGlz7lkmdtqv/v7vH95BAxVZVd
	I2bxXfNaDj4doi6LvOETmq0d4wWaey+5bpdtPcUfVsH+Jyl7FDw+YZKQoP1JxEc0
	w9GgNMyzVsxqNlW3uOq7pvda05K4101pP3oCGlo9sAPv+BcJ9UrsHFh/2Nmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746032295; x=1746118695; bh=fVvp89T/CfMY0ZOQDwmkDyuh8gZEqCnXpyP
	lj+a6pzc=; b=jbF1B7PKvtyrS0SsoXcEJni0ylp9FfbaBkvIRmXYacQY5mZo/uw
	kdXrHfYZVgc2i+f4vLElgradSqmQX5M9i3OM511wgHsziBNSXGU3hzHoUFucJMN0
	W8JOJLo46qSB/1QBdrMWV67csibVUwKByCk+jZe6dSlMOuiR/xN4+IXAIzqUFDeL
	rQleBEGsTEUFNA08uCKiskDcVEVzkmsKkZs5yFmGuMmqzX6sHvDscgTODqmfbZID
	gOwk5vZNtbciBULrVuTbzkU9N5oLcI/wwtT4WkoC0ialolYOrQodFydMJM7EnGTz
	TGJvahCZttaqvzyOS8DHJIEuzDhAZE/XWDQ==
X-ME-Sender: <xms:p1YSaFWaH72hWPDRUwgxIJPzzZ2qGM5ZCr42rAES8u9bKxar7EufvA>
    <xme:p1YSaFkwby_VHiP-SWJsODNj8ir1fhuU85nI-3cs6zfKzYEPUdnMoXwwM5peKdDOG
    hDrtJFrL48jO3yplQ>
X-ME-Received: <xmr:p1YSaBbkM8_zTz0dP_2NODpRwaNwN7p_1ZuqHAoPvAglWYE7mv6zuCE419_q30FwhKvtDD5daL2wn6suLuvizwSytwJVmjV-9Z2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:p1YSaIVNL3U3-LPG5ssHAWLrwrddhsa48fuJJ7etHGcRwmPrzPtnNA>
    <xmx:p1YSaPlDqW0FaGYEYKaLFSVRmPf3o5hhr_CbDKsSgTevUE_sUWa78w>
    <xmx:p1YSaFdDltyY5R2xNPICzk_8cMFZSTJXesUi4LL3ZLpX07alVyt97w>
    <xmx:p1YSaJFnTOVOQmC6R1g2mm9PYRhInk43gnTKrz90mou4GVxcAi6rrg>
    <xmx:p1YSaI3ythNOEcBFlE8mZ1pHEj0WCuvyi8sAhFol67zTFOi_r6dV8WHM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 12:58:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/8] rerere: provide function to collect stale entries
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-6-2580b7b8ca3a@pks.im>
	(Patrick Steinhardt's message of "Wed, 30 Apr 2025 12:25:10 +0200")
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
	<20250430-pks-maintenance-missing-tasks-v2-6-2580b7b8ca3a@pks.im>
Date: Wed, 30 Apr 2025 09:58:13 -0700
Message-ID: <xmqqy0vh1t96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We're about to add another task for git-maintenance(1) that prunes stale
> rerere entries via `git rerere gc`. The condition of when to run this
> subcommand will be configurable so that the subcommand is only executed
> when a certain number of stale rerere entries exists. This requires us
> to know about the number of stale rerere entries in the first place,
> which is non-trivial to figure out.
>
> Refactor `rerere_gc()` and `prune_one()` so that garbage collection is
> split into three phases:
>
>   1. We collect any stale rerere entries and directories that are about
>      to become empty.
>
>   2. Prune all stale rerere entries.
>
>   3. Remove all directories that should have become empty in (2).
>
> By splitting out the collection of stale entries we can trivially expose
> this function to external callers and thus reuse it in later steps.
>
> This refactoring is not expected to result in a user-visible change in
> behaviour.

I have no objection against the goal of allowing "git maintenance"
drive "git rerere gc", and as the primary author of this code path I
do not see anything wrong, in the "correctness" sense, in the
updated code.

I however am not sure if "count what we would prune, and remove only
when there are too many" would work well for this subsystem, because
I expect that the cost to enumerate existing rerere entries and
check each of them for staleness would be the dominant part,
relative to actual "rm -fr <rerere-id>", of the cost you are paying
when you run "git rerere gc".

And if my suspicion is correct, all this change does to the plain
vanilla user of "git rerere gc" is to have them pay the extra cost
of allocating and deallocating the list of names of paths in string
lists.

We need to see some performance measurement to show that the we pay
for collection and counting is a lot smaller compared to the whole
pruning operation to justify the "auto" thing.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  rerere.c | 92 ++++++++++++++++++++++++++++++++++++++++++++--------------------
>  rerere.h | 14 ++++++++++
>  2 files changed, 78 insertions(+), 28 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 740e8ad1a0b..eb06e5f8bea 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -1202,8 +1202,8 @@ static void unlink_rr_item(struct rerere_id *id)
>  	strbuf_release(&buf);
>  }
>  
> -static void prune_one(struct rerere_id *id,
> -		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
> +static int is_stale(struct rerere_id *id,
> +		    timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
>  {
>  	timestamp_t then;
>  	timestamp_t cutoff;
> @@ -1214,11 +1214,11 @@ static void prune_one(struct rerere_id *id,
>  	else {
>  		then = rerere_created_at(id);
>  		if (!then)
> -			return;
> +			return 0;
>  		cutoff = cutoff_noresolve;
>  	}
> -	if (then < cutoff)
> -		unlink_rr_item(id);
> +
> +	return then < cutoff;
>  }
>  
>  /* Does the basename in "path" look plausibly like an rr-cache entry? */
> @@ -1229,29 +1229,35 @@ static int is_rr_cache_dirname(const char *path)
>  	return !parse_oid_hex(path, &oid, &end) && !*end;
>  }
>  
> -void rerere_gc(struct repository *r, struct string_list *rr)
> +int rerere_collect_stale_entries(struct repository *r,
> +				 struct string_list *prunable_dirs,
> +				 struct rerere_id **prunable_entries,
> +				 size_t *prunable_entries_nr)
>  {
> -	struct string_list to_remove = STRING_LIST_INIT_DUP;
> -	DIR *dir;
> -	struct dirent *e;
> -	int i;
>  	timestamp_t now = time(NULL);
>  	timestamp_t cutoff_noresolve = now - 15 * 86400;
>  	timestamp_t cutoff_resolve = now - 60 * 86400;
>  	struct strbuf buf = STRBUF_INIT;
> +	size_t prunable_entries_alloc;
> +	struct dirent *e;
> +	DIR *dir = NULL;
> +	int ret;
>  
> -	if (setup_rerere(r, rr, 0) < 0)
> -		return;
> +	*prunable_entries = NULL;
> +	*prunable_entries_nr = 0;
> +	prunable_entries_alloc = 0;
>  
> -	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
> +	repo_config_get_expiry_in_days(r, "gc.rerereresolved",
>  				       &cutoff_resolve, now);
> -	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
> +	repo_config_get_expiry_in_days(r, "gc.rerereunresolved",
>  				       &cutoff_noresolve, now);
> -	git_config(git_default_config, NULL);
> -	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
> -	if (!dir)
> -		die_errno(_("unable to open rr-cache directory"));
> -	/* Collect stale conflict IDs ... */
> +
> +	dir = opendir(repo_git_path_replace(r, &buf, "rr-cache"));
> +	if (!dir) {
> +		ret = error_errno(_("unable to open rr-cache directory"));
> +		goto out;
> +	}
> +
>  	while ((e = readdir_skip_dot_and_dotdot(dir))) {
>  		struct rerere_dir *rr_dir;
>  		struct rerere_id id;
> @@ -1266,23 +1272,53 @@ void rerere_gc(struct repository *r, struct string_list *rr)
>  		for (id.variant = 0, id.collection = rr_dir;
>  		     id.variant < id.collection->status_nr;
>  		     id.variant++) {
> -			prune_one(&id, cutoff_resolve, cutoff_noresolve);
> -			if (id.collection->status[id.variant])
> +			if (is_stale(&id, cutoff_resolve, cutoff_noresolve)) {
> +				ALLOC_GROW(*prunable_entries, *prunable_entries_nr + 1,
> +					   prunable_entries_alloc);
> +				(*prunable_entries)[(*prunable_entries_nr)++] = id;
> +			} else {
>  				now_empty = 0;
> +			}
>  		}
>  		if (now_empty)
> -			string_list_append(&to_remove, e->d_name);
> +			string_list_append(prunable_dirs, e->d_name);
>  	}
> -	closedir(dir);
>  
> -	/* ... and then remove the empty directories */
> -	for (i = 0; i < to_remove.nr; i++)
> -		rmdir(repo_git_path_replace(the_repository, &buf,
> -					    "rr-cache/%s", to_remove.items[i].string));
> +	ret = 0;
> +
> +out:
> +	strbuf_release(&buf);
> +	if (dir)
> +		closedir(dir);
> +	return ret;
> +}
> +
> +void rerere_gc(struct repository *r, struct string_list *rr)
> +{
> +	struct string_list prunable_dirs = STRING_LIST_INIT_DUP;
> +	struct rerere_id *prunable_entries;
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t prunable_entries_nr;
> +
> +	if (setup_rerere(r, rr, 0) < 0)
> +		return;
> +
> +	git_config(git_default_config, NULL);
> +
> +	if (rerere_collect_stale_entries(r, &prunable_dirs, &prunable_entries,
> +					 &prunable_entries_nr) < 0)
> +		exit(127);
> +
> +	for (size_t i = 0; i < prunable_entries_nr; i++)
> +		unlink_rr_item(&prunable_entries[i]);
> +	for (size_t i = 0; i < prunable_dirs.nr; i++)
> +		rmdir(repo_git_path_replace(r, &buf, "rr-cache/%s",
> +					    prunable_dirs.items[i].string));
>  
> -	string_list_clear(&to_remove, 0);
> +	string_list_clear(&prunable_dirs, 0);
>  	rollback_lock_file(&write_lock);
>  	strbuf_release(&buf);
> +	free(prunable_entries);
>  }
>  
>  /*
> diff --git a/rerere.h b/rerere.h
> index d4b5f7c9320..fd5a2388b06 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -37,6 +37,20 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
>  int rerere_forget(struct repository *, struct pathspec *);
>  int rerere_remaining(struct repository *, struct string_list *);
>  void rerere_clear(struct repository *, struct string_list *);
> +
> +/*
> + * Collect prunable rerere entries that would be garbage collected via
> + * `rerere_gc()`. Whether or not an entry is prunable depends on both
> + * "gc.rerereResolved" and "gc.rerereUnresolved".
> + *
> + * Returns 0 on success, a negative error code in case entries could not be
> + * collected.
> + */
> +int rerere_collect_stale_entries(struct repository *r,
> +				 struct string_list *prunable_dirs,
> +				 struct rerere_id **prunable_entries,
> +				 size_t *prunable_entries_nr);
> +
>  void rerere_gc(struct repository *, struct string_list *);
>  
>  #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
