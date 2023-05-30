Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8955C77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 14:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjE3OQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjE3OQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 10:16:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0311A
        for <git@vger.kernel.org>; Tue, 30 May 2023 07:16:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso47227005e9.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456167; x=1688048167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dv15MovLhudb3Do2gKs9nyutG5uzTma8ACrAzTwDlk=;
        b=g8mFt9jAx/ZtgkpaxS2kZei5gundpAWTlt8OlPu76G35nSBFwQAI6ZQjZUeOYTULBm
         8n7kV/HcVO5xCJ0ShrsvsPST8l89DYrhsTXVXz/1Lcc5ZbH/bEHtoDjWIOj9IAR3bHk4
         ltqoFDfaQst1dtZOCV5Nv5dHXpK+eWGE/c1+8RJV0uDtbYS8h6ZJ6qQA2iWYkciAhneQ
         e1tVadbIvMRtKiVLMfOphlF2OQa+B7j/1YmpZ4XyS2xsFy4UP0YNonlQXFokLd/gExKG
         Ozq19ex2j5tVne1zpFU+v1IMbNvH7VrTWTdlnClSpM/0HXQ7SuVRqS2vVAPmcSBMnpXM
         3AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456167; x=1688048167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Dv15MovLhudb3Do2gKs9nyutG5uzTma8ACrAzTwDlk=;
        b=FRhCCfqU6YOBIObvxdp6pbbJqWQ8+gNEeI1Y3M9GVFrp3Ymi5itTOeysLwg+PPN/bE
         SK1vhPHOc90svZaNx0KWH66V16ro4i2lbHHiYEBXyOmYwxVJrEBOowOehynxaC4wh+0K
         2/HGQcpn5RNHVevhdsXsJtJSSu4QEvtmfaDO97CFgkHN9OoDO6pxn7lDZvgyfRWlH3us
         aC4PjpOZSyjn0E1g3v3zv4RK5IexlWbzjr8N7DbDKsgvVpCH3umx/793jQW0vyRnnhnW
         O2cJAe5XjZ2jEB8cMEbdDjTXFjtyMPasG0Bzn3ky75AW7BJjVBVYbu/nK8f8YLtUy1T1
         6N0Q==
X-Gm-Message-State: AC+VfDxqXvGOGcDIYF8TMLGztkKFxlX0ZyWAtljs0qP5kDdX2Ln0USMA
        I6obRgfqZQPifEngTpMZ5uQ=
X-Google-Smtp-Source: ACHHUZ6UdRI0sNvHn0km90GoCVQyJHc5m1UWiH1MHVWyLiO3oxTJyykIiflRveM0glEDY1Gbgc0g3g==
X-Received: by 2002:a5d:5008:0:b0:30a:e647:fc2e with SMTP id e8-20020a5d5008000000b0030ae647fc2emr2401511wrt.19.1685456167213;
        Tue, 30 May 2023 07:16:07 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id h9-20020adffa89000000b002f6176cc6desm3395132wrr.110.2023.05.30.07.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 07:16:06 -0700 (PDT)
Message-ID: <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
Date:   Tue, 30 May 2023 15:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] cherry-pick: refuse cherry-pick sequence if index is
 dirty
Content-Language: en-US
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>
References: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
 <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao

On 28/05/2023 10:08, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
> 
> Cherry-pick, like merge or rebase, refuses to run when there are changes
> in the index. However, if a cherry-pick sequence is requested, this
> refusal happens "too late": when the cherry-pick sequence has already
> started, and an "--abort" or "--quit" is needed to resume normal
> operation.
> 
> Normally, when an operation is "in-progress" and you want to go back to
> where you were before, "--abort" is the right thing to run. If you run
> "git cherry-pick --abort" in this specific situation, however, your
> staged changes are destroyed as part of the abort! Generally speaking,
> the abort process assumes any changes in the index are part of the
> operation to be aborted.
> 
> Add an earlier check in the cherry-pick sequence process to ensure that
> the index is clean, introducing a new general "quit if index dirty" function
> derived from the existing worktree-level function used in rebase and pull.
> Also add a test.

