Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D729D276
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938632; cv=none; b=F5bC9t3IV/7AAGBp1zV7p3XXovpHH7p3rYaMln37NMVv/PT2L7Skejef+rcHdDHDVIaoezS8GTQxeUUzAb2oV3bkh+OGgoHbZ0THUXli6s0AjyyF2ZpJIZZTSty2ytj05tnTSr7nKLALPGKpozUm9cY/X3M++Sddw8PNvS+pYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938632; c=relaxed/simple;
	bh=BKiG8alFttBj1zEQd7MEYlP0jaSz4Yz7/PdfPh/yQq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Gk8vd5uSaO4w0Mre8+jbibu+BaUkrlYS/mRJxELnJZi94NmSSm8koXNX+pXZsRTKig/NbivFezMtR8tGfTVYTiKK7PNMcXKeVJfxNvMtV3ez4f9C/hJrG/PvShj2O+jreK4LMNohUozJwq38SMoNNGjSGzpRmE5gpiTll0q/d7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lJBTTK/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xo+Oq4dd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lJBTTK/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xo+Oq4dd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BD8EC1D000D1;
	Wed,  8 Oct 2025 11:50:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 11:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938628;
	 x=1760025028; bh=+HxG0AFd1RPns0QWxkWuafuRG+TkSmUWrIfooU087CM=; b=
	lJBTTK/3vMDzimhI3VZYwm0f+cK4gvc7Vg8LJgbPaYbxKn9m/gwaDtzk+Lbuyg1D
	TcwwQz869fB9PlKK8WTmOSfeqexQIYysY3Sbz5G5+Qo14gD93TapF5WyzxJ+DEp2
	URkd/pTuCXyQuBe/l1spjCzlBjDZnIS/OAfrWG2JkwTrsdy+1VuNrVqZ/zopQXE3
	QkdN/hfAofHBdbEs7JIDUxNFIXEUCl756S8CsPYv/XuE/MrKVfUAzSy/wYyqWcLd
	sotj3rB5vKx8QavPVmF4l1ta9qqTI5RlaWlkZqTFOn65qNMhZ0wRSohTFWRaJqQ6
	vgprPPKUOY5+tH1byu/LBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938628; x=
	1760025028; bh=+HxG0AFd1RPns0QWxkWuafuRG+TkSmUWrIfooU087CM=; b=x
	o+Oq4ddeRvyCBdJbpTMxcHyfexlK7GuLzZ9S1WoSJ8vH5JOKd/ZjfNaHPb3Q0J3t
	za9czRG/S8y0n+TQZgGcTV9mBdrhd/KZTq4ECZYoyz6PNfdZpZLIN3wY3/ZvXXjl
	PcatjWTWw8O1anGf40KG5lHloQ1IlbSFF2ACbL2fERuYOjfMb48TXe3h9pgzhEWH
	tqsrhZnHDc/t6z28/dNInS4GdhSOlRvXMzXENeQ7EDrGQTFjlThFLKU6o3q12wt/
	j3DRngkVR1SfcvlQAQ0MUk9sqYU5hOQxsysg1HBG+DecriFVv89/xDD4F5UN9qNL
	RVeDlKLEvWxKMK8cwU6sA==
X-ME-Sender: <xms:RIjmaD5djbWCKRQgSIn6GCCHKJDaejIrXo2Fv0-PrqR0R_MYj888Ng>
    <xme:RIjmaMmoj_9vYT2hfcn62NvfZuuF4Qq7QjLrP9i6K38z_FFCfrpymsIuRnptnSSFW
    W7jMNgKSmkylxlI0ClRINiBwAX50VylUmZcxZDYcAecDdtC24j2OQ>
