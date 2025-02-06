Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB82253F0
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828700; cv=none; b=XipSBfpe9be6BdqUNTGUhu00aqiN9pSGH6eLDXw0xtFJYm1/TENRufnOFshoHdFWKxO+++46r/yb4dmmyDNkPQn/LyJkC5vxNb1Tpa304Mopl8bkriP40pt+ZHumUHTefk7o//DPY3YIsfa07qJMQ3RseeJgpxzGaD3G30x3ZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828700; c=relaxed/simple;
	bh=kGstakfQVzeultUM0sx76ujdzX4K3o9zQS0K34WOyeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=id6dViL9DVQuojV9OS253mUQ5fFKyMUxDpcT18cEO1VctxoZ7W6rmFlOew7UohGJxBaUPwQOdDoLIKJCPhvZ79eiDZgVRAbTSSdGB6lWVY73EoF929Tfv/NJ9AthhCxNghRZTmcrfhhNDDfC5UC9i0RfNtzwVgE2Hlij0uo0iks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mmSxUwO6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsUjNQP6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mmSxUwO6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FsUjNQP6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D97713801FF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Feb 2025 02:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828697;
	 x=1738915097; bh=ncV/U7UTlVqFvA+7uO/uJsnrK+KHqCQrNB7kASsZN3Y=; b=
	mmSxUwO6CZUhD7Js3Rqq2e/fBWlXU0GB51OT8y2cwnXo6jPErWhwykvq/PkRpu74
	Q2uzBP8uv8c4VhhGhRLfUwEwgKA6o0KEDi2ExK6iZwvq1CYZUS4739uLSLoV0G1J
	t1vYU6OM4NIPoh7AngvWImB8JO0hNgwAAfnhckLXhG5ezKY82jXmkoeOG2g6Xfdj
	Znh2CkE2l5THck4/v8ExRVu8/8/XVr40xmA2J+sWnU6N34gPCCkkUOVQW7qCzmv4
	Sq36w06qLhD8iqBLFdxojuJ9TL8IrnRqrIoXctX2J5hfDD/JvqwcXhFux5XPlm4B
	SLOAsXOnsalPFtvMebxr+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828697; x=
	1738915097; bh=ncV/U7UTlVqFvA+7uO/uJsnrK+KHqCQrNB7kASsZN3Y=; b=F
	sUjNQP6RufWLnoOP4BsNuxsgsXsxUY53XJJb80J0x9xLi11/nGgZHuIpJYdgEaVG
	cZZ0eulaNvYEyDuyRKs4lanJOv2smsQQeod7+/VITz/he90hhuxdcFBPBMwzYqKa
	xWNpMCwHpcpWo9UZEnpu4Y0N+tXlYbG6/iFYLlqQOKeA/NJSMHdHOLbhuS1JRPYM
	LmBU6YYRPM8P9q7+RxQ7vwjD9hfrOtoCfTyDxrULlR4ZMYEW8mDEfpQKUZilecwF
	imGf9UFVjkAROV0sGNXL8Sc9EES3E9sKvTCE2rRNUOMGQBLzRy+dDQ59WTYTGP0O
	65SOi2p6GB0tK08BIWfnQ==
X-ME-Sender: <xms:mWukZ7K_AhlGtfbWmG-7Cs0EjDEsNkWjX8bNZf2d1usAFSHHzo_v-A>
    <xme:mWukZ_Kmc3p60ZXDJ02HVB6SqBLG2fSQYvoPme7Bo1-AafoiEzOtKCNY_OPSEGt27
    cUcqjDDtSB3gaomCQ>
