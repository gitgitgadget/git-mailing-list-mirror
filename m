Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239391F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbeG0ShH (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 14:37:07 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39282 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbeG0ShH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 14:37:07 -0400
Received: by mail-wr1-f49.google.com with SMTP id h10-v6so5744883wre.6
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fsRj09atQTOAIlaVrSL5XN7dXTqM5pUANS+CR9GMuk0=;
        b=QUxsIg0rnepbJ4m/3Y33R3CmVGms8wm9vpyeC16SjNxGkT/EOuuOqF+htiS2t8Hxg4
         yQNj632dakPFACFvHbY1kR6qEu2Qk/pSMfJWVhSOaLcor0IaammCEAzPCqx2lpbR91G9
         KCQeWQdfZtMXAjWzLODKBUNJicfjETohFoxXhcJ9mbIZZtDpcc0TjBPWRiZL4L/lTGU9
         BqyxqrMf/bkmRBukkwotjsbKAlNbuPcvUcWD2FrY5cOVvwbKAzhq3BtJLNI4ewKQR15Q
         +aIypicmzhfe8v9ThZi/31GKz8OQM0QSWRMTToyFfVeiut3naq6jIUIF6AFEQfhgSvKl
         hjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fsRj09atQTOAIlaVrSL5XN7dXTqM5pUANS+CR9GMuk0=;
        b=a2IyaYu7QMzS3y74fk01Cen3oie3Q+wROQtGp6WRK+MY4fdyhlgCL3br0GUKH5oQuT
         f5ig0qgmZBuwzP8ZbQcWqaTLgEpbS2ohmxP4huaffh3GGaCxJEk8kMQqaqHm4Uujkuk2
         fhYhPAerANUMdUHfAm0ZfwgERlzwCG1LJ0lm/MEaCL9ZJGV0JvBYlrhOyptBgesWLrDK
         Jnuhq8n0nhFCY/kFmqD72taNWhWnZEI5EtGDojd1e+Yjg51CKY2XyLtLH0pMA2GknnZA
         T9oYQQ85R/yv5tFkO94FgZiJFfOd0OnMn+PH3AnFNJp6Zg62j3hDK3j6d+Al70+ICtEb
         TKJQ==
X-Gm-Message-State: AOUpUlHiAxv0XDM3Lt+VRkXVPCSBrYqnaSHn80VmrrnNQV2XF7cBG1db
        SG97dzRBXc3nqjDoZ/w+k2WHh5pj
X-Google-Smtp-Source: AAOMgpdLUsmXvHMQYxMC2tXWpk+oFnjMqSQnMMTn9o+m4bYkxA96bvgIyMHnr4yfY2Zj9iyNOJRTFg==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr5576710wrv.33.1532711656987;
        Fri, 27 Jul 2018 10:14:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v124-v6sm2922254wma.18.2018.07.27.10.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:14:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
References: <20180718213420.GA17291@sigill.intra.peff.net>
        <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
        <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
        <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
        <20180724042017.GA13248@sigill.intra.peff.net>
        <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
        <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
        <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
        <20180726163049.GA15572@duynguyen.home>
        <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
        <20180727154241.GA21288@duynguyen.home>
Date:   Fri, 27 Jul 2018 10:14:14 -0700
In-Reply-To: <20180727154241.GA21288@duynguyen.home> (Duy Nguyen's message of
        "Fri, 27 Jul 2018 17:42:41 +0200")
Message-ID: <xmqqpnz8ob2x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 66741130ae..9c791b55b2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -642,6 +642,110 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
>  	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
>  }
>  
> +static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
> +					struct name_entry *names,
> +					struct traverse_info *info)
> +{
> +	struct unpack_trees_options *o = info->data;
> +	int i;
> +
> +	if (dirmask != ((1 << n) - 1) || !S_ISDIR(names->mode) || !o->merge)
> +		return 0;

In other words, punt if (1) not all are directories, (2) the first
name entry given by the caller in names[] is not ISDIR(), or (3) we
are not merging i.e. not "Are we supposed to look at the index too?"
in unpack_callback().

I am not sure if the second one is doing us any good.  When
S_ISDIR(names->mode) is not true, then the bit in dirmask that
corresponds to the one in the entry[] traverse_trees() filled and
passed to us must be zero, so the dirmask check would reject such a
case anyway, no?

I would have moved !o->merge to the front, not for performance
reasons but to make it clear that this function helps an
optimization that matters only when we are walking tree(s) together
with the index.

> +	for (i = 1; i < n; i++)
> +		if (!are_same_oid(names, names + i))
> +			return 0;
> +
> +	return cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
> +}
> +
> +/*
> + * Fast path if we detect that all trees are the same as cache-tree at this
> + * path. We'll walk these trees recursively using cache-tree/index instead of
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
> +	/*
> +	 * Do what unpack_callback() and unpack_nondirectories() normally
> +	 * do. But we do it in one function call (for even nested trees)
> +	 * instead.
> +	 *
> +	 * D/F conflicts and staged entries are not a concern because cache-tree
> +	 * would be invalidated and we would never get here in the first place.
> +	 */

