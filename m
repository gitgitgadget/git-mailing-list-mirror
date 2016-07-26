Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3C8203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 07:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634AbcGZHsw (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 03:48:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35808 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbcGZHsv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 03:48:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so332696wmg.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 00:48:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=anmSOv0+rYNsAHd6rbAJdLF6tPDpmw2rxRNFFKKm6Cs=;
        b=Rd3w2xPImu3gBZdIJtnIekQNbqe7SMhFZYLRWEK0C7ZROcp//c9/GGf+aKqDS6yoo5
         JLyN0Fo+9g4Vxq9/52LwvB9NP0Mt5rY07aYdrlV5SRLY1VfGs2fWbiO1j1nsfTMHIcUj
         7xGS+hPPXULLeRliuFQQm1ybh8G88A5Qf03Ew8AwvmjZYeN8FSdmUo0wpbkM0BXH9U8+
         gy79NgSNpvSBd64yTte0LyprAYCVTCdGKPCF6vSRjpkFUIc9bPAEqpFDc35TE/lyMU0a
         JNj4gMnkWM36RWo2zMKbk4DnZPRkJYA7i1EsxZzuRPiQ1uuQjC4FDxx1oSAiU+goWqnn
         TlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=anmSOv0+rYNsAHd6rbAJdLF6tPDpmw2rxRNFFKKm6Cs=;
        b=TbbFSEdaoPNYkGxTCeB9m1IiDw7yUWj5rsJ9iH7iIAaTAat8A7BGFKN/kB/TNkv9hl
         mp4W/Nul1WNbKI2bgEgJDuSlJaY4LMyYFzhubDI0nQy5H/CgbNG/Y9hXsyWpMNhgroR+
         T3y0ITGUXcfBEL9ShAfbhyT9Oz4roVBZ0JCVDYkGmhi2c3H3d244Hzhm9a0ThK2iz0s4
         UnTb87YZsAMILvnHOYUSJTgGJmxZZci6HlsTk09K+saZqexT8O67fULOAAxsZEHZ4w4J
         snYj+enLxmHjAREH/7mm3UmBHU7Ct8+St5YzPTfPkJMe05cs4oLwFtuZyXTes/UECwpg
         3e0Q==
X-Gm-Message-State: AEkoouv+wuhOZeOX4pPpnf2xqM6TA/Y2YU/uutDs77TUUoUSbR8A2qTKdl5Hct0G0YAK3A==
X-Received: by 10.194.144.161 with SMTP id sn1mr21777172wjb.29.1469519329568;
        Tue, 26 Jul 2016 00:48:49 -0700 (PDT)
Received: from localhost.localdomain ([95.86.71.62])
        by smtp.gmail.com with ESMTPSA id xa2sm19746559wjc.0.2016.07.26.00.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 00:48:48 -0700 (PDT)
From:	Orgad Shaneh <orgads@gmail.com>
X-Google-Original-From:	Orgad Shaneh <orgad.shaneh@audiocodes.com>
To:	git@vger.kernel.org
Cc:	Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] merge: Run commit-msg hook
Date:	Tue, 26 Jul 2016 10:48:43 +0300
Message-Id: <1469519323-11420-1-git-send-email-orgad.shaneh@audiocodes.com>
X-Mailer: git-send-email 2.8.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

commit-msg is needed to either validate the commit message or edit it.
Gerrit for instance uses this hook to append its Change-Id footer.

This is relevant to merge commit just like any other commit.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 Documentation/git-merge.txt | 6 +++++-
 builtin/merge.c             | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d55..59508aa 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
-	[--[no-]allow-unrelated-histories]
+	[--[no-]allow-unrelated-histories] [--no-verify]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
@@ -87,6 +87,10 @@ invocations. The automated message can include the branch description.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--no-verify::
+	This option bypasses the commit-msg hook.
+	See also linkgit:githooks[5].
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..30c03c8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -51,7 +51,7 @@ static const char * const builtin_merge_usage[] = {
 static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = 1;
 static int option_edit = -1;
-static int allow_trivial = 1, have_message, verify_signatures;
+static int allow_trivial = 1, have_message, verify_signatures, no_verify;
 static int overwrite_ignore = 1;
 static struct strbuf merge_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
@@ -228,6 +228,7 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
 	OPT_END()
 };
 
@@ -809,6 +810,10 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		if (launch_editor(git_path_merge_msg(), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
+	if (!no_verify &&
+	    run_commit_hook(0 < option_edit, get_index_file(), "commit-msg",
+			    git_path_merge_msg(), NULL))
+		abort_commit(remoteheads, NULL);
 	read_merge_msg(&msg);
 	strbuf_stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
-- 
2.8.2

