Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2484CE685
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673617; cv=none; b=DisIJO2H7kzQGugKf5D+ZxmEYDaMqxsWXFM4mtT++SngIbgIvhI/v7IXFZA1yffskZqfO64HkU8+QFddxklVsYpHoiwk7i/iWboOkUMb4RbhTUAKi64wFPH13ces8IuR8+6ov6576OecD0Vk6LMSZABDGXvNxoP4LTV1XXQpgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673617; c=relaxed/simple;
	bh=FORvyk6NOfdag/ylfbGFlF83m6MWvcetxMSTNp89KEg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TJHbu1cOIeIC5Xr2bH+wT9f12K1hVq6Y1P6h74Iy9jdR0CBayuc5r6mm28BjuffRi7lzFnTKPbd5CCWWS7yTrFV6KjwBgLClHf/ys+5K9T3523Ha49S6rwoRDnaxmCfpsiCiTH6f/f1qaoMbdC/n4vj0loLIaOPkuo9YCdc79+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldGuro6T; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldGuro6T"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-914274b9bfaso1901356d6.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673600; x=1791278400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h7yObsUY6IZ5bePMIbsml64pGOtV3NPbUWylUVDaXBo=;
        b=ldGuro6TVAPIp4I3B2/jO5g9KyoaUP/l4E0BnZ+pfAEXezQw/qXyx4F6JBIwVrgW5J
         JHZe6mN5JWjV8tRawnuGPnxmmxx5z2UYD8/3FwJq3Q2Ctszct7650kWMNubAHNgQc+uD
         uYWNb5wwevfS7QNET5VtAamK7P/bzJ5LQ1aka+/T3wAnR9llQbBvkz3EyhrG3aDjAMDP
         5mpb0/k6tZ9lfyxJl+TNIMKSIYxVXpQOc+Bn3KDMsdLlitwbHsdYoZ+4wosj/UP2d5vX
         +6Q715vheMc65X8xt5iwtEWFstlQrqi1LU/YyGe3Azu19vqwD3VM6JMlRRRqz7VxP+N4
         4nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673600; x=1791278400;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7yObsUY6IZ5bePMIbsml64pGOtV3NPbUWylUVDaXBo=;
        b=D5vMpNCJDnLU4qJe3lPZFnxvMHyBucdW12b4oofEgO4Sx3aFeOTmGSJGVVddhbLP5t
         XcMk8R6JfmuOD3RtwoLNmrjOXGkr0/8jlFkXOVWUsSf34HgrZyGbOLmQEH8ofNcxEPqw
         CeTTv0UaMAVZE4Pdzl9XXcgSwuP+I/vSPEe9f7bm+7E0nAZy8R4XVVy2+qBqPn+Vh+3W
         UsIyW8h+dH4Jl/h2PfUtB4yt/bbT1maDXEFamyQ++9VqnK2IgTjMwljDsNXQN6q8yHjd
         g/Wheco/t7UUkEJjNvquWn8pYKpnZ1G6JllX1ocXLDLwfaaVHMfHiTVJYja9rNM/RKGf
         vGFA==
X-Gm-Message-State: AFq9FYIWd+m01aRnU0PmANir7dvp/z2OHIbwNH9wztbHKw4J1515yrTI
	EHNFAoCTYVb4FKhhwVZEa5v6W4hEx8xw7jSMZct9wi4qiez6zTDs32swkBnY5g==
