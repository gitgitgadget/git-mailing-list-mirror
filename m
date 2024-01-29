Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B285C8E9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528138; cv=none; b=lIuRWEd+jcP2xg+lq2T6dXrIZMEuAuM+F+I3TVp/2K9MOIyGspRJOiBgx5XiD71abt9YvltxI6V0hsP0Vu8QXrXx5kSfZg3osjGH0nbnNeIcBRLxKpeBnGijBcVDtk81z3ONbt40+zyjCffLHXC6elZ1YCaFC2i84ezBp5DF11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528138; c=relaxed/simple;
	bh=UyKR66fdm6MpcoopjID9w0IMIsh+oiDgUSK8wUIBs7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQbPtV+EjJ6HWLDxC2jGWmeP9Y9gvQoYhkigRW13VCl6zWfD5R8kO/DZdRzMQpP/taqPEaaTp88gQdKyW6onbC4t2w/DHguPQt1bG2eP5JjM0oosgJniQBurk7M+sR0zVzCiXT1Ju7CNqLs5tZLENOm823qi5+KWRcJNhhcL+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1WKSq5R; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1WKSq5R"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26f73732c5so283321366b.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706528135; x=1707132935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDo90hDl+W3KyjtTxut4xf8dtU7O7VPa53c7rE6gSko=;
        b=f1WKSq5RcC3IKb/WqlBf4dPRiSY99PCAL2zSr3YIaPTbJ/8VcQF/gaLoQrFYppw27B
         M4FN5Ta9W5j/D7EFfNXd/yjiTNRd+AvnvDGo5OScbGetYVZj/oxJ0o2eYRWVs02P4gid
         pxTE+zl9ZLkHMu1W/dG/4hiqElncogOzM7dlwHlt7ifjv5w/Hjua5Q73rtTUYaBEVNmU
         rSxaiLmttO1bANt2ljnLmY3enPP0RLhbJE7w+t+CvI806XAbaVpJpfaCOoKCL5KM4abZ
         Tp59FN1rjbthSTkNN6pRmnarxYoe8/SJ9msYkYBnxMihCAIgU7QI+eLrqRLriHelNkNF
         k9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528135; x=1707132935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDo90hDl+W3KyjtTxut4xf8dtU7O7VPa53c7rE6gSko=;
        b=hEPUdN4r7iqQE6p3AEZk8+AojMgF6AA0vCtCV6+wOcMFtIBFqUVLp6AhXUkeQs5E0N
         JRh2RhtbrLLX7/VIptQ/tuhBOIXCjyDNfoqDF2nANXpY6lKjw4aZrjXeWQbPyjUw3Ai0
         ci/PGswUcgg5IZzDP8bmd87MRhgEhT29XdF9DtkXXW+5Cv/layQkWMmhOb1tkj8EMCeu
         x0wkXaqERoWTKqD50pLHPvKJHHcSvhF6zcXphMfXPLu0HZHvUvgyUuY5biXIUCrdtpPY
         YQ2+vOr3xepiyHYJsCS855bo9SLzxsa9Lhi5IzAnk5eMf2V1hwJym4i2IfphPisVLcuN
         hucA==
X-Gm-Message-State: AOJu0YyWT6mSeI9nXQyM+0Jr8IA2WLdzDumQ0YLZb6Efk+wNdNI7c1E3
	l3z663GKLKYlm2VKSHUtZqBmYY5zNTA17BIFDTrk9GNzD+oxOYK+55VIZ0u0
X-Google-Smtp-Source: AGHT+IEMRUcrReeCpgsEzEKL06jFS9EWspgU+TTjYFo6V1cn2++aFU27qEIBhRyfnNf1g0XLQTbSEQ==
X-Received: by 2002:a17:906:34ca:b0:a35:9cf0:56d8 with SMTP id h10-20020a17090634ca00b00a359cf056d8mr2611434ejb.47.1706528134379;
        Mon, 29 Jan 2024 03:35:34 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:74c1:f49b:306a:744b])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906070900b00a35a3e2b90asm1370325ejb.149.2024.01.29.03.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:35:34 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 3/4] refs: introduce `refs_for_each_all_refs()`
Date: Mon, 29 Jan 2024 12:35:26 +0100
Message-ID: <20240129113527.607022-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129113527.607022-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new ref iteration flag `DO_FOR_EACH_INCLUDE_ALL_REFS`, which
will be used to iterate over all refs. In the files backend this is
limited to regular refs, pseudorefs and HEAD. For other backends like
the reftable this is the universal set of all refs stored in the
backend.

Refs which fall outside the `refs/` and aren't either pseudorefs or HEAD
are more of a grey area. This is because we don't block the users from
creating such refs but they are not officially supported. In the files
backend, we can isolate such files from other files.

