Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA433F588
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619338; cv=none; b=CyFAJPszCPqYltlwa5Z7Stssz/So8hGUBVn4FoSe6dLylKT2DdbZL1b/aPuoyVDYlGVuketNeCS6RvZlAgOX8EksiNsaVpwGI/ggY9dEnrJxNr9NKIM7XNjwvvKvXwBYcQMLa3Kuqf722p3miPlWPlJiXVj7VR44spT8LK9qLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619338; c=relaxed/simple;
	bh=WgQuYKXgz88ja/4X9bJWb9dJWmA1iHFQcCyNMNu77+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N0drY1eBTIuci3TDe6wiePmNntdk+8dLoKU9MzztGb6fTn6o1Ysd/I91WTTfaZF0VgiIuXwELqnieCVwUHXsn34+SOegI15HcaFMSIi3C9sN5WjvGXxTZ2GK/OZ7+H7zDdW0Stcgc5KpmZKlynohVT+1ZTGUGZG579QfvH55Ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8ogtnpa; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8ogtnpa"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a64f28d0so33757096d6.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619336; x=1792224136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wuQw3Um5ZDAMT6Pl0ZjgP31SLKEBtpV7LAayw7fptRM=;
        b=p8ogtnpagXR9MD1YdmWO25SWNpSCb2L2r2n++frrxWkh4uSNqkOnuW1sPArdT1WRGB
         sjy5chBp7r79PhhuPDLlntYWoeZVF7iYRimoovDusyQPBg6tak/zLqKquCMGPwH06mu/
         ZYELhnaFE6bQXpUlTTDoy3HIGo95ATfuVaMpE5MdYX9Gph3r0lTmMRAcdRDU7AJ5W6iU
         wtLYeLRq4qBilkSZdSNtg8Loz+FRvTAz4UR2+2u3gQ08ObNLyO78gdBvNRPb0A1dqPYl
         snbZx8DWx5EJfYMUIVIfOksAxgtpBtiKscRopzhgwkXhkcpw5j08zH6iaCJamRgnbHnF
         Rc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619336; x=1792224136;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wuQw3Um5ZDAMT6Pl0ZjgP31SLKEBtpV7LAayw7fptRM=;
        b=dtAwI7H7aA8dJn1UI1o/ULHRe7LNxZDMAX4CQtG8O2uAfG5dgo2mc09Js33RMLR6fQ
         EsDf+fTN5h+o8XJAFmWHtqvMHQnas+jVw9ePEvBiTlpCiKgGzcr/T2kRbgi9m3MRIfun
         4USArvteRPSDmdDiSX+UVu/9G3yM4GcAJWMy+BpGb7LtMDro34MdIep2BFwxedOjgptp
         1NPQuxZnIYPsRbscF7inh0N/UJmBvzajPFXKRGrGEBSix+0fToAPBvRtpvS2zEx6ycQ/
         z9kulo73++Mi6Sf4otYYFRoUGUuJ0Dprn8YPhyGbQXX90wkZBgIAOnaYM4B4x4W92t7f
         pUTA==
X-Gm-Message-State: AFq9FYJn4W0jAAjbMQkp0YeA76muKFsKIsUJ5g64Yrlf0lWgywM8Wp8i
	UT9PFwDoXQGLQrPGPiiopAVvaChj8TmftxMKgHZvV0eKVvVCL3n2TKbjal5X1A==
X-Gm-Gg: AYBFou2RQwhFYITvalrf+2Z+wXZT5LhSRkMA62WXuUb5RhlffhweshOYNw3prby5lV/
	gxoek8RIfMSeCgWmsYJreyOYWaRdcxnssya0yCi/5kV6PmuDdd70b5Wyy64hnv4wDAylZVf9TjX
	OOnfPmEzvHxcnH0Z7J3BaSHx+oD9Q0R9IP0EPoMDW472GjmK9zb+dwZ7SZtoLjmVkElpF5tBaUo
	mEMtec3Q7Zbz/xdCrUpULbKPEwAOkz6F+1n8AaomEMjrlbqz7lFTNPDRvhQElaSzbTychNH4QuQ
	Z5yao7fksnsFAiBHD5sl8XfsRxCeIguWzf/f3qH+31IoQBT7I7LDqzX+NNr/t6eV0bV/P6x6o6t
	0n0mvn6emzv1Y0NV4DZio5DKdY70uP2nyPTA+/cjcaSYLp4ohotpgD5OO/KxI1HBwxuHDbqWZDY
	eDu2wiEk9tFAaKd5vOSKElqZ2hfaSRUZnRCZIhQq7+SLWbepF3YqZxuXUPi4So+RYSN8efBN+3u
	GPm
X-Received: by 2002:a05:6214:5d0d:b0:917:9515:6a7a with SMTP id 6a1803df08f44-91b5d565090mr60244826d6.16.1791619335841;
        Sat, 10 Oct 2026 01:02:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b54e7e09dsm39322686d6.5.2026.10.10.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:02:14 -0700 (PDT)
