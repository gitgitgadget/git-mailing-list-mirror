Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B66C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8B6223FB
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrqyvUdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896183AbgJVJwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896175AbgJVJwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 05:52:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC02C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 02:52:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d78so1245947wmd.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0PBqdyemXqv7BHDdoLSatBandI68dWJvIjVL98WVCx4=;
        b=WrqyvUdoaHpLOpYGptPTYwdmy+cAuktKcKHlO5G/gN2Smoq7UCEx/wQrgmpk+kqdZM
         PQV96ORPxgrzev/SZVwWYWkox0XTVpMiESU2IjDeO9FxpwwvQYHfLw8VIZIRsK70xdf+
         tJa4Qs6lwtBOObh8rscFobteXVwqUINk0waVIVmH8NRJcio79cyKnzKDyD+dCooy0Y6h
         quDh35Fo4iu1BQimYE0GNr8pcfxUe17W9JA7aHU0oMfhZjimckRftLxvxqI8+ZMiD2MQ
         +rOXDcgwr5WMdZss5Q3ED3+MY+FANbMY4z8miGruMwPNupWvrEcKF9G9lJhG6UkD9Isk
         zyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0PBqdyemXqv7BHDdoLSatBandI68dWJvIjVL98WVCx4=;
        b=DcNjXFi+JTKw7D1o//2z57mGnTReUmFd2BZ1XcPWH5vhPMCdx3QQmMdk/U2/3zK5JT
         a9lyU6gd8q3DEBFyHXTpeg8J1C1i2u3Nhls5O0j814Wf+oUBtEKUvw3em7VBvomYaX+y
         JEyZ+dwQSZa0a55++MrZJZGI07igoU+xHcxi1JssIs8RfQfhqSzTUc2sIFej3Iquz6oJ
         Bo50o3hMKteRXEslGPPaUipzLbLqxk+wJI87vJv8D0ATtbdpkzA3hJIc9jNsud5NhAF7
         Qu6fGcXdyyNMwwK0UaacNa4EVf4MU2RQWaLgGfH2DmG0lwtbWgr+GEQohgsUGgvjE0SU
         mJNw==
X-Gm-Message-State: AOAM532PCXn6J4rmzLCG21HZUijnbAPP/4TuWmMKxzJXp2LE8wXthb10
        w2yGeRx5MDgRlp/mNR4b2eAyhJ0CJ2Y=
X-Google-Smtp-Source: ABdhPJyp2yrQK8gN6pHz5cPVcITyGE/bqtEn1zfckPAxFf8wu8x4MhQNOZDJBKEQ7wfuYPPfGsj5vA==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr1805942wmi.118.1603360354986;
        Thu, 22 Oct 2020 02:52:34 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id n5sm2625923wrm.2.2020.10.22.02.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 02:52:34 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
 <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
 <nycvar.QRO.7.76.6.2010221042260.56@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <46b208d8-3741-d528-c833-aea5770a502c@gmail.com>
Date:   Thu, 22 Oct 2020 10:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2010221042260.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho and Sangeeta

On 22/10/2020 09:47, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 21 Oct 2020, Phillip Wood wrote:
> 
>> Hi Sangeeta
>>
>> It's great to see you tackling another patch
>>
>> On 21/10/2020 10:09, Sangeeta via GitGitGadget wrote:
>>> From: Sangeeta Jain <sangunb09@gmail.com>
>>>
>>> As `git rebase` was never prevented to run from subdirectory we shouldn't
>>> prevent `git bisect` to run from subdirectories.
>>
>> I'm not sure it's relevant to bisect whether or not rebase can be run from a
>> subdirectory.
> 
> The relevance is this: _iff_ we want to prevent `git bisect` from running
> in a subdirectory under the premise that that subdirectory might need to
> be removed, then why don't we prevent `git rebase` from running in a
> subdirectory when that command is equally likely to remove that
> subdirectory?

That's a good point, I'd completely missed the analogy with `rebase --exec`

>> What is important is that we want all commands to be able to be run from
>> a subdirectory unless there is a good reason not to (and there isn't for
>> bisect)
> 
> There is a difference in quality here, though. If you run, say, `git
> fetch` in a subdirectory, or `git commit` or `git show`, there is not the
> same worry that that subdirectory will go away as with `git bisect`, `git
> rebase`, `git switch`, `git pull` and other commands.
> 
>> I'd recommend adding [Outreachy] to the beginning of the first line of
>> the commit message as well.
> 
> I am opposed to that. The fact that this comes in via Outreachy is
> interesting at the moment, for reviewers, but not for posterity (i.e. in
> the commit that will make it into the commit history).

I thought `am` would strip [Outreachy] the same way as it strips [PATCH]

>>> diff --git a/git-bisect.sh b/git-bisect.sh
>>> index ea7e684ebb..9cd0fa0483 100755
>>> --- a/git-bisect.sh
>>> +++ b/git-bisect.sh
>>> @@ -32,6 +32,7 @@ git bisect run <cmd>...
>>>    Please use "git help bisect" to get the full man page.'
>>>
>>>    OPTIONS_SPEC=
>>> +SUBDIRECTORY_OK=Yes
>>>    . git-sh-setup
>>
>> `git bisect run` takes an optional script that is run to determine if the
>> current commit is good or bad. If the script is given with a relative path
>> then we need to make sure it is invoked from the subdirectory that `git bisect
>> run` was started from. As far as I can see git-bisect.sh does not change
>> directory but it would be good to have a test for `git bisect run <cmd>` from
>> a subdirectory.
> 
> That's a very good point. We should first add a regression test for
> exactly that use case, and then make sure that it passes.

Though I'm now wondering if we should be running the command from the 
repository root directory like rebase[1]

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com

> Ciao,
> Dscho
> 
