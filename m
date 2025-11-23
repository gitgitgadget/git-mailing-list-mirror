Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA861244670
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924425; cv=none; b=tksJ8RYDhZ7J5Z03EBfsZOKRXBFmlnqARwF+pcaxL+PXH69+MTdleclvGthWTgQhGu9ZMPBZPcj5ko/5k8xiQp8mMlw1uCqgcP56+C6vDRaz77yZN5zzCD2d4NaX8zViaxYoGTuA6zHqmtFHHrf7WuyMcyN9rSut/jO1lwN4gR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924425; c=relaxed/simple;
	bh=SHF0wfIyklVvznfIXELy8LWZy/h1FyzHGAMcqdvB1ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raHSZaf6UdVtBQAOsdiC2RlZdguQji3mnf7/laKQ2/4Bk9afdmZHOwo8vHqhR4AFJyKkmtJ0liAUjL2ChrvMzTOSj9HnUCXqVzC7H1dA6NjVVY0HrNyldUCuPaJzaABanRqBxmyGNzzwiqkb974QmGMGfgr+Rzunu3rjt8bSIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iJIX6TLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RmJwlVx7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iJIX6TLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmJwlVx7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0BAC61D0009A;
	Sun, 23 Nov 2025 14:00:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 14:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924422;
	 x=1764010822; bh=YaNVK81oVVSrP19fkknmibSIoO0s5e0E1qzMC5r1Yfc=; b=
	iJIX6TLjBZO0XGG9dbeamWUwN/oYX5MCQ3TXNUPoWKwm1wHqSGEpwO8JsxIOOcwk
	j4gur+3v8QYClf4FZ0XU04W00n8/bS7SpryMpl32Gu8IxJDNgzcKpH3faj2CYyOi
	MXHG9AjSD8qfQCIGfuyQkuF475MKsotLgiAckMRUdF93y2IMElMXg+AxEMnS2ju3
	f4wl3hOweif+vdjaNcXu3sKzBcKg0tVy5EK9pGCuUpSEb47udv+PXBtwP+wTdMX9
	lu+WEyhgAlFiU+m3kuO4bS1G+5oYxcefzsL4fitE6g5qFIQyHwTGzNWMv9deeg+x
	J1VmbdbFE+1nEqpAW/dRqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924422; x=
	1764010822; bh=YaNVK81oVVSrP19fkknmibSIoO0s5e0E1qzMC5r1Yfc=; b=R
	mJwlVx7Lib7wwf6Q+XCOfJ0YVfRvAjE03D+0v/IxJZSR1KnsuKOE4PYZQSH5HfIh
	BPka6Ul+t+rFl4GSzfhUaYQFYW3EAg2fX7Di8EYazjaTpU1S7XOt3MJhk8msomsC
	G+50gGe5fYCQTqgvyB9n1EKFiSsAkmo4iDl/hLUJNY2g43+92w0jbY37IZxhR0mv
	X080o3muBs6y1g451fo9Ba4LRiphCVfPFqBb1U3psDB2Yh9rWhydZOxpMhdCvso+
	tIQO0FwRNAPLNhDYLlO6MS6sOCmRubWnIuHVIx1rEZ9etMHuXormGEVu3Cf37d7+
	KB0LRKnrgV7CCPYNIDn1A==
X-ME-Sender: <xms:xlkjaW_gfgQZYWCqBhiFyxaGeYvFZaqnj3aDALvXiJvqgtxwrAZWnw>
    <xme:xlkjadsJLHOKqJfqf3KQjxULGo7KmzxLq-dFB4vBCsTpGR70zeUz1_yIQutt9nCnt
    RFZCsAC6ULNe8k1VF1Q7bD4SEERHQb0vgwX2-mhCR1lq3I9nafgXA>
X-ME-Received: <xmr:xlkjaRACaQh9uEnMbyN8kW_yZ03FQTrs1ZCwdfUq8VNUlZN0YRFtalmDZ9C9Rd5YcN36uWPk-4zXBpvc1fRVHGXGszYmFS9Dmew9k317oralOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xlkjadVOcIzJ5KnfnMjzDhmPGPeKU9pW_QyqS7jrAmYZzB6mUYMJ-g>
    <xmx:xlkjaXAkQsINZdAkjxSIHm-nq2tta2FaMLMXzx1d4h3yjfixXchglw>
    <xmx:xlkjaY9xvCjkjbArvtQH713ir7lqnsBUEjr1yS_SuZ-w4GbzAcaRJg>
    <xmx:xlkjaWHnAeD-cYJISmRPXmdlw1Gn7qr6QdjFaJDS4-cKnNsXipZKfg>
    <xmx:xlkjad94sbJFNZlyMZjh3ZRYvshqzpL53jtKXsRBdgwoyeNtABqpErtA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9cdae1c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:36 +0100
