Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D1C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEDA6128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhGNNOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhGNNOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:14:48 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C5FC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:11:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o8so1507909ilf.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FY2Hj1vqgHU6OIqqzrPY4WyRsSqi8IyuJE68te3Ac9U=;
        b=Z3a/YaImvRlwbmodjwxkdoKwYvKZFQ8yzLdYK/dGfG7dOaxPZANncvq2XWq67JrOFc
         UJ+p5sPav9FbN1OLH2nLzIYw5URwL0zDRyaKsVLu4YmuImk2ptlsRmP0yQQRQke4NZ6D
         y97bR5Tju5ipNhitTFLKn68WPv7d+RaYMBFDU4BdpqUFDebqgPMonTLn6VmaD0OoYPen
         e5q07Y4IcUZa0g7FcP2zeXCyXkN/TaUdw6Yt15T8R/nQ9/Q4MfD+nAhoVA5etrdXpEY2
         mLfvNdsxZ9GT/6CGxMk8R/AR+dEuhXcgsTPGgtzVgubYx/S9pH7TaWYT+TCYFmbwdoUc
         G9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FY2Hj1vqgHU6OIqqzrPY4WyRsSqi8IyuJE68te3Ac9U=;
        b=OY5m+2ilbIU7SlTYTjlhd8Qzv7N7yGTkSH0mbRhiJ78OI3o0/gPVaypxp2cUZaGwzG
         27JsZNfdZN73qCtOLu8s2m8IakjkMAicKPzFPYaHFHsOfQGq3ja8M1LNp8XjU3j39X85
         p1/lhqPJZZRCNHDE1Njy7uMj6vVNogQVf/LdNo86Ama3FlMuUT9Z0SRfc5uTp/iWdI5I
         e0+CL+oOY24fMHK/Oxh9aYjydEcK1MBhd2BysO9EjZkl+Ki+JA8igsW+W5P9pLe50Cso
         fOZWZfhSKT+WL7Z9P8XFVMfKtJNSYgo+o+3oow/sGFNQvkwgJFRGVdkZcY3A+RB1muVH
         qlzQ==
X-Gm-Message-State: AOAM5327SXPR9MiNW9pbn1YsAUsToz/mBvkqulcXdHl1615WE9MQ6GEc
        BrLOX+VDVZlIU9n5knYQS5h9L3j2MH45dQ==
X-Google-Smtp-Source: ABdhPJzVhP+PPqWTO91quCqfkrkIdyY5iAZkKKgQ2nLrMNbOvlhtllRWjP27T4H8d7JAYgBl3x94yw==
X-Received: by 2002:a92:cdae:: with SMTP id g14mr2508993ild.123.1626268316389;
        Wed, 14 Jul 2021 06:11:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:25b6:24:694f:7804? ([2600:1700:e72:80a0:25b6:24:694f:7804])
        by smtp.gmail.com with ESMTPSA id o8sm1217850ils.24.2021.07.14.06.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 06:11:55 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmtqpzosf.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
Date:   Wed, 14 Jul 2021 09:11:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtqpzosf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2021 9:07 PM, Junio C Hamano wrote:
...
> * en/ort-perf-batch-14 (2021-07-13) 7 commits
>  - merge-ort: restart merge with cached renames to reduce process entry cost
>  - merge-ort: avoid recursing into directories when we don't need to
>  - merge-ort: defer recursing into directories when merge base is matched
>  - merge-ort: add a handle_deferred_entries() helper function
>  - merge-ort: add data structures for allowable trivial directory resolves
>  - merge-ort: add some more explanations in collect_merge_info_callback()
>  - merge-ort: resolve paths early when we have sufficient information
> 
>  Further optimization on "merge -sort" backend.
> 
>  Reviews?

I saw a v2 re-roll, so I will review that this week.

> * ds/commit-and-checkout-with-sparse-index (2021-07-12) 5 commits
>  - checkout: stop expanding sparse indexes
>  - sparse-index: recompute cache-tree
>  - commit: integrate with sparse-index
>  - p2000: compress repo names
>  - p2000: add 'git checkout -' test and decrease depth
>  (this branch uses ds/status-with-sparse-index.)
> 
>  "git checkout" and "git commit" learn to work without unnecessarily
>  expanding sparse indexes.
> 
>  Ready?

Let's mark this as "expecting a re-roll" because of the
directory/file conflict issue. I'm trying to see if there
is a quick way to resolve the current behavior change that
Elijah pointed out.

> * ds/status-with-sparse-index (2021-07-12) 15 commits
>  - fsmonitor: integrate with sparse index
>  - wt-status: expand added sparse directory entries
>  - status: use sparse-index throughout
>  - status: skip sparse-checkout percentage with sparse-index
>  - diff-lib: handle index diffs with sparse dirs
>  - dir.c: accept a directory as part of cone-mode patterns
>  - unpack-trees: unpack sparse directory entries
>  - unpack-trees: rename unpack_nondirectories()
>  - unpack-trees: compare sparse directories correctly
>  - unpack-trees: preserve cache_bottom
>  - t1092: add tests for status/add and sparse files
>  - t1092: expand repository data shape
>  - t1092: replace incorrect 'echo' with 'cat'
>  - sparse-index: include EXTENDED flag when expanding
>  - sparse-index: skip indexes with unmerged entries
>  (this branch is used by ds/commit-and-checkout-with-sparse-index.)
> 
>  "git status" codepath learned to work with sparsely populated index
>  without hydrating it fully.
> 
>  Expecting a final reroll.
>  cf. <e7199fc6-bc7b-f556-c10c-12dee04af287@gmail.com>

Final re-roll inbound.

> * ds/gender-neutral-doc-guidelines (2021-06-16) 2 commits
>  - SQUASH??? replace neutering tips with that of Æver
>  - CodingGuidelines: recommend singular they
>  (this branch uses ds/gender-neutral-doc.)
> 
>  Attempt to give a guideline for gender neutral documentation.
> 
>  Comments?

I've said before and will repeat here that the draft in your
SQUASH??? commit looks like a good compromise to me. It can
replace the other commit in this branch.

Thanks,
-Stolee
