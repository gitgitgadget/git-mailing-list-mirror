Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C730820248
	for <e@80x24.org>; Sat,  9 Mar 2019 23:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCIXyc (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 18:54:32 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:28603 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIXyc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 18:54:32 -0500
Received: from [192.168.1.12] ([2.101.244.128])
        by smtp.talktalk.net with SMTP
        id 2lnPhCWYddrax2lnPhGPZ7; Sat, 09 Mar 2019 23:54:29 +0000
X-Originating-IP: [2.101.244.128]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=8nsoD1t2XaTH5iSUU4dp1Q==:117
 a=8nsoD1t2XaTH5iSUU4dp1Q==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=azOqWcvn-bPetywNrAMA:9 a=K-nuZqdoseK-GALV:21 a=z5tm1yvYdmKz_z6l:21
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: git MUST notify user when files will be deleted or overwritten by
 command
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Kevin Daudt' <me@ikke.info>,
        'Dimitri Joukoff' <dimitri.joukoff@griffithuni.edu.au>
Cc:     git@vger.kernel.org
References: <SYXPR01MB09577F5C4555C9068B606E11DD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
 <20190309104812.GA3403@alpha> <000401d4d6c8$f68bb020$e3a31060$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <dddaf761-29f0-36ce-c0c1-04e59d6c7bc9@iee.org>
Date:   Sat, 9 Mar 2019 23:54:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <000401d4d6c8$f68bb020$e3a31060$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfEoGsbN+HxT51U55gLJ1eRb1Tczvgx8t/pTqVDlpsUJi6u1B7ynVCgh9u6dRQS9I9NeaumdpMLXhSATvl+0dWwjkwA1KVRkHLNuesg9Le9oZhmTeHPnL
 F34FbQjGhFOSxec73K1WOpB+PVlt2CZXPdm5UgqAg2xQfp/V232xVzLUHOw5Q+hWkMbLuu0/+X2I/b+1Ab9Sq1z7CBTM+a2/q8i5b7X90F5PUQFqII3S+9wg
 fkF8empKlnPqMrsgWzS0gvfz8mu7Z2PzztQJWItDLKw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/03/2019 22:39, Randall S. Becker wrote:
> On March 9, 2019 5:48, Kevin Daudt wrote:
>> On Sat, Mar 09, 2019 at 10:19:03AM +0000, Dimitri Joukoff wrote:
>>> Hi,
>>>
>>> As a relatively novice user of git, there have been far too many times
>>> that I have lost data, sometimes quite a lot.  So this proposal is
>>> about catering for the less experienced users and averting fits of
>>> anger and frustration.  The only reason my computer still works is
>>> because my sub-conscious mind stops me from smashing it or throwing it
>>> against a wall.  It seems my sub-conscious mind has a pragmatic view
>>> of the world and understands that whilst I may receive instantaneous
>>> satisfaction at the time, in the long term, the pain will be far
>>> worse, and thus prevents me from doing something rash.
>>>
>> Yes, it can be very frustrating to lose things you did not intend to lose,
> so
>> making sure your tooling limits the chances of that happing is certainly a
>> worthwile goal.
>>
>>> Below is the detail of my proposal: > Whenever a command is issued in
>>> git that will cause git to overwrite or delete *ANY* files whose
>>> current state isn't already recorded in the repository, git should
>>> prompt the user to confirm the operation. This includes untracked
>>> files as well as files that are in the 'not staged'
>>> and 'staged' lists.
>>>
>>> To make the consequences of the command transparent, the confirmation
>>> should include a list of files that will be affected (perhaps in a
>>> similar way to how git status works).  The scope of the files listed
>>> must match the scope of the command to be executed.  No hidden
>>> changes, no side-effects.
>>>
>>> Saying no to the confirmation should abort the command.
>>>
>>> It may be useful to allow confirmation of individual files, but as a
>>> novice user, I can't argue this point objectively, nor reason about
>>> its implications and complexity.
>>>
>>> This feature should be enabled by default whenever a clone or init
>>> operation are performed.
>>>
>>> The user should be able to progressively reduce the range of commands
>>> and amount of confirmation interactions that take place.  The
>>> configuration technique could follow the already established procedure
>>> for other configurable data in git.  So this could be done globally
>>> for the user, or locally within each repository.
>>>
>>>
>>> As a novice user, there may be further useful extensions of this idea,
>>> about which I'm unable to reason.  So I welcome further elaboration of
>>> the idea discussed above.
>> A lot of confirmations only result in people automatically dismissing them
>> (confirmation saturation), missing the goal of what you intend.
>>
>> Instead of asking for confirmation, it's much better to allow people to
> undo
>> these mistakes. You see the same pattern in gmail for example, where they
>> hardly ask you for any confirmation, but instead show an undo button that
>> allows you to undo the last operation. In my opinion this is a better way
> to
>> go then to add confirmations everywhere.
>>
>> I know this has come up on the git mailing list more often, but I cannot
> find a
>> relevant thread at this moment.
> First, I really do not like the idea of confirmations. This could complicate
> scripting and would drive much of the work I do with git in Jenkins up a
> wall. You would need access to stdin for almost anything.
>
> Second, I think an automatic undo has merit and could further differentiate
> git from other DVCS and VCS systems. My thought is along the lines of
> starting with the stash concept for each undo - almost like an auto-stash.
> Basically, any time you perform a working-directory modifying operation, a
> stash-like commit is added to the repository at HEAD (possibly ignoring
> .gitignore or precious files, like --include-untracked but in a config like
> undo.untracked=on, to avoid needing to remember to do this). I envision it
> being a stash without modifying the working-directory or changing the
> repository state other than the "undo" unlike what stash does.
>
> Considering the performance hit this *will* cause, I would want an option to
> not do this (say, undo.enable=on/off, off by default unless there was some
> newbie metric <j/k>, or maybe undo.fearful=high <j/k>), and a limit to the
> number of undoes (undo.limit=n), and an auto-drop capability so that when
> you finally commit, you have the option to drop the undoes of the previous
> parent commit (undo.autoclean=on/off), or limit it to cleaning after more
> than one commit is done beyond the commit where the undo exists
> (undo.autoclean=n).
>
> Deriving an "undo" off of a specific parent commit (HEAD), instead of
> deriving "undoes" on each other, might be helpful in resolving the question
> of how to you roll off (get rid of) undoes over time - making it just based
> on the time of the snapshot and how many you want to keep. The reason I
> would hang it off of a HEAD commit is that a checkout/switch would preserve
> the undo stack so that when you returned to a branch, its undo stack would
> be available, like stash.
>
> I would also see an impact on gc, potentially, to clean up old undoes beyond
> a specific date.
>
> This might need to start as a modification to stash, like --keep-index, but
> more like taking picture, for example, --snapshot-only. Once you had that,
> building an undo stack should be straight-forward, and undoing would be
> virtually the same as a stash apply (might even *be* stash apply if the
> "undo" and stash were somehow the same thing conceptually). We're probably
> also talking about a new command and subcommands, very similar to the stash
> structure but querying either from HEAD or a specified commitish. If I only
> had the time... ;)
>
> Just my musings.
>
> Randall

The key word to look for on the discussion list is 'precious'.

Have a look at the various discussions 
https://public-inbox.org/git/?q=precious

There are quite a number of files that are otherwise trashable that one 
would not want endless confirmations for - it is a tricky task.

--

Philip

