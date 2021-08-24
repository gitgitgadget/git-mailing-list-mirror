Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFCDC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B2361242
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhHXKrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhHXKrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:47:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B4C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:46:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so1505644pjr.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IPickOJqZicCbXw0Z/YT9LexmmOLUjuC4WTn0DZqY0c=;
        b=fB5qf0j3k+SnlEUslljNo+ODOb6gST7wWdbR8SgqiJDgN73Kff9wUGEgRLgnVGk7Qw
         a30VHK9MsHkGqUGIQbODh3fEDfdL/9VCWrmv2NSyiBUMLi+Phgc/7gn7e+uvhYQWFEVR
         6vPzVTTzAhhs6rCG4ZEZ0OUjEUpGMoH79dD9/ZFpClygzroAer2EGDcQUZyJ6CH0+vMT
         gB/mrAE39+hnouQJ9Uu7g9VBORUxjPiyx4ILT16JlOV3OX4SXcidP6s8gmp36PHLskaK
         U9Dson73b9FyffcLQvt48mXxM/ZY+SoHuUgke+78VWB5Ux+O2FDTuzdsSXaoAzm2K35x
         G5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IPickOJqZicCbXw0Z/YT9LexmmOLUjuC4WTn0DZqY0c=;
        b=soPYvXZUC8+5WUngZYJeHeWXa63Dcsc+wU/4dX+EsbpJh2WYdk7C02raLbuWdNjjFi
         wUsCeAcSrU6W7IMiB4kIvMFnQEmKOLCgkhHOinBuqslfEFFCokCFf5MYnsorJBx2/vKf
         3TWOtzpLkodLAbNfWwALkDjNU94dEHbDpCh/bsEqwiiMD3GZh4sQ8YVPT1fJb0KmFTgZ
         pwJ/upTXrkEVN7f8GDfE4jp6Pc1OinvMOfD7/OUPbiGcgiO2cAMdMomUFHWktjxpZwT4
         J1yFekLZJPbtoLbZX6Db+USb/do18FaHiAb26OIaCQQPzwHmMIia8yNY6z2gZV+G2AbL
         pCwQ==
X-Gm-Message-State: AOAM531hJo91/GKzyNYdBMdCzyUnDpat+Q1J/mbAWD2C4RLnNbHkQzET
        gGCBY0rEgdwldjBcj0rNLRztKB1tlRc=
X-Google-Smtp-Source: ABdhPJzd11yHekf+bw9jjeEIui3qnhhkUGmJDfe0jijWsKsXR7k/KmxrzRD0LgsMEN4GMdFmvFuzzg==
X-Received: by 2002:a17:902:e850:b0:12d:91c6:1cd with SMTP id t16-20020a170902e85000b0012d91c601cdmr33142360plg.16.1629801990693;
        Tue, 24 Aug 2021 03:46:30 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id y12sm22906939pgk.7.2021.08.24.03.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 03:46:30 -0700 (PDT)
Subject: Re: git log --encoding=HTML is not supported
To:     =?UTF-8?Q?Krzysztof_=c5=bbelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <22496693-cf63-a278-c85e-d9e4376e2a59@gmail.com>
 <2197959.ZqlxZjeC1n@localhost.localdomain>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <05ffcc36-f473-14f3-d7df-1efa0dcfcade@gmail.com>
Date:   Tue, 24 Aug 2021 17:46:28 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2197959.ZqlxZjeC1n@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/21 17.33, Krzysztof Żelechowski wrote:
> Dnia wtorek, 24 sierpnia 2021 12:31:14 CEST Bagas Sanjaya pisze:
> 
>> Please speak English here (in other words, re-submit git-bugreport
>> without l10n).
> 
> How do I do that?

You need to set locale to English when executing `git bugreport`:

```
LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 /path/to/git bugreport
```

-- 
An old man doll... just what I always wanted! - Clara
