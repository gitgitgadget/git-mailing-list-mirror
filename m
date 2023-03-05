Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5114C61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCEJCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 04:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCEJCK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 04:02:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1BEBBB8
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 01:02:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so6197429pjg.4
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678006929;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4qnsNDa9eDQfZdiYWI8i5V6iSIp5ovNhHZbEoO/oQ4=;
        b=by6xbCGfmj81MONyZnhaS0+fZ8I4BP238Yti0IM3c+IK/fT9ZVAYhEQbop1u7LXvlw
         Vys9kS2oWTAXeq4XwXPiGT7VyEtuC+OYAhoVhLDCqTUSV/BfzZApMX3fESvVT7BkuoOd
         nXSdU/NCwgz/cdOflN/NfyQ3Yb39w5BJzwua1Rxns2US5vPuVmsCiSEvcbqxA/Nc7+PH
         ThYw54IP0aqpjLKZtj7VY51xi0qiFhvjEq5KIHM6s7C6vei3Z6Z1fLmE254sWMFhuh6z
         UhItEaosGd1ygaDDo0rFbtTI+I+afYlosj9enBvbiwKGVOtC5ndWgxMIPGvxWIUJgR1k
         AuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678006929;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4qnsNDa9eDQfZdiYWI8i5V6iSIp5ovNhHZbEoO/oQ4=;
        b=bBTEcPl4E7UdHgvp2Y24mFH2TA0TVez/Y6Tp3D/0n0A5j4T9O3lMt5RbOh5HXCzOUA
         eRX0OPKfvjoYwUstVhwyDwvl+B9YnXM60l3bpSxgkgJJLTBbi5YVxpcKi1eivIpAC5Da
         omcTfRBjIqf/vpYEj7szyI5fDsc1+YXKaaYuIWnk5SQjVmTrnKG8Q2IuUtIp5JCz8FTa
         6+URrIqqEDDqdAOdVha3Hs9escMMxcD0M6tL0n0nvk0UMuI9DL9Te8g/UM337E42d1yn
         umbms23f66961Ceehf7IvlVTWnaBWeC5nAn1+PhYyIN4M5BZ0/gWxUzK7VDx61MojDvG
         b2bA==
X-Gm-Message-State: AO0yUKWhNu0POqzDn8GV/he0mWnI/sqBPWwPuoof0aFYVTfGjUUmC2uC
        aNNH9QztAJ+myamj5Dvm0yERG8KCC7w=
X-Google-Smtp-Source: AK7set+U4lETP3QIHNiVffP8TgYVErnI3FPyYVPFLiL0+l0LmhlvVROW0u5Fm6lBLJdmU58SJ6Gizw==
X-Received: by 2002:a17:90b:d87:b0:233:ebf8:424f with SMTP id bg7-20020a17090b0d8700b00233ebf8424fmr8075651pjb.0.1678006928884;
        Sun, 05 Mar 2023 01:02:08 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id mi18-20020a17090b4b5200b002369a14d6b1sm5896071pjb.31.2023.03.05.01.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:02:08 -0800 (PST)
Message-ID: <143e4a36-02cc-d2a6-ff60-6b143d9e47b4@gmail.com>
Date:   Sun, 5 Mar 2023 16:02:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: How to mirror and augment a git repository
Content-Language: en-US
To:     Sebastian Tennant <sdt@sebyte.me>, git@vger.kernel.org
References: <87ilfgemkb.fsf@sebyte.me>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87ilfgemkb.fsf@sebyte.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/23 19:19, Sebastian Tennant wrote:
> Hello list,
> 
> I wish to mirror _and augment_ an upstream git repository.
> 
>               .--------.
>               |Upstream|
>               '--------'
>                    |
>           .----------------.
>           |Augmented mirror|
>           '----------------'
>            /       |       \
>    .--------. .--------. .--------.
>    |Client#1| |Client#2| |Client#3|
>    '--------' '--------' '--------'
> 
> Clients of the augmented mirror must have access to everything
> available from upstream but must also be able to collaborate on
> additional development branches not available from upstream.
> 

I guess the augmented mirror is integration tree before changes
from clients going upstream, right?

-- 
An old man doll... just what I always wanted! - Clara

