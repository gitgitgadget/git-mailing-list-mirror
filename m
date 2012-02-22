From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Wed, 22 Feb 2012 17:34:19 +0700
Message-ID: <20120222103418.GA27199@tre>
References: <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
 <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
 <7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 11:33:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S09VL-0002Jd-3A
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 11:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2BVKcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 05:32:54 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56771 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2BVKcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 05:32:52 -0500
Received: by daed14 with SMTP id d14so7978026dae.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 02:32:52 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.136.231 as permitted sender) client-ip=10.68.136.231;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.136.231 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.136.231])
        by 10.68.136.231 with SMTP id qd7mr62896566pbb.28.1329906772396 (num_hops = 1);
        Wed, 22 Feb 2012 02:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q35H9Q6FnREHiDJ0fDxqj378b/kG8GWZHO6WE35LqvU=;
        b=gRukGWNeorbEWCUafSClveCeOsjPKWINIgfl6Eukq0iIsrr1vw/lwgs+D1DxYxL3jT
         rgjRJO51yi6XHBNjLFpWLEdWGpkbnKUimJpflt2AtNeqv1QI8LTEcOqbu3RwfOl2keuV
         y0DnbtrF6fs7snfpERgNvBrLo5Hg4BQijNBnM=
Received: by 10.68.136.231 with SMTP id qd7mr52049356pbb.28.1329906772339;
        Wed, 22 Feb 2012 02:32:52 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id y5sm18650321pbk.45.2012.02.22.02.32.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 02:32:50 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 22 Feb 2012 17:34:19 +0700
Content-Disposition: inline
In-Reply-To: <7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191247>

On Tue, Feb 21, 2012 at 11:16:37AM -0800, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > I'm aware that Jeff's tackling at lower level, which retains
> > cache-tree for many more cases.
> >
> > But this patch seems simple and safe
> > to me, and in my experience this case happens quite often (or maybe I
> > tend to keep my index clean). Junio, any chance this patch may get in?
> 
> I do not think we are talking about a duplicated effort here.
> 
> By definition, the change to hook into unpack_trees() and making sure we
> invalidate all the necessary subtrees in the cache cannot give you a cache
> tree that is more populated than what you started with.  And the train of
> thought in Peff's message is to improve this invalidation---we currently
> invalidate everything ;-)
> 
> Somebody has to populate the cache tree fully when we _know_ the index
> matches a certain tree, and adding a call to prime_cache_tree() in
> strategic places is a way to do so.  The most obvious is write-tree, but
> there are a few other existing codepaths that do so.
> 
> Because prime_cache_tree() by itself is a fairly expensive operation that
> reads all the trees recursively, its benefits need to be evaluated. It
> should to happen only in an operation that is already heavy-weight, is
> likely to have read all the trees and have many of them in-core cache, and
> also relatively rarely happens compared to "git add" so that the cost can
> be amortised over time, such as "reset --(hard|mixed)".

It's tradeoff. As you said prime_cache_tree() is expensive.
cache_tree_update is supposed to be cheap. But cache_tree_update() when
empty is even more expensive than prime_cache_tree(). So it boils down
how much cache-tree we have after unpack_trees() and whether it's worth
repopulate cache-tree again.

> Switching branches is likely to fall into that category, but that is just
> my gut feeling.  I would feel better at night if somebody did a benchmark
> ;-)

I timed prime_cache_tree() and cache_tree_update() while switching branch
on linux-2.6, between v2.6.32 and a quite recent version. prime_cache_tree()
took ~55ms while cache_tree_update() 150ms or 90ms (depending on final tree).
It depends on your view, whether 55ms is expensive on such a reasonably large
repository. I took several seconds for me to complete the checkout though.

Checking out with "-q" prime_cache_tree() took 145ms and 80ms respectively,
as expensive as cache_tree_update()

If cache-tree is only used at commit time, I think we could delay
prime_cache_tree() until absolutely needed. We could add an optional index
extension recording the fact that index matches certain tree.
On the first cache_tree_invalidate_path(), if cache-tree is still
empty, we prime cache-tree, then invalidate the requested path.
It would then add no cost to a quick branch switch.

But if diff-cached also takes advantage of cache-tree, it's a different story.

Anyway, I think this patch does better than my last one

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6b9061f..e7eaeec 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -387,6 +387,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 	int newfd = hold_locked_index(lock_file, 1);
+	int head_index_mismatch = 1;
 
 	if (read_cache_preload(NULL) < 0)
 		return error(_("corrupt index file"));
@@ -396,6 +397,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
 			return ret;
+		head_index_mismatch = 0;
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
@@ -490,7 +492,27 @@ static int merge_working_tree(struct checkout_opts *opts,
 			ret = reset_tree(new->commit->tree, opts, 0);
 			if (ret)
 				return ret;
-		}
+		} else
+			head_index_mismatch = topts.head_index_mismatch;
+	}
+
+	/*
+	 * Currently cache-tree is always destroyed after
+	 * unpack_trees(). It's probably a good idea to repopulate
+	 * cache-tree. If the user makes a few modifications and
+	 * commits, tree generation woulda be cheap. If they switch
+	 * away again, not so cheap.
+	 *
+	 * When unpack_trees() learns to retains as much cache-tree as
+	 * possible, this code probably does not help much on tree
+	 * generation, unless the tree difference between to heads are
+	 * too far, little cache-tree can be kept.
+	 */
+	if (!head_index_mismatch &&
+	    !cache_tree_fully_valid(active_cache_tree)) {
+		if (!new->commit->tree->object.parsed)
+			parse_tree(new->commit->tree);
+		prime_cache_tree(&active_cache_tree, new->commit->tree);
 	}
 
 	if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..f2c518f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1022,6 +1022,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
+	if (o->fn != twoway_merge)
+		o->head_index_mismatch = 1;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
@@ -1736,6 +1738,8 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		    (oldtree && newtree &&
 		     !same(oldtree, newtree) && /* 18 and 19 */
 		     same(current, newtree))) {
+			if (!newtree || (newtree && !same(current, newtree)))
+				o->head_index_mismatch = 1;
 			return keep_entry(current, o);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
diff --git a/unpack-trees.h b/unpack-trees.h
index 5e432f5..b75b64e 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -48,7 +48,8 @@ struct unpack_trees_options {
 		     gently,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run;
+		     dry_run,
+		     head_index_mismatch;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 8< --
