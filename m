Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E5C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbjEKOOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 10:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbjEKOOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 10:14:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A69106F2
        for <git@vger.kernel.org>; Thu, 11 May 2023 07:13:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078c092056so4085963f8f.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683814426; x=1686406426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4BO5SU64jrnGzclx5EWwK/kqRbqnQE9s8bG7bBz9H2A=;
        b=WDnlvQp0jCZPaEBnuaeRHbldpCv0vKOIs3hGlRNTr5lg7UG6vgJUMjjB39MYkVM7sX
         mIYrdrnbHr4yVnQLeOtKAsoPx7LlU3DMnf2lCCkq/XylC8t6c0SWvI6mzJlzktYl3a11
         DISws5KTSW/y++fqDeYpr3BplVnzOynSvJ/ajwzmjww4/ymWffG/fRYSrfE/FqxRoDJJ
         hY69FFVuMRQf7svM/iTRNF8EW+IKPgDqus6+5qCRDZKua7P3tFNuM1YgPcXhWdntLkOT
         n2x1mElb+JkZ/1RvNb5Fz1MBJiN1e+nvAIxCbNcC88UIZGL0qhqHARkPwua0qkOzzTuO
         nYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814426; x=1686406426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BO5SU64jrnGzclx5EWwK/kqRbqnQE9s8bG7bBz9H2A=;
        b=anSRab9byuLeLeMbT8rwIg44x4h2HfCWynhIqK20lSaqZFExQu3srgIe6Me1o4Kqej
         v7uTL4ivPtPao/NAcnSLjo1epo52fKhYh2q8oygvmsNe7GKUUHo/GoSUknuVAQm7jvE7
         h9y5kAQ7C0Q2hW3A8ILpKUSbVtXAXprdlKcfyuXjEOfntou1gO4WKQkuGNA3u6y1lIOp
         MWXFSn1MODZRlxli9APhN6tjD4xc0ohy4+WOh7HKQaUxsm8HSmtBQ02MPcGxidOrSGvN
         3utMADx9QbSM4/a4GjJd6VsGb1u6km8F6GNlR4zDpIgakMfwDY06ABucHcZTFwjZKuni
         /XyA==
X-Gm-Message-State: AC+VfDzFepEaOSxqTx62SCHv1pG5nBTaEYXN5I212yAp8WRG6aYn5HbF
        5TyV4tGNX/qD6A/sY+F9HfQ=
X-Google-Smtp-Source: ACHHUZ7eqT4Oq9B6SdKe7L0rfyGHHTsgQdjgO/e8P1nTlo+gMPkxJHGynG9HESNRSRpdOIL5Hd8WZA==
X-Received: by 2002:adf:dc04:0:b0:307:a33d:d054 with SMTP id t4-20020adfdc04000000b00307a33dd054mr6966860wri.49.1683814425763;
        Thu, 11 May 2023 07:13:45 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b003063a92bbf5sm20706251wrv.70.2023.05.11.07.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:13:45 -0700 (PDT)
Message-ID: <b481d212-89c5-5c8e-c99f-6df3909523c7@gmail.com>
Date:   Thu, 11 May 2023 15:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase -r: fix the total number shown in the progress
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
 <d12d5469f8cbc21ce1efbffc8e7569c534b5a305.1683759339.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d12d5469f8cbc21ce1efbffc8e7569c534b5a305.1683759339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 10/05/2023 23:55, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> For regular, non-`--rebase-merges` runs, there is very little work to do
> for the parser when determining the total number of commands in a rebase
> script: it is simply the number of lines after stripping the commented
> lines and then trimming the trailing empty line, if any.
> 
> The `--rebase-merges` mode complicates things by introducing empty lines
> and comments in the middle of the script. These should _not_ be counted
> as commands, and indeed, when an interactive rebase is interrupted and
> subsequently resumed, the total number of commands can magically shrink,
> sometimes dramatically.
> 
> The reason for this strange behavior is that empty lines _are_ counted
> in `edit_todo_list()` (but not the comments, as they are stripped via
> `strbuf_stripspace(..., 1)`, which is a bug.
> 
> Let's fix this so that the correct total number is shown from the
> get-go, by carefully adjusting it according to what's in the rebase
> script. Extra care needs to be taken in case the user edits the script:
> the number of commands might be different after the user edited than
> beforehand.
> 
> Note: Even though commented lines are skipped in `edit_todo_list()`, we
> still need to handle `TODO_COMMENT` items by decrementing the
> already-incremented `total_nr` again: empty lines are also marked as
> `TODO_COMMENT`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   sequencer.c              | 12 ++++++++----
>   t/t3430-rebase-merges.sh |  7 +++++++
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f5d89abdc5e..46dd07df0f2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2609,7 +2609,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>   	char *p = buf, *next_p;
>   	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
>   
> -	todo_list->current = todo_list->nr = 0;
> +	todo_list->current = todo_list->nr = todo_list->total_nr = 0;
>   
>   	for (i = 1; *p; i++, p = next_p) {
>   		char *eol = strchrnul(p, '\n');
> @@ -2628,7 +2628,8 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>   			item->arg_offset = p - buf;
>   			item->arg_len = (int)(eol - p);
>   			item->commit = NULL;
> -		}
> +		} else if (item->command == TODO_COMMENT)
> +			todo_list->total_nr--;

This feels a bit fragile, I think it would be better to count the 
commands properly in the first place rather than adjusting the total 
here. We could do that by not incrementing "todo_list->total_nr" in 
append_new_todo() and then doing

	if (item->command != TODO_COMMENT)
		todo_list->total_nr++;

here. We may want to stop counting invalid commands as well by only 
counting commands whre "item->command < TODO_COMMENT".

>   
>   		if (fixup_okay)
>   			; /* do nothing */
> @@ -6039,7 +6040,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   	struct todo_list new_todo = TODO_LIST_INIT;
>   	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
>   	struct object_id oid = onto->object.oid;
> -	int res;
> +	int new_total_nr, res;
>   
>   	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
>   
> @@ -6066,6 +6067,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		return error(_("nothing to do"));
>   	}
>   
> +	new_total_nr = todo_list->total_nr - count_commands(todo_list);
>   	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
>   			     shortonto, flags);
>   	if (res == -1)
> @@ -6088,11 +6090,13 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		return -1;
>   	}
>   
> +	new_total_nr += count_commands(&new_todo);
> +	new_todo.total_nr = new_total_nr;
> +
>   	/* Expand the commit IDs */
>   	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
>   	strbuf_swap(&new_todo.buf, &buf2);
>   	strbuf_release(&buf2);
> -	new_todo.total_nr -= new_todo.nr;

I think if we just change this line to
	
	new_todo.total_nr = 0;

we don't need any other changes to this function. This is because 
complete_action() is only called at the start of a rebase so we don't 
need to worry about "total_nr" including commands that have already been 
executed. The reason we need to set it to zero here is that we re-parse 
the todo list below which increments "total_nr" by the number of 
commands parsed.

Thanks for working on this.
Best Wishes

Phillip

>   	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
>   		BUG("invalid todo list after expanding IDs:\n%s",
>   		    new_todo.buf.buf);
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f351701fec2..8da99a075dc 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -517,4 +517,11 @@ test_expect_success '--rebase-merges with message matched with onto label' '
>   	EOF
>   '
>   
> +test_expect_success 'progress shows the correct total' '
> +	git checkout -b progress H &&
> +	git rebase --rebase-merges --force-rebase --verbose A 2> err &&
> +	grep "^Rebasing.*14.$" err >progress &&
> +	test_line_count = 14 progress
> +'
> +
>   test_done
