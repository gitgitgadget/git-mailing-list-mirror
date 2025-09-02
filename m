Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA372EB869
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810129; cv=none; b=bi1j+8JC/2odJCKzsIliRttCefS8VhUFFba/h8DW2y6Wdarceqp28X4B4m1uu3Ez5/xvu213eDwbhaFuYq/2zKiSQCamrnRKQCB6qLGvtb0Dlwep5BR1FAfac8qTn+cYJzD4OckvgDP+I49PfzB0/Mpj17KaQ6XqECxH3HoADNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810129; c=relaxed/simple;
	bh=d9Z4OyaXyd2iW8oaUk5+7sCbXKIKvaOWOGF2FflvyiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=pte0WTTyh10Axm6D+WAxLOooOXQ6aktg5BetaE/WomzOu2QE9tLR8prewYrge+3+ryUfHussi7BiLX8P0VK+CwmJ1fk/wg4jZacfEU//Zcval+MfGnCX8LbVS4rLZijyMfRepufgTkHCRa1V3NBCQPNzOKPJW2WA5bYupHQZwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cIt2ce4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YerQi89G; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cIt2ce4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YerQi89G"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AD6DEC0495;
	Tue,  2 Sep 2025 06:48:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 06:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810125;
	 x=1756896525; bh=t8Sup5nBnFIoCf8umDGRPtUmd7W/qtb+f8OggNAOkkw=; b=
	cIt2ce4kCEPYFVa7XjJf69vE+yOgebv/BlOU6Hlw7cOhUcnu43CGW6j6PZ6iAevX
	DwrvT1+Lf9vVWQ6z4MFiEw19gXOl5tsYVjAitQLI7v9HV9JZ/R2b3OAe9yptvJ+x
	VDOxmgP9ga/JonZXEUJiE1F4qU9vAoaL5AtlEoB+43vYei67HOvrcoXuq5wBxK3B
	ZA1UijCy0r5HSSrSQ81vq1I3CMnhInS21p/cUxF3JMzk7yJfIbnf5u9yvmz/HI/T
	0HVJFvzTIlgq54yiXeahr+f7OJGV469VOqEvOc24bRTV6jGRlJXUA8SzNVeuTF4+
	wzsPaTQyL4xV2xc625SKVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810125; x=
	1756896525; bh=t8Sup5nBnFIoCf8umDGRPtUmd7W/qtb+f8OggNAOkkw=; b=Y
	erQi89G0Ea1Xt/8/r9799L7A4scxjH0SBZGajkG3xlusK9vULQXTUvvqBdJ7/H4z
	Ji170aNjMdgbu2MPLUqbNbY1vQdP2xvj8jJpzZphvRxtGA070s8gTFZTXI4qwr2Y
	Q3kWtuTgpZx27ifCLfmR+pIPUjw2HEOl5LCL/z/I8BRVcEsMAKhrgKyKWK4UR0UC
	fP89wdKZoiEWLyROX6pEQ2llDMhdZ81y50SvKu1ynqzBRsmwc6Cp6wQ+xRvNPFDL
	fPjw3LnkRSArOolfi2na7FLKBWf6nKCJHp8T30ia+31mncoc6qs3WA4MseuNCP/H
	nA5iBbBloe0JCgWi7lfCA==
X-ME-Sender: <xms:jcu2aEHzmQ5A42TLTsOxalt6hlMPrKSBxuvxl3CsuMyhMKQ4O1nE8A>
    <xme:jcu2aI2LF8nB0cGSyB9Iy6NySOvn8WRrRCjfEuHneE3JMU0jWh9JLMq3sTcqTnpap
    il6S3dpBLTlIiS1gg>
X-ME-Received: <xmr:jcu2aElDBDidck5BT-gmZus7lyC3wWFer3dy7ZvQXsPJUJQHJ_OkJoSrQCaHnOIbkZoRa6u77g_8zsE_szjRrfBTkWO4zPsbU8xlYgXImg-tiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepte
    euueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:jcu2aA_5pTgVh0kx2f0w4w2PHQXMJ1cw3C3ZnCjh_izcS7dEbl0iMA>
    <xmx:jcu2aBrfPtyeJuXEyBPcEIiwVVovKVHHiZoLqp6vZyWMSPHSwytcGA>
    <xmx:jcu2aBmiZ9FQst4RYG1CglxRCGzTcSALu_n2mEXK6McQrA0glFpQyA>
    <xmx:jcu2aAi8P1l4Mv10iqgToiC7WVhvJuDDiAT72Pc6Hza01Lb25JJm8A>
    <xmx:jcu2aEIJJVBLpo3911zvCab7yehCh01I8phfNohrnHJgL9Z4cbVh7A7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:48:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acd56c3d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:48:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/15] packfile: carve out a new packfile store
