Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C93019AA
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667432; cv=none; b=GUP1pxyc4ETavrzMmlSpqtfWvnKLF2UoO0n0WMggvQcaOQHZxkBPu7kvwL6wFejZ/KDjt45KPjAjqE1eoXV2HMiS6I8Mh+GoMEiHtk0jI6PfVzv/ph6Oi5fe/rcUtjEEu1G+FdqZ1HxJ3mALuqYoszO4dTylxVk1avTE7jmnghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667432; c=relaxed/simple;
	bh=cME+oY6W/cB9RqFUjQRZavyB6pOC0y1klJp54BPxt2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqO2HB3DsAotIXeo+Yudvd3+yOaoRXBrxBbLt8nT/aqn8h5u1N5h2MlyPf4v8MUgkDjIxbrjao5J7spw4RRycSiLV9WF0lUDS6I5qBsMGmVfxbtxdEJc5tsWpGB27DlZ+H441LL86NI3AdvLE7r87gRJULXijDbiyEKy8LRytfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYxiNoYE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYxiNoYE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-beb7f26ed62so215244466b.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780667429; x=1781272229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dpyhRpOjKhUHdtJVKxUVy6BxpCuvFvrG1iMQgKolKOA=;
        b=OYxiNoYEubhkJ2sdck4lIr0aByWtxivJiSFxvTHL79dOErZs9lHeIaiQVQAyHB0nIp
         x2VZirP1QjiHABPuIjuBu/FyeOTIYEkK6pveAWbqFi/lhFemikfYJXp3RsIE1QLpO5/Z
         /irtSfvCjZ4aMA/1UNEzhATljCpfiQCzvFPyAvBWuMAH3ECOgRH83PfKDQYXdLq7pL2I
         AJ1CA+LmdVnzHP6KtTGQfP8MaQNj5unCsgqlDQm4eVxrusjbBfbhHAn6LKYi49bgmB7G
         DBvNSQk4zR6FAyah6OUfBmvLm8eeoUfL9lf/fC9mX+d146pwX1an++IgBnm2G9NCxGCf
         CI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667429; x=1781272229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpyhRpOjKhUHdtJVKxUVy6BxpCuvFvrG1iMQgKolKOA=;
        b=LV2AqwuFEC8b0gfx9eap3RAdufvPWM2ia6mb6r8jsftKLWttjI9Z7cSX2Ygt55rBb1
         PUhgFZUnkCQi/o1DvbSzbM9v6rkOU+/ZWMFGeEhOrbt363YImfZJ6FTnLoS3fRxuUhmt
         M9222sEqhJ+aaw/wXJpYL96Zp644WysjMWK5w5fErb/amvzazuQxg8Kk1RvQzcOO2R1D
         HwZXrNqF+Y0lgnhtuASl/OqD+dhap83FCAXCLYyXMXAyn+4LY8j20LGyKVuRujPfGtwJ
         2Q6IllFzIF0awveNLFKb++IOF/S7J1Rn44ZWlkXefgu+EjXjbjatZt5ZJ9m6mBHQXSzh
         Q2YA==
X-Forwarded-Encrypted: i=1; AFNElJ8pM4yaYYo8J+vPAcW3OQNvSUdJtQBzXFKjzvtTABatsZsYdGaBxp5n3OknoxlLybr/CaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/g/HX+tIZSkoH4CaRCuyHgEEOfF8bBH76oIYh4BC6Xtt+AfT
	3RaDKNNfrtmt4Dy9HXQjWI9doGz/9XIujPGhDIode+hVpgJWATj4qe7v
