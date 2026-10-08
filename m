Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B354471255
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452672; cv=none; b=j6KEmZ0XDgI34lmkr8tOikM6ad1ltr4VsEw83iL/MBQXeYD2NAKnRlUV+B7i46cY59F/xtIoBQkJ4ks5ARrOCPikY0NQcAEMFiRL+fqpJmiLFYmGfkJMovvctd4TSvLGnfWTdn7C3RSam7ms+eXiglNJaXGL6K5jubC4tjNnzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452672; c=relaxed/simple;
	bh=7F4NFHcHIb2zi5CIwA2s84y4oWE3RUJP94Q8x1W0STI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=QS7MdyMRWFcMHy9DWVl2/D4CpuPTtrJxqJToNnIkhtyBq+HDZWUtELUJ2nJDC5v+UhRHwflOa3+TVeYLrROjZZYvUkDuwtsngZSwN5nhfh9G1KvBC/WU7BK2RsLwV4BEwXTaIw/ZcXq8Fzw+bmkIvGuOzF1shwrFbKGE7onqCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMjVcz/v; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMjVcz/v"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c262f1186f0so375431266b.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452668; x=1792057468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZ0uUnGCBEOxETkONt4EmdcxZUsVHQ+MwUJ+kx400x4=;
        b=IMjVcz/vcbiZbI3TbrPKdXIDTgi6cSa3Lfib8RODyVyL8WqSJAl4DBKq0vr7CM035M
         ripIMU18omn5k4DgMSaH6NQjSSQaG0+IJvoUGKOrCP4SuDhYpBYzq9WacDmyjyPSNRi8
         Q5ic+CULSL+5re+iUSZI9AEuDUAP65NzHZxtK4kMQrKALExE/nTdPhs6gyer1qml4U7M
         PpCBQ1BYfZwx8rtOwe88J9OLiEZQGOUifp7KMs18KmHwanVZuT+jOp3YoXE3uVJLLjyk
         h8yPNQCdrXk50N4qwOGSPm9OZbMLwTFJg6c2Fa2eKvbR7Ewz09RThDHcs1G4kqG1n88X
         jOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452668; x=1792057468;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZ0uUnGCBEOxETkONt4EmdcxZUsVHQ+MwUJ+kx400x4=;
        b=nRzy9fU3MrZcgTZabVRqTKPvRvgw4Anoc1y1Cm5utFdYrPvcohDq02yLkwAge0Ub8X
         RdPQQIzicm4Kv+9uNMQ/ToHtHyqsuKyNkKcpF3kKM56aWyPGxHqweC9edAu1PuOYXCcN
         vnrX7BWJNW2R/UpdczHf0yblCE/TtmSUlrAlT8+UaIrYzSRqOntm/pvWTw8pyeo0zXpo
         eQzhrTCjTW2KRJZfIU+FFde2kNTFwDoN2XiiDUpZg2kAl7797JolYzcjRrdY+LNAHdFi
         6KfkWccQ0eNrkUGEcqXDqCcgj8taPqnKABwBF40Fnngr9WO6ci0CTS2QhQaSJVLEIu60
         yiaw==
X-Gm-Message-State: AFq9FYLLm+2IqC+GxhQ+WEsbERAOMZMndDvnT9eeQ8wCNuzmipPb7BAE
	+SlOkGDn9CvgDY657fPMuvGIZYQlUO6HoptNzTeGHNwdPLHwjVZGpkkNpC6epA==
X-Gm-Gg: AYBFou0LX5c85FBYqj0hjgvhq0ENOhvZqEQ6r2+BlI8jENt/I5Vg4sLbLnaIS15ygai
	7uB0p0d5Mct3WEK9f772lvOtCENwfEvi85HLqD2Yljjm05jUSN8UWjw2RBxtH0YimU4K0cMth8g
	MPfCMZgJ7gjY78dt7Gv7BdP4ozsXoOHytxeuTJs7Jv0q+s0SnzMkyJmjDJEVXIMq72qJiU1rnqY
	Uj47ByjTwlZ/IH460RaUokMr2tpQX9asQWXKsUU7Ypzog/mRKJMc5hsPCVeojjFYgF1wOttruow
	TsNFK6s8swUY9jQLfhDgTGl9pepYPtDlxRyW2KY+HmBObEOCoW5nCdSFDmCGeoh9hoMic27OBuS
	jNgVOToTQP9B9ls82G6TixLNlKUba+DKRwB6/BRJ5m6ecXJZNYxNWWOTRXzlb1b4aYBbrs4E7eH
	KByk+42AesLHDVoMWm3ORHuVZwi7XcFYeymDscTFH7x8mfnOnxNTInPA5ssofE6iNkea8Jb7oE1
	nBh6mHqjHTI7T0QVvVaBw4IfTfa/IcA2+VPumimuoNVc+Qrs9W1lJTpnTutpXASCkcce9Kol0eJ
	8qxx06mOH8oAsKbopLTMl2Eaom/4yZwE+ffWqwkdeAyeaUK6KZGJl72wBjwjztxyInlno2YRzf4
	QcOHyPHpLacR+BlMhXiDtmwDd4rPB7kafJQoIfz1866l+
