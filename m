Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC6CE79D0
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjITNDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjITNC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:02:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F5AB
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso34477935e9.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214971; x=1695819771; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx4pAg2r7pkgYgatgoXWRbqkikXadcTJuE8EVrZn++4=;
        b=cQeWeBM1SRL/RaEp5pQwpY0pIqWIlFrOnecs7w9UMdYTN03GMBaOXkeOW0fQ7sFB1r
         R0iB/oq8PkD24cwZdpRgGYvnnGTuRHKSzseNltd+Y+1w9ZKR4fFH/Wqn9lK4Tk5DU0fb
         ExxeyEiOuboPlyH9K+IjhraucX/ZXr8BKKU+JoyeH3LXNyQt55e6r4umLFPb+NPC8EHe
         qq1I3S6p2JTZm7CAGiV6H+60g53Y6EZV2vvI0wHwYl0+S7zQMsuDUZSNTnejwzAJjGuP
         MMnQ7DJkeUNb2S+DlNxd56AXI98P2ysZAigvuOUd/Y4kkk7lc8XdEELbcSkqfqp0yDYr
         BdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214971; x=1695819771;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sx4pAg2r7pkgYgatgoXWRbqkikXadcTJuE8EVrZn++4=;
        b=LP59KN7Vc82rciZfwaUZbebrSjtxql7G+QAVZbrTwcZpLWri1mMrJwFxzS5cbnlr8j
         l3bfiiQ7BOPbMKCG8ANSy+2uoxetITXTZtxs/3sk1G5klyX1/5SEWHlq9At5UXT+UFaB
         5TG9+EfIcxWOhncPcmbVTtVrZsOLJDyG3O+4d80LqDArT3TO0FoncObmjRkHtysobKw1
         aG9jhW1Ou1IHbB2GH6XuSfp2F7E3BxsKEP2/S9wSYQ3pEgBa0wL40TVh/Rho0cMBQUiP
         pxS3ZGr+sDlBX4FS79XorasG3IL7GAZmc8JPF/KIypzR4nbBxUH3htAxn89ylx7ISRGu
         vEJQ==
X-Gm-Message-State: AOJu0YyHKiK6pqjSzY3IwLy0PzoOsiuKItRkS6fxSjjo9lcfcbih2+q9
        p/O/GlOti9KRIEBMSmfsBvEWvRN2HTU=
X-Google-Smtp-Source: AGHT+IGxtPGXBI1vBG3gMwi1pNpHxeNwaw2hFcHpcgpxwb9w2hIbQ9f3KjQM8O7KroOlXSxlKUaK2g==
X-Received: by 2002:a7b:c45a:0:b0:402:ea96:c09a with SMTP id l26-20020a7bc45a000000b00402ea96c09amr2324338wmi.16.1695214971088;
        Wed, 20 Sep 2023 06:02:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c00c100b003fe0a0e03fcsm1920827wmm.12.2023.09.20.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:50 -0700 (PDT)
Message-ID: <e99f3d2005633921299d4ee47f8c05b6f7e9391b.1695214968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:43 +0000
Subject: [PATCH v2 1/6] refs: construct transaction using a _begin callback
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

This prepares for taking locks on constructing the transaction.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                | 8 +++-----
 refs/debug.c          | 8 ++++++++
 refs/files-backend.c  | 8 ++++++++
 refs/packed-backend.c | 9 +++++++++
 refs/refs-internal.h  | 4 ++++
 5 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index fcae5dddc60..f7ba3e56284 100644
--- a/refs.c
+++ b/refs.c
@@ -1129,11 +1129,9 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 						    struct strbuf *err)
 {
-	struct ref_transaction *tr;
-	assert(err);
-
-	CALLOC_ARRAY(tr, 1);
-	tr->ref_store = refs;
+	struct ref_transaction *tr = refs->be->transaction_begin(refs, err);
+	if (tr)
+		tr->ref_store = refs;
 	return tr;
 }
 
diff --git a/refs/debug.c b/refs/debug.c
index b7ffc4ce67e..95fb3eb4430 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -41,6 +41,13 @@ static int debug_init_db(struct ref_store *refs, struct strbuf *err)
 	return res;
 }
 
+static struct ref_transaction *debug_transaction_begin(struct ref_store *ref_store,
+						       struct strbuf *err) {
+	struct ref_transaction *tr;
+	CALLOC_ARRAY(tr, 1);
+	return tr;
+}
+
 static int debug_transaction_prepare(struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
@@ -451,6 +458,7 @@ struct ref_storage_be refs_be_debug = {
 	 * has a function we should also have a wrapper for it here.
 	 * Test the output with "GIT_TRACE_REFS=1".
 	 */
+	.transaction_begin = debug_transaction_begin,
 	.transaction_prepare = debug_transaction_prepare,
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 341354182bb..d83eea8b408 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2681,6 +2681,13 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
+static struct ref_transaction *files_transaction_begin(struct ref_store *ref_store,
+						       struct strbuf *err) {
+	struct ref_transaction *tr;
+	CALLOC_ARRAY(tr, 1);
+	return tr;
+}
+
 static int files_transaction_prepare(struct ref_store *ref_store,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
@@ -3297,6 +3304,7 @@ struct ref_storage_be refs_be_files = {
 	.name = "files",
 	.init = files_ref_store_create,
 	.init_db = files_init_db,
+	.transaction_begin = files_transaction_begin,
 	.transaction_prepare = files_transaction_prepare,
 	.transaction_finish = files_transaction_finish,
 	.transaction_abort = files_transaction_abort,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 59c78d7941f..4f5b1025605 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1580,6 +1580,14 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
+
+static struct ref_transaction *packed_transaction_begin(struct ref_store *ref_store,
+							struct strbuf *err) {
+	struct ref_transaction *tr;
+	CALLOC_ARRAY(tr, 1);
+	return tr;
+}
+
 static int packed_transaction_prepare(struct ref_store *ref_store,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err)
@@ -1758,6 +1766,7 @@ struct ref_storage_be refs_be_packed = {
 	.name = "packed",
 	.init = packed_ref_store_create,
 	.init_db = packed_init_db,
+	.transaction_begin = packed_transaction_begin,
 	.transaction_prepare = packed_transaction_prepare,
 	.transaction_finish = packed_transaction_finish,
 	.transaction_abort = packed_transaction_abort,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9db8aec4da8..0a15e8a2ac8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -531,6 +531,9 @@ typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
+typedef struct ref_transaction *ref_transaction_begin_fn(struct ref_store *refs,
+							 struct strbuf *err);
+
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
 				       struct strbuf *err);
@@ -670,6 +673,7 @@ struct ref_storage_be {
 	ref_store_init_fn *init;
 	ref_init_db_fn *init_db;
 
+	ref_transaction_begin_fn *transaction_begin;
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
 	ref_transaction_abort_fn *transaction_abort;
-- 
gitgitgadget

