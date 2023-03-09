Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E26C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCIRcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCIRcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:32:12 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC910F8F3B
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:32:10 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l18so2856362qtp.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678383130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXawhKfFCDthrOtzBZzRJ/500ZuKCvjsiKkRZqvzNgU=;
        b=N/VE9GND0n3YO2ZLoAjOuFF2PiJQm4cQs3RJjNAxp28H35ZfLgtQqkzjAVCMgbi0MJ
         TIkayBE1i5Us58x2uZi7cJblEm4IKw1mu0wKqgc2khuOt+3w/WS7sfFHIR5nzijyKg2h
         KSGfLdT0rVZgNGL70L+22zNNKODkT4vM6bHoAmDnLnzsFomJte0q993LuQgiczcP5Dr1
         gEjIOvoOIKh5MfwhECqyjAmHifcPsFNZvrfBHRjmeGTqOcj/YAgChCQJTkd07jF6FrO3
         LF6K74tbQnpVAwx9COSpumpcrzjj83i9NZuh9RQkDs/MgEVqVo4eJQPuzAjHbSjZpBwZ
         VXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXawhKfFCDthrOtzBZzRJ/500ZuKCvjsiKkRZqvzNgU=;
        b=Xa0w/8Luk7MoA12YSayR1VXwxR3XLFyaqBxNgLh5kPVpwt6vnYGYdTeoZ38fqOGgSb
         0Vdthnu0qD2DbQbcebU8340IIGIl0eQj8H4zECrgFuDXrhCzFDCt5pKCwiZ/nLnXbBH3
         R53uJD6Uwt/l/ec4HoCg6iEZPmuq/FlYtFebjdNBvBUp2zyR0klmQv3glPxnEe5pHfhM
         uEfkgLU2L5raMT8wFlCiUE8uuluT2akPvvZ03FqgUq1rwSBZsfc4ln53skZinYJmuVtc
         lIq15LdfQ+0D3sOfQnODSZNQdqT05ZzeFuPq1kRSuqSbG6QyR9Yr2VYsupDD45EMNAuV
         OWGw==
X-Gm-Message-State: AO0yUKUsvZE6QOru5+TkKyY0ey8DnYq7Bo/pojsGmETJqwSIui0MjRF/
        Zvcthi08s7W7eyhOANzMjvao
X-Google-Smtp-Source: AK7set+lU29k+gyhDnkpCcxZSI/MmHO/JfAG/bRbP9yLhyxFqxMLow5/nHWEn0coWGQsl6Tt5rl2PQ==
X-Received: by 2002:ac8:5793:0:b0:3b6:5d23:8748 with SMTP id v19-20020ac85793000000b003b65d238748mr38337207qta.52.1678383129926;
        Thu, 09 Mar 2023 09:32:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6c89:caea:856b:721d? ([2600:1700:e72:80a0:6c89:caea:856b:721d])
        by smtp.gmail.com with ESMTPSA id n190-20020a37bdc7000000b0071a291f0a4asm13891235qkf.27.2023.03.09.09.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 09:32:09 -0800 (PST)
Message-ID: <068757a3-9dcd-4158-9dc3-d939ff4ed484@github.com>
Date:   Thu, 9 Mar 2023 12:32:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] ahead-behind: implement ahead_behind() logic
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <b8c55ecf88d6229f13e05e8369adaf9e70ae1de0.1678111599.git.gitgitgadget@gmail.com>
 <ZAaN4w4kltPIeYlt@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZAaN4w4kltPIeYlt@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/6/2023 8:05 PM, Taylor Blau wrote:
> On Mon, Mar 06, 2023 at 02:06:37PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> 
> Having read and worked with this code before, I don't have a ton of
> substance to add here. But it was interesting to reread, and I left a
> few sprinklings here and there of some thing that we may want to
> consider for v2.
> 
> Before that, though, IIRC we wrote most of this together, so I would be
> happy to have my:
> 
>     Co-authored-by: Taylor Blau <me@ttaylorr.com>
>     Signed-off-by: Taylor Blau <me@ttaylorr.com>
> 
> above your S-o-b here. But you've done so much work since we originally
> wrote this together that I don't mind being dropped here. Up to you :-).

Sounds good. Sorry for forgetting that collaboration.