X-Received: by 2002:a17:906:730e:b0:c31:5bb8:4b26 with SMTP id a640c23a62f3a-c317bd44cbcmr454289366b.13.1791452667820;
        Thu, 08 Oct 2026 02:44:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([192.166.203.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c318ae45e19sm114188366b.61.2026.10.08.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:44:27 -0700 (PDT)
Message-Id: <d023da3c09ff9f9f54ecbc6f66aa429f49581f17.1791452597.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791452597.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 08 Oct 2026 11:44:17 +0200
Subject: [PATCH v4 2/4] refs: support replacing reflogs in a transaction
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Explicit log-only updates can already recreate a reflog during
migration. Add ref_transaction_replace_reflog() to replace existing
history with these entries without changing the reference itself. Keep
its marker flag private to the refs implementation so callers cannot
attach this cross-update behavior to an ordinary ref update
accidentally.

Stage files-backend replacements in unique temporary files beside the
logs and install them only during finish. Buffer writes and order
entries by their requested index. Aborting prepare only removes staging
files. In reftable, tombstone the previous entries in the same table as
the replacement.

Do not treat a log-only entry with a null new OID as a reference
deletion: it is part of the history being replayed. Propagate read
errors instead of silently copying a partial log.

Test preservation of null-OID entries, ordering, removal, hook rejection
and duplicate replacement. This is preparation for copying and renaming
through the ordinary transaction path.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 refs.c                        |  34 ++++++-
 refs.h                        |   9 ++
 refs/files-backend.c          | 181 +++++++++++++++++++++++++++++++---
 refs/refs-internal.h          |   3 +
 refs/reftable-backend.c       |  10 +-
 t/helper/test-ref-store.c     |  40 ++++++++
 t/meson.build                 |   1 +
 t/t1425-reflog-transaction.sh |  59 +++++++++++
 8 files changed, 322 insertions(+), 15 deletions(-)
 create mode 100755 t/t1425-reflog-transaction.sh

diff --git a/refs.c b/refs.c
index 642f895b71..c02da9d966 100644
--- a/refs.c
+++ b/refs.c
@@ -1436,7 +1436,6 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
 		return REF_TRANSACTION_ERROR_GENERIC;
 	}
-
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return REF_TRANSACTION_ERROR_GENERIC;
 
@@ -1519,6 +1518,39 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 	return 0;
 }
 
+int ref_transaction_replace_reflog(struct ref_transaction *transaction,
+				    const char *refname,
+				    struct strbuf *err)
+{
+	size_t i;
+	unsigned int flags = REF_LOG_ONLY | REF_NO_DEREF |
+		REF_SKIP_CREATE_REFLOG | REF_REPLACE_REFLOG;
+
+	assert(err);
+	if (transaction->flags &
+	    (REF_TRANSACTION_FLAG_INITIAL | REF_TRANSACTION_ALLOW_FAILURE)) {
+		strbuf_addstr(err, _("reflog replacement requires an "
+				     "all-or-nothing, non-initial transaction"));
+		return REF_TRANSACTION_ERROR_GENERIC;
+	}
+	if (!transaction_refname_valid(refname, NULL, flags, err))
+		return REF_TRANSACTION_ERROR_GENERIC;
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if ((update->flags & REF_REPLACE_REFLOG) &&
+		    !strcmp(update->refname, refname)) {
+			strbuf_addf(err, _("reflog replacement for '%s' already queued"),
+				    refname);
+			return REF_TRANSACTION_ERROR_NAME_CONFLICT;
+		}
+	}
+
+	ref_transaction_add_update(transaction, refname, flags,
+				   NULL, NULL, NULL, NULL, NULL, NULL, NULL);
+	return 0;
+}
+
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
diff --git a/refs.h b/refs.h
index ee3b8a62ef..b0b2b0e4fd 100644
--- a/refs.h
+++ b/refs.h
@@ -943,6 +943,15 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 				  uint64_t index,
 				  struct strbuf *err);
 
