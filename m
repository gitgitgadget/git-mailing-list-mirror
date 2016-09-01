Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FA31F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbcIAWFZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:05:25 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36881 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbcIAWFX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:05:23 -0400
Received: by mail-wm0-f43.google.com with SMTP id v143so4269055wmv.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Pho0DBoteWQ6P/LIkUCCwd3LfFL9DYnpmWlRk+XinNs=;
        b=rO/tG/DILsENwoQy074oe0jNJM7NTZL520uLZf9gIktGl+duTgyXiLdlG8uDD5SfCC
         QVbRzV//gB0kXr1ssUTC4Koh67Ql30cksfPiVLzzqZQPvymyCw3VhVoylABodwy33pcb
         m+2sDtLg88vx0DrGuxS97h7jwU2046IBMgmY6rG14EfalOTKuLwXMmHtfILo9Zwi1LtK
         9uVgrVw+WXGQLkm4H/CIt797AV0mYOM6/0louNPYLLXyr1ds+KXDxMNTatPN45iLIUDY
         VgnjCKts2LowEflDhFwzVwNgLwbk9Jd3UvRPV73LbUQy5MNzwLiUioS3WNrvhDXPfs92
         ox/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Pho0DBoteWQ6P/LIkUCCwd3LfFL9DYnpmWlRk+XinNs=;
        b=Q/nSDGf1fLoCEFmhb1y1YtwKOHeMlabuPXZvmMhhL/D+rGuc33nwgXRV5fU6QvQ++d
         Q2o/QovYwIBJanO7sE60d0aS+SSMeLg6BgxyBcgQ2KfXpLscpVsvYclUPjmXJDzRXWYx
         YGb8i9oymAxAomHVPSyl9/Px6nbA/m/assF4gYffFLwj4tvMN9QxKF1ViIupgOGyuMBS
         9mUi2ahY2TyzE6IzPPOdH1yvZ9G8Cke22RM3l+Vm6WsgLk5HWiyoJ3ypifWe4zttUUS+
         WFR3uyBC0KHyrZyGDIfZeEOWkjlQHAlLxDCZJuZV2sYyCR7bKyIadd7OxJsdT021b4Pi
         +BZA==
X-Gm-Message-State: AE9vXwMMc01Mwqu9Z/v67XTtrT+kzIZMB4Kp9ANgg9Q6ZU5HvOGLfNBLf09BhnTy27Tr/Q==
X-Received: by 10.194.97.17 with SMTP id dw17mr16260056wjb.8.1472767521121;
        Thu, 01 Sep 2016 15:05:21 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id c139sm448903wme.4.2016.09.01.15.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 15:05:20 -0700 (PDT)
Subject: Re: [PATCH 09/22] sequencer: completely revamp the "todo" script
 parsing
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <163aaa2a64ddf6dfb28c77c821726e14cc78619e.1472457609.git.johannes.schindelin@gmx.de>
 <135c9ac7-49a6-8aa1-fc10-02c2a1fd0b1a@gmail.com>
 <alpine.DEB.2.20.1609010836010.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d8112b27-8de3-0860-e902-fb271b80a0e7@gmail.com>
Date:   Fri, 2 Sep 2016 00:05:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609010836010.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 01.09.2016 o 09:49, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Jakub Narębski wrote: 
>> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:
[...]

>> Hmmm... commit_list is, as defined in commit.h, a linked list.
> 
> That is the most prominent reason why the rest is not a mindless
> conversion from commit_list to todo_list.
> 
> And we need todo_list as an array, because we need to be able to peek, or
> even move, backwards from the current command.
> 
>> Here todo_list uses growable array implementation of list.  Which
>> is I guess better on current CPU architecture, with slow memory,
>> limited-size caches, and adjacency prefetching.
> 
> That is not the reason that an array is used here. The array allows us
> much more flexibility.

It would be nice if this reasoning (behind the change from linked list
to growable array) was mentioned in appropriate commit message, and
perhaps also in the cover letter for the series.  It is IMVHO quite
important information (that you thought obvious).

> 
> One of the major performance improvements will come at the very end, for
> example: the reordering of the fixup!/squash! lines. And that would be a
> *major* pain to do if the todo_list were still a linked list.

