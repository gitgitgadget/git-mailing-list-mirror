Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC815C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbiA0WD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiA0WD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:03:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBBEC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so2776563wme.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Q7F4C8AWG73GonN9Ck7xmdK9K4fYGIcHPfj8k8h1/A=;
        b=OHvziAJ6F96o6yOMM13GShSFtE/WNusy5h6NXONIk0T/abFEh0oPJwLu3tendBtzPb
         FvpnhB4njZyiSdQiAu0BpYBQepzyNf9JO+K368hZ7SdNB+ge52ac4BKTEjGgVFi0Li9B
         hSLoRBdrWL+Kej3Icxp4Ya/dyJoh7Cp88pLVyAyKLfUqMc5qS/yc8o5jWRw9RdVsZ2uu
         /0U4vRIAa4sTOsUchwtwbrDkI6il+SpwGro+kDV554fkeiZ8PRYuMEpuNZSS00Lc9qID
         Z7dn7h3lqL80JYWxwQn9T9QlV94BzM49DC65yxZFtPP3Abnw394riVrQvvqc40X1oEg+
         fOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Q7F4C8AWG73GonN9Ck7xmdK9K4fYGIcHPfj8k8h1/A=;
        b=gjwYmCApsAGh49wwsE7Kraf2ER+hSdeTNmYMAjqIkOVKBuBvuxG1myO8G90rmDolRP
         i+E/5H23RTDcVAI/D8ZGHdbCTlJubQdcpihCuxoWzlLjqRye6WOdaaB4QlV+3+LX5fev
         e/kNtcM9HkLlwvJNRyxZ9KfY0zmtkQEOiTfOpqUMlta/6twymjZwUTP1EuIpt4mFqSS9
         W1nJDvYY+qnw0EMtoTWmWrjHnf1NAcVK/UXOmeR1Mddg+4LW2csQgzX+e5RTxRtID/II
         Gure/SyQ8Ax87c31oJvs2dsCWqJ/55x0m6XXsV44FX4n5PEDa+Lstb1oGpUOFtHMrJ8C
         cF9A==
X-Gm-Message-State: AOAM530KX+FPOwSI7mUP2hL1r8qqEDl3W76LAxXdTrMfjs3NepTGOJ5v
        famFO9AooyWTmfj4X77NFJKJcq/DomQ=
X-Google-Smtp-Source: ABdhPJyZBzJJrMNt+gQnDNpG1AI8OZqT4cd33YHGWQsB8bewBdmPGOzqX8CwUyt+hwNV8+qAUTfpXQ==
X-Received: by 2002:a7b:cbce:: with SMTP id n14mr13370033wmi.90.1643321036090;
        Thu, 27 Jan 2022 14:03:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm3942687wri.43.2022.01.27.14.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:03:55 -0800 (PST)
Message-Id: <047a63173775d309e8d88c60b58d7756be5c0900.1643321031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
References: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 22:03:51 +0000
Subject: [PATCH 4/4] stash: stop warning about the obsolete `stash.useBuiltin`
 config setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8a2cd3f5123 (stash: remove the stash.useBuiltin setting, 2020-03-03),
we removed support for `stash.useBuiltin`, but left a warning in its
place.

After almost two years, and several major versions, it is time to remove
even that warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c  | 10 ----------
 t/t3903-stash.sh | 15 ---------------
 2 files changed, 25 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1ef2017c595..25793b5a75a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -788,7 +788,6 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
-static int use_legacy_stash;
 
 static int git_stash_config(const char *var, const char *value, void *cb)
 {
@@ -804,10 +803,6 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "stash.usebuiltin")) {
-		use_legacy_stash = !git_config_bool(var, value);
-		return 0;
-	}
 	return git_diff_basic_config(var, value, cb);
 }
 
@@ -1778,11 +1773,6 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 
 	git_config(git_stash_config, NULL);
 
-	if (use_legacy_stash ||
-	    !git_env_bool("GIT_TEST_STASH_USE_BUILTIN", -1))
-		warning(_("the stash.useBuiltin support has been removed!\n"
-			  "See its entry in 'git help config' for details."));
-
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 686747e55a3..b149e2af441 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1272,7 +1272,6 @@ test_expect_success 'stash works when user.name and user.email are not set' '
 	>2 &&
 	git add 2 &&
 	test_config user.useconfigonly true &&
-	test_config stash.usebuiltin true &&
 	(
 		sane_unset GIT_AUTHOR_NAME &&
 		sane_unset GIT_AUTHOR_EMAIL &&
@@ -1323,20 +1322,6 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
-test_expect_success 'stash -c stash.useBuiltin=false warning ' '
-	expected="stash.useBuiltin support has been removed" &&
-
-	git -c stash.useBuiltin=false stash 2>err &&
-	test_i18ngrep "$expected" err &&
-	env GIT_TEST_STASH_USE_BUILTIN=false git stash 2>err &&
-	test_i18ngrep "$expected" err &&
-
-	git -c stash.useBuiltin=true stash 2>err &&
-	test_must_be_empty err &&
-	env GIT_TEST_STASH_USE_BUILTIN=true git stash 2>err &&
-	test_must_be_empty err
-'
-
 test_expect_success 'git stash succeeds despite directory/file change' '
 	test_create_repo directory_file_switch_v1 &&
 	(
-- 
gitgitgadget
