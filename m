Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C970E1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeHCU0M (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:26:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37483 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeHCU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:26:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so6243150wrr.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LayDY89o/jz70sneklCTnmesGXJyFb/FrcMyf1GOGB4=;
        b=lAJx1JR8cf3o2R2WdUpY+2Fc5vqIaCYfucZScIdskjRioi3xtgd9q9W5MPB5N9/Qgz
         P7GGeLhTJgxYpQD+g9mex1GMIFD5+IL9MAcoLn0N1/3j4tLf3kW2Nh9B3FLvuS7qrCOy
         29mwgMgB6lE5A9xG3khZwu5g9Y1cyCNuyyT7mKmDEtSjrTCMINPD/bfiPU44g8bESjaX
         yPYaS65gtbsLy4bmi2q3dGU8M0UGZvNV9v6zF6mY90aVx6cevRsKyUEBBFc+sifvz+rI
         QBFBfw2yLGaCxXktm/htBCtSWxatZ1WOQp60d6LoKf2r1XgAf2uWH4WfklWtOCRqdP/k
         5UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LayDY89o/jz70sneklCTnmesGXJyFb/FrcMyf1GOGB4=;
        b=f9jxTEQIcJ4XJaE62bgoqTdcfuhvG16snvCh2j05LWDlufWfH2dcA7wYFU/u8np1wN
         NQdBj+VqymtzIhZWC1Hk5hIcbk49utCx0hB8vtlbWIcqadltgzt8aLxMalP5srcTYT8i
         nOPYQszBWzfLoEFaGybjXayeO4ZKxDNm28XEeev4exWjSzRh6DLfexz5YUUY0ohZMXfA
         r12bCzlTeFB5I7A7TY3fCBTOzuKrhCRfAWxOZERXC1OocuooFDBgXEP8MTQ3V/9m+yg0
         Pan+vsKSe5XS0ZSD/6wPg4NSpkcTn9iGBBaSrJPQzSm3py40LOIi8RfV0q0QBbTjuSvh
         WpwQ==
X-Gm-Message-State: AOUpUlE6SZxrVTQAd0ZJwcFo74RQrnXmyahMuGW8f9tE6MnxYn9CayQI
        cL+JLzvN4PqtBFVkrUxnQCc=
X-Google-Smtp-Source: AA+uWPw/Ar0YDMxYtNBYzBnn2C9nzfl4Gg1nsgx1gO9DPt5H5irZXz8S+vb86DK23QbCJZLOxyLMxQ==
X-Received: by 2002:adf:b642:: with SMTP id i2-v6mr2516605wre.54.1533320923663;
        Fri, 03 Aug 2018 11:28:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r8-v6sm23340wmh.37.2018.08.03.11.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 11:28:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase --exec: make it work with --rebase-merges
References: <pull.13.git.gitgitgadget@gmail.com>
        <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com>
Date:   Fri, 03 Aug 2018 11:28:42 -0700
In-Reply-To: <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 03 Aug 2018
        10:42:08 -0700 (PDT)")
Message-ID: <xmqq1sbfxq1x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The idea of `--exec` is to append an `exec` call after each `pick`.
>
> Since the introduction of fixup!/squash! commits, this idea was extended
> to apply to "pick, possibly followed by a fixup/squash chain", i.e. an
> exec would not be inserted between a `pick` and any of its corresponding
> `fixup` or `squash` lines.
>
> The current implementation uses a dirty trick to achieve that: it
> assumes that there are only pick/fixup/squash commands, and then
> *inserts* the `exec` lines before any `pick` but the first, and appends
> a final one.

Ahh, it may be "dirty" but "clever" ;-) As there is no way to say
"add exec after only the third one", inserting before 'pick',
assuming the lines before that would be a "previous group" that
began with a pick and then possibly its amending operations, was
sufficient.  Makes sense.

> With the todo lists generated by `git rebase --rebase-merges`, this
> simple implementation shows its problems: it produces the exact wrong
> thing when there are `label`, `reset` and `merge` commands.

Understandable.

> Let's change the implementation to do exactly what we want: look for
> `pick` lines, skip any fixup/squash chains, and then insert the `exec`
> line. Lather, rinse, repeat.
>
> While at it, also add `exec` lines after `merge` commands, because they
> are similar in spirit to `pick` commands: they add new commits.

Yeah, while reading the "Let's change" paragraph, that exactly was
what came to my mind---the old one was buggy because we didn't
anticipate that 'pick' won't stay to be the first command in the
block that gives us a good anchoring point to find the end of the
previous block, so assuming that 'pick' will stay to be the only
command the users want to add exec after would be making a design
mistake that is quite similar without learning any lesson from the
bug being fixed.

