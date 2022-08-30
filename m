Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15301ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiH3Sv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiH3Suy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F89251A24
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so6672604wmb.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=vqO9uA64WmS1e8PpcJEol1MDKRUQ2ilSXo64PEbap9U=;
        b=IgCW63f4E1BTqVh0AisrabAiHCGnvbI4UuIaVd5qWq98vNPFWERduhCzIsiZWqf50V
         u6dvqDZI9P/z637ZbYlW2S5V2++sICkZ3gnqakp+HXXxuUwejRP7sgX64OulscyrVCLE
         PHLpBjzIXBG/oYphqQP1KwRNJFKUT3Y6RAus0TzsDoIOX0pYPZVepfeE4/FSGMHW0zsb
         ITaKHUxpGcHdxiOEpreDLtHX/KX7xRd68b7CB6fcCOyNzq/oYBxiXr6qfbS+DTDbiOY4
         mnL+kSoPK0QJPoEF3AbHUqVC1XpUY0vQ/rHd4wdZTen2V3A4Bym2t5QHhrTzNX4CrKHS
         M+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=vqO9uA64WmS1e8PpcJEol1MDKRUQ2ilSXo64PEbap9U=;
        b=wPVKB0cAikwQSqvBJT6NGaajyFxpUk84DJIWzvi7RClCToG//FJa1HXk4e5XnytB7K
         W9vhfBuBuZFoph3LWwWkrHteU4ibs4fRyuS0D4eo2bNPbTADnicyEnheVn6Yb4jv4o5S
         HEgcOK0Orsx2yNlfnwLz9BFt+ldEN+lnk1fawxRxzRUjiPU4awGkZiNphMDK0kJ7c32w
         wZBqP8vKDHkXIgpRhekWPT1+bPgwtaxBjSe5cNt+alBXSoUo652QxJySy76/FqP/5M+7
         1awSUpkeAvlrb8agD0xTJevhDBsqJzrNkll082FUbLiDTDXSWdveYsMVi8zZ1jjS95Gz
         cKrQ==
X-Gm-Message-State: ACgBeo1ayZNxYd43w/X+e2JDm6hgLUpqJuSvSXMKuFSskERnIWFRo4lj
        xs5xCHqRTXSqzGqRH11Wd51R1lkXDA0=
X-Google-Smtp-Source: AA6agR5naobIVnBHsHMVEWC8wX0ox9a9qiCiP9RgvnS0b8fM35Xtz7/L7j9LPmLjVohf7PQJvbb6EQ==
X-Received: by 2002:a05:600c:1497:b0:3a5:f608:d765 with SMTP id c23-20020a05600c149700b003a5f608d765mr10176746wmh.19.1661885437204;
        Tue, 30 Aug 2022 11:50:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003a60edc3a44sm14288840wmb.5.2022.08.30.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:36 -0700 (PDT)
Message-Id: <a83fe3dc3c2de664c8d0596564d4ac10dd79331f.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:17 +0000
Subject: [PATCH v6 14/16] Turn `git bisect` into a full built-in
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that the shell script hands off to the `bisect--helper` to do
_anything_ (except to show the help), it is but a tiny step to let the
helper implement the actual `git bisect` command instead.

This retires `git-bisect.sh`, concluding a multi-year journey that many
hands helped with, in particular Pranit Bauna, Tanushree Tumane and
Miriam Rubio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                               |  3 +--
 builtin.h                              |  2 +-
 builtin/{bisect--helper.c => bisect.c} |  2 +-
 git-bisect.sh                          | 37 --------------------------
 git.c                                  |  2 +-
 5 files changed, 4 insertions(+), 42 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)
 delete mode 100755 git-bisect.sh

diff --git a/Makefile b/Makefile
index 1624471badc..4a79b2ba2fe 100644
--- a/Makefile
+++ b/Makefile
@@ -627,7 +627,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1127,7 +1126,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc8485..b9470f8ab4f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -116,7 +116,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
 int cmd_archive(int argc, const char **argv, const char *prefix);
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
+int cmd_bisect(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bisect--helper.c b/builtin/bisect.c
similarity index 99%
rename from builtin/bisect--helper.c
rename to builtin/bisect.c
index 6bcf16d9f62..46b65c91738 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1445,7 +1445,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 	return res;
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	struct strvec args = STRVEC_INIT;
 	parse_opt_subcommand_fn *fn = NULL;
diff --git a/git-bisect.sh b/git-bisect.sh
deleted file mode 100755
index 028d39cd9ce..00000000000
--- a/git-bisect.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-
-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
-LONG_USAGE='git bisect help
-	print this long help message.
-git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
-	reset bisect state and start bisection.
-git bisect (bad|new) [<rev>]
-	mark <rev> a known-bad revision/
-		a revision after change in a given property.
-git bisect (good|old) [<rev>...]
-	mark <rev>... known-good revisions/
-		revisions before change in a given property.
-git bisect terms [--term-good | --term-bad]
-	show the terms used for old and new commits (default: bad, good)
-git bisect skip [(<rev>|<range>)...]
-	mark <rev>... untestable revisions.
-git bisect next
-	find next bisection to test and check it out.
-git bisect reset [<commit>]
-	finish bisection search and go back to commit.
-git bisect (visualize|view)
-	show bisect status in gitk.
-git bisect replay <logfile>
-	replay bisection log.
-git bisect log
-	show bisect log.
-git bisect run <cmd>...
-	use <cmd>... to automatically bisect.
-
-Please use "git help bisect" to get the full man page.'
-
-OPTIONS_SPEC=
-. git-sh-setup
-
-exec git bisect--helper "$@"
diff --git a/git.c b/git.c
index f52a9554103..9c11727e29d 100644
--- a/git.c
+++ b/git.c
@@ -492,7 +492,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-- 
gitgitgadget

