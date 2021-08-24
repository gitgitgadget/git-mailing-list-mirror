Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CDCC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2C4610F7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbhHXSCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhHXSCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:02:05 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCA6C028C37
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:47:46 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id eh1so12152599qvb.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JjGpbulXOE8KPp74+WeR/uNfLGiKUEL2z0c76KJTzHo=;
        b=i9UyxMr94Q09ZFb9GpiQQCyZmvBjpa8wDO2doWkr3F83kmguqIcSGpepNaKe2nZLJJ
         a7OoFPDSP8sDSCl2+vLwy/oKr4jivjELyRg4OTRZwti4PJl2r3TxfVw2k7/CAGblaaM5
         Wag4TiRVfA1mI4uDAqyDrXfkM0rKSbzi3tfqv+wSnSXVKPL1oEOZ0Xah1eL2voxVIV54
         ZXPr/ihLyFF23TBdp/fRLm+WfmMzwDsjoPj/lhk03ecmzuddysP+1DlS8TB+Sm1Gtbiz
         VjVUUJcWMJm0WDXT/lBLMJ469Eh5VGePAgH2coespAIMLi9mdDVh0kGGUm6D9B8XPQmS
         EuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjGpbulXOE8KPp74+WeR/uNfLGiKUEL2z0c76KJTzHo=;
        b=BhDkJAHNzTg9FQKFyDSyRsVfNFnz9t1+vulb+Jsf55C9RnwcqMsLHhpiA6YbTGqIAm
         1P4gMWTLt9fpl+syQkOlwDsxa7T8Ci2/6co34oZZZhG0NDlXtpgxxqj0x1KHsg6xqEk3
         vD/SpFDtBmi7XuZVu0lmkJoj/E/naBRiACUn7/4NSTkFT7vsRUa+Lzewd+YezuOk3hI0
         uzfgoxUwbYT4fLPD+jRxO49KFj1znq8qCf4b+zfSiTf24RIqeOGbIWbx5gXdWC2ac37W
         K7T8zSPjhJB6Vpn6Hsmu4VVFmZlULYGyzZXxyk5w69VAd+Op93iYPxEpxXEkP3WfEBNJ
         4WsA==
X-Gm-Message-State: AOAM533y+TOGW8yOIFQuGBCXBbZre3JDLSyihORiHCd0R2WXJ4MCCw9A
        SNQHyXwffStdktN5+qsI0ys=
X-Google-Smtp-Source: ABdhPJxI/en2xCnBroaVZ41JVSf4hxprFBKagVN9sU/q2pF6q1L2CvSuXkGix+Wjd8CG+/cl+6D0FA==
X-Received: by 2002:a0c:b2d5:: with SMTP id d21mr40151019qvf.33.1629827265860;
        Tue, 24 Aug 2021 10:47:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id d9sm1264514qkn.124.2021.08.24.10.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:47:45 -0700 (PDT)
Subject: Re: [PATCH v8 0/3] maintenance: add support for systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210823204011.87023-1-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <44904983-a6a8-d72f-24db-50bf112c585b@gmail.com>
Date:   Tue, 24 Aug 2021 13:47:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823204011.87023-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 4:40 PM, Lénaïc Huard wrote:
> According to [1], there were 3 changes awaited in this v8:
> * The two already mentionned above (utf-8 characters and
>   `string_list_split` thing)
> * An improvement around the #ifdef.
> 
> I must admit I haven’t touched anything around the #ifdef in this v8
> because I’m not sure what to do. I’ve just asked for some more details
> in [2].

I commented on the relevant patches, but in summary:

1. I think your #ifdef __APPLE__ is fine in patch 2.

2. The #ifdef __linux__ in patch 3 could be removed
   entirely.

Then there is a nit about whitespace, but that is easily
rectified with 'git rebase --whitespace=fix'.

Thanks,
-Stolee
