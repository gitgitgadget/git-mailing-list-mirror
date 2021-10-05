Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B8DC433FE
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2140D61503
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhJERq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJERq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:46:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F7C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:45:06 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id a14so164908qvb.6
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Ps/PeBkjJhPHSxoIFBbWiPoYQ8GmS6ZQz11Ieh1WiM=;
        b=W2pHTZuTToEnvNUHFDli6l94Z1wuNwyZjXcQWk7jxHpglE5KL7b0tL4zxWRvIxkslO
         /9xRiokorgH1BdSj8c1vojKGCI0ZTQUykZqaTbcQcm8h9xNt0duoUnMWSHI5ZcL3NwAU
         Xl3VjQAw9uHqF4O5hWBpSjETfeGIDGAyByBC9uU+RRFHf93xU+ya8akI3GBeCO7SENBx
         qbMunskaVck2hgjipCt/GAsKMrfnAR5nez+Lyq8FCNgHTmDHUctE5oda5clIzuetWit7
         BELWZoM/CE3JK5XWdk8Tz2A2hqjjLt3v6q4PK6FNl7gHcP6JqGD+8i6PJXLj/BAJdaoY
         R2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Ps/PeBkjJhPHSxoIFBbWiPoYQ8GmS6ZQz11Ieh1WiM=;
        b=OUevsyq1RyxJa12Ia22+tmks5duyxTC1F/FotRuDBs9jKh8qcaYYsj5uYeYBTo2iUN
         ivFfpmRrQ37cUG6/k5USwu8xfneE1riMfu2hooWur/OMTo7J3SYeYxov3jsvMMabJF7q
         TDa8199ftBonM4si6py7heaxwW8dQJgAiWL+qD/Q+q6Ro1chqL1jtAZILqKL1uVDKBcJ
         SeZgTUJDGo/BWwSQr+ji6l/AjBFg8r44Z9E1OOZpVwNRTKZEwuJFx6g58b93qz6JPA8C
         j8Ts3RmRMgUyH5uXDhpMF3EnaMpJjhKfAn9jzxzftBWbYddgxAUtk6iTjcxzsL5IT4Fi
         SnXA==
X-Gm-Message-State: AOAM532Is24Lfj2S112oFove6K35AFOZs3SQK7Y7j9ubRprMtUivIZ4h
        LV/OyFLrb8fiYrUlK/50D0RZubaLNWXBpA==
X-Google-Smtp-Source: ABdhPJzjWwshNyZWS1jaMDRfo/Z4k0kXXcl7cxAqDySoNFAu4K7IC8WDBdcGEbdK/MMbDZbqYdFJQw==
X-Received: by 2002:ad4:4652:: with SMTP id y18mr29654147qvv.2.1633455905127;
        Tue, 05 Oct 2021 10:45:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y27sm6953909qkj.64.2021.10.05.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:45:04 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:45:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
Message-ID: <YVyPH59LpxFLHep0@nand.local>
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 10:29:03PM +0000, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach test_perf_() to remove the temporary test_times.* files

Small nit: s/test_times/test_time here and throughout.

> at the end of each test.
>
> test_perf_() runs a particular GIT_PERF_REPEAT_COUNT times and creates
> ./test_times.[123...].  It then uses a perl script to find the minimum
> over "./test_times.*" (note the wildcard) and writes that time to
> "test-results/<testname>.<testnumber>.result".
>
> If the repeat count is changed during the pXXXX test script, stale
> test_times.* files (from previous steps) may be included in the min()
> computation.  For example:
>
> ...
> GIT_PERF_REPEAT_COUNT=3 \
> test_perf "status" "
> 	git status
> "
>
> GIT_PERF_REPEAT_COUNT=1 \
> test_perf "checkout other" "
> 	git checkout other
> "
> ...
>
> The time reported in the summary for "XXXX.2 checkout other" would
> be "min( checkout[1], status[2], status[3] )".
>
> We prevent that error by removing the test_times.* files at the end of
> each test.

Well explained, and makes sense to me. I didn't know we set
GIT_PERF_REPEAT_COUNT inline with the performance tests themselves, but
grepping shows that we do it in the fsmonitor tests.

Dropping any test_times files makes sense as the right thing to do. I
have no opinion on whether it should happen before running a perf test,
or after generating the results. So what you did here looks good to me.

An alternative approach might be to only read the test_time.n files we
know should exist based on GIT_PERF_REPEAT_COUNT, perhaps like:

    test_seq "$GIT_PERF_REPEAT_COUNT" | perl -lne 'print "test_time.$_"' |
    xargs "$TEST_DIRECTORY/perf/min_time.perl" >"$base".result

but I'm not convinced that the above is at all better than what you
wrote, since leaving the extra files around is the footgun we're trying
to avoid in the first place.

Thanks,
Taylor
