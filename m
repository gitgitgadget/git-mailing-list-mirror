Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D79C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjAMKUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjAMKUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:20:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6126A0CF
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:20:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso11933768wms.4
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYEMkrCIm6cjabMMVMZqJMkT1QV88SSL3Bx6x0foWMs=;
        b=nFHfHbZbcWiGql2dujFe0cZREsX4eVtskr5c+cgi9Ffdx7Id/YbT33HOF8ZFw4QKcC
         gMF/wXeuys1HcSSUqpjzt7Sqs9PDE/aHW4lT6OpTnz4JX8PvVGiXAJ1ykqrsZlWwnXZ6
         isBAid8txZiQ863M5fehNRWCi6CROEv4AclMHfIRzPgO3zmpXyGctP2zygTk9Nni7OxS
         qrouRPbCLzUD6o10fT5hN2/z4rGOmXb1MK4Qk8A0Hw/mQ5d9+X7bdsfITntGtONH55AH
         760T6DE9BXK8XZfhfqWk6Ns4RuhKcyltGtFgtsuGB0lUf/mpmmiQdPrEnrKdUm0/88NE
         mJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYEMkrCIm6cjabMMVMZqJMkT1QV88SSL3Bx6x0foWMs=;
        b=3CMe6vUJgJfoTQaVZVPYDGSI1hRSEXCy9By10cER+wFb7qreIncr3CEwB7cpN2xbB1
         Uw8XHK0XnvT73GTsS+n6BlmM9Ic/xGN99uF56IBhNI93xMO9oT352BbNdbuRMYqTUkVR
         WeW1UMx+zyn91rn4Ozz6QhT60lvfWdqRdFLt4iEu7pz4DubT30R7EIlwEVS/4Gg+yL+P
         9HebypvpcSU6Yf6nu/8LDoxnhOK6WIAd3CDbmhTluSuRzzgRHNaZkbOrQLxIAAiGcs4W
         V6ZMKVQSXt6aKku/6tPNmyq+3yVXiLn7HDNhNL0ei9GXHBBYZbzlv2/14/Znn81iFBOV
         p8gA==
X-Gm-Message-State: AFqh2ko4Iu6qqSpMQlOmyRJC9yBFIBQqmky5qG3yq4kcFF9oW+9AHvuq
        7bxDJPAfZTVVScM6TVmLed4=
X-Google-Smtp-Source: AMrXdXuro0iqmfq6sTxae71H8CEwYsPcYH/EitVPjCRWFipdfL4csgDL8TUl7GDfYMqw1WFuNVBP/g==
X-Received: by 2002:a7b:cb56:0:b0:3d2:3be4:2d9a with SMTP id v22-20020a7bcb56000000b003d23be42d9amr58311953wmj.20.1673605227615;
        Fri, 13 Jan 2023 02:20:27 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b003d96efd09b7sm34107238wmp.19.2023.01.13.02.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:20:27 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:20:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20230107045757.30037-1-jacobabel@nullpo.dev>
 <20230109173227.29264-1-jacobabel@nullpo.dev>
 <20230109173227.29264-4-jacobabel@nullpo.dev>
In-Reply-To: <20230109173227.29264-4-jacobabel@nullpo.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

On 09/01/2023 17:33, Jacob Abel wrote:
> Adds support for creating an orphan branch when adding a new worktree.
> This functionality is equivalent to git switch's --orphan flag.
> 
> The original reason this feature was implemented was to allow a user
> to initialise a new repository using solely the worktree oriented
> workflow.
> 
> Current Behavior:
> % git -C foo.git --no-pager branch -l
> + main
> % git -C foo.git worktree add main/
> Preparing worktree (new branch 'main')
> HEAD is now at 6c93a75 a commit
> %
> 
> % git init bar.git
> Initialized empty Git repository in /path/to/bar.git/
> % git -C bar.git --no-pager branch -l
> 
> % git -C bar.git worktree add main/
> Preparing worktree (new branch 'main')
> fatal: not a valid object name: 'HEAD'
> %
> 
> New Behavior:
> 
> % git -C foo.git --no-pager branch -l
> + main
> % git -C foo.git worktree add main/
> Preparing worktree (new branch 'main')
> HEAD is now at 6c93a75 a commit
> %
> 
> % git init --bare bar.git
> Initialized empty Git repository in /path/to/bar.git/
> % git -C bar.git --no-pager branch -l
> 
> % git -C bar.git worktree add main/
> Preparing worktree (new branch 'main')
> fatal: invalid reference: HEAD
> % git -C bar.git worktree add --orphan main main/

