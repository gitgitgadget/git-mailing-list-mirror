Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D05BC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiCIQDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiCIQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E15317AED0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l10so1669235wmb.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=J2J9azPASMzbzgwLjHQY8iMy8vrf58S/h3s3oN8mwn8=;
        b=MICVppu/gw57u8H7DEADW54WOPWXbpdcnFdHIx7dXhi3ApE3IaHeJdWUgiaU0y28Az
         IcYtClNQ1U/IgxTJSQfZIx6EJhQsh4lIJPf4T4OwzQFQQ25zwehF64PNCa1JYGvnQCaS
         x5XWHa662NV4HGu3cFJcoq7XjWvrYz1xvZLKKP0tgcOK95rLZj4ddUWxpzWw8xgFZHfD
         FbFIvNeMKyqbugVfq969IA2AKwPKYoLJTIvcMaJMztr5oAhOuMUOTfB1Oy3d1gDxYBWV
         q3xI2sh32pMPcOfeFuWnfjvnyEVQYBm4lrUbYFQBHX/Zjp77uYDz0GR6GNO9EzX8xtDb
         BpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=J2J9azPASMzbzgwLjHQY8iMy8vrf58S/h3s3oN8mwn8=;
        b=q3CUtdRcE2iwqBBGmBSeA1/u1ZYNYqcx/jbXaklyQs9CtTHQIYJ9R0J8htLApGklQ5
         DIUP79CZawB/+hEESb+9Fc6/c6OxftNhM/fEjJ6J/U+T7JH0/IkPSF9j2LFls0Q0Otps
         xw6GZfHi9Bx3RrqNKnaGg+wIglIcm6PgBPuLl9w7K4qG6ykZQoyPGErMXqmFJH84ES00
         xzS6yiRsrqkakq2WlRESTeWNJwM8suxq8ileqikI8gmysVvFqrMNaFhQMYiTvgJxX/Ej
         7qhP1vH8CyG+qMMsVBwSSpjdyk5s5WYYg+ITaOf6cEVmPseDvcnnMV79vYdb3+4ayH+O
         RJqg==
X-Gm-Message-State: AOAM5332b5uFAlGjnU1BuynoD+X27Xgb7rxIbht9HFySfROe4pFjbJQs
        pDyfkG5AuzkXGWSMIF4XVnjxm+tIMf0=
X-Google-Smtp-Source: ABdhPJw0JLq1Im1TSfdikTT0LXxWRZVwaJDRz/AEYmo5vcsFlZcan+jTkUvAWJuZbeQRrXMFiRA1Tg==
X-Received: by 2002:a7b:c0cb:0:b0:385:cad0:d483 with SMTP id s11-20020a7bc0cb000000b00385cad0d483mr8085999wmh.163.1646841705447;
        Wed, 09 Mar 2022 08:01:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b00381890032dfsm5286776wmi.1.2022.03.09.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:44 -0800 (PST)
Message-Id: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:30 +0000
Subject: [PATCH v4 00/13] Partial bundles
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While discussing bundle-URIs [1], it came to my attention that bundles have
no way to specify an object filter, so bundles cannot be used with partial
clones.

[1]
https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/

This series provides a way to fix that by adding a 'filter' capability to
the bundle file format and allowing one to create a partial bundle with 'git
bundle create --filter=blob:none '.

There are a couple things that I want to point out about this implementation
that could use some high-level feedback:

 1. I moved the '--filter' parsing into setup_revisions() instead of adding
    another place to parse it. This works for 'git bundle' but it also
    allows it to be parsed successfully in commands such as 'git diff' which
    doesn't make sense. Options such as '--objects' are already being parsed
    there, and they don't make sense either, so I want some thoughts on
    this.

 2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
    filtered bundle, then the clone will fail with a message such as

fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
remote did not send all necessary objects

