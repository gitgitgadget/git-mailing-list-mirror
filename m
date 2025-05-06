Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFD27B515
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529772; cv=none; b=Iu7kb8fXPTefXfISecLkJPhmC0z9LLS0JcNt6fmGyLY4SoacJrBbtpIQTfoxcMH1f/llfPZMHuf9bLIouazHOMhbChIhgUQ2SyeQ1zhHOVgKL/I0FmM87gr/9C/V7j0OH9fOXeL5uhwZF75tsw8Hh+o4eqCKt6NZZIWVS5KP6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529772; c=relaxed/simple;
	bh=G/kr50USkrV4aDEI5SKowOKomuFpi2Y2a3O8PzVLAoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnkcS0Myqe8Lwh9cahGZ2hZbjrJ3mS25TKXSsTsUSCNMnLsrpDrJRX0zkc3Fbt1dRmU1Y190K3RtXaks/vRd7DL8A1DsHl2juM5O6BvV38+fKwXU6C9Tci7pmtwxwO32uzVQSvl6Dj9cMLKTZjmjlk+QKLaEtB1Fe0vcyKKiKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sdw72AbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tk/EcYkg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sdw72AbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tk/EcYkg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F49F11401DD
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529769;
	 x=1746616169; bh=E8EhWIRabo2XCPk23fbqzlkuprlZRT+v9P0c6UA+7wk=; b=
	Sdw72AbEdqBnukVwKF2OD4Ctj9ZooK6Xdgo8Zj3O/vrdORfdqOy30ottKAuPTGZC
	lyiTJzk8AuS1o0gv7B6TC6cDQqlm+t7PnIRGmfG8396h9Nl0eiROmf4FiLDdn9fi
	aODtmRrElDMSZizVF+fTVWFo60kSHpwfwzjj7RCmVoEfRpzpXxiKcASSSHnzUnRM
	cQwGHMNzQ932YqVi0nnCc/m/rYV7Mj7zdlykarQzs+K3/74E2xAIS10iTO/gN939
	6lhgODI3H5BK9SFLgUbtyk1GXRYeLo1qAFpXrYj+MGae6RDS6utrLkmfYgxuxHa0
	4NQuMdJgxPGk3Uewar/GPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529769; x=
	1746616169; bh=E8EhWIRabo2XCPk23fbqzlkuprlZRT+v9P0c6UA+7wk=; b=t
	k/EcYkgr7bdbzsvQYdlzppp5APoZY0NmLq7oRv36e6SVGmZDYgpPcZskmFYFp7VI
	OeSE8wA3MMxW4TaFsq/SkkbIwXjGupKDFYcg27eUoLbi/1QRTFCq3ijTNfudfw64
	Z0DpPyxlpHAJb1SjPCfFfwMyKn+htmR2Mpmg8+sxy7Im3kAPA7sS4zZyLurdct0V
	vpUv7q4zoaABHuChfhLskWr8rM2anVAOayYb3A83eseesOpuMLjJEZxyFMmTdhIs
	ctzsben1hYiWdGFAAdkLHh3PuOhX3M1Mi2mh3i01WwmfW/MFdBIkOb4e+WAtgDmg
	/vkNs6aacf2uB09htd7jw==
X-ME-Sender: <xms:6e0ZaE610dVJtgdFFiv8J9fptRDCmGDZaRyuXTuClcYevtEzJI2VMw>
    <xme:6e0ZaF5iDINnSbk7YPl9dnTVSEV-f9ntxbsIEu-Xv4dCFBUTQBWWXqe0IGgO6n4h6
    sVN_zf0GLYk8EPl4Q>
