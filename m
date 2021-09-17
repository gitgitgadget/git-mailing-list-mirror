Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789B9C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B72061029
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhIQW4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhIQW4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:56:32 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2260C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l22-20020a05622a175600b0029d63a970f6so100763657qtk.23
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Co3j4L6SHzZR+C7cvCVLQc8xpLLwuna5mbpgVFL+jSc=;
        b=OXVcsM83blaGkjrl0q5PCJI01ArVsYQbGOIPAIugDxNG6B7Uan2nRobsTzBarzrThb
         tzXHTV+ZDr7l5l4vz72/UXndOcC3ZYnTyV76jfqOanQyW7eMvYouP54lCDM/wmY5d9w6
         rRNdINXDVrkqcTdIAVOt18MGFkyiAzoqGywyJ2AcD38rrAQBlHAczObQ6edBToPvtNsb
         2mVxi/tGN/oCZtiETOQWpeUNnStyJpbYWzoGkQ8O8G3Ay6QzYca8MoxIS9eSc/jSKKmb
         NbC0mlWK7Ejy7p3+EnHOfh8TAIfYC9t5bPXj1YAESAIMjIJ9Ccedi7XdLPFPYQc9K/Bg
         WC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Co3j4L6SHzZR+C7cvCVLQc8xpLLwuna5mbpgVFL+jSc=;
        b=yn7T5tkQhOhRtEVlx6HAx0Rsbl57UTkwDRBt9N/bKAD9oeU8TNDnRO2p0ZngPeW9mx
         XQ1nv2cXCre4ELZLd8/X4sLRSml3AhsjHvYK1Y5TEUdcdtCNYkd5CBSuupcJkdArtMCR
         M8ugO3tRonYrXi/ZtFogwDlGD8E2MU9OtzrcQm3b+meTxi9sf/ctDlUhjIn8eBF2jUFB
         TPnv0izSXVbH8xiwDHZVnbcDpRSeyARPkSTtzxIUQrh8/h1yDB47tup2+OAPlVQh925n
         nWg+U5H38HoQ/k5s6HFhBedDeU39oJZl2rsyA7Igxn1HgsWsWs1MfoAWfHoXxiUjNWze
         3qlA==
X-Gm-Message-State: AOAM532ZFj609f4sLTY3QVowu3oQztKnpiP92Sxx/eI5nmoulLA6+tOE
        cn/zDQU6/xsO0xsSwDt8hSEoEn01QDlRmkxskzBxn8GhV2YaQPRuCsYAqyVTiliqnmoITUQOFOQ
        kv/HbefvQ3HtexvKsvMFRys35fmpwreeFNlI3oeCSVmoZQGjtHiasBOYIX2IKGQY=
X-Google-Smtp-Source: ABdhPJxkSBMWE0Zmcd09zp9Xr8XRhkFFwCMWmIPZcHUbDUYgRhVMZt6H53BDHYPuAiGq2EwKLwTzTtk7soJoIg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:7a6:: with SMTP id
 v6mr13900249qvz.13.1631919308679; Fri, 17 Sep 2021 15:55:08 -0700 (PDT)
Date:   Fri, 17 Sep 2021 15:54:56 -0700
In-Reply-To: <20210913181221.42635-1-chooglen@google.com>
Message-Id: <20210917225459.68086-1-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks so much for the review, the comments have been really helpful!
v2 doesn't change any business logic, it's mostly focused on
incorporating the feedback around commit messages and tests.

Changes since v1:

* clean up typo in patch 1 commit message 
* document the commits that patches 1 and 2 address
* use test helpers in patch 1
* rewrite patch 2's tests so that it's easier to tell that each test
  does something different
* reword patch 3 commit message to explain the bug
* add tests to patch 3

Glen Choo (3):
  fsck: verify commit graph when implicitly enabled
  fsck: verify multi-pack-index when implictly enabled
  gc: perform incremental repack when implictly enabled

 builtin/fsck.c              |  5 ++-
 builtin/gc.c                |  5 +--
 t/t5318-commit-graph.sh     | 24 +++++++++-
 t/t5319-multi-pack-index.sh |  4 +-
 t/t7900-maintenance.sh      | 88 ++++++++++++++++++++++++++-----------
 5 files changed, 94 insertions(+), 32 deletions(-)

