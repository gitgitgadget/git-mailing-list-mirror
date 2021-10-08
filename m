Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4FC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 11:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C01660F22
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 11:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhJHLLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhJHLL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 07:11:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E8C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 04:09:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so28677533wrg.5
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TahShXcSqm5/UzqTZIAtHv5on5GczH5Pb2uVyS4JJzg=;
        b=EM58gL5wqCJTmY4XnWpnRGIv+LX8oVSDGfarCONg0T+7AxSP4oPYpH0+NYbpooSRFd
         U2MBEBSNBqFlY2pquzmwi3p7KLydWgGw0h2c0y+HCh5WQxJWhQu22IUnsdARp44c+rAR
         d9QRCOfnVNrnGAHiBeEVizuz6uVUNfp7i59ph8+Bhx5MMk+RAfq7bUOSPY0aOYJ4S75b
         TdYuguyQ+/tYQBQDOujb82xp0gZ0H4m5st4cMYfzrr7ZITq2BFeADfKOQwKdJr0GW7Ft
         xmyByINthEx5vttsS8A1GVBuk7ggHfwUAET25Go8Zjy6RHnL1DxYagqH/yK9rQR1A/gL
         VLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TahShXcSqm5/UzqTZIAtHv5on5GczH5Pb2uVyS4JJzg=;
        b=M3rKVVJcQ6hotDU2CLz8WPmVd1RuKrads+/10Y1nbSEIdmoOJq/F5pS8MtOFuSRy6G
         QTeXUarloEgPSe8gitJoung9GzyHknn6oMfFUtCguOa089WBhNB6NOJL5tmYKb7/XK4i
         P7DucN2EYaamttpfIcWYUlTRQ+vKtU3yD6YDQIaZANDXO4fP2wqd29ADqeNzv6VT2UaQ
         aOPoAlxcGriyopkFvNsQEb4MbiLertTIrDIbDmGKeBJ4nOh9NeYw9BzTG+qJNBmoE4kq
         G3XF+Jug8EKVSsQapoKbXFd50sFwJI3WseH5bL4/qoCg1H4LKAsoO6WdEswclgmQAms7
         f5nQ==
X-Gm-Message-State: AOAM53236Mx9cBg7Zmg0Og/9jD+HHoic1sLHIg6pp5HoVmd8GfVeZta4
        /0DCylordzwHpvLdRxkYTxM=
X-Google-Smtp-Source: ABdhPJw9MwubwcBD8J0To3y0tGPouxtu5Hb5htBrWTwtnheVxldxyTyk+LnZrnJVBizkNrQYikoIgA==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr2644125wmq.48.1633691371843;
        Fri, 08 Oct 2021 04:09:31 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id c7sm3165333wmq.13.2021.10.08.04.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 04:09:31 -0700 (PDT)
Message-ID: <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
Date:   Fri, 8 Oct 2021 12:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 07/10/2021 22:15, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Remove `ensure_full_index` guard on `prime_cache_tree` and update
> `prime_cache_tree_rec` to correctly reconstruct sparse directory entries in
> the cache tree. While processing a tree's entries, `prime_cache_tree_rec`
> must determine whether a directory entry is sparse or not by searching for
> it in the index (*without* expanding the index). If a matching sparse
> directory index entry is found, no subtrees are added to the cache tree
> entry and the entry count is set to 1 (representing the sparse directory
> itself). Otherwise, the tree is assumed to not be sparse and its subtrees
> are recursively added to the cache tree.

I was looking at the callers to prime_cache_tree() this morning and 
would like to suggest an alternative approach - just delete 
prime_cache_tree() and all of its callers! As far as I can see it is 
only ever called after a successful call to unpack_trees() and since 
52fca2184d ("unpack-trees: populate cache-tree on successful merge", 
2015-07-28) unpack_trees() updates the cache tree for the caller. All 
the call sites are pretty obvious apart from the one in 
t/help/test-fast-rebase.c where unpack_trees() is called by 
merge_switch_to_result()

Best Wishes

Phillip

> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>   cache-tree.c                             | 47 ++++++++++++++++++++++--
>   cache.h                                  | 10 +++++
>   read-cache.c                             | 27 ++++++++++----
>   t/t1092-sparse-checkout-compatibility.sh | 15 +++++++-
>   4 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index 9be19c85b66..2866101052c 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -740,15 +740,26 @@ out:
>   	return ret;
>   }
>   
> +static void prime_cache_tree_sparse_dir(struct cache_tree *it,
> +					struct tree *tree)
> +{
> +
> +	oidcpy(&it->oid, &tree->object.oid);
> +	it->entry_count = 1;
> +}
> +
>   static void prime_cache_tree_rec(struct repository *r,
>   				 struct cache_tree *it,
> -				 struct tree *tree)
> +				 struct tree *tree,
> +				 struct strbuf *tree_path)
>   {
>   	struct tree_desc desc;
>   	struct name_entry entry;
>   	int cnt;
> +	int base_path_len = tree_path->len;
>   
>   	oidcpy(&it->oid, &tree->object.oid);
> +
>   	init_tree_desc(&desc, tree->buffer, tree->size);
>   	cnt = 0;
>   	while (tree_entry(&desc, &entry)) {
> @@ -757,14 +768,40 @@ static void prime_cache_tree_rec(struct repository *r,
>   		else {
>   			struct cache_tree_sub *sub;
>   			struct tree *subtree = lookup_tree(r, &entry.oid);
> +
>   			if (!subtree->object.parsed)
>   				parse_tree(subtree);
>   			sub = cache_tree_sub(it, entry.path);
>   			sub->cache_tree = cache_tree();
> -			prime_cache_tree_rec(r, sub->cache_tree, subtree);
> +
> +			/*
> +			 * Recursively-constructed subtree path is only needed when working
> +			 * in a sparse index (where it's used to determine whether the
> +			 * subtree is a sparse directory in the index).
> +			 */
> +			if (r->index->sparse_index) {
> +				strbuf_setlen(tree_path, base_path_len);
> +				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
> +				strbuf_add(tree_path, entry.path, entry.pathlen);
> +				strbuf_addch(tree_path, '/');
> +			}
> +
> +			/*
> +			 * If a sparse index is in use, the directory being processed may be
> +			 * sparse. To confirm that, we can check whether an entry with that
> +			 * exact name exists in the index. If it does, the created subtree
> +			 * should be sparse. Otherwise, cache tree expansion should continue
> +			 * as normal.
> +			 */
> +			if (r->index->sparse_index &&
> +			    index_entry_exists(r->index, tree_path->buf, tree_path->len))
> +				prime_cache_tree_sparse_dir(sub->cache_tree, subtree);
> +			else
> +				prime_cache_tree_rec(r, sub->cache_tree, subtree, tree_path);
>   			cnt += sub->cache_tree->entry_count;
>   		}
>   	}
> +
>   	it->entry_count = cnt;
>   }
>   
> @@ -772,12 +809,14 @@ void prime_cache_tree(struct repository *r,
>   		      struct index_state *istate,
>   		      struct tree *tree)
>   {
> +	struct strbuf tree_path = STRBUF_INIT;
> +
>   	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
>   	cache_tree_free(&istate->cache_tree);
>   	istate->cache_tree = cache_tree();
>   
> -	ensure_full_index(istate);
> -	prime_cache_tree_rec(r, istate->cache_tree, tree);
> +	prime_cache_tree_rec(r, istate->cache_tree, tree, &tree_path);
> +	strbuf_release(&tree_path);
>   	istate->cache_changed |= CACHE_TREE_CHANGED;
>   	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
>   }
> diff --git a/cache.h b/cache.h
> index f6295f3b048..1d3e4665562 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -816,6 +816,16 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
>    */
>   int index_name_pos(struct index_state *, const char *name, int namelen);
>   
> +/*
> + * Determines whether an entry with the given name exists within the
> + * given index. The return value is 1 if an exact match is found, otherwise
> + * it is 0. Note that, unlike index_name_pos, this function does not expand
> + * the index if it is sparse. If an item exists within the full index but it
> + * is contained within a sparse directory (and not in the sparse index), 0 is
> + * returned.
> + */
> +int index_entry_exists(struct index_state *, const char *name, int namelen);
> +
>   /*
>    * Some functions return the negative complement of an insert position when a
>    * precise match was not found but a position was found where the entry would
> diff --git a/read-cache.c b/read-cache.c
> index f5d4385c408..c079ece981a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -68,6 +68,11 @@
>    */
>   #define CACHE_ENTRY_PATH_LENGTH 80
>   
> +enum index_search_mode {
> +	NO_EXPAND_SPARSE = 0,
> +	EXPAND_SPARSE = 1
> +};
> +
>   static inline struct cache_entry *mem_pool__ce_alloc(struct mem_pool *mem_pool, size_t len)
>   {
>   	struct cache_entry *ce;
> @@ -551,7 +556,10 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
>   	return 0;
>   }
>   
> -static int index_name_stage_pos(struct index_state *istate, const char *name, int namelen, int stage)
> +static int index_name_stage_pos(struct index_state *istate,
> +				const char *name, int namelen,
> +				int stage,
> +				enum index_search_mode search_mode)
>   {
>   	int first, last;
>   
> @@ -570,7 +578,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>   		first = next+1;
>   	}
>   
> -	if (istate->sparse_index &&
> +	if (search_mode == EXPAND_SPARSE && istate->sparse_index &&
>   	    first > 0) {
>   		/* Note: first <= istate->cache_nr */
>   		struct cache_entry *ce = istate->cache[first - 1];
> @@ -586,7 +594,7 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>   		    ce_namelen(ce) < namelen &&
>   		    !strncmp(name, ce->name, ce_namelen(ce))) {
>   			ensure_full_index(istate);
> -			return index_name_stage_pos(istate, name, namelen, stage);
> +			return index_name_stage_pos(istate, name, namelen, stage, search_mode);
>   		}
>   	}
>   
> @@ -595,7 +603,12 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
>   
>   int index_name_pos(struct index_state *istate, const char *name, int namelen)
>   {
> -	return index_name_stage_pos(istate, name, namelen, 0);
> +	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
> +}
> +
> +int index_entry_exists(struct index_state *istate, const char *name, int namelen)
> +{
> +	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
>   }
>   
>   int remove_index_entry_at(struct index_state *istate, int pos)
> @@ -1222,7 +1235,7 @@ static int has_dir_name(struct index_state *istate,
>   			 */
>   		}
>   
> -		pos = index_name_stage_pos(istate, name, len, stage);
> +		pos = index_name_stage_pos(istate, name, len, stage, EXPAND_SPARSE);
>   		if (pos >= 0) {
>   			/*
>   			 * Found one, but not so fast.  This could
> @@ -1322,7 +1335,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>   		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
>   		pos = index_pos_to_insert_pos(istate->cache_nr);
>   	else
> -		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> +		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
>   
>   	/* existing match? Just replace it. */
>   	if (pos >= 0) {
> @@ -1357,7 +1370,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>   		if (!ok_to_replace)
>   			return error(_("'%s' appears as both a file and as a directory"),
>   				     ce->name);
> -		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
> +		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
>   		pos = -pos-1;
>   	}
>   	return pos + 1;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 875cdcb0495..4ac93874cb2 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -756,9 +756,9 @@ test_expect_success 'sparse-index is not expanded' '
>   	ensure_not_expanded checkout - &&
>   	ensure_not_expanded switch rename-out-to-out &&
>   	ensure_not_expanded switch - &&
> -	git -C sparse-index reset --hard &&
> +	ensure_not_expanded reset --hard &&
>   	ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
> -	git -C sparse-index reset --hard &&
> +	ensure_not_expanded reset --hard &&
>   	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
>   
>   	echo >>sparse-index/README.md &&
> @@ -768,6 +768,17 @@ test_expect_success 'sparse-index is not expanded' '
>   	echo >>sparse-index/untracked.txt &&
>   	ensure_not_expanded add . &&
>   
> +	for ref in update-deep update-folder1 update-folder2 update-deep
> +	do
> +		echo >>sparse-index/README.md &&
> +		ensure_not_expanded reset --hard $ref || return 1
> +	done &&
> +
> +	ensure_not_expanded reset --hard update-deep &&
> +	ensure_not_expanded reset --keep base &&
> +	ensure_not_expanded reset --merge update-deep &&
> +	ensure_not_expanded reset --hard &&
> +
>   	ensure_not_expanded checkout -f update-deep &&
>   	test_config -C sparse-index pull.twohead ort &&
>   	(
> 

