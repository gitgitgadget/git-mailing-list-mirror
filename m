Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FF29827E
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462155; cv=none; b=bwLYgEpy49CcNgrSKx3vPf+wPn8TdfRmDfyJFkkNq4yxLjTTHERcFYIIAkwxTy8ZDI9AkUHa81fPNXsXEEsH5HODYEu/ZDSYXeoRkgE0cN9X1FA3a5vZGYmF9BNJ5vH3J6hv/iVcYQxkW3ygFT/4WH3S0eGZAZ2gc4E+x1YXv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462155; c=relaxed/simple;
	bh=+WFYoh24bIyRNU+L1ZzrnxuJDLyISvyOaIE6Juzq5b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eNS/0sIg2g6CDEQiqifmuyqop8UN/Lz4IjdEa3/Ald9xm7a1+nx/VLD0A3wme7X32mlPtC/YbvcQqkPAmONJMZu2ManvG4DjDWu9zOnF8mepOlzFNMoFSufiXIB1Ba0QimAQKT80cncxEOojm78KQh5bwGFjytYMXRuUZbk4BYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=okA1jI8+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRg8wU8l; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="okA1jI8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRg8wU8l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 255BF7A00F4;
	Fri, 17 Apr 2026 17:42:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 17 Apr 2026 17:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776462152;
	 x=1776548552; bh=pCNE1O5dPZuGsfp9DfgClFyphOlzWXQRQ+yUBukwuqE=; b=
	okA1jI8+M2RFtGLj3rBVKNo8aWFz8DHNZyDprjbDP4Xhfyt1hnnFKuKClB0zEAdg
	NUcvEUN8zwW8IYRCk7SJRGEeifaNxGyWbyTa6sIu4ICTHtavdo3XSFVPrVR12x2z
	bMMolSTjtS9tR4HLjtyXBhxTtMnVuW8HIT1Uktiu+Uo0OXKX3SxOtIvQyYfHHFnW
	ZBBU/QZUOBB3iZXqG5+iAp57kWQFDV3SBaIt+b5eYQ1hOW6zqqXFgHuRHa/qic8p
	dWbxlumOrG85MgTd/guGnNpA1djh6bpJkK5X9oGlXHxlEzt2TNtTtQ8UaV8DRSQx
	ry2gVrH0Hstazyviy/XZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776462152; x=
	1776548552; bh=pCNE1O5dPZuGsfp9DfgClFyphOlzWXQRQ+yUBukwuqE=; b=j
	Rg8wU8l67dJkfiaCJr0IkNf818s4cuj+EjLXUDrilsRnhH+KQUTjEuoxFfBx10Sw
	kIsYYUvP79kwupDIsotO87ZXIpgSSTpxJvX4UQx12UfF0ZapuSDMHkHTBpwOLcDA
	KvCohXytUTGIOnh2ZAV37c7VZmR5Tdy0zLgs66M2vc0WZlxmczMpcd/njUHZH7P1
	U+PcFuul4h/nNxGOdm07g9aUNK5KhqbcW25T6R9ZuvxXExiIa7bAyBgeEj8g1ehB
	9WRCePpo1iRQu0nxKiY4cTHDN6m/CEbK8eOn6ATPqhRScH2LG01GcG7tthY5oAsw
	xlAYR7FKSHmd0CYvk3ckA==
X-ME-Sender: <xms:R6niafokESYHViA0laUYeIH9mK6GW1OlMWr3CmEECgbsHPaORrf2MQ>
    <xme:R6niaQobLOIm2Q5yMhH0Dng5OfpDn3Qmdab5DdcGz-s-mrqaZB1Ov_MnUnI_gD-DX
    OHFZlhGwcAr-ZDLTNdTDXH-BzmTFfis6DNTdtzZJxEGXRh41O6zIB0>
