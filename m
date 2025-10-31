Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA72F4A0E
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891203; cv=none; b=f7vrC5JHbRW5+h/DsCPM9b2rzl+ZG9xUaRkJ2JtHQzXvKkVYJJGCRCeaWuiv6Gd8rV3uzC7qrAVg8YJAJbQCa82h2CAqJ4TWuOu1rZF70XeHvuEbwkV3Z4WkvfR5u+UHoBOnliG854B4W6mAMOlqX/HJ1YjMT28o+Ui5TYTEe+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891203; c=relaxed/simple;
	bh=mD8A2/BvriWUPLsF0FPhAI/EWBtIuSgk+nz2Btg43bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRhwiTG+pkGc2ZTNUADYnR/5vsbr0zIuRXv0Sp+U9iwDbNkHy+6PWuH25aZeIz7sXScZFrdnYLOUDrpNDhRxyANptrJJ0j2wnkkAFaA4OCDRsIlr2FRrEuri5gQeN6DL/RaGtPA1VM9oryP8XptNseQXYEcnfj+3o0pSQ6ZV8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b59tkHAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wPxB8hHz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b59tkHAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wPxB8hHz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E6D1EEC0246;
	Fri, 31 Oct 2025 02:13:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Oct 2025 02:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891200;
	 x=1761977600; bh=kWzxq0/dEtCInr2OCx11TmV4AsYIZLjY/CJvSAhVWYY=; b=
	b59tkHAHtZlFgAkkAmsoxFz5SRodJuSxoQMNgTKYL77XYjnKDiGIGBezRSkDoErP
	rx/+Q5O6OkwSW30et9rb/E/oshD2YXCRKgCDB2+ZCa7YIbofyo8ImTS7WB1cdThC
	g2z+4FcW2p3C3S4phLHsU/3uSg9h5PJ3L4mAO9Jgr5KLG/7Fm79jRPx0fdGSW7kF
	K6XVkGa5letI+koS3R/wbD8gLCDEKHhRe467XnVCi/mrQNHKhECy0S/MUqZysSgF
	/hc1pnEEzLTK+fKzeUg7uppp7a+QhOWcKrHA9L6EvKLP34jNZiKt800UhPy0b9Qe
	O5/I0IGdy+g9fzsOCJ6w9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891200; x=
	1761977600; bh=kWzxq0/dEtCInr2OCx11TmV4AsYIZLjY/CJvSAhVWYY=; b=w
	PxB8hHzs5LkPznnVToLDkLu3AZpCPTCJb6ge7ve+lok0cCNre7fTvpIsIAufW/mS
	NrWAK4DxlX7vdjt7D4ydtQvSHcEv2L5w7CjTUyNRaIEsjHJdH4Y/tcB/D8ccZXFH
	s7QuhSv9FhPrpxZFdgj0Sm5Vy9rXLyZYuxmxLWVtpvAihVNJmyXKTPjeZJV2xSIA
	c+KMjj6JFJIeeyINctv2ORRlvCEvi4e4jDSw4h0AMCzPbDBWEWqT34+TNmRhDUR2
	bLg+F3d9QvQq8he4kNPM3u+hA48dRWJXvrd7z7qIaWvH+05VtcXHnAaNVFWJJrSe
	uIjbDB1CaHH/XXpYOKevg==
X-ME-Sender: <xms:gFMEaVnO-U8Iv9q0LcdQlDqFF8H_U0DZ2VWx6ElojCrmYxlE1h8XBA>
    <xme:gFMEaYTJnpZSELfYLQ8YUBM0spxyF8FWuN8UqdbrwhSGgzxkM34U9bRHDOvR6Ic9u
    Qr96bGKMtwZSCbau4nZ34v56GcOm_Le-7Pr9e5G2cTS4noPAzv->
X-ME-Received: <xmr:gFMEaZBt1jwm6yBzkompfzwNy-Krnxc6JSNxlWzU4oVDlVzJoxzvTFieSIqNP4P6KOYt9k5n4WszXgsM_KI7u9mI4djHGRfb4cYtW_q5gVtysg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:gFMEafSJRlfgqXY6ZhmImc0v8owqs5fmqEgnzXMcW5nAuOB3AclzVA>
    <xmx:gFMEaXpwS7jMk2LHciXSvH5oaGPMRKBkkicFW5sK9mpfJAehHFNxMA>
    <xmx:gFMEaRwBNsZft4zhHY8JbMeQi93pwUDx5YJBSLtgayEGgwE6gU8WtQ>
    <xmx:gFMEacKqoKXWno47KwktiOveqzqJYZngRuEy4wmAK0sg12SP-As9Yg>
    <xmx:gFMEacQAkhNRBZcP9UqzIzLRO8GYeVfcuSoiK3azoAvnsCMxWfq9NsIi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6afeaec (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:47 +0100
Subject: [PATCH v2 11/13] object-file: refactor freshening of objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-11-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
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
`odb_loose_source_freshen_object()`. Like this, the format-specific
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
index 0255d757ba1..5ea24de205d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -968,30 +968,10 @@ static int write_loose_object(struct odb_source *source,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-static int freshen_loose_object(struct object_database *odb,
-				const struct object_id *oid)
+int odb_loose_source_freshen_object(struct odb_source *source,
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
index e6daa566f32..b11a9b95498 100644
--- a/object-file.h
+++ b/object-file.h
@@ -59,6 +59,9 @@ void *odb_loose_source_map_object(struct odb_source *source,
 int odb_loose_source_has_object(struct odb_source *source,
 				const struct object_id *oid);
 
+int odb_loose_source_freshen_object(struct odb_source *source,
+				    const struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/odb.c b/odb.c
index 5dc1e2c7eb0..6f8f665351b 100644
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
+		if (odb_loose_source_freshen_object(source, oid))
+			return 1;
+
+	return 0;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index 25fbcd7d951..8681b7782b4 100644
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

