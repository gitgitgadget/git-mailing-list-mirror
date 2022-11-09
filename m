Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC85C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKIWTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIWTT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:19:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C5F03D
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:19:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so3195503pji.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHZr0qy3tLTyKgazQieQbXNoFUwo3oOzh8ZBwtH05WE=;
        b=RdUL8CHXRqk3ufbZYjouI72ch41alJPjFECSSJ24+fFz93qrxBsw2ZI1fFVP0IBSvy
         xBTnSnlLpWWVOkrx/AA7josrZrKMKo83GRs0193xWofbfuQMaNW+DsMN38K5wqDYcd5O
         hCg9uNI9iveGEBLZD5daD6EX6WbMUX1V8mQ8sKRvjtxCkK8t6KCqSQRBXqDNXBel2hDA
         C4s+dLElzb4G6d/uqIqadPgTkMYCSRAGAMNjMbgraLwedW2LhvDdn/ZGm+MlI2WBouCM
         lImLYqsEiSWveRsjph/Rvxl9yw7pXHyTzm/HIZTfQ+qDVr9HP6iY0wKcEhFBZkwAqBHx
         wCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHZr0qy3tLTyKgazQieQbXNoFUwo3oOzh8ZBwtH05WE=;
        b=e/msUgm7v35VVf+q0LGGQE2714esVSYC+lBodMNh475/oehq1N5bpM7V7D0ceP2+Y/
         vNsdrI33pJyAW8rR8bv00XZQ/HRc5CfhDpYe1wPELwxIBPaWDE2WbXFiz0Vfpbbb6oWe
         E2d9E0CHpgVFHQlb5wQ4idDQP8ewYCmfttgg0e/KhKILqQIqS53hRd2fBw6huNaV1D7I
         ARkI7bb0ScIVfX7rA9+r7mHHECU4uuagq5VTSWaJWG5lb+WpEpiK6l1OaUffn60udaMS
         WO/o1VSA4YaICkxvRqU7A0cRpzEZInxvumsAq75ronoKuqGLKutdy/o8L7nzZtR8+NCB
         8BZg==
X-Gm-Message-State: ACrzQf0f9wQns8aTMkYdyHkELj+pRASS3wdnuyuUZC1LYHwXt0pw0tCb
        8FrMFIB+jXmOnjQIwJLYPhlm
X-Google-Smtp-Source: AMsMyM7hsZmTVt1ZwTwE1Q3DkcUD4wqu7c3gpREZ6SX1OX9tmDMhzW30V8WkiR2XQEHzV90+VyOaZw==
X-Received: by 2002:a17:90a:5987:b0:215:d4e8:6f7f with SMTP id l7-20020a17090a598700b00215d4e86f7fmr39077268pji.246.1668032358412;
        Wed, 09 Nov 2022 14:19:18 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b0017f5c7d3931sm9568312plf.282.2022.11.09.14.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 14:18:45 -0800 (PST)
Message-ID: <99c1e5e0-d5cd-cf0e-25ba-31bc96a089c6@github.com>
Date:   Wed, 9 Nov 2022 14:18:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()'
 is called immediate after
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        jonathantanmy@google.com
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <6c1e50e3-cddb-4cc3-f83c-6ec2e2a06a9f@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <6c1e50e3-cddb-4cc3-f83c-6ec2e2a06a9f@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 11/8/2022 5:44 PM, Victoria Dye via GitGitGadget wrote:
>> Following up on a discussion [1] around cache tree refreshes in 'git reset',
>> this series updates callers of 'unpack_trees()' to skip its internal
>> invocation of 'cache_tree_update()' when 'prime_cache_tree()' is called
>> immediately after 'unpack_trees()'. 'cache_tree_update()' can be an
>> expensive operation, and it is redundant when 'prime_cache_tree()' clears
>> and rebuilds the cache tree from scratch immediately after.
>>
>> The first patch adds a test directly comparing the execution time of
>> 'prime_cache_tree()' with that of 'cache_tree_update()'. The results show
>> that on a fully-valid cache tree, they perform the same, but on a
>> fully-invalid cache tree, 'prime_cache_tree()' is multiple times faster
>> (although both are so fast that the total execution time of 100 invocations
>> is needed to compare the results in the default perf repo).
> 
> One thing I found interesting is how you needed 200 iterations to show
> a meaningful change in this test script, but in the case of 'git reset'
> we can see sizeable improvements even with a single iteration.

All of the new performance tests run with multiple iterations: 20 for reset
(10 iterations of two resets each), 100 for read-tree, 200 for the
comparison of 'cache_tree_update()' & 'prime_cache_tree()'. Those counts
were picked mostly by trial-and-error, to strike a balance of "the test
doesn't take too long to run" and "the change in execution time is clearly
visible in the results."

> 
> Is there something about this test that is artificially speeding up
> these iterations? Perhaps the index has up-to-date filesystem information
> that allows these methods to avoid filesystem interactions that are
> necessary in the 'git reset' case?

I would expect the "cache_tree_update, invalid" test's execution time, when
scaled to the iterations of 'read-tree' and 'reset', to match the change in
timing of those commands, but the command tests are reporting *much* larger
improvements (e.g., I'd expect a 0.27s improvement in 'git read-tree', but
the results are *consistently* >=0.9s).

Per trace2 logs, a single invocation of 'read-tree' matching the one added
in 'p0006' spent 0.010108s in 'cache_tree_update()'. Over 100 iterations,
the total time would be ~1.01s, which lines up with the 'p0006' test
results. However, the trace2 results for "test-tool cache-tree --count 3
--fresh --update" show the first iteration taking 0.013060s (looks good),
then the next taking 0.003755s, then 0.004026s (_much_ faster than
expected).

To be honest, I can't figure out what's going on there. It might be some
kind of runtime/memory optimization with repeatedly rebuilding the same
cache tree (doesn't seem to be compiler optimization, since the speedup
still happens with '-O0'). The only sure-fire way to avoid it seems to be
moving the iteration outside of 'test-cache-tree.c' and into 'p0090'.
Unfortunately, the command initialization overhead *really* slows things
down, but I can add a "control" test (with no cache tree refresh) to
quantify how long that initialization takes.

While looking into this, I found a few other things I'd like to add to/fix
in that test (add a "partially-invalidated" cache tree case, use the
original cache tree OID in 'prime_cache_tree()' rather than the OID at
HEAD), so I'll re-roll with those + the updated iteration logic.

Thanks for bringing this up!

>  
>> The second patch introduces the 'skip_cache_tree_update' option for
>> 'unpack_trees()', but does not use it yet.
>>
>> The remaining three patches update callers that make the aforementioned
>> redundant cache tree updates. The performance impact on these callers ranges
>> from "negligible" (in 'rebase') to "substantial" (in 'read-tree') - more
>> details can be found in the commit messages of the patch associated with the
>> affected code path.
> 
> I found these patches well motivated and the code change to be so
> unobtrusive that the benefits are well worth the new options.

Thanks!

> 
> Thanks,
> -Stolee