Thanks for working on this, I think it useful to have this added safety 
check.
>   sequencer.c                     | 53 ++++++++++++++++------------
>   t/t3510-cherry-pick-sequence.sh | 10 ++++++
>   wt-status.c                     | 61 ++++++++++++++++++++++++++-------
>   wt-status.h                     |  5 +++
>   4 files changed, 94 insertions(+), 35 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b553b49fbb6..ea1c34045d3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3162,38 +3162,48 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>   	return 0;
>   }
>   
> -static int create_seq_dir(struct repository *r)
> +static const char *cherry_pick_action_name(enum replay_action action) {
> +	switch (action) {
> +	case REPLAY_REVERT:
> +		return "revert";
> +		break;
> +	case REPLAY_PICK:
> +		return "cherry-pick";
> +		break;
> +	default:
> +		BUG("unexpected action in cherry_pick_action_name");
> +	}
> +}
> +
> +static int create_seq_dir(struct repository *r, enum replay_action requested_action)
>   {
> -	enum replay_action action;
> +	enum replay_action in_progress_action;
> +	const char *in_progress_action_name = NULL;
>   	const char *in_progress_error = NULL;
>   	const char *in_progress_advice = NULL;
> +	const char *requested_action_name = NULL;
>   	unsigned int advise_skip =
>   		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") ||
>   		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
>   
> -	if (!sequencer_get_last_command(r, &action)) {
> -		switch (action) {
> -		case REPLAY_REVERT:
> -			in_progress_error = _("revert is already in progress");
> -			in_progress_advice =
> -			_("try \"git revert (--continue | %s--abort | --quit)\"");
> -			break;
> -		case REPLAY_PICK:
> -			in_progress_error = _("cherry-pick is already in progress");
> -			in_progress_advice =
> -			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
> -			break;
> -		default:
> -			BUG("unexpected action in create_seq_dir");
> -		}
> +	if (!sequencer_get_last_command(r, &in_progress_action)) {
> +		in_progress_action_name = cherry_pick_action_name(in_progress_action);
> +		in_progress_error = _("%s is already in progress");
> +		in_progress_advice =
> +		_("try \"git %s (--continue | %s--abort | --quit)\"");
>   	}
>   	if (in_progress_error) {
> -		error("%s", in_progress_error);
> +		error(in_progress_error, in_progress_action_name);
>   		if (advice_enabled(ADVICE_SEQUENCER_IN_USE))
>   			advise(in_progress_advice,
> +				in_progress_action_name,
>   				advise_skip ? "--skip | " : "");
>   		return -1;
>   	}

I found the changes up to this point a bit confusing. Maybe I've missed 
something but I don't think they are really related to fixing the bug 
described in the commit message. As such they're a distraction from the 
"real" fix.


> +	requested_action_name = cherry_pick_action_name(requested_action);

We already have the function action_name() so I don't think we need to 
add cherry_pick_action_name(). Also the name of the new function is 
confusing as it may return "revert".

> +	if (require_clean_index(r, requested_action_name,
> +				    _("Please commit or stash them."), 1, 1))

How does this interact with "--no-commit"? I think the check that you 
refer to in the commit message is in do_pick_commit() where we have

	if (opts->no_commit) {
		/*
		 * We do not intend to commit immediately.  We just want to
		 * merge the differences in, so let's compute the tree
		 * that represents the "current" state for the merge machinery
		 * to work on.
		 */
		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
			return error(_("your index file is unmerged."));
	} else {
		unborn = repo_get_oid(r, "HEAD", &head);
		/* Do we want to generate a root commit? */
		if (is_pick_or_similar(command) && opts->have_squash_onto &&
		    oideq(&head, &opts->squash_onto)) {
			if (is_fixup(command))
				return error(_("cannot fixup root commit"));
			flags |= CREATE_ROOT_COMMIT;
			unborn = 1;
		} else if (unborn)
			oidcpy(&head, the_hash_algo->empty_tree);
		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
				       NULL, 0))
			return error_dirty_index(r, opts);
	}

I think it would be simpler to reuse the existing check by extracting 
the "else" clause above into a separate function in sequencer.c and call 
it here guarded by "if (!opts->no_commit)" as well as in that "else" 
clause in do_pick_commit()

Best Wishes

Phillip

