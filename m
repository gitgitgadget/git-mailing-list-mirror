Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C0147C6C
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151747; cv=none; b=HXoKS2NAthpJFKpAfH5puZwoSYH38W8iRTEbbBymhRUYb8EyOymdggCWBCAsSxVe4HXkKkwpahHN3QTU0jF+Xw8KiwpBl8mH+NP4hht3qVn10dXkqJ/Mg2hsnCDE2gwfxQgSvNsHdL/HSFINNI+eCzw9Fuq285sVOe+eB78yQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151747; c=relaxed/simple;
	bh=FUC4e2FwLRxwJ8oGEThLFwPQ0YATrdNbFQWVvywA/uY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N5SVC0BMlwW/rxXQrnNy7+0RGwVQtQ4k5Z7hpR1jd9QQbhgsMU/UuFYAgv2mvFJ2OWcv6/I/u9HySwFu9LHquosinepYBgcG7N9DxkiyZ6zfWxgu6XqdsPDwUxTjQAxyAB+HjnVjdAyjGdf4FRxBdfnhPaeGu/g7OK7NaCzIFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/5Zmn2F; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/5Zmn2F"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso7614073e87.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712151744; x=1712756544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UG5iQYcHULhGXUV0rnY9XOlpuq5RkGW4jeXX/DROYWA=;
        b=g/5Zmn2Fod5jAURxnnif1Kk1frnR5SQytB3/RF5jEadNCUeJTiiqo4lUl5QxOh7W1T
         +FjYLoj3EY4oDz5S+k/SJdgpB++x/qtPPyDz+bMBRj3xcJ+CZcIjY5mvpcdHnv9lu6Oy
         05xhjpyYoqKZvl3o8SHOUnDuMjhHKqqpIR92rEnCm5y+FgUtSL/2zXH6BEQiokTbn+QE
         F+5DnwU7UHBaT61+A6SNg+F3vI3rrq+3+Mc1H5WmCYFNKOBN1C/D0LHhi+1uGXHDL6n6
         jjLJIaYn2Dm0Zs4gWxbCjM6TXofQYPi2f2LKNe7e5xlS2YvsQfiu6YZr/n2fYuytQrnc
         L+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151744; x=1712756544;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG5iQYcHULhGXUV0rnY9XOlpuq5RkGW4jeXX/DROYWA=;
        b=OqNBH6jM/4cPXllQElFoex2+Q/mQGjXgR43LOsWJqhmYNjCAFrR2XTxA/BK/kND+cf
         5Wpal6HAw+baklxogV30nB40hfs3UiIpexBIIdfjq8fXpsmC7+SDDgcbWQFvzBj66J0h
         FTlecAe9nTo44yH7Fufhy3R1f90E9R518s16DERcjzfWquGD7gHZX24vLvCmSvSXdhtu
         BWK90/WmSQomVpK3IvyJfO8k4pegcaLRrFqLGrG0fcphzW2HdZ6XJxxdOc2ZD79aENoI
         Q25kre2gP7Ua0QcWaD0Vt/RBQrBZrnKmI1LaJeCYCOuYy+2sLsdexA0ghAiDmZm+Wjgs
         dyhg==
X-Forwarded-Encrypted: i=1; AJvYcCVb2sR/ayULt0pWj78sbWXkBsCYHQxLmUNYh/aY93kRyjxzL6mUEiX4nMCe3hjIqRq622xc6kj9doBJJFbdGPvTgvXx
X-Gm-Message-State: AOJu0YztPuV7RUpPzn8y7se7W9bvriPuNXqLt3s/PJqrBM1WcfElUEUR
	/SbOv1WQz32vZBtWaUhXdVYB+K3/OEiXk3u8RdMbbgANf7bRiqF4
X-Google-Smtp-Source: AGHT+IEvkwld//3Kjwul28ILtdqEBVX7eL9zFpF7MwSlE8kRajP6g6cBK4v2CNMej2NKLCdda1rRAw==
X-Received: by 2002:a05:6512:4893:b0:513:d0e2:8a1e with SMTP id eq19-20020a056512489300b00513d0e28a1emr9588332lfb.54.1712151743310;
        Wed, 03 Apr 2024 06:42:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0041543b57ca2sm21696465wmq.21.2024.04.03.06.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:42:22 -0700 (PDT)
