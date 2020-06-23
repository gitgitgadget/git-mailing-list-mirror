Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931AC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9052070E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj7a/mU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbgFWNrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732633AbgFWNrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 09:47:42 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA4C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 06:47:42 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x202so18890197oix.11
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qaf1SVWpGmo5XbY8OkBMgfkdfcJ4hRtaa7IV31tRgKE=;
        b=oj7a/mU7aT16KxXYUcMHF0OfcV6EvRoL/MQzZQeybNgicfEhANn9s2FGGF9JCuHHel
         KcOlKP0w/d3Wd2k/WXgeo0pPOvtX8wWSV3L0Szc1TvcbW7utTd3J9+KrIsciY76ZtfTJ
         S4zz1SlqkBssoeE/8yFTN6r97WE20VX/LH3vz/Gn4HtmUFyPPciTSwYgD167k+zMp8mW
         w6adTV5NF5tibnbdMR8IY5aKcThRO2tA9aPwxUHXnWhKI1r19o/RT7BbHRCa/Vxg/hs2
         w2r4CFOWXfjxOFuoqQevq+ljqq9RbZ4L8yODjWuhBF+QIFs/Og+TijQDlR5WiUP+YZcX
         QISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaf1SVWpGmo5XbY8OkBMgfkdfcJ4hRtaa7IV31tRgKE=;
        b=JK/HSTY+wGhEHBYHPGhgxzdBRNpAS/L7RQcrimLl26HcT5ASnnacwJKZNR6ckn2N7H
         mTO2t1DU/ogSBnG8QmkpQpEa9rJXuiqsoYTODzKXcIjW+tgFWW3vNDcO+D+KeAAMS6m8
         l6ixK6NY99Pe+w8t/uT82OjVM6UhRb/JWazJV8z0uE8FOELm+UYfmABO7neLGKP1XWe9
         Er6wW/tzwu2peWUQfNdNFlOxhwY8SH7MFbZqwxbLz8Wmw4thDtYmhxI3QYNVZJPx+Fvt
         DAYW8NoNF7P4GhDHq/PzpuPKTaru7FTQZ9MuCznqj8NOvdHPJLlOTAIQaMg/kg7cS+c9
         A60A==
X-Gm-Message-State: AOAM530oOV2XPAaae4nSewtLXyocaEefD1uPdxC3tDgIJWlnaC8XYqPp
        89IE+tGzTQoscqETSxthFgI=
X-Google-Smtp-Source: ABdhPJwvVH45HxbvorKs5wjY+aW35jNva0fFXb+LVvON6yS88UCYCKRkuHR3nJaEcuPHXxr+OxkhKQ==
X-Received: by 2002:aca:b108:: with SMTP id a8mr16691742oif.21.1592920062005;
        Tue, 23 Jun 2020 06:47:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f30sm4030828oij.45.2020.06.23.06.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 06:47:41 -0700 (PDT)
Subject: Re: [PATCH 5/8] commit-graph: check all leading directories in
 changed path Bloom filters
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <9975fc96f1269b049ebdd54835a63480c3dcbe4e.1592252093.git.gitgitgadget@gmail.com>
 <20200619171717.GA55911@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b6a748d0-0fd8-5d43-012d-fabeff75ff31@gmail.com>
