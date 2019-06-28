Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFBA1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 13:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1NoM (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 09:44:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF1NoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 09:44:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so9031163wme.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SS+yOIcneAKpeIgVHz3Enug0sdf8o5P9DFP0wv57jfs=;
        b=OdA6T2/YRTZvQ+4PTrqLtdfdUTsAg1CCRjEK5CrF93QuippBxp+6fkwwUUFsK8/gtz
         L2X6D8921wKigoowT6XdYz1EixWRdOGjxJ24oQrnknU5odHTaALheT/krirFuP08tRdF
         xNi6OvLokl/1rnxvEXCPPLcBLu1vDmStvCY3v40O2uh0al+2aiShUlvgFi0WxfbOBzIX
         VktPb6s5JLUlJtTLT+A7kLZC2pvlGIO/yobIUxlS8TGSHgkbwEsARvTawwaADUXcAYMQ
         vnIaUXDbl+WucbKSa8OqThqUM/fvQE5L6sxCrOsSuKItFQJbo39VOKyixYFGVPru8mVy
         c0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SS+yOIcneAKpeIgVHz3Enug0sdf8o5P9DFP0wv57jfs=;
        b=dAfo2fUer7zXWV5eYY4h++x++kkDLgEi0gTrSjvomXW6mcJGU7imbSrPtxJboTaoYa
         8n+RV09PTFOjuDLbvk/RV2+LQK9k8fwE2rHrLzl4o9iBRuMIYpb0nPCQPvo1M0HHddTW
         d8vytj56e9vK844pccdLyaJ1xoptNDRQoqr1AuUNc7mLYglvZdRfrMyGXhp9iHrOsjii
         8kG9/+m3uRIhq0HC6OGpH2voALGlPWdcA8aaoG2JY4IajmSJwUfoMslho0l4NX1tv9O1
         H31k2YF8islaxSL/rOVCOnhrJSQOuECdV1lmnR3X3i90WdvDi7evzTgF3BHdCYVzJQkA
         Wjjg==
X-Gm-Message-State: APjAAAUj+1CDMYT/ctAldWrKVWSiHH1tAbDRr29KlX/GOsiAgTFM5eB3
        iAFbqYo3juT5zYH7pi3RaBE=
X-Google-Smtp-Source: APXvYqyEfp4UMkhZkGWToNMogQZoMoBVwtz0TgvV1/co8E7J3qvzp60mVVYh2CvVD+L/4NL/iIrRAg==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr5857358wmi.79.1561729449506;
        Fri, 28 Jun 2019 06:44:09 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id s188sm2286646wmf.40.2019.06.28.06.44.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 06:44:08 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect
 interactive rebases
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>
References: <pull.253.git.gitgitgadget@gmail.com>
 <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
 <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
Date:   Fri, 28 Jun 2019 14:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Dscho

On 28/06/2019 12:49, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Thu, 27 Jun 2019, Junio C Hamano wrote:
> 
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>>
>>> -	if (options.reschedule_failed_exec && !is_interactive(&options))
>>> +	if (reschedule_failed_exec > 0 && !is_interactive(&options))
>>
>> OK, it used to be that we got affected by what came from "options",
>> which was read from the configuration.  Now we only pay attention to
>> the command line, which makes sense.
>>
>> At this point, we have already examined '-x' and called
>> imply_interative(), so this should trigger for '-x' (without '-i'),
>> right?
> 
> Yes, at this point we have done all the parsing and automatic implying,
> and check for incompatible options.
> 
>>>   		die(_("--reschedule-failed-exec requires an interactive rebase"));
>>
>> I wonder if users understand that '-x' is "an interctive rebase".
>> The documentation can read both ways, and one of these may want to
>> be clarified.
>>
>> 	-x <cmd>, --exec <cmd>
>> 	...
>> 	This uses the --interactive machinery internally, but it can
>> 	be run without an explicit --interactive.
>>
>> Is it saying that use of interactive machinery is an impelementation
>> detail the users should not concern themselves (in which case, the
>> message given to "die()" above is misleading---not a new problem
>> with this patch, though)?  Is it saying "-x" makes it plenty clear
>> that the user wants interactive behaviour, so the users do not need
>> to spell out --interactive in order to ask for it (in which case,
>> "die()" message is fine, but "... internally, but ..." is
>> misleading)?
> 
> Hmm. What would you think about:
> 
>    		die(_("--reschedule-failed-exec requires --exec or --interactive"));
> 

I was wondering about requiring --exec with --reschedule-failed-exec 
rather than checking is_interactive() as that would be easier to 
understand. One potential problem is if someone has an alias that always 
sets --reschedule-failed-exec but does not always add --exec to the 
command line. We could just emit a warning along the lines of "ignoring 
--reschedule-failed-exec without --exec". I'm not sure that we really 
need to error out, unless we think that the missing --exec is an 
indication that the user forgot --exec and so would not want the rebase 
to start, in which case just dying on --reschedule-failed-exec without 
--exec would be fine.

Best Wishes

Phillip

> 
> It is still not _complete_, but at least it should be a ton less
> confusing.
> 
>>> +	if (reschedule_failed_exec >= 0)
>>> +		options.reschedule_failed_exec = reschedule_failed_exec;
>>
>> OK, here we recover the bit that is only stored in a local variable
>> and pass it into cmd_rebase__interactive() machinery via the options
>> structure, which lets the codepath after this point oblivious to
>> this change, which is good ;-).
>>
>>>   	if (options.git_am_opts.argc) {
>>>   		/* all am options except -q are compatible only with --am */
>>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>>> index bdaa511bb0..4eff14dae5 100755
>>> --- a/t/t3418-rebase-continue.sh
>>> +++ b/t/t3418-rebase-continue.sh
>>> @@ -265,4 +265,12 @@ test_expect_success '--reschedule-failed-exec' '
>>>   	test_i18ngrep "has been rescheduled" err
>>>   '
>>>
>>> +test_expect_success 'rebase.reschedulefailedexec only affects `rebase -i`' '
>>> +	test_config rebase.reschedulefailedexec true &&
>>> +	test_must_fail git rebase -x false HEAD^ &&
>>
>> These three lines gives us a concise summary of this patch ;-)
>>
>>   - The test title can serve as a starting point for a much better
>>     patch title.
>>
>>   - We trigger for '-x' without requiring '-i'.
> 
> I changed the oneline to
> 
> 	rebase --am: ignore rebase.reschedulefailedexec
> 
> This gives credit to the implementation details, as appropriate for commit
> messages, and the error message still tries to be as helpful as possible
> for users (who do not necessarily need to know that there are two
> backends).
> 
> At this point, I am _really_ glad that we only have two backends left (for
> all practical purposes, I don't count --preserve-merges).
> 
> Ciao,
> Dscho
> 
>>> +	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
>>> +	git rebase --abort &&
>>> +	git rebase HEAD^
>>> +'
>>> +
>>>   test_done
>>
