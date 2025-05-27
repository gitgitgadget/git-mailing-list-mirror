Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B02475E3
	for <git@vger.kernel.org>; Tue, 27 May 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342402; cv=none; b=rBK7vnLH3gDRdWlwceeCXeP7d/FQ2hToVe1/NDSph/iNem+iMr53duDziv4QAnueFNkhREL9mHHpw7WeKFH77sWmmpfdKWw/NCQI70mrcEoSXRNGj6GQGAi0U/AK3AuDg293jJjkb236K4mP0dOjJ68FyJMxvfKAJbr7VaDQijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342402; c=relaxed/simple;
	bh=s40A90ZgB5bhJlgK0Cw6LSVXEE8snH3QB2Pn4tlNGXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdORkWyPGS3tSmCuYw0WHa0A0NUWuVUfOp2GfRIsNjXoqLgYORyxQ6wp9UkivekidQvvQ8MyaJJQaKRZ39PraMaiXZG1x9ZPbhrc5Ilx7Cwhy+JMtfDIhplZu3MnLePR5BuR/rzHlfwlaqLslj3DdVgLL3nIRzd2/CU9co1Q7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OeSMEO97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T8Gy6a6v; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OeSMEO97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8Gy6a6v"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BE55114010A;
	Tue, 27 May 2025 06:39:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 06:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748342398; x=1748428798; bh=lEpX+lRC73
	5QX0bBztQtSFC/mrWNn4g9aVHDRN0ecBI=; b=OeSMEO97oC03MzPE1/IbglXMvf
	lHjh2lTFJ2edJq2nuR9ga5JaagvHKAHbnnH7Zl3sP75OTzC0P3eZS5wDenC/gU1p
	zi9Bk5mHOQiOGek5COjO8dZu0XtWdCd9bbQUy4fMFIULpTJG/ghfjTt9ofvEGFbl
	BWgvfNXec8PgVuHTBfoRyAUsHu+gmlskq4H5vveGn6J25fZQ1yGPkkS2274pI5l1
	ytyXrdDYuMi4uDvCBOFmjJ/VDhovlg7tfYsgYNyltyZ0sH2tVsIEPe5KJsYkBGOw
	32MAs28okC6541iIkGdE6oNrhWbj8c93pPZVlEecatqD7yOBkiwuvvZ+vIzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748342398; x=1748428798; bh=lEpX+lRC735QX0bBztQtSFC/mrWNn4g9aVH
	DRN0ecBI=; b=T8Gy6a6volTFK6aLSTrwovCjpSwWj/ZzPXPvm69nlzemGeQVt6L
	aeIUJuDBr2AHzz5zg3zPDtpRWNVEd3xCUog/ehlqgdV9wejuM5oIwH3cXGODfens
	9zInXpJ3yoZx4xnKlPNX3NEieeE9NAdrsRTwboiHT48niAkCwfVekY5V0/6bFwYd
	2PDtqIOwLSDzOuyPrk76M00yk/fdpuGLWgyg/Yz3nVq0kMF2LTQwEkb9TMElYIbO
	tu8I232TBaYYSP9T33IbTP9GChGBkNNlqmtdsBb6N5VLSlVfZfdxjPXT9p1Ud2nE
	TIFUW3tsdUoCyts7t0lDageW1uNRPSWEeDA==
X-ME-Sender: <xms:fZY1aOSob1X-fqIa2MtsdL10y7f60CuaII4_jnqiRjPvglTj-k8PzA>
    <xme:fZY1aDzdbWQYrm93MYKujpmokMkUid13LhALISOj1E_gAUL3UI-bwOXYwV5WQkXzD
    zQUT6E900c4GJXEGA>
