Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98628C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiGOCxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiGOCxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:53:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA824BC3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:53:14 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h22so2930388qta.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D9MzurSM32uVfR8FFBWJEtRZAqDeAZYfqJay063xjv8=;
        b=f7/BfahdySbPue9PpdX0+LpkkO5KxPfEmgkZcR8sG+w/s5EM8gQLzV95djNtI6aOab
         9ArpQo+BPTKkWEHD2DIZO9818lNMFni/XcabqdKMNyd3hfEsND8suN+XZoOEGZufcN+i
         eB9W3/u8+4YyZbzrtfSDHfxzYGtzhwJy6SNCdY8ATSbVoEpa1vNrY4anXzk01S0ErN9T
         tkyrIDGBcvtGzwNmGFjSgKkGptu8FIFicblQLHklAkVctv8oe2xmhefA2y+rMtm2RzMb
         xVUPWJ7ZXhz2oiLVubeECTl+pidmmISxYJG+/rhFjvxZA6X6Nuxh4XJ1xQknh17WhVou
         PlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9MzurSM32uVfR8FFBWJEtRZAqDeAZYfqJay063xjv8=;
        b=Qtcjz4BSwTiOZxi/Bl/meQdhCBym6vExfMaaAZ9Z8UnMQ4SLqp6N5wD+o5xKselkhk
         aOyDDoG4mLrzvN2Po/ELq8DzIvJiUrC7hSjytefV/GQ2/w3gtgjryoH5NdFWmMr+Eqbc
         xlI6RObDStHem3p+SMlmgZk1e9xiuMkcCpf525vGDIst4KWVMATdnX5/aDKPbhLO6WQw
         +uUhw5i73MXuKn+wYn/Nnbned4l5bkH6DYJf/JB82uH3NlHlVP+lq69jO8K32v91ey9W
         vY9J97g4/W+OYp/9kEDuZzBkMf+PjvF2f1W6vThTqDyZyxDRgAfZjvFbaoF1YxG334Ao
         1Jdg==
X-Gm-Message-State: AJIora8kn/9pCGwYoNx0gHWUOvpkysUgq1Hwytd2mVxUSkbiQ4eM+Y7I
        kLkQQJKW/X09zqhMdEt4/fR3W9BjOaEQcA==
X-Google-Smtp-Source: AGRyM1sQJMUKBEZNpIvlVxQ41Vz4PEgBXIj1xy7Sxc9cWtmO+y/BH3ikATejTBdturpHlOvRzmfqWg==
X-Received: by 2002:ac8:5c90:0:b0:31d:bbc9:4143 with SMTP id r16-20020ac85c90000000b0031dbbc94143mr10628059qta.450.1657853593639;
        Thu, 14 Jul 2022 19:53:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b11-20020ac844cb000000b0031ecddf2278sm2629273qto.37.2022.07.14.19.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:53:13 -0700 (PDT)
Date:   Thu, 14 Jul 2022 22:53:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 5/6] bitmap-lookup-table: add performance tests for
 lookup table
Message-ID: <YtDWmAg3R/eRpl0V@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <a155c1e2ebacf54c451a069499325cdf280606fc.1656924376.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a155c1e2ebacf54c451a069499325cdf280606fc.1656924376.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 04, 2022 at 08:46:15AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Add performance tests to verify the performance of lookup table with
> `pack.writeReverseIndex` enabled. This is to check the performance
> when the above configuration is set.
>
> Lookup table makes Git run faster in most of the cases. Below is the
> result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
> gives similar result. The repository used in the test is linux kernel.
>
> Test                                                      this tree
> ---------------------------------------------------------------------------
> 5310.4: repack to disk (lookup=false)                   296.55(256.53+14.52)

Having "lookup=false" in this test definitely helps visually
differentiate which tests have a bitmap with and without the lookup
table.

I think we should take a slightly different approach for these
performance tests. I think the first change to the t/perf tests in this
series should only enable `pack.writeReverseIndex`. That patch would be
a good place to highlight the benefit of enabling the on-disk reverse
index by showing a before and after of running p5310 before and after
that commit.

Then the patch after that should look like this one, which runs the
suite with and without the lookup table. That should give us a sense of:

  - bitmaps without a lookup table or reverse index
  - bitmaps without a lookup table, but with a reverse index
  - bitamps with a reverse index and a lookup table

...which I think are the most interesting combinations (I wouldn't
expect many or any users to have lookup tables enabled without reverse
indexes).

I think that would allow us to drop the last patch in this version of
the series. But I'm definitely open to other testing strategies for the
performance tests (including this one!) if you have different thoughts
about what the best way to go about this is.

Thanks,
Taylor
