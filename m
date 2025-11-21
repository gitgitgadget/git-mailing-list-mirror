Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A693385BE
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710924; cv=none; b=qm3XJOm/7cNhvG7viDPM4EM1Rkc2EA6mCuCNXTZpIOkzRYJbWamQ68v9sLSCKVROezX8JBRD+okzJ5MR3iuYeyj6DCCJ/jkHZyRHL3PggQ0/LyUssto0p0+g7N0oT/U15qkyfgkR9lJpCvPs/JshG7yg0pjhkQMQackFG5WVQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710924; c=relaxed/simple;
	bh=T9kYzF4MInnXHdu6+G4/jK70yJp2sIJyJ1OjlpReg0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9/PPTiaTPrzRUKvQYNqnhriwko1uu7JlLWXXAAwX0aN49jOWr/SB/k7ktqCkkOUizrUKhLHSUC+ypE/u6kyFPj0swRZI/QkL5btjC2R1OPyq8OD9ezwywabEjXAj9ir/C9JAAyXPWqakJW2wrCWo4MZ2qIwgdWJ7LxOznZ2eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DPcMmtYf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xiPnSjqE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DPcMmtYf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xiPnSjqE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 701C61D0015F;
	Fri, 21 Nov 2025 02:42:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 02:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710922;
	 x=1763797322; bh=RtRyuChDK1+yuM/dyvpAibZiN9DdihrpzbDZ6V8hXf4=; b=
	DPcMmtYfnYNJJdaOzo10oFIG3NEimPw/XZhfckg9YZlmsiWwVrtcPnMX6t7vdpZr
	1Ec8b4F3gBpHFaFeIW/tmNCZRFARCgyi1wlE08WX7ySCVVd6o8QTjZJ1LVcLH933
	ECs7Ix4XRGhqdwG33uQfyj3sZfVnhW+xzEaZ+yt5FcKfcT3g0Y8UBaVCOgk4hq6h
	orw/TuIkXXJ5gpMOM056D3NAP8R+TEVtqV1/X2z11I0HinHOaakJLhjlerM7McaN
	fwMokCE+mMPngk9RabuYc7lJNnn0m3CHt3SZQbkD8K2VTZ5Lzu5SGGSseocXt60D
	TyUaknYHTbPKmX6gaxeXpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710922; x=
	1763797322; bh=RtRyuChDK1+yuM/dyvpAibZiN9DdihrpzbDZ6V8hXf4=; b=x
	iPnSjqEqTyO8OgU/yWbmqzTBheN0uwJ0ZVM41Gs6D0+/APAqgEEz5nv4gDaMYELI
	24TC4kZT69hdDautvQxmrrDfuppfnyK1IbD/IzHOGcVf053idkc2nSnaZMoBbMS/
	oaoeeB66EThB2qta+DVsgiwy3ruT6iAhf7yc+WpmkmMYds9pAvu13MzdeLxv993M
	HvasAwXV3UxReGPQRIzlazpL+rZHorZOsVkVYZjY73wnNjmiHVfuOSH9+JNOpb9n
	ks1YQgQmwLLXniTkrJBtEGGmCsWbh9DF9rAs1WTl1mLZa/vuolLY3JZhTcwv/AKz
	bPDpfBpO4/pnIGduBPL+Q==
X-ME-Sender: <xms:yhcgac6AENM_pzRKVdS4c9I6-RqfrjnmPcSvWonGkqdt7d2cJWYWUQ>
    <xme:yhcgaVXjecU28n2imYawyhNV0ZQWn1EzhyJpyS_GbR8sT9AOiGaWd9jOHGULsHfDU
    cBjNwD-JK2WYkluM3mL1u6hFNk8rkH77OE_Y4dysFMc6g9DWxVU>
X-ME-Received: <xmr:yhcgaY0x_hO7kY27zxWhglYA2mF_DX13Rd_ZxnBYN0tjcnkzfFs2XnlnDCxuaMSXMx7dBLR5K5olHrXvz3NysLOpQnw6ub9_rBcjP0ZZipWa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yhcgaa1KhsBE_NAA7mf36NKDeWlkojAWX_l3WU2fJSJG-TnXTM1KUQ>
    <xmx:yhcgaT-1IuijKaXlh-ZydBgHNus1Zp6zEm2Vr5B9BUtwczupn8PwUg>
    <xmx:yhcgaf1GQ8gNhFB5vuZ-W0djJIqiONW_DNoGkwmQ37b-KNzpTFKWqA>
    <xmx:yhcgaY-Re_vzjRiCoE_uXSedLz8lqxAp2ctXfyxxalVKKG8Ur-aLEA>
    <xmx:yhcgaewode-E_xrOmDirjtw7nRUoAQJJokXnrSpnwhbtf0W4vReaSoMh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:42:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d7699ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:42:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:41:01 +0100
Subject: [PATCH v2 16/19] streaming: move logic to read packed objects
 streams into backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-16-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
index cc67d56cd4..3d80ddd757 100644
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

