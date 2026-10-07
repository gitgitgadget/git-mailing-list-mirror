Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E993BB669
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396324; cv=none; b=F2m+1NuhWS4bRkrgrAS+UWtGX4sI9LrwFLVLDsxov4MAORF1pUgeHPSuoxkR6Xx0qw/OsiDwHTIhWDao69R0rQ5kS04UH7YiIfJl+z3ZwqpDyPinVj9cpoeja7FJSS01axSJhNCaq+NVDtS52kMsEFdYSCDbxTN1B4QiQK9nPrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396324; c=relaxed/simple;
	bh=5xOzblL1EhAggmtqUFmF+WeGSNy4Rufg5iR2PW3YBx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=nUUvKSI6PxfcXKC3jU4LWAhMBwo+GrXgD5vxLl3kKV9ZN899pjZ6iJjFjq+VWes2oqhka61taY6c+rAfO0erUBZTd9oEpflUpIpJ3PXG19KHLS27jz+4m33c7JugMex6MT7rxql/1EixKKZJD6YmbktqpAZDZ0vMOO3yIkmlly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKYWQMMM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKYWQMMM"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c263415982eso301516466b.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396321; x=1792001121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njA+3Oh72tyJ2YsDPYi/upFiRlLaUAK1AyvNO5eDmgg=;
        b=pKYWQMMMlue9A1C+wpY9l9u//t0G75xzG7b06SJdwr7KvYdCbb9OvExpKaEnzka1mX
         D61Jk4CN5n/KZY+dAArYALQD+Ui1wUJVp/8olLRV1yweJh3t6lWESBiJkHtB1pyq5FM2
         sqfjUboZeBSTMIWBN/imNVmI8blQ1xrwk4x7zSsn71dcojcXErh4nqTBPjVYiRcwKSrk
         nqbHEum+kxe9fZ5T1JEq7TCTFK4sOEZgXf1GdsfvkIeP4ujkXTW9/jEfH0UNK821yIMl
         cOMDsmyagQ5C0VKjQ8DwntnUZG2Tp5DZBx9mq5/ZiyJ0JAqQp6uEeCsilBPCS7w0TQCL
         155g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396321; x=1792001121;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njA+3Oh72tyJ2YsDPYi/upFiRlLaUAK1AyvNO5eDmgg=;
        b=HSQzW/5gvhX9lQQQzcF/JfD8SuaoKaydvcBL7FE5Jzz2djyhCWp/eK/hjsSgt3+dYy
         wWvm63jxfcBuYM/zGiz08LCIh9mh+ERYp0Sd29vChe9QjCrbsPRJByi/cBRAtkkODMiC
         IgFclGJIGd35dtGWeur98Wkt+/6dfZT0JTdwSwjnM+cy/vEzTMy9nJF8l0np8ufmRIiS
         eP3KonmdAHLgdhNVo+SrOJmKb214bIOFeCCHI7F4XNQbpKuJNptxfIqFnVIEu0MmlO1d
         Xk79u//s4c14i9qRi3Fl2P5zdtbAkQk8Ah46AIjt4n4aEl7KFGnOY2a59z+DsDD2CG3n
         1wLQ==
X-Gm-Message-State: AFuF++nxs2jgaa2AoKtMa5D+NAegArAvbUNOVP2hJroo9y0hPBrkiwot
	ruUwOPThAcAHZwAQv7b2BBN1K+GZdks1QUn1Zpyqi6NxHZ7j9wUG8zO+z9aLHQ==