It's perhaps a bit late to bring this up but I've only just realized 
that it is unfortunate that --orphan takes a branch name rather than 
working in conjunction with -b/-B. It means that in the common case 
where the branch name is the same as the worktree the user has to repeat 
it on the command line as shown above. It also means there is no way to 
force an orphan branch (that's admittedly quite niche). If instead 
--orphan did not take an argument we could have

	git worktree add --orphan main
	git worktree add --orphan -b topic main
	git worktree add --orphan -B topic main

Best Wishes

Phillip

> Preparing worktree (new branch 'main')
> %
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>   Documentation/git-worktree.txt | 15 +++++++++
>   builtin/worktree.c             | 59 ++++++++++++++++++++++++++++++----
>   t/t2400-worktree-add.sh        | 53 ++++++++++++++++++++++++++++++
>   3 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index b9c12779f1..d78460c29c 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -11,6 +11,8 @@ SYNOPSIS
>   [verse]
>   'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
>   		   [(-b | -B) <new-branch>] <path> [<commit-ish>]
> +'git worktree add' [-f] [--lock [--reason <string>]]
> +		   --orphan <new-branch> <path>
>   'git worktree list' [-v | --porcelain [-z]]
>   'git worktree lock' [--reason <string>] <worktree>
>   'git worktree move' <worktree> <new-path>
> @@ -95,6 +97,15 @@ exist, a new branch based on `HEAD` is automatically created as if
>   `-b <branch>` was given.  If `<branch>` does exist, it will be checked out
>   in the new worktree, if it's not checked out anywhere else, otherwise the
>   command will refuse to create the worktree (unless `--force` is used).
> ++
> +------------
> +$ git worktree add --orphan <branch> <path>
> +------------
> ++
> +Create a worktree containing no files, with an empty index, and associated
> +with a new orphan branch named `<branch>`. The first commit made on this new
> +branch will have no parents and will be the root of a new history disconnected
> +from any other branches.
> 
>   list::
> 
> @@ -222,6 +233,10 @@ This can also be set up as the default behaviour by using the
>   	With `prune`, do not remove anything; just report what it would
>   	remove.
> 
> +--orphan <new-branch>::
> +	With `add`, make the new worktree and index empty, associating
> +	the worktree with a new orphan branch named `<new-branch>`.
> +
>   --porcelain::
>   	With `list`, output in an easy-to-parse format for scripts.
>   	This format will remain stable across Git versions and regardless of user
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index ddb33f48a0..ac82c5feda 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -17,7 +17,10 @@
> 
>   #define BUILTIN_WORKTREE_ADD_USAGE \
>   	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
> -	   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]")
> +	   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]"), \
> +	N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
> +	   "                 --orphan <new-branch> <path>")
> +
>   #define BUILTIN_WORKTREE_LIST_USAGE \
>   	N_("git worktree list [-v | --porcelain [-z]]")
>   #define BUILTIN_WORKTREE_LOCK_USAGE \
> @@ -90,6 +93,7 @@ struct add_opts {
>   	int detach;
>   	int quiet;
>   	int checkout;
> +	int orphan;
>   	const char *keep_locked;
>   };
> 
> @@ -364,6 +368,22 @@ static int checkout_worktree(const struct add_opts *opts,
>   	return run_command(&cp);
>   }
> 
> +static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
> +				struct strvec *child_env)
> +{
> +	struct strbuf symref = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	validate_new_branchname(ref, &symref, 0);
> +	strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
> +	if (opts->quiet)
> +		strvec_push(&cp.args, "--quiet");
> +	strvec_pushv(&cp.env, child_env->v);
> +	strbuf_release(&symref);
> +	cp.git_cmd = 1;
> +	return run_command(&cp);
> +}
> +
>   static int add_worktree(const char *path, const char *refname,
>   			const struct add_opts *opts)
>   {
> @@ -393,7 +413,7 @@ static int add_worktree(const char *path, const char *refname,
>   			die_if_checked_out(symref.buf, 0);
>   	}
>   	commit = lookup_commit_reference_by_name(refname);
> -	if (!commit)
> +	if (!commit && !opts->orphan)
>   		die(_("invalid reference: %s"), refname);
> 
>   	name = worktree_basename(path, &len);
> @@ -482,10 +502,10 @@ static int add_worktree(const char *path, const char *refname,
>   	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>   	cp.git_cmd = 1;
> 
> -	if (!is_branch)
> +	if (!is_branch && commit) {
>   		strvec_pushl(&cp.args, "update-ref", "HEAD",
>   			     oid_to_hex(&commit->object.oid), NULL);
> -	else {
> +	} else {
>   		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
>   			     symref.buf, NULL);
>   		if (opts->quiet)
> @@ -497,6 +517,10 @@ static int add_worktree(const char *path, const char *refname,
>   	if (ret)
>   		goto done;
> 
> +	if (opts->orphan &&
> +	    (ret = make_worktree_orphan(refname, opts, &child_env)))
> +		goto done;
> +
>   	if (opts->checkout &&
>   	    (ret = checkout_worktree(opts, &child_env)))
>   		goto done;
> @@ -516,7 +540,7 @@ static int add_worktree(const char *path, const char *refname,
>   	 * Hook failure does not warrant worktree deletion, so run hook after
>   	 * is_junk is cleared, but do return appropriate code when hook fails.
>   	 */
> -	if (!ret && opts->checkout) {
> +	if (!ret && opts->checkout && !opts->orphan) {
>   		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> 
>   		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
> @@ -605,6 +629,7 @@ static int add(int ac, const char **av, const char *prefix)
>   	char *path;
>   	const char *branch;
>   	const char *new_branch = NULL;
> +	const char *orphan_branch = NULL;
>   	const char *opt_track = NULL;
>   	const char *lock_reason = NULL;
>   	int keep_locked = 0;
> @@ -616,6 +641,8 @@ static int add(int ac, const char **av, const char *prefix)
>   			   N_("create a new branch")),
>   		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>   			   N_("create or reset a branch")),
> +		OPT_STRING(0, "orphan", &orphan_branch, N_("branch"),
> +			   N_("new unparented branch")),
>   		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
>   		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
>   		OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
> @@ -633,8 +660,20 @@ static int add(int ac, const char **av, const char *prefix)
>   	memset(&opts, 0, sizeof(opts));
>   	opts.checkout = 1;
>   	ac = parse_options(ac, av, prefix, options, git_worktree_add_usage, 0);
> +	opts.orphan = !!orphan_branch;
>   	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
>   		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
> +	if (!!opts.detach + !!opts.orphan + !!new_branch + !!new_branch_force > 1)
> +		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
> +		    "-b", "-B", "--orphan", "--detach");
> +	if (opts.orphan && opt_track)
> +		die(_("'%s' and '%s' cannot be used together"), "--orphan", "--track");
> +	if (opts.orphan && !opts.checkout)
> +		die(_("'%s' and '%s' cannot be used together"), "--orphan",
> +		    "--no-checkout");
> +	if (opts.orphan && ac == 2)
> +		die(_("'%s' and '%s' cannot be used together"), "--orphan",
> +		    _("<commit-ish>"));
>   	if (lock_reason && !keep_locked)
>   		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
>   	if (lock_reason)
> @@ -663,7 +702,9 @@ static int add(int ac, const char **av, const char *prefix)
>   		strbuf_release(&symref);
>   	}
> 
> -	if (ac < 2 && !new_branch && !opts.detach) {
> +	if (opts.orphan) {
> +		new_branch = orphan_branch;
> +	} else if (ac < 2 && !new_branch && !opts.detach) {
>   		const char *s = dwim_branch(path, &new_branch);
>   		if (s)
>   			branch = s;
> @@ -686,7 +727,11 @@ static int add(int ac, const char **av, const char *prefix)
>   	if (!opts.quiet)
>   		print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
> 
> -	if (new_branch) {
> +	if (opts.orphan) {
> +		branch = new_branch;
> +	} else if (!lookup_commit_reference_by_name(branch)) {
> +		die(_("invalid reference: %s"), branch);
> +	} else if (new_branch) {
>   		struct child_process cp = CHILD_PROCESS_INIT;
>   		cp.git_cmd = 1;
>   		strvec_push(&cp.args, "branch");
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index dd729a00d8..45f896dcd0 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -312,6 +312,11 @@ test_wt_add_excl () {
>   test_wt_add_excl -b poodle -B poodle bamboo main
>   test_wt_add_excl -b poodle --detach bamboo main
>   test_wt_add_excl -B poodle --detach bamboo main
> +test_wt_add_excl -B poodle --orphan poodle bamboo
> +test_wt_add_excl -b poodle --orphan poodle bamboo
> +test_wt_add_excl --orphan poodle --detach bamboo
> +test_wt_add_excl --orphan poodle --no-checkout bamboo
> +test_wt_add_excl --orphan poodle bamboo main
> 
>   test_expect_success '"add -B" fails if the branch is checked out' '
>   	git rev-parse newmain >before &&
> @@ -333,6 +338,46 @@ test_expect_success 'add --quiet' '
>   	test_must_be_empty actual
>   '
> 
> +test_expect_success '"add --orphan"' '
> +	test_when_finished "git worktree remove -f -f orphandir" &&
> +	git worktree add --orphan neworphan orphandir &&
> +	echo refs/heads/neworphan >expected &&
> +	git -C orphandir symbolic-ref HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success '"add --orphan" fails if the branch already exists' '
> +	test_when_finished "git branch -D existingbranch" &&
> +	test_when_finished "git worktree remove -f -f orphandir" &&
> +	git worktree add -b existingbranch orphandir main &&
> +	test_must_fail git worktree add --orphan existingbranch orphandir2 &&
> +	test_path_is_missing orphandir2
> +'
> +
> +test_expect_success '"add --orphan" with empty repository' '
> +	test_when_finished "rm -rf empty_repo" &&
> +	echo refs/heads/newbranch >expected &&
> +	GIT_DIR="empty_repo" git init --bare &&
> +	git -C empty_repo  worktree add --orphan newbranch worktreedir &&
> +	git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success '"add" worktree with orphan branch and lock' '
> +	git worktree add --lock --orphan orphanbr orphan-with-lock &&
> +	test_when_finished "git worktree unlock orphan-with-lock || :" &&
> +	test -f .git/worktrees/orphan-with-lock/locked
> +'
> +
> +test_expect_success '"add" worktree with orphan branch, lock, and reason' '
> +	lock_reason="why not" &&
> +	git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
> +	test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
> +	test -f .git/worktrees/orphan-with-lock-reason/locked &&
> +	echo "$lock_reason" >expect &&
> +	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
> +'
> +
>   test_expect_success 'local clone from linked checkout' '
>   	git clone --local here here-clone &&
>   	( cd here-clone && git fsck )
> @@ -449,6 +494,14 @@ setup_remote_repo () {
>   	)
>   }
> 
> +test_expect_success '"add" <path> <remote/branch> w/ no HEAD' '
> +	test_when_finished rm -rf repo_upstream repo_local foo &&
> +	setup_remote_repo repo_upstream repo_local &&
> +	git -C repo_local config --bool core.bare true &&
> +	git -C repo_local branch -D main &&
> +	git -C repo_local worktree add ./foo repo_upstream/foo
> +'
> +
>   test_expect_success '--no-track avoids setting up tracking' '
>   	test_when_finished rm -rf repo_upstream repo_local foo &&
>   	setup_remote_repo repo_upstream repo_local &&
> --
> 2.38.2
> 
> 
