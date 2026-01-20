Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDD47A0DF
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922803; cv=none; b=ppFhx9c5BsEESx/CWZpHgnf+7re2Ct1S6h+n6QFUWQyi4KrGYMucBeL97+NEMIbRZxFJj9xi/3c/p9CFVGhTHvFgaNbqi0Z9re8YFf2W8r5T4AhawwdbNSjq7xnVzJMkezrrrQ5F8WC31SrJzgadnQ8gugesr2uSfOGl373do+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922803; c=relaxed/simple;
	bh=TIzkqrfiK7tsZ1Vnljemt4K5To+kAqmyCBMDrIl6kmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFXRwc8ZM0lFRhdOjC6Cj1vbGB6zc0YPRK2aJeMXx/DxHA82otyzfyhbG8cBQU2qPGJnOT+vIycg5GuNPMJxKd2WHs8Xmj8ss2HF+Ye5oH7UtOVtrLRqK8tN2ygzcbYLXam4SIdDj8ndK/MQebrTitmc5aqDrT05BBtbd9YJ8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=atJzpS0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrlnhxAq; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="atJzpS0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrlnhxAq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E35271D000B5;
	Tue, 20 Jan 2026 10:26:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 10:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922800;
	 x=1769009200; bh=Pm69Fomtm9auJjGU0PHLDIXQcXEqkJ3rnW+hseBWLpI=; b=
	atJzpS0e/h/oaIb85LbUEDjEvZ1Wvmdlhlf7I/sInUBeIUo0eD9RNu6n2YVLxq13
	NYSOARLitaSWCpKP7xkQIkq99iJIsOW8isK4mfYxqqtN68iNSN9ouMIJX/aTtrK/
	A1Pl0gBitIqAOQVyaNPODcvrqEE8ICd9nBtC7IgHAPe0SpcKwGBSJqFAyIi5w4Nn
	43wry/nS+bovKfECt5C/Bk8X6EisfHEh3Nj6kBOpUFWdcz5Nrl3qRwDyVsY9Ni9O
	dCFXW3hD1a50Dhnq2nNWfCOsxKa+Lch2s1lMIFXPo/gzyv3H7VBKksXhdYfANBZT
	uUTKVdvBoTvtv2wYTq3r+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922800; x=
	1769009200; bh=Pm69Fomtm9auJjGU0PHLDIXQcXEqkJ3rnW+hseBWLpI=; b=U
	rlnhxAqXeEMTWl9DNsAK/U+1DYVoyDJOEiyHX4NZHIzslrJ0ucXLREJEKfyrczMO
	n4M5yowIfnQu09emv+2/OBktfaXb+A1zJk1hqp1xZalmOr2akHdgZVMaB3845+ht
	tnxxUwsngZqeQhGDDhVPDOjHXqTqXOBuOyKE+sdMhNYm0oTde5Q/BD/vKVGC7GgT
	c1qZrrPrpvjLGJWvWrbvvMXCwlbSOC5QnOwpMCD1z01zPgP5wG9qmJFILYzDFrwy
	j6QDExlU5M8M8znkX6MysTZssD5DevjotBuKjUPriHH6EhtvrPW13fn95NytVQzl
	8NNYDL4bh562TbD8CFkkg==
X-ME-Sender: <xms:sJ5vaXa9t3Z5QXBXLELWoD4Bo7YRo-NaZgK9wRshiHnGebs0k94TRw>
    <xme:sJ5vadZvagCHxXw-MmkFsyIVP4mduRN1fqtibEheZ_JjR9sIOCuJ-uECsDrE5wK5r
    bnqx-6q1OMeZ8aMC2iVFEPwa5D7dYc6PWIatRFDMXVQK8CJI8-uSQ>
X-ME-Received: <xmr:sJ5vae_v_ehTO5CP44OHkn5cpQ4QTgUTqCI19qifnCq3Maidb8lDl45zQ14Cbka9KlNO4M5dwRNqvF2T0XnuW-NW-1wcs-GDKqMQw8FHWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sJ5vacjwI6XmJGozibj5YNSXBGfoLQw7UqXtagh1PYRQ761XCYrNvQ>
    <xmx:sJ5vaedqQrAovai5bgt1MXuJpE5mEwVZx9t8jDvUbghkrL-jq8XcyA>
    <xmx:sJ5vaTpc3eWa2YO_PrMJcFj22y9dC1AoXkA5-r-_ok1gtYiBOf5-MA>
    <xmx:sJ5vaTB0f5mYHaY6f5oxMzzQomUIKOmPYw18BuOYaOVqabNq5ZbeaA>
    <xmx:sJ5vaee2I8_Xmh6RbxkrdrvI6pDyfLH0E1yFi559fTZ7jArMGEVKUReO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0900609a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:05 +0100
