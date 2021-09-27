Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F6BC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AFD60EFD
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhI0Qfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbhI0Qfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:35:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB2C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so1124338wmq.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/L3emz/Km3xSiJ/B3L/HHssh8t9NWVNVkZ5l6s+cBXo=;
        b=Ape4ZEPOspQ4lHW8XYaDzRKPnx8YZlIEyzcXIm3mvAfKhA9N4GHko4cEyIyWU9bkhW
         hzzfvUWYyypplhFJ66ZtjarbZUuz7Ei06B6s2ZCN0VZHlbY0+TbTNBby1jXMFyDDsuxS
         25R2cu2vZS6pAq+e9Ojbq8/DrnT1aW67hxmaqS9SsC6AxtsaEAowce7ZgyYzoL/ychOr
         B/GgFJXBTaxsl0nBxikIp/8/dQuCtga/r6H6wuAowBmu8icLFAQ67ObSn1UrrVt4vvcr
         Lmb5qXrJua4nbkkTWZE8ADUaEH5cR/rNjOm+78ZHi8iERADo8NQnXf/0p0vOBSIA5ipN
         ZneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/L3emz/Km3xSiJ/B3L/HHssh8t9NWVNVkZ5l6s+cBXo=;
        b=6e0UKnnbojp2Ft49KU+3xjDwiXQOnpSoJGcAK573Du2G1yjpr+PL9OZEHmMxw94L0t
         Tb9L0IiSyc2EbxzBgjg77hlcWhAY+uSj8Iiwum7gp8k1sXylnNQmxlZX1oQTg1VQRAJO
         QG6b3Bz5YfmjRV5JpkEHHeGOo9oKuM1HMzwis73AeU99Iwsf1B516K7hcOG8wM/fEbDI
         D/wtD2JnC8podI61JF9kDoj3ycUm7igX4xs0dcX9fDnqdKQ8ysb1I9VAx0rujLDN8j23
         nwh54IPfVE+PfnK/t9+5mEOy50KuYpzYXeGdz0jAD5spbOYzszR1hq7fObqgDP2PXIWL
         D1JQ==
X-Gm-Message-State: AOAM533pSmw9oCYxmI8bZ2T45/JyH3vxYteHNoD1Kjvmn9DiVAkk+egt
        uqq1uNlO/LAaF2fpiQHI58sUJzZnE7E=
X-Google-Smtp-Source: ABdhPJxecl9VxPODrqRUf6kmpNYo3cygznCbmR6qeQF1EgkEW7U1bL1bQKi4onF6oRBpp3dkb1Bqgg==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id l11mr24353wmq.0.1632760429581;
        Mon, 27 Sep 2021 09:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm17222338wrl.94.2021.09.27.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:33:49 -0700 (PDT)
Message-Id: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 16:33:37 +0000
Subject: [PATCH v3 00/11] Fix various issues around removal of untracked files/directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have multiple codepaths that delete untracked files/directories but
shouldn't. There are also some codepaths where we delete untracked
files/directories intentionally (based on mailing list discussion), but
where that intent is not documented. We also have some codepaths that
preserve ignored files, which shouldn't. Fix the documentation, add several
new (mostly failing) testcases, fix some of the new testcases, and add
comments about some potential remaining problems. (I found these as a
side-effect of looking at [1], though [2] pointed out one explicitly while I
was working on it.)

Note that I'm using Junio's declaration about checkout -f and reset --hard
(and also presuming that since read-tree --reset is porcelain that its
behavior should be left alone)[3] in this series.

Changes since v2 (all due to Junio's request to consolidate
unpack_trees_options.dir handling):

 * fix some (pre-existing) memory leaks, in preparation for consolidating
   some common code (new patch 2)
 * New patches (3 & 6) to make a few more commands remove ignored files by
   default -- which also fixes an existing testcase
 * New patches (4 & 5) to consolidate the various places handling
   unpack_trees_options.dir and default to treating ignored files as
   expendable within unpack_trees(). These change also make it very easy to
   add --no-overwrite-ignore options in the future to additional commands
   (checkout and merge already have such an option, though merge only passes
   that along to the fast-forwarding backend)

