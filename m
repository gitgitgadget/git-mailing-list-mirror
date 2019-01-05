Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745C41F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 05:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfAEFwq (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 00:52:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42186 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfAEFwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 00:52:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so18345897plp.9
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 21:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmiD5qq5Vt9vDXBIgCf2I7g6RKcm4d/PYfk9p3S3ZbM=;
        b=MBIM9QjIs7PM/WOMhZ5oU0t4E/JZjoNgD40pC5tWOYXAHfOGVkRmlus1TdhfvO44lZ
         JjWQwBqObb+muxjmCknNWehnUAbf2jGbZsZoknXCLu4IDdlZ1hJ5lbsJjAnw7BE11sqc
         b22p9U5pfSe+Id7LDS7jmTmnlzma9um+5nPlsTA/FjXkcy1p6N39jSxm90CdZlOA/Qgl
         i0y5XVcOQzU8GUs+9ZBBoO9ne9SycZvkT1SRN1KA23+ZlGUHdyfctx2+w05KXpdU3pXg
         XiamvXe2jWxEaoJlAMXtQrHQXqOpdKe7gS2Df2luMUODduyO/s/RpOpQlPjminVTAq7n
         m0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmiD5qq5Vt9vDXBIgCf2I7g6RKcm4d/PYfk9p3S3ZbM=;
        b=k7wPzxhmQlUUugJNYDQbFH79hc1rVHzFzorneGyxEypFKVNHMLG/fdVe99cCBnVmD8
         l/91FjmClu60fjs82XxTutbkz2HpNUTwk4V+8GTyOqbryR/dN1yRkZFc4gnoH0eJcJWC
         +3JCVPPOMIc97mIya24RO07XzDvArSEK2g34zCTxN4Xu7uegaiHFeoOarEqO5LvgLc/u
         BWX2BA1UOTIr63BG0GudGKmDlA8lVHKHxe+Z6sYy2+HSqpIlu7d23U+wlAta0t4Y2NO5
         9mPNYoWDF1LR5hS2DN/pPGzhhfl5LlmK+b0wLPbaIoQJMsVlsH+DyzAvYYnYY6YyK5at
         NvmA==
X-Gm-Message-State: AJcUukeDSjsRt4uWu3K2TPqWzSEnc47ScwTcMfofKTQdkX/xmpdkJzgi
        KbEqHMtjAsaPQRLGIU+cq0jPlGEZnnA=
X-Google-Smtp-Source: ALg8bN4iwFElEEXWcw+IaJiYTFE3jQPtxaJx+07gfAS59twPfoHL9dgOyXXHb89DkqTInUpCACgrBw==
X-Received: by 2002:a17:902:3181:: with SMTP id x1mr12345753plb.58.1546667564994;
        Fri, 04 Jan 2019 21:52:44 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id b7sm85706473pfa.52.2019.01.04.21.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:52:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 05 Jan 2019 12:52:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/10] sha1-name.c: remove implicit dependency on the_index
Date:   Sat,  5 Jan 2019 12:51:49 +0700
Message-Id: <20190105055153.3256-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190105055153.3256-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This kills the_index dependency in get_oid_with_context() but for
get_oid() and friends, they still assume the_repository (which also
means the_index).

Unfortunately the widespread use of get_oid() will make it hard to
make the conversion now. We probably will add repo_get_oid() at some
point and limit the use of get_oid() in builtin/ instead of forcing
all get_oid() call sites to carry struct repository.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/cat-file.c            |  6 ++--
 builtin/grep.c                |  3 +-
 builtin/log.c                 |  3 +-
 builtin/rev-parse.c           |  3 +-
 cache.h                       |  4 ++-
 list-objects-filter-options.c |  2 +-
 revision.c                    |  8 +++---
 sha1-name.c                   | 54 +++++++++++++++++++++--------------
 8 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2ca56fd086..7622c502f0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -73,7 +73,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
-	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
 				 &oid, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
