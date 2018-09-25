Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0355C1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeIZEog (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33933 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIZEoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so209880edr.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4u0dFBNQm59Toa3wXWRgraEGh88Vb68GW6Y4gUOVVYQ=;
        b=T1EcPJud3NeHJCnC6PIDQX46UqrbOJ+0VmHf6yD0Uo1pkx2m3RS4SfD9ydv+ZNdLkC
         8yC93pO5vmKcQ3t/2W+mcugl1n9RksIpq2NTqrxHWj+q9HwGRYUwYuvH4rqgu5x8247I
         XhrKFuoTWviSjKRY1PQll4z1vGbzhpMYhtrIx9VKI6q6E0BH58B+TTyjMsEnPGQJsSeG
         bNcEKGiG+ssAvAu7dwLzQFTKHpNU6OXAjhoDi9MBGJMPCn6+mGTkM7QfR5lBnwzouf6P
         M6lCBj1WdeMl/RKMgu5Zr8r9/BiSAv4aoP5eMhiKf7iaS+m1ogHUgspt9DhxpEyXX1q7
         yw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4u0dFBNQm59Toa3wXWRgraEGh88Vb68GW6Y4gUOVVYQ=;
        b=SOmPtCB7qZTKL1UZjr91L+259jqPAU1eoyjJQq1n0QqQ8Ob1FPSxdtPkq3+HO5nhDf
         HYx3bCHTpz9OA8nf61k/qj6s1ffH3dpbpapqmQluww+iy5aVHLxlx0vPZ7GMsTb4jgfz
         5FNc0WZO3zqmseDAooi2h1Rq+PUUCBeAL70RHOf5BOfU6P5VW5dwOtIkXJp+bYZPFUag
         saIzr5TtbvX8tiNk1CvgvdmvLAPW+Y6hoj7yPHUmMl3cR/5pFxFGxlvm7CZir0bbpuRu
         VfvoHrWDrf45ttZId421vl3JHMKgAxWIszFtdpn59GxZQJa6IutnExGrjFzwinZuvNJS
         2HYQ==
X-Gm-Message-State: ABuFfoiFEfyQzMAXObWSST/GksMIVA4SPSchWosi5LHzO5IMA7ywOhzc
        4k/6ut2ypTtzIMojQwOpSGAgOajC
X-Google-Smtp-Source: ACcGV60whenGjpFZPJjCnJaj0yxxBYGV/pDCkeUHoZgH6zGyB1EBMKwDbmr/mpaWLB1tGMIbO+h9Hg==
X-Received: by 2002:a50:e044:: with SMTP id g4-v6mr1363624edl.152.1537914872536;
        Tue, 25 Sep 2018 15:34:32 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:31 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 09/21] stash: convert branch to builtin
Date:   Wed, 26 Sep 2018 01:33:25 +0300
Message-Id: <f7b639a7b4da943884f7a4960d06ec4d2344a119.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
index 72472eaeb7..5841bd0e98 100644
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
@@ -536,6 +542,44 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
+		fprintf_ln(stderr, "No branch name specified");
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
@@ -562,6 +606,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g1fb9f40d88

