Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50680C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E095F2078D
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDKBQV+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgIKSPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIKSPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:15:22 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC779C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:15:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so8547767qtp.13
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svI2MYv8lXZhzp8Lgo7432pLdEWdSOMzrk9KH3pxC6I=;
        b=GDKBQV+/QuXWFlMutLZBSkv8o/z8lm2zAF6/nrCs+a2E/PjazMRU7ek3wtwlPcbr+E
         uBTiCBWkWgZIktu8Y4OQ0xd5ZD0HSlCB83xXKJzxC9gbcv7LdEz4ScAabpPl2Cxl+RH9
         6ysnjgiMFn82sZdHFYL0XUbWr0SsogQUqk1yg08Hqi08MLvxqIBkuP4vZhQn2qLXQFsd
         FO4B+wSgkn8U4Sec+6k1NVYn7AUAOXGaRCRzWzDRPpydXXuE2EAnbE3mDygdMnu+Ejt1
         Lwoe7T8vsrucIUSGNfjEjOZAHjpBuekWu7eO0guUfRero27/bRCxWeaIZiRPzcIPLS/5
         xKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svI2MYv8lXZhzp8Lgo7432pLdEWdSOMzrk9KH3pxC6I=;
        b=Og5JKO+T1h0dlRuluF0WOJfu0I7R+kQ1cqmBD+plneyFM3Qs65c3oj0T6Jwr0Afy+z
         mU2p95HB29oRnmHep1vFSQ816sB+smzZtnEbqiPXKmFodAlXwBd9sYIfdHfiikT88K0A
         Xvb15EaGJ/BwW2GJO5QRSkdTFTd9btcmmHJyAQTdnhiBpWB3xCeSK+c4qh0ZcWKVgBqu
         qpZF1vZQzaOhbLOib2iPb0ZrhwnmmmiCysa6wIvh6ehem5Cj/OtyFMiO8qHnZTl+U3Mi
         bqpnMMWzfwyPpMwHb5v3Cou1+3k/ou7lgZBJXOn1nG1kAGF/x9oxVUMOqH47kp5W+BeM
         uIzg==
X-Gm-Message-State: AOAM530XjFEm7B40HVUuY5VDihTIynSn1P2RJ4bzTjPapA5z/1GRf4Zw
        ZdhL9tIZQhfEfgGWEpVk114=
X-Google-Smtp-Source: ABdhPJza/GRs7WktgYarxANLfSaSGHt8oz7PgmRp60mt4XZy8HxfRejI8GJvxpsawRLZe3u6Y2r58g==
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr3137758qto.36.1599848119983;
        Fri, 11 Sep 2020 11:15:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id m64sm3684316qkd.80.2020.09.11.11.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:15:19 -0700 (PDT)
Subject: Re: [PATCH 10/12] bloom: encode out-of-bounds filters as non-empty
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1599664389.git.me@ttaylorr.com>
 <1c993b83980e77594b0de2b1884cbc4cf484f9ab.1599664389.git.me@ttaylorr.com>
 <20200910033557.GA2178@nand.local> <20200910154516.GA32117@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee881087-76b7-901d-d75c-814ad508f90d@gmail.com>
