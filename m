Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF4420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeLNVb1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:31:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42781 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:31:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so7810361qtq.9
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=I5Fw8sI/zKlvvh+YOPPlcSHhS5UqBhh3irTDA6G4wBE=;
        b=k9fRntsK+jw8u4ydKS4A9cxV4L1gQFrCPuzJpDgqUfxApyObEthNKjJoFnUaCdVAas
         sSCs3s4g/nTv+iOYIJRkw2jIEScpNrdCj+GQZ2yda6zBG9qg+em4phRnF2oQisOCSoqQ
         9qvLh9Mz0VwZr6sFP72ajNXvkaKv6FRK9wJPL0Z8B9MkdRARW5H5W+9oKxQU+h01dfsJ
         RT2NFmxR9L7ttv0NuqWu2GE8qYlz32M8/z10M0prh5jAB6BOAcWNjOUPIyg0AGDv7Ywh
         yP00Lpu1SWoYiCywNzQFnOGZADy5MwbjNwxgtZWYhuVeKUaJ0X2OLmS6TRze2TO0tBdL
         xZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I5Fw8sI/zKlvvh+YOPPlcSHhS5UqBhh3irTDA6G4wBE=;
        b=CdNQo8cS15AoGBGiLcx3pTuVuiQ3rQvx3CWnrIJWOABSTZ/mVSzB2m9W0/25ytdC8h
         OCW33gQllMe9HyNzkcO+k9mDSAJ7m0MnkIGEn7nMrtnkDKhxTnVcukW/Sgrzctv5HIiK
         bxgNzGzlX0vsd8mhHy5mEQ7P/zbdvvt3PD6Cmxr8Rgo2rk2jXSLB5ZZ3gHpbLr31vSLH
         6aRmh0aUojTbZz529qDBB+XnvRTdPx8efSbZCaXwyOLxvbxU/wczFfHKy4L3uxE77P6d
         NSQJIJAhN8+aQnIV0MdFWlD55tp5REwhw0QeiTR2qudbNYhI8Pc65+JCniq5YrVCE2rP
         P8Wg==
X-Gm-Message-State: AA+aEWZiIRsC/NzdM7Ch7qCjvJDetGy2Sp2CSb4G0BFQG+kcQqs19kJt
        2raTv9OVxNxU7vEbESzKtoaSE7cP
X-Google-Smtp-Source: AFSGD/UEA1ZGM335Cau0vv5wq1xGinERLBi2TeHlkhCDiPSkuq1h59PcETM1KdWmPJ04RT4i9+yFtw==
X-Received: by 2002:ac8:7616:: with SMTP id t22mr4609426qtq.375.1544823085777;
        Fri, 14 Dec 2018 13:31:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:cc78:781c:161a:5c5f? ([2001:4898:8010:0:b5ae:781c:161a:5c5f])
        by smtp.gmail.com with ESMTPSA id q21sm3860174qtk.79.2018.12.14.13.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:31:25 -0800 (PST)
Subject: Re: Git blame performance on files with a lot of history
To:     Clement Moyroud <clement.moyroud@gmail.com>, git@vger.kernel.org
References: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3f3e7b11-19ef-cc2f-3bd4-e03d9ba8dc91@gmail.com>
Date:   Fri, 14 Dec 2018 16:31:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2018 1:29 PM, Clement Moyroud wrote:
> My group at work is migrating a CVS repo to Git. The biggest issue we
> face so far is the performance of git blame, especially compared to
> CVS on the same file. One file especially causes us trouble: it's a
> 30k lines file with 25 years of history in 3k+ commits. The complete
> repo has 200k+ commits over that same period of time.

I think the 30k lines is the bigger issue than the 200k+ commits. I'm 
not terribly familiar with the blame code, though.

> Currently, 'cvs annotate' takes 2.7 seconds, while 'git blame'
> (without -M nor -C) takes 145s.
>
> I tried using the commit-graph with the Bloom filter, per
> https://public-inbox.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/.

Thanks for the interest in this prototype feature. Sorry that it doesn't 
appear to help you in this case. It should definitely be a follow-up 
when that feature gets polished to production-quality.
> Looking at the blame code, it does not seem to be able to use the
> commit graph, so I tried the same rev-list command from the e-mail,
> using my own file:
>      > GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y
> /path/to/git rev-list --count --full-history HEAD -- important/file.C
>      3576
>
Please double-check that you have the 'core.commitGraph' config setting 
enabled, or you will not read the commit-graph at run-time:

     git config core.commitGraph true

I see that the commit introducing GIT_TRACE_BLOOM_FILTER [1] does 
nothing if the commit-graph is not loaded.

Thanks,
-Stolee

[1] 
https://github.com/derrickstolee/git/commit/adc469894b755512c9d02f099700ead2a7a78377
