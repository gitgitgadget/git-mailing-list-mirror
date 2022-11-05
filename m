Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832FC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKERIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiKERIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C76E0E7
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso7001785pjc.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLtn2UgEFhBjn81VD+LMZdx9s2ftrF+8mDbiPHHDVak=;
        b=mKKQx/rz1tJwgoqcIAFbLc/z0ZEYfdKi8nmUgNo/rukLtV3bcga0kVoh3zqFTZZvnO
         9NWwqptyVad3ewI5i60q4fLfzywfH2Gto8yoVKxVeqI9h2s798OjVjsMg7qNEygaWG2g
         b99ug0JbcrlyWLA2hX+1XE9eWDl111lfDt/HyBu0SJ6D3dsdhDjnGV5weV1DT3CExv7v
         6I1dzdy8i+fnD8YoGqvMQIvh4eaERgnUIoS23wjqAEt2dG2OgtwyE4drMZK07YJQJKZE
         h0oyOUZZcMTem9FgYm33ymSFYvgSx0HMjy6fATvYdkTWj+DAJW9H6JKgm+iSukAViFQG
         v5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLtn2UgEFhBjn81VD+LMZdx9s2ftrF+8mDbiPHHDVak=;
        b=S/A4kF15brFbVfZA45Pu7K4YwmNGsKR9LzoFu/0DMBO+6wTBEjj6NdfU6M9Xv+gK5H
         z2t0Mu0pWI3LCEn3nMV3w94PpkxpOb1v3L8CrpFLk+kFTpvS21p5+8opW9G1OndOkb8p
         Nl+5Z0nfTwybbMtToK8f8lCGPwrb1SXSZpzKEJTaRfR4gvus+Knyah3Myd+f4cW5MN+z
         LtaBFHBPZIbXmqWfKBuWQzPrG6xrCEnCRaEQvgumYl/MwAKq0nIsAsuTv3TRX2JySH91
         hf2j2YRwXv/5/fSaZ+LCnuM1ZJ8zXy9ptFdXFi1M9hE1eok3NUaa+Yc1KZBvloitzilZ
         bNdQ==
X-Gm-Message-State: ANoB5plo+G3dG36rtw1dDHwPjFmK4n35mW8gz3GzgwilqUicbYNBoy/R
        C5xbM00nkNyC38WFCvteknhEMhX5sH0=
X-Google-Smtp-Source: AA0mqf5JZfaC3ENgcgUuINWm4ilCLxmydoZDIh3uKnJ+opLG8SZVo++AAKVbFzZLqZ416s4rF094cw==
X-Received: by 2002:a17:902:f652:b0:188:71b0:de66 with SMTP id m18-20020a170902f65200b0018871b0de66mr4198734plg.65.1667668099237;
        Sat, 05 Nov 2022 10:08:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:18 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 09/13] bisect--helper: emit usage for "git bisect"
Date:   Sun,  6 Nov 2022 00:07:40 +0700
Message-Id: <b494a4cf4ecfbe1768b5879c3f70891f651f2529.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
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
index 6be4d8861e..bfa160dbf2 100644
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
 
@@ -1413,11 +1435,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

