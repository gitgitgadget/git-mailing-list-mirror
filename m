Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD8C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6BC206DB
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ETGHVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSLBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:01:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56024 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgBSLBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 06:01:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so105549wmj.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 03:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILdvWpIHyHURtZRM6ergoZ/2MWhUk6PD7NMny/Yd8dE=;
        b=N/ETGHVWBmvk9YnaLlk8/3+8tS0PEuq8/trsswpPdhGv54cyXc84PgRP2ARgJqvezH
         InTOzj09z1OguW1gyCUEH9XdxFGiRCxCklCF6Pkuppacfso190o/ZXNKv/sVRtGLI8Ed
         vkDoqT8IrM3xrEbdiD/qCDHKYauCiZ3BlSh+Fyl/y+LfP3ikjFjYWqBdlzKsXiAxpbnx
         agSToPV+xACRD0N//19Tvb58co4ctJ+q3xJ1+pG2CVcPi4uDaWSygIX8gCHIHpDtLLoU
         6FpePoA/DZwtBBvB/a7jAOTIWlOAylh8lIanonXaXMWa0ZrlBHzjC8k8coFqI85V3tAS
         yM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ILdvWpIHyHURtZRM6ergoZ/2MWhUk6PD7NMny/Yd8dE=;
        b=tBXQa0l7IE5e+6EPcJFGUmuGKn5NomwXBFC8ytwhXPQ7CHtjWtM2Fnojva2R8U2ak0
         DdYu6a5UfTBOODRZCUHfeui2+DM0ElrUAjdu6xwOZJ5uHEw+q5MpNi+AG9RlVP5SDI5d
         n+1JwfLpbH4uZKrV76KvtVfLlGuvUKeczbk9Gr2sty6GgRT1RYe1DWwVAF1NiamXmlZL
         pay8I2ACGf/6PkGpUeOBdS4YyMs05ESCuJsXvBSutIoWhVIj0KLyjoQX7odK8GPYf+dT
         xyh4qKUycM7lqjT67x1eb+eDLDK6Pf8Z8oyEGEFQqteeTmX56HcmpaOAA1sYRVJrxhYI
         mzpQ==
X-Gm-Message-State: APjAAAWmckdOPehwJWwOpbNMvrTiTv+QpDCsqPsvPTvdaCVHp9Wo7e+j
        wFLsK5hp/q8p7cetsQ4IYkMIhT+N
X-Google-Smtp-Source: APXvYqwkjBj4IrRdDSapEtw8Lr+aCxY7XQG3y1yHZne+2vVN2VS//gAyFBkY+QAydoB8ckITwXkBhw==
X-Received: by 2002:a1c:451:: with SMTP id 78mr8950228wme.125.1582110111770;
        Wed, 19 Feb 2020 03:01:51 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id e1sm2405981wrt.84.2020.02.19.03.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 03:01:51 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like
 failure
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
 <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
 <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com>
 <CABPp-BHBv+_HkExM1q6WAZZyMhR=UPNQZDhE8jFSQFNoCtgytg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <deae766d-f552-2e30-fb49-e7e187ee984b@gmail.com>
Date:   Wed, 19 Feb 2020 11:01:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHBv+_HkExM1q6WAZZyMhR=UPNQZDhE8jFSQFNoCtgytg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 18/02/2020 15:59, Elijah Newren wrote:
> On Tue, Feb 18, 2020 at 7:05 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> On 17/02/2020 19:12, Elijah Newren wrote:
>>> I forgot to add some cc's in GitGitGadget before submitting; adding now...
>>>
>>> On Mon, Feb 17, 2020 at 9:15 AM Elijah Newren via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> From: Elijah Newren <newren@gmail.com>
>>>>
>>>> A user discovered a case where they had a stack of 20 simple commits to
>>>> rebase, and the rebase would succeed in picking the first commit and
>>>> then error out with a pair of "Could not execute the todo command" and
>>>> "Your local changes to the following files would be overwritten by
>>>> merge" messages.
>>>>
>>>> Their steps actually made use of the -i flag, but I switched it over to
>>>> -m to make it simpler to trigger the bug.  With that flag, it bisects
>>>> back to commit 68aa495b590d (rebase: implement --merge via the
>>>> interactive machinery, 2018-12-11), but that's misleading.  If you
>>>> change the -m flag to --keep-empty, then the problem persists and will
>>>> bisect back to 356ee4659bb5 (sequencer: try to commit without forking
>>>> 'git commit', 2017-11-24)
>>>>
>>>> After playing with the testcase for a bit, I discovered that added
>>>> --exec "sleep 1" to the command line makes the rebase succeed, making me
>>>> suspect there is some kind of discard and reloading of caches that lead
>>>> us to believe that something is stat dirty, but I didn't succeed in
>>>> digging any further than that.

I think `--exec true` would be better as it makes it clear that it's not 
a timing issue. I've changed do_recursive_merge() to print the mtime and 
mode of "DS" before and after the merge which gives

HEAD is now at abd8fe3 side1
Rebasing (1/2) # picking commit1
DS mtime, mode before merge 1582109854, 120000
DS mtime, mode after merge 0, 120000
Rebasing (2/2) # picking commit2
DS mtime, mode before merge 0, 120000
error: Your local changes to the following files would be overwritten by 
merge:
	DS

So it looks like the problem is that when we pick commit1 we don't 
update the index entry for DS properly in merge_trees()

Best Wishes

Phillip

>> Intriguing - it's strange that it errors out picking commit2, not
>> commit1 I'll try and have a look at it. There seem to be some leftover
>> bits at the start of the test that want removing see below
> 
> I know, right?  It's kinda weird.
> 
>>>> +test_expect_success 'setup' '
>>>> +       rm -rf ../stupid &&
>>>> +       git init ../stupid &&
>>>> +       cd ../stupid &&
>>
>> I think these 3 lines must be left over from you trying this out before
>> making it a test
> 
> Whoops, yes you are exactly right.  I'll remove them.
> 
