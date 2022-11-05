Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FBC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKEREG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKEREC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:04:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E99DFDF
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:04:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b62so6957635pgc.0
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESRDjZPiNWu0shLf4bPQ/4AgL4vk+o/cRKgrahfNS0A=;
        b=HEwTq5V/4FTYD05VbD6kio7tnRt81qymNQfo8pxRDkx87TnKdrwflgLxVKxaW17Z1K
         ELOkf4s/sv/V1v+yCS2YRcS69xtrdy9Ru0jFe1CptbdcHLgWIwQR3siAuTtC2OLGd6I+
         vTvwjeGfQ0GkLf2abyOEu/nDp9/e1HAKxrzPphL1Xyklh8nuKDpysdmHKd3ln+R/HoEE
         GN4ZURzdvRgIOz6qPA15P8pWYYOlSy9IN5LgIGPclphgdZQmPuUJQAS8vYiLn9AEqv42
         QSoae75C8q1IJCzr3Sm3vo7EV2redkG5Sc02sUoFQYSCGzxEyIG6sCuZnI1HpLjdgMLk
         ng4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESRDjZPiNWu0shLf4bPQ/4AgL4vk+o/cRKgrahfNS0A=;
        b=R0HpA5gXsE/VSA9uOyvMaJgoz71AFfrzYaCYeSX1AbratgUUyrH6U5nuwadttp1ZR7
         PVGoXHnC879DoSJUKcuEeEVr8caPUqCqyfUSORcCUKQ8rcE9stdRCnSsCsfFjmKgU5QL
         sj9ayD3+tfTCyIPYeJOTUS/TjzdqHytXwU9CzdhgJKbB9INz+I34EBcI2bVruZZxX8rT
         Vvav8kVplSBfYQRZIN8AgVFPFmwpUOPuoeQGe7tg7odUYmQIQAN3trrAB+K4J7K5TNjt
         WoG3zB0zCioaiF0OTPvKKOndkgVxsAKcjnttuodPzBlq3r/sL0DDAuc2XTuONkjYs6FD
         j33g==
X-Gm-Message-State: ACrzQf0K2lcNwGBgqQDs1FJCqLgi5GZL7GGWWaTQ89G/O1e+jZdts1mc
        qbryPyahSuYQL40o8jJ+9Q3llFNi80Q=
X-Google-Smtp-Source: AMsMyM6Sw6WAoBwEUAjyoBFtKHb6b2BX3g3VWR54N7K/PQeLwrf7MjAw41wWc7ATuRFcA8Ax/OTzHA==
X-Received: by 2002:a05:6a00:2294:b0:56d:7387:8a06 with SMTP id f20-20020a056a00229400b0056d73878a06mr32991288pfe.17.1667667840618;
        Sat, 05 Nov 2022 10:04:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b0016c0c82e85csm1910789plb.75.2022.11.05.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:04:00 -0700 (PDT)
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
Subject: [PATCH v2 3/3] bisect--helper: parse subcommand with OPT_SUBCOMMAND
Date:   Sun,  6 Nov 2022 00:03:36 +0700
Message-Id: <a62ac72e241fee67e799abcd04ff54a04abd4f53.1667667058.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667058.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com> <cover.1667667058.git.congdanhqx@gmail.com>
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
 builtin/bisect--helper.c    | 87 ++++++++-----------------------------
 git-bisect.sh               | 23 ++--------
 t/t6030-bisect-porcelain.sh | 10 +++++
 3 files changed, 30 insertions(+), 90 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 292c6fd1dd..d4d813ebfc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1392,84 +1392,31 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 
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
+		OPT_SUBCOMMAND("reset", &fn, cmd_bisect__reset),
+		OPT_SUBCOMMAND("terms", &fn, cmd_bisect__terms),
+		OPT_SUBCOMMAND("start", &fn, cmd_bisect__start),
+		OPT_SUBCOMMAND("next", &fn, cmd_bisect__next),
+		OPT_SUBCOMMAND("state", &fn, cmd_bisect__state),
+		OPT_SUBCOMMAND("log", &fn, cmd_bisect__log),
+		OPT_SUBCOMMAND("replay", &fn, cmd_bisect__replay),
+		OPT_SUBCOMMAND("skip", &fn, cmd_bisect__skip),
+		OPT_SUBCOMMAND("visualize", &fn, cmd_bisect__visualize),
+		OPT_SUBCOMMAND("view", &fn, cmd_bisect__visualize),
+		OPT_SUBCOMMAND("run", &fn, cmd_bisect__run),
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
index 405cf76f2a..dfce4b4f44 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -57,28 +57,11 @@ case "$#" in
 	case "$cmd" in
 	help)
 		git bisect -h ;;
-	start)
-		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
-	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
-	next)
-		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
-	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
-	reset)
-		git bisect--helper --bisect-reset "$@" ;;
-	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
+		git bisect--helper state "$cmd" "$@" ;;
 	log)
-		git bisect--helper --bisect-log || exit ;;
-	run)
-		git bisect--helper --bisect-run "$@" || exit;;
-	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
+		git bisect--helper log || exit ;;
 	*)
-		usage ;;
+		git bisect--helper "$cmd" "$@" ;;
 	esac
 esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 83931d482f..6dbbe62eb2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -266,6 +266,16 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+# We want to make sure no arguments has been eaten
+test_expect_success '"git bisect run" simple case' '
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run printf "%s %s\n" reset --bisect-skip >my_bisect_log.txt &&
+	grep -e "reset --bisect-skip" my_bisect_log.txt &&
+	git bisect reset
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
-- 
2.38.1.157.gedabe22e0a

