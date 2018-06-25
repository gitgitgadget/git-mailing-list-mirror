Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766D41F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933716AbeFYQnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:43:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37508 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933282AbeFYQni (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:43:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so14367094wrp.4
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBBrkdZoZVPG64SMzfRWtU1KZZcLEGMjo3w0YjWJ5Wg=;
        b=qN7UxC1Ztv+P2Z54xrQKwm0KWPCu6qZ9CRtXpoZYJPLzTQ3DupX3UhsCyyJ5a/TN10
         MBJrW7xSAvTlE/Al8bZp2uYeVIJWcki+Yszb1+N0VwPoX1OxGat21Hf/jpsv+UcwS2IB
         fMsKTrVG2JAOIoAGLzsfy3AxDQYGQQkH3zwxZ/FB3l2B8j3lacGGZiQqRedQOFJvlL6H
         VyJI3aZH734CPfGWHzGxCpiKOJFXan3DdFcqp2D1WthkMaUqzect1NTmIjcPXOT4uTFP
         Ot5BBa2R3YmFRpo4GA7PL4ITKCbUZjS0lYhfTTwLjX9jOOb0qgI70/2GFTpEV/7FsYCi
         0ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBBrkdZoZVPG64SMzfRWtU1KZZcLEGMjo3w0YjWJ5Wg=;
        b=GtBbCCU50sLQ8AgRS+9P7QEcCkeBUu0y1UBkYSLinZOST5OLTRYLMmbOa3JXQSuA8w
         OBRq4OTqG9FcqhtH9ZlyPIxK6icFvmDkkX9mEetVS1W/zYOklsjKp49eXNenIrxmdDU4
         rGWAGIXQjRVyA75X7jX8HXR5NCQqlXnbN4fBAXdfMpHjAohhdnoyN6FVpRgF1jMbO3BG
         Lp7Zj9r7zCuKT5MJh/PmGzB/leOKLL0d6U3xFUPsOtosKFcsOUDmqp/8JmRc6tbEDfqo
         GzvS024ALdRu02AQbKEqk0oE90iF1MWG/MMuQhpvAqaUOcWUArFGKC4d5llfILRLZwCZ
         oaTQ==
X-Gm-Message-State: APt69E1j/zlxn/H0eK6xoBLH4Mf3+Q1tdv+Gky694Q0aZKpD1p6fsiEi
        l8yIRe1/vu1Nn+DIVtq+ioQp42Io
X-Google-Smtp-Source: AAOMgpdBZnrHJWVyPWN01ziTIL03JPxQI3qpaGRJcr4yzlKY3QEplW+JNBwSqNDFRlitLBBhdHHtBQ==
X-Received: by 2002:adf:c7c3:: with SMTP id y3-v6mr10801928wrg.230.1529945016958;
        Mon, 25 Jun 2018 09:43:36 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id b124-v6sm14287200wmf.11.2018.06.25.09.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:43:36 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 3/4] stash: convert branch to builtin
Date:   Mon, 25 Jun 2018 19:43:25 +0300
Message-Id: <ac0a24da8a583a137176d1d215df65bb1a3ada0e.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
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
 builtin/stash--helper.c | 43 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++--------------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 84a537f39..fbf78249c 100644
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
@@ -522,6 +528,41 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
+			     git_stash_helper_branch_usage, 0);
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
@@ -548,6 +589,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		return !!branch_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index a99d5dc9e..29d9f4425 100755
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
2.18.0.rc2.13.g506fc12fb

