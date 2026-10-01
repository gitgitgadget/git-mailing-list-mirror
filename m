Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562E418A4E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827898; cv=none; b=T8WI6DZIt4+APyQbwo5jm0enW1xcBm1nnic/7NS4wq4wdY2nQE23TlZD/Nucq6W8CTEwo79eVR5TJZ8vD2lJlmQwVBAGyFBcgUMFZknwlleHjhvlbKLqkDHEb9Quf6H0XctgYO5oGDhzYg4HX91e2WtHHUm14n/hSzBYVZO1TKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827898; c=relaxed/simple;
	bh=xA7G8I98Px+ZVohI8BWpCY8bjIcsS5HRspEL5YJa9og=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD9MOP0L29ndjOdOTSdUNav3loa3B53LLAcf/8/hFWEat5HnCuRSFyrPkwttBTWMzIjECTdENaq9RLQUBuGyhBfxV/6VOA5GT4xwPMbV6HJ9NBm7y4WNI3wzp4CC0gzMyMuzYV0zzGgrbte2in3/+cKfM5vAnov45HUrGEitirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DKR/W6Pq; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DKR/W6Pq"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c2613d80fbso3587183eaf.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827895; x=1791432695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LqOaOIftaB7vHmzXthPKsQi31ENmeLVWihWjq8U9uzo=;
        b=DKR/W6PqnIp+a8989+Dzjyjmi6Vya04f2HzLI2iHG3FmJE8DU2sp5SDzgPJvZprQG6
         bQeTkDYMlkiOH2AUlcb2H0w6rsQW49cGwF4UZD2qjm09FtYaZCd82dhdGB1E0U/9z4ub
         j0a6DJYz4//AGAobcsaGS5L07Y0dzCMWFcxgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827895; x=1791432695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqOaOIftaB7vHmzXthPKsQi31ENmeLVWihWjq8U9uzo=;
        b=aqB3lzxvo2LoE6gfFsyPFhK3Aui7Nap1um1LI6vUYNEsr3qtO4p2br1ZLVQLbTdSf9
         bofCcVhXucVh4KPDax98KGFzdoUoCUNvYNF4MeC4eQ2v/dLuZKH703ci42DYX4O2652E
         l7d8/MylIoEpQ3Wp4ayNhyD/std2OMMPpuyvg0XWOGmtr+1+HtCo7tv050UyUPkqOOFb
         0sxAI1dyTQPOaBO/yzy+msh6P+qVSNxV3Gayax4LbIJ5nHPZBCtDPm+UYB38Rsfo0C1Q
         JIo8gAE7Hfp8ZhQoW46NDdohZ1yj3xQqXZkYCbDXK8z12w/jskSIYGwEvjw9hTCTyUt4
         JPOw==
X-Gm-Message-State: AFuF++lWQIIbx031HWFtz3Ry3JcFmMA+Tt3fwq6uB4XNDfZHPgkhIKOa
	Jnpii8WgEhxbxjPmfNY9+kOHlFGWz0QQ5bmtqX2EBpWqiGVvZkWIF4qCgu8qblAX8uMSntkp6QF
	o0WEXefI=
X-Gm-Gg: AYBFou1uTw6/ER429S1ma17E3yfB/2UxUUTaYtRBPk/WapE1UKg/Pi0fODKXRUZ/qyg
	ohuJznvelDkF882blplnr5t0KmUcNb6vPc2fdpE0ZB/YrZlwmleRfsEEy5QRB5UrQX1hK00Y0C7
	AkyvR/b18u7+F1cImJuAfRTRbAZOFil75a+/JAj6CHTvzurdk2tG1GoymQ+FrcFoZBqUoKRO23x
	p6DKXd7aKpbf+bcRhInaZWyNQTSGfnftnxaPJNnhU9Ugzaqt90HowHaB6SsL2uEr1rVHm2hHwoY
	Q9Ff9Svueppk+NssZftC6C/mUgFZTsf4aOAObzjfmLfh1zeHoMJaRSxz2lJ6gR+lW6VTwyoesGO
	/Ld1iJjKGiATfwuJE+t8XeFOTa1DZ8j9d4lA5JFElhaYDpTWveLxKb8tXT8xsjsNr5LWozJYiWR
	huP8ncS7WP+zv+Lhfpho5sHu9umfgvskAle0uiftESL+v9rIy2aiat8iVW603f9uCFS41nfJYcX
	owH5JNqROrV4iF9Xv5xVjEryqgWf2opIOUlPoyFP9Ej91GKoCwovLSvZV9X4mpd5Kayzz54jok7
	Eyffgdu0
