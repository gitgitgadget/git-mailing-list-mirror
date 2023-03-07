Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C0C64EC4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 01:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCGBFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 20:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjCGBFn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 20:05:43 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E05F229
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 17:05:41 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i4so7667412ils.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 17:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678151141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB4D9RqPxbeW5K3duDaiXpUBeEN7ZEaSn3WXzhrzFxA=;
        b=Q+KvRIRSBdrZIQYYMCapfDVqWAkCEEYAembGQ+2bCXbpR1SpgGNly5h7qTGsxB+f4m
         Ep3bpPrxMhb///EEW1IPvkPkrozWP2tpsclwd9cni3Bun+qluhd9RyYDIdJQBXVgR3td
         AzlthMaKVu5ilX3MwjWZyVLIcYKV0gPcGz6s+aVua6x46BgMs+FRSysajwqxT69xYrsd
         W1FM0f7z4EvTJl3nTLHTfbIFASDRfNE4nNb4h+/RL8SZfRHPvWaVQa7WnGQ0xf9FA9mz
         iVpU76hxNzxmbjlE57XGDqAmrs1Zijt82C+TBW4ijN/A86GA2TmMSLE4HOqsVOqXoHZS
         /zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678151141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB4D9RqPxbeW5K3duDaiXpUBeEN7ZEaSn3WXzhrzFxA=;
        b=mdiKkG9vbpRpdN+zY12XHJdOTJctb1nQfhq9jdb3OtKFxDwU/ytyziAKEPCZMOYT9r
         DjQjDNV+X0GfMAG1dHAiDlVgiYy0a6pUye8wVzokJBTJgOhaMutY+xOzlo+AelFtsxoj
         GqyKKEnJvc9g4bdUDu97esHplBL3Q3s4r+hJRO+Bag/kjlHHciigqc4jUraO7hh044tY
         3XIlmAUwTtz7G+okvSTlhQpOU68u/X+iD7kTwJtEz8XWf1Xfm8noz1bds7B/w9VyX+HN
         +vQxUFXp183U2hSme6U9janXN9c9wPi88+e1bP1JdLynPbjIAZi0+LnaNY7Ufqy41my3
         uqHw==
X-Gm-Message-State: AO0yUKWkaMLQDaabbWGqc7nExCM4YEnkt4exwHIfwU3Qlnx9XYpj6lxL
        53x9VPfEBpK8aWNzZv6YktSRcQ==
X-Google-Smtp-Source: AK7set9yjoms6CEgp+Wd2LePXR4OvptEDWbdk0w0cLl7cMNLKgaN9537Vb/Lot4HOSOpN9r152/brA==
X-Received: by 2002:a05:6e02:144f:b0:316:e3a0:723f with SMTP id p15-20020a056e02144f00b00316e3a0723fmr11378360ilo.17.1678151140772;
        Mon, 06 Mar 2023 17:05:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r22-20020a02c856000000b003e9e5e1aacasm3831826jao.143.2023.03.06.17.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:05:40 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:05:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 7/8] ahead-behind: implement ahead_behind() logic
Message-ID: <ZAaN4w4kltPIeYlt@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <b8c55ecf88d6229f13e05e8369adaf9e70ae1de0.1678111599.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8c55ecf88d6229f13e05e8369adaf9e70ae1de0.1678111599.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 02:06:37PM +0000, Derrick Stolee via GitGitGadget wrote:
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>

Having read and worked with this code before, I don't have a ton of
substance to add here. But it was interesting to reread, and I left a
few sprinklings here and there of some thing that we may want to
consider for v2.

Before that, though, IIRC we wrote most of this together, so I would be
happy to have my:

    Co-authored-by: Taylor Blau <me@ttaylorr.com>
    Signed-off-by: Taylor Blau <me@ttaylorr.com>

above your S-o-b here. But you've done so much work since we originally
wrote this together that I don't mind being dropped here. Up to you :-).

> @@ -71,5 +76,23 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
>  	if (!tips.nr)
>  		return 0;
>
> +	ALLOC_ARRAY(commits, tips.nr + 1);
> +	ALLOC_ARRAY(counts, tips.nr);
> +
> +	for (i = 0; i < tips.nr; i++) {
> +		commits[i] = tips.items[i].util;
> +		counts[i].tip_index = i;
> +		counts[i].base_index = tips.nr;
> +	}
> +	commits[tips.nr] = base;
> +
> +	ahead_behind(commits, tips.nr + 1, counts, tips.nr);
> +
> +	for (i = 0; i < tips.nr; i++)
> +		printf("%s %d %d\n", tips.items[i].string,
> +		       counts[i].ahead, counts[i].behind);
> +
> +	free(counts);
> +	free(commits);
>  	return 0;
>  }

I have to say, the interface looks particularly well designed when you
see the patches come together in this fashion. The builtin is doing
basically no work except collating the user's input, passing it off to
ahead_behind(), and then spitting out the results.

Very nice ;-).

> diff --git a/commit-reach.c b/commit-reach.c
> index 2e33c599a82..87ccc2cd4f5 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -8,6 +8,7 @@
>  #include "revision.h"
>  #include "tag.h"
>  #include "commit-reach.h"
> +#include "ewah/ewok.h"
>
>  /* Remember to update object flag allocation in object.h */

There is a new use of PARENT2 (which we hardcode here as bit 17) below,
but it is already covered as part of the object flag allocation table in
object.h. So this comment has done its job over the years ;-).