X-ME-Received: <xmr:fZY1aL1yO2qIXtgp3t_Lz0yc7vrzRnRCxU4rW4oCsFp_KCfkuPnAZJ8xZXo9daXFxBFVPl5ZNdpa7uB2t9vSwLSJYbGSHR2hClRyID4GNlYOwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdduieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevlefggfekkefhtddv
    leegtdefueethedtvdeujeeuheeluddvveegleehhfegfeenucffohhmrghinhepphgvnh
    guihhnghdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprghvrghrrggssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:fZY1aKAUhZVLeRsrmMZ7sblCNJiQUp2GITWwJpDuLVzthrzk69JMyQ>
    <xmx:fZY1aHhM9Tm8ww84TsdWbO3EHHLZGGxemriwaoRcip4lbzlB7h5HsQ>
    <xmx:fZY1aGr7qx-AqIBGAMu8MgLSDba76Fp9h_QNt4QZMXst5zJM7NMzyg>
    <xmx:fZY1aKjZcCQeTAHfF9Ld-AdAvqUHmRgX09R9qVy6BqQBsnid5Be5ow>
    <xmx:fpY1aLoE08ayG83lkj_WKk82VsU52oBSKeSptQ1sQgHbvhyMu8rlu-V6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 06:39:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36ff425c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 10:39:56 +0000 (UTC)
Date: Tue, 27 May 2025 12:39:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 1/5] last-modified: new subcommand to show when
 files were last modified
Message-ID: <aDWWe6qCQXorPESd@pks.im>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>

On Fri, May 23, 2025 at 11:33:48AM +0200, Toon Claes wrote:
> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
> new file mode 100644
> index 0000000000..1af38f402e
> --- /dev/null
> +++ b/Documentation/git-last-modified.adoc
> @@ -0,0 +1,49 @@
> +git-last-modified(1)
> +====================
> +
> +NAME
> +----
> +git-last-modified - EXPERIMENTAL: Show when files were last modified

Nit: we don't have the EXPERIMENTAL label here for git-switch(1) or
git-restore(1).

> +
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git last-modified [-r] [<revision-range>] [[--] <path>...]
> +
> +DESCRIPTION
> +-----------
> +
> +Shows which commit last modified each of the relevant files and subdirectories.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +OPTIONS
> +-------
> +
> +-r::
> +	Recurse into subtrees.
> +
> +-t::
> +	Show tree entry itself as well as subtrees.  Implies `-r`.

These flags aren't yet supported in this version, are they?

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> new file mode 100644
> index 0000000000..0d4733f666
> --- /dev/null
> +++ b/builtin/last-modified.c
> @@ -0,0 +1,43 @@
> +#include "git-compat-util.h"
> +#include "last-modified.h"
> +#include "hex.h"
> +#include "quote.h"
> +#include "config.h"
> +#include "object-name.h"
> +#include "parse-options.h"
> +#include "builtin.h"
> +
> +static void show_entry(const char *path, const struct commit *commit, void *d)
> +{
> +	struct last_modified *lm = d;
> +
> +	if (commit->object.flags & BOUNDARY)
> +		putchar('^');
> +	printf("%s\t", oid_to_hex(&commit->object.oid));
> +
> +	if (lm->rev.diffopt.line_termination)
> +		write_name_quoted(path, stdout, '\n');
> +	else
> +		printf("%s%c", path, '\0');
> +
> +	fflush(stdout);
> +}
> +
> +int cmd_last_modified(int argc,
> +		   const char **argv,
> +		   const char *prefix,
> +		   struct repository *repo)
> +{
> +	int ret = 0;

`ret` is basically unused here, we only use it to return 0.

> diff --git a/last-modified.c b/last-modified.c
> new file mode 100644
> index 0000000000..9283f8fcae
> --- /dev/null
> +++ b/last-modified.c
> @@ -0,0 +1,213 @@
> +#include "git-compat-util.h"
> +#include "last-modified.h"
> +#include "commit.h"
> +#include "diffcore.h"
> +#include "diff.h"
> +#include "object.h"
> +#include "revision.h"
> +#include "repository.h"
> +#include "log-tree.h"
> +
> +struct last_modified_entry {
> +	struct hashmap_entry hashent;
> +	struct object_id oid;
> +	struct commit *commit;
> +	const char path[FLEX_ARRAY];
> +};
> +
> +static void add_from_diff(struct diff_queue_struct *q,
> +			  struct diff_options *opt UNUSED,
> +			  void *data)
> +{
> +	struct last_modified *lm = data;
> +
> +	for (int i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		struct last_modified_entry *ent;
> +		const char *path = p->two->path;
> +
> +		FLEX_ALLOC_STR(ent, path, path);
> +		oidcpy(&ent->oid, &p->two->oid);
> +		hashmap_entry_init(&ent->hashent, strhash(ent->path));
> +		hashmap_add(&lm->paths, &ent->hashent);
> +	}
> +}
> 
> +static int add_from_revs(struct last_modified *lm)
> +{
> +	size_t count = 0;
> +	struct diff_options diffopt;
> +
> +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
> +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
> +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	diffopt.format_callback = add_from_diff;
> +	diffopt.format_callback_data = lm;

As far as I understand we populate `paths` from the diff here, and
`paths` later on acts as a filter of paths we're interested in? Might be
nice to add a comment explaining the intent of this.

> +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
> +		struct object_array_entry *obj = lm->rev.pending.objects + i;
> +
> +		if (obj->item->flags & UNINTERESTING)
> +			continue;
> +
> +		if (count++)
> +			return error(_("can only get last-modified one tree at a time"));

It's a bit funny that `count` is pretending to be a counter even though
it ultimately is only a boolean flag whether we have already seen an
interesting item.

> +		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
> +			      &obj->item->oid, "", &diffopt);
> +		diff_flush(&diffopt);
> +	}
> +	clear_pathspec(&diffopt.pathspec);

