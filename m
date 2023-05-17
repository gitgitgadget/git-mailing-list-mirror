Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1163C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 12:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjEQMNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQMNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 08:13:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35837527D
        for <git@vger.kernel.org>; Wed, 17 May 2023 05:13:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so5136975e9.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684325610; x=1686917610;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Cr6BmlYeqvrcSSn0MuHNTRXMq8rd9dGCLLhafLWkbs=;
        b=NOpSOl392ryCRQPctu4a1SQd/kVg1eO88GCFIxX4WRH9/I/rgPr4KaWzz+qZ3OjTBh
         mZkJslPxaAXkMnblh4+jKU7RH173uaOtiJHKZL1wuYB+FC+eNjNBJA+iAEYhGb080WNF
         BZDBoP+GX3SgCn8yXUI+WMPq6fjykYKU0CrhpfyUq24r7S/i0O7hoyeOFSB/YK6C1RB/
         ZLwMnH14CJCuTP2Cr3e128igOLRsfhC7D2OHMRcaWNVdaAHE4JR5AgXHf/YbR9mSkWH8
         9tvBKHDO+7PoyPUPwwfGuw3yRyViQLKrWO71adUXIbb9AqWKoTBWNhFrq9L1vUZyz+tH
         rimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325610; x=1686917610;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cr6BmlYeqvrcSSn0MuHNTRXMq8rd9dGCLLhafLWkbs=;
        b=E2D5f9gGijErpTbbnBtW76Ni7WZEngr+8LOGRIVW/L2+zub4PmMW6uCRxycJJgM7ZS
         nmTR5rnhrm9uw6a+ehq4GNKz8MNbET8ndQk7LGr7RUr3fAgd1YvfcGSPigsBeWbB55jU
         QU/JOjUwfDslrLFK9ajyKVx0r7liybzhmGYQ5FL9bQ1mfVyXtiv5XYXolAwswSy5JzSF
         hX7YLLn+Y3cW6dMsWLT/28b/C5sz0T0l6CIlvw7C9rideJK9/x/GTzyeLeRp0efIxpci
         AUFpxFOdd4W7KXqFhPR5RGB056FbGKGf1Da9r/ip2oQBZuQC56jTG4c3VDc/lyICRBIT
         r61w==
X-Gm-Message-State: AC+VfDwidzFReAS8J41Bz7KItAuRc3Z1UEqY43yHCdYIXP1wNp/u+leG
        3LaKbVMlSb9XtfJyLxcNpcZLzgHKp+I=
X-Google-Smtp-Source: ACHHUZ7LQPjx7sT8RqTyYfdrqH9XEv0gIvkKMQmAYuzzpgScdOJTOQ/uBFkaGQrGJK2DHahPa63Pxw==
X-Received: by 2002:a7b:c342:0:b0:3f1:70a2:ceb5 with SMTP id l2-20020a7bc342000000b003f170a2ceb5mr28600352wmj.13.1684325610163;
        Wed, 17 May 2023 05:13:30 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id z18-20020adff752000000b00309382eb047sm2505040wrp.112.2023.05.17.05.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 05:13:29 -0700 (PDT)
Message-ID: <08c4c313-35c8-63e9-7d66-a35b24a449dd@gmail.com>
Date:   Wed, 17 May 2023 13:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 8/8] rebase: improve resumption from incorrect initial
 todo list
Reply-To: phillip.wood@dunelm.org.uk
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-9-oswald.buddenhagen@gmx.de>
 <8a188876-c456-7269-28de-9ff406204030@dunelm.org.uk> <ZElEis+PLDYR+Jvr@ugly>
Content-Language: en-US
In-Reply-To: <ZElEis+PLDYR+Jvr@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 26/04/2023 16:34, Oswald Buddenhagen wrote:
> On Sun, Mar 26, 2023 at 03:28:01PM +0100, Phillip Wood wrote:
>> On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>>> When the user butchers the todo file during rebase -i setup, the
>>> --continue which would follow --edit-todo would have skipped the last
>>> steps of the setup. Notably, this would bypass the fast-forward over
>>> untouched picks (though the actual picking loop would still fast-forward
>>> the commits, one by one).
>>>
>>> Fix this by splitting off the tail of complete_action() to a new
>>> start_rebase() function and call that from sequencer_continue() when no
>>> commands have been executed yet.
>>>
>>> More or less as a side effect, we no longer checkout `onto` before 
>>> exiting
>>> when the todo file is bad. 
>>
>> I think the implications of this change deserve to be discussed in the 
>> commit message. Three things spring to mind but there may be others I 
>> haven't thought of
>>
>>  - Previously when rebase stopped and handed control back to the user
>>    HEAD would have already been detached. This patch changes that
>>    meaning we can have an active rebase of a branch while that branch is
>>    checked out. What does "git status" show in this case? What does the
>>    shell prompt show? Will it confuse users?
>>
> the failed state is identical to the "still editing the initial todo" 
> state as far as "git status" and the shell prompt are concerned. this 
> seems reasonable. i'll add it to the commit message.

When you do that please mention what "git status" and the shell prompt 
actually print in this case. Ideally "git status" should mention that 
the todo list needs to be edited if there are still errors in it, though 
it would not surprise me if it is not that helpful at the moment.

