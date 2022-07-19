Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409FC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiGSUBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiGSUBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:01:42 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459995
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:01:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n7so12726499ioo.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AUglFCEhl8Ltv1Q/Wb7oBA1eZ6+sr8oY4pGxdwb/7/0=;
        b=iEhPGH8RZE6Z1iW9KZXVP7fM1Y3q7d3q23SfhJn2fELEGlwQL+BsMYKl7gOvV3FhVj
         Hv8YyTgjDQ2suqcuvwS+65mBsHaJ7luQ63fCKDBCIDLjParGp/YVm0nnAVeiB7xHCCRr
         K9VNErb4m0QWOuJw5k8vRauZN8z4jtwxUe/KepX3Em4JwyMXTokXZZmWt9bADULUSYkC
         urgjjqfk1bD0nkldZjgfnpg0neM1vH02URNuIho86K3LdIAdAQMNG/aPLULFe2u5cB3I
         3MKppcpYyf4tV/yIjobnT40/qVzUzap5T5xjy0GunEmMxyz5sMG+OhCXB87YkIfwkCNO
         8e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AUglFCEhl8Ltv1Q/Wb7oBA1eZ6+sr8oY4pGxdwb/7/0=;
        b=Fz8ISKyCcWdd1x/mBTwk2My4IKakQu9OFbd6s4kvfyQew6cr6bwUAChDP9bzZR4HZI
         OzYMyLDI+nxd2l3S89Os59nq2KfUn4Zg9wq4kjGjkPXqiPt6J6UOTVtShIor+hZ8zD8s
         K5zV+410UKf0C/k2cZnDb6imN8PIdSb2nlOIQ48Tr5wId8QM2GYjx/j/U/EJ9+tvugqP
         8YqtIENycznbIy02LevG5DLKKZBeq2j0637qKU8fMlbm+x+pvgfLSdLsO+n3Ki6njFBL
         eeZ0GHNqR0NAjcSlcHYTT3cYSDbq//NqnoKT/S1yoU00UIEQ6yq71HRgh5FjYgRRWMNJ
         J+kw==
X-Gm-Message-State: AJIora8GprzgihjXak+thPXuO7A4Q/wA4BCMeEZUEjDWsiPkHJPfUEP9
        dTlPEl0I3f3PJU6aEsIU5ydN
X-Google-Smtp-Source: AGRyM1s54Z7QwP2hLPZUu2Ok3jfl8N6oO6lazzvaV/AC4Cr+JTa55vRVEpNtdQaJsf7TypzGOtUY4w==
X-Received: by 2002:a05:6638:2410:b0:33f:8518:659b with SMTP id z16-20020a056638241000b0033f8518659bmr17053964jat.253.1658260900386;
        Tue, 19 Jul 2022 13:01:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id m15-20020a056e020def00b002dce9ddcb08sm2791156ilj.30.2022.07.19.13.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 13:01:40 -0700 (PDT)
Message-ID: <8dbcd979-0794-65c9-2192-62d4bfc8ef62@github.com>
Date:   Tue, 19 Jul 2022 16:01:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] compat/win32: correct for incorrect compiler warning
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
 <CAPig+cSPnQnw82DsDHhMP12sYW_XHUb6+MYt17V=0sWrW4j2iw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPig+cSPnQnw82DsDHhMP12sYW_XHUb6+MYt17V=0sWrW4j2iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 3:48 PM, Eric Sunshine wrote:
> On Tue, Jul 19, 2022 at 2:48 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The 'win build' job of our CI build is failing with the following error:
>>
>> compat/win32/syslog.c: In function 'syslog':
>> compat/win32/syslog.c:53:17: error: pointer 'pos' may be used after \
>>                                     'realloc' [-Werror=use-after-free]
>>    53 |                 memmove(pos + 2, pos + 1, strlen(pos));
>>     CC compat/poll/poll.o
>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> compat/win32/syslog.c:47:23: note: call to 'realloc' here
>>    47 |                 str = realloc(str, st_add(++str_len, 1));
>>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Removing the unrelated "CC compat/poll/poll.o" line would help make
> this output less confusing.

Yes, sorry. It's output from the parallel build that I should have noticed.
 
>> However, between this realloc() and the use we have a line that resets
>> the value of 'pos'. Thus, this error is incorrect. It is likely due to a
>> new version of the compiler on the CI machines.
>>
>> Instead of waiting for a new compiler, create a new variable to avoid
>> this error.
> 
> If possible, it is a good idea to mention the actual compiler version
> in the commit message as an aid to future readers who might want to
> know if this sort of workaround is still needed.

I wish I knew. I can only guess that it's a new GCC version on the
Windows agents for GitHub Actions, but I don't know exactly which one.

Thanks,
-Stolee