Date:   Fri, 11 Sep 2020 14:15:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200910154516.GA32117@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/10/2020 11:45 AM, Taylor Blau wrote:
> On Wed, Sep 09, 2020 at 11:35:57PM -0400, Taylor Blau wrote:
>> On Wed, Sep 09, 2020 at 11:23:48AM -0400, Taylor Blau wrote:
>>> -		filter->data = NULL;
>>> -		filter->len = 0;
>>> +		filter->data = xmalloc(1);
>>> +		filter->data[0] = 0xFF;
>>> +		filter->len = 1;
>>>
>>>  		if (computed)
>>>  			*computed |= BLOOM_TRUNC_LARGE;
>>
>> Oops, I missed the case that added by the previous patch where the
>> number of diff entries is smaller than the limit, but the hashmap
>> entries (after directories are added and such) crosses the threshold.
>>
>> Specifically, this patch doesn't write the 0xFF filter like it should.
>> I'll send a different version of this patch tomorrow.
> 
> This one should do the trick. Let's use it instead.
> 
> --- >8 ---
> 
> Subject: [PATCH] bloom: encode out-of-bounds filters as non-empty
> 
> When a changed-path Bloom filter has either zero, or more than a
> certain number (commonly 512) of entries, the commit-graph machinery
> encodes it as "missing". More specifically, it sets the indices adjacent
> in the BIDX chunk as equal to each other to indicate a "length 0"
> filter; that is, that the filter occupies zero bytes on disk.
> 
> This has heretofore been fine, since the commit-graph machinery has no
> need to care about these filters with too few or too many changed paths.
> Both cases act like no filter has been generated at all, and so there is
> no need to store them.
> 
> In a subsequent commit, however, the commit-graph machinery will learn
> to only compute Bloom filters for some commits in the current
> commit-graph layer. This is a change from the current implementation
> which computes Bloom filters for all commits that are in the layer being
> written. Critically for this patch, only computing some of the Bloom
> filters means adding a third state for length 0 Bloom filters: zero
> entries, too many entries, or "hasn't been computed".
> 
> It will be important for that future patch to distinguish between "not
> representable" (i.e., zero or too-many changed paths), and "hasn't been
> computed". In particular, we don't want to waste time recomputing
> filters that have already been computed.
> 
> To that end, change how we store Bloom filters in the "computed but not
> representable" category:
> 
>   - Bloom filters with no entries are stored as a single byte with all
>     bits low (i.e., all queries to that Bloom filter will return
>     "definitely not")
> 
>   - Bloom filters with too many entries are stored as a single byte with
>     all bits set high (i.e., all queries to that Bloom filter will
>     return "maybe").
> 
> These rules are sufficient to not incur a behavior change by changing
> the on-disk representation of these two classes. Likewise, no
> specification changes are necessary for the commit-graph format, either:
> 
>   - Filters that were previously empty will be recomputed and stored
>     according to the new rules, and
> 
>   - old clients reading filters generated by new clients will interpret
>     the filters correctly and be none the wiser to how they were
>     generated.
> 
> Clients will invoke the Bloom machinery in more cases than before, but
> this can be addressed by returning a NULL filter when all bits are set
> high. This can be addressed in a future patch.
> 
> Finally, note that this does increase the size of on-disk commit-graphs,
> but far less than other proposals. In particular, this is generally more
> efficient than storing a bitmap for which commits haven't computed their
> Bloom filters. Storing a bitmap incurs a penalty of one bit per commit,
> whereas storing explicit filters as above incurs a penalty of one byte
> per too-large or too-small commit.
> 
> In practice, these boundary commits likely occupy a small proportion of
> the overall number of commits, and so the size penalty is likely smaller
> than storing a bitmap for all commits.
> 
> A test to exercise filters which contain too many changed path entries
> will be introduced in a subsequent patch.
> 
> Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
> Suggested-by: Jakub Narębski <jnareb@gmail.com>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  .../technical/commit-graph-format.txt         |  2 +-
>  bloom.c                                       | 16 ++++++++++++--
>  bloom.h                                       |  1 +
>  commit-graph.c                                |  5 +++++
>  t/t0095-bloom.sh                              |  8 +++----
>  t/t4216-log-bloom.sh                          | 21 +++++++++++++++++--
>  6 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index 6ddbceba15..6585f1948a 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -125,7 +125,7 @@ CHUNK DATA:
>      * The rest of the chunk is the concatenation of all the computed Bloom
>        filters for the commits in lexicographic order.
>      * Note: Commits with no changes or more than 512 changes have Bloom filters
> -      of length zero.
> +      of length one, with either all bits set to zero or one respectively.
>      * The BDAT chunk is present if and only if BIDX is present.
> 
>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
> diff --git a/bloom.c b/bloom.c
> index db9fb82437..d24747a1d5 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -177,6 +177,13 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data,
>  	return strcmp(e1->path, e2->path);
>  }
> 
> +static void init_truncated_large_filter(struct bloom_filter *filter)
> +{
> +	filter->data = xmalloc(1);
> +	filter->data[0] = 0xFF;
> +	filter->len = 1;
> +}
> +

So this hunk is essentially the new bit in this version.

> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index 232ba2c485..7e4ab1795f 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -71,8 +71,8 @@ test_expect_success 'get bloom filters for commit with no changes' '
>  	git init &&
>  	git commit --allow-empty -m "c0" &&
>  	cat >expect <<-\EOF &&
> -	Filter_Length:0
> -	Filter_Data:
> +	Filter_Length:1
> +	Filter_Data:00|
>  	EOF
>  	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
>  	test_cmp expect actual
> @@ -107,8 +107,8 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
>  	git add bigDir &&
>  	git commit -m "commit with 513 changes" &&
>  	cat >expect <<-\EOF &&
> -	Filter_Length:0
> -	Filter_Data:
> +	Filter_Length:1
> +	Filter_Data:ff|
>  	EOF
>  	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
>  	test_cmp expect actual

And these two tests now show the new behavior. Nice.

This version matches my expectations. Thanks.

-Stolee
