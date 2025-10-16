Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644F238D49
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640718; cv=none; b=rxXWFQHBz65rM3OXKKX3PgoxYN5fnCq7Fmbf2DMraelEvmlN3zHZ6nMoacsDusY2W5XRzmRnk6ar4X6mJSBgXUjTTzwdRgl7CDxtQqG3tumR9UN8GdWSxJsK4YfyGY0iHurEyHTUYtDTZfSdnQkN9VfBPyC8rMFboAnZKPe+Wtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640718; c=relaxed/simple;
	bh=1jcj/Mk/5yVuUoyBOkXEBOzaxgg2JpTuoLmIeEAE0OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZRhTtDnPNokwoyrRWG3bZ1AOBDt0yaKTqloFFJNDFNE1TvvcilepqWPmIdolV3jvQqqM5kv8o2h9iBK/OnUmXM2U6KY+HoumQ/Ko1jOcHEBNEk0bt4JDjzBrCyiJG9s9jtWh+ZkwBoCgzR1HeITErBsScHybi8FiisDP0w6XC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp3NOhVs; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp3NOhVs"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6500448067dso514836eaf.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640715; x=1761245515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKKvOqTVyBeMowwX53ppER15YLNxpmtnsOYogRa/1Ac=;
        b=fp3NOhVspeuiRPNDv0nrHYkUjbFz+zyysxR2Si0tLXXRVDUCMgA8cdC6HbO6xsbGSO
         JIdNKHWbxK0mRXcVYWaSBqBmOT8QWtKf+vfoz5OfGLJKpVmP8UxFRXRoz4T1j0ORC58N
         UzoCUyFJR9IBW+0cFHVtd6JJRiw2E1OUAGOY8dbE7XSy0+dLhrssc7zUmLBZK/7xRoUY
         5SApEtLF1N5Zzl/tTIwm5GmmA6VOAsH7LM9bG+KvJA6KpGbeCPBzT80q0HiMLMUr5f1Q
         Nvn+lW67Ra3oe/PaLJoWrocr5/k1YFAwPkYYuRW8PqXw3xnXaWywozcRhyYlur/loX6R
         3LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640715; x=1761245515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKKvOqTVyBeMowwX53ppER15YLNxpmtnsOYogRa/1Ac=;
        b=ivHiiinkLlg3Gtg2mX3+PQMYjSUFIzO27bnngzPU2yJxgSIem5MKDmKfuWbD0zPln0
         yR2hAt9swBcIz3olDhRnSLKsv4tNA1E7OT5zTEkDzRDtC694zxUK9wR2r0vqAY2CH1Wp
         F72IIcchw0dQJw1qmPb/Htm54rNqZl6an+QCj1IjTpejHcfQ/1uY72IIjTLXWNibdsV5
         1XJC7OPX6HqcPW9H/8N6ozHHIGPbKt41IE5rK2EdJH4Ocum8mwXCUJd6AU+ZRDobNQbO
         wIUff4yGRLj6SuSB8LVO5/Ua/ZinER59mfIqLF6H8J3uFozWy6F4QBeklISFO4RY+BcJ
         iCZw==
X-Gm-Message-State: AOJu0YzL8xvkrFTzLceRQI1bNAAMJ7wJQN5On1ihfiPdyaAXP0LfDGNB
	mV5hthjHPyFeMVEq3Wj0V8CpHYy6nvSOHmJsrIMyCXdmrDb/rgeaLbgBjCrT5Q==
X-Gm-Gg: ASbGncuYNDlQKuHY7/GrlWpxM0o+m196OYQ+WCwd4ACpirfuyzi7YGoZPwRkwJrJTgn
	8kpeRm4xtmk5iyJkv3ceqyoyI9gPz/nd6JgxXfeBHadtDmI9vyVP2xV5VSlvoheypteefD11H68
	8Db0sSs1wEwnFhBRQ8FkS0LuzbK+az0zyCsYXSRa+pB6nxadPBhkBHS6KV/0ZNC0F/I04vXi6hr
	zZujuywdEKbTTN3BK5IdhpL+x3uLc7ccnUzTzZWzcBKiZglP6R54/qhikYR9urjE2KpRbBOpV8c
	dC2jOSaJx9SeOa8ipJ2cBcl45sNLvayiC2bpQ4AvttuMMMvxCF9LvkcyAHa3zsAdpuZJvbY/sSb
	r1d72eubKSx4DnBXdKJAAjPkBixOOQ1fZgSOkzdocCBvZm0Jgta3+MWp5SCau56wJZySjIw==
