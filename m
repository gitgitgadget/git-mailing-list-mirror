Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87114C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiKJQhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiKJQhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044A42F4A
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j12so1821725plj.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJX62qbyJIRbryXs5jkbGfdp860Eyj33etQdG7P7jQY=;
        b=D+krJLO8KRtZFNG8CCsvAfy8gWXkeMAIpB+YXpAo/LqL8RgN8O1G4AJEyAmrqhU3Wy
         lSjHxx4lTL2iQlObKUN3QnOkSViTVa/yNc3Ae5VrLf/ezg9gt3okJ9v8xpi/vpQUSbGn
         23UmdiJwoyN+QGNAY4LoFOpl4I/0YDsswO3AMFOL3KW8FdfqBkrQ7r7+lySHPkUvfSvQ
         CQWauqhRS4Ewwpw7SuADjeSf69LYN4WCmsMfoZwuAYGgztSAROctrycurYhHNQlfTF8G
         Op8411A0nikzhtBrUykZs5qPzKjniVsQA9MXPYnF06aJVq5OyI72DbxBe3t67aFI4IiM
         snVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJX62qbyJIRbryXs5jkbGfdp860Eyj33etQdG7P7jQY=;
        b=f7M1GQndNgIX6coWT+eXBlREqysNDl7IyoRggVWGEr8JuZdIKrdqJPZphPh4QTryRr
         v8C2hR7KEztdq+YXh6U5nuVVJVJ37r9W4wEeiwzwXpOPU1s9rD+8NQI8zKfmZYdmmYf/
         JKEPzjsqDWDpDzJ4aXlf3F+TBI7TxdaBP3Xp0LzZwjQDWpxi9nr7TSk76MGIMeDQ/9Tf
         EE6tjPM+65FxXZj02NDXoV7101y6dduWM4l+y+nHOhNWHmImdZ3PZ03Ad3jmaorPHyry
         2/xL7/IgXKcFJw7chslFOlMR4zOuMoKH9Rh6cdCIWnuLBhIzH3M3mnl9J7P6NiOHSsNs
         Um3w==
X-Gm-Message-State: ACrzQf1Us6CqBF2xsQqrJBHoLzPV/7XdOD6mUy/qI9PQOwypdYj3Zec0
        1s+4+H/MbI7r1yZCOMfbmzIlYsW3LrU=
X-Google-Smtp-Source: AMsMyM6OoAxQxBUgI4/i1/tVyulVhfbFfYhS36ZYNyZuLBMw3o5T1arn755F4DN4GUhjc5IBMX7nNg==
X-Received: by 2002:a17:902:c745:b0:186:b287:7d02 with SMTP id q5-20020a170902c74500b00186b2877d02mr66371704plq.87.1668098248733;
        Thu, 10 Nov 2022 08:37:28 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:28 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 09/11] bisect--helper: handle states directly
Date:   Thu, 10 Nov 2022 23:36:44 +0700
Message-Id: <3752c0348b251e066729782729704c91486ed6c5.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. eliminate the need of `state` subcommand.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 42 ++++++++++++++++++++--------------------
 git-bisect.sh            |  2 --
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1ff2d4ea3f..29d5a26c64 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1347,18 +1347,6 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	return res;
 }
 
-static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNUSED)
-{
-	int res;
-	struct bisect_terms terms = { 0 };
-
-	set_terms(&terms, "bad", "good");
-	get_terms(&terms);
-	res = bisect_state(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
-}
-
 static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
 {
 	if (argc)
@@ -1424,7 +1412,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("terms", &fn, cmd_bisect__terms),
 		OPT_SUBCOMMAND("start", &fn, cmd_bisect__start),
 		OPT_SUBCOMMAND("next", &fn, cmd_bisect__next),
-		OPT_SUBCOMMAND("state", &fn, cmd_bisect__state),
 		OPT_SUBCOMMAND("log", &fn, cmd_bisect__log),
 		OPT_SUBCOMMAND("replay", &fn, cmd_bisect__replay),
 		OPT_SUBCOMMAND("skip", &fn, cmd_bisect__skip),
@@ -1433,14 +1420,27 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("run", &fn, cmd_bisect__run),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, prefix, options, git_bisect_usage, 0);
-
-	if (!fn)
-		usage_with_options(git_bisect_usage, options);
-	argc--;
-	argv++;
-
-	res = fn(argc, argv, prefix);
+	argc = parse_options(argc, argv, prefix, options, git_bisect_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+
+	if (!fn) {
+		struct bisect_terms terms = { 0 };
+
+		if (!argc)
+			usage_msg_opt(_("need a command"), git_bisect_usage, options);
+
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (check_and_set_terms(&terms, argv[0]))
+			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
+				       options, argv[0]);
+		res = bisect_state(&terms, argv, argc);
+		free_terms(&terms);
+	} else {
+		argc--;
+		argv++;
+		res = fn(argc, argv, prefix);
+	}
 
 	/*
 	 * Handle early success
diff --git a/git-bisect.sh b/git-bisect.sh
index dfce4b4f44..9f6c8cc093 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -57,8 +57,6 @@ case "$#" in
 	case "$cmd" in
 	help)
 		git bisect -h ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper state "$cmd" "$@" ;;
 	log)
 		git bisect--helper log || exit ;;
 	*)
-- 
2.38.1.157.gedabe22e0a

