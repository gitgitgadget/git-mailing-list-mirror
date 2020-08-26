Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7165C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4518214F1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri9/uJjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHZQV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgHZQV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:21:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0EC061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 09:21:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s15so969109qvv.7
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DVOkZGc/K4MSKtQUqLwPyKpJOksjG1DGsUmEUghDiEE=;
        b=Ri9/uJjXF69KrQZ+gOCLdTWV9rFyUiJl+pjks4RIXqHpFJPvGWWeChM4LGidEpbYpg
         8wEyd6VIP2iAUlmBmvB9t3Oo0rtpwILDGrGGQ1B6xCQCesNFUsoLifD1Ed5mINVUUAEf
         bschr9vNDfVQauUFMLJuFLl0gWv5gpmu0Fr6s3A/NE+vxedhD7M9MMlmttsg2MDqOthE
         UoMMytQfo0gaBe5C2M/9miIwyoPd6dUHn0Vkv897qr1YTU6NC2gdSLV4H3A+fsxqrmmL
         KXNmdecJn5ZG4soB4s0brERhV3qdQEKR4OR6WOPSWb2+BE0yN2YLSNAAnI9SB7N+YPFh
         aspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DVOkZGc/K4MSKtQUqLwPyKpJOksjG1DGsUmEUghDiEE=;
        b=fa6SnSTdep9dk638+Ogg5vGfYzpoyCrvACpyb5eNzMVyjzuTblmF+HWts2UjDB9KAT
         wYCOtq8NUtMXs/ySXJWDzfEiEA8E/GUx5KMwkzH+vctuVfU27s+nHqWzEu1bvDx3VKWT
         9/Y7cRserMdfPUh9guxA9QQCXzXPGo0vl8rX3dx/vUC3ie3hp4LvZQ/dOsVASkqe/Hl/
         yd/OZF4c/uT7dX5sGT6VFZ1sm/1Fka7Hj6kR9v6/w+bhicUKgybbjPBiK7ZEmh/5UDKr
         DXzka5PJ/N9N6cXEdVjFroEq9CL/i4SEsSUyBSuXlD2EvqYvAViF5OkhXkiwGLX7Ntor
         SQ3w==
X-Gm-Message-State: AOAM5334zPqH85GIKblxPjYs/oBsvUFvHAKnjmKj6iyHAcFB5VxSB3NG
        cBLXv1m9NDERvHh6ynK8jLE=
X-Google-Smtp-Source: ABdhPJwrKAfJbKJnwI9zFPTASJVyOh7XZ2+88n3nAopOJBNTeaOXoeC8rhRYnuWPeysW8J63Z3W68A==
X-Received: by 2002:ad4:4aa5:: with SMTP id i5mr14744272qvx.179.1598458915682;
        Wed, 26 Aug 2020 09:21:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id l38sm2448689qtl.58.2020.08.26.09.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 09:21:54 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Maintenance II: prefetch, loose-objects,
 incremental-repack tasks
To:     Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, Jeff King <peff@peff.net>,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
 <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
 <56C4015E-B431-4B16-8E05-5919BFA71E80@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a236846-7631-d999-1579-332d3b3341da@gmail.com>
Date:   Wed, 26 Aug 2020 12:21:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <56C4015E-B431-4B16-8E05-5919BFA71E80@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2020 11:15 AM, Son Luong Ngoc wrote:
> Hi Derrick,
> 
>> On Aug 25, 2020, at 20:36, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> * Dropped the "verify, and delete and rewrite on failure" logic from the
>>   incremental-repack task. This might be added again later after it can be
>>   tested more thoroughly.
> 
> Perhaps I missed some conversations related to this change but
> why was this verify-rewrite strategy dropped?
> 
> Was the problem such strategy were created to solve is now no longer a concern?
> 
> I feel like it would be much better to add it in and then remove it using a separated commit?
> That way we can follow the reasoning behind these decisions via commit message.

The most-recent message was [1]

[1] https://lore.kernel.org/git/20200819174322.3087791-1-jonathantanmy@google.com/

For now, I'd rather move forward with this simpler task
and I will revisit the "verify and fix" situation when
it can be done in a focused way instead of being surrounded
by builtin boilerplate and other basics of the maintenance
feature. Specifically, it would help to have a way to test
the logic. In Scalar, I was able to mock the Git commands
and return failures in specific places. A similar approach
could be done here, or perhaps there is another way to be
confident that the "verify and fix" logic is actually
helpful.

Thanks,
-Stolee
