Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E688C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjDUO6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjDUO6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD58C13864
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:57:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f176a16c03so12390275e9.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089078; x=1684681078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0mXpk4d9JWbSCGcMj4zJbUAFEZYoqEXOABacpBndUs=;
        b=AIb++rAiw81lgPpBLMlrpdup3UxrmbSvFcKR8GEnl1QAQ5vxIJNX8f8Cf3cihNAvhi
         3pLQE2vx1eR+wLtCZs4qxClL0pI9h1SBw8fAGqYSVLGZ9LEgIe08iVzESIE5a77gbhw1
         91v9icu5tcQqx8lX8cQ6/sH7BbJq2jHnHRLuVrRN2bJscmmWL249nAIhSSzO8rLvv1hE
         L3XGXTBvP707p+eppsqGaSyLO8MpVdnQNlJkGc5kviqCLj4czw+IJe7GKKQvKt/jkzRx
         9ob1FNu7HCqcMTfWeqUIuHKf9R0TbfSbCX1Lj95uA7hwd7eeasJR++1xi1pdqSf+A4oq
         Z6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089078; x=1684681078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0mXpk4d9JWbSCGcMj4zJbUAFEZYoqEXOABacpBndUs=;
        b=M+9fevnbYwEbmhkeIzcgspRSw+vVNThyV0xUN55Gknhp52z/Q3x+jQAi1rjXj3IZGz
         QVZfu1YAPIZVS5os63lMfp2VPs5UGL8fDuZVucIP2fFKczs5seVyj20u14ZEUGHioDEs
         TG9TE6w+EzuFvza9EyqnJHBxxt9v9x6/lawXtrugsVHO1OHwnMLJd7sY7az/sU6ccjcH
         MkdC840DJSOEyxfyiaEeL+VJFsqCdEyzVDGyMDVMe/mIhzJnQ78TgD9FkIu0cmlyXkMx
         k0QA4uzWpgDtWVppkXVQo/2I6Cqf8dXwGq/SAbtV5dCQcFEFEwcNiiJQMoFdWA6M9m9S
         Fmsg==
X-Gm-Message-State: AAQBX9ewrzNRmQjcTMqPJ67H0wUU/9jn/8HFL7kccsUp15wVIvbz48PB
        t0vv46yJKZhwiN9vqhg5cL1zbrmCkpM=
X-Google-Smtp-Source: AKy350YaPfVuHqbrTqPhDMef71xiq1fhXT9lfYokA8Qu7E47soNuJxAM8YGZRuyBttdzFzS0bvkDSg==
X-Received: by 2002:a7b:c016:0:b0:3f1:6fba:b69a with SMTP id c22-20020a7bc016000000b003f16fbab69amr2298954wmb.11.1682089078080;
        Fri, 21 Apr 2023 07:57:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003f16f362ae7sm5041305wmj.21.2023.04.21.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:57 -0700 (PDT)
Message-Id: <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:50 +0000
Subject: [PATCH v2 2/6] rebase -i: remove patch file after conflict resolution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebase stops for the user to resolve conflicts it writes a patch
for the conflicting commit to .git/rebase-merge/patch. This file
should be deleted when the rebase continues. As the path is now used
in two different places rebase_path_patch() is added and used to
obtain the path for the patch.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5073ec5902b..c4a548f2c98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -132,6 +132,11 @@ static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
  * the commit object name of the corresponding patch.
  */
 static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
+/*
+ * When we stop for the user to resolve conflicts this file contains
+ * the patch of the commit that is being picked.
+ */
+static GIT_PATH_FUNC(rebase_path_patch, "rebase-merge/patch")
 /*
  * For the post-rewrite hook, we make a list of rewritten commits and
  * their new sha1s.  The rewritten-pending list keeps the sha1s of
@@ -3490,7 +3495,6 @@ static int make_patch(struct repository *r,
 		return -1;
 	res |= write_rebase_head(&commit->object.oid);
 
-	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
 	repo_init_revisions(r, &log_tree_opt, NULL);
 	log_tree_opt.abbrev = 0;
@@ -3498,7 +3502,7 @@ static int make_patch(struct repository *r,
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
 	log_tree_opt.disable_stdin = 1;
 	log_tree_opt.no_commit_id = 1;
-	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
+	log_tree_opt.diffopt.file = fopen(rebase_path_patch(), "w");
 	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
 	if (!log_tree_opt.diffopt.file)
 		res |= error_errno(_("could not open '%s'"), buf.buf);
@@ -4642,6 +4646,7 @@ static int pick_commits(struct repository *r,
 	unlink(rebase_path_message());
 	unlink(rebase_path_stopped_sha());
 	unlink(rebase_path_amend());
+	unlink(rebase_path_patch());
 
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
-- 
gitgitgadget

