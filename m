Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23028C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiDRS7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiDRS7h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:59:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91531372
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:56:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso72797wml.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DIR9tHVM/15PJ7HOI0ujpLaFd4zl6fG4GzTlQ9UnbDg=;
        b=UIztwgxgZ1osl4Wi3YwhXKP0DQw1hjC1c+eZJ3545p1en/PK4/HFfCqYUdGVExNINs
         eIhxAZ3zEu3N7zKJgNt3wV927xpd+bnWnvDAU6OTaE0MXIeGf83XZ4rGSom+EzMkTyhJ
         +90M2gJV4hL6QeE00ggrUXEmmI80tqv5iypimXmI/xLv/GW8VD/n3uskvwDz5t2kEJRt
         6+zs2MowrkDAem3GhuadHx8DMUw1uE1qkq1YMJ7kgqR7Qrvuv1MYSpMTVpf81fhRsRZH
         ajbDl2+IBu+5oS8g4PwRgvOH26yGnQ5vqWO86wx9mD7p99hKCq+vg/JVHOwwIk/xXt1P
         noBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DIR9tHVM/15PJ7HOI0ujpLaFd4zl6fG4GzTlQ9UnbDg=;
        b=EohOqcx9MWeYh4kqqRCvAMOgyaXbN7rKAKNE69/OIE/x78B+YxpPRh9cqrVeb2g+QK
         f/CmsTa6Js7YZhGZT7vxV5E0LzoEX2W8GVbsvjgUmUKWaJgjdIimRPtQ9gcIOIvRPXQY
         jAnCsi3zGQ+Aekv4AT8J5aH+MmorMJBhB6SecIOT4r/OPvvKn9CyPqw8ejaKlJNxUmio
         Kuk/mDTawXyGjIHM05I1SizDfopUMpCoz/S+n+FRp3OzEewpPWKiDbg6va91Z3Q+poNY
         7dmWL1wg/Kjr4tENgnU3a4bdImqoscT00rN5aA/BAaSBlDxNIc7C2WhlENJFengMI9AL
         sGyw==
X-Gm-Message-State: AOAM531FSRJ19+WPkjSQqc+aysZmUDBcU3Bu8xn4LbMHeX1Dn2t8vnqN
        IsZS+kH+qhgkMZoNFgKodFk=
X-Google-Smtp-Source: ABdhPJyygRffdMHXVGHKW14tH3wzQDx5e7DJW0/X8QdhcaUf+ESMqh0njtGWornSYry2JpYTb82ROA==
X-Received: by 2002:a05:600c:281:b0:38e:bc6e:5971 with SMTP id 1-20020a05600c028100b0038ebc6e5971mr12302488wmk.111.1650308215720;
        Mon, 18 Apr 2022 11:56:55 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm18129648wms.35.2022.04.18.11.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 11:56:55 -0700 (PDT)
Message-ID: <0c9c1b37-24eb-3074-18c2-62185af27d43@gmail.com>
Date:   Mon, 18 Apr 2022 19:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Review Request (was Re: [PATCH 0/7] rebase: make reflog messages
 independent of the backend)
Content-Language: en-GB-large
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <64cae3bc-e1b9-d118-2d78-208dc772f74a@gmail.com>
 <CABPp-BGyesv-0upHdipLg+VrA08FV3cD7NrVK9xm4iVgn8iqHQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BGyesv-0upHdipLg+VrA08FV3cD7NrVK9xm4iVgn8iqHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 17/04/2022 03:13, Elijah Newren wrote:
> On Mon, Apr 4, 2022 at 8:34 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> If anyone has time to review these patches I'd be very grateful. I've
>> cc'd this message to some list regulars who have reviewed rebase patches
>> before but if anyone else fancies taking a look at them that would be great.
> 
> I apologize for the delay here...especially when it came after you had
> already waited a month and a half.  (This is the first git thing I've
> done in over a month, sadly.)  Anyway, I just read through the series
> and left some comments; mostly looks good but I second the request to
> split up one of the patches.

There's no need to apologize, I'm very grateful for you comments. I'll 
re-roll with that patch split up.

Thanks

Phillip

> 
>> On 21/02/2022 11:10, Phillip Wood via GitGitGadget wrote:
>>> This is a series of rebase reflog related patches with the aim of unifying
>>> the reflog messages from the two rebase backends.
>>>
>>>    * improve rebase reflog test coverage
>>>    * rebase --merge: fix reflog messages for --continue and --skip
>>>    * rebase --apply: respect GIT_REFLOG_ACTION
>>>    * rebase --abort: improve reflog message
>>>    * unify reflog messages between the two rebase backends
>>>
>>> This series is based on pw/use-inprocess-checkout-in-rebase
>>>
>>> Phillip Wood (7):
>>>     rebase --apply: remove duplicated code
>>>     rebase --merge: fix reflog when continuing
>>>     rebase --merge: fix reflog message after skipping
>>>     rebase --apply: respect GIT_REFLOG_ACTION
>>>     rebase --apply: make reflog messages match rebase --merge
>>>     rebase --abort: improve reflog message
>>>     rebase: cleanup action handling
>>>
>>>    builtin/rebase.c          | 144 ++++++++++++-----------------
>>>    sequencer.c               |   5 ++
>>>    t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
>>>    3 files changed, 214 insertions(+), 120 deletions(-)
>>>
>>>
>>> base-commit: 38c541ce94048cf72aa4f465be9314423a57f445
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v1
>>> Pull-Request: https://github.com/gitgitgadget/git/pull/1150
