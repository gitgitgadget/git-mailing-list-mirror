Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A840C4167B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5891422795
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgLDNlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLDNlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 08:41:16 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCAFC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 05:40:35 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t9so6171530oic.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 05:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHSUF4rNxXSdeWRuGYbiu5/xdySheqcJcwp0fRYe1NQ=;
        b=d5PyOst6l1jZVKFXDTUPStIMbiSgHfS7JT0oawiqCwJTHRyIBVuXWZirEFMsqArsdT
         sCAAso0Tf80d6Mbn9wDO98jcAIv8zlXNc8WcZnI14chhb+Wu2n4QwJ4AaRJVlvhlQ/AK
         A4vgKUQxf7F1Semlod6frS9iMCFLfoaT0xd5O7Un949CFXs01beY93vMOorgwnwbobm5
         qj0/KnkYxW3yWeb7AMOIt2xmKlbW4BnoUgUYQaLOEM4JwAEUek4+zN+Ao+druBUslwa1
         f/Jf+7du+aK+OaAH4NZdOlUCQ1GmFxaEMgRQdoJTNnwAwOFAOiRC08dBG567WZ1lYbhE
         iauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHSUF4rNxXSdeWRuGYbiu5/xdySheqcJcwp0fRYe1NQ=;
        b=dNi1ORYbBf+vZUU+RW0d2QXbZAppDqqy4Fl6hh7P3H68QzvD3hIqPDf4R0GcGIzcKE
         Yc8Iwmchq/2yGsJKeITuO0O/i+pV3H6bH5yaHbqaXr+q/umeU3DkckIIXhi5IHoI/a2H
         BG/7XJFHB1Iphy6UiMWHBmbfxqmk23+wzOYbiZWlnXQjFJ0ayhdCfO3C8bAr1JVBJhJg
         TDi/4PTv499/ks8RXFSI1BXI8KAZr1TOO0K6Ez7pjodS89LNy82SdVOm2QnRBAsI1B2h
         UAVmEbplW28lZ7QUZ8d5sqOoFkA+BCh/ZKISZxvZeIgUSAed5Cp1lHi13ANZLvGKcz1L
         OFsA==
X-Gm-Message-State: AOAM531zEWzuxsZ/AuZ63MRa/Otw5Fxo9v39T+KJDm5jjb+LPEEA/Xr2
        JrfjZCUawjU+4CjMk0xDU1oCXcARqX/Xsg==
X-Google-Smtp-Source: ABdhPJyAfS1XL/NpaKh315Xj1de0kYdwn3cghzFqu03xJScT5oJR94i8mB1KLfC4cpl1SBCxbDGs0Q==
X-Received: by 2002:aca:cf0a:: with SMTP id f10mr3063717oig.11.1607089235177;
        Fri, 04 Dec 2020 05:40:35 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id y139sm201905ooa.45.2020.12.04.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 05:40:34 -0800 (PST)
Subject: Re: [PATCH 08/15] midx: convert chunk write methods to return int
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <dbb637a7ac6d2cc6bb78428ef7bda67687095f88.1607012215.git.gitgitgadget@gmail.com>
 <xmqqeek6h853.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eefba4cd-4989-49ac-4967-264af9f99c68@gmail.com>
Date:   Fri, 4 Dec 2020 08:40:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqqeek6h853.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 4:50 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
> 
>> Subject: Re: [PATCH 08/15] midx: convert chunk write methods to return int
> 
> Please rephrase the title to avoid misleading the readers; it is not
> like we used to return the number of bytes written in size_t but we
> realized that we never write mroe than INTMAX and narrowed the
> return type to "int".
> 
> In other words, returning "int" is not the most important thing in
> this change.  What is more important is that the function will
> eventually signal success/failure with its return value.
 
I suppose "return int" is what I meant, but this is probably better:

 midx: return success/failure in chunk write methods

Thanks,
-Stolee
