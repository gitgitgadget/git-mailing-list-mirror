Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73883C2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F98B20726
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ9ct4OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfLPPsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbfLPPsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so7811390wrl.13
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/50tsg0WF1RPAKWO+eD4BpY/4M3EHrjNNjTZh3wRJNU=;
        b=AJ9ct4OF3clBEGKLbj8nPWPkUMpOUnvb9GVS3rOn72/vhhfChf5nLVbeCS50PbOt89
         bVTlAKDUWVM1g/udutUziB3Y0dXu2QFyAH4SAfD2nlD00eX7gvdbPzBQ8JfeScES2gw2
         psahgOymI64GQH0u0Iiy0COgx75K1SLTctyTK1lUtNQFoY8lIFktl6lZ3wUcWq1Ul077
         mpTnErdKB5gEhfF18nPOp+vY6KCyw0IRpaY0Zb6MmGRExe78UblVDgZRcYaCodZC+skA
         Xa6s6HIqgpJ+RsaiaNOY5a9o+3KPb5fFA1ZfYRpUT/XbHbTTHUGnYf4AwecNcCuF6anB
         fF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/50tsg0WF1RPAKWO+eD4BpY/4M3EHrjNNjTZh3wRJNU=;
        b=E1B9IYIMhAbL4Rv71uXzBCQccUq/M+74+ooV3zn18ydv5WAsvsnf6RzDK/7y3gFDzt
         +HrSTmTB6+D9dwHu2Lvj52tZ4tjVYz+JzCuxgVUzGNjZpD4ABm7RmID9Vkj6Q62FLGSd
         V2Co6BwMeh6YvrJxcnkOYuZTUQbVxpVinmC44J7o5nb/LfcLlCG0hs2ji3M7p1GAT/+l
         sFDr4HBtzcQCViUzVT/L8jE32BBm5I8ZUzFqd/XObnyDSy7Wm17haqIAEfETUKfsDFPa
         S1hVxFVvjTL/aZeqBZyfIS1S+RZaE/uzEpzcSfS8zMC/7C1apug8kdl5l3knDjHL48Nf
         /Hzw==
X-Gm-Message-State: APjAAAW9+hdp56FUQXNBReRMxnPthSCT9uTo31CaU5Gi5iQAaE/x0ndR
        M5AyMJQLrqrxMDIbA5/KAD4fQuBJ
X-Google-Smtp-Source: APXvYqwPotTZZ3aP50PJTuMb7gjcas+Nnbm2eySzFjoiTAgE4Uvw+oZD/Vu87XUi8sDzdxAvB/6Pcw==
X-Received: by 2002:adf:f586:: with SMTP id f6mr30157958wro.46.1576511291599;
        Mon, 16 Dec 2019 07:48:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm21970277wrv.66.2019.12.16.07.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:11 -0800 (PST)
Message-Id: <204a0a4446942ac89a59aba672a7646f55185985.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:53 +0000
Subject: [PATCH v2 05/18] cmd_add: prepare for next patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
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

