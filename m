Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92EC2D0F1
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D7220786
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmgVwyzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgC3Ab6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39532 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgC3Abz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id e9so7855952wme.4
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dNfQ6jVSrkUzYV6pOHZOfey72aL6gNJTsqpvfb9xUaA=;
        b=QmgVwyzM3MILd4XWI9JyABez+o4x1RKFz13jw/Z3Z1DzINrBjiYfBHmPr7M4fzGbIA
         IwqAtbFelBveumzQ1a3dsAccSkkF9iDhSEcNUoANCy2WPSuMLHSzUYBGEJyTpG+uW1N8
         7mRyEtLzkuyOQl/Ipj7q+KctH8iJ5yatgzrXCWIqMOQhpffK7OE9jxe3pEkdGE6o9DBi
         VBDVWwQLVS4ll/4ybOHAvDp/ffOCWys1EVzOsW51uUnU1/QTH/P36zD/T0uY1OkyDwna
         lTzOnWYKYWzmH6Bifzc/YhN+wgEk8bkmupdpx2YtOyRufsa4AQg2iLo08jqH/cg/evWZ
         stBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dNfQ6jVSrkUzYV6pOHZOfey72aL6gNJTsqpvfb9xUaA=;
        b=LVy8/PeLtaL2O9icclwD2MxNDS1X49q9OX9jRSHMNdWnPqzi1fcVS8miWwVaeViGiM
         Cvtdjf0tJweWElMpoLm9aibnsmsGNxprDcXErzEXkMJMjkVStLDlo2uwzhW9AZoFTDrb
         2NQkRrRUzgDz77o/+AqJyFW8p/LvaaldKHnR/o7icYo7ovfNE9HFoLh+9YDmk9E2vDVe
         icXfSr+irZBnECT7NxYdu6Q/dddidY0WFmAV+oPqwTaqapcM0pUxA8RiM/8C/Vt71eXs
         RXPslbP4YOzlK12FcxHUSbImLqEBdmp5hEFBQBJOQqvnFAkUoLcz7CV33w8ztnYg/dJD
         UjpQ==
X-Gm-Message-State: ANhLgQ0l3DZOhM9ry5dm1ohlVvADCAUVSiiSngkVcF+oexLwA06+ATl0
        st1u1JvgEvsSa2BNiYip6JPhQBTw
X-Google-Smtp-Source: ADFU+vs6ispro0COPgf8moAceGq17nrRZ5R/539//j5IxWQK+fUb6WUTrmSTQ3hd0AYy/rlvrnQ4eA==
X-Received: by 2002:a1c:2785:: with SMTP id n127mr10214725wmn.183.1585528313576;
        Sun, 29 Mar 2020 17:31:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm19437211wrx.46.2020.03.29.17.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:52 -0700 (PDT)
Message-Id: <213abb5d8951aac010c2c6be0f7fa45f911e5106.1585528299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:38 +0000
Subject: [PATCH v3 16/16] commit-graph: add
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
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
 t/t5318-commit-graph.sh       | 2 ++
 t/t5324-split-commit-graph.sh | 1 +
 6 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cacb5d04a80..59009837dc9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -171,7 +171,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
-	if (opts.enable_changed_paths)
+	if (opts.enable_changed_paths ||
+	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 4df54c4efea..17e25aade96 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -19,6 +19,7 @@ linux-gcc)
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
+	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	make test
diff --git a/commit-graph.h b/commit-graph.h
index 8e7a8e0e5b2..8655d064c14 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -9,6 +9,7 @@
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
+#define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
 struct commit;
 struct bloom_filter_settings;
diff --git a/t/README b/t/README
index 369e3a9ded8..4f53da53a15 100644
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
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 9bf920ae171..18304a65e4d 100755
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
index 53b2e6b4555..d3f1f2c4a71 100755
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
