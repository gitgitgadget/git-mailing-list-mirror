Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32411F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHaBqA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35248 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeHaBp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so3452398wmc.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8CkTqSmQ4TKw91McjxgIPG6A5mUCY6hsjuaA1OOsYWI=;
        b=Gq/BBCzsOHric6XgYWVw0DJzwQrJVvS2iApqWuRM30TfD1lPuFu64cF1kliCVs0n4e
         ZoButk3KVoD8jP8/MK2DasjcrC0pVckRy1WXkTcRTGf0ybZcCNb1/psV2rPiByLRHhd4
         Dt8K2Akbnkgt4n4Z6IgHCH+7SKhM+RWFFn0WBeAzm6FFfLG4JGfDiOKtjPMOOoewL8NY
         ncGc1cVRsl38lZIh/p83BdnDdDuD7Ksl0ep0xkfsRjxf82qnolCbqTUQ34FX1LhlHBMT
         wZRnzfwSkt1+Nz/13cZZwqd3C0wbbkP2MepN0MfeUA2hn7MSpBhr4u6p35OvIlda3lH7
         RN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CkTqSmQ4TKw91McjxgIPG6A5mUCY6hsjuaA1OOsYWI=;
        b=LeTK6X/4U/twUT9vSSo5hRwhXNZxfqFKTcH+kjv855G2wSHLWIU92ixf5BFY1sfLuj
         KwQp1ktkzQTSQcpw2uBaCDrA1un6NRPBaecfKhuAMpUAgxHM/X6TZtHiyzyom+Aa3pLI
         mBO7rr7Jv8OcN+05AnQI0DJ5gGwkFJpXFgdy0Eh8Z+tyWGYf+Q/vJf/UD31l1NxAvlmM
         yDZGT3pRHQe5SsObOW00hQd7X2u2b/pTjzE7VjDRic5MNFNDkYe/JA3aqCsWmI0bJwNG
         Q8c7a0qtYRrSzSxDI1k74iu4lVDSTDrzfoQAhuxM19saJ3UhEXX4ClYSWqS/LTdBkCxw
         KQXA==
X-Gm-Message-State: APzg51Arj2qgpIlrUXbeV1MSIe9uY4lBH2QcsV9kSMyz0ACWA6YFq+zZ
        KgecvgxF5lqUaXD3GkAMf6Oz4Qx2
X-Google-Smtp-Source: ANB0VdZSmH+60IVlx6PQDBzRUXjJPUoJrT9kflCVJloDfeaVezNL31WJ9gPjYE0KhQula7GUUJ+m7Q==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr2908353wma.63.1535665305436;
        Thu, 30 Aug 2018 14:41:45 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:44 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 08/20] stash: convert branch to builtin
Date:   Fri, 31 Aug 2018 00:40:38 +0300
Message-Id: <ed6aea4eb1e60dfe5c77ce8c9bc9d8409b658aed.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index cbe23fef11..dadc028649 100644
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
@@ -535,6 +541,42 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *branch = NULL;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_branch_usage, 0);
+
+	if (!argc)
+		return error(_("No branch name specified"));
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
+		ret = do_apply_stash(prefix, &info, 1);
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
 	pid_t pid = getpid();
@@ -561,6 +603,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.22.gc26283d74e

