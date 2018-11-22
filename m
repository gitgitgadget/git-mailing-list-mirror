Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E24E1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439038AbeKWJsE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35271 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439014AbeKWJsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so10660197wrb.2
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylwq10VyjIh8YISTHsyTBa06v1wDd70LuXQpDj21lIg=;
        b=He6/MTRf5CpMzMEMz/yjxaxoVTw7BV3JlIZSQ4neawlhHAUzv+0zn88nky5+7Dd2Um
         zjeMNKZQGE2x9uZluWb9p5IFetogc9qQD3yUzB29EfFRK9dpLmQWS95se1kJGRFxumTZ
         UXxBEaY2ypYJ6F0Rkr63f/AN1zhf2nXwNehOf+KHSSqQRJm/Q1bK2AeflM0TCzab8MDK
         rgD9r5MkYY5mqH14ayd+heiK9BqAacGzVMm3y97kq9qqPTac2mnm4r1isbPBcU3jo11+
         D/jA6HcM8jKhWjAjS30M8hwtg0n/269R2fUHa/Q0xGEja4Mp7uPBcZ095KlHrnsEYQVd
         CcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylwq10VyjIh8YISTHsyTBa06v1wDd70LuXQpDj21lIg=;
        b=ZrRPTMIHKiwvDnAgxC47b6MHmVo1v33TlpBFIHc6hSnHbsc1wxpqsm4GUZ8JXOWAGO
         zmZlM2riQmEx6nwkk5XBdNOXNCofTDAxP8E3vzw6LWftHSIagEubGpbozVOtENyrED7w
         EUZoo5+nskYWS9O/H1BpCzF0C1W0nq03yO2FnCDLXeLt504BPIOKJIeHiwO/46ydieM1
         w/lPIp+OcdIcItcMX173t/A1J/9AwcbAAvZTiFh/iIF9IaoRRtrE3/SG8yrPnvJYXUKf
         ukwav5x3qr4U8y5DO9Fr63/anL4Zy16dwE+r4ODhWVAMB9qnPzuMz7Nb/iwmKp1ZwV8h
         Cl/Q==
X-Gm-Message-State: AA+aEWa/JHfBXbYd6aTSOJr3vQRqYLLsesz62mlGSsxReOEQJUwB8QWb
        pWEIg5V5t4GyUw07UvRAp/04ciNu
X-Google-Smtp-Source: AFSGD/WfotBi8aZ0ooJv8k1iqnYUbKBOm0wc194eVUIWsANjj5X58+aSNJENu3H8JbvYqKp2Uo+CWw==
X-Received: by 2002:adf:9786:: with SMTP id s6mr11433586wrb.283.1542927982872;
        Thu, 22 Nov 2018 15:06:22 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:22 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 11/22] stash: convert branch to builtin
Date:   Fri, 23 Nov 2018 01:05:31 +0200
Message-Id: <a91425232407f513901adf1711981b41e73bacf2.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
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
index 07b8ec5bcb..68b65165e4 100644
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
@@ -537,6 +543,44 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
@@ -563,6 +607,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.1.878.g0482332a22

