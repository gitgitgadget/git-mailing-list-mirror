Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639AC433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 23:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiEKXmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 19:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349423AbiEKXmp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 19:42:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA060B94
        for <git@vger.kernel.org>; Wed, 11 May 2022 16:42:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so3435064wmb.0
        for <git@vger.kernel.org>; Wed, 11 May 2022 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ybHRt/S7TpEG3SV+li9GrJydF82zHgSgeBGfWvfsZs=;
        b=bIdoUy4kOkr3roU+oS7fyE2s9756Ul4zpsxVSgx1bcEEv+Aus+o6B9LGlqj/Cav6cQ
         fjtpDwtSMORKfj3xaeRQi82f+56OdTkCQLCBCrUkppw7viw921uYq1SSm3WClOljXSH+
         kWKtEHZiq9zWxxhmbXjyLj4eO6e4sW5wmSxTGIAjsN+UHZa/UcJqiihobsZl0FjhRfN0
         4Scu0/LR0r5sjCgmA12l6HlXHtGtDa+AWbB8crqbq0Nfebu7zTq0RLjmeh6HR4/2ncAO
         tjZ8BqOyMr50zel+w0oA3Ec1BoxulsiXfFpes3PUcl1o56z2LWTqNDX7cG5osVIgItMN
         2u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ybHRt/S7TpEG3SV+li9GrJydF82zHgSgeBGfWvfsZs=;
        b=rHGjtdNaLnyCwOyf42mXY46QhnrQrlpw4x5baL4wnm3c1WOpQA2zEg9vWP9xQLTAB4
         3UX+pz/nYQPFC41VpuSfW2TUBZ+WeVgbROoLtNAzpbyoMSh6t08neqQ08yfGqKtd/uAF
         yZyTDk9IWPBdREnxjE48t0l2+LCh9U747uGVkmRiX7Z6n2XNXG5l73qZyWFCa6MSAlEG
         GtnVrbNvgfinnXW6KhTjOG6dkG23FBBOkqe4Z+vDhjpa5a3gBVsGFQP5ZcNZjP6k2PSy
         oz+RKmi/lloWVzvRxqi/mQTf2L8Q3c2hhUYuPtq/VzKRSlSfNwGEoTh3PUNuNYU47fRj
         mR5Q==
X-Gm-Message-State: AOAM533rrEgUAGAN5m9oAWRQAs00YtRuD3d2Z2fYroCqezk5abHaeugR
        qpkttvemSEoyi4648Cp/graDcPyVKls=
X-Google-Smtp-Source: ABdhPJz3PlVQ7mwAn+m3FlW5vNPmswQNfoQ6w4jZxc6TApTgYb6c1wi3Gsdcke0k/yPcTFtfGYRV/g==
X-Received: by 2002:a05:600c:3583:b0:394:77fc:d6a2 with SMTP id p3-20020a05600c358300b0039477fcd6a2mr7220238wmq.63.1652312562350;
        Wed, 11 May 2022 16:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020adfa108000000b0020c5253d8fbsm2762186wro.71.2022.05.11.16.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:42:41 -0700 (PDT)
Message-Id: <pull.1262.v3.git.git.1652312560207.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
References: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 23:42:40 +0000
Subject: [PATCH v3] pull: do not let submodule.recurse override
 fetch.recurseSubmodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Fix a bug in "git pull" where `submodule.recurse` is preferred over
`fetch.recurseSubmodules` when performing a fetch
(Documentation/config/fetch.txt says that `fetch.recurseSubmodules`
should be preferred.). Do this by passing the value of the
"--recurse-submodules" CLI option to the underlying fetch, instead of
passing a value that combines the CLI option and config variables.

In other words, this bug occurred because builtin/pull.c is conflating
two similar-sounding, but different concepts:

- Whether "git pull" itself should care about submodules e.g. whether it
  should update the submodule worktrees after performing a merge.
- The value of "--recurse-submodules" to pass to the underlying "git
  fetch".

Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
invoked with "--recurse-submodules[=value]", overriding the value of
`fetch.recurseSubmodules`.

