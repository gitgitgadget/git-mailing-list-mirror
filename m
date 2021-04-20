Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33302C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D9E611F2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhDTMkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhDTMkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:40:09 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CCC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:39:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 8so5337661qkv.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpMeUqW3SAjg48S2j+nS42jLbzlyCIWP7cpCRrU3b6M=;
        b=ao9J6rStnZ+bHVzsiQ7v3XSGR+csyaXfY/a4pCtqfxernYbN3Hclv6ZApGjNIUxDWt
         MbKwyS+72a/rbRQOryC06LK1t8IIgDdhqRIMN1GvaXcxJScLkh9fLP9rlUJnXblHGSqH
         AOxtHohH6owJTjuExbNtdXvbsElxQZZR2koQWO9JrktXLcEsBSMVizayYHi42pBq/+5n
         BF4EjXBHFhSNaKgthdq98tFMIjhjsOLIYnQo7MRYoPrnSi6lG/cC9hlN9ShfDMD1rMM/
         cQGxDb0O7/OpalqTLE437lx4DksnAa2nktsBz3rgrrt0mNyW16DQI7ySpasdmPZc2dfK
         /Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpMeUqW3SAjg48S2j+nS42jLbzlyCIWP7cpCRrU3b6M=;
        b=kdJYsIkm0HCn53VgeMPbjmmaKKB1iRz32wCDIlA/m/Z1dXHCMEqp0ZT10n1smBj0U+
         XLQ3uJz1TcrgFxHeW+ff4U0q7qIEuNp6nxYhZkmDivwdyW61b+9un5fpAtgJPodx8hKu
         tjYodvibCEaYQIyLIfiP+v3L+Wl/ThI5x9Zeyt/CZAagHh+tHuVqha4BF8BNySFlccSg
         DCvBddoZUU9NcvBYhqpEjlPXDJJva+GoCcbWwEThCz1WtQmhL/mqdSaieqJ8Ez+BpMQa
         HW78hQhcpJ76A0UqVFG4+bDON9EBrpcK84P7A7y1yQM2sQHYW1xC6/aR6X4UmpBNeikG
         oHBQ==
X-Gm-Message-State: AOAM532fN1IQLdjhzyzWViJy9nU9PkyPHptgQFjnFlCz4etz6ddUtSjS
        pfyBpsQ7p4K/YWC0KbmGKUFNA+f6aYE13Q==
X-Google-Smtp-Source: ABdhPJzNpt0KMQxAhjz8+K1hNCnkZQAXDRn0nliaTPA6It3QgZ9nLlcgLBd+etEMZoZLqWhvCtmPXg==
X-Received: by 2002:ae9:c014:: with SMTP id u20mr12059320qkk.55.1618922376767;
        Tue, 20 Apr 2021 05:39:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:55ce:eccd:370:7010? ([2600:1700:e72:80a0:55ce:eccd:370:7010])
        by smtp.gmail.com with ESMTPSA id z2sm3684091qtu.24.2021.04.20.05.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 05:39:36 -0700 (PDT)
Subject: Re: [PATCH] builtin/repack.c: set a default factor for '--geometric'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
References: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60af51b7-b2a3-8acf-f7a0-49a137daf2c6@gmail.com>
Date:   Tue, 20 Apr 2021 08:39:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/19/2021 9:47 PM, Taylor Blau wrote:
> The '--geometric=<n>' argument specifies that each pack must contain at
> least 'n' times as many objects as the size of the next-largest pack.
> The factor 'n' is customizable, but setting it to '2' is a sane default.
> 
> Instead of making the factor a required argument, make the argument
> optional with a default value of '2'.

This flexibility is nice.
 
> To ensure that the option is setup correctly, modify the most complex
> test of t7703 to drop the explicit factor.

Good testing.

> --g=<factor>::
> ---geometric=<factor>::
> +-g=[<factor>]::
> +--geometric[=<factor>]::
>  	Arrange resulting pack structure so that each successive pack
> -	contains at least `<factor>` times the number of objects as the
> -	next-largest pack.
> +	contains at least `<factor>` (`2` if unspecified) times the
> +	number of objects as the next-largest pack.

The parenthetical interrupts what `<factor>` means. Perhaps
rearrange:

	Arrange resulting pack structure so that each successive pack
	contains at least `<factor>` times the number of objects as the
	next-largest pack. If `<factor>` is not specified, then `2` is
	used by default.

Rest of the diff looks good.

Thanks,
-Stolee
