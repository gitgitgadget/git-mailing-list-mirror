Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C908C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FA020658
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIEsly78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHMRBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMRBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:01:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA3C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 10:01:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so5815056qka.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H3h4lVoMST5F3wjjoxkKBrT5QUsBibv6LhZQp87FBxk=;
        b=WIEsly78JuQf88KPGHfdMzUMslvQAq3oM3EW8m3ho7ukrvzaB+wFuYu9zVWABcD90C
         HmAlGHYlX1jOON6Snq4DLbs/Z1QYy2rlGK/ZXuO/LZy1/pLi/PpwurnR0uFT9epc/uNj
         6Q5XrLJiSnMjfJurybZRYb+zFXOi3uGVtVxaCvLXbJxtu39yL5+ncC8Y2Oi8HsyN7Rhu
         wohZhcP0NLI2haFBi88JrfxtZ8ArOte5IG9+tWPYfzN7RCF4aySrBbKs9byvPZFmRKpD
         1xQmunZwlxLww2p9gv8d0JFo2fAKjhdeHXD7NAyopFFG9z7N1rSkU1s8q+CdPWJLoOd7
         vpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H3h4lVoMST5F3wjjoxkKBrT5QUsBibv6LhZQp87FBxk=;
        b=GGGmSfhODPQCL7S3H6NPDHi1kuzmKI+Y7cX4xhIJpvg7naINI+frk/zks03iK/Fhd2
         xUvZ9JIOi1jI7SKCOvcMbjKqzvb3867Za8vzeNED3QJUA/Wn2k8YtdUh8LxS7wirF7Js
         ZW2hwRZNYQw9UbgouPRfbJHXjeoIKyS+LXESdvSUsRLxGoLAf8TSbV+EW3Tr5Aj0mLds
         VoasZYgwEnnXKsI6t6xCTAJj7PN/XfTv/01eK6HQ5HGIx+vH5EFiPaHJhDqh/Rj0q2FN
         PFaI0C/rcsjzCIuxLqXVtmGn3f+ZABZ5H5Op4bd07pnotYnQCrSNWAmrq2x+dojN69pA
         lRfA==
X-Gm-Message-State: AOAM531/zf5kiFpEtGRXSZo0pdaxl35OfnNT2Pk21fd79WFhgm+ppq9f
        nTCmQBzMNPvBO3hBR3ip2xo=
X-Google-Smtp-Source: ABdhPJzG1IDEQrhjJbTREYmagu0MS/fi1H5aCr4rUCp4Okzyc0hwG0b6Nv4zZfnc6Rq5Qg51u4qNVw==
X-Received: by 2002:a37:27d8:: with SMTP id n207mr5596085qkn.446.1597338103839;
        Thu, 13 Aug 2020 10:01:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id x12sm7799266qta.67.2020.08.13.10.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:01:43 -0700 (PDT)
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
Date:   Thu, 13 Aug 2020 13:01:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813145936.GC891370@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 10:59 AM, Jeff King wrote:
> There's no reason that bugreport has to be a separate binary. And since
> it links against libgit.a, it has a rather large disk footprint. Let's
> make it a builtin, which reduces the size of a stripped installation
> from 24MB to 22MB.
> 
> This also simplifies our Makefile a bit. And we can take advantage of
> builtin niceties like RUN_SETUP_GENTLY.

I agree that this is a good change. I'm a bit surprised that a
feature added so recently wasn't added as a builtin in the first
place. Perhaps that was a conscious decision? Maybe it was just
because there was some point in time where it might have been
relegated to contrib.

Thanks,
-Stolee

