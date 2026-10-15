Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5449E5EF
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047356; cv=none; b=OdQR064dT//kTky4rcw/I78jlCeNPoC0ZrSbt6umXAkjZ/tJQaFRBA1fDLEynASQbSWmEE3MH7Qj5LfQiqahinJtsqrd27f/OcaKqOru89AhAQfiBVDM9u24/NOdfBHEp7TUcIABhQ9Oi6/8EaIYCQlmJIX8H7jx8294LfKxxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047356; c=relaxed/simple;
	bh=4YKf7no2u9K6f/zkLmpCkRbJz/BN7lWN27asoeQw9dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf5MrnT5DFu/UG/YBOxWtOstnDMC72NCn/jXr30A0/ZLrN4DF3ZCQ9KnBRfSy1/Du1lh0BcKlzAdScSTEGmRK9h2kW2i6IzWL5R28YW3ngcQoG7uZJkU98IFS1TyhEtnw9odUqcuKiCAvWjB4GPQdL9ESwJzMcfCFc+WcH/eeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FN7a0hJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tOm509BB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FN7a0hJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tOm509BB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 389AF1D000D4
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:55:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 02:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792047348; x=1792133748; bh=xk9zUR34A0
	/ZbIn04Kmm5cmHPkBEB4n6xp2KiiKRHQI=; b=FN7a0hJcWR8tKsvtgN+4zFyZhw
	VMjkAgpj4KkH77jhiqBk/oZ1fdwRo2fm5K98/7lWwbW5RcdLsIlb4tHfzKubn5aZ
	9kNtP3HlzJ/YpGs8aQdBZyMu9UjQWpnhMu4NvOTWtMh37SUKd3d5PFOMnPiRaDNd
	sYdBzUO8nnHdZN+7VTehfBRUI8L4RRdwO0KtUi0HiWyT1fTQwB1ykLHWOU5zm1b2
	ZOpyr8N5NhYoY+s9yqGPvNTSfcbf4VW8QTwU5n151KpLYMgDZWH8jSXb5XtvLpBS
	X5+iMDIEG0t+vFa3QyS2n8JceSrINwDkHUw65x5mCfyYKvYBPKgJYA3UqDVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792047348; x=1792133748; bh=xk9zUR34A0/ZbIn04Kmm5cmHPkBEB4n6xp2
	KiiKRHQI=; b=tOm509BB8tSmmPFgwhE4dPR1BtcwjPAmDzkoysrOebGA5e+w3Wf
	FH93cpOCU2sy+XIv4I3doS9AjNyuS5BFxfl+cR3BoIWN7S3tPqIMS8dL7Zeb5R6F
	aAMzF/bNYNaT7WeI0r6BxZUDve03Hm1k4kDmYs0rCnb17/sBDALqMK6vBOOyWwH9
	NQVt9dn7xnUJmGDR05eN8T8KIaLflbOkdl01tU4820p3dYureX3RUuCzSr3+meij
	eYIbqrhMDDrLBdEBzn8ZCeGsVKstqCacreziadsJ4YhiNtqnQWSUgSB2LT4Rpe5w
	mC78VqoBBPen55sjp7tbHlax23/6ixqCC8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047348; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AUZmsjA2ZUSg8AR768iZ4lu55febu5zN1UdGHVJr86Qy9hY
	DEM0WFm2D4Y337oy6p84Vk/Pa2LVjTY820fc4ZeDClCbitK/lQhgk6tz7Am0N1us
	ubvPfY0wE9Eja9HtRILmnpVkr5z7qz+CgwxxCiEFLyxUtyh52yC/0nnTKsGn5/2g
	4xCDVMQHqfTtnx6SNNYZRXkIA/ZK7TshhE2HLgPP+hJNuNaovY3M9eDaI/gQiJXT
	LogJN8qWGmt6uA8/PU4fRL3D/MDtuZ9FAev8J+hqE/eNNcsAiTNf0CIwF0F8030K
	GtYb/L1pBn3N6dUBLNSw7Z3F6a1gejG1lxgjcjQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tujMwNz6xShVQnVu6rlhxJ1p2V8aaoJswCLsRy2tYpw=:4YKf7no2u9K6f/zkLmpCkRbJz/BN7lWN27asoeQw9dU=;
X-ME-Sender: <xms:83jQagx-XDH89NuB8iIJwKVh5JzxwqgzgDzpuEjjBqf2Zm44t8nyfA>
    <xme:83jQartqgmoOtl8HZhaPxUQ6t42LV4eAIXrDEsip2KOPMESR6dXM4pr3m2_w9gg1F
    JqYCPDfyPbsIe-coFbaCb9K1G4_WDYjrwrIK4VBJjTcn1XLYvCsc9I>
