Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE7C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIGOrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIGOrI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:47:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274599B6D
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:46:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h21so10564764qta.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8yUJNSwQ2Uj9ZKSgC1yj+v5IOhv+rRY8cowjjsVM+OY=;
        b=VKdj22CfRjIIm2vRl67L0YUjaTc8g5WgLLW+UbfFIt0Z08Ffti+x7dJx/kn7GyrFiA
         pXq2JFnMCgCHnx1s+bFyjPb3soWQe/i3BKliBpoXvxHc6carlvCWAVo5gpAomQl8Z2gW
         RctECi4P2x+rajVLSH03ZROldh+eWoThmJwtosOgWmvS4XOEFw8qT4bZBlSRBLrMdISb
         lYcdkDIAWIjGnl2vKQDhhSZJ3hbuB9e2a2MELvls80LrOe90kgEgYlY2WIu2LbjOxRNl
         zZ9wB+T7QchJyopYreB8NJZI6OyG0AnDXmwQXg6zSnyLINBjTvJCHRyyXkwuwZovuqzR
         XLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8yUJNSwQ2Uj9ZKSgC1yj+v5IOhv+rRY8cowjjsVM+OY=;
        b=2LFlI7CBBQOzbbug38Mj4Uv9hVMoq5vIbEZAmh5JK9juQZd0nKPacvAmA9E1tVgLEV
         Ua56jak6AIw9dMoeJ46J129nK3FxFaM01GbfweBNps0I4x2c1et83TBBb3Av+aW0j7Y/
         ZPv2pTNWR6t/XdL6iELKxYa9wbH6Ye1oNB7u/wEOOzCSM8uLeOp6YNcOSoqiDHjZgOF3
         cd4Y/MxKRsPplToArL9t0Qhf2BIViT5f4zsruFuXPMl/dqBuF+qhpeZuLZMmq4yFvesW
         qEaeVHC7scqrM0oZU8D//SBPufGjG17gLoetDQT4CrHtpB5qh75+YLe+aYJV7tLq3maQ
         zdIA==
X-Gm-Message-State: ACgBeo1q+Aoav89BQUc850byzFyzwLAlCiRe2gVh+vMZRchhb5xgb6zM
        g75XA8pXKY3Kbb+WgghunKoM
X-Google-Smtp-Source: AA6agR71q7SPtJIkuPFDWH6BYAX4qMXc2sbOcMXxQNKgo0DdgbtBK22PJfJGYr11ejEPBX8Wyf5gFw==
X-Received: by 2002:a05:622a:1653:b0:344:74d5:f6d8 with SMTP id y19-20020a05622a165300b0034474d5f6d8mr3429837qtj.689.1662562017297;
        Wed, 07 Sep 2022 07:46:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bj8-20020a05620a190800b006af10bd3635sm14174992qkb.57.2022.09.07.07.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:46:56 -0700 (PDT)
Message-ID: <60a47a3f-e4d5-2339-d79e-48e6a7d4a9f1@github.com>
Date:   Wed, 7 Sep 2022 10:46:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/3] parse_object(): check commit-graph when skip_hash set
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfScUATMQw9cB6m@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YxfScUATMQw9cB6m@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2022 7:06 PM, Jeff King wrote:
> If the caller told us that they don't care about us checking the object
> hash, then we're free to implement any optimizations that get us the
> parsed value more quickly. An obvious one is to check the commit graph
> before loading an object from disk. And in fact, both of the callers who
> pass in this flag are already doing so before they call parse_object()!
> 
> So we can simplify those callers, as well as any possible future ones,
> by moving the logic into parse_object().

Nice!
 
> There are two subtle things to note in the diff, but neither has any
> impact in practice:
> 
>   - it seems least-surprising here to do the graph lookup on the
>     git-replace'd oid, rather than the original. This is in theory a
>     change of behavior from the earlier code, as neither caller did a
>     replace lookup itself. But in practice it doesn't matter, as we
>     disable the commit graph entirely if there are any replace refs.

I can confirm that this is the case.

>   - the caller in get_reference() passes the skip_hash flag only if
>     revs->verify_objects isn't set, whereas it would look in the commit
>     graph unconditionally. In practice this should not matter as we
>     should disable the commit graph entirely when using verify_objects
>     (and that was done recently in another patch).
> 
> So this should be a pure cleanup with no behavior change.

Excellent, thanks!

-Stolee