X-Gm-Gg: Acq92OE3BO+JwISBUk09oY4ks9LVG15798APbE0kzUrlZOQiF/vqlUZbZWbIgdKshzo
	6eGPCi5WycUSghoPVk69ynaJwVZvJu9p9uXS735WAraVb7A2YzfUN6anGLngT1tq8MIkl1BEm6i
	1qOthlkZpDFPzzEpfw+WC0sSVIC9SCQl3nOB7jxBRkovb+U7RbUGYdvb3Qp+una60p4hI5p/auv
	Lz0j9zXl2xZw+4mhCBNqHW0ThKdq7NjjuUgVKkODO1tCO1Gy9m3UYqZH0tKrh4nvHKQZrsOTIdq
	TxRpIJuVTrOyZNLuPjH40w3vqIHkY1Qhm59PXtrWbVByZ7mgBa6U+PWIF4Uk7fW4XHswtOXVv0s
	e8azfN5RUmUln5JnthY5p0U1j0YMVUFVk0+P30yqaHZwQfpgG/U9TiMtp4N69/bnu9LLpt6cbFc
	vi+KAlDxwyx/+krpXCT50CaCBu3S0JgHf0eTcI2ioWFU5JxgToqSMhtzWBee+EtFzwGe7QrSULf
	zzQOnfKPqextvflVPjhmHLd
X-Received: by 2002:a17:907:1c9e:b0:bee:376c:331f with SMTP id a640c23a62f3a-bf372540ad8mr191003066b.39.1780667428222;
        Fri, 05 Jun 2026 06:50:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c83c93sm472224866b.16.2026.06.05.06.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:50:27 -0700 (PDT)
Message-ID: <629b38ab-42d8-4763-919f-005b6ada68a0@gmail.com>
Date: Fri, 5 Jun 2026 14:50:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 4/6] branch: add --prune-merged <branch>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
 <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
 <cccfdb831cc8c4ca0844d5b4ba2b70f0c801fc59.1780477479.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cccfdb831cc8c4ca0844d5b4ba2b70f0c801fc59.1780477479.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 03/06/2026 10:04, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> 	git branch --prune-merged <branch>...

I'm not sure that synopsis is correct anymore as you need to repeat 
"--prune-merged". As --prune-merged now takes an argument there is no 
reason to forbid positional arguments so I think we should support

	git branch --prune-merged origin/master 'feature*'

to delete all the branches beginning with "feature" that have the 
upstream "origin/master" and have been merged.

I wonder about the name - the other options that delete branches are 
called "delete", not "prune". Also "--prune-merged" does not delete the 
branches listed by "--merged" so maybe "--delete-forked" would be better?

I've not commented in detail on the code as it will need to change a bit 
once we match on full refnames and do the filtering in 
apply_ref_filter() but I think the basics are sound.

I'll stop here - I did quickly scan the next two patches and they both 
looked like sensible ideas.

Thanks

Phillip

