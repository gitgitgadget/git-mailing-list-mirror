Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AADC433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5D60F22
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhJJV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 17:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhJJV22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 17:28:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF87C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:26:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so59301850edc.13
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EkpmEVG90Sj49W/Rcsbs1gWx32WMkPmq+gATtDhMmz0=;
        b=m1efUJHFjUJmauHjgbqZYX1fJifal+9h0QjK2A3rU7C7t4dg1GW4GtCjH3L2yRJuo8
         fcWRCTqGC9Hntu4Whzo4s3HBzXL/7VmnlsgFSqr+UtoaF5i/RlChOH2pbwHwMTYl6cHi
         yuDvHetvrYBNvFBZSjHxJapdWrCiDg2qrotMqriPAP6vbTwU4840HNCBMRe8RT5v1w1W
         pE3EZD8bJf+bykEcv5+91DWazZgKtIiEPTMTv0Y2XY5cX6z9DPAMN7kX3DV10ctpPckW
         n32u+oplsysXNti6+g66nRF8eZkT9kAvsCLd+0MVfhxElmXiioEgt8SS34zVvDxQCeC/
         lxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EkpmEVG90Sj49W/Rcsbs1gWx32WMkPmq+gATtDhMmz0=;
        b=WVlo+kGHyySiHT2Kg/4WxmE3I+d4AQ4syWMY+K2+YUhPklpTT8QWIIQM3X0W9t8Z2e
         zOvigCyqaoo/vMyGZdkRvL4UaZjLi11M3kG2R+2yyt8UrAcamXNJrXUQD8Y8kM+FvxPh
         NfersIPXhkuuRfdne09yJveB/k0e/vy6kbbIm3B+RVkVW6juZ31xlFYiUQQyi3tu+Unk
         gFUgY5hWhIf2DTXmgIN5808yN4OCx7ikqx+49eAAQAa/rhjYp6PMYNQVcrWsZVp9OPLt
         a3h65HDHcqBGBN8cvETlN+bRCdJcKz9vfAa72Xpfiw0OHT5GTWKQAj7ZRGSzRx1iNauZ
         2Szw==
X-Gm-Message-State: AOAM532JQ9cRvdiGnpX8kL/rXQKWEGsud1EqJDgJan6TrvhVyiBpPdMb
        fbXQo12qtY8OwyANIgxhfLY=
X-Google-Smtp-Source: ABdhPJzL3e18Xm87v+YXBtnnVKF9f9/UZR2nCyVMVqtCY6+QIbZBG465p+l4uKdJaQfdDBKY4uGt0g==
X-Received: by 2002:a17:906:b819:: with SMTP id dv25mr21261080ejb.21.1633901188502;
        Sun, 10 Oct 2021 14:26:28 -0700 (PDT)
Received: from szeder.dev (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id b3sm2508149ejb.7.2021.10.10.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 14:26:28 -0700 (PDT)
Date:   Sun, 10 Oct 2021 23:26:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Message-ID: <20211010212626.GB571180@szeder.dev>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
 <YVyPH59LpxFLHep0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVyPH59LpxFLHep0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 01:45:03PM -0400, Taylor Blau wrote:
> On Mon, Oct 04, 2021 at 10:29:03PM +0000, Jeff Hostetler via GitGitGadget wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Teach test_perf_() to remove the temporary test_times.* files
> 
> Small nit: s/test_times/test_time here and throughout.
> 
> > at the end of each test.
> >
> > test_perf_() runs a particular GIT_PERF_REPEAT_COUNT times and creates
> > ./test_times.[123...].  It then uses a perl script to find the minimum
> > over "./test_times.*" (note the wildcard) and writes that time to
> > "test-results/<testname>.<testnumber>.result".
> >
> > If the repeat count is changed during the pXXXX test script, stale
> > test_times.* files (from previous steps) may be included in the min()
> > computation.  For example:
> >
> > ...
> > GIT_PERF_REPEAT_COUNT=3 \
> > test_perf "status" "
> > 	git status
> > "
> >
> > GIT_PERF_REPEAT_COUNT=1 \
> > test_perf "checkout other" "
> > 	git checkout other
> > "
> > ...
> >
> > The time reported in the summary for "XXXX.2 checkout other" would
> > be "min( checkout[1], status[2], status[3] )".
> >
> > We prevent that error by removing the test_times.* files at the end of
> > each test.
> 
> Well explained, and makes sense to me. I didn't know we set
> GIT_PERF_REPEAT_COUNT inline with the performance tests themselves, but
> grepping shows that we do it in the fsmonitor tests.
> 
> Dropping any test_times files makes sense as the right thing to do. I
> have no opinion on whether it should happen before running a perf test,
> or after generating the results. So what you did here looks good to me.

I think it's better to remove those files before running the perf
test, and leave them behind after the test finished.  This would give
developers an opportunity to use the timing results for whatever other
statistics they might be interested in.

And yes, I think it would be better if 'make test' left behind
't/test-results' with all the test trace output for later analysis as
well.  E.g. grepping through the test logs can uncover bugs like this:

  https://public-inbox.org/git/20211010172809.1472914-1-szeder.dev@gmail.com/

and I've fixed several similar test bugs that I've found when looking
through 'test-results/*.out'.  Alas, it's always a bit of a hassle to
comment out 'make clean-except-prove-cache' in 't/Makefile'.

