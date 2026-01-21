Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5648A2BA
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999857; cv=none; b=ebqZKlcM+9h0ycVp0slw8T23y4rlEk5/ZG8IUIuqpPGzQTjUofyn6iy7MSK6OKHwbQOSFaJr5buxY6D4OjZxzasbPLSSSOeS+LobcFlpMK7uzuZiUWRyapEEa2MYQbjLfjO4LM+QB/BClATu+f4a9UR2fdXc6Oq+KMTM/cYZkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999857; c=relaxed/simple;
	bh=hAPxeJkOZFwf+CJn3fjeADcz01w9Q5PXtDASFh9Vacg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ky/rVnGkyLM4nsuS3mAf9bevhEs3wujOq2Y7acxoRtwOtsg7fKgnEnOe6jsAPvX+rKfgVYs12ELJ/j7dTGdBkhPyoNlaybMkwfjYZwKdpq7qr5KvcN55LpovEPnTN1bcYIBGRp+B9unNp6FJ1fR25h8PkC8SRZilXtihCLTRA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bE3dr78a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjFTILmm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bE3dr78a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjFTILmm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B8607A0152;
	Wed, 21 Jan 2026 07:50:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 07:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999853;
	 x=1769086253; bh=kSmNKoc8XrNT58i7vtbX2clY0aqlvdD4JGgfdIEW7AI=; b=
	bE3dr78a2xHDk7jfbugTV3Strd9j0tZLA1aWpVwqMcFyl5AtVi/67ftYBMP4PUka
	ycKU+WB3d2BbEk5Lj1TcIiEUZFQlA+3T/o3tRk1AMcZLKK7bv5QsptWP63GuGnEm
	2kyDMM80x0LgtHN4wP1eo4tx67WoI9/sQDFoDPUBwk7YeB1/DZhpO6IcMGmDRLvG
	N0aiUWiZkmSlrf1T8NYNR4QzfxHdl226lrExd3IYnj8KhWw1rVA9oiduVfsujwNT
	At05AClzgzp9nccBtK1Tr0+Mj0sIALy6tE4t0lMqdQJ3GmJiDh8w1ZVUtuDRyjA/
	BeHhB/CZGE1POCAdSrRZTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999853; x=
	1769086253; bh=kSmNKoc8XrNT58i7vtbX2clY0aqlvdD4JGgfdIEW7AI=; b=m
	jFTILmmD/zK089ZdUxCXNDpK2tU5ISwLeizQWD3ZMdxygwgBSsJ0PrrnaiiJHkvW
	o/I8dZQ8bQ0FKH9efmVaXkc5QST2O0WD/eQQD5HxqNQYLEuSTSjt9t5JfL5Nege8
	eZxyAHw06dlHMBtxAL3YuTxpwUGa8smIzyR+2+881467CICUwyWILZumdm/FNg/R
	9boI2y0Il2vXtVZU5f8muVcByKtH2ZcK3uDTw/Hke0DN2fazdTvp0m8F09e6PRw2
	enOI4Szt9igCwH4Apvxt4IFB3sHQSCISmM46ckdQayqDGh2SgydLEXrTzHTHBbqS
	frzeQhLBUBjtNkVJ8IWow==
X-ME-Sender: <xms:rctwaZTwCWG8rhUX0Dd9dUyxjlyrJ0ie6eAFergbHo4cfv0pzcBuNA>
    <xme:rctwaZwn_8IvqjZD5c3vXhl0vqYf_-siTuGAQFNOF3ydSYZfq1tZmwY7sHXv9Yh4S
    2W3e0B0m82IlWKEV27L-xzLAjazwmdxYMIcK6K5oeKLRua0qiN6>
X-ME-Received: <xmr:rctwaT0T9H2aJcCTEguRjDIpK0vm8rUWK_E3lTQh7Bsc8exAnS01n5cpxaZnQmu1JWU2_46MpaDzv7KjjDblXQdbvk4ayaDRJJ-vtzsOwrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rctwaf4MkWVgXeALj8kk7g70LpillBa1evMVYwPXa88c1q2ktt5b8w>
    <xmx:rctwaeXx13uhZIPrIb-8qAc43BDb-CfxlH3TH_uFYOHjeJ72TVIq7Q>
    <xmx:rctwaWAK-KHKMpuWZdYJYUTtxWa7hP3P_oUuAXnHUlJlKYUcjWpPvQ>
    <xmx:rctwaV6-WSjseVC5QCVOHUiyJX1TnvkRH35MQHUgTfoXzd_l-64uwA>
    <xmx:rctwabXH29ccuNocwW-YmkXp-sNBhhw2D6TEVZso4HxDc6m_A4xkoaey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 68e14e16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:24 +0100
Subject: [PATCH v3 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-8-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
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

