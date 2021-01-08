Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEF8C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340382388B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbhAHVAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhAHVAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 16:00:21 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52546C061793
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:59:41 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id r9so11078664ioo.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dctwoewiBYKZ9tSMJLFodedzzJfT/+ys8QGwx5gtXpM=;
        b=UuP9nVoIrA3HhOCqAHMZKrQEWkqugOq0Q92v7pEhiCdY2S97odg8i0BgxLrmc1GZre
         DyRO8BMmm/pMIo1Qd0u7ktjbZ0n7+JxzXbuJuDPztmoeBghjphTmuxw2Md8Ca+11ncYl
         9fLRktWOw3B+Ka2EFzzTowpE2vLdTqXg9G1LdwZW8ZvSt7MKkK1tIpNwK4NCiKgET+b0
         Tb+KqBu/2gk6fvik+Kje+Fe+Jlvd/smp+7Wq6S248qw/0v82J1VlIhw2gI4mi+AkmjIV
         Y0YiPD1Tb1BClC9+LeWKAWrw73/ag0oKxbN/GfM8uE4wT0Q2ROiJx43460btnKyYicn0
         j20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dctwoewiBYKZ9tSMJLFodedzzJfT/+ys8QGwx5gtXpM=;
        b=H4DBlGggZ+nODt7vvJRqJNvqjX9llaAD6sRIeIvEcKWcbNYwAm5egqKi6W1A6B7yv4
         xYhwCzlM2+3D8sMq0meo2gGvcMbyF6o6tefbFJiEBsbHLYtinx80LmIvnfdys740vlfq
         4woysEDyFwcGbl5wSM2x2nF044GQFLp0eHMc8YVo6C/NbIIkN8ecl7gvYP5pobcFTdvd
         RdtFWKH65NN3/DA7K0EFhrG57M3sBCHmLATAXVZbRYp8tJcvkpfb9RgO5VYKXB5KZwMe
         QUfIftQ9qIT0EyzQ17cVchVQnPCD7YpfgmDjQPui9er+CMvVRroPaXmonszw/l6qDOSx
         bBhg==
X-Gm-Message-State: AOAM530kkD2X2n7dwJqaYCujYnvxGYkMByen6KB1NN2fDmpW3fFDDnw/
        x6GL7i7Rck1ut7zb6mtVkBEFAA==
X-Google-Smtp-Source: ABdhPJxi4j5Q/NfGrWMMTe3OSAtXb91lAg4eIAyIfvCWCte6vs39whsDAV8f0IQsHs8QVU9vqjnFwg==
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr4868361jaq.102.1610139579514;
        Fri, 08 Jan 2021 12:59:39 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id p7sm7634038iln.11.2021.01.08.12.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:59:38 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Fri, 8 Jan 2021 15:59:36 -0500
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] merge-ort: begin performance work; instrument with
 trace2_region_* calls
Message-ID: <X/jHpZlSxwAxoUyq@nand.local>
References: <20210108205111.2197944-1-newren@gmail.com>
 <20210108205111.2197944-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108205111.2197944-2-newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 12:51:11PM -0800, Elijah Newren wrote:
> Overall timings, using hyperfine (1 warmup run, 3 runs for mega-renames,
> 10 runs for the other two cases):

Ah, I love hyperfine. In case you don't already have this in your
arsenal, the following `--prepare` step is useful for measuring
cold-cache performance:

    --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'

> === Goals ===
>
> This patch is obviously just the beginning.  Here are some of my goals
> that this measurement will help us achieve:
>
> * Drive the cost of rename detection down considerably for merges
> * After the above has been achieved, see if there are other slowness
>   factors (which would have previously been overshadowed by rename
>   detection costs) which we can then focus on and also optimize.
> * Ensure our rebase testcase that requires little rename detection
>   is noticeably faster with merge-ort than with apply-based rebase.

These are great, and I am looking forward to your work.

> Signed-off-by: Elijah Newren <newren@gmail.com>

Thanks, this patch looks good to me.

Thanks,
Taylor
