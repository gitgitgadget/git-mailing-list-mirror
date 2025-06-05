Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD852066CE
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106031; cv=none; b=t5E54jxOaiWQpQwGOjYpeCBYbbXe6TTkYTjcoSuRx6uXUwqG//x23EMeuDOcn0dmGz9Z+csC3lhIKaV4xU1W+ywOzWZAmcNAfb2i5fN1TlOWjHKgpn9v7KZi4gQjzX4B5SsZp01gTUCj6w4C2qvhKDnRk8xDbIwjusKXSD8om+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106031; c=relaxed/simple;
	bh=sQpsAjFEI+7U/Kp7X3luAcAX8HrqKXJzk3iyqcXsYzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flyRVujnz5bgnVyuYc3Q/QIeqHcsb6B4FPpVDwtEAOeKUHgod52wFQCgHNS7vq7Jy2b7RpSZZRW15k/aNV34+KqqvlPinOhyvtTzjC3DstqCoSxu1HnN+igR4H4714sh/Nc9sQe5O1+tJJT2SOCoesWP/Iejy+9i5xPJewJ/mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QD7YTB/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUBC9HKc; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QD7YTB/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUBC9HKc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A449725400ED;
	Thu,  5 Jun 2025 02:47:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Jun 2025 02:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106028;
	 x=1749192428; bh=4E3TahzTlNQzRenysv391R5n/lfLb7iJPfg0NIC0lbY=; b=
	QD7YTB/um4kmB1cTD9Ah14nFBBNYrbWW0qfGbtSkeoXoIlAHQd88MoXK2mrl+yo0
	a5+//4Oku7d6CQLiPNHlA9Zvfb6WaeFLBeqXQzXJidJlCR0M9nhvjMxCQnpZULdv
	QDqm38o3aaKL6Jh/AqV0AnCxQaXcSL+ia59pQoKJlr3w8mhBrLwQx9hd3JYELCOH
	da3twAdm0qrga4ObIEpBdahM7o+EQl1noCICpEsebCeF17N1UjdIifzW3tbdq0VF
	rH9ZIWjIdg6kII6bNytOLVtzzR1GMXu34P65A884eOmwrPkzNcHND+BqL9jlvMKi
	mnpG4NJ7j+XOc6KFxLqKpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106028; x=
	1749192428; bh=4E3TahzTlNQzRenysv391R5n/lfLb7iJPfg0NIC0lbY=; b=C
	UBC9HKcbZ4Ok+irhx4+sCrb8xr934YnaMbxdtZg8cXFWB4Zyp0pWnWl+p/AUPEvz
	dhxuOR494CDhZg0W7ThYg0hu5FETh2YFbNHte32wwfp0XSvBZ4q8Zo+b7EdcucRt
	uodUJ/Dp0Tm/VN3YPb7Pz18jziwSGt/nTNKct6RQi4jzNIH3oe/yQrwjAfpSeqB4
	b+deDbmRO2rEIcYLuRULYt93TfwbNgpMMhwNuvqopKfA8ofiNVlYdzGvG/958WkR
	C5UEkPMApOHdj3xRxYHO08kgPIcptAEb+QM/PWcTEHePY91tSlCRCrPOhIjr4tmI
	WS2YaDtnl7qHShavQZoNg==
X-ME-Sender: <xms:bD1BaMC9vFbNVlrU0FLms3clKPMVI7vhKyRNPvGKBuwQ8w_K0L6GWg>
    <xme:bD1BaOhmzTXB_XTIOvAz0ZIgd9Vz0X6BmbPBRxvfLnpFiQPcaYH0DwhjDNmc5gntn
    pLqnD4I7p7oPWK32w>
X-ME-Received: <xmr:bD1BaPmYKXjxlMtXUsoSoBLCmw3LwrKBt1NrMIRnabOSwyvty1WOjOlwuv4TbqBkRx8MqhtDxTkI9ZQ3x2bvTarPI0ycaMQf8iyyvI-I7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bD1BaCxElcH56YhxVNbPsEqE1Oex3OyDf2TFQG21loKIuVT7IqeXbQ>
    <xmx:bD1BaBRTocRnXoL2sLdKDzyuCXSdJ3Q7-FfDmHiSntYWmgecOMQz_w>
    <xmx:bD1BaNbzqhgac_nr0_vdmkZYcqs2qMT8XTU6BVlOB70TRDlq_nSapw>
    <xmx:bD1BaKSnweeBI5VHZLA4rEDq-xF1LHxYy4niPN9xmuriFG3K3VxoZA>
    <xmx:bD1BaPaLQ2s45CrRiMZ2EHuNneKJvvUENrKOm1pkRfztlu0rNRYlfeKf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ca09c44 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:47:01 +0200
Subject: [PATCH v5 11/17] odb: get rid of `the_repository` when handling
 submodule sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-11-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The "--recursive" flag for git-grep(1) allows users to grep for a string
across submodule boundaries. To make this work we add each submodule's
object sources to our own object database so that the objects can be
accessed directly.

