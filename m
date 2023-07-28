Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983FDC001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 13:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjG1NJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjG1NJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 09:09:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75219BA
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 06:09:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso32122811fa.1
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690549763; x=1691154563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EpDIsnHBQBF6s3yYSkMLStQwW76d4oblHLvrNk5bZz0=;
        b=jp52btGEgdwMIUqfZLI9UYLwRAuGkIFLsXMr54xIpLjWBPBRS4A/KpgbbFyW7iVIAn
         uaCZkJgmm5Dum2X/VE3CuOMvmlgzeB0wph26x/JfINdJN47raRoa9lE67IuA9wy5XUv0
         drw86HEjwa0tnpThkgdEVy4hvBX7kAHIaaOzZFbt36LYFQmosuH6a629v5iC+AfY8GP2
         tn6rRkk3W3/xog0nyVb3mRODg2Ae3cphblucK2HX3NgTdVn+8OZoFrpvSMLzPq7FNb2O
         LC9PBmuJMDlvf52/jGXvPxX38rHbHT1R4XIdjLioARD6lyHanT/de6u772eQhMIj2V7F
         HNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549763; x=1691154563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpDIsnHBQBF6s3yYSkMLStQwW76d4oblHLvrNk5bZz0=;
        b=CcnKiRBrSpHmyPavmnmEUFC8TwghQA78r5IIjluMpVj+KNv4780LCAKjC6XkrrNFaj
         r9nOGJX/p02lZ4epUAXz72tUdF48DvBNAKwSaGd3hbqBvgq/7m6/AUSjVc1ezQDg9jh6
         uf0m0opx7Ld63jJ/2tAIr7yKV3PbKpy7vYexiUgFv3oY4VOVDD91QhbcZWeA3qKjpW1P
         YruFJuvLeKNpqaswJflrqJExQuJ6/GgmEGqQqiWooCFIpSb+SM3Q3eUMRGMaSH4Ubu0i
         8lFeW5GbyFzG9CRlTWeJPFM2FfxJE3Xsn25T1xKX80ZKo4mxySd2Xxf0Upd7B+TknIoI
         YvKQ==
X-Gm-Message-State: ABy/qLa+sKhXJc7TtdPthvQNcoHvNobh2u+CYRqIT8ftz8UeguOPjvXI
        hhm5iUpKZCxLls6+Wlcrq8U=
X-Google-Smtp-Source: APBJJlGzzhPb/WPNDEIh6TXVLBEzV9Vxc/Ppa5r6jLlvGLoVjKJLO4MF7+uxa/SHPKaQWo2lrIlfnw==
X-Received: by 2002:a05:651c:446:b0:2b9:b067:9554 with SMTP id g6-20020a05651c044600b002b9b0679554mr1784274ljg.2.1690549762505;
        Fri, 28 Jul 2023 06:09:22 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id v8-20020a17090690c800b00997e99a662bsm2020855ejw.20.2023.07.28.06.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:09:22 -0700 (PDT)
Message-ID: <70e35a52-17a0-2590-e94e-4fea70947777@gmail.com>
Date:   Fri, 28 Jul 2023 14:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/3] t2400: Fix test failures when using grep 2.5
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
 <20230716033743.18200-1-jacobabel@nullpo.dev>
 <20230721044012.24360-1-jacobabel@nullpo.dev>
 <20230726214202.15775-1-jacobabel@nullpo.dev> <xmqq4jlqcok9.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq4jlqcok9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2023 23:09, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
> 
>> This patchset is in response to build failures on GGG's Cirrus CI
>> freebsd_12 build jobs[1] and was prompted by a discussion thread [2].
>> These failures seem to be caused by the behavior outlined in [3].
> 
> Looking very good.
> 
> Will queue.  Let's plan to merge it down to 'next' shortly.
> 
> Thanks.

I read through the patches and agree they're looking good now, thanks Jacob.

Best Wishes

Phillip