X-Google-Smtp-Source: AGHT+IH5vt5N3JEj6dOyuWCxKYZv4l8MxBgPeZjQUYHDP0jaZiz4ZpyIXiyO2NqAPjmURVBck+EX8Q==
X-Received: by 2002:a05:6871:eb0e:b0:365:c2ed:d5f5 with SMTP id 586e51a60fabf-3c98cf83d14mr423051fac.15.1760640715211;
        Thu, 16 Oct 2025 11:51:55 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3c8c8e80a38sm6678285fac.15.2025.10.16.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:51:54 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:51:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <kkcpsorsmyfdxlxnlzliuggsaehhrfvfphdse7aslvwsrbm64b@ylgl65mzot2z>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>

On 25/10/16 10:39AM, Toon Claes wrote:
> The current implementation of git-last-modified(1) works by doing a
> revision walk, and inspecting the diff at each level of that walk to
> annotate entries remaining in the hashmap of paths. In other words, if
> the diff at some level touches a path which has not yet been associated
> with a commit, then that commit becomes associated with the path.
> 
> While a perfectly reasonable implementation, it can perform poorly in
> either one of two scenarios:
> 
>   1. There are many entries of interest, in which case there is simply
>      a lot of work to do.
> 
>   2. Or, there are (even a few) entries which have not been updated in a
>      long time, and so we must walk through a lot of history in order to
>      find a commit that touches that path.
> 
> This patch rewrites the last-modified implementation that addresses the
> second point. The idea behind the algorithm is to propagate a set of
> 'active' paths (a path is 'active' if it does not yet belong to a
> commit) up to parents and do a truncated revision walk.
> 
> The walk is truncated because it does not produce a revision for every
> change in the original pathspec, but rather only for active paths.

Ok so if I understand correctly, the optimization here is that as we
perform the revision walk, the set of paths we look for at each commit
monotonically decreases as changed paths are identified. Prior to this,
we were always checking all paths for each commit even though a path may
have already found the commit that last modified it.

> More specifically, consider a priority queue of commits sorted by
> generation number. First, enqueue the set of boundary commits with all
> paths in the original spec marked as interesting.
> 
> Then, while the queue is not empty, do the following:
> 
>   1. Pop an element, say, 'c', off of the queue, making sure that 'c'
>      isn't reachable by anything in the '--not' set.
> 
>   2. For each parent 'p' (with index 'parent_i') of 'c', do the
>      following:
> 
>      a. Compute the diff between 'c' and 'p'.
>      b. Pass any active paths that are TREESAME from 'c' to 'p'.
>      c. If 'p' has any active paths, push it onto the queue.
> 
>   3. Any path that remains active on 'c' is associated to that commit.
> 
> This ends up being equivalent to doing something like 'git log -1 --
> $path' for each path simultaneously. But, it allows us to go much faster
> than the original implementation by limiting the number of diffs we
> compute, since we can avoid parts of history that would have been
> considered by the revision walk in the original implementation, but are
> known to be uninteresting to us because we have already marked all paths
> in that area to be inactive.
> 
> To avoid computing many first-parent diffs, add another trick on top of
> this and check if all paths active in 'c' are DEFINITELY NOT in c's
> Bloom filter. Since the commit-graph only stores first-parent diffs in
> the Bloom filters, we can only apply this trick to first-parent diffs.
> 
[snip]
> As an added benefit, this implementation gives more correct results. For
> example implementation in 'master' gives:

s/implementation/the implementation/

>     $ git log --max-count=1 --format=%H -- pkt-line.h
>     15df15fe07ef66b51302bb77e393f3c5502629de
> 
>     $ git last-modified -- pkt-line.h
>     15df15fe07ef66b51302bb77e393f3c5502629de	pkt-line.h
> 
>     $ git last-modified | grep pkt-line.h
>     5b49c1af03e600c286f63d9d9c9fb01403230b9f	pkt-line.h
> 
> With the changes in this patch the results of git-last-modified(1)
> always match those of `git log --max-count=1`.
> 
> One thing to note though, the results might be outputted in a different
> order than before. This is not considerd to be an issue because nowhere
> is documented the order is guaranteed.
> 
> Based-on-patches-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
[snip]
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index ae8b36a2c3..40e520ba18 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -2,26 +2,32 @@
>  #include "bloom.h"
>  #include "builtin.h"
>  #include "commit-graph.h"
> +#include "commit-slab.h"
>  #include "commit.h"
>  #include "config.h"
> -#include "environment.h"
>  #include "diff.h"
>  #include "diffcore.h"
>  #include "environment.h"
> +#include "ewah/ewok.h"
>  #include "hashmap.h"
>  #include "hex.h"
> -#include "log-tree.h"
>  #include "object-name.h"
>  #include "object.h"
>  #include "parse-options.h"
> +#include "prio-queue.h"
>  #include "quote.h"
>  #include "repository.h"
>  #include "revision.h"
>  
> +/* Remember to update object flag allocation in object.h */

