Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8DC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 20:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjDYU11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDYU1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 16:27:25 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6285B83
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 13:27:24 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54f6f0dae19so46499867b3.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682454444; x=1685046444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaUJGCg2JMzI03e3eR87HugPG5ASffqPAq+8B5zzIkM=;
        b=L+c1H5mBUDfQHwuAv7o17RVf95kkDz7RfhnnFQ5hVpPXS7TeO2RASP/vKAGuhMgleI
         mCetnebEKL3gvlGY6nrJRnw/QU0w3iGnAw76ignTfMpunzDH9/+TTprkv8djk+POop+Q
         OHZUy+nsmrPpoOmkzFBYoVdWdY2OXs2qfU6wAu+fFyNEQ59/RzhchBBljY+s6x4QQO9Z
         CuF7zakYHdzp+lWCd2qQJGkkUbZxu870uJRsIlYq0sTXHmQ8CuUjWy0Y7v6h7ClmU/XF
         Y5eIxR2fnuPr8jxTYC5MwmdFXY3iVNKzg5mK53LR8oLqpSs0G9oYWvRW67yZBzirnbos
         GJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454444; x=1685046444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaUJGCg2JMzI03e3eR87HugPG5ASffqPAq+8B5zzIkM=;
        b=PnOPknjN4vimkl+GPbpkj6qinB4sQBXQ4HQlExhbrsKsIDoLtOx0EXc3+oHYZXStb5
         fUvsIzOEQsx9cxVWayCle5kdZWt6Qrp/Cb32AYE0qZVAT4ZF0BVkirNxPy4O3EUULUk0
         ndopV7I59M5dmB7sDs0WRgF51cl9F+cRK+5Hl6N2lwRqdKzQseIMKGHsn3D1IufOk5xI
         c7wNDMFmXq/dRV9hb8KdEtY5kpCYC6esrQ4g2toeTku3npsFoJNZzDV4EzSu1OLpoD9f
         3ZKSH7nkWtLNsm69/eC6iLGNzkohaB4C8/iVu6GSudohmEdcLyFIlOcbgW3ciQoh3maq
         i7lw==
X-Gm-Message-State: AC+VfDyuw/+1u6fNY54kw5kIasDZOeDo3PqptMOGIVh2xT38+tFpztqq
        CnEXKaSpDO4WbSwsDHAiW0UQ
X-Google-Smtp-Source: ACHHUZ4anTdjvj78o4Y68zc270/kRIHw843ispyZHBT/kza+Pi0R7NB/RpLCZl32PsoK4Q0nm1K+zw==
X-Received: by 2002:a81:698a:0:b0:556:d398:870f with SMTP id e132-20020a81698a000000b00556d398870fmr676063ywc.47.1682454443851;
        Tue, 25 Apr 2023 13:27:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id x67-20020a0dd546000000b0054c0be459dbsm3800023ywd.39.2023.04.25.13.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 13:27:23 -0700 (PDT)
Message-ID: <aa162f0f-022d-7216-51c9-c53884362628@github.com>
Date:   Tue, 25 Apr 2023 16:27:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <f25c6234-83c0-fa49-85f5-9005e312b8a3@github.com>
 <ZEgjiAtK8O0+dbht@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZEgjiAtK8O0+dbht@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2023 3:01 PM, Taylor Blau wrote:
> On Tue, Apr 25, 2023 at 02:06:25PM -0400, Derrick Stolee wrote:
>> For my curiosity, and since you already have a test environment set up,
>> could you redo the "without bitmaps" case with pack.useSparse true and
>> false? When the option was created and defaulted to true, we never
>> really explored comparing it to the bitmap case. In fact, I assumed the
>> bitmap case was faster in important cases like this (where there is a
>> substantial difference in object counts), but your data is surprising me
>> that the sparse algorithm is outperforming bitmaps, even with this new
>> algorithm.
>>
>> The main question I'd like to ask is: is pack.useSparse contributing
>> in an important way to the performance here?
> 
> I don't know enough about pack.useSparse to say with certainty, but
> trying again on the same repository (which is reasonably well-packed at
> the moment), they appear about the same:

Thanks for running that. I apologize, but I didn't sync in my head
that you're purposefully using 'git rev-list' to do the walk and the
config only makes a difference for 'git pack-objects'. The suspiciously
close timings is indeed too suspicious. Thus, the performance numbers
you are considering are not identical to what would happen in 'git
pack-objects' by default.