X-ME-Received: <xmr:R6niaRONNPR1MI4fQTpDSCPfewcN6pHdq8_R39GKY1cFVH0rWOxJfr_2H9j1oi2tDF_zCOvcFmc32X23AgwZSAAgbNsetVYsUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:R6niaRwxw5ElLcDlcr3ndayfr3dJZkrQEyzb7TvPK6iIRaXHXGfX7A>
    <xmx:R6niaatGTKmHzxs4YnDjkCqPF_C0P3K4HzZl-5GEY18oSq0x0D7Q0Q>
    <xmx:R6niaa4GMltfqmPEUclVNIiG0l0JI4RZv2EkOycgShFXmfsbW9yu8Q>
    <xmx:R6niaZQ_oFph40B7vlCoBkuN663CW22-WVN23l0VoHsGta6WJkcAQg>
    <xmx:SKniaQupMOrmmxOeTqKCXf6K5amOXm5daS99Lugrz1eEKLOPFNlawLYu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 17:42:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] builtin/log: prefetch necessary blobs for `git cherry`
In-Reply-To: <610be2a49a17620b2e5cfd3b7d9d38977ef77afb.1776379694.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Thu, 16 Apr 2026
	22:48:13 +0000")
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
	<610be2a49a17620b2e5cfd3b7d9d38977ef77afb.1776379694.git.gitgitgadget@gmail.com>
Date: Fri, 17 Apr 2026 14:42:30 -0700
Message-ID: <xmqqbjfhw9fd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In partial clones, `git cherry` fetches necessary blobs on-demand one
> at a time, which can be very slow.  We would like to prefetch all
> necessary blobs upfront.  To do so, we need to be able to first figure
> out which blobs are needed.
>
> `git cherry` does its work in a two-phase approach: first computing
> header-only IDs (based on file paths and modes), then falling back to
> full content-based IDs only when header-only IDs collide -- or, more
> accurately, whenever the oidhash() of the header-only object_ids
> collide.
>
> patch-ids.c handles this by creating an ids->patches hashmap that has
> all the data we need, but the problem is that any attempt to query the
> hashmap will invoke the patch_id_neq() function on any colliding objects,
> which causes the on-demand fetching.
>
> Insert a new prefetch_cherry_blobs() function before checking for
> collisions.  Use a temporary replacement on the ids->patches.cmpfn
> in order to enumerate the blobs that would be needed without yet
> fetching them, and then fetch them all at once, then restore the old
> ids->patches.cmpfn.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/log.c                                 | 125 +++++++++++
>  investigations/cherry-prefetch-design-spec.md | 210 ++++++++++++++++++

Did you mean to add this file to the project?  As a document to
describe how "git cherry" works, it is vastly lacking, and once this
series lands, I am not sure how others would benefit from being able
to read it.  Many of the materials in there seem to typically be given
in the log message, but not to this degree of details, so I am not
sure where it belongs.

