Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81AEC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbiHSE2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiHSE2S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:28:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555CF64
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so3841351wrq.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=dkVOoLRVbULeqpGuUxyYCeScj/cWpy/9RXHO1x+spIo=;
        b=IUUnbufm6WDyrJ2Y887h7BCCriML6ywNiEkeX/kiDFUMQXu0B+89wxscFvmpo5UTnA
         HLcPOcJjRzVeLRJO3tITO8njGg38bcyH5asXSj+GejOjqXXc+4YORw4srF1GpSKQiesk
         Wmp/lvOTUsJbwAJvOPKZkZV4mi2UMK+jouGoYd4rNHhWuYFRJnkuDmfEJMOqU0KWYNuX
         lyVW8S7Z2Qcnh5HPLzQVTXV4lIdryIXrsZjhpEfYR8/MLc+hQSNNFSirBPAR7hq53gmD
         qJYGHNr8z6jXH3s2Rhq/FMuh2dhwMFc3zFDp+weROHfZ9VnjI54/Xf42zqt3fSC9FpJR
         v/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=dkVOoLRVbULeqpGuUxyYCeScj/cWpy/9RXHO1x+spIo=;
        b=KAUBUwaRruNy34a0C4WyJ3dm+zsT3EcE8rkj3JSGKVyNxQqpETqDpSaADlkuL6CT17
         n3RlPxzVSX2P/f3sWRiRM8OnD0AUAzfuUHsbYK08QUx5ZdJIsqqwN7TNnc4f9dZu/1Na
         NXxRm1yGJxpmy+rkvRAAcjW0TS/d7Sgc605dFCUOSLw/WN2YNTCyEp1iu4vAF38lbtAK
         4MUHypRQ9QTnwRQW7LIVfeIsV22aePYUd8iol1TcFRQ5rIGoMunRKqeAzsStcr8I6A2Z
         PTY6guTbDzi1XT0vU9X1cQMod7QBQ8POf/OhJSM58WFhT6Y6EUho9gl5EdFhGsLGkHun
         I4Tw==
X-Gm-Message-State: ACgBeo2t5FjDZQqi2dFy5NHYM+6PIjlj7IMWlsTttbAOD0DDrilHgYXR
        Cp4nTdjisUHYqR+chR9rEaYyl6fmcKk=
X-Google-Smtp-Source: AA6agR4xhd9xXKLQXx4OVW0Pz3FKFp1fmGslGkbrDVkRk1E1RGtvd+zN0EJz9HUDF/GjQx8nHPVwcw==
X-Received: by 2002:a5d:47a5:0:b0:220:5985:6710 with SMTP id 5-20020a5d47a5000000b0022059856710mr3184756wrb.633.1660883292485;
        Thu, 18 Aug 2022 21:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm4696781wms.17.2022.08.18.21.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 21:28:11 -0700 (PDT)
Message-Id: <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 04:28:07 +0000
Subject: [PATCH v3 0/3] Allow --ancestry-path to take an argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Incorporated Stolee's suggested patch as a preliminary cleanup of t6019.
   Slightly modified his patch by:
   * fixing the "repetitive" typo pointed out by Eric
   * removed the unnecessary "return 1" pointed out by Ævar
   * switched "rev-list" to "log" since we are using --format anyway, in
     order to remove the need to call "sed" afterward
 * lots of wording improvements suggested by Jonathan
 * fixed an issue with argument parsing pointed out by Jonathan

Changes since v1:

 * Tweaked the commit message, and incorporated Junio's suggestion to update
   left_flag and ancestry_flag together.

Series description:

This came out of a previous thread[1], where I wanted to be able to run
something like

git log --oneline --ancestry-path=ab/submodule-cleanup main..seen


and see the commits in main..seen which contained ab/submodule-cleanup in
their ancestry path. Let me start by defining the terminology "X is in a
commit's ancestry path". By that, I just mean that either the commit is X,
the commit is an ancestor of X, or the commit is a descendant of X. With
that definition...

The command

git log --ancestry-path A..B


