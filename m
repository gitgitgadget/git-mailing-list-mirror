Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3FB27B4F3
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529770; cv=none; b=J/f+LpBba6OJ4gs473x+L6LS8DfeF08uIufoxwPD4tkijplxRXHd+dQMk92HQDJ4lK1wV+taKz7WE9RuOjNaFvgbzIWdPo1Vc0St75w9K51vBVmGYvRa2CoN0/BAJRZbHwscpeTDFudvuEa87j5ObkGl21MJ3vFX9hu2hfgHC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529770; c=relaxed/simple;
	bh=59zHaXbidqA1FfepHjLLIbz40KED0yEV358vag/W+Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fR6yp5EXxU2A2ZQVlhnbt4JuvlaJ6MhZ++laEz+AO59pUggu9IgpnwtLKuA1ESQgev8+KdAr61E+d/abiNBIY0NEGB22FmsLVXhrnN8efsgti2z6a/El7YwJt+1C9rapoPvVc8aKdv9nAn+pY1T4GLslz6FfFflYaaxczlclau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sqE/sAyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TwQkutRj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sqE/sAyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TwQkutRj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 989F7114028D
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 06 May 2025 07:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529767;
	 x=1746616167; bh=nVZeP406jw6tz1WxdqcqYbgurt+u7bN64LdemItfaxo=; b=
	sqE/sAySw/tLY23t/VadUzhEzcQuyaVK0VqgdA4c/iPD5VB2+Dd3on0x2fvP1aen
	WHSanjycbKW3WF1FnDdLcsSccpCaBJMDzQfqRWHoFMUEsxbz4MItS2gaMsXGI7dC
	oXg3Z4LkPbBWcv7bF8Yx3bQO9YNOcrpEC15XeJmuaTBDR5y30YQ+oIRKksbboGBD
	Qrkk2jL7D1PgBaenuK8EajrEd1WYABMg3l5vgUqDi/6/kQIDOMSjn+KOLmbBrS1Q
	UMpb4YE4Isvpex/3H1ZKyg5HnEWc33MCnUCsefDVMcxaeINDMSjlS6VyKIm6ypuC
	sNICItqFo175rkzOB/jO5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529767; x=
	1746616167; bh=nVZeP406jw6tz1WxdqcqYbgurt+u7bN64LdemItfaxo=; b=T
	wQkutRje4JLFTxHEOqWmX57VCZA0JZ+wQWxNK5UVvKpQ7IgGYj1b3iVpWlesZRqF
	3i9tpKcYemVixp9NPkOXV4GOhn25Q7g8Lbp5Xwu+MCAm20iEJOsT0pfwUrAcvvrW
	kMHR46TkUEX/5waITRzYjDupJuPSb6hbGYElqOEY8bnDAJcZK21w1PzB7ugxSgzc
	GcoyB9wflr3STs8jV4z3m7vqcDB+vJHX9Stu68K2l/3N3p7z8j+HZ61x23STNJAI
	vsiYDEnhLM4awrv7zfkFHJmC4kT/Z8JmYgb3oEIwb6/zl3lq9AIscXFtRfgQepMN
	a1aOBAr4Dil+djQqkcesA==
X-ME-Sender: <xms:5-0ZaNJ5mdByffDWP3npSqIxTVKAU1eTMR3FP7voWEl-uD0GFxDypw>
    <xme:5-0ZaJKmWWYyrnINwG1Ly7axmEO4qVzYuqag3ERTl2jDuAzQT9r9A0sa89vPjC5Gc
    zNdjHfxPISuw_L3JQ>
X-ME-Received: <xmr:5-0ZaFtwy0EcaaLWYkfFnFyGHRwwQjFdKaWYLwVCq7-FEHwG4qpbe6O6CyStgh-c7DS3cXqA3Jkgkh7uRDcw1Mvb_YUuMjOlpcNjpJ49>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5-0ZaOYEWI34qHFo6aM_QF0XU3Z_eoX47tB1PugorBLPC3oB5ZbXzw>
    <xmx:5-0ZaEZ-LHf0_TlImlqWQIOvUVYV8_J8Lfp2gWk1B7zOm4xv58DJMw>
    <xmx:5-0ZaCBE01Ru2Gyfgg8QwgLbZqJL7bRH1tnaFA7uUBsEuaCPrp6oCQ>
    <xmx:5-0ZaCZTRu1ro4NGlnpkeP715EYMYPM5mlt9U_jndmBfkkBWHAqhnA>
    <xmx:5-0ZaCkrsCiOeCxG-YfxgcfChaEDqpb97O577pXxsnPaLP-YwRh7Fpr0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bd37f10 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:23 +0200
