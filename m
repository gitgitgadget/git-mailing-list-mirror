Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F934B1A3
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947620; cv=none; b=r5IyiO16AF+3Pu4x5Lwf1OGu9Vrmj6pLFsxRdoBG7fJHOR7AQ1BEd3JQotI+WIWFZjdpfDpTF7clC4ba0CEAEGTNFMNCwku5n4djjm4O7kyRvR7DUwuGRbCW+igAIVerRezM6nqZaIrvmKtYIJd/k0igZEcb3h9o7pBG7cwjrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947620; c=relaxed/simple;
	bh=CoGTXjVcW5XHQKPfp9YbwW6dMrSII7pG7nAB4ksO0NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLHGTb+IAwMQ10p05Bx0aFDNUrtjGya7zKWkT7Vb8FIMWeXvdslFom7tuAEiTwqukFtpwTMfdJ0yyhNayIMmFwC3fciO4u9URZtD+pGcGKrj1fHSy2TlEDba1NgjO9dCn1RxyTQh83711HHUxqwtGj/YPIG9mILkzQZsMquq1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fiGStvQU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvyHMxiz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fiGStvQU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvyHMxiz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C5F7BEC009F;
	Fri,  9 Jan 2026 03:33:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 03:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947618;
	 x=1768034018; bh=CDXQbOUNngDFSUjYaYfU//9zo3d8+vHHk/gLvIEBNGQ=; b=
	fiGStvQUEwsdjJHtbSX5IJbUR06xifZ2XnfNf8ZoUt1QuBPbHmKOB5kC9+p5b8HF
	M18veMTc0SijMCc5Px4TIoTQeoMrB5O7YAzG75b7TCnDVSs1hCWHx6VgkKQ6eT/r
	/GJzcVs+WhMYXtsWlDZvljSQr1NuskF9RSfpZWR7SN4fUX/7h33c9k9SAzU1i3YT
	SXuvOcGd52ZSxwFK4fJnkls0tukb2GopteTKDYiMT90vGJefI/3WB3lEaDtqXbqG
	L96PgV+fywfFlqIUyn0/96w6iiBiVHv+hz+9ZGJX7WPRkLv9I0OBM4N2j8n/JdNV
	AuIX7TxQhMP3B/tSHiDiFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947618; x=
	1768034018; bh=CDXQbOUNngDFSUjYaYfU//9zo3d8+vHHk/gLvIEBNGQ=; b=Y
	vyHMxize+hIwAJd/RbicAlt731+/pqfTpczbusCn/udREcMgbGEIwUb2/U8N76Zk
	22BZXA4NL5cCED+W2RVNsvgTaUW/ARpANi/oFkLOjbVe2Mgf3Ml+ZBATZR+BOKxt
	LJnw334cUq9Q1IanrEbK4G3c006DYzZNSkmRSVvYBssSY2q24Tca5EC95O7RNIWl
	uiz2GFo4nuvc85+DIZ8dBV3z6QBtrePsJXBepZQ/3JDRRsA0FNj/Tlbs+DvEdJmJ
	vUyKfnZR5tm8m9x0CiAM+ND1JM8cmp2Ih8qN85a4W9U5UnA7Fy6e0DrvjSGGeHvC
	gmTXWsQQsako5j4TpFdhQ==
X-ME-Sender: <xms:Yr1gaW8rCB0xSass5-tSkqHfbtlCDoszfCb0f4klnQti_zsSR8VWFQ>
    <xme:Yr1gadv4AmMIv7n3VWN9jyRownx5bMng1qWWtgPB7r2Nq18wINo0zf30X0PWcI3RH
    BHH8GD2z3ApqTg4JAnwrtJ5h2x-L-qudCTMieJZ1RPsn4UPDfhhsLo>
X-ME-Received: <xmr:Yr1gaRDFppV6ZMxSaGAm4plrfxCqMAuvTFxoCxJxxDFBIcNmhI77H1Ku-y36ZpbI5WfINSeuoJgfi2voZuMcbeLg_OV1SCU-_y2cd1VSNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhm
X-ME-Proxy: <xmx:Yr1gadVV7vC9U2iyLNoUP2xMx0fOAdx84qR5_ckScsuM2E-VTJA1cA>
    <xmx:Yr1gaXAfNTpjWzO5jaFS12TIeoAYVloTDGnR20GRPcTmLkpN3O8kLQ>
    <xmx:Yr1gaY9Qs-xCB6ELPVQqKDSef-zxB-qEGs1XPZE9lnSMt7cKGEebVQ>
    <xmx:Yr1gaWHaeLDIOajmJDLpTwqaLh9JnY5_D6TQsnUfnMFMhZmUIUxDkA>
    <xmx:Yr1gadASYWj9sYrt-BpA9tJq7gko03-j1tCWuu5oYwozZilRAup62hQY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1486118 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:17 +0100
Subject: [PATCH v3 09/10] packfile: refactor `find_pack_entry()` to work on
 the packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-9-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

The function `find_pack_entry()` doesn't work on a specific packfile
store, but instead works on the whole repository. This causes a bit of a
conceptual mismatch in its callers:

  - `packfile_store_freshen_object()` supposedly acts on a store, and
    its callers know to iterate through all sources already.

  - `packfile_store_read_object_info()` behaves likewise.

The only exception that doesn't know to handle iteration through sources
is `has_object_pack()`, but that function is trivial to adapt.

Refactor the code so that `find_pack_entry()` works on the packfile
store level instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/packfile.c b/packfile.c
index 3bce1b150d..0e4c63e11d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2087,29 +2087,23 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_pack_entry(struct repository *r,
+static int find_pack_entry(struct packfile_store *store,
 			   const struct object_id *oid,
 			   struct pack_entry *e)
 {
-	struct odb_source *source;
-
-	for (source = r->objects->sources; source; source = source->next) {
-		packfile_store_prepare(r->objects->sources->packfiles);
-		if (source->midx && fill_midx_entry(source->midx, oid, e))
-			return 1;
-	}
+	struct packfile_list_entry *l;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *l;
+	packfile_store_prepare(store);
+	if (store->source->midx && fill_midx_entry(store->source->midx, oid, e))
+		return 1;
 
-		for (l = source->packfiles->packs.head; l; l = l->next) {
-			struct packed_git *p = l->pack;
+	for (l = store->packs.head; l; l = l->next) {
+		struct packed_git *p = l->pack;
 
-			if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-				if (!source->packfiles->skip_mru_updates)
-					packfile_list_prepend(&source->packfiles->packs, p);
-				return 1;
-			}
+		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
+			if (!store->skip_mru_updates)
+				packfile_list_prepend(&store->packs, p);
+			return 1;
 		}
 	}
 
@@ -2120,7 +2114,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 				  const struct object_id *oid)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(store->source->odb->repo, oid, &e))
+	if (!find_pack_entry(store, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
@@ -2141,7 +2135,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	struct pack_entry e;
 	int rtype;
 
-	if (!find_pack_entry(store->source->odb->repo, oid, &e))
+	if (!find_pack_entry(store, oid, &e))
 		return 1;
 
 	/*
@@ -2217,8 +2211,17 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *st
 
 int has_object_pack(struct repository *r, const struct object_id *oid)
 {
+	struct odb_source *source;
 	struct pack_entry e;
-	return find_pack_entry(r, oid, &e);
+
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		int ret = find_pack_entry(source->packfiles, oid, &e);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,

-- 
2.52.0.542.g9473a8513b.dirty

