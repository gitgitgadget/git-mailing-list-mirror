Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA993B7745
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278220; cv=none; b=eJn+FVI4hogcCG56RidMoVgM1CT6PHIGH/B9FHBDYbDwWB0V/rCL1muPzCViXyhiXMkZdjcpW+c+OSOL/nN8y1TCo7fbN74U3rmYmOP74LUAWL+s0+yIMkti8FQHJQtbndInt9dNnMOunbtxOn7+yD7dvUWO3BY7/NkWHwh515o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278220; c=relaxed/simple;
	bh=0vnvYSGDWaFABWiDSFMAb34WuYp/itfRt/aBZo7eQ/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCP9RTiHmekn22xyipTOxXChHe5HAg2PN25h/lH932Xw1pYV6wTFgleM4fyDHEMOJMB8/WAPO3K0TT9iF1DUKo5OD7QnBpyBNBBOTAFEIn/w1osW88u9z2E897hx/ZP7yFNT0vbZce1KsPYpUqSPy1amr2UdtvHnJi8/wpq7Aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EyOLIb3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bv4N62sS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EyOLIb3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bv4N62sS"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B651B7A01DC;
	Mon, 23 Mar 2026 11:03:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Mar 2026 11:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278218;
	 x=1774364618; bh=JY45H7qdeJUWQn7YYGLL8/LZI4CwzEr+EHYFDEEY6Og=; b=
	EyOLIb3Lc+PRi4FUOsyCdk7SdhVLng3r1kFTMK0x2L1+NQnKwOq9XU5wVmDIoAYa
	i/+UR8vWIauJfVD/rq5s4sH9x9GIKD8yiPndFZ3glbGpsWTliPe0MNFmKllkBbFh
	P1ss08lX9nIr8SjNF/WboTo7TN/AGukXcx2g7UO0UblkVuXmfaS6II8y65ukMYW+
	C1Grwtyd5hvwElHLbmPj+axbddshiC/0JQBrSa1TUlmoqyp+igaG7H7KCriOTzLi
	7eJrxkhGdFUzHL5CvA9hwR6qUCnfVFE0jZcWua3kCP6/plkFKfBrzA1xo/BdzCLi
	08QS3XpHUMpuBvYmrYlWoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278218; x=
	1774364618; bh=JY45H7qdeJUWQn7YYGLL8/LZI4CwzEr+EHYFDEEY6Og=; b=b
	v4N62sS/Sa6kLwww4GrWzqrTm9uYj89kXajeol65qK1YCBwgmKA2nzvPD+/e/5P2
	DZlS+o8uYelRdQRmpDCiWn+cpAGHQe8fRMwb473tFYQaOGqneEVmA8sDSQuARMF5
	/1viRWQedqPH4jwL2C1GpiG7DFAD7XoSyYANgESBTWCfe8bVP0Mf3E4yQDwWr1+1
	eRAD3azXYSm1pwI+DPQDSnzwzgu4cIzeOZjviYHrPy6SiRRMUInhGunEChQaT6Rf
	YDDbAcJk2aVdHiWwKfADASOxDwPPYycHlUn32t/Y8mOFHifxmljZMuwrmM7/zegX
	6a39GrQdiC3Va2IOZylXg==
X-ME-Sender: <xms:SlbBaa9pe2jzaz702ACUWAsFEWDfO3MLc7HULxgFP_Z2StALm7ksxw>
    <xme:SlbBaQvZZmVzxcY02LQUCYlwEmTD1oR-NNZvKqSTMk6OJM3eNCQVzw4wiyv0kW4zP
    jCpxKzcI7f0WUJsAP-Aw55Bc2a8z8TLDzfiIDPY_UeoR-pdSFx0ul8>
X-ME-Received: <xmr:SlbBadpBN2gun5t8tjvrxC1zAEbYlOE3AUaSU3a7GkOqtyfcLjfHFxQqpIspv92NeQrxqn6r7fBRci06kw9xjnZSfmxM7FwkQevkrApPKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SlbBadkug-0Z5PLUIfuPtKMochBp3saQqV8k7VJf8sJ8hlhiaDt4Wg>
    <xmx:SlbBaRxmxEQvUALhinXZAjtFII4Xril_6vZVcYbXcAZLo8vTe7nLxg>
    <xmx:SlbBaVmNxMLmZFPND_IvzogpJGqo9CCN5ImEB6YCMKmgikOStogM0w>
    <xmx:SlbBaafXTtyAv6mvYXRskcAWbIGG6LyA1x_jUQvETO9Tg4iLSeaQkg>
    <xmx:SlbBaWX7yd26YF5-mgKVK7ht8oNhQVngG0_usfOzjEi1Da5rPTmz4tqx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84d47ba3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:03:02 +0100
