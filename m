Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3BEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHKPLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjHKPLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:11:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249B18F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:11:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317dcdae365so1791477f8f.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691766659; x=1692371459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6u+r8gR1JPtvUkcMy8C4+xdX21qD/mJA4VVOx8GTUQ0=;
        b=TCVhoSyDiT/LBro9AaIhv8mgaoBL6XeQPKQLZwJEbY8kM9QchltF7f3vTnxPzzP+39
         17xpR8r2dFPqEPZYignCJf+0PSvHrniLLEwltJxNlRjHXngOmUYQH2dFOnVSvrxjB7PY
         y+71x2H1qab6QmYQPz0UuuqkiCdme25YBvDhMs8mjukW3t0z6tBg7g6CedlSxItM8Dic
         mUOe2bsUj4yxWjoBwmy7KGIOylect1L4Xq+GImdfrkQifhaRKsAkIXwOvk3Q6rpsQQgU
         LyeepE8DN1B7Vk9+Mmo02CJIZLGdmX2rxIUaWwlO2fTEorUgw7MZEIOD7kMx7+k09N9C
         /INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766659; x=1692371459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u+r8gR1JPtvUkcMy8C4+xdX21qD/mJA4VVOx8GTUQ0=;
        b=O2GV3AfI8FlrSAyyoTBxpzXeJ7ljmlwmc+AGGAl9SDUUnxiEZuPbE/tmqt8FWikqyC
         XO8ZOx8DpCd3VGVobCvQpK/wevR/RvSWdhhqXyc/YzUgf6GtSCbcRGT3CAU2NlzqkJ4E
         xUO3hLxvZSE3oaVwRh4X3gS9NNXkhu31MUnWPwyTLRlPFCArWkKX9NawwnjShBS9RtXn
         9Fvr2EgalWy+HlqVOsgNWBzG0ZVdknQibIFzH7DNYPnkHFqHzJ3BXfhZ/2faZpFB/Qvc
         RQSwy5kjT7FbhFRm8tOwn+nfkE6yIOSHCQduXFwdp4mJabtbfDgYrNpOQhGX79zHPok1
         3Icg==
X-Gm-Message-State: AOJu0YzOZbomUtzLYqH7KrATxztqw7atbaLAvN7eOlGhQApJg4HpAI/f
        HTMBfNZNBxJBKQ2/9pTTWSw=
X-Google-Smtp-Source: AGHT+IEF9jdq4GpmUZjCU3qN9fuFB2EBco94+1kHbLpErbtsopUdxp/UnbrQ9yOz0LRhz6EwlzlxEQ==
X-Received: by 2002:adf:e6c2:0:b0:315:8f4f:81b2 with SMTP id y2-20020adfe6c2000000b003158f4f81b2mr1605465wrm.64.1691766658784;
        Fri, 11 Aug 2023 08:10:58 -0700 (PDT)
Received: from [192.168.1.116] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b0031437ec7ec1sm5713305wrq.2.2023.08.11.08.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:10:58 -0700 (PDT)
Message-ID: <07028529-cbe1-55d0-4ab0-9f3ec03a4fd1@gmail.com>
Date:   Fri, 11 Aug 2023 16:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
Content-Language: en-GB-large
To:     Linus Arver <linusa@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com> <owly5y5mh81i.fsf@fine.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <owly5y5mh81i.fsf@fine.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2023 23:00, Linus Arver wrote:
> Linus Arver <linusa@google.com> writes:
> 
>> How about
>> the following rewording?
>>
>>      While git creates a basic commit message automatically, it is
>>      _strongly_ recommended to explain why the original commit is being
>>      reverted. In addition, repeatedly reverting the same commit will
> 
> Hmph, "repeatedly reverting the same commit" sounds wrong because
> strictly speaking there is only 1 "same commit" (the original commit).

While it isn't strictly accurate I think that wording is easy enough to 
understand. I think it is hard to find a more accurate wording that 
isn't too verbose or cumbersome.

Best Wishes

Phillip


> Perhaps
> 
>      In addition, repeatedly reverting the same progression of reverts will
> 
> or even
> 
>      In addition, repeatedly reverting the same revert chain will
> 
> is better here?