I do agree that it is a good idea to add exec after merge; what I
wanted to say with the above is that I just do not think it is
"While at it"; it would be an integral part of supporting --exec
in rebase-merges mode.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c              | 59 ++++++++++++++++++++++++++++++++--------
>  t/t3430-rebase-merges.sh |  2 +-
>  2 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 31038472f..dda5cdbba 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4244,10 +4244,9 @@ int sequencer_add_exec_commands(const char *commands)
>  {
>  	const char *todo_file = rebase_path_todo();
>  	struct todo_list todo_list = TODO_LIST_INIT;
> -	struct todo_item *item;
>  	struct strbuf *buf = &todo_list.buf;
>  	size_t offset = 0, commands_len = strlen(commands);
> -	int i, first;
> +	int i, insert_final_commands;
>  
>  	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>  		return error(_("could not read '%s'."), todo_file);
> @@ -4257,19 +4256,57 @@ int sequencer_add_exec_commands(const char *commands)
>  		return error(_("unusable todo list: '%s'"), todo_file);
>  	}
>  
> -	first = 1;
> -	/* insert <commands> before every pick except the first one */
> -	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
> -		if (item->command == TODO_PICK && !first) {
> -			strbuf_insert(buf, item->offset_in_buf + offset,
> -				      commands, commands_len);
> -			offset += commands_len;
> +	/*
> +	 * Insert <commands> after every pick. Here, fixup/squash chains
> +	 * are considered part of the pick, so we insert the commands *after*
> +	 * those chains if there are any.
> +	 */

This is a tangent, but can a merge be amended with fixup/squash?  I
am hoping that I can use this machinery to augment Meta/Reintegrate
logic someday, and amending merges to resolve semantic conflicts
between topiocs in flight is what needs to happen constantly.

It appears the code treats TODO_PICK and TODO_MERGE the same way, so
the answer to the question apparently is "yes", which is good.

"after every pick" needs to become "after every pick and merge", or
if you prefer "after creating every new commit (i.e. pick and merge)".

> +	insert_final_commands = 1;

We assume, before entering the loop, that we'd need to append
another exec at the end.

> +	for (i = 0; i < todo_list.nr; ) {
> +		enum todo_command command = todo_list.items[i].command;
> +		int j = 0;
> +
> +		if (command != TODO_PICK && command != TODO_MERGE) {
> +			i++;
> +			continue;

If we ever see a todo-list without any pick/merge, then insert_final
is still 1 when we leave the loop and we will add one single exec at
the end.  Which may or may not make sense---I dunno, as I do not
offhand think of a reason why the user would give us such a sequence
in the first place, so it probably may not matter in practice.

> +		}
> +
> +		/* skip fixup/squash chain, if any */
> +		for (i++; i < todo_list.nr; i++, j = 0) {
> +			command = todo_list.items[i].command;
> +
> +			if (is_fixup(command))
> +				continue;
> +
> +			if (command != TODO_COMMENT)
> +				break;
> +
> +			/* skip comment if followed by any fixup/squash */
> +			for (j = i + 1; j < todo_list.nr; j++)
> +				if (todo_list.items[j].command != TODO_COMMENT)
> +					break;
> +			if (j < todo_list.nr &&
> +			    is_fixup(todo_list.items[j].command)) {
> +				i = j;
> +				continue;
> +			}
> +			break;
>  		}
> -		first = 0;
> +
> +		if (i >= todo_list.nr) {
> +			insert_final_commands = 1;
> +			break;

We saw pick or merge and then skipped zero or more fixups.  If we
reached the end, then we need to append one more to run the command
after this last group.  Makes sense.

> +		}
> +
> +		strbuf_insert(buf, todo_list.items[i].offset_in_buf + offset,
> +			      commands, commands_len);
> +		offset += commands_len;
> +		insert_final_commands = 0;

Otherwise, we finished a group so we insert an exec and move on,
after saying that we do not need one more, unless we see pick/merge

>  	}
>  
>  	/* append final <commands> */
> -	strbuf_add(buf, commands, commands_len);
> +	if (insert_final_commands)
> +		strbuf_add(buf, commands, commands_len);

When we leave the loop without adding exec to a group we saw, we
want to add one more exec, which is done here.

I am not exectly sure if the above loop is what you really want,
though.  I would have found the flow of the logic simpler to follow
if the loop were structured like this:

	append_exec = false
	for each command:
		if append_exec:
			add command to execute after the previous block
			append_exec = false
		if command is neither pick or merge:
			continue
		skip fixup or squash
		# at this point we know we are at the end
		append_exec = true
	if append_exec:
		add command to execute after the last block
		
essentially, the loop uses the flag not to keep track of the need to
emit only the final command, but the need to emit a command before
processing any command in the event stream (or the end of stream).

The above assumes that we do not want any exec if there is no
pick/merge, though.  As I said already, I am assuming that it does
not matter either way in practice, but if it mattered, I'd find it
more natural not to run any command if we did not create any commit.

Thanks.
