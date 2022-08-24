Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10393C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 03:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiHXDuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiHXDuA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 23:50:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6CFE9F
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 20:49:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x5so11881255qtv.9
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=kWiqeEh57hbYK+EhtLE/np/2Fv7F+C0nIfezOe31ngA=;
        b=MCzAtfGXFGQRDl1WIAWsqjJ4u/9iWr3k/6ZOMVM/pZkHX7ETizr24Wk1jq5K5TEZhd
         NJMvjdl1od3wQAobnJIzHszbeF7AKh3NTq5USbZFMXucG/oWt7pQqViXgR/jFHUl9Ybq
         HK7H0xsG96K9DUQfcMhBROVX/i/drbygmlNlkVT/JHBxu2xuDyTLxDMvubiTa3s1w/do
         gZR/muuvu1jixlFN0ddXop1KvqBDC7/9EdPN0w1nAeNtUzURotTFm3cW0vm3Xk4rKS/V
         jidZbJ09wXqApP/xT4jQTJsIUbTlmm77Epbrl3+F876KCQJliZfZlaXgZNErxzOfYmc+
         4DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=kWiqeEh57hbYK+EhtLE/np/2Fv7F+C0nIfezOe31ngA=;
        b=a1rH/64Tbq2R/3V543bqQiu3PpEIVK6AIv8YRtQGOA4/d4kmGDM99uFYsqczj8EpoB
         OPHqyiEwWX/kNRvLgMRVLqEVuubRGmbZJVi5A8lUa28j9wW4Vnud9fqGwFpSd6HOsURQ
         MnDyWPjSsNjeWhlCItHYYrMzXuVD50UuVEws9c4yCIxGGcGOCVTl40P2ljowUL+3N66M
         dl5AaoJuudb/M8rrzr0eMSFBZRCqt93Hn5cUTMx5cCVizeuejP/CUNcPvI/eR+/Q1ntg
         hpi9AdR9K89uAxS9DG/QI0i8DkTYeYpXvRSkyHECu5ukFAd+gyIamPx6vjGwxZLfhs82
         Dlbw==
X-Gm-Message-State: ACgBeo2gHjMDpegwVAvu4NBMQvzGVqv76SrmPs64LO2WOlT1bmvwEQOU
        YG6dic7iDiaLGzyLJ+O2kGI=
X-Google-Smtp-Source: AA6agR4MgM+kT3YDpMyPAMj4gjiDnXayq/+4SaedRFtrnErN6JgOk7KT4GCcbCh88kWth6vk2bGTRg==
X-Received: by 2002:a05:622a:1787:b0:344:94c1:fb0e with SMTP id s7-20020a05622a178700b0034494c1fb0emr21614486qtk.82.1661312996529;
        Tue, 23 Aug 2022 20:49:56 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006aee5df383csm14196049qkl.134.2022.08.23.20.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 20:49:56 -0700 (PDT)
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
Date:   Tue, 23 Aug 2022 23:49:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-08-23 à 14:04, Johannes Schindelin via GitGitGadget a écrit :
> Philippe Blain reported in
> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
> that there is a problem when running the built-in version of git add -p with
> diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
> The symptom is this:
> 
>     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'
> 
> 
> This patch series addresses that and should fix
> https://github.com/so-fancy/diff-so-fancy/issues/437

Thanks for the quick reaction!
I've verified that the patches fix the example in my reproducer, and they also fix it
if using "delta --color-only" as interactive.diffFilter. Delta is another diff colorizer
(and more) that's facing the same issue as diff-so-fancy [1].

However, I've tried it on a more "real-life" example, and then I get:

    error: mismatched output from interactive.diffFilter
    hint: Your filter must maintain a one-to-one correspondence
    hint: between its input and output lines.

This is despite using "diff-so-fancy --patch" as interactive.diffFilter, which should 
keep the number of lines the same. This ('--patch') was added in [2], about a month after Peff wrote the message
you mention in https://lore.kernel.org/git/s40ss309-3311-o08s-38r2-9144r33pq549@tzk.qr/.

Again, when using the Perl version with this new example, it works correctly. I'll try to come up with a new
reproducer for this... But this new example does work with delta with the builtin version,
so it might be diff-so-fancy that's the culprit...

Cheers,

Philippe.

[1] https://github.com/dandavison/delta/issues/1114
[2] https://github.com/so-fancy/diff-so-fancy/commit/13d3f8949e15dd62f6b49bc652fe94af6a9bfc79
