Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160671F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJOFzt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38236 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeJOFzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1-v6so16083337ede.5
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaGkABkwiL+N6cV2L/tqMDiqsQnLMtMqTDPG0vRHneY=;
        b=Md6FOXMf1TYGHMT2IaxlifA7irQasZp0lHf1TVzkzUiKfCo8fMhjCmlZ/ZHwF5X23y
         8SKXcCZFUKvFGHoP0mZbakfjBFn98gsqMhPxPRVBJErdGibpByC6hT18wLlFGbBdg7nN
         lYSRBnpTGttjvSBrPrMxDCgBvbxnB4F8lv1oD21Y/7QRfUCxKXHjKcloLpsSGvnwGFPs
         vibOXUcbSSXBnL/QJCX2HGAggyMSqSOhZfVpAS9q3/hE4i68GeHmt6C/5yWdbzZTS+8d
         uZ1vOPagJ5DewB56v6e8V3yUR9XUJsjXwIH5nAUQygDq6FCMhaSxOQWIsX24P3t28oum
         ReiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaGkABkwiL+N6cV2L/tqMDiqsQnLMtMqTDPG0vRHneY=;
        b=YjqJt3NM9OJYdXJC0nBEqUUA7Nb3QEM5SSZgpM2TzrpksRnjZoPX64/2Pf4huU2vgE
         H1OnmatF/lyG48/b6vOHW0zZVMxifc4hmq+N3uS5vEw4dkXY3jzf5Sq53qk0S2cHFR/R
         nSEJeFOlcLB/YHYhUcILSpZCMpK9k5bo15U0WPesXm8tdFvdoLQopkFgGHzBda8Kllde
         ewlU4uG+lNaEe222XZ9tptG+IeKmb8giVzjV21tTQ7hcA/TTb5AY/aysiEx/710pcLRA
         qlxPN2CeZSGthpctAcwywSMh53RP3WTzSaDSgrxuSdT+yErVGa32Zhf+OaCprSEyZMkM
         M4kg==
X-Gm-Message-State: ABuFfojjjk3dFDX91DJINx4VYZ/a9HeRGsnelkRnvZnVWDigrjIp1X0j
        SbkuKyb/fkAR/mdtAbcZz+abGBrT
X-Google-Smtp-Source: ACcGV624mm6CB5iPIfCw6tOsm+7i8zk3zeW+Vyn6CA78OF0IuZ/7b9MkgloGmall1xP61zUwkyKxvw==
X-Received: by 2002:a50:b3cf:: with SMTP id t15-v6mr21818274edd.181.1539555201359;
        Sun, 14 Oct 2018 15:13:21 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:20 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 12/21] stash: convert list to builtin
Date:   Mon, 15 Oct 2018 01:11:18 +0300
Message-Id: <1b76e429041d7b05678f871607b86cb7a0a7d4df.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index 33f4e83353..a1249f6b76 100644
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
@@ -618,6 +624,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
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
@@ -648,6 +677,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list"))
+		return !!list_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 8f2640fe90..6052441aa2 100755
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
2.19.0.rc0.23.g10a62394e7

