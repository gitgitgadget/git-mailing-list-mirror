Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244F1BDC4
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244582; cv=none; b=JItOcI2qlbIBrF2dIvkTqM8v7eL2020glegkaeY9FBs5zw/mPev/4xHMiBrJGKShBwsJ9x/aa0UQ5IrpVIgWGt6N6NdCZNnGGFjoIH05G4MeSas1EvqW+FdSm6kVYmruuJVh7RsQHaXhtpb4ngy+EaeR2z0C6oUyfeBeiaF9j2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244582; c=relaxed/simple;
	bh=gsUxiLUgWF4nCWqc7HMJZpOhicpY/Q9NOJretGJmXeY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nTV9iMDsvH7aDlCkkAYbJuOtIUh4Pfo5gGPp60oaXfArmXCgNT1edCwsAbveNM7ojDxB6w2Y4+cuyfAl3LBlFhwP0C84Lafk5lgUhFYt1f+uHWi7E+TZgWyunV3V2Q2h4QEGFhHrvUHKAleGWRbX5FKUGouaWSd+Jy9uW76Ok0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG6OhHCp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG6OhHCp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4162a3e2d22so6762645e9.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712244579; x=1712849379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jgeGUIp4pq2b4x/wmWVc6JH7XFuN8LHV/jpUwyR/Ks=;
        b=TG6OhHCpEEn/hdHmTYiF6Y0RYyG/hXYdlGe9TMUDiMYWUxoYXLyUE+aaxDA+3mbwvs
         ZPKYTdCFCNv9Xp8tp0gLPtRCEgvYI/rDErd2lxPlf55VkWr+BvGeMGk4HzfjARRya4hY
         oa9VPBgimjrGy3zbK7tgvf0zjJsaFmdPisd7Ua2rS6xd9l8wNupM2h97OiDLuG97CRgb
         w5wgd2ttqOOSbF828XhZyQp5ZpB2/0OS6Hs+XuotuReQzxiIcn/cdik8DYwaRMypKyZF
         Pdxq56sja426VzVDZTPMsczxVnydnOzRBplOLiBY14WYj3enYZv6MHtYqahEqLRtsAKb
         vJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712244579; x=1712849379;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jgeGUIp4pq2b4x/wmWVc6JH7XFuN8LHV/jpUwyR/Ks=;
        b=TxRjXU+AR5RmG6153dC8KI6+z9vr0kZ0kEpOMs5VQ5Xo9ah1pNv2Z0m+LRzZ3eEd5n
         C9s0keLqd1kd0vf7+YlU8jRtSMQV/bas5rFyuigbbgsUkA+arcPYluI1OXoVE2wUQC8d
         ECJu5v3Cb9x3Q1Fdn2pGrhT8mVDoTUxFsRxEZd6ZEggusLPY+2lhlIMEAJZYT8tbBtKF
         DQwfXnw9EfyZo0YlA1HVi/+Y/vUpxMK29zRjKqolHeeZq82fGZkYhyTeSQILHL689EeZ
         5NrPR/fxodvpk9WWvkEwPIdFf1O8YLo7DUCvaxNH3mD4T1mEuT0CmGUsGSaEXjOo1njA
         7hOw==
X-Gm-Message-State: AOJu0YwB+ibAxqr4EF789t6qYhF1MwLHhJJey4U5/FqGhA/HyU2jcRiW
	QMSLL38MYcTQz07hSOq8qmcF2rIKUdGebxDrhNajPE7LS8GeaH0k
X-Google-Smtp-Source: AGHT+IFUnrZig8O06tc6I/5s4fXyu4Bgs7kvr03dZu01u66b/4bAx8ehqXgtFTRbHWMv7TDy7eOBEA==
X-Received: by 2002:a05:600c:1c87:b0:414:63c2:23cc with SMTP id k7-20020a05600c1c8700b0041463c223ccmr95938wms.2.1712244578695;
        Thu, 04 Apr 2024 08:29:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0041569a819dbsm3054019wmo.1.2024.04.04.08.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 08:29:38 -0700 (PDT)
