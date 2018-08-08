Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410891F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeHHVUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33477 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbeHHVU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so307654wmh.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uWMZAKLH04oO5dP30ruB9xOZyDUf71sXWsvhWJqMj+s=;
        b=DqHvCVCuP5dAwBPEica27gr8kL0zVwwzvm2lByQ0IXz9hHpdEOo9wkQe1F0d0VCQ3I
         xVT3+r7T7UWtZxlP2obNBWxu92NPBgjzvBAefcKhroYNA0xE0+sw3c3pKdDsvU39BFhB
         1zl6i2t15a1Jn36PXjifbsrUNns9IDlPGwnPUd7VndNMtWwL9ifvzNGeFcQP4B+ocYZE
         Xl/l5qyVmdvJXxlxSLLjeJOPZITG2PaO/hUSxQRtWpW4nhc6ybmUtl25bgfK9xkPdOvy
         t3RbqTOnZ++i3pJeNQ2Djf3qpYYy9jsR8hsxoLBTx1Gj/RJDuA3/RKBmklq91C5K7Ijf
         YUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWMZAKLH04oO5dP30ruB9xOZyDUf71sXWsvhWJqMj+s=;
        b=cXcsIhqSROfWiEboE6+BUxQx7qx+p6beahDAaEvBL+ddGtVjs4hIluaWhRG3H2vwpP
         ibd34xKzQYeAb3Q+CAE5UqFROn6WbSJggUU1cxjlCDTcAlSE8arjGP28wYyg18Q+MNlg
         UyBoHrtMYcqIqso//1q38NKGI01it+SYVapdbMsDE8SsdODUK3+QROwh89RWr+DQ4R5m
         PswXCIuaPOQbATqAZOLgr2b4OjxcUQXqW9gy3M6ZWhbvJgQU/Gs/Fvjq14uczz+jsaQt
         YEnvtJwTmeqP7M+d7imeft66QP/hVjQ3hclQgkWT9pAnNEo2ubHlsbt0UFNIVdbbYDV6
         EIdA==
X-Gm-Message-State: AOUpUlGaWDrsQI6+X0ROSy6yXlCrJOAlSKBIEGWmVvSDec1i2LdP37qe
        L8YWgdwMHUrwjqaRHQCjI/z5Z39L
X-Google-Smtp-Source: AA+uWPx62/bPiDvLFUnnLityZCvxVVqHi0l6ItnhcKhBjnxzh44jO/pbym1no5MB36s3yyEFOvP6HQ==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr2813018wma.123.1533754764526;
        Wed, 08 Aug 2018 11:59:24 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:23 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 09/26] stash: implement the "list" command in the builtin
Date:   Wed,  8 Aug 2018 21:58:48 +0300
Message-Id: <47556d40a9944e8cc45ba3df8e12c80a1898b160.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash list to the helper and delete the list_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 31 +++++++++++++++++++++++++++++++
 git-stash.sh            |  7 +------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index d6bd468e0..daa4d0034 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 #include "rerere.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper list [<options>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -19,6 +20,11 @@ static const char * const git_stash_helper_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_list_usage[] = {
+	N_("git stash--helper list [<options>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_drop_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
@@ -609,6 +615,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int list_stash(int argc, const char **argv, const char *prefix)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_list_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (!ref_exists(ref_stash))
+		return 0;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
+			 "--first-parent", "-m", NULL);
+	argv_array_pushv(&cp.args, argv);
+	argv_array_push(&cp.args, ref_stash);
+	argv_array_push(&cp.args, "--");
+	return run_command(&cp);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -639,6 +668,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list"))
+		return !!list_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 8f2640fe9..6052441aa 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -382,11 +382,6 @@ have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
 
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
 show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
@@ -574,7 +569,7 @@ test -n "$seen_non_option" || set "push" "$@"
 case "$1" in
 list)
 	shift
-	list_stash "$@"
+	git stash--helper list "$@"
 	;;
 show)
 	shift
-- 
2.18.0.573.g56500d98f