X-ME-Received: <xmr:mWukZzvZs8WkR-E9Lg29y6eg2IgBLHhc28gQ9EIFgJPFW9fSBtR_zxPXIHuz2o9zjgXpmoMGC8rGjDrhLs1hR8fs4Fu56WYlbdH-fkX8mX4V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhi
    dqqdetfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthej
    redtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhsse
    hpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueefvedtieefuddvudehveethffghfdv
    hfeugfetiefgffeugfekvddufefhjedtnecuffhomhgrihhnpehshhgrrhgvughrvghpoh
    hsihhtohhrhidrihhnthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mWukZ0bsBXRRaUDwtK0Soh_iXg9t7cYI9nncZ886Z5SbSEh62DKQQA>
    <xmx:mWukZyZCmHkqV9YGbG_Q16pLqTTlFAzyvuR3NlrOF6vAUTJUJck8lw>
    <xmx:mWukZ4DqMAH4b2CdRjLkKwpYYB2BQxCPIR4LmT1gLxIXioYGcSq72A>
    <xmx:mWukZwZqIBUwSRlAEtBf4RYtqyhk97A-jKiLeR6_nmnvEYrnBaJJdg>
    <xmx:mWukZ1z6912pL83nb4PdSrOKPWNqHK9lVdzDAWzXL0QEaOiRbne4XOsz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a680ba22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:11 +0100
Subject: [PATCH 15/16] environment: move access to "core.sharedRepository"
 into repo settings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-15-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Similar as with the preceding commit, we track "core.sharedRepository"
