Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C43502B8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840255; cv=none; b=O7WKpy6MCxlAZkRThkpGSTr9ONm4/e56k93EoqlkmkzejOg4PzbKOYufI2N4j7kNQduaq5iW5gTKk76vZl6eQkv6kihJg3y2+LMvWFjmrBSqW2XLwJXZbmwn72eVLruPiI87j4VEd1f5ogtN5OgmtHL0LXrcD1AR0xmdqXL5jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840255; c=relaxed/simple;
	bh=SHed/q8SYwjR6Z3ZX1e7HF4auF80x5mSgqTqKNdJy38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hmz01VD/bJ6MkMTzevZb7wDdMMaiW4EE2T1LLCC/mK9muXAXlJkV5Jqx4YvAMTUXaXNiLG7cBORVJlAoE2DpTEXeeYba1EyVzA6Kl4SyZhln0q/S52aE0oCA1UAxIGH4anCkJdiQiOQ5tc6pzKL2JJi6VrvUQhqNQ48mU3bFvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e2QH50IF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iV5qPoLs; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e2QH50IF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iV5qPoLs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5395814001B8;
	Mon, 23 Feb 2026 04:50:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 04:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771840253;
	 x=1771926653; bh=avmarYO2Cj9u0RJaSQ7zuVy6xAxyvqfMP0/aipg0xPc=; b=
	e2QH50IFONO5nUeIzd+yj6LpDUZojix2gowAeFXULfKIUZDuVYjM7IET3DUFd2Sr
	tqkpTRISP/AqVLpwykVkN07GTsJakE9mFVJM7ZHTuTTFN1FjnAxoMq3gmgdm6cqw
	oZEIR063U49DVq6gMtjt1q7C0TGfY5B3fgAts1MilfUzkm1x2AJn3QjnLQpzySYQ
	9d13Wie9G+CqjJgmGBRDBytRfgnU1T5QT9XRkbTaFmpvj1jmwVM1f/mMMH13/Ipz
	nulJ9yK9HL0J3+9ZZPJ9NEgDwl/A9f2Io2hb2cvG4rH1+1xABM/JrnjLUCBDkMfQ
	pik4+WAIqRt0H6Ju9pzoRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771840253; x=
	1771926653; bh=avmarYO2Cj9u0RJaSQ7zuVy6xAxyvqfMP0/aipg0xPc=; b=i
	V5qPoLsrwRq4Vy1aLmDZEYebwVXK7nGsywes1akUURDE++coD9leeJQVsxffi5wP
	EpurzmVwEjQwPdJn343i4lHJ78tOslTYChlsWR2fPxWntwLv8jUvJ9h4NybahzA+
	Iep3OYkpYtute4ga2mT2GMEQX9aLjl2FLz87x95F8gvK9uIb8Ao6dK5rHXazTD4W
	OAlMByu5PdHdON69kl74xXUXFxGCDc8A76gZJmBwK+1sw50pu3e6CzdICcQrpaVl
	pyyTX+rlNuvLoaJW8WB7QteHJWcU+MADyJF2ms/6A0/xGqcX+dPeOwo7EHco5mxh
	4OinDpqaYDr8wwcCxv5og==
X-ME-Sender: <xms:_SKcaURID2uv0fu6qCIyhH0dw4xYQHQGDHteEFrvUN2rEsVGUTdy6g>
    <xme:_SKcaYydTUp8AvckQVwQYaHQ_De9-d66FOrb55cH5p1aZa_ilbczD_CCepbyOrFP5
    n1Nj6NHc3WYRIzzqGdM9HzAGaJmPeG6LaGF5MVbxlicoUJ3e2Qj>
X-ME-Received: <xmr:_SKcaW3qkXE_VGiFKH62p7XxBWEGSAze_BjF5-op9vIs1rw2lhoakhfUpMI-EoVOO9x2EcaSC8n4ZpueiZKzMonS4k70UHC87m14t9WIjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:_SKcaW7MWu-IOK7nnhB_EswUFbHzCP9P5HkA0Bj8j-8nvQ8FxKbs9A>
    <xmx:_SKcaZUU_QMXr7NLoli74psGazfviN3S0gNHZ4McstsT_WK6GfS2jw>
    <xmx:_SKcaVDvMZFgTyDOSZMQ0OvgFvg7vuifN2gFDwME8KA_TqMCUskJIA>
    <xmx:_SKcaY7Y7zQv7pv6HinRPxp2PxxBDWMY6RILeRCGykkkbXiYevqd9Q>
    <xmx:_SKcaZVMg2Rpa_AcwkGSTTGcmqKjUdKuSveL8lm5NyunRUP3yltWb1M_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:50:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbedcd60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:50:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 10:50:41 +0100
