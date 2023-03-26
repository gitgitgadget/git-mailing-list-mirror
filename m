Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17ABC74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjCZO2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCZO2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 10:28:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A841A7
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:28:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l37so3600263wms.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679840884;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJwk4YKK75L1sFcXvqAnL+mvYf1xoOp6jS3YX7DWg9Y=;
        b=b+5vIFEj9xhEx88txnjiUos9uq+17nZjrsxLmcrSe7O2rGZIE1zP2gItXOODOJRJeI
         aBQkGFSw6apxON4T0v0RHNhUT4fPA2R8cz7hSz6Q7r8wJ8NIZJFm9/WMC+7BE4Z6Et6o
         dh0R5RsYapzKEQ6mZND5TB0n1uZ75EMpPfcnopRFVBevwGh9KCgm2c/bUZ3c2Vxckant
         EqbschGIL5sm9ydNNWpppreH4xCycOPZ6vzfELoqWlZcCJpuQ/yx8YAMxwdRIOKcX76E
         YkUOCkCAb24HGpydPIoV29UiXEqXmH+76aMIEsSd/y2xepqLKpabC/RhpgTQXaT9kqLa
         vEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679840884;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJwk4YKK75L1sFcXvqAnL+mvYf1xoOp6jS3YX7DWg9Y=;
        b=WHSWL5COlN43XXzTCF7nqwcRRbag6jO/cZGVPEHB0g46NIqniYjqiQr1CyBb6PTIi8
         1JpzaAKdlOSXrLc1uosgdz97/SaLRFN3pI1x0X7ovO2+lLcTaHBgYITu44Ih4Bcr9dhC
         ugh4vvBYWCIiHg7PhiJNehQ/LsCJSnz3KOYiublaZjFNVoChTWuOTWkrIsmdcl99OdQR
         pNT52zrnTJY/7enKLNbHDjgebrmLP4hX6IZpWNcDa9PEh7vGkSP13l2znzPSN+kVRfna
         Ri3HWv0u9BhfnSEW5Al5ocShOzu+44KE7Pmxs+wP5hSn8L2N3mjGbi0FWNfG7unURPxM
         dptw==
X-Gm-Message-State: AAQBX9dU4wdh8dYGiyyiv+dDmxRvKq+kxYg/2ZkUTDJySfoTu2QbhR9m
        EBoQNtioNs1NFwLN9rWjB0bAXLthaqk=
X-Google-Smtp-Source: AKy350bFgtJnWtI7MiqhsAmzSx2YDcbG2Q36lVFudnFH9AHWPoio4dXFyo3PNtUrTragVg25WZTK/w==
X-Received: by 2002:a05:600c:220c:b0:3ef:61f7:7d34 with SMTP id z12-20020a05600c220c00b003ef61f77d34mr4043561wml.1.1679840884314;
        Sun, 26 Mar 2023 07:28:04 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c469300b003ee9f396dcesm5763421wmo.30.2023.03.26.07.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:28:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8a188876-c456-7269-28de-9ff406204030@dunelm.org.uk>
Date:   Sun, 26 Mar 2023 15:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 8/8] rebase: improve resumption from incorrect initial
 todo list
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-9-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-9-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> When the user butchers the todo file during rebase -i setup, the
> --continue which would follow --edit-todo would have skipped the last
> steps of the setup. Notably, this would bypass the fast-forward over
> untouched picks (though the actual picking loop would still fast-forward
> the commits, one by one).
> 
> Fix this by splitting off the tail of complete_action() to a new
> start_rebase() function and call that from sequencer_continue() when no
> commands have been executed yet.
> 
> More or less as a side effect, we no longer checkout `onto` before exiting
> when the todo file is bad. 

I think the implications of this change deserve to be discussed in the 
commit message. Three things spring to mind but there may be others I 
haven't thought of

  - Previously when rebase stopped and handed control back to the user
    HEAD would have already been detached. This patch changes that
    meaning we can have an active rebase of a branch while that branch is
    checked out. What does "git status" show in this case? What does the
    shell prompt show? Will it confuse users?

  - Previously if the user created a commit before running "rebase
    --continue" we'd rebase on to that commit. Now that commit will be
    silently dropped.

  - Previously if the user checkout out another commit before running
    "rebase --continue" we'd rebase on to that commit. Now we we rebase
    on to the original "onto" commit.

 > This makes aborting cheaper and will simplify
 > things in a later change.