>>  - Previously if the user created a commit before running "rebase
>>    --continue" we'd rebase on to that commit. Now that commit will be
>>    silently dropped.
>>
> this is arguably a problem, but not much different from the pre-existing 
> behavior of changes to HEAD done during the initial todo edit being lost.

I think there is a significant difference in that we're moving from a 
situation where we lose commits that are created while rebase is running 
to one where we're losing commits created while rebase is stopped. If a 
user tries to create a commit while rebase is running then they're 
asking for trouble. I don't think creating commits when rebase is 
stopped is unreasonable in the same way.

> to avoid that, we'd need to lock HEAD while editing the todo. is that 
> realistic at all?

I don't think it is practical to lock HEAD while git is not running. We 
could just check HEAD has not changed when the rebase continues after 
the user has fixed the todo list as you suggest below.

> on top of that, i should verify HEAD against orig-head in 
> start_rebase(). though the only way for the user to get out of that 
> situation is saving the todo contents and --abort'ing (and we must take 
> care not the touch HEAD).

I think in that case it wouldn't be terrible to lose the edited todo 
list as it is a bit of a corner case. The simplest thing to do would be 
to print an error and remove .git/rebase-merge.

> this is somewhat similar to the abysmal situation of the final 
> update-ref failing if the target ref has been modified while being 
> rebased. we'd need to lock that ref for the entire duration of the 
> rebase to avoid that.

"abysmal" is rather harsh - it would also be bad to overwrite the ref in 
that case. I think it in relatively hard to get into that situation 
though as "git checkout" wont checkout a branch that is being updated by 
a rebase.

>>  - Previously if the user checkout out another commit before running
>>    "rebase --continue" we'd rebase on to that commit. Now we we rebase
>>    on to the original "onto" commit.
>>
> this can be subsumed into the above case.

Meaning check and error out if HEAD has changed?

>> > This makes aborting cheaper and will simplify
>> > things in a later change.
>>
>> Given that we're stopping so the user can fix the problem and continue 
>> the rebase I don't think optimizing for aborting is a convincing 
>> reason for this change on its own.
>>
> this is all part of the "More or less as a side effect" paragraph, so 
> this isn't a relevant objection.

I'm simply saying that we should not be optimizing for "rebase --abort" 
in this case. Do you think we should?

>>> diff --git a/builtin/revert.c b/builtin/revert.c
>>> index 62986a7b1b..00d3e19c62 100644
>>> --- a/builtin/revert.c
>>> +++ b/builtin/revert.c
>>> @@ -231,7 +231,8 @@ static int run_sequencer(int argc, const char 
>>> **argv, struct replay_opts *opts)
>>>           return ret;
>>>       }
>>>       if (cmd == 'c')
>>> -        return sequencer_continue(the_repository, opts);
>>> +        return sequencer_continue(the_repository, opts,
>>> +                      0, NULL, NULL, NULL);
>>
>> It's a bit unfortunate that we have to start passing all these extra 
>> parameters, could the sequencer read them itself in read_populate_opts()?
>>
> that wouldn't help in this case, as these are dummy values which aren't 
> going to be used.

If we only need to pass these when rebasing maybe we should have 
separate wrappers for continuing a rebase and a cherry-pick/revert. If 
we don't always need these parameters when continuing a rebase we could 
have a separate function when these parameters are required and leave 
the signature of sequencer_continue() unchanged.

> but more broadly, the whole state management is a total mess.

For historic reasons there are separate functions to write the state for 
the "merge" backed and the "apply" backend. That is not ideal but it is 
hardly a "total mess". The code for reading the state files is more 
contrived than the code that writes them. I do have some patches to try 
and reduce the duplication when reading the state files.


>>> -int sequencer_continue(struct repository *r, struct replay_opts *opts)
>>> +static int start_rebase(struct repository *r, struct replay_opts 
>>> *opts, unsigned flags,
>>> +            const char *onto_name, const struct object_id *onto,
>>> +            const struct object_id *orig_head, struct todo_list 
>>> *todo_list);
>>
>> It would be nice to avoid this forward declaration. I think you could 
>> do that by adding a preparatory patch that moves either 
>> checkout_onto() or sequencer_continue()
>>
> i went for the "minimal churn" approach.

There is a balance to be had, but we don't want to build up a lot of 
forward declarations over time just because it is easier than moving the 
function in a preparatory patch. A simple patch to move a function is 
easy to review with --color-moved.

>>> +    git reflog > reflog &&
>>> +    test $(grep -c fast-forward reflog) = 1 &&
>>
>> Using test_line_count would make test failures easier to debug.
>>
> that's calling for a new test_filtered_line_count function which would 
> have quite some users.
> for the time being, both grep + test_line_count and grep -c are rather 
> prevalent, in this file the latter in particular.

The style of our tests has evolved over time. When adding new tests it 
is better to focus on making them easy to debug. I don't think you need 
to add a new function here, just

	grep fast-forward reflog >filtered-reflog
	test_line_count = 1 filtered-reflog

>>> +    test_cmp_rev HEAD~1 primary~1 &&
>>> +    test "$(git log -1 --format=%B)" = "E_reworded"
>>
>> It is slightly more work, but please use test_cmp for things like this 
>> as it makes it so much easier to debug test failures.
>>
> fair enough, but the precedents again speak a different language.

Yes older tests tend to be written in a style that is harder to debug.

Best Wishes

Phillip
