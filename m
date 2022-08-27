Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79076ECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiH0Mpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiH0Moz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF67F51
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e13so3848265wrm.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=PauC0EwEr5xvcTDJZfV+MsH+SKq8eY9nrWh2OoMP6y0=;
        b=cHwByHfmPJ3Ly06YCHb1haUQ6u3JPNmVUC1WGLMcZp6Ah2eZ8vIWVrk07kmNRFjdl+
         oJod5c250kqJLNH9HedS+EJw01StuegXUu9KuGIJNvCF1XFtlP6BMi+sXYCPDxPhr9BT
         QFkCiOUK+h00akYQ/vEOV6542o3qekK1dbekJWQWjJBu72JV9C/D5qR5DdwwMHFM5mJt
         IBrV3g+P9GYt+ovWlZ14+w/+7TKMPtF3n8nO/2ovb8aINRC0Mil9FSdS1yIGZ2QE3Fw6
         hiEgsdeR2xpdxwaUD+1rNi/WeqNqNXYW8XCSTWauMfecG2X5WJd1s5QcqnuSoODMEWpM
         mL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=PauC0EwEr5xvcTDJZfV+MsH+SKq8eY9nrWh2OoMP6y0=;
        b=28PVQGI8lsDq9tKpCyZQHNJRBRuPRywz8NoWjBW+bxrR+Jyed1DYnUMGgITwT58NYN
         4cLoKenXM9UVRhHhY5AO3IaQuCKXAjmRGtW6e8i0k4Qm2npodHTf0nfxrJxBhnY1zphd
         dw+r+z/b+5dykfdlqzTtO3GTr3J1WlzTtshbU9CS0yXCR4pmEfPUp3L4VzoAM3aID4uU
         vPG8Q6INyoz3HDvwqZoscumM9xhoWD6Ao09n2c7tXhiQD4OrL9M5ShyLh1jgYDMpe3jr
         P0u8SC/DfH26qQXvcurl1Y5tCaB+D9u4L0NMgvNx94FOZaQZwa08NeCvM4eOX/aR9Sf5
         v6xw==
X-Gm-Message-State: ACgBeo0Lg94dTsTYIO7GS1iZ3WRyV78hqRC0nlYMmC5qdj9KwxWBaOBJ
        QCGzzyu6dt8g2thHEYoKLXFPgj/xzFE=
X-Google-Smtp-Source: AA6agR4o/8W9+WLDEC+wFr3SLT0fKQfSwS4/YFv3SEvSajbx4OPLXUIyQ3aGmYTLDHnG/fq++8mNhQ==
X-Received: by 2002:a05:6000:1549:b0:225:64d0:a5c2 with SMTP id 9-20020a056000154900b0022564d0a5c2mr1999365wry.87.1661604285139;
        Sat, 27 Aug 2022 05:44:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d6391000000b0022511d35d5bsm2307603wru.12.2022.08.27.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:44 -0700 (PDT)
Message-Id: <a8f08f5e0cbfcfb74096d6c611de3d21eac1244f.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:22 +0000
Subject: [PATCH v5 14/16] Turn `git bisect` into a full built-in
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
index d243a9132e2..16f5c92bb9e 100644
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

