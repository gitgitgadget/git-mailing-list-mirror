Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B714658D
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920013; cv=none; b=YgLNBGJjyhO4AToyV6r5s3Kq77HWl2bc/j1j1WnB3JfyTp/Xa7HLUhpRJraHo68W43hx5XejJHhb56MUHSTQzW0Zj8coAvpC1iS/lXDNltrOqeu+EIidoCqURU8p+dpJWfmUf4HZyhiErGKAHqVDIhU9gtCi/lStnb4kwtRACCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920013; c=relaxed/simple;
	bh=aZCgDK8/Hkg01yKI/tCetgrQiDBhIFsd8XUCNGGxeB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fgc5423DrIbt0r5m+y8PmV/5Vx2C+8m0o+S4UBLBEVEUutAWnwHT0EW/hdZ2a/b/VJxfG3EFNYuYwaO4YOBdvysdNXIxKYXo/W7M/UV4ciBA8hU2yUCcFaVAhtFqS9u2Sxli9+ZocwBtvCKB3geE0Qty2cYgQozwQ2Q2+4hkqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G+nTZQUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9Fd4Avu; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G+nTZQUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9Fd4Avu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D2921D00084;
	Mon, 11 Aug 2025 09:46:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 11 Aug 2025 09:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920010;
	 x=1755006410; bh=yK0TUj3UW/IF1yBjcd3tjLX/6AQHO7qlH+SvnqMCSjI=; b=
	G+nTZQUFPH7zbkO6Bk5NK0ezfbkD8FbSFp26u2SQ1Mxipe7s3UHp109u/h+zAPqI
	EtjG1XpVRGA7gJybo8Lajhp4Ynlz8HG1vamXwLqrXBk+5Ez16gSxOyzrAdCJtTij
	cTk93Du7qomG3cEL+Da6ddrEXr8mqqnxqoFxi/9j1uMEgLbzPBJrdC4xcFNQAn6+
	TuEl6Mjc+Nyltc3CA1IZwprfWgQtmqYvOzodtkd6j+OzdbjYm/9hyPMjfSJiueL5
	K4jxog/5Th156xD+eJQK/Uco0ldPCZS2xT7AwD7aWnvunepODnRSMEAwyOnghs5K
	YNfZ/NPD0ynMge3OT/01AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920010; x=
	1755006410; bh=yK0TUj3UW/IF1yBjcd3tjLX/6AQHO7qlH+SvnqMCSjI=; b=T
	9Fd4Avu7284neX4k2avmA+/D2pJ3/U9DuwiIscIIqbNUU4KhDdlEBOhN9L33hpiC
	c1tEPJgpIitAPmL9NSBE143r87FLF3v22G98ZRaT3JZN9O4d3Rh8uf63VKjcA7La
	rc6Kfvd+f2p2sTg8uG40FHPH/3QprbUU+g3Ks2K9lyThJYPfkoztLB5cTqcGRJCL
	fj5uW2lDTSdxoViN9AA5R2YbOFuxW4x77Qvl4R5SGhVt/RSXpQhqtVOdmC0XFNDA
	OkcMn9Z0RgYUoWghlbg3on9gbWcbkU3v1qeP77uPXlDQUqeRjF6v75afqfjS6yoi
	YVIv44a7BOnnTDirXGWvg==
X-ME-Sender: <xms:SfSZaJEvaydcQaX0yBVEQl9N_GpG1BOcqsE5WKZ69NAvkitZahrNzA>
    <xme:SfSZaJ0ZHlA3uYub85_JeQhAds6Ug83Dd09TtpxGSvCwWCrfiV95yebSnMLrNL5hd
    8aIk4udWrxZuyP7IA>
X-ME-Received: <xmr:SfSZaBkgMXBeyf0hs3pNsbLKr00Q303qeNQe4BZmStblgHYJnLfVSUP1K-D0scHayTuuwMb2HPc2YlgpISg1PGwMCQ0Tn3FiqL39UVxDjEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SfSZaJ_d4mEv-L2lxfoH3OYB5aTdO0QTmlUoLj1yrFxzak31XKF-bQ>
    <xmx:SfSZaGqQRbVrYWTzj9iX0Ml-cOAN-mr6LI4OZ_2ZYZQO3F-F6Q5XLQ>
    <xmx:SfSZaCkBTxJbB6l2Zr1J076K6lVQOPk8h59bfaHklQtax-BY0_dV_g>
    <xmx:SfSZaNiV610VsnBK5I9jihYqx1O9dvbvjfv5IFWX-8eDnArhyyGQ1g>
    <xmx:SvSZaP62XRNVsOYw1hDxDYTpaGjoMMbPaHWRQZ66FnO6wsgNm41I6Ivv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:46:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2b895be (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:46:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] midx: stop duplicating info redundant with their
 sources
