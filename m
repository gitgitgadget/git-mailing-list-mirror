Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3C4201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932698AbdBVOIK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:08:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35146 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbdBVOIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:08:09 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so547884pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uv9aWRK3bKzhglK22YNJ+JjyAME/T/cyKCPDhcvVntg=;
        b=GfU1aeaeURY2QpR2mVUIQqr6bA/B90d+ZasIoXV+fduPscrxSPSpQobWHIi4qBbFVQ
         d63sKbW0HQbTaF0z8ZhoNIFPXIkGWRoKk2JNgRwcoKmoAIe7kLv5t60OhZBFEbuTTQhm
         CnnnTFvx7doWtnlXwoNxAr5qMz2XocjMztuDX6+izMxxtqbZv9Wd4kmvsi3tQo1sD9q6
         DpCoj2QnmK+TcHHQzCBABNVBV05456xJo5Euj0JP9lxbHkCmqElEEuUszHluPFuJWr0b
         s5Kmh7Vd/WizvYuQvFSBGwGOPr99kLxxqGpXlP3wQEITLcERDY5dkOKugbqgyozqm1CG
         /PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uv9aWRK3bKzhglK22YNJ+JjyAME/T/cyKCPDhcvVntg=;
        b=b4M0X5QAvop8JLQcpwgMCCtcYfz7QzxjUTeF3FYuKswjwe/G5r757i72NJYqpMSNB8
         epKSCfIRNE6sDDfhw2cO17Gfm8y9SV5ArVMJ+mZhURQIb8BBc01gOA7oJyzDP0+S0r2Y
         7AvFUM2zzlOO3vT3i9zKAW4vAoacytcjheylFlFoutd9zn3vv0EakchDkb15wsdBLz5N
         WAwina0Av4l3nvLbcbQJq3uvitMUSOVJcbQKQRp0T0+O63evI3KPqlpfdmRPHx/+uvM7
         9YiSoOraku3KvgfKfy+4L87Psne1vv7q44CLqBk9tjGHHFDOClizFrcI9FWI62pgDt1S
         ZjVA==
X-Gm-Message-State: AMke39nlLSl1wkyUUaZQ0rAROAvKQOfEKdH87jKKtaL7w6uxeODemzom1gFYoPD6jmM7kw==
X-Received: by 10.84.225.18 with SMTP id t18mr48517875plj.154.1487772488197;
        Wed, 22 Feb 2017 06:08:08 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t6sm4101259pgo.42.2017.02.22.06.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:08:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:08:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 20/24] files-backend: avoid ref api targetting main ref store
Date:   Wed, 22 Feb 2017 21:04:46 +0700
Message-Id: <20170222140450.30886-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small step towards making files-backend works as a non-main ref store
using the newly added store-aware API.

For the record, `join` and `nm` on refs.o and files-backend.o tell me
that files-backend no longer uses functions that defaults to
get_main_ref_store().

I'm not yet comfortable at the idea of removing
files_assert_main_repository() (or converting REF_STORE_MAIN to
REF_STORE_WRITE). More staring and testing is required before that can
happen. Well, except peel_ref(). I'm pretty sure that function is safe.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 85 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dafddefd3..09c280fd3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1836,8 +1836,6 @@ static int files_peel_ref(struct ref_store *ref_store,
 	int flag;
 	unsigned char base[20];
 
