Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD52C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbhLGUXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLGUXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07BC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so84888wru.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rAxIEBO3Mju6hJ0MQgiWtSsQq8Y+3Mu+q44LEuYg1z4=;
        b=dEyMbEeT76Ib2sSXBoezwk5231QLK9mXfpTdH2rY+TxXJGSIDnzLqukY8CuHHuR5OR
         FQZlR8UnGYnAKV5CXiDR3FKI0mhEUOUJkjV6aegYKtkL0Fi4z6OpgzDmJ6wrD1j6tFFW
         glGlvI5WNlPqOWrK+knuRsFYtmZBk3pT4OqCZp0nhtSfKLvZ/myqDJ7K4o7cqMWtULOB
         NbgtypbIlaj7yNxFnGQHQL8S9YKSt/XUEIsYGf8ldtR61V72TC+SzCBV22ZZp9sVt8kc
         JpZ9tKLP66Q5Lz3mKZDTGtn3CO6fDVJKAHxeZkM4k9PhSYS/Z2Y2SIVD80/FJoK0L5QE
         ZX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rAxIEBO3Mju6hJ0MQgiWtSsQq8Y+3Mu+q44LEuYg1z4=;
        b=gVjEk6Mj+zY2urytk2U5seAjQpi/y8vKra2U4KTB33fACdTphNd5C7Eea9TIGtB2/t
         hHeSc5hhUmLUJOguL3lqN6v/p+y7DyMAXQ9HUc4S47gd9ZUwwTau9c+Oby9T7EsUmaN9
         VUapE797/nMdN6vXgdIYVLbnPv512tqzmL5SEA86PLxciutkUmBBLFPvc6OhBneeGTUC
         +MPVR+QH1Fl0kZqORw4epKpRPEy1WpErSLb/ici7fecVxs3N5kgGGJCK1OJLqgyGNR9G
         9tYeU7qicbfDUqjTjgnYUoVebx+uBTnNppsRYh9kCRjsivnn6mEHfSbJ8IxhUV3ZmHec
         1DXQ==
X-Gm-Message-State: AOAM530j6iTd+6E/LiKySuAEHYPX4raLZg1ibKu3LkegTogZ9zbwZKFM
        A4f5AWQi9T6sxWRcn0USxQNOQnAWZis=
X-Google-Smtp-Source: ABdhPJy6h2hyjS0/IVUmxiUo19fKcw1U4n2w2A6/DJCEEvVbPjvGtUD0GVw423EMqOnq1zCf3hQtjQ==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr54690850wrc.417.1638908411930;
        Tue, 07 Dec 2021 12:20:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm626257wmc.14.2021.12.07.12.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:11 -0800 (PST)
Message-Id: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:00 +0000
Subject: [PATCH v2 00/10] sparse-checkout: make set subsume init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described at [1], the split of init and set subcommands in
sparse-checkout causes multiple issues:

 * Poor performance (deleting all tracked files, then later restoring many
   and maybe even most of them)
 * Poor UI (multiple progress bars in wrappers that hide both commands under
   1 user-facing command)
 * Loss of ignored files under directories the user wanted to keep

This series fixes this bug by providing a single command to switch to a
sparse-checkout: set. It does so by making set able to do the combined work
of init and set. It keeps init as-is to give folks time to adapt, but marks
it as deprecated. It also makes reapply able to toggle cone/non-cone mode
and sparse-index/non-sparse-index mode.

Changes since v1:

 * Inserted new patches 3 & 4 as additional preparatory cleanups
 * Took the new mode-toggling work code in sparse_checkout_set from the
   previous series and moved it into a new function, as a preparatory patch,
   and made it usable by init/set/reapply
 * Also updated reapply to allow mode-toggling
 * Updated the documentation as per above
 * Various other small items from review comments

