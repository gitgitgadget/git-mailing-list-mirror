Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C45C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594056128A
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhJDKLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhJDKLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:11:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B7C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 03:09:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a11-20020a7bc1cb000000b0030d6aae48b5so2566684wmj.4
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E5OnwZw92qCthJFGCTzRDFldbldNki5WTpifFTjkO2Q=;
        b=QG5uHwCOI8ildxak8yT1hzIHqztuUdVbIl/83GIwjWc0TcUegZWQ72fHvK41Wo5rfE
         0cDkAZ17ltAF0nsRy65kk4ipkgEJ8vBuzWP6SvbIzlizyyaRT9TyGE0beOCFF9yaB4x9
         B6v0sNojlJx4hXIMrYsxpP+uh5UnD6LldPTgNJbpaK63RdH9c2m3lgdAiu0dt56ERPmu
         96fWqWPl9SE1fk8bJurV8qTkb4kjCv3L37m2TwWsaARhofVo0j8mt2WJjveRsfLgO5/Q
         yKjNAgCRASWQXsJP8qhncSPRGRDMFiN+IfPV6DLGn3+peq4zsZZkSS07tog+sQnHjAej
         qPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E5OnwZw92qCthJFGCTzRDFldbldNki5WTpifFTjkO2Q=;
        b=5rdOgjI2EHWyfNe2dorwHqIsa2n0yvPvJZuKVjSySatLsFz9XesHviQx9ZsI5HOV12
         HGWpYeI2TKH8/tWR284hqXI5apNKzRbkMzklK47kIXL29ATP5+OR3sUeL0aHFttCCh5T
         X9sTrbp3isIwPugB8M2eSLkWOw4fGzDmdZi+bOHtngnGAs+tfVh9PaE5SMUdRDbtSMX9
         okbUChtJeJSa6v8J1UuiOyXJholuOfkRO4PRbRkepHzdCv0yuapPKf45RI0SmZw0xjVr
         ZoUN06Ejje4USDsTnOwh8qwBVHFYKAgmTHtl5DExZBQOwkJLa/8U1BmsQuah82UgSeqR
         SRZw==
X-Gm-Message-State: AOAM531xiEyhgxQKbaoZuYcW0oVuc+rssaJ2z5TZQb4Jv15BVXVEbuuB
        /R/zop2knuE9XCqrrIzQDzA=
X-Google-Smtp-Source: ABdhPJw50PJFs5o1VshoNPK+2pz5HawP+OXgBLOYtKICz4sSzDWYIU6bADLmg3xsF1byZV+0BxV+fg==
X-Received: by 2002:a05:600c:3585:: with SMTP id p5mr17999899wmq.110.1633342166022;
        Mon, 04 Oct 2021 03:09:26 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id i1sm14799576wrb.93.2021.10.04.03.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 03:09:25 -0700 (PDT)
Message-ID: <e423b101-77e2-02df-ee36-03c692c44e6c@gmail.com>
Date:   Mon, 4 Oct 2021 11:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/11] reset_head(): take struct rebase_head_opts
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <267e074e6dbd3c7cf733cd5ba4fa476d2d5e6fd2.1633082702.git.gitgitgadget@gmail.com>
 <xmqq8rzc5u2j.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8rzc5u2j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/10/2021 22:11, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This function already takes a confusingly large number of parameters
>> some of which are optional or not always required. The following
>> commits will add a couple more parameters so change it to take a
>> struct of options first.
> 
> Would all the members in the struct always be used by the function?
> If not, such a change will *not* solve the "confusingly ... required"
> problem at all.

I'll rephrase to emphasize that it solves the problem of remembering 
which order to pass things in and makes it clear what is being passed

> I am not necessarily against a change to consolidate a bag of
> parameters into a pointer to a struct.  I am against a change that
> is justified with a benefit that the change does not bring to us.

I found the existing api hard to use because it is easy to lose track of 
which position each parameter should be in. With the struct the order 
does not matter and having to set opts.parameter = value makes it clear 
which parameters are being passed.

Best Wishes

Phillip

> Thanks.
> 
