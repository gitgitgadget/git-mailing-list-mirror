Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CC2C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A43061494
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 09:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhC2JXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhC2JXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 05:23:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43804C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 02:23:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo6277808wmq.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQo5nQBTKz6wwuDHF9eMSHBfDp7DYwZM+Q3eb4Mv8fg=;
        b=UZ6ordgOEmOp+BeYdic7veojNTdMILfGpArPqUYLxNVkhFJhCzlOPkNFcBItVQKiCB
         YZ+yQb4ROt+YA9Bz8M+EBBxAKNyOd0chLlmnrNQG/trdwD7jbePESshvZ7hSwiMu7zH4
         vmjGRoBybK6q2UNecZF7xB1xQ7yADxccNF13dpcLo3xXULsFx/DNadgItSmMQ9dGok8b
         pgmbAYrpsFKMRMSubc6S/IemEdD6djDKD3ra+oO7MhdY+Ve5Xh/aSNWz8L2wRB4IOGBj
         OVc8gOD2nrkak6KPyDfw1A8SUxZCAR9goq0aGab3s/XyrEPKU2a7GB/XAOCKr7Dxz9ki
         z3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQo5nQBTKz6wwuDHF9eMSHBfDp7DYwZM+Q3eb4Mv8fg=;
        b=KfZZJIpUnjnzbaU+Hn5JBfzo1Mur8E19eYGB8VRkNvvk84jzMJhJNFyUqM5mtazWDv
         iaYEBA0M38XdgXsnnIQybIirVhl7O+P6ENKyO5eGaxs2VjRLp/wjEAHKqdoGLeFKcuYq
         DN/OJry0H7orT1kLgCQe858+2CR8c8pWbSNe6SPURHNYwgZeQbUdChBE6O9dZkuBYAZt
         oBWcCEaNaqtnnC1Yl6UvFCwnsYFoeWvZ7CisAs+7BPYLnqhb0asRrOvqGNudhP+lR7gv
         lC0dACGKX3usHS5rFLkyPO9kFCKIdPvnsININm4CREPcym0ucvpKRoCxBA7FD7h1N4R4
         4TQw==
X-Gm-Message-State: AOAM531t7LZZTD4IQ++FQno18kPTgJtnlHnES91A+nDb0gmEJ6NzDHPE
        UBWeXx5TDAkBPu7t2/EfBzvpfiPhXVo=
X-Google-Smtp-Source: ABdhPJwZZmmYsYbtCBKk7zWa0j6QFvgE9Tpuen5UgZZvOKqFjar2Xa49O8pz5WQ9TngWo2jK4zC7Sg==
X-Received: by 2002:a05:600c:3790:: with SMTP id o16mr23987491wmr.110.1617009789854;
        Mon, 29 Mar 2021 02:23:09 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id t1sm33047135wry.90.2021.03.29.02.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 02:23:09 -0700 (PDT)
Subject: Re: [PATCH] sequencer: fix edit handling for cherry-pick and revert
 messages
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <440980f5-81c9-4201-61a4-29acb0346c65@gmail.com>
Date:   Mon, 29 Mar 2021 10:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/03/2021 07:16, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> save_opts() should save any non-default values.  It was intended to do
> this, but since most options in struct replay_opts default to 0, it only
> saved non-zero values.  Unfortunatley,

s/Unfortunatley/Unfortunately/ also s/iff/if/ in a few places below.

