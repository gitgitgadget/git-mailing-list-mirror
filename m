Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D2C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E346560238
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJ0V7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ0V7c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:59:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE20BC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 14:57:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c9so2458383qvm.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xR8aa0LS9XPvGDC06uHYoUwei0u/1m0b/iVu/FKasVI=;
        b=WnlZN8+zEK9n5jhExceQdsO0N2Q97ayplanec+PIX/GXb85X1lSJoyYBmjb64J4OOX
         qye2+6i255gnE2Jp088MGJP4ljiy2vS8Gh75JStxtfWe2+BIouW2dLo5YRNcatquSKLH
         4+CnBOObTgIsjaTjlrOcRhLTc5fVQdrpQEC/489rcRQEFU9kjGGN6wHSCiC4pQ/qVFNd
         cIPoKp82G1KSy9196qfjyzVBYf0Cpc3b7p4auc5MByPtALcZU2pu7akoES3SJGdfrgcc
         mHcSs1Ui1cD7X16TdjkZjxWmQra2PzXyuVN47kcz30qZwaeOXEySdRR14VFCfzS9U48q
         UnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xR8aa0LS9XPvGDC06uHYoUwei0u/1m0b/iVu/FKasVI=;
        b=JZo5KfRylkKKDuJ1bC0y1Jni2+eATmoN1HmF95SUhKpoyXYJxoq0a1DX53P0akzL+R
         AVjTwmE7FYnmacZb/Qo1Eo7m2oPjU5uuAx4f2ZTruVC/9tbkvsnDw5okyRN+ComjiUBV
         cZmqASu8o+5O7w3nNdqbd3s12RqcGKNvWhISCPcPyeUl0+cYbjOTfWFy3i6J25nNa7KX
         C134trcgqPpVlTqdQ5GpXhppQiC2N5Hry6AHj28r/RH5OjZHMiJNK9dkMuWFKx6Wz6lX
         Y/vxGZKrjs6IMRYRacIQBnhPYp7gYC8L3Dk66aCCGkKnLW6vd5DGQXeqa4TtfPZhz4Ic
         1pbA==
X-Gm-Message-State: AOAM533zAe4IBR22YvS/kBS/SWO262dhM8jNzxlzkwwhIuQAwzLaC1Gq
        dS3uE2izTkUBqiDYedp2V6o=
X-Google-Smtp-Source: ABdhPJwAYRNoL75phsddvbIrZhyrLvZ6Wg2bMbU+rYEPgIRfthseWZuvGZCUxuND4LL+XRfRRIy2wQ==
X-Received: by 2002:a05:6214:1d2b:: with SMTP id f11mr503593qvd.20.1635371825907;
        Wed, 27 Oct 2021 14:57:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id x22sm906921qkp.103.2021.10.27.14.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 14:57:05 -0700 (PDT)
Message-ID: <3b7f5ab0-abe5-836d-9e36-0d8cd128401c@gmail.com>
Date:   Wed, 27 Oct 2021 17:57:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v6 00/15] Upstreaming the Scalar command
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
 <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 4:27 AM, Johannes Schindelin via GitGitGadget wrote:
> tl;dr: This series contributes the core part of the Scalar command to the
> Git project. This command provides an opinionated way to create and
> configure Git repositories with a focus on very large repositories.

I started a discussion [1] to help answer some big questions about this
series, but to separate those thoughts from the concrete patches. If
you are interested, please contribute feedback there.

[1] https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/

Thanks,
-Stolee
