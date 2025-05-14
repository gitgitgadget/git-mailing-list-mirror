Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD41FF1D9
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199563; cv=none; b=s8BPkvruUDkYrNjTycbjzkwyeGKvXO2w28TfT2WyklmNerx/0jMXUEfgROQQb7wM9C2a0gMKCSQLwwOiHcHkUCZQ6T9pDhHdDzfl+BYZlgXFheccza4Qi1m4sAmjAcBC6U7V677mKsrS1sdcS/Q6w7x3mkyD8ywsLzhpKuU/drU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199563; c=relaxed/simple;
	bh=avbf8KfG1U2y1epiP9d7dsXmWeVRDCXj4T3w/XXQMu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifo+zwLiqQf88issT8yjHS+1rvPmFi12vi8jeSm8E701iqTW4nBacFpseKlQcQ7yURrd9JSsMkeZKW+Jr3FIOKoSstc4Tyvr5cGppVZeah28wq1bhP+lCmohZyeG1isQ0TUy//ydHdDrWLQLcl45sBtZtZyfjtfK7vEZbADMARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ABgNLKoo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQIYcpRu; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ABgNLKoo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQIYcpRu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9709C1380145;
	Wed, 14 May 2025 01:12:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 May 2025 01:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199560;
	 x=1747285960; bh=wbGxOiwlYQp96n6opihtF7k4RaGHCXUDWudWKihqd3c=; b=
	ABgNLKood+pXTS8EDZipQaoMiDqwByfLa1r99v9mBFq1tgca07ynubRbOuaHscCi
	y/6ASRa9xRuYHctQY4e6cZnlYlkzhJVOCD4cGqv05Ex+vHGS1KLVN8bCuQrUa2B/
	+hasUXWIT8/RsdoMPmiwz4yhVoPUJI2w29AoJgLYYs8rqjQj/Y7vfC+pBiGyh412
	fBWpOBkQ7jV9adF59BW0FxjySk/Ar3FZcw6/zlxwsgCfY3X/mYEnZgyAiTSVb/Jq
	UdyH0lX2j3NTl0j8f7tnqhPKsNV5W1/D96/ERrvY8TIAkkJ9a8PWVHDi5D/C9lZW
	6uDP+KpV4FNOKimOjRnZhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199560; x=
	1747285960; bh=wbGxOiwlYQp96n6opihtF7k4RaGHCXUDWudWKihqd3c=; b=q
	QIYcpRuF6B8kSxAVHYNARNlV1daAB3YqF/L7oBmksltChlRaw6j+sMux49jCOfQv
	ChYhrpWlEzEds2WQAiXXByWQXTTaAzJMKQVnyocVKJJEIjo0h+U3vqbfwCpOsNTL
	TyFcSkx1AHyduLJUsp5eZuadqdODw0ICZhYLK4BD+B2XprupdjhtKLq1snBHov+K
	Hjee+lNVXrBYRML+1TwLPEdKUop9QmeM/dPUttOKpE31MkGCgaTgFznc/2vbPRX9
	xVfK7cp0FinfvNFvff65ulKL7v6P6d9qVNvf+PB+Lg1y5B+EOpUBx0ED4d7mKsB5
	jeobPipcY4wQFbG9IHiJA==
X-ME-Sender: <xms:SCYkaEgxikP6apIgGe4x3nhnWvSk9dOvmkPyg78ToDycD57d3nbtVA>
    <xme:SCYkaNDHcxAlwZpQaKhpQK5OsLu9N4KkX0w2qK2fSg5ywG7pdp1uO8_vdZvPQrH3X
    -04P78F5q3MX3819Q>
X-ME-Received: <xmr:SCYkaMFL8ZHk9Lz36y3YMY2KYqSyjplLpVUraQ4X-QixP1AYKYiP6w0AMYYJMv64wa0Wsa_N0etQtrbIjqWma9GTNDLn-6oR90EUSuB04KU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homh
X-ME-Proxy: <xmx:SCYkaFQTnGaXX4KRljMJf5qykqZJj3qgZU-955dOklY8p2wzaQVchw>
    <xmx:SCYkaBx3hc-PyAwD3G2H3MyTwf0RHQ9rDbrAARSMOJHAoc8OOOWE9w>
    <xmx:SCYkaD57jdsOq2kEJ9sVML_6tSOU3-98JLetriCkdOiOfEixi8JzUg>
    <xmx:SCYkaOy-vGs-o2ufJjd10GBLxiz1JcaehjeAh2uNZa6gmWlkA02baA>
    <xmx:SCYkaP1H-3o1352r_nHju2-jU8-nb8JJew8tJt9tGdQltHAWocRfVvwc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0fcf8564 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:34 +0200
Subject: [PATCH v3 11/17] odb: get rid of `the_repository` when handling
 submodule alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-11-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The "--recursive" flag for git-grep(1) allows users to grep for a string
