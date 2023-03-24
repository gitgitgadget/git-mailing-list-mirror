Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C06C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 10:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCXKvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 06:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCXKvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 06:51:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36E241F0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 03:50:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m2so1326912wrh.6
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679655054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/iURM9SM/Us74XCjJaM0Xq7+N+pi+ZLOf6HfD4Ul8c=;
        b=btHzz3ClJBPWk9bPzdfGRAQVndp490hnyo9SIaQaEI7ZGc5MQOQcse4vwOFsTyyfz7
         6c38cghXFNuiVr4sb0U7nBCfRsERZutobvP08oCJIBe1KahdkZT4nlZ2Hm6RUuABPRdO
         f2fjN05VD0kQTDkf5CsTXgquXkPhoudBr0OEz4z4cuJKeU90kJ9OaFuS1ojFBMeaU9GG
         NP9KeFN22y7dMhEp6fycRuqS2TiFgCXIEceLzcEgchmOhZDvoQ1iHAcKkvwTSGRZQ6m0
         BilVZ6+nT39SsRQHdWUk1rnAAmJjpP2SxNnBCzITi2mk3Azn/G6brbNe15/felBqCy1t
         pfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679655054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/iURM9SM/Us74XCjJaM0Xq7+N+pi+ZLOf6HfD4Ul8c=;
        b=uMtjw4WrGkRNv+k5ECM29qdNfExhRpyBrWwH6hcvbjgc8O5GhnWYUJcmIUD9HD9olg
         HL+vyQCbZA8bHn1wRu2HWekirPhnQbEAIxZ2IqmvRFzDbXL/E31aX1TnaWDj1CLBG5k5
         MQt7FlRn1vTcK1/XInrCkQhKA78nU8ubJYHJMCNWfs38nTlSsCiTkTVoVNNJbWcDqoTM
         vug/gZEG+RPs7CmkH8itY0tWvgUhzRuHyDHx6Af+WVOxOjFuKIW6mA8zSYVaD4fsxoAY
         GqvadECK0NYZoMQIrT9zcWIbdTdClUbW0kYHWqKsVJievIsU4+HFbKqSoz5BRNRCLUG6
         INLQ==
X-Gm-Message-State: AAQBX9cpPZWSkNa6y7t39oB0ZatyH/+VCi61HV5KMs2BEWIZ8ST0BaY/
        PcPFWZHioXSE+2oNKTdbQMg=
X-Google-Smtp-Source: AKy350bYyYFvmKEK7U2WGnJaL+3KrIJ9qwj91WSEXjTaWZ39MHXvoQ/EVm1KG8dxAC7ua1ThY7TDAQ==
X-Received: by 2002:a5d:6602:0:b0:2ce:a8a1:3085 with SMTP id n2-20020a5d6602000000b002cea8a13085mr1777999wru.28.1679655054213;
        Fri, 24 Mar 2023 03:50:54 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm18180829wrs.44.2023.03.24.03.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:50:53 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9e5093ab-2aa8-16e7-227a-f5c56983be9a@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 10:50:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling command
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <xmqq4jqfmi2k.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq4jqfmi2k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Thanks for your comments

On 20/03/2023 17:46, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> As the sequencer executes todo commands it appends them to
>> .git/rebase-merge/done. This file is used by "git status" to show the
>> recently executed commands. Unfortunately when a command is rescheduled
>> the command preceding it is erroneously appended to the "done" file.
>> This means that when rebase stops after rescheduling "pick B" the "done"
>> file contains
>>
>> 	pick A
>> 	pick B
>> 	pick A
>>
>> instead of
>>
>> 	pick A
>> 	pick B
> 
> Here it may not be clear what you meant with the verb "reschedule"
> to those who weren't closely following the previous discussion that
> led to this fix.
> 
> Is it the same as "the command attempted to execute a step, couldn't
> complete it (e.g. due to conflicts), and gave control to the end
> user until they say 'git rebase --continue'"?  What cases, other
> than interrupted step due to conflicts, involve "rescheduling"?

I'll expand the commit message to explain that if we cannot pick a 
commit because it would overwrite untracked files then we add the 
command back into the todo list and give control to the user until they 
say 'git rebase --continue'. Hopefully they'll have removed the 
problematic files and we try to pick the commit again it will succeed. 
We do the same if an exec command fails and --reschedule-failed-exec was 
given. For conflicts we don't add the command back into the todo list 
because the cherry-pick has happened the user "just" needs to fix the 
conflicts before continuing to the next command.

