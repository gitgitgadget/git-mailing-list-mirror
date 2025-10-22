Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DE2E718F
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115276; cv=none; b=hd4BAdnlEjQ0v8Fiz6C0IzFvD9NXjlNxSHv1VGIsbVxl450tQPr32Ic6SoNwKKj7GUt2hsort3VgeFMXo9JKs3sts3tR0VWjFGrdU/TOo4DgS0OGpful+6qXmx33WFc8J+x42t4ILBWIAmoGCMB6iAb53sZ0YRoXy28Pt6Bb4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115276; c=relaxed/simple;
	bh=sY089tuby7BsiLrp/i2Mvue0hFnuFGHm6BkL2aEh3dQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cdUffJ8KMhTgTydQ3HGSo/07Ipr6W9IoUc3pPcKgqkfTcZ2/MkO+gWtW62Nm8KGD+GeZSmlvegfGxsLrckGXoUA2V6E/ud7t6amvScQ/3kz0B1C8VFX8+yIgMYk/YVD/5ezcZgx5ga5gsW4j37jcpWqvKc9tb3y00hKyQuUBibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d3tf6Z0B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNRxs5C1; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d3tf6Z0B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNRxs5C1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 9B87613001C7;
	Wed, 22 Oct 2025 02:41:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 02:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115270;
	 x=1761122470; bh=prFUFVCvxcqFkb1h0XWphnkkG+yHGYxeuWiRciXN0t0=; b=
	d3tf6Z0BCV9VUvOktbm0CVEbWJjGRHl90kmHyMP1rBkh4CkJ8lHOVJrxwCgEfEvf
	RictPV2jQRrqlN6rge2Xr6sUXhtI/DEbwcyFmvPc1UJ25eFuDTAQpLaw1KRR+6A3
	vr7OMUg7MXcAKBIS0I+kmd2FUe3BnTV3LINCudSeATtFqfISCbT1zR/sf+QLDbYP
	d3TsIj8wfyJvukm89L/txBdt0bkiT/N3wFR6Hklls+SwKNckl+j2/DFeGhDiokzA
	9vVWlj2OCbFenl0U+TejImqfaHWEFJCP8WJlpp/C5wZMWA+02tmUhdzwkH8WzFDj
	+O6CXxz6R/wZD3BTNeIZXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115270; x=
	1761122470; bh=prFUFVCvxcqFkb1h0XWphnkkG+yHGYxeuWiRciXN0t0=; b=Z
	NRxs5C1t7K7xiu+YcokZKfwP1Rt9hoK0IuOQZEDBZQGK0IGEP4onTO/rh9Tu3cx/
	12iszvexguoBsCFH+d0toaA/JGeOj8euYIy1DxZCJKuZl3lSkmvDLlWJWPHE9+os
	bQFMWmASi4jlb2RTqg4bFcr3Qlc4yTuAdaCnpR+SqC0YxfcEWdr2+XDA99ihqWnU
	Duox9RmC7NaUyH8dfqrj74FuZ1uWnUXR3z9QM2KjIscpoZG6ZsGQ//q2t4bzgPwp
	vErQ8Ep4rxx/OdpR6JnxLE9DhFDoC9bSExbWLDiAQbNbtVfVjiFhxSrgUZOCZtvH
	jIgcJ6rFeqrGXDZCpa04Q==
X-ME-Sender: <xms:hnz4aBJMvm1J07R7Qn4bDqp0hvUys5ATBSigMVQNET7hiJMSVkUBKg>
    <xme:hnz4aA3RZ2bqHke46PUchppxCUc0QTTLVK7czFGt46FAgbbcWaesYwEHVyyHt5RdL
    LqEMm2fX_HVOiDrvLSdv0CMVHKHOsr_FW4hPNqDiOEVgUyCLbIVhw>
X-ME-Received: <xmr:hnz4aDgLxSY3HXykAUbu5-Rryw3qKDZ3dXs_fMLpzQqkB9DPY-m8uF3jNUHlbVNNPOiIZWdd3ZgsUrRjV4RP6iZt7OWHm_BVPB3-3pJjQjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeu
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hnz4aJWGh1WuqnPZwR22d2_IjLj3c_hEB_HYWwkH1qI-VF_omOAJlQ>
    <xmx:hnz4aKX6b9ssykfulrOuJ95G4TIF6GAaVkDygtFFPA8vcEpTzSyNDw>
    <xmx:hnz4aBgVKr_fjM8AS1T_B34bYEUZvjfr2bOvd933eShlyLXypKZXFQ>
    <xmx:hnz4aNYBB4SqYROJ1h16lQ57hgS_K1tFnMyRl6VUyDdPK2K6CB7jGw>
    <xmx:hnz4aGmT6J5PBeks-HZCtbXMBROa_oFQixFx1ouI2yhlW8u0jAwQXJe1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0c6842f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/14] refs: improvements and fixes for peeling tags
