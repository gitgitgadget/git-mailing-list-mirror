Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DC0C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjC2Q0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2QZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 12:25:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2F91
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 09:25:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so6536775wmq.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680107155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9FiOccQYLFhJ3+n2GF4/rCO3soPUnWYK7oWTOOah/s=;
        b=O0KLtfdugWlqqe2Y4rQwPJSdBdtpgUCKLyqcURzNmiyeZX0JODmCeI92GYmZfSqvdz
         ZTkAvc59VOvqrJ/t1el5WaSb87f8127mQoWpvcHKv656by/iPedY45mFWm2P1q481AqF
         lafV9KymM0S8fQmVkCrv8GdLZmeitjLOahu7WTlMvOnDnisbB8yL/o0C8oCJlHq0XBHn
         WCnqDqpaLBjTKZ8Ec692lv8T/0OYCLxCtg8mzYNNGaNjDiEFXqjv5dtp7Y8eF7WZTX/K
         IaBupBwcyFWLY3UD6hWaktibuVTRCwCb2v2JMuzD+syK5gLLfMj+l6hUbQDTmSPgY0hF
         vOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9FiOccQYLFhJ3+n2GF4/rCO3soPUnWYK7oWTOOah/s=;
        b=iCaDo0R94os7ykURk3BgTzLntqm2HHdchDvOo80ydmZqun6+vU+Szlz7BpgTcVcy3D
         6haMskFO7dnAy4FSrLhCh5PNrOsukPKgtT6wUb6zOQEdKGSJmK9X05CtFhXera1Ey2Vz
         4AitreqrVe5Pac0+WXflV46S8qk39z+t7B0BEdJeaq4cTeH7oFfNOdID9tJHmhMFJFJm
         8pB8hahKySAcNK6haLLHbn+o+GuiuAU/sod5AONHDaqe44hfpq0tMv4OcnkfynMin8/s
         CLMxWdqobl4NJ6xcL5k6uEwg3nZQpx9kK9p4Pr6GtiOX28ach+zM2D8l/BP1eoT+3/Of
         8PRg==
X-Gm-Message-State: AO0yUKW6edaT40tYXrvn4VmIo4CyUh1icEF34aKgW4M2/Clt2y47YlQ9
        LSVISCzZhRllSUnzRsQgnqDBMvAKBV0=
X-Google-Smtp-Source: AK7set8YVq5k7+85VoibRPhxkIoee23AeIRpu23BKcRy4zQeL0N2ONt8n5mLbKlKwKAsshHRbNzLTw==
X-Received: by 2002:a1c:4c10:0:b0:3ed:e4ac:d532 with SMTP id z16-20020a1c4c10000000b003ede4acd532mr16264645wmf.36.1680107154926;
        Wed, 29 Mar 2023 09:25:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a1ccc05000000b003ee0d191539sm2798493wmb.10.2023.03.29.09.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:25:54 -0700 (PDT)
Message-Id: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
In-Reply-To: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
From:   "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Mar 2023 16:25:53 +0000
Subject: [PATCH v2] describe: enable sparse index for describe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Raghul Nanth A <nanth.raghul@gmail.com>

Add usage and performance tests for describe

Performance metrics

  Test                                                     HEAD~1            HEAD
  -------------------------------------------------------------------------------------------------
  2000.2: git describe --dirty (full-v3)                   0.08(0.09+0.01)   0.08(0.06+0.03) +0.0%
  2000.3: git describe --dirty (full-v4)                   0.09(0.07+0.03)   0.08(0.05+0.04) -11.1%
  2000.4: git describe --dirty (sparse-v3)                 0.88(0.82+0.06)   0.02(0.01+0.05) -97.7%
  2000.5: git describe --dirty (sparse-v4)                 0.68(0.60+0.08)   0.02(0.02+0.04) -97.1%
  2000.6: echo >>new && git describe --dirty (full-v3)     0.08(0.04+0.05)   0.08(0.05+0.04) +0.0%
  2000.7: echo >>new && git describe --dirty (full-v4)     0.08(0.07+0.03)   0.08(0.05+0.04) +0.0%
  2000.8: echo >>new && git describe --dirty (sparse-v3)   0.75(0.69+0.07)   0.02(0.03+0.03) -97.3%
  2000.9: echo >>new && git describe --dirty (sparse-v4)   0.81(0.73+0.09)   0.02(0.01+0.05) -97.5%

Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
---
    describe: enable sparse index for describe
    
     * Removed describe tests not concerned with sparse index
    
     * Added performance metric to commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1480%2FNanthR%2Fdescribe-sparse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1480/NanthR/describe-sparse-v2
