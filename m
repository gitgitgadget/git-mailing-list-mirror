Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA48DC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbiCGNoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242951AbiCGNof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 08:44:35 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E41403D6
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:43:34 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so17708197ooa.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TyuYOaeifkUuq1Ph58h890l0dtQjgxReb+uxsAjd2Kg=;
        b=F2/bJP3qKdvm0hRcGobAvarWj0Hnk15Ey0Mh1S4Eqe9HKjj317mKYrBRq2V1d2NaPe
         lCesjhAcw/uwTwfGv1r5UWM7DzpdwmH0RiPTiVE5L0s4k7irhPSz0QD6VW3DzLN154zR
         /+LZ7fQC8tBSJ2rHl7Zjd7Rrjb5fbps/++dMqxvASS/U+qQVBji7nTRZRKB+hMw9i/Ag
         /q5EimRimekLDR7cH3WVfbf2s3oLhfTr+RHSyu5sNAGe85j67TiBi+kI/0sVbR4A25Lv
         0RFYfzHU+cDp6s05j1EmqvFN1K7V+LFN3SRGEgGiEEAQI7Z4Aiev/5IWUNNADY7s1P/+
         2fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TyuYOaeifkUuq1Ph58h890l0dtQjgxReb+uxsAjd2Kg=;
        b=k7RtlzUXSJNeTNqZSbIP3zePS5iUXLOs8FFNhbhbZPqb85ZZZKWgRylKz+D/c8Jr1J
         Ehyw1gUFTqa9twhMJNlGiHUnSL/48DDowY4Y9MrMxrohy5vEOjAHuPEMfvzqYe5Xqhxn
         MW/lx+rkz8oiQ3f02tYgbmEAocLkLNuK9W+TfhDp5j9SFoGe6jBYG4Y5NQi20gULQI4e
         tYTFkvRad65YtjxbADMhfqHwPUdxaWBQ6Tb+/0gdxrdf2HYEZt2hXlP+TXwhbph4qN1R
         COemTfvnORbMQNRx6YIuDNguI7XDDV0q+BMK+jgLmXCjwxjoNQY0e0KEAxaheBtG1vsr
         ZOjA==
X-Gm-Message-State: AOAM532uM5KGT8FSBf/dJ8lNqv1pLsOt8VnAZd1GXlCVJtgmI+L+WfaU
        /a/8K6w+k5LN+HMYfhCMX1Pc
X-Google-Smtp-Source: ABdhPJyctTnDRsT88tUELOhs6/pud/tU3mx+ZCwMKSIcaSK3LENbOS20Q4CCrRmWHsKKUirK7UvGOw==
X-Received: by 2002:a05:6870:73c9:b0:da:34cf:a3e7 with SMTP id a9-20020a05687073c900b000da34cfa3e7mr4264600oan.37.1646660613412;
        Mon, 07 Mar 2022 05:43:33 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p1-20020a05687052c100b000da2ef5ecdesm2350561oak.44.2022.03.07.05.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:43:33 -0800 (PST)
Message-ID: <34eb7b5a-180c-0e4a-0929-8eaf52f80090@github.com>
Date:   Mon, 7 Mar 2022 08:43:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] string-list API: change "nr" and "alloc" to "size_t"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
References: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
 <patch-2.2-398682c07aa-20220307T113707Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-2.2-398682c07aa-20220307T113707Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 6:38 AM, Ævar Arnfjörð Bjarmason wrote:
> Change the "nr" and "alloc" members of "struct string_list" to use
> "size_t" instead of "nr". On some platforms the size of an "unsigned
> int" will be smaller than a "size_t", e.g. a 32 bit unsigned v.s. 64
> bit unsigned. As "struct string_list" is a generic API we use in a lot
> of places this might cause overflows.
> 

>  			printf_ln(Q_("The bundle requires this ref:",
> -				     "The bundle requires these %d refs:",
> -				     r->nr),
> -				  r->nr);
> +				     "The bundle requires these %"PRIuMAX" refs:",
> +				     (unsigned long)r->nr),
> +				  (uintmax_t)r->nr);

There are more additions of unsigned long here, which will possibly
truncate the size_t of r->nr. I must be missing something here that
explains why you are making this choice.

Thanks,
-Stolee
