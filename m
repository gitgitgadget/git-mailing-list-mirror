Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64DFCE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjITNDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjITNDB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB992
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4051f8e1ba0so10286325e9.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214973; x=1695819773; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np2dYf0WO4fHqgkBJzDV6cHKAMI95yduZgkBP3OUP00=;
        b=IyiWlFeqVrDtdIbJGz51xE4crZWbiretle4VTKgvrDZkbIBVVS3EF3+UfedGQJArho
         hWntucKgjQNJFFNqJTB9K8Hv5wJ+mrys0Sh8IxQTHaqDSpJnT20F4JYTl6U1yad0fahj
         2Kcs53UXBWmja9PhuCzeyFJvYLJK42SwtxUnM9AMBPPEQIr2Zl2F8hT/H0J6iLUDMXZl
         VlToDB8CP4LEsKfF+l56+B8/F5hyQBnvBsz2BRTUz3vKpz5fyt8MHl7ri41TyiByKQYC
         CYQCW/IuF2Uv0JrtDm9IniIzjisRh+nhhrETKMCPN1axp6qI/PK0zywww/hbWKu7t9UJ
         6TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214973; x=1695819773;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Np2dYf0WO4fHqgkBJzDV6cHKAMI95yduZgkBP3OUP00=;
        b=nzQhb0/yWggkmdn/26SaNn48STRG07+5ESNtBpVR8Fs8DItnS9/suDKrrjb59Jux47
         sE6zNRJs+M5L/GIXIIiVGCX8SDr+g63lIBerlny77eygfboJ7hpMlAA5yXJXz4R3PWuR
         iWcY9UnMuYCqER1rRwF2A3jAX/rLQ7bx4g7LC2MlpvsfoJ3pKinrlbfEfN67UIlYfLCg
         aW4XSe3f9AGBLLXu7z+Zg1ym7UgbtwtW6pJRAfmmkfDlUxBbW0PONK0477q3Vbi+sBnx
         +X3dPzm7nyQ0l4JcpKc+zAQoR1MBVVUP25WZ4ul+GWLJoceyIZlbpHTTHg/6o9Upqg1c
         p6/w==
X-Gm-Message-State: AOJu0YyZ1aJDCmYGSu587QguB2FqMz7423uIxohy7ISNXrpwNVswxQso
        0Rx2XRxdqrlxtaRFRWagwRPkksGZqiA=
X-Google-Smtp-Source: AGHT+IFhfn5Zqeelm5loWFg7nAe/849OqJ5hDdx4svqijnh9pBXy/Vr9xQ5vxjdvWFjbUsAEekGRvw==
X-Received: by 2002:a05:600c:2194:b0:3f9:b244:c294 with SMTP id e20-20020a05600c219400b003f9b244c294mr2261387wme.35.1695214971997;
        Wed, 20 Sep 2023 06:02:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0031ad5fb5a0fsm10184926wrt.58.2023.09.20.06.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:51 -0700 (PDT)
Message-ID: <9a459259330515d5b127e141c007ebc01d124428.1695214968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:44 +0000
Subject: [PATCH v2 2/6] refs: wrap transaction in a debug-specific transaction
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This ensures that all transaction methods are properly printed. This is
needed because the callbacks are called as
transaction->ref_store->backend->$CALLBACK.

Originally, there was a hacky workaround which overwrote
transaction->ref_store before passing it into the non-debug prepare()
callback. This would print something for the prepare function, but not
for abort/finish functions.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 83 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 95fb3eb4430..30509da4b89 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -43,25 +43,18 @@ static int debug_init_db(struct ref_store *refs, struct strbuf *err)
 
 static struct ref_transaction *debug_transaction_begin(struct ref_store *ref_store,
 						       struct strbuf *err) {
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	struct ref_transaction *tr;
+	struct ref_transaction *sub_tr = ref_store_transaction_begin(drefs->refs, err);
+	trace_printf_key(&trace_refs, "transaction_begin: %s\n", err->buf);
+	if (!sub_tr) {
+		return NULL;
+	}
 	CALLOC_ARRAY(tr, 1);
+	tr->backend_data = sub_tr;
 	return tr;
 }
 
