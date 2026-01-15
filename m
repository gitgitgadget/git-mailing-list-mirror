Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF136E464
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475124; cv=none; b=Z7pSlfDyYfGsogQvPXgJ0xMytbpnf5znUjbiHczY38rkVG2G34zr7Y8Tp3yurt/2fcPLUTrFg5Dn0xqBIpUNC29oZenMKPmXoMPv7dZbo88h62esraFb1GkPZoX70cw1LLxB1479qlxu9mJWJB50v9vVR4OXxGtyw34uU1qVgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475124; c=relaxed/simple;
	bh=xe9WEtE+sQjtY6/JfkIdLWWvFLuAm+AJos7VYfNSMvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3dwaGIrb0a28H6I/N1cfdgGwLmI8mYjmoFlQ8ysVDbLg8DVUADk0zevlH5cNWMP56bSrYANI8Rpwpceu+UV6ivyWT+rdkZd56ebzYPYQc83pWH4wKb/5jlyydwPF5tOc3S+Q+dQP3dVBZaknqRifrtTlHqx5LBYbsZ5X7IR0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OSOC/qnu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlyXTy4C; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OSOC/qnu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlyXTy4C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EB5AF1D000E0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 06:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475116;
	 x=1768561516; bh=r/f+BXue2ZrLji+p9mHP3dj69UrSJcQPLIW1e3IdBng=; b=
	OSOC/qnugT3Z6Uk72AZwix6BhaoM69408XGXA1LcJWyQUgiWu7RkIonWlsF3GMav
	7h/LZeyQyUR7LFp27vfrMpn8v/xDb+8bhHEcCl6KQkTdF2J46lX4SHsuhLj/oYez
	rCtQLPCZwpzRSKFZBo40IW/w5z6mKN3GC5XRG+dBHLD6ypec3gTCFnOO66OaF+Oo
	iJNQcFSg5CjBvFuVNwvo+/X5d99OVcN3CWSOYwsGTJQuLCSiJyoowP7YLufJRiod
	hfQ5hpMYCzIHrD6r4/lIGSvC2qDCndwGy/DlcDDiEzxJcYRfgrhpHTjxEicdp9KI
	+GPoJ4qyneWe22kIgF447w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475116; x=
	1768561516; bh=r/f+BXue2ZrLji+p9mHP3dj69UrSJcQPLIW1e3IdBng=; b=j
	lyXTy4CJICFLlBRb9NmKrioQuhtVlu8twGSEd0rCmcxLMY4Sbghs4YYrTMYQRSQK
	93FEEJO4TjNG0xVSP42+7TQr59sNupvlWj+powqLyD2DxntMS5pwZalntI0bB/sS
	4DFApQ2HHV1rXD2yE/O2ACAoc0N8NVUma+K5E7kwOR0NNDJnkEh2Ud6rXcO11Ced
	6vn49KqOw3Qp0rshxXMZT/PV9BfRs6jHrzmLXcEpRLzX8b50e1Ik3O756AtbYPOr
	SiBbQLaT5kItQ96lGBAZqFkyPTitFvYxYkHT75eSCnl9Um8r95RGvpxbhm9tXVfS
	LNPEeG72uao8cE6nWxdkA==
X-ME-Sender: <xms:7MloaVKMBjff8FfEE9nb8edwUKl14dg2PjOhSf4f_bsAsgZk5btMMA>
    <xme:7MloaYF_E25sI_RpMNsH6yvF3DD-l7QUGnXGraltOZfyGeN9vf6m1Oe7HtI2x7Luq
    r8Fa3BJ5_3shGSz8fUfhRStdO_iZltestGxPcoCOloQEyiPXxO7jw>
