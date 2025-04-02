Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4E23958B
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592434; cv=none; b=E+cuc/CHV6JX5ZME9aF/Yv+6yWD9kTcCnLUnyPn19fUQHvLx12PZJSsiQiR099Z3DaZJTlRN2XvA7z7//2i3uODOIxCHudCfftAbSTjdxt8XApJnP+ss+FCaJeyQVQ3SlKW3Rhxa0u8BQpF6xoxLBTbeSDh6iVcE8pw3cNzjIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592434; c=relaxed/simple;
	bh=NrAwLQdgiG4EKY8Sd7s4LFLOxNX2CDWW/389OtiJ0Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PI4B/HXazxDBDRV+ca7Z1Nnofljysoya31axJw/EuhhREYDGVMVU+EAscg0pkqQtAbKSaQytD49o3nXSvuHKENk++kdvXwwDWMsyANXGYTAQXpvgT0zESqCnOfHaOxfhe/gDSNg9784Y/uKIbMTOGcC0YRcepa/JIWCAbqVlC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ArGQN4nq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahjmv6c0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ArGQN4nq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahjmv6c0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA2FE2540253;
	Wed,  2 Apr 2025 07:13:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 07:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592431;
	 x=1743678831; bh=4R+T3Pip4DSK6QfxWQZvmMIfTzXFaSIZXU7ViGJy3Ig=; b=
	ArGQN4nqhdRYrKIbDhxTV7OJXutQ9kO0RxaLFaaAm0GaJAME/YWf7W5ahwWdUMkF
	Oskbj5M6y5X7VvCkQZwgRMZZu1tPoSLy9664QVSpFHauwtExkaMtCtI8Dm8rQg1K
	4PexlqeGlFfSgv2KPtM2fLgu3DsaiBzt9ctHX343gHJkGspQE6ejphkAnvQ7nXGQ
	+GCq2dkNAPm/LpvM1GRfipZ00sJkHMk8e1Nx/Vf3UbCSVof9Q5kkz6Fo0KYulurs
	kzj5nMiLurvw7/rRKRMekWhs8F39VP8V1LFiqUV8qepwFljk2M9HE7CcRYDbOTjZ
	k77jzICkLR+H5WBR0/xaSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592431; x=
	1743678831; bh=4R+T3Pip4DSK6QfxWQZvmMIfTzXFaSIZXU7ViGJy3Ig=; b=a
	hjmv6c0Ne7/V10BRLDeeo/Pu0xD0rN5E5zR5im25E4ib6VIwEf1aaLAXgs4o1ASG
	o9C8QSwPPH+08Oc4L8EPB/SunFidqIN6+kdF0rOQmEfnGBnSctzKfNhbR6ZT4xNf
	7vQyiboWYY8m4WiXQpX13U7QR89cg38dJOuDkiMRgxrB4UWuP6B+hh+Ig2MtuRwk
	B2+JuTWVGyeyagU8iSS2FnAQ0/FHiAmgHkeJGK92W8XWOCL32Mar8fAZkOq1Ca1n
	LPorvY7f5Wgwlu8iSkCyA/yh+6LQfZ5FF92rRDG0yWJwQXTyj6SqZL2YVcMjRkVv
	LjDQwxM/Fo5PDFqGiExvw==
X-ME-Sender: <xms:7xvtZ1NT9Ol063vd6j5tRzcyvSoOHXh0NTCA0AuEpxZCEA7iCbeY4A>
    <xme:7xvtZ38oXjIQmMqGNMFOQwstoohMKzf7IWYIm6z3LhJqyNyac3Rhf4TulbjOMSLGh
    Q9EHXJW4QDwRpQioQ>
