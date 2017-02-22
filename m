Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7819201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbdBVOIC (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:08:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36147 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbdBVOIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:08:01 -0500
Received: by mail-pg0-f68.google.com with SMTP id z128so544684pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3sPippmSUGYYJ1rvIJ6WC2ka3V9BgD8kVMrUQ0dqhk=;
        b=BDov5a+pZvWtH5V83ihOsCaH/ep2xBKroJ4vUeugdJYbdaT/fgYnl1VoqATIEiMYrn
         y0HBvNa42fOowRdOwNgsmmlalz0k52d3IMHcFklkoPmshkYsZ2hs+vkz01IR4VhXtSzu
         pYO/KOW93aST8wne1mSLgRhiokIc1xLFgCrfU2ZLvoJiaoH4MwgYHsx3XdzyW8GrHEXc
         mUlZ7p7x9+v6crMxg6NOP2Ol73d5N8MONVD2SsDsZU05a3MhkUlLDT1g8Z1nPhxrK04H
         hyXKyjfg4KAryKsAVqcnFwbPpXv/icl96CJHsiId6i6EVxNnLbPiIPkT1m3DOEUnGsvs
         Y3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3sPippmSUGYYJ1rvIJ6WC2ka3V9BgD8kVMrUQ0dqhk=;
        b=DVQWY9AzcyYZaQIjLgnfg7NhhnDFoKSXiSM/Oh8xJihv/YexMkdvETkVUBrFWJP4ET
         BXJ5KWHnUwTKzVtBxVgedQUWsmdH/yIAAgFRtXbySLgkofZuiPcJvCFs5ZFBvEgZeswh
         2cJ36xriJwFnSnbOrL62E2wTAshGVp0MwVg2rXk2bVAYrFxGRdss8BpLUIhrcWgvzmkK
         cu0RicPHcucH2rMRXR9+rHx427ZhEZCIPMkqRVPGSC2gU1zScU9fJObUxuYk02rwIIIE
         uoHtYCU5yALI852GDNwV0OEth8Uch8DZkWrY4UHUkVuTrkYH9PGGJQh3z/HWV5h12s3t
         +HJQ==
X-Gm-Message-State: AMke39maIseSx2vdDZHXFEzcvih8wUScvB/ygaAS1qhuO3qtn45LUPo/VFiJ7wigpnnxSg==
X-Received: by 10.98.10.216 with SMTP id 85mr25420560pfk.3.1487772480556;
        Wed, 22 Feb 2017 06:08:00 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m21sm4156455pgh.4.2017.02.22.06.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:53 +0700
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
Subject: [PATCH v5 19/24] refs: new transaction related ref-store api
Date:   Wed, 22 Feb 2017 21:04:45 +0700
Message-Id: <20170222140450.30886-20-pclouds@gmail.com>
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

The transaction struct now takes a ref store at creation and will
operate on that ref store alone.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++------------
 refs.h               |  8 ++++++++
 refs/refs-internal.h |  1 +
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 9137ac283..851b5e125 100644
--- a/refs.c
+++ b/refs.c
@@ -618,16 +618,19 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *old_sha1,
-	       unsigned int flags)
+int refs_delete_ref(struct ref_store *refs, const char *refname,
+		    const unsigned char *old_sha1,
+		    unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		assert(refs == get_main_ref_store());
 		return delete_pseudoref(refname, old_sha1);
+	}
 
-	transaction = ref_transaction_begin(&err);
+	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_sha1,
 				   flags, NULL, &err) ||
@@ -642,6 +645,13 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags)
+{
+	return refs_delete_ref(get_main_ref_store(), refname,
+			       old_sha1, flags);
+}
+
 int copy_reflog_msg(char *buf, const char *msg)
 {
 	char *cp = buf;
@@ -801,11 +811,20 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 	return 1;
 }
 
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err)
 {
+	struct ref_transaction *tr;
 	assert(err);
 
-	return xcalloc(1, sizeof(struct ref_transaction));
+	tr = xcalloc(1, sizeof(struct ref_transaction));
+	tr->ref_store = refs;
+	return tr;
+}
+
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+{
+	return ref_store_transaction_begin(get_main_ref_store(), err);
 }
 
 void ref_transaction_free(struct ref_transaction *transaction)
@@ -922,18 +941,20 @@ int update_ref_oid(const char *msg, const char *refname,
 		old_oid ? old_oid->hash : NULL, flags, onerr);
 }
 
-int update_ref(const char *msg, const char *refname,
-	       const unsigned char *new_sha1, const unsigned char *old_sha1,
-	       unsigned int flags, enum action_on_err onerr)
+int refs_update_ref(struct ref_store *refs, const char *msg,
+		    const char *refname, const unsigned char *new_sha1,
+		    const unsigned char *old_sha1, unsigned int flags,
+		    enum action_on_err onerr)
 {
 	struct ref_transaction *t = NULL;
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		assert(refs == get_main_ref_store());
 		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
 	} else {
-		t = ref_transaction_begin(&err);
+		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
 		    ref_transaction_update(t, refname, new_sha1, old_sha1,
 					   flags, msg, &err) ||
@@ -964,6 +985,15 @@ int update_ref(const char *msg, const char *refname,
 	return 0;
 }
 
+int update_ref(const char *msg, const char *refname,
+	       const unsigned char *new_sha1,
+	       const unsigned char *old_sha1,
+	       unsigned int flags, enum action_on_err onerr)
+{
+	return refs_update_ref(get_main_ref_store(), msg, refname, new_sha1,
+			       old_sha1, flags, onerr);
+}
+
 char *shorten_unambiguous_ref(const char *refname, int strict)
 {
 	int i;
@@ -1600,7 +1630,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	struct ref_store *refs = transaction->ref_store;
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
@@ -1719,7 +1749,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	struct ref_store *refs = transaction->ref_store;
 
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
diff --git a/refs.h b/refs.h
index 70d4eb87c..342cecd23 100644
--- a/refs.h
+++ b/refs.h
@@ -330,6 +330,9 @@ int reflog_exists(const char *refname);
  * exists, regardless of its old value. It is an error for old_sha1 to
  * be NULL_SHA1. flags is passed through to ref_transaction_delete().
  */
+int refs_delete_ref(struct ref_store *refs, const char *refname,
+		    const unsigned char *old_sha1,
+		    unsigned int flags);
 int delete_ref(const char *refname, const unsigned char *old_sha1,
 	       unsigned int flags);
 
@@ -414,6 +417,8 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
@@ -548,6 +553,9 @@ void ref_transaction_free(struct ref_transaction *transaction);
  * ref_transaction_update(). Handle errors as requested by the `onerr`
  * argument.
  */
+int refs_update_ref(struct ref_store *refs, const char *msg, const char *refname,
+		    const unsigned char *new_sha1, const unsigned char *old_sha1,
+		    unsigned int flags, enum action_on_err onerr);
 int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5f26208c2..690498698 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -200,6 +200,7 @@ enum ref_transaction_state {
  * as atomically as possible.  This structure is opaque to callers.
  */
 struct ref_transaction {
+	struct ref_store *ref_store;
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
-- 
2.11.0.157.gd943d85

