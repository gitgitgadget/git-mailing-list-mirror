Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD457C432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9976E61101
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbhHSKIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbhHSKIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 06:08:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8DC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:07:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso3698633wms.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iO6yNujRnh3JbcMvtOhqo4JueXfP1rRYgG/26IrNoWc=;
        b=H+76mxwxU9lP0gfZkmb3B7Uc5foVAZJmBgu2WWvBvmNIDd0o05pCo1mOYpne4Zovs7
         WaYx/J/5Tw2hrK58ErfkB7vlPL2j79gOjYfREFRuqu1dwea53hqvZ2g7MZ2qneSceaQm
         V9mGiMHBz+fWkUWhgBTjD+M9cZIkrNp4OpUiKvbPizlJigrxnBUhZrpfMgYGWfxZd2nR
         pQYkhBBukxrZhBdU3tXIm0scsdns6tYMKVLPonhXDk4tII9PTlpULaoaVjjhe5luGOiP
         E3WWkac3dceVmEYQLry7r2Ojqg3MY7FBIPXfW6bVroUqoUeASo5icwof/BIe8qsYvH63
         1Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iO6yNujRnh3JbcMvtOhqo4JueXfP1rRYgG/26IrNoWc=;
        b=louWHUaOQz/4JS+R5YnkokJMjSDByPMSKxf3CknOGWDxVyiL4+2udT0QAk3KtM9kbM
         WKwZwFN0s1zrEO/C+oC6i3kf+1gz7ARY2nA29KvxFIEF2TphecrIz1swXwCGOEorqU9V
         H46AdQagql48tG2HhbSFG42IXqqVDaSRMNFs58Y06KYLjQ6hQkikotP1RwDu04po97s0
         V81yC6qn558mlfSgz3sPZM5sxnTZ7d4xqFh/G1skxWp3LTtGyyYUaFhmiLnpDhVnom//
         n//sRnG/TcZrGBEEB+3awUXirysQkXao9JFipCG08Fy1KhM1yVqlCf+TtgongdRT9W7b
         ksIw==
X-Gm-Message-State: AOAM533ejFTtadLrJDvBt5Mp3R9dERFiSWUOGxCh/C8kN6cx/AQGMv1W
        Ce6vjm7UiWZ1CS+UW93KnIw=
X-Google-Smtp-Source: ABdhPJx7CEHcBWSscBvU6TS1rnMItZOpRO0oH3GcwwIUKbFpsgazRDPoq5dgeVFs/SNk5+dlJQtoEw==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr12764584wmj.72.1629367674089;
        Thu, 19 Aug 2021 03:07:54 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id k1sm2538483wrz.61.2021.08.19.03.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:07:53 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] rebase -r: some merge related fixes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108150042250.59@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a6454b5f-dbf5-56e4-eb91-1db876914a78@gmail.com>
Date:   Thu, 19 Aug 2021 11:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2108150042250.59@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 14/08/2021 23:43, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 13 Aug 2021, Phillip Wood via GitGitGadget wrote:
> 
>> This is a collection of merge related fixes for rebase -r
>>
>>   * Make merge -c behave like reword.
>>   * When fast-forwarding a merge don't leave .git/MERGE_MSG around (reported
>>     by Gábor)
>>   * Make merge -c work when with --strategy
>>
>> Phillip Wood (4):
>>    rebase -r: make 'merge -c' behave like reword
>>    rebase -i: Add another reword test
>>    rebase -r: don't write .git/MERGE_MSG when fast-forwarding
>>    rebase -r: fix merge -c with a merge strategy
> 
> I reviewed all four patches (the first one took the most time, obviously)
> and it was quite the pleasant read. I am in favor of integrating them
> as-are.

Thanks for reviewing them

Best Wishes

Phillip

> Thank you,
> Dscho
> 
>>
>>   sequencer.c                   | 106 ++++++++++++++++++----------------
>>   t/lib-rebase.sh               |  56 ++++++++++++++++++
>>   t/t3404-rebase-interactive.sh |  13 +++++
>>   t/t3430-rebase-merges.sh      |  38 +++++++++---
>>   4 files changed, 155 insertions(+), 58 deletions(-)
>>
>>
>> base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1015%2Fphillipwood%2Fwip%2Fsequencer-merge-c-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1015/phillipwood/wip/sequencer-merge-c-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1015
>> --
>> gitgitgadget
>>