X-ME-Received: <xmr:7MloaTWb6UewZWjySuIJ36-E9BeLtOXNwbc7uOWU6HnaGVAeavmRHfH5ggscKbkychhtXUpKSLMkwj7h9L1bXz1Dye3_5A5yTrvjcxrok4RI7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:7Mloabg0OvNE66-9jTnToNwknnxi_ZazWFunooa3vVmpE0fm1itqOA>
    <xmx:7MloacS36qUwTv_3JjsvvN1JzYLiIFjqCYMD6hmyN58JWCnrvqHy2g>
    <xmx:7MloaWFDZagpuSTdItkX83rPCSECqEgla2LNk3M_pXDmGjxpNsBH6Q>
    <xmx:7MloacnfEfiPYmQ5Sepq8h_3OmVkXvjr4RAnb8cSOJzH0DlYnd5Xjw>
    <xmx:7MloaSoihXsy89eoJO5EUZ4Jp1EWu2O5Blmomh5BqMdyYvse2zYchTsH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95be9b60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:37 +0100
Subject: [PATCH 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-8-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In git-fsck(1) we have two callsites where we iterate over all objects
via `for_each_loose_object()` and `for_each_packed_object()`. Both of
these are trivially convertible with `odb_for_each_object()`.

Refactor these callsites accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 57 ++++++++++++---------------------------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4979bc795e..96107695ae 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -218,15 +218,17 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 	return 0;
 }
 
-static void mark_unreachable_referents(const struct object_id *oid)
+static int mark_unreachable_referents(const struct object_id *oid,
+				      struct object_info *io UNUSED,
+				      void *data UNUSED)
 {
 	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
 	struct object *obj = lookup_object(the_repository, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
-		return; /* not part of our original set */
+		return 0; /* not part of our original set */
 	if (obj->flags & REACHABLE)
-		return; /* reachable objects already traversed */
+		return 0; /* reachable objects already traversed */
 
 	/*
 	 * Avoid passing OBJ_NONE to fsck_walk, which will parse the object
@@ -243,22 +245,7 @@ static void mark_unreachable_referents(const struct object_id *oid)
 	fsck_walk(obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
-}
 
-static int mark_loose_unreachable_referents(const struct object_id *oid,
-					    const char *path UNUSED,
-					    void *data UNUSED)
-{
-	mark_unreachable_referents(oid);
-	return 0;
-}
-
-static int mark_packed_unreachable_referents(const struct object_id *oid,
-					     struct packed_git *pack UNUSED,
-					     uint32_t pos UNUSED,
-					     void *data UNUSED)
-{
-	mark_unreachable_referents(oid);
 	return 0;
 }
 
@@ -394,12 +381,8 @@ static void check_connectivity(void)
 		 * and ignore any that weren't present in our earlier
 		 * traversal.
 		 */
-		for_each_loose_object(the_repository->objects,
-				      mark_loose_unreachable_referents, NULL, 0);
-		for_each_packed_object(the_repository,
-				       mark_packed_unreachable_referents,
-				       NULL,
-				       0);
+		odb_for_each_object(the_repository->objects, NULL,
+				    mark_unreachable_referents, NULL, 0);
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
@@ -848,26 +831,12 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 	fsck_resolve_undo(istate, index_path);
 }
 
-static void mark_object_for_connectivity(const struct object_id *oid)
+static int mark_object_for_connectivity(const struct object_id *oid,
+					struct object_info *oi UNUSED,
+					void *cb_data UNUSED)
 {
 	struct object *obj = lookup_unknown_object(the_repository, oid);
 	obj->flags |= HAS_OBJ;
-}
-
-static int mark_loose_for_connectivity(const struct object_id *oid,
-				       const char *path UNUSED,
-				       void *data UNUSED)
-{
-	mark_object_for_connectivity(oid);
-	return 0;
-}
-
-static int mark_packed_for_connectivity(const struct object_id *oid,
-					struct packed_git *pack UNUSED,
-					uint32_t pos UNUSED,
-					void *data UNUSED)
-{
-	mark_object_for_connectivity(oid);
 	return 0;
 }
 
@@ -1001,10 +970,8 @@ int cmd_fsck(int argc,
 		fsck_refs(the_repository);
 
 	if (connectivity_only) {
-		for_each_loose_object(the_repository->objects,
-				      mark_loose_for_connectivity, NULL, 0);
-		for_each_packed_object(the_repository,
-				       mark_packed_for_connectivity, NULL, 0);
+		odb_for_each_object(the_repository->objects, NULL,
+				    mark_object_for_connectivity, NULL, 0);
 	} else {
 		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next)

-- 
2.52.0.660.gd05f3a8ea5.dirty

