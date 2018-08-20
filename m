Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CC31F954
	for <e@80x24.org>; Mon, 20 Aug 2018 12:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHTP64 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 11:58:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34717 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeHTP64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 11:58:56 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so15962479qth.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YpoQe9/iVtoVFyx82LVV6qtnRK9wwMTFPg14V9vt2w=;
        b=vUXj6x7fVKK7foL9vBhWSmzdTAO4XvMF2eRB8fZCpDeWtdT3rXvlNz4lyZyfwIVlC/
         Ku1VI5O1BD4d+nCaybYfQCKQ+RXjbEkmJ/pFu/mzgUYnVxGzviOpLz2Am1Y6UbSv1kGy
         wZ6ifqA2V5CsotjMaUREjE7vfqo+XgeQSrhs0bmVkdH8K+8SS299wgBZu0uX8nbMzD32
         kFdzraPYU26XuqlKkXfwZCMHZdHLL3FOSJaldc5F+QBRlUz6MnOtwIJGP0gc1DcOMkgE
         Ht8pOGCMGnu9mtikkMbx/caP3kac7g9EkbVE6ucFKvuqByW9k20QCV6eltA8YXOBOK5I
         HMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YpoQe9/iVtoVFyx82LVV6qtnRK9wwMTFPg14V9vt2w=;
        b=Ub+EOpUuJNt1ifbHt/RyYUtp4oq/1t5qURDrktyWIwp5ECMvKhLaXDwaWEnHZkbA7d
         /yYn8AS5dZO1jAoSNjjJXcYseNr+czJXpg4MRQY9qgoFAWeqtqGU7zPHAZDb6qnRMV5x
         rUNHW0ykR4R8SWV0gZNIm4gjAmOnGjpXVaIgf8MbXxMVfLogNcCUlZ3tMwLAYoN1JcAh
         7Oyv2ohwP05tfr2aZolumrdM5lYb5IfkX5quLvZM20DBh7uet++T57dEYmtIbZmu1tYF
         +i71V/2ijUf+aNoBj+hoUby+WGnXCEAQv9f11F/nefLlaLCylSzHRdRCm/WqOQnXMB7B
         7VhA==
X-Gm-Message-State: AOUpUlF0lNP22wcf0w7kAqmzia9kXIb/XbrU0ind2ma0ZMlNtJsBcUhM
        iyTDcdy2uAOeQOnmK8glB+A=
X-Google-Smtp-Source: AA+uWPwc0oBnxBnsxxJjl4Gf/ainQ7BMtohSGV0LzZlWNLMc7B5NFyoqsbLL+DaIRIedTYmVfOW3eA==
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr45990990qts.354.1534769005286;
        Mon, 20 Aug 2018 05:43:25 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n8-v6sm5476092qte.25.2018.08.20.05.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 05:43:24 -0700 (PDT)
Subject: Re: [PATCH v5 3/7] unpack-trees: optimize walking same trees with
 cache-tree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peff@peff.net
References: <20180812081551.27927-1-pclouds@gmail.com>
 <20180818144128.19361-1-pclouds@gmail.com>
 <20180818144128.19361-4-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b9c78c72-5d3a-9bdd-f3eb-b383ca6676a7@gmail.com>