+/*
+ * Replace a reference's reflog with the explicit entries added to the same
+ * transaction via ref_transaction_update_reflog(). Without such entries,
+ * remove the reflog. This operation does not change the reference itself.
+ */
+int ref_transaction_replace_reflog(struct ref_transaction *transaction,
+				    const char *refname,
+				    struct strbuf *err);
+
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ddf0bef7d..36ecd21ed7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1983,6 +1983,22 @@ static int files_create_reflog(struct ref_store *ref_store, const char *refname,
 	return 0;
 }
 
+static void format_reflog_entry(struct strbuf *sb,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *committer, const char *msg)
+{
+	if (!committer)
+		committer = git_committer_info(0);
+
+	strbuf_addf(sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
+	if (msg && *msg) {
+		strbuf_addch(sb, '\t');
+		strbuf_addstr(sb, msg);
+	}
+	strbuf_addch(sb, '\n');
+}
+
 static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 			    const struct object_id *new_oid,
 			    const char *committer, const char *msg)
@@ -1990,15 +2006,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
-	if (!committer)
-		committer = git_committer_info(0);
-
-	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
-	if (msg && *msg) {
-		strbuf_addch(&sb, '\t');
-		strbuf_addstr(&sb, msg);
-	}
-	strbuf_addch(&sb, '\n');
+	format_reflog_entry(&sb, old_oid, new_oid, committer, msg);
 	if (write_in_full(fd, sb.buf, sb.len) < 0)
 		ret = -1;
 	strbuf_release(&sb);
@@ -2397,6 +2405,8 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 
 	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
 		ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
+	if (ferror(logfp))
+		ret = -1;
 	fclose(logfp);
 	strbuf_release(&sb);
 	return ret;
@@ -2665,12 +2675,120 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
 	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 }
 
+struct staged_reflog {
+	struct tempfile *file;
+	struct ref_update **updates;
+	size_t nr, alloc;
+};
+
 struct files_transaction_backend_data {
 	struct ref_transaction *packed_transaction;
 	int packed_refs_locked;
 	struct strmap ref_locks;
+	struct strmap reflog_files;
 };
 
