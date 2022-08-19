Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA3C32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353129AbiHSQdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353208AbiHSQbE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:31:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F411C959
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j21so4262186ejs.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=igvnRN2d16Vpcd1kW1wlWwgcGM3UDndAVAMVd5HApTg=;
        b=HOikjxLAohLL0Ziv115VqEV++rPUUx+B57MKbV6TMbb/TbUXBm3b+xqxN9EGMg6Id8
         v35lEX1a7yrx91koAsh9I2+VDqdMl7K+lVjjc4uje1yffOkYeNhxlrshTX3HWkIA1ZcN
         DKS/6LtfRRw9EfUGFuzouig2rsJesPNWlh2Pi+6A+H0CbexVXl28JORQqGIlCSnV4xzu
         SdqG1bmRylQEck2VGv4PsnessTK4QUp4FTkS9UNUcg0qNp7fkjl0rjVNi/c5DcvLD7xU
         ue31JtIDYzSGfx/+IHNez9TsINv1MbQDvXPV2zrcE6MGkcdpo0TOyheYsYQgfsXWEcll
         nqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=igvnRN2d16Vpcd1kW1wlWwgcGM3UDndAVAMVd5HApTg=;
        b=pSm903RbeGOIK2FayFRQU8gTZhNzKtTWavKhJ/OPJFl51PUSz0Q54F0IEcbgRUbYl2
         tj9VyOVx+PURIF3wNQbInoQyV5V4GcmXqpBcEzGGnMzPTDc+8YMVs6uAlSZJbr3KpCMe
         QROXgtzU6chXcm2or70+OFvZl5p7V2TGnr/+2xNZ/8wjXZxqvi5IM4RLgWv9ydJgJGWE
         qesz9s004RcWzE3QcM1sWhP42ZxxLpwwAu7790DEFIk2QijsxgZxbqRjQAC2kz1TaKb+
         dvAXbGYkgaza3Mmh+ABqyymKRvwi/voMdAzTJOO6MQ31vUw0070336H5Oa63BwMK4Jq2
         GL8A==
X-Gm-Message-State: ACgBeo3jnJq2Lcjypf3yEJMYB2NPueTBvj1+reV6BlhS2gWVFxG/+rzq
        YZOQZjmFKlxqKsln/RLsKSbeyzSQc/E=
X-Google-Smtp-Source: AA6agR4ycuzya6FUIDbmOaKaIRTp8/3LX18fgrJIwsfmWeddus8UcIOTucLxjJT+nxhCrsIekewYww==
X-Received: by 2002:a17:906:cc57:b0:73c:7015:ac39 with SMTP id mm23-20020a170906cc5700b0073c7015ac39mr3685974ejb.725.1660925107271;
        Fri, 19 Aug 2022 09:05:07 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906430200b0072b3406e9c2sm2530299ejm.95.2022.08.19.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:05:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 19/20] builtin/stash.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:10 +0200
Message-Id: <20220819160411.1791200-20-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git stash' parses its subcommands with a long list of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
and listing subcommands for Bash completion.

Note that the push_stash() function implementing the 'push' subcommand
accepts an extra flag parameter to indicate whether push was assumed,
so add a wrapper function with the standard subcommand function
signature.

Note also that this change "hides" the '-h' option in 'git stash push
-h' from the parse_option() call in cmd_stash(), as it comes after the
subcommand.  Consequently, from now on it will emit the usage of the
'push' subcommand instead of the usage of 'git stash'.  We had a
failing test for this case, which can now be flipped to expect
success.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/stash.c  | 53 ++++++++++++++++++++++--------------------------
 t/t3903-stash.sh |  2 +-
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a14e832e9f..1ba24c1173 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1739,6 +1739,11 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			     include_untracked, only_staged);
 }
 
+static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
+{
+	return push_stash(argc, argv, prefix, 0);
+}
+
 static int save_stash(int argc, const char **argv, const char *prefix)
 {
 	int keep_index = -1;
@@ -1787,15 +1792,28 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	pid_t pid = getpid();
 	const char *index_file;
 	struct strvec args = STRVEC_INIT;
-
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("apply", &fn, apply_stash),
+		OPT_SUBCOMMAND("clear", &fn, clear_stash),
+		OPT_SUBCOMMAND("drop", &fn, drop_stash),
+		OPT_SUBCOMMAND("pop", &fn, pop_stash),
+		OPT_SUBCOMMAND("branch", &fn, branch_stash),
+		OPT_SUBCOMMAND("list", &fn, list_stash),
+		OPT_SUBCOMMAND("show", &fn, show_stash),
+		OPT_SUBCOMMAND("store", &fn, store_stash),
+		OPT_SUBCOMMAND("create", &fn, create_stash),
+		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
+		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
 	git_config(git_stash_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_DASHDASH);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_DASHDASH);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
@@ -1804,33 +1822,10 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (!argc)
-		return !!push_stash(0, NULL, prefix, 0);
-	else if (!strcmp(argv[0], "apply"))
-		return !!apply_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "clear"))
-		return !!clear_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "drop"))
-		return !!drop_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "pop"))
-		return !!pop_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "branch"))
-		return !!branch_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "list"))
-		return !!list_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "show"))
-		return !!show_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "store"))
-		return !!store_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "create"))
-		return !!create_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "push"))
-		return !!push_stash(argc, argv, prefix, 0);
-	else if (!strcmp(argv[0], "save"))
-		return !!save_stash(argc, argv, prefix);
-	else if (*argv[0] != '-')
-		usage_msg_optf(_("unknown subcommand: %s"),
-			       git_stash_usage, options, argv[0]);
+	if (fn)
+		return !!fn(argc, argv, prefix);
+	else if (!argc)
+		return !!push_stash_unassumed(0, NULL, prefix);
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2a4c3fd61c..376cc8f4ab 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -25,7 +25,7 @@ test_expect_success 'usage on main command -h emits a summary of subcommands' '
 	grep -F "or: git stash show" usage
 '
 
-test_expect_failure 'usage for subcommands should emit subcommand usage' '
+test_expect_success 'usage for subcommands should emit subcommand usage' '
 	test_expect_code 129 git stash push -h >usage &&
 	grep -F "usage: git stash [push" usage
 '
-- 
2.37.2.817.g36f84ce71d