>  #define PARENT1		(1u<<16)
> @@ -941,3 +942,97 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>
>  	return found_commits;
>  }
> +
> +define_commit_slab(bit_arrays, struct bitmap *);
> +static struct bit_arrays bit_arrays;
> +
> +static void insert_no_dup(struct prio_queue *queue, struct commit *c)
> +{
> +	if (c->object.flags & PARENT2)
> +		return;
> +	prio_queue_put(queue, c);
> +	c->object.flags |= PARENT2;
> +}

You mentioned this in the patch message, but:

It may be worth noting here (or in the call to repo_clear_commit_marks()
below) that the PARENT2 flag is used to detect and avoid duplicates in
this list.

> +static struct bitmap *init_bit_array(struct commit *c, int width)
> +{
> +	struct bitmap **bitmap = bit_arrays_at(&bit_arrays, c);
> +	if (!*bitmap)
> +		*bitmap = bitmap_word_alloc(width);
> +	return *bitmap;
> +}
> +
> +static void free_bit_array(struct commit *c)
> +{
> +	struct bitmap **bitmap = bit_arrays_at(&bit_arrays, c);
> +	if (!*bitmap)
> +		return;
> +	bitmap_free(*bitmap);
> +	*bitmap = NULL;
> +}
> +
> +void ahead_behind(struct commit **commits, size_t commits_nr,
> +		  struct ahead_behind_count *counts, size_t counts_nr)
> +{
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> +	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
> +	size_t i;
> +
> +	if (!commits_nr || !counts_nr)
> +		return;
> +
> +	for (i = 0; i < counts_nr; i++) {
> +		counts[i].ahead = 0;
> +		counts[i].behind = 0;
> +	}
> +
> +	ensure_generations_valid(commits, commits_nr);
> +
> +	init_bit_arrays(&bit_arrays);
> +
> +	for (i = 0; i < commits_nr; i++) {
> +		struct commit *c = commits[i];
> +		struct bitmap *bitmap = init_bit_array(c, width);
> +
> +		bitmap_set(bitmap, i);
> +		insert_no_dup(&queue, c);
> +	}
> +
> +	while (queue_has_nonstale(&queue)) {
> +		struct commit *c = prio_queue_get(&queue);
> +		struct commit_list *p;
> +		struct bitmap *bitmap_c = init_bit_array(c, width);
> +
> +		for (i = 0; i < counts_nr; i++) {
> +			int reach_from_tip = bitmap_get(bitmap_c, counts[i].tip_index);
> +			int reach_from_base = bitmap_get(bitmap_c, counts[i].base_index);

Since we're XORing these, I'd hate to get bit by bitmap_get returning
something other than 0 or 1. It doesn't, since the return value (for any
"pos" for which it holds that `EWAH_BLOCKI(pos) < self->word_alloc`) is:

    (self->words[EWAH_BLOCK(pos)] & EWAH_MASK(pos)) != 0

so we'll always be guaranteed to zero or one. But if we retuned instead:

    self->words[EWAH_BLOCK(pos)] & EWAH_MASK(pos)

...this code would break in a very annoying and hard-to-debug way ;-).

I wonder if we might do a little of belt-and-suspenders here by calling
these like:

    int reach_from_tip  = !!(bitmap_get(bitmap_c, counts[i].tip_index));
    int reach_from_base = !!(bitmap_get(bitmap_c, counts[i].base_index));

where the "!!(...)" is new.

> +			if (reach_from_tip ^ reach_from_base) {
> +				if (reach_from_base)
> +					counts[i].behind++;
> +				else
> +					counts[i].ahead++;
> +			}
> +		}

I have gone back and forth so many times on this code :-). I think the
XORs are fine, though.

> +		for (p = c->parents; p; p = p->next) {
> +			struct bitmap *bitmap_p;
> +
> +			parse_commit(p->item);
> +
> +			bitmap_p = init_bit_array(p->item, width);
> +			bitmap_or(bitmap_p, bitmap_c);
> +
> +			if (bitmap_popcount(bitmap_p) == commits_nr)
> +				p->item->object.flags |= STALE;
> +
> +			insert_no_dup(&queue, p->item);

Do we care about inserting p->item when the above condition is met? IOW,
would it be OK to instead write:

    if (bitmap_popcount(bitmap_p) == commits_nr)
      p->item->object.flags |= STALE;
    else
      insert_no_dup(&queue, p->item);

> diff --git a/commit-reach.h b/commit-reach.h
> index 148b56fea50..1780f9317bf 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -104,4 +104,34 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
>  					 struct commit **to, int nr_to,
>  					 unsigned int reachable_flag);
>
> +struct ahead_behind_count {
> +	/**
> +	 * As input, the *_index members indicate which positions in
> +	 * the 'tips' array correspond to the tip and base of this
> +	 * comparison.
> +	 */
> +	size_t tip_index;
> +	size_t base_index;
> +
> +	/**
> +	 * These values store the computed counts for each side of the
> +	 * symmetric difference:
> +	 *
> +	 * 'ahead' stores the number of commits reachable from the tip
> +	 * and not reachable from the base.
> +	 *
> +	 * 'behind' stores the number of commits reachable from the base
> +	 * and not reachable from the tip.
> +	 */
> +	int ahead;
> +	int behind;
> +};

Should these be unsigned values? I don't think we have a sensible
interpretation for what a negative "ahead" or "behind" could would mean.
I guess behind "behind" by "N" means you're "ahead" by "-N", but I don't
think it's practical ;-).

> +
> +/**

Here and elsewhere, these kind of doc-comments are a little
non-standard, and IIRC the opening should instead be "/*" (with one
asterisk instead of two).

Thanks,
Taylor
