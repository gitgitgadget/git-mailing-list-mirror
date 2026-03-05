Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C86175A79
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720390; cv=none; b=TbcngZ9SaUGNiSA2yifuNwTXAwN72BbBWEffdFiVQ6iO9WSzrLLx+MNB8dpchqsKWil2d81SasfSTnW1qXwGUhbdUPiwI1EbAknh8e4KPCnzx6F5JlPG0mRn14llpT54qWbiA05yH2aPOi30mMgKQWAjQd3NPEcnPrZNiLbObb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720390; c=relaxed/simple;
	bh=iKXZIRTKwBaOhLMulTCC7rlUeBgF/kBQzS7g16v3Xc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KRue4JXJhl2YNEEaaaNI3Ai9pW8lpadLiYyH8P4x/GdX/WjaPFj05KPmV/XdLYab8HfkeaMrMahKzwgiwedCzS8howuSn9lnS91TBmZIs77BTxuIGd7XsfDxowIkRKCngqwT5L60IITBvG7oFM+IzvGtVK40HlKZP7PbOAzDqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=STCu0O+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ri7KnSYj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="STCu0O+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ri7KnSYj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 303B31D00159;
	Thu,  5 Mar 2026 09:19:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 09:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720388;
	 x=1772806788; bh=aR3FfWW8e3/x8seZpWONw2UF2kolvBtxwF6tzC01SyI=; b=
	STCu0O+gZNhsJPWZ9m8FD4BiqHmS1OGIzPc7oofDxwvLapfqOA2rqVm8nYNidUb3
	jSDMQELabyn2XzeFux27SJVYh7KCRi34/iy5Nj6wJAafs7TSDqVzTag2ibJc1NJV
	KJe8zDzJvFilVj+L889lk04wDh7q81BDra99GTXSPdl0qzj+ey7iLHRDy+nd2+CZ
	T7oO8gIi2t4EGC5K+rCv/mpSADxfXzB3uOfbrEllZ1aPfgEYOmi6ht5p0oj6WGh8
	+/95WipKtvbPXyGwLhVEDGvZ3UDNgaMd7d7/tlT2VtWEaLEFpLh/twmTnttFhS6m
	yr9ysb1mklcubAjSlHsifQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720388; x=
	1772806788; bh=aR3FfWW8e3/x8seZpWONw2UF2kolvBtxwF6tzC01SyI=; b=r
	i7KnSYjIxzuSrDBljhgJQe5L6TYxmvjOznLSh5RVKI2lMDMcsxBA6UmtYiKlGukV
	NhnKvngl06TNuyx5uhNaliTemYyp2isFn52edDUDq1uN7KcVrMA5O51U9lpYLgqM
	8sEUTAlMWOgZG4S2uM9EcoI+djGTd+iYBpgsokeJhkAE8opkgTrkzoPRNLy8jj3D
	e4VQAZAYt44W3A1AnDGcX2rO+s+vaWYGwnx0LTr/pjWdGwJ8atBLJLpRKqvWnLzR
	2Ek0tvKZ5tGyL4Zc0LCqB9XJUxvMSi5RpAvIxhkDzCMuNZp7O5Bmhukky/9ff47y
	NWgh6xlu0Uqru+lJlQpfA==
X-ME-Sender: <xms:A5GpaaAZFTLLqBvYx9oV1TUqL3Rl9Y2jFtbPD9ZKjIAlRuW86nao1g>
    <xme:A5GpabhpsAr22opEp2YzcPspkd36pczkmWxsWk6nTN7go43vLhdBOFL3v5wRpO0Pj
    bYmMX_wp9L6ZpWcBky0sqlAtXr-pgaZ5F19VwTwy8S7V-xD-Swv>