A quick overview:

 * Patches 1-4: small preparatory refactorings
 * Patch 5: patch adding new function for toggling {cone,sparse-checkout}
   modes
 * Patch 6: the crux of the series; make set able to handle both init and
   set options
 * Patch 7: make reapply also able to do mode toggling
 * Patches 8-9: documentation modifications (Patch 4 is worth reviewing; it
   marks init as deprecated -- are others okay with that?)
 * Patch 10: trivial modification of git clone --sparse to use git
   sparse-checkout set rather than git sparse-checkout init.

[1]
https://lore.kernel.org/git/CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com/

Elijah Newren (10):
  sparse-checkout: pass use_stdin as a parameter instead of as a global
  sparse-checkout: break apart functions for sparse_checkout_(set|add)
  sparse-checkout: add sanity-checks on initial sparsity state
  sparse-checkout: disallow --no-stdin as an argument to set
  sparse-checkout: split out code for tweaking settings config
  sparse-checkout: enable `set` to initialize sparse-checkout mode
  sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
  git-sparse-checkout.txt: update to document init/set/reapply changes
  Documentation: clarify/correct a few sparsity related statements
  clone: avoid using deprecated `sparse-checkout init`

 Documentation/git-clone.txt           |   8 +-
 Documentation/git-sparse-checkout.txt | 100 +++++++------
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             | 196 ++++++++++++++++++++------
 t/t1091-sparse-checkout-builtin.sh    |  10 +-
 5 files changed, 219 insertions(+), 97 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1151%2Fnewren%2Fsparse-checkout-no-init-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1151/newren/sparse-checkout-no-init-v2
Pull-Request: https://github.com/git/git/pull/1151