Message-ID: <875639c6-1efc-4fb2-b80c-2205b67c263b@gmail.com>
Date: Thu, 4 Apr 2024 16:29:37 +0100
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
To: Patrick Steinhardt <ps@pks.im>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <Zg5D3dXYFM2SONE-@tanuki>
Content-Language: en-US
In-Reply-To: <Zg5D3dXYFM2SONE-@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/04/2024 07:08, Patrick Steinhardt wrote:
> On Mon, Feb 26, 2024 at 10:58:07AM +0000, Phillip Wood via GitGitGadget wrote:
> [...]
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 5b086f651a6..a33e41c44da 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -297,7 +297,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>>   	else {
>>   		discard_index(&the_index);
>>   		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
>> -						&todo_list))
>> +						&todo_list, 1))
> 
> I think these booleans are somewhat hard to read. I may be
> overengineering this, so please feel free to push back, but would it
> make more sense to introduce a `unsigned flags` field and then have a
> `PARSE_INSN_IS_REBASING` flag?

I agree the boolean is a bit opaque, I don't think they are that unusual 
in the code base but that doesn't mean they're readable. I had hoped to 
pass an instance of 'struct replay_opts' to parse_insn_line() and then 
call is_rebase_i() which there which would have been nicer. 
Unfortunately "git rebase --edit-todo" does not instantiate an instance 
of that struct as it is not needed for editing the todo list so I went 
with a boolean instead. There are one or two places where we need to use 
is_rebase_i() for this when calling parse_insn_line() which makes using 
an unsigned flags argument a bit messy. I'll have a look and see how 
hard it would be to ensure we always have a valid 'struct replay_opts' 
when calling parse_insn_line().

