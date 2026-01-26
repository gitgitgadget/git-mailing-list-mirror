Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983D32E120
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421107; cv=none; b=gFQOMxmL6txk2mYSSXxxtVkJDZMtHVXkHvMjv+wg4OszYhcYpZ8BSJfc3kUPZT7Wz9UBDu5UdAB7NrHZ1tkHcCoDoqCZEEI8WYzp2aDv5NHYJrPSyXJ8RcwQEumHhp2mNY3ju+XkRUSasFuIRi3AqAEhmvc5kNZZaCHrdLdQits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421107; c=relaxed/simple;
	bh=blBpKqPQMZIO+BB6Rp/chyR6HRuWZD+lHb1+K06DFfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YT/2FjfJ2b9cn66ATkR8tP5kuUzcwNx+Hf6PtqxxTg9xnFnuT35rcx3ZNGl/9GL9LGtAvy7L5xJIwSCZpBJdWe99s1RdFLTMhANXmJdFf+vBMUhZflsYmbIJvFioXHseLKKqqAkDi1tpVnEKE8amXqE7Rw9Zjicq657UNY58TlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDk2JUpz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqYxJU9u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDk2JUpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqYxJU9u"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1FD57A0084;
	Mon, 26 Jan 2026 04:51:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Jan 2026 04:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421104;
	 x=1769507504; bh=5NXBJksbVedYheMhXZK4A8CCDCG0WrZgByJE1Dhhzn0=; b=
	fDk2JUpzyqntnbAZeyHm70H5jUOc5x0+EUcGhkMKdHnKwTXOfkDVMN7A/9oXhziq
	/f5+zmA7YZCSLsWr7vnOrIM67GBk7k0asc7Jscp/vUX7cxLphnHvuZ7vRs77Gvsn
	bqIc3r3qtRUjpJfgDE5e1v4XT4NMr9Xx+HWI23Jyk2Uw0MQbrgobfXAR+dnxsJya
	x9KtpVcL2DV9L6XraaJaalQxrjmw7ubKtmpmG3MWhVRDlqTPIaOLJol5V2daRXQX
	RjsuH4sDrDmyyl1zg1W/S/4dUXSee4UxCFIBcvE1/lVV2ejpbyZzeiEVB7EBUjpq
	gF1VOqBWNQhHhUEjknGkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421104; x=
	1769507504; bh=5NXBJksbVedYheMhXZK4A8CCDCG0WrZgByJE1Dhhzn0=; b=K
	qYxJU9uKR/qpuNiRtUVwKWbEL0Js54tyi/x1dLAZPa/Ijo65whaiqrYFf5jtnAcV
	VjvT2WluRDjYVqNrMCI3b+lv2x8uG1t7RLj3DCi5GmEysJkE91SDQBHMqq5ChuI4
	zAfmjSsnE/2sc0jhA9HaWwyHHqjIt0r8nZz7zhrNiA4gOed4eYy1hZiCzyyHTf3a
	5XcxOuMpGOoBymKzy9r616BHwWRfSLcITwhF8pf3nl0CZ/EGuRZGlCbuDwZE4dHM
	iS09igHYcHowkz3AE9KE5U53dAmHQNY4/uQMzV2/At42kT/vsXusTx2Ee/dGaNxu
	nizQG4sWbu1xJd/yiBHuA==
X-ME-Sender: <xms:MDl3aVwlb0JlAMOoq6mHWmtyhp0CkDdfGjYBeaxmzRmn_xulY0AwfQ>
    <xme:MDl3acRQ4sB5-TYwNPJ74uuFLRQkmEBOGdGvco29lqq_egPJSa_hOdRBn1Du4MRWj
    -wIdgLo-ks7kju8Ga-3RHNz3Oaxq_RZM08QsHKxN2QZhm465fz0Gg>
X-ME-Received: <xmr:MDl3aUWJhk_qNafGefDoCOaARda2OeB0c-p6suOznwFzLRdp3foN73f2bCpEPQuMccRdPpOHnO4AAOuj7_C-lZXL4bukRuz3w6yheKA9JybdPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MDl3aWZ-WPZcTP-ADjddDvvf1uFkW7umA2p3dKPX4nDGAnd8KYmr_w>
    <xmx:MDl3aS2rhgywz1pdB-6e2UfwNlxF9SJZu89EQdZNThtb3GqLBqtMww>
    <xmx:MDl3aQieM3U5KvcmgT10JD4bmhmp6sj11ux_BihniBVy2VjqtjLFsg>
    <xmx:MDl3aeaMQG7ZAypqAwAKBzxqE934nxlG1ZZkVDvKRPDowsRBNCjZtw>
    <xmx:MDl3ab0X0yGGl5xTzoLcEc4Bg_neACbUCrEfewVZSNOrDj7eR515VvWK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f8b909f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:24 +0100
Subject: [PATCH v4 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-8-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In git-fsck(1) we have two callsites where we iterate over all objects
via `for_each_loose_object()` and `for_each_packed_object()`. Both of
these are trivially convertible with `odb_for_each_object()`.

Refactor these callsites accordingly.

Note that `odb_for_each_object()` may iterate over the same object
multiple times, for example when it exists both in packed and loose
format. But this has already been the case beforehand, so this does not
result in a change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 57 ++++++++++++---------------------------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4979bc795e..2ebe77d58e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -218,15 +218,17 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 	return 0;
 }
 
-static void mark_unreachable_referents(const struct object_id *oid)
+static int mark_unreachable_referents(const struct object_id *oid,
+				      struct object_info *oi UNUSED,
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
2.53.0.rc1.267.g6e3a78c723.dirty

