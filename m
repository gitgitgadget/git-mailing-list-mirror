Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD8B1F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeGJWe7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 18:34:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37743 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732358AbeGJWe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 18:34:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so566201wmh.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jgAd53ReL2oY7smfEYRysk4Bp1WDzkE2rrAZj1fSEA8=;
        b=K5z8KhLT0ZhrnDdPDLkojOwZry0nOSNb6nBptgnY73Lj5YEFGXayrp4xI86D8H8+0i
         1iQn3YSofevOV62Q2P5IrxZY136iTfd/sJUENDa/zT+xDNygFSTs5QY+Z8o+h6ctrB79
         8aTO2km4tON9YxAKFZJgTLuRRsm+LCX5VP/cXi8JWLpgOz/9Z3MWRyNHBneSZF6jc7Qx
         22hc0denNCDGq0strLf2K3HFE9DqWyFYqiXjqyi8KRtXH5I/mhDc571Gbla0LA4U3GPv
         hL4+W3ozY18L48KEfaNP9WvZySHABmxzRvo/Fd4AuRj+EkrmNB/4/zlGlZHt8cpk+W4I
         oSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jgAd53ReL2oY7smfEYRysk4Bp1WDzkE2rrAZj1fSEA8=;
        b=aoEnSSK13lDtIlXIjF5qFpUb1sQQcUWuhIutvSHYxkrn0Og4fbC0PaxtR9k9296v6i
         eXafuEfJbVcwFnbpjypUBvd4zvSfOZEl9+qCD1k+6P423mxmXVqGfnejHqqld+ww3Xh5
         APLpm4UvCvDDUJwt6hzZhklOY18/88b6BprRmkrCWLQtWrDluhwwKgV6Uh/Guf5BSNeP
         9jDurO6zceOpS9cmTsRTNlCHHa4jw6mdljuuUi9r8oRyvfnCO3X3ByHR3mP0NMM26FKU
         aumJUudURaAbqeiUGJURangQo1t0jRVdN0ns2mRzmtPIEHV7kmd0I20xLnOb/wgb3NFw
         d1vg==
X-Gm-Message-State: APt69E1tpCLCjZiEpsWQA5SbPw+hGt5I3kavlb3isf67oD93EUnA5LFI
        eTCRkYBRWnUKWSESIh1g+p0=
X-Google-Smtp-Source: AAOMgpeQBi3+WXMKHpGvg4eOAETIvKE7ELR6iJCh0p8uCgTR2CIPiTkeiLJQcyfv0AFrNKmywUEBHA==
X-Received: by 2002:a1c:a8f:: with SMTP id 137-v6mr14511488wmk.119.1531262024650;
        Tue, 10 Jul 2018 15:33:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a2-v6sm350969wmb.6.2018.07.10.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 15:33:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 10/13] rebase--interactive: rewrite complete_action() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-11-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 15:33:43 -0700
In-Reply-To: <20180710121557.6698-11-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:54 +0200")
Message-ID: <xmqq4lh667qw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites complete_action() from shell to C.
>
> A new mode is added to rebase--helper (`--complete-action`), as well as
> a new flag (`--autosquash`).
>
> Finally, complete_action() is stripped from git-rebase--interactive.sh.
>
> The original complete_action() checked twice that the todo-list had at
> least one operations (the first check took place after the help message
> was inserted, the second after the user edited the todo-list).  If there
> are no actions, complete_action() would return with the code 2.  This is
> a special case for rebase -i and -p; git-rebase.sh would then apply the
> autostash, delete the state directory, and die with the message "nothing
> to do".  This rewrite remove the first check (because a noop is added to
> the todo-list if it is empty).  For the second case, the cleanup is
> rewritten in C instead of returning 2.

The description about the first check seems unclear here.  Is it
"there was a first check but because the list is never empty due to
a noop, the check was unneeded"?  or is it "I decided to add noop to
force the list to be never empty, and that made the first check
unneeded"?  I'd imagine that the end-user experience would become
different if it were the latter (we'd see a todo whose sole entry is
no-op in the editor, instead of getting an error before editor
opens), and such a change would require a separate justification.