Date: Mon, 11 Aug 2025 15:46:40 +0200
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAED0mWgC/5XNyw6CMBAF0F8hXTumDwjFlf9hXNCXTFRKWmgwh
 H+3sNCtLu9k7rkLiTagjeRULCTYhBF9n4M4FER3bX+zgCZnwimvaM0bUCUM9whPNDMYa6bhgbo
 dLUQ/BZ2/e+fBaSc0lcqZSpAsDcE6nPeVyzXnDuPow2sfTWy7/ucnBhTqUhrFrWmFqs65csQn2
 fDEv6Ck9W8gz6DSzinpNGON/oDrur4BbhxgVyQBAAA=
X-Change-ID: 20250729-b4-pks-midx-deduplicate-source-info-fcf3c08bfd53
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is a follow up to the recent patch series that started
to move the MIDX into its object source. It refactors the MIDX subsystem
so that we always read and write them via an ODB source. This ultimately
allows us to store a pointer to  the owning ODB source in the MIDX and
thus dedup some redundant information.

This series is built on top of e813a0200a7 (The fifteenth batch,
2025-07-28) with ps/object-store-midx at ec865d94d46 (midx: remove
now-unused linked list of multi-pack indices, 2025-07-15) merged into
it.

Changes in v2:
  - Fix a comment typo.
  - Introduce another commit that simplifies the calling convention for
    `link_alt_odb_entry()`.
  - Link to v1: https://lore.kernel.org/r/20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im

Changes in v3:
  - Introduce `odb_find_source_or_die()` so that we don't have to repeat
    the calls to `die()`, as suggested by Taylor.
  - Split out a patch to adapt `link_alt_odb_entry()` and friends to
    consistently name the parameter that refers to the alternate object
    directory's path.
  - Link to v2: https://lore.kernel.org/r/20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      odb: store locality in object database sources
      odb: allow `odb_find_source()` to fail
      odb: consistently use "dir" to refer to alternate's directory
      odb: return newly created in-memory sources
      odb: simplify calling `link_alt_odb_entry()`
      midx: drop redundant `struct repository` parameter
      midx: load multi-pack indices via their source
      midx: write multi-pack indices via their source
      midx: stop duplicating info redundant with its owning source
      midx: compute paths via their source

 builtin/commit-graph.c      |   4 +-
 builtin/multi-pack-index.c  |  31 +++++++---
 builtin/pack-objects.c      |   2 +-
 builtin/repack.c            |   7 ++-
 midx-write.c                | 116 +++++++++++++++++--------------------
 midx.c                      | 135 +++++++++++++++++++++-----------------------
 midx.h                      |  42 ++++++--------
 odb.c                       |  64 ++++++++++-----------
 odb.h                       |  19 +++++--
 pack-bitmap.c               |  15 +++--
 pack-revindex.c             |  14 ++---
 packfile.c                  |  13 ++---
 repository.c                |   1 +
 t/helper/test-read-midx.c   |  31 +++++-----
 t/t5319-multi-pack-index.sh |   8 +--
 15 files changed, 254 insertions(+), 248 deletions(-)

