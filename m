Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897FDC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30ADA22CA2
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgLDUHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgLDUHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:07:11 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC61C061A52
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:06:25 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h19so6432970otr.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vB06D3KWOtvHbHDbM0RW2naNGeDq8NDKd9FkxqmIeH4=;
        b=F0BgJQKF5pfbwCWycIZNiNJynGeO2tuYXFqTHWkI1w3rgcBG/Ak4E5IdJKlU7zt1Jw
         mogZAGkbzAoDPht3eNWWdr2L0kxZ7qHzJwWiJY2BK3Obm41FMPjz3TdvIgX1lrayxuYO
         TXf/SPnYIf5esm3wN92FcMeZeUjA/nzr57z/9QHbwr2fqAKfDOTWcE6sfmcCnBv44rMj
         de9M1JSGrs0qF/TsRM1rIPVce3Bi6e6vso1HCI/wDdR76R4l3HYQr8p5B1ojiMaHi6v6
         v7zG2rfJKtduUDc21NFT/hCtAYVneJVhDWKqHZCH4aiBqJrzz9VQYyo6ki0uJQDvwS2p
         X8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vB06D3KWOtvHbHDbM0RW2naNGeDq8NDKd9FkxqmIeH4=;
        b=O+A7ivX70mTAC9Z0aY5zClafeVa6kImvmPUVaKP6MEMcNIn288Cr7Q1MSrV/siKOeM
         yS3JVUbcJS+jgNe10FsIAGB7Wk+8Im4ql0urqgXupZvJg82weuI8a8cg8kbOShyxnYjM
         TDplEgIKUTqe4Xd5F4hJyFaoTHVRmW2nsf4XRc5nlNMUa+l3k+a+b+WOtjq2ZgqIyuqA
         aMWljeFgC48Z1E0neK8mSEyiwxdtj0WYnusZ4b/H3TKSQqm3uk8jgoPeiplgypDeVr/q
         WVPoHlvmvHh6Yw8KDHmLxMHNSGzmGPD6vwPYXIvKwKVFgbuj5FxaAbXXdO2fH1W4GwZc
         JyaA==
X-Gm-Message-State: AOAM533zYCh/EWisxlBOFtH4HRt4uYtlVjAEOgD8vzDOP6BwXfDeUgl2
        M/KYRoO5dh7aI4aSEyxSqCU=
X-Google-Smtp-Source: ABdhPJxp5w5Ej6D1KpbEkeMr7FASCZ78gPCx6U9oIgXigXPDX9Z9mLScelb34RrYVeas72OmOv55Xg==
X-Received: by 2002:a05:6830:159a:: with SMTP id i26mr1708098otr.315.1607112385105;
        Fri, 04 Dec 2020 12:06:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id o63sm869272ooa.10.2020.12.04.12.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:06:24 -0800 (PST)
Subject: Re: [PATCH 7/9] commit-graph: drop count_distinct_commits() function
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1103d97b-668f-8ad6-fc62-3fa09067a8bb@gmail.com>
Date:   Fri, 4 Dec 2020 15:06:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8qGTaIdnNa5mAfC@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2020 1:56 PM, Jeff King wrote:
> That turns out not to be a problem, though. The only things we do with
> the count are:
> 
>   - check if our count will overflow our data structures. But the limit
>     there is 2^31 commits, so it's not likely to happen in practice.

You do point out that you are removing this logic, done in this
if statement:

> -	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
> -		error(_("the commit graph format cannot write %d commits"), count_distinct);
> -		res = -1;
> -		goto cleanup;
> -	}

What is the harm of keeping this? I know it is very unlikely, but
I'd rather fail here than write a commit-graph that gets parsed as
garbage.

Thanks,
-Stolee
