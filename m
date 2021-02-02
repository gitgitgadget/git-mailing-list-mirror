Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0EC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC64C64EAA
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBBCkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBCki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:40:38 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB1C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:39:58 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id t25so8341093otc.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aMlBQAPNhciCSuS0xfTrGso14/bvMKAxVLlEnTz17XY=;
        b=ExSe46H8xMK4kVATcAXJhRfj9s0YMWKQQAvX1mHk4H/BWCW74RBztWOkbsl/eGr8ZM
         vOR5DhvJzRJRrU/Ty7kOpEzS36h27DnD9OhzUlar2w+G8xIx8UakMPu0TWyON+yGP1g1
         oX8a5d6c5PazMxNWZXY+7gTwcfzRHlh8k/NW4PYUgOZI6zE/Rxf5aqpHIpzY8/HNaSCm
         7gL8NI71Z+PBpAJfRpTdgSjr0VId+C7GmIzEBHGpZrZCw64opCo4CPGleQ5FwwOTOcnl
         vnSBLxmsWWRUuK4mfqsB2sVhJDvNRW9HxkCc8kwT+2cXi9WCBIey+Ktdxf7nR4c0EhHr
         t9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aMlBQAPNhciCSuS0xfTrGso14/bvMKAxVLlEnTz17XY=;
        b=nSn+qRmYovyOZnWloFC+DiUHzdzHYxLI2AW9f69+iUs7p9ZWjmur3TZQqS9Q+9dOXf
         O1wJJDvYVCZKSz5J2T5qzpv/jvQGLFB+amWEwF622fVNIk9pPSOWcCFJh5k8MBbWSr4j
         XtElHKG7H2u3awGO749vE8ucQoX90YvH5qTqKItRU9UzZtUwWZ9z4uasIPdSVVHUpZok
         3rBsfGnAFYQLgFzrpEx6VDdFiqQb1LYIdxlULOHQ7rTGu6tnhYUzEkZLQi0gdQS5NOAD
         O0I9iwaREaGj2W9ZZ2WDBd6zDXZta5kmbs5dA1KtxmGNZAkXGOWVgfu/M+of1rqowYlN
         Q4iA==
X-Gm-Message-State: AOAM530iPQyrF3FpMJaRP/NRsl3TvXRmipQfChkLXJCV06BDKFsn1U4x
        mhFuQHbetv2ootAM6VUEzE0=
X-Google-Smtp-Source: ABdhPJwOCUjhTopge96U1xpAsEFLYfMXHyuvvn4Vm1XIc880Elp7yvnq8VRmM/KDj5/8nwB0LhREKw==
X-Received: by 2002:a9d:664d:: with SMTP id q13mr13545792otm.156.1612233597390;
        Mon, 01 Feb 2021 18:39:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:cc4:631e:f39f:4032? ([2600:1700:e72:80a0:cc4:631e:f39f:4032])
        by smtp.gmail.com with UTF8SMTPSA id m7sm4300280otq.33.2021.02.01.18.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 18:39:56 -0800 (PST)
Message-ID: <a73d4cd4-7a5e-dc5d-f381-62666ff1c360@gmail.com>
Date:   Mon, 1 Feb 2021 21:39:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 26/27] pathspec: stop calling ensure_full_index
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <5f53b08225771adc0be12c39e7be169d8620f146.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BHv+kAV5BfrhdQ+Vo-q_eVs7a3MvLYg0wYhZQoyvCoqaw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHv+kAV5BfrhdQ+Vo-q_eVs7a3MvLYg0wYhZQoyvCoqaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 6:24 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The add_pathspec_matches_against_index() focuses on matching a pathspec
>> to file entries in the index. It is possible that this already works
>> correctly for its only use: checking if untracked files exist in the
>> index.
>>
>> It is likely that this causes a behavior issue when adding a directory
>> that exists at HEAD but is outside the sparse cone. I'm marking this as
>> a place to pursue with future tests.
> 
> Sounds like you're unsure if this patch is good.  Should it be marked
> RFC or something?

...isn't the whole series marked as RFC? I only specifically marked the
ensure_full_index() one because I purposefully squashed it.

But in general, everything I'm touching in these areas seems like a
potentially problematic change. So many things are used and re-used
that I'm not sure what is safe or not. More testing is required for
commands to ensure their behavior.

I can enable things like GIT_TEST_SPARSE_INDEX to get other tests
using sparse-checkout to work (but only if they use cone mode). Hence,
I'm relying on what tests I can write to cover the behavior instead of
a robust history of valuable tests.

I hope to gather more confidence as this goes forward. I definitely
work to be confident that I am not making any errors that cause
problems for users who do not enable the sparse-index, but I expect
there to be a long tail of adjustments required as more corner
cases are discovered during the development and testing of the
feature.

The good news is that I have some engaged users who are willing to
test the feature and provide feedback if they hit any snags once
there is a minimal set of functionality.

Thanks,
-Stolee
