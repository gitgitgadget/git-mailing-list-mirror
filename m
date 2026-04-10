Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB23B4E8A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823173; cv=none; b=qA5U2WAWdyAUEv7+ujAng8KKNw9eiQ98BSOgp/9naraJcl47+WrBJOb1BVS7LaN2fgC9b3b9Klhc6xWLhGtkzDTdnWw/g/SgVAkoIDEETLKz9otZ9WzPiBemOJPwvu8sEE0Zb4u/JXafS9b32bNdYZUt2CmOuOt27PHAv0INBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823173; c=relaxed/simple;
	bh=nEAx2VkawXRIm7pkzrkCniQv9vDW+y2fQa3ISt48kQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CzSPSHQwNrLifFxppRen1Gf5Pv4zferEtQwEjHckXPE57Y3xGYeisf5g80Aasgu86ldg0jTk9EvqRwd9YcEntk65VISyXgefF0Osdz0IjRiWjucqCfyk2RMrGvFAASb68CTWof31jT1m8Zjidd44dq0jxJpOKteaAZhHEG5NJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wlqUsw+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsuQpfMH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wlqUsw+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsuQpfMH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9A377A00E8;
	Fri, 10 Apr 2026 08:12:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 08:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823169;
	 x=1775909569; bh=MK2hUXHK+5nyXSYJMsrqHiLwk584MM0dY8lQJUrUsyc=; b=
	wlqUsw+K78RDI9302hX3KnAQbdm+udDbqDJi5P6IB7ystvScANQSlArXEfQTys18
	ueON8M4FZ7osFddipuHmwA9FZjGzd2RI6JKFS9IZ8KFuQ1OqhmP/P+lpYrN4cKUV
	mahWxbgYrpntyZ82psL6dAynyKMhTrFRiFzJKbUXiCgRguxU/mDQgykxBizlQraM
	nFskfWxrHRfv0wIednVjBHCYjvm1m7EdjEtsshbKUf7toS6uW+YdgLRSQeUYzA3/
	v7wgT81bXI8UsODzAQ2XEGHqx+ChpDOj3pFRQ1FHY4SbTBvjyujWxstjeDW6dHKb
	nepAnkm7VJUBLBS6II7cxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823169; x=
	1775909569; bh=MK2hUXHK+5nyXSYJMsrqHiLwk584MM0dY8lQJUrUsyc=; b=W
	suQpfMHxMWS+Mb1lG9nMP+NA1GWJnBanMHV7HbzPO24MxtDYb2+YOjoKnW3ulANu
	OG1LLnw8yIAxHJnakmGkLq+ajSaX6kWHSZafpgAAgj90VTr9c3vlhwCcUwDz++qT
	fdmF4Lor/91b81bk34foQsi3mPQOa27Qh7u49VC9qcw8aisJSpav8FY2nF+Q1Fon
	7QdnFYzv7tDMKB4LeFc5ZbCRvK+QnS2SFIWk0swWw94f2Mi5qsMNpX9l89qijeGk
	/o3hixUpu7X45cmphWBygJbb5UlMOTC9KXiN4v94WtwWhZ/t30ml5vRg+90s6Jel
	3Be+ftCmkHJApkWuUfdNQ==
X-ME-Sender: <xms:QenYacboUbDV8Kj8nhq1SWSoJ2kzlJYaC6nanKx5AdmVVv7kag3FyA>
    <xme:QenYae33W6YXBOaYH0HyzrPtjbsecdkxLPTA_gNstRUOi9R0KM3ZkDtIM9OBv6lee
    rJgqt4LnEV2TnQbI2infO0L2HiX1xro44G7ENQIuEPFQ6d27BoN>