X-ME-Received: <xmr:6e0ZaDeurhYS0g3Qkc9REZ4tjpSpgQE3su2z2_deQfU9wbkzZPfwv_eZfhVJNSFTFhsr4qqmSNRJpsdreIQ0seximYp1nOeQgWfVyXh7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6e0ZaJIDfSp9Mcw1gGHkwD6nlhSzdA4_ARLOBDF9H6iGr_pcUvPr2A>
    <xmx:6e0ZaIJ1S4v0Ar1Q75OD8Zo-4a3O0uvK_NGUuWHGZy1ojaU4Imjg6A>
    <xmx:6e0ZaKxwcqu6cbs9eY7l2WYSNpGzYm6DQQuPm77yfpYjeihe92jnsw>
    <xmx:6e0ZaMISIkrlR-_du-EZ8W8YlglXWOp3LOZBkC-nEDucnyCOZdERtg>
    <xmx:6e0ZaNUsAj-e3V-BCSfsxu50P3bIOqtIHXgL3uysymx-fYzpOCeYfEwy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bed0e92 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:24 +0200
Subject: [PATCH 11/17] odb: get rid of `the_repository` when handling
 submodule backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-11-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "--recursive" flag for git-grep(1) allows users to grep for a string
across submodule boundaries. To make this work we add each submodule's
object backend to our own object database so that the objects can be
accessed directly.

The infrastructure for this depends on a global string list of submodule
paths. The caller is expected to call `add_submodule_odb_by_path()` for
each backend and the object database will then eventually register all
submodule backends via `do_oid_object_info_extended()` in case it isn't
able to look up a specific object.

This reliance on global state is of course suboptimal with regards to
our libification efforts.

