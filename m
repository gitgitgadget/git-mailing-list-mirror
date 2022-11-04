Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002ACC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKDLke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKDLka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:40:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FB1EECA
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:40:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so4608385plz.11
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI5nYp5YdU6JgLYQyfGXaHjanIM2cIwiIE7FmMrFOmk=;
        b=Z6zlpr9Gpil9cvWAcXwYoheJY2elikC+OtnWieAOBsIFBTykGwSR56UAQHIw+AcprG
         d2WkQBPsPsm+bT2mVXUUO2OZAfOSc/fJxqVlSblME24E+zdXDt1vAQge1Mp2pRCpYavu
         TbIlv4r+fN9OmxKzIn5EDakXIRuKx+ddmikjcJY6htKohomiYrgL6+BGlev13Ql23hq7
         ZxzDDUPS32BoFffC03XCIZXBgW/xI/Zg5FSSsn/4KLwno4kLFUQsAPa/WychFzoH7ToQ
         zT/MJWb1qJ2qkbIAxvd+pXq63/xGLcos0Rf8HrpbeD8T3NjacI3YE8nB/kgRm0dtwKvh
         AOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI5nYp5YdU6JgLYQyfGXaHjanIM2cIwiIE7FmMrFOmk=;
        b=acSjZrybjup9jmF/cGJQXuG+bfDXSI6BcGfrMscjM49HaGA99oVWriYyCIFawovDwB
         MTqADpV2MsTuXyby+qAmeNPhDIwmTzQHzqYcd9OojM7VjIJnWxQiVbPkTVoq8o+zcXzu
         MJ6YXscNmmo3mcv1Z7tYE3UY+klchtmOJFG9yFC3JGUTYG0IBATQO/G/vwEW3fRRm/Ag
         RnPf2KzkcEa8JIVLpwpV8I2YzWL22KfamUWwrce7svNH2EfWxYcEWBZXvb5r+KNs391B
         nKV8aoDqBfQqRTLMtkbShzpLo5JzcKCtDjG+v/lyT3TC2csXRFmnOeCE2FESXLaz613D
         YzQQ==
X-Gm-Message-State: ACrzQf1hQT/vEPmYgWLfGo1ZW+fYPg2PX3+RVlToQt8rxz9OxwDECgM/
        zP+NpkVj23SqR4SuZoNpPXTeDqsalbk=
X-Google-Smtp-Source: AMsMyM4Xk5IcOF5zexINBzm/M6h79K0P5KTeaE+UZncCRlflhL1z7gXX969d3adK1CS1cHoToC1aeg==
X-Received: by 2002:a17:902:c1c6:b0:186:994f:6e57 with SMTP id c6-20020a170902c1c600b00186994f6e57mr34857911plc.17.1667562028578;
        Fri, 04 Nov 2022 04:40:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id l24-20020a63ea58000000b0043c22e926f8sm2203133pgk.84.2022.11.04.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:40:28 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] bisect--helper: move all subcommands into their own functions
Date:   Fri,  4 Nov 2022 18:40:11 +0700
Message-Id: <081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667561761.git.congdanhqx@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we will use OPT_SUBCOMMAND to parse sub-commands to
avoid consuming non-option opts.

Since OPT_SUBCOMMAND needs a function pointer to operate,
let's move it now.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 155 ++++++++++++++++++++++++++++++---------
 1 file changed, 121 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5ec2e67f59..292c6fd1dd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1279,6 +1279,117 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	return res;
 }
 
+static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
+{
+	if (argc > 1)
+		return error(_("--bisect-reset requires either no argument or a commit"));
+	return bisect_reset(argc ? argv[0] : NULL);
+}
+
+static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (argc > 1)
+		return error(_("--bisect-terms requires 0 or 1 argument"));
+	res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	set_terms(&terms, "bad", "good");
+	res = bisect_start(&terms, argv, argc);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (argc)
+		return error(_("--bisect-next requires 0 arguments"));
+	get_terms(&terms);
+	res = bisect_next(&terms, prefix);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	set_terms(&terms, "bad", "good");
+	get_terms(&terms);
+	res = bisect_state(&terms, argv, argc);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
+{
+	if (argc)
+		return error(_("--bisect-log requires 0 arguments"));
+	return bisect_log();
+}
+
+static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (argc != 1)
+		return error(_("no logfile given"));
+	set_terms(&terms, "bad", "good");
+	res = bisect_replay(&terms, argv[0]);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	set_terms(&terms, "bad", "good");
+	get_terms(&terms);
+	res = bisect_skip(&terms, argv, argc);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	get_terms(&terms);
+	res = bisect_visualize(&terms, argv, argc);
+	free_terms(&terms);
+	return res;
+}
+
+static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED)
+{
+	int res;
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+
+	if (!argc)
+		return error(_("bisect run failed: no command provided."));
+	get_terms(&terms);
+	res = bisect_run(&terms, argv, argc);
+	free_terms(&terms);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1318,8 +1429,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_END()
 	};
-	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
@@ -1329,60 +1438,38 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	case BISECT_RESET:
-		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
+		res = cmd_bisect__reset(argc, argv, prefix);
 		break;
 	case BISECT_TERMS:
-		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
+		res = cmd_bisect__terms(argc, argv, prefix);
 		break;
 	case BISECT_START:
-		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
+		res = cmd_bisect__start(argc, argv, prefix);
 		break;
 	case BISECT_NEXT:
-		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_next(&terms, prefix);
+		res = cmd_bisect__next(argc, argv, prefix);
 		break;
 	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
+		res = cmd_bisect__state(argc, argv, prefix);
 		break;
 	case BISECT_LOG:
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log();
+		res = cmd_bisect__log(argc, argv, prefix);
 		break;
 	case BISECT_REPLAY:
-		if (argc != 1)
-			return error(_("no logfile given"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_replay(&terms, argv[0]);
+		res = cmd_bisect__replay(argc, argv, prefix);
 		break;
 	case BISECT_SKIP:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
+		res = cmd_bisect__skip(argc, argv, prefix);
 		break;
 	case BISECT_VISUALIZE:
-		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
+		res = cmd_bisect__visualize(argc, argv, prefix);
 		break;
 	case BISECT_RUN:
-		if (!argc)
-			return error(_("bisect run failed: no command provided."));
-		get_terms(&terms);
-		res = bisect_run(&terms, argv, argc);
+		res = cmd_bisect__run(argc, argv, prefix);
 		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
-	free_terms(&terms);
 
 	/*
 	 * Handle early success
-- 
2.38.1.157.gedabe22e0a

