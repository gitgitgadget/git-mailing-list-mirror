Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555A2E1737
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657930; cv=none; b=MYikNt9yoepf+pmIXVCSjdjl0OFSCtC8xjfOqO/Lz9vPeHuBVLB6Z0GKYxiWJhbrbhcNHW/xo1n6se+X5aH4oHJwRm9s+KYDi79W1AXsx1SC4cp396BgtdUrHC+Cx1Wmh3RqgyTgMwJgmjYkj4J4yLnryjkZmsgTjG9Xnw81RIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657930; c=relaxed/simple;
	bh=YPeKzlxBXQRaoEYEfhOIaUtqYtYP77cldYAss8acsj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbcFPVK2T0oQZ6Lh/O/6qZiJkw/v8kcDfa/2XAiWhNr9J6fD8CAvHqyzMfeM7TaYTolAvdbHGDO/R+pr2N8LPB+1R1wWqL/iVhHLaLgT/+JB3hHTI0Byv7RcZ5PiRnq/XM02gpVhwfx080TXwdHp6xmEjFTsHhG3r0jYHdBeDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OGyzolNx; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OGyzolNx"
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-430af8922bfso5933675ab.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760657927; x=1761262727; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sv1wx9Cs37SdTl4CPQMLfaObcLp8ceXAmRg4Dogc8lY=;
        b=OGyzolNx+6YzqzunZQGbmfL36xrRxc9eV3fsEwPzn8GTkUSa76Os81f7nYYLqJpVQE
         jhSXtrzEbGWy5a0PLqpU+NFvYwhTc2uOijWdhxH4DnxDNkzgfLjPRJroJmSfHD9rceTl
         drOPyj+qe3DJC8haq1fV+bMfHrEbmgVhTiymo/fND8t+KjXaGsQY/7xD1qau6rlBrr2V
         eHla+U0uL7tbPxnyUhUsKXNhca+hIzBFvRrsG+FIgg1PUWAKHbx6RT6umL02WPESx4DD
         Rl6PC0LTctu5uHnR+nWlekG4epK6Tco3zyhnFOGuv8NAGyszcKpLyp91HCJbaaGYaTwY
         8Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657927; x=1761262727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv1wx9Cs37SdTl4CPQMLfaObcLp8ceXAmRg4Dogc8lY=;
        b=MUGClS+AfzlZ88WIDfV/6Tw7lM99lmhLdn1i4q/CBiggYz9mX5LZgKrMu+jPdPjpCE
         qaEfBecFnvpjhFqT2SyKxEryU2ywY1r2ohcGW1FSIYYqIUrm/S1U2mV1j/Gtnd1/9sKC
         Si7M7nn3gB0m/rgwagZngkuav2UW7sHoMCjihqTSP+M97NFJLsKlYM90N7mrSrebhtiI
         x200b7YOmxQka1Y158+/24CJyzh8uvGFuht2YdMwBkcfQe1M5uUyLsDp958qvm+HCIQv
         crFqa09Fa/NptBAavH0MEOnQaAtwAxnywqqJIedEuoxnxRIOc4AOqf3SSfEyk76LA3tw
         lssw==
X-Gm-Message-State: AOJu0YysXrOVxvVE9hBB1WNswD9/f4pBdKKqaygAS+UfDu00YZzhitvs
	dr4s6p2ss/VoJuRYL+OpmUkwbsxngG07o8Ae9do3ydevhkxs+Z9fKpAnZGLe9w0zM10=
