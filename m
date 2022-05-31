Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3DC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 13:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344734AbiEaNcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiEaNct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 09:32:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC14E381
        for <git@vger.kernel.org>; Tue, 31 May 2022 06:32:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s23so14068511iog.13
        for <git@vger.kernel.org>; Tue, 31 May 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yhdS0yb4ngoGEz3ktOvVf98ZPe1jb/a519ZMESdTP/c=;
        b=SacE+0bS16ifvbODziCkF3heaSZyMAIzMyvvdBrQT1Ti9+b6VmTvgMKAWgHt9BQKL9
         KY2BdvMgK9qhLEmvK4SZLSny6TvyNWTk59s2ZNj/Ge9oU0sJ5YdjMvgdx73unL0HjL32
         ef4v405LnM5lUhrnd8k9q6Qqnh3p4jldLsTcSYDSxT/OBVG5eDvbJSf5RAZk6QYDFWe0
         6Tvq4UzvrTlp8op1oEk2IcINoenrwgpftX81tWeEUvEXenX43KOpz0/wY1xzvQwor3TD
         qWuiOZx0pF4fOinP5Vj5JRnnAFlhavk5RwxQjfcHhc/Xa4TvN/CdwH7ESMQr/asSVFL9
         WF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yhdS0yb4ngoGEz3ktOvVf98ZPe1jb/a519ZMESdTP/c=;
        b=OK3i3oyn1oa0wike9DAw3J4liYYeyRA7U/jkAuqPYj0/wScaPUXRQYmm8QtyNDract
         /YQ6mgMCy/sl0wvGcq5S/vp/5FUtelJMpz+yucIP0l3dzIrDBuMss7FRxmUmkF552KjN
         cMKeiJo7Spo3c9toMO9Je8c5ywjf6UQ5twLmBWNLT6NYPDIPVMXFLIm/f6xYyIxwMdww
         MOKNheJM1lkax1sgxjkrSVkBZSV2s9RA1MtjiTkken6EIOjJbmykGlYhw95eJu+lI0U0
         wC0WUMDTIBSeys+mvevaY0WtitqmV9rWuFppjBfnRLIfhKJyyz7eeITeWO8Qi7bVS4Qz
         dmng==
X-Gm-Message-State: AOAM533oVqXIP7AwMx1FDmmJnmKcNiTDy4xDbKkrfkgdrhT0JdZPNY+b
        ZoLFQsymrlWR68UwYquTI1jZ
X-Google-Smtp-Source: ABdhPJxNQC1REL1XcfAg6XkcHZkrUBjVJF1w0DsLSbWQkVuiI0s30cpBvlj8nWIvjYzgQezenWUJxg==
X-Received: by 2002:a6b:780b:0:b0:668:6ebc:7156 with SMTP id j11-20020a6b780b000000b006686ebc7156mr6287770iom.18.1654003968278;
        Tue, 31 May 2022 06:32:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:14e9:7db8:f78e:25a8? ([2600:1700:e72:80a0:14e9:7db8:f78e:25a8])
        by smtp.gmail.com with ESMTPSA id j22-20020a056638053600b0032e402a43b6sm3491313jar.60.2022.05.31.06.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 06:32:47 -0700 (PDT)
Message-ID: <a9f1f310-ef48-b5f5-39ae-ca45ae48038d@github.com>
Date:   Tue, 31 May 2022 09:32:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
 <xmqqilpnyiwe.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilpnyiwe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2022 8:16 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Create a new "fetch.credentialsInUrl" config option and teach Git to
>> warn or die when seeing a URL with this kind of information. The warning
>> anonymizes the sensitive information of the URL to be clear about the
>> issue.
>>
>> This change currently defaults the behavior to "allow" which does
>> nothing with these URLs. We can consider changing this behavior to
>> "warn" by default if we wish. At that time, we may want to add some
>> advice about setting fetch.credentialsInUrl=ignore for users who still
>> want to follow this pattern (and not receive the warning).
> 
> Can we make this die in a bit more controlled way?
> 
> e.g. https://github.com/git/git/runs/6646450422 seems to show that
> depending on the timing, the call to die() on the "git clone" side
> may cause us stop reading early enough to kill the other side with
> SIGPIPE.  The nicely prepared warning message seems to be lost.

Thanks for pointing this out. It took a while for me to reproduce
this with --stress, but I can get it to happen on my machine.

Investigating now.

Thanks,
-Stolee
