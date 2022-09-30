Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E030C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 13:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiI3NVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiI3NVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 09:21:22 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D915075A
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 06:21:18 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-131dda37dddso4429419fac.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Tshukr5VDX3jgVsmUSJG98fuuWhbD2oTPrEb+E12ORs=;
        b=TTlqT+fGJZZazv/76h6Zbz3LgOa/wcI09jLn2uRiCFn10B+xYLMKEaRVHMp4ztz3HA
         YFBAzlR9E5Om09r+Ir1+QzXeK7jtSdeJIm2rVa4yI89qnEFO4cYN9z1iGsAHq8GNIql6
         4ClQ2eM9dUD5hPJ+n0YpA6cchlDDYNaPp/FZsxgHcM6XtxugHczsM8thrlAVmwi+dSWf
         9TtWrIYX1fKBaVMojj4oDBbJOysynwwRJVHJLdkqM5eeoyG133jgqH4ufnY1J49okaWl
         A7p8QDVX5Rfbz8/2FR16QeXUVdjyMNIpkNKP87M0UT705jst1CzdvubBH18nNhcpDg0y
         Bejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tshukr5VDX3jgVsmUSJG98fuuWhbD2oTPrEb+E12ORs=;
        b=PrDfMNs3fsu8Wcj05xEKDvtl2e+6gNCZsnsQM7K1ekdefHwWxQrvM2UKsly+HygN6T
         n4e2sbUlTeX+v9dVpPCet97LqSqO3AaskyCHPgrww/Zckj45uqTIk/IYZi6Fyqyn+o9G
         cxjQzb0WIAW6vet9kve/WPkcJkrdssdvfcQrnlaVPKbh6PHII4rNYy5gMPBzHbPZ9U7R
         UJk859yTeHd4BiUYelXMd9HmuTh2gudr5ugsxq9+xUOPHFzCFTihqT96yszQMM45j4UY
         F4N8K14c5zypdCe1ouOdU3Bgo8yi+sBDM5RmbrjBVHzJrGizQpOdUIcICl66hCOJTsrF
         2QUg==
X-Gm-Message-State: ACrzQf3PfEniVfP8z1VLbEeBERjzVfM6o5vAXNDG2llZTw+8n5qDXh90
        x4J59UT2lqgpbYoh9R+ll4aVuofoUjfc
X-Google-Smtp-Source: AMsMyM6IJwmBcE9vPDH64YWRGGC24vHjFvwk/hYhy8F02siRswUbwAPjnA+AjOrHq92iHkj+VUuzjQ==
X-Received: by 2002:a05:6870:7390:b0:131:de6f:b7ce with SMTP id z16-20020a056870739000b00131de6fb7cemr3741675oam.245.1664544076918;
        Fri, 30 Sep 2022 06:21:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c53:a5aa:3322:e297? ([2600:1700:e72:80a0:8c53:a5aa:3322:e297])
        by smtp.gmail.com with ESMTPSA id r16-20020a056870439000b00127ba61535fsm705816oah.15.2022.09.30.06.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 06:21:16 -0700 (PDT)
Message-ID: <1c3ec9f6-7733-8815-2122-300512628712@github.com>
Date:   Fri, 30 Sep 2022 09:21:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/9] Bundle URIs III: Parse and download from bundle
 lists
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <20220929220031.1438958-1-jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220929220031.1438958-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/29/2022 6:00 PM, Jonathan Tan wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Derrick Stolee <derrickstolee@github.com> writes:
>>
>>> If some of the reviewers from v1 could check that I responded to their
>>> comments, then that would be a big help to getting this series moving
>>> again.
> 
> Yes, all my comments from v1 were indeed addressed, thanks.
> 
>> Thanks for a ping.  Also, if reviewers who missed v1 can take a look
>> and give fresh insights, that would also help polishing the series
>> further.
> 
> I didn't miss v1 but I gave some new insights. :-) The patch set looks
> good except for some commands I had on the last one.

Thanks for taking a detailed look. I've added extra "any" mode tests to
my local branch in addition to the code changes you recommended. I'll
plan to send a v3 early next week, giving time for any other review
comments to trickle in.

Thanks,
-Stolee
