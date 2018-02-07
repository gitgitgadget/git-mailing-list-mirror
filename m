Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDAE31F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeBGNqv (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:46:51 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33837 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbeBGNqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:49 -0500
Received: by mail-qt0-f195.google.com with SMTP id d14so1561593qtg.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eV3YS3+KRid/+uzKXKGaH1EOX00I+rvkv1njdvBo9ts=;
        b=MvqAJdI3wSAvvS8S0GztI7WaNbJ2vQTuBCzYgn/5pJET+doMA4W7sbuEBkoFnC9YyV
         o5E6M83fKcJ0HFB7vR7McM2fVzGBYa683rTqB/W4AjIvRQCag8bE7ioebWfM4kIBmwa8
         WExR95L00r5WWas0Nmn0N8pe60HJHugI3HQddEejuzsc5gOLMFwZWrsG1b2F0VTPa8v1
         cFOS5yztbXUvErQdEEZ5eKVgNrmFm1BEEyxCryzdR8TWfBC9pZtCQBgj3bU6X/WxorE+
         /wStNTguh16kgDyUTmVaaeIkUo/9fpvrxw19H0WD45vAnw5xmECrSjU2UH0GfaRuUsSF
         pyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eV3YS3+KRid/+uzKXKGaH1EOX00I+rvkv1njdvBo9ts=;
        b=d+YmBmOAKMfmOcNtbj8/pTbczvPETln/+JMzuWwcIXYkMZBm3ccM8ciDBLlsF7eZVi
         UxQR8E3RX1grMkNQ1fagBFzX+8TUxKki7O602DcawwmBc9Fr0t/p8eKC28FCjjWEVJVv
         7p+kElvFBo+iVcYNxS3EfOtH8QDrebtKBiKAZjGyxWy4mn7osXdPuFRMU0oOdR1MiXoW
         W/4BuMQNBK28ND1ePYNYiwHMohUVSZ2zzCmC3UlUYqQuWrb7j2WtFEpuB29gE3oETAZG
         V17OIbAYolChKwwjeYZUfwpZhYT9AzTtGaMKNgvm+348WIf9Q1Gs0SOX+V9dN+YxgcIc
         2+ng==
X-Gm-Message-State: APf1xPDBGZ8p4rAnEAotNNOAa40sd1t9vm0QzzXsxMz+ZimNInhsYJ9z
        xlX1AJuuWBuXjrylLQUYjUQ=
X-Google-Smtp-Source: AH8x225P8ShWQtILqSu6C3yl5VKkjHiMSSLixeigx5uxiBVm64CNk7ejOgvywloStmOTXT+SqwHevQ==
X-Received: by 10.200.27.34 with SMTP id y31mr9863553qtj.161.1518011208974;
        Wed, 07 Feb 2018 05:46:48 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id s39sm1085975qth.67.2018.02.07.05.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 05:46:47 -0800 (PST)
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com>
 <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
 <CACsJy8C+9Det0zF4+HZ6TL36aCFgboEh4=3yrEk5WvyUD30Drw@mail.gmail.com>
 <CACsJy8CS6QwAc9=i9JhW3RhLqYsfPM_OWSJ-DCvEAftOKDWs2w@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <900d87a2-97e2-a018-70ff-610c707e93de@gmail.com>
Date:   Wed, 7 Feb 2018 08:46:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CS6QwAc9=i9JhW3RhLqYsfPM_OWSJ-DCvEAftOKDWs2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/7/2018 5:59 AM, Duy Nguyen wrote:
> On Tue, Feb 6, 2018 at 7:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Feb 6, 2018 at 7:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Tue, Feb 6, 2018 at 8:48 AM, Ben Peart <peartben@gmail.com> wrote:
>>>> With the new behavior, making a change in dir1/, then calling status would
>>>> update the dir1/ untracked cache entry but not write it out. On the next
>>>> status, git would detect the change in dir1/ again and update the untracked
>>>
>>> Thing only missing piece here I would add is, this dir1/ detection is
>>> done by watchman. We have to contact watchman and ask the set of
>>> changed paths since $TIME where $TIME is the last time we updated
>>> untracked cache and invalidate those paths in core. Then it should
>>> work correctly. I checked the watchman query in the fsmonitor hook and
>>> I think it's correct so far.
>>
>> No I think I'm wrong. And worse, I think the interaction between FSNM
>> and UNTR extension is broken. This is partly from me guessing how
>> fsmonitor works so I may be double-wrong.
>>
>> UNTR extension is supposed to cover the untracked state at timestamp
>> $X. Where $X is stored in FSNM extension. Correct?
>>
>> When fsmonitor is used and read_directory() is executed (at timestamp
>> $Y), we ask watchman "what's new on worktree since $X?"). We get the
>> list, we invalidate relevant directories so we can see new untracked
>> entries (or lack of old untracked entries). We write FSNM with
>> timestamp $Y down. We may or may not write UNTR down because of this
>> patch, but let's suppose we do. All is good. UNTR now records the
>> state at $Y. FSNM says $Y. This is how it works (when there's no bugs)
>>
>> UNTR extension is only updated when read_directory() is called. It
>> does not always happen. FSNM is updated all the time (almost at every
> 
> I was indeed doubly wrong. When FSMN is read, it does make calls to
> invalidate stuff in untracked cache data structure. If the index is
> written down (with updated FSMN extension and timestamp) then the UNTR
> extension, which is generated from in-core untracked data structure,
> also reflects the damages by the changed paths so next time even if
> those changed paths are not reported again (between $Y and $Z below),
> it's fine.
> 
> All is good in the world again :)

Thank you for looking into this closely.  It's always good to have 
someone else examine the logic to make sure there aren't errors that 
were missed.  Sorry my responses have been slow, my day job has had me 
busy lately.

> 
>> git command since most of them needs to read index, many write it
>> down) with new timestamp. Suppose FSNM now records timestamp $Z, UNTR
>> still records the state at $Y because in the last index update,
>> read_directory() is not executed. 4 files have been added between $Y
>> and $Z. When we ask watchman "what's new since $Z?" we will not see
>> those files, so we don't invalidate relevant directories and
>> read_directory() will not see those files.
