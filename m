Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD47DC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2936139A
	for <git@archiver.kernel.org>; Wed, 26 May 2021 15:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhEZPOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhEZPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 11:14:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C376C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 08:13:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so717162wmh.4
        for <git@vger.kernel.org>; Wed, 26 May 2021 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ar7/C4f+jgsj5rDoV1G6E+w15Q72biRO7iqkkUeJofM=;
        b=HUHDnRf49LxnUj23HWHAMJ9SjN3YTuehje6anoh33U+YL2Iv0vVDHvd5wDoZcOBmle
         VCXSuZ0YY+Zg2bCQNVCSu+eNJ3n9BU4UIDmsvISruBk03gfFI8nuyX3rlqzObStUWmAS
         eo5T6QF1wMo3ZwiIBONDDiN6RX2FXqD3x9v3KfRZ8cqaK+g3U7sJrZrOltgyg1yY8dgh
         S7fGlcRG8bnDtCdqYLa+OTxEMm7vcBxsRGF3b26brPBMs8yN3HEKBU6iSK1Z9eQ8CQfm
         x5Xf/xkDE2hHXp+op5Ckp85U0NIVs/phSmd08ZlLzHhRvSs0eo9lSqZTFck3xejPic1P
         4KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ar7/C4f+jgsj5rDoV1G6E+w15Q72biRO7iqkkUeJofM=;
        b=QpDjoSJecwSXhtYFQ+xo4Y6430TZHclUZ+IWPnvld2JITeqrsKyz0V4ivMug9sl8lF
         QNc1Acgyn1HCcA6bQHqKcClueO8r1ylZ5BIIzz+beOX1vPduCVibKn7c2Po2wLbnhNg1
         b3i2tI2/88Ejuk0akdpiPYyp4tctIva6opHAmbMCjeS0CpmnwVZrhfe5AwPjPK2Qf1M0
         ryFDkrILPcUJE3xbE7UqO6jKoNJHGJzVAhPrh+cLPBfG3PeWjr6zoC1LUgI/sl0yd266
         asZaQtDhPQ7Mi37RfOqLYTvGe5j7hJ2E0YshC0yWYg0jj29H2df2wJJH7ba/fm6ecLim
         CcNQ==
X-Gm-Message-State: AOAM530eh9rLWEQ5OkH2qjisYugRRXkBV9BuI/+GMFNs+JJQzk1fjqtW
        jEuLKVmi2w7e+xPsYr/+FPCeMHqzl8I=
X-Google-Smtp-Source: ABdhPJwzBGTDt0yBV9Cj4Lz2uTIe3PAhGMMH/6r/7Mo/tLL3EBvovvr1eHSzcAzPDGxxOSI0+B6e6A==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr30190681wmq.172.1622042001117;
        Wed, 26 May 2021 08:13:21 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id p10sm19518423wrr.58.2021.05.26.08.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 08:13:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
To:     Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
 <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <45c23ea3-0e21-7654-3d2a-5597e159f847@gmail.com>
Date:   Wed, 26 May 2021 16:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2021 15:30, Elijah Newren wrote:
> On Tue, May 25, 2021 at 1:22 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Hi,
>>
>> Supposed that we have following commit graph:
>>
>> ----A----B----C----D <- master
>>                 \
>>                  ----E <- e
>>
>> When we merge e branch by `git merge e`, obviously we will do 3-way
>> merge. Assumed that the merge doesn't conflict, Git will fire up
>> editor to edit `COMMIT_EDITMSG` for us to enter merge commit
>> message. Then we abort the commit by either delete all the lines
>> there, or comment all of them.
>>
>> But when we check status by `git status`, Git says:
>>
>>> On branch master
>>> All conflicts fixed but you are still merging.
>>>    (use "git commit" to conclude merge)
>>
>> That message above is misleading, because we know that our merge
>> doesn't conflict (3-way merge applied successfully without conflict).
>> However, it makes sense only when we have resolved all conflicts
>> on the conflicted merge.
> 
> Once upon a time, that message would have always been right.  Then a
> --no-commit option was introduced to git merge, and editing of commit
> messages for merges was also added.  As you note, both of those can
> yield cases where the message is misleading/surprising.
> 
>> So for non-conflicted merge, we can say instead:
>>
>>> On branch <branch>
>>> You are still merging, and the merge applied without any conflicts.
>>>    (use "git commit" to conclude merge)
> 
> At the time this message is printed, there is no way for us to know
> whether there had been conflicts.  We'd have to record that
> information somewhere (probably the index, though introducing another
> index format just for this seems like a really high lift for such a
> small thing, and may conflict with other efforts to extend the index
> format, such as the sparse-index work),

Can we use the information that `git update-index --unresolve` uses to 
tell that there were conflicts? I'm not clear when that data gets 
cleared from the index - if it's not cleared when we commit then it wont 
be much use for this.

Best Wishes

Phillip

> OR re-do the merge when the
> user runs status just to find out whether there had been conflicts
> (which seems like overkill, and would require you to know which merge
> backend had been used and with which flags so you could re-check with
> the same one; further, three of the merge backends -- recursive,
> resolve, and octopus -- all update the working tree and index and thus
> could not be used for a case like this).
> 
> Seems like opening a really big can of worms.
> 
