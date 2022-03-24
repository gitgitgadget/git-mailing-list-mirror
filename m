Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A97C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 11:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349687AbiCXLMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349677AbiCXLMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 07:12:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF7673DA
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:11:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m30so6134827wrb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kz9lyLUpZYZANNTWP/e5AZbrO2InruBc3wlpkaX7Fw4=;
        b=gd5xFxqd6yJMX6lm1ygHeG9SP6K2TnuHYsHFUvnYFTnIhT0+Wum8y2VH3cp5iGYQi5
         LPWJENCNaar+y9LhxktaE+Z6z0uO4Hy+5cMZ6No0D9bhSAZH/JYbJfk+SluFB/CNz4FE
         eNpj4YwwjDhD7ktrlPV6r5STgKCNm0BM+AaHNarH1dX0do5z6C7wptsdEJofB+6tHX1m
         7zOR1jMtFMIX4Ec6rezDBT0gNDDeKKs4iPDXyW39joIshSaNdE44tAN0waE6KOF+krDr
         Pdy9cE2r26yW2F9Di2DSxHfo9vNsxS/F40TBXawTPUqCGmcE+RYo+gMTvLM8PqmXByOp
         x3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kz9lyLUpZYZANNTWP/e5AZbrO2InruBc3wlpkaX7Fw4=;
        b=waigbw7w8oEHeoP5w+5Y/sEDQQkVf5fsd1r9s4r+31tPRwtCjDpBagXsQLinEknI9C
         XqDh8rsz3y8fG5WSzWel1qgcOPuW5SfOwCcANTluP4qrZl/zT6tuYXfG2o17Gkb3HKgK
         ep/isX4ZL06qTAApfODexDOVEXCKwSZolDMPNiidmk5fgTvxeULsoNaMUvBAErQ1fBCE
         dPf4xuzFRYjRCYS3va8Ylc27Mz9B8OTp6y6u8UjFwhQqHB2Les+hLgdTQ69uTA0nSWIa
         mfUx638LG5rap7SqDsyoghQepFdpEOciP3PBYeooC18NMBpPW1W4he6GczHRWPVRz/ef
         dj6w==
X-Gm-Message-State: AOAM531/OoVXXSHgkVlq2KON0yusHFUatZui32wRbq5DhY6n1ylzeTtW
        ZhoZwGR1xKV3R/CHdaCClp8=
X-Google-Smtp-Source: ABdhPJxC7NiH/QdfpoZM9peD2SLbyQaWo3kAt6QJKAOjVMQA1EP2+yd7OBbxD5Vp+IfbgYp2jFxjDg==
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr4205506wrm.619.1648120264537;
        Thu, 24 Mar 2022 04:11:04 -0700 (PDT)
Received: from [192.168.1.201] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.googlemail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm1795033wmg.38.2022.03.24.04.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:11:03 -0700 (PDT)
Message-ID: <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com>
Date:   Thu, 24 Mar 2022 11:11:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 23/03/2022 18:17, Victoria Dye via GitGitGadget wrote:

> Changes since V1
> ================
> 
>   * Dropped patch that removed '--refresh', again allowing both
>     '--no-refresh' and '--refresh' as valid options.

I should have been clearer in my comments that I think changing the 
option name no '--no-refresh' whilst retaining '--refresh' is 
worthwhile. '--no-refresh' is the form that users will want most of the 
time and changing the option name means that the useful version will be 
shown by "reset -h".

The range-diff for the other changes looks good

Best Wishes

Phillip
