Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCABAC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 04:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B22A233EF
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 04:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbhAUEUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 23:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbhAUEOf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 23:14:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230EC061786
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 20:13:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e6so782702pjj.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 20:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pSKv3Xw0cVrFEHDfQ6AZ0/ZuzaN2xtw8zTsCzYqmTI=;
        b=a9V+vV6DI8qHqD6rbeTIUYiad9TUwBaFf4fYZtMVBnDpJuUxL6V6wvFENicKHtm6GS
         9+MYJeFDpCb+Tz/YqtQbg+J0RpxA3dMxKEghRqJ6NhaIusII+tAziTMbhXPaeuVyZMpK
         CGfXFOOCNxtp62RMWqLfMcSNKAVRZTeyuQhSTovsr7o7OEksruwrGXIi/+2ggBZX6al1
         Z4EZ9SNN8fFYLA67ia7MWfbbK6o+QHDgdifteBGhqkaZ+CuLyJI7V+8PzTNTZ5TZq4V6
         IU1ud1F0Pqm1Pc8VYmVX6u1UyZTfdA320FrTCZ1St5biqZvGlgo0WkuELTZHvq0mMSUi
         jqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pSKv3Xw0cVrFEHDfQ6AZ0/ZuzaN2xtw8zTsCzYqmTI=;
        b=qvR+oCogOvQZOjPp8ePjjMUfB6wwF+OHPswr+Gpmjp+/brwP2Lpn2RKjVgGy4lQ+x2
         IbwjUaY325MuLfuugSzl6SwJ6c46ZisoTj8KK/BFs1Wr0UFdPEn3gv/8p14VV2Ug7JVp
         S5PCgXEpJbq41tJwtKNGd4WTcK0zq5CHn8/uL5xNQvtwwhNEbYVLSwibcIUQnG3Vbn+a
         LV/bpH0SDOS1O4+QyboGLdFU+554ejUUR8vvQs87f2TrU/h4fv2sR0gCfQAQd9v+Qj16
         ZeByQ6SD1SE5wH3uEgk5KT3U1C7qw1Iq90uVAVycSAObf9IEn7UjNRwpLNQAL24EROVq
         XS3w==
X-Gm-Message-State: AOAM530PC5xw0dHFjMLFYZqPp9GMY9+VBcLvC1rkTnGnX8imQupYe8cs
        1+JbjFJdWvdQbVpgygQF6lAnPxj3FPqktg==
X-Google-Smtp-Source: ABdhPJyo6WVQYlVoEC9LFPEvByKH3J5lLO5vcAc5yBIi+CKik1Jy2ppDoHMWYoPTpdm+vFFcC3QN6w==
X-Received: by 2002:a17:902:ecca:b029:de:b5bc:c852 with SMTP id a10-20020a170902eccab02900deb5bcc852mr13045774plh.59.1611202423130;
        Wed, 20 Jan 2021 20:13:43 -0800 (PST)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id v125sm3866175pgv.6.2021.01.20.20.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 20:13:42 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] rebase: add a config option for --no-fork-point
Date:   Wed, 20 Jan 2021 21:13:20 -0700
Message-Id: <20210121041320.66192-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users (myself included) would prefer to have this feature off by
default because it can silently drop commits.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/rebase.txt |  3 +++
 builtin/rebase.c                | 20 +++++++++++++-------
 t/t3431-rebase-fork-point.sh    | 10 ++++++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 7f7a07d22f..8531a4b3f7 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -68,3 +68,6 @@ rebase.rescheduleFailedExec::
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
 	This is the same as specifying the `--reschedule-failed-exec` option.
+
+rebase.forkPoint:
+	If set to false set `--no-fork-point` option by default.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 840dbd7eb7..de400f9a19 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -102,6 +102,7 @@ struct rebase_options {
 	int reschedule_failed_exec;
 	int use_legacy_rebase;
 	int reapply_cherry_picks;
+	int fork_point;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -111,7 +112,8 @@ struct rebase_options {
 		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = STRVEC_INIT,		\
-		.git_format_patch_opt = STRBUF_INIT	\
+		.git_format_patch_opt = STRBUF_INIT,	\
+		.fork_point = -1,			\
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -1095,6 +1097,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.forkpoint")) {
+		opts->fork_point = git_config_bool(var, value) ? -1 : 0;
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.usebuiltin")) {
 		opts->use_legacy_rebase = !git_config_bool(var, value);
 		return 0;
@@ -1306,7 +1313,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
-	int fork_point = -1;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1406,7 +1412,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
-		OPT_BOOL(0, "fork-point", &fork_point,
+		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
 			   N_("strategy"), N_("use the given merge strategy")),
@@ -1494,7 +1500,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("cannot combine '--keep-base' with '--root'"));
 	}
 
-	if (options.root && fork_point > 0)
+	if (options.root && options.fork_point > 0)
 		die(_("cannot combine '--root' with '--fork-point'"));
 
 	if (action != ACTION_NONE && !in_progress)
@@ -1840,8 +1846,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 								    NULL);
 			if (!options.upstream_name)
 				error_on_missing_default_upstream();
-			if (fork_point < 0)
-				fork_point = 1;
+			if (options.fork_point < 0)
+				options.fork_point = 1;
 		} else {
 			options.upstream_name = argv[0];
 			argc--;
@@ -1945,7 +1951,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
-	if (fork_point > 0) {
+	if (options.fork_point > 0) {
 		struct commit *head =
 			lookup_commit_reference(the_repository,
 						&options.orig_head);
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 172562789e..e48c4014cf 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -74,4 +74,14 @@ test_expect_success 'git rebase --fork-point with ambigous refname' '
 	test_must_fail git rebase --fork-point --onto D one
 '
 
+test_expect_success '--fork-point and --root both given' '
+	test_must_fail git rebase --fork-point --root 2>err &&
+	test_i18ngrep "cannot combine" err
+'
+
+test_expect_success 'rebase.forkPoint true and --root given' '
+	test_config rebase.forkPoint true &&
+	git rebase --root
+'
+
 test_done
-- 
2.30.0