X-Received: by 2002:a05:6820:4b0d:b0:6cd:3ffc:e33c with SMTP id 006d021491bc7-6dcf6e19cfemr3605473eaf.90.1790827894924;
        Wed, 30 Sep 2026 21:11:34 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212a413937sm1774802a34.8.2026.09.30.21.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:11:34 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:29 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 0/8] repack: various corner cases for cruft-less MIDXs
Message-ID: <cover.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790731662.git.me@ttaylorr.com>

This is a reroll of [1]. Thanks to Stolee, Junio, and Peff for
reviewing.

With 'repack.midxMustContainCruft=false', geometric repacks copy needed
objects out of cruft packs before omitting those packs from the MIDX.
The follow walk can stop at objects in retained MIDX packs, relying on
the indexed set being closed under reachability. That invariant must
hold for directly enumerated trees and tags, too. A subsequent repack
may introduce a commit that reaches a tree already in a retained pack.

The series adds those tree and tag roots, retains cruft for ordinary
incremental repacks, and includes the required packs when writing either
an ordinary or incremental MIDX. These omissions can otherwise make
bitmap generation fail even though all reachable objects remain
available in the repository.

Changes since v1:

  - Use an oidset for the additional tree and tag roots, as Stolee
    suggested, avoiding duplicate entries when an object appears in
    several input packs.

  - Address Junio's comments by documenting that a non-NULL
    stdin_packs_context requires a non-NULL revs pointer, and by
    returning early from add_loose_object() after common handling when
    there is no context.

  - Following Peff's review, clarify that the tree-closure failure
    occurs in a subsequent repack. Describe the two walks precisely:
    directly enumerated commits go first, but deferred tags can
    introduce commits in the second walk, so path context remains
    best-effort. Existing MIDXs lacking closure still require a full
    repack.

  - Follow Peff's suggestion to traverse kept packs during geometric
    repacks, instead of always retaining cruft whenever kept packs
    exist. A temporary .keep installed by a push should not by itself
    require retaining cruft. The tests distinguish '--pack-kept-objects'
    from an explicit '--keep-pack'.

  - Fix the separate '--write-midx=incremental' issue Peff identified.
    Both cases include required packs outside the retained chain,
    including packs from a replaced tip. Existing append coverage now
    writes and verifies bitmaps; separate regressions cover repacking
    without producing a new pack and replacing a tip containing cruft.

Thanks in advance for your review!

Thanks,
Taylor

[1] https://lore.kernel.org/git/cover.1790731662.git.me@ttaylorr.com/

Taylor Blau (8):
  pack-objects: introduce `stdin_packs_context` struct
  pack-objects: ensure tree/tag closure with '--stdin-packs=follow'
  repack: retain cruft packs in MIDXs after incremental repacks
  repack: use a sorted list for explicitly kept packs
  repack: follow kept packs when omitting cruft from the MIDX
  repack: track the preferred pack explicitly in MIDX write steps
  repack: defer allocating the append plan's write step
  repack: include required packs in incremental MIDX writes

 Documentation/git-pack-objects.adoc |   2 +
 Documentation/git-repack.adoc       |   5 +-
 builtin/pack-objects.c              |  82 +++++++++++++++----
 builtin/repack.c                    |  40 ++++++++-
 repack-midx.c                       | 123 +++++++++++++++++++---------
 repack.c                            |   8 +-
 repack.h                            |   4 +
 t/t5331-pack-objects-stdin.sh       |  81 ++++++++++++++++++
 t/t7704-repack-cruft.sh             |  74 +++++++++++++++++
 t/t7705-repack-incremental-midx.sh  |  63 +++++++++++---
 10 files changed, 404 insertions(+), 78 deletions(-)

