Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8594C352A3
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AB20730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgsmNKt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBEW4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52748 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgBEW4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so4258182wmc.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3ETh5vryuonAAYU2FkAh5Zc9u0kL+J+hSoerlYLa4LM=;
        b=PgsmNKt3/k6aVV+qPCCijHfQ50JuO71vPwu+DczhTey3w26ZO3BGZf0Nb3cfqBF12w
         ejy5nswlilnfsAQ/WJqTp16fGTpEiN8fYTqrPb5BwVrJyKRstHM8bCaBQKm5icTcnaOC
         IBvsuC2gxCaIXjCYjpq7YMl7RxUHjgu20dArfG+Ei1SejTa/3hEe1wYLpwlUCTsnY2NO
         dNlmgvGNxRk5MNaPugRwAZnGsQVHzdv0vGfSWb54gApRz9tJmEaT0CTcyVfsh4DogkmM
         nvOaqrmpCpHrnSxshhwceXOyoA20vFIhqEwWR8sBlH/6I0Gpwl9VgoYZxqYzIVOk36Dc
         y+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3ETh5vryuonAAYU2FkAh5Zc9u0kL+J+hSoerlYLa4LM=;
        b=bFyCkCMnEtvRuKs19OFICzuC1V00aNVAVJ4YjNp/xGAC+3ro1lNQvBemksBl+Arpn8
         TV39q26I140krpsMMOkb7reZ555xfpuxB2jMCIL7z3gTb7SMejhrJAXv8WT5XinguZxu
         W/riygspvIaFVF5LGMtK/Ef9HsE7AFO5mBBb35cYld20cfjD7nYk613Qyjc9t8LMBQgM
         SYBKN3wCe+zB1POQMOJ0zGcROp9m1SpIKq9LzXjsnNsN2ixOh2ZotVQ9UVgoY818QkKk
         YGftF86odXW3x9pZQt8xzzS9jLvluMhfgWtJTtjjmqiCVsjZGaUAlC/wcsyiJOtbY6GO
         ttxw==
X-Gm-Message-State: APjAAAVWtIJ6qYuXtd/NllPC1qYAXkqbn7Uo87UDAUKQXzOonQuNXQzR
        oLbUemqeyWB6nVppwP0littE4tAT
X-Google-Smtp-Source: APXvYqyJlMta8QHTn6OVryrEM35NkEYEyPJqhd3rc6GwZw/iOCThabMBI5va2ikQmDlATgDn35ODDg==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr7910785wml.173.1580943399618;
        Wed, 05 Feb 2020 14:56:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm1672907wrp.95.2020.02.05.14.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:39 -0800 (PST)
Message-Id: <e1b076a714d611e59d3d71c89221e41a3427fae4.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:30 +0000
Subject: [PATCH v2 11/11] commit-graph: add
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag to the test setup suite
in order to toggle writing Bloom filters when running any of the git tests.
If set to true, we will compute and write Bloom filters every time a test
calls `git commit-graph write`, as if the `--changed-paths` option was
passed in.

The test suite passes when GIT_TEST_COMMIT_GRAPH and
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS are enabled.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 builtin/commit-graph.c        | 3 ++-
 ci/run-build-and-tests.sh     | 1 +
 commit-graph.h                | 1 +
 t/README                      | 5 +++++
 t/t4216-log-bloom.sh          | 3 +++
 t/t5318-commit-graph.sh       | 2 ++
 t/t5324-split-commit-graph.sh | 1 +
 7 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 261dcce091..fc9b234ab0 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -146,7 +146,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
-	if (opts.enable_changed_paths)
+	if (opts.enable_changed_paths ||
+	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..7b4857651d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -19,6 +19,7 @@ linux-gcc)
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	make test
 	;;
diff --git a/commit-graph.h b/commit-graph.h
index 25fefefb3e..4c202ff3d7 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -8,6 +8,7 @@
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
+#define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
 struct commit;
 struct bloom_filter_settings;
diff --git a/t/README b/t/README
index caa125ba9a..be2f7d7fd2 100644
--- a/t/README
+++ b/t/README
@@ -378,6 +378,11 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=<boolean>, when true, forces
+commit-graph write to compute and write changed path Bloom filters for
+every 'git commit-graph write', as if the `--changed-paths` option was
+passed in.
+
 GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
 code path for utilizing a file system monitor to speed up detecting
 new or changed files.
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 19eca1864b..7acebb3962 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -3,6 +3,9 @@
 test_description='git log for a path with bloom filters'
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
 test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	git init &&
 	mkdir A A/B A/B/C &&
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..973020be2d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -3,6 +3,8 @@
 test_description='commit graph'
 . ./test-lib.sh
 
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index c24823431f..9235db4561 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -4,6 +4,7 @@ test_description='split commit graph'
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
 test_expect_success 'setup repo' '
 	git init &&
-- 
gitgitgadget
