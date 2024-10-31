Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472719CCF9
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378171; cv=none; b=M65NxzOoRJyw1J6p80GEJ6A1bo2rPwQQPzd8z8MXSmRnyqSu86hLOdd/zYVRwhva1pQGQYIh5EdbfHHiR10qsACYRndRleX2P8+/SF38T9ldXeEOLtBQJ6oHXOwjMnDUHMi45UTlyIp8luKHBzGZhWqC5Vt8fXubHsrVDc7pkQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378171; c=relaxed/simple;
	bh=ogdd1/UVhEjSMqMbkbxcz4HUmJfUXWpIs92B5KxuuwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ8dy7bma0nxjbeu0K4Ded/83PWCf8f6oJljIF6dEck+2/FhDf52r+HTmxFd4Yq3NxImk4EaG6hZQcbLZHkfdESA0aiu9qQvkmi2FWp6qJda96+JdVL/BH08YAB4t+OZv8YQnP9jOIoxjHtKz2wEEQZbYPQoaCiIlyvsfp2WVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUrnDVh4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUrnDVh4"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2918664a3fso757609276.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378164; x=1730982964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6znEM4XlgE1uwmWpiMPMo1soasNwI3rrD79HU5u1NxI=;
        b=RUrnDVh4r0DY4zzb+e+hZPxee0oUb1hiIB664wo0Ba7eFrr5B8rINa5iPlyW8Y+hFm
         wUDHt2U9stTyLo0xjVnNbe/OeEc6iZVCB+2Q7Y0+YkFk157itble6PdNh9ONc54hcKUA
         vS2Mru4Sser2124xNXvcwOl56ADa40aL5syma8Eckv1H4KqMs7fe58wXFBWGL9H29m7U
         m8JQDoSw+K+o6de7aSSyvOGzUap5erNEy7py/B3kWs0VEKDZ+wRVnpkA+s3bFi/VslGb
         0DXdgE/iZes/5lZ8v2Luv208XAuA1a1fsG+DBTGZQGtM5cM+zWefg1ttk+B5yY1eZjJO
         0vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378164; x=1730982964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6znEM4XlgE1uwmWpiMPMo1soasNwI3rrD79HU5u1NxI=;
        b=cQUkfuJhNcavOzd5ywI2CfyaV95h0H1LP7VhZ6NPPh1hGIFTG0Vf54QrX1BH56u65e
         ZL+3o2Rb5+FAgRP6cYdKiMwaDYkq5Ww0lkO+K4D4mynqKB+f4zAq9TNk3feFD9thszfY
         3+IkAQV2bsstiHkcppgJDdx/1t5h0TdZmDYW/tRBZk0VmOAaF7W2hnzljewlyvm2ceG5
         Wsiipr/3KaFc66t7WAt77VjHnWI9/wrRHdk4r0sFXh52uSUl2biIuwi3jsmu5rLMvYu/
         7Vfy9WL1LrASf4vhjWZmLpTtCubqjItWgs4L38Dv42D028ThoEsWwzHWH4vc6YrbXv1c
         qSzw==
X-Forwarded-Encrypted: i=1; AJvYcCXhPu5nz+vGNn+ZfCazatAIElhd/auG7CWnxxpjOmI49nLieyl/wbW4bNDVZie2rcAH46s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLL17bkvreOqoGvYG9nJThWhf6REoYkfx6FlnU9b3nrmi2KbBk
	xIrWKpjS3kAwrZvOKjDBUP50gtKZZVBzjMRe6Dg7ig445sghU+uF3JRreXcI
