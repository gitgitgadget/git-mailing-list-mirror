Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DD31F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeC1WVx (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:21:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33247 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbeC1WVs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:21:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id i194so1726819pgd.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d59pyA2KHtQJ1edWJs/PoDRT68sQ/gvHfTO5Nr4ZvCA=;
        b=f3F3JXpx8MW9jJzoRf2UiLPvyxkR40uCp9vZG+pjjsH8sS8cMTb09/0xcZkoi7KZab
         j67Rz3nGjHip6rnZ5bcj7q2IMaU7NaaZsN0yEGbBIRD4tiEhGreyAMIA5D6GabqCp8+P
         HlDWxG7xHVmwKOQ7MKshNK+95OAH91FIYzd+nQSd1pRI+MtEID9oufRfo3diIqjh3U0H
         WE/S7KFuPq9I7h5J+BBuq9BAWYUuQUgPRIjw2cz5DTsRBcWAhAMx5baSxvmOS58CBQ8E
         f1weYiW1Pl5aAAq5QZrNSc2h7WzkNlzwPTwORzUK8/x+DWuIOK7Ttn3hivXseorxoWKI
         Q2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d59pyA2KHtQJ1edWJs/PoDRT68sQ/gvHfTO5Nr4ZvCA=;
        b=PKDdkl3AtxeAvuZr71UWqwSwfsYYEO2NL5g08/dosidPeMv54XFaiGZaiHc5r0oLp2
         FgnWwBPvowkHLgJRcfPAWpO5gx1dJJEmKH0AbebdBdxfSMWG9wWpCGUAC5GdXbJvc+xO
         Epqq4xnPCE6gsEZmnd6NDERll7I7yjsPItMe5cwQi7dB5Um7mbUlvqRrzCAusBsAboKQ
         0JAYS8d8q8u1pUe543idXmiU+9V2BNyHAoGQJm5deHrUnFrRUtZ4gHBbT5881ukMAKLt
         0k3kLIQypNigy1/f9XAhz6ahFliZRvZd3qLT3t63DmHbdM5Niz7INF5imlKtV+PIfEJe
         Ad7A==
X-Gm-Message-State: AElRT7EHj2u3Xjg/FG3XJezPIPjAj+XuWgYxFKW3wo6Kch44tiVwEjdL
        yIYaRUo8t0BALT51ENOJiG8U2Ak=
X-Google-Smtp-Source: AIpwx49jozceGEasiSfNyBisE8p7VTyG8Bk1XIl8/bgOGhKCjlHQVyVjeiO4uqhJFsmjMzzGjrVfIA==
X-Received: by 2002:a17:902:64cf:: with SMTP id y15-v6mr5625446pli.49.1522275707357;
        Wed, 28 Mar 2018 15:21:47 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id e23sm8801907pfi.76.2018.03.28.15.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 15:21:46 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 4/5] stash: convert branch to builtin
Date:   Wed, 28 Mar 2018 15:21:28 -0700
Message-Id: <20180328222129.22192-5-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328222129.22192-1-joel@teichroeb.net>
References: <20180328222129.22192-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash branch to the helper and delete the apply_to_branch
function from the shell script.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++---------------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 640c545f5..51fe8cab7 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,6 +13,7 @@
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
 };
@@ -27,6 +28,11 @@ static const char * const git_stash_helper_apply_usage[] = {
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
@@ -509,6 +515,45 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *branch = NULL;
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_branch_usage, 0);
+
+	if (argc == 0)
+		return error(_("No branch name specified"));
+
+	branch = argv[0];
+
+	if (get_stash_info(&info, argc - 1, argv + 1))
+		return -1;
+
+	argv_array_pushl(&args, "checkout", "-b", NULL);
+	argv_array_push(&args, branch);
+	argv_array_push(&args, oid_to_hex(&info.b_commit));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+	if (ret) {
+		free_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info);
+
+	free_stash_info(&info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	int result = 0;
@@ -535,6 +580,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
 	else {
 		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0b8f07b38..c5fd4c6c4 100755
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
@@ -672,7 +658,8 @@ pop)
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
2.16.2

