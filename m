Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9786CC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65895214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S03w1oQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgAaOlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:41:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33045 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaOlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 09:41:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so5583354qto.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fi0E1IGxZpGHXYeLC9CBJ00OCiSjXPcwiGqhuHJuuhQ=;
        b=S03w1oQvcjWag/NYHOYf9t956rM1qzOhTDKyNAdE5zoh46h31acWYw0uxiQJ/eALvs
         2O2jv3bqyvilwJ1a8jtt37gylq6ywdswwayngVGKkn/KDqCsOTsdh7qxx4xxwMoJ8q8h
         c1HDQESQmxqeWKRtndUU4CjPg7+3PBmkzxg/nNqzE3kKBW3Ke30OMrY6nESF+oQX3shc
         KIeRGC8LIK5tvp6HGHmUkZC0oJ2Pv0gJqhUVM1u68irhZQ3BSmMA4knIKG+npfvoYtSi
         NV9cC0hvGUqsvuVCt/N+hiBdXgk1tB4V1AZQflA4CGQxAvjRCvLqv17UBKNgDPixBA19
         ZnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fi0E1IGxZpGHXYeLC9CBJ00OCiSjXPcwiGqhuHJuuhQ=;
        b=XEG7PiLLUXZ9ArbuJkOCiGML6nb6p53SEpH22kSGtjCusvg+1bBzX2SPMNYKapv8+E
         4FTm6x5TXrykXS5XTmjxtzO/BRTiZUUONSU/HmicvHKbVTVSscBE+oodQwel/2wCQMtI
         jWXVrg6cKUZSNv2kUUlZfdIrAEIgLrx8IKX0DbsFRvVC8ukXFgm1ekKAQC6S6KbGYRwy
         /IDq0zoYMazwKlcv0PyQf87n6qdt6ArfiK4PR8vwsJ2+naarhwghwWfCVTwEifVFDDks
         MHbTNLcWlhWrkDvMSqUEmbCMvgEd8OSY6lIMgoxr2fHqqTirpCHt5O3122P6HwQF5pyL
         J+Vw==
X-Gm-Message-State: APjAAAW5X/Hc2/ADCgoOvGA6/AXxgN6nq/Mia6sYBww4KA+CNWEOkgJY
        9wEXuBEwvdDC2YuZ7fRuVUo=
X-Google-Smtp-Source: APXvYqxk6vksnboDopzbBFxjQhEoUjYWsLvUuVnbParO2I1oYcbeRvdcx1ASWhr1ePh44eOXAml7pQ==
X-Received: by 2002:ac8:78c:: with SMTP id l12mr10910089qth.187.1580481662292;
        Fri, 31 Jan 2020 06:41:02 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e1f4:827:3448:54f3? ([2001:4898:a800:1010:932a:827:3448:54f3])
        by smtp.gmail.com with ESMTPSA id x19sm4993432qtm.47.2020.01.31.06.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:41:01 -0800 (PST)
Subject: Re: [PATCH 0/3] builtin/commit-graph.c: new split/merge options
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
References: <cover.1580430057.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b873ab69-cdae-7f71-b28b-671b62cea5a8@gmail.com>
Date:   Fri, 31 Jan 2020 09:41:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 7:28 PM, Taylor Blau wrote:
> Hi,
> 
> Here are another few patches that came out of working on GitHub's
> deployment of incremental commit-graphs. These three patches introduce
> two new options: '--split[=<merge-all|no-merge>]' and
> '--input=<source>'.
> 
> The former controls whether or not commit-graph's split machinery should
> either write an incremental commit graph, squash the chain of
> incrementals, or defer to the other options.
> 
> (This comes from GitHub's desire to have more fine-grained control over
> the commit-graph chain's behavior. We run short jobs after every push
> that we would like to limit the running time of, and hence we do not
> want to ever merge a long chain of incrementals unless we specifically
> opt into that.)

I can imagine many scenarios that require the amount of work to be
predictable, which the current merge strategies do not guarantee.

> The latter of the two new options does two things:
> 
>   * It cleans up the many options that specify input sources (e.g.,
>     '--stdin-commits', '--stdin-packs', '--reachable' and so on) under
>     one unifying name.
> 
>   * It allows us to introduce a new argument '--input=none', to prevent
>     walking each packfile when neither '--stdin-commits' nor
>     '--stdin-packs' was given.

I'm happy with these goals.

> Together, these have the combined effect of being able to write the
> following two new invocations:
> 
>   $ git commit-graph write --split=merge-all --input=none
> 
>   $ git commit-graph write --split=no-merge --input=stdin-packs
> 
> to (1) merge the chain, and (2) write a single new incremental.

This is much cleaner than adding yet another option to the builtin,
and allows more flexibility in future extensions.

I have a few comments on the patches, but they are minor.

Thanks!
-Stolee