X-ME-Received: <xmr:83jQavt7TUiWJDlBr4bjL9a6iHzCsJn9MQSb_u73sNdl5D5hFweRtqjcX-e-kMIpIpf5s5U>
X-ME-Proxy-Cause: dmFkZTGCaI+9vszqq7PsXJlDqnjG2KgY6aHgBkg9+/r8Wip7UnB70qswzRu9NL6bdamAkr
    UKC2T2ACjmHXbDsrpfdQsotbw5kKNACBHBKELLHSeLkiXjvRErtOkzezkpdnzW9jxgfODL
    4KZARb+uQSSBCxiKE9pOQ7Z7Tisauq44+0r57nu/CXl4HnMIeY5vKDqnN27WT4+epbACK1
    AL9YT3mcXVrUxULNtyansdtLUOX26O3qwdnwd9NAb01gYCZhX4UQyD3TGTPF87ohXwqzpl
    hbfb8jgZIJHrAIxSiH3Rf4aYZHXRzf9CwoZUSGp3lM6A+5tRiyd5vjb1mbna6R/+Go1BY4
    yq573R8klpH2WmnKZ0TZz3kNF8OGA62cVG7ntB9J8R+BoFYP2HQrJ9wHJ6rv+WyIALpwYw
    06JkZe5i2AVvYEcc5EMAW1pK/GChxdGXWkFQC+nj4J6797pHn/Q0lhdrcJLMeo24sQ9SpH
    rln8NkZ1aKL6g40wcQdrVM9eQtNqH77V9DKXRRbEo7lcjlLGXTkuyqLBnI2vOLidublPFv
    fwXF5DJ7QVBW96xSgHI+ZyhstGFttUX4SuY2qF0ZEQWK1cCxAfpKlN3D87pgL5nWzeU7+y
    7T/1sx6QqFra1cfzfrK1iAi/gD3tJOYn0E1mhS1IenNhmZPg1KFQR/5bLqpA
X-ME-Proxy: <xmx:83jQaoPPj0TZ91RhJtBelgFscxtEL87TB2mKeuOf35TIamzqzIzNcw>
    <xmx:9HjQal2I0LYh889CsroTd09miomgLUtC3JcGyW7y3pYetc7qog1pBg>
    <xmx:9HjQasMem5dGsFmsvvjH62l7ZA4Kp0iroEY9iLZdeqpBLVhrp9LIcg>
    <xmx:9HjQat1URs5ROAU84d_DxVgt5aaNPIRWNJLa63pcXnp0gyb35snYug>
    <xmx:9HjQai9Fcv8ZWkP225RrmuPNv_snyN9nNMA44RLFn1hXKQ6ydHY2zYuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:55:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e6960d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:55:47 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:55:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 4/4] connected: add incremental connectivity check via
 rev-list
Message-ID: <atB48HLgZr3ssOfx@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
 <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>

On Mon, Oct 12, 2026 at 12:07:57PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
[snip]
> Scaling tree size (10 incoming commits, 10 files/commit):
> 
>     files    full  incr.  full/incr
>       5K    0.01s  0.01s    1.0x
>      50K    0.04s  0.01s    4.0x
>     200K    0.15s  0.01s   15.0x
>     800K    0.61s  0.03s   20.3x
> 
> The full mode must walk the trees of boundary commits, which
> grows with overall tree size.  Incremental still scans the
> root trees, but avoids descending into unchanged subtrees,
> so it grows much more slowly with repository size.

Okay, so this is getting better the larger the trees.

> Scaling incoming commit count (200K files, 10 files/commit):
> 
>     commits    full  incr.  full/incr
>           1    0.14s  0.01s   14.0x
>          10    0.15s  0.01s   15.0x
>         100    0.19s  0.05s    3.8x
>         500    0.32s  0.27s    1.2x
>        3000    1.23s  1.52s    0.8x
>        5000    1.88s  2.43s    0.8x
>       10000    3.72s  5.36s    0.7x
> 
> With many commits the per-commit overhead of scanning both
> the new and parent root trees accumulates and incremental
> becomes slower.  Breakeven is between 500 and 3000 commits
> and the ratio stabilizes near 0.7x for this fixture.

And worse the more commits we have. So the new mode is only really
applicable in scenarios where you know what your typical workload looks
like. The big question is of course whether we can have the best of both
worlds, where Git knows to switch between the two modes once it crosses
the threshold.

> diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> index abef02debd..a1d2e9709c 100644
> --- a/Documentation/technical/connectivity-check.adoc
> +++ b/Documentation/technical/connectivity-check.adoc
> +Algorithm
> +~~~~~~~~~
> +
> +At a high level:
> +
> +    verify(commits):
> +        sort topologically (ancestors first)
> +        for each commit:
> +            mark parent root trees as trusted
> +            verify_tree(commit.tree, parent root trees)

So based on this, `verify()` already knows which commits it will be
checking for connectivity. So wouldn't it be possible to fall back to
the original algortihm here in case we see more than N commits?

> diff --git a/tree-verify.c b/tree-verify.c
> new file mode 100644
> index 0000000000..b381a50102
> --- /dev/null
> +++ b/tree-verify.c
> @@ -0,0 +1,316 @@
> +#include "git-compat-util.h"
> +#include "commit.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "khash.h"
> +#include "object.h"
> +#include "odb.h"
> +#include "oid-array.h"
> +#include "oidset.h"
> +#include "tree.h"
> +#include "tree-walk.h"
> +#include "tree-verify.h"
> +#include "packfile.h"
> +#include "trace2.h"
> +
> +enum tree_state {
> +	TREE_UNTRUSTED = 0,
> +	TREE_TRUSTED   = 1,
> +	TREE_EXPANDED  = 2,
> +};
> +
> +KHASH_INIT(oid_tree, struct object_id, unsigned char, 1,

The values are `enum tree_state`s, right? Why don't we use that type
here?

> +	   oidhash_by_value, oideq_by_value)
> +
> +static enum tree_state tree_map_get(kh_oid_tree_t *m,
> +				    const struct object_id *oid)
> +{
> +	khint_t pos = kh_get_oid_tree(m, *oid);
> +	if (pos == kh_end(m))
> +		return TREE_UNTRUSTED;
> +	return kh_val(m, pos);
> +}
> +
> +static void tree_map_add(kh_oid_tree_t *m, const struct object_id *oid,
> +			 enum tree_state state)
> +{
> +	int added;
> +	khint_t pos = kh_put_oid_tree(m, *oid, &added);
> +	if (added)
> +		kh_val(m, pos) = state;
> +	else if (state > kh_val(m, pos))
> +		kh_val(m, pos) = state;
> +}
> +
> +struct work_item {
> +	struct name_entry entry;
> +	struct oid_array parent_trees;
> +};
> +
> +struct verify_state {
> +	kh_oid_tree_t *trees;
> +	struct oidset trusted_blobs;
> +	int trees_loaded;
> +	int blobs_checked;

These probably should be `size_t`.

> +	int exclude_promisor_objects;
> +};
> +
> +/*
> + * Merge-walk the work list against one base tree entry, recording
> + * same-path parent subtrees as recursive comparison bases.
> + * Returns the updated work-list cursor.
> + */
> +static size_t collect_subtree_bases(struct work_item *work, size_t nr_work,
> +				    size_t wi, const struct name_entry *entry)
> +{
> +	while (wi < nr_work) {
> +		int cmp = base_name_compare(
> +			work[wi].entry.path, work[wi].entry.pathlen,
> +			work[wi].entry.mode,
> +			entry->path, entry->pathlen,
> +			entry->mode);
> +		if (cmp > 0)
> +			break;
> +		if (cmp < 0) {
> +			wi++;
> +			continue;
> +		}
> +		if (S_ISDIR(work[wi].entry.mode) &&
> +		    S_ISDIR(entry->mode))
> +			oid_array_append(&work[wi].parent_trees,
> +					 &entry->oid);
> +		return wi + 1;
> +	}
> +	return wi;
> +}
> +
> +static void verify_blob(struct repository *repo,
> +			const struct object_id *oid,
> +			struct verify_state *vs)
> +{
> +	int type;
> +
> +	if (oidset_contains(&vs->trusted_blobs, oid))
> +		return;
> +
> +	vs->blobs_checked++;
> +	type = odb_read_object_info(repo->objects, oid, NULL);
> +	if (type == OBJ_BLOB) {
> +		oidset_insert(&vs->trusted_blobs, oid);
> +		return;
> +	}
> +	if (type >= 0)
> +		die(_("object %s is a %s, not a %s"),
> +		    oid_to_hex(oid), type_name(type), "blob");

I'd love not having all these calls to `die()`, as this logic is
essentially part of a library, and dying inside a library is a bad
smell. We do this everywhere else in Git, too, but we're slowly getting
rid of this as part of our libification efforts.

> +	if (vs->exclude_promisor_objects &&
> +	    is_promisor_object(repo, oid))
> +		return;
> +	die(_("missing blob object '%s'"), oid_to_hex(oid));

Maybe the object is missing, but it may just as well be corrupt. So this
should probably say "unable to read".

> +}
> +
> +static void *read_tree_object(struct object_database *odb,
> +			      const struct object_id *oid,
> +			      size_t *sizep)
> +{
> +	enum object_type type;
> +	void *buf = odb_read_object(odb, oid, &type, sizep);
> +
> +	if (buf && type != OBJ_TREE) {
> +		free(buf);
> +		die(_("object %s is a %s, not a %s"),
> +		    oid_to_hex(oid), type_name(type), "tree");
> +	}
> +	return buf;
> +}
> +
> +static void verify_tree(struct repository *repo,
> +			const struct object_id *new_tree_oid,
> +			const struct oid_array *base_trees,

I think `base_trees` is a bit of a confusing term, as I think those
always are the parent's trees, right? Should we maybe name it
accordingly?

> +			struct verify_state *vs, int depth)
> +{
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +	struct work_item *work = NULL;
> +	size_t nr_work = 0, alloc_work = 0;
> +	int need_subtree_bases = 0;

Nit: this should be a `bool`.

> +	size_t i, tree_size;
> +	void *tree_buf;
> +
> +	if (depth > repo->settings.max_allowed_tree_depth)
> +		die(_("exceeded maximum allowed tree depth"));
> +
> +	if (tree_map_get(vs->trees, new_tree_oid) >= TREE_TRUSTED)
> +		return;
> +
> +	tree_buf = read_tree_object(repo->objects, new_tree_oid, &tree_size);
> +	if (!tree_buf) {
> +		if (vs->exclude_promisor_objects &&
> +		    is_promisor_object(repo, new_tree_oid))
> +			return;
> +		die(_("bad tree object %s"),
> +		    oid_to_hex(new_tree_oid));
> +	}
> +
> +	vs->trees_loaded++;
> +	init_tree_desc(&desc, new_tree_oid, tree_buf, tree_size);
> +
> +	while (tree_entry(&desc, &entry)) {
> +		if (S_ISGITLINK(entry.mode))
> +			continue;
> +		if (S_ISDIR(entry.mode)) {
> +			if (tree_map_get(vs->trees, &entry.oid) >= TREE_TRUSTED)
> +				continue;
> +			need_subtree_bases = 1;
> +		} else {
> +			if (oidset_contains(&vs->trusted_blobs, &entry.oid))
> +				continue;
> +		}
> +		ALLOC_GROW(work, nr_work + 1, alloc_work);
> +		memset(&work[nr_work], 0, sizeof(work[nr_work]));
> +		work[nr_work].entry = entry;
> +		nr_work++;
> +	}

Okay, so first we gather all the tree entries that need verification
becaues we don't trust them yet.

> +
> +	if (!nr_work) {
> +		free(tree_buf);
> +		goto done;
> +	}
> +
> +	for (i = 0; base_trees && i < base_trees->nr; i++) {
> +		const struct object_id *base_oid = &base_trees->oid[i];
> +		int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
> +		struct tree_desc base_desc;
> +		struct name_entry scan_entry;
> +		size_t wi = 0, base_size;
> +		void *base_buf;
> +
> +		if (expanded && !need_subtree_bases)
> +			continue;
> +
> +		base_buf = read_tree_object(repo->objects, base_oid,
> +					    &base_size);
> +		if (!base_buf) {
> +			if (vs->exclude_promisor_objects &&
> +			    is_promisor_object(repo, base_oid))
> +				continue;
> +			die(_("bad tree object %s"),
> +			    oid_to_hex(base_oid));
> +		}
> +
> +		vs->trees_loaded++;
> +		init_tree_desc(&base_desc, base_oid, base_buf, base_size);
> +
> +		while (tree_entry(&base_desc, &scan_entry)) {
> +			if (S_ISGITLINK(scan_entry.mode))
> +				continue;
> +
> +			if (need_subtree_bases)
> +				wi = collect_subtree_bases(work, nr_work,
> +							   wi, &scan_entry);
> +
> +			if (!expanded) {
> +				if (S_ISDIR(scan_entry.mode))
> +					tree_map_add(vs->trees,
> +						     &scan_entry.oid,
> +						     TREE_TRUSTED);
> +				else
> +					oidset_insert(&vs->trusted_blobs,
> +						      &scan_entry.oid);
> +			}
> +		}
> +
> +		if (!expanded)
> +			tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
> +
> +		free(base_buf);
> +	}

Then we expand all of our parent trees to exand the trust boundary. I
think this part is rather non-obvious though, and could really use some
code comments to explain what's even going on here.

> +	for (i = 0; i < nr_work; i++) {
> +		if (S_ISDIR(work[i].entry.mode))
> +			verify_tree(repo, &work[i].entry.oid,
> +				    &work[i].parent_trees, vs,
> +				    depth + 1);

And here we then recurse. The recursion isn't unbounded, but we may go
up to 2048 layers deep here. We already do this recursively in other
places, but I do wonder whether we can maybe avoid the recursion and
instead use a work queue so that we don't bust the stack.

> +		else
> +			verify_blob(repo, &work[i].entry.oid, vs);
> +	}
> +
> +	free(tree_buf);
> +
> +done:
> +	tree_map_add(vs->trees, new_tree_oid, TREE_EXPANDED);
> +	for (i = 0; i < nr_work; i++)
> +		oid_array_clear(&work[i].parent_trees);
> +	free(work);
> +}
> +
> +static void verify_commit_tree(struct repository *repo,
> +			       struct commit *commit,
> +			       struct verify_state *vs)
> +{
> +	struct oid_array base_trees = OID_ARRAY_INIT;
> +	const struct object_id *tree_oid;
> +	struct commit_list *p;
> +
> +	/*
> +	 * Parent trees are trusted: boundary parents are already
> +	 * connected, and earlier incoming parents were verified
> +	 * first due to the topological processing order.
> +	 */

Okay. Parents are trusted because we go from oldest to newest in
topological order.

> +	for (p = commit->parents; p; p = p->next) {
> +		parse_commit_or_die(p->item);

This part here may die in case the repository is a partial clone with
missing commits because we enforce that `fetch_if_missing` is disabled.

> +		tree_oid = get_commit_tree_oid(p->item);
> +		if (!tree_oid)
> +			die(_("unable to load root tree for commit %s"),
> +			    oid_to_hex(&p->item->object.oid));
> +		tree_map_add(vs->trees, tree_oid, TREE_TRUSTED);
> +		oid_array_append(&base_trees, tree_oid);

And we only mark those trees as TRUSTED, not EXPANDED, as we didn't read
the trees themselves.

> +	}
> +
> +	tree_oid = get_commit_tree_oid(commit);
> +	if (!tree_oid)
> +		die(_("unable to load root tree for commit %s"),
> +		    oid_to_hex(&commit->object.oid));
> +	verify_tree(repo, tree_oid, &base_trees, vs, 0);

And this function here recursively verifies the root tree itself.

> +	oid_array_clear(&base_trees);
> +}
> +
> +void verify_commits_incremental(struct repository *repo,
> +				struct commit_list **commits,
> +				int exclude_promisor_objects)
> +{
> +	struct verify_state vs = { 0 };
> +	struct commit_list *iter;
> +	unsigned nr_before;
> +
> +	if (repo->fetch_if_missing)
> +		BUG("verify_commits_incremental must not be called "
> +		    "with fetch_if_missing set");
> +
> +	vs.trees = kh_init_oid_tree();
> +	vs.exclude_promisor_objects = exclude_promisor_objects;
> +
> +	/*
> +	 * Ancestors must be verified before descendants so that parent
> +	 * trees can be trusted without re-verification.  Sort explicitly
> +	 * rather than relying on the caller's ordering.
> +	 *
> +	 * sort_in_topological_order() silently drops cycle members,
> +	 * so explicitly check if the size has changed.
> +	 */
> +	nr_before = commit_list_count(*commits);
> +	sort_in_topological_order(commits, REV_SORT_IN_GRAPH_ORDER);
> +	if (commit_list_count(*commits) < nr_before)
> +		die(_("cycle detected in incoming commit graph"));
> +
> +	*commits = commit_list_reverse(*commits);
> +
> +	for (iter = *commits; iter; iter = iter->next)
> +		verify_commit_tree(repo, iter->item, &vs);
> +
> +	kh_destroy_oid_tree(vs.trees);
> +	oidset_clear(&vs.trusted_blobs);
> +	trace2_data_intmax("connectivity", repo,
> +			   "trees_loaded", vs.trees_loaded);
> +	trace2_data_intmax("connectivity", repo,
> +			   "blobs_checked", vs.blobs_checked);
> +}

Thanks!

Patrick