X-ME-Received: <xmr:QenYaUWG4b631mqeU6gSX-0m8UL2ucjZEH8GsrSe7dQDEs8f49BHmfSvRCbs9j9Od_W7Ftj6tir-PmAzlTMo8jPqOFRkokGevfx3y9o8b72S7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdffkeektdefleetveegueethedtfeeugeegvddvhfdvtdetieeiueekhefgfeehnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QenYaQWtDmsqdHBzmHQJY1GAC2E74CM_gZ5kuVtMhn44gAOc1Hchyg>
    <xmx:QenYabekrwUvQJrwUjkFz8w3ynZ5qxWT__2wK9SkE0seAKDuVIiyuw>
    <xmx:QenYaRUNC88h6Trf3i6d9NaDzUt-2iLbeGuknAMdPgwn1DNMUTZ0yQ>
    <xmx:QenYacd5pMjcaW0jv8YI8i3FeWdQhDgbeOfYU6XJL2QVFjszhb_LQg>
    <xmx:QenYaW3sKOAf5MIJ8XjYCpn6RvvrKSxvuwVpN0xSpmJP8WYuejFIBRn_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:12:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51a500b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:12:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/17] odb: introduce "in-memory" source
Date: Fri, 10 Apr 2026 14:12:30 +0200
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC7p2GkC/32NTQ6CMBgFr0K6tqZ/CrjyHsZFW75KNVDSQqMh3
 N0Wo3HF8iXzZmYUwFsI6FTMyEO0wbo+Db4rkG5lfwNsm7QRI+xIBKFYCTw8AnaNwsFNXieg76B
 z/oVLRUtd8aYGwVESDB6Mfa7yy/Wzw6TuoMdszERrw5ieaz3SzH1DfCsUKSa4UlVDpZKSHeCcy
 L3tUK5E9u+pNz0seQxhShiqiaH851mW5Q0xXWIMGwEAAA==
X-Change-ID: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Hi,

this patch series introduces the second object database source type,
which is the "in-memory" source.

This source may seem somewhat odd at first: it always starts out empty,
and any object written into it will only exist in memory until the
process exits. But the source already serves a purpose in our codebase,
where some commands, for example git-blame(1), write an in-memory
worktree commit.

Furthermore, I think that going forward it can serve more purposes as we
now have an easy way to write and read objects that will not get
persisted. I could see that this may be useful when for example
re-merging diffs. But eventually, once we have the object storage format
extension wired up, callers might even want to manually set up an
in-memory database as the primary ODB for write operations so that no
data will be persisted in an arbitrary write.

Last but not least, this patch series also serves the purpose of
eventually getting rid of the `struct object_info::whence` member.
Instead, we'll simply yield the ODB source a specific object has been
read from, together with some backend-specific data, which gives
strictly more information compared to the status quo.

The series is based onb15384c06f (A bit more post -rc1, 2026-04-08)
with jt/odb-transaction-write at ddf6aee9c6 (odb/transaction: make
`write_object_stream()` pluggable, 2026-04-02) merged into it.

Changes in v2:
  - Fix handling of object IDs when writing objects.
  - I've changed the base of this series to include Justin's
    refactorings for the ODB write streams. I've updated the above
    paragraph detailing the merge base accordingly. @Junio: I'm fine to
    defer this patch series a bit until Justin's patch series has been
    merged to `next` in case this causes inconvenience.
  - Use "in-memory" instead of "inmemory" in commit messages.
  - Link to v1: https://patch.msgid.link/20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im

Changes in v3:
  - Fix a couple more instances where we were saying "inmemory" in
    prose.
  - Fix streaming interface when reading an object.
  - Add unit tests to exercise full functionality of the new source.
    Some of the functionality isn't exercised in our code base yet, so
    this allows us to verify that things work as expected.
  - Link to v2: https://patch.msgid.link/20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      odb: introduce "in-memory" source
      odb/source-inmemory: implement `free()` callback
      odb: fix unnecessary call to `find_cached_object()`
      odb/source-inmemory: implement `read_object_info()` callback
      odb/source-inmemory: implement `read_object_stream()` callback
      odb/source-inmemory: implement `write_object()` callback
      odb/source-inmemory: implement `write_object_stream()` callback
      cbtree: allow using arbitrary wrapper structures for nodes
      oidtree: add ability to store data
      odb/source-inmemory: convert to use oidtree
      odb/source-inmemory: implement `for_each_object()` callback
      odb/source-inmemory: implement `find_abbrev_len()` callback
      odb/source-inmemory: implement `count_objects()` callback
      odb/source-inmemory: implement `freshen_object()` callback
      odb/source-inmemory: stub out remaining functions
      odb: generic in-memory source
      t/unit-tests: add tests for the in-memory object source

 Makefile                      |   2 +
 cbtree.c                      |  25 ++-
 cbtree.h                      |  17 +-
 loose.c                       |   2 +-
 meson.build                   |   1 +
 object-file.c                 |   3 +-
 odb.c                         |  82 ++-------
 odb.h                         |   4 +-
 odb/source-inmemory.c         | 382 ++++++++++++++++++++++++++++++++++++++++++
 odb/source-inmemory.h         |  33 ++++
 odb/source.h                  |   3 +
 oidtree.c                     |  66 +++++---
 oidtree.h                     |  12 +-
 t/meson.build                 |   1 +
 t/unit-tests/u-odb-inmemory.c | 313 ++++++++++++++++++++++++++++++++++
 t/unit-tests/u-oidtree.c      |  26 ++-
 16 files changed, 854 insertions(+), 118 deletions(-)