Changes since v1:

 * Various small cleanups (suggested by Ævar)
 * Fixed memory leaks of unpack_trees_opts->dir (also suggested by Ævar)
 * Use an enum for unpack_trees_options->reset, instead of multiple fields
   (suggested by Phillip)
 * Avoid changing behavior for cases not setting unpack_trees_options.reset
   > 0 (even if it may make sense to nuke ignored files when running either
   read-tree -m -u or the various reset flavors run internally by
   rebase/sequencer); we can revisit that later.

SIDENOTE about treating ignored files as precious:

The patches are now getting pretty close to being able to handle ignored
files as precious. The only things left would be making merge pass the
--no-overwrite-ignore option along to more backends, and adding the
--no-overwrite-ignore option that both checkout and merge take to more
commands. There's already comments in the code about what boolean would need
to be set by that flag. And then perhaps also make a global
core.overwrite_ignored config option to affect all of these. Granted, doing
this would globally treat ignored files as precious rather than allowing
them to be configured on a per-path basis, but honestly I think the idea of
configuring ignored files as precious on a per-path basis sounds like
insanity. (We have enough bugs with untracked and ignored files without
adding yet another type. And, of course, configuring per-path rules sounds
like lots of work for end users to configure. There may be additional
reasons against it.) So, if someone wants to pursue the precious-ignored
concept then I'd much rather see it done as a global setting. Just my $0.02.

[1] https://lore.kernel.org/git/xmqqv93n7q1v.fsf@gitster.g/ [2]
https://lore.kernel.org/git/C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com/
[3] https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/

Elijah Newren (11):
  t2500: add various tests for nuking untracked files
  checkout, read-tree: fix leak of unpack_trees_options.dir
  read-tree, merge-recursive: overwrite ignored files by default
  unpack-trees: introduce preserve_ignored to unpack_trees_options
  unpack-trees: make dir an internal-only struct
  Remove ignored files by default when they are in the way
  Change unpack_trees' 'reset' flag into an enum
  unpack-trees: avoid nuking untracked dir in way of unmerged file
  unpack-trees: avoid nuking untracked dir in way of locally deleted
    file
  Comment important codepaths regarding nuking untracked files/dirs
  Documentation: call out commands that nuke untracked files/directories

 Documentation/git-checkout.txt   |   5 +-
 Documentation/git-read-tree.txt  |  23 +--
 Documentation/git-reset.txt      |   3 +-
 builtin/am.c                     |   3 +-
 builtin/checkout.c               |  10 +-
 builtin/clone.c                  |   1 +
 builtin/merge.c                  |   1 +
 builtin/read-tree.c              |  26 ++--
 builtin/reset.c                  |  10 +-
 builtin/stash.c                  |   5 +-
 builtin/submodule--helper.c      |   4 +
 contrib/rerere-train.sh          |   2 +-
 merge-ort.c                      |   8 +-
 merge-recursive.c                |   5 +-
 merge.c                          |   8 +-
 reset.c                          |   3 +-
 sequencer.c                      |   1 +
 submodule.c                      |   1 +
 t/t1013-read-tree-submodule.sh   |   1 -
 t/t2500-untracked-overwriting.sh | 244 +++++++++++++++++++++++++++++++
 t/t7112-reset-submodule.sh       |   1 -
 unpack-trees.c                   |  61 +++++++-
 unpack-trees.h                   |  14 +-
 23 files changed, 366 insertions(+), 74 deletions(-)
 create mode 100755 t/t2500-untracked-overwriting.sh


base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1036%2Fnewren%2Funtracked_removal-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1036/newren/untracked_removal-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1036

