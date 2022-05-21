Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00509C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355314AbiEUOtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355094AbiEUOtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDAA6C57D
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3972809wmn.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3dZ2Fnr276NklviQebVSsNuynuyJgrY0274sC/fw+2E=;
        b=o1MY0Czs8DcvmMsAYfw/Na7+Xm1I9hBHQva7oBaDHf1XI6yz3SIkX6N0HWY1YHlcyk
         p4UOsUwn3mSJDoQCm/38EQyo+DpLM+B2NDv3iHpBODc7vMErQvChlhW1Wc6giwJ/HO9s
         SGN7RpHE5qONWd1FqoMGMzxjvoPlD2Pu/P6DjhHhk9X+OmHXtfdGGc1Pd+sTM2mn1UaZ
         NB3EW1fIu08W+SbxJ+d7mhtiLnEZVwQC9rwsOZtR1Zz1WwYls1vYCY4qCkkA0V1+gaAG
         atSUcJ2UqXaMNAaVsIePrbq2kTi7/7+qg6xYrLX/YS16czi2cOVw61A48J8HYLMJQvRB
         Y5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3dZ2Fnr276NklviQebVSsNuynuyJgrY0274sC/fw+2E=;
        b=MG8ga3qYpZ2KwEQcLEmaATahpiOXi8giw05qegKmLAo51ephoKAMq5eKNW3yaf8R+H
         Vbs6Pe3JUmc5RR3mcuXczXQgBDZCiLW7yahhI07AAnWrIwqEfKIIbCrLkv/2LmZaVUZ5
         51jN4Cl+K6HKy4tdw1XT8CPyvUp4ZyhdsGCKVpwEhNaDoEl51+elIvYqskPR2cpGszFT
         VashRocDiRLUJQ2UDapF+au+w6E7gXqiYd8b19Q1SztynyELdJ3Dc7VXuBZX7Wa74J4f
         hp/BKuoaxp+AStUZRfxIgZKFXj5BXBQLJY9mRaXL6GOpC5MdC36XJTtMYlVFQ3/OU1/3
         /u0A==
X-Gm-Message-State: AOAM533dH5/mP/tKyb/wYMUlm5TsKbQqfN97pGZMaRbS+XQNN0SGy4mb
        dd9aVe5ne8II8ZhmjwMY068L3IHwxsI=
X-Google-Smtp-Source: ABdhPJyz6SflNbVDq7Aqpm0Vn+Fp1ER5p84qqn+oDbvN1AR+/x9MQBqagfqZ3Z1hBmLmzTOWQMcYug==
X-Received: by 2002:a05:600c:5120:b0:394:6480:d595 with SMTP id o32-20020a05600c512000b003946480d595mr13365041wms.204.1653144556741;
        Sat, 21 May 2022 07:49:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25-20020adfb359000000b0020d0a57af5esm5257454wrd.79.2022.05.21.07.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:16 -0700 (PDT)
Message-Id: <6847af9d4859b3631cfec056f4c6e8d3120349ec.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:48:58 +0000
Subject: [PATCH v3 07/15] bisect--helper: align the sub-command order with
 git-bisect.sh
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to retire the shell implementation of `git bisect`, or
maybe better put: the remainder of the shell implementation (a shell of
a script, if you want).

In preparation for that, align the order of the sub-commands with the
way the outgoing implementation presents them to the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 76 ++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 343aedbc545..37a16c6ac1a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1277,37 +1277,37 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		BISECT_RESET = 1,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_NEXT,
+		BISECT_START = 1,
 		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
+		BISECT_TERMS,
 		BISECT_SKIP,
+		BISECT_NEXT,
+		BISECT_RESET,
 		BISECT_VISUALIZE,
+		BISECT_REPLAY,
+		BISECT_LOG,
 		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
 			 N_("skip some commits for checkout"), BISECT_SKIP),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_END()
@@ -1322,19 +1322,24 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case BISECT_RESET:
-		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
+	case BISECT_START:
+		set_terms(&terms, "bad", "good");
+		res = bisect_start(&terms, argv, argc);
+		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
 		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 		break;
-	case BISECT_START:
+	case BISECT_SKIP:
 		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
+		get_terms(&terms);
+		res = bisect_skip(&terms, argv, argc);
 		break;
 	case BISECT_NEXT:
 		if (argc)
@@ -1342,15 +1347,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
+	case BISECT_RESET:
+		if (argc > 1)
+			return error(_("--bisect-reset requires either no argument or a commit"));
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_LOG:
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log();
+	case BISECT_VISUALIZE:
+		get_terms(&terms);
+		res = bisect_visualize(&terms, argv, argc);
 		break;
 	case BISECT_REPLAY:
 		if (argc != 1)
@@ -1358,14 +1362,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
-	case BISECT_SKIP:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_VISUALIZE:
-		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
+	case BISECT_LOG:
+		if (argc)
+			return error(_("--bisect-log requires 0 arguments"));
+		res = bisect_log();
 		break;
 	case BISECT_RUN:
 		if (!argc)
-- 
gitgitgadget