Pull-Request: https://github.com/git/git/pull/1480

Range-diff vs v1:

 1:  4689f6512db ! 1:  03176f64607 describe: enable sparse index for describe
     @@ Commit message
      
          Add usage and performance tests for describe
      
     +    Performance metrics
     +
     +      Test                                                     HEAD~1            HEAD
     +      -------------------------------------------------------------------------------------------------
     +      2000.2: git describe --dirty (full-v3)                   0.08(0.09+0.01)   0.08(0.06+0.03) +0.0%
     +      2000.3: git describe --dirty (full-v4)                   0.09(0.07+0.03)   0.08(0.05+0.04) -11.1%
     +      2000.4: git describe --dirty (sparse-v3)                 0.88(0.82+0.06)   0.02(0.01+0.05) -97.7%
     +      2000.5: git describe --dirty (sparse-v4)                 0.68(0.60+0.08)   0.02(0.02+0.04) -97.1%
     +      2000.6: echo >>new && git describe --dirty (full-v3)     0.08(0.04+0.05)   0.08(0.05+0.04) +0.0%
     +      2000.7: echo >>new && git describe --dirty (full-v4)     0.08(0.07+0.03)   0.08(0.05+0.04) +0.0%
     +      2000.8: echo >>new && git describe --dirty (sparse-v3)   0.75(0.69+0.07)   0.02(0.03+0.03) -97.3%
     +      2000.9: echo >>new && git describe --dirty (sparse-v4)   0.81(0.73+0.09)   0.02(0.01+0.05) -97.5%
     +
          Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
      
       ## builtin/describe.c ##
     @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
      
       ## t/perf/p2000-sparse-operations.sh ##
      @@ t/perf/p2000-sparse-operations.sh: test_expect_success 'setup repo and indexes' '
     - 		git sparse-checkout set $SPARSE_CONE &&
     - 		git config index.version 3 &&
     - 		git update-index --index-version=3 &&
     --		git checkout HEAD~4
     -+		git checkout HEAD~4 &&
     -+		git tag -a v1.0 -m "Final"
     - 	) &&
     - 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-v4 &&
     - 	(
     -@@ t/perf/p2000-sparse-operations.sh: test_expect_success 'setup repo and indexes' '
     - 		git sparse-checkout set $SPARSE_CONE &&
     - 		git config index.version 4 &&
     - 		git update-index --index-version=4 &&
     --		git checkout HEAD~4
     -+		git checkout HEAD~4 &&
     -+		git tag -a v1.0 -m "Final"
     - 	) &&
     - 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v3 &&
     - 	(
     -@@ t/perf/p2000-sparse-operations.sh: test_expect_success 'setup repo and indexes' '
     - 		git sparse-checkout set $SPARSE_CONE &&
     - 		git config index.version 3 &&
     - 		git update-index --index-version=3 &&
     --		git checkout HEAD~4
     -+		git checkout HEAD~4 &&
     -+		git tag -a v1.0 -m "Final"
     - 	) &&
     - 	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v4 &&
     - 	(
     -@@ t/perf/p2000-sparse-operations.sh: test_expect_success 'setup repo and indexes' '
     - 		git sparse-checkout set $SPARSE_CONE &&
     - 		git config index.version 4 &&
     - 		git update-index --index-version=4 &&
     --		git checkout HEAD~4
     -+		git checkout HEAD~4 &&
     -+		git tag -a v1.0 -m "Final"
     - 	)
     - '
     + 	done &&
     + 
     + 	git sparse-checkout init --cone &&
     ++	git tag -a v1.0 -m "Final" &&
     + 	git sparse-checkout set $SPARSE_CONE &&
     + 	git checkout -b wide $OLD_COMMIT &&
       
      @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all
       test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
       test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
       test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
      +test_perf_on_all git describe --dirty
     -+test_perf_on_all 'echo >> new && git describe --dirty'
     ++test_perf_on_all 'echo >>new && git describe --dirty'
       
       test_done
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
       
      +test_expect_success 'sparse-index is not expanded: describe' '
      +	init_repos &&
     ++	# Add tag to be read by describe
      +	ensure_not_expanded tag -a v1.0 -m "Version 1" &&
      +	ensure_not_expanded describe --dirty &&
      +	ensure_not_expanded describe &&
     -+	echo "test" >> sparse-index/extra.txt &&
     ++	echo "test" >>sparse-index/extra.txt &&
      +	ensure_not_expanded describe --dirty &&
      +	ensure_not_expanded describe
      +'
     @@ t/t6121-describe-sparse.sh (new)
      +
      +test_description='git describe in sparse checked out trees'
      +
     -+#  o---o-----o----o----o-------o----x
     -+#       \   D,R   e           /
     -+#        \---o-------------o-'
     -+#         \  B            /
     -+#          `-o----o----o-'
     -+#                 A    c
     -+#
     -+# First parent of a merge commit is on the same line, second parent below.
     -+
      +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      +
     @@ t/t6121-describe-sparse.sh (new)
      +	shift
      +	describe_opts="$@"
      +	test_expect_success "describe $describe_opts" '
     -+		git ${indir:+ -C "$indir"} describe $describe_opts >raw &&
     -+		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
     ++		git ${indir:+ -C "$indir"} describe $describe_opts >actual &&
      +		echo "$expect" >expect &&
      +		test_cmp expect actual
      +	'
     @@ t/t6121-describe-sparse.sh (new)
      +
      +test_expect_success setup '
      +	test_commit initial file one &&
     -+	test_commit second file two &&
     -+	test_commit third file three &&
      +	test_commit --annotate A file A &&
     -+	test_commit c file c &&
     -+
     -+	git reset --hard second &&
     -+	test_commit --annotate B side B &&
     -+
     -+	test_tick &&
     -+	git merge -m Merged c &&
     -+	merged=$(git rev-parse HEAD) &&
     -+
     -+	git reset --hard second &&
     -+	test_commit --no-tag D another D &&
      +
      +	test_tick &&
     -+	git tag -a -m R R &&
      +
     -+	test_commit e another DD &&
     -+	test_commit --no-tag "yet another" another DDD &&
     -+
     -+	test_tick &&
     -+	git merge -m Merged $merged &&
     -+
     -+	test_commit --no-tag x file &&
      +	git sparse-checkout init --cone
      +'
      +
     -+check_describe A-8-gHASH HEAD
     -+check_describe A-7-gHASH HEAD^
     -+check_describe R-2-gHASH HEAD^^
     -+check_describe A-3-gHASH HEAD^^2
     -+check_describe B HEAD^^2^
     -+check_describe R-1-gHASH HEAD^^^
     -+
     -+check_describe c-7-gHASH --tags HEAD
     -+check_describe c-6-gHASH --tags HEAD^
     -+check_describe e-1-gHASH --tags HEAD^^
     -+check_describe c-2-gHASH --tags HEAD^^2
     -+check_describe B --tags HEAD^^2^
     -+check_describe e --tags HEAD^^^
     -+
     -+check_describe heads/main --all HEAD
     -+check_describe tags/c-6-gHASH --all HEAD^
     -+check_describe tags/e --all HEAD^^^
     -+
     -+check_describe B-0-gHASH --long HEAD^^2^
     -+check_describe A-3-gHASH --long HEAD^^2
     -+
     -+check_describe c-7-gHASH --tags
     -+check_describe e-3-gHASH --first-parent --tags
     -+
     -+test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
     -+	echo "A^0" >expect &&
     -+	git checkout A &&
     -+	test_when_finished "git checkout -" &&
     -+	git describe --contains >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+check_describe tags/A --all A^0
     -+
     -+test_expect_success 'renaming tag A to Q locally produces a warning' "
     -+	git update-ref refs/tags/Q $(git rev-parse refs/tags/A) &&
     -+	git update-ref -d refs/tags/A &&
     -+	git describe HEAD 2>err >out &&
     -+	cat >expected <<-\EOF &&
     -+	warning: tag 'Q' is externally known as 'A'
     -+	EOF
     -+	test_cmp expected err &&
     -+	grep -E '^A-8-g[0-9a-f]+$' out
     -+"
     -+
     -+test_expect_success 'misnamed annotated tag forces long output' '
     -+	description=$(git describe --no-long Q^0) &&
     -+	expr "$description" : "A-0-g[0-9a-f]*$" &&
     -+	git rev-parse --verify "$description" >actual &&
     -+	git rev-parse --verify Q^0 >expect &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'abbrev=0 will not break misplaced tag (1)' '
     -+	description=$(git describe --abbrev=0 Q^0) &&
     -+	expr "$description" : "A-0-g[0-9a-f]*$"
     -+'
     -+
     -+test_expect_success 'abbrev=0 will not break misplaced tag (2)' '
     -+	description=$(git describe --abbrev=0 c^0) &&
     -+	expr "$description" : "A-1-g[0-9a-f]*$"
     -+'
     -+
     -+test_expect_success 'rename tag Q back to A' '
     -+	git update-ref refs/tags/A $(git rev-parse refs/tags/Q) &&
     -+	git update-ref -d refs/tags/Q
     -+'
     -+
     -+test_expect_success 'pack tag refs' 'git pack-refs'
     -+check_describe A-8-gHASH HEAD
     -+
     -+test_expect_success 'describe works from outside repo using --git-dir' '
     -+	git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
     -+	git --git-dir "$TRASH_DIRECTORY/bare" describe >out &&
     -+	grep -E "^A-8-g[0-9a-f]+$" out
     -+'
     -+
     -+check_describe "A-8-gHASH" --dirty
     ++check_describe A HEAD
      +
      +test_expect_success 'describe --dirty with --work-tree' '
      +	(
      +		cd "$TEST_DIRECTORY" &&
      +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
      +	) &&
     -+	grep -E "^A-8-g[0-9a-f]+$" out
     ++	grep "A" out
      +'
      +
      +test_expect_success 'set-up dirty work tree' '
     @@ t/t6121-describe-sparse.sh (new)
      +		cd "$TEST_DIRECTORY" &&
      +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
      +	) &&
     -+	grep -E "^A-8-g[0-9a-f]+-dirty$" out &&
     -+	test_cmp expected out
     -+'
     -+
     -+test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
     -+	git describe --dirty=.mod >expected &&
     -+	(
     -+		cd "$TEST_DIRECTORY" &&
     -+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
     -+	) &&
     -+	grep -E "^A-8-g[0-9a-f]+.mod$" out &&
      +	test_cmp expected out
      +'
     -+
     -+test_expect_success 'describe --dirty HEAD' '
     -+	test_must_fail git describe --dirty HEAD
     -+'
     -+
     -+test_expect_success 'set-up matching pattern tests' '
     -+	git tag -a -m test-annotated test-annotated &&
     -+	echo >>file &&
     -+	test_tick &&
     -+	git commit -a -m "one more" &&
     -+	git tag test1-lightweight &&
     -+	echo >>file &&
     -+	test_tick &&
     -+	git commit -a -m "yet another" &&
     -+	git tag test2-lightweight &&
     -+	echo >>file &&
     -+	test_tick &&
     -+	git commit -a -m "even more"
     -+
     -+'
     -+
     -+check_describe "test-annotated-3-gHASH" --match="test-*"
     -+
     -+check_describe "test1-lightweight-2-gHASH" --tags --match="test1-*"
     -+
     -+check_describe "test2-lightweight-1-gHASH" --tags --match="test2-*"
     -+
     -+check_describe "test2-lightweight-0-gHASH" --long --tags --match="test2-*" HEAD^
     -+
     -+check_describe "test2-lightweight-0-gHASH" --long --tags --match="test1-*" --match="test2-*" HEAD^
     -+
     -+check_describe "test2-lightweight-0-gHASH" --long --tags --match="test1-*" --no-match --match="test2-*" HEAD^
     -+
     -+check_describe "test1-lightweight-2-gHASH" --long --tags --match="test1-*" --match="test3-*" HEAD
     -+
     -+check_describe "test1-lightweight-2-gHASH" --long --tags --match="test3-*" --match="test1-*" HEAD
     -+
     -+test_expect_success 'set-up branches' '
     -+	git branch branch_A A &&
     -+	git branch branch_C c &&
     -+	git update-ref refs/remotes/origin/remote_branch_A "A^{commit}" &&
     -+	git update-ref refs/remotes/origin/remote_branch_C "c^{commit}" &&
     -+	git update-ref refs/original/original_branch_A test-annotated~2
     -+'
     -+
     -+check_describe "heads/branch_A-11-gHASH" --all --match="branch_*" --exclude="branch_C" HEAD
     -+
     -+check_describe "remotes/origin/remote_branch_A-11-gHASH" --all --match="origin/remote_branch_*" --exclude="origin/remote_branch_C" HEAD
     -+
     -+check_describe "original/original_branch_A-6-gHASH" --all test-annotated~1
     -+
     -+test_expect_success '--match does not work for other types' '
     -+	test_must_fail git describe --all --match="*original_branch_*" test-annotated~1
     -+'
     -+
     -+test_expect_success '--exclude does not work for other types' '
     -+	R=$(git describe --all --exclude="any_pattern_even_not_matching" test-annotated~1) &&
     -+	case "$R" in
     -+	*original_branch_A*) echo "fail: Found unknown reference $R with --exclude"
     -+		false;;
     -+	*) echo ok: Found some known type;;
     -+	esac
     -+'
     -+
     -+test_expect_success 'name-rev with exact tags' '
     -+	echo A >expect &&
     -+	tag_object=$(git rev-parse refs/tags/A) &&
     -+	git name-rev --tags --name-only $tag_object >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	echo "A^0" >expect &&
     -+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
     -+	git name-rev --tags --name-only $tagged_commit >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'name-rev --all' '
     -+	>expect.unsorted &&
     -+	for rev in $(git rev-list --all)
     -+	do
     -+		git name-rev $rev >>expect.unsorted || return 1
     -+	done &&
     -+	sort <expect.unsorted >expect &&
     -+	git name-rev --all >actual.unsorted &&
     -+	sort <actual.unsorted >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'name-rev --annotate-stdin' '
     -+	>expect.unsorted &&
     -+	for rev in $(git rev-list --all)
     -+	do
     -+		name=$(git name-rev --name-only $rev) &&
     -+		echo "$rev ($name)" >>expect.unsorted || return 1
     -+	done &&
     -+	sort <expect.unsorted >expect &&
     -+	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &&
     -+	sort <actual.unsorted >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'name-rev --stdin deprecated' "
     -+	git rev-list --all | git name-rev --stdin 2>actual &&
     -+	grep -E 'warning: --stdin is deprecated' actual
     -+"
     -+
     -+test_expect_success 'describe --contains with the exact tags' '
     -+	echo "A^0" >expect &&
     -+	tag_object=$(git rev-parse refs/tags/A) &&
     -+	git describe --contains $tag_object >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	echo "A^0" >expect &&
     -+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
     -+	git describe --contains $tagged_commit >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'describe --contains and --match' '
     -+	echo "A^0" >expect &&
     -+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
     -+	test_must_fail git describe --contains --match="B" $tagged_commit &&
     -+	git describe --contains --match="B" --match="A" $tagged_commit >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'describe --exclude' '
     -+	echo "c~1" >expect &&
     -+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
     -+	test_must_fail git describe --contains --match="B" $tagged_commit &&
     -+	git describe --contains --match="?" --exclude="A" $tagged_commit >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'describe --contains and --no-match' '
     -+	echo "A^0" >expect &&
     -+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
     -+	git describe --contains --match="B" --no-match $tagged_commit >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'setup and absorb a submodule' '
     -+	git init sub1 &&
     -+	test_commit -C sub1 initial &&
     -+	git sparse-checkout add sub1 &&
     -+	git submodule add ./sub1 &&
     -+	git submodule absorbgitdirs &&
     -+	git commit -a -m "add submodule" &&
     -+	git describe --dirty >expect &&
     -+	git describe --broken >out &&
     -+	test_cmp expect out
     -+'
     -+
     -+test_expect_success 'describe chokes on severely broken submodules' '
     -+	mv .git/modules/sub1/ .git/modules/sub_moved &&
     -+	test_must_fail git describe --dirty
     -+'
     -+
     -+test_expect_success 'describe ignoring a broken submodule' '
     -+	git describe --broken >out &&
     -+	grep broken out
     -+'
     -+
     -+test_expect_success 'describe with --work-tree ignoring a broken submodule' '
     -+	(
     -+		cd "$TEST_DIRECTORY" &&
     -+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --broken >"$TRASH_DIRECTORY/out"
     -+	) &&
     -+	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
     -+	grep broken out
     -+'
     -+
     -+test_expect_success 'describe a blob at a directly tagged commit' '
     -+	echo "make it a unique blob" >file &&
     -+	git add file && git commit -m "content in file" &&
     -+	git tag -a -m "latest annotated tag" unique-file &&
     -+	git describe HEAD:file >actual &&
     -+	echo "unique-file:file" >expect &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'describe a blob with its first introduction' '
     -+	git commit --allow-empty -m "empty commit" &&
     -+	git rm file &&
     -+	git commit -m "delete blob" &&
     -+	git revert HEAD &&
     -+	git commit --allow-empty -m "empty commit" &&
     -+	git describe HEAD:file >actual &&
     -+	echo "unique-file:file" >expect &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'describe directly tagged blob' '
     -+	git tag test-blob unique-file:file &&
     -+	git describe test-blob >actual &&
     -+	echo "unique-file:file" >expect &&
     -+	# suboptimal: we rather want to see "test-blob"
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'describe tag object' '
     -+	git tag test-blob-1 -a -m msg unique-file:file &&
     -+	test_must_fail git describe test-blob-1 2>actual &&
     -+	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
     -+'
     -+
     -+test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
     -+	i=1 &&
     -+	while test $i -lt 8000
     -+	do
     -+		echo "commit refs/heads/main
     -+committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
     -+data <<EOF
     -+commit #$i
     -+EOF" &&
     -+		if test $i = 1
     -+		then
     -+			echo "from refs/heads/main^0"
     -+		fi &&
     -+		i=$(($i + 1)) || return 1
     -+	done | git fast-import &&
     -+	git checkout main &&
     -+	git tag far-far-away HEAD^ &&
     -+	echo "HEAD~4000 tags/far-far-away~3999" >expect &&
     -+	git name-rev HEAD~4000 >actual &&
     -+	test_cmp expect actual &&
     -+	run_with_limited_stack git name-rev HEAD~4000 >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success ULIMIT_STACK_SIZE 'describe works in a deep repo' '
     -+	git tag -f far-far-away HEAD~7999 &&
     -+	echo "far-far-away" >expect &&
     -+	git describe --tags --abbrev=0 HEAD~4000 >actual &&
     -+	test_cmp expect actual &&
     -+	run_with_limited_stack git describe --tags --abbrev=0 HEAD~4000 >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+check_describe tags/A --all A
     -+check_describe tags/c --all c
     -+check_describe heads/branch_A --all --match='branch_*' branch_A
     -+
     -+test_expect_success 'describe complains about tree object' '
     -+	test_must_fail git describe HEAD^{tree}
     -+'
     -+
     -+test_expect_success 'describe complains about missing object' '
     -+	test_must_fail git describe $ZERO_OID
     -+'
     -+
     -+test_expect_success 'name-rev a rev shortly after epoch' '
     -+	test_when_finished "git checkout main" &&
     -+
     -+	git checkout --orphan no-timestamp-underflow &&
     -+	# Any date closer to epoch than the CUTOFF_DATE_SLOP constant
     -+	# in builtin/name-rev.c.
     -+	GIT_COMMITTER_DATE="@1234 +0000" \
     -+	git commit -m "committer date shortly after epoch" &&
     -+	old_commit_oid=$(git rev-parse HEAD) &&
     -+
     -+	echo "$old_commit_oid no-timestamp-underflow" >expect &&
     -+	git name-rev $old_commit_oid >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+# A--------------main
     -+#  \            /
     -+#   \----------M2
     -+#    \        /
     -+#     \---M1-C
     -+#      \ /
     -+#       B
     -+test_expect_success 'name-rev covers all conditions while looking at parents' '
     -+	git init repo &&
     -+	(
     -+		cd repo &&
     -+
     -+		echo A >file &&
     -+		git add file &&
     -+		git commit -m A &&
     -+		A=$(git rev-parse HEAD) &&
     -+
     -+		git checkout --detach &&
     -+		echo B >file &&
     -+		git commit -m B file &&
     -+		B=$(git rev-parse HEAD) &&
     -+
     -+		git checkout $A &&
     -+		git merge --no-ff $B &&  # M1
     -+
     -+		echo C >file &&
     -+		git commit -m C file &&
     -+
     -+		git checkout $A &&
     -+		git merge --no-ff HEAD@{1} && # M2
     -+
     -+		git checkout main &&
     -+		git merge --no-ff HEAD@{1} &&
     -+
     -+		echo "$B main^2^2~1^2" >expect &&
     -+		git name-rev $B >actual &&
     -+
     -+		test_cmp expect actual &&
     -+		git sparse-checkout init --cone
     -+	)
     -+'
     -+
     -+# A-B-C-D-E-main
     -+#
     -+# Where C has a non-monotonically increasing commit timestamp w.r.t. other
     -+# commits
     -+test_expect_success 'non-monotonic commit dates setup' '
     -+	UNIX_EPOCH_ZERO="@0 +0000" &&
     -+	git init non-monotonic &&
     -+	test_commit -C non-monotonic A &&
     -+	test_commit -C non-monotonic --no-tag B &&
     -+	test_commit -C non-monotonic --no-tag --date "$UNIX_EPOCH_ZERO" C &&
     -+	test_commit -C non-monotonic D &&
     -+	test_commit -C non-monotonic E &&
     -+	(
     -+		cd non-monotonic &&
     -+		git sparse-checkout init --cone
     -+	)
     -+'
     -+
     -+test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
     -+	test_config -C non-monotonic core.commitGraph true &&
     -+	(
     -+		cd non-monotonic &&
     -+
     -+		git commit-graph write --reachable &&
     -+
     -+		echo "main~3 tags/D~2" >expect &&
     -+		git name-rev --tags main~3 >actual &&
     -+
     -+		test_cmp expect actual
     -+	)
     -+'
     -+
     -+test_expect_success 'name-rev --all works with non-monotonic timestamps' '
     -+	test_config -C non-monotonic core.commitGraph false &&
     -+	(
     -+		cd non-monotonic &&
     -+
     -+		rm -rf .git/info/commit-graph* &&
     -+
     -+		cat >tags <<-\EOF &&
     -+		tags/E
     -+		tags/D
     -+		tags/D~1
     -+		tags/D~2
     -+		tags/A
     -+		EOF
     -+
     -+		git log --pretty=%H >revs &&
     -+
     -+		paste -d" " revs tags | sort >expect &&
     -+
     -+		git name-rev --tags --all | sort >actual &&
     -+		test_cmp expect actual
     -+	)
     -+'
     -+
     -+test_expect_success 'name-rev --annotate-stdin works with non-monotonic timestamps' '
     -+	test_config -C non-monotonic core.commitGraph false &&
     -+	(
     -+		cd non-monotonic &&
     -+
     -+		rm -rf .git/info/commit-graph* &&
     -+
     -+		cat >expect <<-\EOF &&
     -+		E
     -+		D
     -+		D~1
     -+		D~2
     -+		A
     -+		EOF
     -+
     -+		git log --pretty=%H >revs &&
     -+		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
     -+		test_cmp expect actual
     -+	)
     -+'
     -+
     -+test_expect_success 'name-rev --all works with commitGraph' '
     -+	test_config -C non-monotonic core.commitGraph true &&
     -+	(
     -+		cd non-monotonic &&
     -+
     -+		git commit-graph write --reachable &&
     -+
     -+		cat >tags <<-\EOF &&
     -+		tags/E
     -+		tags/D
     -+		tags/D~1
     -+		tags/D~2
     -+		tags/A
     -+		EOF
     -+
     -+		git log --pretty=%H >revs &&
     -+
     -+		paste -d" " revs tags | sort >expect &&
     -+
     -+		git name-rev --tags --all | sort >actual &&
     -+		test_cmp expect actual
     -+	)
     -+'
     -+
     -+test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
     -+	test_config -C non-monotonic core.commitGraph true &&
     -+	(
     -+		cd non-monotonic &&
     -+
     -+		git commit-graph write --reachable &&
     -+
     -+		cat >expect <<-\EOF &&
     -+		E
     -+		D
     -+		D~1
     -+		D~2
     -+		A
     -+		EOF
     -+
     -+		git log --pretty=%H >revs &&
     -+		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
     -+		test_cmp expect actual
     -+	)
     -+'
     -+
     -+#               B
     -+#               o
     -+#                \
     -+#  o-----o---o----x
     -+#        A
     -+#
     -+test_expect_success 'setup: describe commits with disjoint bases' '
     -+	git init disjoint1 &&
     -+	(
     -+		cd disjoint1 &&
     -+
     -+		echo o >> file && git add file && git commit -m o &&
     -+		echo A >> file && git add file && git commit -m A &&
     -+		git tag A -a -m A &&
     -+		echo o >> file && git add file && git commit -m o &&
     -+
     -+		git checkout --orphan branch && rm file &&
     -+		echo B > file2 && git add file2 && git commit -m B &&
     -+		git tag B -a -m B &&
     -+		git merge --no-ff --allow-unrelated-histories main -m x &&
     -+		git sparse-checkout init --cone
     -+	)
     -+'
     -+
     -+check_describe -C disjoint1 "A-3-gHASH" HEAD
     -+
     -+#           B
     -+#   o---o---o------------.
     -+#                         \
     -+#                  o---o---x
     -+#                  A
     -+#
     -+test_expect_success 'setup: describe commits with disjoint bases 2' '
     -+	git init disjoint2 &&
     -+	(
     -+		cd disjoint2 &&
     -+
     -+		echo A >> file && git add file && GIT_COMMITTER_DATE="2020-01-01 18:00" git commit -m A &&
     -+		git tag A -a -m A &&
     -+		echo o >> file && git add file && GIT_COMMITTER_DATE="2020-01-01 18:01" git commit -m o &&
     -+
     -+		git checkout --orphan branch &&
     -+		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:00" git commit -m o &&
     -+		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:01" git commit -m o &&
     -+		echo B >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:02" git commit -m B &&
     -+		git tag B -a -m B &&
     -+		git merge --no-ff --allow-unrelated-histories main -m x &&
     -+		git sparse-checkout init --cone
     -+	)
     -+'
     -+
     -+check_describe -C disjoint2 "B-3-gHASH" HEAD
     -+
     -+test_expect_success 'setup misleading taggerdates' '
     -+	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
     -+'
     -+
     -+check_describe newer-tag-older-commit~1 --contains unique-file~2
     -+
      +test_done


 builtin/describe.c                       |  2 +
 t/perf/p2000-sparse-operations.sh        |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 11 ++++
 t/t6121-describe-sparse.sh               | 67 ++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100755 t/t6121-describe-sparse.sh

