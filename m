Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E378F1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeCWRXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:23:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42863 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeCWRVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id a22-v6so19369833lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edfH2OHRCFJNpRoWAL8jgFMm6AeJ8FpU4qQRdaAmxOU=;
        b=NW7UOQ0b6YCypgKcv+QO6/nmDvXXTHapVa+m+zR8kqnfuA0gDKwi7Zoj4YP+C/cIdr
         vnu/H2RgTwlXTHLw4jehJex171WM2ygPhCMADMZxJG7FV5WZFJ0UtVXRvxqKLplTFxmU
         1jkp+k6dfuM6N/5oPiRFzdwUoN5LMFnR1rJ9jTOwCH0VCYnf8ZNwtKBUj3D+oukFk+yP
         GhwIgtkTYpSMMSm1V6OCzncg6VcmmhEQjSWWsraclEkNTB+TAgeTxfIIszDO8y51zpWj
         FsyfS4hZkYvOZsWxnIR5qCeTTiasXKXllJU8q6WtKeEnpWfHGVlGflDOl3sLlejhquOV
         0DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edfH2OHRCFJNpRoWAL8jgFMm6AeJ8FpU4qQRdaAmxOU=;
        b=El33flwTDvlOzflbd10UPLJEvYM7kZLk1IANo3JfYLp+b5V7QUatWhDzBa7KoLgKGp
         9KSPBZk1UzRcSIspDAFUowLMmDONGqwY0nSsnRg8sA/To9lW+s+c0GnSueyd36T3RmJc
         EdhAwAMpHXOqebeHJPZfILwdnEh8I+F6pOMBsnxZf1OXSPxC4cUOhh7hR3GKQcoLJxwS
         zlhPcAnhW8leyd3356jNQetl5M45fv23meyrXR2mYWn8HKi1qNoYQprEqOKpZ6tx8kV7
         nxg2TurZvvpW5JoJN4paYWsGARaisPn2/Xo3+a2eeAmazeoCyUvx1N09UKzCm1VhiVHw
         ZdjA==
X-Gm-Message-State: AElRT7FbNTFLG/o2wurkpl71qc/zbgoNyjwK0ZGz3Uxt1xmzJ6zXMZQo
        bg4mCdayZaFhmOEowGbGExw=
X-Google-Smtp-Source: AG47ELuQ9crV8CiR3bxEov1YCUBMzzJ1Q15wzNuLE/j2xCIQYiInF/N0BVZy3BQnPse7KkWV9RHOWg==
X-Received: by 10.46.68.14 with SMTP id r14mr12801420lja.44.1521825701798;
        Fri, 23 Mar 2018 10:21:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/27] repository: introduce raw object store field
Date:   Fri, 23 Mar 2018 18:20:55 +0100
Message-Id: <20180323172121.17725-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The raw object store field will contain any objects needed for access
to objects in a given repository.

This patch introduces the raw object store and populates it with the
`objectdir`, which used to be part of the repository struct.

As the struct gains members, we'll also populate the function to clear
the memory for these members.

In a later step, we'll introduce a struct object_parser, that will
complement the object parsing in a repository struct: The raw object
parser is the layer that will provide access to raw object content,
while the higher level object parser code will parse raw objects and
keeps track of parenthood and other object relationships using 'struct
object'.  For now only add the lower level to the repository struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c |  3 ++-
 environment.c  |  5 +++--
 object-store.h | 18 ++++++++++++++++++
 object.c       | 14 ++++++++++++++
 path.c         |  3 ++-
 repository.c   | 15 ++++++++++-----
 repository.h   | 11 ++++-------
 sha1_file.c    |  4 +++-
 8 files changed, 56 insertions(+), 17 deletions(-)
 create mode 100644 object-store.h

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..1e9cdbdf78 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -22,6 +22,7 @@
 #include "pathspec.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "object-store.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -432,7 +433,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objectdir);
+	add_to_alternates_memory(submodule.objects->objectdir);
 	grep_read_unlock();
 
 	if (oid) {
diff --git a/environment.c b/environment.c
index a5eaa97fb1..93c9fbb0ba 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "argv-array.h"
+#include "object-store.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -270,9 +271,9 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!the_repository->objectdir)
+	if (!the_repository->objects->objectdir)
 		BUG("git environment hasn't been setup");
-	return the_repository->objectdir;
+	return the_repository->objects->objectdir;
 }
 
 int odb_mkstemp(struct strbuf *template, const char *pattern)