@@ -382,7 +383,8 @@ static void batch_one_object(const char *obj_name,
 	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
-	result = get_oid_with_context(obj_name, flags, &data->oid, &ctx);
+	result = get_oid_with_context(the_repository, obj_name,
+				      flags, &data->oid, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
diff --git a/builtin/grep.c b/builtin/grep.c
index bad9c0a3d5..3d695ad8fe 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1014,7 +1014,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (get_oid_with_context(arg, GET_OID_RECORD_PATH,
+		if (get_oid_with_context(the_repository, arg,
+					 GET_OID_RECORD_PATH,
 					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
diff --git a/builtin/log.c b/builtin/log.c
index e8e51068bd..dbfb4e31ad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -508,7 +508,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !rev->diffopt.flags.allow_textconv)
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
-	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
+	if (get_oid_with_context(the_repository, obj_name,
+				 GET_OID_RECORD_PATH,
 				 &oidc, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 10d4dab894..910a71ed8b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -933,7 +933,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_oid_with_context(name, flags, &oid, &unused)) {
+		if (!get_oid_with_context(the_repository, name,
+					  flags, &oid, &unused)) {
 			if (verify)
 				revs_count++;
 			else
diff --git a/cache.h b/cache.h
index 702c5bfbb3..fdcd69bfb0 100644
--- a/cache.h
+++ b/cache.h
@@ -1328,7 +1328,9 @@ extern int get_oid_tree(const char *str, struct object_id *oid);
 extern int get_oid_treeish(const char *str, struct object_id *oid);
 extern int get_oid_blob(const char *str, struct object_id *oid);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc);
+extern int get_oid_with_context(struct repository *repo, const char *str,
+				unsigned flags, struct object_id *oid,
+				struct object_context *oc);
 
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8da2e8581..8443184e22 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -71,7 +71,7 @@ static int gently_parse_list_objects_filter(
 		 * command, but DO NOT complain if we don't have the blob or
 		 * ref locally.
 		 */
-		if (!get_oid_with_context(v0, GET_OID_BLOB,
+		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
 					  &sparse_oid, &oc))
 			filter_options->sparse_oid_value = oiddup(&sparse_oid);
 		filter_options->choice = LOFC_SPARSE_OID;
diff --git a/revision.c b/revision.c
index c51ea6a052..4a723efe9a 100644
--- a/revision.c
+++ b/revision.c
@@ -1589,8 +1589,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	if (!*b_name)
 		b_name = "HEAD";
 
-	if (get_oid_with_context(a_name, oc_flags, &a_oid, a_oc) ||
-	    get_oid_with_context(b_name, oc_flags, &b_oid, b_oc))
+	if (get_oid_with_context(revs->repo, a_name, oc_flags, &a_oid, a_oc) ||
+	    get_oid_with_context(revs->repo, b_name, oc_flags, &b_oid, b_oc))
 		return -1;
 
 	if (!cant_be_filename) {
@@ -1724,7 +1724,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags |= GET_OID_COMMITTISH;
 
-	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
+	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -2453,7 +2453,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
-		if (get_oid_with_context(revs->def, 0, &oid, &oc))
+		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
diff --git a/sha1-name.c b/sha1-name.c
index a0fc1008ec..d8cab7b5a6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1513,7 +1513,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 int get_oid(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, 0, oid, &unused);
+	return get_oid_with_context(the_repository, name, 0, oid, &unused);
 }
 
 
@@ -1530,35 +1530,40 @@ int get_oid(const char *name, struct object_id *oid)
 int get_oid_committish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_COMMITTISH,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_COMMITTISH,
 				    oid, &unused);
 }
 
 int get_oid_treeish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_TREEISH,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_TREEISH,
 				    oid, &unused);
 }
 
 int get_oid_commit(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_COMMIT,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_COMMIT,
 				    oid, &unused);
 }
 
 int get_oid_tree(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_TREE,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_TREE,
 				    oid, &unused);
 }
 
 int get_oid_blob(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_OID_BLOB,
+	return get_oid_with_context(the_repository,
+				    name, GET_OID_BLOB,
 				    oid, &unused);
 }
 
@@ -1597,7 +1602,8 @@ static void diagnose_invalid_oid_path(const char *prefix,
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(int stage,
+static void diagnose_invalid_index_path(struct index_state *istate,
+					int stage,
 					const char *prefix,
 					const char *filename)
 {
@@ -1610,11 +1616,11 @@ static void diagnose_invalid_index_path(int stage,
 		prefix = "";
 
 	/* Wrong stage number? */
-	pos = cache_name_pos(filename, namelen);
+	pos = index_name_pos(istate, filename, namelen);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < istate->cache_nr) {
+		ce = istate->cache[pos];
 		if (ce_namelen(ce) == namelen &&
 		    !memcmp(ce->name, filename, namelen))
 			die("Path '%s' is in the index, but not at stage %d.\n"
@@ -1626,11 +1632,11 @@ static void diagnose_invalid_index_path(int stage,
 	/* Confusion between relative and absolute filenames? */
 	strbuf_addstr(&fullname, prefix);
 	strbuf_addstr(&fullname, filename);
-	pos = cache_name_pos(fullname.buf, fullname.len);
+	pos = index_name_pos(istate, fullname.buf, fullname.len);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < istate->cache_nr) {
+		ce = istate->cache[pos];
 		if (ce_namelen(ce) == fullname.len &&
 		    !memcmp(ce->name, fullname.buf, fullname.len))
 			die("Path '%s' is in the index, but not '%s'.\n"
@@ -1664,7 +1670,8 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-static int get_oid_with_context_1(const char *name,
+static int get_oid_with_context_1(struct repository *repo,
+				  const char *name,
 				  unsigned flags,
 				  const char *prefix,
 				  struct object_id *oid,
@@ -1723,13 +1730,13 @@ static int get_oid_with_context_1(const char *name,
 		if (flags & GET_OID_RECORD_PATH)
 			oc->path = xstrdup(cp);
 
-		if (!the_index.cache)
+		if (!repo->index->cache)
 			repo_read_index(the_repository);
-		pos = index_name_pos(&the_index, cp, namelen);
+		pos = index_name_pos(repo->index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
-		while (pos < active_nr) {
-			ce = active_cache[pos];
+		while (pos < repo->index->cache_nr) {
+			ce = repo->index->cache[pos];
 			if (ce_namelen(ce) != namelen ||
 			    memcmp(ce->name, cp, namelen))
 				break;
@@ -1742,7 +1749,7 @@ static int get_oid_with_context_1(const char *name,
 			pos++;
 		}
 		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(stage, prefix, cp);
+			diagnose_invalid_index_path(repo->index, stage, prefix, cp);
 		free(new_path);
 		return -1;
 	}
@@ -1807,12 +1814,15 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(name, GET_OID_ONLY_TO_DIE, prefix, &oid, &oc);
+	get_oid_with_context_1(the_repository, name, GET_OID_ONLY_TO_DIE,
+			       prefix, &oid, &oc);
 }
 
-int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
+int get_oid_with_context(struct repository *repo, const char *str,
+			 unsigned flags, struct object_id *oid,
+			 struct object_context *oc)
 {
 	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
 		BUG("incompatible flags for get_sha1_with_context");
-	return get_oid_with_context_1(str, flags, NULL, oid, oc);
+	return get_oid_with_context_1(repo, str, flags, NULL, oid, oc);
 }
-- 
2.20.0.482.g66447595a7