Subject: [PATCH v2 11/12] builtin/fsck: stop using `the_repository` when
 marking objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-11-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when marking objects for
connectivity. Refactor this to instead inject the repository via the
callback payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 22ca1200a2..e37f708480 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -124,7 +124,7 @@ static int fsck_objects_error_func(struct fsck_options *o UNUSED,
 static struct object_array pending;
 
 static int mark_object(struct object *obj, enum object_type type,
-		       void *data, struct fsck_options *options UNUSED)
+		       void *data, struct fsck_options *options)
 {
 	struct object *parent = data;
 
@@ -153,7 +153,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 	obj->flags |= REACHABLE;
 
-	if (is_promisor_object(the_repository, &obj->oid))
+	if (is_promisor_object(options->repo, &obj->oid))
 		/*
 		 * Further recursion does not need to be performed on this
 		 * object since it is a promisor object (so it does not need to
@@ -162,7 +162,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !odb_has_object(the_repository->objects, &obj->oid,
+		if (parent && !odb_has_object(options->repo->objects, &obj->oid,
 					      HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
@@ -181,7 +181,7 @@ static int mark_object(struct object *obj, enum object_type type,
 
 static void mark_object_reachable(struct object *obj)
 {
-	mark_object(obj, OBJ_ANY, NULL, NULL);
+	mark_object(obj, OBJ_ANY, NULL, &fsck_walk_options);
 }
 
 static int traverse_one_object(struct object *obj)
@@ -222,10 +222,11 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
 
 static int mark_unreachable_referents(const struct object_id *oid,
 				      struct object_info *oi UNUSED,
-				      void *data UNUSED)
+				      void *data)
 {
+	struct repository *repo = data;
 	struct fsck_options options;
-	struct object *obj = lookup_object(the_repository, oid);
+	struct object *obj = lookup_object(data, oid);
 
 	if (!obj || !(obj->flags & HAS_OBJ))
 		return 0; /* not part of our original set */
@@ -237,13 +238,13 @@ static int mark_unreachable_referents(const struct object_id *oid,
 	 * (and we want to avoid parsing blobs).
 	 */
 	if (obj->type == OBJ_NONE) {
-		enum object_type type = odb_read_object_info(the_repository->objects,
+		enum object_type type = odb_read_object_info(repo->objects,
 							     &obj->oid, NULL);
 		if (type > 0)
 			object_as_type(obj, type, 0);
 	}
 
-	fsck_options_init(&options, the_repository, FSCK_OPTIONS_DEFAULT);
+	fsck_options_init(&options, repo, FSCK_OPTIONS_DEFAULT);
 	options.walk = mark_used;
 	fsck_walk(obj, NULL, &options);
 	if (obj->type == OBJ_TREE)
@@ -385,7 +386,7 @@ static void check_connectivity(struct repository *repo)
 		 * traversal.
 		 */
 		odb_for_each_object(repo->objects, NULL,
-				    mark_unreachable_referents, NULL, 0);
+				    mark_unreachable_referents, repo, 0);
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
@@ -909,9 +910,10 @@ static void fsck_index(struct index_state *istate, const char *index_path,
 
 static int mark_object_for_connectivity(const struct object_id *oid,
 					struct object_info *oi UNUSED,
-					void *cb_data UNUSED)
+					void *cb_data)
 {
-	struct object *obj = lookup_unknown_object(the_repository, oid);
+	struct repository *repo = cb_data;
+	struct object *obj = lookup_unknown_object(repo, oid);
 	obj->flags |= HAS_OBJ;
 	return 0;
 }
@@ -1065,7 +1067,7 @@ int cmd_fsck(int argc,
 
 	if (connectivity_only) {
 		odb_for_each_object(repo->objects, NULL,
-				    mark_object_for_connectivity, NULL, 0);
+				    mark_object_for_connectivity, repo, 0);
 	} else {
 		odb_prepare_alternates(repo->objects);
 		for (source = repo->objects->sources; source; source = source->next)

-- 
2.53.0.1118.gaef5881109.dirty

