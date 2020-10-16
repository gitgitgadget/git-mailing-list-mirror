Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B7C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AC220848
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpH/ev6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408011AbgJPN0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407657AbgJPN0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 09:26:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF6C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:26:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h7so2943691wre.4
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0yxOV5K+FrfIo+ZKdFfrxe5T0Xlu01PQ1l0zQmtzfjI=;
        b=bpH/ev6Dyz61/AsZgLvKXwVits/78pk8bNYpbqVgBiRVc6bLNEiGQzYjQzWZsHk9OZ
         /zHCh6iF7Tjnpdni8BBloNeQC68lU7nJIwRVZjedURvC+wIglErWlFkhx0gd9+YNDmDk
         Y3hkna/xjqGPyL29Pop2xqVrmhy2dnbNNvMX+T8T8ceJesmhMbnmmdMWgAhdZCEt75FL
         Z1HLnYlEKNFeUeTRG1W56N4YERhm1+dwRUBuFZHB0XluD/yRXY1qcXPUrwQtmDPxmBG4
         sYHsn4BYaOa6YZKH0Zick2yreYv4lla+BK4LnFmCDh0c1s+SceezaLn/6ee9HedF97O2
         8/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yxOV5K+FrfIo+ZKdFfrxe5T0Xlu01PQ1l0zQmtzfjI=;
        b=GyeXmHce/Xk7741CvDjd4TgqBo9Om+3+A9WkA0mqVHohCY9BQj2CGFa4AIYZ2M6QpQ
         y9taBfDvnTFn+uGrDT6YetgX5wlshUcqLB8EQWzjHPVJIvak6Er6bZAdD88slDP856BI
         l+L+c65Narptxy56g7gzGxGXCwITOPjAodZStF7iSlx4qf91CXsngJkSGO4kLIyX3PiE
         RqlaOqX95RUp9pLUtbcC0byCVQUbv94xGTT0wKAcORwvnZ5j7gbpwqEpDziWzDHkF20M
         Y+CnazBl6oEfs9OtPHagnc5Y4DN5DyGh8gK5hzY0sLJjmGfTYf1vAikp2DO9Yifslf4v
         SVCA==
X-Gm-Message-State: AOAM531Se++IiuF5LOdukTyAZeL5eC/DvHW6ZK1qeDPO3OCUkXid9Ixp
        lPAnSLOsOeeJEQB9yxNYbSpROFMTYFM=
X-Google-Smtp-Source: ABdhPJxwQTJ60QrEZQXGGiTx32bb/qgrbN0ceMPHoQmzICe+FYGw+j4ufPm6pfQz6xTUJRVss0FX3g==
X-Received: by 2002:adf:f101:: with SMTP id r1mr4282095wro.392.1602854772977;
        Fri, 16 Oct 2020 06:26:12 -0700 (PDT)
Received: from [192.168.1.201] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.googlemail.com with ESMTPSA id o63sm2847052wmo.2.2020.10.16.06.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:26:12 -0700 (PDT)
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, kaartic.sivaraam@gmail.com,
        git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com>
 <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
 <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
 <95c90e7a-8f4c-32b9-2b0e-9efce2acfb8e@gmail.com>
 <CAHjREB6i7ZSSXk10OAOXcL-Av3WzesCkMKL2ES_aBRsrynT9DA@mail.gmail.com>
 <8c9b409b-4e44-ca8a-9075-36a7332f9765@gmail.com>
 <CAHjREB44_bjPF86fF3EToD6mVqeLbmtzsN8NPYu1QLes7kpwHg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <05edf120-03fe-9b45-e39c-0d53a517d637@gmail.com>
Date:   Fri, 16 Oct 2020 14:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB44_bjPF86fF3EToD6mVqeLbmtzsN8NPYu1QLes7kpwHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 16/10/2020 06:27, Sangeeta NB wrote:
> Hey everyone,
> 
> On Thu, Oct 15, 2020 at 8:15 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> diff --git a/submodule.c b/submodule.c
>> index 8f6227c993..c4182be633 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1679,6 +1679,8 @@ unsigned is_submodule_modified(const char *path,
>> int ignore_untracked)
>>           strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>>           if (ignore_untracked)
>>                   strvec_push(&cp.args, "-uno");
>> +       else
>> +               strvec_push (&cp.args, "--ignore-submodules=none");
>>
>>           prepare_submodule_repo_env(&cp.env_array);
>>           cp.git_cmd = 1;
>>
>> fixes it, I'm unsure at the moment if we should be adding the extra flag
>> here or setting the appropriate option in status when -uno and
>> --ignore-submodules=<option> are both omitted though
> 
> Ya, that does work and the PR passed all the tests after this correction.
> I have submitted the patch[1] for it and would be glad to have reviews
> on it from the git community.
> 
> [1] https://public-inbox.org/git/pull.751.git.1602781723670.gitgitgadget@gmail.com/T/#u

I'll try and have a proper read through at the beginning of next week. 
Hopefully others who use submodules more regularly will be have time to 
comment as well

>>
>> Have you setup a config.mak file? Mine looks like
>>
>> DEVELOPER = 1
>> SANITIZE = address,leak
>> CFLAGS += -ggdb3
>> CFLAGS += -fvar-tracking-assignments
>> CFLAGS += -fno-omit-frame-pointer
>>
>> Which will build git with warnings enabled, debugging information and
>> enables the address sanitizer. Then you can run the git you have built
>> under gdb with
>>
>>          GIT_DEBUGGER=1 bin-wrappers/git
>>
>> If you want to debug a particular test then I find adding `test_pause`
>> to the test and then running
>>
>>          GIT_DEBUGGER=1 git
>>
>> in the shell that the test opens (it sets up the path appropriately).
>> You may want to add LSAN_OPTIONS=detect_leaks=0 to the commands above or
>> set up a suppressions file
>>
>> I also use printf quite a bit but it does tend to break other tests
>> which can be awkward.
>>
> 
> No, not yet. I would set it up. Thanks again!
> 
> As my next step, I was looking for some #good-first-issue to work on
> where I found an issue[2]. Has someone already worked on it? If not, I
> would love to work on this.
> Or if you have anything else in mind that I could work on please do
> suggest to me.

I'm not sure if someone else has worked on that - there has been some 
work to convert more of bisect to C recently [1]. It should be easy 
enough to test if bisect works from a subdirectory or not. I don't have 
anything else in mind - my advice would be to pick things that interest you

[1] https://lore.kernel.org/git/20201015133838.85524-1-mirucam@gmail.com

Best Wishes

Phillip

> [2] https://github.com/gitgitgadget/git/issues/486[3]
> 
> Thanks and Regards,
> Sangeeta
> 