diff --git a/object-store.h b/object-store.h
new file mode 100644
index 0000000000..abfaae059b
--- /dev/null
+++ b/object-store.h
@@ -0,0 +1,18 @@
+#ifndef OBJECT_STORE_H
+#define OBJECT_STORE_H
+
+struct raw_object_store {
+	/*
+	 * Path to the repository's object store.
+	 * Cannot be NULL after initialization.
+	 */
+	char *objectdir;
+
+	/* Path to extra alternate object database if not NULL */
+	char *alternate_db;
+};
+
+struct raw_object_store *raw_object_store_new(void);
+void raw_object_store_clear(struct raw_object_store *o);
+
+#endif /* OBJECT_STORE_H */
diff --git a/object.c b/object.c
index 9e6f9ff20b..6ddd61242c 100644
--- a/object.c
+++ b/object.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "object-store.h"
 
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
@@ -445,3 +446,16 @@ void clear_commit_marks_all(unsigned int flags)
 			obj->flags &= ~flags;
 	}
 }
+
+struct raw_object_store *raw_object_store_new(void)
+{
+	struct raw_object_store *o = xmalloc(sizeof(*o));
+
+	memset(o, 0, sizeof(*o));
+	return o;
+}
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	FREE_AND_NULL(o->objectdir);
+	FREE_AND_NULL(o->alternate_db);
+}
diff --git a/path.c b/path.c
index da8b655730..3308b7b958 100644
--- a/path.c
+++ b/path.c
@@ -10,6 +10,7 @@
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -382,7 +383,7 @@ static void adjust_git_path(const struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objectdir);
+		replace_dir(buf, git_dir_len + 7, repo->objects->objectdir);
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (repo->different_commondir)
diff --git a/repository.c b/repository.c
index 62f52f47fc..a4848c1bd0 100644
--- a/repository.c
+++ b/repository.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "repository.h"
+#include "object-store.h"
 #include "config.h"
 #include "submodule-config.h"
 
@@ -12,6 +13,7 @@ void initialize_the_repository(void)
 	the_repository = &the_repo;
 
 	the_repo.index = &the_index;
+	the_repo.objects = raw_object_store_new();
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
@@ -58,10 +60,10 @@ void repo_set_gitdir(struct repository *repo,
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-	expand_base_dir(&repo->objectdir, o->object_dir,
+	expand_base_dir(&repo->objects->objectdir, o->object_dir,
 			repo->commondir, "objects");
-	free(repo->alternate_db);
-	repo->alternate_db = xstrdup_or_null(o->alternate_db);
+	free(repo->objects->alternate_db);
+	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
@@ -140,6 +142,8 @@ static int repo_init(struct repository *repo,
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
+	repo->objects = raw_object_store_new();
+
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
 
@@ -214,13 +218,14 @@ void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->objectdir);
-	FREE_AND_NULL(repo->alternate_db);
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
+	raw_object_store_clear(repo->objects);
+	FREE_AND_NULL(repo->objects);
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git a/repository.h b/repository.h
index e7127baffb..abba2c09bc 100644
--- a/repository.h
+++ b/repository.h
@@ -2,9 +2,10 @@
 #define REPOSITORY_H
 
 struct config_set;
+struct git_hash_algo;
 struct index_state;
+struct raw_object_store;
 struct submodule_cache;
-struct git_hash_algo;
 
 struct repository {
 	/* Environment */
@@ -21,13 +22,9 @@ struct repository {
 	char *commondir;
 
 	/*
-	 * Path to the repository's object store.
-	 * Cannot be NULL after initialization.
+	 * Holds any information related to accessing the raw object content.
 	 */
-	char *objectdir;
-
-	/* Path to extra alternate object database if not NULL */
-	char *alternate_db;
+	struct raw_object_store *objects;
 
 	/*
 	 * Path to the repository's graft file.
diff --git a/sha1_file.c b/sha1_file.c
index 4af422e3cf..af5aa83db5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,6 +29,7 @@
 #include "quote.h"
 #include "packfile.h"
 #include "fetch-object.h"
+#include "object-store.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -671,7 +672,8 @@ void prepare_alt_odb(void)
 		return;
 
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(the_repository->alternate_db, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository->objects->alternate_db,
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

