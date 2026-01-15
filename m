Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1EB32E729
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475131; cv=none; b=ZdC9HJIhc844fkdBddFY/9lCL5fwHSSIzmyTw2IicQVwn/QOEeoErGCAJakxn18P6HtOdh3vKvRrQjmUm5jhMZ0Rj+kffWyXMtjwAVLhyDgXHYuiQ+boQNc0s90N3gOrjzfuiqfNZ+po3zb+M0m9gmyrhKOZEBGRmgvZOTDYNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475131; c=relaxed/simple;
	bh=HKyU8bvBb4DuXPOjj2q8ik1aRwqE1S7+B5v3BT5HiD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxtcHYTrB7hVZkJTPn8Y/VKDsJSB/H1pjkRXEsAHkN1YKgUeuDSrN3wSDiq42S2qCzgNN+7TU34x79AiukqGktyr97bMHR5R6edhD73wAzw2E69dTR7Rzd+CTlA7cean0fU8UAth6PDe2jLwZQaZ4N8Ph8KwVBJCW4R7N9Pnm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DmHhHjCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3Z5+gY1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DmHhHjCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3Z5+gY1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAA567A00BC
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 06:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475119;
	 x=1768561519; bh=0RViGHep6sD4VozbQHvdHvHQEZRQ0pxCzBiAGCvEhqs=; b=
	DmHhHjCpFJFu/NvP6aNs9131+tp40UW35qghGqCdCnjfO402L1AnkUBGBcuVDePM
	IlrkW8Ff8Bx8q1apAUdynOjOX3dkdZbYMalLVZ5gMry4kI8iJLqFv2QaemxiVUOO
	NoHKkfH8Jzvyz6oopSkUJspTwMXwAB2wtqo1nAjSGXl1Oc1TnFkPzsK5Q0UDYMer
	jIx1K/6GeofzCMBWGw6E5HRLP85rhFrUZHUCwrF5Mm+2o9oH7YNvaPOf9qcoQ76g
	bsNHrVCs8u+N3v2dTR5LOjCns5eskjzlOX2qm1NRF2jX0Za2qffXDmD2y7nksklr
	vQS4bHo91xOJ8rZjuD2fEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475119; x=
	1768561519; bh=0RViGHep6sD4VozbQHvdHvHQEZRQ0pxCzBiAGCvEhqs=; b=I
	3Z5+gY1NYgFJOEbBEomTyemU8p+6eSW6gE77SkOeVF+XjCHezrkdr9C0VGz49Ttr
	7Un6mLbaJ6zIcAtKOnJd2CnikrgHNomMR5dS6hLkB+efBnG4yWvTHwRB2tawULyF
	0LFZS2+XoZlBKdg1sKa9Fy6T0L/bzLJuelt889DbWBL3evlmBKWCpDXcK48WivmA
	/p20dlw8DKtz/1Go6D+I0a3qA+HOcuByhFlA3Y9aCJ75SoJ0lEVzlJjR/Cb3uZNe
	uO5mvK18SywVGJ0tSMbCcpUeecVHW08rQzLZoCBADWOSjBATlEHeMn5NV84FqQNQ
	71EoxHXiPOTsObP6ZEjow==
X-ME-Sender: <xms:78loaU1q8FLkKCXMg7tXyN_CIFY5eu6R6TzLSt8Bnt5T0DnmmPpP0g>
    <xme:78loaWCFervEDHdXbwmo2gDukNdut6v4AcABbWbPyrreZg9x1Pd1UEG6EmMWWZYm5
    dHkeW8wSF-7z5UJTIrfZk589m7_4V7EWMDA4N4AA2rTjHa27LwDUg>
X-ME-Received: <xmr:78loaSh1oZeL_39rc7eLiHYnh5AtB6JX1PgpZpJ3K3z-ul4UYwd6MrX5nBlECE7C4d-acdSZWpGchEsu3G1PWVb2TnlnttVh89BqH2c5mjls-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:78loaS9TVri6pTcF8hXtt0jPbrSeh-bhgOUSmF-7mfzLUXy4YrQvrQ>
    <xmx:78loaW-a9h0jZD-HIhM-c-nYTHlaJsysyBcWJginzbC2vJxmTmHwxQ>
    <xmx:78loaTBovrIOahl5nUAA4dhQrFIs1YPLimGAaDlTxYCfCYbv2R_JJw>
    <xmx:78loaeyF7OfnZQk6fr2WnlHXKMOVYR9kfcYlO-gASsVQebydERCDaw>
    <xmx:78loaWHM0S1Kx9IMRZ-Ebi4fb2GSXXGBoA77Bnv5rRlsTquF7PZfuH9x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb6006a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:38 +0100
Subject: [PATCH 09/14] treewide: enumerate promisor objects via
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-9-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.52.0.660.gd05f3a8ea5.dirty