This might be fine. We don't expect users to clone partial bundles or fetch
partial bundles into an unfiltered repo and these failures are expected. It
is possible that we could put in custom logic to fail faster by reading the
bundle header for a filter.

Generally, the idea is to open this up as a potential way to bootstrap a
clone of a partial clone using a set of precomputed partial bundles.


Updates in v4
=============

 * 'struct rev_info' now has 'filter' embedded statically, using
   filter.choice to indicate if it is an empty filter. This makes the
   range-diff look really messy, as lots of '&' characters are inserted,
   especially in the middle patches. The end result looks very similar.

 * To accommodate previous lines that were a pointer copy, create
   list_objects_filter_copy() to assist with deep copies of filters.

 * Commit message typo fixes.

 * Documentation improvements.

 * Tests use 'sed' over 'head' to be more robust to future changes.

 * Initialization of a 'struct traversal_context' is made more compact.

 * "filter.choice != LOFC_DISABLED" is replaced by "filter.choice", since
   LOFC_DISABLED is zero by design.


Updates in v3
=============

 * 'struct bundle_header' now has 'filter' embedded statically, using
   filter.choice to indicate if it is an empty filter.

 * list-objects.c is now more robust to NULL function pointers.


Updates in v2
=============

Thanks for the reviews, Jeff, Junio, and Ævar!

 * Commit message typos and grammar are improved.

 * Grammar in MyFirstObjectWalk.txt is improved.

 * Unnecessary line wrapping is unwrapped.

 * Final test to check unbundled repo is made more rigorous.

 * The new 'filter' capability is added to
   Documentation/technical/bundle-format.txt

 * Expanded docs for 'git bundle verify'.

 * Moved API docs gently_parse_list_objects_filter() to header.

 * Test name swaps '' with "" to evaluate $filter.

 * Added a new patch that helps git clone <bundle> fail gracefully when
   <bundle> is has a filter capability.

Thanks, -Stolee

Derrick Stolee (12):
  index-pack: document and test the --promisor option
  list-objects-filter-options: create copy helper
  revision: put object filter into struct rev_info
  pack-objects: use rev.filter when possible
  pack-bitmap: drop filter in prepare_bitmap_walk()
  list-objects: consolidate traverse_commit_list[_filtered]
  MyFirstObjectWalk: update recommended usage
  bundle: parse filter capability
  rev-list: move --filter parsing into revision.c
  bundle: create filtered bundles
  bundle: unbundle promisor packs
  clone: fail gracefully when cloning filtered bundle

Ævar Arnfjörð Bjarmason (1):
  list-objects: handle NULL function pointers

 Documentation/MyFirstObjectWalk.txt       | 44 +++++---------
 Documentation/git-bundle.txt              |  7 ++-
 Documentation/git-index-pack.txt          |  8 +++
 Documentation/technical/bundle-format.txt | 11 +++-
 builtin/clone.c                           | 13 ++++
 builtin/pack-objects.c                    |  9 +--
 builtin/rev-list.c                        | 29 +++------
 bundle.c                                  | 74 +++++++++++++++++++----
 bundle.h                                  |  2 +
 list-objects-filter-options.c             | 36 ++++++-----
 list-objects-filter-options.h             | 24 ++++++++
 list-objects.c                            | 61 ++++++++++---------
 list-objects.h                            | 12 +++-
 pack-bitmap.c                             | 24 ++++----
 pack-bitmap.h                             |  2 -
 reachable.c                               |  2 +-
 revision.c                                |  7 +++
 revision.h                                |  7 +++
 t/t5300-pack-object.sh                    |  4 +-
 t/t6020-bundle-misc.sh                    | 74 +++++++++++++++++++++++
 20 files changed, 317 insertions(+), 133 deletions(-)


base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1159%2Fderrickstolee%2Fbundle%2Fpartial-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1159/derrickstolee/bundle/partial-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1159

