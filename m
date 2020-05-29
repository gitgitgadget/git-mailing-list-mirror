Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26752C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9481205CB
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNAt2QzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgE2NfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgE2NfT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:35:19 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAFC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:35:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 205so2167587qkg.3
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JrvX5g8eT40Izp2qVA/yDjqKHm8js5rlRfrMvqaiuC8=;
        b=XNAt2QzUj7wTSDxvTQgx/LYpIt6QkNvFZYFGjRiYfw/tbKQ5JzIV5XvkT51TZo0hCO
         6dABeaQwjVVcLO17kEPAwfTPv9IWS8u++7KAShfRwi08cEGAQ4qvdsvgJsPwftAFlcvL
         xRxnTUt84bhaztnZxYWLA7GcJIOMGgLf5l/S9mZkHJ3WGSqArzv7pKoQxU8l0/Jj9kcT
         ssoTrQY48aoTHpTZp3Xri4cJJmikJrcj8WzcKPD805pzWiwfRaL7JzFEiQUygvWPk3re
         b3kQAk3c+mUiuEACy8JbkLER+0HN9bXXRCb7CaSvzTpT+pOLAtOcJrFB+ssBEvMrdd2S
         NAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JrvX5g8eT40Izp2qVA/yDjqKHm8js5rlRfrMvqaiuC8=;
        b=jwcPgIJbTzORTkmOBvLQYvpX6QH4pMJaJJm351MeRvlb9PrGQTiOMJGHu4msZyb2e2
         EZUL6go2Qb8eIscY1r60T65XID3Svpfa42NmkSfV6xMM12rmL6xDX8u/bEzgE7dpNT4T
         VGFD02HxoFQer9Ur5eXUuCMG3ciJo1nm9qqRikUMTeXOyU1iebcRY58lP/mIO/8pOW5Y
         0JX1cYl0Fl3myj0KvDyYB/iyw9kw+xWeASE9SZsBUXLmgw6lT7A4Yzsx5OsUYOsx6UUP
         5nXbn9L6kWbgPO9/S0dqajNlJywQ6xzMibxYo/35qJR8giLJiNOyW8Zq1bw9kLHDstqe
         8VKg==
X-Gm-Message-State: AOAM532B2b0IZGDqmxl/qldOd7kbsSXiyRiDQ7raQqcCQRgY7J1kPu0o
        UCVaI2gM2M1hSA+/pJwAu/Y=
X-Google-Smtp-Source: ABdhPJwnE1BnZNdBYOpS51eoLkf13nQjsxvFv0rq20eujUyDBjBpFS6AWu7hB1jFaptNDsQYFBgwKA==
X-Received: by 2002:a37:50c2:: with SMTP id e185mr6007074qkb.140.1590759318167;
        Fri, 29 May 2020 06:35:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m10sm7853755qtg.94.2020.05.29.06.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 06:35:17 -0700 (PDT)
Subject: Re: [PATCH v4 09/15] commit-graph: write Bloom filters to commit
 graph file
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
 <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
 <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
 <20200529085721.GA25128@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <72cff41c-bb2e-5f87-5db6-d4e9ead25a47@gmail.com>
Date:   Fri, 29 May 2020 09:35:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200529085721.GA25128@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2020 4:57 AM, SZEDER Gábor wrote:
> On Mon, Apr 06, 2020 at 04:59:49PM +0000, Garima Singh via GitGitGadget wrote:
>> From: Garima Singh <garima.singh@microsoft.com>
>>
>> Update the technical documentation for commit-graph-format with
>> the formats for the Bloom filter index (BIDX) and Bloom filter
>> data (BDAT) chunks. Write the computed Bloom filters information
>> to the commit graph file using this format.
>>
>> Helped-by: Derrick Stolee <dstolee@microsoft.com>
>> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
>> ---
>>  .../technical/commit-graph-format.txt         |  30 +++++
>>  commit-graph.c                                | 113 +++++++++++++++++-
>>  commit-graph.h                                |   5 +
>>  3 files changed, 147 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
>> index a4f17441aed..de56f9f1efd 100644
>> --- a/Documentation/technical/commit-graph-format.txt
>> +++ b/Documentation/technical/commit-graph-format.txt
>> @@ -17,6 +17,9 @@ metadata, including:
>>  - The parents of the commit, stored using positional references within
>>    the graph file.
>>  
>> +- The Bloom filter of the commit carrying the paths that were changed between
>> +  the commit and its first parent, if requested.
>> +
>>  These positional references are stored as unsigned 32-bit integers
>>  corresponding to the array position within the list of commit OIDs. Due
>>  to some special constants we use to track parents, we can store at most
>> @@ -93,6 +96,33 @@ CHUNK DATA:
>>        positions for the parents until reaching a value with the most-significant
>>        bit on. The other bits correspond to the position of the last parent.
>>  
>> +  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
>> +    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
> 
> This is inconsistent with the implementation: according to the code in
> one of the previous patches these entries are simple byte offsets, not
> 8-byte word offsets, i.e. the combined size of all modified path
> Bloom filters can be at most 2^32 bytes.

The documentation was fixed in 88093289cdc (Documentation: changed-path Bloom
filters use byte words, 2020-05-11).

> The commit-graph file can contain information about at most 2^31-1
> commits.  This means that with that many commits each commit can have
> a merely 2 byte Bloom filter on average.  When using 7 hashes we'd
> need 10 bits per path, so in two bytes we could store only a single
> path.
> 
> Clearly, using 4 byte index entries significantly lowers the max
> number of commits that can be stored with modified path Bloom filters.

