Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5901F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeJOFzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43829 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeJOFzq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so16060693eds.10
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBf2t8AWfkJcR9byiI7A5qymBMgyk68VCmOAHf9XhIA=;
        b=rqGD370UAlBI1UU4GdJPJwKmwnRtg0LpGsAtaBeDjsa/oFVNbBFHP4IVJ9/dy2ouLp
         lJ2SJP1yo3t9ZggRRG78/dfYAGxGwKbd6jusfrKcWc5P1n1zK4JcaFVzRVPTb58VwRE6
         HUj1Vb2j0x6gIkILLrfPkiOXaYylu3ajIa+RIGenZd5X2sb3w9jrBEUdaXP+eb0Hs9zB
         gSbX4H7CtUXSovXTFDLyJGjfZHFm5Cx+mxd5EgxKxhgnfzDas7eu+NYMFNqcwxhd722k
         dacvWyf54hYrrdCcjfzoJB6doDv7UUPs+U+qHeCmwDH3E/shiZ0Jl6fCstg5/yJc3KF6
         kBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBf2t8AWfkJcR9byiI7A5qymBMgyk68VCmOAHf9XhIA=;
        b=hSVS9fCboXK9j7El0/X+gwIX1MrQK6t7thqudm7dQ/MPkb7heEY3Bcl9MJ6X7Lkoi+
         NtXkgiBUKhm/JUmPc3Qk2Ynsb1Sk/GI9NwQAiyWzdf0cURzA435WZd0msKQMMdEc1fQP
         qYT5Pqfn07qy6lVJp3DlPUpK0hB7/s93LIv1iqo2DsxtxkuXaRz1Y+KBWop7WxHtVsQO
         v81hiuuogrriZVGHpLzPRr74vwpdp9U72lp2WH6tYuZyuIiiHQkkeF+9wgyVi5XVHZqJ
         Agmk1QpCV0VwEeYqnAqtlwZ3OtrldE53FTWMrkozRK4H7Sn0cUzbV3zrBAA+Vr7FLt22
         75mQ==
X-Gm-Message-State: ABuFfogssVQI/JJzvB9aWp+o8kBIkPqBg3SAoe4C/nxHdDI5QT8nHi8Y
        5ekz3fkCb+CtkYJm8VBHrH2Dw4OH
X-Google-Smtp-Source: ACcGV620C7O5iIYvw2qPuExzbRncm612p1QKpHrHEsTqTYyVM1VvxMjMeyf+1lT0/5hBP5iscp1AIA==
X-Received: by 2002:a17:906:d55a:: with SMTP id gk26-v6mr16589645ejb.209.1539555199360;
        Sun, 14 Oct 2018 15:13:19 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:18 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 10/21] stash: convert branch to builtin
Date:   Mon, 15 Oct 2018 01:11:16 +0300
Message-Id: <ab4ac449dd1b2722248d5b542c0b4cb1874306f6.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash branch to the helper and delete the apply_to_branch
function from the shell script.

Checkout does not currently provide a function for checking out
a branch as cmd_checkout does a large amount of sanity checks
first that we require here.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 46 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++-------------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index aff6cda4c9..c41aad7036 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -14,6 +14,7 @@
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
 };
@@ -28,6 +29,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_clear_usage[] = {
 	N_("git stash--helper clear"),
 	NULL
@@ -539,6 +545,44 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	const char *branch = NULL;
+	struct stash_info info;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_branch_usage, 0);
+
+	if (!argc) {
+		fprintf_ln(stderr, _("No branch name specified"));
+		return -1;
+	}
+
+	branch = argv[0];
+
+	if (get_stash_info(&info, argc - 1, argv + 1))
+		return -1;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "checkout", "-b", NULL);
+	argv_array_push(&cp.args, branch);
+	argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
+	ret = run_command(&cp);
+	if (!ret)
+		ret = do_apply_stash(prefix, &info, 1, 0);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info, 0);
+
+	free_stash_info(&info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -565,6 +609,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		return !!branch_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index a99d5dc9e5..29d9f44255 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -598,20 +598,6 @@ drop_stash () {
 	clear_stash
 }
 
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -673,7 +659,8 @@ pop)
 	;;
 branch)
 	shift
-	apply_to_branch "$@"
+	cd "$START_DIR"
+	git stash--helper branch "$@"
 	;;
 *)
 	case $# in
-- 
2.19.0.rc0.23.g10a62394e7