diff --git a/builtin/describe.c b/builtin/describe.c
index 5b5930f5c8c..7ff9b5e4b20 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			int fd, result;
 
 			setup_work_tree();
+			prepare_repo_settings(the_repository);
+			the_repository->settings.command_requires_full_index = 0;
 			repo_read_index(the_repository);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a0..db7887470f9 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -43,6 +43,7 @@ test_expect_success 'setup repo and indexes' '
 	done &&
 
 	git sparse-checkout init --cone &&
+	git tag -a v1.0 -m "Final" &&
 	git sparse-checkout set $SPARSE_CONE &&
 	git checkout -b wide $OLD_COMMIT &&
 
@@ -125,5 +126,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git describe --dirty
+test_perf_on_all 'echo >>new && git describe --dirty'
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e1..9a4db09178f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1514,6 +1514,17 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash pop
 '
 
+test_expect_success 'sparse-index is not expanded: describe' '
+	init_repos &&
+	# Add tag to be read by describe
+	ensure_not_expanded tag -a v1.0 -m "Version 1" &&
+	ensure_not_expanded describe --dirty &&
+	ensure_not_expanded describe &&
+	echo "test" >>sparse-index/extra.txt &&
+	ensure_not_expanded describe --dirty &&
+	ensure_not_expanded describe
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 
diff --git a/t/t6121-describe-sparse.sh b/t/t6121-describe-sparse.sh
new file mode 100755
index 00000000000..ce53603c387
--- /dev/null
+++ b/t/t6121-describe-sparse.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='git describe in sparse checked out trees'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+check_describe () {
+	indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+	indir=${indir:+"$indir"/} &&
+	expect="$1"
+	shift
+	describe_opts="$@"
+	test_expect_success "describe $describe_opts" '
+		git ${indir:+ -C "$indir"} describe $describe_opts >actual &&
+		echo "$expect" >expect &&
+		test_cmp expect actual
+	'
+}
+
+test_expect_success setup '
+	test_commit initial file one &&
+	test_commit --annotate A file A &&
+
+	test_tick &&
+
+	git sparse-checkout init --cone
+'
+
+check_describe A HEAD
+
+test_expect_success 'describe --dirty with --work-tree' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
+	) &&
+	grep "A" out
+'
+
+test_expect_success 'set-up dirty work tree' '
+	echo >>file
+'
+
+test_expect_success 'describe --dirty with --work-tree (dirty)' '
+	git describe --dirty >expected &&
+	(
+		cd "$TEST_DIRECTORY" &&
+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
+	) &&
+	test_cmp expected out
+'
+test_done

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