>  t/t3500-cherry.sh                             |  18 ++
>  3 files changed, 353 insertions(+)
>  create mode 100644 investigations/cherry-prefetch-design-spec.md
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8c0939dd42..df19876be6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -21,10 +21,12 @@
>  #include "color.h"
>  #include "commit.h"
>  #include "diff.h"
> +#include "diffcore.h"
>  #include "diff-merges.h"
>  #include "revision.h"
>  #include "log-tree.h"
>  #include "oid-array.h"
> +#include "oidset.h"
>  #include "tag.h"
>  #include "reflog-walk.h"
>  #include "patch-ids.h"
> @@ -43,9 +45,11 @@
>  #include "utf8.h"
>  
>  #include "commit-reach.h"
> +#include "promisor-remote.h"
>  #include "range-diff.h"
>  #include "tmp-objdir.h"
>  #include "tree.h"
> +#include "userdiff.h"
>  #include "write-or-die.h"
>  
>  #define MAIL_DEFAULT_WRAP 72
> @@ -2602,6 +2606,125 @@ static void print_commit(char sign, struct commit *commit, int verbose,
>  	}
>  }
>  
> +/*
> + * Enumerate blob OIDs from a single commit's diff, inserting them into blobs.
> + * Skips files whose userdiff driver explicitly declares binary status
> + * (drv->binary > 0), since patch-ID uses oid_to_hex() for those and
> + * never reads blob content.  Use userdiff_find_by_path() since
> + * diff_filespec_load_driver() is static in diff.c.
> + *
> + * Clean up with diff_queue_clear() (from diffcore.h).
> + */
> +static void collect_diff_blob_oids(struct commit *commit,
> +				   struct diff_options *opts,
> +				   struct oidset *blobs)
> +{
> +	struct diff_queue_struct *q;
> +
> +	/*
> +	 * Merge commits are filtered out by patch_id_defined() in patch-ids.c,
> +	 * so we'll never be called with one.
> +	 */
> +	assert(!commit->parents || !commit->parents->next);
> +
> +	if (commit->parents)
> +		diff_tree_oid(&commit->parents->item->object.oid,
> +			      &commit->object.oid, "", opts);
> +	else
> +		diff_root_tree_oid(&commit->object.oid, "", opts);
> +	diffcore_std(opts);
> +
> +	q = &diff_queued_diff;
> +	for (int i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		struct userdiff_driver *drv;
> +
> +		/* Skip binary files */
> +		drv = userdiff_find_by_path(opts->repo->index, p->one->path);
> +		if (drv && drv->binary > 0)
> +			continue;
> +
> +		if (DIFF_FILE_VALID(p->one))
> +			oidset_insert(blobs, &p->one->oid);
> +		if (DIFF_FILE_VALID(p->two))
> +			oidset_insert(blobs, &p->two->oid);
> +	}
> +	diff_queue_clear(q);
> +}
> +
> +static int always_match(const void *cmp_data UNUSED,
> +			const struct hashmap_entry *entry1 UNUSED,
> +			const struct hashmap_entry *entry2 UNUSED,
> +			const void *keydata UNUSED)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Prefetch blobs for git cherry in partial clones.
> + *
> + * Called between the revision walk (which builds the head-side
> + * commit list) and the has_commit_patch_id() comparison loop.
> + *
> + * Uses a cmpfn-swap trick to avoid reading blobs: temporarily
> + * replaces the hashmap's comparison function with a trivial
> + * always-match function, so hashmap_get()/hashmap_get_next() match
> + * any entry with the same oidhash bucket.  These are the set of oids
> + * that would trigger patch_id_neq() during normal lookup and cause
> + * blobs to be read on demand, and we want to prefetch them all at
> + * once instead.
> + */
> +static void prefetch_cherry_blobs(struct repository *repo,
> +				  struct commit_list *list,
> +				  struct patch_ids *ids)
> +{
> +	struct oidset blobs = OIDSET_INIT;
> +	hashmap_cmp_fn original_cmpfn;
> +
> +	/* Exit if we're not in a partial clone */
> +	if (!repo_has_promisor_remote(repo))
> +		return;
> +
> +	/* Save original cmpfn, replace with always_match */
> +	original_cmpfn = ids->patches.cmpfn;
> +	ids->patches.cmpfn = always_match;
> +
> +	/* Find header-only collisions, gather blobs from those commits */
> +	for (struct commit_list *l = list; l; l = l->next) {
> +		struct commit *c = l->item;
> +		bool match_found = false;
> +		for (struct patch_id *cur = patch_id_iter_first(c, ids);
> +		     cur;
> +		     cur = patch_id_iter_next(cur, ids)) {
> +			match_found = true;
> +			collect_diff_blob_oids(cur->commit, &ids->diffopts,
> +					       &blobs);
> +		}
> +		if (match_found)
> +			collect_diff_blob_oids(c, &ids->diffopts, &blobs);
> +	}
> +
> +	/* Restore original cmpfn */
> +	ids->patches.cmpfn = original_cmpfn;
> +
> +	/* If we have any blobs to fetch, fetch them */
> +	if (oidset_size(&blobs)) {
> +		struct oid_array to_fetch = OID_ARRAY_INIT;
> +		struct oidset_iter iter;
> +		const struct object_id *oid;
> +
> +		oidset_iter_init(&blobs, &iter);
> +		while ((oid = oidset_iter_next(&iter)))
> +			oid_array_append(&to_fetch, oid);
> +
> +		promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr);
> +
> +		oid_array_clear(&to_fetch);
> +	}
> +
> +	oidset_clear(&blobs);
> +}
> +
>  int cmd_cherry(int argc,
>  	       const char **argv,
>  	       const char *prefix,
> @@ -2673,6 +2796,8 @@ int cmd_cherry(int argc,
>  		commit_list_insert(commit, &list);
>  	}
>  
> +	prefetch_cherry_blobs(the_repository, list, &ids);
> +
>  	for (struct commit_list *l = list; l; l = l->next) {
>  		char sign = '+';
>  
> diff --git a/investigations/cherry-prefetch-design-spec.md b/investigations/cherry-prefetch-design-spec.md
> new file mode 100644
> index 0000000000..a499d9538e
> --- /dev/null
> +++ b/investigations/cherry-prefetch-design-spec.md
> @@ -0,0 +1,210 @@
> +# Design Spec: Batch Blob Prefetch for `git cherry` in Partial Clones
> +
> +## Problem
> +
> +In a partial clone with `--filter=blob:none`, `git cherry` compares
> +commits using patch IDs.  Patch IDs are computed in two phases:
> +
> +1. Header-only: hashes file paths and mode changes only (no blob reads)
> +2. Full: hashes actual diff content (requires reading blobs)
> +
> +Phase 2 only runs when two commits have matching header-only IDs
> +(i.e. they modify the same set of files with the same modes).  This
> +is common — any two commits touching the same file(s) will collide.
> +
> +When phase 2 needs a blob that isn't local, it triggers an on-demand
> +promisor fetch.  Each fetch is a separate network round-trip.  With
> +many collisions, this means many sequential fetches.
> +
> +## Solution Overview
> +
> +Add a preparatory pass before the existing comparison loop in
> +`cmd_cherry()` that:
> +
> +1. Identifies which commit pairs will collide on header-only IDs
> +2. Collects all blob OIDs those commits will need
> +3. Batch-prefetches them in one fetch
> +
> +After this pass, the existing comparison loop runs as before, but
> +all needed blobs are already local, so no on-demand fetches occur.
> +
> +## Detailed Design
> +
> +### 1. No struct changes to patch_id
> +
> +The existing `struct patch_id` and `patch_id_neq()` are not
> +modified.  `is_null_oid()` remains the sentinel for "full ID not
> +yet computed".  No `has_full_patch_id` boolean, no extra fields.
> +
> +Key insight: `init_patch_id_entry()` stores only `oidhash()` (the
> +first 4 bytes of the header-only ID) in the hashmap bucket key.
> +The real `patch_id_neq()` comparison function is invoked only when
> +`hashmap_get()` or `hashmap_get_next()` finds entries with a
> +matching oidhash — and that comparison triggers blob reads.
> +
> +The prefetch needs to detect exactly those oidhash collisions
> +*without* triggering blob reads.  We achieve this by temporarily
> +swapping the hashmap's comparison function.
> +
> +### 2. The prefetch function (in builtin/log.c)
> +
> +This function takes the repository, the head-side commit list (as
> +built by the existing revision walk in `cmd_cherry()`), and the
> +patch_ids structure (which contains the upstream entries).
> +
> +#### 2.1 Early exit
> +
> +If the repository has no promisor remote, return immediately.
> +Use `repo_has_promisor_remote()` from promisor-remote.h.
> +
> +#### 2.2 Swap in a trivial comparison function
> +
> +Save `ids->patches.cmpfn` (the real `patch_id_neq`) and replace
> +it with a trivial function that always returns 0 ("equal").
> +
> +```
> +static int patch_id_match(const void *unused_cmpfn_data,
> +                          const struct hashmap_entry *a,
> +                          const struct hashmap_entry *b,
> +                          const void *unused_keydata)
> +{
> +    return 0;
> +}
> +```
> +
> +With this cmpfn in place, `hashmap_get()` and `hashmap_get_next()`
> +will match every entry in the same oidhash bucket — exactly the
> +same set that would trigger `patch_id_neq()` during normal lookup.
> +No blob reads occur because we never call the real comparison
> +function.
> +
> +#### 2.3 For each head-side commit, probe for collisions
> +
> +For each commit in the head-side list:
> +
> +- Use `patch_id_iter_first(commit, ids)` to probe the upstream
> +  hashmap.  This handles `init_patch_id_entry()` + hashmap lookup
> +  internally.  With our swapped cmpfn, it returns any upstream
> +  entry whose oidhash matches — i.e. any entry that *would*
> +  trigger `patch_id_neq()` during the real comparison loop.
> +  (Merge commits are already handled — `patch_id_iter_first()`
> +  returns NULL for them via `patch_id_defined()`.)
> +- If there's a match: collect blob OIDs from the head-side commit
> +  (see section 3).
> +- Then walk `patch_id_iter_next()` to find ALL upstream entries
> +  in the same bucket.  For each, collect blob OIDs from that
> +  upstream commit too.  (Multiple upstream commits can share the
> +  same oidhash bucket.)
> +- Collect blob OIDs from the first upstream match too (from
> +  `patch_id_iter_first()`).
> +
> +We need blobs from BOTH sides because `patch_id_neq()` computes
> +full patch IDs for both the upstream and head-side commit when
> +comparing.
> +
> +#### 2.4 Restore the original comparison function
> +
> +Set `ids->patches.cmpfn` back to the saved value (patch_id_neq).
> +This MUST happen before returning — the subsequent
> +`has_commit_patch_id()` loop needs the real comparison function.
> +
> +#### 2.5 Batch prefetch
> +
> +If the oidset is non-empty, populate an oid_array from it using
> +`oidset_iter_first()`/`oidset_iter_next()`, then call
> +`promisor_remote_get_direct(repo, oid_array.oid, oid_array.nr)`.
> +
> +This is a single network round-trip regardless of how many blobs.
> +
> +#### 2.6 Cleanup
> +
> +Free the oid_array and the oidset.
> +
> +### 3. Collecting blob OIDs from a commit (helper function)
> +
> +Given a commit, enumerate the blobs its diff touches.  Takes an
> +oidset to insert into (provides automatic dedup — consecutive
> +commits often share blob OIDs, e.g. B:foo == C^:foo when C's
> +parent is B).
> +
> +- Compute the diff: `diff_tree_oid()` for commits with a parent,
> +  `diff_root_tree_oid()` for root commits.  Then `diffcore_std()`.
> +- These populate the global `diff_queued_diff` queue.
> +- For each filepair in the queue:
> +  - Check the userdiff driver for the file path.  If the driver
> +    explicitly declares the file as binary (`drv->binary != -1`),
> +    skip it.  Reason: patch-ID uses `oid_to_hex()` for binary
> +    files (see diff.c around line 6652) and never reads the blob.
> +    Use `userdiff_find_by_path()` (NOT `diff_filespec_load_driver`
> +    which is static in diff.c).
> +  - For both sides of the filepair (p->one and p->two): if the
> +    side is valid (`DIFF_FILE_VALID`) and has a non-null OID,
> +    check the dedup oidset — `oidset_insert()` handles dedup
> +    automatically (returns 1 if newly inserted, 0 if duplicate).
> +- Clear the diff queue with `diff_queue_clear()` (from diffcore.h,
> +  not diff.h).
> +
> +Note on `drv->binary`: The value -1 means "not set" (auto-detect
> +at read time by reading the blob); 0 means explicitly text (will
> +be diffed, blob reads needed); positive means explicitly binary
> +(patch-ID uses `oid_to_hex()`, no blob read needed).
> +
> +The correct skip condition is `drv && drv->binary > 0` — skip
> +only known-binary files.  Do NOT use `drv->binary != -1`, which
> +would also skip explicitly-text files that DO need blob reads.
> +(The copilot reference implementation uses `!= -1`, which is
> +technically wrong but harmless in practice since explicit text
> +attributes are rare.)
> +
> +### 4. Call site in cmd_cherry()
> +
> +Insert the call between the revision walk loop (which builds the
> +head-side commit list) and the comparison loop (which calls
> +`has_commit_patch_id()`).
> +
> +### 5. Required includes in builtin/log.c
> +
> +- promisor-remote.h  (for repo_has_promisor_remote,
> +                       promisor_remote_get_direct)
> +- userdiff.h         (for userdiff_find_by_path)
> +- oidset.h           (for oidset used in blob OID dedup)
> +- diffcore.h         (for diff_queue_clear)
> +
> +## Edge Cases
> +
> +- No promisor remote: early return, zero overhead
> +- No collisions: probes the hashmap for each head-side commit but
> +  finds no bucket matches, no blobs collected, no fetch issued
> +- Merge commits in head-side list: skipped (no patch ID defined)
> +- Root commits (no parent): use diff_root_tree_oid instead of
> +  diff_tree_oid
> +- Binary files (explicit driver): skipped, patch-ID doesn't read
> +  them
> +- The cmpfn swap approach matches at oidhash granularity (4 bytes),
> +  which is exactly what the hashmap itself uses to trigger
> +  patch_id_neq().  This means we prefetch for every case the real
> +  code would trigger, plus rare false-positive oidhash collisions
> +  (harmless: we fetch a few extra blobs that won't end up being
> +  compared).  No under-fetching is possible.
> +
> +## Testing
> +
> +See t/t3500-cherry.sh on the copilot-faster-partial-clones branch
> +for two tests:
> +
> +Test 5: "cherry batch-prefetches blobs in partial clone"
> +  - Creates server with 3 upstream + 3 head-side commits modifying
> +    the same file (guarantees collisions)
> +  - Clones with --filter=blob:none
> +  - Runs `git cherry` with GIT_TRACE2_PERF
> +  - Asserts exactly 1 fetch (batch) instead of 6 (individual)
> +
> +Test 6: "cherry prefetch omits blobs for cherry-picked commits"
> +  - Creates a cherry-pick scenario (divergent branches, shared
> +    commit cherry-picked to head side)
> +  - Verifies `git cherry` correctly identifies the cherry-picked
> +    commit as "-" and head-only commits as "+"
> +  - Important: the head side must diverge before the cherry-pick
> +    so the cherry-pick creates a distinct commit object (otherwise
> +    the commit hash is identical and it's in the symmetric
> +    difference, not needing patch-ID comparison at all)
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index 78c3eac54b..17507d9a28 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -78,4 +78,22 @@ test_expect_success 'cherry ignores whitespace' '
>  	test_cmp expect actual
>  '
>  
> +# Reuse the expect file from the previous test, in a partial clone
> +test_expect_success 'cherry in partial clone does bulk prefetch' '
> +	test_config uploadpack.allowfilter 1 &&
> +	test_config uploadpack.allowanysha1inwant 1 &&
> +	test_when_finished "rm -rf copy" &&
> +
> +	git clone --bare --filter=blob:none file://"$(pwd)" copy &&
> +	(
> +		cd copy &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace.output" git cherry upstream-with-space feature-without-space >actual &&
> +		test_cmp ../expect actual &&
> +
> +		grep "child_start.*fetch.negotiationAlgorithm" trace.output >fetches &&
> +		test_line_count = 1 fetches &&
> +		test_trace2_data promisor fetch_count 4 <trace.output
> +	)
> +'
> +
>  test_done
