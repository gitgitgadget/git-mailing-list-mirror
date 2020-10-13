Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F8C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDD422CBB
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+UQ2fs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgJMNIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgJMNIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 09:08:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34DC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 06:08:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so13892420wrv.7
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7a55Po6wiRyP2F0ZOdnNseqMhuWIi5RnnqKAEVMkUQQ=;
        b=r+UQ2fs+a6BSOfzg1c/aYYs7Sh0tMob6QwXJEoBvKIK1CUhuejiD6y91R8ppfc7ZYK
         nDrhB6MYuht7vjdtxJl28vmCw4SnDs7jF3klFBDPd0uFpy+8Bsy3JuD0WANIEnrnQEqo
         38A1zaaNMwmh4AGuBXVteTLM0BPXQ+V7VqTBQXffARQ6WpWKOPeaIawXnDAv+LXFJbgJ
         jKkC634O8H7k5K7zg4rLqgZUGl5jH4/1HwL8Vf3GkJfRqc5mhHPk2hB7G9EWrF1JCD+3
         4pwnDUrAMhq/uS+j21Nn8g+pBB68SFZrFk59LRzsP3ZZjVqjRbAy1Xsz7gdJqLhwcDCT
         n2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7a55Po6wiRyP2F0ZOdnNseqMhuWIi5RnnqKAEVMkUQQ=;
        b=myXSdaM3no/6FGOZA3bG0srkUppHN9Y+jEW7BnbyQkg/I18bUbM6gHSgDjAzCuCu6O
         trs/LAnOqma8uBX16Ar15Mt5n6M/LbkyHSM6Wg/ctw3uTtVG98UpF2MSxHjTgT17uC2Y
         u+dZKwdvin/UOQMwkdb/jqnAlFtrQeNePxm7V4KtCF8OBIQwBIaQg6F6+nnbJiGxOyDL
         BWBjCiEMdjFRFmNJ9DX+QRGIN1p9NJje6YO4DvyXhvt0/YG6+T99878faJazZEdOar6c
         BSiDgTWKHQdj7XrX3bPLYx7e7uAr0BOcDIXRJKHWQUEPfI61I0mNls1Jm2A/s+jKTk5S
         KpGQ==
X-Gm-Message-State: AOAM530BCy3Avl95DU5KICcW4Vqq2dKpreOLYpiRMGZDaIrBprlUbHX2
        vDovElrcBxSM/LQwk3IxLIFnCu75lLM=
X-Google-Smtp-Source: ABdhPJz/L0Vit3DHGpPRwGyagSUzADtzkvnplVKxoWLK4siQsdP4o0dy7fApNVvxfQQoN5v6C/PIsA==
X-Received: by 2002:adf:e881:: with SMTP id d1mr24540086wrm.395.1602594498210;
        Tue, 13 Oct 2020 06:08:18 -0700 (PDT)
Received: from [192.168.1.240] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.gmail.com with ESMTPSA id 1sm30983748wre.61.2020.10.13.06.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:08:17 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Make test selection easier by specifying description
 substrings instead of just numeric counters
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fba0a914-1818-8a24-41b0-35740a7c2d2d@gmail.com>
Date:   Tue, 13 Oct 2020 14:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

I'm worryingly excited by this series

On 13/10/2020 00:26, Elijah Newren via GitGitGadget wrote:
> This patch series enables me to change
> 
>   ./t9999-my-test.sh --run=1-3,5,17,19
> 
> into
> 
>   ./t9999-my-test.sh --run=setup,rename,symlink
> 
> and have it pick out tests with "setup", "rename", or "symlink" in their
> description and run those. Saves me a lot of time, especially since numbers
> for tests aren't readily accessible. The easiest way for me to get the
> numbers corresponding to the tests I want to run, is to run all the tests
> and look at the output to match up the descriptions with their numbers --
> thus defeating the point of selecting just a subset of the tests to run in
> the first place.

Yes it's a real pain to have to run all the tests to find the numbers of 
the ones you actually wanted to run. I like patch 3 as well, without it 
if you're only running a couple of tests it can be hard to find then 
amongst all the skipped tests. I had a quick read of the patches and 
they looked fine to me.

Best Wishes

Phillip

> Elijah Newren (3):
>    test-lib: allow selecting tests by substring/regex with --run
>    t6006, t6012: adjust tests to use 'setup' instead of synonyms
>    test-lib: reduce verbosity of skipped tests
> 
>   t/README                     | 26 +++++++++++++++++------
>   t/t0000-basic.sh             | 41 ++++++++++++++++++++++--------------
>   t/t6006-rev-list-format.sh   |  2 +-
>   t/t6012-rev-list-simplify.sh |  2 +-
>   t/test-lib.sh                | 15 +++++++------
>   5 files changed, 54 insertions(+), 32 deletions(-)
> 
> 
> base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v1
> Pull-Request: https://github.com/git/git/pull/878
> 