Actually deletion from and insertion into single linked list are
not that hard, and O(1) after finding place, O(N) with finding
included.  Moving elements in array is O(N),... and arguably a bit
simpler - but at high level, with appropriate primitives, they are
about the same.

Yes, array is easier for permutation and reordering.

>>> +struct todo_item *append_todo(struct todo_list *todo_list)
>>
>> Errr... I don't quite understand the name of this function.
>> What are you appending here to the todo_list?
> 
> A new item.
> 
>> Compare string_list_append() and string_list_append_nodup(),
>> where the second parameter is item to append.
> 
> Yes, that is correct. In the case of a todo_item, things are a lot more
> complicated, though. Some of the values have to be determined tediously
> (such as the offset and length of the oneline after the "pick <oid>"
> command). I just put those values directly into the newly allocated item,
> is all.

I would expect sth_append command to take a list (or other collection),
an element, and return [modified] collection with the new element added.
Such API would require temporary variable in caller and memcopy in the
sth_append() function.

This is not it.  It creates a new element, expanding a list (a collection),
and then expose this element.  Which spares us memcopy... on non-critical
path.

I don't know how to name operation "grow list and return new element".
But "append" it is not.
 
>>> +	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
>>> +	return todo_list->items + todo_list->nr++;
>>>  }
>>>  
>>> -static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
>>> +static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>>
>> Why the change of return type?  
> 
> Because it makes no sense to return a commit here because not all commands
> are about commits (think rebase -i's `exec`). It makes tons of sense to
> return an error condition, though.

All right.

I have not checked / not remember what caller of parse_insn_line() used
it's return value for.  I guess that we save it into todo_item, moving
that operation from caller to callee.

>> Why now struct todo_item is first when struct replay_opts was last?
> 
> Those play very, very different roles.
> 
> The opts parameter used to provide parse_insn_line() with enough
> information to complain loudly when the overall command was not identical
> to the parsed command.
> 
> The item parameter is a receptacle for the parsed data. It will contain
> the pointer to the commit that was previously returned, if any. But it
> will also contain much more information, such as the command, the oneline,
> the offset in the buffer, etc etc
> 
> So "opts" was an "in" parameter while "item" is an "out" one. Apples and
> oranges.

All right.  Good explanation.  And the one that is too low-level
detail to put in the commit message, I think.

>>> -	end_of_object_name = bol + strcspn(bol, " \t\n");
>>> +	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
>>
>> Why is this cast needed?
> 
> Because bol is a "const char *" and we need to put "NUL" temporarily to
> *end_of_object_name:

Would compiler complain without this const'ness-stripping cast?

> 
>>>  	saved = *end_of_object_name;
>>>  	*end_of_object_name = '\0';
>>>  	status = get_sha1(bol, commit_sha1);
>>>  	*end_of_object_name = saved;
> 
> Technically, this would have made a fine excuse to teach get_sha1() a mode
> where it expects a length parameter instead of relying on a NUL-terminated
> string.
> 
> Practically, such fine excuses cost me months in this rebase--helper
> project already, and I need to protect my time better.

Put it in TODO list (and perhaps add a TODO comment) ;-).

