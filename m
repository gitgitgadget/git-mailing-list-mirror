Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694742C15BE
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155767; cv=none; b=Gp96VbnaB3mWHUBrv1zpxW+XRLQsJbYgC2VBbFPD6KkQ2DMkiJCQ/5PXZaErAlqH5hieovEyPY0utkv/oAZUZ8l5fmlBr1q8/82vvIzMue7QmeLXUIpQ2eGHYuYFoKiBSx25ElX077CpZ9aQxfE/pqBHW6pF55v0E4a9UX2D2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155767; c=relaxed/simple;
	bh=My5Mh3irctLbM/kEFsxyWx+PyydqgUY/TSULhhSUaJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKLOBe509wcZ5fQH4yr2kXxHiZy3l1taXlZD9UfkoeGS/TGJQNvehrsNTSqbDyY0dBRignatPX2iS5wJlBwX3fws240FAXS31kLgxjPh+qboLam4x9G5ySTpPf9//gZGNf9KQnZsgbALlAprZoyizsUkqRGakBHIua/q9W8yIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lsaTKzUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4TyQFHp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lsaTKzUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4TyQFHp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F5281D00171;
	Mon,  3 Nov 2025 02:42:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 02:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155764;
	 x=1762242164; bh=zko55+HDLlffUZYtCv305WUxxQdbOtiIUU/YKztU3Io=; b=
	lsaTKzUgF/GZQOcCa0bqHOQ7wUsKtUmPOsV74DYrm6LcvVpKW0B0ChxJ+tF5zTgo
	C9+oHMF3mRjfzVRVMq96oH+swFxGs7NKadYrY15ppsKTajQkYG2xVWVTGVuop00F
	wswndyWeuL0t4YxmROU1/9aHtcsBMwFsCMvZ/L/Fn8Bq7vXUih3V/yz+qGjmMx83
	N25tui2DrxlfsVX2cTWtd5KxfnTZHI8yaa2RHCu9Hhemt2gq8Mr9HV/1IC+KauuF
	yjbbanX2X23pCUjsP6dy+BBO/yz9tyRL4cqB8wTHuIWMt55gfB52aGRd6PaeCTDR
	b7xd4wf3clDXuqMY1vpuRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155764; x=
	1762242164; bh=zko55+HDLlffUZYtCv305WUxxQdbOtiIUU/YKztU3Io=; b=o
	4TyQFHpt//KG9MjGm0U3BC0+VCaiI0Oe8f+sqVv/ZByPSamHpTtdu1uFSVLKg6QA
	NvUcdnEVAkSaVDMmIU9/3bXkYUerOVzguxFYnXoiUX1oihWytgyUw3RLx76N15Hc
	7N3yRxF2R7tCNuYWTZ1+rktaeVfrgLVYRLMF3e99nmHXh2+Bxee26/GRpGwCAQUc
	Rct0cbVvBDvTX7UsCml116mOg2hNGRTk6Ebj4NNajASYsYtf9LKL9Rxd/PpzclX2
	lg+4+vuqm5lgx5dmUw5K/K232UIIid9alffa4hfuBaVMlzrJUZwyHaeNQY22jDQi
	YAo79tGIfzqUhwFzxheQw==
X-ME-Sender: <xms:9FwIaUJdVylrV5cAR9jgf8zTJUEcYLwG43yrt6b17hqp-PMlBeoELA>
    <xme:9FwIabn4pf5cko8o6v4QqB089MP0HyfAG5prOFORIAWorSMSHx-xac8jtuvSXZTTl
    g00lS_oGzAECwtuYhqUGrsPWeuLNq9HH699vrJ6ebnf2g83u5q_Dg>
X-ME-Received: <xmr:9FwIaSElK3chZPMi2vGmUZl_qRsgvwQg7m7sPKehRfYhB2exLvPTO13vqqiCIbNxYNAgie_w1zcjXCM-FiFjWOD9GyunuRRtC1Q0j4UoGtRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:9FwIabH48EEfGvu-qQasZHax-1utbLBcIvC_mgpPJRoes3Tb8Q6v4Q>
    <xmx:9FwIafNklr6FnxgfN9kBSSPq9Wh9cR0pkLa9h_9LOmvJ4tTwstcnDA>
    <xmx:9FwIaaHOUBnhSlFhWrSwUTgQVs7jreJiuHKkhyjD5ZkCx2Iel9-_dA>
    <xmx:9FwIaWOqS-mbfHikSsI3MBXvGHZhpK5HNWV5HKT5XHe4qwG0TEHRrQ>
    <xmx:9FwIaevskwPSQ0_mgANf323QVir9PmQJh4BfTpgYxzymbHRN-LrKbC6B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id afb54270 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:06 +0100
Subject: [PATCH v3 11/13] object-file: refactor freshening of objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-11-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When writing an object that already exists in our object database we
skip the write and instead only update mtimes of the object, either in
its packed or loose object format. This logic is wholly contained in
"object-file.c", but that file is really only concerned with loose
objects. So it does not really make sense that it also contains the
logic to freshen a packed object.