X-Gm-Gg: ASbGncvVKvTY1J9kE6vxoVz+W95JbwnDSA7SG+EDRM3smb8zR24tWZBslE8Y4s3LfG6
	o4phX/TKrRK8WQP45mwzdfoqRmWDzeb4ZSpV9CyAX3/MY6L7wZqxtBVxnYRGYzrZCwoKodNhFoA
	aDqz7LSTsYecG+G3CPmmm8Ioarjm7dYLQxxXZZNpXnroUdjtO2rETFEVPhmnt0GPVcgFpU+YUQB
	wCBoem+hD/QlBMqHoxVznd1T1QaP7P3PBNgTV59Bn0zdmmYalfgu0qUWGMJjacTgn5XsLJBra/4
	dK8nsr4Cd2M1jygd+VAKtIZl96AE2MXS8H/TpUcvxX29SEMnRi5By49Sbqmhh1UlTR0YuC18/mg
	wWPpjFBpHxJ5dVIZ16p+kjX05FgRQ/LjiW/9wLp2ziGKSJv9XHgXIs6m2WaL4kEt/ged1x0OVsw
	AlKTA/C24mORDwLm3abcVlCJFZU2KgWnovpIt3ZrByFu2+kZaDo9MxjwNUbaAF4EURBZBo6gqEs
	Xpuq1s/tVoKAKh1Cw==
X-Google-Smtp-Source: AGHT+IFMNeVCpyooBntBC/NWboMAUicTBWnSWuNNuawqXu/0MojhWJzZ8dtGlbHnKdwLMnFv+NvFeA==
X-Received: by 2002:a05:6e02:1a66:b0:42d:8525:ac81 with SMTP id e9e14a558f8ab-430c527d363mr28691785ab.17.1760657926843;
        Thu, 16 Oct 2025 16:38:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-430c92987e2sm695685ab.39.2025.10.16.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 16:38:46 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:38:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <aPGB/FJtjDmyNLvG@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>

On Thu, Oct 16, 2025 at 10:39:25AM +0200, Toon Claes wrote:
> [...]
>
> To avoid computing many first-parent diffs, add another trick on top of
> this and check if all paths active in 'c' are DEFINITELY NOT in c's
> Bloom filter. Since the commit-graph only stores first-parent diffs in
> the Bloom filters, we can only apply this trick to first-parent diffs.

OK, up to this point this is the same as the commit message that I wrote
with Stolee back in 2020.

> Comparing the performance of this new algorithm shows about a 2.6x
> improvement on git.git:
>
>     Benchmark 1: master
>       Time (mean ± σ):      3.077 s ±  0.055 s    [User: 3.017 s, System: 0.051 s]
>       Range (min … max):    2.947 s …  3.127 s    10 runs
>
>     Benchmark 2: HEAD
>       Time (mean ± σ):      1.181 s ±  0.010 s    [User: 1.139 s, System: 0.038 s]
>       Range (min … max):    1.169 s …  1.194 s    10 runs
>
>     Summary
>       HEAD ran
>         2.60 ± 0.05 times faster than master
>
> But when comparing a more extreme example of
> `git last-modified -- COPYING t`, the difference is a lot bigger:
>
>     Benchmark 1: master
>       Time (mean ± σ):      4.372 s ±  0.057 s    [User: 4.286 s, System: 0.062 s]
>       Range (min … max):    4.308 s …  4.509 s    10 runs
>
>     Benchmark 2: HEAD
>       Time (mean ± σ):     826.3 ms ±  22.3 ms    [User: 784.1 ms, System: 39.2 ms]
>       Range (min … max):   810.6 ms … 881.2 ms    10 runs
>
>     Summary
>       HEAD ran
>         5.29 ± 0.16 times faster than master

These benchmarks are different than the ones that I provided, which is
good, since we should be measuring modern Git, not dragging forward
stale benchmarks ;-).

I imagine that you are just doing a straight last-modified run here in
both instances. In the original patch, I timed this both with and
without changed-path Bloom filters, which helped illustrate their impact
on the changes here.

I'd suggest including those benchmarks as well, and potentially running
them on linux.git, or another comparably larger open-source repository.
git.git is large enough to show some interesting behavior, but I always
have found it useful to compare the results against a larger repository
as well.

> As an added benefit, this implementation gives more correct results. For
> example implementation in 'master' gives:
>
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

Stolee and I wrote these patches together many years ago, so he should
be credited here as well. Since this patch appears to be substantially
based on the original work, I think it is appropriate to include my
S-o-b once the patch is ready.

