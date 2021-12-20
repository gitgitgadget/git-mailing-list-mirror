Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94808C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhLTNkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLTNkP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:40:15 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7056C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:40:14 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w64so15779009oif.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GvKDu15wOQukEsRkBAHjmNcSM2i7izvJKRqpx7EyYkE=;
        b=pWvzzzeGmaMxrJkJZJJclAdgDuF1fC3GEFcfDFrieCXmFKk+/I20aBrOwVDo6gqRmW
         laBoyO0XjjilCFilccT00jd2Jv75czzkkgCmeW/BTOKrmkJfgtraBovEMHgPkjV56LbH
         JgLt7fgeUpZERpZNS4+g2uYYQpo78tUc4fs5Oy94wC148GUQ7PWDHNxjEZDPkWFTFU6L
         vpooMWRT7cOAkClAcXQHnocLjRVZawgx8rpzErVfnbE8O5Czw3FMrwEGymXWUKrf6ZTK
         Kw1P5YU1yMet+JakJ5o6zlEEn8MeU+RNj7Gr2DYO5fBv783IEe5uH4zbp4GhB7Bm74yw
         8H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GvKDu15wOQukEsRkBAHjmNcSM2i7izvJKRqpx7EyYkE=;
        b=4XDExm32ECzw1gBxEKQWtgmJm3gHkxiT15RDe62750CkABuUA0ko165+tktj+Qk/JO
         ZshZegHHz5h9c0QYd3tKbEW2L5PYPf++LexMkLPCReVtG5pR1tz7gQXdtoYiXWJwPyKM
         sxsj9iXsOV+d8EfvvCux1YAMPX0z3ARRTDGxz2o2h9s1UTyuGV+1gvQAE89UbSFgFIwR
         hQ4D8HwySoirW4zxxVoALjHZunlrQm8x1p12kLBSqMCY5QEuMriagcVyLBde/ot7vuxC
         xKbAHcsXXfgVhwikjPrgzE71l6G3J9foY03iaQWvV0cYjb7OcYqVLhDylEKe5FU8Mfe2
         ujdQ==
X-Gm-Message-State: AOAM532LxJnxuPV/uR4k2MfKOXYxdjN6nP2NbFm11CVGHlMU3lsfdj4x
        q+EYrnkoKHNlbopX/p6LDs4=
X-Google-Smtp-Source: ABdhPJy+908eO1MTMT4qUHTomtcBBP7D5pIj7iSFV8To/vtUpphLBe53cXd0ygjUc6VS8XtJNJgDxw==
X-Received: by 2002:a05:6808:1644:: with SMTP id az4mr18389885oib.86.1640007614017;
        Mon, 20 Dec 2021 05:40:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id n26sm3001710ooq.36.2021.12.20.05.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:40:13 -0800 (PST)
Message-ID: <d10662af-4ce9-6944-aa73-ef344f6bdf67@gmail.com>
Date:   Mon, 20 Dec 2021 08:40:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] repack: respect kept objects with '--write-midx -b'
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
 <YbzHtsl045XZbJGN@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YbzHtsl045XZbJGN@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17/2021 12:24 PM, Jeff King wrote:
> On Fri, Dec 17, 2021 at 04:28:45PM +0000, Derrick Stolee via GitGitGadget wrote:

...

>> +test_expect_success '--write-midx -b packs non-kept objects' '
>> +	git init midx-kept &&
>> +	test_when_finished "rm -fr midx-kept" &&
>> +	(
>> +		cd midx-kept &&
>> +		test_commit_bulk 100 &&
>> +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
>> +			git repack --write-midx -a -b &&
>> +		cat trace.txt | \
>> +			grep \"event\":\"start\" | \
>> +			grep pack-objects | \
>> +			grep \"--honor-pack-keep\"
>> +	)
>> +'
> 
> This looks correct, though:
> 
>   - do we really need this separate repo directory? The test before it
>     uses one, but only because it needs a very specific set of commits.
>     There is a long-running "midx" directory we could use, though I
>     think just the regular test repo would be fine, too.
> 
>   - likewise, do we need 100 commits? They are not too expensive these
>     days with test_commit_bulk, but I think we don't even care about the
>     repo contents at all.
> 
>   - there is no actual .keep file in your test. That's OK, as we are
>     just checking the args passed to pack-objects.
> 
>   - useless use of cat. :) Also, you could probably do it all with one
>     grep. This is bikeshedding, of course, but it's nice to keep process
>     counts low in the test suite. Also, your middle grep is looser than
>     the others (it doesn't check for surrounding quotes).
> 
> So something like this would work:
> 
>   test_expect_success '--write-midx -b packs non-kept objects' '
>           GIT_TRACE2_EVENT="$(pwd)/midx-keep-bitmap.trace" \
>                   git -C midx repack --write-midx -a -b &&
>           grep "\"event\":\"start\".*\"pack-objects\".*\"--honor-pack-keep\"" \
>                   midx-keep-bitmap.trace
>   '
> 
> One could perhaps argue that the combined grep is less readable. If
> that's a concern, I'd suggest wrapping it in a function like:
> 
>   # usage: check_trace2_arg <trace_file> <cmd> <arg>
>   check_trace2_arg () {
> 	grep "\"event\":\"start\".*\"$2\".*\"$3\"" "$1"
>   }
> 
> All just suggestions, of course. I'd be happy enough to see the patch go
> in as-is.

Thanks for the suggestions. I decided to adapt the 'test_subcommand'
helper into a 'test_subcommand_inexact' helper. The existing helper
requires the full argument list in exact order, but the new one only
cares about the given arguments (in that relative order).

Thanks,
-Stolee
