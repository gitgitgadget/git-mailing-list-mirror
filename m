Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3495AC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37FE221F7
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437936AbhARU3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437806AbhARU3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:29:30 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4E1C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:28:49 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 143so19837843qke.10
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B23zgc1sNqPKK44vJUGQzink3HxpS5yfaxTRdkN5IBs=;
        b=KFj7RTblWePoj1RyZoVLeMFo2PkUgdnisMFkTCC5rDgsKkrU75R9YjeXj0FbzWKVG/
         BSubiZpICwrbFW/2AO7WxQiNgofs+QCjmYqHDcIrRbERFvnHrW0jgoPEP7ZKSxAB3INR
         YUEA1ixmqkNfGwLEBzjKHbS6An5m+NgqcKAeFziYqNKBBotwwha1FsjuJe87EGjeB8bM
         4No1keRKr2k4knqYwL4qW6uzKrB60vjd50oECmnm5mDfG50E+J8v8AybnOorcAYBUJAK
         5GpwasEy4L8sigh3w8/SU8hD8ayTAVV05qmOW/wVeRZuRfIQzPIY9bYj7K1Fm08N3Mwt
         Nimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B23zgc1sNqPKK44vJUGQzink3HxpS5yfaxTRdkN5IBs=;
        b=N8Y3LrQoEyaBrIMngj9xJ5QuJVhFk5291YtbJQ4qCOSgrZO02llQ01BFryLpf2xH4o
         W13utKl9aLPplhVfwAFYpYs93St6NGsFG1PqE2JHDI8a1AvPOUkITA1X/ZpSzI51nc6h
         uHMP+cxMZD5bQq3Ib+zf25Ht5my/wRNZENJ3y92VmA+F0SGCYWl1c3p4sa5iP6fOMEAK
         +vpiYnDYTJ0y9buhAdJZW+is2KhV9vYU37a0xv198QvlsZHu9P1d/siz6XZEA5lx6yIc
         KobcrKwWbJnrfVX5l0MvYQGMOqhxxFOuBd01abf5LkWiWBDn9yBgV5FhFLUUVA7yiRMw
         fVtg==
X-Gm-Message-State: AOAM530j4GPEqLI/W/PgV1P8LJP9/dlsIFuHmh2WbNi564DCQKveiFTr
        fNKlYfOW2qYQMj/KV0zz0qJGjw==
X-Google-Smtp-Source: ABdhPJztSozk+J8p0WcycZ1q5oYQM2BW4onnC2vRIqRTay10gu/HcSXH2f0X/S6JgJCMxSRcn3ncQA==
X-Received: by 2002:a05:620a:983:: with SMTP id x3mr1331094qkx.231.1611001729091;
        Mon, 18 Jan 2021 12:28:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id x20sm11594344qkj.18.2021.01.18.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 12:28:48 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:28:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/17] merge-ort: add outline for computing directory
 renames
Message-ID: <YAXvfkIj6IUypCAQ@nand.local>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
 <ccb30dfc3c4c9ad2fc7cd33dc72ecf768827ed9f.1610055365.git.gitgitgadget@gmail.com>
 <YAXnfwGpvhtxbQhF@nand.local>
 <CABPp-BE+NmuFE-Vj8dAzs-Jdsz_ruDE6P_GhAKfrFAe-sJcNEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE+NmuFE-Vj8dAzs-Jdsz_ruDE6P_GhAKfrFAe-sJcNEg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 12:15:11PM -0800, Elijah Newren wrote:
> If the intent was to keep merge-recursive.c indefinitely, then yes it
> would.  However, the intent is to (1) avoid touching merge-recursive.c
> so I don't destabilize it and so folks can fall back to it, (2) get
> merge-ort.c completed, and people to adopt and feel confident in it,
> (3) delete merge-recursive.[ch].
>
> This has come up a few other times in a review on the series, because
> there are even examples of copied-and-unmodified functions; see
> https://lore.kernel.org/git/CABPp-BGtpXRSz+ngFz20j8W4qgpb8juogsLf6HF7b0-Pt=s6=g@mail.gmail.com/
> and https://lore.kernel.org/git/CABPp-BEEoqOer11BYrqSVE9E4HcT5MNWcRm7ZHBQ7MVZRUDVXw@mail.gmail.com/.
> I know it seems weird to intentionally repeat, but since the goal is
> to nuke merge-recursive.c, I'm doing it as a temporary measure.

That all makes sense, and is very helpful information to have. I'll keep
it in mind as I continue to review this series.

Thanks,
Taylor
