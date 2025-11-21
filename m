Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA933A036
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710905; cv=none; b=mmjgoBNWF5ccZ61FQI7sSDHwBzPtZ8VCbWK56maLE12skx4aubwedcuZa0GqXkDaT/qiPf6Ak+6nki1HY805TZVm2ntN+ta0vby6nPlSV0PLR80d4cWlyizfCdM9wjKiaZ2FxjKDDkxmoYPPbqLcNxirOZKa7NFZtjREKkwBRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710905; c=relaxed/simple;
	bh=SHF0wfIyklVvznfIXELy8LWZy/h1FyzHGAMcqdvB1ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEkv00eGZ4gsXJTli7QZOTLyUMlNAsMrR4Z/4wZKq3WukwHYy8bb+p8J/lxDH9egovABVRWnIfn+hO0wsm9WKBAXBbCEbQPkEsEpvZw8DPlAYEu5s7uq8mB8jb/J5K0LUkEawXQsl9wb1NAAetqYrq10rmcVNAglbFAU7FNeKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bpkEFkMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nijr4YhC; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bpkEFkMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nijr4YhC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 939C51D00176;
	Fri, 21 Nov 2025 02:41:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 02:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710902;
	 x=1763797302; bh=YaNVK81oVVSrP19fkknmibSIoO0s5e0E1qzMC5r1Yfc=; b=
	bpkEFkMah9tkbfaWzD3ydSHdvaFtMZdmTJjoGz7pfTD3Ezv2Fv6qeSMSH1R7/p38
	x5M7ZLKi4baDOmHz2bppAwHU0LXb/mKmxHGmyY1gDu1MkA/Y8WW191LnZYDIiSZA
	IVW0Rrbw4Gl/RV9l78IiydCCktF0i07o66BNRSmXqVCq7taY0pPP6YNVQQU5yvN7
	HMc9qdAwcm7OMhJpPaf42xITIh13f7atkt2CxmBujKjkzeholkc1e7goWNJ/1SA4
	YBvGX3+EqnfxT48lACAY0nthSKCRFDyxLkRIAjwr510m26seLPcVk0FJ4AgH0UHm
	OQu0GExoHz9oB8jTBncDQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710902; x=
	1763797302; bh=YaNVK81oVVSrP19fkknmibSIoO0s5e0E1qzMC5r1Yfc=; b=N
	ijr4YhCj1dMz37mUY3U4Zz9BpoTZKyC9qmCJ9NM2jn5HUuEH8EmNZsbbWHCEwezP
	o70C92/t0hUZd9PMjse+XVedweLEhhz2Q74I+8KAcaHYgnd8+gYEe8VO3753EZcd
	8k3noMIlMMN658uVpmdOSLnBuFUQ6Kwg5Qy8UyT4R7nrIQTTL3cqpeMmb9iHrjaL
	6lfhlCVidvrCGOorp8bKlJAiC2aqqA4RPaKiGJhc+UT5a28i/w8lEmuNJrY3h09X
	qoUaiM65PPQvHn0iESI3DmhP3PiIaJt8MvhUbiL8fBb7bwtIXX3vkuna1J4+b3yl
	nrnVU/saraen57JJ6fGwQ==
X-ME-Sender: <xms:thcgaeZRogMzluLNgmXh2XK32AVrCDO_JAF4ZVhS8DueBssalwwPKQ>
    <xme:thcgaY16iwc5owJI7lABby1aYGvx-eVAO7wO1zKj0tUWyNZij5Kl7CWPyQ34gVMtn
    dWvPnIXXunWuNtz-yZYbHMWZM6oyAlvutIT3Ao1s-6DRTgQS_IY_jY>
X-ME-Received: <xmr:thcgaWXk9_ojOHxZShOU-68u_zAfkQlZu0ZyHnB2CPcqMPU76d7nc6X2q2qs_CZF5L_fKXXRbU8XtmkeAgNTJCdUt5taEGMKvhxzW50RPkOV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:thcgaaWApZ6KZsrmKERDPDMgsuTKePY_GCPw6j2c3RQn6ccMcWMs8w>
    <xmx:thcgadd_iVZqj1ketR3F9qdDYOwaKiQXdppyiCKhp69Q-2uQZEjwtw>
    <xmx:thcgabUZLLhwyZs5SYfQTx7c4TqGpvSBm8FelhTo12QFw2JD-FCPHA>
    <xmx:thcgaeeZjiCbo1vRmtNuVfT_Zbl_VGEmivnZS-jxqhSWVMcrpnoV4Q>
    <xmx:thcgaaRzW7TAb4-w_pM55N1RCTR0UeG3gh9HFPg2EeEcgOfcbcMGug6E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a063ab59 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:56 +0100
Subject: [PATCH v2 11/19] packfile: introduce function to read object info
 from a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-11-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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