Subject: [PATCH v3 11/19] packfile: introduce function to read object info
 from a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-11-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Extract the logic to read object info for a packed object from
`do_oid_object_into_extended()` into a standalone function that operates
on the packfile store. This function will be used in a subsequent
commit.

Note that this change allows us to make `find_pack_entry()` an internal
implementation detail. As a consequence though we have to move around
`packfile_store_freshen_object()` so that it is defined after that
function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      | 29 ++++---------------------
 packfile.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++---------------
 packfile.h | 12 ++++++++++-
 3 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/odb.c b/odb.c
index 3ec21ef24e..f4cbee4b04 100644
--- a/odb.c
+++ b/odb.c
@@ -666,8 +666,6 @@ static int do_oid_object_info_extended(struct object_database *odb,
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	const struct cached_object *co;
-	struct pack_entry e;
-	int rtype;
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
@@ -702,8 +700,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	while (1) {
 		struct odb_source *source;
 
-		if (find_pack_entry(odb->repo, real, &e))
-			break;
+		if (!packfile_store_read_object_info(odb->packfiles, real, oi, flags))
+			return 0;
 
 		/* Most likely it's a loose object. */
 		for (source = odb->sources; source; source = source->next)
@@ -713,8 +711,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			odb_reprepare(odb->repo->objects);
-			if (find_pack_entry(odb->repo, real, &e))
-				break;
+			if (!packfile_store_read_object_info(odb->packfiles, real, oi, flags))
+				return 0;
 		}
 
 		/*
@@ -747,25 +745,6 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		}
 		return -1;
 	}
-
-	if (oi == &blank_oi)
-		/*
-		 * We know that the caller doesn't actually need the
-		 * information below, so return early.
-		 */
-		return 0;
-	rtype = packed_object_info(odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
-		mark_bad_packed_object(e.p, real);
-		return do_oid_object_info_extended(odb, real, oi, 0);
-	} else if (oi->whence == OI_PACKED) {
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
-	}
-
-	return 0;
 }
 
 static int oid_object_info_convert(struct repository *r,
diff --git a/packfile.c b/packfile.c
index 40f733dd23..b4bc40d895 100644
--- a/packfile.c
+++ b/packfile.c
@@ -819,22 +819,6 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 	return p;
 }
 
-int packfile_store_freshen_object(struct packfile_store *store,
-				  const struct object_id *oid)
-{
-	struct pack_entry e;
-	if (!find_pack_entry(store->odb->repo, oid, &e))
-		return 0;
-	if (e.p->is_cruft)
-		return 0;
-	if (e.p->freshened)
-		return 1;
-	if (utime(e.p->pack_name, NULL))
-		return 0;
-	e.p->freshened = 1;
-	return 1;
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -2064,7 +2048,9 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+static int find_pack_entry(struct repository *r,
+			   const struct object_id *oid,
+			   struct pack_entry *e)
 {
 	struct list_head *pos;
 
@@ -2087,6 +2073,57 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	return 0;
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
+int packfile_store_read_object_info(struct packfile_store *store,
+				    const struct object_id *oid,
+				    struct object_info *oi,
+				    unsigned flags UNUSED)
+{
+	static struct object_info blank_oi = OBJECT_INFO_INIT;
+	struct pack_entry e;
+	int rtype;
+
+	if (!find_pack_entry(store->odb->repo, oid, &e))
+		return 1;
+
+	/*
+	 * We know that the caller doesn't actually need the
+	 * information below, so return early.
+	 */
+	if (oi == &blank_oi)
+		return 0;
+
+	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	if (rtype < 0) {
+		mark_bad_packed_object(e.p, oid);
+		return -1;
+	}
+
+	if (oi->whence == OI_PACKED) {
+		oi->u.packed.offset = e.offset;
+		oi->u.packed.pack = e.p;
+		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
+					 rtype == OBJ_OFS_DELTA);
+	}
+
+	return 0;
+}
+
 static void maybe_invalidate_kept_pack_cache(struct repository *r,
 					     unsigned flags)
 {
diff --git a/packfile.h b/packfile.h
index 58fcc88e20..0a98bddd81 100644
--- a/packfile.h
+++ b/packfile.h
@@ -144,6 +144,17 @@ void packfile_store_add_pack(struct packfile_store *store,
 #define repo_for_each_pack(repo, p) \
 	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next)
 
+/*
+ * Try to read the object identified by its ID from the object store and
+ * populate the object info with its data. Returns 1 in case the object was
+ * not found, 0 if it was and read successfully, and a negative error code in
+ * case the object was corrupted.
+ */
+int packfile_store_read_object_info(struct packfile_store *store,
+				    const struct object_id *oid,
+				    struct object_info *oi,
+				    unsigned flags);
+
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
@@ -357,7 +368,6 @@ const struct packed_git *has_packed_and_bad(struct repository *, const struct ob
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
 int has_object_pack(struct repository *r, const struct object_id *oid);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

