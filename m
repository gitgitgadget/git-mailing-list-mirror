Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B58352C39
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840257; cv=none; b=YT1YIiJILQ3HdvAVxQIUkaQHIaIhj/k1z/DxjTQUWStrouZUy+DK29hQM2Mh8AOwrJa5p/1c0MZtJAD21y0VlLLhRqUnUo07p2arpbm+N7zCawuw/87Ww5EoHjnFuE2ViSdI7lYac2hO3LhnP850UgXkZX6MD3LB3oUZdXYC6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840257; c=relaxed/simple;
	bh=W35+LUduKI7wZDxgnhOJANbaMTHFHk+XIGYxGQsFslU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7RSBeVmEQ2volFi87DLQonjq24JKTNcTcVMA/evRrG96n3Qo/Bv28viYrARQ9FC3q0BWG5F714//BrMvf1yRqDMChX//cjZTb/mQR5NbaEH8hQPql7w3L8KrIVCskGt482jPAlTc9KztIeMHnZlQeppSKcKDwHPeQF36huArfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BxVCfGTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OsViYdLC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BxVCfGTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsViYdLC"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 718F5EC05E5;
	Mon, 23 Feb 2026 04:50:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 04:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771840255;
	 x=1771926655; bh=96XfvrEsFkE9+e6ZfSYKm3qLVpBE79obZk/YVUy4ItA=; b=
	BxVCfGTjNGY1DXQy6iUKd6FZFRJwZFqRrs3ntm7iydPlJ2hMq5TGX37v+QQZLXwU
	HNh85mEW/WIgk1skZRX7N+uCDCMxolkV4sF4+VEJdg2xk6EiL51Gigi53Gy0mv44
	Gf3RwW/83CI0aWdnoIyyVesha6wF5DVbaj7GwBeAMr9/vs8RT9xvYhgZ6mr6S9yK
	4EZvzQnuSbAJHcDfLK+CzZQLMwmdkXhnqEiz6rEhnKEGUBS1qKSETOvzTNU+W0oR
	0P0t9V414dKQB6uTO+E6Sz1RmKG0+L5VAQMLBT2NM1IslWc/DFD5IdQ3mU6ewl1v
	+QECwVx3CcNfkqnDkfPgSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771840255; x=
	1771926655; bh=96XfvrEsFkE9+e6ZfSYKm3qLVpBE79obZk/YVUy4ItA=; b=O
	sViYdLCC3Et0eCXKiqOCY9lEhrmOTeyfzJaHch7ur28uP8VhTk1t5RDHPDyDtc6g
	SP7Da0iQ4GZci4h6oM35oM6JpJL6EQMlVyFlW531QjiiG6ejy1X9aRxnM3glvRrh
	qnX4rOL+wi5qtWVqCHIMsS3NsbQ1NUPbgaIxuT5nYvsZ5cxwK9jHHadbuBQo2QyK
	TJByxX+c/PtudgB/AMwuClVHJPTxiqXHo5HEpBfowHKXjHYtQ/T06UyM02tgoiXy
	YIDEnfNfyH7kP9Bl4mED9NO75DDvKynkVChBROHwvSMPI3dicJFqZPsSH1W0KWS2
	2Xu+VlQK3UbbFjiF3K/oA==
X-ME-Sender: <xms:_yKcaYR4LKkyudehqZY4_985Suwm8pQxZ3OnymmDKY2l-_8o7cSDNw>
    <xme:_yKcacyoFPFXaOzrnFeEa055A5CAw9FLhJlzov4P-ZCBmc0h9XJ3rgYxUzCK-D7bx
    EP2YR_QAPNebwIWK-BjkzILiHDnNvygSjIo7agVEqXowhm74x9-uE4>
X-ME-Received: <xmr:_yKcaa00bScWhFhiKMz73RHGih_UgEc0Xmtttr9CdR7tdhCY-5E4W3cgH1Qka5ATeXP7Ku16uIDSAjkWld5fTk-uChIoTs9f8TomfcV2yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_yKcaa7pblXIs5vAA3EIf8zH6W6IDsJI_PU3AXJtWI-rpcZnWC92zw>
    <xmx:_yKcadUI1QP9ImdO2A1ptLCtj-FT7qjdsP1zObEv0zhQncrAg43ylg>
    <xmx:_yKcaZBuljAFuoV2MhmOL7KcYP_3w4SSFyuE5VCOy-_8u9vlpV2H6A>
    <xmx:_yKcac6GDSzKoOmxiQrwcb0Tw4-Hgb4bZUQfEEA4w3juwupRd9XuFg>
    <xmx:_yKcadUscuQ0nw47ISLeSWUKrji66XrUH6EbR7cnxprmaJCZmMYaH8-V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:50:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fceff7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:50:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 10:50:42 +0100
Subject: [PATCH 3/4] packfile: expose function to read object stream for an
 offset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v1-3-c29036832b6e@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The function `packfile_store_read_object_stream()` takes as input an
object ID and then constructs a `struct odb_read_stream` from it. In a
subsequent commit we'll want to create an object stream for a given
combination of packfile and offset though, which is not something that
can currently be done.

Extract a new function `packfile_read_object_stream()` that makes this
functionality available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 36 ++++++++++++++++++++----------------
 packfile.h |  4 ++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/packfile.c b/packfile.c
index 402c3b5dc7..9d795a671f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2553,29 +2553,21 @@ static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 	return 0;
 }
 
-int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct packfile_store *store,
-				      const struct object_id *oid)
+int packfile_read_object_stream(struct odb_read_stream **out,
+				struct packed_git *pack,
+				off_t offset)
 {
 	struct odb_packed_read_stream *stream;
 	struct pack_window *window = NULL;
-	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type in_pack_type;
 	unsigned long size;
 
-	oi.sizep = &size;
+	in_pack_type = unpack_object_header(pack, &window, &offset, &size);
+	unuse_pack(&window);
 
-	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
-	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
-	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
+	if (repo_settings_get_big_file_threshold(pack->repo) >= size)
 		return -1;
 
-	in_pack_type = unpack_object_header(oi.u.packed.pack,
-					    &window,
-					    &oi.u.packed.offset,
-					    &size);
-	unuse_pack(&window);
 	switch (in_pack_type) {
 	default:
 		return -1; /* we do not do deltas for now */
@@ -2592,10 +2584,22 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	stream->base.type = in_pack_type;
 	stream->base.size = size;
 	stream->z_state = ODB_PACKED_READ_STREAM_UNINITIALIZED;
-	stream->pack = oi.u.packed.pack;
-	stream->pos = oi.u.packed.offset;
+	stream->pack = pack;
+	stream->pos = offset;
 
 	*out = &stream->base;
 
 	return 0;
 }
+
+int packfile_store_read_object_stream(struct odb_read_stream **out,
+				      struct packfile_store *store,
+				      const struct object_id *oid)
+{
+	struct pack_entry e;
+
+	if (!find_pack_entry(store, oid, &e))
+		return -1;
+
+	return packfile_read_object_stream(out, e.p, e.offset);
+}
diff --git a/packfile.h b/packfile.h
index acc5c55ad5..67d5750140 100644
--- a/packfile.h
+++ b/packfile.h
@@ -436,6 +436,10 @@ off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
 		     off_t delta_obj_offset);
 
+int packfile_read_object_stream(struct odb_read_stream **out,
+				struct packed_git *pack,
+				off_t offset);
+
 void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */

-- 
2.53.0.414.gf7e9f6c205.dirty

