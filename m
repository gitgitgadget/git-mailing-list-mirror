Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC5C43217
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiKIQa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIQa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 11:30:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B21193FB
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:30:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5so11192151wmo.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mD/34eKWPVsjoFwrVIQUMb7w2ily4XmTOMj9oOyAZ5Q=;
        b=McuqO0qWmNrYgTMY56CIGG5tYv7V35fNUAYPmXvm3m2+Qx467aw/05z21ynL2MjU4/
         F7uz3G6gVtyMzA3ZdcrBwtrvT3M3gZOUw6JLN6JsD2jpOwn0qOM5LQmyWirG6XaJmznV
         PuQFnAyCiO74ebg53RNVCOolobV9qjmsV1vLAl/cBcRwvXzrC151QN2N+1opWFXaCO4c
         fxff8IoqKC9HrCdDKX3DEXE8lsdEU7fDMalgZ34m8JIp+jupJJB6XoLdItfnzy5RH4uf
         eF4er2cL7RQMoeY6iiTbWQAIbX3lLZduNb+cDUKaR963W4qPk0+pa0+4QRv7m1jyBj6I
         GVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD/34eKWPVsjoFwrVIQUMb7w2ily4XmTOMj9oOyAZ5Q=;
        b=zfkQxirOwaSkchHltlrsJhSjYv/PXlueEFF845T9A/+WGIBNJb/vNSvVxXCMWVO15q
         9FsS0dCXP2APLGREpVY4kE6YoYKNMkxW2TrispzYDqfVH5wWkS58aqeBuqTmovXGre3/
         2SR1Zg6yPMsSdmqtuVTzOFMwHH4HNyyuL09QWXvCWxq+s/gkuRGv4BIRcqnxzuNLfjs2
         LqwQigCJa5aqjfL6w0agVSuTonBMEMUoQcRPFFkn+6Iu64Cqn5ZJ5BYi9wZ1CLVCyYON
         EbReumdbVZuCfoWRIPAbGJSo2CRMWAgTYUNYocNM2SULLmWWzz8FRkd1x6l0Zrmiycv4
         DpJg==
X-Gm-Message-State: ACrzQf10/0Ek9woZ35Date9hOsKl+Y9dO/fr3v3QaLa+aDJa17c6EN/7
        6jVezcXRY+xZEEL/F48YYNGPMDvZyj4=
X-Google-Smtp-Source: AMsMyM5kigxe5TLzL78nmanWHd6RuKsIVmppPK15sc3SU6ul8HIj3EHVkMCnixjm6J818gZpvDmMxA==
X-Received: by 2002:a7b:cc13:0:b0:3cf:8297:d61 with SMTP id f19-20020a7bcc13000000b003cf82970d61mr30109126wmh.160.1668011453381;
        Wed, 09 Nov 2022 08:30:53 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b003cf57329221sm2394503wms.14.2022.11.09.08.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 08:30:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <28100f66-bd3d-d564-cb40-44b65ef415bc@dunelm.org.uk>
Date:   Wed, 9 Nov 2022 16:30:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] rebase: stop setting GIT_REFLOG_ACTION
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
 <221109.86leokp0vm.gmgdl@evledraar.gmail.com>
In-Reply-To: <221109.86leokp0vm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11/2022 16:05, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Nov 09 2022, Phillip Wood via GitGitGadget wrote:
> 
>> This is a follow up to pw/rebase-reflog-fixes that moves away from using
>> GIT_REFLOG_ACTION internally.
>>
>> Thanks to Taylor & Ævar for their comments on V1. I've updated the commit
>> message of patch 1 as suggested by Taylor, the code is unchanged.
>>
>> Phillip Wood (2):
>>    sequencer: stop exporting GIT_REFLOG_ACTION
>>    rebase: stop exporting GIT_REFLOG_ACTION
>>
>>   builtin/rebase.c | 27 +++++++++++++++------------
>>   sequencer.c      | 45 +++++++++++++++++++++++++--------------------
>>   sequencer.h      |  6 ++++++
>>   3 files changed, 46 insertions(+), 32 deletions(-)
>>
>>
>> base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1405%2Fphillipwood%2Fmore-rebase-reflog-fixes-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1405/phillipwood/more-rebase-reflog-fixes-v2
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1405
>>
>> Range-diff vs v1:
>>
>>   1:  e9c3f5ac5c6 ! 1:  655b4e89f59 sequencer: stop exporting GIT_REFLOG_ACTION
>>       @@ Commit message
>>            pass the reflog action around in a variable and use it to set
>>            GIT_REFLOG_ACTION in the child environment when running "git commit".
>>        
>>       +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is only read
>>       +    by sequencer_reflog_action(). It is still set by rebase before calling
>>       +    the sequencer, that will be addressed in the next commit. cherry-pick
>>       +    and revert are unaffected as they do not set GIT_REFLOG_ACTION before
>>       +    calling the sequencer.
>>       +
>>            Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>        
>>         ## sequencer.c ##
>>   2:  d3747bcc8d1 = 2:  31df037eafe rebase: stop exporting GIT_REFLOG_ACTION
> 
> Thanks, FWIW I'm happy to give this my "Reviewed-by", per [1] I've
> looked this over carefully.
> 
> The tl;dr of that is that this fixes a leak, and adds another one, but
> the root cause of the added one is that you're using an existing
> destructor that we sometimes don't call, which we can just address as a
> follow-up generic issue (I've got patches to fix it).

It is worth noting that the leak that is fixed was unbounded and grew 
with each commit whereas the new one is a fixed size and is only a 
"leak" because we don't clean up properly when exiting.

> But for now this is a good step forward, and fixes the leak that's
> "unique" t this codepath.
> 
> And of course, just makes managing the "reflog" variable nicer in
> general, as we're no longer talking to ourselves within the same process
> with setenv()/getenv().

Yes, that was the main aim really

Best Wishes

Phillip

> 1. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
