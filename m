Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDCD81F463
	for <e@80x24.org>; Wed, 18 Sep 2019 01:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfIRB46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 21:56:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfIRB46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 21:56:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so6995058qtq.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIVBt7nEZcwYPDoW4oCe2Ord9VkUZbxJLJwC358oc3U=;
        b=Qp9Wwoz5rVBKqrGnmnwNvtr2+kvENAG6Tw9Z9RD4gMbrLwkzVxdsi2SOGzDZDrcwPO
         2hYVAOpzZy5PdBYdz3Rc84u64E80HiSg0LGaaEQNPZ/FG7kzVHrAH5z5xIgtENBIye+J
         pJoqi8nzZslnPPX8GH+csIdep/PePHUFFbvtSdafv/0lIYZ/I/OD5D5BcNpbh/Tm0D7C
         PZRBnhgKi8woLWTRwFILYHN00yNub3pEsDfy1zBf09Oex2thMhux6zE2FHp7h4DkIDjk
         kSTXSe5oNrAMLMDfkqLyX+hMpcVdZpf/WWGPZXfJFKMNZ7D9C+SfIiJ3WbqjbCpSDHQt
         Jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIVBt7nEZcwYPDoW4oCe2Ord9VkUZbxJLJwC358oc3U=;
        b=UySxCiKEhtoCRcozJovKdpaBCQLTxzZdyIO+v3rL4RerYpxiw/01k/p59OZyh4EmD9
         0RNo0mvhlDAZv68204z0DMIbXMaWOcVyFBAY/CCTbkU5WBbelSVCXm08dFla3mJcr9P2
         GJCqmtx9inDSpeYvQI51oGMJiupmxAKyWO/fXFfhE75FXiRuq82qFQyVY3I5XT1/8UNT
         sT467rJT/Baa6p23cuJbGPr9kAAJPWRhut8iHUq42OwrF/I5XTj2962WY2ePk28LNkVY
         Fg1zmAVK69SuK/vjoEaj+qi4r4TYbbG6cPTF24dFKCsX/A9n3XVGcLgcfW1Q51Lq7xag
         /zmA==
X-Gm-Message-State: APjAAAUVjm0x5lATE9r6QMfqO/CAo6Pae5loeiVClIXGhzU7ZaJB5noj
        nfg6iB/OkKICacV8//Ke1hnVYyvpneA=
X-Google-Smtp-Source: APXvYqyu3tq0ZxUkgylX2NApF3QSjTPs+zpWHriKjbKYxSYvaQNrhwW/pbHNIL6kn4sM5rJqcXGYHg==
X-Received: by 2002:a05:6214:1463:: with SMTP id c3mr1481045qvy.48.1568771817002;
        Tue, 17 Sep 2019 18:56:57 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id j17sm2156371qki.99.2019.09.17.18.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 18:56:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliams.eng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 3/3] grep: don't add submodules to the alternates list
Date:   Tue, 17 Sep 2019 22:56:05 -0300
Message-Id: <fc5f5fe95c10ac66d1234a025122c8866965021f.1568771073.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568771073.git.matheus.bernardino@usp.br>
References: <cover.1568771073.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When grepping with --recurse-submodules, the object directory of the
submodule is added to the in-memory alternates list. This makes git need
to watch out for more packfiles which might bring bad consequences for
memory and performance.

Now that raw_object_store is a member of the struct repository, it's
possible to use the submodules' instances directly, without the need to
add its odbs to the alternates list. So let's instead pass the subrepo
down to the threads and replace function calls which use
the_repository by default for their more general counterparts. Also,
submodule cleanup must be refactored as calling repo_clear() at the end
of grep_submodules(), might free the subrepo's resources before threads
have finished working on it. To do that, let's keep track of the
workers progress and only call repo_clear() when it's safe to do so.

This change will also help future patches to re-enable threads in
non-worktree grep as less mutual exclusions will be needed. E.g.
grep_submodule()'s call to parse_object_or_die() won't conflict with
other calls to the same function by worker threads (as they should be
referencing different 'struct repository's).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 80 ++++++++++++++++++++++++++++++++++++--------------
 grep.c         | 26 ++++++++--------
 2 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 73ef00c426..0bb58c456b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -43,6 +43,15 @@ static pthread_t *threads;
  */
 struct work_item {
 	struct grep_source source;
+
+	/*
+	 * Each worker thread is initialized with a 'struct grep_opt *opt' where
+	 * opt->repo points to the_repository. But a work item may refeer to a
+	 * subrepo. So the repository relative to each task is also passed to
+	 * the assigned thread and its opt->repo is updated when retrieving the
+	 * task.
+	 */
+	struct repository *repo;
 	char done;
 	struct strbuf out;
 };