X-Gm-Gg: AYBFou2yDVtvO7nnkQMS0/l4R9s+H9b3JXCLAfcbT04QNIccS+CxIVQ4EO3pYjmsLFk
	dBkN9gWxLCmwl85P47LJRoUlnDYrrD62PcJoe7v0JibdGw1sUYlmxkIV4BOJR57qsFTY4z3X653
	uFeabykhCa7Aemsn/qX9qbNoEbmPEYl81adwN2HO2WkEkiVQXedAhxSbYgO0gWVVopf+cySoLOC
	pw8pcNV7DjbWiRHjHPJUaSru7V53NbPtP1kKn6ny8TQAYn0yOa9SKROiz+DcxizLvHZzEZq/NAi
	2OuNSiAMMHkxGo8NQP4cwXuk1fkGiqD/xjzz1clr+UEDCtlOGV5i0kuSmijzBEmQ4nNIAfjjdJT
	mpsjkd3fqIEq6sAOlo5IB5kdmUK5yi84ekR49q4KGXQ3Ty3xMjZ/uSRPGqLNAstPqlGIgM90tLu
	D+15qEggm5JAyvZghSW2DXzelFU3zvlMZMYEen/EnZg5GbVPS8hLNH2UxUrpQbVOkCggfkV4Eua
	xc8T0SJ5tnO0pDYtu3Wn/4/hd76wMejhwD2KG14LisudstCzGFn4dxzNDZ20kpnShVuGAMGCqlM
	Kumq3LzI1GTBvesNSaH0TuqnjhWVe12W35oi7CcafE0OU7ymsECHijqjlv9JsgAHeDpyFkrqQ5J
	Zi2BoV4dgrwytw79JaZ3AtRCeL+rKUBdFSBuTuYi7
