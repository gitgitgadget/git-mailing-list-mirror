Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA99280CD2
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278209; cv=none; b=dlW/FN52ACUa1XVxmtn8yM2NSgAxpmjPpGxRd2eGJXFOWHfLtIpowTOfTzAM/6M925/XIj6oJJM6XGa7724zA1pbjvDvIv98+ImzRn3/sEfXydpcfWTI0xJ+Dkb+sGmMQFlsigNqdevCIVjmSH4/U9Ry9US4vAmdneUsrcV63kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278209; c=relaxed/simple;
	bh=ul5onwc2IFOq77/3mGQhyvd5tTUFLZpHs5VvtLGZ+/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AoK8Zp6DSAQ40ApJSJjtUFCILqfy48QWtNhw2mnCrYaRQpEM2txJrR/MiFr6oPBzWTKB0Ax7rmwlu5eDZLPcfOL0ot46JVLRAaf2lElVHhoU2E+fOftMJ5NxVGj7I5u+V3j/yws/WTczHncKDiPTSK5znGJxoOPzmB70guH0D8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZbfGZh8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIaL4bag; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZbfGZh8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qIaL4bag"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C8547A0150;
	Mon, 23 Mar 2026 11:03:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278208;
	 x=1774364608; bh=4HyJaH41+uIU1izYZmXuCOgSUhmPJNAXshopPGXCgg0=; b=
	TZbfGZh8YjamWeP3spJf3IeBOFGWhETKEjKy02rsauCWPtFJax69Krvh69deVauR
	JXkjRlZzQhX3x4pa/J3x6h9a8g34bmdlKRGCarmN9ot1SQlDHlJF+/9Qry60wKp+
	ZfHays2rEQBoxnoX3uyvcpCqDfkq0l1k7tVKQX37P0usu4ds+W7MtI94SS+lNs2X
	UHR0cDB5hdQf3EKYPwvum/PFnP+mWvJ82kLRuTgbHOQB3a64YrjbQO+c9OK1hBAt
	8o+Om1GytOEOhx6iyu6zujxEmHGLbW+Vv9aEa/bkhBJVeGEEIKdGK/p6xd2p36Hl
	hAl0/UDatpsp9exUx7rxhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278208; x=
	1774364608; bh=4HyJaH41+uIU1izYZmXuCOgSUhmPJNAXshopPGXCgg0=; b=q
	IaL4bagONfqhmO1CU2lWn14Xnk5srLbAFGRHTc2yKlSbvQGD4BuI/8wJ7vG7xETF
	gEvwN4ZOl5zVlUL9hWtqXI53Edv3NrIHCYAldOxUcQldcIju06LEFNjXA+ZliY0e
	uT45HeQDWs3Qy/cgQIbqFi80wZ4zmNxs0rdxALmKcP2NBN9+tmWLCWpljkgb/4zI
	y/WD9t/pJWcim68XgdMR33PreKO1FAU1kAzMi1qXip+nV5vmD/9wfYk5kieh5w0N
	Rp1ITIEVqfoI25E80QChwHxckTurgSThtL8blTtCaRKJ5vHcnGA0FgXVQhaZlffP
	fH/f9+RbCHqKMRBFaM4rA==
X-ME-Sender: <xms:QFbBaQ-huxZTjCbwxzrRjpGCxwZrkSIa_cQDMiIWapeobwiYF69moQ>
    <xme:QFbBaeus_pT2Na13ntfP9duyOsxqA6jYoGFXjF_ei3oy565bVUjRCQvy_cK119yp9
    _73PCf0Rt6r2OJzJIluJchiiXRgmcLdXUT21ukEudlna135JDMpNw>
X-ME-Received: <xmr:QFbBaTq4t6ZOx1pqyj6wW6rbQAaxLKX1cygj1Q1dsKEYCoXnOQemwYiFGX06W4seR2skBr040YshE-2mvHPdLvacqGKd9-rNZ1xuAEdYrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QFbBabnVD1X7zx2EtSGqzmlSXomNfb8EoQUN5cBlSXJweZHjKNJ_ow>
    <xmx:QFbBaXyzFNCPaUuEXF-uJbKTCu5RSZcD4AyEnECAfpp7FfWRnL6vGA>
    <xmx:QFbBaTm_-c3PEexycczHEHSRwGupgXyXOszcbb19SeEny1ijvqekMw>
    <xmx:QFbBaQdURKcvBMmAXbUspyRO-EQBkVisBg_sVNvy-zncPY_UrhAiVA>
    <xmx:QFbBacViWbRSMEBvH_xGBcTSkh94icSJ3pO_fNmX_92df1Jls9c15ls4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ee64bee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:58 +0100
Subject: [PATCH v2 07/12] builtin/fsck: stop using `the_repository` when
 checking refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-7-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when checking refs. Refactor this
to instead inject the repository via the callback payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index edbff16add..efc60862ae 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -574,11 +574,12 @@ static int snapshot_ref(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
+static int fsck_handle_ref(const struct reference *ref, void *cb_data)
 {
+	struct repository *repo = cb_data;
 	struct object *obj;
 
-	obj = parse_object(the_repository, ref->oid);
+	obj = parse_object(repo, ref->oid);
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
 			     ref->oid, "%s", ref->name);
@@ -665,7 +666,7 @@ static void free_snapshot_refs(struct snapshot *snap)
 	free(snap->ref);
 }
 
-static void process_refs(struct snapshot *snap)
+static void process_refs(struct repository *repo, struct snapshot *snap)
 {
 	struct worktree **worktrees, **p;
 
@@ -674,7 +675,7 @@ static void process_refs(struct snapshot *snap)
 			.name = snap->ref[i].refname,
 			.oid = &snap->ref[i].oid,
 		};
-		fsck_handle_ref(&ref, NULL);
+		fsck_handle_ref(&ref, repo);
 	}
 
 	if (include_reflogs) {
@@ -1095,7 +1096,7 @@ int cmd_fsck(int argc,
 	}
 
 	/* Process the snapshotted refs and the reflogs. */
-	process_refs(&snap);
+	process_refs(repo, &snap);
 
 	/* If not given any explicit objects, process index files too. */
 	if (!argc)

-- 
2.53.0.1118.gaef5881109.dirty