Subject: [PATCH 10/17] odb: get rid of `the_repository` when handling the
 primary backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-10-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The functions `set_temporary_primary_odb()` and `restore_primary_odb()`
are responsible for managing a temporary primary backend for the
database. Both of these fucntions implicitly rely on `the_repository`.

Refactor them to instead take an explicit object database parameter as
argument and adjust callers. Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 19 +++++++++++--------
 odb.h        | 25 ++++++++++++++-----------
 tmp-objdir.c | 10 ++++++----
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index 66cad14f538..8be5d4fb2d6 100644
--- a/odb.c
+++ b/odb.c
@@ -329,7 +329,8 @@ void odb_add_to_alternates_memory(struct object_database *odb,
 			     '\n', NULL, 0);
 }
 
-struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_backend *odb_set_temporary_primary_backend(struct object_database *odb,
+						      const char *dir, int will_destroy)
 {
 	struct odb_backend *backend;
 
@@ -337,14 +338,14 @@ struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	odb_prepare_alternates(the_repository->objects);
+	odb_prepare_alternates(odb);
 
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
 	backend = xcalloc(1, sizeof(*backend));
-	backend->odb = the_repository->objects;
+	backend->odb = odb;
 	backend->path = xstrdup(dir);
 
 	/*
@@ -353,8 +354,8 @@ struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 */
 	backend->disable_ref_updates = 1;
 	backend->will_destroy = will_destroy;
-	backend->next = the_repository->objects->backends;
-	the_repository->objects->backends = backend;
+	backend->next = odb->backends;
+	odb->backends = backend;
 	return backend->next;
 }
 
@@ -366,9 +367,11 @@ static void free_object_directory(struct odb_backend *odb)
 	free(odb);
 }
 
-void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path)
+void odb_restore_primary_backend(struct object_database *odb,
+				 struct odb_backend *restore_odb,
+				 const char *old_path)
 {
-	struct odb_backend *cur_odb = the_repository->objects->backends;
+	struct odb_backend *cur_odb = odb->backends;
 
 	if (strcmp(old_path, cur_odb->path))
 		BUG("expected %s as primary object store; found %s",
@@ -377,7 +380,7 @@ void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path)
 	if (cur_odb->next != restore_odb)
 		BUG("we expect the old primary object store to be the first alternate");
 
-	the_repository->objects->backends = restore_odb;
+	odb->backends = restore_odb;
 	free_object_directory(cur_odb);
 }
 
diff --git a/odb.h b/odb.h
index 2165396a165..e80ee5efec6 100644
--- a/odb.h
+++ b/odb.h
@@ -61,17 +61,6 @@ struct odb_backend {
 	char *path;
 };
 
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary object directory.
- */
-struct odb_backend *set_temporary_primary_odb(const char *dir, int will_destroy);
-
-/*
- * Restore a previous ODB replaced by set_temporary_main_odb.
- */
-void restore_primary_odb(struct odb_backend *restore_odb, const char *old_path);
-
 struct packed_git;
 struct multi_pack_index;
 struct cached_object_entry;
@@ -175,6 +164,20 @@ void odb_clear(struct object_database *o);
  */
 struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary backend.
+ */
+struct odb_backend *odb_set_temporary_primary_backend(struct object_database *odb,
+						      const char *dir, int will_destroy);
+
+/*
+ * Restore a previous bakcend replaced by `odb_set_temporary_primary_backend()`.
+ */
+void odb_restore_primary_backend(struct object_database *odb,
+				 struct odb_backend *restore_odb,
+				 const char *old_path);
+
 /*
  * Iterate through all backends of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 2982c646569..e6221879395 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -47,7 +47,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 		the_tmp_objdir = NULL;
 
 	if (t->prev_odb)
-		restore_primary_odb(t->prev_odb, t->path.buf);
+		odb_restore_primary_backend(t->repo->objects, t->prev_odb, t->path.buf);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -279,7 +279,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (t->prev_odb) {
 		if (t->repo->objects->backends->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		restore_primary_odb(t->prev_odb, t->path.buf);
+		odb_restore_primary_backend(t->repo->objects, t->prev_odb, t->path.buf);
 		t->prev_odb = NULL;
 	}
 
@@ -311,7 +311,8 @@ void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 {
 	if (t->prev_odb)
 		BUG("the primary object database is already replaced");
-	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->prev_odb = odb_set_temporary_primary_backend(t->repo->objects,
+							t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
 
@@ -320,7 +321,8 @@ struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
 	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
 		return NULL;
 
-	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
+	odb_restore_primary_backend(the_tmp_objdir->repo->objects,
+				    the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
 	the_tmp_objdir->prev_odb = NULL;
 	return the_tmp_objdir;
 }

-- 
2.49.0.1045.g170613ef41.dirty