>> Note that the rescheduled command will still be appended to the "done"
>> file again when it is successfully executed. Arguably it would be better
>> not to do that but fixing it would be more involved.
> 
> And without quite understanding what "reschedule" refers to, it is
> unclear why it is even arguable---it is perfectly sensible that a
> command that is rescheduled (hence not yet done) would not be sent
> to 'done'.  If a command that was once rescheduled (hence it wasn't
> finished initially) gets finished now, shouldn't it be sent to
> 'done'?  It is unclear why is it better not to.

The command is only successfully executed once but may end up in 'done' 
multiple times. While that means we can see which commands ended up 
being rescheduled I'm not sure it is very useful and think really we're 
just cluttering the 'done' file with failed attempts.

>> -static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>> +static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
>> +		     int reschedule)
>>   {
> 
> OK, all callers to save_todo() are in pick_commits() that knows what
> the value of "reschedule" is, and it is passed down to this helper ...
> 
>> @@ -3389,7 +3390,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>>   	 * rebase -i writes "git-rebase-todo" without the currently executing
>>   	 * command, appending it to "done" instead.
>>   	 */
>> -	if (is_rebase_i(opts))
>> +	if (is_rebase_i(opts) && !reschedule)
>>   		next++;
>>   
>>   	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
>> @@ -3402,7 +3403,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>>   	if (commit_lock_file(&todo_lock) < 0)
>>   		return error(_("failed to finalize '%s'"), todo_path);
>>   
>> -	if (is_rebase_i(opts) && next > 0) {
>> +	if (is_rebase_i(opts) && !reschedule && next > 0) {
>>   		const char *done = rebase_path_done();
>>   		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
>>   		int ret = 0;
> 
> ... and the change here is quite straight-forward.  With reschedule,
> we do not advance because by definition we haven't finished the
> step yet.  OK.
> 
>> @@ -4648,7 +4649,7 @@ static int pick_commits(struct repository *r,
>>   		const char *arg = todo_item_get_arg(todo_list, item);
>>   		int check_todo = 0;
>>   
>> -		if (save_todo(todo_list, opts))
>> +		if (save_todo(todo_list, opts, 0))
>>   			return -1;
> 
> I wonder why we pass a hardcoded 0 here---shouldn't the value match
> the local variable 'reschedule'? here?
> 
> The same question for the other two callers, but I admit that when
> the second one is called, the local variable "reschedule" is not
> set...

The rescheduling code is a bit of a mess as rescheduling commands that 
pick a commit does not use the "reschedule" variable and is handled 
separately to other commands like "reset", "merge" and "exec" which do 
use the "reschedule" varibale. I did try and add a preparatory step to 
fix that but failed to find a good way of doing so. The reason I went 
with hardcoded parameters is that for each call the purpose is fixed and 
as you noticed the "reschedule" variable is only used for rescheduling 
"reset", "merge" and "exec". I could expand the commit message or do you 
think a couple of code comments be more helpful?

Best Wishes

Phillip

>>   		if (is_rebase_i(opts)) {
>>   			if (item->command != TODO_COMMENT) {
>> @@ -4695,8 +4696,7 @@ static int pick_commits(struct repository *r,
>>   							    todo_list->current),
>>   				       get_item_line(todo_list,
>>   						     todo_list->current));
>> -				todo_list->current--;
>> -				if (save_todo(todo_list, opts))
>> +				if (save_todo(todo_list, opts, 1))
>>   					return -1;
> 
> ... yet we call the helper with reschedule set to 1.  Puzzled.
> 
>> @@ -4788,8 +4788,7 @@ static int pick_commits(struct repository *r,
>>   			       get_item_line_length(todo_list,
>>   						    todo_list->current),
>>   			       get_item_line(todo_list, todo_list->current));
>> -			todo_list->current--;
>> -			if (save_todo(todo_list, opts))
>> +			if (save_todo(todo_list, opts, 1))
>>   				return -1;
> 
> At this point, reschedule is set and passing it instead of 1 would
> be OK.
> 
> Thanks.
