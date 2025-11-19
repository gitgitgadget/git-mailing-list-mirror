Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5C327215
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538505; cv=none; b=IlD08zvURgw+6/GQAXjhapLJZ96bvISxTtFDUdH7Duq6RysKZRTPqUyl4YjU5WMZ+kUWyXyb6a90Wfnytk7TrpjeSLyCX7LXcrQySiT0Vry31nS38I3pjFd391NQNkDRnXKEtEhPNVm0yaWScI7oBANexRPWQJ9z0Iz0Y0wRzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538505; c=relaxed/simple;
	bh=vEcPYVC2Hc6thBRVCF9N7c486U4MoZ5lKoj6HX56YxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Or58LZb8LrjUXsxlu/8MMCNU8D6idvdamuzaqjncz+NJrW246qWsB2m3S7qJalXYjXj8QpxwlTMDzwN6Fy4dJNsPF3m0iHkrZLqsAQZmVjDz2rI285RDxBzV1WOuds07ucSkXosVXiHQdSGN4gv12RLfm3WuCOCeG8RUapL+CL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PgNiOr9X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLW7xLvx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PgNiOr9X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLW7xLvx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2DC11400204
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538502;
	 x=1763624902; bh=Fx5WNIV92Rv8/3a9PSKPUW3l0qPNP8ae86AoKN7xDhw=; b=
	PgNiOr9XqND/Pst9Xdu9pti6zwMFfJsGv+sU5Krd5L0L0+gkknI3J1KsRBz+PYqp
	CyagCqE+qI2EZlwOrQKErrk5ZDHwsguGB7wcuu5DD1ooPJRO1knkMzFcVq/NEK7S
	qRrtd7uD8FQ5FAeqmp/9x32NYteKk0OkmITOZKvYDL1rrNj3W8SwS0jMfdW3ZbMQ
	bxbVszSlgJJ4U0mgRBO4hTm5Jkby4V+5VtQss7NhwMjVn4vSPYpjK33Q103P472R
	BZxrXOj/Cg2UkOTPvJHFcou9VyDaywBoyeHqw2xvZm6tV/EW0E9gzQtXW/aPU8p1
	0TBTG2Bxdn/c3kqbrdjcYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538502; x=
	1763624902; bh=Fx5WNIV92Rv8/3a9PSKPUW3l0qPNP8ae86AoKN7xDhw=; b=h
	LW7xLvxlqlQF9b+cZ+gs6GKJCqXKSmlVECDY6p5ZrK9/XlLbaL8a6Xz7xNs7ZGNw
	LXtSmVzvTFQd6T1RY0V2DKwFt8BGeRPUvHFgaS+9Gl9MXDDaBCcTWXHNk9Erarm0
	xR5f+Hfvav3PckYAvNqtnxc8YgwCjHCbUsIrZ6xVlmq2EA9SuIOYrmdrgEVoZiCb
	H1MO0IF1HNnOX9jmPxG8GsEqNMDZN+ZnwIdVLJ4MZb2Dquk1TPUVRsT6dtdyrFi8
	b7orMweAL0bWDGCmOwR0VDVOdOmhq8i/MvAwo7g7dAgsgNGLwPXrtp/b6GwK1bXo
	1UgTtfCnSexNqF8D4+F+Q==
X-ME-Sender: <xms:RnYdaQAcm5XsW2Yi0L2x7GZpuE_rLQb2_xy5lmBlyWOxFv902vxc8w>
    <xme:RnYdaZcA04R_LBOYvp9Rl27l-r6ckZznKVFGe-TjJJsz0lGT8-jPxYim5iMZii0Tw
    Ww2TXQxpriKmmp53LpQHTmaT3aNFDGFvYCfLumWoTSOVvJSAr-1XQ>
X-ME-Received: <xmr:RnYdaZNVtRnc5jN-Vnvc9_g-dVW5ZPLQ3ZgTYYhi1P_pv_iNAN05e3j9aaqznbGXPfft8uazN41EPnTFr-uODplSXrr9OY_u8LyVIEFgEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleff
    vdevleenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RnYdab4CEaMc84LL3acKt8uqWHGhmLtBB0Dapuzn947c-grp34TAWQ>
    <xmx:RnYdaVLUAaMuGu8NBTyWAESl2DOeZl04aNUnYVim-3CTwYVjnjtTXg>
    <xmx:RnYdadf_y6XWG0P03OiKhI-s5Ww3A-rNIUmwpxWxUQlzouqhq8WG5Q>
    <xmx:RnYdaQci6jqEKsOOiCGopgqp3FDkbjkIdaViLTqZLFC0fMrrurRIIA>
    <xmx:RnYdabB9Y2kZq9zm-Aaqq2ROAJeQb8Ng2GlGIgOik81o7ZWPErBZXq0J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc8824d4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:16 +0100
Subject: [PATCH 16/18] streaming: move logic to read packed objects streams
 into backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-16-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Move the logic to read packed object streams into the respective
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c  | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h  |   5 +++
 streaming.c | 136 +-----------------------------------------------------------
 3 files changed, 134 insertions(+), 135 deletions(-)

diff --git a/packfile.c b/packfile.c
index b4bc40d895..ad56ce0b90 100644
--- a/packfile.c
+++ b/packfile.c
@@ -20,6 +20,7 @@
 #include "tree.h"
 #include "object-file.h"
 #include "odb.h"
+#include "streaming.h"
 #include "midx.h"
 #include "commit-graph.h"
 #include "pack-revindex.h"
@@ -2406,3 +2407,130 @@ void packfile_store_close(struct packfile_store *store)
 		close_pack(p);
 	}
 }
+
+struct odb_packed_read_stream {
+	struct odb_read_stream base;
+	struct packed_git *pack;
+	git_zstream z;
+	enum {
+		ODB_PACKED_READ_STREAM_UNINITIALIZED,
+		ODB_PACKED_READ_STREAM_INUSE,
+		ODB_PACKED_READ_STREAM_DONE,
+		ODB_PACKED_READ_STREAM_ERROR,
+	} z_state;
+	off_t pos;
+};
+
+static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *buf,
+					   size_t sz)
+{
+	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
+	size_t total_read = 0;
+
+	switch (st->z_state) {
+	case ODB_PACKED_READ_STREAM_UNINITIALIZED:
+		memset(&st->z, 0, sizeof(st->z));
+		git_inflate_init(&st->z);
+		st->z_state = ODB_PACKED_READ_STREAM_INUSE;
+		break;
+	case ODB_PACKED_READ_STREAM_DONE:
+		return 0;
+	case ODB_PACKED_READ_STREAM_ERROR:
+		return -1;
+	case ODB_PACKED_READ_STREAM_INUSE:
+		break;
+	}
+
+	while (total_read < sz) {
+		int status;
+		struct pack_window *window = NULL;
+		unsigned char *mapped;
+
+		mapped = use_pack(st->pack, &window,
+				  st->pos, &st->z.avail_in);
+
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		st->z.next_in = mapped;
+		status = git_inflate(&st->z, Z_FINISH);
+
+		st->pos += st->z.next_in - mapped;
+		total_read = st->z.next_out - (unsigned char *)buf;
+		unuse_pack(&window);
+
+		if (status == Z_STREAM_END) {
+			git_inflate_end(&st->z);
+			st->z_state = ODB_PACKED_READ_STREAM_DONE;
+			break;
+		}
+
+		/*
+		 * Unlike the loose object case, we do not have to worry here
+		 * about running out of input bytes and spinning infinitely. If
+		 * we get Z_BUF_ERROR due to too few input bytes, then we'll
+		 * replenish them in the next use_pack() call when we loop. If
+		 * we truly hit the end of the pack (i.e., because it's corrupt
+		 * or truncated), then use_pack() catches that and will die().
+		 */
+		if (status != Z_OK && status != Z_BUF_ERROR) {
+			git_inflate_end(&st->z);
+			st->z_state = ODB_PACKED_READ_STREAM_ERROR;
+			return -1;
+		}
+	}
+	return total_read;
+}
+
+static int close_istream_pack_non_delta(struct odb_read_stream *_st)
+{
+	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
+	if (st->z_state == ODB_PACKED_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
+	return 0;
+}
+
+int packfile_store_read_object_stream(struct odb_read_stream **out,
+				      struct packfile_store *store,
+				      const struct object_id *oid)
+{
+	struct odb_packed_read_stream *stream;
+	struct pack_window *window = NULL;
+	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type in_pack_type;
+	unsigned long size;
+
+	oi.sizep = &size;
+
+	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
+	    oi.u.packed.is_delta ||
+	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
+		return -1;
+
+	in_pack_type = unpack_object_header(oi.u.packed.pack,
+					    &window,
+					    &oi.u.packed.offset,
+					    &size);
+	unuse_pack(&window);
+	switch (in_pack_type) {
+	default:
+		return -1; /* we do not do deltas for now */
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_BLOB:
+	case OBJ_TAG:
+		break;
+	}
+
+	CALLOC_ARRAY(stream, 1);
+	stream->base.close = close_istream_pack_non_delta;
+	stream->base.read = read_istream_pack_non_delta;
+	stream->base.type = in_pack_type;
+	stream->base.size = size;
+	stream->z_state = ODB_PACKED_READ_STREAM_UNINITIALIZED;
+	stream->pack = oi.u.packed.pack;
+	stream->pos = oi.u.packed.offset;
+
+	*out = &stream->base;
+
+	return 0;
+}
diff --git a/packfile.h b/packfile.h
index 0a98bddd81..3fcc5ae6e0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -8,6 +8,7 @@
 
 /* in odb.h */
 struct object_info;
+struct odb_read_stream;
 
 struct packed_git {
 	struct hashmap_entry packmap_ent;
@@ -144,6 +145,10 @@ void packfile_store_add_pack(struct packfile_store *store,
 #define repo_for_each_pack(repo, p) \
 	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next)
 
+int packfile_store_read_object_stream(struct odb_read_stream **out,
+				      struct packfile_store *store,
+				      const struct object_id *oid);
+
 /*
  * Try to read the object identified by its ID from the object store and
  * populate the object info with its data. Returns 1 in case the object was
diff --git a/streaming.c b/streaming.c
index 216576857f..02d790f488 100644
--- a/streaming.c
+++ b/streaming.c
@@ -114,140 +114,6 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
 	return &fs->base;
 }
 
-/*****************************************************************
- *
- * Non-delta packed object stream
- *
- *****************************************************************/
-
-struct odb_packed_read_stream {
-	struct odb_read_stream base;
-	struct packed_git *pack;
-	git_zstream z;
-	enum {
-		ODB_PACKED_READ_STREAM_UNINITIALIZED,
-		ODB_PACKED_READ_STREAM_INUSE,
-		ODB_PACKED_READ_STREAM_DONE,
-		ODB_PACKED_READ_STREAM_ERROR,
-	} z_state;
-	off_t pos;
-};
-
-static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *buf,
-					   size_t sz)
-{
-	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
-	size_t total_read = 0;
-
-	switch (st->z_state) {
-	case ODB_PACKED_READ_STREAM_UNINITIALIZED:
-		memset(&st->z, 0, sizeof(st->z));
-		git_inflate_init(&st->z);
-		st->z_state = ODB_PACKED_READ_STREAM_INUSE;
-		break;
-	case ODB_PACKED_READ_STREAM_DONE:
-		return 0;
-	case ODB_PACKED_READ_STREAM_ERROR:
-		return -1;
-	case ODB_PACKED_READ_STREAM_INUSE:
-		break;
-	}
-
-	while (total_read < sz) {
-		int status;
-		struct pack_window *window = NULL;
-		unsigned char *mapped;
-
-		mapped = use_pack(st->pack, &window,
-				  st->pos, &st->z.avail_in);
-
-		st->z.next_out = (unsigned char *)buf + total_read;
-		st->z.avail_out = sz - total_read;
-		st->z.next_in = mapped;
-		status = git_inflate(&st->z, Z_FINISH);
-
-		st->pos += st->z.next_in - mapped;
-		total_read = st->z.next_out - (unsigned char *)buf;
-		unuse_pack(&window);
-
-		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->z);
-			st->z_state = ODB_PACKED_READ_STREAM_DONE;
-			break;
-		}
-
-		/*
-		 * Unlike the loose object case, we do not have to worry here
-		 * about running out of input bytes and spinning infinitely. If
-		 * we get Z_BUF_ERROR due to too few input bytes, then we'll
-		 * replenish them in the next use_pack() call when we loop. If
-		 * we truly hit the end of the pack (i.e., because it's corrupt
-		 * or truncated), then use_pack() catches that and will die().
-		 */
-		if (status != Z_OK && status != Z_BUF_ERROR) {
-			git_inflate_end(&st->z);
-			st->z_state = ODB_PACKED_READ_STREAM_ERROR;
-			return -1;
-		}
-	}
-	return total_read;
-}
-
-static int close_istream_pack_non_delta(struct odb_read_stream *_st)
-{
-	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
-	if (st->z_state == ODB_PACKED_READ_STREAM_INUSE)
-		git_inflate_end(&st->z);
-	return 0;
-}
-
-static int open_istream_pack_non_delta(struct odb_read_stream **out,
-				       struct object_database *odb,
-				       const struct object_id *oid)
-{
-	struct odb_packed_read_stream *stream;
-	struct pack_window *window = NULL;
-	struct object_info oi = OBJECT_INFO_INIT;
-	enum object_type in_pack_type;
-	unsigned long size;
-
-	oi.sizep = &size;
-
-	if (packfile_store_read_object_info(odb->packfiles, oid, &oi, 0) ||
-	    oi.u.packed.is_delta ||
-	    repo_settings_get_big_file_threshold(odb->repo) >= size)
-		return -1;
-
-	in_pack_type = unpack_object_header(oi.u.packed.pack,
-					    &window,
-					    &oi.u.packed.offset,
-					    &size);
-	unuse_pack(&window);
-	switch (in_pack_type) {
-	default:
-		return -1; /* we do not do deltas for now */
-	case OBJ_COMMIT:
-	case OBJ_TREE:
-	case OBJ_BLOB:
-	case OBJ_TAG:
-		break;
-	}
-
-	CALLOC_ARRAY(stream, 1);
-	stream->base.close = close_istream_pack_non_delta;
-	stream->base.read = read_istream_pack_non_delta;
-	stream->base.type = in_pack_type;
-	stream->base.size = size;
-	stream->z_state = ODB_PACKED_READ_STREAM_UNINITIALIZED;
-	stream->pack = oi.u.packed.pack;
-	stream->pos = oi.u.packed.offset;
-
-	*out = &stream->base;
-
-	return 0;
-}
-
-
 /*****************************************************************
  *
  * In-core stream
@@ -318,7 +184,7 @@ static int istream_source(struct odb_read_stream **out,
 {
 	struct odb_source *source;
 
-	if (!open_istream_pack_non_delta(out, r->objects, oid))
+	if (!packfile_store_read_object_stream(out, r->objects->packfiles, oid))
 		return 0;
 
 	odb_prepare_alternates(r->objects);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

