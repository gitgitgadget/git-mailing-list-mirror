Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0033FC433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FD220714
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 18:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOl//7s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgGVSbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVSa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 14:30:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369BC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 11:30:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s10so2823272wrw.12
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RwUUO9mqmUDjAr9JhhE0sygDHYniJz3l1U4OlENywIc=;
        b=VOl//7s76+ucdJdmg6Rna3RGM2jgk2e8UmkWr0bU6hDElR6YBK49nbHRML1yRx4lQ3
         rR9Hp1xvBg06XKREVfwTIQXaySYHGiTEXDV05HpQhgLUaylcl93gmNXWBq8MfeNiHNkA
         wGBxZHzGuGM3nh3dO9csv5TrZ4SOohItUM0IJkCUr47IZTQ+zNALk+7cArMBJJqwd+0c
         xq9mN7wEg0dQGr6lihIu/FKW3oOcPrOD18dq6Y8MAa14xFUgjp7NvcojLvROe4DFBFGa
         BGrY67XCLqNN/1rmc6tGP0kU5j1vbLAdrb97ts0GGZ4TE1aEI3b9DIIc7H+jEdMMb/3y
         5g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwUUO9mqmUDjAr9JhhE0sygDHYniJz3l1U4OlENywIc=;
        b=MiJhc4nBiIa5rGtcwsADsOgitq/88tgEWZs3mWrd2MSGQGH2lv7qGyPqYMuePDcjng
         lNnBEzDB/EH9SINSxMkl/u2hXgUq2X8G3Gh1NloBFCIdEaTJyEP4WFLomxUv6MxwJIxJ
         1BJ5EtKUprybfXpaH58K8TpuOtyZ53MSZxIDG9w2rYmdBIwC9+xQyUoe9EvrvJW6m/qx
         huhsvYLBlIJxeb5fddnCk9CxOx9IRAxAij2JBl5idnP9TbQWbr6Hy26KjnhFE8QB/v14
         XwWXfok2Arq+dq5QzGOMOHCZY1sK3qim6Bc/kNLfeFafxzlFuRaKVd6GMz5aXyV61lW7
         FWmQ==
X-Gm-Message-State: AOAM532O5UcyDvv3JwEuqlIrZr1hDENcrB71RE7svxXaMDk0GkNUgjCt
        /encBnDpXYaXwh0Parj/Vxh3v9+F
X-Google-Smtp-Source: ABdhPJxbTsBEofBKSe2UVMXVGUV1dHU7vI2ir2GMHVB+2+sdw/yUCHll/g1X6RKwSupjULHLMtLitg==
X-Received: by 2002:adf:b30c:: with SMTP id j12mr720526wrd.420.1595442657718;
        Wed, 22 Jul 2020 11:30:57 -0700 (PDT)
Received: from [192.168.1.201] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.googlemail.com with ESMTPSA id l18sm825114wrm.52.2020.07.22.11.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 11:30:57 -0700 (PDT)
Subject: Re: Possible issue with rebase's --rebase-merges option
To:     Joel Marshall <joelmdev@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
 <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com>
 <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com>
Date:   Wed, 22 Jul 2020 19:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel

On 22/07/2020 18:09, Joel Marshall wrote:
> I've attached a couple of screenshots from tortoisegit. The branches
> are too long to show in their entirety, but this should give you an
> idea of what I'm talking about. The highlighted commit is the head of
> the branch that I'm rebasing onto. Interestingly, I just noticed that
> while --rebase merges reports that it's rebasing 202 commits
> intitially, upon manually reconciling the first conflict it reports
> that it is rebasing 183 commits.

Thanks, the rebased topologies are certainly quite different, what is
the topology before the rebase? Looking at the --rebase-merges result it
looks like the second parents of merges that are being rebased have
ancestors in the upstream branch. If that is the case then I think it is
working as intended.

 Are you able to run

  git log --format=%ad --graph $upstream..HEAD

before and after the rebase to check that?

Best Wishes

Phillip

> On Wed, Jul 22, 2020 at 10:22 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Joel
>>
>> On 21/07/2020 22:20, Joel Marshall wrote:
>>> Thank you for filling out a Git bug report!
>>> Please answer the following questions to help us understand your issue.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>> This is a difficult one to give proper steps to reproduce. The issue
>>> is with rebase's --rebase-merges flag. We recently switched from using
>>> rebase with the --preserve-merges option to --rebase-merges. Most of
>>> the time the output is the same, but sometimes it is very different.
>>> I'm unable to determine whether this is by design or a bug.
>>
>> --preserve-merges is buggy if you rearrange the commits (this is way
>> --rebase-merges was added), if you're just rebasing without reordering
>> anything then I think the result should be the same though there may be
>> some corner cases I'm not aware of. Are you able to share the topology
>> before rebasing and after with --preserve-merges and --rebase-merges?
>>
>>> What did you expect to happen? (Expected behavior)
>>> Resulting graph after running rebase --rebase-merges is the same as
>>> running rebase --preserve-merges.
>>>
>>> What happened instead? (Actual behavior)
>>> Using --rebase merges tries to pick substantially more commits and
>>> results in merge commits with no parent commit when viewing log in
>>> reverse chronological order.
>>>
>>> What's different between what you expected and what actually happened?
>>> When the issue does occur (it doesn't for all rebases) it results in
>>> two completely different logs and picks commits that are apparently
>>> not part of the branch being rebased. eg, for a branch with 128
>>> commits including merges, --preserve-merges picks 128 commits and the
>>> resulting topology matches the original branch's topology.
>>> --rebase-merges picked 183(?) commits in v2.24 and 202 commits in
>>> v2.27, and in both cases resulted in a very strange topology.
>>
>> That's interesting there were some changes to how empty commits and
>> upstreamed commits are handled between v2.24 and v2.17, without seeing
>> the staring point and the results it's hard to tell what is going on though.
>>
>> Without seeing some examples it's hard to tell if there is a bug here or
>> not though it does sound a bit suspicious.
>>
>>> Anything else you want to add:
>>> Feel free to contact me at joel@tusksoft.com for additional details.
>>
>> You email me directly if there are things you don't want to share on the
>> list
>>
>> Best wishes
>>
>> Phillip
>>
>>> I
>>> would love to understand if this is by design or a legitimate bug.
>>>
>>> Please review the rest of the bug report below.
>>> You can delete any lines you don't wish to share.
>>>
>>>
>>> [System Info]
>>> git version:
>>> git version 2.27.0.windows.1
>>> cpu: x86_64
>>> built from commit: 907ab1011dce9112700498e034b974ba60f8b407
>>> sizeof-long: 4
>>> sizeof-size_t: 8
>>> uname: Windows 10.0 18363
>>> compiler info: gnuc: 10.1
>>> libc info: no libc information available
>>>
>>>
>>> [Enabled Hooks]
>>>

