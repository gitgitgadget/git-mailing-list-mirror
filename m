Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F5EC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 15:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbiLNPJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiLNPJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 10:09:42 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7016611825
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 07:09:41 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-417b63464c6so140067307b3.8
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thxB3wgOxZ6FC+r4IhpuC41BSaUfo+v8dpOKwexx9TA=;
        b=S1LikNme3ox/dy2jy/SK4xYLg7e+UjmHOZ1lX7ZR7egRUVSku2xEjvWyS3g+1vhBkT
         9rmVsgnsex11s0ttakVM7HFVoFNvubX9DI2YIuNysaXqpEI/FAlFdUHxwBE3Za4fD4ak
         FHypTUEJaIUQ5o/t+rVx+Rd3kRHxlMh37EILB0Uc0zbDeXWuNkvZ3RpWpoUMubJT8jbo
         8H+oDunOhdcIgLGbY0VEsghtffi9I6r26fwYCsCWY63Y06yngzQ5+q0ONkX1gC2pGmwQ
         IecxacLg5NQi1ODrP28TEZCTXW66k4pXKh/QlkGY3zzYSlIpnF/bJSyohrtJ3l2lvwYX
         oR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thxB3wgOxZ6FC+r4IhpuC41BSaUfo+v8dpOKwexx9TA=;
        b=31m/xgOHSbG0IRo8EOIwEhqZdaBu9n4iswol7IzdEfNjDGNIIH/5SAt/UWHynCEjW4
         J1eNA8JD608vG+W5TGzX+L6cT1mWtwN/tGau8n3Fs05ZKrgo2+NSbyBv4MNqnVnCiFy+
         0gAckaEYxqCZ8QKG28VJCVJBOgCOQfayU96FPrXWG1EO2C5e2d6AHxleEt8YFGW/3byG
         4nbRpuAgSsoVHVNFQdGL3dBnmAbR4W6ndsqZKrHoIDYIR2goZrpzmIKL0BnLlxZjXgdS
         oJlDBVKbHkXA8Jy2iF2KUqn2kLBIjZ4vTdJgJCCA4nu00MpyYqaWYaCTjfwNEsMNn0Hk
         wdlg==
X-Gm-Message-State: ANoB5pmP2AgM50EDYJzEC2eEo8PrZSn62ve9335PLRwWoofMtk0tmGJL
        fAvKhgcsaem5u0hJbqzVBlfxwkmaOWWXKRc=
X-Google-Smtp-Source: AA0mqf65KFK2wj3zCLUrNTBVddMR/OzdLdKFvU/rnpd7TTfhwmo5fmzA5w9iqi6OFq9E61Dp2wjPzw==
X-Received: by 2002:a05:7500:3ecd:b0:ea:624a:6cfc with SMTP id lj13-20020a0575003ecd00b000ea624a6cfcmr2599823gab.18.1671030580462;
        Wed, 14 Dec 2022 07:09:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e8ad:a28e:c5d2:998a? ([2600:1700:e72:80a0:e8ad:a28e:c5d2:998a])
        by smtp.gmail.com with ESMTPSA id l9-20020a05620a28c900b006cfc1d827cbsm10441183qkp.9.2022.12.14.07.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 07:09:40 -0800 (PST)
Message-ID: <b712fa19-96b8-80db-5aa7-f823bed687e4@github.com>
Date:   Wed, 14 Dec 2022 10:09:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <xmqqiliewbje.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqiliewbje.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2022 4:59 AM, Junio C Hamano wrote:

> * ds/omit-trailing-hash-in-index (2022-12-13) 4 commits
>  - features: feature.manyFiles implies fast index writes
>  - test-lib-functions: add helper for trailing hash
>  - read-cache: add index.skipHash config option
>  - hashfile: allow skipping the hash function
> 
>  Introduce an optional configuration to allow the trailing hash that
>  protects the index file from bit flipping.
> 
>  Will merge to 'next'.
>  source: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>

There are some outstanding comments on expanding the documentation
and commit messages, so I'm intending to send a v3 later this week.
Please hold off from merging to 'next' until then.

Thanks,
-Stolee
