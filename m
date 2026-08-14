Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534003E3169
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743750; cv=none; b=O7Q2CcgTvj3DlWRkEso00q3+0tVWVbIflNYL97VW5u0vhuix9ZS/FZdh6ch+/yt72IRs/u3mBxKP1elcDJxSVc/uEFtAx/KmY5C7cHmh+B5BlK/tih0gyHCm25FzMy2qDb8dmTDOwy/C+3Z1oNf2jmeyDawQCZ2GB+sbuAoky0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743750; c=relaxed/simple;
	bh=3ywdv+6cTJirEqGnJQDtH6fb+npwITjNRvF/soPAckY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG186q8fxup787pb2gZ/f08yzZbCDReQEon5ggNFl7cjoCZwF0FpTN5oe0mFFgIjimJzm0thGuCRAwIEwU6dgqUuPlJFlvGr0fm8lXeiqF2qSahLu465ln658UThpb6frBXcwWdhRF7UtrLnBdDuYN0Sr5YUqHEePwbEf/MW9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsLqAbmS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsLqAbmS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1076139a12.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786743749; x=1787348549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCqZl3aA6GzorYQPf1V+T/iBKhSSnUGvhf0X7jUNbGE=;
        b=TsLqAbmSPEhIVixVOGiPtURa4ZbbnXplXGRp/jpXThaPrL/oxg6VWx6/5sehvWmr8u
         qgyDGVCubdkhdgkiimzT1YySa4RTmXQ5T+W56e72dbebhICWvGCqWGNHACg/TfoH1YKd
         yxAftBpbNo9E/ZcUHMA6DL7VhRadcrcVUm1mubA2KZQksV3Tr3lri7+YIEWqWyg6bXw8
         1QiyvMecaXj5xsdDlIAOaZz0CF9ytV2zpVlwxUqGwM2U48yGH/7BhCzQ5uZuhyt8UCKz
         SVNOIe3v7+JdJLDFXoE5Zna/YydsvCkfENUFNaGLfgEyvY+P5fSbudn3ZlGtSv3Ava4Q
         zceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786743749; x=1787348549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCqZl3aA6GzorYQPf1V+T/iBKhSSnUGvhf0X7jUNbGE=;
        b=Iv5hheCACPV5XkKqGFivhV0ATt7WGK/y4wo/T10aDErwgnwShdCX4iP+hfAyVV4jpY
         DRvcZce5+TBN5wv0UUY6jOcPKsDo/eYnQAeNUjw7nSEtwEBti/GQwmxWshohA7Mf8YBK
         u5n7mmhlj38WrcfFJ8FTZvJVxSmnJx15UmmiP7me6FbhZVbrkE2HGsqwJMUSVbP7bO62
         bXDG9b42c3AwtABnfUlCa6L0E7ksk5jci7PvDEN+J0xxlqXHE38Ebicn8SXHbSG24fEr
         1nJFAusEQuttnhL0kMvfx0IhKix96H7QIiOo5Uqh2k2W9eFGcnoNwKtRbN3iz9tab7Fi
         FgIA==
X-Gm-Message-State: AOJu0YyfvdLWs2k/WUhbeeMyFlBXaNITOBg4kCWjeeoCFRBuZTs59yua
	pZyMC57mZq2w6HKCOOosBUkEjpMgMffXBXWMR9TzPN/6hsWJIPzpnh5fWAGtYaNo
