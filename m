Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B60C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 09:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKGJqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiKGJqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 04:46:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E41403E
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 01:46:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1368696wmi.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfKaTg0Hp2gvalWcA+ovKJZ9RwAaE0m2Rt+MrOxXO8A=;
        b=OPPZowxymRAPHDqhwCBXmEYi6JQCKW9XoJCevm3GQQNNqtMEGtROJEHruOa6XwiMDa
         64fY8CJjimSs5fLCF/WLyw0sKJjyLDG9xYVMdK/5/2lJ+5+NjMGKCN/PZZxOMK87r0Id
         egHTHzo6y0yM5XpZ1sLem4xilcfkgZgbolv+MLJZplMUJVBNmEWTRzKcizGDSW/IKaQx
         hLc3sDftMvZfG9I3stCfb8GXqBpfOoqQbXJ0ZkQRi0ZDYZwt2pjQkZ7ru04BazpTAWU8
         m5cFJrTUGjeJYYq3OvVNXsiy/lqp3T+WwohOmf1m6ngC72zqk51YHOMCIjl9gSYsqMmZ
         51PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfKaTg0Hp2gvalWcA+ovKJZ9RwAaE0m2Rt+MrOxXO8A=;
        b=q4mx2XcE12S1uLJL1uDwRTcEjH79DBpljJbBQ9cdHLh2IisKjSQRAz0dpuXptp9PIJ
         uulsMZZ81/mEpbbdnuIHlH6r2OgaKyyyx4+Sm9Y66beNin1y/KFNuoiL8lqz+ZeUyYEy
         rKFS1OK9BJJWONwd5S0zxARuluB6t0nqHJpWL/aHaiiPuhUH0gk5WdzS8XVOwktp7rc2
         BlLie+eVNM/0paitBWwT2dOXMBQpqXZqWNRSA3HOur5luBYVwrVPbjoEaI7vsCNznm8g
         /YHj6sznZDuhbPyBvTNwRHAh1FTBmXwfbAKT/4czheifT6pSpnNlvxlNUsjm2fDX36SQ
         E9/A==
X-Gm-Message-State: ANoB5plUpdhlFt622SKLDqh7xXNJoO9xBRApHZ8+hIYjrrDZuhNXx8k3
        IaL/lGYzH22mRhZQxfm0uug=
X-Google-Smtp-Source: AA0mqf6WC36FtgL3uA8BbDiJClI5kCJbf23f6PcAtLwtLxAcmcE1xk4pFfM+D6F9Pbb5rP6Iwpwpjg==
X-Received: by 2002:a05:600c:91d:b0:3cf:a8a5:639c with SMTP id m29-20020a05600c091d00b003cfa8a5639cmr4022958wmp.119.1667814376738;
        Mon, 07 Nov 2022 01:46:16 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003a1980d55c4sm11512026wmo.47.2022.11.07.01.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:46:16 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <ce3c6afa-2f82-d7f6-8919-e3e8912a7555@dunelm.org.uk>
Date:   Mon, 7 Nov 2022 09:46:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/17] leak fixes: use existing constructors & other
 trivia
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <8eec228d-d392-523d-2415-149b946f642e@dunelm.org.uk>
 <221105.865yfty38w.gmgdl@evledraar.gmail.com>
In-Reply-To: <221105.865yfty38w.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11/2022 12:46, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 04 2022, Phillip Wood wrote:
> 
>> On 03/11/2022 17:05, Ævar Arnfjörð Bjarmason wrote:
>>> With the very minor exceptions of:
>>> * 03-04/17 (which need trivial oilerplate)
>>> * 05/17 (need to add trivial control flow to a free_*() function)
>>> * 12/17 (narrowing scope of allocation)
>>
>> I've only looked at the rebase related patches. I'd really appreciate
>> it if you could drop patches 12 & 14 as they conflict with [1] that
>> fixes these issues by removing the setenv() calls.
> 
> Sure, sounds good to me.

Thanks

> I see Taylor queued it up like that, and the combination of the two
> passes with the "true" and "check" mode leak checking modes.

That's great

Best Wishes

Phillip


> For context: I saw that you planned to fix those in some follow-up
> topic, but had this mostly ready before the new leak in the recent topic
> showed up, and that leak had big knock-on effects in what test files I
> could mark as passing.
> 
> So I figured I'd include some more more narrow fixes, but I'm even
> happier to see the root cause addressed.
