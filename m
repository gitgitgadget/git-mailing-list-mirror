Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD281F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753809AbeC1WVy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:21:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44876 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbeC1WVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:21:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id v26so1715168pge.11
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XUHjj70cowKreOXDH5PAdqmM26n2/xW5aaOtFMYCm+s=;
        b=oTLhsJiVnsXFoiNv1HfIZ6eoEG5P+81Ax7rJ0oDQAn5MUxSYqceyjq7mYkHtNw4vx9
         Ny85fBdze/I49sSnPvht6pMXmuYdyytx8IfWtUWaDHg3v2atHYOeQlZBJtn9BjCW7AX4
         JpPZ/j6Xka3dLAqM61P/DfkcTdfJeFad8SargQcMwkhdLPVYf3pbmI0+2uKZRFfZCzBE
         3rMhMPdmZFaSbqc6crSQqPmYKRZhsg3iCsfn85FM+axRwtTtJtwrlGMu6ZmbOS47b/1O
         E9EYoG2TOtPCg7hdhFQHtRhK6CIXAqSjCTm89FGSo0B0EbhKIk3F2KMZWd4tcFfnTfwA
         7zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XUHjj70cowKreOXDH5PAdqmM26n2/xW5aaOtFMYCm+s=;
        b=Lv+KrICkyyeYw14SC+MyETTje9RM5jCXD/HjcE8BFrJHTtAvkeDq+NO/utfvZWuurs
         X29Hdrw7nSNwl/226BgWNb4ioUySVW8pLk675/dkmjROo657yfFCd6XXM4QQQmd2hDs7
         e75+LCLJiohvx1tMJfvBdDI8UxTlGMyJRm3tRE0GcuNSDssny0Htr8f1hiZuFuXYCJ1u
         6zQXgQOhHaEfjOKatadCFuNh2RZG91vIC/fC5pQ1u7T9quMTOIbdnhEBifhwsOdivwTX
         56pxyo2077hpLFgKqlLF7WrHhPOSzUS0vcqanV3Io2VV8NBlcC3tnidEYOb3VzHXxJmo
         ZJiQ==
X-Gm-Message-State: AElRT7FVkin1dAj9/ilUiuEGE4+tLJKrFlgXQNGbXTyFH5toxe8Eo9d5
        wGXxHmPSB7iFdQ1jNxf1Rrt23bk=
X-Google-Smtp-Source: AIpwx490gGhHwqk4Wfin0fO8pxsLokBSmLmV/xpX6arT9Lx6Ju+zVnzhk/UsHxfrOcl++Xp0PKBs0A==
X-Received: by 2002:a17:902:41:: with SMTP id 59-v6mr5606872pla.248.1522275709507;
        Wed, 28 Mar 2018 15:21:49 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id e23sm8801907pfi.76.2018.03.28.15.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 15:21:49 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 5/5] stash: convert pop to builtin
Date:   Wed, 28 Mar 2018 15:21:29 -0700
Message-Id: <20180328222129.22192-6-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328222129.22192-1-joel@teichroeb.net>
References: <20180328222129.22192-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref and pop_stash functions from the shell script
now that they are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 41 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 50 ++++---------------------------------------------
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 51fe8cab7..aa8a2bb3a 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
@@ -23,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
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
@@ -515,6 +521,39 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
+			git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	if (assert_stash_ref(&info)) {
+		free_stash_info(&info);
+		return -1;
+	}
+
+	if (do_apply_stash(prefix, &info, index)) {
+		printf_ln(_("The stash entry is kept in case you need it again."));
+		free_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_drop_stash(prefix, &info);
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -580,6 +619,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		result = branch_stash(argc, argv, prefix);
 	else {
diff --git a/git-stash.sh b/git-stash.sh
index c5fd4c6c4..8f2640fe9 100755
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
@@ -634,7 +590,8 @@ push)
 	;;
 apply)
 	shift
-	apply_stash "$@"
+	cd "$START_DIR"
+	git stash--helper apply "$@"
 	;;
 clear)
 	shift
@@ -654,7 +611,8 @@ drop)
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
2.16.2