Date:   Mon, 20 Aug 2018 08:43:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180818144128.19361-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/18/2018 10:41 AM, Nguyễn Thái Ngọc Duy wrote:
> In order to merge one or many trees with the index, unpack-trees code
> walks multiple trees in parallel with the index and performs n-way
> merge. If we find out at start of a directory that all trees are the
> same (by comparing OID) and cache-tree happens to be available for
> that directory as well, we could avoid walking the trees because we
> already know what these trees contain: it's flattened in what's called
> "the index".
> 
> The upside is of course a lot less I/O since we can potentially skip
> lots of trees (think subtrees). We also save CPU because we don't have
> to inflate and apply the deltas. The downside is of course more
> fragile code since the logic in some functions are now duplicated
> elsewhere.
> 
> "checkout -" with this patch on webkit.git (275k files):
> 
>      baseline      new
>    --------------------------------------------------------------------
>      0.056651714   0.080394752 s:  read cache .git/index
>      0.183101080   0.216010838 s:  preload index
>      0.008584433   0.008534301 s:  refresh index
>      0.633767589   0.251992198 s:   traverse_trees
>      0.340265448   0.377031383 s:   check_updates
>      0.381884638   0.372768105 s:   cache_tree_update
>      1.401562947   1.045887251 s:  unpack_trees
>      0.338687914   0.314983512 s:  write index, changed mask = 2e
>      0.411927922   0.062572653 s:    traverse_trees
>      0.000023335   0.000022544 s:    check_updates
>      0.423697246   0.073795585 s:   unpack_trees
>      0.423708360   0.073807557 s:  diff-index
>      2.559524127   1.938191592 s: git command: git checkout -
> 
> Another measurement from Ben's running "git checkout" with over 500k
> trees (on the whole series):
> 
>      baseline        new
>    ----------------------------------------------------------------------
>      0.535510167     0.556558733     s: read cache .git/index
>      0.3057373       0.3147105       s: initialize name hash
>      0.0184082       0.023558433     s: preload index
>      0.086910967     0.089085967     s: refresh index
>      7.889590767     2.191554433     s: unpack trees
>      0.120760833     0.131941267     s: update worktree after a merge
>      2.2583504       2.572663167     s: repair cache-tree
>      0.8916137       0.959495233     s: write index, changed mask = 28
>      3.405199233     0.2710663       s: unpack trees
>      0.000999667     0.0021554       s: update worktree after a merge
>      3.4063306       0.273318333     s: diff-index
>      16.9524923      9.462943133     s: git command: git.exe checkout
> 
> This command calls unpack_trees() twice, the first time on 2way merge
> and the second 1way merge. In both times, "unpack trees" time is
> reduced to one third. Overall time reduction is not that impressive of
> course because index operations take a big chunk. And there's that
> repair cache-tree line.
> 
> PS. A note about cache-tree invalidation and the use of it in this
> code.
> 
> We do invalidate cache-tree in _source_ index when we add new entries
> to the (temporary) "result" index. But we also use the cache-tree from
> source index in this optimization. Does this mean we end up having no
> cache-tree in the source index to activate this optimization?
> 
> The answer is twisted: the order of finding a good cache-tree and
> invalidating it matters. In this case we check for a good cache-tree
> first in all_trees_same_as_cache_tree(), then we start to merge things
> and potentially invalidate that same cache-tree in the process. Since
> cache-tree invalidation happens after the optimization kicks in, we're
> still good. But we may lose that cache-tree at the very first
> call_unpack_fn() call in traverse_by_cache_tree().
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   unpack-trees.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 127 insertions(+)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 6d9f692ea6..8376663b59 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -635,6 +635,102 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
>   	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
>   }
>   
> +static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
> +					struct name_entry *names,
> +					struct traverse_info *info)
> +{
> +	struct unpack_trees_options *o = info->data;
> +	int i;
> +
> +	if (!o->merge || dirmask != ((1 << n) - 1))
> +		return 0;
> +
> +	for (i = 1; i < n; i++)
> +		if (!are_same_oid(names, names + i))
> +			return 0;
> +
> +	return cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
> +}
> +
> +static int index_pos_by_traverse_info(struct name_entry *names,
> +				      struct traverse_info *info)
> +{
> +	struct unpack_trees_options *o = info->data;
> +	int len = traverse_path_len(info, names);
> +	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
> +	int pos;
> +
> +	make_traverse_path(name, info, names);
> +	name[len++] = '/';
> +	name[len] = '\0';
> +	pos = index_name_pos(o->src_index, name, len);
> +	if (pos >= 0)
> +		BUG("This is a directory and should not exist in index");
> +	pos = -pos - 1;
> +	if (!starts_with(o->src_index->cache[pos]->name, name) ||
> +	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name)))
> +		BUG("pos must point at the first entry in this directory");
> +	free(name);
> +	return pos;
> +}
> +
> +/*
> + * Fast path if we detect that all trees are the same as cache-tree at this
> + * path. We'll walk these trees recursively using cache-tree/index instead of

nit, not worth a re-roll

"We'll walk these trees in an iterative loop using cache-tree/index..."

> + * ODB since already know what these trees contain.
> + */
> +static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
> +				  struct name_entry *names,
> +				  struct traverse_info *info)
> +{
> +	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> +	struct unpack_trees_options *o = info->data;
> +	int i, d;
> +
> +	if (!o->merge)
> +		BUG("We need cache-tree to do this optimization");
> +
> +	/*
> +	 * Do what unpack_callback() and unpack_nondirectories() normally
> +	 * do. But we walk all paths in an iterative loop instead.
> +	 *
> +	 * D/F conflicts and higher stage entries are not a concern
> +	 * because cache-tree would be invalidated and we would never
> +	 * get here in the first place.
> +	 */
> +	for (i = 0; i < nr_entries; i++) {
> +		struct cache_entry *tree_ce;
> +		int len, rc;
> +
> +		src[0] = o->src_index->cache[pos + i];
> +
> +		len = ce_namelen(src[0]);
> +		tree_ce = xcalloc(1, cache_entry_size(len));
> +
> +		tree_ce->ce_mode = src[0]->ce_mode;
> +		tree_ce->ce_flags = create_ce_flags(0);
> +		tree_ce->ce_namelen = len;
> +		oidcpy(&tree_ce->oid, &src[0]->oid);
> +		memcpy(tree_ce->name, src[0]->name, len + 1);
> +
> +		for (d = 1; d <= nr_names; d++)
> +			src[d] = tree_ce;
> +
> +		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
> +		free(tree_ce);
> +		if (rc < 0)
> +			return rc;
> +
> +		mark_ce_used(src[0], o);
> +	}
> +	if (o->debug_unpack)
> +		printf("Unpacked %d entries from %s to %s using cache-tree\n",
> +		       nr_entries,
> +		       o->src_index->cache[pos]->name,
> +		       o->src_index->cache[pos + nr_entries - 1]->name);
> +	return 0;
> +}
> +
>   static int traverse_trees_recursive(int n, unsigned long dirmask,
>   				    unsigned long df_conflicts,
>   				    struct name_entry *names,
> @@ -646,6 +742,27 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>   	void *buf[MAX_UNPACK_TREES];
>   	struct traverse_info newinfo;
>   	struct name_entry *p;
> +	int nr_entries;
> +
> +	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
> +	if (nr_entries > 0) {
> +		struct unpack_trees_options *o = info->data;
> +		int pos = index_pos_by_traverse_info(names, info);
> +
> +		if (!o->merge || df_conflicts)
> +			BUG("Wrong condition to get here buddy");
> +
> +		/*
> +		 * All entries up to 'pos' must have been processed
> +		 * (i.e. marked CE_UNPACKED) at this point. But to be safe,
> +		 * save and restore cache_bottom anyway to not miss
> +		 * unprocessed entries before 'pos'.
> +		 */
> +		bottom = o->cache_bottom;
> +		ret = traverse_by_cache_tree(pos, nr_entries, n, names, info);
> +		o->cache_bottom = bottom;
> +		return ret;
> +	}
>   
>   	p = names;
>   	while (!p->mode)
> @@ -812,6 +929,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
>   	return ce;
>   }
>   
> +/*
> + * Note that traverse_by_cache_tree() duplicates some logic in this function
> + * without actually calling it. If you change the logic here you may need to
> + * check and change there as well.
> + */
>   static int unpack_nondirectories(int n, unsigned long mask,
>   				 unsigned long dirmask,
>   				 struct cache_entry **src,
> @@ -1004,6 +1126,11 @@ static void debug_unpack_callback(int n,
>   		debug_name_entry(i, names + i);
>   }
>   
> +/*
> + * Note that traverse_by_cache_tree() duplicates some logic in this function
> + * without actually calling it. If you change the logic here you may need to
> + * check and change there as well.
> + */
>   static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
>   {
>   	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> 
