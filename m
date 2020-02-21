Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A8C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70020722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANB244ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgBUDKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:10:38 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:57144 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgBUDKi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:10:38 -0500
Received: by mail-pg1-f202.google.com with SMTP id 71so371279pgg.23
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 19:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=FJf6eUskQ/aNbG9s5pXPAUd44cc3hQygCkDP6koc0t0=;
        b=ANB244ZYhlaKBp2PuzDoAfoEmX3/jjwezwV7NMtsKqXJnhfXe7eYSkFFiViNarP0a5
         WsudsobSCbYuPMwO8EmH2Xn0qT/JLiXI/BaYrcSDjNyRr2lVPUhUi79Isx1tAzmxA0aB
         Rsy4l2C0ppWiT0vedYqkhd9P9b7lvBp8wqLFkMlvCs19rQp9oCJLsRbXhzLorWwRTKo5
         Idx0yF0hu25JqDxtcQ7ScPIJje2Wm1GRrEaMZ3xld+tz5DYFLHcMbjWNejM+sIpai5Ou
         J8IHdq8c9Q0bvvvD53QgVCQX8tJWEhjboQ/WLdl2/g0tfsmqh+5cLxg6hxKU6zpLoahQ
         Mi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=FJf6eUskQ/aNbG9s5pXPAUd44cc3hQygCkDP6koc0t0=;
        b=tvAnRHOev9tYe/P3YnL/gaz/rvMQR1klumw/yZ3W/jB5nuXTp2GLWKRKHEUMhvAH8E
         BAx7zMnwC7n0vrwezHGWt6SxEjGifCaI8+pXmrMIGJAjqHalzJp6c5C7hyn5AexqjAEE
         zP5CtBxSWOg7WBa3j4bcMynAccxRvpEEvQuybcfjXdM96xERgMdA40UI09YIigLvbU0C
         s614jb0m1lYEQpatO9uw6yyjpBfx3Q1cRwyLiFPHxEeUDhe//BjP6VkckE19PpagXOo+
         v7xhyGXifRscP47DdSi6VjpwoknoQKwX6ufiF08USyi8+na6n3PrF4UyUozzHsW0cELZ
         2lvw==
X-Gm-Message-State: APjAAAWiVQa3/RTQkAPDrpI1pki/y6zfvIU2yjNsYfj7e9lJ6r386oDE
        5O0jco8Obn+qZB8+PnVVUjwyIKWPI6S0v7X6WM+g7qX04wOD8PYGKtYIY3JHPomkPRTtPUSLpJF
        FhEzlXmaCXiKZD/ExbPeywFPKJca2uyp3ibxxNtRIH/7646TkE94tdqrAbnM78bs3YS+l35+neg
        ==
X-Google-Smtp-Source: APXvYqzfs6CD8VXAsslGZRN02Utp4BtPOonDqklsvcsQaHaI57eJ1AYTLGk4XzAEU6kNMA3w+I7jMmTJsTo5XciKDbY=
X-Received: by 2002:a63:d109:: with SMTP id k9mr37189728pgg.219.1582254637073;
 Thu, 20 Feb 2020 19:10:37 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:10:25 -0800
In-Reply-To: <20200128221736.9217-1-emilyshaffer@google.com>
Message-Id: <20200221031027.204486-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 0/2] propagate --single-branch during clone --recurse-submodules
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2, I replied to Peff's comments, and I also added support to
propagate --no-single-branch. I'm pretty sure I followed the idiom right
to to treat options as "yes, no, unset" but not sure of the best way to
test to feel assured that they're being propagated correctly.

 - Emily

Emily Shaffer (2):
  submodule--helper: use C99 named initializer
  clone: pass --single-branch during --recurse-submodules

 Documentation/git-submodule.txt    |  6 +++++-
 builtin/clone.c                    |  5 +++++
 builtin/submodule--helper.c        | 32 +++++++++++++++++++++++-------
 git-submodule.sh                   | 10 +++++++++-
 t/t5617-clone-submodules-remote.sh | 13 +++++++++++-
 5 files changed, 56 insertions(+), 10 deletions(-)


