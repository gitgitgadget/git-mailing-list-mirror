Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD11C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B1323444
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbhATUQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbhATOA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:00:57 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7687C061798
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 05:59:50 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id x203so5786571ooa.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xQ3KEinywvLRJCulofbeu9yI7VXNS2seqw97guXw20=;
        b=Hk8JKzkzkHIsECd/hxR6CNrhCYcB/n+jjES/mhE5edA8/Lj/4+jus3uZrp1FNLXDps
         gS54k5EF6nY3QW1iOAI6wvViwAO/VpUywvnwpvAlXHRHROzDkFArbczxLk06b3hs/F1W
         d0A5keqSvKDbDhVH3XXHUD+5KKwmViBWBunrCKbhy8unaDX4F4Q4Z4BbbCJFUaXREbqe
         PC7Uj+mtNWeEVF0R1NrJNFy3KYjIumeIgJDgZnvPjPCuvtklQwPHM5rgbkIknTXl7hix
         fEIdMyB9NgY/z8XvSFSoqxGlYAcygEaaXU5E6HuE4iVhYQKXhrSv9JsXPP7AJy5oKJ3r
         3sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xQ3KEinywvLRJCulofbeu9yI7VXNS2seqw97guXw20=;
        b=pk7IaXLNAa4C6T34KNV8wY9wKSyWo9yIlHmOwxk8D+WMHueov84l9lJYsGnVLQxvFy
         jW5+lfniBjcKq94nKnETdWNAa++jbuHhZXtjC1c4SaOqn4EmjAclnNTd6HZA/JmTYnCg
         uOMP/m6JwDMXejXRV6T3+41zSgvSZCP39DWfzTORom1Sss4DOJoHNtfj2Ia4Ts1vULfp
         MirpcYy1eEpBFEKfxA/exHxZYlHX0y4/yBlFjTQfMSRsj78Q1z553RxAeiMlwENdoDlZ
         /GHRcDggwrOUF7LCmER0FRpk9mwasTNcIzLgMvHx4K5elud0iOC2DOl8B6eys+p1Yjmt
         Z9uA==
X-Gm-Message-State: AOAM533eKvaEcJt/pnLg23yU+QI/I7Qam+QMVC3Lm4CaOtVTsJnuZmoT
        16gX/lk36rKAD2e+yo+hDZlLNxwAlaw=
X-Google-Smtp-Source: ABdhPJz1MTCeym6QwpYgVF4Q605rkWmqJeX5rYd6dG3oOL/L3zZdoujI3SLDoi0grrUpdpa//fqxYg==
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr6199674ooj.15.1611151189969;
        Wed, 20 Jan 2021 05:59:49 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id r26sm370732oij.3.2021.01.20.05.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 05:59:49 -0800 (PST)
Subject: Re: [PATCH 09/10] builtin/repack.c: extract loose object handling
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1611098616.git.me@ttaylorr.com>
 <a808fbdf31afc9ad9ba0ab27ce889e5a2d1a01ae.1611098616.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98c65017-8c22-a21f-0e86-a15d91bd7f70@gmail.com>
Date:   Wed, 20 Jan 2021 08:59:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <a808fbdf31afc9ad9ba0ab27ce889e5a2d1a01ae.1611098616.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2021 6:24 PM, Taylor Blau wrote:
> 'git repack -g' will have to learn about unreachable loose objects that

This reference to the '-g' option is one patch too early. Perhaps
say

  An upcoming patch will introduce geometric repacking. This will
  require removing unreachable loose objects in a separate path
  from the existing checks.

or similar?

Thanks,
-Stolee

