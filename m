Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF223ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiH3Sul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiH3Sub (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA17419BE
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so10458511wme.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QDn+yI7bY8uprlyldCcjwOx6A/q3dhJY0o3eVQm211g=;
        b=Zb1DKgTWoUScEZURrCPdvABV6pLasVBEERPetiP/OnE8qwCqWeFRLMBA33xjUbu+2l
         8xXSKP4MjpToqAabjG7Q0shTH61CBnPR4ALRteAa6Vmts+kxuwD8nHfnSpgd4TInhgax
         09C6J/MufEmAGUpmlyZ8+mYNS08n23xxurj8s3AyjDB8UMNRWGi4dfaqHVhaAuzTVkds
         uf+rzjM7sNDsbVAsmPOVqhKYp4kiPixgDV208Sfg5jRpumCWEULNVUrJ6JLr4+dqgne3
         iJeZM2Go3qWQFIV38KF14y5XvmhfV6egaPyL0/b7+1f9TL6r5oll6rDRLM1Lbu6I3S/I
         /iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QDn+yI7bY8uprlyldCcjwOx6A/q3dhJY0o3eVQm211g=;
        b=MYOHOZUA6ojoyYrinMbnNCDhVsGBgZ1Vc2ESrBXvegW+qemJwS5tEIz8S+UFYp7Jxn
         fzK+Y+v0iD9Sg4/OExYUvwGiamKuRFQCgSTlRPVZh1DlEtDqeq/qnNbtr1/BM/JoS6D1
         W3/4/vY9xxmhXroUs9nUT/Gp/OYaNVIAZ6G43BOESr61pCy2IdavhtXGxGjyu0fwn5mg
         mfH6nZzT3eYgeb6hhec5Kzhp5X0CzdLLpEZ+lpkIIYuux+KfyV9OQDW+bD2BPwX/hgTI
         qKFMO9iE11DkARj2TrmsTTYmBbnX0ztZL7QD7TcxVDr4ufFOFjn8sCSlP/1H7atbzUbp
         I4HA==
X-Gm-Message-State: ACgBeo32y/wfMla6KHCjJ1OAjc3uDFjNEXGVCb2cKpL2bI2NSkK1UZho
        51OBXF/A2bOyK90KZ4++fwzUY53szBM=
X-Google-Smtp-Source: AA6agR5gG7aCZT3H3LKUsd5i1Cb54hgiysq2GxpZOUD3lFZrm6LI8QRy5iARwroZIjOC1BYRHKbBTQ==
X-Received: by 2002:a05:600c:1c16:b0:3a6:b11:79be with SMTP id j22-20020a05600c1c1600b003a60b1179bemr10262550wms.203.1661885427858;
        Tue, 30 Aug 2022 11:50:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d6391000000b0022511d35d5bsm10601861wru.12.2022.08.30.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:27 -0700 (PDT)
Message-Id: <c9dc0281e38bf9bc0bce72de172b5dbadbcbb1f5.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:09 +0000
Subject: [PATCH v6 06/16] bisect--helper: make the order consistently `argc,
 argv`
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

In C, the natural order is for `argc` to come before `argv` by virtue of
the `main()` function declaring the parameters in precisely that order.

It is confusing & distracting, then, when readers familiar with the C
language read code where that order is switched around.

Let's just change the order and avoid that type of developer friction.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7f4e8e707c1..0d7cc20f9c9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -652,7 +652,7 @@ static enum bisect_error bisect_auto_next(const char *prefix)
 	return bisect_next(prefix);
 }
 
-static enum bisect_error bisect_start(const char **argv, int argc)
+static enum bisect_error bisect_start(int argc, const char **argv)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
@@ -881,13 +881,12 @@ static int bisect_autostart(void)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(empty_strvec, 0);
+		-1 : bisect_start(0, empty_strvec);
 
 	return res;
 }
 
-static enum bisect_error bisect_state(const char **argv,
-				      int argc)
+static enum bisect_error bisect_state(int argc, const char **argv)
 {
 	const char *state;
 	int i, verify_expected = 1;
@@ -1006,7 +1005,7 @@ static int process_replay_line(struct strbuf *line)
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_start(argv.v, argv.nr);
+		res = bisect_start(argv.nr, argv.v);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1056,7 +1055,7 @@ static enum bisect_error bisect_replay(const char *filename)
 	return bisect_auto_next(NULL);
 }
 
-static enum bisect_error bisect_skip(const char **argv, int argc)
+static enum bisect_error bisect_skip(int argc, const char **argv)
 {
 	int i;
 	enum bisect_error res;
@@ -1086,13 +1085,13 @@ static enum bisect_error bisect_skip(const char **argv, int argc)
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(argv_state.v, argv_state.nr);
+	res = bisect_state(argv_state.nr, argv_state.v);
 
 	strvec_clear(&argv_state);
 	return res;
 }
 
-static int bisect_visualize(const char **argv, int argc)
+static int bisect_visualize(int argc, const char **argv)
 {
 	struct strvec args = STRVEC_INIT;
 	int flags = RUN_COMMAND_NO_STDIN, res = 0;
@@ -1167,7 +1166,7 @@ static int verify_good(const char **quoted_argv)
 	return rc;
 }
 
-static int bisect_run(const char **argv, int argc)
+static int bisect_run(int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
@@ -1240,7 +1239,7 @@ static int bisect_run(const char **argv, int argc)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(&new_state, 1);
+		res = bisect_state(1, &new_state);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1330,7 +1329,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_START:
 		set_terms("bad", "good");
-		res = bisect_start(argv, argc);
+		res = bisect_start(argc, argv);
 		break;
 	case BISECT_NEXT:
 		if (argc)
@@ -1341,7 +1340,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_STATE:
 		set_terms("bad", "good");
 		get_terms();
-		res = bisect_state(argv, argc);
+		res = bisect_state(argc, argv);
 		break;
 	case BISECT_LOG:
 		if (argc)
@@ -1357,17 +1356,17 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_SKIP:
 		set_terms("bad", "good");
 		get_terms();
-		res = bisect_skip(argv, argc);
+		res = bisect_skip(argc, argv);
 		break;
 	case BISECT_VISUALIZE:
 		get_terms();
-		res = bisect_visualize(argv, argc);
+		res = bisect_visualize(argc, argv);
 		break;
 	case BISECT_RUN:
 		if (!argc)
 			return error(_("bisect run failed: no command provided."));
 		get_terms();
-		res = bisect_run(argv, argc);
+		res = bisect_run(argc, argv);
 		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
-- 
gitgitgadget

