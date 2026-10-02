Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223B47ECD2
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935735; cv=none; b=XNkh4fsqpQnKSKCfSN3nGLbgkSYzEyXslg2dev57SbKIQpKKonmOqNuqaTzO6M8CI6fCw9GJCX5C/LJP+3uRXkqLk/BptMDE+Mpl39lOTWuYmU+7PdPiD/94Xtvss9QgEdlAL3HTnh5nQa9JNqi4zOFp1LT/m3URauFAGpFDpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935735; c=relaxed/simple;
	bh=pSHJ5Ns5Kpmf53Ja1OnESbV3iir+ltsthRnNC5FZH2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+qDcjQEfij3vaw/u5EVb/jNF8PHqfnxZ+/KPkIOsgCJf8NtXabWHdWfl19JCG0AHXcPr64d3bA29TsUVzBJ2aHxSgvY4XNXEu06xneLdpavYNdhinhuF7ep5iIXHPKMMahT8+j1GviDHaPGv1f5HMJV21PnTbeEBw1ta+SKND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PVeankrW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXqM19re; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PVeankrW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXqM19re"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF8821400100
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935731;
	 x=1791022131; bh=0UEyBkzgzB5rfBVlZ6SgFiO1QEy06wxr4qTRXbo/1T4=; b=
	PVeankrWiM4XbAknhNp6iK3jy1ipmEGKcpB+KAzSHh9RZIZRk8ZbWLbIdH91gIOI
	OJfqN4hJ4pZh+SahC7BlU5e88B7GB/yhl5JJMOQahF5jtnok4nmIvO1Sh/VL36xZ
	SCAPVuqAXpD4IcBNpbIIc237s6deu4mDH/dlSPVRE7UzjHIZ4gO1hAbT+mkkuz5E
	uuvhcdj8chGujQjQ3vdmmo+J7QBCHEBslWp/2i4kGqCDTJ5+sBfK5lmCrnZAIhXS
	8WbrNRoDIFPhwhZkAAIr7vX4qDkaB3Qwj1YudVCeYCt6ZE3gesiGrltpab+TojPc
	whVnvtDUCakEAKg20xnY3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935731; x=
	1791022131; bh=0UEyBkzgzB5rfBVlZ6SgFiO1QEy06wxr4qTRXbo/1T4=; b=S
	XqM19reTOuOJJQVYsl1VzE7dSJT55v6PgdHrs0WbAmkJbGg/fRUva9su4SswgA/q
	XHQydU5Q3oR2/E4sXefMTAEKVBOawzwXW+R3t+DfgTnX+a2ex025ZZs5ssm547AS
	7p8lUOq19VEeVi98Af+VR13OT8Nm97fsKwjXMn1o2SBiA3Hkxt0vPyu6DhxDWhmQ
	h8SuzAM3yqxXuGg2/5zIUI2eVXLY5tu4qGtapzcQJbndhb6Ka5l3oRoqZzZ2Pymd
	tvhtXOvEWHuJkLiwtQL8moBSx6w8TH/B4V8j951DsmN1RHAp14qTNmFLf8rQiPN7
	UGG74sa8fgkN6Jd3Vf1qw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935731; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:N8CUVN95lD1kL/OFncN5msFFUeoEI+XL3q8Wg85QkQI6NET
	yjmqOsUuApIxL8HsWQduu9jpUHM+WK97Ggmut8Paop0w5CNrsXaA6l0zFd2zydLJ
	Inm38MSYFg7RUFTpukPoteFAXlC6cLwvzwAY/FKUAXf9RcmMB3wPhYlPoLJKFKWz
	b/HENfsODSzDqco2lF7LABj5OOkQiYJ0jEf1/osav8O3Vlg6d6O1zehtCchyMIjv
	ZgkmsKfm3tw4SbMsGDba1owH8JrosGIrZJPGVBDbSk2J0bz3zW/q5P1PmGXxKZmd
	g4FaBJYstmz5WN67bon1njsvrEg9gK5aj9F7JUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:polzgogLPyvYAvJpBMg/drhHWyPFQQUNXww57kVyMp4=:pSHJ5Ns5Kpmf53Ja1OnESbV3iir+ltsthRnNC5FZH2o=;
X-ME-Sender: <xms:s4K_ais1NQ1VLs41lQokp-JBkrmDVyM4LYRBXgp0YwdYFQDE6x8q1A>
    <xme:s4K_auZZsGHxpbcdi7YVA-F3lREpg6vZKXXMNPDmnn5J3TH4zj143QO3G5TRcsGfa
    2s-Hyk6O88jc-5BLXU9Vdb-Dutgpk7pcJTWgcYs-KhlVkuEB-iDCQ>
X-ME-Received: <xmr:s4K_ajZWBdlL-8K9H6cwH77RjICUxuyeTz9_6Ou3SCqZQao2H_BcwA>
X-ME-Proxy-Cause: dmFkZTGAT02lWTZ/HZawnJ/tDJEmEBXLVXxp6MwfA/io4Sxs1l6nT0wzEatoE2fQMDbtpm
    p0gp3n+u0XxYK2N4CQJybkQ1pbEPbrSkjwMeQilVYtooN5JISXASRzysfZGGIuJXYdcQ1Q
    qw/0sdw7da59Q0SGLpwm6WfVe/qbUZmqSgAHokGVJjigUduGeTV/2p0+YAoIgeZDKIboWK
    ebR9j+mvlr+Li/orgYXO2KvuEcbG8RX+IvhOj5yP0wLdgUXh9ZcoXnCXSq+sDT3gVR0jjs
    eIV0I8m87VeWDEn8imSElR4amTLvkCL6Ubwj3FCmUaPVx6oac0qqCnbee4tzgW3UNEhYK0
    iPh6iqM44sVexPmSS7CCyCoCQ0krJZzKaAUM3RPdPvpmQ7TINnwfaC8B9on3XE/GC0e/G/
    ++qg3ig++At1Fe7W6ZQHeWqFlc6n/AZ0fPOWP0Z2LAS9MN928QyM0ZstHI55zKgBrVY8av
    mt9d6koF1s5YDdv5Ii5kxASAsFXAawcvDs/BuwebwKIreLOSgvKPXrOLYvh03Q/B7Z00Vp
    BDFLY981hlpWVOAptW96zieHtYpneWsVGS2Tio5t0HBqe4ur9GtK4DAnEoQFgOWIinjIsi
    QPqDf5FFSfYQH7aRRMtt+T7KnxY7RpzTsLUjhc+V0np1wmfzMgUXpC+id/pg
X-ME-Proxy: <xmx:s4K_aiW69-gVkIOo2pVGqg0qMNmX1J021fAcAN5zrk7ucVwN3ucVUA>
    <xmx:s4K_ai11-BM20T6W2gQ9B4yxick8Uz19VVk9-yyfk3iZ8dTKWV5HFA>
    <xmx:s4K_ahY_N4f13c4wT6tfJsk-Qb66Ic2_Y2JPUqSeIMlJDErc4iosWQ>
    <xmx:s4K_atqpeoD3Abcol4cG81m2wuRh_y8J8ySeLKDRZTCrVCUu0LrODQ>
    <xmx:s4K_atfcErFfwNj2DvXCs7MFD1DuD84Zvi11woGBtmsk3TUZ-t1XPc8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cbe1ab4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:20 +0200
Subject: [PATCH 09/13] tmp-objdir: replace primary source at creation time
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-9-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.56.0.379.gc618271300.dirty

