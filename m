Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCD47255E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448592; cv=none; b=KYtPxo++HiKE5p6mEWBddOJh6swaR+JTd/GlwBEOJvt2clpu8xFSELFVcBXDOwCuLQ980Y0nnjtPCjS+rj77/s0HUSHl7xVf4DpxPY8V56vxchqZihwV7BAApQq0PDE79q+0V4B8STEIyBKv+UZ8nw1P+K5cIhIdUUa3IZuMNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448592; c=relaxed/simple;
	bh=8IDyyJQEgC7Py4Op2waTtBeOpsgZsEhxanEUskD1+3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smI9f58Lg/mSeamTBZKZeM5sV8drQBkNFAMx9A7mSEz2rk8Svy0Z9HNXgBi8rXO5ggpefPWLoHPk9D9iSjt16mo0xJia/GsKZ2an1Bzg3pWWjMmk0BfFklZxDJsEW+Obtakn1+xekuuX+83Lr/p+lnZ+sSWpiXlr+rLAe29Pgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V618dkie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=whstQF52; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V618dkie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whstQF52"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E9394EC0104
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448589;
	 x=1791534989; bh=V8L1yDWBuB+hOYJV6weFzPpsiuf8VheC9GaF5tAfKiI=; b=
	V618dkieLhK3u0MkCAN5EIh+87wfyWmIIXix0Xvtl+l/5IVB3ZtyQbkMcOet9Una
	Nc4W/aqO8X3TJWFYV/tMzyJLEVQvg8/r44EWtUj45mbw7NwntG3gqUPUwS8sOz/j
	FsExPuTm1BXKyhHR3bn+DJFXJpc6d0Z/i9iKg8wJyRIwbNC8R8LtkPoyEFT5HJ5E
	60RZwlELbd4qn+JXlmn4IGvMd0QmA24eObjfCcTsS0pnqCvL8UBOZm5M0mgnXPPh
	5cBZkr2g+cx5R0QDiyTVPscWvG/2l05vxpJj1DqkxrN8Rha/AOmBPCbHHgITlyWP
	LI2PN9+54wFLvuKDLZM94g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448589; x=
	1791534989; bh=V8L1yDWBuB+hOYJV6weFzPpsiuf8VheC9GaF5tAfKiI=; b=w
	hstQF52DHs3B23rbEvx26qlEmqcaU2eiJWA8b355PeBbfKGbH/8Gemgj/E4MF3Ra
	xvu0Vn4gWDigdQ6X3995zIOF59rrGo53u0C2RHFWBZ83sp89QxPShrRnorBeDjUq
	4z/0eXMN6V6pvZya8DtZuyFcw4l50qEJq9W4O0OE4prKFVpMWYRhmTMkwf2oqVwk
	ztJQycUYhdZ7ef/CJuoWaqIUnT0rBHkNZyKnUOm9ZPIcP9NHFotdFOZb1U7W9f3m
	sQqUux8R4cD9mGG1clkhLNjrPU3hHnos9QLVb1SmjFxBL9eXsKlMHWDJti7Cxx0X
	VWWp7hKxrq18mdb29pSfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448589; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:H12LcB+IWV9nmq7I03PTQ2z4bstAlcAhe/X5l2GCh10FqQw
	I5jWMtYvn4gcStvvHSGy5Ix89A2EItPqOoa5QGEA6OzwdRzSC27mOe3bs0Qf+Tc9
	HHA14ILsPU/L81w0ErHJs/MX/OQ+cSpdd8K7ukyeqpTLK5SLSH2+fYlZFW/2cwjB
	4CA1d9ksja9HwckA6lH2FysQ4njadP8mBwEJwvvuDUpHO03M0SNYnhLN+YzGblW+
	0xPTDHsAR//zJ1NAQ0dK7kaKcVPGUh9f3eVkZyqx49CzU26xceazfyAAgZSHQbIA
	4UlRyQPMrMBWkiUGNY0/Atq4y80NHBxh3TXkDVg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:p3b6MrdUU8Hkwd6gGALwfg7V+71X8wi/4ve2ysJDQoA=:8IDyyJQEgC7Py4Op2waTtBeOpsgZsEhxanEUskD1+3o=;
X-ME-Sender: <xms:DVbHahj_p4-0ZmH7NuwgWNy16M22CVTnvamIjlp4DpAcoqTwp4PBrw>
    <xme:DVbHasDMauzl0RCtMmpcr-dX6BkCES4gtVLJ3xGuXI3keQwwwEaNpEsI1-0du7gxG
    fIx582FyvbWV39ANTAYIiHYpit6Yi_Iu4FeLWYjJYXLx5VQDqqDcnY>