means find the commits in A..B which contain A in their ancestry path. I
sometimes still want to use A..B to get the basic range, but would like to
use a commit other than A for specifying which ancestry path is of interest.
So, for example, I might want to use

git log --ancestry-path=C A..B


to mean find the commits in A..B which contain C in their ancestry path, or
use

git log --ancestry-path=C --ancestry-path=D A..B


to mean find the commits in A..B which contain either C or D in their
ancestry path.

This series implements this request, by allowing --ancestry-path to take an
optional argument. With it, I can find the answer to my question in the
thread at [1] within the git.git repository (replacing branch names with
actual hashes since the branches have since moved on):

$ git log --oneline --ancestry-path=5b893f7d81 8168d5e9c2..ac0248bfba | wc -l
36


This returns the answer I want, whereas dropping the '=5b893f7d81' from the
command line gives me 192 unwanted commits (228 total), and various other
command line flags (--first-parent, --boundary, etc.) also fail to give me
the set of commits I am looking for.

[1]
https://lore.kernel.org/git/CABPp-BF+8aqysioP_e27Q9kJ02rE2SuSqXu+XphzKWnk5a_Q+A@mail.gmail.com/

Derrick Stolee (1):
  t6019: modernize tests with helper

Elijah Newren (2):
  rev-list-options.txt: fix simple typo
  revision: allow --ancestry-path to take an argument

 Documentation/rev-list-options.txt |  46 +++++++++----
 object.h                           |   2 +-
 revision.c                         |  89 ++++++++++++++++---------
 revision.h                         |   9 +++
 t/t6019-rev-list-ancestry-path.sh  | 101 +++++++++++------------------
 5 files changed, 141 insertions(+), 106 deletions(-)


base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1303%2Fnewren%2Fancestry-path-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1303/newren/ancestry-path-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1303

