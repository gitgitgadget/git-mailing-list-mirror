Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D541FECAA
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199562; cv=none; b=g96yL1q6YqlxJUwI8BkGtFxVusMeDy7oVQzCZg6ZwEa5vpPNzUEdVde8c2eQ9hTTIgeFscFh9jfKb2jDqWhdEHhLEpPfUTVb5tyN+HxY5cvrDtFdKT+XKsEFb/89YHRyVsMYqBhsrCi4/PipZfjp/tWw0qoXg/oSQwE4x64SWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199562; c=relaxed/simple;
	bh=RTkIZr4HilJr7xXq//JmBpOhSemuaBSFA4MVWhXhLEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d43VghY7HZ0ZzYMPQa2RzVrLhjRnTKPGPcRS+cIqDubo5BsgSBM/0XGxGhmabkJseqp/o4UrLtSiyuKjt0NDnF9PuEvx4SO587nkxAfdS7hho8pDHZfvgvyb9xycEdYl2zykQmUH3YHToPaFcNbxynxNZb+/ncsCQES8VkKeZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=APS5+Xrf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSa24W0K; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="APS5+Xrf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSa24W0K"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73B2B1140138;
	Wed, 14 May 2025 01:12:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 14 May 2025 01:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199559;
	 x=1747285959; bh=hssYLo3HAG5d6f9nMew0SjqTyv518N6Z1biVYdJ0FhI=; b=
	APS5+XrfMqRgR0Y6/9WmOJ6kS0+1m3Mw50Zx9lWs+wvtYXPCGel3o++vDHUA7Cc/
	2oGEPmb+c3fcMy5EjXxc0D2BXVH6Ir1ADUzNMenz/RU+MVn13yBF8I95w7Ds+q+k
	5dJEnKPcaGpznFBJv19jXWa+zf3hnmM0aK3DW8h65tOCbaoe+p9XB+1oVVNTmmjN
	yfpjSzDUr8cVlMFObkSWVCoZu6fJohgD6udMcgYvBN1ZrMHpaWeCoK4fECkzkzjK
	QDRMipvADqxmFma+42QXVnh2n9V+9GrNFgUSJaSS5I9w/KGfj1eEGDZ7np3WxWpI
	ZDztM3up4XX1Nbmkdbgk9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199559; x=
	1747285959; bh=hssYLo3HAG5d6f9nMew0SjqTyv518N6Z1biVYdJ0FhI=; b=n
	Sa24W0KeY87yNrDFeJTtsefvIYL3QyYO2JIEPWIO5oH2rzdlGAa8hdutiKKZZohY
	W63Dr6yGxczE7RDf2fAI7hHqu7peRKW4tNBNS8pnA5J8JpGjM1dA4aOvjTbcaI6c
	BNTwGQPv2LnnMY0Kt0qrLvaOBEJgBdEgqbdT8pHxZ7SgcXCWwl1xdthqG6vP7aOc
	GJ4WxYKnehlzZ6DXgfl+HgX2B9FtyzHTC5rw3Q7vQJ18LTOBa/yPWxdL91sJBRu3
	DmoD6zYB04ERJRLCGnn8z+zOq42sKGImIOzjrDatGiCmf+2QOnGd5+i6CBmT5gK5
	XdMUky3D1SSmL05QugubQ==
X-ME-Sender: <xms:RyYkaKXeVaVO5jl-HGhjjuhLmduH9_KIH6eVmNMIQbWAcBA5IMMzIQ>
    <xme:RyYkaGkmqilmApbGghgKcx0By3WzrfHJIWtIQhTU6XpDUnJkDadBYNHuUW4ASXEPP
    k1WIWlWiWe4W-10hQ>
X-ME-Received: <xmr:RyYkaOYIIQqu67KsqXNiNHoFhW4Qz69e1XXMdS6s7nV3EBCUVVSmXtK3KmTt2dnKuUsbsjysVzomTnazBOGV9MaA1jTuTSCArEDUbntVoR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:RyYkaBXa-uqqFJgbBSKlyb0utuy3jnIrRK-RuPn0aZYLp_TcyDevaQ>
    <xmx:RyYkaEl9XerkOpQEqTyHmOk641k6ASlGD1IeKFWaqvSfrv5XUFaokg>
    <xmx:RyYkaGeKkBaPXrqD0KsSAWjW8SAeEz1Zc5Q3LMLomqQbtfgBfwHamQ>
    <xmx:RyYkaGEJddNievMKqzak9IwsIyBIoJx_MRfbGCVFnoB1MzzpAsKyUg>
    <xmx:RyYkaFKYZSmkJFj2VfhDS8o6DaFwL-QWye5DbmubQFzrTnVW_qWzeI5e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cfa2853 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:33 +0200
Subject: [PATCH v3 10/17] odb: get rid of `the_repository` when handling
 the primary alternate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-10-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
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
index dcc3b0bc1f0..0db4de38529 100644
--- a/odb.h
+++ b/odb.h
@@ -66,17 +66,6 @@ struct odb_alternate {
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
@@ -180,6 +169,20 @@ void odb_clear(struct object_database *o);
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
2.49.0.1141.g47af616452.dirty