> -complete_action() {
> -	test -s "$todo" || echo noop >> "$todo"
> -...
> -
> -	has_action "$todo" ||
> -		return 2

It seems that the answer to my question turns out to be #1 after
some digging, i.e. the original, when it starteed adding noop at
ff74126c ("rebase -i: do not fail when there is no commit to
cherry-pick", 2008-10-10), should have noticed that the first
"Nothing to do" check has now become ineffective and removed it, and
you are fixing this age-old bug while rewriting it to C.

But you shouldn't force reviewers to figure that out.

	Side note.  This age-old omission is especially interesting,
	as the primary point of that change, which can be read from
	its title, was to prevent the command from dying that way.
	I wonder why reviewers did not notice it back then.

        ... ah, it seems that it was done during my absense ;-)

> -	complete_action
> +	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
> +		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
> +		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
> +		${verbose:+--verbose} ${force_rebase:+--no-ff}

The $allow_empty_message and later options are all dashed ones.
git-rebase.sh gives us either empty or --allow-empty-message in the
variable for $allow_empty_message, and if you follow suit to prepare
all the other variables that way, the ugly ${frotz+=--frotz} dance
will all become unnecessary here.

> +int complete_action(struct replay_opts *opts, unsigned flags,
> +		    const char *shortrevisions, const char *onto_name,
> +		    const char *onto, const char *orig_head, const char *cmd,
> +		    unsigned autosquash, unsigned keep_empty)
> +{
> +	const char *shortonto, *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	struct strbuf *buf = &(todo_list.buf);
> +	struct object_id oid;
> +	struct stat st;
> +
> +	get_oid(onto, &oid);
> +	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> +
> +	if (!lstat(todo_file, &st) && st.st_size == 0 &&
> +	    write_message("noop\n", 5, todo_file, 0))
> +		return error_errno(_("could not write '%s'"), todo_file);

Wait a minute... thinking back to the early "age-old ommission"
topic, can the todo file be a non-empty file that does not have any
command (e.g. just a single blank line, or full of comments and
nothing else)?  The original wouldn't have added "noop" and then the
first "do we have anything to do?" check would still have been
necessary, which would mean that ff74126c's not removing the first
check was actually not a bug but was a cautious and sensible thing
to do, and removal of that exact check by this commit becomes a
regression.  So,... can the todo file be a non-empty file that does
not have any command in it at this point?

> +	if (autosquash && rearrange_squash())
> +		return 0;

The original, when rearrange-squash failed, exited with failure,
like so:

-       test -z "$autosquash" || git rebase--helper --rearrange-squash || exit

Now this function returns success when rearrange_squash fails.  
Is that intended?

> +	if (cmd && *cmd)

Shouldn't it be a BUG (programming error) if cmd == NULL?  I thought
the caller of complete_action() in this patch insisted that it got
argc == 6 or something, so *cmd might be NUL but cmd would never be
NULL if I understand your code correctly.  IOW, shouldn't the line
be more like:

	if (!cmd)
		BUG("...");
	if (*cmd)

?

> +		sequencer_add_exec_commands(cmd);

The sequencer_add_exec_commands() function does not take the name of
todo file as a parameter, so even though we have one in todo_file
variable we cannot use it to call the function, which is a bit sad,
but is OK.

> +	if (strbuf_read_file(buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +	if (parse_insn_buffer(buf->buf, &todo_list)) {

Nice that we have parse* function.  We do not have to work with
stripspace plus "wc -l" ;-).

> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);

When the users see this error message, is it easy for them to
diagnose what went wrong (e.g. has parse_insn_buffer() already
issued some message to help pinpoint which insn in the todo list is
misspelt, for example)?

> +	}
> +
> +	strbuf_addch(buf, '\n');
> +	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
> +				      "Rebase %s onto %s (%d commands)",
> +				      todo_list.nr),
> +			      shortrevisions, shortonto, todo_list.nr);
> +	append_todo_help(0, keep_empty, buf);
> +
> +	if (write_message(buf->buf, buf->len, todo_file, 0)) {
> +		todo_list_release(&todo_list);
> +		return error_errno(_("could not write '%s'"), todo_file);
> +	}
> +	copy_file(rebase_path_todo_backup(), todo_file, 0666);
> +	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
> +

It is a bit sad that we are mostly working on the byte array
buf->buf (or external file touched by various helper functions we
call), even though we have a perfectly usable parsed representation
in todo_list structure in all of the above and the rest of this
function.

It might be better to grab todo_list.nr into a local simple integer
variable immediately after parse_insn_buffer() returns and then call
todo_list_release() on todo_list, as the parsed todo-list is only
used for two purposes (i.e. detecting format error by seeing if
parser returns success, and seeing how many insns are on the todo
list by checking todo_list.nr field) and nothing else.  By releasing
the otherwise unused todo_list early, you do not have to sprinkle
various error return codepaths with calls to todo_list_release().

That incidentally would manage too high expectation from readers of
the code as well ;-).

>  struct subject2item_entry {
>  	struct hashmap_entry entry;
>  	int i;
> diff --git a/sequencer.h b/sequencer.h
> index 25b50efe2..02772b927 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -89,6 +89,10 @@ int transform_todos(unsigned flags);
>  enum missing_commit_check_level get_missing_commit_check_level(void);
>  int check_todo_list(void);
>  int skip_unnecessary_picks(const char **output_oid);
> +int complete_action(struct replay_opts *opts, unsigned flags,
> +		    const char *shortrevisions, const char *onto_name,
> +		    const char *onto, const char *orig_head, const char *cmd,
> +		    unsigned autosquash, unsigned keep_empty);
>  int rearrange_squash(void);
>  
>  extern const char sign_off_header[];