X-Gm-Gg: AR+sD129iZLHkJYx1ICd0fLl9Hq/ES9Fvn0gtPPwUdCl/6mmFzx0GYsigKkfAsfX70A
	oX0WSWd1yFas9Boeh8OIlEzgOct/vwKwIzWCNEX5w+akHt5/7QnEAFWeAzMNC0hsy2G6ydsEiPN
	Lz8a9k094mrxPvJDZXdC4dii1ajKdhBTPPVBH+crUcbsOdv0wFfLt2PTe9IqRqx8DMXNcJYPWXo
	IfTY4VyrLvx2qRDSAB7/sDIUVtibUrLD/Jy0EyC97sVAXbARRubMauzXzmhl0aH8M8JKa15GKRY
	PWAsbET5EOJKDholMEUObnR2xAuL+AEhCEc6UirYEU7uVAQL8qDKPCZY091eoTtu9ynltBuJ0UU
	8RKJYWAmcPzutesnE1tz7VM715G6G5p//fRiFg6FNbm6vru7HfgoqGjmW1NzkLohN+4PruPx/dG
	fj0S8LBEhcXj7bSs0eETs0ti5jhwj6YSD3hYIwL/4XIbJLXffMMPWBXPNzzJY722ccTtQxIQOZh
	9URTIP4cdqB
X-Received: by 2002:a05:6a20:4325:b0:3bf:7eb5:9459 with SMTP id adf61e73a8af0-3cc71fa8cd1mr10278605637.20.1786743748406;
        Fri, 14 Aug 2026 14:42:28 -0700 (PDT)
