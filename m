Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52142C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F58224F9
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 12:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhAKMIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 07:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbhAKMIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 07:08:01 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EF9C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 04:07:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j26so10992395qtq.8
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 04:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJWhWDG+4OEce2t0sr0cxsDr3TbQrhLmcsZmKbp04uc=;
        b=FSgSpWUjvTwVuCGMbVtANK7E/v+KjuJOTwMPEhybtaJBjItH/uzYfkN7usR3p2s4jO
         Gi54oRqbz88XLZt8xEMrkRPyYpkaPrtJqxu/32SpvGWy8dRRdgsGI1U6CYcSW5iIsIiK
         SILSQZyZHA0RvqLJf1aiwzeqvnupPZKnRCv0zi4pIMwKZqmyj/FxD4c7FQU3lvMNGI5n
         Mh4uef4sTGzqv3wsp8Q8X5DhKUOo1dmKmxpLJH+H/9O2kk9p71tkdF0Vgp+uWnJh0cCY
         a0WfgOpdya/u7zXodMxM68fPAt4bq9nfFjqaWzpl/fn0X7Ig2Hw41xeccbLTenoMiboO
         Jz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJWhWDG+4OEce2t0sr0cxsDr3TbQrhLmcsZmKbp04uc=;
        b=P72c0xEtbZXqRkFjokAqp3TI56BLmxTtr18YGir+cXKHraomiyrDazckZ6AlsNkOMW
         AEQj3eGaiGI5+mZqHHE4hroukLfbCootzz81DDcezEWsMNunYMYeLRDa9wUTdvpHoSjU
         ai5QadJnoFaA4Gc1qR0M76Dj0+EDD+ah5ykTuAS1LprZQD5KLH98JJIlVC5a/5aE8jL6
         89K83/c0S+A/y7+r85c8JCtbSZKMxM19d4PUbrIqcgDHl0B7QA173T0s0cd0eE4TL5eQ
         36NGVi/PzNrxgf3AuD1V4JYl35dQjMbU7InD6kxt05j9qkshmWXa672YYLVdr02EPae5
         tY+g==
X-Gm-Message-State: AOAM532Dy2y1Xj60lxpuCBOq4N14xUWTKKSZ3oqeRNlo3EpOgvv23ArW
        5v3gQWnXtkv99ak8FyTnmbARs9ede/M=
X-Google-Smtp-Source: ABdhPJwb+4lWn2dVJdG73/tbIjzSz2MWAXiIsQG5EBDKaVOCvStTsq/EMUK1uLp6Ui0kRf0y/zT5kQ==
X-Received: by 2002:aed:2c66:: with SMTP id f93mr15291273qtd.14.1610366839150;
        Mon, 11 Jan 2021 04:07:19 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id g26sm8257350qka.76.2021.01.11.04.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 04:07:18 -0800 (PST)
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <75ba9979-1a1f-de9f-c2cc-1433d30ed09d@gmail.com>
Date:   Mon, 11 Jan 2021 07:07:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2021 1:16 PM, Taylor Blau wrote:
...
>   - First, a new API is proposed.
> 
>   - Then, uses of the old API are removed one by one and replaced with their
>     new counterparts.
> 
>   - Finally, without any callers remaining, the old API is removed.

This patch series has a clear layout that was easy to follow.

In a vacuum, the conversions from immediate struct member lookups
to API calls seems like adding overhead to something that is done
frequently in a loop. However, you do justify it:

> Generating the reverse index in memory for repositories with large packs has two
> significant drawbacks:
> 
>   - It requires allocating sizeof(struct revindex_entry) per packed object.
> 
>   - It requires us to sort the entries by their pack offset. This is implemented
>     in sort_revindex() using a radix sort, but still takes considerable time (as
>     benchmarks found in the second series demonstrate).
> 
> Both of these can be addressed by storing the reverse index in a new '.rev' file
> alongside the packs. This file is written once (during pack creation), and does
> not require sorting when accessed, since it is stored in a sorted order.

Even if these method calls do add a bit of overhead to each
access, it helps to not compute the table from scratch before
any access is possible.

This will be particularly valuable for operations that use only
a few position lookups, such as "is object A reachable from
commit C?"

Operations that iterate through every object in a bitmap are
more likely to notice a difference, but that will probably be
visible in the next series.

My comments on this series are very minor.

I made only one comment about "if (method() < 0)" versus
"if (method())" but that pattern appears in multiple patches.
_If_ you decide to change that pattern, then I'm sure you can
find all uses.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
