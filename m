Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D271F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeHCRzj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:55:39 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38678 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCRzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:55:39 -0400
Received: by mail-lj1-f174.google.com with SMTP id p6-v6so5363867ljc.5
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1cE5iGgzMwyTW2lsiHsw3/tAFEo/mJk3KC0Wj2TSpLY=;
        b=UXsevelCGcbB325k4XdL3cZA5w9RRDrhvX/ux5z4YhtUGvgGg3UauppAH4KeYWyqC4
         aw8w3Hiywnbni42f6P1QBc86B9WfSA/HVRA6URkZqCThustUDeJj2qwd6NDIc8O7++U+
         6ww1/hgErC8w0bN1bJ8EJbsYp6g1IryAoQxugIqFaYEqlgrYo9SUmOlgE/3kBCvarrgS
         /BYcyNqGLY0+fWsgOOQSBkptMTstlYf1dEfCkime5UiFuOnkoYNPfJcgo2wrEF2xnLTa
         13K5kx9b6hdT/Tn58iNNL2iEzFrgd2BwwsjfJShqdbnSLWlUu82ogR4kR5otgqofhJm5
         WiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1cE5iGgzMwyTW2lsiHsw3/tAFEo/mJk3KC0Wj2TSpLY=;
        b=nQrvdrdK9DWgV4FW4340VmgXvH3vrad4/w2fxEuugI4HsgXaNwafU4yMBorg466XIn
         VSBounVsVAsMbkDf1ihEs+GvFYem3xY5uRG1O8E4j5L9yekulD3LrmoTiT7bdIn74G0A
         rZKiIoi8zKxpYcIB/hvB461dPYTQiyqH+2wQ8Pspshvzh5WX17j+I/RQzv6CNmPldxEr
         kJiGAfxzwEHK7aj6glomhZPwO11/4SnHtqCcxLdz2Qd7PGEI+kpfefS5LX6NvP+QkNsq
         pQCPl0c+kY4wS+3t94BL9UMpWCBYKavK+CXx/y/sUIPAAVCG/++jyt9OnhJNKxiuBZ5K
         flPw==
X-Gm-Message-State: AOUpUlHEIrwy6JyS9v3/q9JckUGgUw6aU3NEfrhRps0MV+bxRpREs9kV
        8hVKUG/PMs2rtux6wNB1LYM=
X-Google-Smtp-Source: AAOMgpclm/AP5gc3058h4fZmbYopvF8sW9EqGW1s2JBsm8z/3LfIs6ELobWdPlGvoyazstPGX0/SJA==
X-Received: by 2002:a2e:259:: with SMTP id 86-v6mr6211906ljc.107.1533311921153;
        Fri, 03 Aug 2018 08:58:41 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h9-v6sm764636lfc.47.2018.08.03.08.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 08:58:40 -0700 (PDT)
Date:   Fri, 3 Aug 2018 17:58:38 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
Message-ID: <20180803155838.GA13512@duynguyen.home>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180731163909.19004-1-benpeart@microsoft.com>
 <CACsJy8DMEMsDnKZc65K-0EJcm2udXZ7OKY=xoFmX4COM0dSH=g@mail.gmail.com>
 <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3900401c-4d7b-233c-2098-9771a06ec0dd@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 02:02:00PM -0400, Ben Peart wrote:
> 
> 
> On 8/1/2018 11:10 AM, Duy Nguyen wrote:
> > On Tue, Jul 31, 2018 at 7:03 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
> >>
> >> From: Ben Peart <Ben.Peart@microsoft.com>
> >>
> >> Skip merging the commit, updating the index and working directory if and
> >> only if we are creating a new branch via "git checkout -b <new_branch>."
> >> Any other checkout options will still go through the former code path.
> > 
> > I'd like to see this giant list of checks broken down and pushed down
> > to smaller areas so that chances of new things being added but checks
> > not updated become much smaller. And ideally there should just be no
> > behavior change (I think with your change, "checkout -b" will not
> > report local changes, but it's not mentioned in the config document;
> > more things like that can easily slip).
> > 
> 
> One trade off of pushing these optimizations down into the lower-level 
> functions is that they have a greater potential to break other command 
> if our assumptions are wrong.  Changing these low level functions is a 
> much more invasive set of patches.
> 
> I didn't feel confident enough to pursue this path and instead, decided 
> to do the single, high level optimization around the specific scenario. 
> While it has its own drawbacks (the nasty set of conditions we're 
> testing), the potential for breaking other commands is much smaller.
> 
> That said, I'm willing to look into the model of pushing the 
> checks/optimizations down to smaller areas if we can 1) ensure we aren't 
> breaking other commands and 2) we can get similar performance.
> 
> > So. I assume this reason for this patch is because on super large worktrees
> > 
> >   - 2-way merge is too slow
> >   - applying spare checkout patterns on a huge worktree is also slow
> >   - writing index is, again, slow
> >   - show_local_changes() slow
> > 
> 
> That is pretty close but here is some real data on a large repo.
> 
> "git checkout -b <new_branch>" with this patch takes 0.32 seconds.
> "git checkout -b <new_branch>" without this patch takes 14.6 seconds.
> 
> Note, all numbers are with a hot disk cache - real world numbers for the 
> unpatched case can be much worse as it has to do a lot of disk IO to 
> read/write the 267 MB index, load 500K+ tree objects, etc:
> 
> Name                                      	Inc %	      Inc
>   ||+ git!mainCRTStartup                   	 89.2	   13,380
>   || + git!__tmainCRTStartup               	 89.2	   13,380
>   ||  + git!cmd_main                       	 89.2	   13,380
>   ||   + git!handle_builtin                	 89.2	   13,380
>   ||    + git!cmd_checkout                 	 89.2	   13,380
>   ||     + git!unpack_trees                	 71.5	   10,725
>   ||     |+ git!traverse_trees             	 39.7	    5,956
>   ||     |+ git!cache_tree_update          	 16.1	    2,408
>   ||     |+ git!??unpack_callback          	 11.0	    1,649
>   ||     |+ git!discard_index              	  2.8	      423
>   ||     + git!write_locked_index          	  8.4	    1,257
>   ||     + git!??cache_tree_invalidate_path	  5.1	      767
>   ||     + git!read_index_preload          	  3.4	      514
> 
> > For 2-way merge, I believe we can detect inside unpack_trees() that
> > it's a 2-way merge (fn == twoway_merge), from HEAD to HEAD (simple
> > enough check), then from the 2-way merge table we know for sure
> > nothing is going to change and we can just skip traverse_trees() call
> > in unpack_trees().
> > 
> 
> If we can skip the call to traverse_trees(), that will give us the bulk 
> of the savings (39.7% + 11% = 50.7% if my math is correct).