-static int debug_transaction_prepare(struct ref_store *refs,
-				     struct ref_transaction *transaction,
-				     struct strbuf *err)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
-	int res;
-	transaction->ref_store = drefs->refs;
-	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
-						   err);
-	trace_printf_key(&trace_refs, "transaction_prepare: %d \"%s\"\n", res,
-			 err->buf);
-	return res;
-}
-
 static void print_update(int i, const char *refname,
 			 const struct object_id *old_oid,
 			 const struct object_id *new_oid, unsigned int flags,
@@ -77,20 +70,59 @@ static void print_update(int i, const char *refname,
 	type &= 0xf; /* see refs.h REF_* */
 	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
 		REF_FORCE_CREATE_REFLOG;
-	trace_printf_key(&trace_refs, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
+	trace_printf_key(&trace_refs, "  %d: '%s' %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
 		o, n, flags, type, msg);
 }
 
-static void print_transaction(struct ref_transaction *transaction)
+static void print_transaction(struct ref_transaction *transaction,
+			      const char *action,
+			      int res, struct strbuf *err)
 {
 	int i;
-	trace_printf_key(&trace_refs, "transaction {\n");
+	trace_printf_key(&trace_refs, "transaction %s {\n", action);
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *u = transaction->updates[i];
 		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
 			     u->type, u->msg);
 	}
-	trace_printf_key(&trace_refs, "}\n");
+	trace_printf_key(&trace_refs, "}: %d '%s'\n", res, err->buf);
+}
+
+static void copy_update(struct ref_update *dst,
+			struct ref_update *src) {
+	/* dst->refname is const char; can't assign structs */
+	dst->new_oid = src->new_oid;
+	dst->old_oid = src->old_oid;
+	dst->flags = src->flags;
+	dst->backend_data = NULL;
+	dst->type = src->type;
+	dst->msg = xstrdup(src->msg);
+	dst->parent_update = NULL;
+	/* refname is done as part of FLEX_ALLOC_STR. */
+}
+
+static int debug_transaction_prepare(struct ref_store *refs,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	struct ref_transaction *sub_transaction = transaction->backend_data;
+	int res;
+	int i;
+
+	ALLOC_GROW(sub_transaction->updates, transaction->nr, sub_transaction->alloc);
+	for (i = 0;  i < transaction->nr; i++) {
+		struct ref_update *up = transaction->updates[i];
+		struct ref_update *sub_up;
+		FLEX_ALLOC_STR(sub_up, refname, up->refname);
+		copy_update(sub_up, up);
+		sub_transaction->updates[i] = sub_up;
+	}
+	sub_transaction->nr = transaction->nr;
+	res = drefs->refs->be->transaction_prepare(drefs->refs, sub_transaction,
+						   err);
+	print_transaction(sub_transaction, "prepare", res, err);
+	return res;
 }
 
 static int debug_transaction_finish(struct ref_store *refs,
@@ -98,12 +130,11 @@ static int debug_transaction_finish(struct ref_store *refs,
 				    struct strbuf *err)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	struct ref_transaction *sub_transaction = transaction->backend_data;
 	int res;
-	transaction->ref_store = drefs->refs;
-	res = drefs->refs->be->transaction_finish(drefs->refs, transaction,
+	res = drefs->refs->be->transaction_finish(drefs->refs, sub_transaction,
 						  err);
-	print_transaction(transaction);
-	trace_printf_key(&trace_refs, "finish: %d\n", res);
+	print_transaction(sub_transaction, "finish", res, err);
 	return res;
 }
 
@@ -112,9 +143,11 @@ static int debug_transaction_abort(struct ref_store *refs,
 				   struct strbuf *err)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	struct ref_transaction *sub_transaction = transaction->backend_data;
 	int res;
 	transaction->ref_store = drefs->refs;
-	res = drefs->refs->be->transaction_abort(drefs->refs, transaction, err);
+	res = drefs->refs->be->transaction_abort(drefs->refs, sub_transaction, err);
+	print_transaction(sub_transaction, "abort", res, err);
 	return res;
 }
 
@@ -123,10 +156,12 @@ static int debug_initial_transaction_commit(struct ref_store *refs,
 					    struct strbuf *err)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	struct ref_transaction *sub_transaction = transaction->backend_data;
 	int res;
 	transaction->ref_store = drefs->refs;
 	res = drefs->refs->be->initial_transaction_commit(drefs->refs,
-							  transaction, err);
+							  sub_transaction, err);
+	print_transaction(sub_transaction, "commit", res, err);
 	return res;
 }
 
-- 
gitgitgadget