+static int reflog_update_cmp(const void *a, const void *b)
+{
+	const struct ref_update *one = *(struct ref_update * const *)a;
+	const struct ref_update *two = *(struct ref_update * const *)b;
+
+	return (one->index > two->index) - (one->index < two->index);
+}
+
+static int prepare_reflog_replacements(struct files_ref_store *refs,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err)
+{
+	struct files_transaction_backend_data *data = transaction->backend_data;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	size_t i;
+	int ret = -1;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct staged_reflog *log;
+
+		if (!(update->flags & REF_REPLACE_REFLOG))
+			continue;
+		CALLOC_ARRAY(log, 1);
+		strmap_put(&data->reflog_files, update->refname, log);
+	}
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct staged_reflog *log = strmap_get(&data->reflog_files, update->refname);
+
+		if (!log || !(update->flags & REF_LOG_ONLY) ||
+		    !(update->flags & REF_HAVE_NEW))
+			continue;
+		if (!(update->flags & REF_LOG_USE_PROVIDED_OIDS)) {
+			strbuf_addf(err, "replacing reflog '%s' requires explicit OIDs",
+				    update->refname);
+			goto out;
+		}
+		ALLOC_GROW(log->updates, log->nr + 1, log->alloc);
+		log->updates[log->nr++] = update;
+	}
+	strmap_for_each_entry(&data->reflog_files, &iter, entry) {
+		struct staged_reflog *log = entry->value;
+		int fd;
+
+		if (!log->nr)
+			continue;
+		QSORT(log->updates, log->nr, reflog_update_cmp);
+		/* Keep the staging file beside the logs, which may be on another device. */
+		strbuf_reset(&path);
+		files_reflog_path(refs, &path, is_root_ref(entry->key) ?
+				 ".tmp-reflog-XXXXXX" : "refs/.tmp-reflog-XXXXXX");
+		if (safe_create_leading_directories(refs->base.repo, path.buf))
+			goto write_error;
+		log->file = mks_tempfile_m(path.buf, 0666);
+		if (!log->file)
+			goto write_error;
+		fd = get_tempfile_fd(log->file);
+		for (i = 0; i < log->nr; i++) {
+			struct ref_update *update = log->updates[i];
+
+			format_reflog_entry(&contents, &update->old_oid, &update->new_oid,
+					    update->committer_info, update->msg);
+			if (contents.len >= 65536) {
+				if (write_in_full(fd, contents.buf, contents.len) < 0)
+					goto write_error;
+				strbuf_reset(&contents);
+			}
+		}
+		if (write_in_full(fd, contents.buf, contents.len) < 0)
+			goto write_error;
+		strbuf_reset(&contents);
+		if (adjust_shared_perm(refs->base.repo, get_tempfile_path(log->file)) ||
+		    close_tempfile_gently(log->file))
+			goto write_error;
+	}
+	ret = 0;
+	goto out;
+
+write_error:
+	strbuf_addf(err, "cannot write staged reflog: %s", strerror(errno));
+out:
+	strbuf_release(&path);
+	strbuf_release(&contents);
+	return ret;
+}
+
+static int install_reflog(const char *path, void *data)
+{
+	struct staged_reflog *log = data;
+	int ret = rename(get_tempfile_path(log->file), path);
+
+	/* Some systems report ENOTDIR when the destination is a directory. */
+	if (ret && errno == ENOTDIR)
+		errno = EISDIR;
+	return ret;
+}
+
 /*
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
@@ -2929,6 +3047,17 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 	}
 
 	if (backend_data) {
+		struct hashmap_iter iter;
+		struct strmap_entry *entry;
+
+		strmap_for_each_entry(&backend_data->reflog_files, &iter, entry) {
+			struct staged_reflog *log = entry->value;
+
+			delete_tempfile(&log->file);
+			free(log->updates);
+			free(log);
+		}
+		strmap_clear(&backend_data->reflog_files, 0);
 		if (backend_data->packed_transaction &&
 		    ref_transaction_abort(backend_data->packed_transaction, &err)) {
 			error("error aborting transaction: %s", err.buf);
@@ -2970,6 +3099,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 	CALLOC_ARRAY(backend_data, 1);
 	strmap_init(&backend_data->ref_locks);
+	strmap_init(&backend_data->reflog_files);
 	transaction->backend_data = backend_data;
 
 	/*
@@ -3102,6 +3232,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			if (ret) {
 				ref_transaction_free(packed_transaction);
 				backend_data->packed_transaction = NULL;
+				goto cleanup;
 			}
 		} else {
 			/*
@@ -3122,6 +3253,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	ret = prepare_reflog_replacements(refs, transaction, err);
+
 cleanup:
 	free(head_ref);
 	string_list_clear(&refnames_to_check, 1);
@@ -3346,6 +3479,31 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	backend_data = transaction->backend_data;
 	packed_transaction = backend_data->packed_transaction;
 
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct staged_reflog *log;
+
+		if (!(update->flags & REF_REPLACE_REFLOG))
+			continue;
+		log = strmap_get(&backend_data->reflog_files, update->refname);
+		strbuf_reset(&sb);
+		files_reflog_path(refs, &sb, update->refname);
+		if (!log->file) {
+			if (unlink(sb.buf) && errno != ENOENT && errno != EISDIR)
+				ret = -1;
+		} else if (raceproof_create_file(refs, sb.buf, install_reflog, log)) {
+			ret = -1;
+		} else {
+			delete_tempfile(&log->file);
+		}
+		if (ret) {
+			strbuf_addf(err, "cannot replace reflog '%s': %s",
+				    update->refname, strerror(errno));
+		}
+		if (ret)
+			goto cleanup;
+	}
+
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -3354,8 +3512,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		if (update->rejection_err)
 			continue;
 
-		if (update->flags & REF_NEEDS_COMMIT ||
-		    update->flags & REF_LOG_ONLY) {
+		if ((update->flags & REF_NEEDS_COMMIT ||
+		     update->flags & REF_LOG_ONLY) &&
+		    !strmap_contains(&backend_data->reflog_files, update->refname)) {
 			if (parse_and_write_reflog(refs, update, lock, err)) {
 				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0b41f5fa4b..19fdf39d1d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -49,6 +49,9 @@ struct ref_transaction;
  */
 #define REF_HAVE_PEELED (1 << 15)
 
