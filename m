Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9AC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 19:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiF1Thy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiF1Th0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 15:37:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6211387A1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 12:30:05 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z191so13873709iof.6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kII/8PP7+1I0MQoUOT2vyah4wcx8z4WpDPgaBCAeUag=;
        b=DVkjwBZIxMp0HDvCE5nToLd3KLL9OipSRgBLl36YmH00n4CygQcgzaH+fmT9NXMX3T
         +tbFvSGPcwVrbX5UzsuzsA1T2Luwf6Gdri9AQKVxNNoAj+STZKzlsWVL/uXPFzvw6se1
         7r/ZvUdls8tRVh+c5oPS1U06quiPu/FXOj3nFJ03A/m9bSdbnQ8jGmo8S6LB1kZPDN1c
         YQevbwZwFX4OsLfTjQGNNzTwL03OnqqnU76cAgBNuBRRuhBznqrV+hdH9dcv59sMttVx
         a8OzyRrgC+4QiFZwZq7QdzShV7tS2Ql+esq12leM9m9Z2yUvlpGGl3Qbk1L+S2fwlISi
         Y22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kII/8PP7+1I0MQoUOT2vyah4wcx8z4WpDPgaBCAeUag=;
        b=lLvrag/iF6/kW3NmcfEx0c5kme/qccX9c5UH7nFuRyo4Lgq6wtDSuIl4R7/yEqLIaC
         +ixJ/FeWVq1bVv2BYBljEicptb4zUO+B0arkbthCYWCVIXQnERTT8YYF+JHIzM6We6D0
         /bSunzkf6dSWuoHLsGGeRU0LIJI6iDdLSdigP9bT3teM7CmacLOGI+gd4MzllQgXSZ4r
         DVOglRtk5tpLn1ogVcC7RsAzz2MKlXJ+bbotS41i27/ILD1jyxGXQl0BrtBnsFgCrOcl
         h1q0N1uv9odfi4mKaeQnEMw/nRWHoky9JbNvhtkwOAXQN4POYQwFar2K+zDUk2/UW7zQ
         XX/w==
X-Gm-Message-State: AJIora9iPIQ4vV8Ruu7qM5VYdoQLIpT3QO9kEkvzgcpbJ0lr/P6LYd7t
        KD/L/cjd3KG7ttorWJ+/zTBoOsCcOEM4
X-Google-Smtp-Source: AGRyM1tw6RrJnCfZgN4pOfHELyqcJ+4qKD5rrSDTtkBhr00QJRmhZ7HmkFPczckS0HiBUyCKgtnyIg==
X-Received: by 2002:a02:90ce:0:b0:32e:e2ce:b17c with SMTP id c14-20020a0290ce000000b0032ee2ceb17cmr12490607jag.268.1656444585009;
        Tue, 28 Jun 2022 12:29:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e803:5ac5:fad4:b3b2? ([2600:1700:e72:80a0:e803:5ac5:fad4:b3b2])
        by smtp.gmail.com with ESMTPSA id bo22-20020a056638439600b0033c8edf022bsm3534215jab.144.2022.06.28.12.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 12:29:44 -0700 (PDT)
Message-ID: <0a640845-8207-f8fd-a9df-2fc6d91aabfd@github.com>
Date:   Tue, 28 Jun 2022 15:29:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] git-rebase.txt: use back-ticks consistently
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, Johannes.Schindelin@gmx.de
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <a821c10b-3b55-f20a-dc4c-c5b0452d7819@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a821c10b-3b55-f20a-dc4c-c5b0452d7819@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2022 5:59 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 27/06/2022 22:21, Derrick Stolee via GitGitGadget wrote:

> Thanks for doing this, I think it's fine as a single patch as all the changes are focussed making the quoting more consistent in a single file - splitting it up would be more work for you and would not really make it any easier for reviewers. I've left a few comments but it is a vast improvement as is.

Thanks for taking such a close look!
 