Subject: [PATCH v2 09/14] treewide: enumerate promisor objects via
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-9-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have multiple callsites where we enumerate all promisor objects in
the object database via `for_each_packed_object()`. This is done by
passing the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY` flag, which causes us to
skip over all non-promisor objects.

These callsites can be trivially converted to `odb_for_each_object()` as
we know to skip enumeration of loose objects in case the `PROMISOR_ONLY`
flag was passed by the caller.

Refactor the sites accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c        | 37 ++++++++++++++++++++++---------------
 repack-promisor.c |  8 ++++----
 revision.c        | 10 ++++------
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/packfile.c b/packfile.c
index cd45c6f21c..4f84bc19d9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2408,28 +2408,32 @@ int packfile_store_for_each_object(struct packfile_store *store,
 	return pack_errors ? -1 : 0;
 }
 
+struct add_promisor_object_data {
+	struct repository *repo;
+	struct oidset *set;
+};
+
 static int add_promisor_object(const struct object_id *oid,
-			       struct packed_git *pack,
-			       uint32_t pos UNUSED,
-			       void *set_)
+			       struct object_info *oi UNUSED,
+			       void *cb_data)
 {
-	struct oidset *set = set_;
+	struct add_promisor_object_data *data = cb_data;
 	struct object *obj;
 	int we_parsed_object;
 
-	obj = lookup_object(pack->repo, oid);
+	obj = lookup_object(data->repo, oid);
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object_with_flags(pack->repo, oid,
+		obj = parse_object_with_flags(data->repo, oid,
 					      PARSE_OBJECT_SKIP_HASH_CHECK);
 	}
 
 	if (!obj)
 		return 1;
 
-	oidset_insert(set, oid);
+	oidset_insert(data->set, oid);
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
@@ -2447,19 +2451,19 @@ static int add_promisor_object(const struct object_id *oid,
 			 */
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
-			oidset_insert(set, &entry.oid);
+			oidset_insert(data->set, &entry.oid);
 		if (we_parsed_object)
 			free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		oidset_insert(set, get_commit_tree_oid(commit));
+		oidset_insert(data->set, get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
-			oidset_insert(set, &parents->item->object.oid);
+			oidset_insert(data->set, &parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		oidset_insert(set, get_tagged_oid(tag));
+		oidset_insert(data->set, get_tagged_oid(tag));
 	}
 	return 0;
 }
@@ -2471,10 +2475,13 @@ int is_promisor_object(struct repository *r, const struct object_id *oid)
 
 	if (!promisor_objects_prepared) {
 		if (repo_has_promisor_remote(r)) {
-			for_each_packed_object(r, add_promisor_object,
-					       &promisor_objects,
-					       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
-					       ODB_FOR_EACH_OBJECT_PACK_ORDER);
+			struct add_promisor_object_data data = {
+				.repo = r,
+				.set = &promisor_objects,
+			};
+
+			odb_for_each_object(r->objects, NULL, add_promisor_object, &data,
+					    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY | ODB_FOR_EACH_OBJECT_PACK_ORDER);
 		}
 		promisor_objects_prepared = 1;
 	}
diff --git a/repack-promisor.c b/repack-promisor.c
index 45c330b9a5..35c4073632 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -17,8 +17,8 @@ struct write_oid_context {
  * necessary.
  */
 static int write_oid(const struct object_id *oid,
-		     struct packed_git *pack UNUSED,
-		     uint32_t pos UNUSED, void *data)
+		     struct object_info *oi UNUSED,
+		     void *data)
 {
 	struct write_oid_context *ctx = data;
 	struct child_process *cmd = ctx->cmd;
@@ -55,8 +55,8 @@ void repack_promisor_objects(struct repository *repo,
 	 */
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
-	for_each_packed_object(repo, write_oid, &ctx,
-			       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
+	odb_for_each_object(repo->objects, NULL, write_oid, &ctx,
+			    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
diff --git a/revision.c b/revision.c
index 5aadf46dac..e34bcd8e88 100644
--- a/revision.c
+++ b/revision.c
@@ -3626,8 +3626,7 @@ void reset_revision_walk(void)
 }
 
 static int mark_uninteresting(const struct object_id *oid,
-			      struct packed_git *pack UNUSED,
-			      uint32_t pos UNUSED,
+			      struct object_info *oi UNUSED,
 			      void *cb)
 {
 	struct rev_info *revs = cb;
@@ -3936,10 +3935,9 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
-	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(revs->repo, mark_uninteresting, revs,
-				       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
-	}
+	if (revs->exclude_promisor_objects)
+		odb_for_each_object(revs->repo->objects, NULL, mark_uninteresting,
+				    revs, ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

