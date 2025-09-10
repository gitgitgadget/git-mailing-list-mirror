Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F78528E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509946; cv=none; b=qmWHJbK8gyrb9XG+VSCsEEz9H7GZ27cvwGcbyTqeuPUbVhLUi9OVjsOpqdjrqrKnrPbGecsKK7q0efzsZHCtbXWYjZm2vKJYxfSZ1uNWpfpkzzoVn7wfb7Wu8m58PBAAazmEAcPqHqPOW9b86soJ9KbGgeweQkIUZRBa/ZhQg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509946; c=relaxed/simple;
	bh=Q/7czHTIfPAGoS0SD0YszurmfK+IajU9q4FQwLz2eG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f8kH624Nj7pyhHLp7y3/Dw5v3wuWXcoXAjDGJOMtG8bl3iQ3swqxi3nag9ab5j1TnWFerw0jI/ta6mJpXEeRxzSEHwnbVKaTV6iR55T7fYTani3/vCS0fYVb8CEcBx008WZaXhgpMGeIfQnSJZpI5MF7TDEJETvTmYi9S0f/aG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XIOXLpHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADJXxYk6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XIOXLpHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADJXxYk6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 269EAEC0390
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 09:12:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 10 Sep 2025 09:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757509943; x=1757596343; bh=qyEILq6gnf
	d+2mXJ1VCUyYX64eB7s63yxz/WcNuvbo8=; b=XIOXLpHsNhqbM9+ynNFQvZPLr1
	OIiqfNd5aZdXnwXWoKDmaWpfkBnYO7F/3o6jcEAoZfkiahk0C+Wn/OerLiuyKtmr
	wCjWHUVM2OYyumV8ik41rJ9I761BBDRbR4qe5xUQm1Zm7KUNps7ibYZjSGcl95q9
	kf2AQ55ZTBelWasyc0EX7DCx7hCIahAwhgnvlws4rCth9arec9f4Zgbnf5ShcHwP
	kJAxMsC8OXvSmcKMs5QhbTLQ97nS4cXdA6k2UsQZm9dQFBJdJTFd2t2d/j2wNYJh
	wqJ5VXRGBX3y0QUskgAEeTot507GF7DM7dEjgkHlJ6lrPJ7uM5K3EcrP1iNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757509943; x=1757596343; bh=qyEILq6gnfd+2mXJ1VCUyYX64eB7
	s63yxz/WcNuvbo8=; b=ADJXxYk6iewFhXkLqp6Mu7a0269XyCkyEgmaTwKq704/
	cTzkN81uGDQXpu4kTDv3UxBOlHKuvYiNxfZfYcqGqB6Qy/8jz9ckPT9FZAcVrZpz
	+TX9AENBZY4Znptq5rGimUPycMOl9vmSQhF1FmxYRFsyI0/CtX/Rm6M04AtAGEhH
	Gnczwy/n4qIHyaBGWoz9e/zNe1nztruNWbCyzRMeyU1kfUeGsbo/8Z5/KYyhu/m6
	+4eCf3lz45F0FrQQzXZ9Q0rf9hWGLqOi9OiNjhl/I+ai7IOVyPABRQIqiYMK9aef
	cq+WKWNBhbGrTFBdRYH31ofgVR9M4KUE058ap0r0FA==
X-ME-Sender: <xms:NnnBaAsbUOzMLvk41PirPpu3CmrjGQkzSovnwyBvBJh49JEGcEvhFg>
    <xme:NnnBaPfQrYq7TsaNP0DOx5BT93hXK7aPHGDLM5PmPXYEwkeGkFLM8fKoCJcEmcWl-
    Jv1IJgjjjuLQ5_8QA>
X-ME-Received: <xmr:NnnBaFJk6XMRQwf0fiiuLZAZtOJYZt0fqzZOsmKxw7qY3IxwnmRWD8e4WhSMdS__l5DtVOoViB_hRm0Ju4-Xeoadp-K9hSf8yIWbn-nyiHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeigfeitdffffdvvdeuheehjeehheeludduhfehke
    ekgeeggfeuffehveegteejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NnnBaFZYPkOpm1MBMaiAZuN4MxGIvGCnG-b3OBBtwzYfogZUghSYFg>
    <xmx:N3nBaIvN22kMCPlG4-RaRHzSC42hEmeVYs2VT_sJgo8YcI9Rff4aNA>
    <xmx:N3nBaKtvZKLW2wTfJflMnEG3gxYp5iPW99X0zAF5y7xn6YagiJh9bQ>
    <xmx:N3nBaFfNTnU-kYOuj_zntJbGMU5g0_95OA_4T4oppttWAwED26TZCQ>
    <xmx:N3nBaMU-qKjSlH9R5okGeG4cEZ8usjg9czQoxvt4Rm6saC27WFRX-PvP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Sep 2025 09:12:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce3b7559 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Sep 2025 13:12:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 15:12:17 +0200
