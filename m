Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7741F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeDWTpT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:45:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44972 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeDWTpR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:45:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id o15-v6so44424698wro.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bws7Qb059c9xUUxni8CKRiIupa7k5hEWEaMub/tEK7o=;
        b=OBS+YlEKFQZHUT23/egF67+Ws8X4sqVSP970hvRsM1KAdlVP5vsVfVhPu7a+8C71JN
         sSfUY/ekhlDtWgTk4BG2iaVpetEinxW1M53/0q0/yaQbXj5AZ6QJ6EhXcbYlxVJCG11h
         iolSPadmD38y57efDibjaRdX5siiM7RyKquK6cqIW/z0DEVPxP3lHHrAPzgF5QKr5orH
         2TWKqlTv+nHgOEmuD9Mebcj3OHSLsR/XzlP+0sYhoj3f9+Vo9Ae8O/aKskvTgxfwEzhz
         A/vSGXn8DUqX05vTmmvo55rqoyfOo/551tG25RjuETsJzelCnA9BLMDmgXZRpefc6Cep
         BCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bws7Qb059c9xUUxni8CKRiIupa7k5hEWEaMub/tEK7o=;
        b=gm6FQjjZQpxuLTwV8C1zA13HcThLvFdxlU2xpcYm/3YP7IkP3/bFVJhsNGODddOOxI
         /Ob9C7IqSEUc6QvWNFQsUy8BKplnUGr0F+hnhLo8bJS3dcpzS9/iMeeQuag/b0GJIp6w
         NoCt7fPbiu9EzMOXuLPNv7JM+p3WNSUUaaG4IKeq9vLWDDNw4KYoJTzLtsUh7RIJVVQh
         yh7hp7LvFF3SfzKgdMKGC9IV3YWWQDOo4Dnu1inK0COaHNAfwateJ1l/cMR2d/TdEiC/
         B7BqZYFidXsNt8wYazmBy4B25JWyRI6DRDlXJjJBxdQTYwHhCaPMX8bqp/BIdhOc867W
         v4tQ==
X-Gm-Message-State: ALQs6tASW1rrxaYVCVjSw8bp0FPq+7pTxwB3bCr1PC5qXUR+y9IkF7Oz
        2XznkgGMpoN9d5TqgMIbMgCow8qN
X-Google-Smtp-Source: AIpwx48GnVg8DHVYfn7kv5/MpUPRU5xxZJLQdjPEE9T1+qTkCX9TC3j7QfVJRwFqtK/KFRjGAezoaA==
X-Received: by 2002:adf:c003:: with SMTP id z3-v6mr17648107wre.177.1524512716115;
        Mon, 23 Apr 2018 12:45:16 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v111-v6sm15269181wrb.30.2018.04.23.12.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 12:45:15 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 1/4] worktree: remove extra members from struct add_opts
Date:   Mon, 23 Apr 2018 20:38:45 +0100
Message-Id: <20180423193848.5159-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.74.g7afd1c25cc.dirty
In-Reply-To: <20180423193848.5159-1-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180423193848.5159-1-t.gummerer@gmail.com>
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
2.16.1.74.g7afd1c25cc.dirty

