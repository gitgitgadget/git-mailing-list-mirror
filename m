Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42830C62D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862427; cv=none; b=bvgeeNTxEZW014L8B69bO+4sCsp4bO2oBe7E8J3+0Tc8axv4LIvnFMIo1Fkw45O5PrZNJL9PtBS5yoicupxH0N2oZ2AFOFE6BwPg7uON4qG9g9tRvz8ZbrKIl3AphSLq1rehKarsiADyB6RD8C4X6luLr+KE5iRcBMWhiZMd8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862427; c=relaxed/simple;
	bh=N90xE22SeIToXbA2FyyuEkYVdpxHA7QFvP37x6tdZOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUFL3Zu6AhEnL67YowpIJ4Gguuafs/T8JRDcTC223+gMFC+MTH3CKFii5d5Xw8IiWKDtrDj2spiuI2HkG1YGHHSCNRuJD6KA72W/AF7z+Rdr1lNXdNe1rMfN+1XUaWaYiksRjMWr16yI/jBxac2Ttk07/QTdHavdDC+xx5C83Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDikbM0Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T5Hcst+Q; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDikbM0Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T5Hcst+Q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DBE4EC04F0;
	Mon, 23 Feb 2026 11:00:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 11:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771862425;
	 x=1771948825; bh=lrfMdZa0k38fDCQ481NUAhaK72ohKRpxXOIAS/CNRq8=; b=
	fDikbM0QquUECwXt0LmCWgHug1/0EsjRHcuyBxofO3fFtb5VVmg3fDIKX/mot+YE
	UZR5TyPa0+hw9G69kQ6jno7X2YMpOX0gQ95O/GSUXs5RuG35RyVWqXhO0iM67K9e
	YZ6ib9QiCL/lwJSxyJsSekms7jL3X53WzwPKhJKBAQxrn1r0dp6askMzzi8JOLYq
	CJbmmTGTAx4D/nJCkQqfu/jgMH6asB/a+ITAQdZW+BsS+PAXtgoXoH8ghcwrOBle
	Q0cT0IzyC1k8VpIbU434hoAe6OtyJSibOZ+D7Of3PfiipzbWk/ld1MykusjSDkxz
	uMkGy28M04mvikJP+fYubQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771862425; x=
	1771948825; bh=lrfMdZa0k38fDCQ481NUAhaK72ohKRpxXOIAS/CNRq8=; b=T
	5Hcst+Q5sMKAgmRkk4KGKuYk8Y6kN1P3BVVjv2h3Ajzxpu0W7WuIwbsnzgW4Od/4
	ZQcsK98Hvilb86Gdfuz7LDHEqm4CTaWvqCDQunGVVKz+PERF2Na6p/J8yb05uKGG
	VUZesXSbwAztiU0sqxHQgjU8tEiwUjkhBvr6aHoBKQ1JhrdKSUtQv58Z1u1QNkXi
	sKOObIJBCcmOZPw3NWeuMEuBFEcErwQN0jAszpG79NJ+EdFXuTenk6hL0wmq+vzA
	WW5k1TCOt4wG+a1wyo6gGGd3rrq/lgA38DFTUceSvSU3SHsNruU5bT4A1y4XEdJ6
	N8mHpYam6Fjr6yXCz5O7A==
X-ME-Sender: <xms:mXmcaakE4QfJPSsyTyyZ4r_o5EyH9DdHTAiuUyRo3DEkdN7S-cxLSg>
    <xme:mXmcaYu493lziJYBrUd2yI5jikSxBtt6rRjfEMQMU7DJ0gGCz14LR681_hrvTcvhw
    RcaOMRxX968rD6ubRzZ759wFt9-bhsVbuZRGpFVR5c1KpdD3AB3>
X-ME-Received: <xmr:mXmcaQ8IfctdWoDKFmiZzzUDUMw4t77YrLoeMDdZk68d0tIlv94NezqtKQYu0ak7fB0xNpCtRu-JvPkZgHhhCN9622Cm4oU2CVgxThbYAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:mXmcaaMS7-5yu-VIePTs3pASWCxGW55kDr5LHS7TkmLUoP5raO-HUg>
    <xmx:mXmcaWEe40M4NxO1SI_Zha0kfcRP9exTOjPY0nTbDEGxAus4xbcSVQ>
    <xmx:mXmcaQRvZxiKpcWRWcl2Tmesxy07ZLNVNY2LPHbPFnSHqmXf40TGsg>
    <xmx:mXmcabsksXerQ43zIePM0-vUZvM6yCdsllSd7xiIJXkJgPRmmZ16xg>
    <xmx:mXmcaQXDptzixyqN35Jy2Tqym789jT_QJZI1-pvlGrp2FfietlsbslVT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:00:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aada980d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 16:00:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:00:08 +0100
Subject: [PATCH v2 3/4] packfile: expose function to read object stream for
 an offset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v2-3-99a0714ea3bd@pks.im>
References: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Eric Sunshine <sunshine@sunshineco.com>
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
 packfile.c | 40 ++++++++++++++++++++++++----------------
 packfile.h |  5 +++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/packfile.c b/packfile.c
index 402c3b5dc7..3e61176128 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2553,32 +2553,28 @@ static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 	return 0;
 }
 
-int packfile_store_read_object_stream(struct odb_read_stream **out,
-				      struct packfile_store *store,
-				      const struct object_id *oid)
+int packfile_read_object_stream(struct odb_read_stream **out,
+				const struct object_id *oid,
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
+	case OBJ_BAD:
+		mark_bad_packed_object(pack, oid);
+		return -1;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
@@ -2592,10 +2588,22 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
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
+	return packfile_read_object_stream(out, oid, e.p, e.offset);
+}
diff --git a/packfile.h b/packfile.h
index acc5c55ad5..b9f5f1c18c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -436,6 +436,11 @@ off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
 		     off_t delta_obj_offset);
 
+int packfile_read_object_stream(struct odb_read_stream **out,
+				const struct object_id *oid,
+				struct packed_git *pack,
+				off_t offset);
+
 void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */

-- 
2.53.0.536.g309c995771.dirty