X-ME-Received: <xmr:A5GpaSlhon-qxMdb4J7VS-uOFTewoNCbl1OUrOUWidpWK9zk8sjfirx1p0AKzA_Y2RIFyoqnR61ODB6s3mlyQK8GuJLAyWKM59SFturkqoCb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvieeuffejhfekleeutddvgeethfeukeehlefhgeelffeugeevfeduhfeuteeggfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgtvdefqdhmvghsohhnrdgsuhhilhgune
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:A5GpaXpCWjQg7b7yRKCXWVi6MQ3qPWQdCxLPY7ZzKgw9ubDI4YCC7g>
    <xmx:A5GpabEf4SOCIc58H6hSCrL8qns6YJnvL87wrl73gSFEtYHE0IdOzA>
    <xmx:A5GpaTzSFY3s-vLFKJlx1iFaC0T5TVzhDk8wST_F5mXy5X7ww6SLPA>
    <xmx:A5GpaQp_Zwwu4XXXybQt3NbSvA2E4gDyqMmTTcznr1L88peWVMXVSQ>
    <xmx:BJGpaaE00gvkVaPjomy1oA9RinAUwhfgQMr8hkZWMbGaOcr6enBLlC2d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:19:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b553a47f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:19:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/17] odb: make object database sources pluggable
Date: Thu, 05 Mar 2026 15:19:40 +0100
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyQqWkC/33NwQ6CMAzG8VchPVuzFaboyfcwHNio0IiMbEI0h
 Hd34t3j/0vz6wKRg3CEc7ZA4Fmi+CEF7TJwXT20jNKkBlJ0UJoU2gLHe0TfWIx+Co5x7Ke2rW3
 PaNyRCjLK5q6EJIyBb/La9GuVupP49OG9PZv1d/25RPlfd9aokExua6cba07lJZ3u5QHVuq4f4
 UCqhsMAAAA=
X-Change-ID: 20260120-b4-pks-odb-source-pluggable-5c724250b3c8
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series finally makes the object database source pluggable.
This is done by moving backend-specific logics into callback functions
that are part of `struct odb_source` and providing thin wrappers that
call those functions.

To set expectations: this is only a start, there is still functionality
missing that needs to be made pluggable. Most importantly:

  - Counting of objects.

  - Abbreviating object IDs and finding ambiguous objects.

  - Consistency checks.

  - Optimizing the object database.

  - Generating packfiles.

These will all happen in later patch series. That being said, with this
patch series one already gets a lot of the basic functionality, and it's
almost possible to do local workflows. Only "almost" though because we
rely on abbreviating object IDs in a lot of places, but once that part
is implemented in a subsequent patch series you can indeed work locally
with an alternate backend.

Furthermore, what I didn't include as part of this patch series just yet
is the introduction of the "objectStorage" extension. I mostly wanted to
focus on the mostly-trivial parts without introducing any change in
behaviour.

This series is based on top of 7c02d39fc2 (The 6th batch, 2026-02-20)
with the following two series merged into it:

  - ps/odb-for-each-object at 3565faf28c (odb: drop unused
    `for_each_{loose,packed}_object()` functions, 2026-01-26)

  - ps/object-info-bits-cleanup at 732ec9b17b (odb: convert
    `odb_has_object()` flags into an enum, 2026-02-12)

Changes in v2:
  - Fix mismerge in the base of this patch series.
  - Adjust several comments and improve commit messages a bit.
  - Link to v1: https://lore.kernel.org/r/20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      odb: split `struct odb_source` into separate header
      odb: introduce "files" source
      odb: embed base source in the "files" backend
      odb: move reparenting logic into respective subsystems
      odb/source: introduce source type for robustness
      odb/source: make `free()` function pluggable
      odb/source: make `reprepare()` function pluggable
      odb/source: make `close()` function pluggable
      odb/source: make `read_object_info()` function pluggable
      odb/source: make `read_object_stream()` function pluggable
      odb/source: make `for_each_object()` function pluggable
      odb/source: make `freshen_object()` function pluggable
      odb/source: make `write_object()` function pluggable
      odb/source: make `write_object_stream()` function pluggable
      odb/source: make `read_alternates()` function pluggable
      odb/source: make `write_alternate()` function pluggable
      odb/source: make `begin_transaction()` function pluggable

 Makefile               |   2 +
 builtin/cat-file.c     |   3 +-
 builtin/fast-import.c  |  12 +-
 builtin/grep.c         |   6 +-
 builtin/index-pack.c   |   8 +-
 builtin/pack-objects.c |  13 +-
 commit-graph.c         |   6 +-
 http.c                 |   3 +-
 loose.c                |  23 ++-
 meson.build            |   2 +
 midx.c                 |  26 +--
 object-file.c          |  38 ++--
 odb.c                  | 191 +++-----------------
 odb.h                  |  86 +--------
 odb/source-files.c     | 239 +++++++++++++++++++++++++
 odb/source-files.h     |  35 ++++
 odb/source.c           |  38 ++++
 odb/source.h           | 468 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb/streaming.c        |   8 +-
 packfile.c             |  36 ++--
 packfile.h             |   7 +-
 tmp-objdir.c           |  42 ++---
 tmp-objdir.h           |  15 --
 23 files changed, 953 insertions(+), 354 deletions(-)

