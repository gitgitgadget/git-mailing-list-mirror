Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A56C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 03:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F2361941
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 03:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhF3DKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 23:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhF3DKS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 23:10:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD011C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 20:07:49 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a11so1461112ilf.2
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 20:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ifq0pVE+tQywLSUIEp9EuMByqVQ52l/SsjhlXr0eWOg=;
        b=EJWWAFshDP5+YSJ1E+RJ44YXA7uH49g0yAjDyqk2+23ymqDDSKzYB8fV1WZ96VjXQH
         Pv6r+JoalTZ4uUtE2dROlBPROL/0nbdFKEnJQAH8HsAiTvzvDXQuglEmTd3lm+C4yhx+
         mnjpmxLBT8dY0ihTKKUjZ/EE7fFLU6r4z14Snn6uhJctEyRvFVvV50PQTIt6PlNMK/gh
         fJla22TvD9M1ROQUWlh09CEirWVz/ne8Bj95uyYVjXCRsl1XRV2IaV/E5ohbEKTPTHv6
         U4eOxC4tlYuNtN2K3nXn1BO8rKLUR68wEP8HzWXMGnYszi3wG+e7Mws1oVh1cfOGSdgj
         IkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ifq0pVE+tQywLSUIEp9EuMByqVQ52l/SsjhlXr0eWOg=;
        b=UfwQn6xT68O4gEtU8wHfB7tFatYguyjq4c70HSLOF6I8/a/hoPqTxKDGsKEiEzPRXs
         PIYFjdYVIWP1Qo+XpIm2D/rHh/QwYn6SzX8mx/cXO1M2XEGLqkkdlnPceNlEiqocaA7T
         yD7Ob8bI8luHq/A5fLY9qKNBcfbD6x+A6sBZ9PykJqteRTprToZ3UYMMPw4Oz/+TeZ6r
         dM4pICi9wGcGjvapnBXcmNAPABgx1kyaILHiCcxaOJOdbnq2dWGYw3o8vy6ubNknbVkH
         MNvP8BR90juyOI0X93GtZ+MXjGZM40o4DtMZKZ3RCKreyfY6JddfQM2O6ST9YbAa9bZS
         QA3g==
X-Gm-Message-State: AOAM533kVwGD/p24d7i09sKJdEO3q+y2RiamDLJC3PEMlQm0O8GItCJ6
        uMYXv8LrU+uyGr2ILJnK66v2ow==
X-Google-Smtp-Source: ABdhPJysVWz/4ipp1aGN7jxTEY12T5Z0WWpCn1vU5xy5G2soi6GiHXGrwnDpuGpe9vTTV6qEVBvnew==
X-Received: by 2002:a05:6e02:1b85:: with SMTP id h5mr16552346ili.99.1625022469021;
        Tue, 29 Jun 2021 20:07:49 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:376c:2592:7448:57a4])
        by smtp.gmail.com with ESMTPSA id c2sm11036677ilk.30.2021.06.29.20.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:07:48 -0700 (PDT)
Date:   Tue, 29 Jun 2021 23:07:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YNvgA6RLIMdD77Hk@nand.local>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNovuzAsaEb2uIaa@nand.local>
 <YNuiM8TR5evSeNsN@nand.local>
 <YNvRSJI1oWN9W25Y@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNvRSJI1oWN9W25Y@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 10:04:56PM -0400, Jeff King wrote:
> In the warm-cache case, the improvement seems to go away (or maybe I'm
> holding it wrong; even in the cold-cache case I don't get anywhere near
> as impressive a speedup as you showed above). Which isn't to say that
> cold-cache isn't sometimes important, and this may still be worth doing.
> But it really seems like the CPU involve in walking over the file isn't
> actually that much.

Hmm. I think that you might be holding it wrong, or at least I'm able to
reproduce some substantial improvements in the warm cache case with
limited traversals. Here are a few runs of the same hyperfine
invocation, just swapping the `--prepare` which drops the disk cache
with `--warmup 3` which populates them.

  $ hyperfine \
    'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' \
    'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2' \
    --warmup 3
  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
    Time (mean ± σ):      23.1 ms ±   6.4 ms    [User: 9.4 ms, System: 13.6 ms]
    Range (min … max):    13.8 ms …  35.8 ms    161 runs

  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index 2ab38c17aac10bf55ab3efde4c4db3893d8691d2
    Time (mean ± σ):      11.2 ms ±   1.8 ms    [User: 7.5 ms, System: 3.7 ms]
    Range (min … max):     4.7 ms …  12.6 ms    238 runs

Swapping just loading an individual commit to look at all branches, I
get the following 2.01x improvement:

  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index --branches
    Time (mean ± σ):      22.5 ms ±   5.8 ms    [User: 8.5 ms, System: 14.0 ms]
    Range (min … max):    14.1 ms …  34.9 ms    157 runs

  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index --branches
    Time (mean ± σ):      11.2 ms ±   1.9 ms    [User: 7.1 ms, System: 4.1 ms]
    Range (min … max):     4.7 ms …  13.4 ms    239 runs

But there are some diminishing returns when I include --tags, too, since
I assume that there is some more traversal involved in older parts of
the kernel's history which aren't as well covered by bitmaps. But it's
still an improvement of 1.17x (give or take .31x, according to
hyperfine).

  Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index --branches --tags
    Time (mean ± σ):      66.8 ms ±  12.4 ms    [User: 43.6 ms, System: 23.1 ms]
    Range (min … max):    54.4 ms …  92.3 ms    39 runs

  Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index --branches --tags
    Time (mean ± σ):      57.3 ms ±  10.9 ms    [User: 37.5 ms, System: 19.8 ms]
    Range (min … max):    44.0 ms …  79.5 ms    45 runs


> I got an even more curious result when adding in "--not --all" (which
> the connectivity check under discussion would do). There the improvement
> from your patch should be even less, because we'd end up reading most of
> the bitmaps anyway. But I got:

Interesting. Discussion about that series aside, I go from 28.6ms
without reading the table to 35.1ms reading it, which is much better in
absolute timings, but much worse relatively speaking.

I can't quite seem to make sense of the perf report on that command.
Most of the time is spent faulting pages in, but most of the time
measured in the "git" object is in ubc_check. I don't really know how to
interpret that, but I'd be curious if you had any thoughts.

I was just looking at:

  $ GIT_READ_COMMIT_TABLE=1 perf record -F997 -g \
      git.compile rev-list --count --objects \
      --use-bitmap-index 2ab38c17aac --not --all
  $ perf report

Thanks,
Taylor
