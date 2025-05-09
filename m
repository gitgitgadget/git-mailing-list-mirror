Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA1296159
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799946; cv=none; b=EJIvR5+WzytolYTpUCuD/dZNaZrRC6fgN9m8FKUji94pFVasK8aDOM8tXyuraZvUbVtyFO7FVTONqm0JDWFMebMRcWp1F4xRlu4K4wsNRWqr4RdqtU4Txc34nZWIkCBPIaxUoB6VW6wRQThXWsqyIgDsNInKfFQP3UXpTs6fKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799946; c=relaxed/simple;
	bh=Tdm46KoUVQmt05yO6IFY3PBVCTJHlhc2AjoGvujyBXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slBpf03pMyLjGBc1GFsUS3f2gtblDuspTKreZnFdesBIbkTj2YU23YYFmSdITE8LrN5ZHqPQw7fww2eKlJev7Gh3gQjE8ByrahXLheDJ8Zzfx5f20J53cY5xqGZM8tnbNHt36XYq+s6bUrdJHVbjgq1AZKtl7ZR1CjXVeU7NAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v3W4/F0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RE/Xt4Ek; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v3W4/F0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RE/Xt4Ek"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C6FC25400CB;
	Fri,  9 May 2025 10:12:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799943;
	 x=1746886343; bh=GV5weIDqHblcfGCeVR+BJhLRr1f+Pv2d2JAkrKgCAR0=; b=
	v3W4/F0yUq8g3pSqSQN/YRbAQErCMs81SIGwMYcMCcuGl9IFUZf1VpqAZByWZi+n
	FREfIzTah/FJeirZZKsibA8IqDJo095SmnjVT1HpEikIQLVyK6YsmDJBgv4fxSH7
	IjQwVcPfMcjFGY3xQ2QLzEJzsrFDsGj/cJxyIntvI8dc9Tg8miuQ5yQTZ/XTGGYP
	E7DJSpbrPgfVyF0wkumudlreWjxVWuaoM5W0W5iu51Tkc7MG7D1M4FwTDn5ke6uO
	jMSgfabkmSC1U+PPHUClHOHHnSoGsEWYjxnC8o6nW/KqlC6CvDl8uzIxjMbXuCp+
	SOM8ErqhMBtzA3QFATqVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799943; x=
	1746886343; bh=GV5weIDqHblcfGCeVR+BJhLRr1f+Pv2d2JAkrKgCAR0=; b=R
	E/Xt4Ekzoqam+TSzOPlwjSvnn0VxlJ4jYCdjqG+U2fE+7xHf4PkwbqGeOrbGo6AN
	JTCFxrNU6IJYQx8g9Tp7w06mH6X7BIGR+o4GRIaEghsfy2cQDCIXQR/TqmBxIWla
	01XeuQ6DmJtGMn/QeCJSK3XAgMlOQROw6DHgIqnGMovpywAqu9af1XBQtPyj/ayi
	7MBepEG/hA4BtlhpboDptnPOliJiStlMB2VgMiWLXVZAhAd267qQvOVV36xdNNKR
	pMohC4W5bwEb0a4Z2GRSTspw7kaugXiW95ehJDdpvDBwe7NVlsa/uu0X63HQrNHT
	w/dPU/7ZrX7LMjyrUCjdg==
X-ME-Sender: <xms:Rg0eaEhC1khPOLwfpeCrvI9Yz5nH8sP6sjaFlpoLeGYnE6023La3IA>
    <xme:Rg0eaNAEHVVf4XlM3ZreioD9dxFLeRrVHii78hrnqvDE9iIqJztkhPlwTPuY3HhzM
    qwkDd3na7VIfd9jnw>
X-ME-Received: <xmr:Rg0eaMFEzhbFIi3O6FtzAcmAKP2BNht0-w5eAWZ32xDxbjenHZpM11eYg_CIBv-AJsjm8Tm38QCEOUJgdO9Qen0_2NLA81VrGwwqahNKYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Rw0eaFQYaAxRUpe1XkzmrZaDTRRxw7_N7jDp68djGftIBCFk_4bdKQ>
    <xmx:Rw0eaByY4U9ieRYc-w-bPfMIxWLIEhAdZ20fZpHWgvgYX5_L81mXSg>
    <xmx:Rw0eaD6IbbQct4lfo78QuQGoK-Ipoja8Bi9bNhkmaxJSGbzAS6I5GQ>
    <xmx:Rw0eaOxH0ArP5GE1Bs1X5lNsa2XHsrc1Y-y7bioHXBJDoWFVblvbVQ>
    <xmx:Rw0eaIuUwNAEGYJ9eAX6oIeq62VnQ1BLcm_PJ8pfEhlhyEpzgawsHBDi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 947303d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:10 +0200
Subject: [PATCH v2 10/17] odb: get rid of `the_repository` when handling
 the primary alternate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-10-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The functions `set_temporary_primary_odb()` and `restore_primary_odb()`
are responsible for managing a temporary primary alternate for the
database. Both of these functions implicitly rely on `the_repository`.

