Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB9C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04B320684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyFA04ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLCOC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLCOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so3786091wrj.8
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KIYE1Fbl7vq7RG+1KLuvsBy+QKzADB9oXkWTZbz5N3k=;
        b=MyFA04icvY6xj7+nhkhO7d+OXhuJMidmSveelNrvMgmOPUGIJtEKtOmqx9ZzmZaDe2
         UFnf//zm6BUaq4YnBIDTrZXl1IoeXhSetSx4bdffv0LcoyPNZ+oopnrHC+fzIlKs+n39
         w1uUaUsPtmha7trHFdWHuvH9VRX/wcGRkbzZXrgppzE3Wmw6zKnPvRPjbu5LMfKuBbte
         4djx7Fg5oH/93TO9PVjQX4oOdIdyot0PTGmjsRCiVVkL2m8rXcwjceXOv7GsVHywJCOT
         dPjwRm+Hot7wr4IKy2swgzoU+bg29Xt9l6OFwIImxfo5rUbKWLGtP3YrWnH6/M+Mt1PY
         mxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KIYE1Fbl7vq7RG+1KLuvsBy+QKzADB9oXkWTZbz5N3k=;
        b=hYqAGAOkv9DsuSs1E8XZBrIjEaFfPvwEI44NIOyttX89wMzQuNO5ZcDI4iHeXQe7mX
         60ui07gQ4Xrw9pec6aNvqTnZBsmeOjKavPfTUMhISjE2M4dwrfM8+z0fvJQplkZGEKii
         7vCPQpBX86wm48gsGs01YHGbemsPsASyTdslHZSqYa8B8mlFjND0RKkluzLSfL854/9A
         qTam4BWUwbBsvoyCxCQYLfuGhRdppAxfCCfRSDFQp2+WFMG3TsVslKRqnzZFAdExwdIb
         ETCJZVgCREo+U/x6Yzik4Z4H5gUbYx0GvxIo5Rx42AF8UZKTKQpSK+otY5XDbKyDe08o
         Fq1A==
X-Gm-Message-State: APjAAAXqBt1zScHzI6JlI+V/GdeBsEeVSRuo6xaPzlUOSNKvpLBDYGT3
        VYNnBGXO2FaIUYUgGNH2o2RAvNot
X-Google-Smtp-Source: APXvYqxa0inMlOSzArYDwCtOdc27Q0WFmKIkKvpnhCFnFQuScBCpeKFxzanHdWhfszrv5xTViz9P6A==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr5207481wrq.243.1575381746164;
        Tue, 03 Dec 2019 06:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm3748378wrt.29.2019.12.03.06.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:25 -0800 (PST)
Message-Id: <a97910cb55be86738d499786511db0ea9af9f785.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:12 +0000
Subject: [PATCH v4 07/13] cmd_add: prepare for next patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
index dd18e5c9b6..4fabdc72e6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -418,10 +418,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/* Turn "git add pathspec..." to "git add -A pathspec..." */
-		addremove = 1;
-
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
@@ -434,19 +430,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
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
@@ -456,6 +439,23 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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

