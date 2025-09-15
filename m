Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40442D3ECC
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926473; cv=none; b=lVHhMshXIMDJeUJLaXPoOkoZ9EROpLBSuVYsy/3DsJZ1rORnWRsyQmFAidnoUNC6hFWnw4LJf2h6pGGSmFg9BEBx38PPc2pic/f1X7coqtPU90bVoHdmU+IfpZpScq/dd6YOIPh+ubfTlld09xLrqMFoaCZep1sMza40ldPixE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926473; c=relaxed/simple;
	bh=PBczygZenuhiENkLHtNugpm3eh2KA0tj8yxziH5mLxc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=k1f8IjlTXE4c4+GY8TJTVqSV1M2c6C8t/AxV66I5NI+1ttPQVJIsIat7ehKWkMKNS6aQ6KWQ4Q3UzlZWB0f28UDgMBWYjW0wWi3Q1ObFbbBQ8rgJImx8UerResDBtq+fOcK0Vw3TaJ0s75aFbGEGGNclpsN6kSqsl4hfbvTp/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o6nx3Dhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KhpjyIkc; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o6nx3Dhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhpjyIkc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF55314001A3;
	Mon, 15 Sep 2025 04:54:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 04:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926469;
	 x=1758012869; bh=K+Emb7pTMj/R8Hi97YiHKddywe+cfpCW9rCrAPXpzc0=; b=
	o6nx3Dhn2ZKIkTW15Db2MSWevqPFFvHqeZumnwaoUOo3IawJvNmgMoGFS+QWMf4J
	GZwciN9SbIs1pruFWz4jMYMbWsXlhxqU31mY0wC4rxhMIwvtUfHSHT3MBG/O5Fjl
	yNIDyZXNGV1WQJ4kzrlR49sSUe+tP9IesTDcmsiXZHs7LR3hE6NvOfaXy+dXNl0B
	FXyDahjKym+C2btDkUI/Ogu5S+Whe7YrtIavVn7ylICmbLIooDsVuiqvNBvycjlp
	6cibFJXOy5ZfWNYsEnSwarK4XqiPmyfKn9CEL1/UcdJJpu58Ve3M4HBjuQw4k3Ov
	p1RSXd+eGESNIYR4FZh0gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926469; x=
	1758012869; bh=K+Emb7pTMj/R8Hi97YiHKddywe+cfpCW9rCrAPXpzc0=; b=K
	hpjyIkctIJlzVWtg+LUm0jBvwDyXStZNjlKlMxi7KTqq4AGKMaCoy/UgOKaIxF2N
	OYw0dLS1bR5oW2zbysRyhOiPFpCiuJ1T3ywjAPos/YNM2klyzR/pnRJT7zg2wdAn
	nMcUDxX9SS1qp8HBmz5Ng1wNfCac6QmUhal6I5Se2Jelk7VygHNYzUF3HkyduaNS
	BcPiDpIWtHjPz5kRHUGSsR+hnhpsdzkUsq1v8rXhYLTb1g16JJuO5JTCGe+7AvZ2
	r+o6RtTGWmt2aYiC1SXyN4zAuItwQBK6Orc/QnGML/3SQHHdaA3NiLcUv8N+i4x2
	y0nX3/sGppjx2Tg+CWIKg==
X-ME-Sender: <xms:RdTHaOBn9s1p2YiJluMQ08RE7U7RoIu6JwyKYHXoek-98Y8imBpLbg>
    <xme:RdTHaEAN0LjqmLHjbPdRGYitrtk4Yuzx05jpJWutmoaWsgXfPEAVeVxqC3lzBEid9
    IC14JVqZ1KWcxpXtw>
X-ME-Received: <xmr:RdTHaIBOHtk3sq8VMLt0b0hari9mh2w9-0jivwXaYAfOsDSxyGD55a8cQfzlOml8FAxugJkQAJtNb7Lx_5uSXhUSj-xQuajw3HBAkoCdFV8SDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:RdTHaHophD-wmMrS6iDeF6dARhCxXaV_qDeIm012CfONZvHOT3gvTw>
    <xmx:RdTHaKme_dQ20R3A97RlKNGwJey3zALdtdXLadWpSWufIqY-oKivYg>
    <xmx:RdTHaPyrjbQ2i4YJN-yFapYt2D6-C6JXkdDVYx7wjep2nK4rNKlQ1Q>
    <xmx:RdTHaK_jlzQAQNDdH-cP-_KOWCKcR02sGJWcdqmhJs-9kHLk1mSfsw>
    <xmx:RdTHaK3_KfD-XBa-zcTXns_027j5CPv0jPKh9HLo8ahjiUKyl8T2-JBQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dfcbb12c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/15] packfile: carve out a new packfile store