X-Received: by 2002:a17:907:1c84:b0:c2e:4705:467c with SMTP id a640c23a62f3a-c317bd450f0mr314475966b.10.1791396320570;
        Wed, 07 Oct 2026 11:05:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([37.31.50.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2f19bdsm129986066b.47.2026.10.07.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:05:20 -0700 (PDT)
Message-Id: <83fa644fb3dbf1807e232cac22f9dd7528b766c1.1791395643.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <cover.1791395643.git.maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791395643.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Wed, 07 Oct 2026 20:05:17 +0200
Subject: [PATCH v3 4/4] refs: remove backend-specific copy and rename
 callbacks
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

Copy and rename now use the transaction API for refs and reflogs. Remove
the unused callbacks, backend implementations, and their private
helpers. The files backend no longer needs a shared temporary reflog
name or rollback writes that reconstruct previously visible refs and
logs.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 refs/debug.c            |  24 ---
 refs/files-backend.c    | 334 ----------------------------------------
 refs/packed-backend.c   |   2 -
 refs/refs-internal.h    |   9 --
 refs/reftable-backend.c | 287 ----------------------------------
 5 files changed, 656 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 639db0f26e..b4991f71ae 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -143,28 +143,6 @@ static int debug_optimize_required(struct ref_store *ref_store,
 	return res;
 }
 
-static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
-			    const char *newref, const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
-					      logmsg);
-	trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
-		logmsg, res);
-	return res;
-}
-
-static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
-			  const char *newref, const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res =
-		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
-	trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
-		logmsg, res);
-	return res;
-}
-
 struct debug_ref_iterator {
 	struct ref_iterator base;
 	struct ref_iterator *iter;
@@ -453,8 +431,6 @@ struct ref_storage_be refs_be_debug = {
 	.optimize = debug_optimize,
 	.optimize_required = debug_optimize_required,
 
-	.rename_ref = debug_rename_ref,
-	.copy_ref = debug_copy_ref,
 
 	.iterator_begin = debug_ref_iterator_begin,
 	.read_raw_ref = debug_read_raw_ref,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9e22f62d3f..a00cfc6be5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1623,273 +1623,6 @@ static int files_optimize_required(struct ref_store *ref_store,
 	return 0;
 }
 
-/*
- * People using contrib's git-new-workdir have .git/logs/refs ->
- * /some/other/path/.git/logs/refs, and that may live on another device.
- *
- * IOW, to avoid cross device rename errors, the temporary renamed log must
- * live into logs/refs.
- */
-#define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
-
-struct rename_cb {
-	const char *tmp_renamed_log;
-	int true_errno;
-};
-
-static int rename_tmp_log_callback(const char *path, void *cb_data)
-{
-	struct rename_cb *cb = cb_data;
-
-	if (rename(cb->tmp_renamed_log, path)) {
-		/*
-		 * rename(a, b) when b is an existing directory ought
-		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
-		 * Sheesh. Record the true errno for error reporting,
-		 * but report EISDIR to raceproof_create_file() so
-		 * that it knows to retry.
-		 */
-		cb->true_errno = errno;
-		if (errno == ENOTDIR)
-			errno = EISDIR;
-		return -1;
-	} else {
-		return 0;
-	}
-}
-
-static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
-{
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf tmp = STRBUF_INIT;
-	struct rename_cb cb;
-	int ret;
-
-	files_reflog_path(refs, &path, newrefname);
-	files_reflog_path(refs, &tmp, TMP_RENAMED_LOG);
-	cb.tmp_renamed_log = tmp.buf;
-	ret = raceproof_create_file(refs, path.buf, rename_tmp_log_callback, &cb);
-	if (ret) {
-		if (errno == EISDIR)
-			error("directory not empty: %s", path.buf);
-		else
-			error("unable to move logfile %s to %s: %s",
-			      tmp.buf, path.buf,
-			      strerror(cb.true_errno));
-	}
-
-	strbuf_release(&path);
-	strbuf_release(&tmp);
-	return ret;
-}
-
-static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
-							struct ref_lock *lock,
-							const struct object_id *oid,
-							struct strbuf *err);
-static int commit_ref_update(struct files_ref_store *refs,
-			     struct ref_lock *lock,
-			     const struct object_id *oid, const char *logmsg,
-			     int flags,
-			     struct strbuf *err);
-
-/*
- * Emit a better error message than lockfile.c's
- * unable_to_lock_message() would in case there is a D/F conflict with
- * another existing reference. If there would be a conflict, emit an error
- * message and return false; otherwise, return true.
- *
- * Note that this function is not safe against all races with other
- * processes, and that's not its job. We'll emit a more verbose error on D/f
- * conflicts if we get past it into lock_ref_oid_basic().
- */
-static int refs_rename_ref_available(struct ref_store *refs,
-			      const char *old_refname,
-			      const char *new_refname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ok;
-
-	string_list_insert(&skip, old_refname);
-	ok = !refs_verify_refname_available(refs, new_refname,
-					    NULL, &skip, 0, &err);
-	if (!ok)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ok;
-}
-
-static int files_copy_or_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg, int copy)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct object_id orig_oid;
-	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
-	struct stat loginfo;
-	struct strbuf sb_oldref = STRBUF_INIT;
-	struct strbuf sb_newref = STRBUF_INIT;
-	struct strbuf tmp_renamed_log = STRBUF_INIT;
-	int log, ret;
-	struct strbuf err = STRBUF_INIT;
-
-	files_reflog_path(refs, &sb_oldref, oldrefname);
-	files_reflog_path(refs, &sb_newref, newrefname);
-	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
-
-	log = !lstat(sb_oldref.buf, &loginfo);
-	if (log && S_ISLNK(loginfo.st_mode)) {
-		ret = error("reflog for %s is a symlink", oldrefname);
-		goto out;
-	}
-
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
-				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				     &orig_oid, &flag)) {
-		ret = error("refname %s not found", oldrefname);
-		goto out;
-	}
-
-	if (flag & REF_ISSYMREF) {
-		if (copy)
-			ret = error("refname %s is a symbolic ref, copying it is not supported",
-				    oldrefname);
-		else
-			ret = error("refname %s is a symbolic ref, renaming it is not supported",
-				    oldrefname);
-		goto out;
-	}
-	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
-		ret = 1;
-		goto out;
-	}
-
-	if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
-		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
-			    oldrefname, strerror(errno));
-		goto out;
-	}
-
-	if (copy && log && copy_file(refs->base.repo, tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
-		ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
-			    oldrefname, strerror(errno));
-		goto out;
-	}
-
-	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    &orig_oid, REF_NO_DEREF)) {
-		error("unable to delete old %s", oldrefname);
-		goto rollback;
-	}
-
-	/*
-	 * Since we are doing a shallow lookup, oid is not the
-	 * correct value to pass to delete_ref as old_oid. But that
-	 * doesn't matter, because an old_oid check wouldn't add to
-	 * the safety anyway; we want to delete the reference whatever
-	 * its current value.
-	 */
-	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
-					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					     NULL, NULL) &&
-	    refs_delete_ref(&refs->base, NULL, newrefname,
-			    NULL, REF_NO_DEREF)) {
-		if (errno == EISDIR) {
-			struct strbuf path = STRBUF_INIT;
-			int result;
-
-			files_ref_path(refs, &path, newrefname);
-			result = remove_empty_directories(&path);
-			strbuf_release(&path);
-
-			if (result) {
-				error("Directory not empty: %s", newrefname);
-				goto rollback;
-			}
-		} else {
-			error("unable to delete existing %s", newrefname);
-			goto rollback;
-		}
-	}
-
-	if (log && rename_tmp_log(refs, newrefname))
-		goto rollback;
-
-	logmoved = log;
-
-	lock = lock_ref_oid_basic(refs, newrefname, &err);
-	if (!lock) {
-		if (copy)
-			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
-		else
-			error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
-		strbuf_release(&err);
-		goto rollback;
-	}
-	oidcpy(&lock->old_oid, &orig_oid);
-
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
-		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
-		strbuf_release(&err);
-		goto rollback;
-	}
-
-	ret = 0;
-	goto out;
-
- rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, &err);
-	if (!lock) {
-		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
-		strbuf_release(&err);
-		goto rollbacklog;
-	}
-
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, NULL, REF_SKIP_CREATE_REFLOG, &err)) {
-		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
-		strbuf_release(&err);
-	}
-
- rollbacklog:
-	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from %s: %s",
-			oldrefname, newrefname, strerror(errno));
-	if (!logmoved && log &&
-	    rename(tmp_renamed_log.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-	ret = 1;
- out:
-	strbuf_release(&sb_newref);
-	strbuf_release(&sb_oldref);
-	strbuf_release(&tmp_renamed_log);
-
-	return ret;
-}
-
-static int files_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	return files_copy_or_rename_ref(ref_store, oldrefname,
-				 newrefname, logmsg, 0);
-}
-
-static int files_copy_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	return files_copy_or_rename_ref(ref_store, oldrefname,
-				 newrefname, logmsg, 1);
-}
-
 static int close_ref_gently(struct ref_lock *lock)
 {
 	if (close_lock_file_gently(&lock->lk))
@@ -2121,71 +1854,6 @@ static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *
 	return 0;
 }
 
