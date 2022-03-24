Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9625EC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 15:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351371AbiCXPoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351392AbiCXPoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 11:44:18 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1C1AC04C
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:42:46 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d39f741b2bso5286268fac.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RUm6afFS5bkVCe/cn7zneWsqTaZQvrACKsmHi4yGCcg=;
        b=FIJXPJqVWD/hIJ8b9ABEVrYUNSfy6UoqFuknqArEsX0lUFTOflMyh4aiCV5TzXjzR9
         6CneeWIkFMfvWfK0yV8aMAC7s6BfeB5N+3tl/uh/ZUrInk7DALA4Gbapi9//2J6rdQZv
         nfS6FaDsdgJTsrch3ufMAT7ZcY9ODTrf4csIIL3RNjAojVYDi1JZiG6n6FdgDxFxXpRV
         QklrEi0V3tJX7Esol+Y3SFJsrIMu/04i/GtSMn35ud2PI8gwG7ipcMwhtXzSpxARDo5q
         MoyebMa8D2I8oed5xzQ4hFfQOPzRW1hosqJpFZTcy1v/yKryqnO8hqw8MgcZ+xoAruyV
         v0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RUm6afFS5bkVCe/cn7zneWsqTaZQvrACKsmHi4yGCcg=;
        b=Ze/u6ayat2hH0+sbKjTFz05Urk04aUtRWeYJgKKUposDiR4coG/dgRv7OsQYP1W+X3
         moZAc1YPsZolC2vItZxOB7z4mQ/6eWQo6p9oOW4F/oVN7nn7ozpruxQEfGhfdv5WHeVc
         LR8Qg3WUhXwbFalURm3ZBrsHTwI50BXGqToSWTrA2xsjSg9SCfyBC4KeGScOoY5Rf2VJ
         ArrKJuo09ku2ctBTQgo/M26ubnmbdhURmAlE0ziqEAmr4Dm+f2LD4LGuVrGqv9J/Ei7j
         RpB8bXpE3SbdSLjFbgebjiUhaeg4QxXcshWO/kB5vVl19jXatyV8HGng5ByUyOraNZ89
         0ZjQ==
X-Gm-Message-State: AOAM531oCig7xuG3nLLSFYf+Rvm9uKKBhLaCAy2kjIxHHvmNtKYMEaFP
        ks53HShZTRRWSYvKhh8PdKpt
X-Google-Smtp-Source: ABdhPJyG8gv698/yfcwDKPKqgWB3a1XQLaExWnRDVFybWl+QqlWxrcnZeATEEMWRj63WUa7z+Va5xw==
X-Received: by 2002:a05:6870:b40a:b0:d7:5c87:64ab with SMTP id x10-20020a056870b40a00b000d75c8764abmr2762670oap.168.1648136565653;
        Thu, 24 Mar 2022 08:42:45 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r82-20020aca5d55000000b002ecaaa13cafsm1528208oib.8.2022.03.24.08.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 08:42:45 -0700 (PDT)
Message-ID: <72c54461-8af7-29fc-04da-f435adee9bbe@github.com>
Date:   Thu, 24 Mar 2022 11:42:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
 <xmqqmthgu3e6.fsf@gitster.g>
 <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
 <YjuVAgjaiqrcT7P1@nand.local> <xmqqfsn8p8nr.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfsn8p8nr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 7:10 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> On Wed, Mar 23, 2022 at 10:55:37AM -0400, Derrick Stolee wrote:
>>>> So, perhaps #3 ;-)?
>>>
>>> I'll default to #3 (do nothing), but if this shows up again
>>> I'll plan on adding a comment to the helper to be clear on
>>> how "inexact" the helper really is.
>>
>> I wonder if we could sidestep the whole issue with
>> test_subcommand_inexact by testing this behavior by looking at the
>> contents of the packs themselves.
>>
>> If we have a kept pack, and then add some new objects, and run "git
>> repack --write-midx -adb", the new pack should not contain any of the
>> objects found in the old (kept) pack. And that's the case after this
>> patch, but was broken before it.
> 
> Sounds quite sensible.
> 
> Instead of saying "we are happy as long as we internally run this
> command, as that _should_ give us the desired outcome", we check the
> resulting packs ourselves, and we do not really care how the
> "repack" command gave us that desired outcome.

Sounds good. It's all about a balance: using test_subcommand[_inexact]
gives us a way to check "Did we trigger this other command that we
trust works correctly from other tests?" without the more complicated
work of doing a full post-condition check. It's a bit more of a unit-
level check than most Git tests.

The full post-condition check requires more test code, but that's not
really a problem. The problem comes in if that test is now too rigid
to future changes in that subcommand. What if the post-conditions
change in a subtle way because of the subcommand does something
differently, but in a way that is not of importance to the top
command?

In this specific case, the test name says that it "packs non-kept
objects", so we can do more here to validate that post-condition
that we care about.

As I'm looking at Taylor's test case example, the one thing I notice
is that there is only one pack-file before the repack. It would be
good to have a non-kept packfile get repacked in the process, not
just the loose objects added by the test_commit. I'll take a look at
what can be done here.

Thanks,
-Stolee