Date: Mon, 15 Sep 2025 10:54:18 +0200
Message-Id: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrUx2gC/3XPzQ6CMAwH8FchOzuzdh8yT76H8TCgyIICYYZoC
 O/uICbCgeO/aX9tRxao9xTYORlZT4MPvm1i0IeE5ZVr7sR9ETNDgVqkwvBM8a4OvHN5XfoHBR5
 ebU/cKeWMSHMnrWFxuOup9O8Fvt5irvzc91n2DDBXfyTYPXIALjiYqCokQO0usevon2z2BlwZC
 LsGRqMAYVBKrcmWG0P+DStw15DRMBY1nlIqqdjeodbG/i9q/kVDrjInDazumKbpCzZVOXSFAQA
 A
X-Change-ID: 20250806-b4-pks-packfiles-store-a44a608ca396
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
 odb.h                       |  34 ++----
 pack-bitmap.c               |   4 +-
 pack-objects.c              |   3 +-
 packfile.c                  | 283 ++++++++++++++++++++++++--------------------
 packfile.h                  | 125 ++++++++++++++++---
 server-info.c               |   3 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   2 +-
 transport-helper.c          |   2 +-
 31 files changed, 396 insertions(+), 267 deletions(-)

Range-diff versus v4:

 1:  b006e4f919 =  1:  6dbb423d97 packfile: introduce a new `struct packfile_store`
 2:  078a3aebf1 !  2:  1f402667fd odb: move list of packfiles into `struct packfile_store`
    @@ packfile.c: struct packfile_store *packfile_store_new(struct object_database *od
      
      void packfile_store_free(struct packfile_store *store)
      {
    -+	packfile_store_close(store);
    -+
     +	for (struct packed_git *p = store->packs, *next; p; p = next) {
     +		next = p->next;
     +		free(p);
     +	}
    -+
      	free(store);
      }
     +
 3:  8bbb9b5957 =  3:  b3bae09159 odb: move initialization bit into `struct packfile_store`
 4:  499826d25e !  4:  91d3c6016b odb: move packfile map into `struct packfile_store`
    @@ packfile.c: int parse_pack_header_option(const char *in, unsigned char *out, uns
      }
      
     @@ packfile.c: void packfile_store_free(struct packfile_store *store)
    + 		next = p->next;
      		free(p);
      	}
    - 
     +	hashmap_clear(&store->map);
      	free(store);
      }
 5:  54c02314ac =  5:  5aa029b482 odb: move MRU list of packfiles into `struct packfile_store`
 6:  7810d28c81 =  6:  d2f430f86f odb: move kept cache into `struct packfile_store`
 7:  c5cc67c267 =  7:  1f35516b99 packfile: reorder functions to avoid function declaration
 8:  012059000e =  8:  2c298068b5 packfile: refactor `prepare_packed_git()` to work on packfile store
 9:  f05aa1f700 =  9:  eece281f07 packfile: split up responsibilities of `reprepare_packed_git()`