+/* Replace a reflog with the explicit log-only updates in the transaction. */
+#define REF_REPLACE_REFLOG (1 << 16)
+
 /*
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 10db03991e..203b111f3d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1503,9 +1503,11 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if ((u->flags & REF_HAVE_NEW) &&
+		if ((u->flags & REF_REPLACE_REFLOG) ||
+		    ((u->flags & REF_HAVE_NEW) &&
+		    !(u->flags & REF_LOG_ONLY) &&
 		    !(u->type & REF_ISSYMREF) &&
-		    ref_update_has_null_new_value(u)) {
+		    ref_update_has_null_new_value(u))) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1548,8 +1550,10 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 
 			if (ret)
 				goto done;
-		} else if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
+		}
+		if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
 			   (u->flags & REF_HAVE_NEW) &&
+			   (!ref_update_has_null_new_value(u) || (u->flags & REF_LOG_ONLY)) &&
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(arg->refs, u->refname))) {
 			struct reftable_log_record *log;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index db58f00589..7ce10c28af 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -146,6 +146,45 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 	return refs_rename_ref(refs, oldref, newref, logmsg);
 }
 
+static int cmd_reflog_transaction(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+	const char *mode = notnull(*argv++, "mode");
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction = ref_store_transaction_begin(refs, 0, &err);
+	int ret = !transaction;
+
+	if (!ret) {
+		if (!strcmp(mode, "replace")) {
+			ret = ref_transaction_replace_reflog(transaction, refname, &err);
+		} else if (!strcmp(mode, "replace-twice")) {
+			ret = ref_transaction_replace_reflog(transaction, refname, &err) ||
+				ref_transaction_replace_reflog(transaction, refname, &err);
+		} else if (strcmp(mode, "append")) {
+			die("unknown reflog transaction mode: %s", mode);
+		}
+	}
+	while (!ret && *argv) {
+		uint64_t index = strtoumax(notnull(*argv++, "index"), NULL, 10);
+		struct object_id old_oid, new_oid;
+		const char *message;
+
+		if (get_oid_hex(notnull(*argv++, "old-oid"), &old_oid) ||
+		    get_oid_hex(notnull(*argv++, "new-oid"), &new_oid))
+			die("invalid object ID");
+		message = notnull(*argv++, "message");
+		ret = ref_transaction_update_reflog(transaction, refname,
+				&new_oid, &old_oid, NULL, message, index, &err);
+	}
+	if (!ret)
+		ret = ref_transaction_commit(transaction, &err);
+	if (ret)
+		error("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return ret;
+}
+
 static int each_ref(const struct reference *ref, void *cb_data UNUSED)
 {
 	printf("%s %s 0x%x\n", oid_to_hex(ref->oid), ref->name, ref->flags);
@@ -308,6 +347,7 @@ static struct command commands[] = {
 	{ "create-symref", cmd_create_symref },
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
+	{ "reflog-transaction", cmd_reflog_transaction },
 	{ "for-each-ref", cmd_for_each_ref },
 	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
 	{ "resolve-ref", cmd_resolve_ref },
diff --git a/t/meson.build b/t/meson.build
index f65eb04684..fb5266cd0d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -218,6 +218,7 @@ integration_tests = [
   't1421-reflog-write.sh',
   't1422-show-ref-exists.sh',
   't1423-ref-backend.sh',
+  't1425-reflog-transaction.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1425-reflog-transaction.sh b/t/t1425-reflog-transaction.sh
new file mode 100755
index 0000000000..ee5278045e
--- /dev/null
+++ b/t/t1425-reflog-transaction.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='explicit reflog entries in reference transactions'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	A=$(git rev-parse A) &&
+	B=$(git rev-parse B)
+'
+
+test_expect_success 'log-only entry with null new OID does not delete existing history' '
+	git branch source "$A" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/source >before &&
+	test-tool ref-store main reflog-transaction refs/heads/source append \
+		1 "$A" "$ZERO_OID" deletion &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/source >after &&
+	sed "$ d" after >history &&
+	test_cmp before history &&
+	test_grep "$A $ZERO_OID .*deletion" after &&
+	test_cmp_rev "$A" source
+'
+
+test_expect_success 'replace reflog with entries ordered by index' '
+	test-tool ref-store main reflog-transaction refs/heads/source replace \
+		2 "$A" "$B" second \
+		1 "$ZERO_OID" "$A" first &&
+	git reflog show --format=%gs source >actual &&
+	printf "%s\n" second first >expect &&
+	test_cmp expect actual &&
+	test_cmp_rev "$A" source
+'
+
+test_expect_success 'prepared hook can reject replacement without losing history' '
+	test_when_finished "rm -f .git/hooks/reference-transaction" &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/source >before &&
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	test_must_fail test-tool ref-store main reflog-transaction refs/heads/source replace \
+		1 "$ZERO_OID" "$B" replacement &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/source >after &&
+	test_cmp before after
+'
+
+test_expect_success 'replacement with no entries removes only the reflog' '
+	test-tool ref-store main reflog-transaction refs/heads/source replace &&
+	test_must_fail git reflog exists refs/heads/source &&
+	test_cmp_rev "$A" source
+'
+
+test_expect_success 'duplicate replacement is rejected' '
+	test_must_fail test-tool ref-store main reflog-transaction \
+		refs/heads/source replace-twice
+'
+
+test_done
-- 
2.39.3 (Apple Git-146)

