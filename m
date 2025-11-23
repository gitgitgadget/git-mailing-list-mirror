Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EE15ECD7
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924390; cv=none; b=R4/Oik9ZCSdjySJ8ZGYT8vjHBZT/ZHav362G0A1sOsxs+HR66ZfOtifT3S3FtjKl/WfUY1vFCS/X5RTHAuZd2zXNT3AepIscRKACBOpGyZn6UqCBn01TMqTatMzF1zcDuc4DaNA1wQUKUeHIQeBwWiy8IAIVrqnRtxXeQQObjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924390; c=relaxed/simple;
	bh=5jEu+5sYcSTv+KSluezzl3+TmDzw7Ak2mzU2Nt/MbUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VLt3Cdj+QtiWQ9cXz0zexin1RH09iR+Tl3Iik30h1gOFoz9b286/Au88QEybDWD3g1tjzG+MvIB2hGvrs2CQE8hz3QVcfRDM0LdE0O99TIKK462A3cxnJzFnbu/iDHg8prOZ2D0aV9yuGmeGJAwodYsPt2sNyePZjB8DLioWtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=npWHoK80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABmOR7ml; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="npWHoK80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABmOR7ml"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A16C47A00BC;
	Sun, 23 Nov 2025 13:59:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 23 Nov 2025 13:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924386;
	 x=1764010786; bh=wRCXpk5VE0d1AgugQaguCGV+6sVDSMXgRX2u4y8QxoU=; b=
	npWHoK80v+pVVTll5rIOFgh7QcmC1A7IqBrwBjdt5T50qXmuQxtVZl0xZC9VshsA
	okbcHauw/XCU797POdsxmJxL7MnNiU0AsYLiHrjczxOn+DHRt+r96ihi5lednUaX
	hxGDgJ3+2V/BAJearcwZ2xSNNc+eRHrAg7Vnmtqq03sQQ5pIHBjnWghkTQaUEdei
	BE9rxliiKrBarAFPyF/w2UehcBFGdj/w5bAkm2gifs8xaBmlKXWBoNJmbm+8MvN5
	ocVn5txjo5IgV49O6GzOwZ1/XcFmwwe0/c6DhIiMEB3rTNPG9nyFtqz+/6myxkXS
	HmTj/6ctmA9508OBpQ4zKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924386; x=
	1764010786; bh=wRCXpk5VE0d1AgugQaguCGV+6sVDSMXgRX2u4y8QxoU=; b=A
	BmOR7mlLtepoadn8T/l/jLEQMpb22PadsFKUFliOMxn2uBwCsLNs4UkvrHsWL1Zq
	thfIxiHaCz+57certF7XpE1Ee/+8ZqagD9cJdgiiLCvg8D0zZvBVGioSlpKJVWR/
	ZMuikhE7ANs2Xu+CqVTl5Jnw8ZosGWkbwl1KQ+9Vj3alhz1zd5P8isi1ydLK7Ogl
	5qDScFd0tJgb1DmJmAG3yyVMkXFTfsVU0+7eWFoT5if0g8bXJbq8PLJa4uDOVI2d
	Jp5vzoXgDBqfO8jYJLIE2Ig8QCUbi2XLAssRVhf4Q4XH58oMxXBvAgug6W6XBmmG
	G2/3100BOEXpGBERmmpgQ==
X-ME-Sender: <xms:olkjaeJ002QSilDbjCEBFnKNNrsr9_UFrg-OkOM8WzjAPd9tYFoRww>
    <xme:olkjadKQkgj2DZaobM_N5vxTwgCGpbOfkllE1boRtZYUIOv44igiCwMV2CbVbFBO5
    1EGzvr1k6y4A-u_YUKyv_tFz1U1N3xGRqbMtBIaucOh3c7GUgBD>