That cache_tree_invalidate_path() should belong to unpack_trees() as
well. At least I known unpack_trees() does that (and I'm pretty sure
it's useless to call it in this context), but maybe it's called
elsewhere too.

> 
> > On the sparse checkout application. This only needs to be done when
> > there are new files added, or the spare-checkout file has been updated
> > since the last time it's been used. We can keep track of these things
> > (sparse-checkout file change could be kept track with just stat info
> > maybe as an index extension) then we can skip applying sparse checkout
> > not for this particular case for but general checkouts as well. Spare
> > checkout file rarely changes. Big win overall.
> > 
> 
> With the current patch, we don't need to load or update the index at 
> all.  Without the patch, we've already replaced the standard 
> sparse-checkout logic with something significantly faster so in our 
> particular case, I think it's safe to skip the additional complexity of 
> keeping track of changes to the sparse-checkout file.
> 
> > And if all go according to plan, there will be no changes made in the
> > index (by either 2-way merge or sparse checkout stuff) we should be
> > able to just skip writing down the index, if we haven't done that
> > already.
> > 
> 
> That would be great as writing the index is 8.4% of the time spent.
> 
> > show_local_changes() should be sped up significantly with the new
> > cache-tree optimization I'm working on in another thread.
> > 
> 
> As you can see, updating the cache_tree is relatively expensive (16.1% + 
> 5.1%) so we would definitely benefit from any improvements there.
> 
> > If I have not made any mistake in my analysis so far, we achieve a big
> > speedup without adding a new config knob and can still fall back to
> > slower-but-same-behavior when things are not in the right condition. I
> > know it will not be the same speedup as this patch because when facing
> > thousands of items, even counting them takes time. But I think it's a
> > reasonable speedup without making the code base more fragile.
> > 
> 
> So my rough math says we can potentially save 50.7% + 8.4% + (x * 21.2%) 
> (where x is the percentage savings with an optimized cache_tree).  If we 
> assume x == 50%, that means we can save 69.7% of the overall time.
> 
> For comparison, that would put "git checkout -b <new_branch>" at:
> 
> 0.3 seconds - with the current patch
> 4.4 seconds - with the proposed patch
> 14.6 seconds - with no patch

4.4 seconds is in my opnion already very reasonable compared to the
no-patch number, and other more often used commands, which I assume
take seconds as well. Once common commands take a lot less time, we
could have another look at this "checkout -b".

These numbers btw should be in the commit message if you send another
optimization patch because it's very unconvincing to say "optimize"
without numbers. My initial reaction was, the majority of open source
projects are of moderate size and "checkout" takes subseconds anyway,
what is the point of optimization (even if you could reduce 90% of
time) since it will not be noticeable anyway?

> Am I missing anything?  Is my math wrong?  Any other ideas for how to 
> improve the proposed patch?

But if you still want to push it further, this is something I have in
mind. It probably has bugs, but at least preliminary test shows me
that it could skip 99% work inside unpack_trees() and not need to
write the index.

The main check to determine "checkout -b" is basically the new
oidcmp() in merge_working_tree(). Not sure if I miss any condition in
that check, I didn't look very closely at checkout code.

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28627650cd..912e565acc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -478,6 +478,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 {
 	int ret;
 	struct lock_file lock_file = LOCK_INIT;
+	int skip_cache_tree_update = 0;
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
@@ -493,6 +494,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		struct tree_desc trees[2];
 		struct tree *tree;
 		struct unpack_trees_options topts;
+		int nr_trees;
 
 		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
@@ -514,20 +516,45 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.merge = 1;
 		topts.gently = opts->merge && old_branch_info->commit;
 		topts.verbose_update = opts->show_progress;
-		topts.fn = twoway_merge;
+		/*
+		 * We repair cache-tree explicitly in this function,
+		 * no point in doing it again inside unpack_trees()
+		 */
+		topts.skip_cache_tree_update = 1;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
 			topts.dir->flags |= DIR_SHOW_IGNORED;
 			setup_standard_excludes(topts.dir);
 		}
-		tree = parse_tree_indirect(old_branch_info->commit ?
-					   &old_branch_info->commit->object.oid :
-					   the_hash_algo->empty_tree);
-		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
-		init_tree_desc(&trees[1], tree->buffer, tree->size);
-
-		ret = unpack_trees(2, trees, &topts);
+		if (!oidcmp(&old_branch_info->commit->object.oid,
+			    &new_branch_info->commit->object.oid)) {
+			/*
+			 * Skip 2-way merge because we know the end
+			 * result would be the same anyway (to double
+			 * check).
+			 */
+			topts.fn = noop_merge;
+			nr_trees = 0;
+			/*
+			 * Repairing cache-tree is an optional optimization
+			 * and could be safely skipped. Maybe have some
+			 * heuristics based on the_index->cache_nr to
+			 * determine if updating cache-tree could be too
+			 * costly (including index writing cost) and skip it
+			 * instead.
+			 */
+			skip_cache_tree_update = 1;
+		} else {
+			topts.fn = twoway_merge;
+			tree = parse_tree_indirect(old_branch_info->commit ?
+						   &old_branch_info->commit->object.oid :
+						   the_hash_algo->empty_tree);
+			init_tree_desc(&trees[0], tree->buffer, tree->size);
+			tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
+			init_tree_desc(&trees[1], tree->buffer, tree->size);
+			nr_trees = 2;
+		}
+		ret = unpack_trees(nr_trees, trees, &topts);
 		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
 			/*
@@ -597,13 +624,15 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!skip_cache_tree_update) {
+		if (!active_cache_tree)
+			active_cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree))
-		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+		if (!cache_tree_fully_valid(active_cache_tree))
+			cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+	}
 
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
 
 	if (!opts->force && !opts->quiet)
diff --git a/unpack-trees.c b/unpack-trees.c
index cd0680f11e..007d6662f2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1275,6 +1275,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
+	int result_is_actually_src = 0;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -1353,6 +1354,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 		if (traverse_trees(len, t, &info) < 0)
 			goto return_failed;
+	} else if (o->fn == noop_merge) {
+		o->result = *o->src_index;
+		o->cache_bottom = o->src_index->cache_nr;
+		result_is_actually_src = 1;
 	}
 
 	/* Any left-over entries in the index? */
@@ -1426,7 +1431,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
-		if (!ret) {
+		if (!ret &&!o->skip_cache_tree_update) {
 			if (!o->result.cache_tree)
 				o->result.cache_tree = cache_tree();
 			if (!cache_tree_fully_valid(o->result.cache_tree))
@@ -1435,7 +1440,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_REPAIR);
 		}
 		move_index_extensions(&o->result, o->src_index);
-		discard_index(o->dst_index);
+		if (result_is_actually_src && o->dst_index == o->src_index)
+			; /* no discarding */
+		else
+			discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
 		discard_index(&o->result);
@@ -2193,3 +2201,9 @@ int oneway_merge(const struct cache_entry * const *src,
 	}
 	return merged_entry(a, old, o);
 }
+
+int noop_merge(const struct cache_entry * const *src,
+	       struct unpack_trees_options *o)
+{
+	BUG("This is basically a flag and not supposed to be called");
+}
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..3e5bce19a1 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -52,6 +52,7 @@ struct unpack_trees_options {
 		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
+		     skip_cache_tree_update,
 		     gently,
 		     exiting_early,
 		     show_all_errors,
@@ -96,5 +97,7 @@ int bind_merge(const struct cache_entry * const *src,
 	       struct unpack_trees_options *o);
 int oneway_merge(const struct cache_entry * const *src,
 		 struct unpack_trees_options *o);
+int noop_merge(const struct cache_entry * const *src,
+	       struct unpack_trees_options *o);
 
 #endif
-- 8< --

--
Duy
