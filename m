Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22241E480
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622633; cv=none; b=A500+LGBIHaSRpvzxD/7dgTBnUQNeC0Q7uuw+YjhFVUDsDMfsIAB70HZP/uc/ffifZ3qXldollOWOp4tKLHS3V7uUiFt4TTLuq2CuPgmOC8vfxrv7yEFKN08623KYxnDUS3NFNoAD3SfuNSudroMKdv+uFD+laibsN/XhhzHzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622633; c=relaxed/simple;
	bh=eGvuKELwTnmoZGlXmXMIdm3t0h+TvpvUuIoi+yt4y3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fk/SX8fYoLU3Tgo5uhrG2ueh0TnK1uAMNooRtY6vxMifDSu1Yb9AYMnv0856matEbh83GlEMOy7wFSpAVrBnC1QOlVQhCy9yfOhETiiL9EUIkiMXSAiC1owC+RzWzDaR10GrsT1fzN1kMSeKiisIviklEr/UsIVLPU5U+/sjeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sxZmf0MJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfMKjO8o; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sxZmf0MJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfMKjO8o"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F5C07A01ED;
	Tue, 23 Sep 2025 06:17:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 06:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622629;
	 x=1758709029; bh=SSHCmcXGjaHI+5BJZ1c4wbGHcdO0MGPfUotKEUtQl1Y=; b=
	sxZmf0MJpi5QEJCkd3mF+EBHqXgwb9M0Lz28UEViY5+84NuRPMrjuoD/fYviInaK
	sHLLWsy7NYXbCe2O68vks9h5hhqpFvXuShdOe0qbJjAH/L3O0yTp8S1tWQIoJrWm
	FNhQUMpHFIwdUhOqLtJlzwJXFcLNJHVhZwwyO9mu+bN+iPmBoZmhLVAH12srHqLq
	D53l5d59XxCV3/C2tCZOgdDX5/39rl56EpcZZxWqN11UJbHMAwmr8molICFzDpTH
	96/MlqPhRk9WB79zGfvsom/IRsZaTPDNexvjsD/CopitCVeX4fTivd5cFO8oVly8
	a9kapyQO9vOEyl/1Lgl7Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622629; x=
	1758709029; bh=SSHCmcXGjaHI+5BJZ1c4wbGHcdO0MGPfUotKEUtQl1Y=; b=A
	fMKjO8osl1nW4z4wcwXGKqh+Y9ZwvP14sE4FBCbFmRxHvvEaaApWtNB8Kofv+Nxc
	wEYvzCBBJsYT/TmyKXWH3cgJSFCwtdF9BBfoEXSXIB4xAhllr3mzrSFA07ub9mjU
	cdORO2owxNQuyzKEcvUPBZSS4FnQQiSrFSp/F46rW1gpZaqV+QG2scmHxuKxN5Rd
	eKusBE7EvcoarrqThjmBz29diBqV+cWDFg4UuFpqeRTjM3lq7hKz8geNJbm7/Qk9
	2ZZlsyYEfsg3RPaGKZUGwcBXYlKnienA/DE4qaqHR8aXAmYxgppUyKjlYKRWNpDW
	PE2zJOaB8pUtP3bLbozLQ==
X-ME-Sender: <xms:pXPSaPP0qDQpioNkcWWLH6U5J5OgO2MUjSVB4s33kNTYESSVwCDYew>
    <xme:pXPSaNred7lOqzWdgaKFbx1JEH3bLmlpAW3_WU9aCwr7zmDzVyB3pmGGIHAjj5rEa
    m9LPbNezi_ABUrkKpkr_Leoaby7Nw0C4UfSGS40r--dR9S4d0VX>
X-ME-Received: <xmr:pXPSaIEZ_W_5zF3lrjyIpmblN7_cJwcJ_jnsXnhkBZlgj26mQSEwQx0qnsx5zD5GwA8VvxxTmOtnpMet5RbOmdKyp8i1w6JX6W9b7x5Qby6y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pXPSaKoxh1hqjlnI1VGyuYC5kkj-XPtWkUgyajKbkaNsbk9DvFL9Cg>
    <xmx:pXPSaJawXMO4XnfQrENXo-C11KfLJCYViGLl7_Pa0baUgL28C-w3TA>
    <xmx:pXPSaLUSluK_YD4ir5JvmfeehKQfhl2G4MHZL4JXHSE-Scwm3ZYTuw>
    <xmx:pXPSaK8LmZGa7fom1N1reCc-sq1zS2evBJyksmfKFWgMrw4UDiJpkQ>
    <xmx:pXPSaHqGNoiLQV_5F257oN-1Q20IMwMtmnR6i4CIkr7p62RLvdWLiHkE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06548384 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/15] packfile: carve out a new packfile store
