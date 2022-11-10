Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E245C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKJOol (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKJOoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 09:44:39 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE17E32062
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 06:44:38 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso2324558fac.13
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2804lybQHFIbL3HF1j+36+eFqSO5qVOggv73qpp/1c=;
        b=Xt8FAfHOe2OVEG9CvQsUMiPgvLiXAroSHCRiBV+uwnmzVbCXs2YpTSFPxU6lQmlApp
         VC4R2d6utLaTFXBqkzFpGe3zqMiEneegSGMTNM3J9P/TMPfnyVvNqh+MoqG9L26nf0lR
         rhYnMsoaie5m6Y2CzihXOAfPiLWdMICJk6tJiKQ/oBxdwBxJYbS1vn5cn0+Y2Vmk8UGs
         QsHfbwmrZSwDwmYSff+3VikfnRNyoMG4zMcAD3CycMSPW0I46IBXlwTEjvDuqB3XRNW4
         J8iwvgT4gCqOlggWIdzHDsaakyM/xC+ktQhpfy9SO+x+dY/vO0So1VF0SOcuWFxG2E79
         Vltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2804lybQHFIbL3HF1j+36+eFqSO5qVOggv73qpp/1c=;
        b=5gmMESS9u1Sy9nWV5Jret+CGqz0ymJQlSz3mseUZELNmlxK4dSYfYwvNdMGxOLNipb
         nr9BuR7QCRAorzgFjo0p0qPP1p7nTJCWpreLRpOcU22ZR0UN4OLbRV8JYFlR+HTfWaEe
         T0o5KgtLoc0xXl+DtEHNrufOWEUmkJEiZpB7LfYnZ6B2HOLLd3N5Xy6pPFEqVBHnRtYT
         C634naGOT3M2ZZnSPKqmy1+Y5SBDCvLuHfl+XZaKgdFczRSbu6jHueA8oeyYFXKXNn4Z
         uzCfFFeBaY9gZXIZoCJ36q+tVNZ/JB7QeADyi5RZmkoXMPNcd0N2ToqH+87qrO5Dl44O
         EGPw==
X-Gm-Message-State: ACrzQf3mHS1glxGeDjwpcDtQwWmPTRHJ9vsYPT/LemxwdMO+V4ae3ZZ4
        ewv7laFipik1VU2kJluyqz5O
X-Google-Smtp-Source: AMsMyM4tjhwYSOwatNppDBAkaCIrT49nsw8iM4HpeQb49YFC2du478kSmn38+oRHP1hoPYpdu2mnvA==
X-Received: by 2002:a05:6870:f6a4:b0:13d:1aee:a72f with SMTP id el36-20020a056870f6a400b0013d1aeea72fmr32035137oab.58.1668091478232;
        Thu, 10 Nov 2022 06:44:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8dc6:f062:5d1c:cdbf? ([2600:1700:e72:80a0:8dc6:f062:5d1c:cdbf])
        by smtp.gmail.com with ESMTPSA id e66-20020aca3745000000b0035a5ed5d935sm5742001oia.16.2022.11.10.06.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 06:44:37 -0800 (PST)
Message-ID: <acc2a6d9-16aa-2576-d9cb-ca75fd94a2fa@github.com>
Date:   Thu, 10 Nov 2022 09:44:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()'
 is called immediate after
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        jonathantanmy@google.com
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <6c1e50e3-cddb-4cc3-f83c-6ec2e2a06a9f@github.com>
 <99c1e5e0-d5cd-cf0e-25ba-31bc96a089c6@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <99c1e5e0-d5cd-cf0e-25ba-31bc96a089c6@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/2022 5:18 PM, Victoria Dye wrote:
> Derrick Stolee wrote:
>> On 11/8/2022 5:44 PM, Victoria Dye via GitGitGadget wrote:
>>> Following up on a discussion [1] around cache tree refreshes in 'git reset',
>>> this series updates callers of 'unpack_trees()' to skip its internal
>>> invocation of 'cache_tree_update()' when 'prime_cache_tree()' is called
>>> immediately after 'unpack_trees()'. 'cache_tree_update()' can be an
>>> expensive operation, and it is redundant when 'prime_cache_tree()' clears
>>> and rebuilds the cache tree from scratch immediately after.
>>>
>>> The first patch adds a test directly comparing the execution time of
>>> 'prime_cache_tree()' with that of 'cache_tree_update()'. The results show
>>> that on a fully-valid cache tree, they perform the same, but on a
>>> fully-invalid cache tree, 'prime_cache_tree()' is multiple times faster
>>> (although both are so fast that the total execution time of 100 invocations
>>> is needed to compare the results in the default perf repo).
>>
>> One thing I found interesting is how you needed 200 iterations to show
>> a meaningful change in this test script, but in the case of 'git reset'
>> we can see sizeable improvements even with a single iteration.
> 
> All of the new performance tests run with multiple iterations: 20 for reset
> (10 iterations of two resets each), 100 for read-tree, 200 for the
> comparison of 'cache_tree_update()' & 'prime_cache_tree()'. Those counts
> were picked mostly by trial-and-error, to strike a balance of "the test
> doesn't take too long to run" and "the change in execution time is clearly
> visible in the results."

Thanks for pointing out my misunderstanding. I missed the repeat counts
because 2-3 seconds "seemed right" based on performance tests of large
monorepos, but clearly that's not right when using the Git repository for
performance tests.
>> Is there something about this test that is artificially speeding up
>> these iterations? Perhaps the index has up-to-date filesystem information
>> that allows these methods to avoid filesystem interactions that are
>> necessary in the 'git reset' case?
> 
> I would expect the "cache_tree_update, invalid" test's execution time, when
> scaled to the iterations of 'read-tree' and 'reset', to match the change in
> timing of those commands, but the command tests are reporting *much* larger
> improvements (e.g., I'd expect a 0.27s improvement in 'git read-tree', but
> the results are *consistently* >=0.9s).
> 
> Per trace2 logs, a single invocation of 'read-tree' matching the one added
> in 'p0006' spent 0.010108s in 'cache_tree_update()'. Over 100 iterations,
> the total time would be ~1.01s, which lines up with the 'p0006' test
> results. However, the trace2 results for "test-tool cache-tree --count 3
> --fresh --update" show the first iteration taking 0.013060s (looks good),
> then the next taking 0.003755s, then 0.004026s (_much_ faster than
> expected).
> 
> To be honest, I can't figure out what's going on there. It might be some
> kind of runtime/memory optimization with repeatedly rebuilding the same
> cache tree (doesn't seem to be compiler optimization, since the speedup
> still happens with '-O0'). The only sure-fire way to avoid it seems to be
> moving the iteration outside of 'test-cache-tree.c' and into 'p0090'.
> Unfortunately, the command initialization overhead *really* slows things
> down, but I can add a "control" test (with no cache tree refresh) to
> quantify how long that initialization takes.

Getting unit-level performance tests is always tricky. Sometimes the best
way to do it is to collect a sample using GIT_TRACE2_PERF and then manually
collect the region times. It could be a fun project to integrate region
measurements into the performance test suite instead of only end-to-end
timings.
 
> While looking into this, I found a few other things I'd like to add to/fix
> in that test (add a "partially-invalidated" cache tree case, use the
> original cache tree OID in 'prime_cache_tree()' rather than the OID at
> HEAD), so I'll re-roll with those + the updated iteration logic.

Taking a look now. Thanks!

-Stolee
