Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A89C3F6B0
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 00:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiHYAa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYAay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 20:30:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3481B20
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:30:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id e28so14108665qts.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 17:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nPqIFQZXgeWSZNvIBU1A/gSkxl1agHcsYaVnWTdzhFI=;
        b=ckgaJNO/NYiGak58g6oDSnK3RlEPv0OGP/St7xeTwX+rr+OrNWCojl+xe4DepvhDA/
         H47a//6yILGYQW0My2WE1uMiuF/w+5hz9kA0OztJaP1QNKvkJFCERZGfXPfGeSqVmmuZ
         oPLRCW7vr/Xxtoe5H+2snHlJfFCviBt2n22JTgbBvjaswdPhzWEEsdsV72XO6p8prqX1
         YIbiLisq1YW/HeHLQoeQ4sHecOTlnf306aVLpQrM4wp6zdHkDG6JKNC6XzxMiVk4GT4l
         TkGPgLpI0hz8KBj4IcF/OaOW8VB1WBmEPwNrgk7INp7t4gCzVBNj0MZ9A0Xb/6rDsOD5
         HX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nPqIFQZXgeWSZNvIBU1A/gSkxl1agHcsYaVnWTdzhFI=;
        b=lK1slCltkp2zFM/m9iZvXRWecGt9A6u1PqinYj9NzNXu2M/5/ILKp15Kww42pjqiD/
         idpqd9Lum6Y8srS0e9Gt3WU51yp+npkNuRhbx1QIRAWlyJhmdHHFuDlIceei7/uL8PJy
         1ROMuIjmD9TZZ7stCrOnLCTFgN5cdIXgbYu2TsuVYWmcV3mGAZk8vnFBiQJcPwZGziZN
         B2XKCEEAMDkfJsuYDVDwTteZc1a5cWT67wsP1F9ZJcte6UywQyvP+uNpBaElV4OnMbZl
         ZsVNGC0//zWfn8VKMxjD535j+t8KQZ65BdXSki3qCcO7Uu3gNGNpR/xcTfWCzO+NZfW9
         h8gw==
X-Gm-Message-State: ACgBeo1itCY5qC5VsdIqLTzF/+XmUnU2Y2AE5eLD2zbSExVkZlKhLaVf
        VEwjg8UMYzZlNOHPpBx8phjg
X-Google-Smtp-Source: AA6agR7JDAwM9H4ZISP+rBRFmKlssDwymyrZc0AB39HxZg8xcYrYqM6JUbw8Ms+QGwWXvjqAoexPPg==
X-Received: by 2002:a05:622a:13c6:b0:342:f6c7:5305 with SMTP id p6-20020a05622a13c600b00342f6c75305mr1723262qtk.348.1661387453147;
        Wed, 24 Aug 2022 17:30:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:64e6:a996:33b5:bb90? ([2600:1700:e72:80a0:64e6:a996:33b5:bb90])
        by smtp.gmail.com with ESMTPSA id ey13-20020a05622a4c0d00b003434e47515csm13345630qtb.7.2022.08.24.17.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:30:52 -0700 (PDT)
Message-ID: <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
Date:   Wed, 24 Aug 2022 20:30:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwnax438x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/22 7:43 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> GitHub Actions scheduled a brownout of Ubuntu 18.04, which canceled all
>> runs of the 'static-analysis' job in our CI runs. Update to 22.04 to
>> avoid this as the brownout later turns into a complete deprecation.
>>
>> The use of 18.04 was set in d051ed77ee6 (.github/workflows/main.yml: run
>> static-analysis on bionic, 2021-02-08) due to the lack of Coccinelle
>> being available on 20.04 (which continues today).
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>     ci: update 'static-analysis' to Ubuntu 20.04
>>     
>>     I noticed this while preparing my bundle URIs series. See an example
>>     cancellation at [1]
>>     
>>     [1]
>>     https://github.com/gitgitgadget/git/runs/7954913465?check_suite_focus=true
>>     
>>     I initially asked about this [2]. Thanks to Matthias Aßhauer for
>>     pointing out that 22.04 has Coccinelle available [3].
> 
> Thanks, it is already paying its dividend, it seems.
> 
> We probably need to fix or revert/remove rules we have in
> unused.cocci that makes bogus "suggestion".
> 
>   https://github.com/git/git/runs/8005321972?check_suite_focus=true

Yes, this is definitely a bogus suggestion. It's probable that it
is picked up by the newer version of Coccinelle.

I would recommend removing unused.cocci in a patch after this one,
and then you can apply both into 'maint'.

Perhaps a careful rewrite of unused.cocci could fix these kind of
suggestions using the latest version of Coccinelle, but now is not
the time to wait for that.

Thanks,
-Stolee
