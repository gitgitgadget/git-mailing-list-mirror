Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B12CC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiA1AMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbiA1AMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7755C061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l25so7610941wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xgvZ1PEwGj+nTYvwqT5lUb33L+DTtVBe6u/LBGGglGo=;
        b=KVOTCntXfRArMk+h9iE5wrCF6va/NM1SOJow7q9HuhBVmfiGsVUQvJFtBv4pTPsBx0
         jt/R5gp1HIVpnRjjPE7XJUqkk1Lk68JWCOSGUjLRx//yk9dWTfjChhNEmRawtw83yuf8
         hqJE3QxAirxLxgv/sErHDJtedky1PXpTVq0kv7ryMlb1ZDCU63cM3LxiUMej16oBhr01
         v/HImDIVBLloE4VDeCEnQEnw7N+wCLASONLGxuPEjV8lTUgCkEyob+hSiHxsuadjcP5l
         exv+Te2G5rUcelC5YQpPtaKEYThxWM3ihHBos5cZsCKi2K7IIRV/woVx//TlH34HCl3J
         tr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xgvZ1PEwGj+nTYvwqT5lUb33L+DTtVBe6u/LBGGglGo=;
        b=ENcF004vKn8HcAEwacexXvu5dbSBI0VQ1tkCTGSfmuplEiA38V3iLSfSFJTAYZj99v
         0nHsiDJXv5EKm8B8JL8ZzUmaOPpglao9dILGPqrN69r3GhLEYAkA9GkvWkdlV9q0WH2V
         SUQKucYXEylvewARSb0rwgKFj6xR7CG+YMpTE+VbyCAAVRcnni2s/b8gnqL900vsx1D1
         5Ue87DrIat7wmoXxLR2Od5bwJdyuVTAz2qQ1eioms4NDG6t2ynbUF7Q1ej4QTPPLpf8M
         ekg2RobrfI/L534kT4BO0v9SAz7XlWymBQHGQpvjMfMrz6N5jtN65NDopqJyaXU+9TOQ
         v1/w==
X-Gm-Message-State: AOAM5337L8nJHFtX6BoawjkK53AODV+8wSESmukIEfKZFK3T4HT579Qq
        wcAEVRqkAgqlaV2WnSNP0D+07VN10D8=
X-Google-Smtp-Source: ABdhPJyAoU4Pr5w5JdHO1IiJKDbfkB7kFAiacHn6OuJhyxZSbKdUgPyTpo55BCPs4MMJIfDLCQQzDA==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr5305374wrn.158.1643328757428;
        Thu, 27 Jan 2022 16:12:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm3740982wrr.7.2022.01.27.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:37 -0800 (PST)
Message-Id: <6afc6e0eeced94d6d5b820cc0c77cbb74d175900.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:26 +0000
Subject: [PATCH 05/11] bisect--helper: align the sub-command order with
 git-bisect.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
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
index 7ba4be1947e..cc5a9ca41b9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1169,37 +1169,37 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
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
 			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_END()
@@ -1214,19 +1214,24 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1234,15 +1239,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1250,14 +1254,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