X-ME-Received: <xmr:olkjaTtjBmD_lSVvdHuKy7qlkMnWc4OMHgVANdNY_n0BacVehXHNxthRd-hrgMkw0YbPYZ96KTrtrL9QFH-cFKnZfrsFHqRYEaq88l9jNvix7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiheeugfevteffveduvdefteekieekgfevleeftdevffdtudeigfehhfelgeegveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhgtohhrvgdrrhgvrggunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:olkjaSRQYx1K4SWXjDjARMW8mHmWszpG72AHGDmjEX0jiK4f55p1bg>
    <xmx:olkjaROtuoOsNvpwfjcNObcTJ59jkUx8p7XRlNOMil9AKzFMPwh4nw>
    <xmx:olkjafYQFSR4RcbPggvB4Z2HSBDVTDVxlSoPWavMK8KFwBUJUggTZw>
    <xmx:olkjaTxQ6MgHgj4y50UqQwyiRqSS--toVhFxk3ZJr0JOSmfMKwR4wQ>
    <xmx:olkjaTPBNJ9QWpcQMhkRhAbknQHF6TJWxwxjIqz6L-B7sPvHFV1KVfzv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e1ab668 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/19] Refactor object read streams to work via object
 sources
Date: Sun, 23 Nov 2025 19:59:25 +0100
Message-Id: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1ZI2kC/3XNywrCMBAF0F8pWTuSSVr7WPkf4iJNJjZIHyQlK
 KX/blpE3HQ13OHOmYUF8o4Ca7KFeYouuHFIQZ4ypjs1PAicSZkJLgpEXkKbw/QMMJoWPCkDYU6
 jh5JUaTlxVdmcpePJk3WvHb7dU+5cmEf/3v9E3LZfEusjMiJwUEZpy6UWWttrap1dzzYvij9D4
 KEhkqFVVci8vkgs+M9Y1/UDApBHp/0AAAA=
X-Change-ID: 20251107-b4-pks-odb-read-stream-7ea7f0e0a8f4
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

the `git_istream` data structure can be used to read objects from the
object database in a streaming fashion. This is used for example to read
large files that one doesn't want to load into memory in full.

In the current architecture, all the logic to handle these streams is
fully self-contained in "streaming.c". It contains the logic to set up
streams for loose, packed, in-memory and filtered objects. This doesn't
really play all that well with pluggable object databases, as it should
be the responsibility of the object database source itself to handle the
logic.

This patch series thus revamps our object read streams: instead of being
entirely contained in "streaming.c", the format-specific streams are now
created by the ODB sources. This allows each source itself to decide
whether and, if so, how to make objects streamable.

This overall requires quite a bit of refactoring, but I think that the
end result is an easier-to-understand infrastructure that is an
improvement even without pluggable object databases.

This series is built on top of v2.52.0 with ps/object-source-loose at
3e5e360888 (object-file: refactor writing objects via a stream,
2025-11-03) merged into it.

Changes in v3:
  - Clarify why we want to get rid of the `open()` callback.
  - Explain change in semantics now that we iterate through sources
    first to create the read stream.
  - Fix "opaque" comment applying to the correct structure.
  - Rename `odb_read_object_stream()` to `odb_read_stream_open()`.
  - Link to v2: https://lore.kernel.org/r/20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im

Changes in v2:
  - Some commit message improvements.
  - Drop the `type` and `size` out pointers in
    `odb_read_object_stream()` in an additional commit.
  - Improve a "hidden" variable declaration by moving it onto its own
    line.
  - Link to v1: https://lore.kernel.org/r/20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (19):
      streaming: rename `git_istream` into `odb_read_stream`
      streaming: drop the `open()` callback function
      streaming: propagate final object type via the stream
      streaming: explicitly pass packfile info when streaming a packed object
      streaming: allocate stream inside the backend-specific logic
      streaming: create structure for in-core object streams
      streaming: create structure for loose object streams
      streaming: create structure for packed object streams
      streaming: create structure for filtered object streams
      streaming: move zlib stream into backends
      packfile: introduce function to read object info from a store
      streaming: rely on object sources to create object stream
      streaming: get rid of `the_repository`
      streaming: make the `odb_read_stream` definition public
      streaming: move logic to read loose objects streams into backend
      streaming: move logic to read packed objects streams into backend
      streaming: refactor interface to be object-database-centric
      streaming: move into object database subsystem
      streaming: drop redundant type and size pointers

 Makefile               |   2 +-
 archive-tar.c          |  12 +-
 archive-zip.c          |  17 +-
 builtin/cat-file.c     |   4 +-
 builtin/fsck.c         |   5 +-
 builtin/index-pack.c   |  15 +-
 builtin/log.c          |   6 +-
 builtin/pack-objects.c |  24 ++-
 entry.c                |   4 +-
 meson.build            |   2 +-
 object-file.c          | 183 ++++++++++++++--
 object-file.h          |  42 +---
 odb.c                  |  29 +--
 odb/streaming.c        | 293 ++++++++++++++++++++++++++
 odb/streaming.h        |  67 ++++++
 packfile.c             | 199 ++++++++++++++++--
 packfile.h             |  17 +-
 parallel-checkout.c    |   5 +-
 streaming.c            | 561 -------------------------------------------------
 streaming.h            |  21 --
 20 files changed, 779 insertions(+), 729 deletions(-)

