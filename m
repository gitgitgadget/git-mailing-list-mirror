Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F47C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKJQgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKJQgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:36:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7F63E0B9
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:37 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y13so2672316pfp.7
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmZwz6ThbuN98eLGER2hpNqEqt8phzn1nLYNAugH668=;
        b=jwcp6cSQBa7lCuNCz+jDm/X6w4qfiNpUe7rnw2pNT2cICW5SexiU+EZHkLA4MknLr4
         UtbTjqnhuRCW2MBxYhwL01R7OgoaByEIOXG+yaiVpoNOYI6Gnu5VF7H3Q6TsOiSXVQ6G
         2ROHQnDv/bDWLJYuLFgtBEDNoE1VuYWUMEAkogxtLtheKErkggaXLsLOQveyvcuVbTv8
         c4UFWNM33kqwg2VaEzrFyyny7B09jqAw2nagNpKMj0vzFHgRlpuDRwsBR2ydtQaoR4fe
         2lXfF0Bm01Qc0/6RigQSXdGDlqt3akTs0XfxCvgWUA9dSYtnld1PcNKKVNKOXgQd9lya
         ZIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmZwz6ThbuN98eLGER2hpNqEqt8phzn1nLYNAugH668=;
        b=VK3zZUXJZ91hH6pdU/i1uCYNmSXs47cwrIaiddgM80G4WYfq1pWpU0zRNQoHluVzXI
         uIC1jV6gaYWOPVcgCzsSj3M0EPfAScPJaUPYh4cO8ZPvblF9uLaNXLuPAwnUlWcjshmC
         3N9p3PCYpIHIfDEwEiRnt5ejJtLOqi5znKf6h77WvBkL/pWmvIhQVbi+P3ntiTKQGScs
         lNV0U4FXlD/nJVwZLcQB1VJ5V+EfAk981bKwcWSIF85+O9z1AUry56m8ByCtfw0r3cdh
         bZQ13UifbhQkuGMh4Cf5yWnas7fO81ev5nIsqd/Yl1+lFzQYWRT7C3VpO+VWuiFQS1Q2
         jT3Q==
X-Gm-Message-State: ACrzQf0OV9r2xpPvcX7yiG8DpkWny2jTzOKVbBJQocXa8nQ1UFlkrNbj
        QEO6eu3QyFlvvu1yFKD+k4E3gUSWzxs=
X-Google-Smtp-Source: AMsMyM4kfidPnomvV35iyYjBVCTBOWypWBoEuQmGDN3310KUu+A+FxZKGV3Gg1xsbvPwLaKcEJwOug==
X-Received: by 2002:a63:5a21:0:b0:470:2ecd:e9fa with SMTP id o33-20020a635a21000000b004702ecde9famr2572237pgb.183.1668098196447;
        Thu, 10 Nov 2022 08:36:36 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id b29-20020a631b5d000000b0047022e07035sm9371372pgm.47.2022.11.10.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:36:35 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] bisect--helper: move all subcommands into their own functions
Date:   Thu, 10 Nov 2022 23:36:21 +0700
Message-Id: <248ed392ea8bc7c812156276bd120bc9d5b8ba6e.1668097286.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097286.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com> <cover.1668097286.git.congdanhqx@gmail.com>
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
index 5ec2e67f59..d425555d1f 100644
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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
+	struct bisect_terms terms = { 0 };
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

