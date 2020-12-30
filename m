Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA68C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D7C22262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgL3Ty1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3Ty1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:54:27 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE64C061575
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:53:47 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id y14so3904841oom.10
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u4IvaHK11y6ZGFE70q+a180OSWJYVAFrMc7/mUequa0=;
        b=QuZccbP3NWzfLD0wt6WM8Ctn2Lq4Tsug/XFxaXpfw3gnbN28/21b+w6KTTh94YVOON
         Kcp0U4HBx2AtBaLT9hh0AF00B/iupVpEgcYrQJw1zL7ebPYyg/5BuQ0xqGvpj/DrWsAv
         dwFsvknlijl6ILF4YC1fJDqa6ogDCLNUf1WOQW7PA2ODuw0LZkFgV3pGvJpvrMlGeqWe
         T593qLaN5fBvCS+KDCJmlpdPeasBcBqSz+31NFgDO+k2LBsIAPUM6xNKgxIdDrdUD34N
         VFv3t5f4j2FUJu6q8KZgkbykGuhu+Q03Khq2iQ6SQciNM3ShGiW85o9MrBcg4ASHZHuO
         93AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4IvaHK11y6ZGFE70q+a180OSWJYVAFrMc7/mUequa0=;
        b=rk3xyIpAgvoAk3Z7U4jaQNwIWOdp7SyaWR4gAyLVW3YkhUP33T9Gp5+LYpAYC2ROi6
         17r/PCXMk3g5/xj2/I1dstWrw4HSSmVx2/2BJEna19H3v378zkeyKWgaXg+xBgFJ5+m8
         zc9lA4W+PRiatInfTzNxndYR8jI3ZZoPKsFMHMz5w8blQbQpLt4tKcnzMcnJ5ezU/KZz
         0YOM4uenBC9F760eZJ+erFGwegUKWvi0S4gpNFpbV/1yOivwJdH7DWFd2Ar7y1r6aV5d
         rkmp95x/X+TWX+dSQE0+EyUSGafEUCxIcXt0sYMXleky2T+JKMH6AyBrE4ggkKsJ7gmm
         Meeg==
X-Gm-Message-State: AOAM531REXe3C9o2MWPIFb67fYeczbns6g4mcz1OQhom4OVAM5WGC2vY
        Kdhug/Y8TTP7HywIkxDIeAA=
X-Google-Smtp-Source: ABdhPJwCKowmXNLUjE2xa4Z2CatglQMywghQiXdUhT7OSLewszyFhJSmUNM5ivPzjlBr2PSaUG5Yiw==
X-Received: by 2002:a4a:a3cb:: with SMTP id t11mr37258050ool.30.1609358026421;
        Wed, 30 Dec 2020 11:53:46 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id v4sm10672582otk.50.2020.12.30.11.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 11:53:45 -0800 (PST)
Subject: Re: [PATCH 5/8] cache-tree: trace regions for prime_cache_tree
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <5d1c9c8a356b9003be21059c7ed6232732fd26c0.1609356414.git.gitgitgadget@gmail.com>
 <CABPp-BGTXvNjwQkqSzqLJwL6T2a_Ly_9=wiejqpt-3sq6oPGEw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <97488332-a24e-889c-0114-ff54b12e573b@gmail.com>
Date:   Wed, 30 Dec 2020 14:53:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGTXvNjwQkqSzqLJwL6T2a_Ly_9=wiejqpt-3sq6oPGEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 2:48 PM, Elijah Newren wrote:
> On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Commands such as "git reset --hard" rebuild the in-memory representation
>> of the cached tree index extension by parsing tree objects starting at a
>> known root tree. The performance of this operation can vary widely
>> depending on the width and depth of the repository's working directory
>> structure. Measure the time in this operation using trace2 regions in
>> prime_cache_tree().
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  cache-tree.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/cache-tree.c b/cache-tree.c
>> index 45fb57b17f3..f135bb77af5 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -746,7 +746,10 @@ void prime_cache_tree(struct repository *r,
>>  {
>>         cache_tree_free(&istate->cache_tree);
>>         istate->cache_tree = cache_tree();
>> +
>> +       trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
> 
> Shouldn't this be at the start of the function, a few lines up?
> 
>>         prime_cache_tree_rec(r, istate->cache_tree, tree);
>> +       trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
> 
> ...and this be one more line down?  (or the string "prime_cache_tree"
> have a "_rec" added to it?)

I guess my focus was on creating changes around the "bulk"
of the operation, keeping the region enter/leave pair close
together. But perhaps enclosing the full block will be
better for full coverage in case this method became more
complicated (but not within prime_cache_tree_rec()).

Thanks,
-Stolee