Shouldn't we call `diff_free()` instead of `clear_pathspec` to clear the
whole `struct diff_options`?

> +
> +	return 0;
> +}
> +
> +static int last_modified_entry_hashcmp(const void *unused UNUSED,
> +				    const struct hashmap_entry *hent1,
> +				    const struct hashmap_entry *hent2,
> +				    const void *path)
> +{
> +	const struct last_modified_entry *ent1 =
> +		container_of(hent1, const struct last_modified_entry, hashent);
> +	const struct last_modified_entry *ent2 =
> +		container_of(hent2, const struct last_modified_entry, hashent);
> +	return strcmp(ent1->path, path ? path : ent2->path);
> +}
> +
> +void last_modified_init(struct last_modified *lm,
> +		     struct repository *r,
> +		     const char *prefix,
> +		     int argc, const char **argv)
> +{
> +	memset(lm, 0, sizeof(*lm));
> +	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
> +
> +	repo_init_revisions(r, &lm->rev, prefix);
> +	lm->rev.def = "HEAD";
> +	lm->rev.combine_merges = 1;
> +	lm->rev.show_root_diff = 1;
> +	lm->rev.boundary = 1;
> +	lm->rev.no_commit_id = 1;
> +	lm->rev.diff = 1;
> +	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
> +		die(_("unknown last-modified argument: %s"), argv[1]);
> +
> +	if (add_from_revs(lm) < 0)
> +		die(_("unable to setup last-modified"));

Given that this is library code, do we rather want to have
`last_modified_init()` return an error code and let the caller die?

> +}
> +
> +void last_modified_release(struct last_modified *lm)
> +{
> +	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
> +	release_revisions(&lm->rev);
> +}
> +
> +struct last_modified_callback_data {
> +	struct commit *commit;
> +	struct hashmap *paths;
> +
> +	last_modified_callback callback;
> +	void *callback_data;
> +};
> +
> +static void mark_path(const char *path, const struct object_id *oid,
> +		      struct last_modified_callback_data *data)
> +{
> +	struct last_modified_entry *ent;
> +
> +	/* Is it even a path that we are interested in? */
> +	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
> +					  struct last_modified_entry, hashent);
> +	if (!ent)
> +		return;

Yup, so this here is the filter to figure out whether we care for a
path, which uses the `paths` map we have populated at the beginning.