Received: from Velociraptor ([172.88.119.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm18109247c88.12.2026.08.14.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 14:42:27 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v2] chdir-notify.h: Removed unused param 'name'
Date: Fri, 14 Aug 2026 14:42:10 -0700
Message-ID: <20260814214210.1625-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260814193849.1538-1-colinlewishinton@gmail.com>
References: <20260814193849.1538-1-colinlewishinton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `name` parameter in `chdir_notify_entry` was only ever used by
chdir_notify_reparent() to produce trace output. That function was
removed in 5bf546755c (chdir-notify: drop unused
`chdir_notify_reparent()`, 2026-06-25), which left `name` with no
remaining consumers.

Prior to that removal, most callers had already stopped passing a
meaningful name, switching to NULL in 1f43ff2c7e (refs: unregister
reference stores from "chdir_notify", 2026-06-25) and 0de2467e6c
(odb/source-packed: start converting to a proper `struct odb_source`,
2026-06-17).

Since no caller has populated `name` with real data for some time,
and its last consumer is gone, drop it from chdir_notify_register(),
chdir_notify_unregister(), and the callback signature to simplify
the API.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 chdir-notify.c          | 12 ++++--------
 chdir-notify.h          |  8 +++-----
 odb/source-files.c      |  7 +++----
 odb/source-loose.c      |  7 +++----
 odb/source-packed.c     |  7 +++----
 refs/files-backend.c    |  7 +++----
 refs/packed-backend.c   |  7 +++----
 refs/reftable-backend.c |  7 +++----
 setup.c                 |  5 ++---
 tmp-objdir.c            |  7 +++----
 10 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index 1237a45e2e..55773c24c9 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -7,25 +7,22 @@
 #include "trace.h"
 
 struct chdir_notify_entry {
-	const char *name;
 	chdir_notify_callback cb;
 	void *data;
 	struct list_head list;
 };
 static LIST_HEAD(chdir_notify_entries);
 
-void chdir_notify_register(const char *name,
-			   chdir_notify_callback cb,
+void chdir_notify_register(chdir_notify_callback cb,
 			   void *data)
 {
 	struct chdir_notify_entry *e = xmalloc(sizeof(*e));
-	e->name = name;
 	e->cb = cb;
 	e->data = data;
 	list_add_tail(&e->list, &chdir_notify_entries);
 }
 
-void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
+void chdir_notify_unregister(chdir_notify_callback cb,
 			     void *data)
 {
 	struct list_head *pos, *p;
@@ -34,8 +31,7 @@ void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 		struct chdir_notify_entry *e =
 			list_entry(pos, struct chdir_notify_entry, list);
 
-		if (e->cb != cb || e->data != data || !e->name != !name ||
-		    (e->name && strcmp(e->name, name)))
+		if (e->cb != cb || e->data != data)
 			continue;
 
 		list_del(pos);
@@ -64,7 +60,7 @@ int chdir_notify(const char *new_cwd)
 	list_for_each(pos, &chdir_notify_entries) {
 		struct chdir_notify_entry *e =
 			list_entry(pos, struct chdir_notify_entry, list);
-		e->cb(e->name, old_cwd.buf, new_cwd, e->data);
+		e->cb(old_cwd.buf, new_cwd, e->data);
 	}
 
 	strbuf_release(&old_cwd);
diff --git a/chdir-notify.h b/chdir-notify.h
index 36b4114472..e4ae38e12d 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -33,13 +33,11 @@
  * $GIT_TRACE_SETUP. It may be NULL, but if non-NULL should point to
  * storage which lasts as long as the registration is active.
  */
-typedef void (*chdir_notify_callback)(const char *name,
-				      const char *old_cwd,
+typedef void (*chdir_notify_callback)(const char *old_cwd,
 				      const char *new_cwd,
 				      void *data);
-void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
-void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
-			     void *data);
+void chdir_notify_register(chdir_notify_callback cb, void *data);
+void chdir_notify_unregister(chdir_notify_callback cb, void *data);
 
 /*
  *
diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..c12e2795ba 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -22,8 +22,7 @@
 #include "tree.h"
 #include "write-or-die.h"
 
-static void odb_source_files_reparent(const char *name UNUSED,
-				      const char *old_cwd,
+static void odb_source_files_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *cb_data)
 {
@@ -37,7 +36,7 @@ static void odb_source_files_reparent(const char *name UNUSED,
 static void odb_source_files_free(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
+	chdir_notify_unregister(odb_source_files_reparent, files);
 	odb_source_free(&files->loose->base);
 	odb_source_free(&files->packed->base);
 	odb_source_release(&files->base);
@@ -763,7 +762,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	 * paths in the primary ODB source in some user-facing functionality.
 	 */
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, odb_source_files_reparent, files);
+		chdir_notify_register(odb_source_files_reparent, files);
 
 	return files;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ef0e919277..6a594a6458 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1006,8 +1006,7 @@ static void odb_source_loose_close(struct odb_source *source UNUSED)
 	/* Nothing to do. */
 }
 
-static void odb_source_loose_reparent(const char *name UNUSED,
-				      const char *old_cwd,
+static void odb_source_loose_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *cb_data)
 {
@@ -1023,7 +1022,7 @@ static void odb_source_loose_free(struct odb_source *source)
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	odb_source_loose_clear_cache(loose);
 	loose_object_map_clear(&loose->map);
-	chdir_notify_unregister(NULL, odb_source_loose_reparent, loose);
+	chdir_notify_unregister(odb_source_loose_reparent, loose);
 	odb_source_release(&loose->base);
 	free(loose);
 }
@@ -1053,7 +1052,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.write_alternate = odb_source_loose_write_alternate;
 
 	if (!is_absolute_path(loose->base.path))
-		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
+		chdir_notify_register(odb_source_loose_reparent, loose);
 
 	return loose;
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..8d028971cd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -786,8 +786,7 @@ static void odb_source_packed_prepare(struct odb_source *source,
 	packed->initialized = true;
 }
 
-static void odb_source_packed_reparent(const char *name UNUSED,
-				       const char *old_cwd,
+static void odb_source_packed_reparent(const char *old_cwd,
 				       const char *new_cwd,
 				       void *cb_data)
 {
@@ -816,7 +815,7 @@ static void odb_source_packed_free(struct odb_source *source)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 
-	chdir_notify_unregister(NULL, odb_source_packed_reparent, packed);
+	chdir_notify_unregister(odb_source_packed_reparent, packed);
 
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
 		free(e->pack);
@@ -853,7 +852,7 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
+		chdir_notify_register(odb_source_packed_reparent, packed);
 
 	return packed;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1cc20aa486..71628550f2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -111,8 +111,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 	}
 }
 
-static void files_ref_store_reparent(const char *name UNUSED,
-				     const char *old_cwd,
+static void files_ref_store_reparent(const char *old_cwd,
 				     const char *new_cwd,
 				     void *payload)
 {
@@ -182,7 +181,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
 
-	chdir_notify_register(NULL, files_ref_store_reparent, refs);
+	chdir_notify_register(files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
 
@@ -234,7 +233,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
 	free(refs->gitcommondir);
 	ref_store_release(refs->packed_ref_store);
 	free(refs->packed_ref_store);
-	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);
+	chdir_notify_unregister(files_ref_store_reparent, refs);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b9b04b7010..a73fc6aca7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -217,8 +217,7 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
-static void packed_ref_store_reparent(const char *name UNUSED,
-				      const char *old_cwd,
+static void packed_ref_store_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *payload)
 {
@@ -248,7 +247,7 @@ struct ref_store *packed_ref_store_init(struct repository *repo,
 
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
-	chdir_notify_register(NULL, packed_ref_store_reparent, refs);
+	chdir_notify_register(packed_ref_store_reparent, refs);
 	return ref_store;
 }
 
@@ -293,7 +292,7 @@ static void packed_ref_store_release(struct ref_store *ref_store)
 	clear_snapshot(refs);
 	rollback_lock_file(&refs->lock);
 	delete_tempfile(&refs->tempfile);
-	chdir_notify_unregister(NULL, packed_ref_store_reparent, refs);
+	chdir_notify_unregister(packed_ref_store_reparent, refs);
 	free(refs->path);
 }
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 028f0211af..08a75fb328 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -391,8 +391,7 @@ static const struct reftable_be_write_options *reftable_be_write_options(struct
 	return opts;
 }
 
-static void reftable_be_reparent(const char *name UNUSED,
-				 const char *old_cwd,
+static void reftable_be_reparent(const char *old_cwd,
 				 const char *new_cwd,
 				 void *payload)
 {
@@ -465,7 +464,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 			goto done;
 	}
 
-	chdir_notify_register(NULL, reftable_be_reparent, refs);
+	chdir_notify_register(reftable_be_reparent, refs);
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
@@ -492,7 +491,7 @@ static void reftable_be_release(struct ref_store *ref_store)
 		free(be);
 	}
 	strmap_clear(&refs->worktree_backends, 0);
-	chdir_notify_unregister(NULL, reftable_be_reparent, refs);
+	chdir_notify_unregister(reftable_be_reparent, refs);
 }
 
 static int reftable_be_create_on_disk(struct ref_store *ref_store,
diff --git a/setup.c b/setup.c
index 95909e9603..671f88201d 100644
--- a/setup.c
+++ b/setup.c
@@ -1057,8 +1057,7 @@ static void apply_gitdir_and_environment(struct repository *repo, const char *pa
 	strvec_clear(&to_free);
 }
 
-static void update_relative_gitdir(const char *name UNUSED,
-				   const char *old_cwd,
+static void update_relative_gitdir(const char *old_cwd,
 				   const char *new_cwd,
 				   void *data)
 {
@@ -1086,7 +1085,7 @@ static void apply_and_export_relative_gitdir(struct repository *repo, const char
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
 
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, update_relative_gitdir, repo);
+		chdir_notify_register(update_relative_gitdir, repo);
 
 	strbuf_release(&realpath);
 }
diff --git a/tmp-objdir.c b/tmp-objdir.c
index d199d39e7c..520df2df8c 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -37,8 +37,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
-static void tmp_objdir_reparent(const char *name UNUSED,
-				const char *old_cwd,
+static void tmp_objdir_reparent(const char *old_cwd,
 				const char *new_cwd,
 				void *cb_data)
 {
@@ -67,7 +66,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 
 	err = remove_dir_recursively(&t->path, 0);
 
-	chdir_notify_unregister(NULL, tmp_objdir_reparent, t);
+	chdir_notify_unregister(tmp_objdir_reparent, t);
 	tmp_objdir_free(t);
 
 	return err;
@@ -155,7 +154,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		    repo_get_object_directory(r), prefix);
 
 	if (!is_absolute_path(t->path.buf))
-		chdir_notify_register(NULL, tmp_objdir_reparent, t);
+		chdir_notify_register(tmp_objdir_reparent, t);
 
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
-- 
2.55.0.windows.3

