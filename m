Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B9C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 09:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjDEJQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 05:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbjDEJP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 05:15:58 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C63449C
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 02:15:56 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id n7-20020a4ae1c7000000b0053b61145406so5561651oot.11
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680686155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uV9tKa0hWoZGyBpyoJF6cGkL4G/osPh8BtTVYh3EkOI=;
        b=bXiSnnWxcMFNRUQHe4UWhTHkkp5oaXPQOoMlhjTvPpeGsYoh5NoAlMcAqlWEot7pZN
         EtC8j3A61Mo84+ggnfApBtCC39bFsKVUc4Klzmoz++exYrt7fyZuo60mUaS7HvYD9fWU
         aEXyEi5PXzotlBjJxM1rPQQ8Sl7gjLRGQMSZJEfESo3dOLHhCoYwo4nlkBcfF0FDfT5g
         R1q5LYal3NuV5yC/VUOyxBnNe8CNOT96nwbPyWjtO/plhHp27IeFOq5+i6Gnn8Kv1hfE
         JM5DCjtF55nBQynQFlhyooZk4qAH1L/shbvaaeMsyPA8g1BZlvXRW05TQ0sC6fC2tisI
         toSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV9tKa0hWoZGyBpyoJF6cGkL4G/osPh8BtTVYh3EkOI=;
        b=1V+cTn1q/baMB2H4lsOQ6Zd2nXg6BHoWr6esABXiwcpqYED/em5cJL3hmDcsCSiRNZ
         kFcyCDlPgmjDYwf3wiAg7hVapZjBgVx9fu39nWmtmloL/pWoZW4h2pq3TD65tEjYgKCm
         scwGsoYyuJyTRQFsIzNmppuI0MElZhCkv7e9xoSxeRnkpF6UIHLUbbviypamZ8HqmTCr
         7+fMKfxTfab6fHQD/gfIxEDfQOYSVJiEJkIB6BlzdVMudkahfCGIEnPhMLyrjYT+akca
         aLY4gUx7O1U6ThHtgucUxwoGqrYm7rZxv2Vbtac9sq8qjeGn9K1cRutYJZQEuECPFsMC
         9hiw==
X-Gm-Message-State: AAQBX9e4xHl4OpeClW/CSjmdHD3yrUXx+qlYR37iuVIftfTY13nwrfO2
        TTjquXEZnIHdoflgIok0tXI=
X-Google-Smtp-Source: AKy350YgV5BoogfKu27rYYHByQEuZuC1SJNp8Ped80Xn8ki338kK2JxUAgfbwrThCu1GzqlnFgYlwQ==
X-Received: by 2002:a4a:1187:0:b0:541:521:b527 with SMTP id 129-20020a4a1187000000b005410521b527mr2355041ooc.7.1680686155222;
        Wed, 05 Apr 2023 02:15:55 -0700 (PDT)
Received: from [10.136.10.190] ([194.199.146.45])
        by smtp.gmail.com with ESMTPSA id i2-20020a4aab02000000b005251e3f92ecsm6343711oon.47.2023.04.05.02.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:15:54 -0700 (PDT)
Message-ID: <11f9fec6-dbad-4f70-75f3-793eadd62840@gmail.com>
Date:   Wed, 5 Apr 2023 11:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] branch: improve error log on branch not found by
 checking remotes refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ClementMabileau via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
 <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
 <xmqq355wctjq.fsf@gitster.g> <cffce108-c39d-f13f-9fb6-60624f7e7cea@gmail.com>
 <ff7bb1f4-e35a-66ad-1116-6bb2b906fed3@gmail.com> <xmqqmt3n1up1.fsf@gitster.g>
Content-Language: en-US
From:   Clement Mabileau <mabileau.clement@gmail.com>
In-Reply-To: <xmqqmt3n1up1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/4/23 18:24, Junio C Hamano wrote:
> Clement Mabileau <mabileau.clement@gmail.com> writes:
>
> Ah, sorry, I didn't get your response as a conditional "if you like
> it, I'll work on it further", as we usually take "how deeply does
> the original proposer of a change believes in it" as a strong hint
> when we need to decide if it is something worth pursuing [*1*].  I
> am not so enthused to drop everything else and invest 100% of my
> time and attention to this change, but I am not opposed to the
> change being proposed, either.  We haven't seen anybody other than
> us two to speak on the review discussion thread of the previous
> round, so I do not know about other developers and users.

Thanks a lot for taking the time to explain the usual process, I must 
confess I'm not used to it, so the confusing discussion, sorry for that.

> The usual next step by the author is
>
>   * Update and resend the patch(es), taking care of not just
>     correctness of the code but also making sure that the proposed
>     log message reduces the need for those questions asked during the
>     review of the previous round [*2*].
>
>   * Wait to see other people who find the change favorable.
>
>   * After that, the patch may be picked up, advance to 'next' and
>     then to a future release.
>
> but the author can abandon it at any step.  After all it is author's
> itch and all we can do here on the list is to give encouragement and
> help in polishing it.
>
> Thanks.
> [Footnote]
>
> *1* We do not take it very kindly when somebody says "I am dreaming
>      this and that change, I think it would be great, and if you
>      promise it will be included in the next version of Git, I'll
>      work on it", and respond with "We do not know how good your
>      change will be until we see it." plus "If a change is so great,
>      we expect you would work on it even only for yourself,its
>      greatness will spread by word of the mouth, many people will
>      yearn for it, and eventually we would come to you begging."  A
>      change, in which even the original author does not feel it is
>      worth their time to invest to perfect, has much less chance to
>      be successful.

Be sure that I'll work further on my patch with this in mind!

> *2* Reviews on the previous round may have asked "why is this change
>      needed?" "what is the intended use case?" etc.  The proposed log
>      message is the place to explain these.  The goal is to make it
>      easier for future readers of "git log" to understand so that
>      they do not need to ask these questions (unlike reviewers who
>      can ask and get answers from the author of the patch, they do
>      not have anybody to ask because the author of the patch may not
>      be around forever).
This is also good to know, I'm still learning for sure.