Date: Tue, 02 Sep 2025 12:48:25 +0200
Message-Id: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnLtmgC/3XNTQ6CMBAF4KuYrh3TTn8CrryHcVFhkAkKpDWNh
 nB3CzHGDcs3ee+bSUQKTFEcd5MIlDjy0Oeg9ztRtb6/EXCds0CJVhbSwdXA2EUYfdU1fKcI8Tk
 EAm+Md7KovC6dyOMxUMOvFT5fcm556b3XP0kt1y+pyi0yKZCgXFYNkkLrT7l14IdYvIR/BqpNA
 7NRK+lQa2upbH7GPM8f6e1dyf0AAAA=
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
      packfile: remove `get_packed_git()`
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
 odb.c                       |  40 ++++--
 odb.h                       |  34 ++----
 pack-bitmap.c               |   4 +-
 pack-objects.c              |   3 +-
 packfile.c                  | 287 ++++++++++++++++++++++++--------------------
 packfile.h                  | 119 +++++++++++++++---
 server-info.c               |   3 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   2 +-
 transport-helper.c          |   2 +-
 31 files changed, 391 insertions(+), 270 deletions(-)

Range-diff versus v2:

 1:  9f205abd1e =  1:  efa41d9634 packfile: introduce a new `struct packfile_store`
 2:  a48391a618 !  2:  c4a45fdaf1 odb: move list of packfiles into `struct packfile_store`
    @@ odb.c: void odb_clear(struct object_database *o)
     -	}
     -	o->packed_git = NULL;
     +	packfile_store_free(o->packfiles);
    ++	o->packfiles = NULL;
      
      	hashmap_clear(&o->pack_map);
      	string_list_clear(&o->submodule_source_paths, 0);
    @@ packfile.c: void reprepare_packed_git(struct repository *r)
      
      struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
     @@ packfile.c: struct packed_git *get_all_packs(struct repository *r)
    - 			prepare_midx_pack(r, m, i);
    + 			prepare_midx_pack(m, i);
      	}
      
     -	return r->objects->packed_git;
    @@ packfile.c: const struct packed_git *has_packed_and_bad(struct repository *r,
      			return p;
      	return NULL;
     @@ packfile.c: int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
    - 		if (source->midx && fill_midx_entry(r, oid, e, source->midx))
    + 		if (source->midx && fill_midx_entry(source->midx, oid, e))
      			return 1;
      
     -	if (!r->objects->packed_git)
    @@ packfile.c: struct packfile_store *packfile_store_new(struct object_database *od
     +
     +void packfile_store_close(struct packfile_store *store)
     +{
    -+	struct packed_git *p;
    -+
    -+	for (p = store->packs; p; p = p->next)
    ++	for (struct packed_git *p = store->packs; p; p = p->next) {
     +		if (p->do_not_close)
     +			BUG("want to close pack marked 'do-not-close'");
     +		else
     +			close_pack(p);
    ++	}
     +}
     
      ## packfile.h ##
 3:  4a8cdfd936 =  3:  22125b27eb odb: move initialization bit into `struct packfile_store`
 4:  ba32eb35c4 !  4:  b927b57c6d odb: move packfile map into `struct packfile_store`
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## midx.c ##
    -@@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
    +@@ midx.c: int prepare_midx_pack(struct multi_pack_index *m,
      	strbuf_addbuf(&key, &pack_name);
      	strbuf_strip_suffix(&key, ".idx");
      	strbuf_addstr(&key, ".pack");
    @@ odb.c: struct object_database *odb_new(struct repository *repo)
      	string_list_init_dup(&o->submodule_source_paths);
      	return o;
     @@ odb.c: void odb_clear(struct object_database *o)
    - 	close_object_store(o);
      	packfile_store_free(o->packfiles);
    + 	o->packfiles = NULL;
      
     -	hashmap_clear(&o->pack_map);
      	string_list_clear(&o->submodule_source_paths, 0);
 5:  a87f102193 !  5:  030e34967d odb: move MRU list of packfiles into `struct packfile_store`
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## midx.c ##
    -@@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
    - 		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
    +@@ midx.c: int prepare_midx_pack(struct multi_pack_index *m,
    + 				   m->source->local);
      		if (p) {
      			install_packed_git(r, p);
     -			list_add_tail(&p->mru, &r->objects->packed_git_mru);
    @@ odb.c: void odb_clear(struct object_database *o)
     -	INIT_LIST_HEAD(&o->packed_git_mru);
      	close_object_store(o);
      	packfile_store_free(o->packfiles);
    - 
    + 	o->packfiles = NULL;
     
      ## odb.h ##
     @@
 6:  7b43149530 !  6:  bda7ae0259 odb: move kept cache into `struct packfile_store`
    @@ packfile.h: struct packfile_store {
      	 */
      	struct packed_git *packs;
      
    ++	/*
    ++	 * Cache of packfiles which are marked as "kept", either because there
    ++	 * is an on-disk ".keep" file or because they are marked as "kept" in
    ++	 * memory.
    ++	 *
    ++	 * Should not be accessed directly, but via `kept_pack_cache()`. The
    ++	 * list of packs gets invalidated when the stored flags and the flags
    ++	 * passed to `kept_pack_cache()` mismatch.
    ++	 */
     +	struct {
     +		struct packed_git **packs;
     +		unsigned flags;
 7:  23d8d87330 !  7:  0ed3c2f690 packfile: reorder functions to avoid function declaration
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## packfile.c ##
    -@@ packfile.c: static void prepare_packed_git_one(struct odb_source *source, int local)
    +@@ packfile.c: static void prepare_packed_git_one(struct odb_source *source)
      	string_list_clear(data.garbage, 0);
      }
      
 8:  1623a5682e !  8:  c39180e7d2 packfile: refactor `prepare_packed_git()` to work on packfile store
    @@ packfile.c: static int sort_pack(const struct packed_git *a, const struct packed
      
     -	odb_prepare_alternates(r->objects);
     -	for (source = r->objects->sources; source; source = source->next) {
    --		int local = (source == r->objects->sources);
     +	odb_prepare_alternates(store->odb);
     +	for (source = store->odb->sources; source; source = source->next) {
    -+		int local = (source == store->odb->sources);
    - 		prepare_multi_pack_index_one(source, local);
    - 		prepare_packed_git_one(source, local);
    + 		prepare_multi_pack_index_one(source);
    + 		prepare_packed_git_one(source);
      	}
     -	rearrange_packed_git(r);
     +	sort_packs(&store->packs, sort_pack);
    @@ packfile.c: int find_pack_entry(struct repository *r, const struct object_id *oi
     +	packfile_store_prepare(r->objects->packfiles);
      
      	for (struct odb_source *source = r->objects->sources; source; source = source->next)
    - 		if (source->midx && fill_midx_entry(r, oid, e, source->midx))
    + 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 9:  1ef4f6b1da !  9:  c39986a035 packfile: split up responsibilities of `reprepare_packed_git()`
    @@ odb.c: void odb_clear(struct object_database *o)
     +{
     +	struct odb_source *source;
     +
    ++	obj_read_lock();
    ++
     +	/*
     +	 * Reprepare alt odbs, in case the alternates file was modified
     +	 * during the course of this process. This only _adds_ odbs to
    @@ odb.h: struct object_database {
     +void odb_reprepare(struct object_database *o);
     +
      /*
    -  * Find source by its object directory path. Dies in case the source couldn't
    -  * be found.
    +  * Find source by its object directory path. Returns a `NULL` pointer in case
    +  * the source could not be found.
     
      ## packfile.c ##
     @@ packfile.c: static void packfile_store_prepare(struct packfile_store *store)
10:  3da8d69d11 ! 10:  8bc0e68c2f packfile: refactor `install_packed_git()` to work on packfile store
    @@ http.h: int finish_http_pack_request(struct http_pack_request *preq);
       * from http_get_info_packs() and have chosen a specific pack to fetch.
     
      ## midx.c ##
    -@@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
    - 	if (!p) {
    - 		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
    +@@ midx.c: int prepare_midx_pack(struct multi_pack_index *m,
    + 		p = add_packed_git(r, pack_name.buf, pack_name.len,
    + 				   m->source->local);
      		if (p) {
     -			install_packed_git(r, p);
     +			packfile_store_add_pack(r->objects->packfiles, p);
11:  5c98d84581 <  -:  ---------- packfile: always add packfiles to MRU when adding a pack
12:  d9bca4e7cf ! 11:  0ea8488379 packfile: introduce function to load and add packfiles
    @@ builtin/index-pack.c: static void final(const char *final_pack_name, const char
      		printf("%s\n", hash_to_hex(hash));
     
      ## midx.c ##
    -@@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
    - 		      uint32_t pack_int_id)
    +@@ midx.c: int prepare_midx_pack(struct multi_pack_index *m,
      {
    + 	struct repository *r = m->source->odb->repo;
      	struct strbuf pack_name = STRBUF_INIT;
     -	struct strbuf key = STRBUF_INIT;
      	struct packed_git *p;
      
      	pack_int_id = midx_for_pack(&m, pack_int_id);
    -@@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
    +@@ midx.c: int prepare_midx_pack(struct multi_pack_index *m,
      
    - 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
    + 	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
      		    m->pack_names[pack_int_id]);
     -
     -	/* pack_map holds the ".pack" name, but we have the .idx */
    @@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
     -					strhash(key.buf), key.buf,
     -					struct packed_git, packmap_ent);
     -	if (!p) {
    --		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
    --		if (p)
    +-		p = add_packed_git(r, pack_name.buf, pack_name.len,
    +-				   m->source->local);
    +-		if (p) {
     -			packfile_store_add_pack(r->objects->packfiles, p);
    +-			list_add_tail(&p->mru, &r->objects->packfiles->mru);
    +-		}
     -	}
     -
     +	p = packfile_store_load_pack(r->objects->packfiles,
    -+				     pack_name.buf, m->local);
    ++				     pack_name.buf, m->source->local);
    ++	if (p)
    ++		list_add_tail(&p->mru, &r->objects->packfiles->mru);
      	strbuf_release(&pack_name);
     -	strbuf_release(&key);
      
    @@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
     
      ## packfile.c ##
     @@ packfile.c: void packfile_store_add_pack(struct packfile_store *store,
    - 	list_add_tail(&pack->mru, &store->mru);
    + 	hashmap_add(&store->map, &pack->packmap_ent);
      }
      
     +struct packed_git *packfile_store_load_pack(struct packfile_store *store,
13:  bfda0a35f8 ! 12:  34a1b17424 packfile: move `get_multi_pack_index()` into "midx.c"
    @@ midx.c: static int midx_read_object_offsets(const unsigned char *chunk_start,
     +	return source->midx;
     +}
     +
    - static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
    - 							  const char *object_dir,
    - 							  const char *midx_name,
    + static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
    + 							  const char *midx_name)
    + {
     
      ## midx.h ##
    -@@ midx.h: void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
    - 				 struct strbuf *buf, const char *object_dir,
    +@@ midx.h: void get_midx_chain_filename(struct odb_source *source, struct strbuf *out);
    + void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
      				 const unsigned char *hash, const char *ext);
      
     +struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
    -+
    - struct multi_pack_index *load_multi_pack_index(struct repository *r,
    - 					       const char *object_dir,
    - 					       int local);
    + struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
    + int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
    + struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
     
      ## packfile.c ##
     @@ packfile.c: static void packfile_store_prepare_mru(struct packfile_store *store)
14:  8d54b4034b ! 13:  e039ab7770 packfile: remove `get_packed_git()`
    @@ Commit message
           - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
             calls `prepare_midx_pack()` for each pack.
     
    -    This means that the latter function also properly loads the info of
    -    whether or not a packfile is part of a multi-pack index. Preparing this
    -    extra information also shouldn't be significantly more expensive:
    +    Based on the naming alone one might think that `get_all_packs()` would
    +    return more packs than `get_packed_git()`. But that's not the case: both
    +    functions end up returning the exact same list of packfiles. The real
    +    difference between those functions is that `get_all_packs()` also loads
    +    the info of whether or not a packfile is part of a multi-pack index.
    +
    +    Preparing this extra information also shouldn't be significantly more
    +    expensive:
     
           - We have already loaded all packfiles via `prepare_packed_git_one()`.
             So given that multi-pack indices may only refer to packfiles in the
15:  b04c2e4f7d ! 14:  65690526c2 packfile: refactor `get_all_packs()` to work on packfile store
    @@ Commit message
     
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static void batch_each_object(struct batch_options *opt,
    + 
    + 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
      						 batch_one_object_bitmapped, &payload)) {
    ++		struct packfile_store *packs = the_repository->objects->packfiles;
      		struct packed_git *pack;
      
     -		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
    -+		for (pack = packfile_store_get_packs(the_repository->objects->packfiles); pack; pack = pack->next) {
    ++		for (pack = packfile_store_get_packs(packs); pack; pack = pack->next) {
      			if (bitmap_index_contains_pack(bitmap, pack) ||
      			    open_pack_index(pack))
      				continue;
     
      ## builtin/count-objects.c ##
    +@@ builtin/count-objects.c: int cmd_count_objects(int argc,
    + 				      count_loose, count_cruft, NULL, NULL);
    + 
    + 	if (verbose) {
    ++		struct packfile_store *packs = the_repository->objects->packfiles;
    + 		struct packed_git *p;
    + 		unsigned long num_pack = 0;
    + 		off_t size_pack = 0;
     @@ builtin/count-objects.c: int cmd_count_objects(int argc,
      		struct strbuf pack_buf = STRBUF_INIT;
      		struct strbuf garbage_buf = STRBUF_INIT;
      
     -		for (p = get_all_packs(the_repository); p; p = p->next) {
    -+		for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++		for (p = packfile_store_get_packs(packs); p; p = p->next) {
      			if (!p->pack_local)
      				continue;
      			if (open_pack_index(p))
     
      ## builtin/fast-import.c ##
    +@@ builtin/fast-import.c: static int store_object(
    + 	struct object_id *oidout,
    + 	uintmax_t mark)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	void *out, *delta;
    + 	struct object_entry *e;
    + 	unsigned char hdr[96];
     @@ builtin/fast-import.c: static int store_object(
      	if (e->idx.offset) {
      		duplicate_count_by_type[type]++;
      		return 1;
     -	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
    -+	} else if (find_oid_pack(&oid, packfile_store_get_packs(the_repository->objects->packfiles))) {
    ++	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
      		e->type = type;
      		e->pack_id = MAX_PACK_ID;
      		e->idx.offset = 1; /* just not zero! */
    +@@ builtin/fast-import.c: static void truncate_pack(struct hashfile_checkpoint *checkpoint)
    + 
    + static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
    + 	unsigned char *in_buf = xmalloc(in_sz);
    + 	unsigned char *out_buf = xmalloc(out_sz);
     @@ builtin/fast-import.c: static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
      		duplicate_count_by_type[OBJ_BLOB]++;
      		truncate_pack(&checkpoint);
      
     -	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
    -+	} else if (find_oid_pack(&oid, packfile_store_get_packs(the_repository->objects->packfiles))) {
    ++	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
      		e->type = OBJ_BLOB;
      		e->pack_id = MAX_PACK_ID;
      		e->idx.offset = 1; /* just not zero! */
     
      ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show_progress)
    +@@ builtin/fsck.c: static int mark_packed_for_connectivity(const struct object_id *oid,
    + 
    + static int check_pack_rev_indexes(struct repository *r, int show_progress)
    + {
    ++	struct packfile_store *packs = r->objects->packfiles;
    + 	struct progress *progress = NULL;
    + 	uint32_t pack_count = 0;
      	int res = 0;
      
      	if (show_progress) {
     -		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
    -+		for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next)
    ++		for (struct packed_git *p = packfile_store_get_packs(packs); p; p = p->next)
      			pack_count++;
      		progress = start_delayed_progress(the_repository,
      						  "Verifying reverse pack-indexes", pack_count);
    @@ builtin/fsck.c: static int check_pack_rev_indexes(struct repository *r, int show
      	}
      
     -	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
    -+	for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
    ++	for (struct packed_git *p = packfile_store_get_packs(packs); p; p = p->next) {
      		int load_error = load_pack_revindex_from_disk(p);
      
      		if (load_error < 0) {
    +@@ builtin/fsck.c: int cmd_fsck(int argc,
    + 		for_each_packed_object(the_repository,
    + 				       mark_packed_for_connectivity, NULL, 0);
    + 	} else {
    ++		struct packfile_store *packs = the_repository->objects->packfiles;
    ++
    + 		odb_prepare_alternates(the_repository->objects);
    + 		for (source = the_repository->objects->sources; source; source = source->next)
    + 			fsck_source(source);
     @@ builtin/fsck.c: int cmd_fsck(int argc,
      			struct progress *progress = NULL;
      
      			if (show_progress) {
     -				for (p = get_all_packs(the_repository); p;
    -+				for (p = packfile_store_get_packs(the_repository->objects->packfiles); p;
    ++				for (p = packfile_store_get_packs(packs); p;
      				     p = p->next) {
      					if (open_pack_index(p))
      						continue;
    @@ builtin/fsck.c: int cmd_fsck(int argc,
      							  _("Checking objects"), total);
      			}
     -			for (p = get_all_packs(the_repository); p;
    -+			for (p = packfile_store_get_packs(the_repository->objects->packfiles); p;
    ++			for (p = packfile_store_get_packs(packs); p;
      			     p = p->next) {
      				/* verify gives error messages itself */
      				if (verify_pack(the_repository,
     
      ## builtin/gc.c ##
    -@@ builtin/gc.c: static struct packed_git *find_base_packs(struct string_list *packs,
    +@@ builtin/gc.c: static int too_many_loose_objects(struct gc_config *cfg)
    + static struct packed_git *find_base_packs(struct string_list *packs,
    + 					  unsigned long limit)
      {
    ++	struct packfile_store *packfiles = the_repository->objects->packfiles;
      	struct packed_git *p, *base = NULL;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packfiles); p; p = p->next) {
      		if (!p->pack_local || p->is_cruft)
      			continue;
      		if (limit) {
    -@@ builtin/gc.c: static int too_many_packs(struct gc_config *cfg)
    +@@ builtin/gc.c: static struct packed_git *find_base_packs(struct string_list *packs,
    + 
    + static int too_many_packs(struct gc_config *cfg)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 	int cnt;
    + 
      	if (cfg->gc_auto_pack_limit <= 0)
      		return 0;
      
     -	for (cnt = 0, p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (cnt = 0, p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (cnt = 0, p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (!p->pack_local)
      			continue;
      		if (p->pack_keep)
    @@ builtin/gc.c: static off_t get_auto_pack_size(void)
      			max_size = p->pack_size;
     
      ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static int pack_mtime_cmp(const void *_a, const void *_b)
    + 
    + static void read_packs_list_from_stdin(struct rev_info *revs)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct string_list include_packs = STRING_LIST_INIT_DUP;
    + 	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
     @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(struct rev_info *revs)
      	string_list_sort(&exclude_packs);
      	string_list_remove_duplicates(&exclude_packs, 0);
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		const char *pack_name = pack_basename(p);
      
      		if ((item = string_list_lookup(&include_packs, pack_name)))
    +@@ builtin/pack-objects.c: static void enumerate_cruft_objects(void)
    + 
    + static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 	struct rev_info revs;
    + 	int ret;
     @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
      	 * Re-mark only the fresh packs as kept so that objects in
      	 * unknown packs do not halt the reachability traversal early.
      	 */
     -	for (p = get_all_packs(the_repository); p; p = p->next)
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next)
      		p->pack_keep_in_core = 0;
      	mark_pack_kept_in_core(fresh_packs, 1);
      
    +@@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
    + 
    + static void read_cruft_objects(void)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct string_list discard_packs = STRING_LIST_INIT_DUP;
    + 	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
     @@ builtin/pack-objects.c: static void read_cruft_objects(void)
      	string_list_sort(&discard_packs);
      	string_list_sort(&fresh_packs);
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		const char *pack_name = pack_basename(p);
      		struct string_list_item *item;
      
    -@@ builtin/pack-objects.c: static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
    +@@ builtin/pack-objects.c: static void add_unreachable_loose_objects(struct rev_info *revs)
    + 
    + static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	static struct packed_git *last_found = (void *)1;
      	struct packed_git *p;
      
      	p = (last_found != (void *)1) ? last_found :
     -					get_all_packs(the_repository);
    -+					packfile_store_get_packs(the_repository->objects->packfiles);
    ++					packfile_store_get_packs(packs);
      
      	while (p) {
      		if ((!p->pack_local || p->pack_keep ||
    @@ builtin/pack-objects.c: static int has_sha1_pack_kept_or_nonlocal(const struct o
      		}
      		if (p == last_found)
     -			p = get_all_packs(the_repository);
    -+			p = packfile_store_get_packs(the_repository->objects->packfiles);
    ++			p = packfile_store_get_packs(packs);
      		else
      			p = p->next;
      		if (p == last_found)
    -@@ builtin/pack-objects.c: static void loosen_unused_packed_objects(void)
    +@@ builtin/pack-objects.c: static int loosened_object_can_be_discarded(const struct object_id *oid,
    + 
    + static void loosen_unused_packed_objects(void)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 	uint32_t i;
      	uint32_t loosened_objects_nr = 0;
      	struct object_id oid;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
      			continue;
      
    -@@ builtin/pack-objects.c: static void add_extra_kept_packs(const struct string_list *names)
    +@@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, int ac, const char **av)
    + 
    + static void add_extra_kept_packs(const struct string_list *names)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
    + 
      	if (!names->nr)
      		return;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		const char *name = basename(p->pack_name);
      		int i;
      
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    + 
      	add_extra_kept_packs(&keep_pack_list);
      	if (ignore_packed_keep_on_disk) {
    ++		struct packfile_store *packs = the_repository->objects->packfiles;
      		struct packed_git *p;
     -		for (p = get_all_packs(the_repository); p; p = p->next)
    -+		for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
    ++
    ++		for (p = packfile_store_get_packs(packs); p; p = p->next)
      			if (p->pack_local && p->pack_keep)
      				break;
      		if (!p) /* no keep-able packs found */
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
    + 		 * want to unset "local" based on looking at packs, as
      		 * it also covers non-local objects
      		 */
    ++		struct packfile_store *packs = the_repository->objects->packfiles;
      		struct packed_git *p;
     -		for (p = get_all_packs(the_repository); p; p = p->next) {
    -+		for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++
    ++		for (p = packfile_store_get_packs(packs); p; p = p->next) {
      			if (!p->pack_local) {
      				have_non_local_packs = 1;
      				break;
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *
      static struct pack_list * add_pack_file(const char *filename)
      {
     -	struct packed_git *p = get_all_packs(the_repository);
    -+	struct packed_git *p = packfile_store_get_packs(the_repository->objects->packfiles);
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    ++	struct packed_git *p = packfile_store_get_packs(packs);
      
      	if (strlen(filename) < 40)
      		die("Bad pack filename: %s", filename);
    @@ builtin/pack-redundant.c: static struct pack_list * add_pack_file(const char *fi
      static void load_all(void)
      {
     -	struct packed_git *p = get_all_packs(the_repository);
    -+	struct packed_git *p = packfile_store_get_packs(the_repository->objects->packfiles);
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    ++	struct packed_git *p = packfile_store_get_packs(packs);
      
      	while (p) {
      		add_pack(p);
     
      ## builtin/repack.c ##
    -@@ builtin/repack.c: static void collect_pack_filenames(struct existing_packs *existing,
    +@@ builtin/repack.c: static void existing_packs_release(struct existing_packs *existing)
    + static void collect_pack_filenames(struct existing_packs *existing,
    + 				   const struct string_list *extra_keep)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
      	struct packed_git *p;
      	struct strbuf buf = STRBUF_INIT;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		int i;
      		const char *base;
      
     @@ builtin/repack.c: static void init_pack_geometry(struct pack_geometry *geometry,
    + 			       struct existing_packs *existing,
    + 			       const struct pack_objects_args *args)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
      	struct packed_git *p;
      	struct strbuf buf = STRBUF_INIT;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (args->local && !p->pack_local)
      			/*
      			 * When asked to only repack local packfiles we skip
    -@@ builtin/repack.c: static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct pack_objects_args *args,
    + static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
    + 				      struct existing_packs *existing)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *p;
      	struct strbuf buf = STRBUF_INIT;
      	size_t i;
      
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (!(p->is_cruft && p->pack_local))
      			continue;
      
     
      ## connected.c ##
     @@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
    + 		 */
    + 		odb_reprepare(the_repository->objects);
      		do {
    ++			struct packfile_store *packs = the_repository->objects->packfiles;
      			struct packed_git *p;
      
     -			for (p = get_all_packs(the_repository); p; p = p->next) {
    -+			for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++			for (p = packfile_store_get_packs(packs); p; p = p->next) {
      				if (!p->pack_promisor)
      					continue;
      				if (find_pack_entry_one(oid, p))
     
      ## http-backend.c ##
    -@@ http-backend.c: static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
    +@@ http-backend.c: static void get_head(struct strbuf *hdr, char *arg UNUSED)
    + static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
    + {
    + 	size_t objdirlen = strlen(repo_get_object_directory(the_repository));
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct packed_git *p;
      	size_t cnt = 0;
      
      	select_getanyfile(hdr);
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (p->pack_local)
      			cnt++;
      	}
      
      	strbuf_grow(&buf, cnt * 53 + 2);
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (p->pack_local)
      			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
      	}
     
      ## http.c ##
    +@@ http.c: static char *fetch_pack_index(unsigned char *hash, const char *base_url)
    + static int fetch_and_setup_pack_index(struct packed_git **packs_head,
    + 	unsigned char *sha1, const char *base_url)
    + {
    ++	struct packfile_store *packs = the_repository->objects->packfiles;
    + 	struct packed_git *new_pack, *p;
    + 	char *tmp_idx = NULL;
    + 	int ret;
     @@ http.c: static int fetch_and_setup_pack_index(struct packed_git **packs_head,
      	 * If we already have the pack locally, no need to fetch its index or
      	 * even add it to list; we already have all of its objects.
      	 */
     -	for (p = get_all_packs(the_repository); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		if (hasheq(p->hash, sha1, the_repository->hash_algo))
      			return 0;
      	}
    @@ pack-bitmap.c: int verify_bitmap_files(struct repository *r)
      		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
     
      ## pack-objects.c ##
    +@@ pack-objects.c: struct object_entry *packlist_find(struct packing_data *pdata,
    + 
    + static void prepare_in_pack_by_idx(struct packing_data *pdata)
    + {
    ++	struct packfile_store *packs = pdata->repo->objects->packfiles;
    + 	struct packed_git **mapping, *p;
    + 	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
    + 
     @@ pack-objects.c: static void prepare_in_pack_by_idx(struct packing_data *pdata)
      	 * (i.e. in_pack_idx also zero) should return NULL.
      	 */
      	mapping[cnt++] = NULL;
     -	for (p = get_all_packs(pdata->repo); p; p = p->next, cnt++) {
    -+	for (p = packfile_store_get_packs(pdata->repo->objects->packfiles); p; p = p->next, cnt++) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next, cnt++) {
      		if (cnt == nr) {
      			free(mapping);
      			return;
    @@ packfile.c: void packfile_store_reprepare(struct packfile_store *store)
      		struct multi_pack_index *m = source->midx;
      		if (!m)
      			continue;
    - 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
    --			prepare_midx_pack(r, m, i);
    -+			prepare_midx_pack(store->odb->repo, m, i);
    +@@ packfile.c: struct packed_git *get_all_packs(struct repository *r)
    + 			prepare_midx_pack(m, i);
      	}
      
     -	return r->objects->packfiles->packs;
    @@ packfile.h: int for_each_packed_object(struct repository *repo, each_packed_obje
       * Give a rough count of objects in the repository. This sacrifices accuracy
     
      ## server-info.c ##
    -@@ server-info.c: static void init_pack_info(struct repository *r, const char *infofile, int force
    +@@ server-info.c: static int compare_info(const void *a_, const void *b_)
    + 
    + static void init_pack_info(struct repository *r, const char *infofile, int force)
    + {
    ++	struct packfile_store *packs = r->objects->packfiles;
    + 	struct packed_git *p;
    + 	int stale;
      	int i;
      	size_t alloc = 0;
      
     -	for (p = get_all_packs(r); p; p = p->next) {
    -+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
    ++	for (p = packfile_store_get_packs(packs); p; p = p->next) {
      		/* we ignore things on alternate path since they are
      		 * not available to the pullers in general.
      		 */
16:  594d14487e = 15:  1315247fd2 packfile: refactor `get_packed_git_mru()` to work on packfile store

---
base-commit: 337c7a0bbcf228ce11c87d066ecee352b3e52467
change-id: 20250806-b4-pks-packfiles-store-a44a608ca396

