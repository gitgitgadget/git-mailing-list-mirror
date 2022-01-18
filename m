Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72AC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 19:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiARTn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348895AbiARTnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 14:43:21 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE19C06161C
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 11:43:21 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id g205so526527oif.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aFTU5ZsklJYMUJdLlJuooFgnxo1V0qsZMbPDV/3m/ws=;
        b=EqzWjVz5t+o3+p14cjz50OkzB1Q/GpWfPvuE0OF4EPd22gJMtnfqRoJWnAABaXJiCJ
         y8AlqyUrC1DVzXRHUj4LZwlcskdMH8WELYErJgAtCtgyi9WzsrVBd0lqGJZS04uekvVQ
         Av33i+aQ9C8mIiB5gRXPMBRT/4Lk/jPfotfvH8AYOp1ajEWJcSQvZpCc36/deKY9dBNk
         MonGEI518+O0g6wH0zONfRlJ6sanGPuLnozlZxdwx+sADBaM0ylRchyqAflf85ZE76Ou
         jd25ggnDnbjcGUteq/QlU4XxSq7Jh9616Eiy+gOaMOOS3+zoOqAGJRol1AVo9pccRENl
         G2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aFTU5ZsklJYMUJdLlJuooFgnxo1V0qsZMbPDV/3m/ws=;
        b=tNmWkxeTGftxa6SfCrgKAcgpHqYl28gPl8imqM6sY1LMi85vFS/peIabsJLj9nOTpL
         h8iSSL9xiNLkDDWCtqRg2UK54nf6k9tU+P/hoghxvmFWs5FzrU00ioXWVU9c2+2UAhSd
         hhDSP7PtBcSq454V12XqN8jjqbHeJ0wx932qU2nkIjof5PLNVRFS3xdLrZG1J03JufNt
         rqruZxqDjzJIjUhFmttZA+SK0ZzfqXAVgE5LKvbsugIdkntmtkR6vEDUb4d1N/J+kkue
         Dy6F9f4BNHiWITyPIfootnMTHY698qj1gGhCNT57jOsYJ4bnBXam/mBfiL5TEnxuubNh
         zlJQ==
X-Gm-Message-State: AOAM532ROAPfyp4JO/wS8WKJ7cd12ngkrOai5HGM7bGq9yciLeSvFdh7
        e1Oowo8pUO7n072PKiRd7yg=
X-Google-Smtp-Source: ABdhPJz0uX1P02BFR0yV4aEL4Bjn7RkOdaw56ADUR8VotFifG8o4BA5M5A5UhYPiJGlnECQtQO3Rkg==
X-Received: by 2002:a05:6808:1292:: with SMTP id a18mr76772oiw.29.1642535000444;
        Tue, 18 Jan 2022 11:43:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:113f:db67:413a:89ca? ([2600:1700:e72:80a0:113f:db67:413a:89ca])
        by smtp.gmail.com with ESMTPSA id i7sm6777009oot.17.2022.01.18.11.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 11:43:19 -0800 (PST)
Message-ID: <102cc731-99ec-57b0-91de-23d5569fd959@gmail.com>
Date:   Tue, 18 Jan 2022 14:43:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
 <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
 <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
 <220112.86a6g1xgyl.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <220112.86a6g1xgyl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2022 7:42 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Derrick Stolee wrote:
> 
>> On 12/20/2021 11:13 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Mon, Dec 20 2021, Derrick Stolee wrote:
>>>
>>>> On 12/12/2021 3:13 PM, Ævar Arnfjörð Bjarmason wrote:
>>>>> But we've also grown a hard dependency on this directory within git
>>>>> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
>>>>> subcommand, 2019-11-21) released with v2.25.0 the "git
>>>>> sparse-checkout" command has wanted to add exclusions to
>>>>> "info/sparse-checkout". It didn't check or create the leading
>>>>> directory, so if it's omitted the command will die.
>>>>
>>>>> Even if that behavior were fixed we'd be left with older versions of
>>>>> "git" dying if that was attempted if they used a repository
>>>>> initialized without a template.
>>>>
>>>> This, I don't understand. Why can't we add a
>>>> safe_create_leading_directories() to any place where we try to
>>>> create a sparse-checkout file?
>>>>
>>>> This would fix situations where older versions were init'd with a
>>>> different template or if the user deleted the info dir. The change
>>>> you've made here doesn't fix those cases, which is what you are
>>>> claiming is the reason to not do the other fix that seems like it
>>>> would.
>>>>
>>>> What am I misunderstanding here?
>>>
>>> I'll clarify that a bit in any re-roll.
>>>
>>> Pedantically nothing changes, i.e. you can create a repository with an
>>> empty template now, and it'll break on both the sparse-checkout on that
>>> version, and any previous version that had that un-noticed issue.
>>
>> You continue after this with more motivations for adding 'init' 
>> unconditionally, which I am not fighting.
>>
>> What I _am_ saying is important is that if we are trying to write
>> a file to a known location and its parent directory doesn't exist,
>> then we should create it. Not doing so is a bug and should be
>> fixed, no matter how rare such a thing is to occur. As you've
>> shown, it is not required to have an info directory until we need
>> one (e.g. for sparse-checkout or an excludes file).
>>
>> If you're not planning to add that to this series, then I'll add it
>> to my list. I do think it would fit well into this one, though.
> 
> Just so we'll avoid stepping on each other's toes, what's the status of
> your plan/non-plan to work on that more isolated fix, perhaps you have
> one that's unsubmitted?

I do not have one that is unsubmitted. I was hoping that you would
include it in a v2 to this series. I might have been quicker to
volunteer to create one had I not been sidelined for two weeks, but
right now I have a lot to catch up on so don't have the time.

Thanks,
-Stolee