@@ -65,6 +74,13 @@ static int todo_done;
 /* Has all work items been added? */
 static int all_work_added;
 
+/* Tracks the work progress in subrepos to correctly free them in the end */
+struct progress_in_subrepo {
+	struct repository subrepo;
+	int all_work_added;
+	int work_counter;
+};
+
 /* This lock protects all the variables above. */
 static pthread_mutex_t grep_mutex;
 
@@ -93,6 +109,8 @@ static int skip_first_line;
 
 static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 {
+	struct progress_in_subrepo *p;
+
 	grep_lock();
 
 	while ((todo_end+1) % ARRAY_SIZE(todo) == todo_done) {
@@ -104,9 +122,15 @@ static void add_work(struct grep_opt *opt, const struct grep_source *gs)
 		grep_source_load_driver(&todo[todo_end].source,
 					opt->repo->index);
 	todo[todo_end].done = 0;
+	todo[todo_end].repo = opt->repo;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
 
+	if (opt->repo != the_repository) {
+		p = container_of(opt->repo, struct progress_in_subrepo, subrepo);
+		p->work_counter++;
+	}
+
 	pthread_cond_signal(&cond_add);
 	grep_unlock();
 }
@@ -132,6 +156,7 @@ static struct work_item *get_work(void)
 
 static void work_done(struct work_item *w)
 {
+	struct progress_in_subrepo *p;
 	int old_done;
 
 	grep_lock();
@@ -156,6 +181,17 @@ static void work_done(struct work_item *w)
 
 			write_or_die(1, p, len);
 		}
+
+		if (w->repo != the_repository) {
+			p = container_of(w->repo, struct progress_in_subrepo,
+					 subrepo);
+			p->work_counter--;
+			if (p->work_counter == 0 && p->all_work_added) {
+				repo_clear(&p->subrepo);
+				free(p);
+			}
+		}
+
 		grep_source_clear(&w->source);
 	}
 
@@ -179,6 +215,7 @@ static void *run(void *arg)
 			break;
 
 		opt->output_priv = w;
+		opt->repo = w->repo;
 		hit |= grep_source(opt, &w->source);
 		grep_source_clear_data(&w->source);
 		work_done(w);
@@ -295,12 +332,14 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
-static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+static void *lock_and_read_oid_file(struct repository *r,
+				    const struct object_id *oid,
+				    enum object_type *type, unsigned long *size)
 {
 	void *data;
 
 	grep_read_lock();
-	data = read_object_file(oid, type, size);
+	data = repo_read_object_file(r, oid, type, size);
 	grep_read_unlock();
 	return data;
 }
