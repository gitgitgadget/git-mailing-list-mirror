Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E95C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 12:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA89E2075D
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 12:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXEL3l2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHKM1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgHKM1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 08:27:43 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713C2C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 05:27:43 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l204so12043966oib.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUYBRzenopV8kyCNR6wMWjsBDTlCxu0qHDufp6fbZEI=;
        b=rXEL3l2IyC6vLOg2mBtNZoEGo/S2UgntKYsITAq/x47ObVyB+DhjqJvV+DK8bm/nvk
         LMRTjFssxPXF0yfLrvuN7V4tv+PBLJgGTcNGTwTOZrtWMtaKbBBqcspg4pzQvr4JQgkW
         szORgxpWcpoYzEdC5UdfwHvw0IOLPMmT0HrCcf6b1dAka0/2i7P54+J/ICj5/ww97+2Q
         5adL/DffAk2DMJE2P7y3VuBHNOP0IJdfRLUQNaTnhfMVCc99WjqqG8V9U4yn6ZepfmKN
         u+gDqG7fIND04nuXfsocYKdsDW7Nk4GRzjkgB9UD2roXzhl7LCtXHjdk/5MEzgr9cy6n
         C5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUYBRzenopV8kyCNR6wMWjsBDTlCxu0qHDufp6fbZEI=;
        b=PLCQ8FIsb2SwMjkMsEnN/Z6EM9FbH2xAu/Lm23b/LDnLEc6065kIjucxuZwOemDxW2
         9RmABsnqDJfzA5jZR8vGUr+kAS+G/+bcI0jIRdvBZvXsU/u75MHmyT8knRaQ99WVc4PB
         qCm66fNM5OIoVZAWrugeEMzT+tMmKA8EFvzqfuLwT2XBATDzuys1eYZ8ZXmvpfjEKPEx
         Ip3k/L9M5d8nGKZorZgbvjja21nzHGxI4q9SQFT4iWeXXvjPzVhxgpJ+zVI2X5yusSES
         IwlpJYs5MUWRXAR3bumkb8ffaveEwExxj1B6Bpc27tU5Xmd/a18dMAz30iuOHjAt5jah
         0ESg==
X-Gm-Message-State: AOAM533Z5qDIzAsuKVv4sj4IJtK8Ddgz26Yne1oLWsFV/KbQFs1zwp1K
        GIZUTWRIjfWIUaiceY45uGjaauU63Rw=
X-Google-Smtp-Source: ABdhPJwCJhB7Dny8u8nolyxDHj5cfVedaDb3aqZD9sgnKyWdTUoH0qWLLTYXwAd4FWSo+wIRVXKxfg==
X-Received: by 2002:aca:c7cc:: with SMTP id x195mr3303482oif.9.1597148862256;
        Tue, 11 Aug 2020 05:27:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id 102sm4066174oth.3.2020.08.11.05.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 05:27:41 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] commit-graph: implement generation data chunk
To:     aee0ae56-3395-6848-d573-27a318d72755@gmail.com
Cc:     jnareb@gmail.com, abhishekkumar8222@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, gitgitgadget@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <cb797e20d79e9dcd3e0b953e0db3ed1defb9aa7c.1596941625.git.gitgitgadget@gmail.com>
 <aee0ae56-3395-6848-d573-27a318d72755@gmail.com>
 <20200811110316.GA3220@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3c053281-f5af-1ac8-75ef-9eb8ce4f539d@gmail.com>
Date:   Tue, 11 Aug 2020 08:27:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200811110316.GA3220@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 7:03 AM, Abhishek Kumar wrote:
> On Mon, Aug 10, 2020 at 12:28:10PM -0400, Derrick Stolee wrote:
>> Patches 5-7 could perhaps be reorganized as follows:
>>
>>   i. commit-graph: return 64-bit generation number, as-is.
>>
>>  ii. Add a topo_level slab that is parsed from CDAT. Modify
>>      compute_generation_numbers() to populate this value and modify
>>      write_graph_chunk_data() to read this value. Simultaneously
>>      populate the "generation" member with the same value.
>>
>> iii. "commit-graph: implement corrected commit date" without any GDAT
>>      chunk interaction. Make sure the algorithm in
>>      compute_generation_numbers() walks commits if either topo_level or
>>      generation are unset. There is a trick here: the generation value
>>      _is_ set if the commit is parsed from the existing commit-graph!
>>      Is this case covered by the existing logic to not write GDAT when
>>      writing a split commit-graph file with a base that does not have
>>      GDAT? Note that the non-split case does not load the commit-graph
>>      for parsing, so the interesting case is "--split-replace". Worth
>>      a test (after we write the GDAT chunk), which you have in "commit-graph:
>>      handle mixed generation commit chains".
>>
> 
> Right, so at the end of this patch we compute corrected commit dates but
> don't write them to graph file.
> 
> Although, writing ii. and iii. together in the same patch makes more
> sense to me. Would it be hard to follow for someone who has no context
> of this discussion?

It is always easier to combine two patches than to split one into two.

With that in mind, I recommend starting with a split version and then
seeing how each patch looks. I think that these are "independent enough"
ideas that justify the separate patches.

>>  iv. This patch, introducing the chunk and the read/write logic.
>>
>>   v. Add the remaining patches.
>>
>> Again, this is a complicated patch-reorganization. The hope is that
>> the end result is something that is easy to review as well as something
>> that produces an as-sane-as-possible history for future bisecters.
>>
>> Perhaps other reviewers have similar feelings, or can say that I am
>> being too picky.
>>
> 
> I can see how the reorganization helps us avoid a rather nasty
> situation to be in. Should not be too hard to reorganize.

I hope not. Hopefully you get some more review on this version
before jumping in on such a big reorg (in case someone else has
a different opinion).

Thanks,
-Stolee