Range-diff versus v1:

 1:  28258657d5 =  1:  6dd89d5721 odb: split `struct odb_source` into separate header
 2:  38fa6650e7 =  2:  aaf6175ad7 odb: introduce "files" source
 3:  bbdfe087d3 !  3:  1188bc969a odb: embed base source in the "files" backend
    @@ odb/source-files.h: struct packfile_store;
      void odb_source_files_free(struct odb_source_files *files);
      
     +/*
    -+ * Cast the given object database source to the files backend. This will cause
    -+ * a BUG in case the source doesn't use this backend.
    ++ * Cast the given object database source to the files backend.
     + */
     +static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
     +{
 4:  1f545a0b28 !  4:  a5deca0da9 odb: move reparenting logic into respective subsystems
    @@ Commit message
         odb: move reparenting logic into respective subsystems
     
         The primary object database source may be initialized with a relative
    -    path. When reparenting the process to a different working directory we
    -    thus have to update this path and have it point to the same path, but
    +    path. When the process changes its current working directory we thus
    +    have to update this path and have it point to the same path, but
         relative to the new working directory.
     
         This logic is handled in the object database layer. It consists of three
 5:  f3f0f3daeb !  5:  defb03a1b9 odb/source: introduce source type for robustness
    @@ odb/source-files.c: struct odb_source_files *odb_source_files_new(struct object_
      
     
      ## odb/source-files.h ##
    -@@ odb/source-files.h: void odb_source_files_free(struct odb_source_files *files);
    +@@ odb/source-files.h: struct odb_source_files *odb_source_files_new(struct object_database *odb,
    + void odb_source_files_free(struct odb_source_files *files);
    + 
    + /*
    +- * Cast the given object database source to the files backend.
    ++ * Cast the given object database source to the files backend. This will cause
    ++ * a BUG in case the source doesn't use this backend.
       */
      static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
      {
    @@ odb/source.h
      
     +enum odb_source_type {
     +	/*
    -+	 * The "unknown" type, which should never be in use. This is type
    -+	 * mostly exists to catch cases where the type field remains zeroed
    -+	 * out.
    ++	 * The "unknown" type, which should never be in use. This type mostly
    ++	 * exists to catch cases where the type field remains zeroed out.
     +	 */
     +	ODB_SOURCE_UNKNOWN,
     +
 6:  c86a03bf7c =  6:  df5c9e7584 odb/source: make `free()` function pluggable
 7:  b1645d0de0 =  7:  6787995a2c odb/source: make `reprepare()` function pluggable
 8:  e873c4f32c =  8:  9942876dbe odb/source: make `close()` function pluggable
 9:  0ccf994441 !  9:  9902f4561b odb/source: make `read_object_info()` function pluggable
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## object-file.c ##
    -@@ object-file.c: static int read_object_info_from_path(struct odb_source *source,
    - int odb_source_loose_read_object_info(struct odb_source *source,
    - 				      const struct object_id *oid,
    - 				      struct object_info *oi,
    --				      unsigned flags)
    -+				      enum object_info_flags flags)
    +@@ object-file.c: int odb_source_loose_read_object_info(struct odb_source *source,
    + 				      enum object_info_flags flags)
      {
      	static struct strbuf buf = STRBUF_INIT;
     +
10:  f98a8adfed = 10:  99299ed03e odb/source: make `read_object_stream()` function pluggable
11:  b8a9b9fe16 ! 11:  274a6020ab odb/source: make `for_each_object()` function pluggable
    @@ odb/source.h: struct odb_source {
     +	 * valid to yield the same object multiple time. A non-zero exit code
     +	 * from the object callback shall abort iteration.
     +	 *
    -+	 * The optional `oi` structure shall be populated similar to how an individual
    -+	 * call to `odb_source_read_object_info()` would have behaved. If the caller
    -+	 * passes a `NULL` pointer then the object itself shall not be read.
    ++	 * The optional `request` structure should serve as a template for
    ++	 * looking up object info for every individual iterated object. It
    ++	 * should not be modified directly and should instead be copied into a
    ++	 * separate `struct object_info` that gets passed to the callback. If
    ++	 * the caller passes a `NULL` pointer then the object itself shall not
    ++	 * be read.
     +	 *
     +	 * The callback is expected to return a negative error code in case the
     +	 * iteration has failed to read all objects, 0 otherwise. When the
    @@ odb/source.h: static inline int odb_source_read_object_stream(struct odb_read_st
     + * callback function aborts iteration. There is no guarantee that objects
     + * are only iterated over once.
     + *
    -+ * The optional `oi` structure shall be populated similar to how an individual
    -+ * call to `odb_source_read_object_info()` would have behaved. If the caller
    -+ * passes a `NULL` pointer then the object itself shall not be read.
    ++ * The optional `request` structure serves as a template for retrieving the
    ++ * object info for each indvidual iterated object and will be populated as if
    ++ * `odb_source_read_object_info()` was called on the object. It will not be
    ++ * modified, the callback will instead be invoked with a separate `struct
    ++ * object_info` for every object. Object info will not be read when passing a
    ++ * `NULL` pointer.
     + *
     + * The flags is a bitfield of `ODB_FOR_EACH_OBJECT_*` flags. Not all flags may
     + * apply to a specific backend, so whether or not they are honored is defined
12:  406826905d = 12:  abc1bc6f81 odb/source: make `freshen_object()` function pluggable
13:  59a3678799 ! 13:  9a995ff455 odb/source: make `write_object()` function pluggable
    @@ odb/source.h
     +
      enum odb_source_type {
      	/*
    - 	 * The "unknown" type, which should never be in use. This is type
    + 	 * The "unknown" type, which should never be in use. This type mostly
     @@ odb/source.h: struct odb_source {
      	 */
      	int (*freshen_object)(struct odb_source *source,
14:  e5c47518ef = 14:  8c938de272 odb/source: make `write_object_stream()` function pluggable
15:  ca0e6dfb1a ! 15:  16a826e24c odb/source: make `read_alternates()` function pluggable
    @@ odb/source.h: struct odb_source {
     +	 * This callback is expected to read the list of alternate object
     +	 * database sources connected to it and write them into the `strvec`.
     +	 *
    -+	 * The format is expected to follow the "objectStorage" extension
    -+	 * format with `(backend://)?payload` syntax. If the payload contains
    -+	 * paths, these paths must be resolved to absolute paths.
    ++	 * The result is expected to be paths to the alternates. All paths must
    ++	 * be resolved to absolute paths.
     +	 *
     +	 * The callback is expected to return 0 on success, a negative error
     +	 * code otherwise.
16:  7e36a7ec8f = 16:  2f6bf3aedc odb/source: make `write_alternate()` function pluggable
17:  dc918d3fc5 = 17:  118b442202 odb/source: make `begin_transaction()` function pluggable

---
base-commit: b1af291b4adf1c433ad2b79f0390f7d6b516a964
change-id: 20260120-b4-pks-odb-source-pluggable-5c724250b3c8

