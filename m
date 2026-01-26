Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAB32D438
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421110; cv=none; b=loE7l6lpdGnSlc+CszavCj4YztB9OlgiuN2oStvQb7e/anqpCpTK0Bs6mrmzGQ7sNPJeR3bH3Qpdv5S4QEU2TfGtS527rsu/L2TNPxhLlJjDRTE9oaLdvvNglNGKm2n05QQBkrsqYuviovgnHyOGKgOXB5Rn1BtAUjUfdewaO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421110; c=relaxed/simple;
	bh=ig7BOo8rrxq5UL0hlCCNYIU09+jTUW0Tp0xmANGPwmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfxwtAduaVPBVWCsOjKwPWjc+bFedof9VslGTtfZQ+5+/qYDImRSMd9u7g2XzxqAwdV5/D+dAXMJ00Sr++3JZof1ZfkNbOQhPSBOiItJYzYWfqd8CWtOF/Go64vsOeaU3EAXa1SS3hUaM6i/1qsu4zPohZOJ1qNjizD2C6f+JmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g3/6USkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fA5U8p5k; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g3/6USkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fA5U8p5k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F8E67A0084;
	Mon, 26 Jan 2026 04:51:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Jan 2026 04:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421108;
	 x=1769507508; bh=MlSQOzMwCQFCy7qUCZFrfyQNi6WEPq3nXlX1x3f20eI=; b=
	g3/6USkkdzRn7y8bmU1kLVeom+TFnYzABTisBINdcC79ivuDBLqG9F/T463iuDuF
	wEglk+ionV+eLorvDUZVm4ekxJptb11SN5iZl+ZZas8r7ItkylNG/IEz0UZhxSCr
	J+IZPsVOluL5tGmtmuW0FtmFEqEZPZYLZcCEveUitf543ooU8UPAAjdgX8wp1M0V
	NxIXcA6rGhDiB2lWkqBXTEJxeSm0O9GJaAqeQ7ruuPG+HE3bPrPPyab/AvZtNMzW
	NIJEBKbI3TmQS+x+IOvrF3aE+mo63AaWOogFOOsBjuk9aqFw7ony9s8XcI5Crjqr
	4BYndXOp4+tU2YYDFxS4OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421108; x=
	1769507508; bh=MlSQOzMwCQFCy7qUCZFrfyQNi6WEPq3nXlX1x3f20eI=; b=f
	A5U8p5k05HCkYRvtM4pkmYqJjTdDLF9iwDp5teNAquR2iqRY8O/cPzvaD4xCBllC
	yRCip2tObxMIw+/o4U4fjaDFKepsIU3jkuNZW8VPv2wfAsgtScTWxLxT3H4qj+0V
	GEMbviyya1Ayge1CqRhXSD48jeVSQrrSHSwbi3pUtan1yK7kbjLxUkGl/GmFlUT8
	5+ctzFj5xhw6r/eqPF7qosP+vEhtPIJIkYDfzCrlT7oEIbVICz3Bix+FrYEJ3wxP
	wOIkFD2KVm4fQfMfUzggtGoJ2qbEvWR4ogENnUjb3jE27Z6sdWYiKAyvEaQLW/Bb
	twCXr29RTdxYLRMoNWmlg==
X-ME-Sender: <xms:NDl3acugCZn1xCXmVSWrRbVbfRTe3nj9kZ1ft2k8C2KmqezHoVziqw>
    <xme:NDl3aQeZ4nfy45SlMGAf-MLWSKCqIYrq3ZuYyqphf1f_d-2zU8wz6_YZmb2DPZxBk
    PlgTz_xFeOY-uSzqCdnrc-biePOijR8rynTbd2vHHPCopwtGUPTTg>
X-ME-Received: <xmr:NDl3acx_VTOZpAu5Q34j_hJh7tdOFCquGHxRPf_gTUbp2veRB4xd25N7novA870s3GJLY765QBS7Wv3ohHIMHc7kVaUAs6mwXhrVHuOS75vNLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NDl3aeG_aD0ixwj2Y8B-mN4TJN8IQTr1dbik9CcPcXO39_0qAUe-wQ>
    <xmx:NDl3aYwOq_Bkh5-WqVQJz9rMXOIgzK-jhpPH1yw1OruGsRCktUDbHA>
    <xmx:NDl3aXtHjUe4xnkr6lzsIADreZNrSME8Orxhyo5uJr4KdXwGfHGNvw>
    <xmx:NDl3ad0Er3zfw9Q0auKuyg9vmoawObRg4_42oo1Io3vqWLcr0VHaTQ>
    <xmx:NDl3aeswsXMIkqdHhI4SB63dqPIgIXG_vLkC_5GzsaE-6y3ESyBPjQ3o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 517804a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:25 +0100
Subject: [PATCH v4 09/14] treewide: enumerate promisor objects via
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-9-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
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
index c35d5ea655..c54deabd64 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2411,28 +2411,32 @@ int packfile_store_for_each_object(struct packfile_store *store,
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
@@ -2450,19 +2454,19 @@ static int add_promisor_object(const struct object_id *oid,
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
@@ -2474,10 +2478,13 @@ int is_promisor_object(struct repository *r, const struct object_id *oid)
 
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
2.53.0.rc1.267.g6e3a78c723.dirty

