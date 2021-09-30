Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6658AC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A4F61A54
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbhI3XBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344543AbhI3XBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 19:01:50 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A2C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:00:06 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a14so4565588qvb.6
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bt26eKhu+1Xdt2CfQIb8Xv3CI3N8VDmok2152HdArPw=;
        b=iJjM5KkIhQQWsBRwK8dUVtEhpVrv9+efGe/Y99pIyuUXH0W8/b8JT3O38qN7pyaxVR
         AYmKAZMz7YhnyjnOCu+NZ7SYc+vnVhboMBQKVfdE1dLI3NnYqOd60BKr1PLMA/jhQEX3
         gacpLeXy2KV6/qtY1iVuSGydgn5DfKk8lA4fIPti7WvGHZwHh1Kc1pjSIMOPKJNPvsHY
         3OxH59vVKtS04f1uFqZKAPcZ6bqQaieQagVMUjBBsS6Uful1Bb6dCDlXnLveRku+GU9A
         yzCRVcvBZ7c7QizXz0k4hW5p2nwaJJXGov2qLsr7x+cbkTRMXBN5su9f9OUi7iFpBPNR
         xUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bt26eKhu+1Xdt2CfQIb8Xv3CI3N8VDmok2152HdArPw=;
        b=6guzigaJokO9xoXcOmw92vbRVGsJmH6EniPOXQdDZ2Dun5AQaYVpMUu4dp4uKK03GB
         ZSBHSnxTdeh0swDhRhKS016DQENhI9ovwyZWR+CC08IfUMFrW8NzZTEY69j/sABekkNt
         +xmUN32ov2/1eA3hqjzT+kLnEjNdN9LTcOcvlm2z/gkjmc8Dzs2DJgyiA3BtKa89Xqx2
         5r2w9ZageNwAGAWdcQ/6B7XygblB5Lkn2uEG4xMNCqrPpcwzkHl3fdaIbK/2mKjUglE3
         I2kOhN7lsroZZWfqVF+krY1cdNfEZTc6NxnicLbkpblCNiqaWQPizfLCnzSj87l0SbgO
         5DhQ==
X-Gm-Message-State: AOAM531ILiGoNzMV6Br/dC9gHGvZO2RHGTWdOHfm2ipSh4dUAaOXz5g9
        vt6Oni817ooCKl2PQPgJmkQ6
X-Google-Smtp-Source: ABdhPJwZL955h2haIDOIhUTlJvtxB49tyED3dfFrZ7cSlpJrw8Bw19uf+VIPUdJUyj0XKLYf9VwAug==
X-Received: by 2002:a0c:b30f:: with SMTP id s15mr6178924qve.23.1633042806049;
        Thu, 30 Sep 2021 16:00:06 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id d14sm2308915qkg.49.2021.09.30.16.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 16:00:05 -0700 (PDT)
Message-ID: <e6049a17-c721-c596-51a6-101cb6065829@github.com>
Date:   Thu, 30 Sep 2021 18:59:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
 <YVYNW13aVADaR+g6@nand.local>
 <6e9843d5-bc04-e69c-9e53-7bf18ca30fc8@github.com>
 <xmqqk0ixagw8.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqk0ixagw8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> Taylor Blau wrote:
>>> On Thu, Sep 30, 2021 at 02:50:56PM +0000, Victoria Dye via GitGitGadget wrote:
>>>> From: Victoria Dye <vdye@github.com>
>>>>
>>>> In anticipation of multiple commands being fully integrated with sparse
>>>> index, update the test for index expand and collapse for non-sparse index
>>>> integrated commands to use `mv`.
>>>> ...
>>>>  	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>>>> -		git -C sparse-index -c core.fsmonitor="" reset --hard &&
>>>> +		git -C sparse-index -c core.fsmonitor="" mv a b &&
>>>
>>> Double-checking my understanding as somebody who is not so familiar with
>>> t1092: this test is to ensure that commands which don't yet understand
>>> the sparse index can temporarily expand it in order to do their work?
>>
>> Exactly - if a command doesn't explicitly enable use of the sparse index by
>> setting `command_requires_full_index` to 0, the index is expanded if/when it
>> is first read during the command's execution and collapsed if/when it is
>> written to disk. This test makes sure that mechanism works as intended.
> 
> Sorry, I do not quite follow.  
> 
> So is this "before this series of patches, 'reset --hard' can be
> used to as a sample of a command that expands and then collapses,
> but because it no longer is a good sample of a command so we replace
> it with 'mv a b'"?

Yes, because this series enables sparse index integration in `git reset`,
the test no longer applies to that command (but it does apply to `git mv`).

> Do we need to update this further when "mv a b"
> learns to expand and then collapse?

Unfortunately, yes. `git mv` was picked more-or-less at random from the set
of commands that read the index and don't already have sparse index
integrations (excluding those I know are planned for sparse index
integration in the near future). If `git mv` were to be updated to disable
`command_requires_full_index`, the command in the test would need to change
again.

For what it's worth, I do think the test itself is valuable, since it makes
sure a command's capability to use the sparse index is always the result of
an intentional update to (and review of) the code.