via a pair of global variables. Move them into `struct repo_settings` so
that we can instead track them per-repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c |  8 ++++----
 builtin/log.c     |  6 +++---
 environment.c     | 26 --------------------------
 environment.h     | 10 ----------
 path.c            | 10 +++++-----
 repo-settings.c   | 26 ++++++++++++++++++++++++++
 repo-settings.h   |  9 +++++++++
 setup.c           | 21 +++++++++++----------
 8 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 096f96b9c4..196dccdd77 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -132,8 +132,8 @@ int cmd_init_db(int argc,
 				 * and we know shared_repository should always be 0;
 				 * but just in case we play safe.
 				 */
-				saved = get_shared_repository();
-				set_shared_repository(0);
+				saved = repo_settings_get_shared_repository(the_repository);
+				repo_settings_set_shared_repository(the_repository, 0);
 				switch (safe_create_leading_directories_const(argv[0])) {
 				case SCLD_OK:
 				case SCLD_PERMS:
@@ -145,7 +145,7 @@ int cmd_init_db(int argc,
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
-				set_shared_repository(saved);
+				repo_settings_set_shared_repository(the_repository, saved);
 				if (mkdir(argv[0], 0777) < 0)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried = 1;
@@ -175,7 +175,7 @@ int cmd_init_db(int argc,
 	}
 
 	if (init_shared_repository != -1)
-		set_shared_repository(init_shared_repository);
+		repo_settings_set_shared_repository(the_repository, init_shared_repository);
 
 	/*
 	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
diff --git a/builtin/log.c b/builtin/log.c
index e41f88945e..04a6ef97bc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2309,8 +2309,8 @@ int cmd_format_patch(int argc,
 		 * We consider <outdir> as 'outside of gitdir', therefore avoid
 		 * applying adjust_shared_perm in s-c-l-d.
 		 */
-		saved = get_shared_repository();
-		set_shared_repository(0);
+		saved = repo_settings_get_shared_repository(the_repository);
+		repo_settings_set_shared_repository(the_repository, 0);
 		switch (safe_create_leading_directories_const(output_directory)) {
 		case SCLD_OK:
 		case SCLD_EXISTS:
@@ -2319,7 +2319,7 @@ int cmd_format_patch(int argc,
 			die(_("could not create leading directories "
 			      "of '%s'"), output_directory);
 		}
-		set_shared_repository(saved);
+		repo_settings_set_shared_repository(the_repository, saved);
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 			die_errno(_("could not create directory '%s'"),
 				  output_directory);
diff --git a/environment.c b/environment.c
index 39755873ee..c79acc69e7 100644
--- a/environment.c
+++ b/environment.c
@@ -206,32 +206,6 @@ const char *get_commit_output_encoding(void)
 	return git_commit_encoding ? git_commit_encoding : "UTF-8";
 }
 
-static int the_shared_repository = PERM_UMASK;
-static int need_shared_repository_from_config = 1;
-
-void set_shared_repository(int value)
-{
-	the_shared_repository = value;
-	need_shared_repository_from_config = 0;
-}
-
-int get_shared_repository(void)
-{
-	if (need_shared_repository_from_config) {
-		const char *var = "core.sharedrepository";
-		const char *value;
-		if (!git_config_get_value(var, &value))
-			the_shared_repository = git_config_perm(var, value);
-		need_shared_repository_from_config = 0;
-	}
-	return the_shared_repository;
-}
-
-void reset_shared_repository(void)
-{
-	need_shared_repository_from_config = 1;
-}
-
 int use_optional_locks(void)
 {
 	return git_env_bool(GIT_OPTIONAL_LOCKS_ENVIRONMENT, 1);
diff --git a/environment.h b/environment.h
index 66989afbac..45e690f203 100644
--- a/environment.h
+++ b/environment.h
@@ -134,16 +134,6 @@ void setup_git_env(const char *git_dir);
  */
 int have_git_dir(void);
 
-/*
- * Accessors for the core.sharedrepository config which lazy-load the value
- * from the config (if not already set). The "reset" function can be
- * used to unset "set" or cached value, meaning that the value will be loaded
- * fresh from the config file on the next call to get_shared_repository().
- */
-void set_shared_repository(int value);
-int get_shared_repository(void);
-void reset_shared_repository(void);
-
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
diff --git a/path.c b/path.c
index e81ebd3b5c..a2f402baec 100644
--- a/path.c
+++ b/path.c
@@ -844,17 +844,17 @@ int calc_shared_perm(int mode)
 {
 	int tweak;
 
-	if (get_shared_repository() < 0)
-		tweak = -get_shared_repository();
+	if (repo_settings_get_shared_repository(the_repository) < 0)
+		tweak = -repo_settings_get_shared_repository(the_repository);
 	else
-		tweak = get_shared_repository();
+		tweak = repo_settings_get_shared_repository(the_repository);
 
 	if (!(mode & S_IWUSR))
 		tweak &= ~0222;
 	if (mode & S_IXUSR)
 		/* Copy read bits to execute bits */
 		tweak |= (tweak & 0444) >> 2;
-	if (get_shared_repository() < 0)
+	if (repo_settings_get_shared_repository(the_repository) < 0)
 		mode = (mode & ~0777) | tweak;
 	else
 		mode |= tweak;
@@ -867,7 +867,7 @@ int adjust_shared_perm(const char *path)
 {
 	int old_mode, new_mode;
 
-	if (!get_shared_repository())
+	if (!repo_settings_get_shared_repository(the_repository))
 		return 0;
 	if (get_st_mode_bits(path, &old_mode) < 0)
 		return -1;
diff --git a/repo-settings.c b/repo-settings.c
index 876d527581..67e9cfd2e6 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -4,6 +4,7 @@
 #include "repository.h"
 #include "midx.h"
 #include "pack-objects.h"
+#include "setup.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
@@ -181,3 +182,28 @@ const char *repo_settings_get_hooks_path(struct repository *repo)
 		repo_config_get_pathname(repo, "core.hookspath", &repo->settings.hooks_path);
 	return repo->settings.hooks_path;
 }
+
+int repo_settings_get_shared_repository(struct repository *repo)
+{
+	if (!repo->settings.shared_repository_initialized) {
+		const char *var = "core.sharedrepository";
+		const char *value;
+		if (!repo_config_get_value(repo, var, &value))
+			repo->settings.shared_repository = git_config_perm(var, value);
+		else
+			repo->settings.shared_repository = PERM_UMASK;
+		repo->settings.shared_repository_initialized = 1;
+	}
+	return repo->settings.shared_repository;
+}
+
+void repo_settings_set_shared_repository(struct repository *repo, int value)
+{
+	repo->settings.shared_repository = value;
+	repo->settings.shared_repository_initialized = 1;
+}
+
+void repo_settings_reset_shared_repository(struct repository *repo)
+{
+	repo->settings.shared_repository_initialized = 0;
+}
diff --git a/repo-settings.h b/repo-settings.h
index 0cef970443..ddc11967e0 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -37,6 +37,9 @@ struct repo_settings {
 	int pack_use_bitmap_boundary_traversal;
 	int pack_use_multi_pack_reuse;
 
+	int shared_repository;
+	int shared_repository_initialized;
+
 	/*
 	 * Does this repository have core.useReplaceRefs=true (on by
 	 * default)? This provides a repository-scoped version of this
@@ -65,6 +68,7 @@ struct repo_settings {
 	char *hooks_path;
 };
 #define REPO_SETTINGS_INIT { \
+	.shared_repository = -1, \
 	.index_version = -1, \
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
@@ -84,4 +88,9 @@ int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
 /* Read the value for "core.hooksPath". */
 const char *repo_settings_get_hooks_path(struct repository *repo);
 
+/* Read, set or reset the value for "core.sharedRepository". */
+int repo_settings_get_shared_repository(struct repository *repo);
+void repo_settings_set_shared_repository(struct repository *repo, int value);
+void repo_settings_reset_shared_repository(struct repository *repo);
+
 #endif /* REPO_SETTINGS_H */
diff --git a/setup.c b/setup.c
index 30889386f7..aa65b93f53 100644
--- a/setup.c
+++ b/setup.c
@@ -2332,7 +2332,7 @@ static int create_default_files(const char *template_path,
 	 */
 	copy_templates(template_path);
 	git_config_clear();
-	reset_shared_repository();
+	repo_settings_reset_shared_repository(the_repository);
 	git_config(git_default_config, NULL);
 
 	reinit = is_reinit();
@@ -2342,7 +2342,8 @@ static int create_default_files(const char *template_path,
 	 * values we might have just re-read from the config.
 	 */
 	if (init_shared_repository != -1)
-		set_shared_repository(init_shared_repository);
+		repo_settings_set_shared_repository(the_repository,
+						    init_shared_repository);
 
 	is_bare_repository_cfg = !work_tree;
 
@@ -2350,7 +2351,7 @@ static int create_default_files(const char *template_path,
 	 * We would have created the above under user's umask -- under
 	 * shared-repository settings, we would need to fix them up.
 	 */
-	if (get_shared_repository()) {
+	if (repo_settings_get_shared_repository(the_repository)) {
 		adjust_shared_perm(repo_get_git_dir(the_repository));
 	}
 
@@ -2597,7 +2598,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 					  initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
 
-	if (get_shared_repository()) {
+	if (repo_settings_get_shared_repository(the_repository)) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
 		 * the configuration can be read by older version
@@ -2605,12 +2606,12 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		 * and compatibility values for PERM_GROUP and
 		 * PERM_EVERYBODY.
 		 */
-		if (get_shared_repository() < 0)
+		if (repo_settings_get_shared_repository(the_repository) < 0)
 			/* force to the mode value */
-			xsnprintf(buf, sizeof(buf), "0%o", -get_shared_repository());
-		else if (get_shared_repository() == PERM_GROUP)
+			xsnprintf(buf, sizeof(buf), "0%o", -repo_settings_get_shared_repository(the_repository));
+		else if (repo_settings_get_shared_repository(the_repository) == PERM_GROUP)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
-		else if (get_shared_repository() == PERM_EVERYBODY)
+		else if (repo_settings_get_shared_repository(the_repository) == PERM_EVERYBODY)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			BUG("invalid value for shared_repository");
@@ -2622,12 +2623,12 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		int len = strlen(git_dir);
 
 		if (reinit)
-			printf(get_shared_repository()
+			printf(repo_settings_get_shared_repository(the_repository)
 			       ? _("Reinitialized existing shared Git repository in %s%s\n")
 			       : _("Reinitialized existing Git repository in %s%s\n"),
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 		else
-			printf(get_shared_repository()
+			printf(repo_settings_get_shared_repository(the_repository)
 			       ? _("Initialized empty shared Git repository in %s%s\n")
 			       : _("Initialized empty Git repository in %s%s\n"),
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");

-- 
2.48.1.538.gc4cfc42d60.dirty

