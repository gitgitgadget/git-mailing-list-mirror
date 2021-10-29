Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D41BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2310E60FF2
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhJ2TCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJ2TCe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 15:02:34 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907EC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:00:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w8so10033206qts.4
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wle5Csonn6fJtQpgEcUeh0f43nOr7eYf0CbOBgUwC3s=;
        b=VXQ06vgVHf0QLOoI90TRe9t4fsIQipDsnOL/U7Q9+PpqVJaGwobClEv5P9KK1HHo79
         zGtQK9cKeOcIZklOsf5BZckD5zOO/+QUHK3HVvoBx4sIQZkz60fOqHeJbPerT3UVn2sj
         fUs/7r5IxctHUOE3/VAMVHesyCTK4BoZq3FccPisvPQ9zkEpmHjboYyGRQUzSDnZgrDK
         Uox9SsT6UJHwN1eQOiwP+c6f6ichKIG/1Rdt8VmpJv8NbRCAN69zvLvcoTHFrQilbvVJ
         Nx9e/IpOSay9wgrzWxUxTesTpGXTG2zNgOx8bzl7w7S0CtFLHhAaUcB004wQ9qCwu5jV
         fYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wle5Csonn6fJtQpgEcUeh0f43nOr7eYf0CbOBgUwC3s=;
        b=g82m3uCTPH4yg+TzaAS+4QAlNXa7crOLu/AlxMhsulfqeaM8PjcWEbN1o/393q6cJu
         NoBY3yHDhfEnkhcblqAjXYDo0ZKVSdEyFYecH6/xcClbeS0HCQ/DF7Wz5HCZHBqLeiaY
         uzhFj4a6bRJ1mZRCMHXrAqRPzLKNrMMyxlmDdSebHn4IxrwV1KWqoRx9i4SNPf6aDjX6
         rpTFLRp9Shu5gOXUJrw2Utx/TGT9JdGKbGwO5rvBadMrPbDgtYkivx0Wmnl93IDOIwt0
         aP9lQxAFLP+m/AUp24IjJHrS71kRaXeccJSo8w/Dj9ErSleO0uFAqNRc50l8kj4NHOuk
         4Djg==
X-Gm-Message-State: AOAM532xgTv3z2cd7eUqsnX1MgQ6rJvbqA3+VUiUFdEKU/DqPHUr8ypC
        fc1zOtbys+WgzIsNSyKN8PA=
X-Google-Smtp-Source: ABdhPJzrwcmQBUWoptfJczMWv5lLJ+0CCwykWfwbuqQyX/qn+qdpTd52xJSCUh5hkAgFJbD3raa9Gg==
X-Received: by 2002:ac8:7294:: with SMTP id v20mr13586419qto.51.1635534004116;
        Fri, 29 Oct 2021 12:00:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6463:ee8f:8638:ff1b? ([2600:1700:e72:80a0:6463:ee8f:8638:ff1b])
        by smtp.gmail.com with ESMTPSA id b19sm4906910qtb.64.2021.10.29.12.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 12:00:03 -0700 (PDT)
Message-ID: <006b1747-fc6b-61e4-7ce9-f0a6687ddd8f@gmail.com>
Date:   Fri, 29 Oct 2021 15:00:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 2/4] sparse-index: avoid unnecessary cache tree
 clearing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
 <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
 <91351ac4bded2c19264cd2009e90ee71fcf67b81.1635515487.git.gitgitgadget@gmail.com>
 <xmqqfssjllen.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfssjllen.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29/2021 2:45 PM, Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> When converting a full index to sparse, clear and recreate the cache tree
>> only if the cache tree is not fully valid. The convert_to_sparse operation
>> should exit silently if a cache tree update cannot be successfully completed
>> (e.g., due to a conflicted entry state). However, because this failure
>> scenario only occurs when at least a portion of the cache tree is invalid,
>> we can save ourselves the cost of clearing and recreating the cache tree by
>> skipping the check when the cache tree is fully valid.
> 
> I see in cache-tree.c::update_one() this snippet of code.
> 
> 	/*
> 	 * If the first entry of this region is a sparse directory
> 	 * entry corresponding exactly to 'base', then this cache_tree
> 	 * struct is a "leaf" in the data structure, pointing to the
> 	 * tree OID specified in the entry.
> 	 */
> 	if (entries > 0) {
> 		const struct cache_entry *ce = cache[0];
> 
> 		if (S_ISSPARSEDIR(ce->ce_mode) &&
> 		    ce->ce_namelen == baselen &&
> 		    !strncmp(ce->name, base, baselen)) {
> 			it->entry_count = 1;
> 			oidcpy(&it->oid, &ce->oid);
> 			return 1;
> 		}
> 	}
> 
> Sorry for not noticing it earlier, but does this mean that the
> content of a cache-tree changes shape when sparse-ness of the index
> changes?  Is a cache-tree that knows about all of the
> subdirectories, even the ones that are descendants of a directory
> that is represented as a tree-ish entry in the main index array,
> still valid in a sparse index?
> 
> If not, then I do not think of a quick and sure way to ensure that
> the cache-tree is valid when the sparse-ness changes.
> 
> The earlier suggestion was based on my assumption that even when the
> main index array becomes sparse, the cache tree is still populated
> and valid, so that after writing a tree and writing an on-disk index,
> and then reading the on-disk index back (possibly in another process),
> would not have to incur the recomputation cost of the full tree when
> the reading codepath needs to flip the sparseness.
>
> But the above code snippet makes me worried a lot.  A cache-tree
> that used to be valid when the corresponding in-core index array was
> not sparse will become invalid immediately when we decide to make it
> sparse, right?

I think I would argue that the cache-tree is valid in this case. Each
node represents the tree that would be created from that region of the
index if we called 'git commit'. We can reconstruct the contained
subtrees by walking trees if necessary, but that isn't necessary at
this point.

I am writing a blog post about the sparse index, and I go into detail
about how the cache tree is modified. I use the
derrickstolee/trace-flamechart repo [1] as an example, so I will use
it as a concrete discussion of what is happening here.

Here is the cache-tree without sparse-index:

 [ root (left: 0, size: 16) ]
  |
  +---- [ bin/ (left: 2, size: 1) ] 
  |
  +---- [ examples/ (left: 3, size: 11) ]
        |
        +---- [ fetch/ (left: 3, size: 8) ]
        |
        +---- [ maintenance/ (left: 11, size: 3) ]

Then, I run

	git sparse-checkout init --cone --sparse-index
	git sparse-checkout set bin

the cache-tree looks like this:

 [ root (left: 0, size: 6) ]
  |
  +---- [ bin/ (left: 2, size: 1) ] 
  |
  +---- [ examples/ (left: 3, size: 1) ]

The tree OIDs at each of "root", "bin" and "examples" match the trees
for the nodes in the non-sparse cache tree.

By contrast, including any subtrees of "examples" would cause a few
things to happen:

1. The size of the cache-tree would increase (significantly in large
   repos).

2. The contained cache-tree nodes would have size _zero_, since there
   are no cache entries defined within their directories.

I think in this pruned form, the cache-tree is valid and serves all of
the roles it was designed for. We can quickly compute the root tree in
'git commit'. We can navigate the cache-tree in traverse_by_cache_tree()
to accurately describe the trees in the index. These things are tested
in t1092 and the p2000 performance test.

Does this satisfy your concern, or is there a larger expectation of the
cache-tree extension that I am not taking into account?

Thanks,
-Stolee