X-Gm-Gg: AYBFou0sSXEsnNuWPmIluoPC5SdbVPyJ5f+EkEbCUdtdH0Ku/7evI3inNHBHSq8SILj
	CFm8ExRBWQB1AOqS1SDcfy4N6CrVzUrAOo+OJWq4vz5t4GxAtxkKV8B0RJdxagEVDcSyOivdySi
	kRru7t5UBrqFBugd+eFQOtAS5SSm6QmuMn6YGUh8PZFuXgh6M+djhfjKDCZEAqoyDqyL/hxVOdT
	kYZgUWCezavsViDTgPem/o3qxVabJgeGJHlQoLXJrxSDjceWkG/a9f6bO3yr2fjvP2gSRIYp/6B
	gxDeX45w+BDdycQqKz36KYbjYL22MsjHhAAEm1gXVOj/RYsfXtrDKaFB7+nLYb7+q2LkS7nvdvh
	9rYO6U+hRWDtigeA2Kd/3XJqt4G40zR6xOcHAbwZiMEG0W0nh/cgph/E5Dg3jGzDy87xixeOYqC
	1pAglBaAd4eW3larv+3TcUuflzgY01aoaIJ1VOgEyHWKstm7yWvf7x5PgTRQbB2kjTDY+q5ZBZe
	s8=
X-Received: by 2002:a05:6214:2f89:b0:912:4680:c96f with SMTP id 6a1803df08f44-9142f6c3868mr282990966d6.3.1790673599968;
        Tue, 29 Sep 2026 02:19:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d325e09sm6124626d6.22.2026.09.29.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:19:59 -0700 (PDT)
