Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F501F404
	for <e@80x24.org>; Sat,  3 Mar 2018 21:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeCCVKA (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 16:10:00 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35510 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeCCVJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 16:09:59 -0500
Received: by mail-wm0-f44.google.com with SMTP id x7so8899870wmc.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m+Ms0O/0PvI9yBd1YI/3yrr0aTsJ9vPqVctcN6lPN4M=;
        b=HDvjWVMNrjEp7k76PUCNwBHsoI5sHEAaQa3U2+JzPIeELYbyc9xxE3Au9UaShD8hRW
         sbsRLL/uuZPbd8KJxyVqX1WNthyKoDHXlLWoIIOUJULKleOFYB4rQb442mLQVSWCku2F
         yRHJRwa/Nn4M8LHGK/+GwzGJgqHGGTOpbyleslG5YG08OsPVwY7LreQz9Tt/++qzz1KV
         QATe63oHd3nrB30kP/+ZOsjbl/thiZWNPOLgcjr4e/cnd1sKh/tDps+p5vG5y4h4Gmi4
         xHk2ufsM2HI7OBqAVg+/PIO0KI147iS7XGfvb2oJt8tUPAFSXehv2cUnhHDHZIfZEH91
         IRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m+Ms0O/0PvI9yBd1YI/3yrr0aTsJ9vPqVctcN6lPN4M=;
        b=HoP6rxeIbCo7/Kh+Rxsy68xmpkH0WFh8TEcWEgdvUi9H80ysrRu4R7BNnFVJ2HAmAb
         ArdauNsVCDbiSPBsJJQph2BfJRkzYBAf4HYuhf1L+/mTXNfcjRsy3qJyJXhRM45jclAO
         COsb4zrF7Yt/brI/2QfKUKhvgu5s07oRp4vBYIjO/YZ+edojHgY71RKIyC5WRXJrJ/+j
         Qv3Bg2Zl7FsWX0XMCLjh6KQVoPGsccMnbkf60xVrt+CNJ/8ZX2bFaSEGtepEUQun3jhf
         VyKE1D+qDBkIM2E6+yojpqktYMy6HYSlkcNG8U+aGphf9V1QVNrVie+7EcAfBaf1vUwz
         mGRg==
X-Gm-Message-State: AElRT7F+7YU1+vZHGvmnwGOQdJCVnRbKFEA1bxrrElE+kXlvmokNcoHk
        vgRVxsLGGyShq4hsF/B1kxTDCKM9
X-Google-Smtp-Source: AG47ELskwd1bXsVe+yal3BiQ27L6f2Vp/FwxHHt21PiN8hFXp2GKmTLMjsJLGz8j4mYlodyE1ajtmA==
X-Received: by 10.28.87.211 with SMTP id l202mr4212864wmb.32.1520111397857;
        Sat, 03 Mar 2018 13:09:57 -0800 (PST)
Received: from localhost.localdomain (5-13-157-86.residential.rdsnet.ro. [5.13.157.86])
        by smtp.gmail.com with ESMTPSA id p104sm12791967wrb.47.2018.03.03.13.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 13:09:56 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC][PATCH v3] Make options that expect object ids less chatty if id is invalid
Date:   Sat,  3 Mar 2018 23:09:38 +0200
Message-Id: <20180303210938.32474-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.2.346.g22874a30c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually, the usage should be shown only if the user does not know what
options are available. If the user specifies an invalid value, the user
is already aware of the available options. In this case, there is no
point in displaying the usage anymore.

