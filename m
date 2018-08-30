Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9E81F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHaBqA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHaBp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so3415777wmi.3
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3tYb7lO8VBSDIXn6siX1Bhc8e9uh0K0OkeGjoKaNh4M=;
        b=a68fPgfl7rsvf38TphS4db/UIv57xNF/5+f7YAgQh+izLBgWG73RlI7fNAE6wF5R60
         L1PyBpuVBpJiFJCkwiDJEdKjeSx9AHF9OllKwm8XNSqcOBLu4uhw0V9AgQ2Yo+rjw4HS
         hH+JXqGwGUiGls30o/GQJG3SkP9yTQbFe6Dt026RBl5uFw84soqIf3Kp91TT3GoCoI/m
         7y2tqXykt/JFu2FftMhFwsdNb2yyuc2wvLIFVUCgzOp7GF0b2MQBaXjYeCbTVoAW8Guo
         xEdMfYtpy/+Tar3a4EXvrrbqVExrq4VJIRY7wDebYsjSX9ukYQzLzgbGCd8w27LhxWTP
         W86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tYb7lO8VBSDIXn6siX1Bhc8e9uh0K0OkeGjoKaNh4M=;
        b=TyMBayxEINgMN8wSIyBy4c506ryknj/x1Lr7XbI/OtzEvB0uJnr6Uadm1jA1NFmXgi
         dn5UDkAFsegl1JsPAqPC6UUiadmLQqeOu50yRkFomX/IwFz8Itrqa4fZxFr/MMJtHZbN
         Ww0m8xP0AivZJNA9/qeYyRzxjlajlV88oFEs0fLricV6zy3Vit5RVRnkHybtAJj97cb4
         KVUoy+RpvOsRzjJyvJyd+Z+wOOPenBo6vTXnN4kVI9wcu4mq28Eyg2VZlP1yUz1wgefi
         vb7AX665KRHyDCmDhEmRTRTU18JUpeIV71Kf/ePcvVVN2VYzaRgxAquOaLHK73wcanBY
         0mRQ==
X-Gm-Message-State: APzg51D7HfM9B4XHJeNL5+skH8L+xDVZbfrumGQOGE5SLvqbIZhqxLkf
        kOvvY1HW4D2ChFAg553w+jIFsOWk
X-Google-Smtp-Source: ANB0VdZ579yNL8qxqN0v/DTzEkB4kEZxzXxJ5zs1DywoBIQ8A4AWJ7cW6Uz3MGeKEYKq1CAf/w360Q==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr2759060wma.85.1535665306327;
        Thu, 30 Aug 2018 14:41:46 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:45 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 09/20] stash: convert pop to builtin
Date:   Fri, 31 Aug 2018 00:40:39 +0300
Message-Id: <dd9cfad6db6050333c2356236cc2ef5748e2084c.1535665109.git.ungureanupaulsebastian@gmail.com>
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

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 36 ++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index dadc028649..9fb1003dbb 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
@@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -541,6 +546,33 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0, ret;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+	if ((ret = do_apply_stash(prefix, &info, index)))
+		printf_ln(_("The stash entry is kept in case you need it again."));
+	else
+		ret = do_drop_stash(prefix, &info);
+
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -603,6 +635,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 29d9f44255..8f2640fe90 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -554,50 +554,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -655,7 +611,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.19.0.rc0.22.gc26283d74e

