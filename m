Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C235DC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A7A21655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UycH0JmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfLLOgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35049 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfLLOgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2777871wmb.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/50tsg0WF1RPAKWO+eD4BpY/4M3EHrjNNjTZh3wRJNU=;
        b=UycH0JmHMm6oQgSwwh6G2acSFsEZ9L5ZdYXucWeB11VayokPqafeZb9E90S0n0ynqU
         6q2QL8sujl9PhFVSzwAy5aa0l1HHgyf4BzM35AyNl4hdMtsRX4F0Vdkv7C40ro3e9XSU
         3gumdisJqpRVZliXBZfgVZmqfSSZQwFG9gwVkHqWuZY2u/UnkSCJZKwtNZx2/Gbawa9+
         4/qUwkIPAfg9nvvaz0nY4QZVIqMpMD/LYWzetOKFiolBKjOR0Z5FY0CCi6MlFQMe3mhS
         hJPuA49bCYiM5vKBoSoDnMrUtgipxeX1AbIdHUr4kufR+VbW3oilLTXle+9vKpXswBpV
         l6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/50tsg0WF1RPAKWO+eD4BpY/4M3EHrjNNjTZh3wRJNU=;
        b=RJhV1q879kqd0ZoW9T/Kp1IdJJc8v1stpHE6MhFYSX2iXcpHl6I0Se1E8gv+Yt2x4i
         PxuiR99CWQK8Yozzxhb9G41U4jT/VqsbUCP6P849WA8k9Z+0BNS0fvxm77Pd0TfjTs4P
         N8680+BVyMd2rnaYn0oL3bRBtHnBxEKj1+de+ty8c1dDdK8Oa5hO8SAWwJJQTe9tkyJ5
         yqPYFtOTUl9S1RUgIm+eevlqVxWhJqAcBcXm96w2RiMSnLnii/qz0hIRJndUrEKII7Km
         MD4NvlJNZvq6Rhrh3e0007sxOst+ISn4lziKlV7sw7gOmIGbYGVK1E4DpDWpQV84lWpu
         rlRg==
X-Gm-Message-State: APjAAAWpQ0+AT03lZk2vCs+VaPFixB0JECoz4iqjL0V8aJ9sl4GQ/9Ko
        LgsciMY0FGBUF0indQMdUH9jiApk
X-Google-Smtp-Source: APXvYqxBN8HIvTveN3H0hZERVYhI/VXOzIbOFGqzydz6Dh8vl6+0kOgfkGVyIHSptq8FGVChBh5EDQ==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr6696895wmg.86.1576161388572;
        Thu, 12 Dec 2019 06:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm6384470wrt.45.2019.12.12.06.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:28 -0800 (PST)
Message-Id: <369096494223222ef96e38ca27f0b82c6eb59e92.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:12 +0000
Subject: [PATCH 03/16] cmd_add: prepare for next patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Some code blocks were moved down to be able to test for `pathspec.nr`
in the next patch. Blocks are moved as is without any changes. This
is done as separate patch to reduce the amount of diffs in next patch.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/add.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index d4686d5218..3d1791dd82 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -430,10 +430,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/* Turn "git add pathspec..." to "git add -A pathspec..." */
-		addremove = 1;
-
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
@@ -446,19 +442,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
-		 (show_only ? ADD_CACHE_PRETEND : 0) |
-		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
-		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
-		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
-
-	if (require_pathspec && argc == 0) {
-		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
-		return 0;
-	}
-
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
 	 * below before enabling new magic.
@@ -468,6 +451,23 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		       PATHSPEC_SYMLINK_LEADING_PATH,
 		       prefix, argv);
 
+	if (require_pathspec && argc == 0) {
+		fprintf(stderr, _("Nothing specified, nothing added.\n"));
+		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		return 0;
+	}
+
+	if (!take_worktree_changes && addremove_explicit < 0 && argc)
+		/* Turn "git add pathspec..." to "git add -A pathspec..." */
+		addremove = 1;
+
+	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
+		 (show_only ? ADD_CACHE_PRETEND : 0) |
+		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
+		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
+		 (!(addremove || take_worktree_changes)
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+
 	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
 
-- 
gitgitgadget

