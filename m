Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5D202969
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106029; cv=none; b=Nurle2Uu9Fy5BOYM5eYc4xZuoNbjn9lT0yehoLeFoZluV8xgHyBJSdCxIoYTYI0YYe5hoxrZ571hILTHHrleXPFssftBp1oeTtOZ/94MvBG8435hrGCLm0qrFEtBQJ83aNNrERAeUV+CILpr6sXK2qXO4txkZ727bpoxBN0fOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106029; c=relaxed/simple;
	bh=+aGnwv9Q1BF9s8QHaz4GXYBetyY43ip1yQWQyXmKHA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpaGyVwEcQxIFzN7tnZb7n+AFKWfTfJRn/NOkdGWBSLAnUM12jHEYBDLQk8ROGi68xHRHX4Uz75yQ8Pj6yeuYtwE8S4y2I/zS7/U79NLw7aFcA27+SsnGMBJErSTRbmPJeKqz4n8Y9CEfTb6oHcy3dWdM9lCx7BiF3irJtG30HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0FyjNeY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oiwz8Fyh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0FyjNeY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oiwz8Fyh"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13D2125400EC;
	Thu,  5 Jun 2025 02:47:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 02:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106026;
	 x=1749192426; bh=WI5PDJl4C0rqu5QaKSmIM0er2AMmG+rRZJEvQixeUh0=; b=
	S0FyjNeYMY5ruANN/svw0+848os2bI3OUNZilWMugFYj36m8LwqNO7Z3BfNg9QV6
	LEW499WPPWUDo/BQvLgWk8fOPbLoaFfnZ5JPz02dThtjwhTjiZPTYX4GSxBX6H21
	hkGgxOzmN/DRHTakoodlK8BropjfWoAkDYmMcN03eX1RRi51h0aj9QGPT8I1GOyB
	jZ6I80xFuhlk7bvdPi30x9UyUp1Fl4fsQPSufa67S5ofMqn2vEVQIgX/gWqUnRuX
	1Qrih7Np5i0G2c5HpWvHlCEMQ2krkh0OBjACyznJI02bEjDIruMqgsmOUii2r7fx
	lIr6gLFaT/VzUztkihAFKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106026; x=
	1749192426; bh=WI5PDJl4C0rqu5QaKSmIM0er2AMmG+rRZJEvQixeUh0=; b=o
	iwz8FyhpP2i4JuJI40aYVhDHAnrCFRODQ6fx7F+AQjJyJMKu2CUz72RgiYGGlE87
	xzU0CQT9+dIQXF9T5F+VbMN1wLiMlC0JVptLVK+yfmvXZnSF3k9EIZpLwo/yUbqy
	GA646e3Gdl3+kwkC2edeovpb4OSrwGEP+ovVX+yNbpPFonQvi3z8gxxMW/LZumy/
	81JICnef4J8K239xUJ6FPJG3OcKxnPjZGs16bkLyg1kz80eX4uLkDvUvQ9dPNWBp
	x2NFhN3o/5R2SrVIB9fZJOz/5MPc7YIFvruMEskeMgyZDFFYfoUrzztuAIVN40MT
	6fHYi/qNSC2zjlFWaDk8Q==
X-ME-Sender: <xms:aj1BaMDSHvyhnW5_3tjxtsRcR532OZAF9mWjTkpa56i8KA1VyZ9A_Q>
    <xme:aj1BaOhXbhtg-CEcygsFsQqB_BzpHXYj_GDxTMLVU5Qhsm65uABTovSbM9x1NmeAS
    y3waXxFnokd4PJ4Eg>
X-ME-Received: <xmr:aj1BaPk1NgK6MHVInH8Y9xVdNEin1OHF355SnYp1eC4VmdDd87I2ZLotPKKob6rdjMs1q8X75aqQfHWeRwQvvh-5xNjaJY0kk6H2hoiyuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aj1BaCwdApqjeEDUMbLlPdXYh6KQFIBKRuL2m3E38kDjVenFbAIqMw>
    <xmx:aj1BaBS478EM6WeYW02so0pzxKr7139XyDrw6g7j0Zwz3AU_wABB8Q>
    <xmx:aj1BaNb0yX3ah-sAC1cY_DZsjk2DLP06tb8_EEGfdkxkpqCy1ugjeg>
    <xmx:aj1BaKQU27w8_i4w5uxqSnQ9b96jfwC2ii2BJHZZ62ijxuDSQUd6dg>
    <xmx:aj1BaPZUTmqC9D8W_lR8MXEDVrHWxf4uOEFo12U79SmjSNuPlh_rdXrn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37921692 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:47:00 +0200
