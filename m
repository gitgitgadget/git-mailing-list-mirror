Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F8C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiGSOSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiGSORx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:17:53 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789087E33A
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:50:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l15so11083411qvo.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N5Y4P2dCwIEg3pcBZLodagVD2fMesBbfWQHJSyrygmk=;
        b=Jo1RvWILJRlnyCAJuTWjRXSHIUq1Sx/YgwDqRoNyWRRDNdPLhmmrG0sNzdjLlJKod8
         GImkBAdBkTpDGC+wIhz1hpxINicAVIw2kXvU1PPNVJh93rkCLleS2R5BgasTp5kygOF5
         1vnF6RXxBWQm+4HKVBpIi2wGjV9j2ItlBA0esaz0B+xO8054XYQO/tFZB+UZJVimL7VN
         Cy61pGoBklEW+UYEFF74q/LdzqV1ll4XkXGede5TNukcgXYGUuM80Q1FMistzBaetojr
         ktJLiOhFGp2Rdcl2Bbfz0EXBas6Nfskcl7pwUT2zc9HVTTtzMmK0og6PA5lzX1AqRWoT
         P+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N5Y4P2dCwIEg3pcBZLodagVD2fMesBbfWQHJSyrygmk=;
        b=poPWtsmX9xq6GyeBrTtg8wbf1mbf2ZjZXGMajbEoV9qnEn3ledJVzwJA6pVUEVcF9t
         RrldGZZa83Jg/2i8IeuLlS+rqt+Y4Ne6PP9XtP4LRqyguKzYVkIS4g8bLVypVHcvTplD
         k5QrK3NSIdHhjRfwt2Z/XCeTKkzRvBoiK1x3YGSyqLKQug5mC1vYgySR7HaJq5Gc8NXb
         7LgT0UBQEKq34EVoyPaYuBzQKEr+9wZBt/BAGzWwuufsaYWwS7jgFZL0ZnNNU8Lqrj1m
         33CnEyqIaeP77sadD7+V9QIdUQSFkTRYS6yG+kotlkaYdrxo+2JZ1rm5Nf8H2q2R+Ct7
         g3tQ==
X-Gm-Message-State: AJIora8YtS9ceX3fQWZPFXpFV41qlOomwHox7ASm5e0Cpkj/9v/MTCx1
        qjbBEaUQCGs9pxs8HFtYMy/+XPC6GKzH
X-Google-Smtp-Source: AGRyM1vTLS3XYt+3d8+kfNEXLRiebg5h3M9hzjwO0BwRriaRR32Xz/Spr6VNhJKtFZ0xCX6vwSx+aw==
X-Received: by 2002:ad4:5bee:0:b0:473:10b5:e767 with SMTP id k14-20020ad45bee000000b0047310b5e767mr25705111qvc.39.1658238653555;
        Tue, 19 Jul 2022 06:50:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a258600b006a65c58db99sm14778676qko.64.2022.07.19.06.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 06:50:53 -0700 (PDT)
Message-ID: <335a5d52-ea9b-565b-396d-6543451aa027@github.com>
Date:   Tue, 19 Jul 2022 09:50:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] midx: reduce memory pressure while writing bitmaps
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, chakrabortyabhradeep79@gmail.com
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
 <220718.867d4aw0k3.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220718.867d4aw0k3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2022 5:47 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 18 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> It is unfortunate that the lifetime of the 'entries' array is less
>> clear. To make this simpler, I added a few things to try and prevent an
>> accidental reference:
>>
>>  1. Using FREE_AND_NULL() we will at least get a segfault from reading a
>>     NULL pointer instead of a use-after-free.
>>
>>  2. 'entries_nr' is also set to zero to make any loop that would iterate
>>     over the entries be trivial.
>>
>>  3. Set the 'ctx' pointer to NULL within write_midx_bitmap() so it does
>>     not get another reference later. This requires adding a local copy
>>     of 'pack_order' giving us a reference that we can use later in the
>>     method.
>>
>>  4. Add significant comments in write_midx_bitmap() and
>>     write_midx_internal() to add warnings for future authors who might
>>     accidentally add references to this cleared memory.
>> [...]
>> +	/*
>> +	 * Remove the ctx.entries to reduce memory pressure.
>> +	 * Nullify 'ctx' to help avoid adding new references to ctx->entries.
>> +	 */
>> +	FREE_AND_NULL(ctx->entries);
>> +	ctx->entries_nr = 0;
>> +	pack_order = ctx->pack_order;
>> +	ctx = NULL;
> 
> After this change this is a ~70 line function, but only 3 lines at the
> top actually use ctx for anything:
>     
> 	/* the bug check for ctx.nr... */
> 	prepare_midx_packing_data(&pdata, ctx);
> 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
> 
> Did you consider just splitting it up so that that there's a "prepare
> write" function? Then you don't need to worry about the scoping of ctx.

I did not, and that's a good suggestion. Extracting these prepare steps
into write_midx_internal() works to reduce the complexity and make the
early free()ing more clear.
 
> I'd think that would be better, then you also wouldn't need to implement
> your own free-ing, nothing after this seems to use ctx->entries_nr (but
> I just skimmed it), so it could just fall through to the free() at the
> end of write_midx_internal() (the only caller), couldn't it?

I think this paragraph misunderstands the point. The bitmaps are being
computed and written before the MIDX lock file completes, so the free()
of the entries array is after the bitmaps are computed. To reduce the
memory pressure (by ~25%) by freeing early is the point of this patch.

We still want that free(ctx.entries) after the cleanup: label for the
error cases, but for the "happy path" we can free early.

By doing the refactoring, this point of having an earlier free() makes
things more clear.

Thanks,
-Stolee