X-ME-Received: <xmr:RIjmaETO3hG5rrx2L9qBMzdgMsDK7dw-blT6kPE2NbEofnYX_tFxy2U92KnxiE-wzejxOzcZu3is-DORYcgEOqsl5QJ4sxYIzbzRgtbT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvgefhueevgffffedvieetuddvheeggeetgedvhfdvfeeufeeiiedtgeekhffgueen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdprhgvfhdrnh
    grmhgvpdhrvghfrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:RIjmaLFazMteiJl56fg6yM8n3D0KR95nCUNIL5r1UdSboFNMyULCGA>
    <xmx:RIjmaJFyH99bH6BvCLOThGJHWfZlaUd9_ZADyCHesImi1lB598t_hw>
    <xmx:RIjmaJQsLiw9-G9JdnUDQ2kkPNMBEqEGC1zHBaXE5oAm1XAnLFLzew>
    <xmx:RIjmaKJpLsqankxXvwqOHjGjhh861r20oeCHuCTF9iWr7hk6QEcNmA>
    <xmx:RIjmaI1gHnDFLSvpEFAoUA9DrGgWJNq0CjhCmUzHgxxOkyH_IwZIbjks>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4cb97e97 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Date: Wed, 08 Oct 2025 17:50:15 +0200
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADeI5mgC/42NQQ6CMBBFr0Jm7ZiWYAFX3sOwKGUKIwpNhxAN4
 e5WTuDy/eT9t4FQZBK4ZhtEWll4nhLkpwzcYKeekLvEkKv8ompdYVtgGAUjefT8XCiijBww2Cg
 89Ti3D3KLoFed9sb6wtYe0llIAr+P0L1JPLAsc/wc3VX/1iOhlSr/TawaFdbaOFc6U1WmvSXrz
 C9o9n3/Ai3dhnPZAAAA
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

The topic is built on top of 45547b60ac (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-10-05). There is a merge conflict with
tb/incremental-midx-part-3.1, which moves code from "builtin/repack.c"
into "repack-*.c".

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
 builtin/repack.c            |  16 ++-
 builtin/replace.c           |  21 ++--
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
 65 files changed, 791 insertions(+), 831 deletions(-)