Date:   Tue, 23 Jun 2020 09:47:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200619171717.GA55911@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2020 1:17 PM, Taylor Blau wrote:
> Hi Stolee,
> 
> On Mon, Jun 15, 2020 at 08:14:50PM +0000, SZEDER Gábor via GitGitGadget wrote:
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
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  revision.c           | 35 ++++++++++++++++++++++++++---------
>>  revision.h           |  6 ++++--
>>  t/t4216-log-bloom.sh |  2 +-
>>  3 files changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index c644c660917..027ae3982b4 100644
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
>> +	int path_component_nr = 0, j;
>>
>>  	if (!revs->commits)
>>  		return;
>> @@ -705,8 +706,22 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>>
>>  	len = strlen(path);
>>
>> -	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
>> -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
>> +	p = path;
>> +	do {
>> +		p = strchrnul(p + 1, '/');
>> +		path_component_nr++;
>> +	} while (p - path < len);
>> +
>> +	revs->bloom_keys_nr = path_component_nr;
>> +	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
>> +
>> +	p = path;
>> +	for (j = 0; j < revs->bloom_keys_nr; j++) {
>> +		p = strchrnul(p + 1, '/');
>> +
>> +		fill_bloom_key(path, p - path, &revs->bloom_keys[j],
>> +			       revs->bloom_filter_settings);
>> +	}
>>
> 
> Somewhat related to our off-list discussion yesterday, there is a bug in
> both 2.27 and this patch which produces incorrect results when (1)
> Bloom filters are enabled, and (2) we are doing a revision walk from
> root with the pathspec '.'.
> 
> What appears to be going on is that our normalization takes '.' -> '',
> and then we form a Bloom key based on the empty string, which will
> return 'definitely not' when querying the Bloom filter some of the time,
> which should never happen. This is a consequence of never inserting the
> empty key into the Bloom filter upon generation.
> 
> As a result, I have patched this in GitHub's fork (which is currently
> based on 2.27 and doesn't have these patches yet) by doing an early
> return when 'strlen(path) == 0'. Since it looks like these patches are
> going to land, here is some clean-up and a fix for the bug that you
> should feel free to test with and apply on top:
> 
> --- >8 ---
> 
> diff --git a/revision.c b/revision.c
> index 8bd383b1dd..123e72698d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -670,10 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
>         struct pathspec_item *pi;
>         char *path_alloc = NULL;
> -       const char *path, *p;
> +       char *path, *p;
>         int last_index;
>         size_t len;
> -       int path_component_nr = 0, j;
> +       int path_component_nr = 1, j;
> 
>         if (!revs->commits)
>                 return;
> @@ -698,29 +698,33 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
> 
>         /* remove single trailing slash from path, if needed */
>         if (pi->match[last_index] == '/') {
> -           path_alloc = xstrdup(pi->match);
> -           path_alloc[last_index] = '\0';
> -           path = path_alloc;
> -       } else
> -           path = pi->match;
> +               path_alloc = xstrdup(pi->match);
> +               path_alloc[last_index] = '\0';
> +               path = path_alloc;
> +       } else {
> +               path = pi->match;
> +               len = pi->len;
> +       }
> 
> -       len = strlen(path);
> +       if (!len)
> +               return;
> 
> -       p = path;
>         do {
> -               p = strchrnul(p + 1, '/');
> -               path_component_nr++;
> -       } while (p - path < len);
> +               if (is_dir_sep(*p)) {
> +                       *p = '\0';
> +                       path_component_nr++;
> +               }
> +       } while (*p++);
> 
>         revs->bloom_keys_nr = path_component_nr;
>         ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
> 
>         p = path;
>         for (j = 0; j < revs->bloom_keys_nr; j++) {
> -               p = strchrnul(p + 1, '/');
> -
> -               fill_bloom_key(path, p - path, &revs->bloom_keys[j],
> +               size_t plen = strlen(p);
> +               fill_bloom_key(p, plen, &revs->bloom_keys[j],
>                                revs->bloom_filter_settings);
> +               p += plen;

I don't think this is correct at all. Looking at it, it seems
that it would take a path "A/B/C" and add keys for "A", "B", and
"C" instead of "A", "A/B", and "A/B/C".

Looking more closely, there are a few issues that makes it clear
why you didn't see a failing test:

1. You use "while (*p++)" instead of "while (*++p)" so the scan
   terminates after the first directory split. (So only "A" is
   added, which won't fail, but will be slower than intended.)

Changing that, we see the next problem:

2. You use "p += plen" instead of "p += plen + 1". This causes
   the filters to add "A", "", and "" (because we don't skip the
   terminating character). This _is_ incorrect and would result
   in test failures.

Changing that, we then see "A", "B", and "C" are added as keys.

I'm going to take the style issues that you presented, and
change them in one commit (reported-by you) and then the
if (!len) fix in a separate patch.

I'll update the scan loops to use is_dir_sep() accordingly
in this patch.

Thanks,
-Stolee