The infrastructure for this depends on a global string list of submodule
paths. The caller is expected to call `add_submodule_odb_by_path()` for
each source and the object database will then eventually register all
submodule sources via `do_oid_object_info_extended()` in case it isn't
able to look up a specific object.

This reliance on global state is of course suboptimal with regards to
our libification efforts.

Refactor the logic so that the list of submodule sources is instead
tracked in the object database itself. This allows us to lose the
condition of `r == the_repository` before registering submodule sources
as we only ever add submodule sources to `the_repository` anyway. As
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
index 336cfcab6fb..cfcf916bce1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -505,7 +505,8 @@ static int grep_submodule(struct grep_opt *opt,
 	 * lazily registered as alternates when needed (and except in an
 	 * unexpected code interaction, it won't be needed).
 	 */
-	add_submodule_odb_by_path(subrepo->objects->sources->path);
+	odb_add_submodule_source_by_path(the_repository->objects,
+					 subrepo->objects->sources->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/odb.c b/odb.c
index b154e91953d..decf261dec6 100644
--- a/odb.c
+++ b/odb.c
@@ -24,6 +24,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "submodule.h"
+#include "trace2.h"
 #include "write-or-die.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
@@ -469,6 +470,12 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	return source;
 }
 
+void odb_add_submodule_source_by_path(struct object_database *odb,
+				      const char *path)
+{
+	string_list_insert(&odb->submodule_source_paths, path);
+}
+
 static void fill_alternate_refs_command(struct child_process *cmd,
 					const char *repo_path)
 {
@@ -623,6 +630,23 @@ void disable_obj_read_lock(void)
 
 int fetch_if_missing = 1;
 
+static int register_all_submodule_sources(struct object_database *odb)
+{
+	int ret = odb->submodule_source_paths.nr;
+
+	for (size_t i = 0; i < odb->submodule_source_paths.nr; i++)
+		odb_add_to_alternates_memory(odb,
+					     odb->submodule_source_paths.items[i].string);
+	if (ret) {
+		string_list_clear(&odb->submodule_source_paths, 0);
+		trace2_data_intmax("submodule", odb->repo,
+				   "register_all_submodule_sources/registered", ret);
+		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
+			BUG("register_all_submodule_sources() called");
+	}
+	return ret;
+}
+
 static int do_oid_object_info_extended(struct repository *r,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
@@ -676,13 +700,12 @@ static int do_oid_object_info_extended(struct repository *r,
 		}
 
 		/*
-		 * If r is the_repository, this might be an attempt at
-		 * accessing a submodule object as if it were in the_repository
-		 * (having called add_submodule_odb() on that submodule's ODB).
-		 * If any such ODBs exist, register them and try again.
+		 * This might be an attempt at accessing a submodule object as
+		 * if it were in main object store (having called
+		 * `odb_add_submodule_source_by_path()` on that submodule's
+		 * ODB). If any such ODBs exist, register them and try again.
 		 */
-		if (r == the_repository &&
-		    register_all_submodule_odb_as_alternates())
+		if (register_all_submodule_sources(r->objects))
 			/* We added some alternates; retry */
 			continue;
 
@@ -968,6 +991,7 @@ struct object_database *odb_new(struct repository *repo)
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
+	string_list_init_dup(&o->submodule_source_paths);
 	return o;
 }
 
@@ -1017,4 +1041,5 @@ void odb_clear(struct object_database *o)
 	o->packed_git = NULL;
 
 	hashmap_clear(&o->pack_map);
+	string_list_clear(&o->submodule_source_paths, 0);
 }
diff --git a/odb.h b/odb.h
index 4e2d1004f8a..0ea9d4faa70 100644
--- a/odb.h
+++ b/odb.h
@@ -6,6 +6,7 @@
 #include "list.h"
 #include "oidset.h"
 #include "oidmap.h"
+#include "string-list.h"
 #include "thread-utils.h"
 
 struct oidmap;
@@ -165,6 +166,12 @@ struct object_database {
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
+
+	/*
+	 * Submodule source paths that will be added as additional sources to
+	 * allow lookup of submodule objects via the main object database.
+	 */
+	struct string_list submodule_source_paths;
 };
 
 struct object_database *odb_new(struct repository *repo);
@@ -191,6 +198,14 @@ void odb_restore_primary_source(struct object_database *odb,
 				struct odb_source *restore_source,
 				const char *old_path);
 
+/*
+ * Call odb_add_submodule_source_by_path() to add the submodule at the given
+ * path to a list. The object stores of all submodules in that list will be
+ * added as additional sources in the object store when looking up objects.
+ */
+void odb_add_submodule_source_by_path(struct object_database *odb,
+				      const char *path);
+
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/submodule-config.c b/submodule-config.c
index 9c80f9f7b66..a9f72107888 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -810,7 +810,8 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_submodule_odb_by_path(repo->objects->sources->path);
+				odb_add_submodule_source_by_path(the_repository->objects,
+								 repo->objects->sources->path);
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
2.50.0.rc1.591.g9c95f17f64.dirty

