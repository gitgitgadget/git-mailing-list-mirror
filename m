Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64841C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 12:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE9601FF
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 12:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhDLMPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhDLMPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 08:15:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F45C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 05:14:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so8705562pjb.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vqu8q+7gZ0CsWbwzNNc+2sGO8deQFB/bf4jrXZucs1Y=;
        b=Hh4drE06ZFfu4QhUA95jwPoIApXlOwEikjFmJOPEgCouv7pjkmDAim2dh1YhC8+Oxp
         0euPLMxks1W+9wxzBxCUGzent48vGO6rjQucGhmEUkF6PYEAlxoDYI9iGxdziNzfdfxH
         VCQTcC613WzTa3duxdoTzr9GcwyY6AckPWo6rwPb+0ONUGyOqsaxDqQUgx6TU1oGROQY
         69/Wwku7hXZnGGTw4bxSBAJj3NSGuxGzAkVg6jmbqKdBlf4SP8vjU9lnwk5j20uBJfy8
         fPSKFX9z0GZYpG3qRIM4mf44zhBM7A8P1cPpP/Aikp7tPM0Mo8ydgwGbKZ/w9kwEbXzS
         FuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqu8q+7gZ0CsWbwzNNc+2sGO8deQFB/bf4jrXZucs1Y=;
        b=Mo4qWgB+ba0PVbhQOp1daUY5E4elsj+P9sW8SNstpWXkZYyjhqoF7dw6VxbN9PI2xS
         G0BAF22xgac/drkLEDQp/MZiysDikUDGU8gy5Lj1/6+fiOdgZxJWFC0LRQyyDVcvxMUa
         X+ageAwIdKckEBTtWLhJJo5zf53KG6nEDNT8BM7bjrEt1G9IHNDqvGxrmCo/ERbeIymx
         sKyPu8K4cvjaBk6h1vW8ftKrPmyR3eI155z27XfgqNPYvnnqxPPZybjmZsYceZooVz9/
         nFO95mP4fe0/N0+hmD8MP+r+pOxxrsih2/vZcIDh4zJC/WCi8hfnzgOLo4Yh/8N0JAy+
         55/w==
X-Gm-Message-State: AOAM533OQPI27PASoDlz1BnKaSt5Xp5clffnmVfpirlmnLd98zDuqbMS
        s/6rBASzbax06rdgFLix29Fw8idx82aoiQ==
X-Google-Smtp-Source: ABdhPJzPt0ImdTXRgSc2vomSv4ldAKtWhFr/tVfvjHwo9mqvRfIabM7T+Xvaxn+f/Ip0kWRyi4cAZQ==
X-Received: by 2002:a17:902:b185:b029:e6:6d17:6ea with SMTP id s5-20020a170902b185b02900e66d1706eamr26418406plr.40.1618229696058;
        Mon, 12 Apr 2021 05:14:56 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id np15sm10711289pjb.3.2021.04.12.05.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:14:55 -0700 (PDT)
Subject: Re: [PATCH 0/2] C99: harder dependency on variadic macros
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <67645f4b-b320-3ed6-bf5d-552bae0c2688@gmail.com>
Date:   Mon, 12 Apr 2021 19:14:52 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/04/21 18.02, Ævar Arnfjörð Bjarmason wrote:
> But I'm submitting this because of brian m. carlson's note[3] about
> wanting to submit more general patches for declaring a hard dependency
> on all of C99.

I think we should bump standard requirement to C99, right?

-- 
An old man doll... just what I always wanted! - Clara