> +	/* Have we already found a commit? */
> +	if (ent->commit)
> +		return;

Can this case even be hit? We remove the entry from the map once we have
seen it, so I'd expect that we never hit the same commit map entry
twice. If so, can this be converted to a `BUG()` or am I missing the
obvious?

> +	/*
> +	 * Is it arriving at a version of interest, or is it from a side branch
> +	 * which did not contribute to the final state?
> +	 */
> +	if (!oideq(oid, &ent->oid))
> +		return;
> +
> +	ent->commit = data->commit;
> +	if (data->callback)
> +		data->callback(path, data->commit, data->callback_data);
> +
> +	hashmap_remove(data->paths, &ent->hashent, path);

And we end up removing that entry from paths so that we don't revisit it
in the future. After all, we're only interested in a single commit per
path.

> +	free(ent);
> +}
> +
> +static void last_modified_diff(struct diff_queue_struct *q,
> +		       struct diff_options *opt UNUSED, void *cbdata)
> +{
> +	struct last_modified_callback_data *data = cbdata;
> +
> +	for (int i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		switch (p->status) {
> +		case DIFF_STATUS_DELETED:
> +			/*
> +			 * There's no point in feeding a deletion, as it could
> +			 * not have resulted in our current state, which
> +			 * actually has the file.
> +			 */
> +			break;
> +
> +		default:
> +			/*
> +			 * Otherwise, we care only that we somehow arrived at
> +			 * a final path/sha1 state. Note that this covers some
> +			 * potentially controversial areas, including:
> +			 *
> +			 *  1. A rename or copy will be found, as it is the
> +			 *     first time the content has arrived at the given
> +			 *     path.
> +			 *
> +			 *  2. Even a non-content modification like a mode or
> +			 *     type change will trigger it.

Curious, but sensible. We're looking for the last time a specific tree
entry was changed, and that of course includes modifications. I could
totally see that we may eventually want to add a flag that ignores such
mode changes and only presents content changes. But for now I agree that
this is sensible.

> +			 * We take the inclusive approach for now, and find
> +			 * anything which impacts the path. Options to tweak
> +			 * the behavior (e.g., to "--follow" the content across
> +			 * renames) can come later.
> +			 */
> +			mark_path(p->two->path, &p->two->oid, data);
> +			break;
> +		}
> +	}
> +}
> +
> +int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
> +{
> +	struct last_modified_callback_data data;
> +
> +	data.paths = &lm->paths;
> +	data.callback = cb;
> +	data.callback_data = cbdata;
> +
> +	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	lm->rev.diffopt.format_callback = last_modified_diff;
> +	lm->rev.diffopt.format_callback_data = &data;
> +
> +	prepare_revision_walk(&lm->rev);
> +
> +	while (hashmap_get_size(&lm->paths)) {

Okay, and this is the core of our logic: we continue walking the tree
until there are no more paths that we care about.

> diff --git a/last-modified.h b/last-modified.h
> new file mode 100644
> index 0000000000..42a819d979
> --- /dev/null
> +++ b/last-modified.h
> @@ -0,0 +1,27 @@
> +#ifndef LAST_MODIFIED_H
> +#define LAST_MODIFIED_H
> +
> +#include "commit.h"
> +#include "revision.h"
> +#include "hashmap.h"
> +
> +struct last_modified {
> +	struct hashmap paths;
> +	struct rev_info rev;
> +};
> +
> +void last_modified_init(struct last_modified *lm,
> +		     struct repository *r,
> +		     const char *prefix,
> +		     int argc, const char **argv);
> +
> +void last_modified_release(struct last_modified *);
> +
> +typedef void (*last_modified_callback)(const char *path,
> +				    const struct commit *commit,
> +				    void *data);
> +int last_modified_run(struct last_modified *lm,
> +		   last_modified_callback cb,
> +		   void *cbdata);
> +#endif /* LAST_MODIFIED_H */

It would be nice to have some documentation for each of these functions
as well as a bit of a higher-level conceptual info.