Range-diff vs v2:

 1:  68ab719d99c = 1:  68ab719d99c rev-list-options.txt: fix simple typo
 -:  ----------- > 2:  5226da2123e t6019: modernize tests with helper
 2:  f580ec6d060 ! 3:  b810b3c8a2a revision: allow --ancestry-path to take an argument
     @@ Commit message
              git log --ancestry-path master..seen
          which shows all commits which satisfy all three of these criteria:
            * are an ancestor of seen
     -      * are not an ancestor master
     +      * are not an ancestor of master
            * have master as an ancestor
      
          This commit allows another variant:
     @@ Documentation/rev-list-options.txt: Default mode::
      -	directly on the ancestry chain between the 'commit1' and
      -	'commit2', i.e. commits that are both descendants of 'commit1',
      -	and ancestors of 'commit2'.
     -+	or 'commit2 {caret}commit1'), only display commits in that
     -+	range where <commit> is part of the ancestry chain.  By "part of
     -+	the ancestry chain", we mean including <commit> itself and
     -+	commits that are either ancestors or descendants of <commit>.
     -+	If no commit is specified, use 'commit1' (the excluded part of
     -+	the range) as <commit>.  Can be passed multiple times to look for
     -+	commits in the ancestry range of multiple commits.
     ++	or 'commit2 {caret}commit1'), only display commits in that range
     ++	that are ancestors of <commit>, descendants of <commit>, or
     ++	<commit> itself.  If no commit is specified, use 'commit1' (the
     ++	excluded part of the range) as <commit>.  Can be passed multiple
     ++	times; if so, a commit is included if it is any of the commits
     ++	given or if it is an ancestor or descendant of one of them.
       
       A more detailed explanation follows.
       
     @@ Documentation/rev-list-options.txt: Note the major differences in `N`, `P`, and
      -	range. I.e. only display commits that are ancestor of the ``to''
      -	commit and descendants of the ``from'' commit.
      +--ancestry-path[=<commit>]::
     -+	Limit the displayed commits to those containing <commit> in their
     -+	ancestry path.  I.e. only display <commit> and commits which have
     -+	<commit> as either a direct ancestor or descendant.
     ++	Limit the displayed commits to those which are an ancestor of
     ++	<commit>, or which are a descendant of <commit>, or are <commit>
     ++	itself.
       +
       As an example use case, consider the following commit history:
       +
     @@ revision.c: static int still_interesting(struct commit_list *src, timestamp_t da
       
       /*
      - * "rev-list --ancestry-path A..B" computes commits that are ancestors
     -+ * "rev-list --ancestry-path=C A..B" computes commits that are ancestors
     -  * of B but not ancestors of A but further limits the result to those
     +- * of B but not ancestors of A but further limits the result to those
      - * that are descendants of A.  This takes the list of bottom commits and
      - * the result of "A..B" without --ancestry-path, and limits the latter
      - * further to the ones that can reach one of the commits in "bottom".
     -+ * that have C in their ancestry path (i.e. are either ancestors of C,
     -+ * descendants of C, or are C).  If multiple --ancestry-path=$COMMITTISH
     -+ * arguments are supplied, we limit the result to those that have at
     -+ * least one of those COMMITTISH in their ancestry path. If
     -+ * --ancestry-path is specified with no commit, we use all bottom
     -+ * commits for C.
     ++ * "rev-list --ancestry-path=C_0 [--ancestry-path=C_1 ...] A..B"
     ++ * computes commits that are ancestors of B but not ancestors of A but
     ++ * further limits the result to those that have any of C in their
     ++ * ancestry path (i.e. are either ancestors of any of C, descendants
     ++ * of any of C, or are any of C). If --ancestry-path is specified with
     ++ * no commit, we use all bottom commits for C.
     ++ *
     ++ * Before this function is called, ancestors of C will have already
     ++ * been marked with ANCESTRY_PATH previously.
      + *
     -+ * Before this function is called, ancestors of C will have already been
     -+ * marked with ANCESTRY_PATH previously, so we just need to also mark
     -+ * the descendants here, then collect both sets of commits.
     ++ * This takes the list of bottom commits and the result of "A..B"
     ++ * without --ancestry-path, and limits the latter further to the ones
     ++ * that have any of C in their ancestry path. Since the ancestors of C
     ++ * have already been marked (a prerequisite of this function), we just
     ++ * need to mark the descendants, then exclude any commit that does not
     ++ * have any of these marks.
        */
      -static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
      +static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)
     @@ revision.c: static int limit_list(struct rev_info *revs)
      -	if (revs->ancestry_path) {
      -		bottom = collect_bottom_commits(original_list);
      -		if (!bottom)
     -+	if (revs->ancestry_path_need_bottoms) {
     ++	if (revs->ancestry_path_implicit_bottoms) {
      +		collect_bottom_commits(original_list,
      +				       &revs->ancestry_path_bottoms);
      +		if (!revs->ancestry_path_bottoms)
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
       	const unsigned hexsz = the_hash_algo->hexsz;
       
      @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
     - 		revs->first_parent_only = 1;
     - 	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
     - 		revs->exclude_first_parent_only = 1;
     --	} else if (!strcmp(arg, "--ancestry-path")) {
     -+	} else if (!strcmp(arg, "--ancestry-path") ||
     -+		   skip_prefix(arg, "--ancestry-path=", &optarg)) {
       		revs->ancestry_path = 1;
       		revs->simplify_history = 0;
       		revs->limited = 1;
     -+		if (optarg) {
     -+			struct commit *c;
     -+			struct object_id oid;
     -+			const char *msg = _("could not get commit for ancestry-path argument %s");
     ++		revs->ancestry_path_implicit_bottoms = 1;
     ++	} else if (skip_prefix(arg, "--ancestry-path=", &optarg)) {
     ++		struct commit *c;
     ++		struct object_id oid;
     ++		const char *msg = _("could not get commit for ancestry-path argument %s");
     ++
     ++		revs->ancestry_path = 1;
     ++		revs->simplify_history = 0;
     ++		revs->limited = 1;
      +
     -+			if (repo_get_oid_committish(revs->repo, optarg, &oid))
     -+				return error(msg, optarg);
     -+			get_reference(revs, optarg, &oid, ANCESTRY_PATH);
     -+			c = lookup_commit_reference(revs->repo, &oid);
     -+			if (!c)
     -+				return error(msg, optarg);
     -+			commit_list_insert(c, &revs->ancestry_path_bottoms);
     -+		} else {
     -+			revs->ancestry_path_need_bottoms = 1;
     -+		}
     ++		if (repo_get_oid_committish(revs->repo, optarg, &oid))
     ++			return error(msg, optarg);
     ++		get_reference(revs, optarg, &oid, ANCESTRY_PATH);
     ++		c = lookup_commit_reference(revs->repo, &oid);
     ++		if (!c)
     ++			return error(msg, optarg);
     ++		commit_list_insert(c, &revs->ancestry_path_bottoms);
       	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
       		init_reflog_walk(&revs->reflog_info);
       	} else if (!strcmp(arg, "--default")) {
     @@ revision.h: struct rev_info {
       			cherry_mark:1,
       			bisect:1,
       			ancestry_path:1,
     -+			ancestry_path_need_bottoms:1,
     ++
     ++			/* True if --ancestry-path was specified without an
     ++			 * argument. The bottom revisions are implicitly
     ++			 * the arguments in this case.
     ++			 */
     ++			ancestry_path_implicit_bottoms:1,
     ++
       			first_parent_only:1,
       			exclude_first_parent_only:1,
       			line_level_traverse:1,
     @@ t/t6019-rev-list-ancestry-path.sh: test_description='--ancestry-path'
       #
       #  D..M -- M.t                 == M
       #  --ancestry-path D..M -- M.t == M
     -@@ t/t6019-rev-list-ancestry-path.sh: test_expect_success 'rev-list --ancestry-path D..M' '
     - 	test_cmp expect actual
     - '
     +@@ t/t6019-rev-list-ancestry-path.sh: test_ancestry () {
     + test_ancestry "D..M" "E F G H I J K L M"
       
     -+test_expect_success 'rev-list --ancestry-path=F D..M' '
     -+	test_write_lines E F J L M >expect &&
     -+	git rev-list --ancestry-path=F --format=%s D..M |
     -+	sed -e "/^commit /d" |
     -+	sort >actual &&
     -+	test_cmp expect actual
     -+'
     -+test_expect_success 'rev-list --ancestry-path=G D..M' '
     -+	test_write_lines G H I J L M >expect &&
     -+	git rev-list --ancestry-path=G --format=%s D..M |
     -+	sed -e "/^commit /d" |
     -+	sort >actual &&
     -+	test_cmp expect actual
     -+'
     -+test_expect_success 'rev-list --ancestry-path=H D..M' '
     -+	test_write_lines E G H I J L M >expect &&
     -+	git rev-list --ancestry-path=H --format=%s D..M |
     -+	sed -e "/^commit /d" |
     -+	sort >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'rev-list --ancestry-path=K D..M' '
     -+	test_write_lines K L M >expect &&
     -+	git rev-list --ancestry-path=K --format=%s D..M |
     -+	sed -e "/^commit /d" |
     -+	sort >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'rev-list --ancestry-path=F --ancestry-path=K D..M' '
     -+	test_write_lines E F J K L M >expect &&
     -+	git rev-list --ancestry-path=F --ancestry-path=K --format=%s D..M |
     -+	sed -e "/^commit /d" |
     -+	sort >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     - test_expect_success 'rev-list D..M -- M.t' '
     - 	echo M >expect &&
     - 	git rev-list --format=%s D..M -- M.t |
     + test_ancestry "--ancestry-path D..M" "E F H I J L M"
     ++test_ancestry "--ancestry-path=F D..M" "E F J L M"
     ++test_ancestry "--ancestry-path=G D..M" "G H I J L M"
     ++test_ancestry "--ancestry-path=H D..M" "E G H I J L M"
     ++test_ancestry "--ancestry-path=K D..M" "K L M"
     ++test_ancestry "--ancestry-path=F --ancestry-path=K D..M" "E F J K L M"
     + 
     + test_ancestry "D..M -- M.t" "M"
     + test_ancestry "--ancestry-path D..M -- M.t" "M"

-- 
gitgitgadget
