Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6012750FA
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372577; cv=none; b=QNRJDGw0N76TDX8MBZBqf4qfT17b3t/obBSa+/7bSxGwY9snxvvPzpCJFgxlzoaLv/7X64WW3X0HKUr6Kb/IAbgXWaftulQ06ohsSutwBy8S356bC8JGbcuu9tXp1oYsJYzOdzC0mSqxv+9Xtgg2GDMTg/Bzfu5pg/L+3gn6/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372577; c=relaxed/simple;
	bh=owI3LtQtwhwKDR+3BGYUD1amAk+tWXlJMQntBilSEH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq9j71PhfkGBlJuumAZvCkty1LelGLRkwzJ9D6rTbFf1KlmSJbOc98GY5YG5N6PUW1W+gVVJLXVnKLoAhfETDhcChjpX1Wtym77aW/oA3C4utnXN+32YhWmr/TF9xrVccup29vU1JmRSC3knmyA2mXeX0zrAls9U0PDBU2c1ut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FaQSQtYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mhrkqzrr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FaQSQtYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mhrkqzrr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C6152EC04DA;
	Tue,  1 Jul 2025 08:22:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372574;
	 x=1751458974; bh=i+u3G9GOVg2HmFZ+UATQGQ2Uaph/5eYPOJnvIgqVirc=; b=
	FaQSQtYQ2MBMuApY2CJY2NS9IBwLmj09lqT5RuLd8IP9vxRF1DC1pfQRezwa173N
	ZtHC3y4sBY0zk77+KJbIATdOqjA85sT9JvZnk55hN2l8Dx5UiYMMF/Yh9JlqKfNe
	k42GlctxG9XsdKyToC2AE33CaN7ezZ1l5rgquYBVMpyIRU060e2R/kN/VkjDeEyT
	x4yGtyvZ/nkPa8Y06gPLILwtHut+a6gpX03koJBhuv3INJu7PalkMyctS+g3ikbx
	aiNLWRQeyj+KJeIdjDSO9w2TpH9x6zw6C86jTVA5lN3utMoYL7fISpPcNI89Z9fO
	ICVXZPdm9j4CyUMxe5MEYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372574; x=
	1751458974; bh=i+u3G9GOVg2HmFZ+UATQGQ2Uaph/5eYPOJnvIgqVirc=; b=m
	hrkqzrrky97fOOHWseBXHDC1G5K6Gjx7OZSOFgkgMEXwH5yIaunDNziDAZKYlC8I
	dKnCEnpbir14+r4RtFGovD401hAR5y5/YGYUvZZtfYYbgtyYunOZG5YChE3jNkbo
	yrRDlxMh6rJSPH5nYTd4fZzG/qu+swhsLwoRo8l+lNZ+MYtlQ2PYoK989e4eECxg
	d/e69evGV03wovovhXMS0HLBfcz++O8No4qfZC3u+FNHZoHwmDl8tc9u4f1fWcNQ
	1OavSqytftYAyCTbH0/nbzg11YI3PPNtOGq/Zu0yF13n86j4u347GZJO37GdUeIR
	/7AynaBXj7vllU3xOTh8Q==
X-ME-Sender: <xms:HtNjaNR59gOlJAPHwv2rJvRIwRbh_dHnwybdG_UFVJNUXXYetgicVQ>
    <xme:HtNjaGxzzJBAv6bhJW_y1zDBtDNk71IBgIYfbpn4Fq2eOZt3aHVgC6wQDMflUorU1
    sbtwplS9Wm2FKk1XA>
X-ME-Received: <xmr:HtNjaC2FsF2H-If4zOP-j_IB3rlNmka5wBZKIBmtMbYraRmBK83zyMHfD1C-ivale8LchFcEoLV2Gr5hoYFXPXcG9XhiHVl-4eNV-FpinA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:HtNjaFCOLowI4xEp_aU5aZGW_DhJWH4Oy2NqCVj2MA11H2Io64kt5w>
    <xmx:HtNjaGg8slEXnq47QpX9H24yIw0jKZJs20wGiXTswUKWXNbr9Ybo4g>
    <xmx:HtNjaJrE70t2u33sZEv-nMLynBXTxI1TEayaimDHDNoRZKglTZfEQw>
    <xmx:HtNjaBijTvwu7Ag-oH-bACFVpGbWiAt_7B_BvO-bl09Tx_gTpX_fuQ>
    <xmx:HtNjaNqB9MICkJ5bQ6YYUFs_isoBkppdnEaRv-ZF21KkgtD5kH32-nlJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5984b34b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:22 +0200
Subject: [PATCH v6 10/17] odb: get rid of `the_repository` when handling
 the primary source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-10-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
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
index 03fb68605c1..4f03be7f770 100644
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
2.50.0.195.g74e6fc65d0.dirty