>> +static int error_merge_commit(enum todo_command command)
>> +{
>> +	switch(command) {
>> +	case TODO_PICK:
>> +		return error(_("'%s' does not accept merge commits, "
>> +			       "please use '%s'"),
>> +			     todo_command_info[command].str, "merge -C");
> 
> I wonder how actionable these commands are. Can we give the full command
> that the user can use instead, including the commit ID?

The calling function also prints the offending line so the user can see 
the commit details there.

> That raises another question though: how exactly is the user supposed to
> perform the merge? Should they merge the merge commit, resulting in two
> merge commits? Should they pick one of the sides, and if so, which one?
> I guess the answer is "it depends", which makes it harder for us to come
> up with actionable advice here.

I agree it would be nice to be more precise but I'm not sure we can tell 
what the user is actually trying to do so I think the best we can do is 
point them in the direction of the 'merge' command.

>> +	case TODO_REWORD:
>> +		return error(_("'%s' does not accept merge commits, "
>> +			       "please use '%s'"),
>> +			     todo_command_info[command].str, "merge -c");
> 
> I was about to suggest that the above two cases should be merged. But
> then I realized that it's "merge -c" here, but "merge -C" in the first
> case.

Yes, it is a subtle difference.

Thanks very much for taking a look at this

Phillip

> Patrick
> 
>> +	case TODO_EDIT:
>> +		return error(_("'%s' does not accept merge commits, "
>> +			       "please use '%s' followed by '%s'"),
>> +			     todo_command_info[command].str,
>> +			     "merge -C", "break");
>> +
>> +	case TODO_FIXUP:
>> +	case TODO_SQUASH:
>> +		return error(_("cannot squash merge commit into another commit"));
>> +
>> +	default:
>> +		BUG("unexpected todo_command");
>> +	}
>> +}
>> +
>>   static int parse_insn_line(struct repository *r, struct todo_item *item,
>> -			   const char *buf, const char *bol, char *eol)
>> +			   const char *buf, const char *bol, char *eol,
>> +			   int rebasing)
>>   {
>>   	struct object_id commit_oid;
>>   	char *end_of_object_name;
>> @@ -2655,7 +2684,12 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>   		return status;
>>   
>>   	item->commit = lookup_commit_reference(r, &commit_oid);
>> -	return item->commit ? 0 : -1;
>> +	if (!item->commit)
>> +		return -1;
>> +	if (rebasing && item->command != TODO_MERGE &&
>> +	    item->commit->parents && item->commit->parents->next)
>> +		return error_merge_commit(item->command);
>> +	return 0;
>>   }
>>   
>>   int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *action)
>> @@ -2686,7 +2720,7 @@ int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *
>>   }
>>   
>>   int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>> -				struct todo_list *todo_list)
>> +				struct todo_list *todo_list, int rebasing)
>>   {
>>   	struct todo_item *item;
>>   	char *p = buf, *next_p;
>> @@ -2704,7 +2738,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>>   
>>   		item = append_new_todo(todo_list);
>>   		item->offset_in_buf = p - todo_list->buf.buf;
>> -		if (parse_insn_line(r, item, buf, p, eol)) {
>> +		if (parse_insn_line(r, item, buf, p, eol, rebasing)) {
>>   			res = error(_("invalid line %d: %.*s"),
>>   				i, (int)(eol - p), p);
>>   			item->command = TODO_COMMENT + 1;
>> @@ -2852,7 +2886,8 @@ static int read_populate_todo(struct repository *r,
>>   	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
>>   		return -1;
>>   
>> -	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
>> +	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list,
>> +					  is_rebase_i(opts));
>>   	if (res) {
>>   		if (is_rebase_i(opts))
>>   			return error(_("please fix this using "
>> @@ -2882,7 +2917,7 @@ static int read_populate_todo(struct repository *r,
>>   		struct todo_list done = TODO_LIST_INIT;
>>   
>>   		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
>> -		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
>> +		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done, 1))
>>   			todo_list->done_nr = count_commands(&done);
>>   		else
>>   			todo_list->done_nr = 0;
>> @@ -6286,7 +6321,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>>   	strbuf_release(&buf2);
>>   	/* Nothing is done yet, and we're reparsing, so let's reset the count */
>>   	new_todo.total_nr = 0;
>> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
>> +	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo, 1) < 0)
>>   		BUG("invalid todo list after expanding IDs:\n%s",
>>   		    new_todo.buf.buf);
>>   
>> diff --git a/sequencer.h b/sequencer.h
>> index dcef7bb99c0..ed2c4b38514 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -136,7 +136,7 @@ struct todo_list {
>>   }
>>   
>>   int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>> -				struct todo_list *todo_list);
>> +				struct todo_list *todo_list, int rebasing);
>>   int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
>>   			    const char *file, const char *shortrevisions,
>>   			    const char *shortonto, int num, unsigned flags);
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 64b641002e4..20b8589ad07 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -2203,6 +2203,39 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
>>   	test_path_is_missing execed
>>   '
>>   
>> +test_expect_success 'non-merge commands reject merge commits' '
>> +	test_when_finished "test_might_fail git rebase --abort" &&
>> +	git checkout E &&
>> +	git merge I &&
>> +	oid=$(git rev-parse HEAD) &&
>> +	cat >todo <<-EOF &&
>> +	pick $oid
>> +	reword $oid
>> +	edit $oid
>> +	fixup $oid
>> +	squash $oid
>> +	EOF
>> +	(
>> +		set_replace_editor todo &&
>> +		test_must_fail git rebase -i HEAD 2>actual
>> +	) &&
>> +	cat >expect <<-EOF &&
>> +	error: ${SQ}pick${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ}
>> +	error: invalid line 1: pick $oid
>> +	error: ${SQ}reword${SQ} does not accept merge commits, please use ${SQ}merge -c${SQ}
>> +	error: invalid line 2: reword $oid
>> +	error: ${SQ}edit${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ} followed by ${SQ}break${SQ}
>> +	error: invalid line 3: edit $oid
>> +	error: cannot squash merge commit into another commit
>> +	error: invalid line 4: fixup $oid
>> +	error: cannot squash merge commit into another commit
>> +	error: invalid line 5: squash $oid
>> +	You can fix this with ${SQ}git rebase --edit-todo${SQ} and then run ${SQ}git rebase --continue${SQ}.
>> +	Or you can abort the rebase with ${SQ}git rebase --abort${SQ}.
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>>   # This must be the last test in this file
>>   test_expect_success '$EDITOR and friends are unchanged' '
>>   	test_editor_unchanged
>>
>> base-commit: c875e0b8e036c12cfbf6531962108a063c7a821c
>> -- 
>> gitgitgadget
>>