Message-Id: <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 09:19:54 +0000
Subject: [PATCH v4 0/4] fetch: avoid fetching every branch of a new remote in a shallow repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (4):
  fetch: add remote.<name>.refmap
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  60 +++++++++++++---
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  41 ++++++++++-
 remote.h                         |   9 +++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  17 +++++
 t/t5585-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 363 insertions(+), 18 deletions(-)
 create mode 100755 t/t5585-fetch-refmap.sh


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v4
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v3:

 1:  b04c00b974 ! 1:  d48a7004e4 fetch: add remote.<name>.refmap
     @@ Commit message
      
          Add a per-remote config variable, remote.<name>.refmap, that provides
          the default value for --refmap the same way remote.<name>.fetch
     -    already provides the default refspecs to fetch. It only takes effect
     -    when there is something explicit to fetch, on the command line or via
     -    remote.<name>.fetch, matching how --refmap itself already behaves.
     +    already provides the default refspecs to fetch. Like --refmap itself,
     +    it only maps refs that are actually being fetched, so it has nothing
     +    to do when there is nothing explicit to fetch, on the command line or
     +    via remote.<name>.fetch.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/config/remote.adoc: remote.<name>.fetch::
       
      +remote.<name>.refmap::
      +	The default value of the `--refmap` option for linkgit:git-fetch[1].
     -+	Only takes effect when the fetch names what to fetch explicitly,
     -+	either on the command line or via `remote.<name>.fetch`. See the
     -+	`--refmap` entry in linkgit:git-fetch[1].
     ++	Used to map remote refs being fetched to remote-tracking refs to
     ++	store. See the `--refmap` entry in linkgit:git-fetch[1].
      +
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
 2:  4ec508a223 ! 2:  45b26e2bb2 fetch: infer branches to fetch from a refmap-only remote
     @@ Commit message
          says where to put fetched refs, not what to fetch.
      
          Make that case infer what to fetch: the local branches whose
     -    @{upstream} is already on that remote, plus the remote's default
     -    branch, which is always included so it is available even before
     -    anything is set up to track it. This lets a remote be configured to
     -    fetch only the branches actually in use, without listing them by
     -    hand in remote.<name>.fetch, and without needing to touch the
     -    command line every time.
     +    @{upstream} is already on that remote. This lets a remote be
     +    configured to fetch only the branches actually in use, without
     +    listing them by hand in remote.<name>.fetch, and without needing to
     +    touch the command line every time.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/config/remote.adoc ##
      @@ Documentation/config/remote.adoc: remote.<name>.fetch::
     - 
       remote.<name>.refmap::
       	The default value of the `--refmap` option for linkgit:git-fetch[1].
     --	Only takes effect when the fetch names what to fetch explicitly,
     --	either on the command line or via `remote.<name>.fetch`. See the
     --	`--refmap` entry in linkgit:git-fetch[1].
     -+	If `remote.<name>.fetch` is not set either, a refspec-less fetch
     -+	infers what to fetch from local branches built on this remote,
     -+	instead of fetching every branch it has. See the `--refmap` entry
     -+	in linkgit:git-fetch[1].
     + 	Used to map remote refs being fetched to remote-tracking refs to
     +-	store. See the `--refmap` entry in linkgit:git-fetch[1].
     ++	store. If `remote.<name>.fetch` is not set either, a refspec-less
     ++	fetch infers what to fetch from local branches built on this
     ++	remote, instead of fetching every branch it has. See the
     ++	`--refmap` entry in linkgit:git-fetch[1].
       
       remote.<name>.push::
       	The default set of "refspec" for linkgit:git-push[1]. See
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
      +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
      +there is nothing to fetch, neither on the command line nor from
      +`remote.<name>.fetch`, Git infers what to fetch from the local branches
     -+whose `@{upstream}` is on that remote, plus the remote's default branch,
     -+which is always included so that it is available even before anything
     -+is set up to track it.
     ++whose `@{upstream}` is on that remote.
       
       `-t`::
       `--tags`::
      
       ## builtin/fetch.c ##
     -@@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
     - static struct ref *get_ref_map(struct remote *remote,
     - 			       const struct ref *remote_refs,
     - 			       struct refspec *rs,
     --			       int tags, int *autotags)
     -+			       int tags, int *autotags,
     -+			       char **bootstrap_head_branch)
     - {
     - 	int i;
     - 	struct ref *rm;
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	struct ref **tail = &ref_map;
       	struct refspec *effective_refmap =
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      +	    effective_refmap && effective_refmap->nr) {
      +		struct string_list tracked = STRING_LIST_INIT_DUP;
      +		struct string_list_item *item;
     -+		struct ref *head;
     -+		char *default_branch = NULL;
     -+		char *default_branch_dst = NULL;
      +
      +		branches_tracking_remote(remote, &tracked);
      +		for_each_string_list_item(item, &tracked)
      +			refspec_append(&inferred_rs, item->string);
     -+
     -+		/* Always fetch the default branch too, as "HEAD". */
     -+		head = get_remote_ref(remote_refs, "HEAD");
     -+		if (head && head->symref && *head->symref)
     -+			default_branch = xstrdup(head->symref);
     -+		free_one_ref(head);
     -+
     -+		for (i = 0; default_branch && !default_branch_dst &&
     -+			    !string_list_has_string(&tracked, default_branch) &&
     -+			    i < effective_refmap->nr; i++) {
     -+			struct refspec_item *map = &effective_refmap->items[i];
     -+
     -+			if (map->pattern)
     -+				match_refname_with_pattern(map->src, default_branch,
     -+							    map->dst, &default_branch_dst);
     -+			else if (!strcmp(map->src, default_branch))
     -+				default_branch_dst = xstrdup(map->dst);
     -+		}
     -+
     -+		if (default_branch_dst) {
     -+			struct refspec_item head_item = { .force = 1 };
     -+
     -+			head_item.src = xstrdup("HEAD");
     -+			head_item.dst = default_branch_dst;
     -+			get_fetch_map(remote_refs, &head_item, &tail, 1);
     -+			free(head_item.src);
     -+		}
     -+
     -+		if (default_branch && bootstrap_head_branch) {
     -+			const char *branch_name = default_branch;
     -+			skip_prefix(branch_name, "refs/heads/", &branch_name);
     -+			*bootstrap_head_branch = xstrdup(branch_name);
     -+		}
     -+
     -+		free(default_branch);
     -+		free(default_branch_dst);
      +		string_list_clear(&tracked, 0);
      +
      +		rs = &inferred_rs;
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	return ref_map;
       }
       
     -@@ builtin/fetch.c: static void warn_set_head(const char *remote, const char *head_name,
     - }
     - 
     - static int set_head(const struct ref *remote_refs, struct remote *remote,
     --			int follow_remote_head)
     -+			int follow_remote_head, const char *known_head_branch)
     - {
     - 	int result = 0, create_only, baremirror, was_detached;
     - 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
     - 		      b_local_head = STRBUF_INIT;
     - 	const char *no_warn_branch = remote->no_warn_branch;
     - 	char *head_name = NULL;
     --	struct ref *ref, *matches;
     -+	struct ref *ref, *matches = NULL;
     - 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
     - 	struct refspec_item refspec = {
     - 		.force = 0,
     -@@ builtin/fetch.c: static int set_head(const struct ref *remote_refs, struct remote *remote,
     - 	struct string_list heads = STRING_LIST_INIT_DUP;
     - 	struct ref_store *refs = get_main_ref_store(the_repository);
     - 
     --	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
     --	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
     --				    fetch_map, REMOTE_GUESS_HEAD_ALL);
     --	for (ref = matches; ref; ref = ref->next) {
     --		string_list_append(&heads, strip_refshead(ref->name));
     --	}
     -+	if (known_head_branch) {
     -+		head_name = xstrdup(known_head_branch);
     -+	} else {
     -+		get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
     -+		matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
     -+					    fetch_map, REMOTE_GUESS_HEAD_ALL);
     -+		for (ref = matches; ref; ref = ref->next) {
     -+			string_list_append(&heads, strip_refshead(ref->name));
     -+		}
     - 
     --	if (!heads.nr)
     --		result = 1;
     --	else if (heads.nr > 1)
     --		result = 1;
     --	else
     --		head_name = xstrdup(heads.items[0].string);
     -+		if (!heads.nr)
     -+			result = 1;
     -+		else if (heads.nr > 1)
     -+			result = 1;
     -+		else
     -+			head_name = xstrdup(heads.items[0].string);
     -+	}
     - 
     - 	if (!head_name)
     - 		goto cleanup;
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 	struct strmap rejected_refs = STRMAP_INIT;
     - 	int summary_width = 0;
     - 	int follow_remote_head;
     -+	char *bootstrap_head_branch = NULL;
     - 
     - 	if (tags == TAGS_DEFAULT) {
     - 		if (transport->remote->fetch_tags == 2)
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
       	} else {
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      +				strvec_push(&transport_ls_refs_options.ref_prefixes,
      +					    item->string);
      +			string_list_clear(&tracked, 0);
     -+			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
      +		} else if (transport->remote->fetch.nr) {
       			refspec_ref_prefixes(&transport->remote->fetch,
       					     &transport_ls_refs_options.ref_prefixes);
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       			for (i = 0; i < branch->merge_nr; i++) {
       				strvec_push(&transport_ls_refs_options.ref_prefixes,
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 	transport_ls_refs_options_release(&transport_ls_refs_options);
       
       	ref_map = get_ref_map(transport->remote, remote_refs, rs,
     --			      tags, &autotags);
     -+			      tags, &autotags, &bootstrap_head_branch);
     + 			      tags, &autotags);
      +
       	if (!update_head_ok)
       		check_not_current_branch(ref_map);
       
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 		 * Way too many cases where this can go wrong so let's just
     - 		 * ignore errors and fail silently for now.
     - 		 */
     --		set_head(remote_refs, transport->remote, follow_remote_head);
     -+		set_head(remote_refs, transport->remote, follow_remote_head,
     -+			 bootstrap_head_branch);
     - 	}
     - 
     - cleanup:
     -+	free(bootstrap_head_branch);
     - 	/*
     - 	 * When using batched updates, we want to commit the non-rejected
     - 	 * updates and also handle the rejections.
      
       ## remote.c ##
      @@ remote.c: int branch_merge_matches(struct branch *branch,
     @@ t/t5585-fetch-refmap.sh (new)
      +
      +When a remote has a refmap configured but no fetch refspec, a
      +refspec-less fetch infers what to fetch from the local branches whose
     -+@{upstream} is on that remote, plus the default branch of that remote,
     -+which is always included so that it is available even before anything
     -+is set up to track it.
     ++@{upstream} is on that remote.
      +'
      +
      +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     @@ t/t5585-fetch-refmap.sh (new)
      +	)
      +'
      +
     -+test_expect_success 'fetching the new remote does not need every branch it has' '
     ++test_expect_success 'a bare fetch needs nothing until a branch is tracked' '
      +	(
      +		cd client &&
      +		git fetch upstream &&
      +		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
     -+		cat >expect <<-\EOF &&
     -+		refs/remotes/upstream/HEAD
     -+		refs/remotes/upstream/main
     -+		EOF
     -+		test_cmp expect actual
     ++		test_must_be_empty actual
      +	)
      +'
      +
     -+test_expect_success 'set-upstream-to now resolves right after that first fetch' '
     ++test_expect_success 'an explicit one-time fetch lets a branch be tracked' '
      +	(
      +		cd client &&
     -+		git branch --set-upstream-to=upstream &&
     ++		git fetch upstream main &&
     ++		git branch --set-upstream-to=upstream/main &&
      +		test_cmp_config upstream branch.main.remote &&
      +		test_cmp_config refs/heads/main branch.main.merge
      +	)
 3:  604e584956 ! 3:  e2f072c254 remote: add "git remote add --limited-fetch"
     @@ Documentation/git-remote.adoc: the `refs/remotes/<name>/` namespace, a refspec t
      +With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
      +that tracks all branches, `remote.<name>.refmap` is set up so that a
      +refspec-less `git fetch <name>` only fetches branches our local branches
     -+are built on, plus the remote's default branch. See the `--refmap` entry
     -+in linkgit:git-fetch[1] for details.
     ++are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
     ++details.
      ++
       With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
       up to point at remote's _<master>_ branch. See also the set-head command.
 4:  31462e9445 ! 4:  43b9711a2c remote: default to --limited-fetch in a shallow repository
     @@ Documentation/git-remote.adoc: Add a remote named _<name>_ for the repository at
      @@ Documentation/git-remote.adoc: With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
       that tracks all branches, `remote.<name>.refmap` is set up so that a
       refspec-less `git fetch <name>` only fetches branches our local branches
     - are built on, plus the remote's default branch. See the `--refmap` entry
     --in linkgit:git-fetch[1] for details.
     -+in linkgit:git-fetch[1] for details. `--no-limited-fetch` explicitly
     -+disables this, overriding the shallow-repository default described above.
     + are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
     +-details.
     ++details. `--no-limited-fetch` explicitly disables this, overriding the
     ++shallow-repository default described above.
       +
       With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
       up to point at remote's _<master>_ branch. See also the set-head command.
     @@ t/t5505-remote.sh: test_expect_success 'filters are listed by git remote -v only
      +		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
      +			remote.upstream.refmap &&
      +		test_must_fail git config get remote.upstream.fetch &&
     ++		git fetch upstream main &&
     ++		git branch --set-upstream-to=upstream/main &&
     ++		test_cmp_config upstream branch.main.remote &&
     ++		test_cmp_config refs/heads/main branch.main.merge &&
      +		git fetch upstream &&
      +		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
      +		cat >expect <<-\EOF &&
      +		refs/remotes/upstream/HEAD
      +		refs/remotes/upstream/main
      +		EOF
     -+		test_cmp expect actual &&
     -+		git branch --set-upstream-to=upstream &&
     -+		test_cmp_config upstream branch.main.remote &&
     -+		test_cmp_config refs/heads/main branch.main.merge
     ++		test_cmp expect actual
      +	)
      +'
      +

-- 
gitgitgadget