across submodule boundaries. To make this work we add each submodule's
object alternate to our own object database so that the objects can be
accessed directly.

The infrastructure for this depends on a global string list of submodule
paths. The caller is expected to call `add_submodule_odb_by_path()` for
each alternate and the object database will then eventually register all
submodule alternates via `do_oid_object_info_extended()` in case it
isn't able to look up a specific object.

This reliance on global state is of course suboptimal with regards to
our libification efforts.

Refactor the logic so that the list of submodule alternates is instead
tracked in the object database itself. This allows us to lose the
condition of `r == the_repository` before registering submodule
alternates as we only ever add submodule alternates to `the_repository`
anyway. As such, behaviour before and after this refactoring should
always be the same.

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
index b19fee20425..277bc121e4e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -505,7 +505,8 @@ static int grep_submodule(struct grep_opt *opt,
 	 * lazily registered as alternates when needed (and except in an
 	 * unexpected code interaction, it won't be needed).
 	 */
-	add_submodule_odb_by_path(subrepo->objects->alternates->path);
+	odb_add_submodule_alternate_by_path(the_repository->objects,
+					    subrepo->objects->alternates->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/odb.c b/odb.c
index 100dd39cbe8..72ff1ab5a7d 100644
--- a/odb.c
+++ b/odb.c
@@ -24,6 +24,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "submodule.h"
+#include "trace2.h"
 #include "write-or-die.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
@@ -469,6 +470,12 @@ struct odb_alternate *odb_find_alternate(struct object_database *odb, const char
 	return alternate;
 }
 
+void odb_add_submodule_alternate_by_path(struct object_database *odb,
+					 const char *path)
+{
+	string_list_insert(&odb->submodule_alternate_paths, path);
+}
+
 static void fill_alternate_refs_command(struct child_process *cmd,
 					const char *repo_path)
 {
@@ -623,6 +630,23 @@ void disable_obj_read_lock(void)
 
 int fetch_if_missing = 1;
 
+static int register_all_submodule_alternates(struct object_database *odb)
+{
+	int ret = odb->submodule_alternate_paths.nr;
+
+	for (size_t i = 0; i < odb->submodule_alternate_paths.nr; i++)
+		odb_add_to_alternates_memory(odb,
+					     odb->submodule_alternate_paths.items[i].string);
+	if (ret) {
+		string_list_clear(&odb->submodule_alternate_paths, 0);
+		trace2_data_intmax("submodule", odb->repo,
+				   "register_all_submodule_alternates/registered", ret);
+		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
+			BUG("register_all_submodule_alternates() called");
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
+		 * `odb_add_submodule_alternate_by_path()` on that submodule's
+		 * ODB). If any such ODBs exist, register them and try again.
 		 */
-		if (r == the_repository &&
-		    register_all_submodule_odb_as_alternates())
+		if (register_all_submodule_alternates(r->objects))
 			/* We added some alternates; retry */
 			continue;
 
@@ -977,6 +1000,7 @@ struct object_database *odb_new(struct repository *repo)
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
+	string_list_init_dup(&o->submodule_alternate_paths);
 	return o;
 }
 
@@ -1027,4 +1051,5 @@ void odb_clear(struct object_database *o)
 	o->packed_git = NULL;
 
 	hashmap_clear(&o->pack_map);
+	string_list_clear(&o->submodule_alternate_paths, 0);
 }
diff --git a/odb.h b/odb.h
index 0db4de38529..44326cb698d 100644
--- a/odb.h
+++ b/odb.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "list.h"
 #include "oidset.h"
+#include "string-list.h"
 #include "thread-utils.h"
 
 struct oidmap;
@@ -158,6 +159,12 @@ struct object_database {
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
+
+	/*
+	 * Submodule alternate paths that will be added as alternatives to
+	 * allow lookup of submodule objects via the main object database.
+	 */
+	struct string_list submodule_alternate_paths;
 };
 
 struct object_database *odb_new(struct repository *repo);
@@ -183,6 +190,14 @@ void odb_restore_primary_alternate(struct object_database *odb,
 				   struct odb_alternate *restore_alt,
 				   const char *old_path);
 
+/*
+ * Call odb_add_submodule_alternate_by_path() to add the submodule at the given
+ * path to a list. The object stores of all submodules in that list will be
+ * added as alternates in the object store when looking up objects.
+ */
+void odb_add_submodule_alternate_by_path(struct object_database *odb,
+					  const char *path);
+
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/submodule-config.c b/submodule-config.c
index 09034a587f1..0f775f93259 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -810,7 +810,8 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
-				add_submodule_odb_by_path(repo->objects->alternates->path);
+				odb_add_submodule_alternate_by_path(the_repository->objects,
+								    repo->objects->alternates->path);
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
2.49.0.1141.g47af616452.dirty