BTW. open-source produces better software, and development bandwidth
is good, but the latency :-(((( 

> 
>>> -	/*
>>> -	 * Verify that the action matches up with the one in
>>> -	 * opts; we don't support arbitrary instructions
>>> -	 */
>>> -	if (action != opts->action) {
>>> -		if (action == REPLAY_REVERT)
>>> -		      error((opts->action == REPLAY_REVERT)
>>> -			    ? _("Cannot revert during another revert.")
>>
>> Errr... could the above ever happen?  Namely
>>
>>   action != opts->action && action == REPLAY_REVERT && opts->action == REPLAY_REVERT
>>
>> Surely not.
> 
> Your reply pointed to the very circumstance when this may happen: `git
> cherry-pick --continue` after an interrupted `git revert`.

I was talking about "Cannot revert during another revert." and
"Cannot cherry-pick during another cherry-pick." errors, which can
never happen because of the outermost if.

   x == A && y == A && x != Y

can never happen, because equality is transitive^*

   x == A && y == A  =>  x == y

*) except NaN (NaN != NaN), but we don't deal with floating point here.


From those error messages it looks like they were originally intended
to prevent from starting another revert or cherry-pick if sequencer
based operation is already in progress (to not stomp on the latter
internal state).  But for that it would need to examine the
opts->subcommand if it is REPLAY_NONE (or equivalent), check that
sequencer file already exists, and read it to fond which operation
is in progress.

This is about checking that command in todo-list agrees with
the git command used (we probably checked that it is --continue,
or maybe --skip).  But the error message does not spell that;
it is misleading.

[Nb. git-blame shows Vasco Almeida as author of those lines]

> 
> But then, I remove that code here, so I should not try to defend it.
> 

But that was / is another reason for removing code: it is slightly
wrong.

>>> -			    : _("Cannot revert during a cherry-pick."));
>>> -		else
>>> -		      error((opts->action == REPLAY_REVERT)
>>> -			    ? _("Cannot cherry-pick during a revert.")
>>> -			    : _("Cannot cherry-pick during another cherry-pick."));
>>> -		return NULL;
>>> -	}
>>
>> Anyway, while it is / would be a good idea to prevent starting any
>> sequencer-based command (cherry-pick, revert, soon rebase -i) when
>> other command is in progress (cherry-pick, revert, soon rebase -i).
>> That is, if cherry-pick / revert waits for user action, you cannot
>> run another cherry-pick or revert.
>>
>> Which I guess the above code was not about...
> 
> It was about that, though.

No it was not, see the reasoning above.

> 
> It went about it in a pretty round-about way: opts->action comes from the
> name of the command ("was I called as `git revert` or `git cherry-pick`?")
> and action comes from the todo script, which was assumed to be written by
> a previous run of the sequencer, using the then-current value of
> opts->action.

It did different check, that we continue with the same command
as we began with.

> 
> So it wrote that command into *every single line* of the todo script, *for
> the sole purpose* of verifying that it was the same action when running
> via --continue.
> 
> As I said earlier, I would not complain at all if an interrupted `git
> revert` could be continued via `git cherry-pick --continue`.
> 
> If that is not desirable, I can reintroduce that overzealous check, but
> that will have to wait until after v2.10.0. And it would require an
> argument that convinces me.

One argument is that you can add options to --continue, and among
options for cherry-pick, revert and rebase -i, there are options
that apply only to some of them.  So we need at least decide what
to do if we started rebase, and try to continue with cherry-pick:
do we accept rebase-only options?  What we do with cherry-pick-only
options, that rebase does not understand?

It is easier to just check that revert is continued with revert
(by checking command in todo file), cherry-pick with cherry-pick
(same), rebase -i with rebase (by checking another file), and
am with am.

> 
>>> +		item = append_todo(todo_list);
>>
>> A better name, in my personal option, would be
>>
>>   +		item = todo_list_next(todo_list);
>>
>> Or todo_next(todo_list).
> 
> That sounds more like a function that performs the next command in the
> todo_list.
> 
> While I agree that naming is hard, I still think that `append_todo()` with
> the todo_list as single parameter and returning a todo_item is pretty much
> self-explanatory: it appends a new item to the todo_list and returns a
> pointer to it.

It creates new item in the todo_list at the end, or it grows todo_list,
but the function does not append anything...

[...]
>>> -	if (strbuf_read(&buf, fd, 0) < 0) {
>>> +	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
>>>  		close(fd);
>>> -		strbuf_release(&buf);
>>
>> A question: when is todo_list->buf released?
> 
> Why, I am glad you asked! It is released in todo_list_release(), called at
> the end e.g. of sequencer_continue().

All right.  I could have guessed that.

>>> -static int walk_revs_populate_todo(struct commit_list **todo_list,
>>> +static int walk_revs_populate_todo(struct todo_list *todo_list,
>>>  				struct replay_opts *opts)
>>>  {
>>> +	enum todo_command command = opts->action == REPLAY_PICK ?
>>> +		TODO_PICK : TODO_REVERT;
>>>  	struct commit *commit;
>>> -	struct commit_list **next;
>>>  
>>>  	if (prepare_revs(opts))
>>>  		return -1;
>>>  
>>> -	next = todo_list;
>>> -	while ((commit = get_revision(opts->revs)))
>>> -		next = commit_list_append(commit, next);
>>> +	while ((commit = get_revision(opts->revs))) {
>>> +		struct todo_item *item = append_todo(todo_list);
>>> +		const char *commit_buffer = get_commit_buffer(commit, NULL);
>>
>> I see that you are creating todo file contents while walking revision list,
>> something that was left for later in current / previous implementation
>> of the sequencer...
> 
> Not really. This function was always about generating a todo_list. It just
> did not format it yet.
> 
> With the change of keeping the original formatting of the todo script
> instead of re-formatting it in save_todo(), this function now has to
> format the todo_list itself.

So the commit parsing was moved from save_todo(), which contrary to
the name also re-generated todo list, to walk_revs_populate_todo().
I guess it is the same callchain.

Additional question, answer to which should address Junio's complaint
about early/eager commit parsing (if I understand it correctly):
do information from parsing commit is needed for creating a new
commit, i.e. doing a pick or revert?  If not, then perhaps parsing
only those commits that are left, at the time of saving todo file
(with probably less commit that what we have started with), would
be better?

[...]
>>> -static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
>>> +static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>>>  {
>>>  	static struct lock_file todo_lock;
>>> -	struct strbuf buf = STRBUF_INIT;
>>> -	int fd;
>>> +	const char *todo_path = get_todo_path(opts);
>>> +	int next = todo_list->current, offset, fd;
>>
>> The "next = todo_list->current" looks a bit strange.
> 
> Depending whether we need rebase -i processing or revert/cherry-pick's
> slightly different one, the "current" position points to the next one
> already...
> 
>> Also, we do not change todo_list->current, we use it in one place, so it
>> can be used directly without help of temporary / helper variable.  But
>> that is just my personal opinion.
> 
> No, it has nothing to do with opinion. It prepares the code to keep it
> readable even when REPLAY_INTERACTIVE_REBASE is introduced.

Ah, all right.

[...]
>> and this should be done in one of earlier patches, isn't it?
> 
> No. I deliberately skipped save_todo() from "future-proofing" as I planned
> to rewrite it anyway. There is no point in future-proofing something you
> are going to toss in a minute.
> 

All right.  Though I wonder if it should not be mentioned in
the commit message of said previous patch (though I have missed
that not all sites were "future-proofed" in review; I'm sorry).

>>> -	if (commit_lock_file(&todo_lock) < 0) {
>>> -		strbuf_release(&buf);
>>> -		return error(_("Error wrapping up %s."), git_path_todo_file());
>>> -	}
>>> -	strbuf_release(&buf);
>>> +	if (commit_lock_file(&todo_lock) < 0)
>>> +		return error(_("Error wrapping up %s."), todo_path);
>>
>> Note: this is unrelated change, but we usually put paths in quotes, like this
>>
>>   +		return error(_("Error wrapping up '%s'."), todo_path);
>>
>> (in this and earlier error message), so that paths containing spaces show
>> correctly and readably to the user.  Though this possibly is not a problem
>> for this path.
> 
> Right.
> 
>> Also, how user is to understand "wrapping up"?
> 
> The same as before: the removed lines already had the error message,
> missing the quotes, too.
> 
> Don't get me wrong: I am a big fan of consistency, and I wish that Git's
> source code had more of it. So I would love to see a patch series that
> makes all error messages consistently reporting paths enclosed in single
> quotes.
> 
> I am also a big fan of the separation of concerns, though. And this patch
> series' concern is consistency *with the existing code*.
> 
> So I won't change the error message that I inherited at this point.

All right, I can understand that.  But I think it won't cost
much to do _while at it_ adding of quotes around pathnames in
error messages, where you notice this problem.
 
>>>  static int single_pick(struct commit *cmit, struct replay_opts *opts)
>>>  {
>>>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>> -	return do_pick_commit(cmit, opts);
>>> +	return do_pick_commit(opts->action == REPLAY_PICK ?
>>> +		TODO_PICK : TODO_REVERT, cmit, opts);
>>
>> The ternary conditional operator here translates one enum to other enum,
>> isn't it?
> 
> Well, almost. Please note that the enum will receive a new value in the
> sequencer-i patch series. And there is no equivalent todo_command for
> REPLAY_INTERACTIVE_REBASE.

All right.  And casting one enum to other, relying on the same
order, is tricky to the extreme and brittle.

> 
> Thanks for the review!

You are welcome.

Best,
-- 
Jakub Narębski