Date: Tue, 23 Sep 2025 12:16:59 +0200
Message-Id: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtz0mgC/3XPTU7DMBAF4KtUXmPk+bGJWXEPxMJNJtQqtFGMI
 lCVuzOukJoiefmsmc/zLqbInKWY593FzLLkks8nDeFhZ/pDOr2LzYNmgw6961ywe7bTsdgp9cc
 xf0ix5es8i03MKbiuTxSD0eVpljF/X+HXN82HXOd+rv8sUF//SIgtcgHrLARVGQXQpxedesyfp
 noLbgyEpoFqDOACEnkvcbwz6GZEh02D1AgRPT51MspwfwdvjXYXrl089LxPFODfHX5jgG8avnY
 JxI50jvhmrOv6C5TYzvjJAQAA
X-Change-ID: 20250806-b4-pks-packfiles-store-a44a608ca396
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

information about a object database's packfiles is currently distributed
across two different structures:

  - `struct packed_git` contains the `next` pointer as well as the
    `mru_head`, both of which serve to store the list of packfiles.

  - `struct object_database` contains several fields that relate to the
    packfiles.

So we don't really have a central data structure that tracks our
packfiles, and consequently responsibilities aren't always clear cut.
A consequence for the upcoming pluggable object databases is that this
makes it very hard to move management of packfiles from the object
database level down into the object database source.

This patch series introduces a new `struct packfile_store`, which is
about to become the single source of truth for managing packfiles, and
carves out the packfile store subsystem.

This is the first step to make packfiles work with pluggable object
databases. Next steps will be to:

  - Move the `struct packed_git::next` and `struct packed::mru_head`
    pointers into the packfile store so that `struct packed_git` only
    tracks a single packfile.

  - Push the `struct packfile_store` down one level so that it's not
    hosted by the object database anymore, but instead by the object
    database source.

Changes in v2:
  - Convert the `initialized` flag into a boolean.
  - Polish some commit messages.
  - Some smaller formatting changes to the layout of `struct
    object_database`.
  - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im

Changes in v3:
  - Rebased on top of master at 6ad8021821 (The fifth batch, 2025-08-29)
    with ps/object-store-midx-dedup-info at 13296ac909 (midx: compute
    paths via their source, 2025-08-11) merged into it. This fixes
    various conflicts with "seen". There's still two conflicts: a
    trivial one with jt/de-global-bulk-checkin. And a more complex one
    with tb/prepare-midx-pack-cleanup. I don't think it's necessary to
    really address the first one, but I'm unsure how to proceed with the
    second one given that the patch series still seems to be cooking.
  - Set `struct object_database::packfiles` to `NULL` after free'ing it.
  - Add a comment to explain the kept cache.
  - Fix a missing `obj_read_lock()` call.
  - Drop the commit that always adds packfiles to the MRU. I've moved
    this into a subsequent patch series.
  - Avoid some overly long lines by storing the pointer to the packfile
    store on the stack.
  - Point out the difference between `get_all_packs()` and
    `get_packed_git()`.
  - Link to v2: https://lore.kernel.org/r/20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im

Changes in v4:
  - Small code style improvement as suggested by Junio.
  - Some commit message improvements as suggested by Karthik.
  - Link to v3: https://lore.kernel.org/r/20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im

Changes in v5:
  - Stop closing packfiles when freeing the packfile store.
  - Don't drop `get_packed_git()` for now. This will be done in a
    subsequent patch series.
  - Link to v4: https://lore.kernel.org/r/20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im

Changes in v6:
  - Fix a grammar issue in a commit message.
  - Update a comment to reflect that we access `struct packfile_store`
    in "midx.c" directly, as well.
  - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (15):
      packfile: introduce a new `struct packfile_store`
      odb: move list of packfiles into `struct packfile_store`
      odb: move initialization bit into `struct packfile_store`
      odb: move packfile map into `struct packfile_store`
      odb: move MRU list of packfiles into `struct packfile_store`
      odb: move kept cache into `struct packfile_store`
      packfile: reorder functions to avoid function declaration
      packfile: refactor `prepare_packed_git()` to work on packfile store
      packfile: split up responsibilities of `reprepare_packed_git()`
      packfile: refactor `install_packed_git()` to work on packfile store
      packfile: introduce function to load and add packfiles
      packfile: move `get_multi_pack_index()` into "midx.c"
      packfile: refactor `get_packed_git()` to work on packfile store
      packfile: refactor `get_all_packs()` to work on packfile store
      packfile: refactor `get_packed_git_mru()` to work on packfile store

 builtin/backfill.c          |   2 +-
 builtin/cat-file.c          |   3 +-
 builtin/count-objects.c     |   3 +-
 builtin/fast-import.c       |  10 +-
 builtin/fsck.c              |  11 +-
 builtin/gc.c                |  14 ++-
 builtin/grep.c              |   2 +-
 builtin/index-pack.c        |  10 +-
 builtin/pack-objects.c      |  32 +++--
 builtin/pack-redundant.c    |   6 +-
 builtin/receive-pack.c      |   2 +-
 builtin/repack.c            |  11 +-
 bulk-checkin.c              |   2 +-
 connected.c                 |   5 +-
 fetch-pack.c                |   4 +-
 http-backend.c              |   5 +-
 http.c                      |   5 +-
 http.h                      |   2 +-
 midx.c                      |  29 ++---
 midx.h                      |   1 +
 object-name.c               |   6 +-
 odb.c                       |  40 +++++--
 odb.h                       |  36 ++----
 pack-bitmap.c               |   4 +-
 pack-objects.c              |   3 +-
 packfile.c                  | 283 ++++++++++++++++++++++++--------------------
 packfile.h                  | 125 ++++++++++++++++---
 server-info.c               |   3 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   2 +-
 transport-helper.c          |   2 +-
 31 files changed, 396 insertions(+), 269 deletions(-)