> this does not always work for
> options.edit.  Roughly speaking, options.edit had a default value of 0
> for cherry-pick but a default value of 1 for revert.  Make save_opts()
> record a value whenever it differs from the default.
> 
> options.edit was also overly simplistic; we had more than two cases.
> The behavior that previously existed was as follows:
> 
>                         Non-conflict commits    Right after Conflict
>      revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>      cherry-pick        No edit                 See above
>      Specify --edit     Edit (ignore isatty(0)) See above
>      Specify --no-edit  (*)                     See above
> 
>      (*) Before stopping for conflicts, No edit is the behavior.  After
>          stopping for conflicts, the --no-edit flag is not saved so see
>          the first two rows.
> 
> However, the expected behavior is:
> 
>                         Non-conflict commits    Right after Conflict
>      revert             Edit iff isatty(0)      Edit iff isatty(0)
>      cherry-pick        No edit                 Edit iff isatty(0)
>      Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>      Specify --no-edit  No edit                 No edit
> 
> In order to get the expected behavior, we need to change options.edit
> to a tri-state: unspecified, false, or true.  When specified, we follow
> what it says.  When unspecified, we need to check whether the current
> commit being created is resolving a conflict as well as consulting
> options.action and isatty(0).  While at it, add a should_edit() utility
> function that compresses options.edit down to a boolean based on the
> additional information for the non-conflict case.
> 
> Make continue_single_pick() (which is the function responsible for
> resuming after conflict cases) 

It might be worth emphasizing that despite its name 
continue_single_pick() is used to commit conflict resolutions regardless 
of the number of picks - I had to check the code to see what it was 
doing in the multi-pick case.

stop assuming edit behavior in all cases,
> so that it can correctly handle !isatty(0) and specific requests to not
> edit the commit message.

Thanks for the thorough description.

