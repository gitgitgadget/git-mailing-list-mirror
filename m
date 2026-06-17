Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753073B71D4
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678412; cv=none; b=gs5+PXlAj/Qp1eu9uMoGYfo/O97NWLR+UBkYvYsn+ynIoY1f4xuYOjeNYu5UQKgTSRuPxaJmEj4FWf1KlDQvwgjnbv/zQ1Qe2elmR21KS7wxKWHDwoEw4uLsG1Lz3RH3kk8gqAtdJmnsixXbb8GRZU6wcoE/5Vt+GYmDO/7syJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678412; c=relaxed/simple;
	bh=gVzcIvVfTEI92p/DzfzxjAzDxCZKW9OdQWUQhjTVx3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYzgt0DoXQD3Pfke+JvIrqgWU7rmlxz5DY6bpsMhqyx6x4GrXNOywxz9RHxEUuqYFsHdK02jCT41HJHVC2fPuCnAF3ArVDdq2c/oDKPQ9kD5mWI90VlMK+iwxYSiRuEw2eR9NP5RLArG+U0i/qRx8CBnnY38FC9zMppcfuo6OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZLnZmiRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fF81UIud; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLnZmiRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fF81UIud"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC2187A0104;
	Wed, 17 Jun 2026 02:40:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 17 Jun 2026 02:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678410;
	 x=1781764810; bh=H2OFrnLx3JgDmAYIQQ6UzfxhAmC7ErZKWT746Jw5Ln8=; b=
	ZLnZmiRBqZOYRPFrtSwnVgdNwNsydSCQyLub/Lw4ufrEOVhscz8uXc9pq8WZ7z/L
	vIc5TZLCjXOtcR7SJSBdMbctBJXvZ87awTJqm9E/79GgA5ZPqSLD8IW3AsmWsIw1
	RAMGpjeEY6FX7WcuUFRlq6Y0lz2u6W+vqZ3XeHH48jMegtDB2rTqFvB2nAgbkQvh
	fNXxys2QQv5ODr69bAfSwdTh0iZWhAqj/hfgNAMkofM/BChcRInrm1iPw919Ic4e
	Wa4UTA9VkQL2bPhqG4gEKmmablG+LJAmf1tFz9/DWyDlCtsw0QDVViqHs96nbrVR
	/ebaw3vuWxiRY4585oQg4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678410; x=
	1781764810; bh=H2OFrnLx3JgDmAYIQQ6UzfxhAmC7ErZKWT746Jw5Ln8=; b=f
	F81UIudBnC+oxWEPn8ddRqPpRSl4BZgP+MVSfSiIIXXb60g9ILKiPPQ2p1ThqyKK
	lc7RSaROLjd+w2LNJPFey/giMfAq+/PPOEysFJVs9+SWfc4HrR0Npx6TqS2Cvi1M
	7T6ZaUhNwueo8csD3OO/fGN8pxgYNvGr2Lz/hO/G9JAncy4IaMMXzRV9aIGPKclm
	f71XTp//MTaCE7WkgxDoVQQ/kNhb6K5LvMAcplQVXUw68JRIXD2xe8VI71yKgomb
	/vrJ0IBDDkMdstwyFCnXci8Cs/+BcSWoI09v6R1f7SqzFKVamux5Bi+JYU84vtU5
	SMo0Q0WgPg7uyalX+YV+w==
X-ME-Sender: <xms:SUEyauWlKTUw1TV4sdYxlr8R6pAekyYhfSbq1m3QiBqjDUOGLL5qCQ>
    <xme:SUEyaiBYtURM0N4ASz-9tDh3QYG9soWzFYR8tdfoaVYeybplTlOAg6giCEeqQ9LAC
    6qpjnFNZkmEHlxDnDnofidRxyQN0ERa23Fuqd6zxyjFta1laRBNyw>
X-ME-Received: <xmr:SUEyavxNYWCMXbMV6NPb3xnY_iQzc4O68Z_zXSVL3xMZo2s-9OZUnGofbgXgeDhkzBk3HPhs_EiFpeMyovfKFxrf8CWieaFsoIKh_rI>
X-ME-Proxy-Cause: dmFkZTEnB39eLvyMgsk+d1zBATJAS2Dd09yZUP4TCe4zWysBccoWgY8Y+enBv1+9aJfPT8
    oVvaCC5MWGV30uZzKswgiCAK2gGSGYELp/F+QCNhRNY/bQx6x+ywijOIUW8TKDwAx48Lcx
    KhLHoOJu9m1Ux2Kfz7iOtjqmT/hnPJJkdtWT0xsGgHMCb1yqiVx9G0A93DDw8nseLTKulF
    USUks9qtFi47cv66z4EPIfMktSNXs9lIOpQJ4JZJ8Sqt4LT7yml6xL5bA1DQ7F1XoINCS5
    8+0eJLKjW+BUl0nBlxv0Wa8T6T4Bg1YQKal6uMYv+KeVZbCqw870pv0xnOpn9ZF3vGEMKP
    zIwI0/aOCo8JqOR+zRXSUmFh1oNe92kVoLwGqh6ZQUC6HQB0YsRutR2SpnfbP/eB0u7t3V
    xwTX7bH3+MqV/TwCWfb50mU4c/UMRauSHT2tYd2Y855kNMz9zFlqI2fa0aW5QCqf7bCiMy
    4ph65NCYtOEPUf7JbdVsEcME/j9WyUv6pX9VYdYkLF/mvZ6k4Rs3FDsssgAZ/fKRHj4WTE
    v49U3QfvIJ9iJobJB6ddqcK/4rOQ6s2aXIP7inRnG653olwEuEn9Qn28ZnQN3xmTs35mDj
    EzSiyzxdvA6IIOl/M/QLszHEPexIay8peROTyRaM+d9/SYXo3/VztmrV/H2w