Range-diff against v1:
1:  6bddc4e158 ! 1:  97ab2bb529 fsck: verify commit graph when implicitly enabled
    @@ Metadata
      ## Commit message ##
         fsck: verify commit graph when implicitly enabled
     
    -    the_repository->settings() is the preferred way to get certain
    +    the_repository->settings is the preferred way to get certain
         settings (such as "core.commitGraph") because it gets default values
         from prepare_repo_settings(). However, cmd_fsck() reads the config
         directly via git_config_get_bool(), which bypasses these default values.
         This causes fsck to ignore the commit graph if "core.commitgraph" is not
    -    explicitly set in the config, even though commit graph is enabled by
    -    default.
    +    explicitly set in the config. This worked fine until commit-graph was
    +    enabled by default in 31b1de6a09 (commit-graph: turn on commit-graph by
    +    default, 2019-08-13).
     
         Replace git_config_get_bool("core.commitgraph") in fsck with the
         equivalent call to the_repository->settings.core_commit_graph.
    @@ t/t5318-commit-graph.sh: test_expect_success 'git fsck (checks commit-graph)' '
     +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
     +		"incorrect checksum" &&
     +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
    -+	git -c core.commitGraph=false fsck
    ++	test_config core.commitGraph false &&
    ++	git fsck
     +'
     +
     +test_expect_success 'git fsck (checks commit-graph when config unset)' '
    @@ t/t5318-commit-graph.sh: test_expect_success 'git fsck (checks commit-graph)' '
     +	git fsck &&
     +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
     +		"incorrect checksum" &&
    -+        git config --unset core.commitGraph &&
    ++	test_unconfig core.commitGraph &&
     +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
     +	test_must_fail git fsck
     +'
2:  3b86afc45b ! 2:  ace92453ca fsck: verify multi-pack-index when implictly enabled
    @@ Commit message
         Like the previous commit, the_repository->settings.core_multi_pack_index
         is preferable to reading "core.multiPackIndex" from the config because
         prepare_repo_settings() sets a default value for
    -    the_repository->settings.
    +    the_repository->settings. This worked fine until core.multiPackIndex was
    +    enabled by default in 18e449f86b (midx: enable core.multiPackIndex by
    +    default, 2020-09-25).
     
         Replace git_config_get_bool("core.multiPackIndex") in fsck with the
         equivalent call to the_repository->settings.multi_pack_index.
    @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
     
      ## t/t5319-multi-pack-index.sh ##
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'verify incorrect offset' '
    - 		"incorrect object offset"
    - '
    - 
    --test_expect_success 'git-fsck incorrect offset' '
    -+test_expect_success 'git-fsck incorrect offset (config set to true)' '
    + test_expect_success 'git-fsck incorrect offset' '
      	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
      		"incorrect object offset" \
    - 		"git -c core.multipackindex=true fsck"
    - '
    - 
    -+test_expect_success 'git-fsck incorrect offset (config set to false)' '
    -+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
    -+		"incorrect object offset" \
    +-		"git -c core.multipackindex=true fsck"
     +		"git -c core.multipackindex=true fsck" &&
    ++		test_must_fail git fsck &&
     +		git -c core.multipackindex=false fsck
    -+'
    -+
    -+test_expect_success 'git-fsck incorrect offset (config unset)' '
    -+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
    -+		"incorrect object offset" \
    -+		"git fsck"
    -+'
    -+
    + '
    + 
      test_expect_success 'corrupt MIDX is not reused' '
    - 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
    - 		"incorrect object offset" &&