Range-diff vs v2:

  1:  9460a49c7ed =  1:  66270ffc74e t2500: add various tests for nuking untracked files
  -:  ----------- >  2:  0c74285b253 checkout, read-tree: fix leak of unpack_trees_options.dir
  -:  ----------- >  3:  2501a0c552a read-tree, merge-recursive: overwrite ignored files by default
  -:  ----------- >  4:  f1a0700e598 unpack-trees: introduce preserve_ignored to unpack_trees_options
  -:  ----------- >  5:  0d119142778 unpack-trees: make dir an internal-only struct
  -:  ----------- >  6:  b7fe354efff Remove ignored files by default when they are in the way
  2:  b77692b8f49 !  7:  9eb20121fc3 Change unpack_trees' 'reset' flag into an enum
     @@ Commit message
          (i.e. "true") can be split into two:
             UNPACK_RESET_PROTECT_UNTRACKED,
             UNPACK_RESET_OVERWRITE_UNTRACKED
     -    In order to catch accidental misuses, define with the enum a special
     -    value of
     +    In order to catch accidental misuses (i.e. where folks call it the way
     +    they traditionally used to), define the special enum value of
             UNPACK_RESET_INVALID = 1
          which will trigger a BUG().
      
     @@ Commit message
             numerous callers from rebase/sequencer to reset_head()
          will use the new UNPACK_RESET_PROTECT_UNTRACKED value.
      
     -    In order to protect untracked files but still allow deleting of ignored
     -    files, we also have to setup unpack_trees_opt.dir.  It may make sense to
     -    set up unpack_trees_opt.dir in more cases, but here I tried to only do
     -    so in cases where we switched from deleting all untracked files to
     -    avoiding doing so (i.e. where we now use
     -    UNPACK_RESET_PROTECT_UNTRACKED).
     +    Also, note that it has been reported that 'git checkout <treeish>
     +    <pathspec>' currently also allows overwriting untracked files[1].  That
     +    case should also be fixed, but it does not use unpack_trees() and thus
     +    is outside the scope of the current changes.
      
     -    Also, note that 'git checkout <pathspec>' currently also allows
     -    overwriting untracked files.  That case should also be fixed, but it
     -    does not use unpack_trees() and thus is outside the scope of the current
     -    changes.
     +    [1] https://lore.kernel.org/git/15dad590-087e-5a48-9238-5d2826950506@gmail.com/
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote,
       	opts.update = 1;
       	opts.merge = 1;
      -	opts.reset = reset;
     +-	if (!reset)
     +-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
      +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
     ++	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
       	opts.fn = twoway_merge;
     -+	if (opts.reset) {
     -+		/* Allow ignored files in the way to get overwritten */
     -+		opts.dir = xcalloc(1, sizeof(*opts.dir));
     -+		opts.dir->flags |= DIR_SHOW_IGNORED;
     -+		setup_standard_excludes(opts.dir);
     -+	}
       	init_tree_desc(&t[0], head->buffer, head->size);
       	init_tree_desc(&t[1], remote->buffer, remote->size);
     - 
     -@@ builtin/am.c: static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
     - 		return -1;
     - 	}
     - 
     -+	if (opts.reset) {
     -+		dir_clear(opts.dir);
     -+		FREE_AND_NULL(opts.dir);
     -+	}
     -+
     - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
     - 		die(_("unable to write new index file"));
     - 
      
       ## builtin/checkout.c ##
      @@ builtin/checkout.c: static int reset_tree(struct tree *tree, const struct checkout_opts *o,
     - {
     - 	struct unpack_trees_options opts;
     - 	struct tree_desc tree_desc;
     -+	int unpack_trees_ret;
     - 
     - 	memset(&opts, 0, sizeof(opts));
       	opts.head_idx = -1;
       	opts.update = worktree;
       	opts.skip_unmerged = !worktree;
      -	opts.reset = 1;
      +	opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
      +				UNPACK_RESET_PROTECT_UNTRACKED;
     ++	opts.preserve_ignored = (!o->force && !o->overwrite_ignore);
       	opts.merge = 1;
     +-	opts.preserve_ignored = 0;
       	opts.fn = oneway_merge;
       	opts.verbose_update = o->show_progress;
       	opts.src_index = &the_index;
     - 	opts.dst_index = &the_index;
     -+	if (o->overwrite_ignore) {
     -+		opts.dir = xcalloc(1, sizeof(*opts.dir));
     -+		opts.dir->flags |= DIR_SHOW_IGNORED;
     -+		setup_standard_excludes(opts.dir);
     -+	}
     - 	init_checkout_metadata(&opts.meta, info->refname,
     - 			       info->commit ? &info->commit->object.oid : null_oid(),
     - 			       NULL);
     - 	parse_tree(tree);
     - 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
     --	switch (unpack_trees(1, &tree_desc, &opts)) {
     -+	unpack_trees_ret = unpack_trees(1, &tree_desc, &opts);
     -+
     -+	if (o->overwrite_ignore) {
     -+		dir_clear(opts.dir);
     -+		FREE_AND_NULL(opts.dir);
     -+	}
     -+
     -+	switch (unpack_trees_ret) {
     - 	case -2:
     - 		*writeout_error = 1;
     - 		/*
      
       ## builtin/read-tree.c ##
      @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **argv, const char *
       	 *
      
       ## builtin/reset.c ##
     -@@
     - #define USE_THE_INDEX_COMPATIBILITY_MACROS
     - #include "builtin.h"
     - #include "config.h"
     -+#include "dir.h"
     - #include "lockfile.h"
     - #include "tag.h"
     - #include "object.h"
      @@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id *oid, int reset_t
       		break;
       	case HARD:
     @@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id
       	default:
      -		opts.reset = 1;
      +		BUG("invalid reset_type passed to reset_index");
     -+	}
     -+	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
     -+		/* Setup opts.dir so we can overwrite ignored files */
     -+		opts.dir = xcalloc(1, sizeof(*opts.dir));
     -+		opts.dir->flags |= DIR_SHOW_IGNORED;
     -+		setup_standard_excludes(opts.dir);
       	}
       
       	read_cache_unmerged();
     -@@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id *oid, int reset_t
     - 	ret = 0;
     - 
     - out:
     -+	if (opts.reset == UNPACK_RESET_PROTECT_UNTRACKED) {
     -+		dir_clear(opts.dir);
     -+		FREE_AND_NULL(opts.dir);
     -+	}
     - 	for (i = 0; i < nr; i++)
     - 		free((void *)desc[i].buffer);
     - 	return ret;
      
       ## builtin/stash.c ##
     -@@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
     - 	struct tree_desc t[MAX_UNPACK_TREES];
     - 	struct tree *tree;
     - 	struct lock_file lock_file = LOCK_INIT;
     -+	int unpack_trees_ret;
     - 
     - 	read_cache_preload(NULL);
     - 	if (refresh_cache(REFRESH_QUIET))
      @@ builtin/stash.c: static int reset_tree(struct object_id *i_tree, int update, int reset)
       	opts.src_index = &the_index;
       	opts.dst_index = &the_index;
       	opts.merge = 1;
      -	opts.reset = reset;
      +	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
     -+	if (opts.reset) {
     -+		opts.dir = xcalloc(1, sizeof(*opts.dir));
     -+		opts.dir->flags |= DIR_SHOW_IGNORED;
     -+		setup_standard_excludes(opts.dir);
     -+	}
       	opts.update = update;
     +-	if (update && !reset)
     ++	if (update)
     + 		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
       	opts.fn = oneway_merge;
       
     --	if (unpack_trees(nr_trees, t, &opts))
     -+	unpack_trees_ret = unpack_trees(nr_trees, t, &opts);
     -+
     -+	if (opts.reset) {
     -+		dir_clear(opts.dir);
     -+		FREE_AND_NULL(opts.dir);
     -+	}
     -+
     -+	if (unpack_trees_ret)
     - 		return -1;
     - 
     - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
      
       ## reset.c ##
     -@@
     - #include "git-compat-util.h"
     - #include "cache-tree.h"
     -+#include "dir.h"
     - #include "lockfile.h"
     - #include "refs.h"
     - #include "reset.h"
      @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char *action,
     - 	unpack_tree_opts.update = 1;
     - 	unpack_tree_opts.merge = 1;
     + 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
       	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
     --	if (!detach_head)
     + 	if (!detach_head)
      -		unpack_tree_opts.reset = 1;
     -+	if (!detach_head) {
      +		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
     -+		unpack_tree_opts.dir = xcalloc(1, sizeof(*unpack_tree_opts.dir));
     -+		unpack_tree_opts.dir->flags |= DIR_SHOW_IGNORED;
     -+		setup_standard_excludes(unpack_tree_opts.dir);
     -+	}
       
       	if (repo_read_index_unmerged(r) < 0) {
       		ret = error(_("could not read index"));
     -@@ reset.c: reset_head_refs:
     - 			    oid_to_hex(oid), "1", NULL);
     - 
     - leave_reset_head:
     -+	if (unpack_tree_opts.dir) {
     -+		dir_clear(unpack_tree_opts.dir);
     -+		FREE_AND_NULL(unpack_tree_opts.dir);
     -+	}
     - 	strbuf_release(&msg);
     - 	rollback_lock_file(&lock);
     - 	clear_unpack_trees_porcelain(&unpack_tree_opts);
      
       ## t/t2500-untracked-overwriting.sh ##
      @@ t/t2500-untracked-overwriting.sh: test_setup_checkout_m () {
     @@ t/t2500-untracked-overwriting.sh: test_expect_failure 'git rebase --abort and un
      
       ## unpack-trees.c ##
      @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
     - 	struct pattern_list pl;
       	int free_pattern_list = 0;
     + 	struct dir_struct dir = DIR_INIT;
       
      +	if (o->reset == UNPACK_RESET_INVALID)
      +		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
      +
       	if (len > MAX_UNPACK_TREES)
       		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
     + 	if (o->dir)
     +@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
     + 		ensure_full_index(o->dst_index);
     + 	}
       
     ++	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED &&
     ++	    o->preserve_ignored)
     ++		BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible with preserved ignored files");
     ++
     + 	if (!o->preserve_ignored) {
     + 		o->dir = &dir;
     + 		o->dir->flags |= DIR_SHOW_IGNORED;
      @@ unpack-trees.c: static int verify_absent_1(const struct cache_entry *ce,
       	int len;
       	struct stat st;
     @@ unpack-trees.h: void setup_unpack_trees_porcelain(struct unpack_trees_options *o
      -		     merge,
      +	unsigned int merge,
       		     update,
     + 		     preserve_ignored,
       		     clone,
     - 		     index_only,
      @@ unpack-trees.h: struct unpack_trees_options {
       		     exiting_early,
       		     show_all_errors,
     @@ unpack-trees.h: struct unpack_trees_options {
      +	enum unpack_trees_reset_type reset;
       	const char *prefix;
       	int cache_bottom;
     - 	struct dir_struct *dir;
     + 	struct pathspec *pathspec;
  3:  208f3b3ebe5 =  8:  e4c42d43b09 unpack-trees: avoid nuking untracked dir in way of unmerged file
  4:  0a0997d081b =  9:  1a770681704 unpack-trees: avoid nuking untracked dir in way of locally deleted file
  5:  4b78a526d2a ! 10:  6b42a80bf3d Comment important codepaths regarding nuking untracked files/dirs
     @@ Commit message
            * git-archimport.perl: Don't care; arch is long since dead
            * git-cvs*.perl: Don't care; cvs is long since dead
      
     +    Also, the reset --hard in builtin/worktree.c looks safe, due to only
     +    running in an empty directory.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/stash.c ##
     @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
       
       		if (add_data->branch) {
      
     - ## builtin/worktree.c ##
     -@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
     - 	if (opts->checkout) {
     - 		cp.argv = NULL;
     - 		strvec_clear(&cp.args);
     -+		/*
     -+		 * NOTE: reset --hard is okay here, because 'worktree add'
     -+		 * refuses to work in an extant non-empty directory, so there
     -+		 * is no risk of deleting untracked files.
     -+		 */
     - 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
     - 		if (opts->quiet)
     - 			strvec_push(&cp.args, "--quiet");
     -
       ## contrib/rerere-train.sh ##
      @@ contrib/rerere-train.sh: do
       		git checkout -q $commit -- .
  6:  993451a8036 = 11:  de416f887d7 Documentation: call out commands that nuke untracked files/directories

-- 
gitgitgadget
