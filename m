Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C651F461
	for <e@80x24.org>; Thu, 22 Aug 2019 14:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbfHVOxQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 10:53:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38745 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbfHVOxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 10:53:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so5399183qkh.5
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDuNurtgNzHHTU4jgP9Fk/USEH7MOjTKBIZCTGhp6hw=;
        b=bXMmcDKvU5ooII8hS13ySfanQNVtAULFRR2XcgUJsLSqpFB07bDrGfpOoxXEds3Mnv
         KULrdRqiwAPein1uaZ49U4xNRl4uRbSTTWEyZSCH0J2Fhsje1u5RuDagwCeDLcBNz4PJ
         qGt6G2imXo5UTsXHpLXnzbTMMoymVfyt0lnM2qYqx3kHYqyOVRxTTPuoPdGe980CpcjF
         sX73sf6nZPv+Gbx+QnMC+BUdJh9NDLA6coSfSbjJsd8XvoFlTVg2whYpW81d9KPkHrQ5
         LAD4oDhB0I/jLmZI/KIc4fmaqddSe5hrfh2MDbWojThl7026Uaxhxxu4GOWNzayDwKY+
         PHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDuNurtgNzHHTU4jgP9Fk/USEH7MOjTKBIZCTGhp6hw=;
        b=MmK/h/CzjxILea4NUrX2Ze1xxEozSv9dT9TvFKOOnuMh738n1t4KVBhGvjZVCqZq80
         PAF/yBIeRPKG4nWVagbCNq7nT95NzVeA278qqScoJbcsv8R3wkZLKyluQnLrEz0ueV3y
         s5l6vo1byF47rocnEn7yW+29b5GBFkovruHWvlrbRw/nXmRb5bqkmfxdr7by8p2SoXpc
         rYR+52FsJj2NtMYe143/37n/QR7ue1lb9MBfU++GyKvOcdgRJ+aLfTDeGMvlyxWmVgcx
         5OldqXuca1tA4CRgcaGXoieiI/+cXP48BR5ChnkV8aC/8Rh94wrGbtMJiFUFWdyoE74u
         wLBw==
X-Gm-Message-State: APjAAAU3z7BvLjov1hJ7fyPg/9R+vPTu3FBoHRlTatmJIiBDZNgP0X7r
        gtFCteZtcJeLSjXApETD9cg=
X-Google-Smtp-Source: APXvYqwky/267pYy5dJZB5hzuGM0A8Tr+QsarktBAvbWs6xnEcaXudeybSYX059CpDCp6BZzF9vCuA==
X-Received: by 2002:a05:620a:1513:: with SMTP id i19mr33222198qkk.284.1566485594579;
        Thu, 22 Aug 2019 07:53:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1010:2f03:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id x68sm12582661qkc.16.2019.08.22.07.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 07:53:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
 <20190821110424.18184-3-szeder.dev@gmail.com>
 <e52e867b-af17-d239-11b5-e0c6353acc2f@gmail.com>
 <20190821173515.GY20404@szeder.dev> <20190822084158.GC20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5261a122-cdcb-dab5-dffa-75976c607017@gmail.com>
Date:   Thu, 22 Aug 2019 10:53:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190822084158.GC20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2019 4:41 AM, SZEDER Gábor wrote:
> On Wed, Aug 21, 2019 at 07:35:15PM +0200, SZEDER Gábor wrote:
>> So line-level log clearly computes a lot less diffs than
>> '--full-history', though still about 50% more than a regular
>> pathspec-limited history traversal.  Looking at the commit-parent
>> pairs in the output, it appears that the difference comes mostly from
>> merge commits, because line-level log compares a merge commit with all
>> of its parents.
> 
>> It seems there is still more room for improvements by avoiding
>> commit-non_first_parent diffs when the first parent is TREESAME, and
>> doing so could hopefully avoid triggering rename detection in those
>> subtree merges or in case of your evil path.
> 
> Well, that fruit hung much lower than I though, just look at the size
> of the WIP patch below.  I just hope that there are no unexpected
> surprises, but FWIW it produces the exact same output for all files up
> to 't/t5515' in v2.23.0 as the previous patch.
> 
> Can't wait to see how it fares with that evil Windows path :)

Thanks for this! With this patch, we finally have the time down to ~20s.

This is a HUGE improvement, especially considering there is only one result
for the particular section, so the entire history is explored in that time.
 
>   --- >8 ---
> 
> Subject: [PATCH 3/2] WIP line-log: stop diff-ing after first TREESAME merge parent
> 
>   # git.git, ~25% of all commits are merges
>   $ time git --no-pager log -L:read_alternate_refs:sha1-file.c v2.23.0
> 
>   Before:
> 
>     real    0m2.516s
>     user    0m2.456s
>     sys     0m0.060s
> 
>   After:
> 
>     real    0m1.132s
>     user    0m1.096s
>     sys     0m0.036s
> 
>   # linux.git, ~7% of all commits are merges
>   $ time ~/src/git/git --no-pager log \
>     -L:build_restore_work_registers:arch/mips/mm/tlbex.c v5.2
> 
>   Before:
> 
>     real    0m2.599s
>     user    0m2.466s
>     sys     0m0.157s
> 
>   After:
> 
>     real    0m1.976s
>     user    0m1.856s
>     sys     0m0.121s
> 
> [TODO: get rid of unnecessary arrays, tests?, write commit message...]
> ---
>  line-log.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/line-log.c b/line-log.c
> index 9010e00950..a4b032f83a 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1184,13 +1184,11 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  
>  	p = commit->parents;
>  	for (i = 0; i < nparents; i++) {
> +		int changed;
>  		parents[i] = p->item;
>  		p = p->next;
>  		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
> -	}
>  
> -	for (i = 0; i < nparents; i++) {
> -		int changed;
>  		cand[i] = NULL;
>  		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
>  		if (!changed) {

Interesting. The old logic computed ALL the diffs, then started navigating.

By navigating before computing all the diffs, we are now avoiding the rename logic
on the SECOND parent, and there will be a lot of second parents that do not include
the file (depending on the number of parallel topics being merged independently).
That's why git.git has a better performance difference than linux.git.

> @@ -1203,7 +1201,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  			commit_list_append(parents[i], &commit->parents);
>  			free(parents);
>  			free(cand);
> -			free_diffqueues(nparents, diffqueues);
> +			free_diffqueues(i, diffqueues);

Good point here, as we haven't initialized all of the queues.

Thanks,
-Stolee