> ---
> This series revives those changes. I did more thorough deep dive through
> the code and the algorithm and got the code working a lot faster. The
> benchmark results can be found in the commit message.
>
> Some changes compared to GitHub's version include:
>
>  * Use of `struct bitmap` from "ewah/ewok.h", instead of self-defined
>    `struct commit_active_paths`.
>
>  * Removed shortcut code that handled the case when commit and parent
>    are fully treesame, and instead always checked 'active_c' whether the
>    next parent is worth looking at.
>
>  * Modified comments and commit message to make the algorithm more
>    clear (at least to me).
>
>  * Mentioned the use of PARENT1 and PARENT2 in object.h.
>
>  * Removed the use of any global variables.
>
>  * Less conditions are checked in mark_path() because the hashmap of
>    'paths' is considered the single-source of truth.
>
>  * pass_to_parent() doesn't pass on when the path isn't in the 'paths'
>    hashmap no more.

Thanks for clearly showing what the changes on top are. When I applied
this locally and ran it, it pretty quickly segfaulted for me:

    expecting success of 8020.3 'last-modified non-recursive':
      check_last_modified <<-\EOF
      3 a
      1 file
      EOF

    + check_last_modified
    + local indir=
    + test 0 != 0
    + cat
    + git last-modified
    Segmentation fault
    error: last command exited with $?=139
    not ok 3 - last-modified non-recursive
    #
    #		check_last_modified <<-\EOF
    #		3 a
    #		1 file
    #		EOF
    #
    1..3

Looking through the backtrace, it looks like someone is calling
mark_path() with a NULL oid, like so:

    (gdb) bt
    #0  __memcmp_evex_movbe ()
        at ../sysdeps/x86_64/multiarch/memcmp-evex-movbe.S:132
    #1  0x00005555555f2c32 in oideq (oid1=0x0, oid2=0x555555a5eeb0)
        at ./hash.h:408
    #2  0x00005555555f3523 in mark_path (path=0x555555a5eee8 "a", oid=0x0,
        data=0x7fffffffd650) at builtin/last-modified.c:179

, which makes sense, since at the end of the main loop we call
mark_path() on all remaining active paths to indicate that they were
modified by whatever commit we just popped off the queue.

Something like this on top (which matches the original patch that I sent
from GitHub's fork) fixes the tests:

--- 8< ---
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 40e520ba18..c8f66633a7 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -176,7 +176,7 @@ static void mark_path(const char *path, const struct object_id *oid,
 	 * Is it arriving at a version of interest, or is it from a side branch
 	 * which did not contribute to the final state?
 	 */
-	if (!oideq(oid, &ent->oid))
+	if (oid && !oideq(oid, &ent->oid))
 		return;

 	last_modified_emit(data->lm, path, data->commit);
--- >8 ---

> +/* Remember to update object flag allocation in object.h */
> +#define PARENT1 (1u<<16) /* used instead of SEEN */
> +#define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
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
> +

Nice, I am glad to see that we are using a bitmap here rather than the
hacky 'char *' that we had originally written. I seem to remember that
there was a tiny slow-down when using bitmaps, but can't find the
discussion anymore. (It wasn't in the internal PR that I originally
opened, and I no longer can read messages that far back in history.)

It might be worth benchmarking here to see if using a 'char *' is
faster. Of course, that's 8x worse in terms of memory usage, but not a
huge deal given both the magnitude and typical number of directory
elements (you'd need 1024^2 entries in a single tree to occupy even a
single MiB of heap).

Regardless of how you handle the above, I think that the commit slab
name here is a little generic. I guess it's OK since this is only
visible within this compilation unit, but perhaps something like
"active_paths_bitmap" would be more descriptive.

Likewise, I wonder if we should have elemtype here be just 'struct
bitmap'. Unfortunately I don't think the EWAH code has a function like:

    void bitmap_init(struct bitmap *);

and only has ones that allocate for us. So we may consider adding one,
or creating a dummy bitmap and copying its contents, or otherwise.

>  struct last_modified {
>  	struct hashmap paths;
>  	struct rev_info rev;
>  	bool recursive;
>  	bool show_trees;
> +
> +	const char **all_paths;
> +	size_t all_paths_nr;

I wonder if all_paths should be a strvec here? I think that this code
was all written when the type was called argv_array (hilariously, that
change took place towards the end of July, 2020, and the --go-faster
code where this patch came from was written just a couple of weeks
earlier.)

> @@ -196,7 +226,36 @@ static void last_modified_diff(struct diff_queue_struct *q,
>  	}
>  }
>
> -static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
> +static size_t path_idx(struct last_modified *lm, char *path)
> +{
> +	struct last_modified_entry *ent;
> +	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
> +					  struct last_modified_entry, hashent);
> +
> +	return ent ? ent->diff_idx : -1;
> +}
> +
> +static void pass_to_parent(struct last_modified *lm,
> +			   struct bitmap *c,
> +			   struct bitmap *p,
> +			   size_t pos)
> +{
> +	struct last_modified_entry *ent;
> +	struct hashmap_iter iter;
> +
> +	bitmap_unset(c, pos);
> +
> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
> +		if (ent->diff_idx == pos) {
> +			bitmap_set(p, pos);
> +			break;
> +		}
> +	}
> +}