Date: Wed, 22 Oct 2025 08:41:00 +0200
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHx8+GgC/42OQQ6DIBBFr2JYdxpARemq92i6QASd2ioBQ9oY7
 1500XTp8k3y35uFBOPRBHLJFuJNxIDTmCA/ZUT3auwMYJuYcMpLKlkNTQFuCOCNBYvP2XgIAzp
 wygccO5iah9FzAEtbZoWyhZKWJJlLA3zvods9cY9hnvxn70a2XfcEo7Q6mogMKEgmtK60qGvRX
 NPqjC+y+SP/dx5+O/LkrITJaVtqWRb851zX9Qs3mhu/LQEAAA==
X-Change-ID: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

originally, all I wanted to do was the last patch: a small performance
optimization that stops parsing objects in git-for-each-ref(1) unless we
really need to parse them. But that fix cause one specific test to fail,
and only with the reftable backend. So this led me down the rabbit hole
of tag peeling, ending up with this patch series.

The series is structured like follows:

  - Patches 1 to 8 refactor our codebase so that we don't have the
    `peel_iterated_object()` hack anymore. I just found it hard to
    follow and thought it shouldn't be too hard to get rid of it.

  - Patches 9 and 10 remove infrastructure that we don't need anymore
    after the first couple of patches.

  - Patches 11 to 13 fix a couple of issues with peeled tags that I
    found. The underlying issue is that tags store both the tagged
    object and their type, but this information may not match. We never
    verify the actual object type though when allocating the tagged
    object, so this only blows up much later.

  - Patch 14 was my original motivation, a small performance
    optimization.

I'm not particularly fond of the patches 11 to 13. It feels more like
playing whack-a-mole, and I very much assume that there still are edge
cases where we should properly verify the tagged object type. But
changing it in `parse_tag_buffer()` itself causes a bunch of tests to
fail where we intentionally create such corrupted tags. So I didn't
really dare to touch that part, to be honest.

If anybody has suggestions for an alternative approach I'd be very open
to it.

Changes in v3:
  - I've rebuilt the topic on 133d151831 (The twenty-first batch, 2025-10-20) with
        - tb/incremental-midx-part-3.1 at 935ab44a0a (builtin/repack.c:
          clean up unused `#include`s, 2025-10-15)
        - jt/16a93c03c7 at (builtin/repo: add progress meter for
          structure stats, 2025-10-21)
    merged into it. This is done to fix a couple of merge conflicts with
    "seen". Both of the topics are only in "seen" right now, but they
    are close to be merged.
  - Link to v2: https://lore.kernel.org/r/20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im