Refactor them to instead take an explicit object database parameter as
argument and adjust callers. Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 19 +++++++++++--------
 odb.h        | 25 ++++++++++++++-----------
 tmp-objdir.c | 10 ++++++----
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index feca14d9683..100dd39cbe8 100644
--- a/odb.c
+++ b/odb.c
@@ -329,7 +329,8 @@ void odb_add_to_alternates_memory(struct object_database *odb,
 			     '\n', NULL, 0);
 }
 
-struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_alternate *odb_set_temporary_primary_alternate(struct object_database *odb,
+							  const char *dir, int will_destroy)
 {
 	struct odb_alternate *alternate;
 
@@ -337,14 +338,14 @@ struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	odb_prepare_alternates(the_repository->objects);
+	odb_prepare_alternates(odb);
 
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
 	alternate = xcalloc(1, sizeof(*alternate));
-	alternate->odb = the_repository->objects;
+	alternate->odb = odb;
 	alternate->path = xstrdup(dir);
 
 	/*
@@ -353,8 +354,8 @@ struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destro
 	 */
 	alternate->disable_ref_updates = 1;
 	alternate->will_destroy = will_destroy;
-	alternate->next = the_repository->objects->alternates;
-	the_repository->objects->alternates = alternate;
+	alternate->next = odb->alternates;
+	odb->alternates = alternate;
 	return alternate->next;
 }
 
@@ -366,9 +367,11 @@ static void free_object_directory(struct odb_alternate *alternate)
 	free(alternate);
 }
 
-void restore_primary_odb(struct odb_alternate *restore_alt, const char *old_path)
+void odb_restore_primary_alternate(struct object_database *odb,
+				   struct odb_alternate *restore_alt,
+				   const char *old_path)
 {
-	struct odb_alternate *cur_alt = the_repository->objects->alternates;
+	struct odb_alternate *cur_alt = odb->alternates;
 
 	if (strcmp(old_path, cur_alt->path))
 		BUG("expected %s as primary object store; found %s",
@@ -377,7 +380,7 @@ void restore_primary_odb(struct odb_alternate *restore_alt, const char *old_path
 	if (cur_alt->next != restore_alt)
 		BUG("we expect the old primary object store to be the first alternate");
 
-	the_repository->objects->alternates = restore_alt;
+	odb->alternates = restore_alt;
 	free_object_directory(cur_alt);
 }
 
diff --git a/odb.h b/odb.h
index 03ac369bca9..f61b391764f 100644
--- a/odb.h
+++ b/odb.h
@@ -63,17 +63,6 @@ struct odb_alternate {
 	char *path;
 };
 
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary object directory.
- */
-struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy);
-
-/*
- * Restore a previous ODB replaced by set_temporary_main_odb.
- */
-void restore_primary_odb(struct odb_alternate *restore_alternate, const char *old_path);
-
 struct packed_git;
 struct multi_pack_index;
 struct cached_object_entry;
@@ -177,6 +166,20 @@ void odb_clear(struct object_database *o);
  */
 struct odb_alternate *odb_find_alternate(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary alternate.
+ */
+struct odb_alternate *odb_set_temporary_primary_alternate(struct object_database *odb,
+							  const char *dir, int will_destroy);
+
+/*
+ * Restore a previous bakcend replaced by `odb_set_temporary_primary_alternate()`.
+ */
+void odb_restore_primary_alternate(struct object_database *odb,
+				   struct odb_alternate *restore_alt,
+				   const char *old_path);
+
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/tmp-objdir.c b/tmp-objdir.c
index cbb50438d16..c2e58c4be5c 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -47,7 +47,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 		the_tmp_objdir = NULL;
 
 	if (t->prev_alt)
-		restore_primary_odb(t->prev_alt, t->path.buf);
+		odb_restore_primary_alternate(t->repo->objects, t->prev_alt, t->path.buf);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -279,7 +279,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (t->prev_alt) {
 		if (t->repo->objects->alternates->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		restore_primary_odb(t->prev_alt, t->path.buf);
+		odb_restore_primary_alternate(t->repo->objects, t->prev_alt, t->path.buf);
 		t->prev_alt = NULL;
 	}
 
@@ -311,7 +311,8 @@ void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 {
 	if (t->prev_alt)
 		BUG("the primary object database is already replaced");
-	t->prev_alt = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->prev_alt = odb_set_temporary_primary_alternate(t->repo->objects,
+							  t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
 
@@ -320,7 +321,8 @@ struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
 	if (!the_tmp_objdir || !the_tmp_objdir->prev_alt)
 		return NULL;
 
-	restore_primary_odb(the_tmp_objdir->prev_alt, the_tmp_objdir->path.buf);
+	odb_restore_primary_alternate(the_tmp_objdir->repo->objects,
+				      the_tmp_objdir->prev_alt, the_tmp_objdir->path.buf);
 	the_tmp_objdir->prev_alt = NULL;
 	return the_tmp_objdir;
 }

-- 
2.49.0.1077.gc0e912fd4c.dirty

