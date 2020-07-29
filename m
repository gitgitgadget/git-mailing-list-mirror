Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025FC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA442075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJWCKwGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG2TTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2TTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 15:19:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EEC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:19:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v22so12602888qtq.8
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGNbAihZTFX/hcDztNq9wlxOrg4wGS/xrxOokJLeVCw=;
        b=SJWCKwGfkDUf6T9CAUNJxRjHPJ4FCXzwz7l9ZFFaVPg7ZWRcu4DNq28JbKSZG3itRI
         sNa83IkOyFb2ZhVD4aOX5IbadqLd8zKItDGuFB2rjv/OQilCT9zGBrLG4UJnl7Y7EL2y
         +Ic/+38xwRMPdK12JNFevN3jtl4/7eaqXy29a196YAdXiO28+3c8WybttVG6ttYmmwAb
         51JZpQ53kDr2q+VLxyRLWm8x3jHNF0RJ41pphZAMz1JOCnrr0aHJ4nLMgETJHpE8c87o
         spDLTl0FeHVX2HEKxmeIXRhNE6tooDRUhrULGjs3SDP3K0sYZ/Gk1QR0XuAlpHyNrfY+
         yVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGNbAihZTFX/hcDztNq9wlxOrg4wGS/xrxOokJLeVCw=;
        b=WWs/5LB2gOZoB/PdYZZtMPLQtjjXzUTr7xSqv6Te0gS0mV3n0ee/IV9aCFrdndhQOk
         h6x/X2z/cHa/TxCUiZhFiz/GW/JPvkZjlhunSLMrVOMyJgRhMNE8NNU58oxNOorKw5Yp
         +2qz5GfAzMFVHIUjA4X1hEX6BjaycvdEfRtW/c64dK2UAdInD7IQ/nloZyJxiQOWTYbb
         7aJ0MZKLDU9V62alm2IssCeGcUzZHkO8acLOikHkswVfb2dn32FGj/QlAEvJq7+2nkmw
         mWVtLtLd0P8soBAydRaXuXYvCt3oKW2qIoqyMNTDJIiz6NbP6sNRB0E1fgfbm+3fy9hJ
         FFSg==
X-Gm-Message-State: AOAM5314Xcx/pYiJgeshbKHH7s9Ln0S/WoaClUbmaV9pQm8Z/q7J/02B
        zn/yQbatf2SH7axopf5x1Is=
X-Google-Smtp-Source: ABdhPJzN87ZYZN1HfznphoNGcXQYfx+dRUK5BQ3NakfVkgEJ2XZsLKF+lxEY0eNFoeYEqSc84+UHsw==
X-Received: by 2002:ac8:198b:: with SMTP id u11mr14835786qtj.31.1596050374035;
        Wed, 29 Jul 2020 12:19:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id j31sm2386209qtb.63.2020.07.29.12.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 12:19:32 -0700 (PDT)
Subject: Re: [PATCH] comment: fix spelling mistakes inside comments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Steve Kemp via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Steve Kemp <steve@steve.org.uk>
References: <pull.685.git.1595993608886.gitgitgadget@gmail.com>
 <571792b3-e65b-e6e8-34b9-56a87a47de8d@gmail.com>
 <xmqq4kpqb301.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2eeff10b-38e3-5d6d-6805-ff7920d52244@gmail.com>
Date:   Wed, 29 Jul 2020 15:19:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kpqb301.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/29/2020 2:16 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> I'll leave it to more experienced contributors to comment on how a
>> comment-only patch fits with this section Documentation/CodingGuidelines:
>>
>>  - Fixing style violations while working on a real change as a
>>    preparatory clean-up step is good, but otherwise avoid useless code
>>    churn for the sake of conforming to the style.
>>
>> In my opinion, this change is not harmful, but also isn't super
>> necessary. I could go either way.
> 
> Typofixes in comments has no chance of breaking things than a
> carelessly done code churn made in the name of cleaning up, so
> cost-benefit comparison is much more favourable.  I'm sure that I
> won't be exhausted after reviewing comment-only patch as much as
> after reviewing code-churn only patch.

Thanks. I appreciate the context that provides more clarity.

Steve's patch with the de-duplicated sign-off has my full support.

-Stolee