Range-diff versus v2:

 1:  937fe12914 =  1:  51817fdd71 odb: store locality in object database sources
 2:  c1a382e2e5 <  -:  ---------- odb: allow `odb_find_source()` to fail
 -:  ---------- >  2:  37da6f7908 odb: allow `odb_find_source()` to fail
 -:  ---------- >  3:  b0f3c8af7b odb: consistently use "dir" to refer to alternate's directory
 3:  31fa81ce51 !  4:  88af2d77bd odb: return newly created in-memory sources
    @@ odb.c: static void read_info_alternates(struct object_database *odb,
      				 int depth);
      
     -static int link_alt_odb_entry(struct object_database *odb,
    --			      const struct strbuf *entry,
    +-			      const char *dir,
     -			      const char *relative_base,
     -			      int depth,
     -			      const char *normalized_objdir)
     +static struct odb_source *link_alt_odb_entry(struct object_database *odb,
    -+					     const char *entry,
    ++					     const char *dir,
     +					     const char *relative_base,
     +					     int depth,
     +					     const char *normalized_objdir)
    @@ odb.c: static void read_info_alternates(struct object_database *odb,
      	khiter_t pos;
     -	int ret = -1;
      
    --	if (!is_absolute_path(entry->buf) && relative_base) {
    -+	if (!is_absolute_path(entry) && relative_base) {
    + 	if (!is_absolute_path(dir) && relative_base) {
      		strbuf_realpath(&pathbuf, relative_base, 1);
    - 		strbuf_addch(&pathbuf, '/');
    - 	}
    --	strbuf_addbuf(&pathbuf, entry);
    -+	strbuf_addstr(&pathbuf, entry);
    - 
    - 	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
    - 		error(_("unable to normalize alternate object path: %s"),
     @@ odb.c: static int link_alt_odb_entry(struct object_database *odb,
      
      	/* recursively add alternates */
    @@ odb.c: static int link_alt_odb_entry(struct object_database *odb,
      }
      
      static const char *parse_alt_odb_entry(const char *string,
    -@@ odb.c: static void link_alt_odb_entries(struct object_database *odb, const char *alt,
    - 		alt = parse_alt_odb_entry(alt, sep, &entry);
    - 		if (!entry.len)
    - 			continue;
    --		link_alt_odb_entry(odb, &entry,
    -+		link_alt_odb_entry(odb, entry.buf,
    - 				   relative_base, depth, objdirbuf.buf);
    - 	}
    - 	strbuf_release(&entry);
     @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
      	free(alts);
      }
      
     -void odb_add_to_alternates_memory(struct object_database *odb,
    --				  const char *reference)
    +-				  const char *dir)
     +struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
    -+						const char *reference)
    ++						const char *dir)
      {
     +	struct odb_source *alternate;
     +	char *objdir;
    @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
      	 */
      	odb_prepare_alternates(odb);
      
    --	link_alt_odb_entries(odb, reference,
    --			     '\n', NULL, 0);
    +-	link_alt_odb_entries(odb, dir, '\n', NULL, 0);
     +	objdir = real_pathdup(odb->sources->path, 1);
    -+	alternate = link_alt_odb_entry(odb, reference, NULL, 0, objdir);
    ++	alternate = link_alt_odb_entry(odb, dir, NULL, 0, objdir);
     +
     +	free(objdir);
     +	return alternate;
 4:  a94136e0a6 !  5:  4f002abcee odb: simplify calling `link_alt_odb_entry()`
    @@ Commit message
      ## odb.c ##
     @@ odb.c: static void read_info_alternates(struct object_database *odb,
      static struct odb_source *link_alt_odb_entry(struct object_database *odb,
    - 					     const char *entry,
    + 					     const char *dir,
      					     const char *relative_base,
     -					     int depth,
     -					     const char *normalized_objdir)
    @@ odb.c: static const char *parse_alt_odb_entry(const char *string,
      				 int sep, const char *relative_base, int depth)
      {
     -	struct strbuf objdirbuf = STRBUF_INIT;
    - 	struct strbuf entry = STRBUF_INIT;
    + 	struct strbuf dir = STRBUF_INIT;
      
      	if (!alt || !*alt)
     @@ odb.c: static void link_alt_odb_entries(struct object_database *odb, const char *alt,
    @@ odb.c: static void link_alt_odb_entries(struct object_database *odb, const char
     -	strbuf_realpath(&objdirbuf, odb->sources->path, 1);
     -
      	while (*alt) {
    - 		alt = parse_alt_odb_entry(alt, sep, &entry);
    - 		if (!entry.len)
    + 		alt = parse_alt_odb_entry(alt, sep, &dir);
    + 		if (!dir.len)
      			continue;
    --		link_alt_odb_entry(odb, entry.buf,
    +-		link_alt_odb_entry(odb, dir.buf,
     -				   relative_base, depth, objdirbuf.buf);
    -+		link_alt_odb_entry(odb, entry.buf, relative_base, depth);
    ++		link_alt_odb_entry(odb, dir.buf, relative_base, depth);
      	}
    - 	strbuf_release(&entry);
    + 	strbuf_release(&dir);
     -	strbuf_release(&objdirbuf);
      }
      
      static void read_info_alternates(struct object_database *odb,
     @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
      struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
    - 						const char *reference)
    + 						const char *dir)
      {
     -	struct odb_source *alternate;
     -	char *objdir;
    @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
      	odb_prepare_alternates(odb);
     -
     -	objdir = real_pathdup(odb->sources->path, 1);
    --	alternate = link_alt_odb_entry(odb, reference, NULL, 0, objdir);
    +-	alternate = link_alt_odb_entry(odb, dir, NULL, 0, objdir);
     -
     -	free(objdir);
     -	return alternate;
    -+	return link_alt_odb_entry(odb, reference, NULL, 0);
    ++	return link_alt_odb_entry(odb, dir, NULL, 0);
      }
      
      struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 5:  eaf7cc324a =  6:  91cf3fc19a midx: drop redundant `struct repository` parameter
 6:  64d1e33a88 =  7:  eac8ce2f0d midx: load multi-pack indices via their source
 7:  094fb9fd83 !  8:  634ccedddf midx: write multi-pack indices via their source
    @@ midx-write.c: static int write_midx_bitmap(struct write_midx_context *ctx,
     -static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
     -							const char *object_dir)
     -{
    --	struct odb_source *source = odb_find_source(r->objects, object_dir);
    --	if (!source)
    --		die(_("could not find object directory matching %s"), object_dir);
    +-	struct odb_source *source = odb_find_source_or_die(r->objects, object_dir);
     -	return get_multi_pack_index(source);
     -}
     -
 8:  2d6c844618 =  9:  91a15ad630 midx: stop duplicating info redundant with its owning source
 9:  93f60b02b6 = 10:  357f6a4986 midx: compute paths via their source

---
base-commit: ee2fd3d4b224c8145eeff04101ea6075560973e1
change-id: 20250729-b4-pks-midx-deduplicate-source-info-fcf3c08bfd53

