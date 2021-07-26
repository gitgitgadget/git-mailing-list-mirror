Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC7C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C30F60F55
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 14:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhGZOD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbhGZOD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:03:57 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9BC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 07:44:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d17so5138224qvn.13
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/lYKUJl0qs9v7EutNiEzK/gAl+biwNYVb2sBxAuk/0Y=;
        b=pmUqJdLCx+JgRKaDaW/dA/nbooQu6QyFdH3zfyVs9Q6F+HbDH8jcHGa+cy5UUgHV2d
         uk0t89VvC0NCQFarDJ3nAkmCzIGFbJ6QjH1Ig3xyM57fid4FCbNqpRWNsSAyxOeHIS9c
         VIcQxnHwrxGNg+U0QRRM7JtgUU8nFbVs87TWW4X/SBbUI5fy1lamlCKweZusCif4guNU
         Bc9RNbaEHqOcrNvIAVJ95Ai1Dr/Ro/jwwl28B3+mJpfLJRJN6aLtK7VeAoKRGScX5M97
         ZRPGNo6FsrLFXLaS29STqMOA9nc0fUqGpa+YISf4q0AyQ6R483BQ6hwy/DiTOG1dYjpr
         y4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/lYKUJl0qs9v7EutNiEzK/gAl+biwNYVb2sBxAuk/0Y=;
        b=qbpqBLWRP9h5K8spUzIhhcHpQ3d9JvAdh1RmS6OkOuLHnLUU6gZXYME9NDAIuznoBv
         +TGoTH6Ellv6LaecS/5zmQfwiXOr4jMD6Jkh2sxH2/0ry37YNlIeRHfjXY3yDokbt56K
         4HQwbDNmG9Npoi6juns7MtIk05xDz6bGKsTujaIxfYdQLN6YCh8EoKOxMwRcoX6rSjFx
         rkHBRKZfDWf3PV6zbAL7UlK7UQxBAgegcGuzOpRGhRO/6uZB3axZpuWKI4Ky8bga3THt
         kOBRCiT6/kMAFdawu9mIK8oaew2e6P6VHk8a1I9KyXYypQij0SxBZMRJ5Kq6T9YPJ86+
         VkbQ==
X-Gm-Message-State: AOAM533Em0xtYTCLxMTk0A/DmtBdFo+MmYr/p4AZiGXRv5KIEDLl8psW
        OPNTaHnQx841RrYcXPg4GYU=
X-Google-Smtp-Source: ABdhPJyykEiENVbUCitPybhPdImVA1WyQnIzsJZRappL1PYDHu3jjg6Bdqm0RVfUl0C2FfvhFao2+w==
X-Received: by 2002:a0c:f084:: with SMTP id g4mr18178749qvk.52.1627310664714;
        Mon, 26 Jul 2021 07:44:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8509:d58a:ff00:9b31? ([2600:1700:e72:80a0:8509:d58a:ff00:9b31])
        by smtp.gmail.com with ESMTPSA id w71sm87482qkb.67.2021.07.26.07.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 07:44:24 -0700 (PDT)
Subject: Re: [PATCH 0/7] Final optimization batch (#15): use memory pools
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <884002ab-c59d-143d-0cf0-8d06d5fb5f0f@gmail.com>
Date:   Mon, 26 Jul 2021 10:44:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2021 8:54 AM, Elijah Newren via GitGitGadget wrote:
...
> === Basic Optimization idea ===
> 
> In this series, I make use of memory pools to get faster allocations and
> deallocations for many data structures that tend to all be deallocated at
> the same time anyway.

Makes sense. This is appropriate for a final optimization, since the gains
tend to be quite small.

> === Results ===
> 
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28), the
> changes in just this series improves the performance as follows:
> 
>                      Before Series           After Series
> no-renames:      204.2  ms ±  3.0  ms    198.3 ms ±  2.9 ms
> mega-renames:      1.076 s ±  0.015 s    661.8 ms ±  5.9 ms
> just-one-mega:   364.1  ms ±  7.0  ms    264.6 ms ±  2.5 ms


But these are larger than I anticipated! Amazing.

> === Overall Results across all optimization work ===

I enjoyed reading this section. I'm excited to make ORT the default in
the microsoft/git fork and see how this improves the lives of our users.

> === Caveat ===
> 
> It may be worth noting, though, that my optimization numbers above for
> merge-ort use test-tool fast-rebase. git rebase -s ort on the three
> testcases above is 5-20 times slower (taking 3.835s, 6.798s, and 1.235s,
> respectively).

The performance and behavior changes recommended here should definitely
be considered. However, the benefits still apply and at the moment users
do not expect immediate responses from 'git rebase' so we have some time
to approach with caution.

I only had one small question that is not even important to the
correctness of this series, so feel free to ignore it. The patches tell
a convincing story.

Just to be careful, have you taken the time to run the merge-ORT tests
with --valgrind?

Thanks,
-Stolee