Message-Id: <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 08:02:09 +0000
Subject: [PATCH v8 0/5] fetch: avoid fetching every branch of a new remote in a shallow repo
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

Changes in v8:

 * Split into a preliminary collect_upstream_from_remote() helper commit
   plus a simplified refmap-inference commit.
 * Fixed a regression that could drop the current branch's @{upstream} when
   remote.<name>.fetch was narrowed.
 * Threaded struct repository * through instead of hardcoding
   the_repository.
 * Minor naming and comment cleanups.

Changes in v7:

 * Fixed fatal: --refmap option is only meaningful with command-line
   refspec(s) firing just from configuring remote.<name>.refmap alone, with
   nothing else to fetch.
 * When both remote.<name>.fetch and remote.<name>.refmap are configured, a
   refspec-less fetch follows .fetch as usual, .refmap only remaps something
   already being fetched by name. Added tests.

Changes in v6:

 * Remove leftover reference to deleted default-branch logic in commit
   message.

Changes in v5:

 * Renumber test file from t5585 to t5586.

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

Harald Nordgren (5):
  fetch: add remote.<name>.refmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  84 ++++++++++++++++++----
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  51 ++++++++++++-
 remote.h                         |  19 +++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  63 ++++++++++++++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 448 insertions(+), 23 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v8
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v7:

 1:  b5db64d56f ! 1:  2a48c21bc8 fetch: add remote.<name>.refmap
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       	struct ref *rm;
       	struct ref *ref_map = NULL;
       	struct ref **tail = &ref_map;
     ++	/*
     ++	 * The --refmap command line option, if given, takes precedence
     ++	 * over remote.<name>.refmap.
     ++	 */
      +	struct refspec *effective_refmap =
      +		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
       
 -:  ---------- > 2:  08fea07a8b fetch: extract collect_upstream_from_remote() helper
 2:  fd6864daaf ! 3:  a39316d233 fetch: infer branches to fetch from a refmap-only remote
     @@ Documentation/fetch-options.adoc: endif::git-pull[]
      -`remote.<name>.refmap` provides the default value for this option, the
      -same way `remote.<name>.fetch` provides the default refspecs to fetch.
      +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
     -+there is nothing to fetch, neither on the command line nor from
     -+`remote.<name>.fetch`, Git infers what to fetch from the local branches
     -+whose `@{upstream}` is on that remote.
     ++nothing to fetch is specified on the command line, nor is there a
     ++`remote.<name>.fetch`, branches from the remote that are used as the
     ++`@{upstream}` of our local branches are fetched.
       
       `-t`::
       `--tags`::
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
     - 	struct ref **tail = &ref_map;
     + 	 */
       	struct refspec *effective_refmap =
       		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
      +	struct refspec inferred_rs;
     -+	int inferred_branches = 0;
     ++	int infer_from_refmap = 0;
       
       	/* opportunistically-updated references: */
       	struct ref *orefs = NULL, **oref_tail = &orefs;
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
      +		struct string_list tracked = STRING_LIST_INIT_DUP;
      +		struct string_list_item *item;
      +
     -+		branches_tracking_remote(remote, &tracked);
     ++		branches_tracking_remote(the_repository, remote, &tracked);
      +		for_each_string_list_item(item, &tracked)
      +			refspec_append(&inferred_rs, item->string);
      +		string_list_clear(&tracked, 0);
      +
      +		rs = &inferred_rs;
     -+		inferred_branches = 1;
     ++		infer_from_refmap = 1;
      +	}
      +
       	if (rs->nr) {
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       		for (i = 0; i < rs->nr; i++) {
      -			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
      +			get_fetch_map(remote_refs, &rs->items[i], &tail,
     -+				      inferred_branches);
     ++				      infer_from_refmap);
       			if (rs->items[i].dst && rs->items[i].dst[0])
       				*autotags = 1;
       		}
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       
       		for (i = 0; i < fetch_refspec->nr; i++)
       			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
     -+	} else if (inferred_branches) {
     ++	} else if (infer_from_refmap) {
      +		/* Already fully handled above. */
       	} else if (refmap.nr) {
       		die("--refmap option is only meaningful with command-line refspec(s)");
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       }
       
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
     + 				    item->string);
     + 		string_list_clear(&tracked, 0);
       	} else {
     - 		struct branch *branch = branch_get(NULL);
     --
     --		if (transport->remote->fetch.nr) {
     -+		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
     -+			!strcmp(branch->remote_name, transport->remote->name);
     ++		/*
     ++		 * The --refmap command line option, if given, takes
     ++		 * precedence over remote.<name>.refmap.
     ++		 */
      +		struct refspec *effective_refmap = refmap.nr ? &refmap :
      +			&transport->remote->refmap;
     -+		int inferred_branches = !transport->remote->fetch.nr &&
     -+			effective_refmap->nr;
     -+
     -+		if (inferred_branches) {
     -+			struct string_list tracked = STRING_LIST_INIT_DUP;
     -+			struct string_list_item *item;
     -+
     -+			branches_tracking_remote(transport->remote, &tracked);
     -+			for_each_string_list_item(item, &tracked)
     -+				strvec_push(&transport_ls_refs_options.ref_prefixes,
     -+					    item->string);
     -+			string_list_clear(&tracked, 0);
     -+		} else if (transport->remote->fetch.nr) {
     - 			refspec_ref_prefixes(&transport->remote->fetch,
     - 					     &transport_ls_refs_options.ref_prefixes);
     --			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     --				do_set_head = 1;
     - 		}
     --		if (branch && branch_has_merge_config(branch) &&
     --		    !strcmp(branch->remote_name, transport->remote->name)) {
     -+		if ((transport->remote->fetch.nr || inferred_branches) &&
     -+		    follow_remote_head != FOLLOW_REMOTE_NEVER)
     -+			do_set_head = 1;
     -+		if (tracks_this_remote) {
     - 			int i;
     - 			for (i = 0; i < branch->merge_nr; i++) {
     - 				strvec_push(&transport_ls_refs_options.ref_prefixes,
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 
     - 	ref_map = get_ref_map(transport->remote, remote_refs, rs,
     - 			      tags, &autotags);
     -+
     - 	if (!update_head_ok)
     - 		check_not_current_branch(ref_map);
     + 		struct string_list tracked = STRING_LIST_INIT_DUP;
     + 		struct string_list_item *item;
       
     +-		collect_upstream_from_remote(the_repository, &tracked,
     +-					      transport->remote, NULL);
     ++		if (effective_refmap->nr) {
     ++			branches_tracking_remote(the_repository,
     ++						  transport->remote, &tracked);
     ++			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     ++				do_set_head = 1;
     ++		} else {
     ++			collect_upstream_from_remote(the_repository, &tracked,
     ++						      transport->remote, NULL);
     ++		}
     + 		for_each_string_list_item(item, &tracked)
     + 			strvec_push(&transport_ls_refs_options.ref_prefixes,
     + 				    item->string);
      
       ## remote.c ##
     -@@ remote.c: int branch_merge_matches(struct branch *branch,
     - 	return refname_match(branch->merge[i]->src, refname);
     +@@ remote.c: void collect_upstream_from_remote(struct repository *repo,
     + 		string_list_insert(tracked, branch->merge[i]->src);
       }
       
      +struct branches_tracking_remote_cb_data {
     ++	struct repository *repo;
      +	struct remote *remote;
      +	struct string_list *tracked;
      +};
     @@ remote.c: int branch_merge_matches(struct branch *branch,
      +static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
      +{
      +	struct branches_tracking_remote_cb_data *data = cb_data;
     -+	struct branch *branch;
     -+
     -+	branch = branch_get(ref->name);
     -+	if (!branch_has_merge_config(branch) ||
     -+	    strcmp(branch->remote_name, data->remote->name))
     -+		return 0;
     -+
     -+	for (int i = 0; i < branch->merge_nr; i++)
     -+		string_list_insert(data->tracked, branch->merge[i]->src);
      +
     ++	collect_upstream_from_remote(data->repo, data->tracked, data->remote,
     ++				      ref->name);
      +	return 0;
      +}
      +
     -+void branches_tracking_remote(struct remote *remote, struct string_list *tracked)
     ++void branches_tracking_remote(struct repository *repo, struct remote *remote,
     ++			       struct string_list *tracked)
      +{
     -+	struct branches_tracking_remote_cb_data data = { remote, tracked };
     ++	struct branches_tracking_remote_cb_data data = { repo, remote, tracked };
      +
     -+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     ++	refs_for_each_branch_ref(get_main_ref_store(repo),
      +				  add_if_tracking_remote, &data);
      +}
      +
     @@ remote.c: int branch_merge_matches(struct branch *branch,
       {
      
       ## remote.h ##
     -@@ remote.h: int branch_has_merge_config(struct branch *branch);
     - 
     - int branch_merge_matches(struct branch *, int n, const char *);
     +@@ remote.h: void collect_upstream_from_remote(struct repository *repo,
     + 				   struct remote *remote,
     + 				   const char *refname);
       
      +/* fills tracked with the refname of every local branch's upstream on remote */
     -+void branches_tracking_remote(struct remote *remote, struct string_list *tracked);
     ++void branches_tracking_remote(struct repository *repo, struct remote *remote,
     ++			       struct string_list *tracked);
      +
       /* list of the remote in a group as configured */
       struct remote_group_data {
 3:  a2208875b6 = 4:  2b974bbe0a remote: add "git remote add --limited-fetch"
 4:  c8fd073de3 = 5:  db27c29086 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget
