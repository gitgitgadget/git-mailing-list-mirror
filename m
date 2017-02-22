Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9C1201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932726AbdBVOH3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36483 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbdBVOHP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so541357pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENTbTklqkoCTnUKq4MLBURoduRyvYCU8zZmCnDOp8p4=;
        b=N5GQagML+pwFGxT/PTZYLEvgcFvPojAjy9r/j89ks8ckfv2frq0NRXaGp1Ol7pXpj7
         8KtH+yiLpjjqdXn1hSpPejD+4GiM1gUu35+kDoWvtPhraBmgRCnO8wNP1RPNxQnwUMVi
         AxfsUgH3IfnsR5457BgfU70g8CFARof3DrjOFYK3zR6VsBAlpWetGFSzmEq2F9aD0itp
         jz50aYf4b2Be1D58Y8PygDpSkXPHpKxXrG/LVETE3ucRmg0f9hYcfj3gBWp6crzxge38
         1JVpSlmYhPCcjM7dAzrCsrVOBRuKjm5VaNyaqE+zy5QeSuk+X2eMyXGOKMq77LoMahKA
         rBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENTbTklqkoCTnUKq4MLBURoduRyvYCU8zZmCnDOp8p4=;
        b=XS+SSYa6pFARvfyLvfhP+SRg/E5HmX9O5G6YmDpmi4dmLvhG8d71ApFjRkBgy9/2ZK
         Tb5UlAv/1+DfyH4R2HeedB/8pi6gbfwNCEBFYUZmds8CuV8hH7YdXJe7Thirl8peRfXQ
         7FCGZ4G1/gKmD3zoEWx8404dnivYgVvhDabrZGxxEaoUJJ2Guh6KBZyVoP3QdDZCqIzM
         mytYkp/ecVCUDMWhBxCOrvRYMPgQzrH+70rnd0/FpFh+Wsgdap533ql8hxxiqlv9ugXF
         tUbslfbBItHrjPpNG56MCmlLOkrqLcj/qtZv513ccISi9pq4mP146YXpytzOeYrpfDoz
         AovA==
X-Gm-Message-State: AMke39l0y3qvuglrrEAYSwtTzxnESyt7KEDdQ0FpgMLCmP1immLA5Hsa781mXhTJzxVFCQ==
X-Received: by 10.98.104.4 with SMTP id d4mr2077799pfc.2.1487772429601;
        Wed, 22 Feb 2017 06:07:09 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id a77sm286099pfl.91.2017.02.22.06.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:02 +0700
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
Subject: [PATCH v5 13/24] refs.c: make get_main_ref_store() public and use it
Date:   Wed, 22 Feb 2017 21:04:39 +0700
Message-Id: <20170222140450.30886-14-pclouds@gmail.com>
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

get_ref_store() will soon be renamed to get_submodule_ref_store().
Together with future get_worktree_ref_store(), the three functions
provide an appropriate ref store for different operation modes. New APIs
will be added to operate directly on ref stores.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 36 ++++++++++++++++++------------------
 refs.h               |  3 +++
 refs/files-backend.c |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 6adc38e42..562834fc0 100644
--- a/refs.c
+++ b/refs.c
@@ -1314,7 +1314,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->init_db(refs, err);
 }
@@ -1322,7 +1322,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
-	return resolve_ref_recursively(get_ref_store(NULL), refname,
+	return resolve_ref_recursively(get_main_ref_store(), refname,
 				       resolve_flags, sha1, flags);
 }
 
@@ -1428,7 +1428,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
-static struct ref_store *get_main_ref_store(void)
+struct ref_store *get_main_ref_store(void)
 {
 	struct ref_store *refs;
 
@@ -1494,14 +1494,14 @@ void base_ref_store_init(struct ref_store *refs,
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
@@ -1509,7 +1509,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_symref(refs, ref_target, refs_heads_master,
 				       logmsg);
@@ -1518,7 +1518,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1528,14 +1528,14 @@ int verify_refname_available(const char *refname,
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
@@ -1546,7 +1546,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent_reverse(refs, refname,
 						     fn, cb_data);
@@ -1555,14 +1555,14 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
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
@@ -1570,14 +1570,14 @@ int reflog_exists(const char *refname)
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
@@ -1589,7 +1589,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_expire(refs, refname, sha1, flags,
 				       prepare_fn, should_prune_fn,
@@ -1599,21 +1599,21 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index c494b641a..29013cb7e 100644
--- a/refs.h
+++ b/refs.h
@@ -2,6 +2,7 @@
 #define REFS_H
 
 struct object_id;
+struct ref_store;
 struct ref_transaction;
 struct strbuf;
 struct string_list;
@@ -559,4 +560,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 int ref_storage_backend_exists(const char *name);
 
+struct ref_store *get_main_ref_store(void);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a390eaadf..d80c27837 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3165,7 +3165,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
+		files_downcast(get_main_ref_store(), 0, "set_head_symref");
 
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
-- 
2.11.0.157.gd943d85