Range-diff versus v5:

 1:  00b1c404db !  1:  976df0d77d packfile: introduce a new `struct packfile_store`
    @@ Metadata
      ## Commit message ##
         packfile: introduce a new `struct packfile_store`
     
    -    Information about a object database's packfiles is currently distributed
    -    across two different structures:
    +    Information about an object database's packfiles is currently
    +    distributed across two different structures:
     
           - `struct packed_git` contains the `next` pointer as well as the
             `mru_head`, both of which serve to store the list of packfiles.
 2:  bd31834585 =  2:  0aa64a5a70 odb: move list of packfiles into `struct packfile_store`
 3:  d5d99e619b =  3:  7681f7d72d odb: move initialization bit into `struct packfile_store`
 4:  8d905f3e58 !  4:  b65334c581 odb: move packfile map into `struct packfile_store`
    @@ odb.c: void odb_clear(struct object_database *o)
      }
     
      ## odb.h ##
    +@@ odb.h: struct object_database {
    + 	/*
    + 	 * private data
    + 	 *
    +-	 * should only be accessed directly by packfile.c
    ++	 * Should only be accessed directly by packfile.c and midx.c.
    + 	 */
    + 	struct packfile_store *packfiles;
    + 	/* A most-recently-used ordered version of the packed_git list. */
     @@ odb.h: struct object_database {
      	struct cached_object_entry *cached_objects;
      	size_t cached_object_nr, cached_object_alloc;
 5:  a5d14ca02c !  5:  5d067ef530 odb: move MRU list of packfiles into `struct packfile_store`
    @@ odb.h
      #include "oidmap.h"
      #include "string-list.h"
     @@ odb.h: struct object_database {
    - 	 * should only be accessed directly by packfile.c
    + 	 * Should only be accessed directly by packfile.c and midx.c.
      	 */
      	struct packfile_store *packfiles;
     -	/* A most-recently-used ordered version of the packed_git list. */
 6:  a957203b3c !  6:  2d4cd7e170 odb: move kept cache into `struct packfile_store`
    @@ Commit message
     
      ## odb.h ##
     @@ odb.h: struct object_database {
    + 	struct commit_graph *commit_graph;
      	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
      
    - 	/*
    +-	/*
     -	 * private data
     -	 *
    --	 * should only be accessed directly by packfile.c
    -+	 * Should only be accessed directly by packfile.c
    - 	 */
    +-	 * Should only be accessed directly by packfile.c and midx.c.
    +-	 */
    ++	/* Should only be accessed directly by packfile.c and midx.c. */
      	struct packfile_store *packfiles;
     -	struct {
     -		struct packed_git **packs;
 7:  b49fffa17f =  7:  dd515d94dd packfile: reorder functions to avoid function declaration
 8:  015d0de331 =  8:  7c7d116314 packfile: refactor `prepare_packed_git()` to work on packfile store
 9:  29540e3690 =  9:  b75323ece8 packfile: split up responsibilities of `reprepare_packed_git()`
10:  e3283daf07 = 10:  7863cd6bae packfile: refactor `install_packed_git()` to work on packfile store
11:  257a6f8458 = 11:  f65025d54e packfile: introduce function to load and add packfiles
12:  081bb4d348 = 12:  15e962daea packfile: move `get_multi_pack_index()` into "midx.c"
13:  39f70c5cca = 13:  7ba39efd3a packfile: refactor `get_packed_git()` to work on packfile store
14:  36f5d08128 = 14:  505d32ea35 packfile: refactor `get_all_packs()` to work on packfile store
15:  a558e95cf0 = 15:  c474d336be packfile: refactor `get_packed_git_mru()` to work on packfile store

---
base-commit: 337c7a0bbcf228ce11c87d066ecee352b3e52467
change-id: 20250806-b4-pks-packfiles-store-a44a608ca396

