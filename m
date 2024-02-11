Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6B5D49D
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676773; cv=none; b=LZbyU6LZm0zR/XmxJid7/JwPvph/Z1Hi8sMDfpSX4A+4dAhV7alKrfhIkshRw5zem2k7o28DrDd+6WslkCSRmLVFLvlxa9RphOcF5QvJOYyYIBZRSc/Pq6dEtnb0s2UIjtZO66XtjjiB3d3EQJcgbyQhgkX2C1AVlWuQ2lOecTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676773; c=relaxed/simple;
	bh=XdHksjn/cdzBpsfKt6RXWgzaqPjs6g/AgtRaahE7OmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/MatAoy4Dh2zDVjJrXT+iMRrwlyfw8N6NgFQGG+iZOzv8UU+U0oPKxNpbfN+oc9SegkOWxGJ73Qx2l7rhnmrfmvGHo99ToKsVqSdRx5rIbvbbagQprwqPuSvDQzBwpjDbSgP3HVyqIFsdEaJolh3R5pIkVgWAkWemBydjWP4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etSYJaJZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etSYJaJZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so338688066b.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 10:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707676770; x=1708281570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMan9LFdGitwOzGBOks4QduvHVZgtY9qYqaDjMNW1IE=;
        b=etSYJaJZ21MDLKrr+Y06H1A6Xz5R0ODOBXk20VJaLPmA8plKyh7IoVWt5Hn1n2b8C+
         4B9NEM9dsj8hwW0svK/NBqHrUqWnfpVgLx/7qmR8USMzNehoOg1KW6W80l4zqjvokxgP
         yEtLmi8u4ALyD8jdjjSqP/LizLvFv96V0kZq4yGeF+XHumymRAovy/jAFasIPJQA7BDf
         95jNAQq27/JNtkLoUYFBzB0LvS7DkwS98AZKOc1zQ189fXrgcllzOLD3pNKZRGHpBdF8
         Nm1w5KJaRqATHr7dk4X7ObA/O6vvv+HuIneBR3wb6/MVkOHRstuoTkP72JQ3mqpp3IrQ
         3cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707676770; x=1708281570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMan9LFdGitwOzGBOks4QduvHVZgtY9qYqaDjMNW1IE=;
        b=RfKlplVEl274jdTMNEzI4t28lODvF8Qm8+QTlAji7NmvH62j2ISfmLDSQMvmwMFfyb
         glx6Qsjq4k8n/9Fh3hcvOh4n11eW4rFbfYLlvynJnIWnuiglVbQPgwmAUYNgvF+VZlh8
         4g0/ogoRzeoZWxaeI2f/f4Dy1bxPsw8PA5zudvC28XzXJezB9ZDzX8bU9HwlBnjWTNdE
         zXfz/5fUDQKUd14wGcM+eExTUQ1iK/lNUks8Bg2uCUFbO8efajvkQx+kygwo3cBUJS+R
         CS7CfsdoEc7VPeY585fhnsn77UQTmnhdtZyHXoSuIe19CNfWwKv2XbODvFNFPZWDh2PZ
         bsDw==
X-Gm-Message-State: AOJu0YyuIHsEIwIRDUGqOOQqsfPB0T7vBhD4RZ/GgAjAz4Vy1EFgOsQn
	JXEDTiwmknGN0uzV2vxwYu0K1GLy0rh1O8KJrQkL4Ou/qQymDAc6NrK55sBD
X-Google-Smtp-Source: AGHT+IH5XBEEo0DhdJPW8a5Zgs8kzICnw/1oGoTt2Z9gc1/lUU7q0jb9JwGWVXdHmT6+2ckypO1vgQ==
X-Received: by 2002:a17:906:cf9b:b0:a37:4765:658 with SMTP id um27-20020a170906cf9b00b00a3747650658mr2664254ejb.34.1707676769773;
        Sun, 11 Feb 2024 10:39:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVybj5p46gNLIG/gsKlnCv4P5K2z8CNnfAaCdEN8ojpfXWgajKe1JIQTUmjX0rLTASjaihlD1Pezm8cEAHOGAhBPwZoNJnYty01lshaCHhNAI4llDrkixxeKz1IZZibGAI6aPwOQ2zHEBoUAA==
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b00a3716299b40sm3069808ejb.155.2024.02.11.10.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:39:28 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 3/5] refs: introduce `refs_for_each_include_root_refs()`
Date: Sun, 11 Feb 2024 19:39:21 +0100
Message-ID: <20240211183923.131278-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211183923.131278-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new ref iteration flag `DO_FOR_EACH_INCLUDE_ROOT_REFS`,
which will be used to iterate over regular refs plus pseudorefs and
HEAD.

Refs which fall outside the `refs/` and aren't either pseudorefs or HEAD
are more of a grey area. This is because we don't block the users from
creating such refs but they are not officially supported.

Introduce `refs_for_each_include_root_refs()` which calls
`do_for_each_ref()` with this newly introduced flag.

In `refs/files-backend.c`, introduce a new function
`add_pseudoref_and_head_entries()` to add pseudorefs and HEAD to the
`ref_dir`. We then finally call `add_pseudoref_and_head_entries()`
whenever the `DO_FOR_EACH_INCLUDE_ROOT_REFS` flag is set. Any new ref
backend will also have to implement similar changes on its end.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  7 +++++
 refs.h               |  6 ++++
 refs/files-backend.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 refs/refs-internal.h |  6 ++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index d8e4cf9a11..77f4c1e4c2 100644
--- a/refs.c
+++ b/refs.c
@@ -1765,6 +1765,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
+				    void *cb_data)
+{
+	return do_for_each_ref(refs, "", NULL, fn, 0,
+			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
+}
+
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index f66cdd731c..5cfaee6229 100644
--- a/refs.h
+++ b/refs.h
@@ -398,6 +398,12 @@ int for_each_namespaced_ref(const char **exclude_patterns,
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+/*
+ * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
+ */
+int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
+				    void *cb_data);
+
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 65128821a8..9c1c42fe52 100644
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
+		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
+			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
+						       refs->loose->root->name);
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
index 83e0f0bba3..73a8fa18ad 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -260,6 +260,12 @@ enum do_for_each_ref_flags {
 	 * INCLUDE_BROKEN, since they are otherwise not included at all.
 	 */
 	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+
+	/*
+	 * Include root refs i.e. HEAD and pseudorefs along with the regular
+	 * refs.
+	 */
+	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
 };
 
 /*
-- 
2.43.GIT

