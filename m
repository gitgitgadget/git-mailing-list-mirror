Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF510C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AEC64EED
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhCQU5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhCQU4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D912C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so3262347wrn.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DFcbG/+O66fBy5ztwRSDO7/S87Yn7g8A7IS0gHTH4w=;
        b=iCu0a218+pS4m4xS5N5k9B5U/JhdUV0I9l73vUlVqzbjpLQCbSExh0C8QasJpALitw
         mSrcg+1HzrC5GUx3iZ6qF8wYMjpdPuweEjt2+55A9c0UchoqhOzJtA2RTKbr3HCUYBcn
         i305Yk40SXpLDfLfkc2kcsX9rgaRfnH+SpFl7OZSym8s0NCF+bn1x5X59uVaLyq3rDhI
         XMlyVYe9rm/jsG3GTJx7Js4pY4acGbGt6FARdWxL+iIeXK0f384HqNOVHpWNbk0ARgXZ
         Z29aVVnNb+lpbjTSG/YaTqkDbqg4eFVIAVAhO/V16PPPwqRXIIAW625HncIed3OrkTdL
         OG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DFcbG/+O66fBy5ztwRSDO7/S87Yn7g8A7IS0gHTH4w=;
        b=q8yzHP9GCcS12230n8xpCayl7WKO8zzoBfIc9j2o3hsH9nLH9EsXJUl/lvUgd603d8
         +jZAiMIXU3WrO7nkh5xA8DXEuZoH6mGeC2wgSdxonJP5vwULJkhjWT9RONm00ygNtfT3
         1PP50UT1Sbq2jbhybTPYJq6s/bmHpdbkbS9aJt2l4eVfA7ZIpQMaS+PMMVYNOEN9YFKM
         6aloXy+BIzq1o0cawQgrMJjmJDDcI9BJPCZiFV6fecjSEo3oqI+q5SJNsAoEQJO/Wh9/
         B+BdA1jVV0sVzmUyFANJj9wwBLczgCJscsKjFEQHeNPxtl7H1D/YXmAlRPIJvoNCZTtq
         NFFw==
X-Gm-Message-State: AOAM532WI/Hz/GBpQeV9PZofWnHLWZI+5O52k9LFs0LX8iJPqHcg85Eh
        Zcl+Y2N/qH+Vo98Q6JR/F+rqRFhYOoE=
X-Google-Smtp-Source: ABdhPJyyt8j8f6X/p7JmdXRd/zsppMzDQ1VsJ9l1D+8Zd941I/0GZqcp99ywonKFd7PHa2bWflxglA==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr6268827wrp.269.1616014593729;
        Wed, 17 Mar 2021 13:56:33 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:32 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 00/15] Rewrite the remaining merge strategies from shell to C