X-ME-Received: <xmr:DVbHauujthLw8Kz2dDvtpeuA8v0WKQUDl_nRkLRrkQyeoKZPRUx9QQ>
X-ME-Proxy-Cause: dmFkZTEJ12PrM6lPkulG2HrVHQhK7W+nzWtv82fCmVg5Srp1vYOBsOZXk+3zbaSKR1o9q9
    zgaDeQtd8exjkN8iOx8gK+wWQ1lxo0Q9l5NbSN30f6p85fJAxnBnfB37gvWssqHY0VvvFk
    PiSqXLopWAifncYeDTw784/UzhaCYudHQhaoZVmElltXFrtbNxE9yoMHYjh+fC+7+cmO4F
    trDv6wR/hEYFDz8+qQNhsJOcx0mrPE3FW04oN9df+1q7n0ABLdhTxdS8UQHC0rVd1KtZxV
    7/37M0p9gjidiOzO6b0dZkeD/ejphFx+/vQQFlrVrQqcWyOiFkr2KBwIfyyln8WZPtNoUq
    iqauGbzvoo7/w6LiPRaMnJCgPz0p2U+KrN8hJpDSdf5ORZkNsVzb0zmdG9rHUAb1+/cs85
    T2xdDxGkpzF+PLh0mAmD8VBDWlFtZ2KYoPCyeT0A0KTgsizEVVOXXyxWx494FLK0y/V/Ob
    ZODI06f5ewy7FE3gOa+hxfF/IRgmI7ZUsW0ZIiy/06vLCS528iiKY64bOzSWSLInc8+5zE
    NWKW210sx5sXy1eNiqriO/7S0E757lT+uzTwOs2/IbMNv0W32lTFt/rxMwG0VmiKb+gho1
    Qp9/cw+LfZm9cPXGt2V/KbG39yyfFPhRzPjYsSK5mcRuRoruI0MFyLZJ+nEw
X-ME-Proxy: <xmx:DVbHahY2hx1QjvT4oQyMzVRdCE6IhiaIp73QHnzCOTgZ5lvGpLUgBg>
    <xmx:DVbHahVJOOcPboZqOJVWmgn5Ravok2TxVRY_B_kBce8sTEGyK9PkKQ>
    <xmx:DVbHal7nkzdwa746uXYzwRuh9OdKEvcCuziDhZwrCYrJn4tVNuhK8Q>
    <xmx:DVbHasipFDZZi0t7zQtFMoAvPXzKOqSNk64R6bzvnwl47Defj_ZSOw>
    <xmx:DVbHapQrr9nvegQnMy_TJ5JZa4ksAYEPhy-sY3e4Zu4PqzL7dkCv80sD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b920c3c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:59 +0200
Subject: [PATCH v2 09/13] tmp-objdir: replace primary source at creation
 time
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-9-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When creating transactions via the "tmp-objdir" subsystem callers are
expected to first call `tmp_objdir_create()` to create the quarantine
directory and then `tmp_objdir_replace_primary_odb()` to activate that
quarantine directory as the primary object database source so that all
newly written objects are written into it.

This dance is performed by all users of temporary object directories, so
that makes the setup unnecessarily involved. Merge the logic to replace
the primary object database source into `tmp_objdir_create()` to
simplify the dance.

Note that with the quarantine directory being installed by
`tmp_objdir_create()`, users of this function no longer get a pointer to
the underlying quarantine directory. So instead of repreparing only that
directory, we now reprepare the whole source instead, and as we know
that the source has wired up the quarantine directory already, this will
cause us to reprepare the quarantine directory, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 log-tree.c    |  3 +--
 object-file.c |  8 ++------
 tmp-objdir.c  | 47 +++++++++++++++++++----------------------------
 tmp-objdir.h  | 18 +++++-------------
 4 files changed, 27 insertions(+), 49 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..361dfadbb3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1043,10 +1043,9 @@ static int do_remerge_diff(struct rev_info *opt,
 	 * into the alternative object store list as the primary.
 	 */
 	if (opt->remerge_diff && !opt->remerge_objdir) {
-		opt->remerge_objdir = tmp_objdir_create(the_repository, "remerge-diff");
+		opt->remerge_objdir = tmp_objdir_create(the_repository, "remerge-diff", 1);
 		if (!opt->remerge_objdir)
 			return error(_("unable to create temporary object directory"));
-		tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
 	}
 
 	/* Setup merge options */
diff --git a/object-file.c b/object-file.c
index fe9139c96d..02521afcaf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -488,7 +488,6 @@ struct odb_transaction_files {
 	enum odb_transaction_flags flags;
 
 	struct tmp_objdir *objdir;
-	struct odb_files_dir *quarantine;
 	struct transaction_packfile packfile;
 	const char *prefix;
 
@@ -511,12 +510,10 @@ int odb_transaction_files_prepare(struct odb_transaction *base)
 	if (!transaction || transaction->objdir)
 		return 0;
 
-	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix);
+	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix, 0);
 	if (!transaction->objdir)
 		return error(_("unable to create temporary object directory"));
 
-	transaction->quarantine = tmp_objdir_replace_primary_odb(transaction->objdir, 0);
-
 	return 0;
 }
 