-/*
- * Commit a change to a loose reference that has already been written
- * to the loose reference lockfile. Also update the reflogs if
- * necessary, using the specified lockmsg (which can be NULL).
- */
-static int commit_ref_update(struct files_ref_store *refs,
-			     struct ref_lock *lock,
-			     const struct object_id *oid, const char *logmsg,
-			     int flags,
-			     struct strbuf *err)
-{
-	files_assert_main_repository(refs, "commit_ref_update");
-
-	clear_loose_ref_cache(refs);
-	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid, oid, NULL,
-				logmsg, flags, err)) {
-		char *old_msg = strbuf_detach(err, NULL);
-		strbuf_addf(err, "cannot update the ref '%s': %s",
-			    lock->ref_name, old_msg);
-		free(old_msg);
-		unlock_ref(lock);
-		return -1;
-	}
-
-	if (strcmp(lock->ref_name, "HEAD") != 0) {
-		/*
-		 * Special hack: If a branch is updated directly and HEAD
-		 * points to it (may happen on the remote side of a push
-		 * for example) then logically the HEAD reflog should be
-		 * updated too.
-		 * A generic solution implies reverse symref information,
-		 * but finding all symrefs pointing to the given branch
-		 * would be rather costly for this rare event (the direct
-		 * update of a branch) to be worth it.  So let's cheat and
-		 * check with HEAD only which should cover 99% of all usage
-		 * scenarios (even 100% of the default ones).
-		 */
-		int head_flag;
-		const char *head_ref;
-
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
-						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name)) {
-			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write(refs, "HEAD", &lock->old_oid,
-						oid, NULL, logmsg, flags,
-						&log_err)) {
-				error("%s", log_err.buf);
-				strbuf_release(&log_err);
-			}
-		}
-	}
-
-	if (commit_ref(lock)) {
-		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
-		unlock_ref(lock);
-		return -1;
-	}
-
-	unlock_ref(lock);
-	return 0;
-}
-
 #if defined(NO_SYMLINK_HEAD) || defined(WITH_BREAKING_CHANGES)
 #define create_ref_symlink(a, b) (-1)
 #else