Range-diff versus v2:

 1:  b18e427c69 !  1:  155b2cdf81 odb: introduce "in-memory" source
    @@ odb/source-inmemory.h (new)
     +struct cached_object_entry;
     +
     +/*
    -+ * An inmemory source that you can write objects to that shall be made
    ++ * An in-memory source that you can write objects to that shall be made
     + * available for reading, but that shouldn't ever be persisted to disk. Note
     + * that any objects written to this source will be stored in memory, so the
     + * number of objects you can store is limited by available system memory.
    @@ odb/source-inmemory.h (new)
     +struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb);
     +
     +/*
    -+ * Cast the given object database source to the inmemory backend. This will
    ++ * Cast the given object database source to the in-memory backend. This will
     + * cause a BUG in case the source doesn't use this backend.
     + */
     +static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
     +{
     +	if (source->type != ODB_SOURCE_INMEMORY)
    -+		BUG("trying to downcast source of type '%d' to inmemory", source->type);
    ++		BUG("trying to downcast source of type '%d' to in-memory", source->type);
     +	return container_of(source, struct odb_source_inmemory, base);
     +}
     +
    @@ odb/source.h: enum odb_source_type {
      	/* The "files" backend that uses loose objects and packfiles. */
      	ODB_SOURCE_FILES,
     +
    -+	/* The "inmemory" backend that stores objects in memory. */
    ++	/* The "in-memory" backend that stores objects in memory. */
     +	ODB_SOURCE_INMEMORY,
      };
      
 2:  8fd337da90 !  2:  c66edd10a8 odb/source-inmemory: implement `free()` callback
    @@ odb/source-inmemory.h
     +};
      
      /*
    -  * An inmemory source that you can write objects to that shall be made
    +  * An in-memory source that you can write objects to that shall be made
 3:  f4ae2a2bde =  3:  a86549f39c odb: fix unnecessary call to `find_cached_object()`
 4:  8600b88530 =  4:  49ac739dd2 odb/source-inmemory: implement `read_object_info()` callback
 5:  ab33c0b7ee !  5:  321ef11be3 odb/source-inmemory: implement `read_object_stream()` callback
    @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_info(struct od
      
     +struct odb_read_stream_inmemory {
     +	struct odb_read_stream base;
    -+	const void *buf;
    ++	const unsigned char *buf;
     +	size_t offset;
     +};
     +
    @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_info(struct od
     +
     +	if (buf_len > inmemory->base.size - inmemory->offset)
     +		bytes = inmemory->base.size - inmemory->offset;
    -+	memcpy(buf, inmemory->buf, bytes);
    ++
    ++	memcpy(buf, inmemory->buf + inmemory->offset, bytes);
    ++	inmemory->offset += bytes;
     +
     +	return bytes;
     +}
 6:  983f886eeb !  6:  506df5e488 odb/source-inmemory: implement `write_object()` callback
    @@ odb.c: int odb_pretend_object(struct object_database *odb,
      void *odb_read_object(struct object_database *odb,
     
      ## odb/source-inmemory.c ##
    +@@
    + #include "git-compat-util.h"
    ++#include "object-file.h"
    + #include "odb.h"
    + #include "odb/source-inmemory.h"
    + #include "odb/streaming.h"
     @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
      	return 0;
      }
    @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_stream(struct
     +	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
     +	struct cached_object_entry *object;
     +
    ++	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
    ++
     +	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
     +		   inmemory->objects_alloc);
     +	object = &inmemory->objects[inmemory->objects_nr++];
 7:  68edefa269 <  -:  ---------- odb/source-inmemory: implement `write_object()` callback
 8:  18d451152b !  7:  21eef34c1b odb/source-inmemory: implement `write_object_stream()` callback
    @@ odb/source-inmemory.c: static int odb_source_inmemory_write_object(struct odb_so
     +			goto out;
     +		}
     +
    -+		memcpy(data, buf, bytes_read);
    ++		memcpy(data + total_read, buf, bytes_read);
     +		total_read += bytes_read;
     +	}
     +
 9:  cee53b9853 !  8:  504e34d116 cbtree: allow using arbitrary wrapper structures for nodes
    @@ cbtree.c: int cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
      
     
      ## cbtree.h ##
    +@@
    +  *
    +  * This is adapted to store arbitrary data (not just NUL-terminated C strings
    +  * and allocates no memory internally.  The user needs to allocate
    +- * "struct cb_node" and fill cb_node.k[] with arbitrary match data
    +- * for memcmp.
    +- * If "klen" is variable, then it should be embedded into "c_node.k[]"
    ++ * "struct cb_node" and provide `key_offset` to indicate where the key can be
    ++ * found relative to the `struct cb_node` for memcmp.
    ++ * If "klen" is variable, then it should be embedded into the key.
    +  * Recursion is bound by the maximum value of "klen" used.
    +  */
    + #ifndef CBTREE_H
     @@ cbtree.h: struct cb_node {
      	 */
      	uint32_t byte;
10:  8ad5b81b13 =  9:  9bdd475a92 oidtree: add ability to store data
11:  1ed2d23137 ! 10:  956b989529 odb/source-inmemory: convert to use oidtree
    @@ odb/source-inmemory.h
     +struct oidtree;
      
      /*
    -  * An inmemory source that you can write objects to that shall be made
    +  * An in-memory source that you can write objects to that shall be made
     @@ odb/source-inmemory.h: struct cached_object_entry {
       */
      struct odb_source_inmemory {
12:  99fbb1cc35 ! 11:  bec1428116 odb/source-inmemory: implement `for_each_object()` callback
    @@ odb/source-inmemory.c: static int odb_source_inmemory_read_object_stream(struct
     +	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
     +	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
     +		return 0;
    ++	if (!inmemory->objects)
    ++		return 0;
     +
     +	return oidtree_each(inmemory->objects,
     +			    opts->prefix ? opts->prefix : &null_oid, opts->prefix_hex_len,
13:  c87a621f39 = 12:  32dada3c27 odb/source-inmemory: implement `find_abbrev_len()` callback
14:  9b88f0c07b = 13:  43127840c0 odb/source-inmemory: implement `count_objects()` callback
15:  3c9493f2bb = 14:  439acbd068 odb/source-inmemory: implement `freshen_object()` callback
16:  f2b6317104 ! 15:  12c1b6ffd2 odb/source-inmemory: stub out remaining functions
    @@ odb/source-inmemory.c: static int odb_source_inmemory_freshen_object(struct odb_
     +static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
     +						 struct odb_transaction **out UNUSED)
     +{
    -+	return error("inmemory source does not support transactions");
    ++	return error("in-memory source does not support transactions");
     +}
     +
     +static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
    @@ odb/source-inmemory.c: static int odb_source_inmemory_freshen_object(struct odb_
     +static int odb_source_inmemory_write_alternate(struct odb_source *source UNUSED,
     +					       const char *alternate UNUSED)
     +{
    -+	return error("inmemory source does not support alternates");
    ++	return error("in-memory source does not support alternates");
     +}
     +
     +static void odb_source_inmemory_close(struct odb_source *source UNUSED)
17:  81da5d5048 = 16:  ef37a61e7f odb: generic in-memory source
 -:  ---------- > 17:  51b51e0382 t/unit-tests: add tests for the in-memory object source

---
base-commit: a3ebc5a08e67ccac4c915622049a968a31e48662
change-id: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43

