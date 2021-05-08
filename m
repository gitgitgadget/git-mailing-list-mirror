Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C2C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6F661288
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEHE2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 00:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEHE2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 00:28:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C3C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 21:27:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so5664413pjk.0
        for <git@vger.kernel.org>; Fri, 07 May 2021 21:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bF0etiCkQs2lvtZHPnRxrIy6c4LJSR7OwSL10pCnYNY=;
        b=mhxy5AK/7Sdx0sqSP4sRP98XT+pbwVnckH3uOlp55lhZBA6uM8b1pSrA35VGJHWt+j
         x8x2IbBNueZaHHnYzHUmAThguHGuDaJ1nQzNWJA44ws3gI5+4hmyobSxCFPykj2oN8AZ
         wQWJtM8sf5Y2ynxndkJ+RZ1RACLL1IG9McY+eeh7J88Y1KwDemJw/A1XY8bNvabBFlJN
         gP/ibTJl1iJ+5l9GAkkObGbNdIzTdYNDJS7rZSq8V+A1YP63zCNXVBsawUZhCSMGWS5B
         qV/7JqLajSh9JhJIRktUocu+tLMyq7gXU8AFIEcJ6VyYpy90idcpUt7t7pZTxrzefYFL
         zY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bF0etiCkQs2lvtZHPnRxrIy6c4LJSR7OwSL10pCnYNY=;
        b=W9rCka69s2on0j8MiyOZuFH/znIBm+6w7wqqneGuXF1fi8g9zGPGI0GBIGbK7/UtUZ
         LrPaGCQ8UtbgMKXKkhXcDUK3+sZIWgwUyZYw8lay9vodAmn2bT6LcTnzE56XAGlaRSck
         l9eGNa/edodF2BUxFvZEptC3pAPbcCH3mVqkz5K432qh/nmjQ44lLzuCFEonE4fIgpf8
         nP3SWnxUzgiaK19IBx0ioygZ2kGZsvyC/hcWp4wmPilhuxz+ayvcTG3XU7ptqrXe4UNJ
         xUD276zrdNnQ5rmuyz4AzCRmdRebr214gO0NYH8z9c3GDUsrMCJ/NcBVRRM4t4A781Il
         qKSA==
X-Gm-Message-State: AOAM532QjB+tfFB0dwwKn2t6mQjhYoJ3QZP2ibsddQnV2Dnn2BZTvNLh
        uCDsy8AFwt9dj+jcInTpuJaBDw3yWXM51Q==
X-Google-Smtp-Source: ABdhPJxogkZDOLODDp7Ok17ATkyLJp/9LzgzUQYKVyDIBDnKjQwuQqndB5k8vDJG4bCk/MfEoyb8xg==
X-Received: by 2002:a17:90b:1e51:: with SMTP id pi17mr25689490pjb.5.1620448024291;
        Fri, 07 May 2021 21:27:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id p11sm5804027pjo.19.2021.05.07.21.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 21:27:04 -0700 (PDT)
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJUyHkYAIth0W9dY@danh.dev> <6095c74993f19_cfc72085d@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <5130bb11-002c-9aa9-ac6d-11bfd6f85f3f@gmail.com>
Date:   Sat, 8 May 2021 11:27:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6095c74993f19_cfc72085d@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05/21 06.03, Felipe Contreras wrote:
  >> I think we're better to do like this:
>>
>> * If we're using asciidoc, we will use xmlto
>> * If we're using asciidoctor, we will generate man-pages with
>>    asciidoctor directly
> 
> This certainly is the way to go.
> 
> I'm not sure if Bagas suggested to make USE_ASCIIDOCTOR=YesPlease the
> default, but first we would need to make sure the output without xmlto
> is desirable, which we don't at the moment.

I'm not aiming for defaulting to AsciiDoctor, but I agree that we would like
to migrate away from xmlto by making sure the output sans it is desirable.

> So, even if we were to consider this, *first* the option to use pure
> asciidoctor needs to be in place.

Don't you know there is USE_ASCIIDOCTOR=YesPlease flag which do the job?

-- 
An old man doll... just what I always wanted! - Clara