Subject: [PATCH 2/4] object-file: adapt `stream_object_signature()` to take
 a stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v1-2-c29036832b6e@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The function `stream_object_signature()` is responsible for verifying
whether the given object ID matches the actual hash of the object's
contents. In contrast to `check_object_signature()` it does so in a
streaming fashion so that we don't have to load the full object into
memory.

In a subsequent commit we'll want to adapt one of its callsites to pass
a preconstructed stream. Prepare for this by accepting a stream as input
that the caller needs to assemble.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 10 +++-------
 object-file.h |  4 +++-
 object.c      | 15 ++++++++++++---
 pack-check.c  | 12 +++++++++---
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1b62996ef0..ca2c4dddf3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -129,18 +129,15 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-int stream_object_signature(struct repository *r, const struct object_id *oid)
+int stream_object_signature(struct repository *r,
+			    struct odb_read_stream *st,
+			    const struct object_id *oid)
 {
 	struct object_id real_oid;
-	struct odb_read_stream *st;
 	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	st = odb_read_stream_open(r->objects, oid, NULL);
-	if (!st)
-		return -1;
-
 	/* Generate the header */
 	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
 
@@ -160,7 +157,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 		git_hash_update(&c, buf, readlen);
 	}
 	git_hash_final_oid(&real_oid, &c);
-	odb_read_stream_close(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
diff --git a/object-file.h b/object-file.h
index a62d0de394..733d232309 100644
--- a/object-file.h
+++ b/object-file.h
@@ -164,7 +164,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  * Try reading the object named with "oid" using
  * the streaming interface and rehash it to do the same.
  */
-int stream_object_signature(struct repository *r, const struct object_id *oid);
+int stream_object_signature(struct repository *r,
+			    struct odb_read_stream *stream,
+			    const struct object_id *oid);
 
 enum finalize_object_file_flags {
 	FOF_SKIP_COLLISION_CHECK = 1,
diff --git a/object.c b/object.c
index 4669b8d65e..56d79d77b4 100644
--- a/object.c
+++ b/object.c
@@ -6,6 +6,7 @@
 #include "object.h"
 #include "replace-object.h"
 #include "object-file.h"
+#include "odb/streaming.h"
 #include "blob.h"
 #include "statinfo.h"
 #include "tree.h"
@@ -330,9 +331,17 @@ struct object *parse_object_with_flags(struct repository *r,
 
 	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
-		if (!skip_hash && stream_object_signature(r, repl) < 0) {
-			error(_("hash mismatch %s"), oid_to_hex(oid));
-			return NULL;
+		if (!skip_hash) {
+			struct odb_read_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
+			if (!stream || stream_object_signature(r, stream, repl) < 0) {
+				error(_("hash mismatch %s"), oid_to_hex(oid));
+				if (stream)
+					odb_read_stream_close(stream);
+				return NULL;
+			}
+
+			if (stream)
+				odb_read_stream_close(stream);
 		}
 		parse_blob_buffer(lookup_blob(r, oid));
 		return lookup_object(r, oid);
diff --git a/pack-check.c b/pack-check.c
index 67cb2cf72f..46782a29d5 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -9,6 +9,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 
 struct idx_entry {
 	off_t                offset;
@@ -104,6 +105,7 @@ static int verify_packfile(struct repository *r,
 	QSORT(entries, nr_objects, compare_entries);
 
 	for (i = 0; i < nr_objects; i++) {
+		struct odb_read_stream *stream = NULL;
 		void *data;
 		struct object_id oid;
 		enum object_type type;
@@ -152,7 +154,9 @@ static int verify_packfile(struct repository *r,
 							type) < 0)
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
-		else if (!data && stream_object_signature(r, &oid) < 0)
+		else if (!data &&
+			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
+			  stream_object_signature(r, stream, &oid) < 0))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
@@ -163,12 +167,14 @@ static int verify_packfile(struct repository *r,
 		}
 		if (((base_count + i) & 1023) == 0)
 			display_progress(progress, base_count + i);
-		free(data);
 
+		if (stream)
+			odb_read_stream_close(stream);
+		free(data);
 	}
+
 	display_progress(progress, base_count + i);
 	free(entries);
-
 	return err;
 }
 

-- 
2.53.0.414.gf7e9f6c205.dirty