So, I created my own example using git.git, which included this input:

	refs/remotes/origin/master
	refs/remotes/origin/maint
	refs/remotes/origin/next
	refs/remotes/origin/seen
	^refs/remotes/origin/master~1000

And there is a clear preference for pack.useSparse=false in this
case:

Benchmark 1: GIT_TRACE2_PERF="/home/stolee/_git/git/git-review/trace-true.txt" ~/_git/git/git-review/git -c pack.useSparse=true -c pack.useBitmaps=false pack-objects --stdout --revs <in >/dev/null
  Time (mean ± σ):      2.857 s ±  0.031 s    [User: 6.850 s, System: 0.378 s]
  Range (min … max):    2.814 s …  2.922 s    10 runs
 
Benchmark 2: GIT_TRACE2_PERF="/home/stolee/_git/git/git-review/trace-false.txt" ~/_git/git/git-review/git -c pack.useSparse=false -c pack.useBitmaps=false pack-objects --stdout --revs <in >/dev/null
  Time (mean ± σ):      2.682 s ±  0.029 s    [User: 6.678 s, System: 0.388 s]
  Range (min … max):    2.653 s …  2.753 s    10 runs
 
and I used the perf traces to extract that the enumerate objects
phase took ~550ms for the sparse walk and ~375ms for the non-sparse
version.

But using this same input, I'm able to construct an example where
your modified bitmap walk is faster than the non-sparse object walk:

Benchmark 1: GIT_TRACE2_PERF="/home/stolee/_git/git/git-review/trace-true.txt" ~/_git/git/git-review/git -c pack.useSparse=false -c pack.useBitmaps=true pack-objects --stdout --revs <in >/dev/null
  Time (mean ± σ):      2.045 s ±  0.039 s    [User: 6.464 s, System: 0.334 s]
  Range (min … max):    1.966 s …  2.089 s    10 runs
 
Benchmark 2: GIT_TRACE2_PERF="/home/stolee/_git/git/git-review/trace-false.txt" ~/_git/git/git-review/git -c pack.useSparse=false -c pack.useBitmaps=false pack-objects --stdout --revs <in >/dev/null
  Time (mean ± σ):      2.138 s ±  0.034 s    [User: 6.070 s, System: 0.333 s]
  Range (min … max):    2.058 s …  2.182 s    10 runs

(Here, the enumerate objects phase takes ~230ms on average.)

I can easily swap this by changing my negative ref to

  ^revs/remotes/origin/master

Benchmark 1: GIT_TRACE2_PERF="/home/stolee/_git/git/git-review/trace-true.txt" ~/_git/git/git-review/git -c pack.useSparse=false -c pack.useBitmaps=true pack-objects --stdout --revs <in >/dev/null
  Time (mean ± σ):     521.0 ms ±  28.8 ms    [User: 1190.9 ms, System: 103.6 ms]
  Range (min … max):   496.5 ms … 589.8 ms    10 runs
 
Benchmark 2: GIT_TRACE2_PERF="/home/stolee/_git/git/git-review/trace-false.txt" ~/_git/git/git-review/git -c pack.useSparse=false -c pack.useBitmaps=false pack-objects --stdout --revs <in >/dev/null
  Time (mean ± σ):     498.5 ms ±  13.2 ms    [User: 1089.1 ms, System: 123.3 ms]
  Range (min … max):   471.3 ms … 513.6 ms    10 runs

which gives us reason to think about "small fetches" don't need
bitmaps, but "big fetches" do. But that can be done separately
from this patch.

Context about the sparse walk:

The sparse walk uses the names of the paths with respect to the root 
trees as a way to walk only the "new" objects without walking the
entire object set at the boundary. This makes a big difference in
repos with many files at HEAD, but the risk is that those path names
become significant overhead if there are enough new changes spread
across a large fraction of the tree. For clients pushing the work
of a single developer, the sparse algorithm outperforms the default
walk.

I wrote about this years ago in [1] and almost brought it up earlier
as a description of the commit boundary (called the frontier in [1]),
but the sparse object walk is helpful to visualize.

[1] https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-push-performance/

Thanks,
-Stolee