@@ -405,7 +444,8 @@ static int grep_submodule(struct grep_opt *opt,
 			  const struct object_id *oid,
 			  const char *filename, const char *path, int cached)
 {
-	struct repository subrepo;
+	struct progress_in_subrepo *p = xcalloc(1, sizeof(*p));
+	struct repository *subrepo = &p->subrepo;
 	struct repository *superproject = opt->repo;
 	const struct submodule *sub = submodule_from_path(superproject,
 							  &null_oid, path);
@@ -422,31 +462,21 @@ static int grep_submodule(struct grep_opt *opt,
 
 	if (!is_submodule_active(superproject, path)) {
 		grep_read_unlock();
+		free(p);
 		return 0;
 	}
 
-	if (repo_submodule_init(&subrepo, superproject, sub)) {
+	if (repo_submodule_init(subrepo, superproject, sub)) {
 		grep_read_unlock();
+		free(p);
 		return 0;
 	}
 
-	repo_read_gitmodules(&subrepo);
-
-	/*
-	 * NEEDSWORK: This adds the submodule's object directory to the list of
-	 * alternates for the single in-memory object store.  This has some bad
-	 * consequences for memory (processed objects will never be freed) and
-	 * performance (this increases the number of pack files git has to pay
-	 * attention to, to the sum of the number of pack files in all the
-	 * repositories processed so far).  This can be removed once the object
-	 * store is no longer global and instead is a member of the repository
-	 * object.
-	 */
-	add_to_alternates_memory(subrepo.objects->odb->path);
+	repo_read_gitmodules(subrepo);
 	grep_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
-	subopt.repo = &subrepo;
+	subopt.repo = subrepo;
 
 	if (oid) {
 		struct object *object;
@@ -455,10 +485,10 @@ static int grep_submodule(struct grep_opt *opt,
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
-		object = parse_object_or_die(the_repository, oid, NULL);
+		object = parse_object_or_die(subrepo, oid, NULL);
 
 		grep_read_lock();
-		data = read_object_with_reference(&subrepo,
+		data = read_object_with_reference(subrepo,
 						  &object->oid, tree_type,
 						  &size, NULL);
 		grep_read_unlock();
@@ -478,7 +508,13 @@ static int grep_submodule(struct grep_opt *opt,
 		hit = grep_cache(&subopt, pathspec, cached);
 	}
 
-	repo_clear(&subrepo);
+	grep_lock();
+	p->all_work_added = 1;
+	if (p->work_counter == 0) {
+		repo_clear(&p->subrepo);
+		free(p);
+	}
+	grep_unlock();
 	return hit;
 }
 
@@ -587,7 +623,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_oid_file(&entry.oid, &type, &size);
+			data = lock_and_read_oid_file(repo, &entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(&entry.oid));
diff --git a/grep.c b/grep.c
index cd952ef5d3..0b3f38aaae 100644
--- a/grep.c
+++ b/grep.c
@@ -10,9 +10,8 @@
 #include "quote.h"
 #include "help.h"
 
-static int grep_source_load(struct grep_source *gs);
-static int grep_source_is_binary(struct grep_source *gs,
-				 struct index_state *istate);
+static int grep_source_load(struct repository *r, struct grep_source *gs);
+static int grep_source_is_binary(struct repository *r, struct grep_source *gs);
 
 static struct grep_opt grep_defaults;
 
@@ -1714,7 +1713,7 @@ static int fill_textconv_grep(struct repository *r,
 	size_t size;
 
 	if (!driver || !driver->textconv)
-		return grep_source_load(gs);
+		return grep_source_load(r, gs);
 
 	/*
 	 * The textconv interface is intimately tied to diff_filespecs, so we
@@ -1820,11 +1819,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	if (!textconv) {
 		switch (opt->binary) {
 		case GREP_BINARY_DEFAULT:
-			if (grep_source_is_binary(gs, opt->repo->index))
+			if (grep_source_is_binary(opt->repo, gs))
 				binary_match_only = 1;
 			break;
 		case GREP_BINARY_NOMATCH:
-			if (grep_source_is_binary(gs, opt->repo->index))
+			if (grep_source_is_binary(opt->repo, gs))
 				return 0; /* Assume unmatch */
 			break;
 		case GREP_BINARY_TEXT:
@@ -2105,12 +2104,12 @@ void grep_source_clear_data(struct grep_source *gs)
 	}
 }
 
-static int grep_source_load_oid(struct grep_source *gs)
+static int grep_source_load_oid(struct repository *r, struct grep_source *gs)
 {
 	enum object_type type;
 
 	grep_read_lock();
-	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
+	gs->buf = repo_read_object_file(r, gs->identifier, &type, &gs->size);
 	grep_read_unlock();
 
 	if (!gs->buf)
@@ -2154,7 +2153,7 @@ static int grep_source_load_file(struct grep_source *gs)
 	return 0;
 }
 
-static int grep_source_load(struct grep_source *gs)
+static int grep_source_load(struct repository *r, struct grep_source *gs)
 {
 	if (gs->buf)
 		return 0;
@@ -2163,7 +2162,7 @@ static int grep_source_load(struct grep_source *gs)
 	case GREP_SOURCE_FILE:
 		return grep_source_load_file(gs);
 	case GREP_SOURCE_OID:
-		return grep_source_load_oid(gs);
+		return grep_source_load_oid(r, gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
 	}
@@ -2184,14 +2183,13 @@ void grep_source_load_driver(struct grep_source *gs,
 	grep_attr_unlock();
 }
 
-static int grep_source_is_binary(struct grep_source *gs,
-				 struct index_state *istate)
+static int grep_source_is_binary(struct repository *r, struct grep_source *gs)
 {
-	grep_source_load_driver(gs, istate);
+	grep_source_load_driver(gs, r->index);
 	if (gs->driver->binary != -1)
 		return gs->driver->binary;
 
-	if (!grep_source_load(gs))
+	if (!grep_source_load(r, gs))
 		return buffer_is_binary(gs->buf, gs->size);
 
 	return 0;
-- 
2.23.0

