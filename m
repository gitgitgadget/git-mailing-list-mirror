Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6A1C20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbdASSiy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:38:54 -0500
Received: from smtp82.iad3a.emailsrvr.com ([173.203.187.82]:58351 "EHLO
        smtp82.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754117AbdASSiw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jan 2017 13:38:52 -0500
Received: from smtp3.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp3.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 92E3925136;
        Thu, 19 Jan 2017 13:38:04 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp3.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 66DEF24C53;
        Thu, 19 Jan 2017 13:38:04 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 19 Jan 2017 13:38:04 -0500
Subject: Re: [RFC] stash --continue
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
 <alpine.DEB.2.20.1701161153340.3469@virtualbox>
 <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
 <alpine.DEB.2.20.1701181725130.3469@virtualbox>
 <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
 <alpine.DEB.2.20.1701191341530.3469@virtualbox>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <aa8104ad-45f4-7bef-f199-6e6021cf0c06@xiplink.com>
Date:   Thu, 19 Jan 2017 13:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701191341530.3469@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-19 10:49 AM, Johannes Schindelin wrote:
> Hi Marc,
>
> On Wed, 18 Jan 2017, Marc Branchaud wrote:
>
>> On 2017-01-18 11:34 AM, Johannes Schindelin wrote:
>>>
>>> On Wed, 18 Jan 2017, Marc Branchaud wrote:
>>>
>>>> On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
>>>>
>>>>> On Mon, 16 Jan 2017, Stephan Beyer wrote:
>>>>>
>>>>>> a git-newbie-ish co-worker uses git-stash sometimes. Last time
>>>>>> he used "git stash pop", he got into a merge conflict. After he
>>>>>> resolved the conflict, he did not know what to do to get the
>>>>>> repository into the wanted state. In his case, it was only "git
>>>>>> add <resolved files>" followed by a "git reset" and a "git stash
>>>>>> drop", but there may be more involved cases when your index is
>>>>>> not clean before "git stash pop" and you want to have your index
>>>>>> as before.
>>>>>>
>>>>>> This led to the idea to have something like "git stash
>>>>>> --continue"[1]
>>>>>
>>>>> More like "git stash pop --continue". Without the "pop" command,
>>>>> it does not make too much sense.
>>>>
>>>> Why not?  git should be able to remember what stash command created
>>>> the conflict.  Why should I have to?  Maybe the fire alarm goes off
>>>> right when I run the stash command, and by the time I get back to it
>>>> I can't remember which operation I did.  It would be nice to be able
>>>> to tell git to "just finish off (or abort) the stash operation,
>>>> whatever it was".
>>>
>>> That reeks of a big potential for confusion.
>>>
>>> Imagine for example a total Git noob who calls `git stash list`,
>>> scrolls two pages down, then hits `q` by mistake. How would you
>>> explain to that user that `git stash --continue` does not continue
>>> showing the list at the third page?
>>
>> Sorry, but I have trouble taking that example seriously.  It assumes
>> such a level of "noobness" that the user doesn't even understand how
>> standard command output paging works, not just with git but with any
>> shell command.
>
> Yeah, well, I thought you understood what I meant.
>
> The example was the best I could come up with quickly, and it only tried
> to show that there are *other* stash operations that one might perceive
> to happen at the same time as the "pop" operation, so your flimsical
> comment "why not continue the latest operation" may very well be
> ambiguous.
>
> And if it is not ambiguous in "stash", it certainly will be in other Git
> operations. And therefore, having a DWIM in "stash" to allow "--continue"
> without any specific subcommand, but not having it in other Git commands,
> is just a very poor user interface design. It is prone to confuse users,
> which is always a hallmark of a bad user interface.

Please don't underestimate the power of syntactic consistency in helping 
users achieve their goals.  Having some commands use "git foo 
--continue" while others use "git foo bar --continue" *will* confuse 
people, regardless of how logical the reasons for those differences.

But in the case of stash, I still don't see the utility in having 
operation-specific continuation.  Consider the following sequence (as 
you say, this doesn't work yet, but making it work seems reasonable):

	git stash pop  # creates some conflicts
	git stash apply stash@{4} # creates some other conflicts
	# (User resolves the conflicts created by the pop.)
	git stash pop --continue

Given the description of the original proposal (do "git reset; git stash 
drop"), what's the state of the index and the working tree?

In particular, what has the user gained by continuing just that pop?

Another thing to ask is, how common is such a scenario likely to be?  I 
suggest that it will be far more common for users to resolve all the 
conflicts and then want to continue all their interrupted stash 
operations.  If so, fussily forcing them to explicitly continue the pop 
and the apply is just a waste.

> Hence my objection to "git stash --continue". No argument in favor of "git
> stash --continue" I heard so far comes even close to being convincing.

Well, what about the potential for a slippery slope?  If the user is 
forced to be specific about continuing either a pop or an apply, why 
wouldn't git allow them to be specific about *which* pop or apply they 
want to continue?  Consider another hypothetical scenario:

	git stash pop  # creates some conflicts
	git stash pop  # creates some more conflicts
	git stash pop  # creates even more conflicts
	# (User resolves the conflicts created by second pop.)
	git stash pop --continue
	# Oops, there's still some unresovled pops!

Obviously the user isn't ready to finish off all the pops, so they'll 
want some way to specify which pop to continue.  Dealing with that just 
feels like a lot of work for minimal benefit.

>>> Even worse: `git stash` (without arguments) defaults to the `save`
>>> operation, so any user who does not read the documentation (and who
>>> does?) would assume that `git stash --continue` *also* implies `save`.
>>
>> Like the first example, your user is trying to "continue" a command that
>> is already complete.
>
> Says who? You may understand the semantics better than other users, but
> who are you to judge?
>
> But that's besides the point.
>
> My point (which you did not quite understand) was that it can be ambiguous
> what to continue when looking at *all* Git commands. To special-case "git
> stash"'s user interface makes things more confusing, and therefore less
> usable for everyone.
>
> And even with `git stash apply`, you could construct a very plausible
> scenario (which does not work yet, but we may want to make it work): if
> `git stash apply` causes conflicts, and `git stash apply stash@{1}`
> conflicts in a *different* set of files, why don't we allow the second
> operation to succeed (adding its conflicts)?

Running those two commands should be perfectly fine.  The interesting 
question is what it means to *continue* from that state.

> That example is like `git cherry-pick -n` with two different commits, both
> of which conflict with the current worktree, but in different files. Both
> cherry-picks would do their job if called after one another, and the
> result is a worktree with the *combined* conflicts. That is a legitimate
> use case (which I happened to *actually* perform just the other day).

I don't mean to suggest that you shouldn't be able to do that.

> If we fix "git stash" (and there is no reason we should not), it would
> also allow "git stash pop; git stash pop" to work with two stashes that
> both conflict with the current worktree, just in different files.

Sounds fine to me.  So, what would it mean to continue from that state?

> So I challenge you to get less hung up on the *exact* example I present,
> and to try to see through the example what the issue is that I am trying
> to get at.
>
>>> If that was not enough, there would still be the overall design of
>>> Git's user interface. You can call it confusing, inconsistent, with a
>>> lot of room for improvement, and you would be correct. But none of
>>> Git's commands has a `--continue` option that remembers the latest
>>> subcommand and continues that. To introduce that behavior in `git
>>> stash` would disimprove the situation.
>>
>> I think it's more the case that none of the current continuable commands
>> have subcommands (though I can't think of all the continuable or
>> abortable operations offhand, so maybe I'm wrong).  I think we're
>> discussing new UI ground here.
>
> Nope, we are not entering new UI ground here. The principle is clear with
> the existing --continue options: you pass them to the same operation that
> you want to continue. By that reasoning, "git stash --continue" should
> continue the (implicit) "save" operation. But that is not at all what you
> want.
>
>> And since the pattern is already "git foo --continue",
>
> But foo *is the operation*! By that reasoning, you should agree that "git
> stash --continue" is *wrong*!

No, in the user's mind *stash* is the operation!  The user is doing 
"stash" stuff.  She doesn't care if the conflicts came from a pop or an 
apply.  She has resolved the conflicts, and now she just wants to continue.

There's no confusion about possibly continuing some other stash 
subcommand, like save or list or drop.  None of those other commands are 
continuable.  In the following sequence

	git stash "let me save my work now"
	git stash --continue

That continue command does nothing, regardless of whether the implied 
save command succeeded or failed.  There's simply nothing to continue.

With the sequence

	git stash pop  # creates some conflicts
	git stash "got some popped conflicts"
	git stash --continue

Again the continue command should do nothing:  If the save command 
succeeded it should have cleaned up the interrupted pop.  If the save 
command failed, then the continue command can't continue from a 
conflicted state.  (OTOH, a "git stash --abort" would abort the pop.)

>> Think of it this way:  All the currently continuable/abortable commands
>> put the repository in a shaky state, where performing certain other
>> operations would be ill advised.  Attempting to start a rebase while a
>> merge conflict is unresolved, for example.  IIRC, git actually tries to
>> stop users from shooting their feet in this way.
>>
>> And so it should be for the stash operation:  If applying a stash yields
>> a conflict, it has to be resolved or aborted before something like a
>> rebase or merge is attempted.
>
> That already happens, and I have no idea how you think this safe-guarding
> has anything to do whether the "--continue" option makes sense in "git
> stash", or only in "git stash pop".
>
>> In the long run, I think there's even the possibility of generic "git
>> continue" and "git abort" commands,
>
> Wrong.
>
> You can call "git cherry-pick" (and "git cherry-pick --continue") while
> running a "git rebase -i".
>
> You can run "git rebase", "git stash", "git cherry-pick" and many other
> commands while running a "git bisect".
>
> You can even run a "git rebase" or a "git cherry-pick" while resolving an
> interrupted "git am".
>
> Many, many examples that make it *impossible* for Git to know *what* you
> want to continue, *what* you want to abort.

Right, I'd missed that.  I agree that a generic "git continue" is nonsense.

		M.

