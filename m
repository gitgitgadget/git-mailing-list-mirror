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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E011C48BE6
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687C0613DE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFJNBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:01:13 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:40478 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFJNBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:01:04 -0400
Received: by mail-wm1-f41.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so6479964wmd.5
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ggK1vRq4EPD3GAYB0verdQVOgjBfjwjzE+KqL0j3Kas=;
        b=CKj/Va7ARI191UQfdB5MRp0SNqrSeXJpwJkBDY1PuwsB3xzhEpfdOict8ZgqX2pYHL
         JaSze1JwoSYKIvAIqP3hCbpZ8vHnK2DndAMigfHBtZ5M0DHy4YH0k+f+vQFZS8NU0pKt
         pFaID+wCat6mvS9BXzcwD9tL5SymE0xfJO1VIMrWERN4cUE5uP0FJtLLePQLGxcXNbts
         sWclheFJ0iQYKD66XQ6nJ2nMTLSHyttXynsTD3JcKG2E1Ha8L3MdoxdhsEj0mu8gV/HU
         Mxt9au6oukoKb5GfXe5hSTzw+vWJFBs3+wj+RM6dga5nVd9Dg3kfL2RPz1/nMPXdeplZ
         7s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ggK1vRq4EPD3GAYB0verdQVOgjBfjwjzE+KqL0j3Kas=;
        b=LbnxRwRpW8u03THbXHDaLkFwV+2+Xly11NyDbOz766WkbyZeuWtVaCp5zSYvYYLs3k
         bbyXVIpqkRvHFL+wsRIALQZBBRDi1S/oGJYugs0dTHqAEsAezns4dBKwhLj3UxcvkAAY
         rz+ANGFtkz1oJkDxMuWX7Jmkhi3m95ZMP/YrXCWHw/KA8Iu3v+uDxw9AqcMt6p8PunE/
         GHUzF/1HVpu6d5Vk5vNLo8Xezlc6AjhDEHCuPycHskiOOLb/Y5fYogWU8thXdOjL1j9C
         2W3vjy2LwQOWCGzBJvV7qr1+Pr91YRlcqMsJwxORDKOvzMCoZrQ6nfilOJ2Whiu9K1pl
         NF/Q==
X-Gm-Message-State: AOAM532m81ccR8RjBpV2fzk4SMYfaDVKfGIy5r0PTSRaBptnVyGZ6Ykc
        v0Kmfu0M8Idhd+ns+HzCcRIBJgAm8yM=
X-Google-Smtp-Source: ABdhPJz0cKFwi1XiIgkrBroydPeM4N5xref4Wd1f/3mKUSz67yMmMZLo1nw5Sn7X9SD7uYrGGQpd8Q==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr5065019wmq.42.1623329873707;
        Thu, 10 Jun 2021 05:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm3751947wre.95.2021.06.10.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:53 -0700 (PDT)
Message-Id: <2b346caf1aed265ca4787de4208375bd5cfb7bc7.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:46 +0000
Subject: [PATCH v2 6/8] refs: add failure_errno to refs_read_raw_ref()
 signature
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

This makes the errno output of refs_read_raw_ref explicit.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                | 29 ++++++++++++++---------------
 refs/files-backend.c  |  8 ++++----
 refs/packed-backend.c | 10 ++++++----
 refs/refs-internal.h  |  6 +++---
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 64e2d55adcfb..ed2dde1c0c6d 100644
--- a/refs.c
+++ b/refs.c
@@ -1671,21 +1671,19 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	return result;
 }
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type)
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno)
 {
-	int result, failure;
+	if (failure_errno)
+		*failure_errno = 0;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
-	failure = 0;
-	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					     type, &failure);
-	errno = failure;
-	return result;
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					   type, failure_errno);
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1726,9 +1724,10 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
+		int read_failure = 0;
 
-		if (refs_read_raw_ref(refs, refname,
-				      oid, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
+				      &read_flags, &read_failure)) {
 			*flags |= read_flags;
 
 			/* In reading mode, refs must eventually resolve */
@@ -1740,9 +1739,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			 * may show errors besides ENOENT if there are
 			 * similarly-named refs.
 			 */
-			if (errno != ENOENT &&
-			    errno != EISDIR &&
-			    errno != ENOTDIR)
+			if (read_failure != ENOENT && read_failure != EISDIR &&
+			    read_failure != ENOTDIR)
 				return NULL;
 
 			oidclr(oid);
@@ -2254,7 +2252,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+				       &type, NULL)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5a430aabf623..01c9bd0dbf04 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -383,8 +383,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+				      referent, type, NULL)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -423,8 +423,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+				      referent, type, NULL)) {
 			errno = EISDIR;
 			goto out;
 		}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a457f18e93c8..03353ce48869 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -739,7 +739,8 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	if (!rec) {
 		/* refname is not a packed reference. */
-		*failure_errno = ENOENT;
+		if (failure_errno)
+			*failure_errno = ENOENT;
 		return -1;
 	}
 
@@ -1347,6 +1348,7 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 	ret = 0;
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		int failure;
 		unsigned int type;
 		struct object_id oid;
 
@@ -1357,9 +1359,9 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 			 */
 			continue;
 
-		if (!refs_read_raw_ref(ref_store, update->refname,
-				       &oid, &referent, &type) ||
-		    errno != ENOENT) {
+		if (!refs_read_raw_ref(ref_store, update->refname, &oid,
+				       &referent, &type, &failure) ||
+		    failure != ENOENT) {
 			/*
 			 * We have to actually delete that reference
 			 * -> this transaction is needed.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index eb97023658f8..c65d26580ce8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -149,9 +149,9 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type);
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno);
 
 /* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
  * failure. */
-- 
gitgitgadget