At first I was wondering if this is a leftover note, but it looks like
it is just a reminder if the allocations change here.

> +#define PARENT1 (1u<<16) /* used instead of SEEN */
> +#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */

Naive question: why do we use these object flags instead of the ones
mentioned?

> +
>  struct last_modified_entry {
>  	struct hashmap_entry hashent;
>  	struct object_id oid;
>  	struct bloom_key key;
> +	size_t diff_idx;
>  	const char path[FLEX_ARRAY];
>  };
>  
> @@ -37,13 +43,35 @@ static int last_modified_entry_hashcmp(const void *unused UNUSED,
>  	return strcmp(ent1->path, path ? path : ent2->path);
>  }
>  
> +/*
> + * Hold a bitmap for each commit we're working with. Each bit represents a path
> + * in `lm->all_paths`. Active bit means the path still needs to be dealt with.
> + */
> +define_commit_slab(commit_bitmaps, struct bitmap *);

Why do we need a path bitmap for each commit? My understanding is that
we check commits in a certain order as dictated by the priority queue.
As soon as the commit that last-modified a path has been identified,
wouldn't we always want the remaining commits processed to only check
the outstanding paths?

>  struct last_modified {
>  	struct hashmap paths;
>  	struct rev_info rev;
>  	bool recursive;
>  	bool show_trees;
> +
> +	const char **all_paths;
> +	size_t all_paths_nr;

It is not immediately obvious to me why we have both `paths` and
`all_paths`. From my understanding, `all_paths` is defining the path
order for the bitmap. If this is the case, maybe it would be worth
explaining in a comment?

> +	struct commit_bitmaps commit_bitmaps;
> +
> +	/* 'scratch' bitmap to avoid allocating every proccess_parent() */
> +	struct bitmap *scratch;
>  };
>  
> +static struct bitmap *get_bitmap(struct last_modified *lm, struct commit *c)
> +{
> +	struct bitmap **bitmap = commit_bitmaps_at(&lm->commit_bitmaps, c);
> +	if (!*bitmap)
> +		*bitmap = bitmap_word_alloc(lm->all_paths_nr / BITS_IN_EWORD);
> +
> +	return *bitmap;
> +}
> +
>  static void last_modified_release(struct last_modified *lm)
>  {
>  	struct hashmap_iter iter;
[snip]
>  static int last_modified_run(struct last_modified *lm)
>  {
> +	int max_count, queue_popped = 0;
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> +	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
> +	struct commit_list *list;
>  	struct last_modified_callback_data data = { .lm = lm };
>  
>  	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	lm->rev.diffopt.format_callback = last_modified_diff;
>  	lm->rev.diffopt.format_callback_data = &data;
> +	lm->rev.no_walk = 1;
>  
>  	prepare_revision_walk(&lm->rev);
>  
> -	while (hashmap_get_size(&lm->paths)) {
> -		data.commit = get_revision(&lm->rev);
> -		if (!data.commit)
> -			BUG("paths remaining beyond boundary in last-modified");
> +	max_count = lm->rev.max_count;
> +
> +	init_commit_bitmaps(&lm->commit_bitmaps);
> +	lm->scratch = bitmap_word_alloc(lm->all_paths_nr);

It looks like we initialize and release both `commit_bitmaps` and
`scratch` here in `last_modified_run()`. Any reason we wouldn't want to
move this to `last_modified_{init,release}()`?

> +
> +	/*
> +	 * lm->rev.commits holds the set of boundary commits for our walk.

Naive question: would it be more correct to say that `rev.commits` is
the list of starting commits? Boundary commits sounds like commits on
the boundary of what we consider interesting/uninteresting which, from
my understanding, is not the case here.

> +	 *
> +	 * Loop through each such commit, and place it in the appropriate queue.
> +	 */
> +	for (list = lm->rev.commits; list; list = list->next) {
> +		struct commit *c = list->item;
> +
> +		if (c->object.flags & BOTTOM) {
> +			prio_queue_put(&not_queue, c);

Ok so commits with the BOTTOM flag are at the boundary of the
"interesting" commit graph. Thus they are not included in the search and
added to the "not_queue".

> +			c->object.flags |= PARENT2;

What is the meaning behind the name PARENT2 in this context? From my
understanding we are using this flag to denote a commit we are not
interested in.

> +		} else if (!(c->object.flags & PARENT1)) {

Same question about PARENT1. It seems to be used to just denote commits
that we have already encountered. The names confuse me a bit though.

> +			/*
> +			 * If the commit is a starting point (and hasn't been
> +			 * seen yet), then initialize the set of interesting
> +			 * paths, too.
> +			 */
> +			struct bitmap *active;
> +
> +			prio_queue_put(&queue, c);
> +			c->object.flags |= PARENT1;

We queue the commit and mark it as seen. Makes sense.

> -		if (data.commit->object.flags & BOUNDARY) {
> +			active = get_bitmap(lm, c);
> +			for (size_t i = 0; i < lm->all_paths_nr; i++)
> +				bitmap_set(active, i);

Here we set up the path bitmap for the commit. At this point, all paths
are still "active" and thus set accordingly. I'm still not entirely sure
though if we really need a path bitmap per commit.

> +		}
> +	}
> +
> +	while (queue.nr) {
> +		int parent_i;
> +		struct commit_list *p;
> +		struct commit *c = prio_queue_get(&queue);
> +		struct bitmap *active_c = get_bitmap(lm, c);
> +
> +		if ((0 <= max_count && max_count < ++queue_popped) ||
> +		    (c->object.flags & PARENT2)) {
> +			/*
> +			 * Either a boundary commit, or we have already seen too
> +			 * many others. Either way, stop here.
> +			 */
> +			c->object.flags |= PARENT2 | BOUNDARY;
> +			data.commit = c;
>  			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
> -				      &data.commit->object.oid, "",
> -				      &lm->rev.diffopt);
> +				      &c->object.oid,
> +				      "", &lm->rev.diffopt);
>  			diff_flush(&lm->rev.diffopt);
> +			goto cleanup;
> +		}
>  
> -			break;
> +		/*
> +		 * Otherwise, make sure that 'c' isn't reachable from anything
> +		 * in the '--not' queue.
> +		 */
> +		repo_parse_commit(lm->rev.repo, c);
> +
> +		while (not_queue.nr) {
> +			struct commit_list *np;
> +			struct commit *n = prio_queue_get(&not_queue);
> +
> +			repo_parse_commit(lm->rev.repo, n);
> +
> +			for (np = n->parents; np; np = np->next) {
> +				if (!(np->item->object.flags & PARENT2)) {
> +					prio_queue_put(&not_queue, np->item);
> +					np->item->object.flags |= PARENT2;
> +				}
> +			}
> +
> +			if (commit_graph_generation(n) < commit_graph_generation(c))
> +				break;

If the generation number of 'c' is higher than 'n' we know 'c' cannot be
an ancestor of 'n' and thus we continue on. Makes sense.

>  		}
>  
> -		if (!maybe_changed_path(lm, data.commit))
> -			continue;
> +		/*
> +		 * Look at each parent and pass on each path that's TREESAME
> +		 * with that parent. Stop early when no active paths remain.
> +		 */
> +		for (p = c->parents, parent_i = 0; p; p = p->next, parent_i++) {
> +			process_parent(lm, &queue,
> +				       c, active_c,
> +				       p->item, parent_i);
> +
> +			if (bitmap_is_empty(active_c))
> +				break;
> +		}
>  
> -		log_tree_commit(&lm->rev, data.commit);
> +		/*
> +		 * Paths that remain active, or not TREESAME with any parent,
> +		 * were changed by 'c'.
> +		 */
> +		if (!bitmap_is_empty(active_c))  {
> +			data.commit = c;
> +			for (size_t i = 0; i < lm->all_paths_nr; i++) {
> +				if (bitmap_get(active_c, i))
> +					mark_path(lm->all_paths[i], NULL, &data);
> +			}
> +		}
> +
> +cleanup:
> +		bitmap_free(active_c);
>  	}
>  
> +	if (hashmap_get_size(&lm->paths))
> +		BUG("paths remaining beyond boundary in last-modified");
> +
> +	clear_prio_queue(&not_queue);
> +	clear_prio_queue(&queue);
> +	clear_commit_bitmaps(&lm->commit_bitmaps);
> +	bitmap_free(lm->scratch);
> +
>  	return 0;
>  }
[snip]

I've taken an initial look a this patch and have mostly questions so
far. Just FYI, after applying this patch locally, the last-modified
tests seem to be failing. The command seems to be segfaulting, but I
haven't looked into it further.

-Justin
