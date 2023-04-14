Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C30C77B73
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDNR6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNR6n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:58:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D37DB6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e16so5089437wra.6
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495120; x=1684087120;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv0m5He2+t546XYlCCWfavvHgOUqvZ9+YAQRmB1nnwE=;
        b=R33Y7EOP/XNMqkICfHA1M2caRoz6vmZ6rf4aDAjXOtdtuTfc8Y/zm3CnwChzHj/nQO
         eNcr8Yb0D5fgWZSJNartrwMINxuMlc98v76hrLkLmalg5z2AgeDg7Hx+xBriRQu98XCL
         pHjmXPKB67rxXeDmHF+J97bocrYL4WnEQtiOaTFR1oHsRxGogHx0G7nIsz1LfQG6Qcnu
         0gSMlPvzbhH72MfP0/FEnSKf8+DMjyQkN15rE6jzL/yqtoSTluSj9JFpQwctBBiQf1Q0
         SN9yiaoE5uGgMm0OGXzOijESeSfeew8tQuvo7DH1TQLPYAL7HOFVSV6yufLIKUS4uQaO
         clGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495120; x=1684087120;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv0m5He2+t546XYlCCWfavvHgOUqvZ9+YAQRmB1nnwE=;
        b=diCK/RmMQeBw2eq/MWG7gyWUJVIfXA8qinoN6r3iOQdMtFFr534qMxDfutoi5DNI7A
         yW0VEpZw7XyLKh1xtyb/S55U6OwvD4Ej3ZK/hMWOlSYsI2rvMeN+ElA6IEGPpfD5C7Ct
         h1YToIRfdx1PlpIZgv1QDiq9OE9KuVnTlzbAjo2+ozfc3AMmxT27NubkpeL7vfBkpUui
         cqMzU1/YHoFC+SjWMy9+SN4bufsaTvEw8gRLNfjz4fJxRcP61EJNX3pbYqHG/B2InOCp
         h1vuuy12zBxQBaLOt/Dt654mklWvwrcN2UZDpUYft+SZ0Vr3Gis7B2DOV9IA9IwJcRsL
         UYsw==
X-Gm-Message-State: AAQBX9cQMow1+n0K38moDKpeYzrpEkaGb7kGoo2MVw0uYB5jSsmOeBmP
        UkIweviIZznkJo0uTqlrQ3JCbUr/9cM=
X-Google-Smtp-Source: AKy350ZmsYy1Cbxp9JbPcdq25vVWmVE2/SumU95q0Exk8BUlLJm6H9v/s/C5sQFJ0E2+kmIdj/RNqQ==
X-Received: by 2002:adf:e98f:0:b0:2de:e7c3:1663 with SMTP id h15-20020adfe98f000000b002dee7c31663mr5032417wrm.10.1681495120522;
        Fri, 14 Apr 2023 10:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020adfe551000000b002f7394e7c01sm1714412wrm.104.2023.04.14.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:58:40 -0700 (PDT)
Message-Id: <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 17:58:34 +0000
Subject: [PATCH 1/5] revisions.txt: document more special refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Some special refs, namely HEAD, FETCH_HEAD, ORIG_HEAD, MERGE_HEAD and
CHERRY_PICK_HEAD, are mentioned and described in 'gitrevisions', but some
others, namely REBASE_HEAD, REVERT_HEAD, and BISECT_HEAD, are not.

Add a small description of these special refs.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/revisions.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9aa58052bc7..98b8f89bc8d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -32,8 +32,8 @@ characters and to avoid word splitting.
   first match in the following rules:
 
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
-    and `CHERRY_PICK_HEAD`);
+    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
+    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
 
   . otherwise, 'refs/<refname>' if it exists;
 
@@ -55,8 +55,15 @@ you can easily change the tip of the branch back to the state before you ran
 them.
 `MERGE_HEAD` records the commit(s) which you are merging into your branch
 when you run `git merge`.
+`REBASE_HEAD`, during a rebase, records the commit at which the
+operation is currently stopped, either because of conflicts or an `edit`
+command in an interactive rebase.
+`REVERT_HEAD` records the commit which you are reverting when you
+run `git revert`.
 `CHERRY_PICK_HEAD` records the commit which you are cherry-picking
 when you run `git cherry-pick`.
+`BISECT_HEAD` records the current commit to be tested when you
+run `git bisect --no-checkout`.
 +
 Note that any of the 'refs/*' cases above may come either from
 the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
-- 
gitgitgadget

