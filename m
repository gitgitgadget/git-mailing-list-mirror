Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F3C47254
	for <git@archiver.kernel.org>; Fri,  8 May 2020 12:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327B8208D6
	for <git@archiver.kernel.org>; Fri,  8 May 2020 12:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOtM4RQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHMQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHMQC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 08:16:02 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE750C05BD09
        for <git@vger.kernel.org>; Fri,  8 May 2020 05:16:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t3so1277701otp.3
        for <git@vger.kernel.org>; Fri, 08 May 2020 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Si97PSnTI3M9pWpV04l3WlzvAnLocIJDNNQ5BgG23PA=;
        b=kOtM4RQLTi0M18SLf7wHJLDsWsCAc0i8Y87ygZQN4WyxzFKLsxJM/ZhmTCu61C5Dkv
         6I1UBIk0SK+xsTDgz64QgqfMvQxssBgn3I5n4+x5WX/PzU8ex7Jx8Xr5RZ0T41qYFtRD
         2QMu4H4oXAY5tJpVPB62xHjXXzhS1gFUNbW+B64WUcUItAYLcPxKNV6HT2O7TNj31R2Z
         vXmALyhZYKtYgBuVbwvoVofAqfiSMr1cXg/XWfIquxCbfIBPlMRAvlCDAUiVX/2SORgh
         7Y4z2Dsj73vrB/SCxPFpa2uRnh+i1G0Yg+Aqk9uW97h5Nk+89Dn+OlNOGDUr5MRtrvgV
         yYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Si97PSnTI3M9pWpV04l3WlzvAnLocIJDNNQ5BgG23PA=;
        b=Ls4pys5KYL/3gk/buwt+nSnRaXnxv3b4EIZx0E2k+CRw1L+g7Yss4WAUdAtI8TgLgN
         +TE4yrJKP8LlNJpRxN2WCNtTq/hIsdKgZx7CEhIg29cbv7JAAZa7uoMVvL586efRrQX4
         5VCpqMZVq/NsFK3M6RCs3cqf9ZvBiTaDrEnTFpsRJSXF7mkq3voEoUtXXQGY1Zf+sQN0
         JbA3447LnlR+NBhOSUWaZR0QOOd3gSYYHSR6ClsLoxbVW5vVWXRn7KblDH8FIwBXwIKl
         9SK/Po4nMXXSm76litJZFwsetyS0rIM8X0agjHR0Ue3+1KMAeofRVHSYm1OZf9MnsSUz
         CVBw==
X-Gm-Message-State: AGi0PubY2pm1/EWAI6IIIvabZNTn7ns2eVAHosPbafjjJKcTHhFpnHza
        YDvawOytvjnyX/LYb7rhBLvbK5v85YA=
X-Google-Smtp-Source: APiQypJnp7pDsgMQo478w+yTytlxpjD7BzEZ9MUdujvSwu75FToYCxt6bNLRBeKlOBpa2TprsPu7DA==
X-Received: by 2002:a9d:6d12:: with SMTP id o18mr1892294otp.370.1588940161791;
        Fri, 08 May 2020 05:16:01 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f20sm338129otp.61.2020.05.08.05.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 05:16:01 -0700 (PDT)
Subject: Re: Subject: [PATCH] bloom: fix `make sparse` warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
References: <01ff8217-bd38-e7e4-58b1-81645ba9282a@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e0594ef1-d471-877b-81d1-980ba47966dc@gmail.com>
Date:   Fri, 8 May 2020 08:15:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <01ff8217-bd38-e7e4-58b1-81645ba9282a@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/7/2020 7:51 PM, Ramsay Jones wrote:
> From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
>  <congdanhqx@gmail.com>
> 
> * We need a `final_new_line` to make our source code as text file, per
>   POSIX and C specification.
> * `bloom_filters` should be limited to interal linkage only
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Junio,
> 
> This patch by Danh seems to have slipped through the cracks, so I decided
> to pass it along. The original version of this patch (which I don't seem
> to be able to find) clashed with one of Jeff's series [1], because they
> both fixed up a 'No newline at end of file' issue with test-bloom.c.
> Also as Danh points out [2], the original patch didn't fix up the test
> files.
> 
> Anyway, this fixes up some 8 sparse warnings on 'master' and 'next':
> 
>   $ diff sp-out sp-out1
>   17d16
>   < bloom.h:90:6: warning: no newline at end of file
>   20,22d18
>   < bloom.c:276:1: warning: no newline at end of file
>   < bloom.h:90:6: warning: no newline at end of file
>   < bloom.c:12:26: warning: symbol 'bloom_filters' was not declared. Should it be static?
>   33d28
>   < bloom.h:90:6: warning: no newline at end of file
>   163d157
>   < bloom.h:90:6: warning: no newline at end of file
>   366,367d359
>   < ./bloom.h:90:6: warning: no newline at end of file
>   < t/helper/test-bloom.c:6:30: warning: symbol 'settings' was not declared. Should it be static?
>   $ 
>   
> ... along with a further warning on 'pu', due to the 'ds/line-log-on-bloom'
> branch adding another '#include "bloom.h"'.

Thanks for being careful and making sure this gets in.

The patch looks good to me.

-Stolee
