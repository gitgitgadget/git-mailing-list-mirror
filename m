Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F324C2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdCRCFs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35056 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdCRCFi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so12084458pge.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGL68L5lyractkQ7KuDg2+AXUXrEoXhCrvXsKLePEds=;
        b=HzuaBVj/C3vNsc0s8ri1y4kQseut9K0JWMZW5dNX8kW4XtHVvRKtIgjF9OEPTC1pSA
         txzEDkBqBs7JDWAuZ+ZZlSS2W504+mKqegox7sXeyx0AwECcjzALmmNChLvnr4dgAIM7
         SU/7gCa2XYkqkP3BhcTfbdRqB9I13gAbG1JO2m9w9wZEXZj2mpnVjWTSJjtTJQcWlavS
         gKrFwfRYplga2nIOlzEmEs6HrWjIZcC3WH8BYroIw2gy61RocDeAv+19ZISdF1GW5pza
         FEz8+gQd2qm3KJn2ldElvsv/cl2hPutc65DZqo8Z2IQ2tQGhjZlWL3CjhkWeeY0Nl7Bg
         oqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGL68L5lyractkQ7KuDg2+AXUXrEoXhCrvXsKLePEds=;
        b=kmMFY4iEmsvjHPaHj5JIvIWTBZEPs+yySpzwZDSpAmlbsod5i3HBE73Siheb0OaWp+
         TxYHZQ7Xc8NJsA24GWlpe7911ANKklH+H+irsbH3U1vcvH3OHzAV7lSE9tWNW6Hl41us
         jzcknxWZLVHfFQsShvS/U4/ey9HyyDSrAJ7HQRarbup8Bk2FeDW0bCmViyGhQfuDJBGZ
         wjyLhVTwVr9y/g2pZWBcXH01kmvYHz4OWkReHtJJA49mO7Zq37e6cpLUCmuIvWs6r7hH
         iPnqV7BJ4LVZ6NahUiyWlfsbxVqmaZjnFHpFWM7ZcRTNIMPshA32w2LD5admzI5XZofk
         teVQ==
X-Gm-Message-State: AFeK/H3URbXzMasbEfa39bL3wu+a8EDSf75/tVasPSEw7IGqrFwLCDXTYoSyNCHdDE7tcA==
X-Received: by 10.99.143.18 with SMTP id n18mr14185212pgd.12.1489802736766;
        Fri, 17 Mar 2017 19:05:36 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id 185sm19094383pfg.13.2017.03.17.19.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:30 +0700
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
Subject: [PATCH v6 15/27] refs.c: make get_main_ref_store() public and use it
Date:   Sat, 18 Mar 2017 09:03:25 +0700
Message-Id: <20170318020337.22767-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
index 11c460c5e9..404d3b62b5 100644
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
 
@@ -1491,14 +1491,14 @@ void base_ref_store_init(struct ref_store *refs,
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
@@ -1506,7 +1506,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->create_symref(refs, ref_target, refs_heads_master,
 				       logmsg);
@@ -1515,7 +1515,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1525,14 +1525,14 @@ int verify_refname_available(const char *refname,
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
@@ -1543,7 +1543,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->for_each_reflog_ent_reverse(refs, refname,
 						     fn, cb_data);
@@ -1552,14 +1552,14 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
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
@@ -1567,14 +1567,14 @@ int reflog_exists(const char *refname)
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
@@ -1586,7 +1586,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	struct ref_store *refs = get_ref_store(NULL);
+	struct ref_store *refs = get_main_ref_store();
 
 	return refs->be->reflog_expire(refs, refname, sha1, flags,
 				       prepare_fn, should_prune_fn,
@@ -1596,21 +1596,21 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 2d6b6263fc..a6cd12267f 100644
--- a/refs.h
+++ b/refs.h
@@ -2,6 +2,7 @@
 #define REFS_H
 
 struct object_id;
+struct ref_store;
 struct strbuf;
 struct string_list;
 
@@ -560,4 +561,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 
 int ref_storage_backend_exists(const char *name);
 
+struct ref_store *get_main_ref_store(void);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 43d8ddac93..351934d36e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3166,7 +3166,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target, const char
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
+		files_downcast(get_main_ref_store(), 0, "set_head_symref");
 
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
-- 
2.11.0.157.gd943d85