@@ -1443,8 +1440,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 
-		odb_source_prepare(&transaction->quarantine->packed->base,
-				   ODB_PREPARE_FLUSH_CACHES);
+		odb_source_prepare(base->source, ODB_PREPARE_FLUSH_CACHES);
 	}
 
 	return 0;
diff --git a/tmp-objdir.c b/tmp-objdir.c
index a3903b6e6d..719b55e580 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -57,7 +57,7 @@ static void tmp_objdir_reparent(const char *old_cwd,
 
 /*
  * Restore the primary source that was previously replaced by
- * `tmp_objdir_replace_primary_odb()`.
+ * `tmp_objdir_create()`.
  */
 static void tmp_objdir_restore_source(struct tmp_objdir *t)
 {
@@ -157,8 +157,10 @@ static int setup_tmp_objdir(const char *root)
 }
 
 struct tmp_objdir *tmp_objdir_create(struct repository *r,
-				     const char *prefix)
+				     const char *prefix,
+				     int will_destroy)
 {
+	struct odb_source_files *files = odb_source_files_downcast(r->objects->sources);
 	static int installed_handlers;
 	struct tmp_objdir *t;
 
@@ -167,6 +169,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 
 	t = xcalloc(1, sizeof(*t));
 	t->repo = r;
+	t->will_destroy = will_destroy;
 	strbuf_init(&t->path, 0);
 	strvec_init(&t->env);
 
@@ -204,6 +207,20 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	env_replace(&t->env, GIT_QUARANTINE_ENVIRONMENT,
 		    absolute_path(t->path.buf));
 
+	/*
+	 * Make a new primary source and link the old primary source in as an
+	 * alternate. Disable ref updates while a temporary source is active,
+	 * since the objects in the database may roll back.
+	 */
+	t->temp_dir = odb_files_dir_new(t->repo->objects, t->path.buf, false);
+	t->temp_dir->loose->base.will_destroy = will_destroy;
+	t->temp_dir->packed->base.will_destroy = will_destroy;
+	t->temp_dir->next = files->dirs;
+
+	t->orig_dir = files->dirs;
+	files->dirs = t->temp_dir;
+	t->repo->disable_ref_updates = true;
+
 	return t;
 }
 
@@ -345,29 +362,3 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 		return NULL;
 	return t->env.v;
 }
-
-struct odb_files_dir *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
-						     int will_destroy)
-{
-	struct odb_source_files *files = odb_source_files_downcast(t->repo->objects->sources);
-
-	if (t->temp_dir)
-		BUG("the primary object database is already replaced");
-	t->will_destroy = will_destroy;
-
-	/*
-	 * Make a new primary source and link the old primary source in as an
-	 * alternate. Disable ref updates while a temporary source is active,
-	 * since the objects in the database may roll back.
-	 */
-	t->temp_dir = odb_files_dir_new(t->repo->objects, t->path.buf, false);
-	t->temp_dir->loose->base.will_destroy = will_destroy;
-	t->temp_dir->packed->base.will_destroy = will_destroy;
-	t->temp_dir->next = files->dirs;
-
-	t->orig_dir = files->dirs;
-	files->dirs = t->temp_dir;
-	t->repo->disable_ref_updates = true;
-
-	return t->temp_dir;
-}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 5ed0db1ee0..a301b01d84 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -11,7 +11,7 @@
  * Example:
  *
  *	struct child_process child = CHILD_PROCESS_INIT;
- *	struct tmp_objdir *t = tmp_objdir_create(repo, "incoming");
+ *	struct tmp_objdir *t = tmp_objdir_create(repo, "incoming", 0);
  *	strvec_push(&child.args, cmd);
  *	strvec_pushv(&child.env, tmp_objdir_env(t));
  *	if (!run_command(&child)) && !tmp_objdir_migrate(t))
@@ -25,10 +25,11 @@ struct repository;
 struct tmp_objdir;
 
 /*
- * Create a new temporary object directory with the specified prefix;
- * returns NULL on failure.
+ * Create a new temporary object directory with the specified prefix and
+ * install the directory as the primary write target; returns NULL on failure.
  */
-struct tmp_objdir *tmp_objdir_create(struct repository *r, const char *prefix);
+struct tmp_objdir *tmp_objdir_create(struct repository *r, const char *prefix,
+				     int will_destroy);
 
 /*
  * Return a list of environment strings, suitable for use with
@@ -55,13 +56,4 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_discard_objects(struct tmp_objdir *);
 
-/*
- * Replaces the writable object store in the current process with the temporary
- * object directory and makes the former main object store an alternate.
- * If will_destroy is nonzero, the object directory may not be migrated. Returns
- * the newly installed primary source.
- */
-struct odb_files_dir *tmp_objdir_replace_primary_odb(struct tmp_objdir *,
-						     int will_destroy);
-
 #endif /* TMP_OBJDIR_H */

-- 
2.56.0.406.ga2d225a756.dirty