>> +static void insert_no_dup(struct prio_queue *queue, struct commit *c)
>> +{
>> +	if (c->object.flags & PARENT2)
>> +		return;
>> +	prio_queue_put(queue, c);
>> +	c->object.flags |= PARENT2;
>> +}
> 
> You mentioned this in the patch message, but:
> 
> It may be worth noting here (or in the call to repo_clear_commit_marks()
> below) that the PARENT2 flag is used to detect and avoid duplicates in
> this list.

I'll add a comment before we clear the bits, to be clear about
why we need each bit.
 
>> +	while (queue_has_nonstale(&queue)) {
>> +		struct commit *c = prio_queue_get(&queue);
>> +		struct commit_list *p;
>> +		struct bitmap *bitmap_c = init_bit_array(c, width);
>> +
>> +		for (i = 0; i < counts_nr; i++) {
>> +			int reach_from_tip = bitmap_get(bitmap_c, counts[i].tip_index);
>> +			int reach_from_base = bitmap_get(bitmap_c, counts[i].base_index);
> 
> Since we're XORing these, I'd hate to get bit by bitmap_get returning
> something other than 0 or 1. It doesn't, since the return value (for any
> "pos" for which it holds that `EWAH_BLOCKI(pos) < self->word_alloc`) is:

> I wonder if we might do a little of belt-and-suspenders here by calling
> these like:
> 
>     int reach_from_tip  = !!(bitmap_get(bitmap_c, counts[i].tip_index));
>     int reach_from_base = !!(bitmap_get(bitmap_c, counts[i].base_index));
> 
> where the "!!(...)" is new.

Can't hurt.
 
>> +			if (bitmap_popcount(bitmap_p) == commits_nr)
>> +				p->item->object.flags |= STALE;
>> +
>> +			insert_no_dup(&queue, p->item);
> 
> Do we care about inserting p->item when the above condition is met? IOW,
> would it be OK to instead write:
> 
>     if (bitmap_popcount(bitmap_p) == commits_nr)
>       p->item->object.flags |= STALE;
>     else
>       insert_no_dup(&queue, p->item);

We need to push p->item to the queue, even if stale, because it
may need to be walked in order to pass the bitmaps (and the STALE
bit) to other commits that were reached by only a subset of the
tips.

Here's an example:

     A B
     |/ \
     C   D
     |  /
     E /
     |/
     F

If A and B are the starting commits, then C is stale when we
walk it, so its parent E would be stale. Your proposed change
would not add it to the queue, and thus F would never see that
it is stale and would be counted as reachable from B but not A.

>> diff --git a/commit-reach.h b/commit-reach.h
>> index 148b56fea50..1780f9317bf 100644
>> --- a/commit-reach.h
>> +++ b/commit-reach.h
>> @@ -104,4 +104,34 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>>  					 struct commit **to, int nr_to,
>>  					 unsigned int reachable_flag);
>>
>> +struct ahead_behind_count {
>> +	/**
>> +	 * As input, the *_index members indicate which positions in
>> +	 * the 'tips' array correspond to the tip and base of this
>> +	 * comparison.
>> +	 */
>> +	size_t tip_index;
>> +	size_t base_index;
>> +
>> +	/**
>> +	 * These values store the computed counts for each side of the
>> +	 * symmetric difference:
>> +	 *
>> +	 * 'ahead' stores the number of commits reachable from the tip
>> +	 * and not reachable from the base.
>> +	 *
>> +	 * 'behind' stores the number of commits reachable from the base
>> +	 * and not reachable from the tip.
>> +	 */
>> +	int ahead;
>> +	int behind;
>> +};
> 
> Should these be unsigned values? I don't think we have a sensible
> interpretation for what a negative "ahead" or "behind" could would mean.
> I guess behind "behind" by "N" means you're "ahead" by "-N", but I don't
> think it's practical ;-).
Unsigned sounds good.
 
>> +
>> +/**
> 
> Here and elsewhere, these kind of doc-comments are a little
> non-standard, and IIRC the opening should instead be "/*" (with one
> asterisk instead of two).

I think double-asterisk is the preferred choice for new things, but
commit-reach.h only uses a single asterisk so I'll change this to
be consistent.

Thanks,
-Stolee
