Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9688C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiCATua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiCATuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FAE6CA71
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:48:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y5so8135668wmi.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jzfY7G2FPSxLDqzzXVbkHQ5+qizdixX50hvQjBuuVzA=;
        b=WI7O7hUMou5p0v0o7ZwnUqIDdTkYyQyNKu55ymUXhjgM63MVo/DY/wt3DogU2tZVIk
         6nC2Qy416fCiWkqO6IbDCUGqVsbwwauFXZOgl0BS+53E09GneGCuHt21/adjAszZdcR8
         9K38AztDo6kwbPj/qptNGHdUrpBmVzmxUDiUk7JeG+TrZ4vdo2GTtN7yQKz1q90J21sk
         oYOjTI2EWwQgsYATvC1VyseDG9dlzjMU5VacQJLegjHlBPvaP2t4uYVeCkBAHxedTnOH
         iTnWOunO8B3qOA1FAdE68EDoIFW2aPUPqdqKQdULf5wACjiSD9/eZg8uAw3vXovd+u2k
         q6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jzfY7G2FPSxLDqzzXVbkHQ5+qizdixX50hvQjBuuVzA=;
        b=a7LHbMCmA9IJKNbMHBYhEWOXdywtpnDZQvRqmTMclPL+sr3eP4LnYv6w3toSaZywAk
         7kmHSJu+u3oZdqtecFUKeSFoPTVa7vqM0B2Lpw864p19vfGFkvr+UGvs7s1bkiPkQh+N
         7AdrJMtTDAZxePz9v07Zw9qPVpdJpzqOSNm658mDXs5Mt07wisUJtz+AFOJ8XQJqrh7d
         MWuOTlyDxeZXkeCX5BWMjnZCHsgj9w6S6Rc7KTCPS3B/cIdlxOwyjjunobI3ef5ix8lX
         lQ5a44TnciPqX+c/Hs4hEu9ehPqt4LUrfMnSv7wbJlkb2Oi/wvpaUNl44RwvxIqhYhPw
         AmEw==
X-Gm-Message-State: AOAM531j7lZSQenUQRh2AIGsMHkJQPb3n9DkEUZnsgfhKo1E4Js19o1V
        jsge+USfIM3GNgRExHeNkj5MlXTAAkk=
X-Google-Smtp-Source: ABdhPJzqytEjI0yXfcTlt2/dGXHcxne1DDjeIP83YIHSr+U+hfOrzvAO4/2SbvOcKT1I/xjogXhVkw==
X-Received: by 2002:a7b:c2fa:0:b0:381:6403:b44c with SMTP id e26-20020a7bc2fa000000b003816403b44cmr9569802wmk.92.1646164113507;
        Tue, 01 Mar 2022 11:48:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600018c600b001efe4a49566sm6111500wrq.78.2022.03.01.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:33 -0800 (PST)
Message-Id: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 19:48:27 +0000
Subject: [PATCH v3 0/5] Commit-graph: Generation Number v2 Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes some bugs in generation number v2. They were
discovered while building generation number v3, but that implementation will
be delayed until these fixes are merged.

In particular, Git has been ignoring corrected commit dates since shortly
after they were introduced. This is due to a bug I introduced when trying to
make split commit-graphs safer with mixed generation number versions. I also
noticed an issue with the offset overflows that I only noticed after writing
generation number v3 using a smaller offset size, actually triggering the
bug in the test suite.


Updates in v3
=============

 * Used portable printf macros for uint32.
 * Added a new patch that creates lib-commit-graph.sh in preparation for new
   64-bit test script.
 * While copying this information, replaced 'test ! -z ...' with 'test -n
   ...'
 * Instead of editing existing overflow tests, created a new test script
   focused on 64-bit tests.


Updates in v2
=============

 * Dropped generation v3 patches, saving them for later.
 * Updated a commit message to more clearly describe the problem with the
   old code.
 * Used an || instead of two if statements in test script.

Thanks, -Stolee

Derrick Stolee (5):
  test-read-graph: include extra post-parse info
  t5318: extract helpers to lib-commit-graph.sh
  commit-graph: fix ordering bug in generation numbers
  commit-graph: start parsing generation v2 (again)
  commit-graph: fix generation number v2 overflow values

 commit-graph.c                     | 15 +++++--
 t/helper/test-read-graph.c         | 13 ++++++
 t/lib-commit-graph.sh              | 58 ++++++++++++++++++++++++++
 t/t4216-log-bloom.sh               |  1 +
 t/t5318-commit-graph.sh            | 55 +++----------------------
 t/t5324-split-commit-graph.sh      | 10 +++++
 t/t5328-commit-graph-64bit-time.sh | 66 ++++++++++++++++++++++++++++++
 7 files changed, 164 insertions(+), 54 deletions(-)
 create mode 100755 t/lib-commit-graph.sh
 create mode 100755 t/t5328-commit-graph-64bit-time.sh