X-Google-Smtp-Source: AGHT+IFu8nwAsvQ3erESDl8KWpwLdZDrkJmvIxacIYRSg2gp45ZxbjxVvxhJHfQRaWR+EsHo7sQRWw==
X-Received: by 2002:a25:8741:0:b0:e29:2d4a:a3ff with SMTP id 3f1490d57ef6-e30e8d664bdmr1417961276.25.1730378163788;
        Thu, 31 Oct 2024 05:36:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c963:384a:338d:bad6? ([2600:1700:60ba:9810:c963:384a:338d:bad6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55cd3ab3sm2180677b3.145.2024.10.31.05.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 05:36:03 -0700 (PDT)
Message-ID: <d467d241-4989-45aa-bf15-c2ead7b74240@gmail.com>
Date: Thu, 31 Oct 2024 08:36:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/24 2:26 AM, Derrick Stolee via GitGitGadget wrote:

> This is a new series that rerolls the initial "path-walk API" patches of my
> RFC [1] "Path-walk API and applications". This new API (in path-walk.c and
> path-walk.h) presents a new way to walk objects such that trees and blobs
> are walked in batches according to their path.
> 
> This also replaces the previous version of ds/path-walk that was being
> reviewed in [2]. The consensus was that the series was too long/dense and
> could use some reduction in size. This series takes the first few patches,
> but also makes some updates (which will be described later).
> 
> [1]
> https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/
> [RFC] Path-walk API and applications
> 
> [2]
> https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/
> [PATCH v2 00/17] pack-objects: add --path-walk option for better deltas
...
> I will include a full range diff relative to the previous versions of these
> patches in [2] in a reply to this cover letter.
Here is the promised range-diff:

1:  98bdc94a773 ! 1:  c71f0a0e361 path-walk: introduce an object walk by path
     @@ Commit message

          In anticipation of a few planned applications, introduce the most 
basic form
          of a path-walk API. It currently assumes that there are no UNINTERESTING
     -    objects and does not include any complicated filters. It calls a function
     +    objects, and does not include any complicated filters. It calls a function
          pointer on groups of tree and blob objects as grouped by path. This only
          includes objects the first time they are discovered, so an object that
          appears at multiple paths will not be included in two batches.

     +    These batches are collected in 'struct type_and_oid_list' objects, which
     +    store an object type and an oid_array of objects.
     +
     +    The data structures are documented in 'struct path_walk_context', but in
     +    summary the most important are:
     +
     +      * 'paths_to_lists' is a strmap that connects a path to a
     +        type_and_oid_list for that path. To avoid conflicts in path names,
     +        we make sure that tree paths end in "/" (except the root path with
     +        is an empty string) and blob paths do not end in "/".
     +
     +      * 'path_stack' is a string list that is added to in an append-only
     +        way. This stores the stack of our depth-first search on the heap
     +        instead of using recursion.
     +
     +      * 'path_stack_pushed' is a strmap that stores path names that were
     +        already added to 'path_stack', to avoid repeating paths in the
     +        stack. Mostly, this saves us from quadratic lookups from doing
     +        unsorted checks into the string_list.
     +
     +    The coupling of 'path_stack' and 'path_stack_pushed' is protected by the
     +    push_to_stack() method. Call this instead of inserting into these
     +    structures directly.
     +
     +    The walk_objects_by_path() method initializes these structures and
     +    starts walking commits from the given rev_info struct. The commits are
     +    used to find the list of root trees which populate the start of our
     +    depth-first search.
     +
     +    The core of our depth-first search is in a while loop that continues
     +    while we have not indicated an early exit and our 'path_stack' still has
     +    entries in it. The loop body pops a path off of the stack and "visits"
     +    the path via the walk_path() method.
     +
     +    The walk_path() method gets the list of OIDs from the 'path_to_lists'
     +    strmap and executes the callback method on that list with the given path
     +    and type. If the OIDs correspond to tree objects, then iterate over all
     +    trees in the list and run add_children() to add the child objects to
     +    their own lists, adding new entries to the stack if necessary.
     +
     +    In testing, this depth-first search approach was the one that used the
     +    least memory while iterating over the object lists. There is still a
     +    chance that repositories with too-wide path patterns could cause memory
     +    pressure issues. Limiting the stack size could be done in the future by
     +    limiting how many objects are being considered in-progress, or by
     +    visiting blob paths earlier than trees.
     +
          There are many future adaptations that could be made, but they are 
left for
          future updates when consumers are ready to take advantage of those 
features.

     @@ Documentation/technical/api-path-walk.txt (new)
      +multiple paths possible to reach the same object, then only one of those
      +paths is used to visit the object.
      +
     -+When walking a range of commits with some `UNINTERESTING` objects, the
     -+objects with the `UNINTERESTING` flag are included in these batches. In
     -+order to walk `UNINTERESTING` objects, the `--boundary` option must be
     -+used in the commit walk in order to visit `UNINTERESTING` commits.
     -+
      +Basics
      +------
      +
     @@ Documentation/technical/api-path-walk.txt (new)
      +`revs` struct. The revision walk should only be used to walk commits, and
      +the objects will be walked in a separate way based on those starting
      +commits.
     -++
     -+If you want the path-walk API to emit `UNINTERESTING` objects based on the
     -+commit walk's boundary, be sure to set `revs.boundary` so the boundary
     -+commits are emitted.
      +
      +Examples
      +--------
     @@ path-walk.c (new)
      +	/**
      +	 * Store the current list of paths in a stack, to
      +	 * facilitate depth-first-search without recursion.
     ++	 *
     ++	 * Use path_stack_pushed to indicate whether a path
     ++	 * was previously added to path_stack.
      +	 */
      +	struct string_list path_stack;
     ++	struct strset path_stack_pushed;
      +};
      +
     ++static void push_to_stack(struct path_walk_context *ctx,
     ++			  const char *path)
     ++{
     ++	if (strset_contains(&ctx->path_stack_pushed, path))
     ++		return;
     ++
     ++	strset_add(&ctx->path_stack_pushed, path);
     ++	string_list_append(&ctx->path_stack, path);
     ++}
     ++
      +static int add_children(struct path_walk_context *ctx,
      +			const char *base_path,
      +			struct object_id *oid)
     @@ path-walk.c (new)
      +		if (!o) /* report error?*/
      +			continue;
      +
     -+		/* Skip this object if already seen. */
     -+		if (o->flags & SEEN)
     -+			continue;
     -+		o->flags |= SEEN;
     -+
      +		strbuf_setlen(&path, base_len);
      +		strbuf_add(&path, entry.path, entry.pathlen);
      +
     @@ path-walk.c (new)
      +			CALLOC_ARRAY(list, 1);
      +			list->type = type;
      +			strmap_put(&ctx->paths_to_lists, path.buf, list);
     -+			string_list_append(&ctx->path_stack, path.buf);
      +		}
     ++		push_to_stack(ctx, path.buf);
     ++
     ++		/* Skip this object if already seen. */
     ++		if (o->flags & SEEN)
     ++			continue;
     ++		o->flags |= SEEN;
      +		oid_array_append(&list->oids, &entry.oid);
      +	}
      +
     @@ path-walk.c (new)
      +		.revs = info->revs,
      +		.info = info,
      +		.path_stack = STRING_LIST_INIT_DUP,
     ++		.path_stack_pushed = STRSET_INIT,
      +		.paths_to_lists = STRMAP_INIT
      +	};
      +
     @@ path-walk.c (new)
      +	CALLOC_ARRAY(root_tree_list, 1);
      +	root_tree_list->type = OBJ_TREE;
      +	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
     ++	push_to_stack(&ctx, root_path);
      +
      +	if (prepare_revision_walk(info->revs))
      +		die(_("failed to setup revision walk"));
      +
      +	while ((c = get_revision(info->revs))) {
      +		struct object_id *oid = get_commit_tree_oid(c);
     -+		struct tree *t = lookup_tree(info->revs->repo, oid);
     ++		struct tree *t;
      +		commits_nr++;
      +
     -+		if (t) {
     -+			if (t->object.flags & SEEN)
     -+				continue;
     -+			t->object.flags |= SEEN;
     -+			oid_array_append(&root_tree_list->oids, oid);
     -+		} else {
     ++		oid = get_commit_tree_oid(c);
     ++		t = lookup_tree(info->revs->repo, oid);
     ++
     ++		if (!t) {
      +			warning("could not find tree %s", oid_to_hex(oid));
     ++			continue;
      +		}
     ++
     ++		if (t->object.flags & SEEN)
     ++			continue;
     ++		t->object.flags |= SEEN;
     ++		oid_array_append(&root_tree_list->oids, oid);
      +	}
      +
      +	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
      +	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
      +
     -+	string_list_append(&ctx.path_stack, root_path);
     -+
      +	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
      +	while (!ret && ctx.path_stack.nr) {
      +		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
     @@ path-walk.c (new)
      +	trace2_region_leave("path-walk", "path-walk", info->revs->repo);
      +
      +	clear_strmap(&ctx.paths_to_lists);
     ++	strset_clear(&ctx.path_stack_pushed);
      +	string_list_clear(&ctx.path_stack, 0);
      +	return ret;
      +}
5:  6e89fb219b5 ! 2:  4f9f898fec1 revision: create mark_trees_uninteresting_dense()
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>

       ## Commit message ##
     -    revision: create mark_trees_uninteresting_dense()
     +    test-lib-functions: add test_cmp_sorted

     -    The sparse tree walk algorithm was created in d5d2e93577e (revision:
     -    implement sparse algorithm, 2019-01-16) and involves using the
     -    mark_trees_uninteresting_sparse() method. This method takes a repository
     -    and an oidset of tree IDs, some of which have the UNINTERESTING flag and
     -    some of which do not.
     -
     -    Create a method that has an equivalent set of preconditions but uses a
     -    "dense" walk (recursively visits all reachable trees, as long as they
     -    have not previously been marked UNINTERESTING). This is an important
     -    difference from mark_tree_uninteresting(), which short-circuits if the
     -    given tree has the UNINTERESTING flag.
     -
     -    A use of this method will be added in a later change, with a condition
     -    set whether the sparse or dense approach should be used.
     +    This test helper will be helpful to reduce repeated logic in
     +    t6601-path-walk.sh, but may be helpful elsewhere, too.

          Signed-off-by: Derrick Stolee <stolee@gmail.com>

     - ## revision.c ##
     -@@ revision.c: static void add_children_by_path(struct repository *r,
     - 	free_tree_buffer(tree);
     + ## t/test-lib-functions.sh ##
     +@@ t/test-lib-functions.sh: test_cmp () {
     + 	eval "$GIT_TEST_CMP" '"$@"'
       }

     -+void mark_trees_uninteresting_dense(struct repository *r,
     -+				    struct oidset *trees)
     -+{
     -+	struct object_id *oid;
     -+	struct oidset_iter iter;
     -+
     -+	oidset_iter_init(trees, &iter);
     -+	while ((oid = oidset_iter_next(&iter))) {
     -+		struct tree *tree = lookup_tree(r, oid);
     ++# test_cmp_sorted runs test_cmp on sorted versions of the two
     ++# input files. Uses "$1.sorted" and "$2.sorted" as temp files.
      +
     -+		if (tree && (tree->object.flags & UNINTERESTING))
     -+			mark_tree_contents_uninteresting(r, tree);
     -+	}
     ++test_cmp_sorted () {
     ++	sort <"$1" >"$1.sorted" &&
     ++	sort <"$2" >"$2.sorted" &&
     ++	test_cmp "$1.sorted" "$2.sorted" &&
     ++	rm "$1.sorted" "$2.sorted"
      +}
      +
     - void mark_trees_uninteresting_sparse(struct repository *r,
     - 				     struct oidset *trees)
     - {
     -
     - ## revision.h ##
     -@@ revision.h: void put_revision_mark(const struct rev_info *revs,
     -
     - void mark_parents_uninteresting(struct rev_info *revs, struct commit 
*commit);
     - void mark_tree_uninteresting(struct repository *r, struct tree *tree);
     -+void mark_trees_uninteresting_dense(struct repository *r, struct oidset 
*trees);
     - void mark_trees_uninteresting_sparse(struct repository *r, struct oidset 
*trees);
     -
     - void show_object_with_name(FILE *, struct object *, const char *);
     + # Check that the given config key has the expected value.
     + #
     + #    test_cmp_config [-C <dir>] <expected-value>
2:  a00ab0c62c9 ! 3:  6f93dff88e7 t6601: add helper for testing path-walk API
     @@ Commit message
          sets a baseline for the behavior and we can extend it as new options are
          introduced.

     +    It is important to mention that the behavior of the API will change 
soon as
     +    we start to handle UNINTERESTING objects differently, but these tests will
     +    demonstrate the change in behavior.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>

       ## Documentation/technical/api-path-walk.txt ##
     -@@ Documentation/technical/api-path-walk.txt: commits are emitted.
     +@@ Documentation/technical/api-path-walk.txt: commits.
       Examples
       --------

     @@ t/t6601-path-walk.sh (new)
      +	blobs:6
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
      +test_expect_success 'topic only' '
     @@ t/t6601-path-walk.sh (new)
      +	blobs:5
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
      +test_expect_success 'topic, not base' '
     @@ t/t6601-path-walk.sh (new)
      +	blobs:4
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
      +test_expect_success 'topic, not base, boundary' '
     @@ t/t6601-path-walk.sh (new)
      +	blobs:5
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
      +test_done
3:  14375d19392 ! 4:  f4bf8be30b5 path-walk: allow consumer to specify object types
     @@ Commit message
          We add the ability to filter the object types in the path-walk API so
          the callback function is called fewer times.

     -    This adds the ability to ask for the commits in a list, as well. Future
     -    changes will add the ability to visit annotated tags.
     +    This adds the ability to ask for the commits in a list, as well. We
     +    re-use the empty string for this set of objects because these are passed
     +    directly to the callback function instead of being part of the
     +    'path_stack'.
     +
     +    Future changes will add the ability to visit annotated tags.

          Signed-off-by: Derrick Stolee <stolee@gmail.com>

       ## Documentation/technical/api-path-walk.txt ##
     -@@ Documentation/technical/api-path-walk.txt: If you want the path-walk 
API to emit `UNINTERESTING` objects based on the
     - commit walk's boundary, be sure to set `revs.boundary` so the boundary
     - commits are emitted.
     +@@ Documentation/technical/api-path-walk.txt: It is also important that 
you do not specify the `--objects` flag for the
     + the objects will be walked in a separate way based on those starting
     + commits.

      +`commits`, `blobs`, `trees`::
      +	By default, these members are enabled and signal that the path-walk
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	/* Insert a single list for the root tree into the paths. */
       	CALLOC_ARRAY(root_tree_list, 1);
       	root_tree_list->type = OBJ_TREE;
     - 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
     --
     - 	if (prepare_revision_walk(info->revs))
     +@@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       		die(_("failed to setup revision walk"));

       	while ((c = get_revision(info->revs))) {
      -		struct object_id *oid = get_commit_tree_oid(c);
     --		struct tree *t = lookup_tree(info->revs->repo, oid);
      +		struct object_id *oid;
     -+		struct tree *t;
     + 		struct tree *t;
       		commits_nr++;

      +		if (info->commits)
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      +		if (!info->trees && !info->blobs)
      +			continue;
      +
     -+		oid = get_commit_tree_oid(c);
     -+		t = lookup_tree(info->revs->repo, oid);
     -+
     - 		if (t) {
     - 			if (t->object.flags & SEEN)
     - 				continue;
     + 		oid = get_commit_tree_oid(c);
     + 		t = lookup_tree(info->revs->repo, oid);
     +
      @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
       	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      +	oid_array_clear(&commit_list->oids);
      +	free(commit_list);
      +
     - 	string_list_append(&ctx.path_stack, root_path);
     -
       	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
     + 	while (!ret && ctx.path_stack.nr) {
     + 		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;

       ## path-walk.h ##
      @@ path-walk.h: struct path_walk_info {
       	 */
       	path_fn path_fn;
       	void *path_fn_data;
     ++
      +	/**
      +	 * Initialize which object types the path_fn should be called on. This
      +	 * could also limit the walk to skip blobs if not set.
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       	TREE:left/:$(git rev-parse topic:left)
       	TREE:right/:$(git rev-parse topic:right)
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     - 	test_cmp expect.sorted out.sorted
     + 	test_cmp_sorted expect out
       '

      +test_expect_success 'topic, not base, only blobs' '
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	blobs:4
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
      +# No, this doesn't make a lot of sense for the path-walk API,
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	blobs:0
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
      +test_expect_success 'topic, not base, only trees' '
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	blobs:0
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     ++	test_cmp_sorted expect out
      +'
      +
       test_expect_success 'topic, not base, boundary' '
4:  c321f58c62d ! 5:  dfd00b2bf0c path-walk: allow visiting tags
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>

       ## Commit message ##
     -    path-walk: allow visiting tags
     +    path-walk: visit tags and cached objects

     -    In anticipation of using the path-walk API to analyze tags or include
     -    them in a pack-file, add the ability to walk the tags that were included
     -    in the revision walk.
     +    The rev_info that is specified for a path-walk traversal may specify
     +    visiting tag refs (both lightweight and annotated) and also may specify
     +    indexed objects (blobs and trees). Update the path-walk API to walk
     +    these objects as well.

     -    When these tag objects point to blobs or trees, we need to make sure
     -    those objects are also visited. Treat tagged trees as root trees, but
     -    put the tagged blobs in their own category.
     +    When walking tags, we need to peel the annotated objects until reaching
     +    a non-tag object. If we reach a commit, then we can add it to the
     +    pending objects to make sure we visit in the commit walk portion. If we
     +    reach a tree, then we will assume that it is a root tree. If we reach a
     +    blob, then we have no good path name and so add it to a new list of
     +    "tagged blobs".

     -    Be careful about objects that are referred to by multiple references.
     +    When the rev_info includes the "--indexed-objects" flag, then the
     +    pending set includes blobs and trees found in the cache entries and
     +    cache-tree. The cache entries are usually blobs, though they could be
     +    trees in the case of a sparse index. The cache-tree stores
     +    previously-hashed tree objects but these are cleared out when staging
     +    objects below those paths. We add tests that demonstrate this.
     +
     +    The indexed objects come with a non-NULL 'path' value in the pending
     +    item. This allows us to prepopulate the 'path_to_lists' strmap with
     +    lists for these paths.
     +
     +    The tricky thing about this walk is that we will want to combine the
     +    indexed objects walk with the commit walk, especially in the future case
     +    of walking objects during a command like 'git repack'.
     +
     +    Whenever possible, we want the objects from the index to be grouped with
     +    similar objects in history. We don't want to miss any paths that appear
     +    only in the index and not in the commit history.
     +
     +    Thus, we need to be careful to let the path stack be populated initially
     +    with only the root tree path (and possibly tags and tagged blobs) and go
     +    through the normal depth-first search. Afterwards, if there are other
     +    paths that are remaining in the paths_to_lists strmap, we should then
     +    iterate through the stack and visit those objects recursively.

     -    Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     -    Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>

       ## Documentation/technical/api-path-walk.txt ##
     -@@ Documentation/technical/api-path-walk.txt: If you want the path-walk 
API to emit `UNINTERESTING` objects based on the
     - commit walk's boundary, be sure to set `revs.boundary` so the boundary
     - commits are emitted.
     +@@ Documentation/technical/api-path-walk.txt: It is also important that 
you do not specify the `--objects` flag for the
     + the objects will be walked in a separate way based on those starting
     + commits.

      -`commits`, `blobs`, `trees`::
      +`commits`, `blobs`, `trees`, `tags`::
     @@ path-walk.c
       #include "trace2.h"
       #include "tree.h"
       #include "tree-walk.h"
     +
     ++static const char *root_path = "";
     ++
     + struct type_and_oid_list
     + {
     + 	enum object_type type;
     +@@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     +
     + 	list = strmap_get(&ctx->paths_to_lists, path);
     +
     ++	if (!list)
     ++		BUG("provided path '%s' that had no associated list", path);
     ++
     + 	/* Evaluate function pointer on this data, if requested. */
     + 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
     +-	    (list->type == OBJ_BLOB && ctx->info->blobs))
     ++	    (list->type == OBJ_BLOB && ctx->info->blobs)||
     ++	    (list->type == OBJ_TAG && ctx->info->tags))
     + 		ret = ctx->info->path_fn(path, &list->oids, list->type,
     + 					ctx->info->path_fn_data);
     +
     +@@ path-walk.c: static void clear_strmap(struct strmap *map)
     + 	strmap_init(map);
     + }
     +
     ++static void setup_pending_objects(struct path_walk_info *info,
     ++				  struct path_walk_context *ctx)
     ++{
     ++	struct type_and_oid_list *tags = NULL;
     ++	struct type_and_oid_list *tagged_blobs = NULL;
     ++	struct type_and_oid_list *root_tree_list = NULL;
     ++
     ++	if (info->tags)
     ++		CALLOC_ARRAY(tags, 1);
     ++	if (info->blobs)
     ++		CALLOC_ARRAY(tagged_blobs, 1);
     ++	if (info->trees)
     ++		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
     ++
     ++	/*
     ++	 * Pending objects include:
     ++	 * * Commits at branch tips.
     ++	 * * Annotated tags at tag tips.
     ++	 * * Any kind of object at lightweight tag tips.
     ++	 * * Trees and blobs in the index (with an associated path).
     ++	 */
     ++	for (size_t i = 0; i < info->revs->pending.nr; i++) {
     ++		struct object_array_entry *pending = info->revs->pending.objects + i;
     ++		struct object *obj = pending->item;
     ++
     ++		/* Commits will be picked up by revision walk. */
     ++		if (obj->type == OBJ_COMMIT)
     ++			continue;
     ++
     ++		/* Navigate annotated tag object chains. */
     ++		while (obj->type == OBJ_TAG) {
     ++			struct tag *tag = lookup_tag(info->revs->repo, &obj->oid);
     ++			if (!tag)
     ++				break;
     ++			if (tag->object.flags & SEEN)
     ++				break;
     ++			tag->object.flags |= SEEN;
     ++
     ++			if (tags)
     ++				oid_array_append(&tags->oids, &obj->oid);
     ++			obj = tag->tagged;
     ++		}
     ++
     ++		if (obj->type == OBJ_TAG)
     ++			continue;
     ++
     ++		/* We are now at a non-tag object. */
     ++		if (obj->flags & SEEN)
     ++			continue;
     ++		obj->flags |= SEEN;
     ++
     ++		switch (obj->type) {
     ++		case OBJ_TREE:
     ++			if (!info->trees)
     ++				continue;
     ++			if (pending->path) {
     ++				struct type_and_oid_list *list;
     ++				char *path = *pending->path ? xstrfmt("%s/", pending->path)
     ++							    : xstrdup("");
     ++				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
     ++					CALLOC_ARRAY(list, 1);
     ++					list->type = OBJ_TREE;
     ++					strmap_put(&ctx->paths_to_lists, path, list);
     ++				}
     ++				oid_array_append(&list->oids, &obj->oid);
     ++				free(path);
     ++			} else {
     ++				/* assume a root tree, such as a lightweight tag. */
     ++				oid_array_append(&root_tree_list->oids, &obj->oid);
     ++			}
     ++			break;
     ++
     ++		case OBJ_BLOB:
     ++			if (!info->blobs)
     ++				continue;
     ++			if (pending->path) {
     ++				struct type_and_oid_list *list;
     ++				char *path = pending->path;
     ++				if (!(list = strmap_get(&ctx->paths_to_lists, path))) {
     ++					CALLOC_ARRAY(list, 1);
     ++					list->type = OBJ_BLOB;
     ++					strmap_put(&ctx->paths_to_lists, path, list);
     ++				}
     ++				oid_array_append(&list->oids, &obj->oid);
     ++			} else {
     ++				/* assume a root tree, such as a lightweight tag. */
     ++				oid_array_append(&tagged_blobs->oids, &obj->oid);
     ++			}
     ++			break;
     ++
     ++		case OBJ_COMMIT:
     ++			/* Make sure it is in the object walk */
     ++			if (obj != pending->item)
     ++				add_pending_object(info->revs, obj, "");
     ++			break;
     ++
     ++		default:
     ++			BUG("should not see any other type here");
     ++		}
     ++	}
     ++
     ++	/*
     ++	 * Add tag objects and tagged blobs if they exist.
     ++	 */
     ++	if (tagged_blobs) {
     ++		if (tagged_blobs->oids.nr) {
     ++			const char *tagged_blob_path = "/tagged-blobs";
     ++			tagged_blobs->type = OBJ_BLOB;
     ++			push_to_stack(ctx, tagged_blob_path);
     ++			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
     ++		} else {
     ++			oid_array_clear(&tagged_blobs->oids);
     ++			free(tagged_blobs);
     ++		}
     ++	}
     ++	if (tags) {
     ++		if (tags->oids.nr) {
     ++			const char *tag_path = "/tags";
     ++			tags->type = OBJ_TAG;
     ++			push_to_stack(ctx, tag_path);
     ++			strmap_put(&ctx->paths_to_lists, tag_path, tags);
     ++		} else {
     ++			oid_array_clear(&tags->oids);
     ++			free(tags);
     ++		}
     ++	}
     ++}
     ++
     + /**
     +  * Given the configuration of 'info', walk the commits based on 
'info->revs' and
     +  * call 'info->path_fn' on each discovered path.
     +@@ path-walk.c: static void clear_strmap(struct strmap *map)
     +  */
     + int walk_objects_by_path(struct path_walk_info *info)
     + {
     +-	const char *root_path = "";
     + 	int ret = 0;
     + 	size_t commits_nr = 0, paths_nr = 0;
     + 	struct commit *c;
      @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	CALLOC_ARRAY(commit_list, 1);
       	commit_list->type = OBJ_COMMIT;
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	CALLOC_ARRAY(root_tree_list, 1);
       	root_tree_list->type = OBJ_TREE;
       	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
     -+
     + 	push_to_stack(&ctx, root_path);
     +
      +	/*
      +	 * Set these values before preparing the walk to catch
     -+	 * lightweight tags pointing to non-commits.
     ++	 * lightweight tags pointing to non-commits and indexed objects.
      +	 */
      +	info->revs->blob_objects = info->blobs;
      +	info->revs->tree_objects = info->trees;
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)

      +	info->revs->blob_objects = info->revs->tree_objects = 0;
      +
     -+	if (info->tags) {
     -+		struct oid_array tagged_blob_list = OID_ARRAY_INIT;
     -+		struct oid_array tags = OID_ARRAY_INIT;
     -+
     -+		trace2_region_enter("path-walk", "tag-walk", info->revs->repo);
     -+
     -+		/*
     -+		 * Walk any pending objects at this point, but they should only
     -+		 * be tags.
     -+		 */
     -+		for (size_t i = 0; i < info->revs->pending.nr; i++) {
     -+			struct object_array_entry *pending = info->revs->pending.objects + i;
     -+			struct object *obj = pending->item;
     -+
     -+			if (obj->type == OBJ_COMMIT || obj->flags & SEEN)
     -+				continue;
     -+
     -+			while (obj->type == OBJ_TAG) {
     -+				struct tag *tag = lookup_tag(info->revs->repo,
     -+							     &obj->oid);
     -+				if (!(obj->flags & SEEN)) {
     -+					obj->flags |= SEEN;
     -+					oid_array_append(&tags, &obj->oid);
     -+				}
     -+				obj = tag->tagged;
     -+			}
     -+
     -+			if ((obj->flags & SEEN))
     -+				continue;
     -+			obj->flags |= SEEN;
     ++	trace2_region_enter("path-walk", "pending-walk", info->revs->repo);
     ++	setup_pending_objects(info, &ctx);
     ++	trace2_region_leave("path-walk", "pending-walk", info->revs->repo);
      +
     -+			switch (obj->type) {
     -+			case OBJ_TREE:
     -+				if (info->trees)
     -+					oid_array_append(&root_tree_list->oids, &obj->oid);
     -+				break;
     -+
     -+			case OBJ_BLOB:
     -+				if (info->blobs)
     -+					oid_array_append(&tagged_blob_list, &obj->oid);
     -+				break;
     + 	while ((c = get_revision(info->revs))) {
     + 		struct object_id *oid;
     + 		struct tree *t;
     +@@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
     +
     + 		free(path);
     + 	}
      +
     -+			case OBJ_COMMIT:
     -+				/* Make sure it is in the object walk */
     -+				add_pending_object(info->revs, obj, "");
     -+				break;
     ++	/* Are there paths remaining? Likely they are from indexed objects. */
     ++	if (!strmap_empty(&ctx.paths_to_lists)) {
     ++		struct hashmap_iter iter;
     ++		struct strmap_entry *entry;
      +
     -+			default:
     -+				BUG("should not see any other type here");
     -+			}
     ++		strmap_for_each_entry(&ctx.paths_to_lists, &iter, entry) {
     ++			push_to_stack(&ctx, entry->key);
      +		}
      +
     -+		info->path_fn("", &tags, OBJ_TAG, info->path_fn_data);
     ++		while (!ret && ctx.path_stack.nr) {
     ++			char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
     ++			ctx.path_stack.nr--;
     ++			paths_nr++;
      +
     -+		if (tagged_blob_list.nr && info->blobs)
     -+			info->path_fn("/tagged-blobs", &tagged_blob_list, OBJ_BLOB,
     -+				      info->path_fn_data);
     ++			ret = walk_path(&ctx, path);
      +
     -+		trace2_data_intmax("path-walk", ctx.repo, "tags", tags.nr);
     -+		trace2_region_leave("path-walk", "tag-walk", info->revs->repo);
     -+		oid_array_clear(&tags);
     -+		oid_array_clear(&tagged_blob_list);
     ++			free(path);
     ++		}
      +	}
      +
     - 	while ((c = get_revision(info->revs))) {
     - 		struct object_id *oid;
     - 		struct tree *t;
     + 	trace2_data_intmax("path-walk", ctx.repo, "paths", paths_nr);
     + 	trace2_region_leave("path-walk", "path-walk", info->revs->repo);
     +

       ## path-walk.h ##
      @@ path-walk.h: struct path_walk_info {
     @@ t/t6601-path-walk.sh: test_expect_success 'all' '
      +	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
      +	BLOB:child/file:$(git rev-parse refs/tags/tree-tag^{}:child/file)
      +	blobs:10
     -+	TAG::$(git rev-parse refs/tags/first)
     -+	TAG::$(git rev-parse refs/tags/second.1)
     -+	TAG::$(git rev-parse refs/tags/second.2)
     -+	TAG::$(git rev-parse refs/tags/third)
     -+	TAG::$(git rev-parse refs/tags/fourth)
     -+	TAG::$(git rev-parse refs/tags/tree-tag)
     -+	TAG::$(git rev-parse refs/tags/blob-tag)
     ++	TAG:/tags:$(git rev-parse refs/tags/first)
     ++	TAG:/tags:$(git rev-parse refs/tags/second.1)
     ++	TAG:/tags:$(git rev-parse refs/tags/second.2)
     ++	TAG:/tags:$(git rev-parse refs/tags/third)
     ++	TAG:/tags:$(git rev-parse refs/tags/fourth)
     ++	TAG:/tags:$(git rev-parse refs/tags/tree-tag)
     ++	TAG:/tags:$(git rev-parse refs/tags/blob-tag)
      +	tags:7
     ++	EOF
     ++
     ++	test_cmp_sorted expect out
     ++'
     ++
     ++test_expect_success 'indexed objects' '
     ++	test_when_finished git reset --hard &&
     ++
     ++	# stage change into index, adding a blob but
     ++	# also invalidating the cache-tree for the root
     ++	# and the "left" directory.
     ++	echo bogus >left/c &&
     ++	git add left &&
     ++
     ++	test-tool path-walk -- --indexed-objects >out &&
     ++
     ++	cat >expect <<-EOF &&
     ++	commits:0
     ++	TREE:right/:$(git rev-parse topic:right)
     ++	trees:1
     ++	BLOB:a:$(git rev-parse HEAD:a)
     ++	BLOB:left/b:$(git rev-parse HEAD:left/b)
     ++	BLOB:left/c:$(git rev-parse :left/c)
     ++	BLOB:right/c:$(git rev-parse HEAD:right/c)
     ++	BLOB:right/d:$(git rev-parse HEAD:right/d)
     ++	blobs:5
     ++	tags:0
     ++	EOF
     ++
     ++	test_cmp_sorted expect out
     ++'
     ++
     ++test_expect_success 'branches and indexed objects mix well' '
     ++	test_when_finished git reset --hard &&
     ++
     ++	# stage change into index, adding a blob but
     ++	# also invalidating the cache-tree for the root
     ++	# and the "right" directory.
     ++	echo fake >right/d &&
     ++	git add right &&
     ++
     ++	test-tool path-walk -- --indexed-objects --branches >out &&
     ++
     ++	cat >expect <<-EOF &&
     ++	COMMIT::$(git rev-parse topic)
     ++	COMMIT::$(git rev-parse base)
     ++	COMMIT::$(git rev-parse base~1)
     ++	COMMIT::$(git rev-parse base~2)
     ++	commits:4
     ++	TREE::$(git rev-parse topic^{tree})
     ++	TREE::$(git rev-parse base^{tree})
     ++	TREE::$(git rev-parse base~1^{tree})
     ++	TREE::$(git rev-parse base~2^{tree})
     ++	TREE:a/:$(git rev-parse base:a)
     ++	TREE:left/:$(git rev-parse base:left)
     ++	TREE:left/:$(git rev-parse base~2:left)
     ++	TREE:right/:$(git rev-parse topic:right)
     ++	TREE:right/:$(git rev-parse base~1:right)
     ++	TREE:right/:$(git rev-parse base~2:right)
     ++	trees:10
     ++	BLOB:a:$(git rev-parse base~2:a)
     ++	BLOB:left/b:$(git rev-parse base:left/b)
     ++	BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	BLOB:right/c:$(git rev-parse topic:right/c)
     ++	BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	BLOB:right/d:$(git rev-parse :right/d)
     ++	blobs:7
     ++	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     + 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
       	BLOB:right/c:$(git rev-parse topic:right/c)
       	BLOB:right/d:$(git rev-parse base~1:right/d)
     @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
      +	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     + 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       	BLOB:right/c:$(git rev-parse topic:right/c)
       	BLOB:right/d:$(git rev-parse topic:right/d)
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     + 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
       	BLOB:right/c:$(git rev-parse topic:right/c)
       	BLOB:right/d:$(git rev-parse topic:right/d)
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
      +	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     + 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only commits' '
       	commits:1
       	trees:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only commits' '
      +	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     + 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
       	TREE:right/:$(git rev-parse topic:right)
       	trees:3
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
      +	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     + 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       	BLOB:right/c:$(git rev-parse topic:right/c)
       	BLOB:right/d:$(git rev-parse base~1:right/d)
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
      +	tags:0
       	EOF

     - 	sort expect >expect.sorted &&
     -@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
     - 	test_cmp expect.sorted out.sorted
     + 	test_cmp_sorted expect out
       '

      +test_expect_success 'trees are reported exactly once' '
6:  238d7d95715 ! 6:  5252076d556 path-walk: add prune_all_uninteresting option
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>

       ## Commit message ##
     -    path-walk: add prune_all_uninteresting option
     +    path-walk: mark trees and blobs as UNINTERESTING

     -    This option causes the path-walk API to act like the sparse tree-walk
     -    algorithm implemented by mark_trees_uninteresting_sparse() in
     -    list-objects.c.
     +    When the input rev_info has UNINTERESTING starting points, we want to be
     +    sure that the UNINTERESTING flag is passed appropriately through the
     +    objects. To match how this is done in places such as 'git 
pack-objects', we
     +    use the mark_edges_uninteresting() method.

     -    Starting from the commits marked as UNINTERESTING, their root trees and
     -    all objects reachable from those trees are UNINTERSTING, at least as we
     -    walk path-by-path. When we reach a path where all objects associated
     -    with that path are marked UNINTERESTING, then do no continue walking the
     -    children of that path.
     +    This method has an option for using the "sparse" walk, which is similar in
     +    spirit to the path-walk API's walk. To be sure to keep it independent, 
add a
     +    new 'prune_all_uninteresting' option to the path_walk_info struct.

     -    We need to be careful to pass the UNINTERESTING flag in a deep way on
     -    the UNINTERESTING objects before we start the path-walk, or else the
     -    depth-first search for the path-walk API may accidentally report some
     -    objects as interesting.
     +    To check how the UNINTERSTING flag is spread through our objects, 
extend the
     +    'test-tool path-walk' command to output whether or not an object has that
     +    flag. This changes our tests significantly, including the removal of some
     +    objects that were previously visited due to the incomplete implementation.

          Signed-off-by: Derrick Stolee <stolee@gmail.com>

       ## Documentation/technical/api-path-walk.txt ##
     -@@ Documentation/technical/api-path-walk.txt: commits are emitted.
     +@@ Documentation/technical/api-path-walk.txt: commits.
       While it is possible to walk only commits in this way, consumers would be
       better off using the revision walk API instead.

     @@ Documentation/technical/api-path-walk.txt: commits are emitted.


       ## path-walk.c ##
     +@@
     + #include "dir.h"
     + #include "hashmap.h"
     + #include "hex.h"
     ++#include "list-objects.h"
     + #include "object.h"
     + #include "oid-array.h"
     + #include "revision.h"
      @@ path-walk.c: struct type_and_oid_list
       {
       	enum object_type type;
     @@ path-walk.c: struct type_and_oid_list

       #define TYPE_AND_OID_LIST_INIT { \
      @@ path-walk.c: static int add_children(struct path_walk_context *ctx,
     - 			strmap_put(&ctx->paths_to_lists, path.buf, list);
     - 			string_list_append(&ctx->path_stack, path.buf);
     - 		}
     + 		if (o->flags & SEEN)
     + 			continue;
     + 		o->flags |= SEEN;
     ++
      +		if (!(o->flags & UNINTERESTING))
      +			list->maybe_interesting = 1;
       		oid_array_append(&list->oids, &entry.oid);
       	}

      @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     -
     - 	list = strmap_get(&ctx->paths_to_lists, path);
     + 	if (!list)
     + 		BUG("provided path '%s' that had no associated list", path);

      +	if (ctx->info->prune_all_uninteresting) {
      +		/*
     @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
      +							     &list->oids.oid[i]);
      +				if (t && !(t->object.flags & UNINTERESTING))
      +					list->maybe_interesting = 1;
     -+			} else {
     ++			} else if (list->type == OBJ_BLOB) {
      +				struct blob *b = lookup_blob(ctx->repo,
      +							     &list->oids.oid[i]);
      +				if (b && !(b->object.flags & UNINTERESTING))
      +					list->maybe_interesting = 1;
     ++			} else {
     ++				/* Tags are always interesting if visited. */
     ++				list->maybe_interesting = 1;
      +			}
      +		}
      +
     @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
      +
       	/* Evaluate function pointer on this data, if requested. */
       	if ((list->type == OBJ_TREE && ctx->info->trees) ||
     - 	    (list->type == OBJ_BLOB && ctx->info->blobs))
     + 	    (list->type == OBJ_BLOB && ctx->info->blobs)||
      @@ path-walk.c: static void clear_strmap(struct strmap *map)
     - int walk_objects_by_path(struct path_walk_info *info)
     - {
     - 	const char *root_path = "";
     --	int ret = 0;
     -+	int ret = 0, has_uninteresting = 0;
     - 	size_t commits_nr = 0, paths_nr = 0;
     - 	struct commit *c;
     - 	struct type_and_oid_list *root_tree_list;
     -@@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
     - 		.path_stack = STRING_LIST_INIT_DUP,
     - 		.paths_to_lists = STRMAP_INIT
     - 	};
     -+	struct oidset root_tree_set = OIDSET_INIT;
     -
     - 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
     + 	strmap_init(map);
     + }

     ++static struct repository *edge_repo;
     ++static struct type_and_oid_list *edge_tree_list;
     ++
     ++static void show_edge(struct commit *commit)
     ++{
     ++	struct tree *t = repo_get_commit_tree(edge_repo, commit);
     ++
     ++	if (!t)
     ++		return;
     ++
     ++	if (commit->object.flags & UNINTERESTING)
     ++		t->object.flags |= UNINTERESTING;
     ++
     ++	if (t->object.flags & SEEN)
     ++		return;
     ++	t->object.flags |= SEEN;
     ++
     ++	oid_array_append(&edge_tree_list->oids, &t->object.oid);
     ++}
     ++
     + static void setup_pending_objects(struct path_walk_info *info,
     + 				  struct path_walk_context *ctx)
     + {
     +@@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
     + 		if (tagged_blobs->oids.nr) {
     + 			const char *tagged_blob_path = "/tagged-blobs";
     + 			tagged_blobs->type = OBJ_BLOB;
     ++			tagged_blobs->maybe_interesting = 1;
     + 			push_to_stack(ctx, tagged_blob_path);
     + 			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
     + 		} else {
     +@@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
     + 		if (tags->oids.nr) {
     + 			const char *tag_path = "/tags";
     + 			tags->type = OBJ_TAG;
     ++			tags->maybe_interesting = 1;
     + 			push_to_stack(ctx, tag_path);
     + 			strmap_put(&ctx->paths_to_lists, tag_path, tags);
     + 		} else {
      @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	/* Insert a single list for the root tree into the paths. */
       	CALLOC_ARRAY(root_tree_list, 1);
       	root_tree_list->type = OBJ_TREE;
      +	root_tree_list->maybe_interesting = 1;
       	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
     + 	push_to_stack(&ctx, root_path);

     - 	/*
      @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
     - 		t = lookup_tree(info->revs->repo, oid);
     + 	if (prepare_revision_walk(info->revs))
     + 		die(_("failed to setup revision walk"));

     - 		if (t) {
     -+			if ((c->object.flags & UNINTERESTING)) {
     -+				t->object.flags |= UNINTERESTING;
     -+				has_uninteresting = 1;
     -+			}
     ++	/* Walk trees to mark them as UNINTERESTING. */
     ++	edge_repo = info->revs->repo;
     ++	edge_tree_list = root_tree_list;
     ++	mark_edges_uninteresting(info->revs, show_edge,
     ++				 info->prune_all_uninteresting);
     ++	edge_repo = NULL;
     ++	edge_tree_list = NULL;
      +
     - 			if (t->object.flags & SEEN)
     - 				continue;
     - 			t->object.flags |= SEEN;
     --			oid_array_append(&root_tree_list->oids, oid);
     -+			if (!oidset_insert(&root_tree_set, oid))
     -+				oid_array_append(&root_tree_list->oids, oid);
     - 		} else {
     - 			warning("could not find tree %s", oid_to_hex(oid));
     - 		}
     -@@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
     - 	oid_array_clear(&commit_list->oids);
     - 	free(commit_list);
     + 	info->revs->blob_objects = info->revs->tree_objects = 0;

     -+	/*
     -+	 * Before performing a DFS of our paths and emitting them as interesting,
     -+	 * do a full walk of the trees to distribute the UNINTERESTING bit. Use
     -+	 * the sparse algorithm if prune_all_uninteresting was set.
     -+	 */
     -+	if (has_uninteresting) {
     -+		trace2_region_enter("path-walk", "uninteresting-walk", info->revs->repo);
     -+		if (info->prune_all_uninteresting)
     -+			mark_trees_uninteresting_sparse(ctx.repo, &root_tree_set);
     -+		else
     -+			mark_trees_uninteresting_dense(ctx.repo, &root_tree_set);
     -+		trace2_region_leave("path-walk", "uninteresting-walk", info->revs->repo);
     -+	}
     -+	oidset_clear(&root_tree_set);
     -+
     - 	string_list_append(&ctx.path_stack, root_path);
     -
     - 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
     + 	trace2_region_enter("path-walk", "pending-walk", info->revs->repo);

       ## path-walk.h ##
      @@ path-walk.h: struct path_walk_info {
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)


       ## t/t6601-path-walk.sh ##
     +@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     + 	COMMIT::$(git rev-parse topic)
     + 	commits:1
     + 	TREE::$(git rev-parse topic^{tree})
     +-	TREE:left/:$(git rev-parse topic:left)
     ++	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     + 	TREE:right/:$(git rev-parse topic:right)
     + 	trees:3
     +-	BLOB:a:$(git rev-parse topic:a)
     +-	BLOB:left/b:$(git rev-parse topic:left/b)
     ++	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     ++	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     + 	BLOB:right/c:$(git rev-parse topic:right/c)
     +-	BLOB:right/d:$(git rev-parse topic:right/d)
     ++	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     + 	blobs:4
     + 	tags:0
     + 	EOF
     +@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     + 	test_cmp_sorted expect out
     + '
     +
     ++test_expect_success 'fourth, blob-tag2, not base' '
     ++	test-tool path-walk -- fourth blob-tag2 --not base >out &&
     ++
     ++	cat >expect <<-EOF &&
     ++	COMMIT::$(git rev-parse topic)
     ++	commits:1
     ++	TREE::$(git rev-parse topic^{tree})
     ++	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     ++	TREE:right/:$(git rev-parse topic:right)
     ++	trees:3
     ++	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     ++	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     ++	BLOB:right/c:$(git rev-parse topic:right/c)
     ++	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     ++	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	blobs:5
     ++	TAG:/tags:$(git rev-parse fourth)
     ++	tags:1
     ++	EOF
     ++
     ++	test_cmp_sorted expect out
     ++'
     ++
     + test_expect_success 'topic, not base, only blobs' '
     + 	test-tool path-walk --no-trees --no-commits \
     + 		-- topic --not base >out &&
     +@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
     + 	cat >expect <<-EOF &&
     + 	commits:0
     + 	trees:0
     +-	BLOB:a:$(git rev-parse topic:a)
     +-	BLOB:left/b:$(git rev-parse topic:left/b)
     ++	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     ++	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     + 	BLOB:right/c:$(git rev-parse topic:right/c)
     +-	BLOB:right/d:$(git rev-parse topic:right/d)
     ++	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     + 	blobs:4
     + 	tags:0
     + 	EOF
     +@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
     + 	cat >expect <<-EOF &&
     + 	commits:0
     + 	TREE::$(git rev-parse topic^{tree})
     +-	TREE:left/:$(git rev-parse topic:left)
     ++	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     + 	TREE:right/:$(git rev-parse topic:right)
     + 	trees:3
     + 	blobs:0
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '

       	cat >expect <<-EOF &&
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       	tags:0
       	EOF
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
     - 	test_cmp expect.sorted out.sorted
     + 	test_cmp_sorted expect out
       '

     +-test_expect_success 'trees are reported exactly once' '
     +-	test_when_finished "rm -rf unique-trees" &&
     +-	test_create_repo unique-trees &&
     +-	(
     +-		cd unique-trees &&
     +-		mkdir initial &&
     +-		test_commit initial/file &&
     +-
     +-		git switch -c move-to-top &&
     +-		git mv initial/file.t ./ &&
     +-		test_tick &&
     +-		git commit -m moved &&
     +-
     +-		git update-ref refs/heads/other HEAD
     +-	) &&
     +-
     +-	test-tool -C unique-trees path-walk -- --all >out &&
     +-	tree=$(git -C unique-trees rev-parse HEAD:) &&
     +-	grep "$tree" out >out-filtered &&
     +-	test_line_count = 1 out-filtered
      +test_expect_success 'topic, not base, boundary with pruning' '
      +	test-tool path-walk --prune -- --boundary topic --not base >out &&
      +
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
      +	tags:0
      +	EOF
      +
     -+	sort expect >expect.sorted &&
     -+	sort out >out.sorted &&
     -+
     -+	test_cmp expect.sorted out.sorted
     -+'
     -+
     - test_expect_success 'trees are reported exactly once' '
     - 	test_when_finished "rm -rf unique-trees" &&
     - 	test_create_repo unique-trees &&
     ++	test_cmp_sorted expect out
     + '
     +
     + test_done

