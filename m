Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721C26AA94
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578970; cv=none; b=GwElb3RBxY+Yy737oSrjwBQWINUI+ZWeV8jUhqV7xuIPQYMyxb71SRYSPiL+sieBmXkulNuIctd3FiYdDfR0wHzh4dfetKbQStNqs5SGZUeNSR70lZILnWaWm3nf9TrtwauhsynQ3fpsWdnorBbJksWi5Xk73HSOMgJz7tKhDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578970; c=relaxed/simple;
	bh=ER/XkrPyaZC5D5RCI2M43fPgbc0oizf7CIuEslKkAJE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=epU/eAW01NLgWDElh1AQ2e+/0KDhGCfXlZ0YIU2XdbuOxvOJlu2QpX+4CVpr1OnAra9YvBLVh8Q90uXRIPAjs/mwWcaMsyWmEA/ume9SLpOO2AaiUkSH5uOa2NmRDIrAlKrjFGoEkCoZvqKO/ILsHqHbSDZkKe3yXt1FxuWC/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CJxA0dK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SviYKuJd; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CJxA0dK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SviYKuJd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D101FEC0A47;
	Tue, 15 Jul 2025 07:29:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Jul 2025 07:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752578966;
	 x=1752665366; bh=FoSQ/o2kBn1MhC6S++PkA6F8FN0V5Jg4VYM0V6un+OQ=; b=
	CJxA0dK1+CK8dO0AzY9Wv16X0E15+LW8TSUWQT32AhkJKv4Zcr9kVUWOzeDKsZyD
	gqrRQM3nX75+vY8uHyhUcZ5uDP7cne3S8/HEDZYY5l+QEtw6H0KmOrZX/0ftH1lF
	naW3ITBenTnsMBbuwvCxD/evDopgKRpdh9mUEhT3iesdr5FCeJ+RJgMk3e6ldxGq
	uWGsZTYtRvYGZA5DaI+m+/QTBWgvunK0mzxJ0W6IHsuxuOfuUPm6i/w7speMHP7v
	pOUqCrwXIdIJ8Ilnndo16Ptlmd3vZzXkk17otBDO2Q6ymHyG6Z1DRq5WpirziePg
	hFjCoPxC69Y7ZKNW1MF8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752578966; x=
	1752665366; bh=FoSQ/o2kBn1MhC6S++PkA6F8FN0V5Jg4VYM0V6un+OQ=; b=S
	viYKuJdNbfrCDRPQGDVd/RxxrdC6qW/DzZBTQiACddKaN84aXAHfhHGUKPxLKldY
	Q2n/lDit+SGOxn0RYHrhwCLNUW0OXKWcLUzLKEBEgd4jiIFWTsN9rulABb9iYbZj
	hVMF7PL1TTgkE4oWZ9IEybU//w/n5wodhp3onhY7OdZNnX7E5ka0rRjm5s7A4IW4
	ogpqDUl0BqmSnWTGBeYD0eXSEE+uLVbRI6plKb1sLz4xL/37gBJhpsFcUZyrl5VS
	f25t6ugL7xbQDDm4AeMSvzDIQii5CBX9SwUxmEhRBTfeIr14khkCZL/EgAb9G1yt
	uKuCXImsU01lqpS7sBI2Q==
X-ME-Sender: <xms:ljt2aE0ZiDc77GJQ35cn0RBL4jL3xQaIs0xPN2FaNfsj0PNysUGwew>
    <xme:ljt2aJoBlHJMqzFuSmMEPvOPWQ3cQO8kD1tMRDeMd_aKoY8uTXgOQuIUw7uOkEIUi
    zjDeNp-qAqtINwlDQ>