Subject: [PATCH v5 10/17] odb: get rid of `the_repository` when handling
 the primary source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-10-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The functions `set_temporary_primary_odb()` and `restore_primary_odb()`
are responsible for managing a temporary primary source for the
database. Both of these functions implicitly rely on `the_repository`.

Refactor them to instead take an explicit object database parameter as
argument and adjust callers. Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 27 +++++++++++++++------------
 odb.h        | 26 +++++++++++++++-----------
 tmp-objdir.c | 10 ++++++----
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/odb.c b/odb.c
index d83f7416e9e..b154e91953d 100644
--- a/odb.c
+++ b/odb.c
@@ -329,7 +329,8 @@ void odb_add_to_alternates_memory(struct object_database *odb,
 			     '\n', NULL, 0);
 }
 
-struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
+						    const char *dir, int will_destroy)
 {
 	struct odb_source *source;
 
@@ -337,14 +338,14 @@ struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	odb_prepare_alternates(the_repository->objects);
+	odb_prepare_alternates(odb);
 
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
 	source = xcalloc(1, sizeof(*source));
-	source->odb = the_repository->objects;
+	source->odb = odb;
 	source->path = xstrdup(dir);
 
 	/*
@@ -353,8 +354,8 @@ struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 */
 	source->disable_ref_updates = 1;
 	source->will_destroy = will_destroy;
-	source->next = the_repository->objects->sources;
-	the_repository->objects->sources = source;
+	source->next = odb->sources;
+	odb->sources = source;
 	return source->next;
 }
 
@@ -366,19 +367,21 @@ static void free_object_directory(struct odb_source *source)
 	free(source);
 }
 
-void restore_primary_odb(struct odb_source *restore_alt, const char *old_path)
+void odb_restore_primary_source(struct object_database *odb,
+				struct odb_source *restore_source,
+				const char *old_path)
 {
-	struct odb_source *cur_alt = the_repository->objects->sources;
+	struct odb_source *cur_source = odb->sources;
 
-	if (strcmp(old_path, cur_alt->path))
+	if (strcmp(old_path, cur_source->path))
 		BUG("expected %s as primary object store; found %s",
-		    old_path, cur_alt->path);
+		    old_path, cur_source->path);
 
-	if (cur_alt->next != restore_alt)
+	if (cur_source->next != restore_source)
 		BUG("we expect the old primary object store to be the first alternate");
 
-	the_repository->objects->sources = restore_alt;
-	free_object_directory(cur_alt);
+	odb->sources = restore_source;
+	free_object_directory(cur_source);
 }
 
 char *compute_alternate_path(const char *path, struct strbuf *err)
diff --git a/odb.h b/odb.h
index 7e65e9707c1..4e2d1004f8a 100644
--- a/odb.h
+++ b/odb.h
@@ -73,17 +73,6 @@ struct odb_source {
 	char *path;
 };
 
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary object directory.
- */
-struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy);
-
-/*
- * Restore a previous ODB replaced by set_temporary_main_odb.
- */
-void restore_primary_odb(struct odb_source *restore_alternate, const char *old_path);
-
 struct packed_git;
 struct multi_pack_index;
 struct cached_object_entry;
@@ -187,6 +176,21 @@ void odb_clear(struct object_database *o);
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary source.
+ */
+struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
+						    const char *dir, int will_destroy);
+
+/*
+ * Restore the primary source that was previously replaced by
+ * `odb_set_temporary_primary_source()`.
+ */
+void odb_restore_primary_source(struct object_database *odb,
+				struct odb_source *restore_source,
+				const char *old_path);
+
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 4120badf5ce..ae01eae9c41 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -47,7 +47,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 		the_tmp_objdir = NULL;
 
 	if (t->prev_source)
-		restore_primary_odb(t->prev_source, t->path.buf);
+		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -279,7 +279,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (t->prev_source) {
 		if (t->repo->objects->sources->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		restore_primary_odb(t->prev_source, t->path.buf);
+		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
 		t->prev_source = NULL;
 	}
 
@@ -311,7 +311,8 @@ void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 {
 	if (t->prev_source)
 		BUG("the primary object database is already replaced");
-	t->prev_source = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->prev_source = odb_set_temporary_primary_source(t->repo->objects,
+							  t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
 
@@ -320,7 +321,8 @@ struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
 	if (!the_tmp_objdir || !the_tmp_objdir->prev_source)
 		return NULL;
 
-	restore_primary_odb(the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
+	odb_restore_primary_source(the_tmp_objdir->repo->objects,
+				   the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
 	the_tmp_objdir->prev_source = NULL;
 	return the_tmp_objdir;
 }

-- 
2.50.0.rc1.591.g9c95f17f64.dirty

