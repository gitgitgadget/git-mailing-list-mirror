Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA26C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 10:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiGOK1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiGOK1q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 06:27:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF082F80
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:27:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk26so6125409wrb.11
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5JLDPeBgUzbYzgwISDh7iQ7Sohqmj3HZJDnxc4UKN44=;
        b=nst355206oxGojAzmdeO8l41jgyxZrEBCZe3trgzpTlattwqA2Xbt6UCpAb7JGo1a9
         szyuWZrAqGJo9qpPDLQtx0iA0z4zJRV5wIwEPGpfT7mSIXyo/z6B4yeqfBvaatrBIyPt
         qGdiv+ws5w5cFdwCRHi1vgO1lzobrhy6yhVWrNwBY2mpZpmqQEMpzcxlfUfcCSvWY2Av
         8wTab7/BvLqDs0rsaRQ+ZBa3MOPkz68tZx6Glg7SWHKKrtzA4GxJKS+fZJQR/8OnCAZ6
         VkBJblEZcZxnbrG3el0tJqn/7ceS9V+BRs0ncEeP9nRwQCWPA6QqqZL+1tT7BnTK9JHR
         8BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5JLDPeBgUzbYzgwISDh7iQ7Sohqmj3HZJDnxc4UKN44=;
        b=oBPYglhGfPpsUyEhX6H7vwsgywez4tCN65rRMUvqrYBOgRiYiT9UNZDuHZVKH/RRzS
         Ix0DfwgL1WBg2LfAE+yvQm7K2CjwseI3ge9nli/4XqN69J3pGHT+jm5e3TQ7Hp0AmuzN
         RfnsYhTHXVVnXwpUDF0suCOL3LzIMZFaxXFNvXyr/DoWI2eeIaZbK2HqhfYIGEAP3/1h
         7VyqiZzq4JwY7HC0vVCy4hCFXi+amhUOYarhQpWEL4U0iLMVR7ZwFefWYkNr9aHtV+h7
         xJvxfm4B8Vj5gfz7ntJ+O0S28UzJKYtJgMiDDbQ94+NT7pozpd3HdHVE2TIBiLixMPm8
         w98w==
X-Gm-Message-State: AJIora90nAtzx5gcCplIbemJFYabDkCqzGWJyf/ckai2HH8I4z9sP8rd
        SrcbSISwH2+PPGqalw/gaD8=
X-Google-Smtp-Source: AGRyM1v8e2JDlYYcuWK8JWWbTW9wCr0rrRNmCskOpns5K0vTEUZoif2EORkz12NjRkE7YuG2jk18GA==
X-Received: by 2002:adf:ce0c:0:b0:21d:929e:1522 with SMTP id p12-20020adfce0c000000b0021d929e1522mr11431624wrn.126.1657880863350;
        Fri, 15 Jul 2022 03:27:43 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id i3-20020a1c5403000000b003a2e1883a27sm9862706wmb.18.2022.07.15.03.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 03:27:42 -0700 (PDT)
Message-ID: <7a471a98-09d1-78cb-d6dd-a7faaa9071ba@gmail.com>
Date:   Fri, 15 Jul 2022 11:27:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 09/12] sequencer: rewrite update-refs as user edits
 todo list
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <29c7c76805abb9b8afd44a65cb39d8f9d3c95892.1657631226.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <29c7c76805abb9b8afd44a65cb39d8f9d3c95892.1657631226.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 12/07/2022 14:07, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> An interactive rebase provides opportunities for the user to edit the
> todo list. The --update-refs option initializes the list with some
> 'update-ref <ref>' steps, but the user could add these manually.
> Further, the user could add or remove these steps during pauses in the
> interactive rebase.
> 
> Add a new method, todo_list_filter_update_refs(), that scans a todo_list
> and compares it to the stored update-refs file. There are two actions
> that can happen at this point:
> 
> 1. If a '<ref>/<before>/<after>' triple in the update-refs file does not
>     have a matching 'update-ref <ref>' command in the todo-list _and_ the
>     <after> value is the null OID, then remove that triple. Here, the
>     user removed the 'update-ref <ref>' command before it was executed,
>     since if it was executed then the <after> value would store the
>     commit at that position.
> 
> 2. If a 'update-ref <ref>' command in the todo-list does not have a
>     matching '<ref>/<before>/<after>' triple in the update-refs file,
>     then insert a new one. Store the <before> value to be the current
>     OID pointed at by <ref>. This is handled inside of the
>     init_update_ref_record() helper method.
> 
> We can test that this works by rewriting the todo-list several times in
> the course of a rebase. Check that each ref is locked or unlocked for
> updates after each todo-list update. We an also verify that the ref
> update fails if a concurrent process updates one of the refs after the
> rebase process records the "locked" ref location.

