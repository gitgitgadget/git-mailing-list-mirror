Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96986C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiKDLkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKDLkd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:40:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC02CDE1
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:40:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k15so4299768pfg.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubtVdZipZS5W3KZeBgEFygkHS3EN6DreLxs3aSePvzw=;
        b=Y721tpTwh2smdJlslqFvI+oUUkv0fhWB44htUVSwK1pLnyIBwmIjAp7Pux/6+2qRwB
         C42BBJBm5auMcMXycv2WR4hETG9hU+/H9Le340LhCqVGpJsR6pOnDIHeueeInc1m39tK
         OL/YQv8SlwedD+hbEnSOVVvBGfPiUxBKifryyvTymKnmRH1orM/4wLvcOfTzJ4YI/Kup
         TcIaYO7C05GK4GQcjgbN+Jv+usxb//wpFJGHcZT50LU72zJOG/k0sBtPGF32IuoNREtj
         Qzyfs4DHsbzvyifF3jdfniB3X3pfe13uuqHSMyE/3pJr/WkDSP7ZdC5OiFFtBa9s5lLR
         qdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubtVdZipZS5W3KZeBgEFygkHS3EN6DreLxs3aSePvzw=;
        b=EfYSi4MnNVZN85f4tqX89mn4cKt+fg81gzY8OIJ8y1pnP/z1qyzakiTP5TNdREaMdJ
         4J6CVSW+xs1+Sn/HbPDsm9ZkKFDWvcu66hBQudeTK7u5s6S3ikdro72qeCHzIjR6O26l
         zuM+y4W8DuPRnpBUbJUMF/xauP1vsNQw3tPti0MhfUsRA1qNOdjtXyl7v6ayfNJA2zqu
         jdWrJ+iH70NylIhUlEJpuMVgOh1UMdrBnsuK9FqROY4XWC6jqRsUlVjAWeNJqxVv/Bzf
         xrFyBE5381xryu+dPq4mbSWEfI8ko2/g3EcA+EmCNrvLGWyE718apsrHaUMXgnO9uMgl
         FWXw==
X-Gm-Message-State: ACrzQf02cGlUBXKws/0Wx80oKww0/eoPTIV7o0V7/1fFdLBLBo8awY5S
        uoFjsIkbAz5grhMDbRRGbmPzyfTccsk=
X-Google-Smtp-Source: AMsMyM4msjjgHD+ll7y3rxJsoO7MeHkW67jW+UopIL3ZofNTdb9CgN4nGhd5y3KWFrWstxOysymjxA==
X-Received: by 2002:a05:6a00:1595:b0:56d:e04d:e0ab with SMTP id u21-20020a056a00159500b0056de04de0abmr17007885pfk.51.1667562031021;
        Fri, 04 Nov 2022 04:40:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id l24-20020a63ea58000000b0043c22e926f8sm2203133pgk.84.2022.11.04.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:40:30 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] bisect--helper: parse subcommand with OPT_SUBCOMMAND
Date:   Fri,  4 Nov 2022 18:40:12 +0700
Message-Id: <76c585d22bf415e719762fcf5decf4b71efa5bfb.1667561761.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667561761.git.congdanhqx@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of it is, we're parsing subcommand with OPT_CMDMODE, which will
continue to parse more options even if the command has been found.

When we're running "git bisect run" with a command that expecting
a "--log" or "--no-log" arguments, or one of those "--bisect-..."
arguments, bisect--helper may mistakenly think those options are
bisect--helper's option.

We may fix those problems by passing "--" when calling from
git-bisect.sh, and skip that "--" in bisect--helper. However, it may
interfere with user's "--".

Let's parse subcommand with OPT_SUBCOMMAND since that API was born for
this specific use-case.

Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c    | 86 +++++++------------------------------
 git-bisect.sh               | 20 ++++-----
 t/t6030-bisect-porcelain.sh | 10 +++++
 3 files changed, 36 insertions(+), 80 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 292c6fd1dd..c37cb89a90 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1392,84 +1392,30 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_RESET = 1,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_AUTOSTART,
-		BISECT_NEXT,
-		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
-		BISECT_SKIP,
-		BISECT_VISUALIZE,
-		BISECT_RUN,
-	} cmdmode = 0;
 	int res = 0;
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
+		OPT_SUBCOMMAND("bisect-reset", &fn, cmd_bisect__reset),
+		OPT_SUBCOMMAND("bisect-terms", &fn, cmd_bisect__terms),
+		OPT_SUBCOMMAND("bisect-start", &fn, cmd_bisect__start),
+		OPT_SUBCOMMAND("bisect-next", &fn, cmd_bisect__next),
+		OPT_SUBCOMMAND("bisect-state", &fn, cmd_bisect__state),
+		OPT_SUBCOMMAND("bisect-log", &fn, cmd_bisect__log),
+		OPT_SUBCOMMAND("bisect-replay", &fn, cmd_bisect__replay),
+		OPT_SUBCOMMAND("bisect-skip", &fn, cmd_bisect__skip),
+		OPT_SUBCOMMAND("bisect-visualize", &fn, cmd_bisect__visualize),
+		OPT_SUBCOMMAND("bisect-run", &fn, cmd_bisect__run),
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     git_bisect_helper_usage, 0);
 
-	if (!cmdmode)
+	if (!fn)
 		usage_with_options(git_bisect_helper_usage, options);
+	argc--;
+	argv++;
 
-	switch (cmdmode) {
-	case BISECT_RESET:
-		res = cmd_bisect__reset(argc, argv, prefix);
-		break;
-	case BISECT_TERMS:
-		res = cmd_bisect__terms(argc, argv, prefix);
-		break;
-	case BISECT_START:
-		res = cmd_bisect__start(argc, argv, prefix);
-		break;
-	case BISECT_NEXT:
-		res = cmd_bisect__next(argc, argv, prefix);
-		break;
-	case BISECT_STATE:
-		res = cmd_bisect__state(argc, argv, prefix);
-		break;
-	case BISECT_LOG:
-		res = cmd_bisect__log(argc, argv, prefix);
-		break;
-	case BISECT_REPLAY:
-		res = cmd_bisect__replay(argc, argv, prefix);
-		break;
-	case BISECT_SKIP:
-		res = cmd_bisect__skip(argc, argv, prefix);
-		break;
-	case BISECT_VISUALIZE:
-		res = cmd_bisect__visualize(argc, argv, prefix);
-		break;
-	case BISECT_RUN:
-		res = cmd_bisect__run(argc, argv, prefix);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
-	}
+	res = fn(argc, argv, prefix);
 
 	/*
 	 * Handle early success
diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a..07a7257be4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -58,26 +58,26 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		git bisect--helper --bisect-start "$@" ;;
+		git bisect--helper bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
+		git bisect--helper bisect-state "$cmd" "$@" ;;
 	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
+		git bisect--helper bisect-skip "$@" || exit;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
+		git bisect--helper bisect-next "$@" || exit ;;
 	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
+		git bisect--helper bisect-visualize "$@" || exit;;
 	reset)
-		git bisect--helper --bisect-reset "$@" ;;
+		git bisect--helper bisect-reset "$@" ;;
 	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
+		git bisect--helper bisect-replay "$@" || exit;;
 	log)
-		git bisect--helper --bisect-log || exit ;;
+		git bisect--helper bisect-log || exit ;;
 	run)
-		git bisect--helper --bisect-run "$@" || exit;;
+		git bisect--helper bisect-run "$@" || exit;;
 	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
+		git bisect--helper bisect-terms "$@" || exit;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482f..a17027d574 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -266,6 +266,16 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+# We want to make sure --log is not eaten
+test_expect_success '"git bisect run" simple case' '
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run printf "%s\n" --log >my_bisect_log.txt &&
+	grep -e --log my_bisect_log.txt &&
+	git bisect reset
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
-- 
2.38.1.157.gedabe22e0a