-	files_assert_main_repository(refs, "peel_ref");
-
 	if (current_ref_iter && current_ref_iter->refname == refname) {
 		struct object_id peeled;
 
@@ -1847,7 +1845,8 @@ static int files_peel_ref(struct ref_store *ref_store,
 		return 0;
 	}
 
-	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
+	if (refs_read_ref_full(ref_store, refname,
+			       RESOLVE_REF_READING, base, &flag))
 		return -1;
 
 	/*
@@ -2017,15 +2016,15 @@ static struct ref_iterator *files_ref_iterator_begin(
  * on success. On error, write an error message to err, set errno, and
  * return a negative value.
  */
-static int verify_lock(struct ref_lock *lock,
+static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 		       const unsigned char *old_sha1, int mustexist,
 		       struct strbuf *err)
 {
 	assert(err);
 
-	if (read_ref_full(lock->ref_name,
-			  mustexist ? RESOLVE_REF_READING : 0,
-			  lock->old_oid.hash, NULL)) {
+	if (refs_read_ref_full(ref_store, lock->ref_name,
+			       mustexist ? RESOLVE_REF_READING : 0,
+			       lock->old_oid.hash, NULL)) {
 		if (old_sha1) {
 			int save_errno = errno;
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
@@ -2094,8 +2093,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_refname_path(refs, &ref_file, refname);
-	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
-					lock->old_oid.hash, type);
+	resolved = !!refs_resolve_ref_unsafe(&refs->base,
+					     refname, resolve_flags,
+					     lock->old_oid.hash, type);
 	if (!resolved && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
@@ -2112,8 +2112,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 					    refname);
 			goto error_return;
 		}
-		resolved = !!resolve_ref_unsafe(refname, resolve_flags,
-						lock->old_oid.hash, type);
+		resolved = !!refs_resolve_ref_unsafe(&refs->base,
+						     refname, resolve_flags,
+						     lock->old_oid.hash, type);
 	}
 	if (!resolved) {
 		last_errno = errno;
@@ -2151,7 +2152,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (verify_lock(lock, old_sha1, mustexist, err)) {
+	if (verify_lock(&refs->base, lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
@@ -2406,7 +2407,7 @@ static void try_remove_empty_parents(struct files_ref_store *refs,
 }
 
 /* make sure nobody touched the ref, and unlink */
-static void prune_ref(struct ref_to_prune *r)
+static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2414,7 +2415,7 @@ static void prune_ref(struct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = ref_store_transaction_begin(&refs->base, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
 				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
@@ -2428,10 +2429,10 @@ static void prune_ref(struct ref_to_prune *r)
 	strbuf_release(&err);
 }
 
-static void prune_refs(struct ref_to_prune *r)
+static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	while (r) {
-		prune_ref(r);
+		prune_ref(refs, r);
 		r = r->next;
 	}
 }
@@ -2455,7 +2456,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
-	prune_refs(cbdata.ref_to_prune);
+	prune_refs(refs, cbdata.ref_to_prune);
 	return 0;
 }
 
@@ -2547,7 +2548,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (delete_ref(refname, NULL, flags))
+		if (refs_delete_ref(&refs->base, refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
@@ -2665,8 +2666,9 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				orig_sha1, &flag))
+	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
+				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				     orig_sha1, &flag))
 		return error("refname %s not found", oldrefname);
 
 	if (flag & REF_ISSYMREF)
@@ -2684,7 +2686,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 		return error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
+	if (refs_delete_ref(&refs->base, oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
@@ -2696,9 +2698,10 @@ static int files_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			   sha1, NULL) &&
-	    delete_ref(newrefname, NULL, REF_NODEREF)) {
+	if (!refs_read_ref_full(&refs->base, newrefname,
+				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				sha1, NULL) &&
+	    refs_delete_ref(&refs->base, newrefname, NULL, REF_NODEREF)) {
 		if (errno == EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -3054,8 +3057,9 @@ static int commit_ref_update(struct files_ref_store *refs,
 		int head_flag;
 		const char *head_ref;
 
-		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-					      head_sha1, &head_flag);
+		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
+						   RESOLVE_REF_READING,
+						   head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
@@ -3099,7 +3103,9 @@ static void update_symref_reflog(struct files_ref_store *refs,
 {
 	struct strbuf err = STRBUF_INIT;
 	unsigned char new_sha1[20];
-	if (logmsg && !read_ref(target, new_sha1) &&
+	if (logmsg &&
+	    !refs_read_ref_full(&refs->base, target,
+				RESOLVE_REF_READING, new_sha1, NULL) &&
 	    files_log_ref_write(refs, refname, lock->old_oid.hash,
 				new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
@@ -3403,6 +3409,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 struct files_reflog_iterator {
 	struct ref_iterator base;
 
+	struct ref_store *ref_store;
 	struct dir_iterator *dir_iterator;
 	struct object_id oid;
 };
@@ -3424,8 +3431,9 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
-		if (read_ref_full(diter->relative_path, 0,
-				  iter->oid.hash, &flags)) {
+		if (refs_read_ref_full(iter->ref_store,
+				       diter->relative_path, 0,
+				       iter->oid.hash, &flags)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
@@ -3479,6 +3487,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
 	files_reflog_path(refs, &sb, NULL);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
+	iter->ref_store = ref_store;
 	strbuf_release(&sb);
 	return ref_iterator;
 }
@@ -3718,8 +3727,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_sha1:
 			 */
-			if (read_ref_full(referent.buf, 0,
-					  lock->old_oid.hash, NULL)) {
+			if (refs_read_ref_full(&refs->base,
+					       referent.buf, 0,
+					       lock->old_oid.hash, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
@@ -3873,8 +3883,10 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	 * head_ref within the transaction, then split_head_update()
 	 * arranges for the reflog of HEAD to be updated, too.
 	 */
-	head_ref = resolve_refdup("HEAD", RESOLVE_REF_NO_RECURSE,
-				  head_oid.hash, &head_type);
+	head_ref = (char *)refs_resolve_ref_unsafe(ref_store, "HEAD",
+						   RESOLVE_REF_NO_RECURSE,
+						   head_oid.hash, &head_type);
+	head_ref = xstrdup_or_null(head_ref);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
 		free(head_ref);
@@ -4047,7 +4059,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (refs_for_each_rawref(&refs->base, ref_present,
+				 &affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < transaction->nr; i++) {
@@ -4166,7 +4179,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
-	if (!reflog_exists(refname)) {
+	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
 	}
@@ -4197,7 +4210,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	}
 
 	(*prepare_fn)(refname, sha1, cb.policy_cb);
-	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
+	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-- 
2.11.0.157.gd943d85