Introduce a new `odb_freshen_object()` function that sits on the object
database level and two functions `packfile_store_freshen_object()` and
`odb_source_loose_freshen_object()`. Like this, the format-specific
functions can be part of their respective subsystems, while the backend
agnostic function to freshen an object sits at the object database
layer.

Note that this change also moves the logic that iterates through object
sources from the object source layer into the object database layer.
This change is intentional: object sources should ideally only have to
worry about themselves, and coordination of different sources should be
handled on the object database level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 33 +++++----------------------------
 object-file.h |  3 +++
 odb.c         | 16 ++++++++++++++++
 odb.h         |  3 +++
 packfile.c    | 16 ++++++++++++++++
 packfile.h    |  3 +++
 6 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index 79e7ab8d2e3..893c32adcdd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -968,30 +968,10 @@ static int write_loose_object(struct odb_source *source,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-static int freshen_loose_object(struct object_database *odb,
-				const struct object_id *oid)
+int odb_source_loose_freshen_object(struct odb_source *source,
+				    const struct object_id *oid)
 {
-	odb_prepare_alternates(odb);
-	for (struct odb_source *source = odb->sources; source; source = source->next)
-		if (check_and_freshen_source(source, oid, 1))
-			return 1;
-	return 0;
-}
-
-static int freshen_packed_object(struct object_database *odb,
-				 const struct object_id *oid)
-{
-	struct pack_entry e;
-	if (!find_pack_entry(odb->repo, oid, &e))
-		return 0;
-	if (e.p->is_cruft)
-		return 0;
-	if (e.p->freshened)
-		return 1;
-	if (!freshen_file(e.p->pack_name))
-		return 0;
-	e.p->freshened = 1;
-	return 1;
+	return !!check_and_freshen_source(source, oid, 1);
 }
 
 int stream_loose_object(struct odb_source *source,
@@ -1073,12 +1053,10 @@ int stream_loose_object(struct odb_source *source,
 		die(_("deflateEnd on stream object failed (%d)"), ret);
 	close_loose_object(source, fd, tmp_file.buf);
 
-	if (freshen_packed_object(source->odb, oid) ||
-	    freshen_loose_object(source->odb, oid)) {
+	if (odb_freshen_object(source->odb, oid)) {
 		unlink_or_warn(tmp_file.buf);
 		goto cleanup;
 	}
-
 	odb_loose_path(source, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
@@ -1137,8 +1115,7 @@ int write_object_file(struct odb_source *source,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (freshen_packed_object(source->odb, oid) ||
-	    freshen_loose_object(source->odb, oid))
+	if (odb_freshen_object(source->odb, oid))
 		return 0;
 	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
diff --git a/object-file.h b/object-file.h
index 065a44bb8a0..ee5b24cec66 100644
--- a/object-file.h
+++ b/object-file.h
@@ -59,6 +59,9 @@ void *odb_source_loose_map_object(struct odb_source *source,
 int odb_source_loose_has_object(struct odb_source *source,
 				const struct object_id *oid);
 
+int odb_source_loose_freshen_object(struct odb_source *source,
+				    const struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/odb.c b/odb.c
index 4c0b4fdcd54..17734bdaffe 100644
--- a/odb.c
+++ b/odb.c
@@ -987,6 +987,22 @@ int odb_has_object(struct object_database *odb, const struct object_id *oid,
 	return odb_read_object_info_extended(odb, oid, NULL, object_info_flags) >= 0;
 }
 
+int odb_freshen_object(struct object_database *odb,
+		       const struct object_id *oid)
+{
+	struct odb_source *source;
+
+	if (packfile_store_freshen_object(odb->packfiles, oid))
+		return 1;
+
+	odb_prepare_alternates(odb);
+	for (source = odb->sources; source; source = source->next)
+		if (odb_source_loose_freshen_object(source, oid))
+			return 1;
+
+	return 0;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index f9a3137a34a..2653247e0cc 100644
--- a/odb.h
+++ b/odb.h
@@ -396,6 +396,9 @@ int odb_has_object(struct object_database *odb,
 		   const struct object_id *oid,
 		   unsigned flags);
 
+int odb_freshen_object(struct object_database *odb,
+		       const struct object_id *oid);
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect);
 
diff --git a/packfile.c b/packfile.c
index 5a7caec2925..2ab49a0beb1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -819,6 +819,22 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 	return p;
 }
 
+int packfile_store_freshen_object(struct packfile_store *store,
+				  const struct object_id *oid)
+{
+	struct pack_entry e;
+	if (!find_pack_entry(store->odb->repo, oid, &e))
+		return 0;
+	if (e.p->is_cruft)
+		return 0;
+	if (e.p->freshened)
+		return 1;
+	if (utime(e.p->pack_name, NULL))
+		return 0;
+	e.p->freshened = 1;
+	return 1;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
diff --git a/packfile.h b/packfile.h
index e7a5792b6cf..0ad080046f1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -161,6 +161,9 @@ struct list_head *packfile_store_get_packs_mru(struct packfile_store *store);
 struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 					    const char *idx_path, int local);
 
+int packfile_store_freshen_object(struct packfile_store *store,
+				  const struct object_id *oid);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;

-- 
2.51.2.1041.gc1ab5b90ca.dirty

