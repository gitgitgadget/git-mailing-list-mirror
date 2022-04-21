Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F414C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392116AbiDUT5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392109AbiDUT5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:57:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7219B4D9D8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:54:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c125so6457004iof.9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cgErMQ5zVlBKsfVyXDwpRjVllEHAm4EEFb0pW5LV5tw=;
        b=VXAPNeltn7h3nbjuq4OPOSyLV3MrpgKcXyAMfdaJSEef3plUqdvAWJLNZnFYRlO5Qm
         SO2LPnSCBHWWHvuLyjnWaUE7oNVa+OAykkeOMvJYr+Tg3yXyHvFr/lKnxz1qOsdgF3XI
         J/svFIe4JG2F9wy9f078HKhTFXASbGP7cvKaKu5d6kC4D53nP7bVWWWd2PJeXBwcv7Xb
         Uq00YgwoF7+tBFsJEQe/njgAhxN2xzsmhuR9AEq8tMcvx4l7RMqFTvc5m1lxcD2Rw7M2
         rh7mwAUpvr3WXEofO3N6Fd7s1Xe21wpH/2NV/I1jeVo+S4ltXR8AYe0r7XlN5N3SenGY
         6NNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cgErMQ5zVlBKsfVyXDwpRjVllEHAm4EEFb0pW5LV5tw=;
        b=h9wIToofMU0OhrWgS3aM7ifVNDUaB+QUsbL3wHV7M+m7UXQEf1k7SmXbo3z3UZBK10
         0t0PU+DO1uTImqGIo/6xYU9/GiuwJ29zETJqgmuDF+U/qFTdam8cGGSunbLzHWIn6MFg
         egBnQRrCqv1WEEVxU2EYB05jWIxVIybbFDLgMJA5pd5ey00iyCcm+XHyRjZh1lEgXq1L
         P6HhCzL5E5+r7iWIq6vLak4lHJWd2GfID1J95OParbdyPglZgb+1e3dkIchicMO9xwkf
         QB2OlXpxg3xTEJ8PMo2NqTLzTAWVO00QWXZJoAGeSDdE3axsPiwWUxEKFltV/3cQoGXB
         sCSg==
X-Gm-Message-State: AOAM530piDpG4nCTnT3lFtTemKJR6XpkiuYyao8oaeY2T2ENwckbvEjH
        vSRYx4yIM9qH+Socf9czU6bp
X-Google-Smtp-Source: ABdhPJx9Rodhl+vXfjPs01PsmtTo0A5TpN6bAhT65TfsB2nANl2C6QtqaE0aajG+9OAaRG5iLDbdKA==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr580845jat.289.1650570867862;
        Thu, 21 Apr 2022 12:54:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p15-20020a92da4f000000b002caa4481d07sm12811095ilq.23.2022.04.21.12.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 12:54:27 -0700 (PDT)
Message-ID: <dd9836e8-bfc9-9a52-199a-3ffce26101f8@github.com>
Date:   Thu, 21 Apr 2022 15:54:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v2 00/36] bundle-uri: a "dumb CDN" for git + TOC
 format
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
 <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2022 1:23 PM, Ævar Arnfjörð Bjarmason wrote:
> This RFC series is a start at trying to combine the two differing RFC
> versions of bundle URIs I [1] and Derrick Stolee [2] were kicking
> around.
> 
> = Layout
> 
> This series arranged in the following way:
> 
> * 01-08: "Prep" patches from both [1] and [2] which in principle could
>   graduate first to "master".
> 
>   I.e. they're prep fixes added for the two bundle-uri
>   implementations, but which either justify themselves, or e.g. expose
>   a now-static function via an API.
> 
>   I tried to move things into the "justify themselves" category
>   whenever possible, but may have overdone it e.g. for 02/36
>   (originally an idea/commit of Derrick's, but I changed the
>   authorship as pretty much all of it at this point is something I
>   changed).
> 
>   For the "prep" changes that are only needed for later changes in the
>   series perhaps we should just squash them if they're small enough.

I focused today on reading these first 8 patches with the intention that
they can be submitted for full review and merging on their own. I think
they don't fully succeed in justifying themselves (since not all public
methods have callers) but it would be best to have these refactors
settled before getting into the nitty gritty of the bundle URI feature.

I mostly had a few nits here and there. I noticed that you did not always
add your sign-off after mine, so please correct that when you send the
next version (assuming you are planning to do so).

I'll now start digging into the bigger parts of the series, but I expect
it to take a lot longer to look at everything.

Thanks,
-Stolee