X-ME-Received: <xmr:ljt2aJcYjaEyEqqTQrNqQ1Dhsny1FLWFnEJvnUH9eoKiob_fZUvZGCmP00zHxmv7cD7k6iEzsLw7Syi8GTR9ZLSYZiGwi473fPB7PaNLinkFeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ljt2aApYoNc-I7KkyxlzFA25ozVfpKn1LW_oiTxHUooAqgdRxUkjyw>
    <xmx:ljt2aCHGLAIcMqqD6gLcRKQFU0D2DT0BQIl8jYtgBBDgtUiRZfzD2Q>
    <xmx:ljt2aIsVafNYC_kJwi-usbw10ysaazlCBXycWx39E8jfBokdE9V2GQ>
    <xmx:ljt2aMX0aY5Hp-8P47CZkQ2VywPTXcoDRcf0JJiEKo5CIqYJ6kvh2w>
    <xmx:ljt2aAZfOLvLnJW3V1i7IRds3PufgaCXKhl-qHoGU1ixXg3l_OiUYQE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 07:29:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9001f421 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 11:29:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] odb: track multi-pack-indices via their object
 sources
Date: Tue, 15 Jul 2025 13:29:17 +0200
Message-Id: <20250715-b4-pks-midx-via-odb-alternate-v2-0-b0ca0b4b516e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI07dmgC/4XNQQ6CMBCF4auQWTum09IorryHYVHoIBMVSEsaD
 OHuVjyAy/9l8s0KkYNwhEuxQuAkUcYhhz4U0PZuuDOKzw1aaassGWxKnB4RX+IXTOJw9A2658x
 hcDOjLxtblcrpc+shG1PgTpbdv9W5e4nzGN77u0Tf9SefVPVHToQKO0NklddkDF3z8VFeUG/b9
 gEQBOq/xwAAAA==
X-Change-ID: 20250513-b4-pks-midx-via-odb-alternate-d4b5940a28cd
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

multi-pack-indices are tracked via `struct multi_pack_index`. This data
structure is stored inside `struct object_database`, which is the global
database that spans across all of the object sources

This layout causes two problems:

  - Multi-pack indices aren't global to an object database, but instead
    there can be one multi-pack index per object source. This creates a
    mismatch between the on-disk layout and how things are organized in
    the object database subsystems and makes some parts, like figuring
    out whether an object source has an MIDX, quite awkward.

  - Multi-pack indices are an implementation detail of how efficient
    access for packfiles work. As such, they are neither relevant in the
    context of loose objects, nor in a potential future where we have
    pluggable backends.

This patch series thus refactors the codebase to stop tracking MIDX's
globally. Instead, they are being pushed down one level so that every
`struct odb_source` has an optional MIDX itself. This simplifies some of
our code and will make it easier in a future iteration to move the data
into a packfile-specific object source backend.

Changes in v2:
  - Changed the base of this series. It is now built on top of
    a30f80fde92 (The eighth batch, 2025-07-08) with "ps/object-store" at
    841a03b4046 (odb: rename `read_object_with_reference()`, 2025-07-01)
    and "tb/midx-avoid-cruft-packs" at 5ee86c273bf (repack: exclude
    cruft pack(s) from the MIDX where possible, 2025-06-23) merged into
    it.
  - Re-explain the split between object databases and object sources
    to help readers out a bit, given that this is a rather recent
    change.
  - Rename `struct odb_source::multi_pack_index` to `struct
    odb_source::midx`.
  - Fix some overly long lines when looping through the individual
    sources.
  - Drop the patch that guards re-loading MIDXs, as we already have the
    guard via `packed_git_initialized`.
  - Remove some while-at-it changes to make the diffs easier to read.
  - Link to v1: https://lore.kernel.org/r/20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      midx: start tracking per object database source
      packfile: refactor `prepare_packed_git_one()` to work on sources
      midx: stop using linked list when closing MIDX
      packfile: refactor `get_multi_pack_index()` to work on sources
      packfile: stop using linked MIDX list in `find_pack_entry()`
      packfile: stop using linked MIDX list in `get_all_packs()`
      midx: remove now-unused linked list of multi-pack indices

 builtin/pack-objects.c | 10 ++++--
 builtin/repack.c       | 10 +++---
 midx-write.c           | 22 ++-----------
 midx.c                 | 36 ++++++++-------------
 midx.h                 |  5 ++-
 object-name.c          | 22 +++++++++----
 odb.h                  | 16 +++++-----
 pack-bitmap.c          | 21 ++++++++----
 packfile.c             | 86 ++++++++++++++++++++++----------------------------
 packfile.h             |  3 +-
 10 files changed, 107 insertions(+), 124 deletions(-)

Range-diff versus v1:

