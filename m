Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17741613C8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhKQPb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKQPbX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 10:31:23 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54696C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:28:25 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a24so2282370qvb.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IsZ+P3YWQZPSxTaVLbtGQiCpkx2EdnYl375/lROl9rg=;
        b=hAz1SllgUDpFchVOWVQcyXHFwAMZVPZpR/hbMQ//ZoZBSQ7W/w4YrE1lPEf6AZ+88U
         X3Ix6RfgVriVU/HqW05tDurPom86rlq1ku/O5oIgSuFmVAtitpxUMCvlEUr64C3YMGFH
         tFJWbikpuistdyCnbNmsedoxgp7RU+dpinnZBAWOrJpKN/UJ+KBiKcPA/yvEE+e/89QS
         YVbcRlHAUXMhtPylt+DMyqkp4vrfJIGMWD7M6WpvV+zA3LTXuhCbcEjOCJDbCHLk08nJ
         dzkLSXZUoWl7FQAOl0kpz1/FsTXWJ7XH7Zq+3fZNhc5NjMb7dFL0tiguhCrzYqdb3NUp
         /Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IsZ+P3YWQZPSxTaVLbtGQiCpkx2EdnYl375/lROl9rg=;
        b=WWG1BjWT2SaVkbycCJFxVqMBoWxyhaaT1ZOeN45eaR/hPuWc2KRKQ74U6Rwi1eCtzx
         EQhhk/t8SMVhBQB3M5C+8+iZBJ2bNszdvqIqiZUhAt/ZlciswXc5L6K3w9ML6EhPHrn0
         N+MANatQSCp7sF42UEJGwJY0Fczf5w8av5M4b44Yr9BYwOfUUO3qGDVfIpw0ZFrYAd9S
         6x4D07ow0yfSefAScIvOfn0DPN/wZ0blTgzxU4U2eenCmBT7z6QLQyi1Qp0WheqmUHOZ
         KxZ66GkdZA9FHU429Cq20SI2IIdA+cSGKeCJ8zgGbPo2/YaDVsgaAb/vzjj8576eodLg
         Oh0g==
X-Gm-Message-State: AOAM5314AGlgNjkva3369NgpH3nAgPdLiB0kmRUkQwphUDRvHAf0Sgep
        ELlSuw9ndznZG7I01rHHYNw=
X-Google-Smtp-Source: ABdhPJz4Nck26N/XpcOqdev8IKEVFMzMvktHCHNEhHhviEc5Ag3+CeFnqSc/P7OFl4+0SB3JewouFw==
X-Received: by 2002:a05:6214:2523:: with SMTP id gg3mr56315901qvb.56.1637162904405;
        Wed, 17 Nov 2021 07:28:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d1ee:6c8f:319:f5? ([2600:1700:e72:80a0:d1ee:6c8f:319:f5])
        by smtp.gmail.com with ESMTPSA id w10sm38977qkp.121.2021.11.17.07.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:28:23 -0800 (PST)
Message-ID: <08679a6f-51c1-0e48-9dcc-e7ac4c9a9c80@gmail.com>
Date:   Wed, 17 Nov 2021 10:28:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/2] Sparse index: fetch, pull, ls-files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <xmqqlf1n2krf.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqlf1n2krf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2021 4:29 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This is based on ld/sparse-index-blame (merged with 'master' due to an
>> unrelated build issue).
>>
>> Here are two relatively-simple patches that further the sparse index
>> integrations.
>>
>> Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
>> have been an integration much earlier in the cycle. They read the index to
>> look for the .gitmodules file in case there are submodules that need to be
>> fetched. Since looking for a file by name is already protected, we only need
>> to disable 'command_requires_full_index' and we are done.
> 
> This reminds me of one thing.  Our strategy so far has been:
> 
>  - start with blindly calling ensure_full();
> 
>  - audit the code and adjust each code path that needs to walk to
> 
>    . keep walking the full index, but narrow the scope of
>      ensure_full_index() if we can; or
> 
>    . stop assuming we need to walk the full index, but teach it to
>      "skip" the tree-in-index that we are not interested in.
> 
>  - declare victory and drop the blind call to ensure_full().

This is a fair summary of the approach.

> But what makes sure, after all of the above happens, that no new
> changes that assume it can walk the full index enters in the
> codebase?
> 
> In other words, after "fetch" is declared "sparse clean" with patch
> [1/2], what effort from us will it take to stay clean?

The tests in t1092 that use the "ensure_not_expanded" helper are
intended to be regression tests that would start failing if the
sparse index starts expanding in a new way. I think this is what
you mean by staying "sparse clean".

The rest of the tests are attempting to verify that the behavior
is correct when the sparse index is enabled, and that is hopefully
a more obvious situation when something goes wrong. We've tried to
create a robust set of tests here, but I'm sure we will add new
ones as more users start using it. (We will soon have a large set
of real users of the sparse index, and that should be informative.)

Do you see a test gap that would be prudent to address?

One direction I could see is that as new features are contributed
that change how the index is used, these features are not
automatically tested with sparse-checkout and the sparse index.
In this case, we will need to increase our awareness when reviewing
such features to ensure that they could fit within the sparse index
model (or are sufficiently protected by ensure_full_index() in their
first version).

I spent some time thinking about how we could add a
GIT_TEST_SPARSE_INDEX mode to the test suite that would automatically
test the sparse index in the existing tests. However, the feature is
only enabled when in cone-mode sparse-checkout, so we would need to
modify the test repos in a way that some sparse directory entries
exist but also don't collide with the test expectations. I never
found a way to get around that issue, which is why t1092 is such a
big test script.

Thanks,
-Stolee