This one I'm not quite following. The original implementation does
something like:

    c->active[i] = 0;
    c->nr--;
    p->active[i] = 1;
    p->nr++;

, where 'i' is an index into the all_paths array. It looks like you are
effectively doing the first part of that with the bitmap_unset() call,
but I'm confused why you're iterating over paths here.

The caller in process_parents() is iterating over all entries that are
treesame to the parent, bit by bit. So I think you can just bitmap_set()
in the parent directly here, but let me know if I am missing something.

> @@ -220,42 +282,197 @@ static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
>  	return false;
>  }
>
> +static void process_parent(struct last_modified *lm,
> +			   struct prio_queue *queue,
> +			   struct commit *c, struct bitmap *active_c,
> +			   struct commit *parent, int parent_i)
> +{
> +	size_t i;
> +	struct bitmap *active_p;
> +
> +	repo_parse_commit(lm->rev.repo, parent);
> +	active_p = get_bitmap(lm, parent);
> +
> +	/*
> +	 * The first time entering this function for this commit (i.e. first parent)
> +	 * see if Bloom filters will tell us it's worth to do the diff.
> +	 */
> +	if (parent_i || maybe_changed_path(lm, c, active_c)) {
> +		diff_tree_oid(&parent->object.oid,
> +			      &c->object.oid, "", &lm->rev.diffopt);
> +		diffcore_std(&lm->rev.diffopt);
> +	}
> +
> +	/*
> +	 * Otherwise, test each path for TREESAME-ness against the parent. If

This "otherwise" is referencing a piece of the patch that doesn't appear
to be here directly, which is how we handle the special case of having
nothing in the diff queue, meaning we are treesame at the root.

In the GitHub version of this patch, we pass all active paths to the
parent, assign the PARENT1 flag if it doesn't already have it, and put
it in the queue as well.

In your version, we'd skip past the next for-loop, and do the same
pass-to-parent dance below, along with inserting the parent into the
prio queue.

So I think that this is all functionally equivalent, but I had to work
through a little bit of the details here, mostly since I haven't looked
at or thought about this code in many years ;-).

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

This one is new relative to the original patch. Why set no_walk here?

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
> +
> +	/*
> +	 * lm->rev.commits holds the set of boundary commits for our walk.
> +	 *
> +	 * Loop through each such commit, and place it in the appropriate queue.
> +	 */
> +	for (list = lm->rev.commits; list; list = list->next) {

Hmm. In the original patch, we look at rev.pending, not rev.commits. The
rest of the patch looks good to me and looks like a faithful
representation of the original patch from GitHub's fork. Thanks for
working on this and making the new last-modified builtin faster ;-).

Thanks,
Taylor