Range-diff vs v1:

  1:  e41cfe3c1bb =  1:  e41cfe3c1bb sparse-checkout: pass use_stdin as a parameter instead of as a global
  2:  6f7de8f5412 =  2:  6f7de8f5412 sparse-checkout: break apart functions for sparse_checkout_(set|add)
  -:  ----------- >  3:  bade5e52390 sparse-checkout: add sanity-checks on initial sparsity state
  -:  ----------- >  4:  0180bfc4a93 sparse-checkout: disallow --no-stdin as an argument to set
  -:  ----------- >  5:  3f5255eeef9 sparse-checkout: split out code for tweaking settings config
  3:  a90687eb4c1 !  6:  3c640f5bcef sparse-checkout: enable `set` to initialize sparse-checkout mode
     @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char *
       
       static char const * const builtin_sparse_checkout_set_usage[] = {
      -	N_("git sparse-checkout set (--stdin | <patterns>)"),
     -+	N_("git sparse-checkout set [--cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
     ++	N_("git sparse-checkout set [--[no-]cone] [--[no-]sparse-index] (--stdin | <patterns>)"),
       	NULL
       };
       
     @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char *
       
       static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
       {
     -+	int mode, record_mode;
     -+	const char *default_patterns[] = {"/*", "!/*/"};
     ++	int default_patterns_nr = 2;
     ++	const char *default_patterns[] = {"/*", "!/*/", NULL};
      +
       	static struct option builtin_sparse_checkout_set_options[] = {
      +		OPT_BOOL(0, "cone", &set_opts.cone_mode,
      +			 N_("initialize the sparse-checkout in cone mode")),
      +		OPT_BOOL(0, "sparse-index", &set_opts.sparse_index,
      +			 N_("toggle the use of a sparse index")),
     - 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
     - 			 N_("read patterns from standard in")),
     - 		OPT_END(),
     + 		OPT_BOOL_F(0, "stdin", &set_opts.use_stdin,
     + 			   N_("read patterns from standard in"),
     + 			   PARSE_OPT_NONEG),
      @@ builtin/sparse-checkout.c: static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
       
       	repo_read_index(the_repository);
     @@ builtin/sparse-checkout.c: static int sparse_checkout_set(int argc, const char *
       			     builtin_sparse_checkout_set_usage,
       			     PARSE_OPT_KEEP_UNKNOWN);
       
     -+	/* Determine if we need to record the mode; ensure sparse checkout on */
     -+	record_mode = (set_opts.cone_mode != -1) || !core_apply_sparse_checkout;
     -+	core_apply_sparse_checkout = 1;
     -+
     -+	/* If not specified, use previous definition of cone mode */
     -+	if (set_opts.cone_mode == -1 && core_apply_sparse_checkout)
     -+		set_opts.cone_mode = core_sparse_checkout_cone;
     -+
     -+	/* Set cone/non-cone mode appropriately */
     -+	if (set_opts.cone_mode == 1) {
     -+		mode = MODE_CONE_PATTERNS;
     -+		core_sparse_checkout_cone = 1;
     -+	} else {
     -+		mode = MODE_ALL_PATTERNS;
     -+	}
     -+	if (record_mode && set_config(mode))
     ++	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
      +		return 1;
      +
     -+	/* Set sparse-index/non-sparse-index mode if specified */
     -+	if (set_opts.sparse_index >= 0) {
     -+		if (set_sparse_index_config(the_repository, set_opts.sparse_index) < 0)
     -+			die(_("failed to modify sparse-index config"));
     -+
     -+		/* force an index rewrite */
     -+		repo_read_index(the_repository);
     -+		the_repository->index->updated_workdir = 1;
     -+	}
     -+
      +	/*
      +	 * Cone mode automatically specifies the toplevel directory.  For
      +	 * non-cone mode, if nothing is specified, manually select just the
     @@ builtin/sparse-checkout.c: static int sparse_checkout_set(int argc, const char *
      +	 */
      +	if (!core_sparse_checkout_cone && argc == 0) {
      +		argv = default_patterns;
     -+		argc = 2;
     ++		argc = default_patterns_nr;
      +	}
      +
       	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
  -:  ----------- >  7:  acb10889a1f sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
  4:  95d3df78b2f !  8:  17b033caf4b git-sparse-checkout.txt: update to document that set handles init
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    git-sparse-checkout.txt: update to document that set handles init
     +    git-sparse-checkout.txt: update to document init/set/reapply changes
      
          As noted in the previous commit, using separate `init` and `set` steps
     -    with sparse-checkout result in a number of issues.  The previous commit
     -    made `set` able to handle the work of both commands.  Update the
     -    documentation to reflect this, and mark `init` as deprecated.
     +    with sparse-checkout result in a number of issues.  The previous commits
     +    made `set` able to handle the work of both commands, and enabled reapply
     +    to tweak the {cone,sparse-index} settings.  Update the documentation to
     +    reflect this, and mark `init` as deprecated.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ Documentation/git-sparse-checkout.txt: COMMANDS
      +files that are siblings of ancestor directories. The input format
      +matches the output of `git ls-tree --name-only`.  This includes
      +interpreting pathnames that begin with a double quote (") as C-style
     -+quoted strings.
     ++quoted strings.  This may become the default in the future; --no-cone
     ++can be passed to request non-cone mode.
       +
      -Use the `--[no-]sparse-index` option to toggle the use of the sparse
      -index format. This reduces the size of the index to be more closely
     @@ Documentation/git-sparse-checkout.txt: to rewrite your index to not be sparse. O
       	Update the sparse-checkout file to include additional patterns.
       	By default, these patterns are read from the command-line arguments,
      @@ Documentation/git-sparse-checkout.txt: C-style quoted strings.
     + 	cases, it can make sense to run `git sparse-checkout reapply` later
     + 	after cleaning up affected paths (e.g. resolving conflicts, undoing
     + 	or committing changes, etc.).
     +++
     ++The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
     ++flags, with the same meaning as the flags from the `set` command, in order
     ++to change which sparsity mode you are using without needing to also respecify
     ++all sparsity paths.
       
       'disable'::
       	Disable the `core.sparseCheckout` config setting, and restore the
  5:  9d455f1fb51 =  9:  922a65b4019 Documentation: clarify/correct a few sparsity related statements
  6:  2ad404874ee = 10:  d47b2c88242 clone: avoid using deprecated `sparse-checkout init`

-- 
gitgitgadget
