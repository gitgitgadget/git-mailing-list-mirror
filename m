Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78DA1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeHZPUU (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 11:20:20 -0400
Received: from mout.web.de ([212.227.17.12]:34511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeHZPUU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 11:20:20 -0400
Received: from [192.168.178.36] ([91.20.53.4]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY6sm-1gOmCF2XjM-00UpkJ; Sun, 26
 Aug 2018 13:37:43 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
 <20180814015842.GA27055@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <030bac66-eeb4-7bc9-8f27-1e6b4124fd76@web.de>
Date:   Sun, 26 Aug 2018 13:37:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180814015842.GA27055@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ESh5AvVssQuLRZE4ecvD+LIA4yvNEtDv9CZyoEVmQfmnfxlfDGQ
 WXSUXY7MbnrOLwoSHT1icUFAyQydA4BjkedAWS76kLpoJ9cp79ZZfsQxEu+6b+tmJvSOFuM
 V8eS+pmU6mq0tKG9EocmLuED/Sr8LPQGruyIZkFw/O7LUCujGBeP3dRUXk+gmxaI8tSseEY
 iMXI7YPMApylxt1zpM0Gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u9Uo6++Yn8o=:eFSLtZXlAqRgyeoFoKfjaf
 DhHjK6CipUeNzrpnISnlL9seR2MJRG/W+BMANhbOJneUVIGfP5l4sXuZjEcearnebMpVp1zPw
 Y7QsqnVNRufb8Dnutc4e8IQFJyPz4fVx/PrDCRTvxS95EWWOtYujez4TL+c4y1oUY1L+yFbE1
 JJUsmtmmO489yBhDnQVr6tZUEBdPRboc3ifCj3Ql3EXcryp/wjNCyV7nPP7c405VQ1x1Mke64
 7Re2GhX+tmkGDeVME8A4N11dymst7wlAfxSgxESrZCBD9aNdsJIYVnV6IiXGZx6YrBru3gyRQ
 o0jyTmmjdkVfBxg4xxbGdS3k+iUBiwxL9wcz+qLrOkG5ySPjhNyyFJUBUhIOR5JmysUc/nzFo
 XvGSJQedl8hhyhztOSwrFu2BT0wdi9xpuL1OE9+aH2E6r92F2pXPY/l6RXIBnzakAMid3ivam
 Pukjeuv+GTs4PQ9LFxP5ToRy5qCIfxD2IzeUnvRUwJKcsCCzPZVYgqcAys+7YDpSPNFCNvxBh
 2vUD2r2+J1MlG0Ys3AWSRgYgCjOtp7l+1So2LAoKgu2qX5Pb9WK4W4f4oAaaQn5uah2DAWmOK
 RcrFLu/GxgDZZn7jF8708/0sy0ZsY2T1CENqff14QSfeXP4WwKYo3luOQorMANUmrds4BxZ5c
 6RKb3GWCXxYYfcl5GUQCtmqsZVwQQ/LoK3WzlyAVcODI8bzwog7PKJZ0VbdSjoT0lTlAqgDRi
 ItJxhS+FHCLz4oz/7R+9Xzcl0Y2TrxXNG0lxoRrxPM/VvUWILaY5nCA24/EWD1EC6FRaZnL0o
 SarmHb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.2018 um 03:58 schrieb Jeff King:
> Your suggestion can be implemented using khash (my patch below).
> 
>> Before:
>> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
>>
>>   Time (mean ± σ):     269.5 ms ±  26.7 ms    [User: 247.7 ms, System: 21.4 ms]
>>
>>   Range (min … max):   240.3 ms … 339.3 ms
>>
>> After:
>> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
>>
>>   Time (mean ± σ):     224.2 ms ±  18.2 ms    [User: 201.7 ms, System: 22.1 ms]
>>
>>   Range (min … max):   205.0 ms … 259.0 ms
> 
> Yeah. My best-of-five dropped from 300ms to 247ms. That 300 was using
> the memory pool, though khash's deletion strategy isn't all that
> different (the wasted memory hangs around until the next hash resize,
> but if you're evenly dropping and adding, you likely won't need to
> resize).

With your khash patch:

Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'

  Time (mean ± σ):     159.1 ms ±  20.5 ms    [User: 140.3 ms, System: 18.5 ms]

  Range (min … max):   140.0 ms … 214.0 ms

So it seems worth it.

> Anyway, here's the khash patch for reference.
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 5714bcbddd..5a86b10a5e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -534,7 +534,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
>  	 * add to "newlist" between calls, the additions will always be for
>  	 * oids that are already in the set.
>  	 */
> -	if (!tip_oids->map.map.tablesize) {
> +	if (!tip_oids->map) {
>  		add_refs_to_oidset(tip_oids, unmatched);
>  		add_refs_to_oidset(tip_oids, newlist);
>  	}

The caller shouldn't look at the private parts of the implementation
like this.  tablesize is the allocation count, which becomes non-zero
if at least one entry was added.  tip_oids is only inserted into, never
deleted from, so a count or size function could be used instead as a
cleaner interface.  (In a separate patch..)

> diff --git a/oidset.c b/oidset.c
> index 454c54f933..2964b43b2d 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -3,38 +3,44 @@
>  
>  int oidset_contains(const struct oidset *set, const struct object_id *oid)
>  {
> -	if (!set->map.map.tablesize)
> +	khiter_t pos;
> +
> +	if (!set->map)
>  		return 0;
> -	return !!oidmap_get(&set->map, oid);
> +
> +	pos = kh_get_oid(set->map, *oid);
> +	return pos < kh_end(set->map);
>  }
>  
>  int oidset_insert(struct oidset *set, const struct object_id *oid)
>  {
> -	struct oidmap_entry *entry;
> +	int hash_ret;
>  
> -	if (!set->map.map.tablesize)
> -		oidmap_init(&set->map, 0);
> -	else if (oidset_contains(set, oid))
> -		return 1;
> +	if (!set->map)
> +		set->map = kh_init_oid();
>  
> -	entry = xmalloc(sizeof(*entry));
> -	oidcpy(&entry->oid, oid);
> -
> -	oidmap_put(&set->map, entry);
> -	return 0;
> +	kh_put_oid(set->map, *oid, &hash_ret);
> +	return !hash_ret;
>  }

So initialization is deferred to the first insert, and the empty set
can be represented in two ways -- map == NULL and map->size == 0.

I wondered about the performance impact of all those NULL checks at
insert and lookup and converted it to stack storage, with a dirty
hand-rolled oidset_clear() implementation.  It wasn't any faster.

>  
>  int oidset_remove(struct oidset *set, const struct object_id *oid)
>  {
> -	struct oidmap_entry *entry;
> +	khiter_t pos;
>  
> -	entry = oidmap_remove(&set->map, oid);
> -	free(entry);
> +	if (!set->map)
> +		return 0;
> +
> +	pos = kh_get_oid(set->map, *oid);
> +	if (pos < kh_end(set->map)) {
> +		kh_del_oid(set->map, pos);
> +		return 1;
> +	}
>  
> -	return (entry != NULL);
> +	return 0;
>  }
>  
>  void oidset_clear(struct oidset *set)
>  {
> -	oidmap_free(&set->map, 1);
> +	kh_destroy_oid(set->map);
> +	set->map = NULL;
>  }
> diff --git a/oidset.h b/oidset.h
> index 40ec5f87fe..4c4c5a42fe 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -2,6 +2,7 @@
>  #define OIDSET_H
>  
>  #include "oidmap.h"

This can go.

> +#include "khash.h"
>  
>  /**
>   * This API is similar to sha1-array, in that it maintains a set of object ids
> @@ -15,19 +16,34 @@
>   *      table overhead.
>   */
>  
> +static inline unsigned int oid_hash(const struct object_id oid)
> +{
> +	unsigned int hash;
> +	memcpy(&hash, oid.hash, sizeof(hash));
> +	return hash;
> +}
> +
> +static inline int oid_equal(const struct object_id a,
> +			    const struct object_id b)
> +{
> +	return !oidcmp(&a, &b);
> +}

Look, it's oideq() from that other series in disguise! :)

> +
> +KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)

Note to self: The 0 is for kh_is_map, which means that no values are
kept and the given value type (int) doesn't matter.

> +
> +
>  /**
>   * A single oidset; should be zero-initialized (or use OIDSET_INIT).
>   */
>  struct oidset {
> -	struct oidmap map;
> +	kh_oid_t *map;
>  };
>  
> -#define OIDSET_INIT { OIDMAP_INIT }
> -
> +#define OIDSET_INIT { NULL }
>  
>  static inline void oidset_init(struct oidset *set, size_t initial_size)
>  {
> -	oidmap_init(&set->map, initial_size);
> +	set->map = NULL;
>  }

This ignores initial_size, which is misleading.  We should probably
call kh_resize_oid() here and move the function to oidset.c.  Or
get rid of the second parameter..

>  
>  /**
> @@ -58,19 +74,25 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
>  void oidset_clear(struct oidset *set);
>  
>  struct oidset_iter {
> -	struct oidmap_iter m_iter;
> +	kh_oid_t *map;
> +	khiter_t iter;
>  };
>  
>  static inline void oidset_iter_init(struct oidset *set,
>  				    struct oidset_iter *iter)
>  {
> -	oidmap_iter_init(&set->map, &iter->m_iter);
> +	iter->map = set->map;
> +	iter->iter = kh_begin(iter->map);
>  }

This is fine even if map == NULL, because kh_begin() can handle any
parameter value, as it ignores them...

>  
>  static inline struct object_id *oidset_iter_next(struct oidset_iter *iter)
>  {
> -	struct oidmap_entry *e = oidmap_iter_next(&iter->m_iter);
> -	return e ? &e->oid : NULL;
> +	for (; iter->iter != kh_end(iter->map); iter->iter++) {
> +		if (!kh_exist(iter->map, iter->iter))
> +			continue;
> +		return &kh_key(iter->map, iter->iter);
> +	}
> +	return NULL;
>  }

... but kh_end() dereferences map, so iterating a fresh oidset will
segfault here.

>  
>  static inline struct object_id *oidset_iter_first(struct oidset *set,
> 
