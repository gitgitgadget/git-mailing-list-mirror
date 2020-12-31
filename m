Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A8C433E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E763A222F9
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 16:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgLaQrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 11:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgLaQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 11:47:04 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A67C061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 08:46:24 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b64so16672044qkc.12
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbbojLICyf7OD6uDEMDV2ZjuDO23iQXmp2ZFZ2Be4Ug=;
        b=g0RP3+zIMoIZa0j8HICHjllSvJ9t7ETkr9Kau7XlKQo35QhYdZAtHwqfmPAYj9mt+D
         obtxlYezEkKkmshTKYRj2lwnAAfEk4AX0PGQOdx8EQOLuuxwkB851D0NAzi9oPeR+zsw
         VV2GVxoKWIP6l5BRukFy3nz9oK+eETFPRpkr2RC2v92rPHdFLp729OyYUjKgdL1iWGbD
         RsufkVjC9Oqihw8lhXZlPh+txjfwNSRmLNQWIsv2LSltlL80RBa57HAh271ouovSUt7a
         xS/0hgqdAqRnKbJOOy5xTj+wLahyfoR6W8qQz7KrXjJOYoY/Hm94OeTaZL8/4iaeGQ9A
         ZzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbbojLICyf7OD6uDEMDV2ZjuDO23iQXmp2ZFZ2Be4Ug=;
        b=Fx0Rt2K++gRsnkHJGtrp/j5e3wAu6SyxWrqbU5fqytmNebkdXhS/SSnwuYTKJsnp0/
         6jmzPEOy5aRgMdhncAho060LIhxyWcVy99U8uAS96QqFX/HKuIIWtebAMc1kxQOTvq8x
         zLAJ9r3bXigkdVNqZG06/I/l4oSNCjQxDvM327pfTqOfPr2ZuymjiB4KKztJNpLhqoyJ
         m5WQFq7AYalUofuIZrsUSadvIbd+jmYNyBgazQDkuNdyJgdWn4W/PmsmngFaKZvhYxcK
         lKkoh7X9JWm3xjHpb3SSD699NoDgMt9oG64bMpf6LdwBZeBKe7TvveVywneMAuwc0hI3
         BhOQ==
X-Gm-Message-State: AOAM533E3Qi66eUY14eS82qkjB2LlwJphXqqGTYYdkq0pRFzPjaE8Pob
        PFLu7UU2vH9ENhj/Pi1dqAI=
X-Google-Smtp-Source: ABdhPJyOwCOsJjj5qVqEVXCoB+ka0dNDuYjy/e3J4hWQpFkSBzXTi4gEGIH3bc77hI5f/Z1f0O1+tA==
X-Received: by 2002:a37:e10c:: with SMTP id c12mr60006974qkm.265.1609433183080;
        Thu, 31 Dec 2020 08:46:23 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id w127sm29685438qkb.133.2020.12.31.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 08:46:21 -0800 (PST)
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
 <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
Date:   Thu, 31 Dec 2020 11:46:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2020 7:34 AM, René Scharfe wrote:
> Am 30.12.20 um 20:26 schrieb Derrick Stolee via GitGitGadget:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The verify_cache() method is used both for debugging issues with the
>> cached tree extension but also to avoid using the extension when there
>> are unmerged entries. It also checks for cache entries out of order with
>> respect to file-versus-directory sorting.
>>
>> In 996277c (Refactor cache_tree_update idiom from commit, 2011-12-06),
>> the silent option was added to remove the progress indicators from the
>> initial loop looking for unmerged entries. This was changed to be a flag
>> in e859c69 (cache-tree: update API to take abitrary flags, 2012-01-16).
>>
>> In both cases, the silent option is ignored for the second loop that
>> checks for file-versus-directory sorting. It must be that this loop is
>> intended only for debugging purposes and is not actually helpful in
>> practice.
> 
> So you're saying that the directory/file conflict check not honoring the
> WRITE_TREE_SILENT flag would have been noticed as a bug and therefore
> doesn't happen?
> 
> I'm not sure I can follow that logic.  I don't know how important that
> check is, how often it found a conflict and how likely such a find is
> overlooked or ignored, but disabling a check in silent mode that
> affects the return code instead of only suppressing its messages seems
> risky.
> 
> If we are sure that the check cannot trigger then we should remove it.
> If we are not so sure, but a conflict would be Git's fault (and not the
> user's) then we should always do the check and BUG out.  And otherwise
> we should keep it.

I think this method was originally designed for debugging issues with
the index, and it still serves that purpose when someone is working on
it. The check for out-of-order directory/file conflicts probably exists
only for that case.

However, this method also got repurposed to (silently) check for the
real scenario of unmerged entries. Perhaps it would be better to split
these into two cases and move the silent case into a new method,
"has_unmerged_entries()".

>> Since verify_cache() is called in cache_tree_update(), which is run
>> during 'git commit', we could speed up 'git commit' operations by not
>> iterating through this loop another time. Of course, noticing this loop
>> requires an incredibly large index.
>>
>> To get a measurable difference, I needed to run this test on the
>> Microsoft Office monorepo, which has over three million entries in its
>> index. I used 'git commit --amend --no-edit' as my command and saw the
>> performance go from 752ms to 739ms with this change.>> Could you please check the performance impact of the following code
> simplification?