Message-ID: <db27d746-5b83-45fa-a8e7-d88022ce1ca5@gmail.com>
Date: Wed, 3 Apr 2024 14:42:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Philippe Blain <levraiphilippeblain@gmail.com>,
 Brian Lyles <brianmlyles@gmail.com>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

If anyone has time to review this I'd be very grateful. I've added a 
couple of people to the cc list who have recently contributed to the 
sequencer but if anyone else fancies taking a look please do.

Thanks

Phillip

On 26/02/2024 10:58, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The only todo commands that accept a merge commit are "merge" and
> "reset". All the other commands like "pick" or "reword" fail when they
> try to pick a a merge commit and print the message
> 
>      error: commit abc123 is a merge but no -m option was given.
> 
> followed by a hint about the command being rescheduled. This message is
> designed to help the user when they cherry-pick a merge and forget to
> pass "-m". For users who are rebasing the message is confusing as there
> is no way for rebase to cherry-pick the merge.
> 
> Improve the user experience by detecting the error when the todo list is
> parsed rather than waiting for the "pick" command to fail and print a
> message recommending the "merge" command instead. We recommend "merge"
> rather than "exec git cherry-pick -m ..." on the assumption that
> cherry-picking merges is relatively rare and it is more likely that the
> user chose "pick" by a mistake.
> 
> It would be possible to support cherry-picking merges by allowing the
> user to pass "-m" to "pick" commands but that adds complexity to do
> something that can already be achieved with
> 
>      exec git cherry-pick -m1 abc123
> 
> The change is relatively straight forward but is complicated slightly as
> we now need to tell the parser if we're rebasing or not.
> 
> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>      rebase -i: improve error message when picking merge
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1672%2Fphillipwood%2Frebase-reject-merges-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1672/phillipwood/rebase-reject-merges-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1672
> 
>   builtin/rebase.c              |  2 +-
>   rebase-interactive.c          |  7 ++---
>   sequencer.c                   | 49 ++++++++++++++++++++++++++++++-----
>   sequencer.h                   |  2 +-
>   t/t3404-rebase-interactive.sh | 33 +++++++++++++++++++++++
>   5 files changed, 81 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b086f651a6..a33e41c44da 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -297,7 +297,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   	else {
>   		discard_index(&the_index);
>   		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
> -						&todo_list))
> +						&todo_list, 1))
>   			BUG("unusable todo list");
>   
>   		ret = complete_action(the_repository, &replay, flags,
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index d9718409b3d..78d5ed1a41d 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -114,7 +114,8 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>   	 * it.  If there is an error, we do not return, because the user
>   	 * might want to fix it in the first place. */
>   	if (!initial)
> -		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
> +		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf,
> +							todo_list, 1) |
>   			file_exists(rebase_path_dropped());
>   
>   	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
> @@ -134,7 +135,7 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>   	if (initial && new_todo->buf.len == 0)
>   		return -3;
>   
> -	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
> +	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo, 1)) {
>   		fprintf(stderr, _(edit_todo_list_advice));
>   		return -4;
>   	}
> @@ -234,7 +235,7 @@ int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_
>   	int res = 0;
>   
>   	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
> -		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
> +		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup, 1);
>   		res = todo_list_check(&backup, todo_list);
>   	}
>   
> diff --git a/sequencer.c b/sequencer.c
> index 91de546b323..cf808c24d20 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2550,8 +2550,37 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
>   	return 0;
>   }
>   
> +static int error_merge_commit(enum todo_command command)
> +{
> +	switch(command) {
> +	case TODO_PICK:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s'"),
> +			     todo_command_info[command].str, "merge -C");
> +
> +	case TODO_REWORD:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s'"),
> +			     todo_command_info[command].str, "merge -c");
> +
> +	case TODO_EDIT:
> +		return error(_("'%s' does not accept merge commits, "
> +			       "please use '%s' followed by '%s'"),
> +			     todo_command_info[command].str,
> +			     "merge -C", "break");
> +
> +	case TODO_FIXUP:
> +	case TODO_SQUASH:
> +		return error(_("cannot squash merge commit into another commit"));
> +
> +	default:
> +		BUG("unexpected todo_command");
> +	}
> +}
> +
>   static int parse_insn_line(struct repository *r, struct todo_item *item,
> -			   const char *buf, const char *bol, char *eol)
> +			   const char *buf, const char *bol, char *eol,
> +			   int rebasing)
>   {
>   	struct object_id commit_oid;
>   	char *end_of_object_name;
> @@ -2655,7 +2684,12 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   		return status;
>   
>   	item->commit = lookup_commit_reference(r, &commit_oid);
> -	return item->commit ? 0 : -1;
> +	if (!item->commit)
> +		return -1;
> +	if (rebasing && item->command != TODO_MERGE &&
> +	    item->commit->parents && item->commit->parents->next)
> +		return error_merge_commit(item->command);
> +	return 0;
>   }
>   
>   int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
> @@ -2686,7 +2720,7 @@ int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *
>   }
>   
>   int todo_list_parse_insn_buffer(struct repository *r, char *buf,
> -				struct todo_list *todo_list)
> +				struct todo_list *todo_list, int rebasing)
>   {
>   	struct todo_item *item;
>   	char *p = buf, *next_p;
> @@ -2704,7 +2738,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>   
>   		item = append_new_todo(todo_list);
>   		item->offset_in_buf = p - todo_list->buf.buf;
> -		if (parse_insn_line(r, item, buf, p, eol)) {
> +		if (parse_insn_line(r, item, buf, p, eol, rebasing)) {
>   			res = error(_("invalid line %d: %.*s"),
>   				i, (int)(eol - p), p);
>   			item->command = TODO_COMMENT + 1;
> @@ -2852,7 +2886,8 @@ static int read_populate_todo(struct repository *r,
>   	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
>   		return -1;
>   
> -	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
> +	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list,
> +					  is_rebase_i(opts));
>   	if (res) {
>   		if (is_rebase_i(opts))
>   			return error(_("please fix this using "
> @@ -2882,7 +2917,7 @@ static int read_populate_todo(struct repository *r,
>   		struct todo_list done = TODO_LIST_INIT;
>   
>   		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
> -		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
> +		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done, 1))
>   			todo_list->done_nr = count_commands(&done);
>   		else
>   			todo_list->done_nr = 0;
> @@ -6286,7 +6321,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   	strbuf_release(&buf2);
>   	/* Nothing is done yet, and we're reparsing, so let's reset the count */
>   	new_todo.total_nr = 0;
> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
> +	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo, 1) < 0)
>   		BUG("invalid todo list after expanding IDs:\n%s",
>   		    new_todo.buf.buf);
>   
> diff --git a/sequencer.h b/sequencer.h
> index dcef7bb99c0..ed2c4b38514 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -136,7 +136,7 @@ struct todo_list {
>   }
>   
>   int todo_list_parse_insn_buffer(struct repository *r, char *buf,
> -				struct todo_list *todo_list);
> +				struct todo_list *todo_list, int rebasing);
>   int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
>   			    const char *file, const char *shortrevisions,
>   			    const char *shortonto, int num, unsigned flags);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 64b641002e4..20b8589ad07 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2203,6 +2203,39 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
>   	test_path_is_missing execed
>   '
>   
> +test_expect_success 'non-merge commands reject merge commits' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout E &&
> +	git merge I &&
> +	oid=$(git rev-parse HEAD) &&
> +	cat >todo <<-EOF &&
> +	pick $oid
> +	reword $oid
> +	edit $oid
> +	fixup $oid
> +	squash $oid
> +	EOF
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i HEAD 2>actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	error: ${SQ}pick${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ}
> +	error: invalid line 1: pick $oid
> +	error: ${SQ}reword${SQ} does not accept merge commits, please use ${SQ}merge -c${SQ}
> +	error: invalid line 2: reword $oid
> +	error: ${SQ}edit${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ} followed by ${SQ}break${SQ}
> +	error: invalid line 3: edit $oid
> +	error: cannot squash merge commit into another commit
> +	error: invalid line 4: fixup $oid
> +	error: cannot squash merge commit into another commit
> +	error: invalid line 5: squash $oid
> +	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${SQ}git rebase --continue${SQ}.
> +	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged
> 
> base-commit: c875e0b8e036c12cfbf6531962108a063c7a821c