10:  62ad7cfc0c = 10:  68d057c18c packfile: refactor `install_packed_git()` to work on packfile store
11:  ed795182ac = 11:  0700b475ce packfile: introduce function to load and add packfiles
12:  fc97ab562c = 12:  7d2e76e127 packfile: move `get_multi_pack_index()` into "midx.c"
13:  ececdd0a23 ! 13:  cea2433d84 packfile: remove `get_packed_git()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    packfile: remove `get_packed_git()`
    +    packfile: refactor `get_packed_git()` to work on packfile store
     
    -    We have two different functions to retrieve packfiles for a packfile
    -    store:
    -
    -      - `get_packed_git()` returns the list of packfiles after having called
    -        `prepare_packed_git()`.
    -
    -      - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
    -        calls `prepare_midx_pack()` for each pack.
    -
    -    Based on the naming alone one might think that `get_all_packs()` would
    -    return more packs than `get_packed_git()`. But that's not the case: both
    -    functions end up returning the exact same list of packfiles. The real
    -    difference between those functions is that `get_all_packs()` also loads
    -    the info of whether or not a packfile is part of a multi-pack index.
    -
    -    Preparing this extra information also shouldn't be significantly more
    -    expensive:
    -
    -      - We have already loaded all packfiles via `prepare_packed_git_one()`.
    -        So given that multi-pack indices may only refer to packfiles in the
    -        same object directory we know that we already loaded each packfile.
    -
    -      - The multi-pack index was prepared via `packfile_store_prepare()`
    -        already, which calls `prepare_multi_pack_index_one()`.
    -
    -      - So all that remains to be done is to look up the index of the pack
    -        in its multi-pack index so that we can store that info in both the
    -        pack itself and the MIDX.
    -
    -    So it is somewhat confusing to readers that one of these two functions
    -    claims to load "all" packfiles while the other one doesn't, even though
    -    the ultimate difference is way more nuanced.
    -
    -    Convert all of these sites to use `get_all_packs()` instead and remove
    -    `get_packed_git()`. There doesn't seem to be a good reason to discern
    -    these two functions.
    +    The `get_packed_git()` function prepares the packfile store and then
    +    returns its packfiles. Refactor it to accept a packfile store instead of
    +    a repository to clarify its scope.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ builtin/gc.c: static int incremental_repack_auto_condition(struct gc_config *cfg
      		return 1;
      
     -	for (p = get_packed_git(the_repository);
    -+	for (p = get_all_packs(the_repository);
    ++	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
      	     count < incremental_repack_auto_limit && p;
      	     p = p->next) {
      		if (!p->multi_pack_index)
    @@ builtin/grep.c: int cmd_grep(int argc,
      			repo_read_gitmodules(the_repository, 1);
      		if (startup_info->have_repository)
     -			(void)get_packed_git(the_repository);
    -+			packfile_store_prepare(the_repository->objects->packfiles);
    ++			(void)packfile_store_get_packs(the_repository->objects->packfiles);
      
      		start_threads(&opt);
      	} else {
    @@ object-name.c: static void find_short_packed_object(struct disambiguate_state *d
      	}
      
     -	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
    -+	for (p = get_all_packs(ds->repo); p && !ds->ambiguous;
    ++	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
      	     p = p->next)
      		unique_in_pack(p, ds);
      }
    @@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
      	}
      
     -	for (p = get_packed_git(mad->repo); p; p = p->next)
    -+	for (p = get_all_packs(mad->repo); p; p = p->next)
    ++	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
      		find_abbrev_len_for_pack(p, mad);
      }
      
    @@ packfile.c: void packfile_store_reprepare(struct packfile_store *store)
      }
      
     -struct packed_git *get_packed_git(struct repository *r)
    --{
    ++struct packed_git *packfile_store_get_packs(struct packfile_store *store)
    + {
     -	packfile_store_prepare(r->objects->packfiles);
     -	return r->objects->packfiles->packs;
    --}
    --
    ++	packfile_store_prepare(store);
    ++	return store->packs;
    + }
    + 
      struct packed_git *get_all_packs(struct repository *r)
    - {
    - 	packfile_store_prepare(r->objects->packfiles);
     
      ## packfile.h ##
    +@@ packfile.h: void packfile_store_reprepare(struct packfile_store *store);
    + void packfile_store_add_pack(struct packfile_store *store,
    + 			     struct packed_git *pack);
    + 
    ++/*
    ++ * Get packs managed by the given store. Does not load the MIDX or any packs
    ++ * referenced by it.
    ++ */
    ++struct packed_git *packfile_store_get_packs(struct packfile_store *store);
    ++
    + /*
    +  * Open the packfile and add it to the store if it isn't yet known. Returns
    +  * either the newly opened packfile or the preexisting packfile. Returns a
     @@ packfile.h: int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
      #define PACKDIR_FILE_GARBAGE 4
      extern void (*report_garbage)(unsigned seen_bits, const char *path);
14:  ed7a0d5457 ! 14:  8d5296bbbe packfile: refactor `get_all_packs()` to work on packfile store
    @@ builtin/cat-file.c: static void batch_each_object(struct batch_options *opt,
      		struct packed_git *pack;
      
     -		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
    -+		for (pack = packfile_store_get_packs(packs); pack; pack = pack->next) {
    ++		for (pack = packfile_store_get_all_packs(packs); pack; pack = pack->next) {
      			if (bitmap_index_contains_pack(bitmap, pack) ||
      			    open_pack_index(pack))
      				continue;
    @@ builtin/count-objects.c: int cmd_count_objects(int argc,
      		struct strbuf garbage_buf = STRBUF_INIT;
      
     -		for (p = get_all_packs(the_repository); p; p = p->next) {
    -+		for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      			if (!p->pack_local)
      				continue;
      			if (open_pack_index(p))
    @@ builtin/fast-import.c: static int store_object(
      		duplicate_count_by_type[type]++;
      		return 1;
     -	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
    -+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
    ++	} else if (find_oid_pack(&oid, packfile_store_get_all_packs(packs))) {
      		e->type = type;
      		e->pack_id = MAX_PACK_ID;
      		e->idx.offset = 1; /* just not zero! */
    @@ builtin/fast-import.c: static void stream_blob(uintmax_t len, struct object_id *
      		truncate_pack(&checkpoint);
      
     -	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
    -+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
    ++	} else if (find_oid_pack(&oid, packfile_store_get_all_packs(packs))) {
      		e->type = OBJ_BLOB;
      		e->pack_id = MAX_PACK_ID;
      		e->idx.offset = 1; /* just not zero! */
    @@ builtin/fsck.c: static int mark_packed_for_connectivity(const struct object_id *
      
      	if (show_progress) {
     -		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
    -+		for (struct packed_git *p = packfile_store_get_packs(packs); p; p = p->next)
    ++		for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next)
      			pack_count++;
      		progress = start_delayed_progress(the_repository,
      						  "Verifying reverse pack-indexes", pack_count);
    @@ builtin/fsck.c: static int mark_packed_for_connectivity(const struct object_id *
      	}
      
     -	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
    -+	for (struct packed_git *p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		int load_error = load_pack_revindex_from_disk(p);
      
      		if (load_error < 0) {
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      
      			if (show_progress) {
     -				for (p = get_all_packs(the_repository); p;
    -+				for (p = packfile_store_get_packs(packs); p;
    ++				for (p = packfile_store_get_all_packs(packs); p;
      				     p = p->next) {
      					if (open_pack_index(p))
      						continue;
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      							  _("Checking objects"), total);
      			}
     -			for (p = get_all_packs(the_repository); p;
    -+			for (p = packfile_store_get_packs(packs); p;
    ++			for (p = packfile_store_get_all_packs(packs); p;
      			     p = p->next) {
      				/* verify gives error messages itself */
      				if (verify_pack(the_repository,
    @@ builtin/gc.c: static int too_many_loose_objects(struct gc_config *cfg)
      	struct packed_git *p, *base = NULL;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packfiles); p; p = p->next) {
      		if (!p->pack_local || p->is_cruft)
      			continue;
      		if (limit) {
    @@ builtin/gc.c: static struct packed_git *find_base_packs(struct string_list *pack
      		return 0;
      
     -	for (cnt = 0, p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (cnt = 0, p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (cnt = 0, p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (!p->pack_local)
      			continue;
      		if (p->pack_keep)
    -@@ builtin/gc.c: static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
    - 	if (incremental_repack_auto_limit < 0)
    - 		return 1;
    - 
    --	for (p = get_all_packs(the_repository);
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
    - 	     count < incremental_repack_auto_limit && p;
    - 	     p = p->next) {
    - 		if (!p->multi_pack_index)
     @@ builtin/gc.c: static off_t get_auto_pack_size(void)
      	struct repository *r = the_repository;
      
      	odb_reprepare(r->objects);
     -	for (p = get_all_packs(r); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
      		if (p->pack_size > max_size) {
      			second_largest_size = max_size;
      			max_size = p->pack_size;
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(struct rev_info *
      	string_list_remove_duplicates(&exclude_packs, 0);
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		const char *pack_name = pack_basename(p);
      
      		if ((item = string_list_lookup(&include_packs, pack_name)))
    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
      	 * unknown packs do not halt the reachability traversal early.
      	 */
     -	for (p = get_all_packs(the_repository); p; p = p->next)
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next)
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next)
      		p->pack_keep_in_core = 0;
      	mark_pack_kept_in_core(fresh_packs, 1);
      
    @@ builtin/pack-objects.c: static void read_cruft_objects(void)
      	string_list_sort(&fresh_packs);
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		const char *pack_name = pack_basename(p);
      		struct string_list_item *item;
      
    @@ builtin/pack-objects.c: static void add_unreachable_loose_objects(struct rev_inf
      
      	p = (last_found != (void *)1) ? last_found :
     -					get_all_packs(the_repository);
    -+					packfile_store_get_packs(packs);
    ++					packfile_store_get_all_packs(packs);
      
      	while (p) {
      		if ((!p->pack_local || p->pack_keep ||
    @@ builtin/pack-objects.c: static int has_sha1_pack_kept_or_nonlocal(const struct o
      		}
      		if (p == last_found)
     -			p = get_all_packs(the_repository);
    -+			p = packfile_store_get_packs(packs);
    ++			p = packfile_store_get_all_packs(packs);
      		else
      			p = p->next;
      		if (p == last_found)
    @@ builtin/pack-objects.c: static int loosened_object_can_be_discarded(const struct
      	struct object_id oid;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
      			continue;
      
    @@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, int a
      		return;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		const char *name = basename(p->pack_name);
      		int i;
      
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      		struct packed_git *p;
     -		for (p = get_all_packs(the_repository); p; p = p->next)
     +
    -+		for (p = packfile_store_get_packs(packs); p; p = p->next)
    ++		for (p = packfile_store_get_all_packs(packs); p; p = p->next)
      			if (p->pack_local && p->pack_keep)
      				break;
      		if (!p) /* no keep-able packs found */
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      		struct packed_git *p;
     -		for (p = get_all_packs(the_repository); p; p = p->next) {
     +
    -+		for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      			if (!p->pack_local) {
      				have_non_local_packs = 1;
      				break;
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *
      {
     -	struct packed_git *p = get_all_packs(the_repository);
     +	struct packfile_store *packs = the_repository->objects->packfiles;
    -+	struct packed_git *p = packfile_store_get_packs(packs);
    ++	struct packed_git *p = packfile_store_get_all_packs(packs);
      
      	if (strlen(filename) < 40)
      		die("Bad pack filename: %s", filename);
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack_file(const char *fi
      {
     -	struct packed_git *p = get_all_packs(the_repository);
     +	struct packfile_store *packs = the_repository->objects->packfiles;
    -+	struct packed_git *p = packfile_store_get_packs(packs);
    ++	struct packed_git *p = packfile_store_get_all_packs(packs);
      
      	while (p) {
      		add_pack(p);
    @@ builtin/repack.c: static void existing_packs_release(struct existing_packs *exis
      	struct strbuf buf = STRBUF_INIT;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		int i;
      		const char *base;
      
    @@ builtin/repack.c: static void init_pack_geometry(struct pack_geometry *geometry,
      	struct strbuf buf = STRBUF_INIT;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (args->local && !p->pack_local)
      			/*
      			 * When asked to only repack local packfiles we skip
    @@ builtin/repack.c: static int write_filtered_pack(const struct pack_objects_args
      	size_t i;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (!(p->is_cruft && p->pack_local))
      			continue;
      
    @@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
      			struct packed_git *p;
      
     -			for (p = get_all_packs(the_repository); p; p = p->next) {
    -+			for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++			for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      				if (!p->pack_promisor)
      					continue;
      				if (find_pack_entry_one(oid, p))
    @@ http-backend.c: static void get_head(struct strbuf *hdr, char *arg UNUSED)
      
      	select_getanyfile(hdr);
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (p->pack_local)
      			cnt++;
      	}
      
      	strbuf_grow(&buf, cnt * 53 + 2);
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (p->pack_local)
      			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
      	}
    @@ http.c: static int fetch_and_setup_pack_index(struct packed_git **packs_head,
      	 * even add it to list; we already have all of its objects.
      	 */
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		if (hasheq(p->hash, sha1, the_repository->hash_algo))
      			return 0;
      	}
     
    - ## object-name.c ##
    -@@ object-name.c: static void find_short_packed_object(struct disambiguate_state *ds)
    - 			unique_in_midx(m, ds);
    - 	}
    - 
    --	for (p = get_all_packs(ds->repo); p && !ds->ambiguous;
    -+	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
    - 	     p = p->next)
    - 		unique_in_pack(p, ds);
    - }
    -@@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
    - 			find_abbrev_len_for_midx(m, mad);
    - 	}
    - 
    --	for (p = get_all_packs(mad->repo); p; p = p->next)
    -+	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
    - 		find_abbrev_len_for_pack(p, mad);
    - }
    - 
    -
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static int open_pack_bitmap(struct repository *r,
      	struct packed_git *p;
      	int ret = -1;
      
     -	for (p = get_all_packs(r); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
      		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
      			ret = 0;
      			/*
    @@ pack-bitmap.c: int verify_bitmap_files(struct repository *r)
      	}
      
     -	for (struct packed_git *p = get_all_packs(r);
    -+	for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles);
    ++	for (struct packed_git *p = packfile_store_get_all_packs(r->objects->packfiles);
      	     p; p = p->next) {
      		char *pack_bitmap_name = pack_bitmap_filename(p);
      		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
    @@ pack-objects.c: static void prepare_in_pack_by_idx(struct packing_data *pdata)
      	 */
      	mapping[cnt++] = NULL;
     -	for (p = get_all_packs(pdata->repo); p; p = p->next, cnt++) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next, cnt++) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next, cnt++) {
      		if (cnt == nr) {
      			free(mapping);
      			return;
     
      ## packfile.c ##
    -@@ packfile.c: void packfile_store_reprepare(struct packfile_store *store)
    - 	packfile_store_prepare(store);
    +@@ packfile.c: struct packed_git *packfile_store_get_packs(struct packfile_store *store)
    + 	return store->packs;
      }
      
     -struct packed_git *get_all_packs(struct repository *r)
    -+struct packed_git *packfile_store_get_packs(struct packfile_store *store)
    ++struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
      {
     -	packfile_store_prepare(r->objects->packfiles);
     +	packfile_store_prepare(store);
    @@ packfile.c: struct packed_git **kept_pack_cache(struct repository *r, unsigned f
      		 * the non-kept version.
      		 */
     -		for (p = get_all_packs(r); p; p = p->next) {
    -+		for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
    ++		for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
      			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
      			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
      				ALLOC_GROW(packs, nr + 1, alloc);
    @@ packfile.c: int for_each_packed_object(struct repository *repo, each_packed_obje
      	int pack_errors = 0;
      
     -	for (p = get_all_packs(repo); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next) {
      		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
      			continue;
      		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
     
      ## packfile.h ##
    -@@ packfile.h: void packfile_store_reprepare(struct packfile_store *store);
    - void packfile_store_add_pack(struct packfile_store *store,
    - 			     struct packed_git *pack);
    +@@ packfile.h: void packfile_store_add_pack(struct packfile_store *store,
    +  */
    + struct packed_git *packfile_store_get_packs(struct packfile_store *store);
      
     +/*
     + * Get all packs managed by the given store, including packfiles that are
     + * referenced by multi-pack indices.
     + */
    -+struct packed_git *packfile_store_get_packs(struct packfile_store *store);
    ++struct packed_git *packfile_store_get_all_packs(struct packfile_store *store);
     +
      /*
       * Open the packfile and add it to the store if it isn't yet known. Returns
    @@ server-info.c: static int compare_info(const void *a_, const void *b_)
      	size_t alloc = 0;
      
     -	for (p = get_all_packs(r); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(packs); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
      		/* we ignore things on alternate path since they are
      		 * not available to the pullers in general.
      		 */
    @@ t/helper/test-find-pack.c: int cmd__find_pack(int argc, const char **argv)
      		die("cannot parse %s as an object name", argv[0]);
      
     -	for (p = get_all_packs(the_repository); p; p = p->next)
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
    ++	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next)
      		if (find_pack_entry_one(&oid, p)) {
      			printf("%s\n", p->pack_name);
      			actual_count++;
    @@ t/helper/test-pack-mtimes.c: int cmd__pack_mtimes(int argc, const char **argv)
      		usage(pack_mtimes_usage);
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next) {
      		strbuf_addstr(&buf, basename(p->pack_name));
      		strbuf_strip_suffix(&buf, ".pack");
      		strbuf_addstr(&buf, ".mtimes");
15:  6af591f605 ! 15:  444f7f3b3f packfile: refactor `get_packed_git_mru()` to work on packfile store
    @@ builtin/pack-objects.c: static int want_object_in_pack_mtime(const struct object
      	}
     
      ## packfile.c ##
    -@@ packfile.c: struct packed_git *packfile_store_get_packs(struct packfile_store *store)
    +@@ packfile.c: struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
      	return store->packs;
      }
      
    @@ packfile.c: struct packed_git *packfile_store_get_packs(struct packfile_store *s
      /*
     
      ## packfile.h ##
    -@@ packfile.h: void packfile_store_add_pack(struct packfile_store *store,
    +@@ packfile.h: struct packed_git *packfile_store_get_packs(struct packfile_store *store);
       */
    - struct packed_git *packfile_store_get_packs(struct packfile_store *store);
    + struct packed_git *packfile_store_get_all_packs(struct packfile_store *store);
      
     +/*
     + * Get all packs in most-recently-used order.

---
base-commit: 337c7a0bbcf228ce11c87d066ecee352b3e52467
change-id: 20250806-b4-pks-packfiles-store-a44a608ca396