An alternative (and more obvious) approach to fix the bug would be to
teach "git pull" to understand `fetch.recurseSubmodules`, but the
proposed solution works better because:

- We don't maintain two identical config-parsing implementions in "git
  pull" and "git fetch".
- It works better with other commands invoked by "git pull" e.g. "git
  merge" won't accidentally respect `fetch.recurseSubmodules`.

Reported-by: Huang Zou <huang.zou@schrodinger.com>
Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
    pull: do not let submodule.recurse override fetch.recurseSubmodules
    
    Thanks for the debugging help :)
    
    Changes since v1:
    
     * add a test that actually tests the precedence of the config values
       * I've kept the previous test; it has always worked, but it still
         seems like a useful smoke test
     * reworded the commit message slightly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1262%2Fchooglen%2Fpull%2Ffetch-recurse-submodules-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1262/chooglen/pull/fetch-recurse-submodules-v3
Pull-Request: https://github.com/git/git/pull/1262

Range-diff vs v2:

 1:  ba08e10b759 ! 1:  07f052c377c pull: only pass '--recurse-submodules' to subcommands
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    pull: only pass '--recurse-submodules' to subcommands
     +    pull: do not let submodule.recurse override fetch.recurseSubmodules
      
          Fix a bug in "git pull" where `submodule.recurse` is preferred over
          `fetch.recurseSubmodules` when performing a fetch


 builtin/pull.c            | 10 +++++++---
 t/t5572-pull-submodule.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4d667abc19d..01155ba67b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -72,6 +72,7 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static char *opt_progress;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
@@ -120,7 +121,7 @@ static struct option pull_options[] = {
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
 	OPT_CALLBACK_F(0, "recurse-submodules",
-		   &recurse_submodules, N_("on-demand"),
+		   &recurse_submodules_cli, N_("on-demand"),
 		   N_("control for recursive fetching of submodules"),
 		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 
@@ -536,8 +537,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		strvec_push(&args, opt_tags);
 	if (opt_prune)
 		strvec_push(&args, opt_prune);
-	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
-		switch (recurse_submodules) {
+	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
+		switch (recurse_submodules_cli) {
 		case RECURSE_SUBMODULES_ON:
 			strvec_push(&args, "--recurse-submodules=on");
 			break;
@@ -1001,6 +1002,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
+	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
+		recurse_submodules = recurse_submodules_cli;
+
 	if (cleanup_arg)
 		/*
 		 * this only checks the validity of cleanup_arg; we don't need
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index fa6b4cca65c..a35396fadf5 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -107,6 +107,32 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
 	test_path_is_file super/sub/merge_strategy_4.t
 '
 
+test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
+	test_commit -C child merge_strategy_5 &&
+	# Omit the parent commit, otherwise this passes with the
+	# default "pull" behavior.
+
+	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
+	# Check that the submodule commit was fetched
+	sub_oid=$(git -C child rev-parse HEAD) &&
+	git -C super/sub cat-file -e $sub_oid &&
+	# Check that the submodule worktree did not update
+	! test_path_is_file super/sub/merge_strategy_5.t
+'
+
+test_expect_success "fetch.recurseSubmodules takes precedence over submodule.recurse" '
+	test_commit -C child merge_strategy_6 &&
+	# Omit the parent commit, otherwise this passes with the
+	# default "pull" behavior.
+
+	git -C super -c submodule.recurse=false -c fetch.recursesubmodules=true pull --no-rebase &&
+	# Check that the submodule commit was fetched
+	sub_oid=$(git -C child rev-parse HEAD) &&
+	git -C super/sub cat-file -e $sub_oid &&
+	# Check that the submodule worktree did not update
+	! test_path_is_file super/sub/merge_strategy_6.t
+'
+
 test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
 	# This tests the following scenario :
 	# - local submodule has new commits

base-commit: e8005e4871f130c4e402ddca2032c111252f070a
-- 
gitgitgadget