Introduce `refs_for_each_all_refs()` which calls `do_for_each_ref()`
with this newly introduced flag.

In `refs/files-backend.c`, introduce a new function
`add_pseudoref_and_head_entries()` to add pseudorefs and HEAD to the
`ref_dir`. We then finally call `add_pseudoref_and_head_entries()`
whenever the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is set. Any new ref
backend will also have to implement similar changes on its end.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  7 +++++
 refs.h               |  6 ++++
 refs/files-backend.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 refs/refs-internal.h |  7 +++++
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 559f5aeea8..89b925719f 100644
--- a/refs.c
+++ b/refs.c
@@ -1762,6 +1762,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int refs_for_each_all_refs(struct ref_store *refs, each_ref_fn fn,
+			   void *cb_data)
+{
+	return do_for_each_ref(refs, "", NULL, fn, 0,
+			       DO_FOR_EACH_INCLUDE_ALL_REFS, cb_data);
+}
+
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index 46b8085d63..77ecb820f9 100644
--- a/refs.h
+++ b/refs.h
@@ -396,6 +396,12 @@ int for_each_namespaced_ref(const char **exclude_patterns,
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+/*
+ * Iterates over all ref types, regular, pseudorefs and HEAD.
+ */
+int refs_for_each_all_refs(struct ref_store *refs, each_ref_fn fn,
+			   void *cb_data);
+
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 22495a4807..104f2e1ac7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -315,9 +315,59 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	add_per_worktree_entries_to_dir(dir, dirname);
 }
 
-static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
+/*
+ * Add pseudorefs to the ref dir by parsing the directory for any files
+ * which follow the pseudoref syntax.
+ */
+static void add_pseudoref_and_head_entries(struct ref_store *ref_store,
+					 struct ref_dir *dir,
+					 const char *dirname)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
+	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
+	struct dirent *de;
+	size_t dirnamelen;
+	DIR *d;
+
+	files_ref_path(refs, &path, dirname);
+
+	d = opendir(path.buf);
+	if (!d) {
+		strbuf_release(&path);
+		return;
+	}
+
+	strbuf_addstr(&refname, dirname);
+	dirnamelen = refname.len;
+
+	while ((de = readdir(d)) != NULL) {
+		unsigned char dtype;
+
+		if (de->d_name[0] == '.')
+			continue;
+		if (ends_with(de->d_name, ".lock"))
+			continue;
+		strbuf_addstr(&refname, de->d_name);
+
+		dtype = get_dtype(de, &path, 1);
+		if (dtype == DT_REG && (is_pseudoref(ref_store, de->d_name) ||
+								is_headref(ref_store, de->d_name)))
+			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
+
+		strbuf_setlen(&refname, dirnamelen);
+	}
+	strbuf_release(&refname);
+	strbuf_release(&path);
+	closedir(d);
+}
+
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
+					     unsigned int flags)
 {
 	if (!refs->loose) {
+		struct ref_dir *dir;
+
 		/*
 		 * Mark the top-level directory complete because we
 		 * are about to read the only subdirectory that can
@@ -328,12 +378,17 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 		/* We're going to fill the top level ourselves: */
 		refs->loose->root->flag &= ~REF_INCOMPLETE;
 
+		dir = get_ref_dir(refs->loose->root);
+
+		if (flags & DO_FOR_EACH_INCLUDE_ALL_REFS)
+			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
+										   refs->loose->root->name);
+
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
 		 * lazily):
 		 */
-		add_entry_to_dir(get_ref_dir(refs->loose->root),
-				 create_dir_entry(refs->loose, "refs/", 5));
+		add_entry_to_dir(dir, create_dir_entry(refs->loose, "refs/", 5));
 	}
 	return refs->loose;
 }
@@ -861,7 +916,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * disk, and re-reads it if not.
 	 */
 
-	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
+	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
 					      prefix, ref_store->repo, 1);
 
 	/*
@@ -1222,7 +1277,7 @@ static int files_pack_refs(struct ref_store *ref_store,
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
 					the_repository, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8e9f04cc67..1cf7506435 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -260,6 +260,13 @@ enum do_for_each_ref_flags {
 	 * INCLUDE_BROKEN, since they are otherwise not included at all.
 	 */
 	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+
+	/*
+	 * Include all refs in the $GIT_DIR in contrast to generally only listing
+	 * references having the "refs/" prefix. In the files-backend this is
+	 * limited to regular refs, pseudorefs and HEAD.
+	 */
+	DO_FOR_EACH_INCLUDE_ALL_REFS = (1 << 3),
 };
 
 /*
-- 
2.43.GIT

