Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CFC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8266B611C8
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhHUIZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 04:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 04:25:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC1C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:24:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so8832474pjb.3
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bux4OOWLVZOsAvBqejYAbutCjCZivdr+s2j33yNboE=;
        b=YKPO+qDDVoe/G1QdCi2fwyNtRb9S+aI7quoW5MzDHlKE4QvOB74o+tutHGy6TF6+Z9
         +oZHILLFFLsJsqiOTEJJI/hXBK9rR2t7Uvj181BrbhQdaHJoOxANUBXPthC6Z1NT1OwN
         9oPmjsSX1VfEeosP3OYxrKUANEdM3CqzdbVP3tZcFaApyl1OlWr89ic/lB8MNlrWvjsR
         hPNj3kz/u9mh8BIW3L1Nj6tLxE7B90WVKnLxDU8a9dyXqUBTZMDn4RNUhhh+RrytCi9C
         E34P2zFKW9BVl7ku0Td7u933fEmdS8qtlTVuV2q/anGAqlh/vL5dix83M/99lVHNPl3a
         ROlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bux4OOWLVZOsAvBqejYAbutCjCZivdr+s2j33yNboE=;
        b=QhtzoQ4rLRxxivSlMbxyNfvqgjw0BnuNtb0Jnr/0b/pCIqnG2ZNNax+oy6Ewu7VmAZ
         vEIB4UUoIElCVZBZI+ZWqUTTDQ5rE1KGHzQox+Qim4Bt+ZySJhqyk3bdW9LqgutxWFLP
         ZQXjVPRzstGAvEJVBTTgZCNJXWajL3jRZTQ+ho7uTsFkGsW62oqphT/T3kcJcrAlOxTB
         JKx0Uh+2I0go6qbY9w5LKbu9NaR3MhdqwEUbP0SLWBOkWg9PrGWm1J6/3ARFR40/4Rud
         wXAZwqRshoD6OanM8I77vYgfQBQXKxXGuDeYcsyxWtXU/IlMzudycJPtRCg8uP05oy7l
         LN7w==
X-Gm-Message-State: AOAM53233pwlRpLfRxNrLZLwh+bjfoYU70Ia+TWan+oB4iNou6lnC7SY
        XS4rCeT7NOHwDSkB+94lY78=
X-Google-Smtp-Source: ABdhPJywinlYXL36T9TFJybPtQxFS2JpNH1b+hEb4/TgKCz9c/tI0Q5aq5vzsgba33Z1TkEtgm/r8Q==
X-Received: by 2002:a17:902:e8c2:b029:123:25ba:e443 with SMTP id v2-20020a170902e8c2b029012325bae443mr20302585plg.29.1629534265887;
        Sat, 21 Aug 2021 01:24:25 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-6.three.co.id. [180.214.233.6])
        by smtp.gmail.com with ESMTPSA id r13sm11474944pgl.90.2021.08.21.01.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 01:24:25 -0700 (PDT)
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210820105052.30631-1-bagasdotme@gmail.com>
 <YR+Tp2AGeeKyRKoC@danh.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <70e609f5-bf40-658a-a021-ab7a0ad4baa1@gmail.com>
Date:   Sat, 21 Aug 2021 15:24:22 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR+Tp2AGeeKyRKoC@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/21 18.36, Đoàn Trần Công Danh wrote:
> I believe it's better to write like this:
> 
> ----- 8< ------
> ifdef INSTALL_STRIP
> install: strip
> endif
> 
> install: all
> 	....
> ---- >8-------
> 
> IOW, install depends on strip, not install invoke strip.

Oh, I missed that.

> I think it would work better for:
> 
> 	make install strip
> 

Wouldn't it install unstripped binaries to the prefix then stripping 
them in the build directory?

-- 
An old man doll... just what I always wanted! - Clara
