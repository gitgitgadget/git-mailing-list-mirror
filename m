Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC292C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B7120678
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkJTyORE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgDASLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:11:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40188 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgDASLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 14:11:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so1015788edu.7
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=o1d7bKVC0u5o9KNjkni1FqC1mHGNOnKHNJTramX3Wjg=;
        b=lkJTyOREg0qULGsEFVqceFWj+u74KRmrNHZVdbCnx/pwxcl6FC27nb+7cexWfhGPlt
         X/1TgdogwtjenEELXYm6JkKkbh2kPbMFIpXGP+MPJmYluhZpj+8Z/FRtYuWa8IFigxHs
         VWtUSefxSNVkccOrTu53Nt2IAOBnGFuC1sZhCMx22nLvryjEige0+JaueEGSY0SVlyUh
         jKgySDLdhC1xF7vScaNkS5LX7PUGeoJmk/CLpTHWlQQutNQHYjK3DPUZiS6Kufgj138N
         y2WwELc2XxWxc7eZyaOuPK5kVb/3XfMSVAYBHQ2D5nfwI1VF8RKHxrTjEPOrUlaiWlJB
         11OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o1d7bKVC0u5o9KNjkni1FqC1mHGNOnKHNJTramX3Wjg=;
        b=R5QVG9d4qTB0vvmWDWjlfNqCYe6Am8Hx0hnQoZRtBSsnwN13IlY9R21+dipX4w7Gm/
         JqgTZtbAF48EiCwIZ2+3s2ffSdGnzGt8QsYr5YWp4oF/Bq6IWqSl+geqY2Xb+36nXdm4
         DHIUwsHZkhCT6Gr3q7IELh6fBbP9G1LwPBAJWKp9RNTEPzdIeTce1Bs3vFvK1VizVNWR
         p/cIQSWURaVha9yMDMRv9tofOjJYriEtRJyhkUoDzotV0QiytPQi21yjcPiIg0MlBjRF
         8zpu3C19bp7tW/+fvcRdjcDHMSF/4o72rjatpdplIt7/f8t7DPVyGiB8lOsysEz3Ojst
         ulXQ==
X-Gm-Message-State: ANhLgQ3rCPpQ1qBanXmlWkX7rNvoP1bm7Get0m9bLx/myRSZcjcmKDiu
        J5cE3l6IrSBZEnDfUxJSAA+pZPZo
X-Google-Smtp-Source: ADFU+vuZVLajf20tiRveR0px0CvrhI86+bSYk4Ms8BLwdxyMD6qjDw0Za0RNxhnNyLxmohi/yRQtQg==
X-Received: by 2002:a17:906:1251:: with SMTP id u17mr9682028eja.315.1585764696838;
        Wed, 01 Apr 2020 11:11:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm583774edn.69.2020.04.01.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:11:36 -0700 (PDT)
Message-Id: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 18:11:35 +0000
Subject: [PATCH] commit-graph: fix buggy --expire-time option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph builtin has an --expire-time option that takes a
datetime using OPT_EXPIRY_DATE(). However, the implementation inside
expire_commit_graphs() was treating a non-zero value as a number of
seconds to subtract from "now".

Update t5323-split-commit-graph.sh to demonstrate the correct value
of the --expire-time option by actually creating a crud .graph file
with mtime earlier than the expire time. Instead of using a super-
early time (1980) we need to use a recent time or else the old
logic actually passes by accident. This test will start passing
again on the old logic in 40 years or so.

I noticed this when inspecting some Scalar repos that had an excess
number of commit-graph files. In Scalar, we were using this second
interpretation by using "--expire-time=3600" to mean "delete graphs
older than one hour ago" to avoid deleting a commit-graph that a
foreground process may be trying to load.

Also I noticed that the help text was copied from the --max-commits
option. Fix that help text.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    commit-graph: fix buggy --expire-time option
    
    This is embarassing. I should have noticed this when writing it the
    first time, or when integrating the feature into Scalar and VFS for Git.
    Sorry!
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-596%2Fderrickstolee%2Fcommit-graph-expire-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-596/derrickstolee/commit-graph-expire-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/596

 builtin/commit-graph.c        | 2 +-
 commit-graph.c                | 2 +-
 t/t5324-split-commit-graph.sh | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4a70b33fb5f..8000ff0d2ee 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -140,7 +140,7 @@ static int graph_write(int argc, const char **argv)
 		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
 			N_("maximum ratio between two levels of a split commit-graph")),
 		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
-			N_("maximum number of commits in a non-base split commit-graph")),
+			N_("do not expire files newer than a number of seconds before now")),
 		OPT_END(),
 	};
 
diff --git a/commit-graph.c b/commit-graph.c
index f013a84e294..0d0d37787a0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1707,7 +1707,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	timestamp_t expire_time = time(NULL);
 
 	if (ctx->split_opts && ctx->split_opts->expire_time)
-		expire_time -= ctx->split_opts->expire_time;
+		expire_time = ctx->split_opts->expire_time;
 	if (!ctx->split) {
 		char *chain_file_name = get_chain_filename(ctx->odb);
 		unlink(chain_file_name);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 53b2e6b4555..4e4efcaff22 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
 		git config core.commitGraph true &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test_commit 15 &&
-		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
+		touch -m -t 201801010000.00 $graphdir/extra.graph &&
+		git commit-graph write --reachable --split --size-multiple=10 --expire-time=2019-01-01 &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
+		test_path_is_missing $graphdir/extra.graph &&
 		ls $graphdir/graph-*.graph >graph-files &&
 		test_line_count = 3 graph-files
 	) &&

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