> +		return -1;
>   	if (mkdir(git_path_seq_dir(), 0777) < 0)
>   		return error_errno(_("could not create sequencer directory '%s'"),
>   				   git_path_seq_dir());
> @@ -5223,12 +5233,11 @@ int sequencer_pick_revisions(struct repository *r,
>   
>   	/*
>   	 * Start a new cherry-pick/ revert sequence; but
> -	 * first, make sure that an existing one isn't in
> -	 * progress
> +	 * first, make sure that the index is clean and that
> +	 * an existing one isn't in progress.
>   	 */
> -
>   	if (walk_revs_populate_todo(&todo_list, opts) ||
> -			create_seq_dir(r) < 0)
> +			create_seq_dir(r, opts->action) < 0)
>   		return -1;
>   	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT))
>   		return error(_("can't revert as initial commit"));
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 3b0fa66c33d..e8f4138bf89 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -47,6 +47,16 @@ test_expect_success 'cherry-pick persists data on failure' '
>   	test_path_is_file .git/sequencer/opts
>   '
>   
> +test_expect_success 'cherry-pick sequence refuses to run on dirty index' '
> +	pristine_detach initial &&
> +	touch localindexchange &&
> +	git add localindexchange &&
> +	echo picking &&
> +	test_must_fail git cherry-pick initial..picked &&
> +	test_path_is_missing .git/sequencer &&
> +	test_must_fail git cherry-pick --abort
> +'
> +
>   test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
>   	pristine_detach initial &&
>   	test_must_fail git cherry-pick base..anotherpick &&
> diff --git a/wt-status.c b/wt-status.c
> index 068b76ef6d9..e6ecb3fa606 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2616,15 +2616,12 @@ int has_uncommitted_changes(struct repository *r,
>   	return result;
>   }
>   
> -/**
> - * If the work tree has unstaged or uncommitted changes, dies with the
> - * appropriate message.
> - */
> -int require_clean_work_tree(struct repository *r,
> -			    const char *action,
> -			    const char *hint,
> -			    int ignore_submodules,
> -			    int gently)
> +static int require_clean_index_or_work_tree(struct repository *r,
> +				     const char *action,
> +				     const char *hint,
> +				     int ignore_submodules,
> +				     int check_index_only,
> +				     int gently)
>   {
>   	struct lock_file lock_file = LOCK_INIT;
>   	int err = 0, fd;
> @@ -2635,10 +2632,12 @@ int require_clean_work_tree(struct repository *r,
>   		repo_update_index_if_able(r, &lock_file);
>   	rollback_lock_file(&lock_file);
>   
> -	if (has_unstaged_changes(r, ignore_submodules)) {
> -		/* TRANSLATORS: the action is e.g. "pull with rebase" */
> -		error(_("cannot %s: You have unstaged changes."), _(action));
> -		err = 1;
> +	if (!check_index_only) {
> +		if (has_unstaged_changes(r, ignore_submodules)) {
> +			/* TRANSLATORS: the action is e.g. "pull with rebase" */
> +			error(_("cannot %s: You have unstaged changes."), _(action));
> +			err = 1;
> +		}
>   	}
>   
>   	if (has_uncommitted_changes(r, ignore_submodules)) {
> @@ -2659,3 +2658,39 @@ int require_clean_work_tree(struct repository *r,
>   
>   	return err;
>   }
> +
> +/**
> + * If the work tree has unstaged or uncommitted changes, dies with the
> + * appropriate message.
> + */
> +int require_clean_work_tree(struct repository *r,
> +			    const char *action,
> +			    const char *hint,
> +			    int ignore_submodules,
> +			    int gently)
> +{
> +	return require_clean_index_or_work_tree(r,
> +						action,
> +						hint,
> +						ignore_submodules,
> +						0,
> +						gently);
> +}
> +
> +/**
> + * If the work tree has uncommitted changes, dies with the appropriate
> + * message.
> + */
> +int require_clean_index(struct repository *r,
> +			const char *action,
> +			const char *hint,
> +			int ignore_submodules,
> +			int gently)
> +{
> +	return require_clean_index_or_work_tree(r,
> +						action,
> +						hint,
> +						ignore_submodules,
> +						1,
> +						gently);
> +}
> diff --git a/wt-status.h b/wt-status.h
> index ab9cc9d8f03..9f424d7c16c 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -181,5 +181,10 @@ int require_clean_work_tree(struct repository *repo,
>   			    const char *hint,
>   			    int ignore_submodules,
>   			    int gently);
> +int require_clean_index(struct repository *repo,
> +			    const char *action,
> +			    const char *hint,
> +			    int ignore_submodules,
> +			    int gently);
>   
>   #endif /* STATUS_H */
> 
> base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680