X-ME-Received: <xmr:7xvtZ0Sw7Xj-usdbE6XG4hMQpvOkinnljzFM5zEcvTNxae3Lw_b_AyDBWNYM-wfS1nhvzsmIFWCxIBVUmG5rtssgl1adYSLsJ_pHSy6FNftvIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7xvtZxuRJMXp9sFdTby_RvkTtfp8lKsbaRLQynMmMvjjBQCSBsGihw>
    <xmx:7xvtZ9fOFzYftXe4629-3wfRDVU3bw4ygSOTFNC1nsWqSjaJ8QTbvA>
    <xmx:7xvtZ93XEg3Ll88SR_1PhTfFoAub1rN-K9oEU02XhK2nszgF5O9Chw>
    <xmx:7xvtZ58IUJeKJqoXPhxBJ5IHlRILv31sF_R-GK3bFseg0ilDsXl7KA>
    <xmx:7xvtZ59hk2MRzQEOuRdCSXskf-26C4o2TDw3vXjCHOwnHteqR_is7z9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80a1dc22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:42 +0200
Subject: [PATCH v3 07/11] pack-bitmap: allow passing payloads to
 `show_reachable_fn()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-7-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `show_reachable_fn` callback is used by a couple of functions to
present reachable objects to the caller. The function does not provide a
way for the caller to pass a payload though, which is functionality that
we'll require in a subsequent commit.

Change the callback type to accept a payload and adapt all callsites
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  3 ++-
 builtin/rev-list.c     |  3 ++-
 pack-bitmap.c          | 15 ++++++++-------
 pack-bitmap.h          |  3 ++-
 reachable.c            |  3 ++-
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a7e4bb79049..38784613fc0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1736,7 +1736,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 static int add_object_entry_from_bitmap(const struct object_id *oid,
 					enum object_type type,
 					int flags UNUSED, uint32_t name_hash,
-					struct packed_git *pack, off_t offset)
+					struct packed_git *pack, off_t offset,
+					void *payload UNUSED)
 {
 	display_progress(progress_state, ++nr_seen);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bb26bee0d45..1100dd2abe7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -429,7 +429,8 @@ static int show_object_fast(
 	int exclude UNUSED,
 	uint32_t name_hash UNUSED,
 	struct packed_git *found_pack UNUSED,
-	off_t found_offset UNUSED)
+	off_t found_offset UNUSED,
+	void *payload UNUSED)
 {
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
 	return 1;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6f7fd94c36f..d192fb87da9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1625,7 +1625,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 		    (obj->type == OBJ_TAG && !revs->tag_objects))
 			continue;
 
-		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0, NULL);
 	}
 }
 
@@ -1663,7 +1663,8 @@ static void init_type_iterator(struct ewah_or_iterator *it,
 static void show_objects_for_type(
 	struct bitmap_index *bitmap_git,
 	enum object_type object_type,
-	show_reachable_fn show_reach)
+	show_reachable_fn show_reach,
+	void *payload)
 {
 	size_t i = 0;
 	uint32_t offset;
@@ -1715,7 +1716,7 @@ static void show_objects_for_type(
 			if (bitmap_git->hashes)
 				hash = get_be32(bitmap_git->hashes + index_pos);
 
-			show_reach(&oid, object_type, 0, hash, pack, ofs);
+			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
 		}
 	}
 
@@ -2518,13 +2519,13 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 {
 	assert(bitmap_git->result);
 
-	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
+	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable, NULL);
 	if (revs->tree_objects)
-		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
+		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable, NULL);
 	if (revs->blob_objects)
-		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
+		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable, NULL);
 	if (revs->tag_objects)
-		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
+		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable, NULL);
 
 	show_extended_objects(bitmap_git, revs, show_reachable);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index dd0951088f6..de6bf534fef 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,7 +50,8 @@ typedef int (*show_reachable_fn)(
 	int flags,
 	uint32_t hash,
 	struct packed_git *found_pack,
-	off_t found_offset);
+	off_t found_offset,
+	void *payload);
 
 struct bitmap_index;
 
diff --git a/reachable.c b/reachable.c
index 9ee04c89ec6..421d354d3b5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -341,7 +341,8 @@ static int mark_object_seen(const struct object_id *oid,
 			     int exclude UNUSED,
 			     uint32_t name_hash UNUSED,
 			     struct packed_git *found_pack UNUSED,
-			     off_t found_offset UNUSED)
+			     off_t found_offset UNUSED,
+			     void *payload UNUSED)
 {
 	struct object *obj = lookup_object_by_type(the_repository, oid, type);
 	if (!obj)

-- 
2.49.0.604.gff1f9ca942.dirty

