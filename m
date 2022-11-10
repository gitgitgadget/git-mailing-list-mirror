Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27930C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiKJQht (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiKJQhf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:35 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4842F44
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b62so2366047pgc.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czEInH5324+mQVHDisgby16/etFJ1Zunl5Zn7RZAEg8=;
        b=jpubXABJ3aserG8wicxRA2dX6oEU5/yWC02zzJquJZu+E8sQC77NNbX6JjPt2mqoNY
         Vd9pPKVELT0cWkxjnL2JYJWymh7EulSAt0yuiMU8HQymVOKXLamDC5CGmGOIJzzkcHgK
         KCWXe0liCBtdx5Ra5+YHuChkL51sQmzQ5YmY4TxDug3py2oSUd5qPqAXF8l0o2kKGHhv
         mibuGO8Q5K5hRmudO0+W6YzZYdUZXsDPfDiA77+TQHt20/ERzuDNVBeGy9AM7zCPG1JT
         eJpxaalJ9HZnTzLTsAKbEGB3f8KwNSKmCfY3ZWplAcGXvp+lDd+iDfTlnFv9SiPkXsXz
         XRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czEInH5324+mQVHDisgby16/etFJ1Zunl5Zn7RZAEg8=;
        b=2UU57+gdBpXC9AeqKrJIuxPEoqKBlOrORTRHDk0/03b/dDqYDacAc8eiuKGVGK0W/W
         iVZOflP7kAVTjjZFuOguPfMt0gQC2mHf8bE/ALbzTXlFFkhOEyKck39s0AMMGBRQbmyT
         al4z/1vfXJWF5XIuUL7vQSIzxy0vtTLgLIJbFckzOgETpP3V3eQkSAyPZ8VT7ttkCQ7d
         fBS99dYntqVyrJ7lH7PSthk2hwo0VqzuY383Rl9BozF5IxgZkozDVQaxfqhWE0j75TVH
         ITMVu/H9LYkmlNWL+6/0KE4ENxz9B27mUaTW86rwy5DVkVgZ5uiR6Fcze/VYri//oyDi
         Xtuw==
X-Gm-Message-State: ACrzQf0tlG4jWsiyXnORyH7DP59R11e1BMGA85FRNFLKyyoc4NU7u32w
        0iKxepNpNThEllej0inaRgf6SraD/pg=
X-Google-Smtp-Source: AMsMyM41woNHGLHJyFTyR87LrnUK879zj313JQ0ZQGdHgxndP8rnfn4TT/r3pxMjWdZInMlLXT/gag==
X-Received: by 2002:a62:d118:0:b0:56c:dba2:30b with SMTP id z24-20020a62d118000000b0056cdba2030bmr2948598pfg.72.1668098244982;
        Thu, 10 Nov 2022 08:37:24 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:24 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 08/11] bisect--helper: emit usage for "git bisect"
Date:   Thu, 10 Nov 2022 23:36:43 +0700
Message-Id: <4500867d56d688a5b799ca25bb935bc3ec1f6c6d.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

In subsequent commits we'll be removing "git-bisect.sh" in favor of
promoting "bisect--helper" to a "bisect" built-in.

In doing that we'll first need to have it support "git bisect--helper
<cmd>" rather than "git bisect--helper --<cmd>", and then finally have
its "-h" output claim to be "bisect" rather than "bisect--helper".

Instead of suffering that churn let's start claiming to be "git
bisect" now. In just a few commits this will be true, and in the
meantime emitting the "wrong" usage information from the helper is a
small price to pay to avoid the churn.

Let's also declare "BUILTIN_*" macros, when we eventually migrate the
sub-commands themselves to parse_options() we'll be able to re-use the
strings. See 0afd556b2e1 (worktree: define subcommand -h in terms of
command -h, 2022-10-13) for a recent example.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 51 ++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f28bedac6a..1ff2d4ea3f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,18 +20,40 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
-static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --bisect-reset [<commit>]"),
-	"git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]",
-	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
-					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
-	"git bisect--helper --bisect-next",
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
-	N_("git bisect--helper --bisect-replay <filename>"),
-	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
-	"git bisect--helper --bisect-visualize",
-	N_("git bisect--helper --bisect-run <cmd>..."),
+#define BUILTIN_GIT_BISECT_START_USAGE \
+	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]" \
+	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
+	   "    [<pathspec>...]")
+#define BUILTIN_GIT_BISECT_STATE_USAGE \
+	N_("git bisect (good|bad) [<rev>...]")
+#define BUILTIN_GIT_BISECT_TERMS_USAGE \
+	"git bisect terms [--term-good | --term-bad]"
+#define BUILTIN_GIT_BISECT_SKIP_USAGE \
+	N_("git bisect skip [(<rev>|<range>)...]")
+#define BUILTIN_GIT_BISECT_NEXT_USAGE \
+	"git bisect next"
+#define BUILTIN_GIT_BISECT_RESET_USAGE \
+	N_("git bisect reset [<commit>]")
+#define BUILTIN_GIT_BISECT_VISUALIZE_USAGE \
+	"git bisect visualize"
+#define BUILTIN_GIT_BISECT_REPLAY_USAGE \
+	N_("git bisect replay <logfile>")
+#define BUILTIN_GIT_BISECT_LOG_USAGE \
+	"git bisect log"
+#define BUILTIN_GIT_BISECT_RUN_USAGE \
+	N_("git bisect run <cmd>...")
+
+static const char * const git_bisect_usage[] = {
+	BUILTIN_GIT_BISECT_START_USAGE,
+	BUILTIN_GIT_BISECT_STATE_USAGE,
+	BUILTIN_GIT_BISECT_TERMS_USAGE,
+	BUILTIN_GIT_BISECT_SKIP_USAGE,
+	BUILTIN_GIT_BISECT_NEXT_USAGE,
+	BUILTIN_GIT_BISECT_RESET_USAGE,
+	BUILTIN_GIT_BISECT_VISUALIZE_USAGE,
+	BUILTIN_GIT_BISECT_REPLAY_USAGE,
+	BUILTIN_GIT_BISECT_LOG_USAGE,
+	BUILTIN_GIT_BISECT_RUN_USAGE,
 	NULL
 };
 
@@ -1411,11 +1433,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("run", &fn, cmd_bisect__run),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_bisect_usage, 0);
 
 	if (!fn)
-		usage_with_options(git_bisect_helper_usage, options);
+		usage_with_options(git_bisect_usage, options);
 	argc--;
 	argv++;
 
-- 
2.38.1.157.gedabe22e0a

