Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F7C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871D061A43
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCZI0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCZI03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 04:26:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D34C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 01:26:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1373935pjh.2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vvr6qSK2Pez1fAbqVv6k3zCe1aRXrSnu5ZqJWTbKrwc=;
        b=sZ3HoIUpk8ckAtGi9cggqhwXQU8rU0bTl1m1RaYXIlpsZjdveSyKHCSTjp/NXso7cu
         +am1GabOaCZLROePCR0ptUORtU0ZHBuRq6IX2QJOHCWn3FWEjoElKut+l0+U0jhLJXNp
         Jx++5ryxKFRViy68wKKdqqWw41W8OBLCaI3p6xmaTgrOcAd/EaK5ZQhZeIV/NnAWV7Mk
         6AzdfDWrQb+7TJFuKI8nZCaH3k/J56ev504KWNeOUhnSQrDxERwqpWjzl3kLH+yi1Iak
         X8jS2jG0dSBjr+frKRmTDv0y40pmEM+CZRnzGtweJXCwZWO/1AcQS48eZol7KqYo0gPz
         PQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vvr6qSK2Pez1fAbqVv6k3zCe1aRXrSnu5ZqJWTbKrwc=;
        b=ewfGWNjD1115MKVsuu3uLgriAXa3d/ULbGuv/JorRosRpI93hv+Pzh4OIxq106gvqX
         YKIVj4w0z+N1UztzfMwWcrbI7NdZzH1x+GClOa4TqIZ97WmH7PNFPP0QiTBkEdTlyxXx
         7ZwazNDuriMZBJR+3cETGGiT1T+JC1UZZ0oVzynEDQKpGSr9PemYKzKmfN71L7GMtptL
         k66xaKWp9n555qGH/n+kzgdO0cdNPCdK39BEUQpEMyXKvVhqDg5aT2WzwgP2iFttvxMy
         XXP6yfpfutUGmlxs6pIRHIhd6y8spAyhdh12kQ0otUUbBOUhYjX6hV3SkE9apUrrzS9Y
         Wl8Q==
X-Gm-Message-State: AOAM530fr/Mcjy3Q3Lb0AjeSOpB3Y/3sTrbqi177pq+P3xwV2adgijRK
        CB9hj9WftQqbqQNHntoAaJssLlIahrQOXA==
X-Google-Smtp-Source: ABdhPJxFbMDFDT/0pyWc+wZ4JK7he+aB2Qke6pEw14dBZ8pE9UFUVqUyhkyRjuOdNHEiWAcQnuZC5A==
X-Received: by 2002:a17:902:e74e:b029:e7:1f01:c6b1 with SMTP id p14-20020a170902e74eb02900e71f01c6b1mr2162045plf.43.1616747188065;
        Fri, 26 Mar 2021 01:26:28 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id h68sm8146435pfe.111.2021.03.26.01.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 01:26:27 -0700 (PDT)
Subject: Re: [PATCH] format-patch: give an overview of what a "patch" message
 is
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20210325105433.43310-1-bagasdotme@gmail.com>
 <xmqqmturuh8o.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7c0aabe0-9240-950e-912f-0a195db7a144@gmail.com>
Date:   Fri, 26 Mar 2021 15:26:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqmturuh8o.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/03/21 03.10, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> The text says something called a "patch" is prepared one for each
>> commit, it is suitable for e-mail submission, and "am" is the
>> command to use it, but does not say what the "patch" really is.  The
>> description in the page also refers to "three-dash" line, but that
>> is totally unclear unless the reader is given a more detailed
>> overview of what the "patch" the first paragraph refers to.
>>
>> Co-authored-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
> 
> I do not think this was co-authored; you are forwarding somebody
> else's patch that was written without any input from you.
> 
Oh dear...

Next time when I need to send patches forwarded from you (or others),
but not necessarily Co-authored-by, what should I do? Something like
this note below?

[forwarded from someone]

-- 
An old man doll... just what I always wanted! - Clara