Given that we're stopping so the user can fix the problem and continue 
the rebase I don't think optimizing for aborting is a convincing reason 
for this change on its own.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 62986a7b1b..00d3e19c62 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -231,7 +231,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   		return ret;
>   	}
>   	if (cmd == 'c')
> -		return sequencer_continue(the_repository, opts);
> +		return sequencer_continue(the_repository, opts,
> +					  0, NULL, NULL, NULL);

It's a bit unfortunate that we have to start passing all these extra 
parameters, could the sequencer read them itself in read_populate_opts()?

> -int sequencer_continue(struct repository *r, struct replay_opts *opts)
> +static int start_rebase(struct repository *r, struct replay_opts *opts, unsigned flags,
> +			const char *onto_name, const struct object_id *onto,
> +			const struct object_id *orig_head, struct todo_list *todo_list);

It would be nice to avoid this forward declaration. I think you could do 
that by adding a preparatory patch that moves either checkout_onto() or 
sequencer_continue()

> @@ -6142,49 +6154,52 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   
>   		return error(_("nothing to do"));
>   	} else if (res == EDIT_TODO_INCORRECT) {
> -		checkout_onto(r, opts, onto_name, onto, orig_head);
>   		todo_list_release(&new_todo);
>   
>   		return -1;
>   	}
>   
> -	/* Expand the commit IDs */
> -	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
> -	strbuf_swap(&new_todo.buf, &buf2);
> -	strbuf_release(&buf2);
> -	new_todo.total_nr -= new_todo.nr;
> -	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
> -		BUG("invalid todo list after expanding IDs:\n%s",
> -		    new_todo.buf.buf);

I don't think we need to move this code. If start_rebase() is called 
from sequencer_continue() the initial edit of the todo list failed and 
has been fixed by running "git rebase --edit-todo". In that case the 
oids have already been expanded on disc.

> -	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &onto)) {
> -		todo_list_release(&new_todo);
> -		return error(_("could not skip unnecessary pick commands"));
> -	}
> -
> -	if (todo_list_write_to_file(r, &new_todo, todo_file, NULL, NULL, -1,
> -				    flags & ~(TODO_LIST_SHORTEN_IDS), action)) {
> -		todo_list_release(&new_todo);
> -		return error_errno(_("could not write '%s'"), todo_file);
> -	}
> -
> -	res = -1;
> -
> -	if (checkout_onto(r, opts, onto_name, onto, orig_head))
> -		goto cleanup;
> -
> -	if (require_clean_work_tree(r, "rebase", NULL, 1, 1))
> -		goto cleanup;
> -
> -	todo_list_write_total_nr(&new_todo);
> -	res = pick_commits(r, &new_todo, opts);
> -
> -cleanup:
> +	res = start_rebase(r, opts, flags, onto_name, onto, orig_head, &new_todo);
>   	todo_list_release(&new_todo);
>   
>   	return res;
>   }
>   

> +test_expect_success 'continue after bad first command' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	git checkout primary^0 &&

If you want a specific commit it's better to use a tag name as those are 
fixed whereas the branches get rebased all over the place in this test file.

> +	git reflog expire --expire=all HEAD &&

Is this really necessary, can you pass -n to "git reflog" below?

> +	(
> +		set_fake_editor &&
> +		test_must_fail env FAKE_LINES="bad 1 pick 1 pick 2 reword 3" \
> +			git rebase -i HEAD~3 &&
> +		test_cmp_rev HEAD primary &&
> +		FAKE_LINES="pick 2 pick 3 reword 4" git rebase --edit-todo &&
> +		FAKE_COMMIT_MESSAGE="E_reworded" git rebase --continue
> +	) &&
> +	git reflog > reflog &&
> +	test $(grep -c fast-forward reflog) = 1 &&

Using test_line_count would make test failures easier to debug.

> +	test_cmp_rev HEAD~1 primary~1 &&
> +	test "$(git log -1 --format=%B)" = "E_reworded"

It is slightly more work, but please use test_cmp for things like this 
as it makes it so much easier to debug test failures.

Best Wishes

Phillip

> +'
> +
> +test_expect_success 'abort after bad first command' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	git checkout primary^0 &&
> +	(
> +		set_fake_editor &&
> +		test_must_fail env FAKE_LINES="bad 1 pick 1 pick 2 reword 3" \
> +			git rebase -i HEAD~3
> +	) &&
> +	git rebase --abort &&
> +	test_cmp_rev HEAD primary
> +'
> +
>   test_expect_success 'tabs and spaces are accepted in the todolist' '
>   	rebase_setup_and_clean indented-comment &&
>   	write_script add-indent.sh <<-\EOF &&
