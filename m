Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54EA61F453
	for <e@80x24.org>; Tue, 30 Oct 2018 06:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeJ3PQ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 11:16:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33634 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeJ3PQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 11:16:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so5015227pln.0
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jPF9pm2ngSEGhR2H3o3DJAOiXxuejOLINPiVePQBiIs=;
        b=aRdWowgPOqhJ8YwWo33itViCBOC2IeOqBpYGY/iKCA4IkkrAIBHa4QwV3ZF8P9qSO2
         1czPzLfjPoBgu5QYQMSLjrGKWk/P9i8IK7n8VS28iXdUjA0kbH+015mD4588Xh8rVKJ/
         5D8fM5Ba8Ie82f7Yjxr7kK1V0O+uK5PSHEr2NMvv51zM6lYRtRxYCTZ5J2Q3jxVcnvjS
         ypVg+qOMS9ADQnl6r0FE3gKWkkpQ7CGXhObakdRxluovdMRCgyi+NNbtcC8yCe+iHa83
         KF0SdDY8BOXi2O4PrHETlGy9VmOC/eFeONzcUOJdgHDCJ/a+66z7rXX0HkmYzb0liYq4
         HZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jPF9pm2ngSEGhR2H3o3DJAOiXxuejOLINPiVePQBiIs=;
        b=JPqXh9n65pvpP+Cc5IAPEBb5sW+a5Wwa58NAMptJ5ajpD86naDsKHN9SeSi/kmsvYi
         hJZb98l6VoR96U6md57ZTYDLCMK55I7ycV0jKIDlUyLUAzuTYnBGtqvoYYTyPu9JiOP+
         n50S5/FkJzWKH9FevHAaWra9QI9dwppBy8IiBiEk1UDXFDTl7KJW22hnQiA/5UVYsvkF
         fAvX85g80GjLb2af+Lm4USPoLPjrlYmIE9nKbJu3ivoqkFMGV0q+FXw+Zd2PKxjgCVKr
         QjsPP3S7zIBnSkmppkTFmxX634QBuh6Xv8Y7UNBodm4wVRH0zrQDscOLQaogRjAtuJt3
         vymg==
X-Gm-Message-State: AGRZ1gIghdmX7X5Nuzb0OBkl6OSZHJIfUriFcUoBUteLLI+3jTGNi3/C
        pfeGN5TvRzSgiTnvcso7TiS5fRW7
X-Google-Smtp-Source: AJdET5dTSqLbZBPVnkWZxd8exe7gy/xPFeaP09Z5s+MnjHSdLQ/ySoOt08t+3yEXBCcFaO2lv0JFDQ==
X-Received: by 2002:a17:902:8ec2:: with SMTP id x2-v6mr17546609plo.157.1540880686866;
        Mon, 29 Oct 2018 23:24:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-200-74.socal.res.rr.com. [23.241.200.74])
        by smtp.gmail.com with ESMTPSA id m1-v6sm24817085pgl.33.2018.10.29.23.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 23:24:46 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org, sunshine@sunshineco.com
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v3 2/2] worktree: rename is_worktree_locked to worktree_lock_reason
Date:   Mon, 29 Oct 2018 23:24:09 -0700
Message-Id: <20181030062409.42169-2-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181030062409.42169-1-nbelakovski@gmail.com>
References: <20181030062409.42169-1-nbelakovski@gmail.com>
In-Reply-To: <20181025055142.38077-1-nbelakovski@gmail.com>
References: <20181025055142.38077-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

A function prefixed with 'is_' would be expected to return a boolean,
however this function returns a string.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 builtin/worktree.c | 10 +++++-----
 worktree.c         |  2 +-
 worktree.h         |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c4abbde2b..5e8402617 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -245,7 +245,7 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	if (!wt)
 		goto done;
 
-	locked = !!is_worktree_locked(wt);
+	locked = !!worktree_lock_reason(wt);
 	if ((!locked && opts->force) || (locked && opts->force > 1)) {
 		if (delete_git_dir(wt->id))
 		    die(_("unable to re-add worktree '%s'"), path);
@@ -682,7 +682,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	if (is_main_worktree(wt))
 		die(_("The main working tree cannot be locked or unlocked"));
 
-	old_reason = is_worktree_locked(wt);
+	old_reason = worktree_lock_reason(wt);
 	if (old_reason) {
 		if (*old_reason)
 			die(_("'%s' is already locked, reason: %s"),
@@ -714,7 +714,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("The main working tree cannot be locked or unlocked"));
-	if (!is_worktree_locked(wt))
+	if (!worktree_lock_reason(wt))
 		die(_("'%s' is not locked"), av[0]);
 	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
 	free_worktrees(worktrees);
@@ -787,7 +787,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	validate_no_submodules(wt);
 
 	if (force < 2)
-		reason = is_worktree_locked(wt);
+		reason = worktree_lock_reason(wt);
 	if (reason) {
 		if (*reason)
 			die(_("cannot move a locked working tree, lock reason: %s\nuse 'move -f -f' to override or unlock first"),
@@ -900,7 +900,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
 	if (force < 2)
-		reason = is_worktree_locked(wt);
+		reason = worktree_lock_reason(wt);
 	if (reason) {
 		if (*reason)
 			die(_("cannot remove a locked working tree, lock reason: %s\nuse 'remove -f -f' to override or unlock first"),
diff --git a/worktree.c b/worktree.c
index b0d0b5426..befdbe7fa 100644
--- a/worktree.c
+++ b/worktree.c
@@ -235,7 +235,7 @@ int is_main_worktree(const struct worktree *wt)
 	return !wt->id;
 }
 
-const char *is_worktree_locked(struct worktree *wt)
+const char *worktree_lock_reason(struct worktree *wt)
 {
 	assert(!is_main_worktree(wt));
 
diff --git a/worktree.h b/worktree.h
index 6b12a3cf6..55d449b6a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -10,7 +10,7 @@ struct worktree {
 	char *path;
 	char *id;
 	char *head_ref;		/* NULL if HEAD is broken or detached */
-	char *lock_reason;	/* private - use is_worktree_locked */
+	char *lock_reason;	/* private - use worktree_lock_reason */
 	struct object_id head_oid;
 	int is_detached;
 	int is_bare;
@@ -60,7 +60,7 @@ extern int is_main_worktree(const struct worktree *wt);
  * Return the reason string if the given worktree is locked or NULL
  * otherwise.
  */
-extern const char *is_worktree_locked(struct worktree *wt);
+extern const char *worktree_lock_reason(struct worktree *wt);
 
 #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
 
-- 
2.14.2

