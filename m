Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.241
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329159;
	b=S17/KUL+1t/IzxUw1MUTvmhfit5BR5W1O9oFr0gXR16oR7y5ktcSCbq6re5iXJJEkr+T
	 3AHdtUf8qDqQqM88LUVgWIie7WxW4uJsDdLK7k1ZsM+8wRA40daNKqGwEYgE7gE6wfxo8
	 UI6OgSvHWeJcRDGoB3AULpBXvx8C97Wb9J6Cj2YsAeBEnp+MFsmVxzQSPwKTSZxe6q9GW
	 zmZzRfr1ws2gUvac1DmJDAMMdsawi3X6mzfZvb8VtKEoj0TRelD2I9KPq9t6s3ghCmFdM
	 SR6MSa/eXrN9jkJoePM1grCb0DNVg+66Gf3v2+lUikKjVrME1LDr4+v/YFBaY2fQSeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329159;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=b91d1EU9DfWpLS5Dvk2omLsBhld9qBYLKLBBmeVqxM4=;
	b=VXEfwzB2t+kQrNBNMoGLJ1YqojYVki9ugKMCKcpUEI7j1KTQPUtX7fByPO7s8FMyVHDb
	 zkr7m1ImX+lPbnl6jHZ4yBOM8COci1ipvbT84w25tlmKVcAsYec9wFm1t0xN655xEzw4j
	 WBQWQWUfXEt9iK0MoCkIKzAVxWTM0OG/lZ7UayWyw3wK+F2ZsOsp1Etq3/9We/EZ0TV/H
	 Os4kCsXlPeEMQLFvnCwd2ADEE2wCThLl+GB1bG7hwyTAvDR8BrOeGpxvb9vxY8o4jwzd0
	 cC8sitIwyiWgt3LwUaqVugSwYXWhFJuJInxJmm5Ey0GwZDh1uKqNNqpyBCRiultJrOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=XQo0SY8a;
	arc=none smtp.remote-ip=95.215.58.241
Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC315606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC315606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=XQo0SY8a
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a2UA0e06D4HHi1KGhtq9YV9v5e51iflOjuY1zXpDxRc=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794329154; v=1; x=1794933954;
 b=XQo0SY8aZ28vP0b6Y9EyhQ9FmNE99FO8R54W8xt4J8o0KqTQM170G1P5m91GJnwWGkSFQUmi
 BXAhfXIsi6o1QngsvtKCaqSb+wFUKiLSCFsEex1P47gsUVog0IHO0+1LpoJIPekY/je+opoizgY
 87FM3ONYKQfayoVho4S5zUN4=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8ddd513fa5da1db9;
	Tue, 10 Nov 2026 16:45:54 +0000
X-Mizu-Trace-ID: 8ddd513fa5da1db9
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Miklos Vajna <vmiklos@collabora.com>, gitster@pobox.com
Cc: szeder.dev@gmail.com, ps@pks.im, git@vger.kernel.org
Subject: Re: [PATCH v5 4/5] log: simplify --follow following renames for
 non-linear history
