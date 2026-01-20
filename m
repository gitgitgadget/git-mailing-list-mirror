Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC3466B61
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922800; cv=none; b=eTPoq08QliVcoGRk6D3KCvfqnymMg3887E6FkgPLcJrTQxHfrH0rd+RkI7n6BhixmlqHNAVAg4P3ieJZF7mC+mJxA/48Qm/TCisgAxBuKQF3/zInOxGZnfs8aGGw+eULysNEPjLa1YIQW3pyIEDtsXpxDUvPONo/82sbQdgzg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922800; c=relaxed/simple;
	bh=hAPxeJkOZFwf+CJn3fjeADcz01w9Q5PXtDASFh9Vacg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBJV6Cx+cxjp3R53zQDGh/gt7i7GwstTncVOzqTR8LpyxSrxbDgdgGutB1oFkXuFb9xVIXSn3P8ME4ZPDjLZktJpEPB7lgAmbQ0Q8lMz5Jvz4cKDCP+luRzamBSMrhGqgZjZdm91NtmGQa8cf+1KBXQrB/9Y5Vd3xm7p9rbaiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h9v+VCWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBdnixMZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h9v+VCWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBdnixMZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 533D57A00D5;
	Tue, 20 Jan 2026 10:26:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922798;
	 x=1769009198; bh=kSmNKoc8XrNT58i7vtbX2clY0aqlvdD4JGgfdIEW7AI=; b=
	h9v+VCWoKeSJ4xZN7bCHK0D1us+ZVSmoS/L34IGoznKyMoR/mxz6b7zVlOvPIJAT
	4Vii3jXbEVLpJs8r9AUZSblcC7c3FujwrYgAPZOxahUPan3djElzlZQKpJT157L8
	3QllKVpz5d/OqcJUO1Tcw4XsS+6muWpaLHlLZzt0N1GIoPsiYix5sEejij9vgA++
	JIG903XMviPdrgf31d2XgCYg5L84gJ2vqBwFPc/A34s4/pMzO9vk3ttwPPlMxFkM
	JpTzknYY2PhzakmVsArkr7frnIFrfGp02ywBvfmmCSKcNUnFAQVRuwcRb4jFWtBw
	zlPDU+A5FChBWvr3z5EVcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922798; x=
	1769009198; bh=kSmNKoc8XrNT58i7vtbX2clY0aqlvdD4JGgfdIEW7AI=; b=h
	BdnixMZK1lE9WwpKwANZL8Og4MDbZjubmsyHZPchLB5q6Pzuu3/J1DnVX4xPl+oz
	XS5UGDf8ZlGvMLoVqj2td2FdLyqFWbjAkKLjp7ibQLmieHSw3r3CYxeNnySSq/Ck
	MV0ioBhXSXkvnOUURRFax9Fn1lHmWcdL4t0FEBX4SlUSun0IhKkzhzKTxIZxsTne
	cYQqZ25HBJSObm/su2JRy8TJJ+HObFZS+Ez5Ie3mPvxdT2mlWjtGka74W4p3VCfP
	Y2UbDg/SZ0dowJQU12WJqduhORpfkzgEKgLJ6Z4gFBGqIaFVB6QLvDhy84AIamEf
	HOhXDeY/2eV3hZK/OzCDg==
X-ME-Sender: <xms:rp5vaevfTuyO5S79Eto5Z_33mwASUj1V_NNfnXxAK6a_cNdkUeTTCQ>
    <xme:rp5vaac5lRRdu8xBcLMHZ1g5c3ZSSIhgx8b9_Ak3bjj5WKfnrUUo6MMtw2SMcQWrD
    IwnJjcwAuGrS6eC0pH1i8oeALMngXkP7_3BGEEruCRvX7tAPTcyeA>
X-ME-Received: <xmr:rp5vaeyjMzuu5L0mK6HblMKXqHCYCQowSbTkUc2WgTYClU5kkFzI1a0QzH9TdWs-Po0Z2tinmSRytwvH8Wh7hO1C26t4QKFxoOKmM0xoEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rp5vaYHh8jivGpas22HRCq489LTLSZ-_Qy04oHqT5S-AFLyzfVTd5Q>
    <xmx:rp5vaawfMeSkZbL034kH6w1Cw5lFXr9PNsDl4E5ULV_3mT5ka7B_sA>
    <xmx:rp5vaRtShfQf0SuplNBlRHZ2mOt4Xiqln_gj5jmkXKAmcaBy_uxP4A>
    <xmx:rp5vaf1KV4cnz_pAvekyM-7rJkcD37oK9rS5o70HPH0DXeKqcU7wpg>
    <xmx:rp5vaYua-Q4oibRO86Ei9GPlh-gBx-glbssjgPJgyLxvKMmH3X2i5eFF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e7e5d672 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:04 +0100
Subject: [PATCH v2 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-8-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.53.0.rc0.250.g0ac79233d6.dirty