Range-diff against v1:
1:  fcc07ede9a0 ! 1:  354c29cae73 pack-objects: introduce `stdin_packs_context` struct
    @@ Commit message
         object enumeration callbacks.
     
         Signed-off-by: Taylor Blau <ttaylorr@openai.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
      static int stdin_packs_hints_nr;
      
     +struct stdin_packs_context {
    -+	struct rev_info *revs;
    ++	struct rev_info *revs; /* must be non-NULL */
     +	enum stdin_packs_mode mode;
     +};
     +
2:  41448dca614 ! 2:  940953e5c40 pack-objects: ensure tree/tag closure with '--stdin-packs=follow'
    @@ Commit message
         maintain reachability closure for lone trees (that are not reachable
         from any commit otherwise in the closure).
     
    -    A later walk with '!' packs can stop at that tree in a retained '^'
    -    pack even if a new commit reaches it. If the cruft pack remains
    +    A subsequent repack with '!' packs can stop at that tree in a retained
    +    '^' pack even if a new commit reaches it. If the cruft pack remains
         excluded, and the bitmap selection picks one or more commits which reach
         that tree, the MIDX cannot generate a bitmap for that commit.
     
    @@ Commit message
         '--unpacked') as roots in '--stdin-packs=follow' mode. This rescues
         their descendants even when no input commit reaches them. Walk these
         roots after the existing traversal, preserving the `SEEN` bit to avoid
    -    redundant traversals. Ensure that the walk takes place *after* the
    -    existing traversal so that we don't lose the path prefix used for trees
    -    and blobs wherever possible.
    +    redundant traversals. This gives directly enumerated commits priority
    +    for the path prefixes used by name hashes and delta attributes. Tags can
    +    introduce commits in the second walk, so path selection remains
    +    best-effort.
    +
    +    Collect the extra roots in an oidset to avoid queuing duplicates. This
    +    uses memory for each distinct root and walks its unvisited descendants.
     
         Objects in '^' packs remain cutoffs to avoid rewalking packs that are
    -    known to be closed under reachability.
    +    known to be closed under reachability, provided '!' packs are present.
    +    This does not repair existing MIDXs lacking closure; those need a full
    +    repack.
     
         Signed-off-by: Taylor Blau <ttaylorr@openai.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/git-pack-objects.adoc ##
     @@ Documentation/git-pack-objects.adoc: pack may include additional objects based on the following:
    @@ Documentation/git-pack-objects.adoc: pack may include additional objects based o
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static int stdin_packs_hints_nr;
      struct stdin_packs_context {
    - 	struct rev_info *revs;
    + 	struct rev_info *revs; /* must be non-NULL */
      	enum stdin_packs_mode mode;
    -+	struct oid_array extra_roots;
    ++	struct oidset extra_roots;
      };
      
      static int add_object_entry_from_pack(const struct object_id *oid,
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
      		add_pending_oid(ctx->revs, NULL, oid, 0);
     +	} else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
     +		   (type == OBJ_TREE || type == OBJ_TAG)) {
    -+		oid_array_append(&ctx->extra_roots, oid);
    ++		oidset_insert(&ctx->extra_roots, oid);
      	}
      
      	if (!want_object_in_pack(oid, 0, &p, &ofs))
    @@ builtin/pack-objects.c: static void read_stdin_packs(struct repository *repo,
      	struct stdin_packs_context ctx = {
      		.revs = &revs,
      		.mode = mode,
    -+		.extra_roots = OID_ARRAY_INIT,
    ++		.extra_roots = OIDSET_INIT,
      	};
    ++	struct oidset_iter iter;
    ++	const struct object_id *oid;
      
      	/*
    + 	 * The revision walk may hit objects that are promised, only. As the
     @@ builtin/pack-objects.c: static void read_stdin_packs(struct repository *repo,
      			     show_object_pack_hint,
      			     &mode);
      
     +	/*
     +	 * Trees and tags need closure even when no commit reaches them.
    -+	 * Defer adding these roots to revs.pending until the commit walk
    ++	 * Defer adding these roots to revs.pending until the first walk
     +	 * finishes. Otherwise a subtree may be visited and marked SEEN
    -+	 * before its commit's root tree, using "a" instead of "sub/a" for
    -+	 * a blob's namehash and delta attributes.
    ++	 * before its commit's root tree, using "a" instead of "sub/a"
    ++	 * for a blob's namehash and delta attributes.
    ++	 *
    ++	 * Tags may introduce more commits in the second walk, so this
    ++	 * does not *always* guarantee that trees are always visited
    ++	 * with their full paths.
     +	 */
    -+	for (size_t i = 0; i < ctx.extra_roots.nr; i++) {
    -+		const struct object_id *oid = &ctx.extra_roots.oid[i];
    ++	oidset_iter_init(&ctx.extra_roots, &iter);
    ++	while ((oid = oidset_iter_next(&iter))) {
     +		struct object *obj = lookup_object(repo, oid);
     +
     +		if (!obj || !(obj->flags & SEEN))
    @@ builtin/pack-objects.c: static void read_stdin_packs(struct repository *repo,
     +				     show_object_pack_hint,
     +				     &mode);
     +	}
    -+	oid_array_clear(&ctx.extra_roots);
    ++	oidset_clear(&ctx.extra_roots);
     +
      	release_revisions(&revs);
      
      	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
     @@ builtin/pack-objects.c: static int add_loose_object(const struct object_id *oid, const char *path,
    + 		add_object_entry(oid, type, "", 0);
    + 	}
      
    - 	if (ctx && type == OBJ_COMMIT)
    +-	if (ctx && type == OBJ_COMMIT)
    ++	if (!ctx)
    ++		return 0;
    ++
    ++	if (type == OBJ_COMMIT)
      		add_pending_oid(ctx->revs, NULL, oid, 0);
    -+	else if (ctx && ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
    ++	else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
     +		 (type == OBJ_TREE || type == OBJ_TAG))
    -+		oid_array_append(&ctx->extra_roots, oid);
    ++		oidset_insert(&ctx->extra_roots, oid);
      
      	return 0;
      }
3:  72f49ff37bb ! 3:  a244b26030c repack: retain cruft packs in MIDXs after incremental repacks
    @@ Commit message
         such guarantee. Require the MIDX to include cruft packs in that case,
         even when a new pack was written.
     
    +    This fixes ordinary '--write-midx'. The separate
    +    '--write-midx=incremental' writer does not consult this flag and needs
    +    its own handling.
    +
         Exercise this with the existing fixture that makes a cruft commit
         reachable again and adds a new (unpacked) commit on top, and ensure that
         the incremental repack is able to successfully write a reachability
         bitmap.
     
         Signed-off-by: Taylor Blau <ttaylorr@openai.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
     @@ builtin/repack.c: int cmd_repack(int argc,
-:  ----------- > 4:  c1ff18bf913 repack: use a sorted list for explicitly kept packs
-:  ----------- > 5:  51e20444dac repack: follow kept packs when omitting cruft from the MIDX
-:  ----------- > 6:  a85dbcd04c7 repack: track the preferred pack explicitly in MIDX write steps
-:  ----------- > 7:  4a6504629a2 repack: defer allocating the append plan's write step
4:  a10e3aa86c1 ! 8:  a42f775cbe2 repack: retain cruft packs in MIDXs containing kept packs
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    repack: retain cruft packs in MIDXs containing kept packs
    +    repack: include required packs in incremental MIDX writes
     
    -    When performing a geometric repack with 'repack.midxMustContainCruft'
    -    set to "false", Git uses '--stdin-packs=follow' to copy (once-cruft)
    -    objects needed for reachability closure out of cruft packs. .keep packs
    -    do not need to participate in that walk, though they *are* included in
    -    the resulting MIDX.
    +    The append plan introduced in 06733a50eee (repack: allow
    +    `--write-midx=incremental` without `--geometric`, 2026-05-19) adds only
    +    newly written packs to the existing MIDX chain. The bitmap writer can
    +    use objects from the new layer and all retained base layers, but the
    +    plan omits preexisting packs outside the chain. Bitmap generation fails
    +    if a selected commit reaches an object absent from the resulting chain.
     
    -    A .keep pack can contain a commit that reaches an object whose only copy
    -    is in a cruft pack. When there is no previous MIDX and the repack writes
    -    a new pack, neither `midx_has_unknown_packs()` nor the `!names.nr`
    -    fallback require that cruft pack to be included. If the kept commit (or
    -    a descendant of it) is selected for bitmap coverage, the bitmap writer
    -    fails because the MIDX does not contain all of its reachable objects.
    +    The geometric plan from 1da62fb5c86 (repack: implement incremental MIDX
    +    repacking, 2026-05-19) can omit kept and cruft packs, since neither
    +    necessarily participates in the geometric repack. Such packs can also be
    +    lost when replacing a tip layer that contains them. Neither plan
    +    consults `midx_included_packs()`, so the rules for retaining cruft in
    +    ordinary MIDX writes do not protect incremental writes.
     
    -    Include cruft packs whenever the MIDX contains kept packs. This also
    -    retains cruft when the kept packs happen to have full closure, or when
    -    '--pack-kept-objects' lets the repack walk them. It avoids having to
    -    establish their closure before deciding which packs the MIDX needs.
    +    Use that selection logic to add missing packs to each plan's write step.
    +    Skip packs in retained base layers, but include required packs from a
    +    replaced tip. Count added objects when choosing which layers to compact,
    +    without changing the preferred pack.
     
    -    Add a test that packs the tip commit and its tree into a kept pack,
    -    leaving its parent in the cruft pack. The new commit's blob remains
    -    loose, making the geometric repack write a new pack and bypass the
    -    no-new-packs fallback. Verify that the repack succeeds and that we are
    -    able to successfully write a bitmap.
    +    Write and verify bitmaps in the existing append test: its existing
    +    checks do not detect the omitted pack containing the first commit. Cover
    +    the no-new-pack case separately with a reachable blob in a cruft pack.
     
         Signed-off-by: Taylor Blau <ttaylorr@openai.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
    +
    + ## Documentation/git-repack.adoc ##
    +@@ Documentation/git-repack.adoc: linkgit:git-multi-pack-index[1]).
    + 		flat MIDX.
    + +
    + Without `--geometric`, a new MIDX layer is appended to the existing
    +-chain (or a new chain is started) containing whatever packs were written
    +-by the repack. Existing layers are preserved as-is.
    ++chain (or a new chain is started) containing newly written packs and any
    ++other required packs not already in the chain. Existing layers are
    ++preserved as-is.
    + +
    + When combined with `--geometric`, the incremental mode maintains a chain
    + of MIDX layers that is compacted over time using a geometric merging
     
      ## repack-midx.c ##
    +@@
    + #include "odb.h"
    + #include "oidset.h"
    + #include "pack-bitmap.h"
    ++#include "packfile.h"
    + #include "path.h"
    + #include "refs.h"
    + #include "run-command.h"
    +@@ repack-midx.c: void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
    + 
    + static int midx_has_unknown_packs(struct string_list *include,
    + 				  struct pack_geometry *geometry,
    +-				  struct existing_packs *existing)
    ++				  struct existing_packs *existing,
    ++				  struct multi_pack_index *base)
    + {
    + 	struct string_list_item *item;
    + 
    +@@ repack-midx.c: static int midx_has_unknown_packs(struct string_list *include,
    + 		 *    MIDX. Note this function is called before the include
    + 		 *    list is populated with any cruft pack(s).
    + 		 *
    ++		 *  - In a MIDX layer retained as part of the new chain's base.
    ++		 *
    + 		 *  - Below the geometric split line (if using pack geometry),
    + 		 *    indicating that the pack won't be included in the new
    + 		 *    MIDX, but its contents were rolled up as part of the
    +@@ repack-midx.c: static int midx_has_unknown_packs(struct string_list *include,
    + 		 *  - In the existing non-kept packs list (if not using pack
    + 		 *    geometry), and marked as non-deleted.
    + 		 */
    +-		if (string_list_has_string(include, pack_name)) {
    ++		if (string_list_has_string(include, pack_name) ||
    ++		    midx_contains_pack(base, pack_name)) {
    + 			continue;
    + 		} else if (geometry) {
    + 			struct strbuf buf = STRBUF_INIT;
    +@@ repack-midx.c: static int midx_has_unknown_packs(struct string_list *include,
    + }
    + 
    + static void midx_included_packs(struct string_list *include,
    +-				struct repack_write_midx_opts *opts)
    ++				struct repack_write_midx_opts *opts,
    ++				struct multi_pack_index *base)
    + {
    + 	struct existing_packs *existing = opts->existing;
    + 	struct pack_geometry *geometry = opts->geometry;
     @@ repack-midx.c: static void midx_included_packs(struct string_list *include,
    - 	}
      
      	if (opts->midx_must_contain_cruft ||
    -+	    existing->kept_packs.nr ||
    - 	    midx_has_unknown_packs(include, geometry, existing)) {
    + 	    (!geometry->split_factor && existing->kept_packs.nr) ||
    +-	    midx_has_unknown_packs(include, geometry, existing)) {
    ++	    midx_has_unknown_packs(include, geometry, existing, base)) {
      		/*
      		 * If there are one or more unknown pack(s) present (see
    -@@ repack-midx.c: static void midx_included_packs(struct string_list *include,
    - 		 * reachability closure if the MIDX is bitmapped and one
    - 		 * or more of the bitmap's selected commits reaches a
    - 		 * once-cruft object that was later made reachable.
    -+		 *
    -+		 * Kept packs may also depend on cruft objects, since
    -+		 * they are included above without necessarily being
    -+		 * traversed by the repack.
    - 		 */
    - 		for_each_string_list_item(item, &existing->cruft_packs) {
    - 			/*
    + 		 * midx_has_unknown_packs() for what makes a pack
    +@@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opts *opts)
    + 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
    + 	int ret = 0;
    + 
    +-	midx_included_packs(&include, opts);
    ++	midx_included_packs(&include, opts, NULL);
    + 	if (!include.nr)
    + 		goto done;
    + 
    +@@ repack-midx.c: static void midx_compaction_step_release(struct midx_compaction_step *step)
    + 	free(step->csum);
    + }
    + 
    ++static int midx_compaction_step_include_packs(struct midx_compaction_step *step,
    ++					      struct repack_write_midx_opts *opts,
    ++					      struct multi_pack_index *base)
    ++{
    ++	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
    ++	struct string_list include = STRING_LIST_INIT_DUP;
    ++	struct string_list_item *item;
    ++	struct strbuf path = STRBUF_INIT;
    ++	int ret = 0;
    ++
    ++	midx_included_packs(&include, opts, base);
    ++	string_list_sort(&step->u.write);
    ++
    ++	for_each_string_list_item(item, &include) {
    ++		struct packed_git *p;
    ++
    ++		if (string_list_has_string(&step->u.write, item->string) ||
    ++		    midx_contains_pack(base, item->string))
    ++			continue;
    ++
    ++		strbuf_reset(&path);
    ++		strbuf_addf(&path, "%s/%s", opts->packdir, item->string);
    ++		p = packfile_store_load_pack(files->packed, path.buf, 1);
    ++		if (!p || open_pack_index(p)) {
    ++			ret = error(_("cannot open index for %s"), path.buf);
    ++			goto out;
    ++		}
    ++		if (unsigned_add_overflows(step->objects_nr, p->num_objects)) {
    ++			ret = error(_("too many objects in MIDX compaction step"));
    ++			goto out;
    ++		}
    ++		step->objects_nr += p->num_objects;
    ++		string_list_insert(&step->u.write, item->string);
    ++	}
    ++
    ++out:
    ++	strbuf_release(&path);
    ++	string_list_clear(&include, 0);
    ++	return ret;
    ++}
    ++
    + /*
    +- * Build an append-only MIDX plan: a single WRITE step for the freshly
    +- * written packs, plus COPY steps for every existing layer.  No
    ++ * Build an append-only MIDX plan: a single WRITE step for packs not
    ++ * already in the chain, plus COPY steps for every existing layer. No
    +  * compaction or merging is performed.
    +  */
    + static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
    +@@ repack-midx.c: static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
    + 					 size_t *steps_nr_p)
    + {
    + 	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
    ++	struct string_list include = STRING_LIST_INIT_DUP;
    ++	struct string_list_item *item;
    + 	struct multi_pack_index *m;
    + 	struct midx_compaction_step *steps = NULL;
    + 	struct midx_compaction_step *step = NULL;
    +-	struct strbuf buf = STRBUF_INIT;
    + 	size_t steps_nr = 0, steps_alloc = 0;
    +-	uint32_t i;
    + 
    + 	odb_reprepare(opts->existing->repo->objects);
    + 	m = get_multi_pack_index(files->packed);
    + 
    +-	for (i = 0; i < opts->names->nr; i++) {
    ++	midx_included_packs(&include, opts, m);
    ++	for_each_string_list_item(item, &include) {
    ++		if (midx_contains_pack(m, item->string))
    ++			continue;
    + 		if (!step) {
    + 			ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
    + 			step = &steps[steps_nr++];
    +@@ repack-midx.c: static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
    + 			step->type = MIDX_COMPACTION_STEP_WRITE;
    + 			string_list_init_dup(&step->u.write);
    + 		}
    +-		strbuf_reset(&buf);
    +-		strbuf_addf(&buf, "pack-%s.idx",
    +-			    opts->names->items[i].string);
    +-		string_list_append(&step->u.write, buf.buf);
    ++		string_list_append(&step->u.write, item->string);
    + 	}
    +-	strbuf_release(&buf);
    ++	string_list_clear(&include, 0);
    + 
    + 	for (; m; m = m->base_midx) {
    + 		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
    +@@ repack-midx.c: static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
    + 	if (opts->geometry->midx_tip_rewritten)
    + 		m = m->base_midx;
    + 
    ++	if (midx_compaction_step_include_packs(&step, opts, m) < 0) {
    ++		midx_compaction_step_release(&step);
    ++		ret = -1;
    ++		goto out;
    ++	}
    ++
    + 	trace2_data_string("repack", opts->existing->repo, "midx:rewrote-tip",
    + 			   opts->geometry->midx_tip_rewritten ? "true" : "false");
    + 
     
    - ## t/t7704-repack-cruft.sh ##
    -@@ t/t7704-repack-cruft.sh: test_expect_success 'incremental repack includes cruft for MIDX bitmaps' '
    + ## t/t7705-repack-incremental-midx.sh ##
    +@@ t/t7705-repack-incremental-midx.sh: test_expect_success '--write-midx=incremental without --geometric' '
    + 		git repack -d &&
    + 
    + 		test_commit second &&
    +-		git repack --write-midx=incremental &&
    ++		git repack --write-midx=incremental --write-bitmap-index &&
    + 
    + 		git multi-pack-index verify &&
    + 		test_line_count = 1 $midx_chain &&
    +@@ t/t7705-repack-incremental-midx.sh: test_expect_success '--write-midx=incremental without --geometric' '
    + 		# A second repack appends a new layer without
    + 		# disturbing the existing one.
    + 		test_commit third &&
    +-		git repack --write-midx=incremental &&
    ++		git repack --write-midx=incremental --write-bitmap-index &&
    + 
    + 		git multi-pack-index verify &&
    + 		test_line_count = 2 $midx_chain &&
    +@@ t/t7705-repack-incremental-midx.sh: test_expect_success '--write-midx=incremental without --geometric' '
    + 		head -n 1 $midx_chain >actual &&
    + 		test_cmp expect actual &&
    + 
    ++		git rev-list --test-bitmap HEAD &&
    + 		git fsck
      	)
      '
      
    -+test_expect_success 'geometric repack includes cruft for kept packs' '
    -+	setup_cruft_exclude_tests kept-cruft &&
    ++test_expect_success 'incremental MIDX includes cruft without a new pack' '
    ++	git init incremental-cruft &&
    ++	(
    ++		cd incremental-cruft &&
    ++		git config repack.midxMustContainCruft false &&
    ++
    ++		test_commit base &&
    ++		echo cruft | git hash-object -w --stdin &&
    ++		git repack --cruft -d &&
    ++		test_commit cruft &&
    ++		git repack -d &&
    ++
    ++		# All objects are packed, but the new MIDX still needs cruft.
    ++		git repack --write-midx=incremental --write-bitmap-index &&
    ++		git rev-list --test-bitmap HEAD
    ++	)
    ++'
    ++
    ++test_expect_success 'geometric incremental MIDX retains cruft when replacing its tip' '
    ++	git init geometric-incremental-cruft &&
     +	(
    -+		cd kept-cruft &&
    ++		cd geometric-incremental-cruft &&
    ++		git config repack.midxNewLayerThreshold 1 &&
     +
    -+		# Keep HEAD and its tree outside the geometric repack. Its
    -+		# parent is reachable again, but still in the cruft pack.
    -+		git rev-parse HEAD HEAD^{tree} >objects &&
    -+		pack=$(git pack-objects $packdir/pack <objects) &&
    -+		touch $packdir/pack-$pack.keep &&
    -+		git prune-packed &&
    ++		test_commit base &&
    ++		echo cruft | git hash-object -w --stdin &&
    ++		git repack --cruft -d &&
    ++		git multi-pack-index write --incremental --bitmap &&
    ++		test_commit cruft &&
     +
    -+		# The new blob is still loose, so this writes a pack instead
    -+		# of taking the no-new-packs fallback.
    -+		GIT_TEST_MULTI_PACK_INDEX=0 \
    -+		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
    ++		# Pack the new commit and tree, leaving the blob in cruft.
    ++		git repack -d &&
    ++		git repack --geometric=2 --write-midx=incremental \
    ++			--write-bitmap-index &&
    ++		test_line_count = 1 $midx_chain &&
     +		git rev-list --test-bitmap HEAD
     +	)
     +'
     +
    - test_expect_success 'repack --write-midx includes cruft when instructed' '
    - 	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
    + test_expect_success 'below layer threshold, tip packs excluded' '
    + 	git init below-layer-threshold-tip-packs-excluded &&
    + 	(
    +@@ t/t7705-repack-incremental-midx.sh: test_expect_success 'geometric rollup with surviving tip packs' '
    + 	)
    + '
    + 
    +-test_expect_success 'kept packs are excluded from repack' '
    ++test_expect_success 'kept packs are excluded from repack but included in MIDX' '
    + 	git init kept-packs-excluded-from-repack &&
      	(
    + 		cd kept-packs-excluded-from-repack &&
    +@@ t/t7705-repack-incremental-midx.sh: test_expect_success 'kept packs are excluded from repack' '
    + 			test_commit "$i" && git repack -d || return 1
    + 		done &&
    + 
    +-		keep=$(ls $packdir/pack-*.idx | head -n 1) &&
    +-		touch "${keep%.idx}.keep" &&
    ++		keep=$(test-tool find-pack A) &&
    ++		touch "${keep%.pack}.keep" &&
    + 
    +-		# The kept pack is excluded as a repacking candidate
    +-		# entirely, so no rollup occurs as there is only one
    +-		# non-kept pack. A new MIDX layer is written containing
    +-		# that pack.
    +-		git repack --geometric=2 -d --write-midx=incremental &&
    ++		# Neither pack is repacked, but both are needed for the
    ++		# bitmap of B, which reaches objects in the kept pack.
    ++		git repack --geometric=2 -d --write-midx=incremental \
    ++			--write-bitmap-index &&
    + 
    + 		test-tool read-midx $objdir >actual &&
    + 		grep "^pack-.*\.idx$" actual >actual.packs &&
    +-		test_line_count = 1 actual.packs &&
    +-		test_grep ! "$keep" actual.packs &&
    ++		test_line_count = 2 actual.packs &&
    + 
    + 		git multi-pack-index verify &&
    ++		git rev-list --test-bitmap HEAD &&
    + 
    + 		# All objects (from both kept and non-kept packs)
    + 		# must still be accessible.

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.56.0.8.ga42f775cbe2