3:  d122ce3bf8 ! 3:  d6959d61c1 gc: perform incremental repack when implictly enabled
    @@ Metadata
      ## Commit message ##
         gc: perform incremental repack when implictly enabled
     
    -    builtin/gc.c has two ways of checking of multi-pack-index is enabled:
    +    builtin/gc.c has two ways of checking if multi-pack-index is enabled:
         - git_config_get_bool() in incremental_repack_auto_condition()
         - the_repository->settings.core_multi_pack_index in
           maintenance_task_incremental_repack()
     
    -    the_repository->settings.core_multi_pack_index should be preferred
    -    because it has default values from prepare_repo_settings().
    +    The two implementations have existed since the incremental-repack task
    +    was introduced in e841a79a13 (maintenance: add incremental-repack auto
    +    condition, 2020-09-25). These two values can diverge because
    +    prepare_repo_settings() enables the feature in the_repository->settings
    +    by default.
     
    -    Standardize on the_repository->settings.core_multi_pack_index to check
    -    if multi-pack-index is enabled.
    +    In the case where core.multiPackIndex is not set in the config, the auto
    +    condition would fail, causing the incremental-repack task to not be
    +    run. Because we always want to consider the default values, we should
    +    just always just use the_repository->settings.
    +
    +    Standardize on using the_repository->settings.core_multi_pack_index to
    +    check if multi-pack-index is enabled.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
    @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_run_o
      		return 0;
      
      	git_config_get_int("maintenance.incremental-repack.auto",
    +
    + ## t/t7900-maintenance.sh ##
    +@@ t/t7900-maintenance.sh: test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
    + '
    + 
    + test_expect_success 'maintenance.incremental-repack.auto' '
    +-	git repack -adk &&
    +-	git config core.multiPackIndex true &&
    +-	git multi-pack-index write &&
    +-	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
    +-		-c maintenance.incremental-repack.auto=1 \
    +-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
    +-	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
    +-	test_commit A &&
    +-	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
    +-	HEAD
    +-	^HEAD~1
    +-	EOF
    +-	GIT_TRACE2_EVENT=$(pwd)/trace-A git \
    +-		-c maintenance.incremental-repack.auto=2 \
    +-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
    +-	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
    +-	test_commit B &&
    +-	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
    +-	HEAD
    +-	^HEAD~1
    +-	EOF
    +-	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
    +-		-c maintenance.incremental-repack.auto=2 \
    +-		maintenance run --auto --task=incremental-repack 2>/dev/null &&
    +-	test_subcommand git multi-pack-index write --no-progress <trace-B
    ++	(
    ++		git init incremental-repack-true &&
    ++		cd incremental-repack-true &&
    ++		git config core.multiPackIndex true &&
    ++		test_commit A &&
    ++		git repack -adk &&
    ++		git multi-pack-index write &&
    ++		GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
    ++			-c maintenance.incremental-repack.auto=1 \
    ++			maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++		test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
    ++		test_commit B &&
    ++		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
    ++		HEAD
    ++		^HEAD~1
    ++		EOF
    ++		GIT_TRACE2_EVENT=$(pwd)/trace-A git \
    ++			-c maintenance.incremental-repack.auto=2 \
    ++			maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++		test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
    ++		test_commit C &&
    ++		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
    ++		HEAD
    ++		^HEAD~1
    ++		EOF
    ++		GIT_TRACE2_EVENT=$(pwd)/trace-B git \
    ++			-c maintenance.incremental-repack.auto=2 \
    ++			maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++		test_subcommand git multi-pack-index write --no-progress <trace-B
    ++	)
    ++'
    ++
    ++test_expect_success 'maintenance.incremental-repack.auto (when config is unset)' '
    ++	(
    ++		git init incremental-repack-unset &&
    ++		cd incremental-repack-unset &&
    ++		test_unconfig core.multiPackIndex &&
    ++		test_commit A &&
    ++		git repack -adk &&
    ++		git multi-pack-index write &&
    ++		GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
    ++			-c maintenance.incremental-repack.auto=1 \
    ++			maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++		test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
    ++		test_commit B &&
    ++		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
    ++		HEAD
    ++		^HEAD~1
    ++		EOF
    ++		GIT_TRACE2_EVENT=$(pwd)/trace-A git \
    ++			-c maintenance.incremental-repack.auto=2 \
    ++			maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++		test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
    ++		test_commit C &&
    ++		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
    ++		HEAD
    ++		^HEAD~1
    ++		EOF
    ++		GIT_TRACE2_EVENT=$(pwd)/trace-B git \
    ++			-c maintenance.incremental-repack.auto=2 \
    ++			maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++		test_subcommand git multi-pack-index write --no-progress <trace-B
    ++	)
    + '
    + 
    + test_expect_success 'pack-refs task' '
-- 
2.33.0.464.g1972c5931b-goog