This patch applies to "git tag --contains", "git branch --contains",
"git branch --points-at", "git for-each-ref --contains" and many more.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/update-index.c        |  2 +
 parse-options.c               | 13 +++--
 parse-options.h               |  1 +
 t/t0040-parse-options.sh      |  9 ++--
 t/t3404-rebase-interactive.sh |  2 +-
 t/t3502-cherry-pick-merge.sh  |  8 +--
 t/tcontains.sh                | 92 +++++++++++++++++++++++++++++++++++
 7 files changed, 111 insertions(+), 16 deletions(-)
 create mode 100755 t/tcontains.sh

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 58d1c2d28..eeee1c170 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1060,6 +1060,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		switch (parseopt_state) {
 		case PARSE_OPT_HELP:
 			exit(129);
+		case PARSE_OPT_ERROR:
+			exit(1);
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_DONE:
 		{
diff --git a/parse-options.c b/parse-options.c
index d02eb8b01..eee401662 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -434,7 +434,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
-	int err = 0;
 
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
@@ -459,7 +458,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
-				goto show_usage_error;
+				return PARSE_OPT_ERROR;
 			case -2:
 				if (ctx->opt)
 					check_typos(arg + 1, options);
@@ -472,7 +471,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			while (ctx->opt) {
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
-					goto show_usage_error;
+					return PARSE_OPT_ERROR;
 				case -2:
 					if (internal_help && *ctx->opt == 'h')
 						goto show_usage;
@@ -504,7 +503,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
-			goto show_usage_error;
+			return PARSE_OPT_ERROR;
 		case -2:
 			goto unknown;
 		}
@@ -517,10 +516,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	}
 	return PARSE_OPT_DONE;
 
- show_usage_error:
-	err = 1;
  show_usage:
-	return usage_with_options_internal(ctx, usagestr, options, 0, err);
+	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -543,6 +540,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
+	case PARSE_OPT_ERROR:
+		exit(1);
 	default: /* PARSE_OPT_UNKNOWN */
 		if (ctx.argv[0][1] == '-') {
 			error("unknown option `%s'", ctx.argv[0] + 2);
diff --git a/parse-options.h b/parse-options.h
index af711227a..c77bb3b4f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -188,6 +188,7 @@ enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
 	PARSE_OPT_NON_OPTION,
+	PARSE_OPT_ERROR,
 	PARSE_OPT_UNKNOWN
 };
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 0c2fc81d7..8af12e8a1 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -162,9 +162,9 @@ test_expect_success 'long options' '
 '
 
 test_expect_success 'missing required value' '
-	test_expect_code 129 test-parse-options -s &&
-	test_expect_code 129 test-parse-options --string &&
-	test_expect_code 129 test-parse-options --file
+	test_expect_code 1 test-parse-options -s &&
+	test_expect_code 1 test-parse-options --string &&
+	test_expect_code 1 test-parse-options --file
 '
 
 cat >expect <<\EOF
@@ -214,7 +214,7 @@ test_expect_success 'unambiguously abbreviated option with "="' '
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test_expect_code 129 test-parse-options --strin 123
+	test_expect_code 1 test-parse-options --strin 123
 '
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
@@ -291,6 +291,7 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
+	>expect.err &&
 	test_i18ncmp expect.err output.err
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ef2887bd8..e6a0766f8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -921,7 +921,7 @@ test_expect_success 'rebase -i --exec without <CMD>' '
 	set_fake_editor &&
 	test_must_fail git rebase -i --exec 2>tmp &&
 	sed -e "1d" tmp >actual &&
-	test_must_fail git rebase -h >expected &&
+	>expected &&
 	test_cmp expected actual &&
 	git checkout master
 '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index b1602718f..157cbcdb2 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -34,10 +34,10 @@ test_expect_success setup '
 test_expect_success 'cherry-pick -m complains of bogus numbers' '
 	# expect 129 here to distinguish between cases where
 	# there was nothing to cherry-pick
-	test_expect_code 129 git cherry-pick -m &&
-	test_expect_code 129 git cherry-pick -m foo b &&
-	test_expect_code 129 git cherry-pick -m -1 b &&
-	test_expect_code 129 git cherry-pick -m 0 b
+	test_expect_code 1 git cherry-pick -m &&
+	test_expect_code 1 git cherry-pick -m foo b &&
+	test_expect_code 1 git cherry-pick -m -1 b &&
+	test_expect_code 1 git cherry-pick -m 0 b
 '
 
 test_expect_success 'cherry-pick a non-merge with -m should fail' '
diff --git a/t/tcontains.sh b/t/tcontains.sh
new file mode 100755
index 000000000..4856111ff
--- /dev/null
+++ b/t/tcontains.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='Test "contains" argument behavior'
+
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	git init . &&
+	echo "this is a test" >file &&
+	git add -A &&
+	git commit -am "tag test" &&
+	git tag "v1.0" &&
+	git tag "v1.1"
+'
+
+test_expect_success 'tag --contains <existent_tag>' '
+	git tag --contains "v1.0" >actual &&
+	grep "v1.0" actual &&
+	grep "v1.1" actual
+'
+
+test_expect_success 'tag --contains <inexistent_tag>' '
+	test_must_fail git tag --contains "notag" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'tag --no-contains <existent_tag>' '
+	git tag --no-contains "v1.1" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'tag --no-contains <inexistent_tag>' '
+	test_must_fail git tag --no-contains "notag" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'tag usage error' '
+	test_must_fail git tag --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_expect_success 'branch --contains <existent_commit>' '
+	git branch --contains "master" >actual &&
+	test_i18ngrep "master" actual
+'
+
+test_expect_success 'branch --contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'branch --no-contains <existent_commit>' '
+	git branch --no-contains "master" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'branch --no-contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'branch usage error' '
+	test_must_fail git branch --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_expect_success 'for-each-ref --contains <existent_object>' '
+	git for-each-ref --contains "master" >actual &&
+	test_line_count = 3 actual
+'
+
+test_expect_success 'for-each-ref --contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'for-each-ref --no-contains <existent_object>' '
+	git for-each-ref --no-contains "master" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'for-each-ref usage error' '
+	test_must_fail git for-each-ref --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_done
-- 
2.16.2.346.g22874a30c

