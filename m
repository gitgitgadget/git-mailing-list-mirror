Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12DC48BE5
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD7F613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFJNBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:01:03 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39847 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhFJNBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:01:02 -0400
Received: by mail-wr1-f41.google.com with SMTP id l2so2212989wrw.6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uf+y4ZrMvh9HtGQoVOmGu6w9gtBwi2AXbIFRiB9KD5s=;
        b=UbuC92NHTcGYU9C0yQOWn22P2xNPmb2YVphPJ8CBiNTV1g2vsfyOeyXvvWb2PUqd+s
         2a2XSw+Cw3vjmtx+/M2jIPcHrJGN63c4LN73x4dq/b8UHL9ixa3Etc7EcOb60OjeHxsJ
         oxgF09DVtBF0MDC2PSIEcUDtIr6iWIzdBXkwv5UzTVSL0QD2wrvSb24XLh8y4s1lWLkD
         oeoqOlS/JnTKoiB6Y+JYNT+5YQXs6IJjzrsJUGkIZvmGfhMAXyYS2kApjCBcTUEBbnFy
         ngvBNAp1I00c7P4JA8HGXq7MERpVhmCfRx0HN07vD4kJQCl8OEgHNgBgNtb+ywqMlCkx
         phUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uf+y4ZrMvh9HtGQoVOmGu6w9gtBwi2AXbIFRiB9KD5s=;
        b=pnlWWTRIrdjJe+ijrr2L0rwLX/YpnoxcOuCCmxHXS9cRP7+43ScpLYKhzSdrHE3Xrp
         EOaPyYN+2PHXqtvedi0Aa1TWV9kfoYGtt7DXrtwFW8lo6oL8MXLkFk+bjJmRjx5+g1p/
         gJsu1+5JiXqA+YsI6VcZRCA9sk1Mgr9AHrpRC8gsILzcgZRQn+PVNC+FiLsH9c4G4EJD
         mjsXbH9YBe/DXVSJLtBBLH6ciQ7Tkt4dUKRQWFXJG1Hmvs6A49KPaV3L8gby8BMcg8dz
         baM7cIG7fMwq5xt5uh+mpqyembxXZ3MIGaCwCCEAejkHZZU/VRdlXtVUJrvXKIs/4qEh
         VoYw==
X-Gm-Message-State: AOAM5333HJrJG6LCjhXiqBmsH1WUZRM0u9R2L5g+gqSOKOsLbROfFpix
        FPykCHH+8OwOlGU7JE+swSg3vpiLi5s=
X-Google-Smtp-Source: ABdhPJxC7K32JHmdCOoyWrzxUNF5RhieqU3xNB0f3sAChRkDNbhVhQuLqoM4l30ErTuTVNRUlOXh7Q==
X-Received: by 2002:a5d:64a4:: with SMTP id m4mr5162611wrp.185.1623329872187;
        Thu, 10 Jun 2021 05:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm1463068wme.21.2021.06.10.05.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:51 -0700 (PDT)
Message-Id: <3e2831e59c8e4cb8aef416a41b55083887b4559c.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:43 +0000
Subject: [PATCH v2 3/8] refs: make errno output explicit for read_raw_ref_fn
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

read_raw_ref_fn needs to supply a credible errno for a number of cases. These
are primarily:

1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
resulting error codes to create/remove directories as needed.

2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
returning the last successfully resolved symref. This is necessary so
read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
du-jour), and we know on which branch to create the first commit.

Make this information flow explicit by adding a failure_errno to the signature
of read_raw_ref. All errnos from the files backend are still propagated
unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
relevant.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                |  8 ++++++--
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 24 ++++++++++++------------
 refs/packed-backend.c |  8 ++++----
 refs/refs-internal.h  | 17 +++++++++--------
 5 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index 8c9490235ea6..bebe3f584da7 100644
--- a/refs.c
+++ b/refs.c
@@ -1675,13 +1675,17 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type)
 {
+	int result, failure;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
-	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					   type);
+	failure = 0;
+	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					     type, &failure);
+	errno = failure;
+	return result;
 }
 
 /* This function needs to return a meaningful errno on failure */
