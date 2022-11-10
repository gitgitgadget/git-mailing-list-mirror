Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C746C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiKJQgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiKJQgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:36:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C03F070
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:41 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y4so1832119plb.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YAScvM74QtH4Iem9LRxMY8zFdM8lGAZ3QAOOjU8Ob8=;
        b=pFLzwG3z38G/e5i+8ZBeTwKmop2B2Kg9/9Lmh87cNHFcvL1OY2WCO5tHUe07cvNLdm
         0+VHdATkiJn9HfL2vSAziCljqnvvl/73OQy1RbSqbYOEwzqqjNQEp8Cwv6Yqd/4DQCO2
         NWJ+A2c381+ZZvGB2N1Qs1PbS94xC/DDq3dc2IduXCdsVIzbBOnuSJIZNO3TEC0dYt78
         fMFmER3dnKyni52NKPnPmLxjdSnOvSInu8g1sWZG+kc+/1XcADlAB9qYiBO8EifXsAcx
         bRbzF0AekWIPsitM6T1aowTkuBZAyUupsOTEb3qF8oEFWrLPqnEe3MIzbAYv1sxS0BGh
         frpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YAScvM74QtH4Iem9LRxMY8zFdM8lGAZ3QAOOjU8Ob8=;
        b=TPawlf2SN7unwHvpLydvCaq6Z1M/RlEkxkqezadGs7UeVzFGehsYZOOps6IlhO4wC1
         5+3Z+8otd2nocy61LsvnLl7YR1MF0vqNm8AYc91MGXRkILx/hD9/XKN/0KUZ66l0mL8h
         1cs0ZIf/C+CtKzxSJYT4fG9Z9UqIPC891N+4PspgC+nA/SXJCEcApgSo1152l0Dx36eV
         tiUyXJb0fCc6/gyJ4yCCCGhB7y4rxbjgrb2YolBUvyaJPZga3QWAL1GMqUp+1gKVmOhB
         2VWmpkENUk+RAY273jcFV/7SZcGHceGMZvjX/sIx4uAUM4Cfi6ItKPgjGF+dP4Yqto2m
         vJzw==
X-Gm-Message-State: ACrzQf2pea1vCz2FQ89SV5g434aBeH9kNljocUbgXLg7S0zx9j73pIe5
        20QORO5UQfaAaxslDGibGnZ2eJ9BRGg=
X-Google-Smtp-Source: AMsMyM5X3sgtOoQeFfUr402R8vHdSxYP+6IWpMzJBB8i1NGoo3QSloUgjm+eqkkD16+Pgrk+dn2Jsw==
X-Received: by 2002:a17:903:2446:b0:187:11c6:6a1b with SMTP id l6-20020a170903244600b0018711c66a1bmr58327705pls.39.1668098200178;
        Thu, 10 Nov 2022 08:36:40 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id b29-20020a631b5d000000b0047022e07035sm9371372pgm.47.2022.11.10.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:36:39 -0800 (PST)
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
Subject: [PATCH v3 3/3] bisect--helper: parse subcommand with OPT_SUBCOMMAND
Date:   Thu, 10 Nov 2022 23:36:22 +0700
Message-Id: <b67691f600d4a0bc800fda5c8d19e447c4a743e2.1668097286.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097286.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com> <cover.1668097286.git.congdanhqx@gmail.com>
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
index d425555d1f..6e41cbdb2d 100644
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

