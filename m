Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBACC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD17611BD
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhIIKKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhIIKKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:10:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91BC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 03:09:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x6so1699795wrv.13
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2pCux6y7D+0zhlKAd464qyaFS5BDjJQC30ok8uIDgc=;
        b=M0CFrqWxhtjiC4bAwEAfwOzWL3oMAXTR9Lq8pbDqQccsCGdieuMBmoK/9riY17T7p3
         vyRO3HcJ3tiqurl7yxz6qujllTSorPJPsJFQruC11Wh6K0hTSSOlSLZuHel6NYuoScAs
         SGzE+Xwc4jhR0cn3ty3fCxdFw0bQ7pK7FkTC8IojWhNtH6pQNbnY1K5fZB8gpqGvlTQd
         vr2V+sXqI8EhWr16mkFQOzs+bBoRF18z13hb6BUxhysojbVO36gneg70VkcIX2IU42Iw
         MKAjS6H4BXHq9Zn9zyNhxY/6EDWS5xvyAO3WkNHKHB3vfNt5p9jhArNBkOHX70f9kuix
         a4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c2pCux6y7D+0zhlKAd464qyaFS5BDjJQC30ok8uIDgc=;
        b=hCNAiWZfK0e+GyyfTp5hDZPNIlx9NScasfbc7/xES1bLl3nWPNDSs2Mfr1ntpazTkd
         vUC97s203dAItjvTrnGP+nR68FZwrKRTWA9qG04k4YfnZaKx+4l3DTq5QZXA1ETUi4xf
         qliIy2ogY0rQtEizDiDhXi+mqq3/6M72NraBEXg9/yITNaQOiuSCAwHPqkr0YlxoxTFj
         Dzs/pGzI74SGeOlpmNVQibXG933LP+5QgcaC6J6Pv10kBhNdgbpZJtizEaBGs9Fy/xxu
         zm0zTPAeYtXqSCB1+t+Aa0RDWM7cpBANABX6i8trIuR6rZ3EEQwkTlQexSeco7cllnuK
         dSdQ==
X-Gm-Message-State: AOAM5327KzJDwQjyjqpm4xuimf6K7JNKi0r2Ebn9d9gl+GrJJpFd1jEb
        UB6Ag/E45S2B+z32wLFm3Wk=
X-Google-Smtp-Source: ABdhPJw+hZwRRVjhCPK7GlFkk5+lUUk/WksLMWtQ52ciXuYm0ul1crPLwcI/JPcQsJEh4snh3T6HOg==
X-Received: by 2002:adf:f84d:: with SMTP id d13mr2584886wrq.292.1631182173650;
        Thu, 09 Sep 2021 03:09:33 -0700 (PDT)
Received: from [192.168.1.201] (187.96.189.80.dyn.plus.net. [80.189.96.187])
        by smtp.googlemail.com with ESMTPSA id l26sm1157525wmi.13.2021.09.09.03.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 03:09:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
Date:   Thu, 9 Sep 2021 11:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe

On 08/09/2021 19:14, Philippe Blain wrote:
> Hi Phillip,
> 
> Le 2021-09-08 à 09:41, Phillip Wood via GitGitGadget a écrit :
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The "apply" based rebase has avoided forking git checkout since
>> ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
>> 2018-08-07). The code that handles the checkout was moved into libgit
>> by b309a97108 ("reset: extract reset_head() from rebase", 2020-04-07)
>> so lets start using it for the "merge" based rebase as well. This
>> opens the way for us to stop calling the post-checkout hook in the
>> future.
>>
> 
> While in general I think it's a good thing to avoid forking, this change
> might result in behavioral differences. Any config that affects
> 'git checkout' but not the internal 'reset.c::reset_head' function might
> play a role in the rebase UX.
> 
> One that immediately came to mind is 'submodule.recurse'. This initial 
> 'onto'
> checkout was pretty much the only part of 'git rebase' that did 
> something useful
> for submodules, so it's kind of sad to see it regress. 

Thanks for pointing that out. As a non-submodule user my question would 
be is it actually useful for the initial checkout to work that way if 
the rest of rebase (and the checkout for the am backend) ignores 
submodules? reset.c::reset_head() just uses unpack trees like checkout 
so if rebase read 'submodule.recurse' then reset_head() would work like 
'git checkout' and also 'git rebase --abort' and the "reset" command in 
the todo list would start checking out submodules. I'm reluctant to do 
that until the merge backend also handles submodules unless there is a 
good reason that such partial submodule support would help submodule users.

[That is, until
> someone
> takes the time to implement 'git rebase --recurse-submodules' and makes 
> sure *all*
> code paths that touch the working tree pay attention to this flag, and 
> that will
> probably necessitate 'git merge --recurse-submodules' first because of 
> the 'merge'
> backend... as far as I'm aware it's on Emily's list [1], it's also on 
> mine but
> I don't know when I'll get the time.]
> 
> Anyway, I'm not saying that we should not do what this patch is 
> proposing, but
> I think caveats such as that should be documented in the commit message, 

Yes I'll update the commit message. It should also mention that this 
fixes the bug reported in [1] where a failing post-checkout hook aborts 
a rebase.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com/

> and maybe
> an audit of other configs that might results in behavioural differences 
> should be done.
> 
> Thanks,
> 
> Philippe.
> 
> [1] 
> https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/t/#m0229af9183a84c2367f21e82adfbd21f08aa4437 
> 

