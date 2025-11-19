Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C975320CAC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538486; cv=none; b=RPlkIr7sv6FHi8p1aQ6q4p/XGbs0S5ZA7H3wvlH66UdAUS3FEzPghIzKZRoLlR7jCtZaS1nQJCZRRAuc5uNbDIGTZIOZDVie7ePtnD0ZGWOSquFU/4d0DI64VtIM+jAX4sTL9iTip/r9FaobDTVjCmImvUtVrlmnA417hmFbzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538486; c=relaxed/simple;
	bh=SHF0wfIyklVvznfIXELy8LWZy/h1FyzHGAMcqdvB1ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ut8WBIU2ydT92tcqT5CDb/W8XGTlZCxGbrWmFAAeI3tVX1o3/4mDA6ux8nvvSpQoD8gf20ntr3lY5C6qEFd/lf7816De34GpCR5aOUOrkP+qUdBmmM9Ewshdqdf7I+5miBhWkG9NhsSzmOzJFY+wQPV/zFNfp4Xxd67kRLkfRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QVMkSZsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+HEiGri; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QVMkSZsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+HEiGri"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 57F60EC00B4
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 19 Nov 2025 02:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538484;
	 x=1763624884; bh=YaNVK81oVVSrP19fkknmibSIoO0s5e0E1qzMC5r1Yfc=; b=
	QVMkSZsmG+uew+nQlM0tfJxmaZF+iOtdFmqQS/e7ept2WVruNP4/RpAyAkHF+ppU
	uvRGxLAtJ3PRrQRbitlROyOrYyNSHQc6oSmBssnlSvoQ1UGLvRTO97IKXGoSnybY
	YuvcZPZGWCaWsPr2IAu5WN3Fml0eXB+t5TN6q7NbTVU7BahfG3sZW35pfKtw/xGJ
	ATs3rF8y50k5OmjSyh4sxUk3ISX6s093nM9reZAhEFEr97Y5GyIOVKtnKoNXf5PS
	g8isVHO6yER+9SH9dpWmn9rQgPvRxX5XPFtMyrTQuYxdXp4IEBwBChsvVvu9SXDa
	YG+hrGZ6NyxFLyN6TQHGHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538484; x=
	1763624884; bh=YaNVK81oVVSrP19fkknmibSIoO0s5e0E1qzMC5r1Yfc=; b=Q
	+HEiGrimvEg/MnKHGm/DtshKOK4QKWWlN2ETPc0n3WqIDq/XLjZlMXJFUNP6gxLe
	zIY3WLwqOasbYjU2XLdRkkJtoTkQvEBL+EfAYwFpKsSZ/VNUAB+wEfCeOkUICEEc
	Qrq/urJIuNulsteHUmA+iBmENuXH+fn2QecDSKNayl/L2dTOQqM8W5hbSG8klOKE
	IFk4/WYYZpEEbJC4LT3F5MpbNcttCM8jvX2JSmfM9O8jBFtbaHeFHa8d8BLo7JjN
	v1t64VLIxMqRqzi0G3PeEEkA5t0KdwBESe0FdxgJyNPKN3E9UTrdoj3WvPzeJjLv
	TLR/K/8UFWulUP2GJx3Mw==
X-ME-Sender: <xms:NHYdabfEDIvdrRjvNrMtKnZatTSuz0DUHXQ5GVuuqVFZt-nYrN2NUg>
    <xme:NHYdaYJAgF6xCdc5yNOGpe4mrCbMCBbw9MF_SeLiyYGyNJgmP72lowu5dvPiX9c7K
    EtyScliIvFl8Kr-hGqSCc8LHULB13HMQxjfy7wyZpcGJDnh8sj3RmA>
X-ME-Received: <xmr:NHYdaaKuiia11gSWVOaat6rGKD_6DpaK9Uvomet6O_n8VCRqxNVarQA9BsEsLhGnIpYKdIWRgg8R5OfC6nqD9jFCa_o7iYM6e2Q4c7RNZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleff
    vdevleenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NHYdaSFov-NhVMTmiInHrwqWRViK3fSNHrhZTanUStGhKtDcReOlPw>
    <xmx:NHYdaXnxnS04OX2AzpHCHkFhyZl6bZCjgoSeY2g6hlG25zdNX_CUuw>
    <xmx:NHYdaXJzaZ6uQ_AEwCxDuZQx-5X1JD1Wr9Err4KmgPyzzFRCYbJ8ug>
    <xmx:NHYdaQadtYjNDqMN58MdI312mFYiGfZ1gnKyNc3Qb1Cmi6Fy4mWxEA>
    <xmx:NHYdadMBUkPMuxb2HDwZqAvqs4Ow_zpCgKGDlI04HjZ7oUzp0lcfpE-C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bde4306 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:11 +0100
Subject: [PATCH 11/18] packfile: introduce function to read object info
 from a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-11-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
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