Range-diff versus v2:

 1:  9862db07e9 =  1:  5e1b90ccf0 streaming: rename `git_istream` into `odb_read_stream`
 2:  42a9684d52 !  2:  c55a13abb6 streaming: drop the `open()` callback function
    @@ Commit message
           - The structure needs to be allocated and partially populated with the
             open function before we can properly initialize it.
     
    -      - We never use the `open()` callback after having opened it initially.
    +      - We only ever call the `open()` callback function right after having
    +        populated the `struct odb_read_stream::open` member, and it's never
    +        called thereafter again. So it is somewhat pointless to store the
    +        callback in the first place.
     
         Especially the first point creates a problem for us. In subsequent
         commits we'll want to fully move construction of the read source into
    @@ streaming.c: static int istream_source(struct odb_read_stream *st,
      
      /****************************************************************
     @@ streaming.c: struct odb_read_stream *open_istream(struct repository *r,
    - {
    - 	struct odb_read_stream *st = xmalloc(sizeof(*st));
    - 	const struct object_id *real = lookup_replace_object(r, oid);
    --	int ret = istream_source(st, r, real, type);
    -+	int ret;
    - 
    -+	ret = istream_source(st, r, real, type);
    - 	if (ret) {
    - 		free(st);
      		return NULL;
      	}
      
 3:  c00bef7a2d !  3:  c588ab7a66 streaming: propagate final object type via the stream
    @@ streaming.c: static int istream_source(struct odb_read_stream *st,
      
      /****************************************************************
     @@ streaming.c: struct odb_read_stream *open_istream(struct repository *r,
    + {
    + 	struct odb_read_stream *st = xmalloc(sizeof(*st));
      	const struct object_id *real = lookup_replace_object(r, oid);
    - 	int ret;
    +-	int ret = istream_source(st, r, real, type);
    ++	int ret = istream_source(st, r, real);
      
    --	ret = istream_source(st, r, real, type);
    -+	ret = istream_source(st, r, real);
      	if (ret) {
      		free(st);
    - 		return NULL;
     @@ streaming.c: struct odb_read_stream *open_istream(struct repository *r,
      	}
      
 4:  3d5f3ce9d2 =  4:  5b3671c699 streaming: explicitly pass packfile info when streaming a packed object
 5:  0bd824d570 !  5:  440b858905 streaming: allocate stream inside the backend-specific logic
    @@ streaming.c: static ssize_t read_istream_incore(struct odb_read_stream *st, char
      			       const struct object_id *oid)
      {
      	struct object_info oi = OBJECT_INFO_INIT;
    +-
    +-	st->u.incore.read_ptr = 0;
    +-	st->close = close_istream_incore;
    +-	st->read = read_istream_incore;
    +-
    +-	oi.typep = &st->type;
    +-	oi.sizep = &st->size;
    +-	oi.contentp = (void **)&st->u.incore.buf;
    +-	return odb_read_object_info_extended(r->objects, oid, &oi,
    +-					     OBJECT_INFO_DIE_IF_CORRUPT);
     +	struct odb_read_stream stream = {
     +		.close = close_istream_incore,
     +		.read = read_istream_incore,
     +	};
     +	int ret;
    - 
    --	st->u.incore.read_ptr = 0;
    --	st->close = close_istream_incore;
    --	st->read = read_istream_incore;
    ++
     +	oi.typep = &stream.type;
     +	oi.sizep = &stream.size;
     +	oi.contentp = (void **)&stream.u.incore.buf;
    @@ streaming.c: static ssize_t read_istream_incore(struct odb_read_stream *st, char
     +					    OBJECT_INFO_DIE_IF_CORRUPT);
     +	if (ret)
     +		return ret;
    - 
    --	oi.typep = &st->type;
    --	oi.sizep = &st->size;
    --	oi.contentp = (void **)&st->u.incore.buf;
    --	return odb_read_object_info_extended(r->objects, oid, &oi,
    --					     OBJECT_INFO_DIE_IF_CORRUPT);
    ++
     +	CALLOC_ARRAY(*out, 1);
     +	**out = stream;
     +	return 0;
    @@ streaming.c: struct odb_read_stream *open_istream(struct repository *r,
     -	struct odb_read_stream *st = xmalloc(sizeof(*st));
     +	struct odb_read_stream *st;
      	const struct object_id *real = lookup_replace_object(r, oid);
    - 	int ret;
    +-	int ret = istream_source(st, r, real);
    ++	int ret = istream_source(&st, r, real);
      
    --	ret = istream_source(st, r, real);
     -	if (ret) {
     -		free(st);
    -+	ret = istream_source(&st, r, real);
     +	if (ret)
      		return NULL;
     -	}
 6:  468f17442a =  6:  9107044e1a streaming: create structure for in-core object streams
 7:  42f75b6d1f =  7:  9d2fd8212f streaming: create structure for loose object streams
 8:  63b3dbe842 =  8:  82b994a6ca streaming: create structure for packed object streams
 9:  e192352dc3 =  9:  96c07c0e5f streaming: create structure for filtered object streams
10:  dd718680f6 = 10:  ccb8abf077 streaming: move zlib stream into backends
11:  466ccbe059 = 11:  07ef79d591 packfile: introduce function to read object info from a store
12:  ba7bddecb1 ! 12:  741414fef9 streaming: rely on object sources to create object stream
    @@ Commit message
     
         But both of these issues will soon be addressed.
     
    +    This refactoring results in a slight change to semantics: previously, it
    +    was `odb_read_object_info_extended()` that picked the source for us, and
    +    it would have favored packed (non-deltified) objects over loose objects.
    +    And while we still favor packed over loose objects for a single source
    +    with the new logic, we'll now favor a loose object from an earlier
    +    source over a packed object from a later source.
    +
    +    Ultimately this shouldn't matter though: the stream doesn't indicate to
    +    the caller which source it is from and whether it was created from a
    +    packed or loose object, so such details are opaque to the caller. And
    +    other than that we should be able to assume that two objects with the
    +    same object ID should refer to the same content, so the streamed data
    +    would be the same, too.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## streaming.c ##
13:  723910c871 ! 13:  39134f2260 streaming: get rid of `the_repository`
    @@ streaming.c: int stream_blob_to_fd(int fd, const struct object_id *oid, struct s
     
      ## streaming.h ##
     @@
    + 
      #include "object.h"
      
    - /* opaque */
     +struct object_database;
    + /* opaque */
      struct odb_read_stream;
      struct stream_filter;
    - 
     @@ streaming.h: struct odb_read_stream *open_istream(struct repository *, const struct object_id
      int close_istream(struct odb_read_stream *);
      ssize_t read_istream(struct odb_read_stream *, void *, size_t);
14:  023015855f ! 14:  12b6ff9b93 streaming: make the `odb_read_stream` definition public
    @@ streaming.c
     
      ## streaming.h ##
     @@
    - 
      #include "object.h"
      
    --/* opaque */
      struct object_database;
    +-/* opaque */
      struct odb_read_stream;
      struct stream_filter;
      
15:  9439f09f8b = 15:  af51d9959f streaming: move logic to read loose objects streams into backend
16:  e7f8c8038d = 16:  5bc76e022d streaming: move logic to read packed objects streams into backend
17:  b8933fb980 ! 17:  1dcd53f244 streaming: refactor interface to be object-database-centric
    @@ archive-tar.c: static int stream_blocked(struct repository *r, const struct obje
      	ssize_t readlen;
      
     -	st = open_istream(r, oid, &type, &sz, NULL);
    -+	st = odb_read_object_stream(r->objects, oid, &type, &sz, NULL);
    ++	st = odb_read_stream_open(r->objects, oid, &type, &sz, NULL);
      	if (!st)
      		return error(_("cannot stream blob %s"), oid_to_hex(oid));
      	for (;;) {
    @@ archive-zip.c: static int write_zip_entry(struct archiver_args *args,
      			enum object_type type;
     -			stream = open_istream(args->repo, oid, &type, &size,
     -					      NULL);
    -+			stream = odb_read_object_stream(args->repo->objects, oid,
    -+							&type, &size, NULL);
    ++			stream = odb_read_stream_open(args->repo->objects, oid,
    ++						      &type, &size, NULL);
      			if (!stream)
      				return error(_("cannot stream blob %s"),
      					     oid_to_hex(oid));
    @@ builtin/index-pack.c: static int check_collison(struct object_entry *entry)
      	data.entry = entry;
     -	data.st = open_istream(the_repository, &entry->idx.oid, &type, &size,
     -			       NULL);
    -+	data.st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
    -+					 &type, &size, NULL);
    ++	data.st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
    ++				       &type, &size, NULL);
      	if (!data.st)
      		return -1;
      	if (size != entry->size || type != entry->type)
    @@ builtin/pack-objects.c: static unsigned long write_no_reuse_object(struct hashfi
      					 repo_settings_get_big_file_threshold(the_repository)) &&
     -		    (st = open_istream(the_repository, &entry->idx.oid, &type,
     -				       &size, NULL)) != NULL)
    -+		    (st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
    -+						 &type, &size, NULL)) != NULL)
    ++		    (st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
    ++					       &type, &size, NULL)) != NULL)
      			buf = NULL;
      		else {
      			buf = odb_read_object(the_repository->objects,
    @@ object-file.c: int stream_object_signature(struct repository *r, const struct ob
      	int hdrlen;
      
     -	st = open_istream(r, oid, &obj_type, &size, NULL);
    -+	st = odb_read_object_stream(r->objects, oid, &obj_type, &size, NULL);
    ++	st = odb_read_stream_open(r->objects, oid, &obj_type, &size, NULL);
      	if (!st)
      		return -1;
      
    @@ streaming.c: static int open_istream_incore(struct odb_read_stream **out,
     -				     enum object_type *type,
     -				     unsigned long *size,
     -				     struct stream_filter *filter)
    -+struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
    -+					       const struct object_id *oid,
    -+					       enum object_type *type,
    -+					       unsigned long *size,
    -+					       struct stream_filter *filter)
    ++struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
    ++					     const struct object_id *oid,
    ++					     enum object_type *type,
    ++					     unsigned long *size,
    ++					     struct stream_filter *filter)
      {
      	struct odb_read_stream *st;
     -	const struct object_id *real = lookup_replace_object(r, oid);
    +-	int ret = istream_source(&st, r, real);
     +	const struct object_id *real = lookup_replace_object(odb->repo, oid);
    - 	int ret;
    ++	int ret = istream_source(&st, odb, real);
      
    --	ret = istream_source(&st, r, real);
    -+	ret = istream_source(&st, odb, real);
      	if (ret)
      		return NULL;
    - 
     @@ streaming.c: struct odb_read_stream *open_istream(struct repository *r,
      		/* Add "&& !is_null_stream_filter(filter)" for performance */
      		struct odb_read_stream *nst = attach_stream_filter(st, filter);
    @@ streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
      	int result = -1;
      
     -	st = open_istream(odb->repo, oid, &type, &sz, filter);
    -+	st = odb_read_object_stream(odb, oid, &type, &sz, filter);
    ++	st = odb_read_stream_open(odb, oid, &type, &sz, filter);
      	if (!st) {
      		if (filter)
      			free_stream_filter(filter);
    @@ streaming.h: struct odb_read_stream {
     + *
     + * Returns the stream on success, a `NULL` pointer otherwise.
     + */
    -+struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
    -+					       const struct object_id *oid,
    -+					       enum object_type *type,
    -+					       unsigned long *size,
    -+					       struct stream_filter *filter);
    ++struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
    ++					     const struct object_id *oid,
    ++					     enum object_type *type,
    ++					     unsigned long *size,
    ++					     struct stream_filter *filter);
     +
     +/*
     + * Close the given read stream and release all resources associated with it.
18:  9fc79d10fd = 18:  e8c4e1931c streaming: move into object database subsystem
19:  aab61d5697 ! 19:  f8e31ef59f streaming: drop redundant type and size pointers
    @@ archive-tar.c: static void write_trailer(void)
      	char buf[BLOCKSIZE];
      	ssize_t readlen;
      
    --	st = odb_read_object_stream(r->objects, oid, &type, &sz, NULL);
    -+	st = odb_read_object_stream(r->objects, oid, NULL);
    +-	st = odb_read_stream_open(r->objects, oid, &type, &sz, NULL);
    ++	st = odb_read_stream_open(r->objects, oid, NULL);
      	if (!st)
      		return error(_("cannot stream blob %s"), oid_to_hex(oid));
      	for (;;) {
    @@ archive-zip.c: static int write_zip_entry(struct archiver_args *args,
      
      		if (!buffer) {
     -			enum object_type type;
    --			stream = odb_read_object_stream(args->repo->objects, oid,
    --							&type, &size, NULL);
    -+			stream = odb_read_object_stream(args->repo->objects, oid, NULL);
    +-			stream = odb_read_stream_open(args->repo->objects, oid,
    +-						      &type, &size, NULL);
    ++			stream = odb_read_stream_open(args->repo->objects, oid, NULL);
      			if (!stream)
      				return error(_("cannot stream blob %s"),
      					     oid_to_hex(oid));
    @@ builtin/index-pack.c: static int check_collison(struct object_entry *entry)
      
      	memset(&data, 0, sizeof(data));
      	data.entry = entry;
    --	data.st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
    --					 &type, &size, NULL);
    -+	data.st = odb_read_object_stream(the_repository->objects, &entry->idx.oid, NULL);
    +-	data.st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
    +-				       &type, &size, NULL);
    ++	data.st = odb_read_stream_open(the_repository->objects, &entry->idx.oid, NULL);
      	if (!data.st)
      		return -1;
     -	if (size != entry->size || type != entry->type)
    @@ builtin/pack-objects.c
     @@ builtin/pack-objects.c: static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
      		    oe_size_greater_than(&to_pack, entry,
      					 repo_settings_get_big_file_threshold(the_repository)) &&
    - 		    (st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
    --						 &type, &size, NULL)) != NULL)
    -+						 NULL)) != NULL) {
    + 		    (st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
    +-					       &type, &size, NULL)) != NULL)
    ++					       NULL)) != NULL) {
      			buf = NULL;
     -		else {
     +			type = st->type;
    @@ object-file.c: int check_object_signature(struct repository *r, const struct obj
      	char hdr[MAX_HEADER_LEN];
      	int hdrlen;
      
    --	st = odb_read_object_stream(r->objects, oid, &obj_type, &size, NULL);
    -+	st = odb_read_object_stream(r->objects, oid, NULL);
    +-	st = odb_read_stream_open(r->objects, oid, &obj_type, &size, NULL);
    ++	st = odb_read_stream_open(r->objects, oid, NULL);
      	if (!st)
      		return -1;
      
    @@ object-file.c: int check_object_signature(struct repository *r, const struct obj
      ## odb/streaming.c ##
     @@ odb/streaming.c: ssize_t odb_read_stream_read(struct odb_read_stream *st, void *buf, size_t sz)
      
    - struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
    - 					       const struct object_id *oid,
    --					       enum object_type *type,
    --					       unsigned long *size,
    - 					       struct stream_filter *filter)
    + struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
    + 					     const struct object_id *oid,
    +-					     enum object_type *type,
    +-					     unsigned long *size,
    + 					     struct stream_filter *filter)
      {
      	struct odb_read_stream *st;
    -@@ odb/streaming.c: struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
    +@@ odb/streaming.c: struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
      		st = nst;
      	}
      
    @@ odb/streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
      	ssize_t kept = 0;
      	int result = -1;
      
    --	st = odb_read_object_stream(odb, oid, &type, &sz, filter);
    -+	st = odb_read_object_stream(odb, oid, filter);
    +-	st = odb_read_stream_open(odb, oid, &type, &sz, filter);
    ++	st = odb_read_stream_open(odb, oid, filter);
      	if (!st) {
      		if (filter)
      			free_stream_filter(filter);
    @@ odb/streaming.h: struct odb_read_stream {
       *
       * Returns the stream on success, a `NULL` pointer otherwise.
       */
    - struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
    - 					       const struct object_id *oid,
    --					       enum object_type *type,
    --					       unsigned long *size,
    - 					       struct stream_filter *filter);
    + struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
    + 					     const struct object_id *oid,
    +-					     enum object_type *type,
    +-					     unsigned long *size,
    + 					     struct stream_filter *filter);
      
      /*

---
base-commit: 899e578b5b7c020aec806bd694adf2563f62843c
change-id: 20251107-b4-pks-odb-read-stream-7ea7f0e0a8f4