@@ -4468,8 +4136,6 @@ struct ref_storage_be refs_be_files = {
 
 	.optimize = files_optimize,
 	.optimize_required = files_optimize_required,
-	.rename_ref = files_rename_ref,
-	.copy_ref = files_copy_ref,
 
 	.iterator_begin = files_ref_iterator_begin,
 	.read_raw_ref = files_read_raw_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca7..364a912912 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2164,8 +2164,6 @@ struct ref_storage_be refs_be_packed = {
 	.optimize = packed_optimize,
 	.optimize_required = packed_optimize_required,
 
-	.rename_ref = NULL,
-	.copy_ref = NULL,
 
 	.iterator_begin = packed_ref_iterator_begin,
 	.read_raw_ref = packed_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2746ce5b49..c415ba0a4e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -470,13 +470,6 @@ typedef int optimize_required_fn(struct ref_store *ref_store,
 				 struct refs_optimize_opts *opts,
 				 bool *required);
 
-typedef int rename_ref_fn(struct ref_store *ref_store,
-			  const char *oldref, const char *newref,
-			  const char *logmsg);
-typedef int copy_ref_fn(struct ref_store *ref_store,
-			  const char *oldref, const char *newref,
-			  const char *logmsg);
-
 /*
  * Iterate over the references in `ref_store` whose names start with
  * `prefix`. `prefix` is matched as a literal string, without regard
@@ -596,8 +589,6 @@ struct ref_storage_be {
 
 	optimize_fn *optimize;
 	optimize_required_fn *optimize_required;
-	rename_ref_fn *rename_ref;
-	copy_ref_fn *copy_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 72c1596c11..ef3bab69ee 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1798,290 +1798,6 @@ struct write_create_symref_arg {
 	const char *logmsg;
 };
 
-struct write_copy_arg {
-	struct reftable_ref_store *refs;
-	struct reftable_backend *be;
-	const char *oldname;
-	const char *newname;
-	const char *logmsg;
-	int delete_old;
-};
-
-static int write_copy_table(struct reftable_writer *writer, void *cb_data)
-{
-	struct write_copy_arg *arg = cb_data;
-	uint64_t deletion_ts, creation_ts;
-	struct reftable_ref_record old_ref = {0}, refs[2] = {0};
-	struct reftable_log_record old_log = {0}, *logs = NULL;
-	struct reftable_iterator it = {0};
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct ident_split committer_ident = {0};
-	struct strbuf errbuf = STRBUF_INIT;
-	size_t logs_nr = 0, logs_alloc = 0, i;
-	const char *committer_info;
-	int ret;
-
-	committer_info = git_committer_info(0);
-	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
-		BUG("failed splitting committer info");
-
-	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
-		ret = error(_("refname %s not found"), arg->oldname);
-		goto done;
-	}
-	if (old_ref.value_type == REFTABLE_REF_SYMREF) {
-		ret = error(_("refname %s is a symbolic ref, copying it is not supported"),
-			    arg->oldname);
-		goto done;
-	}
-
-	/*
-	 * There's nothing to do in case the old and new name are the same, so
-	 * we exit early in that case.
-	 */
-	if (!strcmp(arg->oldname, arg->newname)) {
-		ret = 0;
-		goto done;
-	}
-
-	/*
-	 * Verify that the new refname is available.
-	 */
-	if (arg->delete_old)
-		string_list_insert(&skip, arg->oldname);
-	ret = refs_verify_refname_available(&arg->refs->base, arg->newname,
-					    NULL, &skip, 0, &errbuf);
-	if (ret < 0) {
-		error("%s", errbuf.buf);
-		goto done;
-	}
-
-	/*
-	 * When deleting the old reference we have to use two update indices:
-	 * once to delete the old ref and its reflog, and once to create the
-	 * new ref and its reflog. They need to be staged with two separate
-	 * indices because the new reflog needs to encode both the deletion of
-	 * the old branch and the creation of the new branch, and we cannot do
-	 * two changes to a reflog in a single update.
-	 */
-	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
-	if (arg->delete_old)
-		creation_ts++;
-	ret = reftable_writer_set_limits(writer, deletion_ts, creation_ts);
-	if (ret < 0)
-		goto done;
-
-	/*
-	 * Add the new reference. If this is a rename then we also delete the
-	 * old reference.
-	 */
-	refs[0] = old_ref;
-	refs[0].refname = xstrdup(arg->newname);
-	refs[0].update_index = creation_ts;
-	if (arg->delete_old) {
-		refs[1].refname = xstrdup(arg->oldname);
-		refs[1].value_type = REFTABLE_REF_DELETION;
-		refs[1].update_index = deletion_ts;
-	}
-	ret = reftable_writer_add_refs(writer, refs, arg->delete_old ? 2 : 1);
-	if (ret < 0)
-		goto done;
-
-	/*
-	 * When deleting the old branch we need to create a reflog entry on the
-	 * new branch name that indicates that the old branch has been deleted
-	 * and then recreated. This is a tad weird, but matches what the files
-	 * backend does.
-	 */
-	if (arg->delete_old) {
-		struct strbuf head_referent = STRBUF_INIT;
-		struct object_id head_oid;
-		int append_head_reflog;
-		unsigned head_type = 0;
-
-		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-		logs[logs_nr].refname = xstrdup(arg->newname);
-		logs[logs_nr].update_index = deletion_ts;
-		logs[logs_nr].value.update.message =
-			xstrndup(arg->logmsg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
-		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
-		logs_nr++;
-
-		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
-						&head_referent, &head_type);
-		if (ret < 0)
-			goto done;
-		append_head_reflog = (head_type & REF_ISSYMREF) && !strcmp(head_referent.buf, arg->oldname);
-		strbuf_release(&head_referent);
-
-		/*
-		 * The files backend uses `refs_delete_ref()` to delete the old
-		 * branch name, which will append a reflog entry for HEAD in
-		 * case it points to the old branch.
-		 */
-		if (append_head_reflog) {
-			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-			logs[logs_nr] = logs[logs_nr - 1];
-			logs[logs_nr].refname = xstrdup("HEAD");
-			logs[logs_nr].value.update.name =
-				xstrdup(logs[logs_nr].value.update.name);
-			logs[logs_nr].value.update.email =
-				xstrdup(logs[logs_nr].value.update.email);
-			logs[logs_nr].value.update.message =
-				xstrdup(logs[logs_nr].value.update.message);
-			logs_nr++;
-		}
-	}
-
-	/*
-	 * Create the reflog entry for the newly created branch.
-	 */
-	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-	logs[logs_nr].refname = xstrdup(arg->newname);
-	logs[logs_nr].update_index = creation_ts;
-	logs[logs_nr].value.update.message =
-		xstrndup(arg->logmsg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
-	memcpy(logs[logs_nr].value.update.new_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
-	logs_nr++;
-
-	/*
-	 * In addition to writing the reflog entry for the new branch, we also
-	 * copy over all log entries from the old reflog. Last but not least,
-	 * when renaming we also have to delete all the old reflog entries.
-	 */
-	ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
-	if (ret < 0)
-		goto done;
-
-	ret = reftable_iterator_seek_log(&it, arg->oldname);
-	if (ret < 0)
-		goto done;
-
-	while (1) {
-		ret = reftable_iterator_next_log(&it, &old_log);
-		if (ret < 0)
-			goto done;
-		if (ret > 0 || strcmp(old_log.refname, arg->oldname)) {
-			ret = 0;
-			break;
-		}
-		if (reftable_log_record_is_deletion(&old_log))
-			continue;
-
-		free(old_log.refname);
-
-		/*
-		 * Copy over the old reflog entry with the new refname.
-		 */
-		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-		logs[logs_nr] = old_log;
-		logs[logs_nr].refname = xstrdup(arg->newname);
-		logs_nr++;
-
-		/*
-		 * Delete the old reflog entry in case we are renaming.
-		 */
-		if (arg->delete_old) {
-			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-			logs[logs_nr].refname = xstrdup(arg->oldname);
-			logs[logs_nr].value_type = REFTABLE_LOG_DELETION;
-			logs[logs_nr].update_index = old_log.update_index;
-			logs_nr++;
-		}
-
-		/*
-		 * Transfer ownership of the log record we're iterating over to
-		 * the array of log records. Otherwise, the pointers would get
-		 * free'd or reallocated by the iterator.
-		 */
-		memset(&old_log, 0, sizeof(old_log));
-	}
-
-	ret = reftable_writer_add_logs(writer, logs, logs_nr);
-	if (ret < 0)
-		goto done;
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	reftable_iterator_destroy(&it);
-	string_list_clear(&skip, 0);
-	strbuf_release(&errbuf);
-	for (i = 0; i < logs_nr; i++)
-		reftable_log_record_release(&logs[i]);
-	free(logs);
-	for (i = 0; i < ARRAY_SIZE(refs); i++)
-		reftable_ref_record_release(&refs[i]);
-	reftable_ref_record_release(&old_ref);
-	reftable_log_record_release(&old_log);
-	return ret;
-}
-
-static int reftable_be_rename_ref(struct ref_store *ref_store,
-				  const char *oldrefname,
-				  const char *newrefname,
-				  const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct write_copy_arg arg = {
-		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-		.delete_old = 1,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
-		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
-	if (ret)
-		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	return ret;
-}
-
-static int reftable_be_copy_ref(struct ref_store *ref_store,
-				const char *oldrefname,
-				const char *newrefname,
-				const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct write_copy_arg arg = {
-		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
-		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
-	if (ret)
-		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	return ret;
-}
-
 struct reftable_reflog_iterator {
 	struct ref_iterator base;
 	struct reftable_ref_store *refs;
@@ -2909,9 +2625,6 @@ struct ref_storage_be refs_be_reftable = {
 	.optimize = reftable_be_optimize,
 	.optimize_required = reftable_be_optimize_required,
 
-	.rename_ref = reftable_be_rename_ref,
-	.copy_ref = reftable_be_copy_ref,
-
 	.iterator_begin = reftable_be_iterator_begin,
 	.read_raw_ref = reftable_be_read_raw_ref,
 	.read_symbolic_ref = reftable_be_read_symbolic_ref,
-- 
2.39.3 (Apple Git-146)