Changes in v2:
  - A couple of improvements to commit messages.
  - A new commit that ensures that `struct ref_iterator::ref` is always
    zeroed out to protect against stale state.
  - Link to v1: https://lore.kernel.org/r/20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (14):
      refs: introduce wrapper struct for `each_ref_fn`
      refs: introduce `.ref` field for the base iterator
      refs: fully reset `struct ref_iterator::ref` on iteration
      refs: refactor reference status flags
      refs: expose peeled object ID via the iterator
      upload-pack: convert to use `reference_get_peeled_oid()`
      ref-filter: propagate peeled object ID
      builtin/show-ref: convert to use `reference_get_peeled_oid()`
      refs: drop `current_ref_iter` hack
      refs: drop infrastructure to peel via iterators
      object: add flag to `peel_object()` to verify object type
      refs: don't store peeled object IDs for invalid tags
      ref-filter: detect broken tags when dereferencing them
      ref-filter: parse objects on demand

 bisect.c                    |  24 ++---
 builtin/bisect.c            |  17 +---
 builtin/checkout.c          |   6 +-
 builtin/describe.c          |  18 ++--
 builtin/fetch.c             |  13 +--
 builtin/fsck.c              |  33 +++---
 builtin/gc.c                |  15 ++-
 builtin/ls-remote.c         |   2 +-
 builtin/name-rev.c          |  17 ++--
 builtin/pack-objects.c      |  28 +++---
 builtin/receive-pack.c      |  13 ++-
 builtin/remote.c            |  44 ++++----
 builtin/replace.c           |  21 ++--
 builtin/repo.c              |   9 +-
 builtin/rev-parse.c         |  12 +--
 builtin/show-branch.c       |  35 +++----
 builtin/show-ref.c          |  50 ++++-----
 builtin/submodule--helper.c |  10 +-
 builtin/tag.c               |   2 +-
 builtin/verify-tag.c        |   2 +-
 builtin/worktree.c          |   6 +-
 commit-graph.c              |  14 ++-
 delta-islands.c             |   9 +-
 fetch-pack.c                |  16 +--
 help.c                      |  10 +-
 http-backend.c              |  20 ++--
 log-tree.c                  |  24 ++---
 ls-refs.c                   |  36 ++++---
 midx-write.c                |  17 ++--
 negotiator/default.c        |   7 +-
 negotiator/skipping.c       |   7 +-
 notes.c                     |   8 +-
 object-name.c               |  10 +-
 object.c                    |  20 +++-
 object.h                    |  15 ++-
 pseudo-merge.c              |  21 ++--
 reachable.c                 |   9 +-
 ref-filter.c                | 239 ++++++++++++++++++++++++++++++--------------
 ref-filter.h                |   5 +-
 reflog.c                    |   9 +-
 refs.c                      |  85 +++++++++-------
 refs.h                      |  88 ++++++++++------
 refs/debug.c                |  17 +---
 refs/files-backend.c        |  71 +++++--------
 refs/iterator.c             |  73 +++-----------
 refs/packed-backend.c       |  71 +++++--------
 refs/ref-cache.c            |  18 +---
 refs/refs-internal.h        |  25 +----
 refs/reftable-backend.c     |  47 +++------
 remote.c                    |  27 +++--
 repack-midx.c               |  16 ++-
 replace-object.c            |  16 ++-
 revision.c                  |  12 +--
 server-info.c               |  12 +--
 shallow.c                   |  16 +--
 submodule.c                 |  12 +--
 t/for-each-ref-tests.sh     |   4 +-
 t/helper/test-reach.c       |   2 +-
 t/helper/test-ref-store.c   |   5 +-
 t/pack-refs-tests.sh        |  32 ++++++
 t/t0610-reftable-basics.sh  |  28 ++++++
 tag.c                       |  12 ---
 tag.h                       |   1 -
 upload-pack.c               |  49 ++++-----
 walker.c                    |   8 +-
 worktree.c                  |  11 +-
 66 files changed, 794 insertions(+), 837 deletions(-)

