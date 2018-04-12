Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9071F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeDLW52 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:28 -0400
Received: from ao2.it ([92.243.12.208]:51126 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753064AbeDLW5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:25 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008Uz-JA; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kad-0001VI-KE; Fri, 13 Apr 2018 00:21:11 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 05/10] submodule: adjust references to '.gitmodules' in comments
Date:   Fri, 13 Apr 2018 00:20:42 +0200
Message-Id: <20180412222047.5716-6-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the comments refer to a more generic "gitmodules file" instead of
using the '.gitmodules' file name directly.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 builtin/submodule--helper.c |  2 +-
 config.c                    |  7 +++----
 config.h                    |  7 +++----
 git-submodule.sh            | 10 +++++-----
 repository.h                |  2 +-
 submodule-config.c          |  8 ++++----
 submodule-config.h          |  2 +-
 submodule.c                 | 24 ++++++++++++------------
 8 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 72b95d27b..7e8fa26c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -476,7 +476,7 @@ static void init_submodule(const char *path, const char *prefix,
 	/*
 	 * Copy url setting when it is not set yet.
 	 * To look up the url in .git/config, we must not fall back to
-	 * .gitmodules, so look it up directly.
+	 * the gitmodules file, so look it up directly.
 	 */
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
diff --git a/config.c b/config.c
index 6ffb1d501..9921b6c2c 100644
--- a/config.c
+++ b/config.c
@@ -2079,11 +2079,10 @@ int git_config_get_pathname(const char *key, const char **dest)
 
 /*
  * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
+ * 'fetch' and 'update_clone' storing configuration in the gitmodules file and
+ * should NOT be used anywhere else.
  *
- * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
+ * Runs the provided config function on the gitmodules file.
  */
 void config_from_gitmodules(config_fn_t fn, void *data)
 {
diff --git a/config.h b/config.h
index ef70a9cac..37aef35d5 100644
--- a/config.h
+++ b/config.h
@@ -191,11 +191,10 @@ extern int repo_config_get_pathname(struct repository *repo,
 
 /*
  * Note: This function exists solely to maintain backward compatibility with
- * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
- * NOT be used anywhere else.
+ * 'fetch' and 'update_clone' storing configuration in the gitmodules file and
+ * should NOT be used anywhere else.
  *
- * Runs the provided config function on the '.gitmodules' file found in the
- * working directory.
+ * Runs the provided config function on the gitmodules file.
  */
 extern void config_from_gitmodules(config_fn_t fn, void *data);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 610fd0dc5..615a65be9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -59,10 +59,10 @@ die_if_unmatched ()
 # $3 = default value
 #
 # Checks in the usual git-config places first (for overrides),
-# otherwise it falls back on .gitmodules.  This allows you to
-# distribute project-wide defaults in .gitmodules, while still
+# otherwise it falls back to the gitmodules file.  This allows you to
+# distribute project-wide defaults in the gitmodules file, while still
 # customizing individual repositories if necessary.  If the option is
-# not in .gitmodules either, print a default value.
+# not in the gitmodules file either, print a default value.
 #
 get_submodule_config () {
 	name="$1"
@@ -95,7 +95,7 @@ sanitize_submodule_env()
 }
 
 #
-# Add a new submodule to the working tree, .gitmodules and the index
+# Add a new submodule to the working tree, the gitmodules file and the index
 #
 # $@ = repo path
 #
@@ -960,7 +960,7 @@ cmd_status()
 #
 # Sync remote urls for submodules
 # This makes the value for remote.$remote.url match the value
-# specified in .gitmodules.
+# specified in the gitmodules file.
 #
 cmd_sync()
 {
diff --git a/repository.h b/repository.h
index 09df94a47..2db62af0e 100644
--- a/repository.h
+++ b/repository.h
@@ -59,7 +59,7 @@ struct repository {
 	 */
 	struct config_set *config;
 
-	/* Repository's submodule config as defined by '.gitmodules' */
+	/* Repository's submodule config as defined by the gitmodules file */
 	struct submodule_cache *submodule_cache;
 
 	/*
diff --git a/submodule-config.c b/submodule-config.c
index 620d522ee..18984473b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -9,7 +9,7 @@
 /*
  * submodule cache lookup structure
  * There is one shared set of 'struct submodule' entries which can be
- * looked up by their sha1 blob id of the .gitmodules file and either
+ * looked up by their sha1 blob id of the gitmodules file and either
  * using path or name as key.
  * for_path stores submodule entries with path as key
  * for_name stores submodule entries with name as key
@@ -91,7 +91,7 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 	/*
 	 * We iterate over the name hash here to be symmetric with the
 	 * allocation of struct submodule entries. Each is allocated by
-	 * their .gitmodules blob sha1 and submodule name.
+	 * their gitmodules file blob sha1 and submodule name.
 	 */
 	hashmap_iter_init(&cache->for_name, &iter);
 	while ((entry = hashmap_iter_next(&iter)))
@@ -476,7 +476,7 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
 }
 
 /* This does a lookup of a submodule configuration by name or by path
- * (key) with on-demand reading of the appropriate .gitmodules from
+ * (key) with on-demand reading of the appropriate gitmodules file from
  * revisions.
  */
 static const struct submodule *config_from(struct submodule_cache *cache,
@@ -614,7 +614,7 @@ static void gitmodules_read_check(struct repository *repo)
 {
 	submodule_cache_check_init(repo);
 
-	/* read the repo's .gitmodules file if it hasn't been already */
+	/* read the repo's gitmodules file if it hasn't been already */
 	if (!repo->submodule_cache->gitmodules_read)
 		repo_read_gitmodules(repo);
 }
diff --git a/submodule-config.h b/submodule-config.h
index a5503a5d1..75fa54cf2 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -17,7 +17,7 @@ struct submodule {
 	const char *ignore;
 	const char *branch;
 	struct submodule_update_strategy update_strategy;
-	/* the sha1 blob id of the responsible .gitmodules file */
+	/* the sha1 blob id of the responsible gitmodules file */
 	unsigned char gitmodules_sha1[20];
 	int recommend_shallow;
 };
diff --git a/submodule.c b/submodule.c
index 97213b549..d9b84760f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -30,16 +30,16 @@ static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
 
 /*
- * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
- * will be disabled because we can't guess what might be configured in
- * .gitmodules unless the user resolves the conflict.
+ * Check if the gitmodules file is unmerged. Parsing of the gitmodules
+ * file will be disabled because we can't guess what might be configured in
+ * the gitmodules file unless the user resolves the conflict.
  */
 int is_gitmodules_unmerged(const struct index_state *istate)
 {
 	int pos = index_name_pos(istate, submodules_file, strlen(submodules_file));
-	if (pos < 0) { /* .gitmodules not found or isn't merged */
+	if (pos < 0) { /* gitmodules file not found or isn't merged */
 		pos = -1 - pos;
-		if (istate->cache_nr > pos) {  /* there is a .gitmodules */
+		if (istate->cache_nr > pos) {  /* there is a gitmodules file */
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_namelen(ce) == strlen(submodules_file) &&
 			    !strcmp(ce->name, submodules_file))
@@ -51,8 +51,8 @@ int is_gitmodules_unmerged(const struct index_state *istate)
 }
 
 /*
- * Check if the .gitmodules file has unstaged modifications.  This must be
- * checked before allowing modifications to the .gitmodules file with the
+ * Check if the gitmodules file has unstaged modifications.  This must be
+ * checked before allowing modifications to the gitmodules file with the
  * intention to stage them later, because when continuing we would stage the
  * modifications the user didn't stage herself too. That might change in a
  * future version when we learn to stage the changes we do ourselves without
@@ -82,7 +82,7 @@ static int for_each_remote_ref_submodule(const char *submodule,
 
 /*
  * Try to update the "path" entry in the "submodule.<name>" section of the
- * .gitmodules file. Return 0 only if a .gitmodules file was found, a section
+ * gitmodules file. Return 0 only if a gitmodules file was found, a section
  * with the correct path=<oldpath> setting was found and we could update it.
  */
 int update_path_in_gitmodules(const char *oldpath, const char *newpath)
@@ -90,7 +90,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	struct strbuf entry = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(submodules_file)) /* Do nothing without .gitmodules */
+	if (!file_exists(submodules_file)) /* Do nothing without a gitmodules file */
 		return -1;
 
 	if (is_gitmodules_unmerged(&the_index))
@@ -115,8 +115,8 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 }
 
 /*
- * Try to remove the "submodule.<name>" section from .gitmodules where the given
- * path is configured. Return 0 only if a .gitmodules file was found, a section
+ * Try to remove the "submodule.<name>" section from the gitmodules file where the given
+ * path is configured. Return 0 only if a gitmodules file was found, a section
  * with the correct path=<path> setting was found and we could remove it.
  */
 int remove_path_from_gitmodules(const char *path)
@@ -124,7 +124,7 @@ int remove_path_from_gitmodules(const char *path)
 	struct strbuf sect = STRBUF_INIT;
 	const struct submodule *submodule;
 
-	if (!file_exists(submodules_file)) /* Do nothing without .gitmodules */
+	if (!file_exists(submodules_file)) /* Do nothing without a gitmodules file */
 		return -1;
 
 	if (is_gitmodules_unmerged(&the_index))
-- 
2.17.0