-:  ---------- > 1:  d1d69cc9ce submodule--helper: use C99 named initializer
1:  e064e805da ! 2:  adfe55b18f clone: pass --single-branch during --recurse-submodules
    @@ Documentation/git-submodule.txt: If you really want to remove a submodule from t
      options.
      
     -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
    -+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--single-branch] [--] [<path>...]::
    ++update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--] [<path>...]::
      +
      --
      Update the registered submodules to match what the superproject
    @@ Documentation/git-submodule.txt: options carefully.
      	Clone new submodules in parallel with as many jobs.
      	Defaults to the `submodule.fetchJobs` option.
      
    -+--single-branch::
    ++--[no-]single-branch::
     +	This option is only valid for the update command.
    -+	Clone only one branch during update, HEAD or --branch.
    ++	Clone only one branch during update: HEAD or one specified by --branch.
     +
      <path>...::
      	Paths to submodule(s). When specified this will restrict the command
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      			argv_array_push(&args, "--no-fetch");
      		}
      
    -+		if (option_single_branch)
    -+			argv_array_push(&args, "--single-branch");
    ++		if (option_single_branch >= 0)
    ++			argv_array_push(&args, option_single_branch ?
    ++					       "--single-branch" :
    ++					       "--no-single-branch");
     +
      		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
      		argv_array_clear(&args);
    @@ builtin/submodule--helper.c: static int clone_submodule(const char *path, const
      		argv_array_push(&cp.args, "--dissociate");
      	if (gitdir && *gitdir)
      		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
    -+	if (single_branch)
    -+		argv_array_push(&cp.args, "--single-branch");
    ++	if (single_branch >= 0)
    ++		argv_array_push(&cp.args, single_branch ?
    ++					  "--single-branch" :
    ++					  "--no-single-branch");
      
      	argv_array_push(&cp.args, "--");
      	argv_array_push(&cp.args, url);
    @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
      	struct string_list reference = STRING_LIST_INIT_NODUP;
      	int dissociate = 0, require_init = 0;
      	char *sm_alternate = NULL, *error_strategy = NULL;
    -+	int single_branch = 0;
    ++	int single_branch = -1;
      
      	struct option module_clone_options[] = {
      		OPT_STRING(0, "prefix", &prefix,
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	/* to be consumed by git-submodule.sh */
      	struct update_clone_data *update_clone;
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
    - };
    - #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
    - 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
    --	NULL, NULL, NULL, \
    -+	NULL, NULL, NULL, 0,\
    - 	NULL, 0, 0, 0, NULL, 0, 0, 1}
    - 
    - 
    + 	.update = SUBMODULE_UPDATE_STRATEGY_INIT, \
    + 	.recommend_shallow = -1, \
    + 	.references = STRING_LIST_INIT_DUP, \
    ++	.single_branch = -1, \
    + 	.max_jobs = 1 \
    + }
    + 
    +-
    + static void next_submodule_warn_missing(struct submodule_update_clone *suc,
    + 		struct strbuf *out, const char *displaypath)
    + {
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
      		argv_array_push(&child->args, "--dissociate");
      	if (suc->depth)
      		argv_array_push(&child->args, suc->depth);
    -+	if (suc->single_branch)
    -+		argv_array_push(&child->args, "--single-branch");
    ++	if (suc->single_branch >= 0)
    ++		argv_array_push(&child->args, suc->single_branch ?
    ++					      "--single-branch" :
    ++					      "--no-single-branch");
      
      cleanup:
      	strbuf_reset(&displaypath_sb);
    @@ git-submodule.sh: USAGE="[--quiet] [--cached]
         or: $dashless [--quiet] init [--] [<path>...]
         or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
     -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    -+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--single-branch] [--] [<path>...]
    ++   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
         or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
         or: $dashless [--quiet] set-url [--] <path> <newurl>
         or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    @@ git-submodule.sh: cmd_update()
      			jobs=$1
      			;;
     +		--single-branch)
    -+			single_branch=1
    ++			single_branch="--single-branch"
    ++			;;
    ++		--no-single-branch)
    ++			single_branch="--no-single-branch"
     +			;;
      		--)
      			shift
    @@ git-submodule.sh: cmd_update()
      		${dissociate:+"--dissociate"} \
      		${depth:+--depth "$depth"} \
      		${require_init:+--require-init} \
    -+		${single_branch:+--single-branch} \
    ++		$single_branch \
      		$recommend_shallow \
      		$jobs \
      		-- \
    @@ t/t5617-clone-submodules-remote.sh: test_expect_success 'check the default is --
     +	git clone --recurse-submodules --single-branch "file://$pwd/." super_clone &&
     +	(
     +		cd super_clone/sub &&
    -+		git branch -a >branches &&
    -+		test_must_fail grep other branches
    ++		git rev-parse --verify origin/master &&
    ++		test_must_fail git rev-parse --verify origin/other
     +	)
     +'
     +

-- 
2.25.0.265.gbab2e86ba0-goog