1:  d5a98780836 ! 1:  0617b4bfaf7 midx: start tracking per object database source
    @@ Commit message
     
         This layout causes two problems:
     
    -      - Multi-pack indices aren't global to an object database, but instead
    -        there can be one multi-pack index per source. This creates a
    -        mismatch between the on-disk layout and how things are organized in
    -        the object database subsystems and makes some parts, like figuring
    -        out whether a source has an MIDX, quite awkward.
    +      - Object databases consist of multiple object sources (e.g. one source
    +        per alternate object directory), where each multi-pack index is
    +        specific to one of those sources. Regardless of that though, the
    +        MIDX is not tracked per source, but tracked globally for the whole
    +        object database. This creates a mismatch between the on-disk layout
    +        and how things are organized in the object database subsystems and
    +        makes some parts, like figuring out whether a source has an MIDX,
    +        quite awkward.
     
           - Multi-pack indices are an implementation detail of how efficient
             access for packfiles work. As such, they are neither relevant in the
    @@ midx.c: int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_i
     -			return 1;
     -
     -	m = load_multi_pack_index(r, object_dir, local);
    -+	if (source->multi_pack_index)
    ++	if (source->midx)
     +		return 1;
      
     +	m = load_multi_pack_index(r, source->path, local);
    @@ midx.c: int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_i
     +		} else {
      			r->objects->multi_pack_index = m;
     +		}
    -+		source->multi_pack_index = m;
    ++		source->midx = m;
     +
      		return 1;
      	}
    @@ midx.c: void clear_midx_file(struct repository *r)
      		close_midx(r->objects->multi_pack_index);
      		r->objects->multi_pack_index = NULL;
     +		for (struct odb_source *source = r->objects->sources; source; source = source->next)
    -+			source->multi_pack_index = NULL;
    ++			source->midx = NULL;
      	}
      
      	if (remove_path(midx.buf))
     
      ## midx.h ##
    -@@
    - 
    - #include "string-list.h"
    - 
    -+struct bitmapped_pack;
    -+struct git_hash_algo;
    - struct object_id;
    -+struct odb_source;
    - struct pack_entry;
    +@@ midx.h: struct pack_entry;
      struct repository;
    --struct bitmapped_pack;
    --struct git_hash_algo;
    + struct bitmapped_pack;
    + struct git_hash_algo;
    ++struct odb_source;
      
      #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
      #define MIDX_VERSION 1
    @@ midx.h: int fill_midx_entry(struct repository *r, const struct object_id *oid, s
       * Variant of write_midx_file which writes a MIDX containing only the packs
     
      ## odb.h ##
    -@@
    - #include "string-list.h"
    - #include "thread-utils.h"
    - 
    -+struct multi_pack_index;
    - struct oidmap;
    +@@ odb.h: struct oidmap;
      struct oidtree;
    --struct strbuf;
    + struct strbuf;
      struct repository;
    -+struct strbuf;
    ++struct multi_pack_index;
      
      /*
       * Compute the exact path an alternate is at and returns it. In case of
    @@ odb.h: struct odb_source {
     +	 *
     +	 * should only be accessed directly by packfile.c and midx.c
     +	 */
    -+	struct multi_pack_index *multi_pack_index;
    ++	struct multi_pack_index *midx;
     +
      	/*
      	 * This is a temporary object store created by the tmp_objdir
    @@ packfile.c: void close_object_store(struct object_database *o)
      		close_midx(o->multi_pack_index);
      		o->multi_pack_index = NULL;
     +		for (struct odb_source *source = o->sources; source; source = source->next)
    -+			source->multi_pack_index = NULL;
    ++			source->midx = NULL;
      	}
      
      	close_commit_graph(o);
2:  8315835a35a ! 2:  f81ea4ea950 packfile: refactor `prepare_packed_git_one()` to work on sources
    @@ Metadata
      ## Commit message ##
         packfile: refactor `prepare_packed_git_one()` to work on sources
     
    -    In the preceding commit we have refactored how we load multi-pack
    -    indices so that we take take the source as input for which we want to
    -    load the MIDX. As part of this refactoring we started to store a pointer
    -    to the MIDX in `struct odb_source` itself.
    +    In the preceding commit we refactored how we load multi-pack indices to
    +    take a corresponding "source" as input. As part of this refactoring we
    +    started to store a pointer to the MIDX in `struct odb_source` itself.
     
         Refactor loading of packfiles in the same way: instead of passing in the
    -    object directory, we now pass in the source for which we want to load
    +    object directory, we now pass in the source from which we want to load
         packfiles. This allows us to simplify the code because we don't have to
         search for a corresponding MIDX anymore, but we can instead directly use
         the MIDX that we have already prepared beforehand.
    @@ packfile.c: static void prepare_pack(const char *full_name, size_t full_name_len
     -	struct prepare_pack_data data;
      	struct string_list garbage = STRING_LIST_INIT_DUP;
     +	struct prepare_pack_data data = {
    -+		.m = source->multi_pack_index,
    ++		.m = source->midx,
     +		.r = source->odb->repo,
     +		.garbage = &garbage,
     +		.local = local,
3:  d4e426c028a ! 3:  7bf5ce4f766 midx: stop using linked list when closing MIDX
    @@ Commit message
     
         Refactor the function to iterate through sources instead.
     
    +    Note that after this patch, there's a couple of callsites left that
    +    continue to use `close_midx()` without iterating through all sources.
    +    These are all cases where we don't care about the MIDX from other
    +    sources though, so it's fine to keep them as-is.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## midx.c ##
    @@ midx.c: void clear_midx_file(struct repository *r)
     -		r->objects->multi_pack_index = NULL;
     -		for (struct odb_source *source = r->objects->sources; source; source = source->next)
     +	if (r->objects) {
    -+		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
    -+			if (source->multi_pack_index)
    -+				close_midx(source->multi_pack_index);
    - 			source->multi_pack_index = NULL;
    ++		struct odb_source *source;
    ++
    ++		for (source = r->objects->sources; source; source = source->next) {
    ++			if (source->midx)
    ++				close_midx(source->midx);
    + 			source->midx = NULL;
     +		}
     +		r->objects->multi_pack_index = NULL;
      	}
    @@ midx.c: void clear_midx_file(struct repository *r)
      	if (remove_path(midx.buf))
     
      ## packfile.c ##
    +@@ packfile.c: void close_pack(struct packed_git *p)
    + 
    + void close_object_store(struct object_database *o)
    + {
    ++	struct odb_source *source;
    + 	struct packed_git *p;
    + 
    + 	for (p = o->packed_git; p; p = p->next)
     @@ packfile.c: void close_object_store(struct object_database *o)
      		else
      			close_pack(p);
    @@ packfile.c: void close_object_store(struct object_database *o)
     -		close_midx(o->multi_pack_index);
     -		o->multi_pack_index = NULL;
     -		for (struct odb_source *source = o->sources; source; source = source->next)
    --			source->multi_pack_index = NULL;
    -+	for (struct odb_source *source = o->sources; source; source = source->next) {
    -+		if (source->multi_pack_index)
    -+			close_midx(source->multi_pack_index);
    -+		source->multi_pack_index = NULL;
    +-			source->midx = NULL;
    ++	for (source = o->sources; source; source = source->next) {
    ++		if (source->midx)
    ++			close_midx(source->midx);
    ++		source->midx = NULL;
      	}
     +	o->multi_pack_index = NULL;
      
4:  06661849d72 < -:  ----------- midx: track whether we have loaded the MIDX
5:  2b7ae703f48 ! 4:  abf26698a61 packfile: refactor `get_multi_pack_index()` to work on sources
    @@ Commit message
     
      ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static int want_object_in_pack_mtime(const struct object_id *oid,
    + 				     uint32_t found_mtime)
      {
      	int want;
    ++	struct odb_source *source;
      	struct list_head *pos;
     -	struct multi_pack_index *m;
      
    @@ builtin/pack-objects.c: static int want_object_in_pack_mtime(const struct object
     -	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
     +	odb_prepare_alternates(the_repository->objects);
     +
    -+	for (struct odb_source *source = the_repository->objects->sources; source; source = source->next) {
    ++	for (source = the_repository->objects->sources; source; source = source->next) {
     +		struct multi_pack_index *m = get_multi_pack_index(source);
      		struct pack_entry e;
     -		if (fill_midx_entry(the_repository, oid, &e, m)) {
    @@ builtin/repack.c: static void mark_packs_for_deletion(struct existing_packs *exi
      		clear_midx_file(the_repository);
      	strbuf_insertf(&buf, 0, "%s/", dir_name);
      	unlink_pack_path(buf.buf, 1);
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 		 * midx_has_unknown_packs() will make the decision for
    + 		 * us.
    + 		 */
    +-		if (!get_local_multi_pack_index(the_repository))
    ++		if (!get_multi_pack_index(the_repository->objects->sources))
    + 			midx_must_contain_cruft = 1;
    + 	}
    + 
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 
    + 	string_list_sort(&names);
    + 
    +-	if (get_local_multi_pack_index(the_repository)) {
    ++	if (get_multi_pack_index(the_repository->objects->sources)) {
    + 		struct multi_pack_index *m =
    +-			get_local_multi_pack_index(the_repository);
    ++			get_multi_pack_index(the_repository->objects->sources);
    + 
    + 		ALLOC_ARRAY(midx_pack_names,
    + 			    m->num_packs + m->num_packs_in_base);
     
      ## midx-write.c ##
     @@ midx-write.c: static int write_midx_bitmap(struct write_midx_context *ctx,
    @@ object-name.c: static void unique_in_pack(struct packed_git *p,
      static void find_short_packed_object(struct disambiguate_state *ds)
      {
     -	struct multi_pack_index *m;
    ++	struct odb_source *source;
      	struct packed_git *p;
      
      	/* Skip, unless oids from the storage hash algorithm are wanted */
    @@ object-name.c: static void unique_in_pack(struct packed_git *p,
     -	     m = m->next)
     -		unique_in_midx(m, ds);
     +	odb_prepare_alternates(ds->repo->objects);
    -+	for (struct odb_source *source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
    ++	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
     +		struct multi_pack_index *m = get_multi_pack_index(source);
     +		if (m)
     +			unique_in_midx(m, ds);
    @@ object-name.c: static void find_abbrev_len_for_pack(struct packed_git *p,
      }
     
      ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static int open_midx_bitmap(struct repository *r,
    +@@ pack-bitmap.c: static int open_pack_bitmap(struct repository *r,
    + static int open_midx_bitmap(struct repository *r,
      			    struct bitmap_index *bitmap_git)
      {
    ++	struct odb_source *source;
      	int ret = -1;
     -	struct multi_pack_index *midx;
      
    @@ pack-bitmap.c: static int open_midx_bitmap(struct repository *r,
     -	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
     -		if (!open_midx_bitmap_1(bitmap_git, midx))
     +	odb_prepare_alternates(r->objects);
    -+	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
    ++	for (source = r->objects->sources; source; source = source->next) {
     +		struct multi_pack_index *midx = get_multi_pack_index(source);
     +		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
      			ret = 0;
      	}
    -+
      	return ret;
    - }
    +@@ pack-bitmap.c: static int verify_bitmap_file(const struct git_hash_algo *algop,
      
    -@@ pack-bitmap.c: int verify_bitmap_files(struct repository *r)
    + int verify_bitmap_files(struct repository *r)
      {
    ++	struct odb_source *source;
      	int res = 0;
      
     -	for (struct multi_pack_index *m = get_multi_pack_index(r);
     -	     m; m = m->next) {
     -		char *midx_bitmap_name = midx_bitmap_filename(m);
     +	odb_prepare_alternates(r->objects);
    -+	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
    ++	for (source = r->objects->sources; source; source = source->next) {
     +		struct multi_pack_index *m = get_multi_pack_index(source);
     +		char *midx_bitmap_name;
     +
    @@ packfile.c: static void prepare_packed_git(struct repository *r);
      	if (!r->objects->approximate_object_count_valid) {
     -		unsigned long count;
     -		struct multi_pack_index *m;
    ++		struct odb_source *source;
     +		unsigned long count = 0;
      		struct packed_git *p;
      
    @@ packfile.c: static void prepare_packed_git(struct repository *r);
     -		for (m = get_multi_pack_index(r); m; m = m->next)
     -			count += m->num_objects;
     +
    -+		for (struct odb_source *source = r->objects->sources; source; source = source->next) {
    ++		for (source = r->objects->sources; source; source = source->next) {
     +			struct multi_pack_index *m = get_multi_pack_index(source);
     +			if (m)
     +				count += m->num_objects;
    @@ packfile.c: struct packed_git *get_packed_git(struct repository *r)
     -
     -	return NULL;
     +	prepare_packed_git(source->odb->repo);
    -+	return source->multi_pack_index;
    ++	return source->midx;
      }
      
      struct packed_git *get_all_packs(struct repository *r)
6:  5f9d1d62514 ! 5:  05264cb723d packfile: stop using linked MIDX list in `find_pack_entry()`
    @@ packfile.c: static int fill_pack_entry(const struct object_id *oid,
     -	for (m = r->objects->multi_pack_index; m; m = m->next) {
     -		if (fill_midx_entry(r, oid, e, m))
     +	for (struct odb_source *source = r->objects->sources; source; source = source->next)
    -+		if (source->multi_pack_index && fill_midx_entry(r, oid, e, source->multi_pack_index))
    ++		if (source->midx && fill_midx_entry(r, oid, e, source->midx))
      			return 1;
     -	}
     +
7:  020761d0ed5 ! 6:  995581b2979 packfile: stop using linked MIDX list in `get_all_packs()`
    @@ packfile.c: struct multi_pack_index *get_multi_pack_index(struct odb_source *sou
     -		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++)
     +
     +	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
    -+		struct multi_pack_index *m = source->multi_pack_index;
    ++		struct multi_pack_index *m = source->midx;
     +		if (!m)
     +			continue;
     +		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
8:  d34129034ef ! 7:  7320e4cbe37 midx: remove now-unused linked list of multi-pack indices
    @@ midx.c: int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_i
      	struct repository *r = source->odb->repo;
     -	struct multi_pack_index *m;
      
    - 	if (source->multi_pack_index_loaded)
    - 		return !!source->multi_pack_index;
    -@@ midx.c: int prepare_multi_pack_index_one(struct odb_source *source, int local)
    + 	prepare_repo_settings(r);
      	if (!r->settings.core_multi_pack_index)
    - 		return 0;
    +@@ midx.c: int prepare_multi_pack_index_one(struct odb_source *source, int local)
    + 	if (source->midx)
    + 		return 1;
      
     -	m = load_multi_pack_index(r, source->path, local);
     -	if (m) {
    @@ midx.c: int prepare_multi_pack_index_one(struct odb_source *source, int local)
     -		} else {
     -			r->objects->multi_pack_index = m;
     -		}
    --		source->multi_pack_index = m;
    +-		source->midx = m;
    ++	source->midx = load_multi_pack_index(r, source->path, local);
    + 
    +-		return 1;
     -	}
     -
    -+	source->multi_pack_index = load_multi_pack_index(r, source->path, local);
    - 	source->multi_pack_index_loaded = 1;
    -+
    - 	return !!source->multi_pack_index;
    +-	return 0;
    ++	return !!source->midx;
      }
      
    + int midx_checksum_valid(struct multi_pack_index *m)
     @@ midx.c: void clear_midx_file(struct repository *r)
    - 			source->multi_pack_index = NULL;
    - 			source->multi_pack_index_loaded = 0;
    + 				close_midx(source->midx);
    + 			source->midx = NULL;
      		}
     -		r->objects->multi_pack_index = NULL;
      	}
    @@ midx.c: void clear_midx_file(struct repository *r)
      	if (remove_path(midx.buf))
     
      ## midx.h ##
    -@@ midx.h: struct repository;
    +@@ midx.h: struct odb_source;
      	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
      
      struct multi_pack_index {
    @@ odb.h: struct object_database {
     
      ## packfile.c ##
     @@ packfile.c: void close_object_store(struct object_database *o)
    - 		source->multi_pack_index = NULL;
    - 		source->multi_pack_index_loaded = 0;
    + 			close_midx(source->midx);
    + 		source->midx = NULL;
      	}
     -	o->multi_pack_index = NULL;
      

---
base-commit: 10b5a133fe89e14e8b4a0d441119d71ab3620ba8
change-id: 20250513-b4-pks-midx-via-odb-alternate-d4b5940a28cd

