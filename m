Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C214C1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbdBMPVW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:21:22 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34083 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbdBMPVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:21:21 -0500
Received: by mail-ot0-f196.google.com with SMTP id 73so11888974otj.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/dxWaMDdK6POnXgul5VaXplmo09YQvAYCthCHKRsM4=;
        b=o5Rcht8QDxf3GVWDEwkR+h1tN9scwgqWWZiavD2ygiFDIaTYsOHlPbzVF2Ibwn0IOc
         9pONdxmCtNvvfI8c/wn5jS+GejW2Kx0IEtuTOO+tx0zM9RBxo9MGgBU5r6J7nEmDZYLD
         Z3CtOloowucwOVdH7q24qHWrXbuU8wrWNpvaeEn93DOfQtWCy2RKxMDLkad5xiaoy2da
         iNquGIT8mz68YYcIdSZ3OK7QnGSvS5KxhrO5am0p23jcASp53fZMWFV3rhrvp2YzFXix
         SXtThz7iS0CgdRAhssbA3xHRI8L/hbo5OSecDhAjdZLNOO28vOFb21Dgnsc3rZK6lOgN
         s89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/dxWaMDdK6POnXgul5VaXplmo09YQvAYCthCHKRsM4=;
        b=meDrqRvjhQiWL/NURsilc1bzimtqyDoRP9cdRcr9hqB+UAc7t8PkQjqnuVZ+6dNqGR
         HTbsLkt9vNMYPZQ2cBns1jq1rrMRcArj9WjRpNYbfdqMKNleys9N/wLxM4dYiDmk+qQx
         WHC5xdZM5kLc0DGzSOGwm+L5rRxosBG03bnwU9+SOdxYNKS3LazWxUsYQcfvZS7LFvvi
         94qYk1vNmZIdqdlm68PkwgojoMGZvekl0nTXsinXg2nwb5DYs5MfrhZp0w6Onzy7+MoT
         9MvTplUDfLn/rNoujNaF1hQdEJtR8BUqzV0l+vRheBMMYLq2P2hfMbEoidG4z3IejxPT
         f28A==
X-Gm-Message-State: AMke39nTuv3H9w7WWCc3qn2a8Mh7Gy6otv9X8rGzVoeO3ZkND9cZcgSwMRhorP15apgcTA==
X-Received: by 10.99.177.6 with SMTP id r6mr27162476pgf.61.1486999280155;
        Mon, 13 Feb 2017 07:21:20 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id s65sm15455777pgb.64.2017.02.13.07.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:21:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:21:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/11] refs: split and make get_*_ref_store() public API
Date:   Mon, 13 Feb 2017 22:20:11 +0700
Message-Id: <20170213152011.12050-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 59 ++++++++++++++++++++++++++++++----------------------
 refs.h               | 13 ++++++++++++
 refs/files-backend.c |  2 +-
 refs/refs-internal.h | 12 -----------
 4 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/refs.c b/refs.c
index 9ac194945..48350da87 100644
--- a/refs.c
+++ b/refs.c
@@ -1160,7 +1160,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 static int do_for_each_ref(const char *submodule, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(submodule);
+	struct ref_store *refs = get_submodule_ref_store(submodule);
 	struct ref_iterator *iter;
 
 	if (!refs)
@@ -1304,7 +1304,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->init_db(refs, err);
 }
@@ -1312,7 +1312,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_ref_store(NULL), refname,
+	return resolve_ref_recursively(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1333,10 +1333,10 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 		/* We need to strip off one or more trailing slashes */
 		char *stripped = xmemdupz(submodule, len);
 
-		refs = get_ref_store(stripped);
+		refs = get_submodule_ref_store(stripped);
 		free(stripped);
 	} else {
-		refs = get_ref_store(submodule);
+		refs = get_submodule_ref_store(submodule);
 	}
 
 	if (!refs)