This is a good point, and certainly the reason for 8-byte multiples.

> IMO every new chunk must support at least 2^31-1 commits.

I'm not sure this is a valid requirement. Even extremely large repositories
(that are created by actual use, not synthetic) are on the scale of 2^24
commits.

You are right that we should make the commit-graph write process more robust
to reaching these limits. You point out that we have a new limit when these
filters are enabled.

For reference, the Windows OS repo has ~4.25 million commits and the
commit-graph file with changed-path Bloom filters is around 520mb. That's
the whole file size, and without the filters it's around 240mb, so the
filters are taking <300mb ~ 2^29 and we would need to grow the repo by 8x
to hit this limit. That's not an unreasonable amount of growth, but is
also far enough away that we can handle it in time.

The incremental commit-graph can actually save us here (and is similar to
how we solved a scale issue in Azure Repos around the multi-pack-index):
we can refuse to merge layers of an incremental commit-graph if the
changed-path filters would exceed the size limit. Of course, the _first_
write of such a commit-graph would need to be aware of this limit and
plan for it in advance, but that's also a theoretical issue.

I'm tracking some follow-up work [1] for the changed-path filters,
including a way to limit the number of filters computed in one
"git commit-graph write" process. I'll make note of your concerns here,
too.

[1] https://github.com/microsoft/git/issues/272

>> +      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
>> +      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
>> +      BIDX[i] (plus header length), where BIDX[-1] is 0.
>> +    * The BIDX chunk is ignored if the BDAT chunk is not present.
>> +
>> +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
>> +    * It starts with header consisting of three unsigned 32-bit integers:
>> +      - Version of the hash algorithm being used. We currently only support
>> +	value 1 which corresponds to the 32-bit version of the murmur3 hash
>> +	implemented exactly as described in
>> +	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
>> +	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
>> +	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
>> +	in Probabilistic Verification"
> 
> How should double hashing compute the k hashes, i.e. using 64 bit or
> 32 bit unsigned integer arithmetic?
> 
> I'm puzzled that you link to this paper and still use double hashing.
> 
> Two of the contributions of that paper are that it points out some
> shortcomings of the double hashing scheme and provides a better
> alternative in the form of enhanced double hashing, which can cut the
> false positive rate in half.
> 
> However, that paper considers the hashing scheme only in the context
> of one big Bloom filter.  I've found that when it comes to many small
> Bloom filters then the k hashes produced by any double hashing variant
> are not independent enough, and "standard" double hashing fares the
> worst among them.  There are real repositories out there where double
> hashing has over an order of magnitude higher average false positive
> rate than enhanced double hashing.  Though that's not to say that
> enhanced double hashing is good...
> 
> For details on these issues see
> 
>   https://public-inbox.org/git/20200529085038.26008-16-szeder.dev@gmail.com

That message includes very detailed experimental analysis, which is nice.
We will need to do some concrete side-by-side comparisons to see if there
actually is a meaningful difference. (You may have already done this.)

>> +      - The number of times a path is hashed and hence the number of bit positions
>> +	      that cumulatively determine whether a file is present in the commit.
>> +      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
>> +	      contains 'n' entries, then the filter size is the minimum number of 64-bit
>> +	      words that contain n*b bits.
> 
> Since the ideal number of bits per element depends only on the number
> of hashes per path (k / ln(2) ≈ k * 10 / 7), why is this value stored
> in the commit-graph?

The ideal number depends also on what false-positive rate you want. In a
hypothetical future where we want to allow customization here, we want
the filters to be consistently sized across all filters.

>> +    * The rest of the chunk is the concatenation of all the computed Bloom
>> +      filters for the commits in lexicographic order.
>> +    * Note: Commits with no changes or more than 512 changes have Bloom filters
>> +      of length zero.
> 
> What does this "Note:" prefix mean in the file format specification?
> 
> Can an implementation use a one byte Bloom filter with no bits set for
> a commit with no changes?  Can an implementation still store a Bloom
> filter for commits that modify more than 512 paths?

This is currently due to a hard-coded value in the implementation. It's not a
requirement of the file format.

>> +    * The BDAT chunk is present if and only if BIDX is present.
>> +
>>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>>        This list of H-byte hashes describe a set of B commit-graph files that
>>        form a commit-graph chain. The graph position for the ith commit in this
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 732c81fa1b2..a8b6b5cca5d 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
> 
>> @@ -1034,6 +1071,59 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
>>  	}
>>  }
>>  
>> +static void write_graph_chunk_bloom_indexes(struct hashfile *f,
>> +					    struct write_commit_graph_context *ctx)
>> +{
>> +	struct commit **list = ctx->commits.list;
>> +	struct commit **last = ctx->commits.list + ctx->commits.nr;
>> +	uint32_t cur_pos = 0;
>> +	struct progress *progress = NULL;
>> +	int i = 0;
>> +
>> +	if (ctx->report_progress)
>> +		progress = start_delayed_progress(
>> +			_("Writing changed paths Bloom filters index"),
>> +			ctx->commits.nr);
>> +
>> +	while (list < last) {
>> +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
>> +		cur_pos += filter->len;
> 
> Given a sufficiently large number of commits with large enough Bloom
> filters this will silently overflow.

Worth fixing, but we are not in a rush. I noted it in my GitHub issue.

Thanks,
-Stolee

