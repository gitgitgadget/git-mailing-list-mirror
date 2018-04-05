Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636571F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeDEC2a (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:28:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39432 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeDEC21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:28:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so17024353plq.6
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufUNIn5y16AfxXPYaiKnmewCJQsM5SAEnreuGHUx5bg=;
        b=X8FtPQ0u+bxbnmvFmf6+arj+NhasWUhklX8P0S7D4iY2CQ/KscJ0tLak5Q46//vQZp
         ELEwWSVjOOXIDP3UvyqWufVbm+L+YYPa96EWlYonq/I3oZG+oOQ58/P4VO6T/5w4NMfq
         E9qwJNVonYO9dLXeHlvTOv43VmLR1KUYtv58W3xFIsFjL1TXr9+J1yBzaWDZt2KN1Cc9
         6Q50yJSXMcqhaz5HQ0iZxAY/RpmJy5j4feo7IWzWsA/uya67wGGUBagsl4Ba5Ug1Q0NX
         T9XymSOAih4berrtfSGaafqu/1bHlufRMpCVMkVl03393LcyQRLLLXETGG1pf+X1bLT5
         tZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ufUNIn5y16AfxXPYaiKnmewCJQsM5SAEnreuGHUx5bg=;
        b=hU78yd2Ca7Ck6cdKImyyFYHs8uQAfP/uiku7Sn6xT8DzlEukm/znBHwSri7LD6IMXR
         S548Yj2MGIxxHeyQ37gaS6Y/cgpCiw6qLzuiix7sv/AULHmvs3eMevbN0uiNTY9NKFOl
         +YnA0EZ2YZbLEwNSn3lKMAGZ55lP0nxAdemIXuoS8S1aP0KbcIZzmQ8TBW8irRzsCQjS
         UhNrgma6cpU+0CALXofti1hhNlScxO4Qz4aXzRkkg0AtFc/aVOHNHU4wpI3JC2wiGqcf
         LmfjQ4tc/jXv3+4e9OC09D1OElbMFdt5E81SkVlh2VpOyUzh2289Apv65Iz6omqbP3/f
         /jmg==
X-Gm-Message-State: AElRT7HN+sEy7b1Abqfm2ENkuQEH72c3n8z/SjB11SrtwJXW1iU+lDqO
        sVpKgYpyxBPq//HLT99/Wkw/0f8=
X-Google-Smtp-Source: AIpwx4+TlEhp3fXRUdkb4p/i/7xqt8gYfgU3UgmysNpiSmTLD3usspBrBE2V/BjOlo8T3CQGTf8jiQ==
X-Received: by 10.98.137.218 with SMTP id n87mr15826670pfk.48.1522895306345;
        Wed, 04 Apr 2018 19:28:26 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id 86sm14194093pfh.93.2018.04.04.19.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:28:25 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v5 4/5] stash: convert branch to builtin
Date:   Wed,  4 Apr 2018 19:28:09 -0700
Message-Id: <20180405022810.15796-5-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405022810.15796-1-joel@teichroeb.net>
References: <20180405022810.15796-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash branch to the helper and delete the apply_to_branch
function from the shell script.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++---------------
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 520cd746c4..486796bb6a 100644
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
@@ -502,6 +508,49 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
+	/* Checkout does not currently provide a function for checking out a branch
+	 * as cmd_checkout does a large amount of sanity checks first that we
+	 * require here.
+	 */
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
@@ -528,6 +577,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
 	else {
 		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0b8f07b38a..c5fd4c6c44 100755
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
2.16.3

