Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2821C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA49F6120E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbhIIOlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242380AbhIIOlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:41:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D9C057FBA
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:04:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso1587959wms.3
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILF1lKronwwKjc9aV6eAlHQzXLx+Wro482Quwig3IrI=;
        b=e8Vj2946iMQPswbjU3nWRppNUqMPgtr0JmtqRGYhvlXUa31IPM03QTIOw3qtQhk4Yk
         D5FaVcnSR4F18GhehaM8fWOcj0pgonFLbGfzl3FGR/9yIlFLzhcuvWN64BUxwbBLAZfH
         izWYle0BMEiOJ0MxV0RHIJWbNeZnjTD7OKmBDjoS0Mw6lui7YxTYjxaRfbRNvXzMIZ3f
         LGGxICslxgsSjIMJKZvSshzTTq478JLQDmMIbu0fj6tj4KtFtRXpAf3O5Ol/GnNwDF/I
         0ivzg6sdKlPRPEM5zXKpZOKz8b1ZCRDOvYb1XhdBCKLTqwwqL63skL21JMoxDZtegAQZ
         MMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ILF1lKronwwKjc9aV6eAlHQzXLx+Wro482Quwig3IrI=;
        b=WUKrKcubu4HntZzC3uoejw9DQeNVKo4mVJIWBqB5seAYjOQZM7BUlEbjLKBa3F4fnv
         Kf9RXgpyp6Jwn9GpyGGWEnAuUGFqStvskZeNfBB+57F83Hu2JkRuXzlRxuosXMvtfVrc
         1QA1Bj/dj8kqc743DfJdPiIFZWAZZlLi1+BAz+lTUnfRSQ2rtLgepxw1Zppn9CF9Y5Cr
         cI83jn74C21dYqFroKE3milkYIXy6WacmevfHY7i0/wnrN/FlIAjFmrQqplkNBbCE9Du
         Q2kwSGDCJmFrI79V48GGlwtE3vPrjSIDZEDfH4lekJvIhxXhbDzq6nRQbg7Iol1IWgqf
         ATEA==
X-Gm-Message-State: AOAM531LlzaDZAa3WUL+M/w2lc59zZqusNR0K6OhAxDWyQjqEtPZb1E+
        1yT0Tmzpan+RZ0Enaxa0HrQRujR2M9w=
X-Google-Smtp-Source: ABdhPJzdiECzH6NkCcP2jX3jsxhuUVNu1I7yti5WkU8gTiXbmqhjB1kVYBHyiLIP4FMav0xKi5WjqQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr2843343wmm.57.1631196260867;
        Thu, 09 Sep 2021 07:04:20 -0700 (PDT)
Received: from [192.168.1.240] (187.96.189.80.dyn.plus.net. [80.189.96.187])
        by smtp.gmail.com with ESMTPSA id f18sm1644568wmc.6.2021.09.09.07.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 07:04:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] rebase: remove unused parameter
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <c8a92d4242b4dfad71297d1eec9c3ef658641193.1631108472.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2109091254010.59@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <632884f6-ff63-23de-c043-0848939b4e15@gmail.com>
Date:   Thu, 9 Sep 2021 15:04:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2109091254010.59@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 09/09/2021 11:54, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 8 Sep 2021, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Now that we use reset_head() we don't need to pass orig_head around.
> 
> Does this indicate a change in behavior? When we call `update_ref()` with
> the original `HEAD`, we get some version of safety in that it will fail if
> anything changed the ref in an unexpected way in the meantime.

Good point, it looks like that was overlooked when the am rebase 
starting using reset_head(). There are already too many arguments to 
reset_head(), I'll look at changing it (in a separate commit) to take a 
struct of options instead.

Best Wishes

Phillip

> Ciao,
> Dscho
> 