base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1163%2Fderrickstolee%2Fgen-v3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1163/derrickstolee/gen-v3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1163

Range-diff vs v2:

 1:  2f89275314b ! 1:  4eca8028c97 test-read-graph: include extra post-parse info
     @@ t/helper/test-read-graph.c: int cmd__read_graph(int argc, const char **argv)
       
      +	printf("options:");
      +	if (graph->bloom_filter_settings)
     -+		printf(" bloom(%d,%d,%d)",
     ++		printf(" bloom(%"PRIu32",%"PRIu32",%"PRIu32")",
      +		       graph->bloom_filter_settings->hash_version,
      +		       graph->bloom_filter_settings->bits_per_entry,
      +		       graph->bloom_filter_settings->num_hashes);
 -:  ----------- > 2:  a90cad8efa5 t5318: extract helpers to lib-commit-graph.sh
 2:  cbcbf10e699 ! 3:  562341b76b3 commit-graph: fix ordering bug in generation numbers
     @@ Commit message
          Instead, iterate over the full commit list at the end, checking the
          offsets to see how many grow beyond the maximum value.
      
     -    Update a test in t5318 to use a larger time value, which will help
     -    demonstrate this bug in more cases. It still won't hit all potential
     -    cases until the next change, which reenables reading generation numbers.
     +    Create a new t5328-commit-graph-64-bit-time.sh test script to handle
     +    special cases of testing 64-bit timestampes. This helps demonstrate this
     +    bug in more cases. It still won't hit all potential cases until the next
     +    change, which reenables reading generation numbers. Use the skip_all
     +    trick from 0a2bfccb9c8 (t0051: use "skip_all" under !MINGW in
     +    single-test file, 2022-02-04) to make the output clean when run on a
     +    32-bit system.
      
     +    Hepled-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## commit-graph.c ##
     @@ t/t5318-commit-graph.sh: test_expect_success 'warn on improper hash version' '
       	rm -f .git/objects/info/commit-graph &&
       	test_commit --date "$FUTURE_DATE" future-1 &&
       	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
     +
     + ## t/t5328-commit-graph-64bit-time.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='commit graph with 64-bit timestamps'
     ++. ./test-lib.sh
     ++
     ++if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
     ++then
     ++	skip_all='skipping 64-bit timestamp tests'
     ++	test_done
     ++fi
     ++
     ++. "$TEST_DIRECTORY"/lib-commit-graph.sh
     ++
     ++UNIX_EPOCH_ZERO="@0 +0000"
     ++FUTURE_DATE="@4147483646 +0000"
     ++
     ++GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
     ++
     ++test_expect_success 'lower layers have overflow chunk' '
     ++	rm -f .git/objects/info/commit-graph &&
     ++	test_commit --date "$FUTURE_DATE" future-1 &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" old-1 &&
     ++	git commit-graph write --reachable &&
     ++	test_commit --date "$FUTURE_DATE" future-2 &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" old-2 &&
     ++	git commit-graph write --reachable --split=no-merge &&
     ++	test_commit extra &&
     ++	git commit-graph write --reachable --split=no-merge &&
     ++	git commit-graph write --reachable &&
     ++	graph_read_expect 5 "generation_data generation_data_overflow" &&
     ++	mv .git/objects/info/commit-graph commit-graph-upgraded &&
     ++	git commit-graph write --reachable &&
     ++	graph_read_expect 5 "generation_data generation_data_overflow" &&
     ++	test_cmp .git/objects/info/commit-graph commit-graph-upgraded
     ++'
     ++
     ++graph_git_behavior 'overflow' '' HEAD~2 HEAD
     ++
     ++test_done
 3:  5bc6a7660d8 ! 4:  041d96bf1d7 commit-graph: start parsing generation v2 (again)
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
       
       	if (r->settings.commit_graph_read_changed_paths) {
      
     - ## t/t4216-log-bloom.sh ##
     -@@ t/t4216-log-bloom.sh: graph_read_expect () {
     - 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
     - 	num_commits: $1
     - 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
     --	options: bloom(1,10,7)
     -+	options: bloom(1,10,7) read_generation_data
     - 	EOF
     - 	test-tool read-graph >actual &&
     - 	test_cmp expect actual
     -
     - ## t/t5318-commit-graph.sh ##
     -@@ t/t5318-commit-graph.sh: graph_read_expect() {
     + ## t/lib-commit-graph.sh ##
     +@@ t/lib-commit-graph.sh: graph_read_expect() {
       		OPTIONAL=" $2"
       		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
       	fi
      +	GENERATION_VERSION=2
     -+	if test ! -z "$3"
     ++	if test -n "$3"
      +	then
      +		GENERATION_VERSION=$3
      +	fi
     @@ t/t5318-commit-graph.sh: graph_read_expect() {
       	EOF
       	test-tool read-graph >output &&
       	test_cmp expect output
     +
     + ## t/t4216-log-bloom.sh ##
     +@@ t/t4216-log-bloom.sh: graph_read_expect () {
     + 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
     + 	num_commits: $1
     + 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
     +-	options: bloom(1,10,7)
     ++	options: bloom(1,10,7) read_generation_data
     + 	EOF
     + 	test-tool read-graph >actual &&
     + 	test_cmp expect actual
     +
     + ## t/t5318-commit-graph.sh ##
      @@ t/t5318-commit-graph.sh: test_expect_success 'git commit-graph verify' '
       	cd "$TRASH_DIRECTORY/full" &&
       	git rev-parse commits/8 | git -c commitGraph.generationVersion=1 commit-graph write --stdin-commits &&
 4:  193217c71e0 ! 5:  e957baa9d77 commit-graph: fix generation number v2 overflow values
     @@ Commit message
          show up as a failure in 'git commit-graph verify' if we increase that
          FUTURE_DATE to be above four billion.
      
     -    Fix this error and update the test to require 64-bit dates so we can
     -    safely use this large value in our test.
     +    Fix this error and create a 64-bit timestamp version of the test so we
     +    can test these larger values.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ commit-graph.c: static void fill_commit_graph_info(struct commit *item, struct c
       			graph_data->generation = item->date + offset;
       	} else
      
     - ## t/t5318-commit-graph.sh ##
     -@@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missing tree)' '
     - 	)
     - '
     + ## t/t5328-commit-graph-64bit-time.sh ##
     +@@ t/t5328-commit-graph-64bit-time.sh: test_expect_success 'lower layers have overflow chunk' '
       
     -+# The remaining tests check timestamps that flow over
     -+# 32-bits. The graph_git_behavior checks can't take a
     -+# prereq, so just stop here if we are on a 32-bit machine.
     -+
     -+if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
     -+then
     -+	test_done
     -+fi
     -+
     - # We test the overflow-related code with the following repo history:
     - #
     - #               4:F - 5:N - 6:U
     -@@ t/t5318-commit-graph.sh: test_expect_success 'corrupt commit-graph write (missing tree)' '
     - # The largest offset observed is 2 ^ 31, just large enough to overflow.
     - #
     - 
     --test_expect_success 'set up and verify repo with generation data overflow chunk' '
     -+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk' '
     - 	objdir=".git/objects" &&
     - 	UNIX_EPOCH_ZERO="@0 +0000" &&
     --	FUTURE_DATE="@2147483646 +0000" &&
     -+	FUTURE_DATE="@4000000000 +0000" &&
     - 	test_oid_cache <<-EOF &&
     - 	oid_version sha1:1
     - 	oid_version sha256:2
     -@@ t/t5318-commit-graph.sh: test_expect_success 'set up and verify repo with generation data overflow chunk'
     + graph_git_behavior 'overflow' '' HEAD~2 HEAD
       
     - graph_git_behavior 'generation data overflow chunk repo' repo left right
     - 
     -+# Do not add tests at the end of this file, unless they require 64-bit
     -+# timestamps, since this portion of the script is only executed when
     -+# time data types have 64 bits.
     ++test_expect_success 'set up and verify repo with generation data overflow chunk' '
     ++	mkdir repo &&
     ++	cd repo &&
     ++	git init &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
     ++	test_commit 2 &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
     ++	git commit-graph write --reachable &&
     ++	graph_read_expect 3 generation_data &&
     ++	test_commit --date "$FUTURE_DATE" 4 &&
     ++	test_commit 5 &&
     ++	test_commit --date "$UNIX_EPOCH_ZERO" 6 &&
     ++	git branch left &&
     ++	git reset --hard 3 &&
     ++	test_commit 7 &&
     ++	test_commit --date "$FUTURE_DATE" 8 &&
     ++	test_commit 9 &&
     ++	git branch right &&
     ++	git reset --hard 3 &&
     ++	test_merge M left right &&
     ++	git commit-graph write --reachable &&
     ++	graph_read_expect 10 "generation_data generation_data_overflow" &&
     ++	git commit-graph verify
     ++'
     ++
     ++graph_git_behavior 'overflow 2' repo left right
      +
       test_done

-- 
gitgitgadget
