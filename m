Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B941F404
	for <e@80x24.org>; Sun, 15 Apr 2018 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDOU3R (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 16:29:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33209 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeDOU3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 16:29:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id z73so20528601wrb.0
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mzo40x3dX51Tk9S1GkEn+gpowvF+/WvFCc2Oyt83IDU=;
        b=h3Adwy/BgeYuv1cX2eJQ4XQFj0l84zduaoz6J/qqtLo1xrPXZ/d0rQFEshORQFHU3F
         x1a7sQcMEZ6gTYsiA/cX1RCuUwCkLXJSWXCGV88NWcCT2gPRqZW62pX8DXEHHOA2w8f9
         ibsFbVVwOBFJJI91RgjLVW83oBf6wTi49mpcC3bbe2WL3qmiUnfHjO3Iir/7EGe3OR3y
         cjVMWAPOxsb9Qzrhg54tSEmwjpv2286iR0z9HCm2Idmo26+d0xD9OeWXbkOh0ZiaaFD9
         ZwLGhaCLD0bWT/R1tN75Jk7ilu+kJ6UJkA3P6y5Em3+ZsWcCifb0dyeFg17nYrigxh6w
         jFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mzo40x3dX51Tk9S1GkEn+gpowvF+/WvFCc2Oyt83IDU=;
        b=lmYA8b1tlcGLN2l3TrTh/Jr2La2OuLv0prNXCBFVatzH5SMPO6UzyKodvZ67dCGtxZ
         WTDLFXZqpqEb0wBrjqm4R1QuLMNNU2wEnNiYjlJLMo0h0mtDorWCO9prswmjTMd3eKOK
         B3JoV+civ4+xLnakgMiQUrcXQWp15XutND7zCaPcXbuBP04J1bt/IAgFcmnwKgDpAJZK
         7uLp/tr7lDWIRLmns0f7Hq5DRQrtUg35jNIrLi15E5c/diA+79ReyuoUKvEmIutEHjww
         rX5/+DkcHHJ4eSVxU809Aezobe4HXxVJ70bPtqrS5vRWZc+lI2OE4st3nxQft2Jiilao
         aUWw==
X-Gm-Message-State: ALQs6tBOJ0JcWWLOfaN0YDAcXXeP0CKRL7HfDzSGvbA8zxDLZTydFSpv
        N+YeXScQ+rMdatNsxLaO4ommwBXM
X-Google-Smtp-Source: AIpwx48tnRqPJqYKMm0G2ijqHfY1SqelWaJHYhMtjKAa2TCNJpL+w+rdUV+XEIZhR2stTHUW+RZGcg==
X-Received: by 10.223.139.199 with SMTP id w7mr8771535wra.230.1523824154343;
        Sun, 15 Apr 2018 13:29:14 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 71sm8120797wmg.11.2018.04.15.13.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 13:29:13 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 1/4] worktree: remove extra members from struct add_opts
Date:   Sun, 15 Apr 2018 21:29:14 +0100
Message-Id: <20180415202917.4360-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180415202917.4360-1-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180415202917.4360-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two members of 'struct add_opts', which are only used inside
the 'add()' function, but being part of 'struct add_opts' they are
needlessly also passed to the 'add_worktree' function.

Make them local to the 'add()' function to make it clearer where they
are used.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..4d96a21a45 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,8 +27,6 @@ struct add_opts {
 	int detach;
 	int checkout;
 	int keep_locked;
-	const char *new_branch;
-	int force_new_branch;
 };
 
 static int show_only;
@@ -363,10 +361,11 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	const char *new_branch = NULL;
 	const char *opt_track = NULL;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT_STRING('b', NULL, &new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
@@ -384,7 +383,7 @@ static int add(int ac, const char **av, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
+	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
@@ -395,33 +394,32 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!strcmp(branch, "-"))
 		branch = "@{-1}";
 
-	opts.force_new_branch = !!new_branch_force;
-	if (opts.force_new_branch) {
+	if (new_branch_force) {
 		struct strbuf symref = STRBUF_INIT;
 
-		opts.new_branch = new_branch_force;
+		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !strbuf_check_branch_ref(&symref, opts.new_branch) &&
+		    !strbuf_check_branch_ref(&symref, new_branch) &&
 		    ref_exists(symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
 	}
 
-	if (ac < 2 && !opts.new_branch && !opts.detach) {
+	if (ac < 2 && !new_branch && !opts.detach) {
 		int n;
 		const char *s = worktree_basename(path, &n);
-		opts.new_branch = xstrndup(s, n);
+		new_branch = xstrndup(s, n);
 		if (guess_remote) {
 			struct object_id oid;
 			const char *remote =
-				unique_tracking_name(opts.new_branch, &oid);
+				unique_tracking_name(new_branch, &oid);
 			if (remote)
 				branch = remote;
 		}
 	}
 
-	if (ac == 2 && !opts.new_branch && !opts.detach) {
+	if (ac == 2 && !new_branch && !opts.detach) {
 		struct object_id oid;
 		struct commit *commit;
 		const char *remote;
@@ -430,25 +428,25 @@ static int add(int ac, const char **av, const char *prefix)
 		if (!commit) {
 			remote = unique_tracking_name(branch, &oid);
 			if (remote) {
-				opts.new_branch = branch;
+				new_branch = branch;
 				branch = remote;
 			}
 		}
 	}
 
-	if (opts.new_branch) {
+	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
-		if (opts.force_new_branch)
+		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
-		argv_array_push(&cp.args, opts.new_branch);
+		argv_array_push(&cp.args, new_branch);
 		argv_array_push(&cp.args, branch);
 		if (opt_track)
 			argv_array_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
-		branch = opts.new_branch;
+		branch = new_branch;
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
-- 
2.17.0.252.gfe0a9eaf31