Refactor the logic so that the list of submodule backends is instead
tracked in the object database itself. This allows us to lose the
condition of `r == the_repository` before registering submodule backends
as we only ever add submodule backends to `the_repository` anyway. As
such, behaviour before and after this refactoring should always be the
same.

Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c     |  3 ++-
 odb.c              | 37 +++++++++++++++++++++++++++++++------
 odb.h              | 15 +++++++++++++++
 submodule-config.c |  3 ++-
 submodule.c        | 26 --------------------------
 submodule.h        |  9 ---------
 6 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 610428e6298..e9816cce8cd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -505,7 +505,8 @@ static int grep_submodule(struct grep_opt *opt,
 	 * lazily registered as alternates when needed (and except in an
 	 * unexpected code interaction, it won't be needed).
 	 */
-	add_submodule_odb_by_path(subrepo->objects->backends->path);
+	odb_add_submodule_backend_by_path(the_repository->objects,
+					  subrepo->objects->backends->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/odb.c b/odb.c
index 8be5d4fb2d6..bfdf36751e0 100644
--- a/odb.c
+++ b/odb.c
@@ -24,6 +24,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "submodule.h"
+#include "trace2.h"
 #include "write-or-die.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
@@ -469,6 +470,12 @@ struct odb_backend *odb_find_backend(struct object_database *odb, const char *ob
 	return backend;
 }
 
+void odb_add_submodule_backend_by_path(struct object_database *odb,
+				       const char *path)
+{
+	string_list_insert(&odb->submodule_backend_paths, path);
+}
+
 static void fill_alternate_refs_command(struct child_process *cmd,
 					const char *repo_path)
 {
@@ -623,6 +630,23 @@ void disable_obj_read_lock(void)
 
 int fetch_if_missing = 1;
 
+static int register_all_submodule_backends(struct object_database *odb)
+{
+	int ret = odb->submodule_backend_paths.nr;
+
+	for (size_t i = 0; i < odb->submodule_backend_paths.nr; i++)
+		odb_add_to_alternates_memory(odb,
+					     odb->submodule_backend_paths.items[i].string);
+	if (ret) {
+		string_list_clear(&odb->submodule_backend_paths, 0);
+		trace2_data_intmax("submodule", odb->repo,
+				   "register_all_submodule_backends/registered", ret);
+		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
+			BUG("register_all_submodule_backends() called");
+	}
+	return ret;
+}
+
 static int do_oid_object_info_extended(struct repository *r,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
@@ -678,13 +702,12 @@ static int do_oid_object_info_extended(struct repository *r,
 		}
 
 		/*
-		 * If r is the_repository, this might be an attempt at
-		 * accessing a submodule object as if it were in the_repository
-		 * (having called add_submodule_odb() on that submodule's ODB).
-		 * If any such ODBs exist, register them and try again.
+		 * This might be an attempt at accessing a submodule object as
+		 * if it were in main object store (having called
+		 * `odb_add_submodule_backend_by_path()` on that submodule's
+		 * ODB). If any such ODBs exist, register them and try again.
 		 */
-		if (r == the_repository &&
-		    register_all_submodule_odb_as_alternates())
+		if (register_all_submodule_backends(r->objects))
 			/* We added some alternates; retry */
 			continue;
 
@@ -977,6 +1000,7 @@ struct object_database *odb_new(struct repository *repo)
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
+	string_list_init_dup(&o->submodule_backend_paths);
 	return o;
 }
 
@@ -1027,4 +1051,5 @@ void odb_clear(struct object_database *o)
 	o->packed_git = NULL;
 
 	hashmap_clear(&o->pack_map);
+	string_list_clear(&o->submodule_backend_paths, 0);
 }
diff --git a/odb.h b/odb.h
index e80ee5efec6..1558f467425 100644
--- a/odb.h
+++ b/odb.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "list.h"
 #include "oidset.h"
+#include "string-list.h"
 #include "thread-utils.h"
 
 struct oidmap;
@@ -153,6 +154,12 @@ struct object_database {
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
+
+	/*
+	 * Submodule backend paths that will be added as alternatives to allow
+	 * lookup of submodule objects via the main object database.
+	 */
+	struct string_list submodule_backend_paths;
 };
 
 struct object_database *odb_new(struct repository *repo);
@@ -178,6 +185,14 @@ void odb_restore_primary_backend(struct object_database *odb,
 				 struct odb_backend *restore_odb,
 				 const char *old_path);
 
+/*
+ * Call odb_add_submodule_backend_by_path() to add the submodule at the given
+ * path to a list. The object stores of all submodules in that list will be
+ * added as alternates in the object store when looking up objects.
+ */
+void odb_add_submodule_backend_by_path(struct object_database *odb,
+				       const char *path);
+
 /*
  * Iterate through all backends of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/submodule-config.c b/submodule-config.c
index 4abef906f26..ed4bb32dc37 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -810,7 +810,8 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_submodule_odb_by_path(repo->objects->backends->path);
+				odb_add_submodule_backend_by_path(the_repository->objects,
+								  repo->objects->backends->path);
 		} else {
 			goto out;
 		}
diff --git a/submodule.c b/submodule.c
index 386be234230..788c9e55ed3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -31,7 +31,6 @@
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
-#include "trace2.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
@@ -176,31 +175,6 @@ void stage_updated_gitmodules(struct index_state *istate)
 		die(_("staging updated .gitmodules failed"));
 }
 
-static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_DUP;
-
-void add_submodule_odb_by_path(const char *path)
-{
-	string_list_insert(&added_submodule_odb_paths, path);
-}
-
-int register_all_submodule_odb_as_alternates(void)
-{
-	int i;
-	int ret = added_submodule_odb_paths.nr;
-
-	for (i = 0; i < added_submodule_odb_paths.nr; i++)
-		odb_add_to_alternates_memory(the_repository->objects,
-					     added_submodule_odb_paths.items[i].string);
-	if (ret) {
-		string_list_clear(&added_submodule_odb_paths, 0);
-		trace2_data_intmax("submodule", the_repository,
-				   "register_all_submodule_odb_as_alternates/registered", ret);
-		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
-			BUG("register_all_submodule_odb_as_alternates() called");
-	}
-	return ret;
-}
-
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
diff --git a/submodule.h b/submodule.h
index db980c1d083..b10e16e6c06 100644
--- a/submodule.h
+++ b/submodule.h
@@ -104,15 +104,6 @@ int submodule_uses_gitfile(const char *path);
 #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
 int bad_to_remove_submodule(const char *path, unsigned flags);
 
-/*
- * Call add_submodule_odb_by_path() to add the submodule at the given
- * path to a list. When register_all_submodule_odb_as_alternates() is
- * called, the object stores of all submodules in that list will be
- * added as alternates in the_repository.
- */
-void add_submodule_odb_by_path(const char *path);
-int register_all_submodule_odb_as_alternates(void);
-
 /*
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.

-- 
2.49.0.1045.g170613ef41.dirty