We want to at least have

	if (!o->merge || ARRAY_SIZE(src) <= nr_names)
		BUG("");

here, I'd think.

> +	for (i = 0; i < nr_entries; i++) {
> +		struct cache_entry *tree_ce;
> +		int len, rc;
> +
> +		src[0] = o->src_index->cache[pos + i];
> +
> +		/* Do what unpack_nondirectories() normally does */
> +		len = ce_namelen(src[0]);
> +		tree_ce = xcalloc(1, cache_entry_size(len));

unpack_nondirectories() uses create_ce_entry() here.  Any reason why
we shouldn't use it and tell it to make a transient one?

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
> +	trace_printf("Quick traverse over %d entries from %s to %s\n",
> +		     nr_entries,
> +		     o->src_index->cache[pos]->name,
> +		     o->src_index->cache[pos + nr_entries - 1]->name);
> +	return 0;
> +}

When I invented the cache-tree originally, primarily to speed up
writing of deeply nested trees, I had the "diff-index --cached"
optimization where a subtree with contents known to be the same as
the corresponding span in the index is entirely skipped without
getting even looked at.  I didn't realize this (now obvious)
optimization that scanning the index is faster than opening and
traversing trees (I was more focused on not even scanning, which
is what "diff-index --cached" optimization was about).

Nice.


> +static int index_pos_by_traverse_info(struct name_entry *names,
> +				      struct traverse_info *info)
> +{
> +	struct unpack_trees_options *o = info->data;
> +	int len = traverse_path_len(info, names);
> +	char *name = xmalloc(len + 1);
> +	int pos;
> +
> +	make_traverse_path(name, info, names);
> +	pos = index_name_pos(o->src_index, name, len);
> +	if (pos >= 0)
> +		BUG("This is so wrong. This is a directory and should not exist in index");
> +	pos = -pos - 1;
> +	/*
> +	 * There's no guarantee that pos points to the first entry of the
> +	 * directory. If the directory name is "letters" and there's another
> +	 * file named "letters.txt" in the index, pos will point to that file
> +	 * instead.
> +	 */

Is this trying to address the issue o->cache_bottom,
next_cache_entry(), etc. are trying to address?  i.e. an entry
"letters" appears at a different place relative to other entries in
a tree, depending on the type of the entry itself, so linear and
parallel scan of the index and the trees may miss matching entries
without backtracking?  If so, I am not sure if the loop below is
sufficient.

> +	while (pos < o->src_index->cache_nr) {
> +		const struct cache_entry *ce = o->src_index->cache[pos];
> +		if (ce_namelen(ce) > len &&
> +		    ce->name[len] == '/' &&
> +		    !memcmp(ce->name, name, len))
> +			break;
> +		pos++;
> +	}
> +	if (pos == o->src_index->cache_nr)
> +		BUG("This is still wrong");
> +	free(name);
> +	return pos;
> +}
> +

In anycase, nice progress.