Range-diff vs v3:

  1:  a1eb4dceb0b =  1:  a1eb4dceb0b index-pack: document and test the --promisor option
  -:  ----------- >  2:  a4c5a727ef1 list-objects-filter-options: create copy helper
  2:  3a88c99d9bc !  3:  4ac09ddbfaa revision: put object filter into struct rev_info
     @@ Metadata
       ## Commit message ##
          revision: put object filter into struct rev_info
      
     -    Placing a 'struct list_objects_filter_options' pointer within 'struct
     -    rev_info' will assist making some bookkeeping around object filters in
     -    the future.
     +    Placing a 'struct list_objects_filter_options' within 'struct rev_info'
     +    will assist making some bookkeeping around object filters in the future.
      
          For now, let's use this new member to remove a static global instance of
          the struct from builtin/rev-list.c.
     @@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *revs,
       	max_count = revs->max_count;
       
      -	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
     -+	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
     ++	bitmap_git = prepare_bitmap_walk(revs, &revs->filter,
      +					 filter_provided_objects);
       	if (!bitmap_git)
       		return -1;
     @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info *revs,
       		return -1;
       
      -	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
     -+	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
     ++	bitmap_git = prepare_bitmap_walk(revs, &revs->filter,
      +					 filter_provided_objects);
       	if (!bitmap_git)
       		return -1;
     @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
       		return -1;
       
      -	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
     -+	bitmap_git = prepare_bitmap_walk(revs, revs->filter, filter_provided_objects);
     ++	bitmap_git = prepare_bitmap_walk(revs, &revs->filter, filter_provided_objects);
       	if (!bitmap_git)
       		return -1;
       
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
      -			parse_list_objects_filter(&filter_options, arg);
      -			if (filter_options.choice && !revs.blob_objects)
     -+			if (!revs.filter)
     -+				CALLOC_ARRAY(revs.filter, 1);
     -+			parse_list_objects_filter(revs.filter, arg);
     -+			if (revs.filter->choice && !revs.blob_objects)
     ++			parse_list_objects_filter(&revs.filter, arg);
     ++			if (revs.filter.choice && !revs.blob_objects)
       				die(_("object filtering requires --objects"));
       			continue;
       		}
       		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
      -			list_objects_filter_set_no_filter(&filter_options);
     -+			if (!revs.filter)
     -+				CALLOC_ARRAY(revs.filter, 1);
     -+			list_objects_filter_set_no_filter(revs.filter);
     ++			list_objects_filter_set_no_filter(&revs.filter);
       			continue;
       		}
       		if (!strcmp(arg, "--filter-provided-objects")) {
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       
       	traverse_commit_list_filtered(
      -		&filter_options, &revs, show_commit, show_object, &info,
     -+		revs.filter, &revs, show_commit, show_object, &info,
     ++		&revs.filter, &revs, show_commit, show_object, &info,
       		(arg_print_omitted ? &omitted_objects : NULL));
       
       	if (arg_print_omitted) {
      
       ## revision.h ##
     -@@ revision.h: struct rev_cmdline_info {
     - 
     - struct oidset;
     - struct topo_walk_info;
     -+struct list_objects_filter_options;
     - 
     - struct rev_info {
     - 	/* Starting list */
     +@@
     + #include "pretty.h"
     + #include "diff.h"
     + #include "commit-slab-decl.h"
     ++#include "list-objects-filter-options.h"
     + 
     + /**
     +  * The revision walking API offers functions to build a list of revisions
      @@ revision.h: struct rev_info {
       	/* The end-points specified by the end user */
       	struct rev_cmdline_info cmdline;
       
     -+	/* Object filter options. NULL for no filtering. */
     -+	struct list_objects_filter_options *filter;
     ++	/*
     ++	 * Object filter options. No filtering is specified
     ++	 * if and only if filter.choice is zero.
     ++	 */
     ++	struct list_objects_filter_options filter;
      +
       	/* excluding from --branches, --refs, etc. expansion */
       	struct string_list *ref_excludes;
  3:  d5edb193229 !  4:  ed22a77782b pack-objects: use rev.filter when possible
     @@ builtin/pack-objects.c: static int pack_options_allow_reuse(void)
       static int get_object_list_from_bitmap(struct rev_info *revs)
       {
      -	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
     -+	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
     ++	if (!(bitmap_git = prepare_bitmap_walk(revs, &revs->filter, 0)))
       		return -1;
       
       	if (pack_options_allow_reuse() &&
     @@ builtin/pack-objects.c: static void get_object_list(int ac, const char **av)
       	repo_init_revisions(the_repository, &revs, NULL);
       	save_commit_buffer = 0;
       	setup_revisions(ac, av, &revs, &s_r_opt);
     -+	revs.filter = &filter_options;
     ++	list_objects_filter_copy(&revs.filter, &filter_options);
       
       	/* make sure shallows are read */
       	is_repository_shallow(the_repository);
     @@ builtin/pack-objects.c: static void get_object_list(int ac, const char **av)
       	if (!fn_show_object)
       		fn_show_object = show_object;
      -	traverse_commit_list_filtered(&filter_options, &revs,
     -+	traverse_commit_list_filtered(revs.filter, &revs,
     ++	traverse_commit_list_filtered(&revs.filter, &revs,
       				      show_commit, fn_show_object, NULL,
       				      NULL);
       
  4:  888774f6f28 !  5:  346baa78ec5 pack-bitmap: drop filter in prepare_bitmap_walk()
     @@ builtin/pack-objects.c: static int pack_options_allow_reuse(void)
       
       static int get_object_list_from_bitmap(struct rev_info *revs)
       {
     --	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
     +-	if (!(bitmap_git = prepare_bitmap_walk(revs, &revs->filter, 0)))
      +	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
       		return -1;
       
     @@ builtin/rev-list.c: static int try_bitmap_count(struct rev_info *revs,
       	 */
       	max_count = revs->max_count;
       
     --	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
     +-	bitmap_git = prepare_bitmap_walk(revs, &revs->filter,
      -					 filter_provided_objects);
      +	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
       	if (!bitmap_git)
     @@ builtin/rev-list.c: static int try_bitmap_traversal(struct rev_info *revs,
       	if (revs->max_count >= 0)
       		return -1;
       
     --	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
     +-	bitmap_git = prepare_bitmap_walk(revs, &revs->filter,
      -					 filter_provided_objects);
      +	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
       	if (!bitmap_git)
     @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
       	if (!show_disk_usage)
       		return -1;
       
     --	bitmap_git = prepare_bitmap_walk(revs, revs->filter, filter_provided_objects);
     +-	bitmap_git = prepare_bitmap_walk(revs, &revs->filter, filter_provided_objects);
      +	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
       	if (!bitmap_git)
       		return -1;
     @@ pack-bitmap.c: static struct bitmap *find_objects(struct bitmap_index *bitmap_gi
       		show_data.base = base;
       
      -		traverse_commit_list_filtered(filter, revs,
     -+		traverse_commit_list_filtered(revs->filter, revs,
     ++		traverse_commit_list_filtered(&revs->filter, revs,
       					      show_commit, show_object,
       					      &show_data, NULL);
       
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
       		return NULL;
       
      -	if (!can_filter_bitmap(filter))
     -+	if (!can_filter_bitmap(revs->filter))
     ++	if (!can_filter_bitmap(&revs->filter))
       		return NULL;
       
       	/* try to open a bitmapped pack, but don't parse it yet
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      -	filter_bitmap(bitmap_git, (filter && filter_provided_objects) ? NULL : wants,
      -		      wants_bitmap, filter);
      +	filter_bitmap(bitmap_git,
     -+		      (revs->filter && filter_provided_objects) ? NULL : wants,
     ++		      (revs->filter.choice && filter_provided_objects) ? NULL : wants,
      +		      wants_bitmap,
     -+		      revs->filter);
     ++		      &revs->filter);
       
       	bitmap_git->result = wants_bitmap;
       	bitmap_git->haves = haves_bitmap;
  5:  bcb76a065bf !  6:  34afea8fcd6 list-objects: consolidate traverse_commit_list[_filtered]
     @@ builtin/pack-objects.c: static void get_object_list(int ac, const char **av)
       
       	if (!fn_show_object)
       		fn_show_object = show_object;
     --	traverse_commit_list_filtered(revs.filter, &revs,
     +-	traverse_commit_list_filtered(&revs.filter, &revs,
      -				      show_commit, fn_show_object, NULL,
      -				      NULL);
      +	traverse_commit_list(&revs,
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
       
       	traverse_commit_list_filtered(
     --		revs.filter, &revs, show_commit, show_object, &info,
     +-		&revs.filter, &revs, show_commit, show_object, &info,
      +		&revs, show_commit, show_object, &info,
       		(arg_print_omitted ? &omitted_objects : NULL));
       
     @@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
       	struct rev_info *revs,
       	show_commit_fn show_commit,
       	show_object_fn show_object,
     -@@ list-objects.c: void traverse_commit_list_filtered(
     - 	ctx.show_object = show_object;
     - 	ctx.show_commit = show_commit;
     - 	ctx.show_data = show_data;
     --	ctx.filter = list_objects_filter__init(omitted, filter_options);
     -+	if (revs->filter)
     -+		ctx.filter = list_objects_filter__init(omitted, revs->filter);
     -+	else
     -+		ctx.filter = NULL;
     + 	void *show_data,
     + 	struct oidset *omitted)
     + {
     +-	struct traversal_context ctx;
     ++	struct traversal_context ctx = {
     ++		.revs = revs,
     ++		.show_object = show_object,
     ++		.show_commit = show_commit,
     ++		.show_data = show_data,
     ++	};
      +
     ++	if (revs->filter.choice)
     ++		ctx.filter = list_objects_filter__init(omitted, &revs->filter);
     + 
     +-	ctx.revs = revs;
     +-	ctx.show_object = show_object;
     +-	ctx.show_commit = show_commit;
     +-	ctx.show_data = show_data;
     +-	ctx.filter = list_objects_filter__init(omitted, filter_options);
       	do_traverse(&ctx);
      -	list_objects_filter__free(ctx.filter);
      +
     @@ pack-bitmap.c: static struct bitmap *find_objects(struct bitmap_index *bitmap_gi
       		show_data.bitmap_git = bitmap_git;
       		show_data.base = base;
       
     --		traverse_commit_list_filtered(revs->filter, revs,
     +-		traverse_commit_list_filtered(&revs->filter, revs,
      -					      show_commit, show_object,
      -					      &show_data, NULL);
      +		traverse_commit_list(revs,
  6:  efc03168818 =  7:  e522bf61b68 MyFirstObjectWalk: update recommended usage
  7:  782182a26e3 !  8:  7287aaec598 list-objects: handle NULL function pointers
     @@ Commit message
          leaving this segfault open for other callers.
      
          Replace all callers of the show_commit and show_object function pointers
     -    in list-objects.c to be local methods show_commit() and show_object()
     -    which check that the given contex has non-NULL functions before passing
     -    the necessary data. One extra benefit is that it reduces duplication
     -    due to passing ctx->show_data to every caller.
     +    in list-objects.c to call helper functions show_commit() and
     +    show_object() which check that the given context has non-NULL functions
     +    before passing the necessary data. One extra benefit is that it reduces
     +    duplication due to passing ctx->show_data to every caller.
      
          Test that this segfault no longer occurs for 'git bundle'.
      
     @@ t/t6020-bundle-misc.sh: test_expect_success 'clone from bundle' '
      +		--all &&
      +
      +	# Compare the headers of these files.
     -+	head -11 all.bdl >expect &&
     -+	head -11 all-objects.bdl >actual &&
     ++	sed -n -e "/^$/q" -e "p" all.bdl >expect &&
     ++	sed -n -e "/^$/q" -e "p" all-objects.bdl >actual &&
      +	test_cmp expect actual
      +'
      +
  8:  025f38290f5 !  9:  faf7a38b0e5 bundle: parse filter capability
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     + ## Documentation/git-bundle.txt ##
     +@@ Documentation/git-bundle.txt: verify <file>::
     + 	cleanly to the current repository.  This includes checks on the
     + 	bundle format itself as well as checking that the prerequisite
     + 	commits exist and are fully linked in the current repository.
     +-	'git bundle' prints a list of missing commits, if any, and exits
     +-	with a non-zero status.
     ++	Information about additional capabilities, such as "object filter",
     ++	is printed. See "Capabilities" in link:technical/bundle-format.html
     ++	for more information. Finally, 'git bundle' prints a list of
     ++	missing commits, if any. The exit code is zero for success, but
     ++	will be nonzero if the bundle file is invalid.
     + 
     + list-heads <file>::
     + 	Lists the references defined in the bundle.  If followed by a
     +
       ## Documentation/technical/bundle-format.txt ##
      @@ Documentation/technical/bundle-format.txt: and the Git bundle v2 format cannot represent a shallow clone repository.
       == Capabilities
     @@ bundle.c: int verify_bundle(struct repository *r,
       	req_nr = revs.pending.nr;
       	setup_revisions(2, argv, &revs, NULL);
       
     -+	revs.filter = &header->filter;
     ++	list_objects_filter_copy(&revs.filter, &header->filter);
      +
       	if (prepare_revision_walk(&revs))
       		die(_("revision walk setup failed"));
     @@ bundle.c: int verify_bundle(struct repository *r,
       			  r->nr);
       		list_refs(r, 0, NULL);
      +
     -+		if (header->filter.choice != LOFC_DISABLED) {
     ++		if (header->filter.choice) {
      +			printf_ln("The bundle uses this filter: %s",
      +				  list_objects_filter_spec(&header->filter));
      +		}
  9:  2c8e8a6c2a5 ! 10:  05d7322fdfc rev-list: move --filter parsing into revision.c
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       		}
      -
      -		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
     --			if (!revs.filter)
     --				CALLOC_ARRAY(revs.filter, 1);
     --			parse_list_objects_filter(revs.filter, arg);
     --			if (revs.filter->choice && !revs.blob_objects)
     +-			parse_list_objects_filter(&revs.filter, arg);
     +-			if (revs.filter.choice && !revs.blob_objects)
      -				die(_("object filtering requires --objects"));
      -			continue;
      -		}
      -		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
     --			if (!revs.filter)
     --				CALLOC_ARRAY(revs.filter, 1);
     --			list_objects_filter_set_no_filter(revs.filter);
     +-			list_objects_filter_set_no_filter(&revs.filter);
      -			continue;
      -		}
       		if (!strcmp(arg, "--filter-provided-objects")) {
     @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *revs,
       	} else if (!strcmp(arg, "--single-worktree")) {
       		revs->single_worktree = 1;
      +	} else if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
     -+		if (!revs->filter)
     -+			CALLOC_ARRAY(revs->filter, 1);
     -+		parse_list_objects_filter(revs->filter, arg);
     ++		parse_list_objects_filter(&revs->filter, arg);
      +	} else if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
     -+		if (!revs->filter)
     -+			CALLOC_ARRAY(revs->filter, 1);
     -+		list_objects_filter_set_no_filter(revs->filter);
     ++		list_objects_filter_set_no_filter(&revs->filter);
       	} else {
       		return 0;
       	}
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
       		die("cannot combine --walk-reflogs with history-limiting options");
       	if (revs->rewrite_parents && revs->children.name)
       		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
     -+	if (revs->filter && revs->filter->choice && !revs->blob_objects)
     ++	if (revs->filter.choice && !revs->blob_objects)
      +		die(_("object filtering requires --objects"));
       
       	/*
 10:  470b6f73e28 ! 11:  7435095bbc9 bundle: create filtered bundles
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## Documentation/git-bundle.txt ##
     -@@ Documentation/git-bundle.txt: verify <file>::
     - 	cleanly to the current repository.  This includes checks on the
     - 	bundle format itself as well as checking that the prerequisite
     - 	commits exist and are fully linked in the current repository.
     --	'git bundle' prints a list of missing commits, if any, and exits
     --	with a non-zero status.
     -+	'git bundle' prints the bundle's object filter and its list of
     -+	missing commits, if any, and exits with a non-zero status.
     - 
     - list-heads <file>::
     - 	Lists the references defined in the bundle.  If followed by a
     -
       ## bundle.c ##
      @@ bundle.c: static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
       		     "--stdout", "--thin", "--delta-base-offset",
       		     NULL);
       	strvec_pushv(&pack_objects.args, pack_options->v);
     -+	if (revs->filter)
     ++	if (revs->filter.choice)
      +		strvec_pushf(&pack_objects.args, "--filter=%s",
     -+			     list_objects_filter_spec(revs->filter));
     ++			     list_objects_filter_spec(&revs->filter));
       	pack_objects.in = -1;
       	pack_objects.out = bundle_fd;
       	pack_objects.git_cmd = 1;
     @@ bundle.c: int create_bundle(struct repository *r, const char *path,
      +	 *    SHA1.
      +	 * 2. @filter is required because we parsed an object filter.
      +	 */
     -+	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter)
     ++	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter.choice)
      +		min_version = 3;
      +
      +	if (argc > 1) {
     @@ bundle.c: int create_bundle(struct repository *r, const char *path,
      -	if (argc > 1) {
      -		error(_("unrecognized argument: %s"), argv[1]);
      -		goto err;
     -+		if (revs.filter) {
     -+			const char *value = expand_list_objects_filter_spec(revs.filter);
     ++		if (revs.filter.choice) {
     ++			const char *value = expand_list_objects_filter_spec(&revs.filter);
      +			capability = "@filter=";
      +			write_or_die(bundle_fd, capability, strlen(capability));
      +			write_or_die(bundle_fd, value, strlen(value));
     @@ bundle.c: int create_bundle(struct repository *r, const char *path,
       	bpi.pending = &revs_copy.pending;
       
      +	/*
     -+	 * Nullify the filter here, and any object walking. We only care
     -+	 * about commits and tags here. The revs_copy has the right
     -+	 * instances of these values.
     ++	 * Remove any object walking here. We only care about commits and
     ++	 * tags here. The revs_copy has the right instances of these values.
      +	 */
     -+	revs.filter = NULL;
       	revs.blob_objects = revs.tree_objects = 0;
       	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
       	object_array_remove_duplicates(&revs_copy.pending);
 11:  e85ca2770a3 ! 12:  77a62156332 bundle: unbundle promisor packs
     @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
       	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
       
      +	/* If there is a filter, then we need to create the promisor pack. */
     -+	if (header->filter.choice != LOFC_DISABLED)
     ++	if (header->filter.choice)
      +		strvec_push(&ip.args, "--promisor=from-bundle");
      +
       	if (extra_index_pack_args) {
 12:  805e1d11722 ! 13:  de6a1a868d3 clone: fail gracefully when cloning filtered bundle
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	transport->cloning = 1;
       
      +	if (is_bundle) {
     -+		struct bundle_header header = { 0 };
     ++		struct bundle_header header = BUNDLE_HEADER_INIT;
      +		int fd = read_bundle_header(path, &header);
      +		int has_filter = header.filter.choice != LOFC_DISABLED;
      +

-- 
gitgitgadget