@@ -1491,15 +1491,24 @@ static struct ref_store *init_submodule_ref_store(const char *path)
 	return refs;
 }
 
-struct ref_store *get_ref_store(const char *submodule)
+struct ref_store *get_main_ref_store(void)
 {
 	struct ref_store *refs;
 
-	if (!submodule || !*submodule) {
-		refs = lookup_ref_store(NULL);
+	refs = lookup_ref_store(NULL);
 
-		if (!refs)
-			refs = ref_store_init(NULL, NULL);
+	if (!refs)
+		refs = ref_store_init(NULL, NULL);
+
+	return refs;
+}
+
+struct ref_store *get_submodule_ref_store(const char *submodule)
+{
+	struct ref_store *refs;
+
+	if (!submodule || !*submodule) {
+		return get_main_ref_store();
 	} else {
 		refs = lookup_ref_store(submodule);
 
@@ -1519,14 +1528,14 @@ void base_ref_store_init(struct ref_store *refs,
 /* backend functions */
 int pack_refs(unsigned int flags)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->pack_refs(refs, flags);
 }
 
 int peel_ref(const char *refname, unsigned char *sha1)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->peel_ref(refs, refname, sha1);
 }
@@ -1534,7 +1543,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_symref(refs, ref_target, refs_heads_master,
 				       logmsg);
@@ -1543,7 +1552,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1553,14 +1562,14 @@ int verify_refname_available(const char *refname,
 			     const struct string_list *skip,
 			     struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
 }
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 	struct ref_iterator *iter;
 
 	iter = refs->be->reflog_iterator_begin(refs);
@@ -1571,7 +1580,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent_reverse(refs, refname,
 						     fn, cb_data);
@@ -1580,14 +1589,14 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
 			void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
 }
 
 int reflog_exists(const char *refname)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_exists(refs, refname);
 }
@@ -1595,14 +1604,14 @@ int reflog_exists(const char *refname)
 int safe_create_reflog(const char *refname, int force_create,
 		       struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_reflog(refs, refname, force_create, err);
 }
 
 int delete_reflog(const char *refname)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->delete_reflog(refs, refname);
 }
@@ -1614,7 +1623,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_expire(refs, refname, sha1, flags,
 				       prepare_fn, should_prune_fn,
@@ -1624,21 +1633,21 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
 
 int delete_refs(struct string_list *refnames, unsigned int flags)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->delete_refs(refs, refnames, flags);
 }
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->rename_ref(refs, oldref, newref, logmsg);
 }
diff --git a/refs.h b/refs.h
index 694784391..f5fba16c8 100644
--- a/refs.h
+++ b/refs.h
@@ -553,4 +553,17 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 int ref_storage_backend_exists(const char *name);
 
+/*
+ * Return the ref_store instance for the specified submodule. For the
+ * main repository, use submodule==NULL; such a call cannot fail. For
+ * a submodule, the submodule must exist and be a nonbare repository,
+ * otherwise return NULL. If the requested reference store has not yet
+ * been initialized, initialize it first.
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+struct ref_store *get_submodule_ref_store(const char *submodule);
+struct ref_store *get_main_ref_store(void);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2fb270b6f..eab156733 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3116,7 +3116,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), "set_head_symref");
+		files_downcast(get_main_ref_store(), "set_head_symref");
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d7112770d..cb6882779 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -634,18 +634,6 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
-/*
- * Return the ref_store instance for the specified submodule. For the
- * main repository, use submodule==NULL; such a call cannot fail. For
- * a submodule, the submodule must exist and be a nonbare repository,
- * otherwise return NULL. If the requested reference store has not yet
- * been initialized, initialize it first.
- *
- * For backwards compatibility, submodule=="" is treated the same as
- * submodule==NULL.
- */
-struct ref_store *get_ref_store(const char *submodule);
-
 const char *resolve_ref_recursively(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
-- 
2.11.0.157.gd943d85

