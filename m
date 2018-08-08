Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8C71F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbeHHVUZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52203 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbeHHVUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so3822581wma.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jn/jLoQdmy19dGum8B9OOSKvjQxvJz0GRTMk8POrRUQ=;
        b=CWKpyAJ+fev+jynq6rBSopfBgPsBwJYm6YyIAMYnLUwAvz3nqyOxv6Z0psfWWi7RqL
         X3KcVxNFXbwr+fKkJaQ9Lv3SpS8RzlTWmv3dCeMUVMycdw8yDLY4eAwfKigpqNwWD5tW
         wxnPXpBBVaXTuG5gxKt8t8bRFZhcZPbGGrXXGZfwNttKT5er6AwD7MosLuOxJx1vcFce
         +V+cOAyHjLkR3QW2ZyZU+vyeGslbS3yY/qyFeGiMXKYhMF9p+sM6tEYkmdt2Gd+YnM4l
         eobuL6b64AN4iUcOMIYfJOX2Tujux5+A5zjGGPivCu+YtUhUOJ15Y81Wetav1Wa46uZ+
         TfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jn/jLoQdmy19dGum8B9OOSKvjQxvJz0GRTMk8POrRUQ=;
        b=lceBUZcAEWV1fo4j94g7Rm4y3Yx31+RHcYkBWEku6CTf74qTo4b0fDm8jQ69eYyheW
         QdeK7YjgUOB766mymOwzO8yf00Zx35FTducVZf8GjjLI9WMUJErDKw73wgmSgSi1fsJy
         3ub2a7BXY5Wyj0irH6k1Wx6fXnq1HbHCHxwlaPUtylPNXEUWFtmHdUpDcsue8TUsmEOs
         qsAA1p+Vp/ARvQRd9vmpPX0iNrqijpJPHMH67R0KFyv6UL6+V/fIY2WDwE53U7MtPQqP
         mUkRJac3t0uJgBV4Wsl/zBOYOkWH4ogKPRxrD/DqsTNZweGfCyf8Lniyy/LPOebuS40l
         SgNg==
X-Gm-Message-State: AOUpUlHcIyuTGnl+phXnBEkU8HbvKommmtEDQeRKHqqd99U+Jt/vaC5A
        5khZXlrUuTY991q9CTID28YNHg8H
X-Google-Smtp-Source: AA+uWPzTEuX6TS+UB4r1lz4ELbu8dlSeIpGaAMxV81q74LGDoII9wfZkIbw55h1zO32fY28zOMDlNQ==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr2545759wma.128.1533754762421;
        Wed, 08 Aug 2018 11:59:22 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.21
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:21 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 07/26] stash: convert branch to builtin
Date:   Wed,  8 Aug 2018 21:58:46 +0300
Message-Id: <ee70cc83b9b57c43672cfa5065d3c6156d089d92.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
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
index ae719b7fc..1e4d07295 100644
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
+	if (argc == 0)
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
2.18.0.573.g56500d98f