Date:   Wed, 17 Mar 2021 21:49:24 +0100
Message-Id: <20210317204939.17890-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to reduce the number of shell scripts in git's codebase, I
propose this patch series converting the two remaining merge strategies,
resolve and octopus, from shell to C.  This will enable slightly better
performance, better integration with git itself (no more forking to
perform these operations), better portability (Windows and shell scripts
don't mix well).

Three scripts are actually converted: first git-merge-one-file.sh, then
git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
are converted, but they also are modified to operate without forking,
and then libified so they can be used by git without spawning another
process.

The first patch is not important to make the whole series work, but I
made this patch while working on it.

This series keeps the commands `git merge-one-file', `git
merge-resolve', and `git merge-octopus', so any script depending on them
should keep working without changes.

This series is based on a5828ae6b5 (Git 2.31, 2021-03-15).  The tip is
tagged as "rewrite-merge-strategies-v7" at https://github.com/agrn/git.

Changes since v6:

 - The series has been rebased on Git 2.31.

 - The series has been reordered.  Now, all the work around merge-index
   happens first to handle the case when git has been compiled with
   SKIP_DASHED_BUILT_INS enabled.

 - Remove usage of the index in the new builtins and in merge-index.

 - Adapt t6407 to use the "main" branch instead of "master".

 - Move merge_one_file_spawn() from merge-strategies.c to
   builtin/merge-index.c.

 - The functions extracted from merge-index and merge_three_way() now
   take a `struct index_state *' instead of a `struct repository *'.

 - Introduce ADD_TO_INDEX_CACHEINFO_{INVALID_PATH,UNABLE_TO_ADD}.

 - Remove checkout_from_index(), and replace it by
   add_merge_result_to_index(), a new function that calls
   add_to_index_cacheinfo() and checkout_entry() at the same time.

 - Fix a case where a file deleted in both branches would result in a
   failure in merge_three_way().  A test case has been added in t6060 to
   check that the new version is correct.

 - Rename some variables in merge_strategies_octopus(), and change its
   flow to make it more understandable.

 - Use CALLOC_ARRAY() in merge_strategies_octopus() instead of
   xcalloc().

 - Change merge-resolve and merge-octopus to handle the case where they
   are given an empty tree instead of a commit.

Alban Gruin (15):
  t6407: modernise tests
  t6060: modify multiple files to expose a possible issue with
    merge-index
  t6060: add tests for removed files
  merge-index: libify merge_one_path() and merge_all()
  merge-index: drop the index
  merge-index: add a new way to invoke `git-merge-one-file'
  update-index: move add_cacheinfo() to read-cache.c
  merge-one-file: rewrite in C
  merge-resolve: rewrite in C
  merge-recursive: move better_branch_name() to merge.c
  merge-octopus: rewrite in C
  merge: use the "resolve" strategy without forking
  merge: use the "octopus" strategy without forking
  sequencer: use the "resolve" strategy without forking
  sequencer: use the "octopus" merge strategy without forking

 Documentation/git-merge-index.txt |   7 +-
 Makefile                          |   7 +-
 builtin.h                         |   3 +
 builtin/merge-index.c             | 119 ++++---
 builtin/merge-octopus.c           |  70 ++++
 builtin/merge-one-file.c          |  94 ++++++
 builtin/merge-recursive.c         |  16 +-
 builtin/merge-resolve.c           |  74 ++++
 builtin/merge.c                   |   7 +
 builtin/update-index.c            |  25 +-
 cache.h                           |  10 +-
 git-merge-octopus.sh              | 112 ------
 git-merge-one-file.sh             | 167 ---------
 git-merge-resolve.sh              |  54 ---
 git.c                             |   3 +
 merge-strategies.c                | 544 ++++++++++++++++++++++++++++++
 merge-strategies.h                |  39 +++
 merge.c                           |  12 +
 read-cache.c                      |  35 ++
 sequencer.c                       |  17 +-
 t/t6060-merge-index.sh            |  23 +-
 t/t6407-merge-binary.sh           |  27 +-
 t/t6415-merge-dir-to-symlink.sh   |   2 +-
 23 files changed, 1001 insertions(+), 466 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v6:
 1:  70d6507330 !  1:  dfe230bfce t6407: modernise tests
    @@ Commit message
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## t/t6407-merge-binary.sh ##
    -@@ t/t6407-merge-binary.sh: test_description='ask merge-recursive to merge binary files'
    +@@ t/t6407-merge-binary.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
      
      test_expect_success setup '
    @@ t/t6407-merge-binary.sh: test_expect_success setup '
      	rm -f a* m* &&
      	git reset --hard anchor &&
     -
    --	if git merge -s resolve master
    +-	if git merge -s resolve main
     -	then
     -		echo Oops, should not have succeeded
     -		false
    @@ t/t6407-merge-binary.sh: test_expect_success setup '
     -		git ls-files -s >current
     -		test_cmp expect current
     -	fi
    -+	test_must_fail git merge -s resolve master &&
    ++	test_must_fail git merge -s resolve main &&
     +	git ls-files -s >current &&
     +	test_cmp expect current
      '
    @@ t/t6407-merge-binary.sh: test_expect_success setup '
      	rm -f a* m* &&
      	git reset --hard anchor &&
     -
    --	if git merge -s recursive master
    +-	if git merge -s recursive main
     -	then
     -		echo Oops, should not have succeeded
     -		false
    @@ t/t6407-merge-binary.sh: test_expect_success setup '
     -		git ls-files -s >current
     -		test_cmp expect current
     -	fi
    -+	test_must_fail git merge -s recursive master &&
    ++	test_must_fail git merge -s recursive main &&
     +	git ls-files -s >current &&
     +	test_cmp expect current
      '
 2:  25e9c47e41 =  2:  575e24685d t6060: modify multiple files to expose a possible issue with merge-index
 -:  ---------- >  3:  4f366ff363 t6060: add tests for removed files
 -:  ---------- >  4:  6af79a6b2d merge-index: libify merge_one_path() and merge_all()
 -:  ---------- >  5:  909ed66114 merge-index: drop the index
 -:  ---------- >  6:  1a8aba05bd merge-index: add a new way to invoke `git-merge-one-file'
 3:  e7ea43c5ff !  7:  1f6635512c update-index: move add_cacheinfo() to read-cache.c
    @@ builtin/update-index.c: static int process_path(const char *path, struct stat *s
     -	if (add_cache_entry(ce, option))
     +	res = add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
     +				     allow_add, allow_replace, NULL);
    -+	if (res == -1)
    -+		return res;
    -+	if (res == -2)
    ++	if (res == ADD_TO_INDEX_CACHEINFO_INVALID_PATH)
    ++		return error(_("Invalid path '%s'"), path);
    ++	if (res == ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD)
      		return error("%s: cannot add to the index - missing --add option?",
      			     path);
     +
    @@ cache.h: int remove_file_from_index(struct index_state *, const char *path);
      int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
      int add_file_to_index(struct index_state *, const char *path, int flags);
      
    ++#define ADD_TO_INDEX_CACHEINFO_INVALID_PATH (-1)
    ++#define ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD (-2)
    ++
     +int add_to_index_cacheinfo(struct index_state *, unsigned int mode,
     +			   const struct object_id *oid, const char *path,
     +			   int stage, int allow_add, int allow_replace,
    -+			   struct cache_entry **pce);
    ++			   struct cache_entry **ce_ret);
     +
      int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
      int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
    @@ read-cache.c: int add_index_entry(struct index_state *istate, struct cache_entry
     +int add_to_index_cacheinfo(struct index_state *istate, unsigned int mode,
     +			   const struct object_id *oid, const char *path,
     +			   int stage, int allow_add, int allow_replace,
    -+			   struct cache_entry **pce)
    ++			   struct cache_entry **ce_ret)
     +{
     +	int len, option;
    -+	struct cache_entry *ce = NULL;
    ++	struct cache_entry *ce;
     +
     +	if (!verify_path(path, mode))
    -+		return error(_("Invalid path '%s'"), path);
    ++		return ADD_TO_INDEX_CACHEINFO_INVALID_PATH;
     +
     +	len = strlen(path);
     +	ce = make_empty_cache_entry(istate, len);
    @@ read-cache.c: int add_index_entry(struct index_state *istate, struct cache_entry
     +
     +	if (add_index_entry(istate, ce, option)) {
     +		discard_cache_entry(ce);
    -+		return -2;
    ++		return ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD;
     +	}
     +
    -+	if (pce)
    -+		*pce = ce;
    ++	if (ce_ret)
    ++		*ce_ret = ce;
     +
     +	return 0;
     +}
 4:  284fc4227f !  8:  8755608f6d merge-one-file: rewrite in C
    @@ Commit message
         it did not because there was no regular file called `a/b'.  This test is
         now marked as successful.
     
    +    This also teaches `merge-index' to call merge_three_way() (when invoked
    +    with `--use=merge-one-file') without forking using a new callback,
    +    merge_one_file_func().
    +
    +    To avoid any issue with a shrinking index because of the merge function
    +    used (directly in the process or by forking), as described earlier, the
    +    iterator of the loop of merge_all_index() is increased by the number of
    +    entries with the same name, minus the difference between the number of
    +    entries in the index before and after the merge.
    +
    +    This should handle a shrinking index correctly, but could lead to issues
    +    with a growing index.  However, this case is not treated, as there is no
    +    callback that can produce such a case.
    +
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## Makefile ##
    @@ Makefile: SCRIPT_SH += git-bisect.sh
      SCRIPT_SH += git-merge-resolve.sh
      SCRIPT_SH += git-mergetool.sh
      SCRIPT_SH += git-quiltimport.sh
    -@@ Makefile: LIB_OBJS += match-trees.o
    - LIB_OBJS += mem-pool.o
    - LIB_OBJS += merge-blobs.o
    - LIB_OBJS += merge-recursive.o
    -+LIB_OBJS += merge-strategies.o
    - LIB_OBJS += merge.o
    - LIB_OBJS += mergesort.o
    - LIB_OBJS += midx.o
     @@ Makefile: BUILTIN_OBJS += builtin/mailsplit.o
      BUILTIN_OBJS += builtin/merge-base.o
      BUILTIN_OBJS += builtin/merge-file.o
    @@ builtin.h: int cmd_merge_base(int argc, const char **argv, const char *prefix);
      int cmd_merge_tree(int argc, const char **argv, const char *prefix);
      int cmd_mktag(int argc, const char **argv, const char *prefix);
     
    + ## builtin/merge-index.c ##
    +@@ builtin/merge-index.c: static int merge_one_file_spawn(struct index_state *istate,
    + int cmd_merge_index(int argc, const char **argv, const char *prefix)
    + {
    + 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
    +-	merge_fn merge_action = merge_one_file_spawn;
    ++	merge_fn merge_action;
    + 	struct lock_file lock = LOCK_INIT;
    + 	struct repository *r = the_repository;
    + 	const char *use_internal = NULL;
    +@@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
    + 
    + 	if (skip_prefix(pgm, "--use=", &use_internal)) {
    + 		if (!strcmp(use_internal, "merge-one-file"))
    +-			pgm = "git-merge-one-file";
    ++			merge_action = merge_one_file_func;
    + 		else
    + 			die(_("git merge-index: unknown internal program %s"), use_internal);
    +-	}
    ++
    ++		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    ++	} else
    ++		merge_action = merge_one_file_spawn;
    + 
    + 	for (; i < argc; i++) {
    + 		const char *arg = argv[i];
    +
      ## builtin/merge-one-file.c (new) ##
     @@
     +/*
    @@ builtin/merge-one-file.c (new)
     + * that might change the tree layout.
     + */
     +
    -+#define USE_THE_INDEX_COMPATIBILITY_MACROS
     +#include "cache.h"
     +#include "builtin.h"
     +#include "lockfile.h"
    @@ builtin/merge-one-file.c (new)
     +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
     +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret = 0;
     +	struct lock_file lock = LOCK_INIT;
    ++	struct repository *r = the_repository;
     +
     +	if (argc != 8)
     +		usage(builtin_merge_one_file_usage);
     +
    -+	if (read_cache() < 0)
    ++	if (repo_read_index(r) < 0)
     +		die("invalid index");
     +
    -+	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
    ++	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
     +
     +	if (!get_oid_hex(argv[1], &orig_blob)) {
     +		p_orig_blob = &orig_blob;
    @@ builtin/merge-one-file.c (new)
     +	if (ret)
     +		return ret;
     +
    -+	ret = merge_three_way(the_repository, p_orig_blob, p_our_blob, p_their_blob,
    ++	ret = merge_three_way(r->index, p_orig_blob, p_our_blob, p_their_blob,
     +			      argv[4], orig_mode, our_mode, their_mode);
     +
     +	if (ret) {
    @@ builtin/merge-one-file.c (new)
     +		return !!ret;
     +	}
     +
    -+	return write_locked_index(&the_index, &lock, COMMIT_LOCK);
    ++	return write_locked_index(r->index, &lock, COMMIT_LOCK);
     +}
     
      ## git-merge-one-file.sh (deleted) ##
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
      	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
     
    - ## merge-strategies.c (new) ##
    + ## merge-strategies.c ##
     @@
    -+#include "cache.h"
    + #include "cache.h"
     +#include "dir.h"
    -+#include "merge-strategies.h"
    + #include "merge-strategies.h"
     +#include "xdiff-interface.h"
     +
    -+static int checkout_from_index(struct index_state *istate, const char *path,
    -+			       struct cache_entry *ce)
    ++static int add_merge_result_to_index(struct index_state *istate, unsigned int mode,
    ++				     const struct object_id *oid, const char *path,
    ++				     int checkout)
     +{
    -+	struct checkout state = CHECKOUT_INIT;
    ++	struct cache_entry *ce;
    ++	int res;
     +
    -+	state.istate = istate;
    -+	state.force = 1;
    -+	state.base_dir = "";
    -+	state.base_dir_len = 0;
    ++	res = add_to_index_cacheinfo(istate, mode, oid, path, 0, 1, 1, &ce);
    ++	if (res == -1)
    ++		return error(_("Invalid path '%s'"), path);
    ++	else if (res == -2)
    ++		return -1;
    ++
    ++	if (checkout) {
    ++		struct checkout state = CHECKOUT_INIT;
    ++
    ++		state.istate = istate;
    ++		state.force = 1;
    ++		state.base_dir = "";
    ++		state.base_dir_len = 0;
    ++
    ++		if (checkout_entry(ce, &state, NULL, NULL) < 0)
    ++			return error(_("%s: cannot checkout file"), path);
    ++	}
     +
    -+	if (checkout_entry(ce, &state, NULL, NULL) < 0)
    -+		return error(_("%s: cannot checkout file"), path);
     +	return 0;
     +}
     +
    @@ merge-strategies.c (new)
     +				  const struct object_id *their_blob, const char *path,
     +				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
     +{
    -+	if ((our_blob && orig_mode != our_mode) ||
    -+	    (their_blob && orig_mode != their_mode))
    ++	if ((!our_blob && orig_mode != their_mode) ||
    ++	    (!their_blob && orig_mode != our_mode))
     +		return error(_("File %s deleted on one branch but had its "
     +			       "permissions changed on the other."), path);
     +
    @@ merge-strategies.c (new)
     +	return add_file_to_index(istate, path, 0);
     +}
     +
    -+int merge_three_way(struct repository *r,
    ++int merge_three_way(struct index_state *istate,
     +		    const struct object_id *orig_blob,
     +		    const struct object_id *our_blob,
     +		    const struct object_id *their_blob, const char *path,
     +		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
     +{
     +	if (orig_blob &&
    -+	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
    ++	    ((!our_blob && !their_blob) ||
    ++	     (!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
     +	     (!our_blob && their_blob && oideq(orig_blob, their_blob)))) {
     +		/* Deleted in both or deleted in one and unchanged in the other. */
    -+		return merge_one_file_deleted(r->index, our_blob, their_blob, path,
    ++		return merge_one_file_deleted(istate, our_blob, their_blob, path,
     +					      orig_mode, our_mode, their_mode);
     +	} else if (!orig_blob && our_blob && !their_blob) {
     +		/*
    -+		 * Added in one.  The other side did not add and we
    ++		 * Added in ours.  The other side did not add and we
     +		 * added so there is nothing to be done, except making
     +		 * the path merged.
     +		 */
    -+		return add_to_index_cacheinfo(r->index, our_mode, our_blob,
    -+					      path, 0, 1, 1, NULL);
    ++		return add_merge_result_to_index(istate, our_mode, our_blob, path, 0);
     +	} else if (!orig_blob && !our_blob && their_blob) {
    -+		struct cache_entry *ce;
     +		printf(_("Adding %s\n"), path);
     +
     +		if (file_exists(path))
     +			return error(_("untracked %s is overwritten by the merge."), path);
     +
    -+		if (add_to_index_cacheinfo(r->index, their_mode, their_blob,
    -+					   path, 0, 1, 1, &ce))
    -+			return -1;
    -+		return checkout_from_index(r->index, path, ce);
    ++		return add_merge_result_to_index(istate, their_mode, their_blob, path, 1);
     +	} else if (!orig_blob && our_blob && their_blob &&
     +		   oideq(our_blob, their_blob)) {
    -+		struct cache_entry *ce;
    -+
     +		/* Added in both, identically (check for same permissions). */
     +		if (our_mode != their_mode)
     +			return error(_("File %s added identically in both branches, "
    @@ merge-strategies.c (new)
     +
     +		printf(_("Adding %s\n"), path);
     +
    -+		if (add_to_index_cacheinfo(r->index, our_mode, our_blob,
    -+					   path, 0, 1, 1, &ce))
    -+			return -1;
    -+		return checkout_from_index(r->index, path, ce);
    ++		return add_merge_result_to_index(istate, our_mode, our_blob, path, 1);
     +	} else if (our_blob && their_blob) {
     +		/* Modified in both, but differently. */
    -+		return do_merge_one_file(r->index,
    ++		return do_merge_one_file(istate,
     +					 orig_blob, our_blob, their_blob, path,
     +					 orig_mode, our_mode, their_mode);
     +	} else {
    @@ merge-strategies.c (new)
     +
     +	return 0;
     +}
    ++
    ++int merge_one_file_func(struct index_state *istate,
    ++			const struct object_id *orig_blob,
    ++			const struct object_id *our_blob,
    ++			const struct object_id *their_blob, const char *path,
    ++			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    ++			void *data)
    ++{
    ++	return merge_three_way(istate,
    ++			       orig_blob, our_blob, their_blob, path,
    ++			       orig_mode, our_mode, their_mode);
    ++}
    + 
    + static int merge_entry(struct index_state *istate, int quiet, unsigned int pos,
    + 		       const char *path, int *err, merge_fn fn, void *data)
    +@@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    + 		    merge_fn fn, void *data)
    + {
    + 	int err = 0, ret;
    +-	unsigned int i;
    ++	unsigned int i, prev_nr;
    + 
    + 	for (i = 0; i < istate->cache_nr; i++) {
    + 		const struct cache_entry *ce = istate->cache[i];
    + 		if (!ce_stage(ce))
    + 			continue;
    + 
    ++		prev_nr = istate->cache_nr;
    + 		ret = merge_entry(istate, quiet || oneshot, i, ce->name, &err, fn, data);
    +-		if (ret > 0)
    +-			i += ret - 1;
    +-		else if (ret == -1)
    ++		if (ret > 0) {
    ++			/*
    ++			 * Don't bother handling an index that has
    ++			 * grown, since merge_one_file_func() can't grow
    ++			 * it, and merge_one_file_spawn() can't change
    ++			 * it.
    ++			 */
    ++			i += ret - (prev_nr - istate->cache_nr) - 1;
    ++		} else if (ret == -1)
    + 			return -1;
    + 
    + 		if (err && !oneshot)
     
    - ## merge-strategies.h (new) ##
    + ## merge-strategies.h ##
     @@
    -+#ifndef MERGE_STRATEGIES_H
    -+#define MERGE_STRATEGIES_H
    -+
    -+#include "object.h"
    -+
    -+int merge_three_way(struct repository *r,
    + 
    + #include "object.h"
    + 
    ++int merge_three_way(struct index_state *istate,
     +		    const struct object_id *orig_blob,
     +		    const struct object_id *our_blob,
     +		    const struct object_id *their_blob, const char *path,
     +		    unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode);
     +
    -+#endif /* MERGE_STRATEGIES_H */
    + typedef int (*merge_fn)(struct index_state *istate,
    + 			const struct object_id *orig_blob,
    + 			const struct object_id *our_blob,
    +@@ merge-strategies.h: typedef int (*merge_fn)(struct index_state *istate,
    + 			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    + 			void *data);
    + 
    ++int merge_one_file_func(struct index_state *istate,
    ++			const struct object_id *orig_blob,
    ++			const struct object_id *our_blob,
    ++			const struct object_id *their_blob, const char *path,
    ++			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    ++			void *data);
    ++
    + int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    + 		     const char *path, merge_fn fn, void *data);
    + int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    +
    + ## t/t6060-merge-index.sh ##
    +@@ t/t6060-merge-index.sh: test_expect_success 'merge-one-file fails without a work tree' '
    + 	(cd bare.git &&
    + 	 GIT_INDEX_FILE=$PWD/merge.index &&
    + 	 export GIT_INDEX_FILE &&
    +-	 test_must_fail git merge-index git-merge-one-file -a
    ++	 test_must_fail git merge-index --use=merge-one-file -a
    + 	)
    + '
    + 
     
      ## t/t6415-merge-dir-to-symlink.sh ##
     @@ t/t6415-merge-dir-to-symlink.sh: test_expect_success SYMLINKS 'a/b was resolved as symlink' '
 5:  54abee902f <  -:  ---------- merge-index: libify merge_one_path() and merge_all()
 6:  acaf100edd <  -:  ---------- merge-index: don't fork if the requested program is `git-merge-one-file'
 7:  9a9e3faeff !  9:  3ecf49a8ac merge-resolve: rewrite in C
    @@ builtin/merge-resolve.c (new)
     + * Resolve two trees, using enhanced multi-base read-tree.
     + */
     +
    -+#define USE_THE_INDEX_COMPATIBILITY_MACROS
     +#include "cache.h"
     +#include "builtin.h"
     +#include "merge-strategies.h"
    @@ builtin/merge-resolve.c (new)
     +	const char *head = NULL;
     +	struct commit_list *bases = NULL, *remote = NULL;
     +	struct commit_list **next_base = &bases;
    ++	struct repository *r = the_repository;
     +
     +	if (argc < 5)
     +		usage(builtin_merge_resolve_usage);
     +
     +	setup_work_tree();
    -+	if (read_cache() < 0)
    ++	if (repo_read_index(r) < 0)
     +		die("invalid index");
     +
     +	/*
    @@ builtin/merge-resolve.c (new)
     +			if (get_oid(argv[i], &oid))
     +				die("object %s not found.", argv[i]);
     +
    -+			commit = lookup_commit_or_die(&oid, argv[i]);
    ++			commit = oideq(&oid, r->hash_algo->empty_tree) ?
    ++				NULL : lookup_commit_or_die(&oid, argv[i]);
     +
     +			if (sep_seen)
     +				commit_list_insert(commit, &remote);
    @@ builtin/merge-resolve.c (new)
     +	if (!bases)
     +		return 2;
     +
    -+	return merge_strategies_resolve(the_repository, bases, head, remote);
    ++	return merge_strategies_resolve(r, bases, head, remote);
     +}
     
      ## git-merge-resolve.sh (deleted) ##
    @@ git-merge-resolve.sh (deleted)
     -	exit 0
     -else
     -	echo "Simple merge failed, trying Automatic merge."
    --	if git merge-index -o git-merge-one-file -a
    +-	if git merge-index -o --use=merge-one-file -a
     -	then
     -		exit 0
     -	else
    @@ merge-strategies.c
      #include "dir.h"
     +#include "lockfile.h"
      #include "merge-strategies.h"
    - #include "run-command.h"
     +#include "unpack-trees.h"
      #include "xdiff-interface.h"
      
    - static int checkout_from_index(struct index_state *istate, const char *path,
    -@@ merge-strategies.c: int merge_all_index(struct repository *r, int oneshot, int quiet,
    + static int add_merge_result_to_index(struct index_state *istate, unsigned int mode,
    +@@ merge-strategies.c: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
      
      	return err;
      }
    @@ merge-strategies.c: int merge_all_index(struct repository *r, int oneshot, int q
     +
     +		puts(_("Simple merge failed, trying Automatic merge."));
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+		ret = merge_all_index(r, 1, 0, merge_one_file_func, NULL);
    ++		ret = merge_all_index(r->index, 1, 0, merge_one_file_func, NULL);
     +
     +		write_locked_index(r->index, &lock, COMMIT_LOCK);
     +		return !!ret;
    @@ merge-strategies.h
     +#include "commit.h"
      #include "object.h"
      
    - int merge_three_way(struct repository *r,
    -@@ merge-strategies.h: int merge_index_path(struct repository *r, int oneshot, int quiet,
    - int merge_all_index(struct repository *r, int oneshot, int quiet,
    + int merge_three_way(struct index_state *istate,
    +@@ merge-strategies.h: int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    + int merge_all_index(struct index_state *istate, int oneshot, int quiet,
      		    merge_fn fn, void *data);
      
     +int merge_strategies_resolve(struct repository *r,
 8:  359346229c = 10:  615b04d417 merge-recursive: move better_branch_name() to merge.c
 9:  4dff780212 ! 11:  a6ece04f3d merge-octopus: rewrite in C
    @@ builtin/merge-octopus.c (new)
     + * Resolve two or more trees.
     + */
     +
    -+#define USE_THE_INDEX_COMPATIBILITY_MACROS
     +#include "cache.h"
     +#include "builtin.h"
     +#include "commit.h"
    @@ builtin/merge-octopus.c (new)
     +	struct commit_list *bases = NULL, *remotes = NULL;
     +	struct commit_list **next_base = &bases, **next_remote = &remotes;
     +	const char *head_arg = NULL;
    ++	struct repository *r = the_repository;
     +
     +	if (argc < 5)
     +		usage(builtin_merge_octopus_usage);
     +
     +	setup_work_tree();
    -+	if (read_cache() < 0)
    ++	if (repo_read_index(r) < 0)
     +		die("invalid index");
     +
     +	/*
    @@ builtin/merge-octopus.c (new)
     +			if (get_oid(argv[i], &oid))
     +				die("object %s not found.", argv[i]);
     +
    -+			commit = lookup_commit_or_die(&oid, argv[i]);
    ++			commit = oideq(&oid, r->hash_algo->empty_tree) ?
    ++				NULL : lookup_commit_or_die(&oid, argv[i]);
     +
     +			if (sep_seen)
     +				next_remote = commit_list_append(commit, next_remote);
    @@ builtin/merge-octopus.c (new)
     +	if (commit_list_count(remotes) < 2)
     +		return 2;
     +
    -+	return merge_strategies_octopus(the_repository, bases, head_arg, remotes);
    ++	return merge_strategies_octopus(r, bases, head_arg, remotes);
     +}
     
      ## git-merge-octopus.sh (deleted) ##
    @@ git-merge-octopus.sh (deleted)
     -	if test $? -ne 0
     -	then
     -		gettextln "Simple merge did not work, trying automatic merge."
    --		git merge-index -o git-merge-one-file -a ||
    +-		git merge-index -o --use=merge-one-file -a ||
     -		OCTOPUS_FAILURE=1
     -		next=$(git write-tree 2>/dev/null)
     -	fi
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +			    struct tree **reference_tree)
     +{
     +	struct tree_desc t[MAX_UNPACK_TREES];
    -+	struct commit_list *j;
    ++	struct commit_list *i;
     +	int nr = 0, ret = 0;
     +
     +	printf(_("Trying simple merge with %s\n"), branch_name);
     +
    -+	for (j = common; j; j = j->next) {
    -+		struct tree *tree = repo_get_commit_tree(r, j->item);
    ++	for (i = common; i; i = i->next) {
    ++		struct tree *tree = repo_get_commit_tree(r, i->item);
     +		if (add_tree(tree, t + (nr++)))
     +			return -1;
     +	}
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +	if (add_tree(current_tree, t + (nr++)))
     +		return -1;
     +	if (fast_forward(r, t, nr, 1))
    -+		return -1;
    ++		return 2;
     +
     +	if (write_tree(r, reference_tree)) {
     +		struct lock_file lock = LOCK_INIT;
     +
     +		puts(_("Simple merge did not work, trying automatic merge."));
     +		repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
    -+		ret = merge_all_index(r, 1, 0, merge_one_file_func, NULL);
    ++		ret = !!merge_all_index(r->index, 0, 0, merge_one_file_func, NULL);
     +		write_locked_index(r->index, &lock, COMMIT_LOCK);
     +
     +		write_tree(r, reference_tree);
     +	}
     +
    -+	return ret ? -2 : 0;
    ++	return ret;
     +}
     +
     +int merge_strategies_octopus(struct repository *r,
     +			     struct commit_list *bases, const char *head_arg,
     +			     struct commit_list *remotes)
     +{
    -+	int ff_merge = 1, ret = 0, references = 1;
    -+	struct commit **reference_commit, *head_commit;
    ++	int ff_merge = 1, ret = 0, nr_references = 1;
    ++	struct commit **reference_commits, *head_commit;
     +	struct tree *reference_tree, *head_tree;
     +	struct commit_list *i;
     +	struct object_id head;
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		return 2;
     +	}
     +
    -+	reference_commit = xcalloc(commit_list_count(remotes) + 1,
    -+				   sizeof(struct commit *));
    -+	reference_commit[0] = head_commit;
    ++	CALLOC_ARRAY(reference_commits, commit_list_count(remotes) + 1);
    ++	reference_commits[0] = head_commit;
     +	reference_tree = head_tree;
     +
     +	for (i = remotes; i && i->item; i = i->next) {
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		struct object_id *oid = &c->object.oid;
     +		struct tree *current_tree = repo_get_commit_tree(r, c);
     +		struct commit_list *common, *j;
    -+		char *branch_name;
    -+		int k = 0, up_to_date = 0;
    -+
    -+		if (ret) {
    -+			/*
    -+			 * We allow only last one to have a
    -+			 * hand-resolvable conflicts.  Last round failed
    -+			 * and we still had a head to merge.
    -+			 */
    -+			puts(_("Automated merge did not work."));
    -+			puts(_("Should not be doing an octopus."));
    -+
    -+			free(reference_commit);
    -+			return 2;
    -+		}
    -+
    -+		branch_name = merge_get_better_branch_name(oid_to_hex(oid));
    -+		common = get_merge_bases_many(c, references, reference_commit);
    ++		char *branch_name = merge_get_better_branch_name(oid_to_hex(oid));
    ++		int up_to_date = 0;
     +
    ++		common = repo_get_merge_bases_many(r, c, nr_references, reference_commits);
     +		if (!common) {
     +			error(_("Unable to find common commit with %s"), branch_name);
     +
     +			free(branch_name);
     +			free_commit_list(common);
    -+			free(reference_commit);
    ++			free(reference_commits);
     +
     +			return 2;
     +		}
     +
    -+		for (j = common; j && !(up_to_date || !ff_merge); j = j->next) {
    ++		for (j = common; j && !up_to_date && ff_merge; j = j->next) {
     +			up_to_date |= oideq(&j->item->object.oid, oid);
     +
    -+			if (k < references)
    -+				ff_merge &= oideq(&j->item->object.oid, &reference_commit[k++]->object.oid);
    ++			if (!j->next &&
    ++			    !oideq(&j->item->object.oid,
    ++				   &reference_commits[nr_references - 1]->object.oid))
    ++				ff_merge = 0;
     +		}
     +
     +		if (up_to_date) {
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		if (ff_merge) {
     +			ret = octopus_fast_forward(r, branch_name, head_tree,
     +						   current_tree, &reference_tree);
    -+			references = 0;
    ++			nr_references = 0;
     +		} else {
     +			ret = octopus_do_merge(r, branch_name, common,
     +					       current_tree, &reference_tree);
    @@ merge-strategies.c: int merge_strategies_resolve(struct repository *r,
     +		free(branch_name);
     +		free_commit_list(common);
     +
    -+		if (ret == -1)
    ++		if (ret == -1 || ret == 2)
     +			break;
    ++		else if (ret && i->next) {
    ++			/*
    ++			 * We allow only last one to have a
    ++			 * hand-resolvable conflicts.  Last round failed
    ++			 * and we still had a head to merge.
    ++			 */
    ++			puts(_("Automated merge did not work."));
    ++			puts(_("Should not be doing an octopus."));
     +
    -+		reference_commit[references++] = c;
    ++			free(reference_commits);
    ++			return 2;
    ++		}
    ++
    ++		reference_commits[nr_references++] = c;
     +	}
     +
    -+	free(reference_commit);
    ++	free(reference_commits);
     +	return ret;
     +}
     
      ## merge-strategies.h ##
    -@@ merge-strategies.h: int merge_all_index(struct repository *r, int oneshot, int quiet,
    +@@ merge-strategies.h: int merge_all_index(struct index_state *istate, int oneshot, int quiet,
      int merge_strategies_resolve(struct repository *r,
      			     struct commit_list *bases, const char *head_arg,
      			     struct commit_list *remote);
10:  76f02b4531 = 12:  cc1500147b merge: use the "resolve" strategy without forking
11:  c9e0a38d0f = 13:  ec3dc3b81e merge: use the "octopus" strategy without forking
12:  5b595efa46 = 14:  e7dc4a15d4 sequencer: use the "resolve" strategy without forking
13:  7eb0f13442 = 15:  34280dd82d sequencer: use the "octopus" merge strategy without forking
-- 
2.31.0