Range-diff versus v1:

 1:  4f4de68657 !  1:  3d0c5110b3 refs: introduce wrapper struct for `each_ref_fn`
    @@ Commit message
         more opaque. While it is obvious which callsites need to be fixed up
         when we change the function type, it's not obvious anymore once we use
         a structure. That being said, we only have a handful of sites that
    -    actually need to populate this wrapper structure: our ref backends and
    -    "refs/iterator.c".
    +    actually need to populate this wrapper structure: our ref backends,
    +    "refs/iterator.c" as well as very few sites that invoke the iterator
    +    callback functions directly.
     
         Introduce this wrapper structure so that we can adapt the iterator
         interfaces more readily.
    @@ refs.h: struct ref_transaction;
     +
      /*
       * The signature for the callback function for the for_each_*()
    -  * functions below.  The memory pointed to by the refname and oid
    -  * arguments is only guaranteed to be valid for the duration of a
    +- * functions below.  The memory pointed to by the refname and oid
    +- * arguments is only guaranteed to be valid for the duration of a
    ++ * functions below.  The memory pointed to by the `struct reference`
    ++ * argument is only guaranteed to be valid for the duration of a
       * single callback invocation.
       */
     -typedef int each_ref_fn(const char *refname, const char *referent,
 2:  e90c26f12c !  2:  412818b8d1 refs: introduce `.ref` field for the base iterator
    @@ Commit message
         refs: introduce `.ref` field for the base iterator
     
         The base iterator has a couple of fields that tracks the name, target,
    -    object ID and flags for the current reference. Due do this design we
    +    object ID and flags for the current reference. Due to this design we
         have to create a new `struct reference` whenever we want to hand over
         that reference to the callback function, which is tedious and not very
         efficient.
     
    -    Convert the structure to instead contain a `stuct reference` as member.
    +    Convert the structure to instead contain a `struct reference` as member.
         This member is expected to be populated by the implementations of the
         iterator and is handed over to the callback directly.
     
    +    While at it, simplify `should_pack_ref()` to take a `struct reference`
    +    directly instead of passing its respective fields.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs.c ##
 -:  ---------- >  3:  231adc4960 refs: fully reset `struct ref_iterator::ref` on iteration
 3:  bc0432dc35 =  4:  1d2189e7a9 refs: refactor reference status flags
 4:  aba078d59c !  5:  1f975f1079 refs: expose peeled object ID via the iterator
    @@ refs.h: struct reference {
     +
      /*
       * The signature for the callback function for the for_each_*()
    -  * functions below.  The memory pointed to by the refname and oid
    +  * functions below.  The memory pointed to by the `struct reference`
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static int next_record(struct packed_ref_iterator *iter)
    - 		if ((iter->base.ref.flags & REF_ISBROKEN)) {
    - 			oidclr(&iter->peeled, iter->repo->hash_algo);
      			iter->base.ref.flags &= ~REF_KNOWS_PEELED;
    -+			iter->base.ref.peeled_oid = NULL;
      		} else {
      			iter->base.ref.flags |= REF_KNOWS_PEELED;
     +			iter->base.ref.peeled_oid = &iter->peeled;
      		}
      	} else {
      		oidclr(&iter->peeled, iter->repo->hash_algo);
    -+		iter->base.ref.peeled_oid = NULL;
    - 	}
    - 
    - 	return ITER_OK;
    -
    - ## refs/ref-cache.c ##
    -@@ refs/ref-cache.c: static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
    - 			iter->base.ref.name = entry->name;
    - 			iter->base.ref.target = entry->u.value.referent;
    - 			iter->base.ref.oid = &entry->u.value.oid;
    -+			iter->base.ref.peeled_oid = NULL;
    - 			iter->base.ref.flags = entry->flag;
    - 			return ITER_OK;
    - 		}
     
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: struct reftable_ref_iterator {
    @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_ite
      		iter->base.ref.oid = &iter->oid;
     +		if (iter->ref.value_type == REFTABLE_REF_VAL2)
     +			iter->base.ref.peeled_oid = &iter->peeled_oid;
    -+		else
    -+			iter->base.ref.peeled_oid = NULL;
      		iter->base.ref.flags = flags;
      
      		break;
 5:  664775be02 !  6:  8f3b757726 upload-pack: convert to use `reference_get_peeled_oid()`
    @@ Commit message
         The `write_v0_ref()` callback is invoked from two callsites:
     
           - Once via `send_ref()` which is a callback passed to
    -        `for_each_namespaced_ref_1()`.
    +        `for_each_namespaced_ref_1()` and `refs_head_ref_namespaced()`.
     
           - Once manually to announce capabilities.
     
 6:  e0c95a3df2 =  7:  603213919f ref-filter: propagate peeled object ID
 7:  9ef21d25d1 =  8:  8d3cae65f8 builtin/show-ref: convert to use `reference_get_peeled_oid()`
 8:  2d32a2410d =  9:  35226e7a7d refs: drop `current_ref_iter` hack
 9:  a9fbbe6b1a = 10:  2e73f3b227 refs: drop infrastructure to peel via iterators
10:  68b3a85ade ! 11:  ade4d5875a object: add flag to `peel_object()` to verify object type
    @@ Commit message
         tagged object.
     
         The relevant code path here eventually ends up in `parse_tag_buffer()`.
    -    Here, we parset he various fields of the tag, including the "type". Once
    +    Here, we parse the various fields of the tag, including the "type". Once
         we've figured out the type and the tagged object ID, we call one of the
         `lookup_${type}()` functions for whatever type we have found. There is
         two possible outcomes in the successful case:
11:  80ec80883e = 12:  c1ccb8e6e1 refs: don't store peeled object IDs for invalid tags
12:  8056c68337 = 13:  e5db08d3fa ref-filter: detect broken tags when dereferencing them
13:  40cc049093 ! 14:  617d03d8c1 ref-filter: parse objects on demand
    @@ Metadata
      ## Commit message ##
         ref-filter: parse objects on demand
     
    -    When formatting an arbitray object we parse that object regardless of
    +    When formatting an arbitrary object we parse that object regardless of
         whether or not we actually need any parsed data. In fact, many of the
         atoms we have don't require any.
     

---
base-commit: 45547b60aca32b45d2f1ef93462cf9df28637c13
change-id: 20250918-b4-pks-ref-filter-skip-parsing-objects-f0d1f6af4a9f

