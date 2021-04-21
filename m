Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9AC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A9560720
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 13:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbhDUN4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbhDUN4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 09:56:38 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C35C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:56:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i12so11302542qke.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1pEJ0d58k/yD0pINtZrMbRjfip3WM5tXRNtDj0TKoF0=;
        b=ZvvWkNrRi0l+DmhxycvxkuC/dw8C8fwTuupQ2PoumX0Pv24eMbSrE6RXcHQypqJBzR
         FmWCWJ6cCf9tZP3Ih/SM/7OjOObiKkVAhaSGeK86emV3Beq9uwawZhUOGo+4mC3lM/Pr
         Rbmg3MN6QTGSj4ZsLaLxj7Rxl8Jwt6BM6uHbWqZ2BeZV2OGZO5XWZG6DNCgND+fpOg7r
         Jd39WyGqsly9rgx7bVp+o1Y/5kgqCNLxkbpgq2AJhd5Pp/vAWwY3kdYj2HRuk+q2XJgm
         2kmNX3gy2YrM2CztE+kg5K/J2yfRgQYlJ2L8Nx0J7p3DguV5aSOVE6UAN4ATcDt0h6Cp
         mRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1pEJ0d58k/yD0pINtZrMbRjfip3WM5tXRNtDj0TKoF0=;
        b=lcuWKF0ghwvaJWYFIcs93mJxMGnN/qoLRYyBKxNGBrB5QVG4URvP1kwbH5tbfBc22U
         FjYdCqjW04RTIyVbaFP3YEOzPZ9gG+/p23ZjaUrSFBxYlI1rCGgO4w8ngpUNxEIkhF3P
         OsVcgH1gEKwxPgI+IEw9UsraYdSH4902iAOP543osBnaoCu5pN4Ov/MQFOwCh7GI/lpE
         HGJezDNmNcTZRTyDhKlP6bGBHIid50x3Pr2fjSHEphoy0P4LMYFIh1tG/216XqWIFZFw
         Xfe4sKFGLOzNZra4ybaYeNs95+IoqS1r9u7/PvnfT+UwvQE71nvneadN0U3N3bznepu+
         h+OQ==
X-Gm-Message-State: AOAM533z2X8UQJ9OrCgz0NhrXJyT0aQbpBKvs30fEmsbMjaxAr37u2jd
        gtVnNRVRxGraM7L65oKnWZg=
X-Google-Smtp-Source: ABdhPJy0LlRhQpKcfnhqKAuPoP5G7UiNkCN5Vaie+zqhldoiA/0VOeInu1EFSWzU2PT9MhNci5UBCQ==
X-Received: by 2002:a05:620a:125c:: with SMTP id a28mr23851787qkl.253.1619013363310;
        Wed, 21 Apr 2021 06:56:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id h12sm1784232qtq.1.2021.04.21.06.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 06:56:02 -0700 (PDT)
Subject: Re: [PATCH 05/10] status: use sparse-index throughout
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <d7d4cad8be0b2a27a332a2796ba0dce92783355f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHzfcCNqhHOnK0gsC1r6XX9KAqMYVHhsAzdLpJj5E5TEw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <17feba15-a7a9-1948-3e0b-a395df69010e@gmail.com>
Date:   Wed, 21 Apr 2021 09:55:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHzfcCNqhHOnK0gsC1r6XX9KAqMYVHhsAzdLpJj5E5TEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 8:44 PM, Elijah Newren wrote:
> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> By testing 'git -c core.fsmonitor= status -uno', we can check for the
>> simplest index operations that can be made sparse-aware. The necessary
>> implementation details are already integrated with sparse-checkout, so
>> modify command_requires_full_index to be zero for cmd_status().
>>
>> By running the debugger for 'git status -uno' after that change, we find
>> two instances of ensure_full_index() that were added for extra safety,
>> but can be removed without issue.
>>
>> In refresh_index(), we loop through the index entries. The
>> refresh_cache_ent() method copies the sparse directories into the
>> refreshed index without issue.
> 
> I do see the removal of a call to ensure_full_index() in
> refresh_index() that you mention in this paragraph in the patch below.
> 
> I'm confused, though; I would have thought we wanted to avoid a
> refresh_cache_ent() call.  Also, one of your previous patches added a
> 
>     if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
>         continue;
> 
> check before the code ever gets to the refresh_cache_ent() call, so as
> far as I can tell, that function won't be called from refresh_entry()
> for sparse entries.  Maybe your commit message here is out-of-date?
> Or am I confused somehow?
> 
>> The loop within run_diff_files() skips things that are in stage 0 and
>> have skip-worktree enabled, so seems safe to disable ensure_full_index()
>> here.
> 
> Unlike the above, I don't see a removal of a ensure_full_index() call
> in run_diff_files() as claimed by this paragraph.  Has the commit
> message gotten out of date with refactorings you did while developing
> this series?

I greatly reduced the number of ensure_full_index() calls in the
previous topic (ds/sparse-index-protections) since first writing this
patch, so it is very likely to be out-of-date. Thanks for calling it out.

>> This allows some cases of 'git status' to no longer expand a sparse
>> index to a full one, giving the following performance improvements for
>> p2000-sparse-checkout-operations.sh:
>>
>> Test                                  HEAD~1           HEAD
>> -----------------------------------------------------------------------------
>> 2000.2: git status (full-index-v3)    0.38(0.36+0.07)  0.37(0.31+0.10) -2.6%
>> 2000.3: git status (full-index-v4)    0.38(0.29+0.12)  0.37(0.30+0.11) -2.6%
>> 2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
>> 2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%
>>
>> Note that since HEAD~1 was expanding the sparse index by parsing trees,
>> it was artificially slower than the full index case. Thus, the 98%
>> improvement is misleading, and instead we should celebrate the 0.37s to
>> 0.05s improvement of 82%. This is more indicative of the peformance
>> gains we are expecting by using a sparse index.
> 
> 82%, very nice.  Was this with git.git as the test repository, or some
> other repo?  If it's git.git, then we'd actually expect a much bigger
> speedup for other repositories, as git.git is pretty small.
This test script takes the input repository (git.git in this case) and
creates a tree that contains that repository many times over, but only
four copies remain in the sparse-checkout definition. This creates the
big speedup, because of the enormous difference in index size.

As I am exploring commands such as 'merge' and 'rebase' I am finding
that this test setup is too expensive to cover those commands. I will
need to reduce the size of the test repository (by a factor of 4) and
that will reduce how impressive these results are while making the more
complicated commands testable in a reasonable amount of time.

Thanks,
-Stolee
