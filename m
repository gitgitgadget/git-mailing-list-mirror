Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65351F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdGYVkB (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:01 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35892 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdGYVj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:58 -0400
Received: by mail-pf0-f169.google.com with SMTP id z129so23489898pfb.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/xASbBJ0YwNKLCb0MmcmJdR/bL3hGcJ0Zl6MFX+NzI=;
        b=Qbs+9l0vyEfNCXLCrRzjxDxkP4iqQb7mqTJOXPX+Zu1nqCv8V6Fgdxzx6PKM9E+lgq
         sZAH8EeiavgjDnQLmLzRZ1/SPxqW/Nh4TMGbgsXSS/4787biF5b/MdYifPDVSkdfQv0n
         1uOUlgLRWMGXw35bdePGg5CkjHOKgTRJawsfujVj6KHzuVGdnFOsoypzDzVTupSkqWVi
         BhPNTKFU5q4BHtddlmYDGfGn07HVWTnLuGR/OgXe+rD8nKCaH1W4np9rhinzAhHB6TA3
         uTfQQiGfsgYi76lO5pkYfJciJLfe/Nfi2CETC+29LLtnbB8xD9BDrgZsIJHry1qFIY65
         h6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/xASbBJ0YwNKLCb0MmcmJdR/bL3hGcJ0Zl6MFX+NzI=;
        b=OgV3mPom05GqtzfdYMJ1LmIaCNx1EDUlxt9mt0gyurHt2kFvDio7XHY6FWNVMBI8oG
         lGgv76EWcR5ofpNM6aPSy2B3nLZNh6TjYhtfeH2U1IngS68S6ulmpgLLirkAOrm8FwNx
         ofCZOvJZQAAIo/rnClTcMlo+4cnlxqz+Cbrk/bLUVZZTSN26xa8zbi+yAVYB2VWJIb9D
         p/NC7k8isvZMzmY/BMiSyThAhvxzEpsVYYXi2uXAxoBUwroBzNZxK6ZpC6xmT+C9ctPi
         g6OQ9vxEfxjjh2GPgwrYUlipSajODsm2EEy/E0NSWzM2PAGcaW1l02uGZu2mtGfPCfxR
         VwwA==
X-Gm-Message-State: AIVw112PuBPbqtym7k37XSi9k5otZWxkn/SeoJwtIwJhchtmdFqJXtu9
        zqyyu0HgjFjZt+/1mI9lYw==
X-Received: by 10.99.127.83 with SMTP id p19mr21019142pgn.376.1501018797221;
        Tue, 25 Jul 2017 14:39:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/15] submodule-config: remove support for overlaying repository config
Date:   Tue, 25 Jul 2017 14:39:24 -0700
Message-Id: <20170725213928.125998-12-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers have been migrated to explicitly read any configuration they
need.  The support for handling it automatically in submodule-config is
no longer needed.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule-config.h               |  1 -
 t/helper/test-submodule-config.c |  6 ----
 t/t7411-submodule-config.sh      | 72 ----------------------------------------
 3 files changed, 79 deletions(-)

diff --git a/submodule-config.h b/submodule-config.h
index cccd34b92..84c2cf515 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -34,7 +34,6 @@ extern int option_fetch_parse_recurse_submodules(const struct option *opt,
 						 const char *arg, int unset);
 extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-extern int parse_submodule_config_option(const char *var, const char *value);
 extern int submodule_config_option(struct repository *repo,
 				   const char *var, const char *value);
 extern const struct submodule *submodule_from_name(
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index e13fbcc1b..f4a7c431c 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -10,11 +10,6 @@ static void die_usage(int argc, const char **argv, const char *msg)
 	exit(1);
 }
 
-static int git_test_config(const char *var, const char *value, void *cb)
-{
-	return parse_submodule_config_option(var, value);
-}
-
 int cmd_main(int argc, const char **argv)
 {
 	const char **arg = argv;
@@ -38,7 +33,6 @@ int cmd_main(int argc, const char **argv)
 
 	setup_git_directory();
 	gitmodules_config();
-	git_config(git_test_config, NULL);
 
 	while (*arg) {
 		struct object_id commit_oid;
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 7d6b25ba2..46c09c776 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -122,78 +122,6 @@ test_expect_success 'using different treeishs works' '
 	)
 '
 
-cat >super/expect_url <<EOF
-Submodule url: 'git@somewhere.else.net:a.git' for path 'b'
-Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-EOF
-
-cat >super/expect_local_path <<EOF
-Submodule name: 'a' for path 'c'
-Submodule name: 'submodule' for path 'submodule'
-EOF
-
-test_expect_success 'reading of local configuration' '
-	(cd super &&
-		old_a=$(git config submodule.a.url) &&
-		old_submodule=$(git config submodule.submodule.url) &&
-		git config submodule.a.url git@somewhere.else.net:a.git &&
-		git config submodule.submodule.url git@somewhere.else.net:submodule.git &&
-		test-submodule-config --url \
-			"" b \
-			"" submodule \
-				>actual &&
-		test_cmp expect_url actual &&
-		git config submodule.a.path c &&
-		test-submodule-config \
-			"" c \
-			"" submodule \
-				>actual &&
-		test_cmp expect_local_path actual &&
-		git config submodule.a.url "$old_a" &&
-		git config submodule.submodule.url "$old_submodule" &&
-		git config --unset submodule.a.path c
-	)
-'
-
-cat >super/expect_url <<EOF
-Submodule url: '../submodule' for path 'b'
-Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-EOF
-
-test_expect_success 'reading of local configuration for uninitialized submodules' '
-	(
-		cd super &&
-		git submodule deinit -f b &&
-		old_submodule=$(git config submodule.submodule.url) &&
-		git config submodule.submodule.url git@somewhere.else.net:submodule.git &&
-		test-submodule-config --url \
-			"" b \
-			"" submodule \
-				>actual &&
-		test_cmp expect_url actual &&
-		git config submodule.submodule.url "$old_submodule" &&
-		git submodule init b
-	)
-'
-
-cat >super/expect_fetchrecurse_die.err <<EOF
-fatal: bad submodule.submodule.fetchrecursesubmodules argument: blabla
-EOF
-
-test_expect_success 'local error in fetchrecursesubmodule dies early' '
-	(cd super &&
-		git config submodule.submodule.fetchrecursesubmodules blabla &&
-		test_must_fail test-submodule-config \
-			"" b \
-			"" submodule \
-				>actual.out 2>actual.err &&
-		touch expect_fetchrecurse_die.out &&
-		test_cmp expect_fetchrecurse_die.out actual.out  &&
-		test_cmp expect_fetchrecurse_die.err actual.err  &&
-		git config --unset submodule.submodule.fetchrecursesubmodules
-	)
-'
-
 test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 	(cd super &&
 		git config -f .gitmodules \
-- 
2.14.0.rc0.400.g1c36432dff-goog