>> -The current branch is reset to <upstream>, or <newbase> if the
>> ---onto option was supplied.  This has the exact same effect as
>> -`git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
>> +The current branch is reset to `<upstream>`, or `<newbase>` if the
>> +`--onto` option was supplied.  This has the exact same effect as
>> +`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
> 
> Unrelated to your change but I think we could lose the comma on this line if you do re-roll.

Noted. Thanks.

>>   Note that a rebase merge works by replaying each commit from the working
>> -branch on top of the <upstream> branch.  Because of this, when a merge
>> +branch on top of the `<upstream>` branch.  Because of this, when a merge
>>   conflict happens, the side reported as 'ours' is the so-far rebased
>> -series, starting with <upstream>, and 'theirs' is the working branch.  In
>> -other words, the sides are swapped.
>> +series, starting with `<upstream>`, and 'theirs' is the working branch.
>> +In other words, the sides are swapped.
> 
> Here when talking about "ours" and "theirs" as the parents of a merge we use single quotes ...

Good point...

>> -Because 'git rebase' replays each commit from the working branch
>> -on top of the <upstream> branch using the given strategy, using
>> -the 'ours' strategy simply empties all patches from the <branch>,
>> +Because `git rebase` replays each commit from the working branch
>> +on top of the `<upstream>` branch using the given strategy, using
>> +the `ours` strategy simply empties all patches from the `<branch>`,
> 
> Here "ours" is an option argument so I think the backquotes make sense

I agree.

>> @@ -371,8 +371,8 @@ See also INCOMPATIBLE OPTIONS below.
>>   --strategy-option=<strategy-option>::
>>       Pass the <strategy-option> through to the merge strategy.
>>       This implies `--merge` and, if no strategy has been
>> -    specified, `-s ort`.  Note the reversal of 'ours' and
>> -    'theirs' as noted above for the `-m` option.
>> +    specified, `-s ort`.  Note the reversal of `ours` and
>> +    `theirs` as noted above for the `-m` option.
> 
> Here "ours" and "theirs" are options so using backquotes is probably the right thing to do, but the text is referring to the section where they are not backquoted which confused me initially.

I think your confusion makes sense. Here, we are talking about "sides"
of a merge and not a strategy. I'll fix this in v2.

>> -apply backend: When applying a patch, ignore changes in whitespace in
>> +'apply backend:' When applying a patch, ignore changes in whitespace in
> 
> I'm not sure if we want to say
>     'apply backend:'
> or
>     'apply' backend:
>>     -x <cmd>::
>>   --exec <cmd>::
>> -    Append "exec <cmd>" after each line creating a commit in the
>> -    final history. <cmd> will be interpreted as one or more shell
>> +    Append `exec <cmd>` after each line creating a commit in the
> 
> Lower down when talking about other todo list commands we refer to them as "pick" (with double quotes) so I wonder if we should use "exec `<cmd>`" here as it is only <cmd> that comes from the command line argument

Junio has some ideas about making this a bulletted list more clearly,
so I'll try that and see what happens.

>> -git rebase has two primary backends: apply and merge.  (The apply
>> -backend used to be known as the 'am' backend, but the name led to
>> -confusion as it looks like a verb instead of a noun.  Also, the merge
>> +`git rebase` has two primary backends: `apply` and `merge`.  (The `apply`
>> +backend used to be known as the `am` backend, but the name led to
>> +confusion as it looks like a verb instead of a noun.  Also, the `merge`
> 
> I think using single quotes for the backend names might make more sense as they are just names.

I was thinking of them similar to the merge strategies, but you're right
that these are not used as CLI input (just something implied by --merge
or --apply). I'll remove the ticks from around these uses.

>> -When the git-rebase command is run, it will first execute a "pre-rebase"
>> +When the `git rebase` command is run, it will first execute a "pre-rebase"
> 
> This is the section I was referring to earlier when talking about quoting hook names.

Excellent. Will fix.

Thanks,
-Stolee