> deletes the local branches that "--forked <branch>" would list,
> restricted to those whose tip is reachable from their configured
> upstream: the work has already landed on the upstream they track,
> so the local copy is no longer needed.
> 
> Reachability is read from local refs; nothing is fetched. Users
> who want fresh upstream refs run "git fetch" first.
> 
> Three classes of branches are spared:
> 
>    * any branch checked out in any worktree;
>    * any branch whose upstream no longer resolves locally (its
>      disappearance is not, on its own, evidence of integration);
>    * any branch whose push destination equals its upstream
>      (<branch>@{push} == <branch>@{upstream}). Such a branch
>      cannot be distinguished from a freshly pulled trunk that
>      just looks "fully merged", e.g. local "main" tracking and
>      pushing to "origin/main" right after a pull. Only branches
>      that push somewhere other than their upstream (typically
>      topics in a fork-based workflow) are treated as candidates.
> 
> Deletion goes through the existing delete_branches() in warn-only
> mode and with the HEAD-fallback disabled: a branch that is not
> yet fully merged to its upstream is reported as a one-line warning
> and skipped, so a single un-mergeable topic does not abort the
> whole sweep. We only act on upstream-merged status.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-branch.adoc |  23 +++++
>   builtin/branch.c              | 117 +++++++++++++++++++--
>   t/t3200-branch.sh             | 188 ++++++++++++++++++++++++++++++++++
>   3 files changed, 318 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index 8002d7f38c..f7942fcd7d 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
>   git branch (-c|-C) [<old-branch>] <new-branch>
>   git branch (-d|-D) [-r] <branch-name>...
>   git branch --edit-description [<branch-name>]
> +git branch (--prune-merged <branch>)...
>   
>   DESCRIPTION
>   -----------
> @@ -206,6 +207,28 @@ This option is only applicable in non-verbose mode.
>   	`master`) or a shell-style glob (e.g. `'origin/*'`). The
>   	option can be repeated to widen the filter.
>   
> +`--prune-merged <branch>`::
> +	Delete the local branches that `--forked` would list for the
> +	same _<branch>_, but only those whose tip is reachable from
> +	their configured upstream. In other words, the work on the
> +	branch has already landed on the upstream it tracks, so the
> +	local copy is no longer needed. May be given more than once to
> +	union the matches; positional arguments are not accepted.
> ++
> +Reachability is checked against whatever the upstream refs say
> +locally; nothing is fetched. Run `git fetch` first if you want
> +the upstream refs refreshed.
> ++
> +A branch is left alone if any of the following holds:
> +its upstream no longer resolves locally; it is checked out in any
> +worktree; or its push destination (`<branch>@{push}`) equals its
> +upstream (`<branch>@{upstream}`), so it cannot be distinguished
> +from a freshly pulled trunk that just looks "fully merged".
> ++
> +Branches refused by the "fully merged" safety check are listed as
> +warnings and skipped; pass them to `git branch -D` explicitly if
> +you want them gone.
> +
>   `-v`::
>   `-vv`::
>   `--verbose`::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 09afdd9257..736480b002 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -39,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
>   	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>   	N_("git branch [<options>] [-r | -a] [--points-at]"),
>   	N_("git branch [<options>] [-r | -a] [--format]"),
> +	N_("git branch [<options>] (--prune-merged <branch>)..."),
>   	NULL
>   };
>   
> @@ -782,17 +783,13 @@ static int upstream_matches(const char *short_upstream,
>   	return 0;
>   }
>   
> -static int branch_upstream_matches(const char *full_refname,
> +static int branch_upstream_matches(const char *short_branch_name,
>   				   const struct upstream_pattern *patterns,
>   				   size_t nr_patterns)
>   {
> -	const char *short_name;
> -	struct branch *branch;
> +	struct branch *branch = branch_get(short_branch_name);
>   	const char *upstream;
>   
> -	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
> -		return 0;
> -	branch = branch_get(short_name);
>   	if (!branch)
>   		return 0;
>   	upstream = branch_get_upstream(branch, NULL);
> @@ -813,8 +810,9 @@ static void filter_array_by_forked(struct ref_array *array,
>   
>   	for (i = 0; i < array->nr; i++) {
>   		struct ref_array_item *item = array->items[i];
> -		if (branch_upstream_matches(item->refname,
> -					    patterns, nr_patterns))
> +		const char *short_name;
> +		if (skip_prefix(item->refname, "refs/heads/", &short_name) &&
> +		    branch_upstream_matches(short_name, patterns, nr_patterns))
>   			array->items[kept++] = item;
>   		else
>   			free_ref_array_item(item);
> @@ -824,6 +822,94 @@ static void filter_array_by_forked(struct ref_array *array,
>   	upstream_pattern_list_clear(patterns, nr_patterns);
>   }
>   
> +struct forked_cb {
> +	const struct upstream_pattern *patterns;
> +	size_t nr_patterns;
> +	struct string_list *out;
> +};
> +
> +static int collect_forked_branch(const struct reference *ref, void *cb_data)
> +{
> +	struct forked_cb *cb = cb_data;
> +
> +	if (ref->flags & REF_ISSYMREF)
> +		return 0;
> +	if (branch_upstream_matches(ref->name, cb->patterns, cb->nr_patterns))
> +		string_list_append(cb->out, ref->name);
> +	return 0;
> +}
> +
> +static void collect_forked_set(const struct string_list *upstreams,
> +			       struct string_list *out)
> +{
> +	struct upstream_pattern *patterns = NULL;
> +	size_t nr_patterns = 0;
> +	struct forked_cb cb;
> +
> +	parse_forked_args(upstreams, &patterns, &nr_patterns);
> +	cb.patterns = patterns;
> +	cb.nr_patterns = nr_patterns;
> +	cb.out = out;
> +
> +	refs_for_each_branch_ref(get_main_ref_store(the_repository),
> +				 collect_forked_branch, &cb);
> +
> +	string_list_sort(out);
> +
> +	upstream_pattern_list_clear(patterns, nr_patterns);
> +}
> +
> +static int prune_merged_branches(const struct string_list *upstreams,
> +				 int quiet)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct string_list candidates = STRING_LIST_INIT_DUP;
> +	struct strvec deletable = STRVEC_INIT;
> +	struct string_list_item *item;
> +	int ret = 0;
> +
> +	if (!upstreams->nr)
> +		die(_("--prune-merged requires at least one <branch>"));
> +
> +	collect_forked_set(upstreams, &candidates);
> +
> +	for_each_string_list_item(item, &candidates) {
> +		const char *short_name = item->string;
> +		struct branch *branch = branch_get(short_name);
> +		const char *upstream, *push;
> +		struct strbuf full = STRBUF_INIT;
> +		int skip;
> +
> +		strbuf_addf(&full, "refs/heads/%s", short_name);
> +		skip = !!branch_checked_out(full.buf);
> +		strbuf_release(&full);
> +		if (skip)
> +			continue;
> +
> +		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
> +		if (!upstream || !refs_ref_exists(refs, upstream))
> +			continue;
> +		push = branch ? branch_get_push(branch, NULL) : NULL;
> +		if (!push || !strcmp(push, upstream))
> +			continue;
> +
> +		strvec_push(&deletable, short_name);
> +	}
> +
> +	if (deletable.nr)
> +		ret = delete_branches(deletable.nr, deletable.v,
> +				      0, /* force */
> +				      FILTER_REFS_BRANCHES,
> +				      quiet,
> +				      1, /* warn_only */
> +				      1, /* no_head_fallback */
> +				      0  /* dry_run */);
> +
> +	strvec_clear(&deletable);
> +	string_list_clear(&candidates, 0);
> +	return ret;
> +}
> +
>   static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
>   
>   static int edit_branch_description(const char *branch_name)
> @@ -866,6 +952,7 @@ int cmd_branch(int argc,
>   	int delete = 0, rename = 0, copy = 0, list = 0,
>   	    unset_upstream = 0, show_current = 0, edit_description = 0;
>   	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
> +	struct string_list prune_merged_upstreams = STRING_LIST_INIT_DUP;
>   	const char *new_upstream = NULL;
>   	int noncreate_actions = 0;
>   	/* possible options */
> @@ -921,6 +1008,8 @@ int cmd_branch(int argc,
>   			 N_("edit the description for the branch")),
>   		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
>   			N_("list local branches whose upstream matches <branch> (repeatable)")),
> +		OPT_STRING_LIST(0, "prune-merged", &prune_merged_upstreams, N_("branch"),
> +			N_("delete local branches whose upstream matches <branch> and is merged (repeatable)")),
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>   		OPT_MERGED(&filter, N_("print only branches that are merged")),
>   		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> @@ -965,7 +1054,8 @@ int cmd_branch(int argc,
>   			     0);
>   
>   	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
> -	    !show_current && !unset_upstream && argc == 0)
> +	    !show_current && !unset_upstream && !prune_merged_upstreams.nr &&
> +	    argc == 0)
>   		list = 1;
>   
>   	if (filter.with_commit || filter.no_commit ||
> @@ -975,7 +1065,7 @@ int cmd_branch(int argc,
>   
>   	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
>   			    !!show_current + !!list + !!edit_description +
> -			    !!unset_upstream;
> +			    !!unset_upstream + !!prune_merged_upstreams.nr;
>   	if (noncreate_actions > 1)
>   		usage_with_options(builtin_branch_usage, options);
>   
> @@ -1016,6 +1106,12 @@ int cmd_branch(int argc,
>   		ret = delete_branches(argc, argv, delete > 1, filter.kind,
>   				      quiet, 0, 0, 0);
>   		goto out;
> +	} else if (prune_merged_upstreams.nr) {
> +		if (argc)
> +			die(_("--prune-merged does not take positional arguments; "
> +			      "repeat --prune-merged for each <branch>"));
> +		ret = prune_merged_branches(&prune_merged_upstreams, quiet);
> +		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();
>   		ret = 0;
> @@ -1178,5 +1274,6 @@ int cmd_branch(int argc,
>   out:
>   	string_list_clear(&sorting_options, 0);
>   	string_list_clear(&forked_upstreams, 0);
> +	string_list_clear(&prune_merged_upstreams, 0);
>   	return ret;
>   }
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 4e7deddc04..beb86987ad 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1809,4 +1809,192 @@ test_expect_success '--forked requires a value' '
>   	test_grep "requires a value" err
>   '
>   
> +test_expect_success '--prune-merged: setup' '
> +	test_create_repo pm-upstream &&
> +	test_commit -C pm-upstream base &&
> +	git -C pm-upstream checkout -b next &&
> +	test_commit -C pm-upstream one-commit &&
> +	test_commit -C pm-upstream two-commit &&
> +	git -C pm-upstream branch one HEAD~ &&
> +	git -C pm-upstream branch two HEAD &&
> +	git -C pm-upstream branch wip main &&
> +	git -C pm-upstream checkout main &&
> +	test_create_repo pm-fork
> +'
> +
> +test_expect_success '--prune-merged deletes branches integrated into upstream' '
> +	test_when_finished "rm -rf pm-merged" &&
> +	git clone pm-upstream pm-merged &&
> +	git -C pm-merged remote add fork ../pm-fork &&
> +	test_config -C pm-merged remote.pushDefault fork &&
> +	test_config -C pm-merged push.default current &&
> +	git -C pm-merged branch one one-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next one &&
> +	git -C pm-merged branch two two-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next two &&
> +
> +	git -C pm-merged branch --prune-merged "origin/*" &&
> +
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged accepts a literal upstream' '
> +	test_when_finished "rm -rf pm-literal" &&
> +	git clone pm-upstream pm-literal &&
> +	git -C pm-literal remote add fork ../pm-fork &&
> +	test_config -C pm-literal remote.pushDefault fork &&
> +	test_config -C pm-literal push.default current &&
> +	git -C pm-literal branch one one-commit &&
> +	git -C pm-literal branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-literal branch --prune-merged origin/next &&
> +
> +	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged unions multiple <branch> arguments' '
> +	test_when_finished "rm -rf pm-union" &&
> +	git clone pm-upstream pm-union &&
> +	git -C pm-union remote add fork ../pm-fork &&
> +	test_config -C pm-union remote.pushDefault fork &&
> +	test_config -C pm-union push.default current &&
> +	git -C pm-union branch one one-commit &&
> +	git -C pm-union branch --set-upstream-to=origin/next one &&
> +	git -C pm-union branch two base &&
> +	git -C pm-union branch --set-upstream-to=origin/main two &&
> +	git -C pm-union checkout --detach &&
> +
> +	git -C pm-union branch --prune-merged origin/next --prune-merged origin/main &&
> +
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged accepts a local upstream' '
> +	test_when_finished "rm -rf pm-local" &&
> +	git clone pm-upstream pm-local &&
> +	git -C pm-local remote add fork ../pm-fork &&
> +	test_config -C pm-local remote.pushDefault fork &&
> +	test_config -C pm-local push.default current &&
> +	git -C pm-local checkout -b trunk &&
> +	git -C pm-local branch one one-commit &&
> +	git -C pm-local branch --set-upstream-to=trunk one &&
> +	git -C pm-local merge --ff-only one-commit &&
> +
> +	git -C pm-local branch --prune-merged trunk &&
> +
> +	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
> +	test_when_finished "rm -rf pm-unmerged" &&
> +	git clone pm-upstream pm-unmerged &&
> +	git -C pm-unmerged remote add fork ../pm-fork &&
> +	test_config -C pm-unmerged remote.pushDefault fork &&
> +	test_config -C pm-unmerged push.default current &&
> +	git -C pm-unmerged checkout -b wip origin/wip &&
> +	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
> +	test_commit -C pm-unmerged local-only &&
> +	git -C pm-unmerged checkout - &&
> +
> +	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
> +	test_grep "not fully merged" err &&
> +	test_grep ! "If you are sure you want to delete it" err &&
> +	git -C pm-unmerged rev-parse --verify refs/heads/wip
> +'
> +
> +test_expect_success '--prune-merged is silent about not-merged-to-HEAD' '
> +	test_when_finished "rm -rf pm-nohead" &&
> +	git clone pm-upstream pm-nohead &&
> +	git -C pm-nohead remote add fork ../pm-fork &&
> +	test_config -C pm-nohead remote.pushDefault fork &&
> +	test_config -C pm-nohead push.default current &&
> +	git -C pm-nohead branch topic one-commit &&
> +	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
> +
> +	git -C pm-nohead branch --prune-merged "origin/*" 2>err &&
> +
> +	test_grep ! "not yet merged to HEAD" err &&
> +	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--prune-merged skips branches whose upstream is gone' '
> +	test_when_finished "rm -rf pm-upstream-gone" &&
> +	git clone pm-upstream pm-upstream-gone &&
> +	git -C pm-upstream-gone remote add fork ../pm-fork &&
> +	test_config -C pm-upstream-gone remote.pushDefault fork &&
> +	test_config -C pm-upstream-gone push.default current &&
> +	git -C pm-upstream-gone branch one one-commit &&
> +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
> +	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
> +
> +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged never deletes the checked-out branch' '
> +	test_when_finished "rm -rf pm-head" &&
> +	git clone pm-upstream pm-head &&
> +	git -C pm-head remote add fork ../pm-fork &&
> +	test_config -C pm-head remote.pushDefault fork &&
> +	test_config -C pm-head push.default current &&
> +	git -C pm-head checkout -b one one-commit &&
> +	git -C pm-head branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-head branch --prune-merged "origin/*" &&
> +
> +	git -C pm-head rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged spares branches that push back to their upstream' '
> +	test_when_finished "rm -rf pm-push-eq" &&
> +	git clone pm-upstream pm-push-eq &&
> +	git -C pm-push-eq checkout --detach &&
> +
> +	git -C pm-push-eq branch --prune-merged "origin/*" &&
> +
> +	git -C pm-push-eq rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged spares a per-branch pushRemote==upstream remote' '
> +	test_when_finished "rm -rf pm-push-branch" &&
> +	git clone pm-upstream pm-push-branch &&
> +	git -C pm-push-branch remote add fork ../pm-fork &&
> +	test_config -C pm-push-branch remote.pushDefault fork &&
> +	test_config -C pm-push-branch push.default current &&
> +	test_config -C pm-push-branch branch.main.pushRemote origin &&
> +	git -C pm-push-branch checkout --detach &&
> +
> +	git -C pm-push-branch branch --prune-merged "origin/*" &&
> +
> +	git -C pm-push-branch rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged prunes when @{push} differs from @{upstream}' '
> +	test_when_finished "rm -rf pm-push-diff" &&
> +	git clone pm-upstream pm-push-diff &&
> +	git -C pm-push-diff remote add fork ../pm-fork &&
> +	test_config -C pm-push-diff remote.pushDefault fork &&
> +	test_config -C pm-push-diff push.default current &&
> +	git -C pm-push-diff branch topic one-commit &&
> +	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
> +	git -C pm-push-diff checkout --detach &&
> +
> +	git -C pm-push-diff branch --prune-merged "origin/*" &&
> +
> +	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
> +'
> +
> +test_expect_success '--prune-merged requires a value' '
> +	test_must_fail git -C forked branch --prune-merged 2>err &&
> +	test_grep "requires a value" err
> +'
> +
> +test_expect_success '--prune-merged rejects positional arguments' '
> +	test_must_fail git -C forked branch --prune-merged origin/one other/foreign 2>err &&
> +	test_grep "does not take positional arguments" err
> +'
> +
>   test_done

