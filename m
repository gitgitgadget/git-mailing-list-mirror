Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DFCC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A014860F02
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbhHJOsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhHJOsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 10:48:02 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61797C061798
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 07:47:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 3so11036070qvd.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfBaHzms0civLgKmTUT90eF4cYOVHdtL8KgFL+5Ojf0=;
        b=kO64SkWAb8TvqQULK8DlDfSzNsixfeNwrJVZWYNnzlP9cNGerWRwgnCD9FoGHVFwh/
         83K2H/o1nsPRzFmjQC4oIp4rH7178FA1ziPtNp82q7Qt4Zsy+EQ1Qwm1SUFhEX9jQQu7
         UIP86FLbciVuHH7EDvFJ/FGxf3cLXsFX61j8uj1Td7wCzJPw+z527JpnwdmJYLxjVUsT
         VjeMGxR8/m64+SDB3OXElMhBzJLpTuTwc2eVcmY6a1u4qPI5h0LXJS5EcAc4mXDBZFJU
         6087p2N7Gw+hDQsv9O0C7Y6P/jnc8L//4W5dVROGWlz+2P77LHmgyrZP8exxQxfTvn8D
         mDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfBaHzms0civLgKmTUT90eF4cYOVHdtL8KgFL+5Ojf0=;
        b=KcivLQX4BeqqjvZD9/aiwGewBfIGkiSswEgRaLB1Ew+KqmLa+O8lu15sAM/F4GnCCx
         wybuZqdnA6YiFWaOEKGVL8wYSZOhD+SUkTZKIaRYGx4gfha6n1yPNuy8YlbNwfh/sfJh
         5UK9adRRW2HM+Y/OWvP8odjTvzX47rCDkGqS1BxRVWlbZN+XjHP+OMvEdYzNFn9AiqqM
         4OEqsCA5W88q5HqjvnfgLeopbE7+dHym9XC6tTgX3xKzEu/slXMXDZ+r9FZyWdd+zDGD
         zpHuNv3Ep4EZVBOkp7U5yK4xrw5dG11GYv275yGNWigxK9spQTZsHjoAd3QL9xseOF4Q
         WMrg==
X-Gm-Message-State: AOAM5305CrvfGoAAYzzuRM20Pmd+1q4D/p+lDoYA5TQQUA9Nfj3PmLj7
        skxAhm8h//jMBe2T+QyH1Qw=
X-Google-Smtp-Source: ABdhPJxtyPdqwsqvpf3J2tBz5AQIWNi+FOjmKcxm3AxQH3akqSkhbwDz6EpE4+PfeAQYe/GaTauUfw==
X-Received: by 2002:a0c:e7cd:: with SMTP id c13mr2194794qvo.37.1628606859387;
        Tue, 10 Aug 2021 07:47:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:eca1:9959:196d:81ab? ([2600:1700:e72:80a0:eca1:9959:196d:81ab])
        by smtp.gmail.com with ESMTPSA id o26sm3949092qkm.29.2021.08.10.07.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:47:39 -0700 (PDT)
Subject: Re: [PATCH 0/3] some small range-diff read_patches() fixes
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
References: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <65b00c6a-ef88-29c3-157b-24ad9f4d8a8c@gmail.com>
Date:   Tue, 10 Aug 2021 10:47:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/9/2021 6:45 PM, Jeff King wrote:
> Amidst all the talk of clang4 in another thread, I noticed that Debian
> unstable recently shipped a clang-14 package. So I tried it out, and it
> does find one small cleanup. And then looking at the surrounding code
> helped me find 2 more. :)
> 
>   [1/3]: range-diff: drop useless "offset" variable from read_patches()
>   [2/3]: range-diff: handle unterminated lines in read_patches()
>   [3/3]: range-diff: use ssize_t for parsed "len" in read_patches()

I gave these a read. The code diffs are obviously correct and the
explanations are well motivated. Thanks.

-Stolee