Thank you for sending this. I started comparing the performance and
discovered that the performance difference I had measured before was
NOT consistent! I went back and debugged and found that 'git commit'
doesn't actually pass the silent flag, and my performance tests were
skewed by the filesystem cache. (A warmup of 3 runs was not sufficient
to get consistent numbers, it seemed. Perhaps the threaded index reads
are too inconsistent.)

> diff --git a/cache-tree.c b/cache-tree.c
> index a537a806c1..1105cfe6b7 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -187,10 +187,8 @@ static int verify_cache(struct cache_entry **cache,
>  		 */
>  		const char *this_name = cache[i]->name;
>  		const char *next_name = cache[i+1]->name;
> -		int this_len = strlen(this_name);
> -		if (this_len < strlen(next_name) &&
> -		    strncmp(this_name, next_name, this_len) == 0 &&
> -		    next_name[this_len] == '/') {
> +		const char *p;
> +		if (skip_prefix(next_name, this_name, &p) && *p == '/') {
>  			if (10 < ++funny) {
>  				fprintf(stderr, "...\n");
>  				break;
 
This performs consistently worse than both cases (see performance test
later in this message). I think the strlen is saving us some time here.

In fact, I think the compiler is doing some magic to save our strlen
results, as I get identical performance results when doing this:

diff --git a/cache-tree.c b/cache-tree.c
index c6c084463b..a076e7cec5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -156,6 +156,8 @@ static int verify_cache(struct cache_entry **cache,
 {
        int i, funny;
        int silent = flags & WRITE_TREE_SILENT;
+       const char *this_name;
+       size_t this_len;
 
        /* Verify that the tree is merged */
        funny = 0;
@@ -182,18 +184,21 @@ static int verify_cache(struct cache_entry **cache,
         * and they should not exist unless a bug was introduced along
         * the way.
         */
-       if (silent)
-               return 0;
        funny = 0;
-       for (i = 0; i < entries - 1; i++) {
+
+       if (!entries)
+               return 0;
+       this_name = cache[0]->name;
+       this_len = strlen(this_name);
+
+       for (i = 1; i < entries; i++) {
                /* path/file always comes after path because of the way
                 * the cache is sorted.  Also path can appear only once,
                 * which means conflicting one would immediately follow.
                 */
-               const char *this_name = cache[i]->name;
-               const char *next_name = cache[i+1]->name;
-               int this_len = strlen(this_name);
-               if (this_len < strlen(next_name) &&
+               const char *next_name = cache[i]->name;
+               size_t next_len = strlen(next_name);
+               if (this_len < next_len &&
                    strncmp(this_name, next_name, this_len) == 0 &&
                    next_name[this_len] == '/') {
                        if (10 < ++funny) {
@@ -203,6 +208,8 @@ static int verify_cache(struct cache_entry **cache,
                        fprintf(stderr, "You have both %s and %s\n",
                                this_name, next_name);
                }
+               this_name = next_name;
+               this_len = next_len;
        }
        if (funny)
                return -1;

To get more consistent results, I modified my benchmark to be the following:

	git -c index.threads=1 commit --amend --allow-empty --no-edit

I also adjusted the test suite to use 5 warmup rounds. Here are the numbers:

  Benchmark #1: v2.30.0
    Time (mean ± σ):     856.6 ms ±  18.0 ms    [User: 807.9 ms, System: 198.4 ms]
    Range (min … max):   832.1 ms … 882.2 ms    10 runs
 
So, 756.5ms average for v2.30.0.

  Benchmark #2: skipping the second loop
    Time (mean ± σ):     805.5 ms ±  15.8 ms    [User: 758.0 ms, System: 197.1 ms]
    Range (min … max):   783.4 ms … 835.2 ms    10 runs
 
Here, I just deleted the second loop to see what is the potential minimum.

  Benchmark #3: storing this_name during second loop
    Time (mean ± σ):     855.6 ms ±  14.1 ms    [User: 804.5 ms, System: 194.6 ms]
    Range (min … max):   835.9 ms … 875.2 ms    10 runs

The diff I provided earlier reduces the number of strlen() computations
by storing them across the loop iterations. There is no effect, which
makes me think the compiler is being smart.

  Benchmark #4: check for '/' before strncmp()
    Time (mean ± σ):     834.1 ms ±  18.0 ms    [User: 786.6 ms, System: 196.7 ms]
    Range (min … max):   803.5 ms … 860.4 ms    10 runs 

HOWEVER, if we swap the order of the conditionals to be

		if (this_len < next_len &&
		    strncmp(this_name, next_name, this_len) == 0 &&
		    next_name[this_len] == '/') {

then we _do_ get a measurable, consistent speedup.

  Benchmark #5: using skip_prefix
    Time (mean ± σ):     877.3 ms ±  16.1 ms    [User: 839.1 ms, System: 187.5 ms]
    Range (min … max):   847.7 ms … 900.4 ms    10 runs

This final benchmark stores the results for your skip_prefix diff.

Including the full ranges of the 10 runs hopefully assists in demonstrating
that the performance changes are (mostly) consistent.

To wrap up, I'm going to eject this patch from my v2 since more investigation
must be done to see if this second loop _can_ be dropped. At minimum, it isn't
properly silent when requested and there _is_ a performance boost possible,
even if we keep the check.

Thanks,
-Stolee