diff --git a/refs/debug.c b/refs/debug.c
index 7db4abccc341..f12413a9bc0f 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -238,7 +238,7 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
 
 static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 			      struct object_id *oid, struct strbuf *referent,
-			      unsigned int *type)
+			      unsigned int *type, int *failure_errno)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
@@ -246,7 +246,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	oidcpy(oid, null_oid());
 	errno = 0;
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
-					    type);
+					    type, failure_errno);
 
 	if (res == 0) {
 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6aa0f5c41dd3..8f969c8f711f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -341,9 +341,9 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 	return refs->loose;
 }
 
-static int files_read_raw_ref(struct ref_store *ref_store,
-			      const char *refname, struct object_id *oid,
-			      struct strbuf *referent, unsigned int *type)
+static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			      struct object_id *oid, struct strbuf *referent,
+			      unsigned int *type, int *failure_errno)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -354,7 +354,6 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	struct stat st;
 	int fd;
 	int ret = -1;
-	int save_errno;
 	int remaining_retries = 3;
 
 	*type = 0;
@@ -459,10 +458,10 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	ret = parse_loose_ref_contents(buf, oid, referent, type);
 
 out:
-	save_errno = errno;
+	if (failure_errno)
+		*failure_errno = errno;
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
-	errno = save_errno;
 	return ret;
 }
 
@@ -541,6 +540,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
+	int failure_errno = 0;
 
 	assert(err);
 	files_assert_main_repository(refs, "lock_raw_ref");
@@ -629,9 +629,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	 * fear that its value will change.
 	 */
 
-	if (files_read_raw_ref(&refs->base, refname,
-			       &lock->old_oid, referent, type)) {
-		if (errno == ENOENT) {
+	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
+			       type, &failure_errno)) {
+		if (failure_errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
@@ -655,7 +655,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				 *   reference named "refs/foo/bar/baz".
 				 */
 			}
-		} else if (errno == EISDIR) {
+		} else if (failure_errno == EISDIR) {
 			/*
 			 * There is a directory in the way. It might have
 			 * contained references that have been deleted. If
@@ -693,13 +693,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
 					goto error_return;
 				}
 			}
-		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
+		} else if (failure_errno == EINVAL && (*type & REF_ISBROKEN)) {
 			strbuf_addf(err, "unable to resolve reference '%s': "
 				    "reference broken", refname);
 			goto error_return;
 		} else {
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(errno));
+				    refname, strerror(failure_errno));
 			goto error_return;
 		}
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfecdbc1db60..a457f18e93c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -724,9 +724,9 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 	return refs->snapshot;
 }
 
-static int packed_read_raw_ref(struct ref_store *ref_store,
-			       const char *refname, struct object_id *oid,
-			       struct strbuf *referent, unsigned int *type)
+static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			       struct object_id *oid, struct strbuf *referent,
+			       unsigned int *type, int *failure_errno)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -739,7 +739,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 
 	if (!rec) {
 		/* refname is not a packed reference. */
-		errno = ENOENT;
+		*failure_errno = ENOENT;
 		return -1;
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f4445e329045..904b2a9e51ae 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -617,11 +617,12 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
- * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
- * (errno should not be ENOENT) If there is another error reading the
- * ref, set errno appropriately and return -1.
+ * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT
+ * and return -1. If the ref exists but is neither a symbolic ref nor an object
+ * ID, it is broken; set REF_ISBROKEN in type, and return -1 (failure_errno
+ * should not be ENOENT). The files backend may return EISDIR (if the ref name
+ * is a directory) and ENOTDIR (if a ref prefix is not a directory). If there is
+ * another error reading the ref, set failure_errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
@@ -635,9 +636,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-typedef int read_raw_ref_fn(struct ref_store *ref_store,
-			    const char *refname, struct object_id *oid,
-			    struct strbuf *referent, unsigned int *type);
+typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
+			    struct object_id *oid, struct strbuf *referent,
+			    unsigned int *type, int *failure_errno);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
-- 
gitgitgadget

