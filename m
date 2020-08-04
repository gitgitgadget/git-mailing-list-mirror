Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25261C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F216F206D4
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At/dodKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgHDRbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgHDRbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 13:31:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5EC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 10:31:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so17510164qth.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N5Deg5yH0WRtpwMrHdPnPQGRMKHC4obTCQcHDbNeWmM=;
        b=At/dodKjgLsuJGlcVhUJpu7wn+n2OfI2jcGanCdD1Eh87elq/98N+CDdB6WHr0rfhy
         MNtIPFdROQbjk/bCYS+oE9Lqg+Ey3Y6iHOT6y1BVIQW85Si359QQj+Z/4flGXdWEmvEw
         dEsbJDVGeBQr/A3sffAWxm82+uJABiPDkLBxvTyeBV2zlXX749B+8nztzvHb3iNMtjAa
         cRBSm5IRkLXoITVuhhsw+R+h8nFSON/FEBJvSOhr4GYora5G1dtxRkf5pNe6jSNdyhv5
         s/Mfwn0gdqBg2iMXM/9Z0VUQg1h5QSAKSWQlbWt/Qanu3CDpnxXJVLTACd5eGgp0FZza
         aL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N5Deg5yH0WRtpwMrHdPnPQGRMKHC4obTCQcHDbNeWmM=;
        b=rJCbw/MJIsSI8JaC+HppzJxp7ZblgcvbKfG8UKhfTV51cI/ZLDQIA0//GRHw8OexFl
         qOU5RyHgfJoUkboRhHVPrLZz+2fodrEQSzqEv+mb4vPoY7CUUNojYz9klzFOl91NOByQ
         PMlBe+to9b4bj4fixt+jxIxI8QqviElxQY5Y4k9MLd1GfRM46SYJpPgC+0IXJYjVCxrJ
         luy2SfHAPbGRLEbaWMmhqDdzpr0iLTlq/ZFfwXsYYc1hy5drq2afFhU2h0xERU/w45PF
         OPI3C6i3NCY2dwoDBVwEcFI4ojQEpL3LEvpTJRvHkEa1s46vM9kKr5ZLdDQHusPJ8ort
         /tdw==
X-Gm-Message-State: AOAM533jWlB5n2DyWNBh37N5W3EhZJyCOShKmNzAYRdZzTMMBJEpfZRO
        s0SzYcq46AYdfMc6h4o5OUI=
X-Google-Smtp-Source: ABdhPJzdroCfPcdh5T4Fg2taL9ySFORnmvEIUZDSk2iHLAv2slzoESx3qUiEwfOBNCupoaAQsRTZ9g==
X-Received: by 2002:ac8:1948:: with SMTP id g8mr23601224qtk.354.1596562268063;
        Tue, 04 Aug 2020 10:31:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id c42sm19124518qte.5.2020.08.04.10.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 10:31:07 -0700 (PDT)
Subject: Re: [PATCH v4 05/15] diff: halt tree-diff early after max_changes
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
 <20200804144724.GA25052@szeder.dev>
 <a08c26bb-54ec-13af-e503-fccd68727cf3@gmail.com>
 <20200804170040.GB25052@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cfa4e35e-e227-5862-6978-53e699a4a1d2@gmail.com>
Date:   Tue, 4 Aug 2020 13:31:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200804170040.GB25052@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 1:00 PM, SZEDER Gábor wrote:
> On Tue, Aug 04, 2020 at 12:25:45PM -0400, Derrick Stolee wrote:
>> On 8/4/2020 10:47 AM, SZEDER Gábor wrote:
>>> On Mon, Apr 06, 2020 at 04:59:45PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> This counter is basically broken, its value is wrong for over 98% of
>>> commits, and, worse, its value remains 0 for over 85% of commits in
>>> the repositories I usually use to test modified path Bloom filters.
>>> Consequently, a relatively large number of commits modifying more than
>>> 512 paths get Bloom filters.
>>
>> Thanks for finding this! The counter is only really tested in one
>> place, and that test only considers _file adds_, which is a problem.
>>
>> If I understand this correctly, the bug is a performance-only bug
>> (since this is a performance-only feature), but it is an important
>> one to fix.
> 
> Or a performance-only feature in a performance-only feature, because
> those additional modified path Bloom filters can improve the runtime
> of pathspec-limited revision walks (assuming that the false positive
> rate is low enough).
> 
>> There is certainly some dark magic happening in this tree-diff logic,
>> so instead of trying to get an accurate count we should just use the
>> magic global diff_queued_diff to track the current list of file changes.
>>
>> Note: diff_queued_diff does not track the directory changes, so it
>> is an under-count for the total changes to track in the Bloom filter.
>> This is later corrected by the block that adds these leading directory
>> changes.
>>
>>> The makeshift tests in the patch below demonstrate these issues as
>>> most of them fail, most notably those two tests that demonstrate that
>>> modifying existing paths are not counted at all.
>>
>> I adapted your diff along with ripping out 'num_changes' in favor
>> of diff_queued_diff.nr. This required modifying some of your expected
>> values in the test script (losing the leading directories in the
>> count).
>>
>> I'll work with Taylor to create a fix, and include proper testing
>> of the logic here. We'll stick it in the v2 of his max-changed-paths
>> series [1]. He already has some helpful logging that can help create
>> tests that ensure this logic is performing as expected.
> 
> Don't forget to include a check of the hashmap's size, to make sure.

Yes, thanks for the pointer. That check is currently not in there,
since the code assumes the hashmap's size will match num_changes.
Hopefully, the tests I intend to write around this would have caught
such an omission.
 
> FWIW, the patch below does result in the correct count (read: the same
> as in my implemenation) for all but 4 commits in those repositories I
> use for testing, without adding any memory allocations and extra
> strcmp() calls.

...

> Having said that, the best (i.e faster and accurate) solution to this
> issue is probably:
> 
>   - Update the callchain between diff_tree_oid() and the diff callback
>     functions to allow the callbacks to break diffing with a non-zero
>     error code.

It looks like this part would not be too difficult. The pathchange
callback is called by emit_path() which returns a struct combine_diff_path
pointer. This could return NULL to signal an early termination, but
we need to update all callers of the following methods to handle NULL
responses:

 * emit_path()
 * ll_diff_tree_paths()
 * diff_tree_paths()

Of some interest: diff_tree_paths() returns a struct combine_diff_path
pointer, but no callers seem to consume it.

>   - Fill Bloom filters using the approach presented in:
> 
>       https://public-inbox.org/git/20200529085038.26008-21-szeder.dev@gmail.com/
> 
>     but modify the callbacks to return non-zero when too many paths
>     have been processed.

Thanks for the pointer to that specific patch. You do a good job of
describing your thought process, including why you used the callback
approach instead of the diff queue approach. The main reason seemed to
be memory overhead from populating the entire diff queue before
checking the limit.

However, if we are using the diff queue as the short-circuit, then
perhaps that memory overhead isn't as much of a problem?

You admit yourself, that

  This patch implements a more efficient, but more complex, approach:

The logic around matching prefixes definitely seems complex and
hard to test, especially around the file/directory changes with the
sort order problems that have plagued similar prefix checks recently.
I'm not doubting your implementation, just saying that the complexity
is worth considering before jumping to that solution too quickly.

To sum up, I intend to start with a fix that uses the diff queue
count as a limit, then try the callback approach to see if there are
measurable improvements in performance.

>   - Drop this counter entirely, as there are no other users.

With the callback approach, "this counter" is both num_changes and
max_changes, since the callback would perform all of the short-circuit
logic.

Thanks,
-Stolee