> Reported-by: Renato Botelho <garga@freebsd.org>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>      sequencer: fix edit handling for cherry-pick and revert messages
>      
>      save_opts() should save any non-default values. It was intended to do
>      this, but since most options in struct replay_opts default to 0, it only
>      saved non-zero values. Unfortunatley, this does not always work for
>      options.edit. Roughly speaking, options.edit had a default value of 0
>      for cherry-pick but a default value of 1 for revert. Make save_opts()
>      record a value whenever it differs from the default.
>      
>      options.edit was also overly simplistic; we had more than two cases. The
>      behavior that previously existed was as follows:
>      
>                         Non-conflict commits    Right after Conflict
>      revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>      cherry-pick        No edit                 See above
>      Specify --edit     Edit (ignore isatty(0)) See above
>      Specify --no-edit  (*)                     See above
>      
>      (*) Before stopping for conflicts, No edit is the behavior.  After
>          stopping for conflicts, the --no-edit flag is not saved so see
>          the first two rows.
>      
>      
>      However, the expected behavior is:
>      
>                         Non-conflict commits    Right after Conflict
>      revert             Edit iff isatty(0)      Edit iff isatty(0)
>      cherry-pick        No edit                 Edit iff isatty(0)
>      Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>      Specify --no-edit  No edit                 No edit
>      
>      
>      In order to get the expected behavior, we need to change options.edit to
>      a tri-state: unspecified, false, or true. When specified, we follow what
>      it says. When unspecified, we need to check whether the current commit
>      being created is resolving a conflict as well as consulting
>      options.action and isatty(0). While at it, add a should_edit() utility
>      function that compresses options.edit down to a boolean based on the
>      additional information for the non-conflict case.
>      
>      Make continue_single_pick() (which is the function responsible for
>      resuming after conflict cases) stop assuming edit behavior in all cases,
>      so that it can correctly handle !isatty(0) and specific requests to not
>      edit the commit message.
>      
>      Reported-by: Renato Botelho garga@freebsd.org Signed-off-by: Elijah
>      Newren newren@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-988%2Fnewren%2Ffix-sequencer-no-edit-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-988/newren/fix-sequencer-no-edit-v1
> Pull-Request: https://github.com/git/git/pull/988
> 
>   builtin/revert.c                |  4 +--
>   sequencer.c                     | 55 ++++++++++++++++++++++++++-------
>   sequencer.h                     |  6 ++--
>   t/t3510-cherry-pick-sequence.sh | 32 ++++++++++++++++++-
>   4 files changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 314a86c5621b..81441020231a 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   				"--signoff", opts->signoff,
>   				"--no-commit", opts->no_commit,
>   				"-x", opts->record_origin,
> -				"--edit", opts->edit,
> +				"--edit", opts->edit == 1,
>   				NULL);
>   
>   	if (cmd) {
> @@ -230,8 +230,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>   	struct replay_opts opts = REPLAY_OPTS_INIT;
>   	int res;
>   
> -	if (isatty(0))
> -		opts.edit = 1;
>   	opts.action = REPLAY_REVERT;
>   	sequencer_init_config(&opts);
>   	res = run_sequencer(argc, argv, &opts);
> diff --git a/sequencer.c b/sequencer.c
> index 848204d3dc3f..2fe0e0eff7e6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1860,14 +1860,26 @@ static void record_in_rewritten(struct object_id *oid,
>   		flush_rewritten_pending();
>   }
>   
> +static int should_edit(struct replay_opts *opts) {
> +	assert(opts->edit >= -1 && opts->edit <= 1);
> +	if (opts->edit == -1)
> +		/*
> +		 * Note the we only handle the case of non-conflicted
> +		 * commits; continue_single_pick() handles the conflicted
> +		 * commits itself instead of calling this function.
> +		 */
> +		return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
> +	return opts->edit;
> +}
> +
>   static int do_pick_commit(struct repository *r,
>   			  enum todo_command command,
>   			  struct commit *commit,
>   			  struct replay_opts *opts,
>   			  int final_fixup, int *check_todo)
>   {
> -	unsigned int flags = opts->edit ? EDIT_MSG : 0;
> -	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(r);
> +	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
> +	const char *msg_file = should_edit(opts) ? NULL : git_path_merge_msg(r);
>   	struct object_id head;
>   	struct commit *base, *next, *parent;
>   	const char *base_label, *next_label;
> @@ -3101,9 +3113,9 @@ static int save_opts(struct replay_opts *opts)
>   	if (opts->no_commit)
>   		res |= git_config_set_in_file_gently(opts_file,
>   					"options.no-commit", "true");
> -	if (opts->edit)
> -		res |= git_config_set_in_file_gently(opts_file,
> -					"options.edit", "true");
> +	if (opts->edit != -1)
> +		res |= git_config_set_in_file_gently(opts_file, "options.edit",
> +						     opts->edit ? "true" : "false");
>   	if (opts->allow_empty)
>   		res |= git_config_set_in_file_gently(opts_file,
>   					"options.allow-empty", "true");
> @@ -4077,7 +4089,7 @@ static int pick_commits(struct repository *r,
>   	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
>   	if (opts->allow_ff)
>   		assert(!(opts->signoff || opts->no_commit ||
> -			 opts->record_origin || opts->edit ||
> +			 opts->record_origin || should_edit(opts) ||
>   			 opts->committer_date_is_author_date ||
>   			 opts->ignore_date));
>   	if (read_and_refresh_cache(r, opts))
> @@ -4370,14 +4382,35 @@ static int pick_commits(struct repository *r,
>   	return sequencer_remove_state(opts);
>   }
>   
> -static int continue_single_pick(struct repository *r)
> +static int continue_single_pick(struct repository *r, struct replay_opts *opts)
>   {
> -	const char *argv[] = { "commit", NULL };
> +	struct strvec argv = STRVEC_INIT;
> +	int want_edit;
> +	int ret;
>   
>   	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>   	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
>   		return error(_("no cherry-pick or revert in progress"));
> -	return run_command_v_opt(argv, RUN_GIT_CMD);
> +
> +	strvec_push(&argv, "commit");
> +
> +	/*
> +	 * continue_single_pick() handles the case of recovering from a
> +	 * conflict.  should_edit() doesn't handle that case; for a conflict,
> +	 * we want to edit if the user asked for it, or if they didn't specify
> +	 * and stdin is a tty.
> +	 */
> +	want_edit = (opts->edit == 1) || ((opts->edit == -1) && isatty(0));
> +	if (!want_edit)
> +		/*
> +		 * Include --cleanup=strip as well because we don't want the
> +		 * "# Conflicts:" messages.
> +		 */
> +		strvec_pushl(&argv, "--no-edit", "--cleanup=strip", NULL);
> +
> +	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);

I'm not sure why the original was not using run_git_commit(), changing 
it here is probably outside the scope of this patch.

> +	strvec_clear(&argv);
> +	return ret;
>   }
>   
>   static int commit_staged_changes(struct repository *r,
> @@ -4547,7 +4580,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   			goto release_todo_list;
>   		}
>   	} else if (!file_exists(get_todo_path(opts)))
> -		return continue_single_pick(r);
> +		return continue_single_pick(r, opts);
>   	else if ((res = read_populate_todo(r, &todo_list, opts)))
>   		goto release_todo_list;
>   
> @@ -4556,7 +4589,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   		if (refs_ref_exists(get_main_ref_store(r),
>   				    "CHERRY_PICK_HEAD") ||
>   		    refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
> -			res = continue_single_pick(r);
> +			res = continue_single_pick(r, opts);
>   			if (res)
>   				goto release_todo_list;
>   		}
> diff --git a/sequencer.h b/sequencer.h
> index f8b2e4ab8527..d57d8ea23d7a 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -31,8 +31,10 @@ enum commit_msg_cleanup_mode {
>   struct replay_opts {
>   	enum replay_action action;
>   
> -	/* Boolean options */
> +	/* Tri-state options: unspecified, false, or true */
>   	int edit;
> +
> +	/* Boolean options */
>   	int record_origin;
>   	int no_commit;
>   	int signoff;
> @@ -71,7 +73,7 @@ struct replay_opts {
>   	/* Only used by REPLAY_NONE */
>   	struct rev_info *revs;
>   };
> -#define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
> +#define REPLAY_OPTS_INIT { .edit = -1, .action = -1, .current_fixups = STRBUF_INIT }
>   
>   /*
>    * Note that ordering matters in this enum. Not only must it match the mapping
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index b76cb6de91d0..49010aa9469d 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -65,7 +65,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
>   	# gets interrupted, use a high-enough number that is larger
>   	# than the number of parents of any commit we have created
>   	mainline=4 &&
> -	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours initial..anotherpick &&
> +	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours --edit initial..anotherpick &&
>   	test_path_is_dir .git/sequencer &&
>   	test_path_is_file .git/sequencer/head &&
>   	test_path_is_file .git/sequencer/todo &&
> @@ -84,6 +84,36 @@ test_expect_success 'cherry-pick persists opts correctly' '
>   	ours
>   	EOF
>   	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
> +	test_cmp expect actual &&
> +	echo "true" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.edit >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'revert persists opts correctly' '
> +	pristine_detach initial &&
> +	# to make sure that the session to revert a sequence
> +	# gets interrupted, revert commits that are not in the history
> +	# of HEAD.
> +	test_expect_code 1 git revert -s --strategy=recursive -X patience -X ours --no-edit picked yetanotherpick &&
> +	test_path_is_dir .git/sequencer &&
> +	test_path_is_file .git/sequencer/head &&
> +	test_path_is_file .git/sequencer/todo &&
> +	test_path_is_file .git/sequencer/opts &&
> +	echo "true" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
> +	test_cmp expect actual &&
> +	echo "recursive" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.strategy >actual &&
> +	test_cmp expect actual &&
> +	cat >expect <<-\EOF &&
> +	patience
> +	ours
> +	EOF
> +	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
> +	test_cmp expect actual &&
> +	echo "false" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.edit >actual &&
>   	test_cmp expect actual
>   '

These tests check that the options are saved but do not check what we do 
with them. It would be good to have a test that checked we actually open 
the editor when we should to test the new code in 
continue_single_pick(), however as that code calls isatty() that may be 
tricky

I was surprised how big a change was required to the existing code but 
it seems this is surprising tricky to get right - I cannot think of any 
simplifications.

Thanks and Best Wishes

Phillip

>   
> 
> base-commit: 98164e9585e02e31dcf1377a553efe076c15f8c6
> 

