Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561CC43219
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKEREE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKEREA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:04:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533CDFAF
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:03:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h14so7050953pjv.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI5nYp5YdU6JgLYQyfGXaHjanIM2cIwiIE7FmMrFOmk=;
        b=TjI8e+PSQI8fH47Syh2IhTPzFQtopU3sjnZXgM2qQ64/hQTooNmgU6Y+coB3tftN6E
         tlKuL5smRQhhXrez5iuPD5FtZJeJLflfQsqL4F0Y5/7zyP9Ss9TL4rxggBMpiyzkKNiL
         0RtomeIn0wSAyl6IylSQPhBAhMAFLPbDts1teHw7HGFzYvUWrVHxFV/OF6t8P94VVP8a
         VAnMFQq5iCf3FwZBE0k6+lB5gxZJIbd5AiwgWRAqjo2Gr7UV24qlAAWDo8zCG1CTug9r
         m+DTNdzfh1NXs4IITuedTSuFG849HKME3jn5q4jzN1edCIxAGVRVoMyw4JECMhVsJQln
         F3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI5nYp5YdU6JgLYQyfGXaHjanIM2cIwiIE7FmMrFOmk=;
        b=CXNskqBTQBCcAncPD9PDKmaD9LbzFgChrqATKgfWczp+AQD0lqEYsgqCHQYWriLwdi
         tiZd2c27+22j2cUJxqc/rUHqZu3yBRcqY+cmaCyGpEvxZxrM56q6AYT63ZqEW03dZMbN
         T+IEKv/HpSbNY0Dea9aKcdvhLAiA4QXRt8WoFMwwV9RO2QO8tqXTzK/eKfDrn+djoK8P
         eBxtLZdSW8WdCfZlqgyEVulT4nHBw0fvPUGaMFeLG33t4Mq2wdj4kGHvwgxE63uD0w/i
         z2AKTCF0Wt53OiEH5glbWRyHci2U+HUSWXY5ONEwOtB8/OMtlg6Zj50jjwmWAEkk/qLY
         TMlw==
X-Gm-Message-State: ACrzQf1SM0GwVqgBXuUyY5qaqJlxrbfXv9c8uZTe4h+87TLkyWYGnmgw
        Uuo4YiaFutSqVskWAsL3ouhxYwEpg4Y=
X-Google-Smtp-Source: AMsMyM6mvsFnXCBI/i570eZOgtkRPHg0p4YGZ3C7o+ZhqBhik6Iauzkpj66B90czA9Y3b8n8/iCe8w==
X-Received: by 2002:a17:90a:fe6:b0:212:bfc3:31f5 with SMTP id 93-20020a17090a0fe600b00212bfc331f5mr60454604pjz.215.1667667838035;
        Sat, 05 Nov 2022 10:03:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b0016c0c82e85csm1910789plb.75.2022.11.05.10.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:03:57 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] bisect--helper: move all subcommands into their own functions
Date:   Sun,  6 Nov 2022 00:03:35 +0700
Message-Id: <9d8a3cdd7a9472df01f67eb11ebac02a143d270b.1667667058.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667058.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com> <cover.1667667058.git.congdanhqx@gmail.com>
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

