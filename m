Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9DC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 14:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiHEOV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbiHEOVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 10:21:54 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D1E0E1
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 07:21:52 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10dc1b16c12so3087792fac.6
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qupqlFlf6movwzcpRZBfCiVWTM4oE0YTilpOsrN8Xyk=;
        b=W2IRqYY0aqArRi7YXSCfRpnjM2V0UazTklBKRzABMAknm2xmrIqO/x3qiRp7g4C93b
         jn4RpdrKaqnoODmWtXOGd9S/phPIQZtj4ynslN+gXibjB50ZZVMa4o8dD73tMYt5SYxr
         N6HTORR/VZH02reg2p/vJZrDe8KGAJbipoTftQ03zxDCT7Zs1NndYDwvirfSRoeXjATj
         HXcPL/8wpaOIlT50oHRaKGZIo3QqM1/MZQzqcGX/WhkBFCB5x1Oqrs1YwBhah0NTDh2W
         KSU/m8T+YTvndYbrFTUJpGUBMNDKPwP49iJqi+I63pCOAPdvY9LbZC+ChCs0RVOZwYf6
         ATdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qupqlFlf6movwzcpRZBfCiVWTM4oE0YTilpOsrN8Xyk=;
        b=JZIuCGgcGZ2VIt2PiqmdqFN6D6EYb9zQHiHysXVToCeKQtr1sjTuRIvs0SKVngvaN9
         WMcJu9wZ9Weqe2jRB4Hk7831fjKsJ+kIaxhQTJojOnXSiF8hOONmeDO6xgs8t1BQmVFa
         VcYo0mYswggG5JF4U/0oaWhkc0Q/XCu5r7QRO9FNcSZJm/qRQ1e5+E+xU47Nf2qnYxQu
         pE6wVlxpjllAvfBGbZEIKNF5GMG/K+r6wMYnh7yohQvUNBm7hKEO0T7KxvOy9QEiXjrP
         j4jBGM89bWJrOrp6Q3XLpTVJPBE3wtbJacE73lccIWIYPbr5XVshzIfRWm67dzoVNkOk
         l2xQ==
X-Gm-Message-State: ACgBeo1wMRaz/J3PT+kGVRazft4fflAqzvbPZgMmbMQtrNGja2fbeJE4
        ROXLtJkxv6+JbjP2CMblE0sX
X-Google-Smtp-Source: AA6agR7vWPEUNc8c03vtmUWj6r7FBhgmWObkQzklB0h/5pHONFzRcCk0aSAKrs4cLKAje5/gpybn+g==
X-Received: by 2002:a05:6870:1699:b0:10e:a227:67e1 with SMTP id j25-20020a056870169900b0010ea22767e1mr3362861oae.129.1659709312112;
        Fri, 05 Aug 2022 07:21:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id x19-20020a056870a79300b0010e5a5dfcb4sm717245oao.0.2022.08.05.07.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:21:51 -0700 (PDT)
Message-ID: <f999258e-1822-bf38-dd2a-e553f1d796b7@github.com>
Date:   Fri, 5 Aug 2022 10:21:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 02/10] t4207: test coloring of grafted decorations
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
 <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com>
 <CAPig+cTUTXuBov4m0xvxehVFbbPjVPrAHAFfPWO5Yv4C9imyaQ@mail.gmail.com>
 <220803.86les5fpfg.gmgdl@evledraar.gmail.com>
 <CAPig+cSjHf3d6xKT71biR8Cd0iKHqBpQ6Q9_bd_w9Hgg_uE=0g@mail.gmail.com>
 <xmqqsfmb6hxx.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfmb6hxx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 1:23 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> it's hardly a cause for concern at this point (though, I still
>> reflexively write the more portable notation as used by `OID_REGEX`
>> and `_x05`, etc.).
> 
> Yeah, use of predefined constants we have in our test framework
> releaves us from having to worry about the issue, which is why
> I too am in favor of using them.

Thanks. Using $OID_REGEX (along with --no-abbrev) will work
perfectly for this script.

-Stolee