Subject: [PATCH] odb: drop deprecated wrapper functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>
X-B4-Tracking: v=1; b=H4sIADB5wWgC/x3MwQqDMAyA4VeRnA20omzdqwwPrU23MLAhgSmI7
 27x+B3+/wAjZTJ4dQco/dm4rg2+72D5xvVDyLkZBjdMLniHaUT5GdacMGsV3DSKkBp6KlN4PCm
 ksUDLRanwfq/f83letJz8b2oAAAA=
X-Change-ID: 20250910-b4-pks-odb-drop-wrappers-1ef5978e9b4f
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In the Git 2.51 release cycle we've refactored the object database layer
to access objects via `struct object_database` directly. To make the
transition a bit easier we have retained some of the old-style functions
in case those were widely used.

Now that Git 2.51 has been released it's time to clean up though and
drop these old wrappers. Do so and adapt the small number of newly added
users to use the new functions instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c      |  6 +++---
 odb.h                       | 33 ---------------------------------
 t/helper/test-pack-deltas.c | 10 ++++------
 3 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 53a2256250..ff6900b654 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3774,7 +3774,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
 	if (mode == STDIN_PACKS_MODE_FOLLOW) {
 		if (object->type == OBJ_BLOB &&
-		    !has_object(the_repository, &object->oid, 0))
+		    !odb_has_object(the_repository->objects, &object->oid, 0))
 			return;
 		add_object_entry(&object->oid, object->type, name, 0);
 	} else {
@@ -4591,8 +4591,8 @@ static int add_objects_by_path(const char *path,
 
 		/* Skip objects that do not exist locally. */
 		if ((exclude_promisor_objects || arg_missing_action != MA_ERROR) &&
-		    oid_object_info_extended(the_repository, oid, &oi,
-					     OBJECT_INFO_FOR_PREFETCH) < 0)
+		    odb_read_object_info_extended(the_repository->objects, oid, &oi,
+						  OBJECT_INFO_FOR_PREFETCH) < 0)
 			continue;
 
 		exclude = is_oid_uninteresting(the_repository, oid);
diff --git a/odb.h b/odb.h
index 3dfc66d75a..e8b9dff948 100644
--- a/odb.h
+++ b/odb.h
@@ -475,37 +475,4 @@ static inline int odb_write_object(struct object_database *odb,
 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
 }
 
-/* Compatibility wrappers, to be removed once Git 2.51 has been released. */
-#include "repository.h"
-
-static inline int oid_object_info_extended(struct repository *r,
-					   const struct object_id *oid,
-					   struct object_info *oi,
-					   unsigned flags)
-{
-	return odb_read_object_info_extended(r->objects, oid, oi, flags);
-}
-
-static inline int oid_object_info(struct repository *r,
-				  const struct object_id *oid,
-				  unsigned long *sizep)
-{
-	return odb_read_object_info(r->objects, oid, sizep);
-}
-
-static inline void *repo_read_object_file(struct repository *r,
-					  const struct object_id *oid,
-					  enum object_type *type,
-					  unsigned long *size)
-{
-	return odb_read_object(r->objects, oid, type, size);
-}
-
-static inline int has_object(struct repository *r,
-			     const struct object_id *oid,
-			     unsigned flags)
-{
-	return odb_has_object(r->objects, oid, flags);
-}
-
 #endif /* ODB_H */
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 4caa024b1e..4981401eaa 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -51,16 +51,14 @@ static void write_ref_delta(struct hashfile *f,
 	unsigned long size, base_size, delta_size, compressed_size, hdrlen;
 	enum object_type type;
 	void *base_buf, *delta_buf;
-	void *buf = repo_read_object_file(the_repository,
-					  oid, &type,
-					  &size);
+	void *buf = odb_read_object(the_repository->objects,
+				    oid, &type, &size);
 
 	if (!buf)
 		die("unable to read %s", oid_to_hex(oid));
 
-	base_buf = repo_read_object_file(the_repository,
-					 base, &type,
-					 &base_size);
+	base_buf = odb_read_object(the_repository->objects,
+				   base, &type, &base_size);
 
 	if (!base_buf)
 		die("unable to read %s", oid_to_hex(base));

---
base-commit: 4975ec3473b4bc61bc8a3df1ef29d0b7e7959e87
change-id: 20250910-b4-pks-odb-drop-wrappers-1ef5978e9b4f