In-Reply-To: <5ba93e49cff31e61621ac166f2d60b8133937f20.1794078554.git.vmiklos@collabora.com>
References: <5ba93e49cff31e61621ac166f2d60b8133937f20.1794078554.git.vmiklos@collabora.com>
Date: Tue, 10 Nov 2026 17:45:50 +0100
Message-ID: <877bik63ep.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> Code added in 304812ed33 (log: improve --follow following renames for
> non-linear history, 2026-06-22) implements the feature by introducing a
> new propagate_follow_pathspec_to_parent() function which adds a new call
> to diff_tree_oid(). Also it introduces a new loop to record what path
> each parent of a merge commit should use when following a path.
>
> This works, but it causes a performance regression: e.g. 'git log
> --stat --follow -- include/linux/rsc_table.h' in linux.git takes 6m43s,
> while it took 28s before that commit. The new code diffs each merge
> against each of its parents with rename detection, which is expensive
> when a parent doesn't have the followed path yet. Fixing this would
> require adding even more custom code, instead of just extending the
> existing code in log_tree_diff(). So first simplify the code here, and
> fix the performance regression in a follow-up commit.
>
> Remove propagate_follow_pathspec_to_parent() and the loop calling it
> for each parent. Instead, record the path to follow for each parent in
> the parent loop of log_tree_diff(), right after diff_tree_oid() updates
> the pathspec in case of a rename. Merges are not diffed by default, so
> with --follow, run the same loop for them as well, but without showing
> anything. With -c, --cc or --remerge-diff, show the merge diff after the
> loop. With --diff-merges=first-parent, keep diffing the other parents
> silently, unless the walk only follows first parents. This gets rid of
> the additional call to diff_tree_oid(). The rework has no positive
> performance impact yet, it just simplifies the code.
>
> The previous commit restores the path of the merge before diffing each
> parent, and also after the loop, for
> propagate_follow_pathspec_to_parent(). Keep restoring it between
> parents, but not after the loop, since there is no later propagation
> anymore.
>
> Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
> ---
>  log-tree.c | 96 +++++++++++++++++++++++-------------------------------
>  1 file changed, 41 insertions(+), 55 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index befc5c8b22..0aa27fb210 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1153,33 +1153,6 @@ void release_follow_pathspec_slab(struct rev_info *opt)
>  	FREE_AND_NULL(opt->follow_pathspec_slab);
>  }
>  
> -/* Compute a path to follow in parent, if there is one */
> -static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
> -						struct commit *commit,
> -						struct commit *parent)
> -{
> -	struct diff_options diff_opts;
> -	const char *path;
> -
> -	parse_commit_or_die(parent);
> -	repo_diff_setup(opt->diffopt.repo, &diff_opts);
> -	copy_pathspec(&diff_opts.pathspec, &opt->diffopt.pathspec);
> -	diff_opts.flags.recursive = 1;
> -	diff_opts.flags.follow_renames = 1;
> -	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> -	diff_setup_done(&diff_opts);
> -	diff_tree_oid(get_commit_tree_oid(parent),
> -		      get_commit_tree_oid(commit),
> -		      "", &diff_opts);
> -
> -	path = pathspec_single_path(&diff_opts.pathspec);
> -	if (path)
> -		remember_follow_pathspec(opt, parent, path);
> -
> -	diff_queue_clear(&diff_queued_diff);
> -	diff_free(&diff_opts);
> -}
> -
>  /* Show the remerge or combined diff of a merge commit */
>  static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
>  			       struct commit_list *parents,
> @@ -1208,10 +1181,11 @@ static int log_tree_merge_diff(struct rev_info *opt, struct commit *commit,
>  static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log_info *log)
>  {
>  	int showed_log;
> -	struct commit_list *parents;
> +	struct commit_list *parents, *all_parents;
>  	struct object_id *oid;
>  	int is_merge;
>  	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
> +	int follow_only = 0;
>  	char *path = NULL;
>  
>  	if (!all_need_diff && !opt->merges_need_diff)
> @@ -1241,46 +1215,73 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  	}
>  
>  	if (is_merge) {
> -		if (opt->remerge_diff || opt->combine_merges)
> +		int merge_diff = opt->remerge_diff || opt->combine_merges;
> +
> +		if (merge_diff && !opt->diffopt.flags.follow_renames)
>  			return log_tree_merge_diff(opt, commit, parents, oid);
> -		if (opt->separate_merges) {
> +		if (opt->separate_merges && !merge_diff) {
>  			if (!opt->first_parent_merges) {
>  				/* Show parent info for multiple diffs */
>  				log->parent = parents->item;
>  			}
> +		} else if (opt->diffopt.flags.follow_renames) {
> +			/* Diff only to find the path to follow in parents */
> +			follow_only = 1;
>  		} else
>  			return 0;

This part of code has become pretty tough to read if you ask me. I've
tried to rewrite it:

        if (is_merge) {
                /* -c, --cc or --remerge-diff: show one diff for the whole merge. */
                int merge_diff = opt->remerge_diff || opt->combine_merges;

                /* Without --follow the parent loop is only needed for -m. */
                if (!opt->diffopt.flags.follow_renames) {
                        /* -c, --cc or --remerge-diff: show it, no parent loop. */
                        if (merge_diff)
                                return log_tree_merge_diff(opt, commit, parents, oid);
                        /* No -m either, i.e. merge diffs are off: show nothing. */
                        if (!opt->separate_merges)
                                return 0;
                }

                /* Run the loop silently, unless -m shows a diff per parent. */
                follow_only = !opt->separate_merges || merge_diff;

                /* -m showing all parents: label each diff "(from <parent>)". */
                if (!follow_only && !opt->first_parent_merges)
                        /* Label the first diff, others are labeled in parent loop. */
                        log->parent = parents->item;
        }

The comments I've added are possibly too verbose for the Git project,
but they helped me understand what happens at each line. I hope it's
functionally the same?

(This is as far as I have gotten in the review today, but I wanted to
send this out already)

>  	}
>  
> -	if (is_merge && opt->diffopt.flags.follow_renames)
> +	if (opt->diffopt.flags.follow_renames)
>  		path = xstrdup_or_null(
>  			pathspec_single_path(&opt->diffopt.pathspec));
>  
>  	showed_log = 0;
> +	all_parents = parents;
>  	for (;;) {
>  		struct commit *parent = parents->item;
>  
> -		/* Diff each parent with the path of the merge */
> -		if (path)
> -			set_pathspec_to_single_path(&opt->diffopt.pathspec,
> -						    path);
>  		parse_commit_or_die(parent);
>  		diff_tree_oid(get_commit_tree_oid(parent),
>  			      oid, "", &opt->diffopt);
> -		log_tree_diff_flush(opt);
> +		if (follow_only) {
> +			diff_queue_clear(&diff_queued_diff);
> +			opt->diffopt.found_follow = 0;
> +		} else {
> +			log_tree_diff_flush(opt);
> +		}
>  
>  		showed_log |= !opt->loginfo;
>  
> +		/* The diff updated the pathspec in case of a rename */
> +		if (path)
> +			remember_follow_pathspec(opt, parent,
> +				pathspec_single_path(&opt->diffopt.pathspec));
> +
>  		/* Set up the log info for the next parent, if any.. */
>  		parents = parents->next;
> -		if (!parents || opt->first_parent_merges)
> +		if (!parents)
>  			break;
> +		if (opt->first_parent_merges) {
> +			if (!path || opt->first_parent_only)
> +				break;
> +			/* Only find the path to follow in the other parents */
> +			follow_only = 1;
> +		}
> +		if (path)
> +			set_pathspec_to_single_path(&opt->diffopt.pathspec,
> +						    path);
> +		if (follow_only)
> +			continue;
>  		log->parent = parents->item;
>  		opt->loginfo = log;
>  	}
> -	/* Propagate to parents starting from the path of the merge, too */
> -	if (path)
> -		set_pathspec_to_single_path(&opt->diffopt.pathspec, path);
> +	if (follow_only && (opt->remerge_diff || opt->combine_merges)) {
> +		/* Show the merge diff with the path of this commit */
> +		if (path)
> +			set_pathspec_to_single_path(&opt->diffopt.pathspec,
> +						    path);
> +		showed_log = log_tree_merge_diff(opt, commit, all_parents, oid);
> +	}
>  	free(path);
>  	return showed_log;
>  }
> @@ -1319,21 +1320,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
>  		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
>  	if (shown)
>  		show_diff_of_diff(opt);
> -
> -	/* Record what path each parent of this commit should use */
> -	if (opt->diffopt.flags.follow_renames) {
> -		struct commit_list *parents = get_saved_parents(opt, commit);
> -		if (parents && parents->next) {
> -			struct commit_list *p;
> -			for (p = parents; p; p = p->next)
> -				propagate_follow_pathspec_to_parent(opt, commit,
> -								    p->item);
> -		} else if (parents) {
> -			remember_follow_pathspec(opt, parents->item,
> -				pathspec_single_path(&opt->diffopt.pathspec));
> -		}
> -	}
> -
>  	opt->loginfo = NULL;
>  	maybe_flush_or_die(opt->diffopt.file, "stdout");
>  	opt->diffopt.no_free = no_free;
> -- 
> 2.51.0
>

-- 
Laters,
Toon