Range-diff versus v2:

 1:  4a78d628cef !  1:  05cfb7e0364 refs: introduce wrapper struct for `each_ref_fn`
    @@ builtin/remote.c: static void free_remote_ref_states(struct ref_states *states)
      		string_list_append(&states->tracked, abbrev_branch(refspec.src));
      		free(refspec.src);
     
    - ## builtin/repack.c ##
    -@@ builtin/repack.c: struct midx_snapshot_ref_data {
    - 	int preferred;
    - };
    - 
    --static int midx_snapshot_ref_one(const char *refname UNUSED,
    --				 const char *referent UNUSED,
    --				 const struct object_id *oid,
    --				 int flag UNUSED, void *_data)
    -+static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
    - {
    - 	struct midx_snapshot_ref_data *data = _data;
    -+	const struct object_id *maybe_peeled = ref->oid;
    - 	struct object_id peeled;
    - 
    --	if (!peel_iterated_oid(the_repository, oid, &peeled))
    --		oid = &peeled;
    -+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
    -+		maybe_peeled = &peeled;
    - 
    --	if (oidset_insert(&data->seen, oid))
    -+	if (oidset_insert(&data->seen, maybe_peeled))
    - 		return 0; /* already seen */
    - 
    --	if (odb_read_object_info(the_repository->objects, oid, NULL) != OBJ_COMMIT)
    -+	if (odb_read_object_info(the_repository->objects, maybe_peeled, NULL) != OBJ_COMMIT)
    - 		return 0;
    - 
    - 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
    --		oid_to_hex(oid));
    -+		oid_to_hex(maybe_peeled));
    - 
    - 	return 0;
    - }
    -
      ## builtin/replace.c ##
     @@ builtin/replace.c: struct show_data {
      	enum replace_format format;
    @@ builtin/replace.c: struct show_data {
      	}
      
     
    + ## builtin/repo.c ##
    +@@ builtin/repo.c: struct count_references_data {
    + 	struct progress *progress;
    + };
    + 
    +-static int count_references(const char *refname,
    +-			    const char *referent UNUSED,
    +-			    const struct object_id *oid,
    +-			    int flags UNUSED, void *cb_data)
    ++static int count_references(const struct reference *ref, void *cb_data)
    + {
    + 	struct count_references_data *data = cb_data;
    + 	struct ref_stats *stats = data->stats;
    + 	size_t ref_count;
    + 
    +-	switch (ref_kind_from_refname(refname)) {
    ++	switch (ref_kind_from_refname(ref->name)) {
    + 	case FILTER_REFS_BRANCHES:
    + 		stats->branches++;
    + 		break;
    +@@ builtin/repo.c: static int count_references(const char *refname,
    + 	 * While iterating through references for counting, also add OIDs in
    + 	 * preparation for the path walk.
    + 	 */
    +-	add_pending_oid(data->revs, NULL, oid, 0);
    ++	add_pending_oid(data->revs, NULL, ref->oid, 0);
    + 
    + 	ref_count = get_total_reference_count(stats);
    + 	display_progress(data->progress, ref_count);
    +
      ## builtin/rev-parse.c ##
     @@ builtin/rev-parse.c: static int show_default(void)
      	return 0;
    @@ remote.c: static int get_stale_heads_cb(const char *refname, const char *referen
      
      clean_exit:
     
    + ## repack-midx.c ##
    +@@ repack-midx.c: struct midx_snapshot_ref_data {
    + 	int preferred;
    + };
    + 
    +-static int midx_snapshot_ref_one(const char *refname UNUSED,
    +-				 const char *referent UNUSED,
    +-				 const struct object_id *oid,
    +-				 int flag UNUSED, void *_data)
    ++static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
    + {
    + 	struct midx_snapshot_ref_data *data = _data;
    ++	const struct object_id *maybe_peeled = ref->oid;
    + 	struct object_id peeled;
    + 
    +-	if (!peel_iterated_oid(data->repo, oid, &peeled))
    +-		oid = &peeled;
    ++	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
    ++		maybe_peeled = &peeled;
    + 
    +-	if (oidset_insert(&data->seen, oid))
    ++	if (oidset_insert(&data->seen, maybe_peeled))
    + 		return 0; /* already seen */
    + 
    +-	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
    ++	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) != OBJ_COMMIT)
    + 		return 0;
    + 
    + 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
    +-		oid_to_hex(oid));
    ++		oid_to_hex(maybe_peeled));
    + 
    + 	return 0;
    + }
    +
      ## replace-object.c ##
     @@
      #include "repository.h"
 2:  9efd804f546 =  2:  e3bebc60554 refs: introduce `.ref` field for the base iterator
 3:  a4d79cf863d =  3:  99849a0323a refs: fully reset `struct ref_iterator::ref` on iteration
 4:  b4dcba74daf =  4:  6b93b3601b8 refs: refactor reference status flags
 5:  89cc42156b4 !  5:  8756dc100ab refs: expose peeled object ID via the iterator
    @@ builtin/pack-objects.c: static int mark_bitmap_preferred_tip(const struct refere
      
      	object = parse_object_or_die(the_repository, maybe_peeled, ref->name);
     
    - ## builtin/repack.c ##
    -@@ builtin/repack.c: static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
    - 	const struct object_id *maybe_peeled = ref->oid;
    - 	struct object_id peeled;
    - 
    --	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
    -+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
    - 		maybe_peeled = &peeled;
    - 
    - 	if (oidset_insert(&data->seen, maybe_peeled))
    -
      ## commit-graph.c ##
     @@ commit-graph.c: static int add_ref_to_set(const struct reference *ref, void *cb_data)
      	struct object_id peeled;
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_ite
      		iter->base.ref.flags = flags;
      
      		break;
    +
    + ## repack-midx.c ##
    +@@ repack-midx.c: static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
    + 	const struct object_id *maybe_peeled = ref->oid;
    + 	struct object_id peeled;
    + 
    +-	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
    ++	if (!reference_get_peeled_oid(data->repo, ref, &peeled))
    + 		maybe_peeled = &peeled;
    + 
    + 	if (oidset_insert(&data->seen, maybe_peeled))
 6:  3168a0ca998 =  6:  93ef81780ec upload-pack: convert to use `reference_get_peeled_oid()`
 7:  e72d8ff494f =  7:  4546770861f ref-filter: propagate peeled object ID
 8:  1eb5dee1e04 =  8:  fe65e6040f1 builtin/show-ref: convert to use `reference_get_peeled_oid()`
 9:  f58de2e9eaa =  9:  c656a638c2b refs: drop `current_ref_iter` hack
10:  1e62da6ed1e = 10:  03f85e095e8 refs: drop infrastructure to peel via iterators
11:  af36e3bfe80 = 11:  8087e6db211 object: add flag to `peel_object()` to verify object type
12:  14859152c57 = 12:  1cc87f74e11 refs: don't store peeled object IDs for invalid tags
13:  2191cfee400 = 13:  a5a6f27aea9 ref-filter: detect broken tags when dereferencing them
14:  0ef24754924 = 14:  2265eecd4ee ref-filter: parse objects on demand

---
base-commit: 5c120f01eb88f4be8b06fd4bc6893763204b78c4
change-id: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f

