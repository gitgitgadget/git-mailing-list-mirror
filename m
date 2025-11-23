Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64962255E34
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924442; cv=none; b=hcuy5gLVezeuY6zf18UWG/nOhPf0zuTwZW153RIgnIQZzDxAJlk/NkdTwM4N+xrfcFhIyNcuM0WmJ+LHDMPWci8IOlL95A0io5dfKqFmwAE62qoSznCT45LFBKBB5zg9etoM2I0bQ7bum0CLBszuk+WlGZq0drBtFCPmyQsiHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924442; c=relaxed/simple;
	bh=2o81X5kkLMO0BOVOCSjIvDf6jYX80HgvlhAKw6v95J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvQcb1iauIERXDHusp/hJCqntOmHwJVwB5kBTC/ye+i6HbQY+OG3u75LtK1jCscfFssqBd1Z68m3iLJAJYmsafXSnwMIfsxLsr8FUKnXlWNxGwxSpS1uKfZSBmcA0SvrdjvmMT958l/WjBjs3X5BaHxi21IZi8wC6viAaOCyDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mU1cdglq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrOrNjtx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mU1cdglq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrOrNjtx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 946C97A0091;
	Sun, 23 Nov 2025 14:00:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 23 Nov 2025 14:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924439;
	 x=1764010839; bh=lI0ubYwOdVQOrJ/rksGwYn7mgNXx6nsYT7U81o7xBJw=; b=
	mU1cdglqF4jsUF9mkjGBShjP6U9+STwCgZMQ1bMqYbDnC6MfYLhmf0zNqN+pBq2V
	oimkTkJCBkbyDxz0ARfZ9WTMX6XECzu3woIBCzy1WbWdgXPB4GaAn/5Nde172R/4
	E/OjMCaED4dSDorFFrBc/iAdS7aU+4FgXNmGoOPXetD14zNwEbjcHfLCnr5aqgAS
	rzbuM2XVDJj2xvXodiyseR6f5/PM1o2tBiRiY6aIyinkta1ViQSh3UIfO35Q9i/C
	UvGRT2wfzPYfWp34maVP9V5s7kppnBorQF/QbZ6eVQEryqp8QOJlK0H1D2Gkb3aR
	VPFy+VHEiIYJbaFh4kTX/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924439; x=
	1764010839; bh=lI0ubYwOdVQOrJ/rksGwYn7mgNXx6nsYT7U81o7xBJw=; b=P
	rOrNjtxhC6T5OV/BRkfPeig3WHUJsVF+1FiK4Szk+p/uih3Up/PZpTPm+CPoI++q
	f0ojyeKqflibCyZftSf2BOTZAOajgG6+y6WIazLDw5m5KOTLbdTRbTL/I7aXSzaf
	y1mtJg2KNIiwnoL1A3KpEAf/8w/Q4Bft4IhZbElIWkb2cKTOPCYXjJTlVQYaACGl
	B803r7dkV7T46/KFQNw3S39UrMHKPdJOqS8RQboBFpbIgzKSvDo9UjRAsTyeDnAb
	4+y8u4iqdQKap8Y72SuqJgBaw4VgNbvtMUHCyNyeOEXc+2t0lZGsxWMDu9R0k1Re
	PItbuYJtafflsTGUqGlYg==
X-ME-Sender: <xms:11kjaTWAm6HjOGP6hELgD69Abxv6STfdl0CGFgfbOyBHeJ6JDeW7wA>
    <xme:11kjaSn1bw7nJIFL52Tb3Rnq8sGEtuY5t70xfMH5Qe2fnvTYiDMyYEYXX58VggPZ4
    00K3zPFzubHjoxKeyBaSdq6aSTMllA1nvNMq4zgimEQepCqBVZ3pw>
X-ME-Received: <xmr:11kjaUZGpLkDz-a__dOrTqdZfxrUIcB1-9DRUSOt55KF4lYW1wUfXiyslS9q2RUm48g5djmJg5Xt-espNDo5NK8ieuLT_o__OHYJ5ysVRS2x3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:11kjadPdvPc9Q5R9VrQzJZ_WdqOm7unHItq7nDlVYDPjIZwL2Q6i9w>
    <xmx:11kjaZY6e1CdK7vrpyzTSlv6AfxoIh2kAJ1YXWc1EuvrM_1KC3bdbg>
    <xmx:11kjab0D-V_c29QB-qrcSGxiJRyG_drk38-5ymhvTmmHHeQqD1es9A>
    <xmx:11kjafd4iXb5bX8zMM6C7s8msxH78-rgC9YHn4mO_ul0ic8W-mXixw>
    <xmx:11kjaf6__fN96rNJgJrOJJGRrmy2Y-BJyvC23rvUL9ArQk9qvMVTqGEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d49b3120 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:41 +0100
Subject: [PATCH v3 16/19] streaming: move logic to read packed objects
 streams into backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-16-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index d5acc1c396..3140728a70 100644
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
@@ -319,7 +185,7 @@ static int istream_source(struct odb_read_stream **out,
 {
 	struct odb_source *source;
 
-	if (!open_istream_pack_non_delta(out, r->objects, oid))
+	if (!packfile_store_read_object_stream(out, r->objects->packfiles, oid))
 		return 0;
 
 	odb_prepare_alternates(r->objects);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