X-ME-Proxy: <xmx:SUEyavAfmcrcPvOBryo4fhzzReAhXkjgwwVHbEPbSQ2TTFaseZ8iyA>
    <xmx:SUEyasa0hdGQ27bcuZhLV0RuIZ3PPyC1XSg_g4RSykoQcySyU5-JKA>
    <xmx:SUEyanhdcbuC6OOZiEaWoVlDkatFf5hPaBduoj7Sdeyu0Q6NZXk0SA>
    <xmx:SUEyau6lsVHqgwybWMAiLqRZGoeg_CSwXr7n9MF7vbkmYJVwWgOzUw>
    <xmx:SkEyameyZR4lvSB--9653QsjvCpj3ucDJjbjRGA1KenenJw2sB1LuaqI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4de51668 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:48 +0200
Subject: [PATCH v3 05/17] odb/source-packed: start converting to a proper
 `struct odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-5-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Start converting `struct odb_source_packed` into a proper pluggable
`struct odb_source` by embedding the base struct and assigning it the
new `ODB_SOURCE_PACKED` type. Furthermore, wire up lifecycle management
of this source by implementing the `free` callback and taking ownership
of the chdir notifications.

Note that the packed source is not yet functional as a standalone `struct
odb_source`, as it's missing all of the callback implementations. These
will be wired up in subsequent commits.

Further note that we're also registering a `chdir_notify` callback to
reparent our path. This wasn't previously necessary (and still isn't at
this point in time) because all paths are taken from the owning "files"
source, and that source already handles the reparenting for us. But a
subsequent commit will change that so that we're using the path of the
"packed" source, and once that happens we'll need it to be updated when
changing the working directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 odb/source-packed.h | 12 ++++++++++++
 odb/source.h        |  3 +++
 packfile.c          | 10 ----------
 packfile.h          |  6 ------
 6 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index e04525fb08..3608808e7c 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -29,7 +29,7 @@ static void odb_source_files_free(struct odb_source *source)
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
 	odb_source_free(&files->loose->base);
-	packfile_store_free(files->packed);
+	odb_source_free(&files->packed->base);
 	odb_source_release(&files->base);
 	free(files);
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 12e785be48..f81a990cbd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,11 +1,50 @@
 #include "git-compat-util.h"
+#include "abspath.h"
+#include "chdir-notify.h"
 #include "odb/source-packed.h"
+#include "packfile.h"
+
+static void odb_source_packed_reparent(const char *name UNUSED,
+				       const char *old_cwd,
+				       const char *new_cwd,
+				       void *cb_data)
+{
+	struct odb_source_packed *packed = cb_data;
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    packed->base.path);
+	free(packed->base.path);
+	packed->base.path = path;
+}
+
+static void odb_source_packed_free(struct odb_source *source)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+
+	chdir_notify_unregister(NULL, odb_source_packed_reparent, packed);
+
+	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
+		free(e->pack);
+	packfile_list_clear(&packed->packs);
+
+	strmap_clear(&packed->packs_by_path, 0);
+	odb_source_release(&packed->base);
+	free(packed);
+}
 
 struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 {
-	struct odb_source_packed *store;
-	CALLOC_ARRAY(store, 1);
-	store->files = parent;
-	strmap_init(&store->packs_by_path);
-	return store;
+	struct odb_source_packed *packed;
+
+	CALLOC_ARRAY(packed, 1);
+	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
+			parent->base.path, parent->base.local);
+	packed->files = parent;
+	strmap_init(&packed->packs_by_path);
+
+	packed->base.free = odb_source_packed_free;
+
+	if (!is_absolute_path(parent->base.path))
+		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
+
+	return packed;
 }
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 3c2d229a17..68e64cabab 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -9,6 +9,7 @@
  * A store that manages packfiles for a given object database.
  */
 struct odb_source_packed {
+	struct odb_source base;
 	struct odb_source_files *files;
 
 	/*
@@ -69,4 +70,15 @@ struct odb_source_packed {
  */
 struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
 
+/*
+ * Cast the given object database source to the packed backend. This will cause
+ * a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_PACKED)
+		BUG("trying to downcast source of type '%d' to packed", source->type);
+	return container_of(source, struct odb_source_packed, base);
+}
+
 #endif
diff --git a/odb/source.h b/odb/source.h
index 8bcb67787e..6865e1f71a 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -17,6 +17,9 @@ enum odb_source_type {
 	/* The "loose" backend that uses loose objects, only. */
 	ODB_SOURCE_LOOSE,
 
+	/* The "packed" backend that uses packfiles. */
+	ODB_SOURCE_PACKED,
+
 	/* The "in-memory" backend that stores objects in memory. */
 	ODB_SOURCE_INMEMORY,
 };
diff --git a/packfile.c b/packfile.c
index 862a24ad49..6d492216de 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2749,16 +2749,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-void packfile_store_free(struct odb_source_packed *store)
-{
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
-		free(e->pack);
-	packfile_list_clear(&store->packs);
-
-	strmap_clear(&store->packs_by_path, 0);
-	free(store);
-}
-
 void packfile_store_close(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
diff --git a/packfile.h b/packfile.h
index 2d0bb7adbe..e8bc9349f8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -55,12 +55,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-/*
- * Free the packfile store and all its associated state. All packfiles
- * tracked by the store will be closed.
- */
-void packfile_store_free(struct odb_source_packed *store);
-
 /*
  * Close all packfiles associated with this store. The packfiles won't be
  * free'd, so they can be re-opened at a later point in time.

-- 
2.55.0.rc0.786.g65d90a0328.dirty