Thanks for adding this and taking the time to write some good tests. 
When adding a new update-ref command to the todo list it would be nice 
to check if the ref is already checked. We could print a warning or 
force the user to re-edit the todo list as we do if they delete a pick 
and rebase.missingcommitscheck == error

The checks below are quadratic but we don't expect that many refs so 
that should be fine. I don't think it is worth the complexity of 
building a hash table or whatever at this stage.

Best Wishes

Phillip

> To help these tests, add a new 'set_replace_editor' helper that will
> replace the todo-list with an exact file.
> 
> Reported-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   rebase-interactive.c          |   6 ++
>   sequencer.c                   |  96 +++++++++++++++++++++++
>   sequencer.h                   |  12 +++
>   t/lib-rebase.sh               |  15 ++++
>   t/t3404-rebase-interactive.sh | 139 ++++++++++++++++++++++++++++++++++
>   5 files changed, 268 insertions(+)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 1ff07647af3..7407c593191 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -146,6 +146,12 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>   		return -4;
>   	}
>   
> +	/*
> +	 * See if branches need to be added or removed from the update-refs
> +	 * file based on the new todo list.
> +	 */
> +	todo_list_filter_update_refs(r, new_todo);
> +
>   	return 0;
>   }
>   
> diff --git a/sequencer.c b/sequencer.c
> index 2d89b3b727a..2808c027d68 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4141,6 +4141,102 @@ cleanup:
>   	return result;
>   }
>   
> +/*
> + * Parse the update-refs file for the current rebase, then remove the
> + * refs that do not appear in the todo_list (and have not had updated
> + * values stored) and add refs that are in the todo_list but not
> + * represented in the update-refs file.
> + *
> + * If there are changes to the update-refs list, then write the new state
> + * to disk.
> + */
> +void todo_list_filter_update_refs(struct repository *r,
> +				  struct todo_list *todo_list)
> +{
> +	int i;
> +	int updated = 0;
> +	struct string_list update_refs = STRING_LIST_INIT_DUP;
> +
> +	sequencer_get_update_refs_state(r->gitdir, &update_refs);
> +
> +	/*
> +	 * For each item in the update_refs list, if it has no updated
> +	 * value and does not appear in the todo_list, then remove it
> +	 * from the update_refs list.
> +	 */
> +	for (i = 0; i < update_refs.nr; i++) {
> +		int j;
> +		int found = 0;
> +		const char *ref = update_refs.items[i].string;
> +		size_t reflen = strlen(ref);
> +		struct update_ref_record *rec = update_refs.items[i].util;
> +
> +		/* OID already stored as updated. */
> +		if (!is_null_oid(&rec->after))
> +			continue;
> +
> +		for (j = 0; !found && j < todo_list->total_nr; j++) {
> +			struct todo_item *item = &todo_list->items[j];
> +			const char *arg = todo_list->buf.buf + item->arg_offset;
> +
> +			if (item->command != TODO_UPDATE_REF)
> +				continue;
> +
> +			if (item->arg_len != reflen ||
> +			    strncmp(arg, ref, reflen))
> +				continue;
> +
> +			found = 1;
> +		}
> +
> +		if (!found) {
> +			free(update_refs.items[i].string);
> +			free(update_refs.items[i].util);
> +
> +			update_refs.nr--;
> +			MOVE_ARRAY(update_refs.items + i, update_refs.items + i + 1, update_refs.nr - i);
> +
> +			updated = 1;
> +			i--;
> +		}
> +	}
> +
> +	/*
> +	 * For each todo_item, check if its ref is in the update_refs list.
> +	 * If not, then add it as an un-updated ref.
> +	 */
> +	for (i = 0; i < todo_list->total_nr; i++) {
> +		struct todo_item *item = &todo_list->items[i];
> +		const char *arg = todo_list->buf.buf + item->arg_offset;
> +		int j, found = 0;
> +
> +		if (item->command != TODO_UPDATE_REF)
> +			continue;
> +
> +		for (j = 0; !found && j < update_refs.nr; j++) {
> +			const char *ref = update_refs.items[j].string;
> +
> +			found = strlen(ref) == item->arg_len &&
> +				!strncmp(ref, arg, item->arg_len);
> +		}
> +
> +		if (!found) {
> +			struct string_list_item *inserted;
> +			struct strbuf argref = STRBUF_INIT;
> +
> +			strbuf_add(&argref, arg, item->arg_len);
> +			inserted = string_list_insert(&update_refs, argref.buf);
> +			inserted->util = init_update_ref_record(argref.buf);
> +			strbuf_release(&argref);
> +			updated = 1;
> +		}
> +	}
> +
> +	if (updated)
> +		write_update_refs_state(&update_refs);
> +	string_list_clear(&update_refs, 1);
> +}
> +
>   static int do_update_ref(struct repository *r, const char *refname)
>   {
>   	struct string_list_item *item;
> diff --git a/sequencer.h b/sequencer.h
> index e671d7e0743..98f3bcc1658 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -132,6 +132,18 @@ void todo_list_release(struct todo_list *todo_list);
>   const char *todo_item_get_arg(struct todo_list *todo_list,
>   			      struct todo_item *item);
>   
> +/*
> + * Parse the update-refs file for the current rebase, then remove the
> + * refs that do not appear in the todo_list (and have not had updated
> + * values stored) and add refs that are in the todo_list but not
> + * represented in the update-refs file.
> + *
> + * If there are changes to the update-refs list, then write the new state
> + * to disk.
> + */
> +void todo_list_filter_update_refs(struct repository *r,
> +				  struct todo_list *todo_list);
> +
>   /* Call this to setup defaults before parsing command line options */
>   void sequencer_init_config(struct replay_opts *opts);
>   int sequencer_pick_revisions(struct repository *repo,
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index ec6b9b107da..b57541356bd 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -207,3 +207,18 @@ check_reworded_commits () {
>   		>reword-log &&
>   	test_cmp reword-expected reword-log
>   }
> +
> +# usage: set_replace_editor <file>
> +#
> +# Replace the todo file with the exact contents of the given file.
> +set_replace_editor () {
> +	cat >script <<-\EOF &&
> +	cat FILENAME >"$1"
> +
> +	echo 'rebase -i script after editing:'
> +	cat "$1"
> +	EOF
> +
> +	sed -e "s/FILENAME/$1/g" <script | write_script fake-editor.sh &&
> +	test_set_editor "$(pwd)/fake-editor.sh"
> +}
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index a37820fa728..7bfbd405ab8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1830,6 +1830,145 @@ test_expect_success '--update-refs updates refs correctly' '
>   	test_cmp_rev HEAD refs/heads/no-conflict-branch
>   '
>   
> +test_expect_success 'respect user edits to update-ref steps' '
> +	git checkout -B update-refs-break no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	git branch -f unseen base &&
> +
> +	# First, we will add breaks to the expected todo file
> +	cat >fake-todo-1 <<-EOF &&
> +	pick $(git rev-parse HEAD~3)
> +	break
> +	update-ref refs/heads/second
> +	update-ref refs/heads/first
> +
> +	pick $(git rev-parse HEAD~2)
> +	pick $(git rev-parse HEAD~1)
> +	update-ref refs/heads/third
> +
> +	pick $(git rev-parse HEAD)
> +	update-ref refs/heads/no-conflict-branch
> +	EOF
> +
> +	# Second, we will drop some update-refs commands (and move one)
> +	cat >fake-todo-2 <<-EOF &&
> +	update-ref refs/heads/second
> +
> +	pick $(git rev-parse HEAD~2)
> +	update-ref refs/heads/third
> +	pick $(git rev-parse HEAD~1)
> +	break
> +
> +	pick $(git rev-parse HEAD)
> +	EOF
> +
> +	# Third, we will:
> +	# * insert a new one (new-branch),
> +	# * re-add an old one (first), and
> +	# * add a second instance of a previously-stored one (second)
> +	cat >fake-todo-3 <<-EOF &&
> +	update-ref refs/heads/unseen
> +	update-ref refs/heads/new-branch
> +	pick $(git rev-parse HEAD)
> +	update-ref refs/heads/first
> +	update-ref refs/heads/second
> +	EOF
> +
> +	(
> +		set_replace_editor fake-todo-1 &&
> +		git rebase -i --update-refs primary &&
> +
> +		# These branches are currently locked.
> +		for b in first second third no-conflict-branch
> +		do
> +			test_must_fail git branch -f $b base || return 1
> +		done &&
> +
> +		set_replace_editor fake-todo-2 &&
> +		git rebase --edit-todo &&
> +
> +		# These branches are currently locked.
> +		for b in second third
> +		do
> +			test_must_fail git branch -f $b base || return 1
> +		done &&
> +
> +		# These branches are currently unlocked for checkout.
> +		for b in first no-conflict-branch
> +		do
> +			git worktree add wt-$b $b &&
> +			git worktree remove wt-$b || return 1
> +		done &&
> +
> +		git rebase --continue &&
> +
> +		set_replace_editor fake-todo-3 &&
> +		git rebase --edit-todo &&
> +
> +		# These branches are currently locked.
> +		for b in second third first unseen
> +		do
> +			test_must_fail git branch -f $b base || return 1
> +		done &&
> +
> +		# These branches are currently unlocked for checkout.
> +		for b in no-conflict-branch
> +		do
> +			git worktree add wt-$b $b &&
> +			git worktree remove wt-$b || return 1
> +		done &&
> +
> +		git rebase --continue
> +	) &&
> +
> +	test_cmp_rev HEAD~2 refs/heads/third &&
> +	test_cmp_rev HEAD~1 refs/heads/unseen &&
> +	test_cmp_rev HEAD~1 refs/heads/new-branch &&
> +	test_cmp_rev HEAD refs/heads/first &&
> +	test_cmp_rev HEAD refs/heads/second &&
> +	test_cmp_rev HEAD refs/heads/no-conflict-branch
> +'
> +
> +test_expect_success '--update-refs: check failed ref update' '
> +	git checkout -B update-refs-error no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~2 &&
> +	git branch -f third HEAD~1 &&
> +
> +	cat >fake-todo <<-EOF &&
> +	pick $(git rev-parse HEAD~3)
> +	break
> +	update-ref refs/heads/first
> +
> +	pick $(git rev-parse HEAD~2)
> +	update-ref refs/heads/second
> +
> +	pick $(git rev-parse HEAD~1)
> +	update-ref refs/heads/third
> +
> +	pick $(git rev-parse HEAD)
> +	update-ref refs/heads/no-conflict-branch
> +	EOF
> +
> +	(
> +		set_replace_editor fake-todo &&
> +		git rebase -i --update-refs base
> +	) &&
> +
> +	# At this point, the values of first, second, and third are
> +	# recorded in the update-refs file. We will force-update the
> +	# "second" ref, but "git branch -f" will not work because of
> +	# the lock in the update-refs file.
> +	git rev-parse third >.git/refs/heads/second &&
> +
> +	git rebase --continue 2>err &&
> +	grep "update_ref failed for ref '\''refs/heads/second'\''" err
> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged

