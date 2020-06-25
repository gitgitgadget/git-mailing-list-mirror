Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC3C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEBE206C0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1aZxsD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405591AbgFYPFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405405AbgFYPFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 11:05:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDEEC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 08:05:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g11so2917035qvs.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oaTqM35jM7exwPitjIIUDd4k9Ae/Ge4Var7LP0Qxs8s=;
        b=N1aZxsD6dvGrdaRjR7M2qm+Ffkn2o9I+i7bKQfmn1LKKnJXo6l98v0V7Z/BCC39AtL
         zNNp/B+ixSkBWV42cNIg2XZuzQOcKAWTg9eaQ1gGyoKvS2z1kP0zzCFY4fKosB8OEiz2
         q1n4y1C7HD43xJvPuFdVGP2TIlzgLIXI0/PiuMYUdRTOhEWvJFf96VIXJzDL2nhUYuW1
         eH7ZauMvIaPUiVkjK/VWqZvm/aNXDVdxbnyTzHw87zv5nLu4IKsX/01o0BTlIyjQGKna
         RK+HdpDJxNsYbAxp14q0aesa1IOocjNLh+GN2igQ5LpcxMnUV9JBd8UaUinOdkaq+HVE
         Q0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaTqM35jM7exwPitjIIUDd4k9Ae/Ge4Var7LP0Qxs8s=;
        b=hrCiETH1Pk+xQNvcii7d1isAhJtU62tobDdakztLIDNlGy5WRm45j4FvQLX4EcW/+K
         AZEUnczEZQ7oG4aAPiF/1VtMJOqaVTiJQgHF56tmmNAoPSeva832vdtmr3UY3MiU148+
         LWoQKTZ6oz5OX4LNMUsLgp48uO2bpY2E7yHLPvrVZ7b659dNFPZ30NcOgjxkspk+LR+2
         Q0yFFwVrCfjDifjmRPx0xWNwNiJ1OLm92t1Tj9lhHRJtH0RJ/86/6r9Hbzqe70ngQoQ1
         DCf3NXM5bhe6sCIKu2cXBmc65fB7pRSx4sNwbP/BEKw88NcsWAqWxg5sA0J21PeQdyky
         AE8g==
X-Gm-Message-State: AOAM532H9L8+jZZUo6m0fvdhpZUyrnhb5VPE2uJzSMmGnPm3cWs5rheq
        /g9QP9Iam4o5fACPWeUYf/s=
X-Google-Smtp-Source: ABdhPJz2jq3BrX4QssSfHdudUVt9IlAUykbHoDoECgaiSbgsk28CIdrfnuELv5cSa0hCDDCeciVrag==
X-Received: by 2002:a0c:f109:: with SMTP id i9mr22093887qvl.154.1593097505140;
        Thu, 25 Jun 2020 08:05:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l67sm5907276qkd.7.2020.06.25.08.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:05:04 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] commit-graph: check all leading directories in
 changed path Bloom filters
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <9c2076b4ce46918fce8f05e609b057611ec56e13.1592934430.git.gitgitgadget@gmail.com>
 <8d8b1763-bbf3-682e-0649-f5a0885399e6@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0fe96c75-2946-8160-2ced-3d9781dca8c0@gmail.com>
Date:   Thu, 25 Jun 2020 11:05:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <8d8b1763-bbf3-682e-0649-f5a0885399e6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2020 3:25 AM, René Scharfe wrote:
> Am 23.06.20 um 19:47 schrieb SZEDER Gábor via GitGitGadget:
>> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>>
>> The file 'dir/subdir/file' can only be modified if its leading
>> directories 'dir' and 'dir/subdir' are modified as well.
>>
>> So when checking modified path Bloom filters looking for commits
>> modifying a path with multiple path components, then check not only
>> the full path in the Bloom filters, but all its leading directories as
>> well.  Take care to check these paths in "deepest first" order,
>> because it's the full path that is least likely to be modified, and
>> the Bloom filter queries can short circuit sooner.
>>
>> This can significantly reduce the average false positive rate, by
>> about an order of magnitude or three(!), and can further speed up
>> pathspec-limited revision walks.  The table below compares the average
>> false positive rate and runtime of
>>
>>   git rev-list HEAD -- "$path"
>>
>> before and after this change for 5000+ randomly* selected paths from
>> each repository:
>>
>>                     Average false           Average        Average
>>                     positive rate           runtime        runtime
>>                   before     after     before     after   difference
>>   ------------------------------------------------------------------
>>   git             3.220%   0.7853%     0.0558s   0.0387s   -30.6%
>>   linux           2.453%   0.0296%     0.1046s   0.0766s   -26.8%
>>   tensorflow      2.536%   0.6977%     0.0594s   0.0420s   -29.2%
>>
>> *Path selection was done with the following pipeline:
>>
>> 	git ls-tree -r --name-only HEAD | sort -R | head -n 5000
>>
>> The improvements in runtime are much smaller than the improvements in
>> average false positive rate, as we are clearly reaching diminishing
>> returns here.  However, all these timings depend on that accessing
>> tree objects is reasonably fast (warm caches).  If we had a partial
>> clone and the tree objects had to be fetched from a promisor remote,
>> e.g.:
>>
>>   $ git clone --filter=tree:0 --bare file://.../webkit.git webkit.notrees.git
>>   $ git -C webkit.git -c core.modifiedPathBloomFilters=1 \
>>         commit-graph write --reachable
>>   $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/info/
>>   $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=1 \
>>         rev-list HEAD -- "$path"
>>
>> then checking all leading path component can reduce the runtime from
>> over an hour to a few seconds (and this is with the clone and the
>> promisor on the same machine).
>>
>> This adjusts the tracing values in t4216-log-bloom.sh, which provides a
>> concrete way to notice the improvement.
>>
>> Helped-by: Taylor Blau <me@ttaylorr.com>
>> Helped-by: René Scharfe <l.s.r@web.de>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  revision.c           | 41 ++++++++++++++++++++++++++++++++---------
>>  revision.h           |  6 ++++--
>>  t/t4216-log-bloom.sh |  2 +-
>>  3 files changed, 37 insertions(+), 12 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index b53377cd52..077888ee51 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>>  {
>>  	struct pathspec_item *pi;
>>  	char *path_alloc = NULL;
>> -	const char *path;
>> +	const char *path, *p;
>>  	int last_index;
>> -	int len;
>> +	size_t len;
>> +	int path_component_nr = 1;
>>
>>  	if (!revs->commits)
>>  		return;
>> @@ -709,8 +710,28 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>>  		return;
>>  	}
>>
>> -	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
>> -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
>> +	p = path;
>> +	while (*p) {
>> +		if (is_dir_sep(*p))
>> +			path_component_nr++;
>> +		p++;
>> +	}
>> +
>> +	revs->bloom_keys_nr = path_component_nr;
>> +	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
>> +
>> +	fill_bloom_key(path, len, &revs->bloom_keys[0],
>> +		       revs->bloom_filter_settings);
>> +	path_component_nr = 1;
>> +
>> +	p = path + len - 1;
> 
> len cannot be 0 at this point, as patch 9 made sure, so this is safe.
> Good.
> 
>> +	while (p > path) {
>> +		if (is_dir_sep(*p))
>> +			fill_bloom_key(path, p - path,
>> +				       &revs->bloom_keys[path_component_nr++],
>> +				       revs->bloom_filter_settings);
>> +		p--;
>> +	}
> 
> This walks the directory hierarchy upwards and adds bloom filters for
> shorter and shorter paths, ("deepest first").  Good.
> 
> And it supports all directory separators.  On Windows that would be
> slash (/) and backslash (\).  I assume paths are normalized to use
> only slashes when bloom filters are written, correct?  Then the lookup
> side needs to normalize a given path to only use slashes as well,
> otherwise paths with backslashes cannot be found.  This part seems to
> be missing.

Yes, that's a good point. We _require_ the paths to be normalized
here to be Unix-style paths or else the Bloom filter keys are
incorrect. Thankfully, they are. Let's make that clear in-code by
using '/' instead of is_dir_sep().

Thanks,
-Stolee
