Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48461C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229DF61073
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhHYONq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbhHYONn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:13:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A3EC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:12:57 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bk29so21479648qkb.8
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bvq9bqG5/MzIJ2QN1KH3JWNM2+VwRARtKcotL1n9M7A=;
        b=cE7zFQuoZHFZ9eM+kChKo4uN0pSkhfG7VVc0hGqgTb+BC5ZwE+c41JhcniqQjxTwMF
         rtqnfzQRaMZLivTi3npDqaiCfSk9QdiCjV7DHwj8GS9xyZTSWJ+I7qi3zLmp25oZAm05
         i+BYbKW48j64EHK03sbXAcRD7OTo13OMEhJ9mHVi2G3AYOZCtB1viQ/mpDQeERvUamP6
         lCNZKUn1FTL2hy61kzurpEOT40G7sjyE42Ky/oPa0fZNXa6bBOu7GWbyI53tjfsZ2Sp6
         NaVRxcpxk0hsM8jt8aQyD5hW9YRi+RGC/lecnXd/GTwIocR0a2L16hcq+rBR5xr2vf6N
         vkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bvq9bqG5/MzIJ2QN1KH3JWNM2+VwRARtKcotL1n9M7A=;
        b=bOB4bIkp39iJOzDClv1FQ6iPtjeGM+KtR2ExtbI53SI/TLo1qCsrzqGR78f1xSa4Eu
         OyEFUPwvz+mDU4YtMy5WFTTB7h5Tgz479v8w1f05qPXKrjRWetrQfBPq6o4I9hqryXz5
         yaZ2qrp6eXupYxRgn/E6zNPYWg/q0bWoI/XQL0peO86ykJUZsxZXSVbiKBQ1ozqG55Il
         tGfXC1z8XPgAoopxuavQgKqr98MOLxXK3jlWBdk819CXSRx0S6d1nfo1TCCRc7bkSLwU
         izScoEPrz8c+09icJSPQDU+Mlbo7lxjH5hm7TccD0iIr6m+BLeZPhGqfjujojkpVxequ
         xihA==
X-Gm-Message-State: AOAM531vLQ11CBm1KnTSy9T1Qs6hD/kMsCUKltB37K++vWBqHfnMOhca
        0ESEDn5A2pA8jTkK3zFD1IU=
X-Google-Smtp-Source: ABdhPJxlcUxk10nJb8HbBYZGjsu+jGZW9RbQWez3HpEoYj1HegL4iJoeRygCSPO2y5gJVfnK5PvjFA==
X-Received: by 2002:a05:620a:799:: with SMTP id 25mr31493844qka.119.1629900776810;
        Wed, 25 Aug 2021 07:12:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6d81:bb65:3870:d879? ([2600:1700:e72:80a0:6d81:bb65:3870:d879])
        by smtp.gmail.com with ESMTPSA id g8sm72238qkm.25.2021.08.25.07.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:12:56 -0700 (PDT)
Subject: Re: [PATCH 1/6] fetch: speed up lookup of want refs via commit-graph
To:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1629452412.git.ps@pks.im>
 <6872979c4557204821d788dc3f5e1c8bef0a773c.1629452412.git.ps@pks.im>
 <fce98460-eed6-c874-8c42-bf3a6f5f93a8@gmail.com> <xmqq7dggvxup.fsf@gitster.g>
 <YSNEQ9R0TDUNPZPM@ncase>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b2b2316e-3d2c-4561-3da8-2d3a5ca243e0@gmail.com>
Date:   Wed, 25 Aug 2021 10:12:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSNEQ9R0TDUNPZPM@ncase>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 2:46 AM, Patrick Steinhardt wrote:
> On Fri, Aug 20, 2021 at 10:18:22AM -0700, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> I do worry about the case where annotated tags greatly outnumber
>>> branches, so this binary search is extra overhead and the performance
>>> may degrade. Would it be worth checking the ref to see if it lies
>>> within "refs/heads/" (or even _not_ in "refs/tags/") before doing
>>> this commit-graph check?
>>
>> Ah, clever.
> 
> Good idea. Benchmarks for my test repository (which definitely isn't
> representative, but it's at least some numbers) show that restricting to
> "refs/heads/" diminishes almost all the gains, while restricting to
> everything but "refs/tags/" performs almost the same (it's a tiny bit
> slower, probably because of the added string comparisons):
> 
>     Benchmark #1: all refs: git-fetch
>       Time (mean ± σ):     32.959 s ±  0.282 s    [User: 29.801 s, System: 5.137 s]
>       Range (min … max):   32.760 s … 33.158 s    2 runs
> 
>     Benchmark #2: refs/heads: git-fetch
>       Time (mean ± σ):     56.955 s ±  0.002 s    [User: 53.447 s, System: 5.362 s]
>       Range (min … max):   56.953 s … 56.957 s    2 runs
> 
>     Benchmark #3: !refs/tags: git-fetch
>       Time (mean ± σ):     33.447 s ±  0.003 s    [User: 30.160 s, System: 5.027 s]
>       Range (min … max):   33.444 s … 33.449 s    2 runs
> 
>     Summary
>       'all refs: git-fetch' ran
>         1.01 ± 0.01 times faster than '!refs/tags: git-fetch'
>         1.73 ± 0.01 times faster than 'refs/heads: git-fetch'

Thanks for testing both options.

> This is easily explained by the fact that the test repo has most of its
> refs neither in "refs/tags/" nor in "refs/heads/", but rather in special
> namespaces like "refs/merge-requests/", "refs/environments/" or
> "refs/keep-around/".

That makes sense to me. GitHub also stores refs like refs/pull/ so I can
understand not wanting to restrict to refs/heads/.

> I like the idea of excluding "refs/tags/" though: as you point out,
> chances are high that these don't point to commits but to annotated tags
> instead. So I'll go with that, thanks!

Yeah, that makes sense as a good way forward.

Thanks,
-Stolee

