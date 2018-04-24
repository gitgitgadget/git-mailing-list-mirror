Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152A21F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeDXV5O (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:57:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38992 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeDXV5L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:57:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id b21so3317328wme.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJd0sXfWin10YKW/Wl8fqPgrCuC/o0xFodTWnrNKix8=;
        b=mpxR0gYjCiw8ReFxOO42f0a2FCDfwiCNUHK/cr8KSw/9qrcZDUe62vP62OGWziL4hU
         TFmD27wBmF1oRiqFWlhCcw7Pf1C56oHzOyUo+V1PQbZo1Rk3Nm5obcY6c8OAipjB6fOC
         w86MksUrxtbV8aU/OeJiTWlzDnFklAR801W/vUtQlmWQ2aNIF4Ptt4vBuKTWkAXapI6x
         TxuMl6kKBMLabIqQEsakC2ZX1QEtxBY6pCV4Qrxs9Oawo8kCJmVmNzAZrzqkcxHKLnU8
         c6ituFVL3BrTw3OZfqWFQgCi7mv/cxw6w7JPXxOSuLBOT5v4XkSbGsysZLLVGUQwLDzU
         rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJd0sXfWin10YKW/Wl8fqPgrCuC/o0xFodTWnrNKix8=;
        b=hhYGhvC0MSb3KtOR+wMfrsAytAwAfYpkmUlFuuc8d8sz/5axvIUIwqFrSxEox99APl
         H0rxf7nKu8nyT9hJ9hTLi59vFxqkZN7DyMfHvzHG8H16V26vLE6nOnJBlrrksVS5lojr
         GQUS4fqARZAfPhwbVnVcpgZa8YiRJ3NGgRv85JGjhbmdduAwre6VStfNIdNinONaNslC
         Abn1huchrw7sQHflSLR3lsg98YqXytoFfi0KgrgoAdcHrvV2iZcqQ4yb75/XIjW95RXB
         wxCr5x22Ab6feDpZb5+wGoHXo90cw2jNhP4SFV8gOOUMgSvsrp8DHm2TF6zVhBR+aG8m
         ZHKA==
X-Gm-Message-State: ALQs6tCfe8mboWg35TXNURNg0gngrI3XcHzr6NzJg/dTJYj210Kp3HWq
        +rwu1Gk5ATj6VJAqgHoE9a+ZlE9+
X-Google-Smtp-Source: AB8JxZp3Bu6MgGL9XIdAJe9n7P+75pmNIQrHuK5GELfRBjlYtzYj+0r+7GUP1ue3bpYT5xp9BYWsag==
X-Received: by 10.28.176.194 with SMTP id z185mr12672010wme.45.1524607029305;
        Tue, 24 Apr 2018 14:57:09 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m15-v6sm5269718wri.8.2018.04.24.14.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:57:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v9 1/4] worktree: remove extra members from struct add_opts
Date:   Tue, 24 Apr 2018 22:56:32 +0100
Message-Id: <20180424215635.9183-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.76.ga910c1dec4
In-Reply-To: <20180424215635.9183-1-t.gummerer@gmail.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180424215635.9183-1-t.gummerer@gmail.com>
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
 builtin/worktree.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..bf305c8b7b 100644
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
@@ -395,33 +394,33 @@ static int add(int ac, const char **av, const char *prefix)
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
+		UNLEAK(new_branch);
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
@@ -430,25 +429,25 @@ static int add(int ac, const char **av, const char *prefix)
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

