Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FFC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiCQR3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiCQR24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:28:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223791CAF18
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h15so8330613wrc.6
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbWOcrdeVMI55M4RK7hpmNMMjGL7XRaeJVrRZFRTQDk=;
        b=PAO6ZzaqvKFvYlrBZqvOTarJlYLJQWIYGlF65dxas2tN5em7THlcJ2x+MUvBge3xOn
         ZRxIjz0atgJ4ahvJm1S7xD68caOcl9GODpPZ97M92+2i/CbG7kyFZd/ZHWekqNgXgjpD
         iKs2uvzFy6XhEGy0EPShqF4bfHuiv3VWj+0HmovnlPN/Vn0AgXBCgZwWd5qeNpP60XKX
         o3fB4w4RwtibIX1NvuPCA9ZvRjOVRlYXGq06A6dqEX3Pt42gTefSS49B/32r2LggLf2D
         G/yw+b83c7ywtwZ0M6kAdYjrXXzBHl+hoa9IqzRd02ynfJHFgqtzXkQMb+rAObh5R1e4
         OuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbWOcrdeVMI55M4RK7hpmNMMjGL7XRaeJVrRZFRTQDk=;
        b=uGWtXn0VePFt7Qo94NETDUEOCxAUwQyNkfDZ6FdTz3w2Q9IlRkFJ/ZlAFQWgyBgiHi
         8EOkQSqJ8jDe4/kU0b3FCqYC5ocjmoCyKuRxNABoQIX4RWl8j4I8QEXPrsq95v8PQYJ2
         sqUpYUsi03yCWhGxQg54ohur9dgOZ4hKXScat+KMxuOYkPMTcOEy5VTDrE+6RuoYN62n
         j0O5jJ+LHAkcevFv9PkSpyWPzRzcgiYlzhFtAMmVsqINIcaa4KZlKsaWqXrWn+RLK/Y8
         ftU7T9dYhnKLjuyFMPIzQrdypAZPOUYP4piAuItq+aSAq9c/AA4zz3C6do/tKJeb2Ex1
         WAQw==
X-Gm-Message-State: AOAM5301j9FwjCZ7RPZ/2y3wDZFbJ9h/VLPL34ZioU0Y6iVcufYVy8rQ
        OxVeq8cIKANa/ZPcYoHXOR900U7r2ORJwg==
X-Google-Smtp-Source: ABdhPJzrfjnDxHFpp8qlLtUs/pldIbvF00HnaA5xVkfEHRBdvPLy9LOe3YvR56mBwDe1iVfwx7fYXA==
X-Received: by 2002:a05:6000:1ace:b0:203:d45b:fbce with SMTP id i14-20020a0560001ace00b00203d45bfbcemr4908266wry.673.1647538057405;
        Thu, 17 Mar 2022 10:27:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm4690693wrw.91.2022.03.17.10.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:27:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] packed-backend: remove stub BUG(...) functions
Date:   Thu, 17 Mar 2022 18:27:18 +0100
Message-Id: <patch-4.5-c9a7004bc38-20220317T171618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the stub BUG(...) functions previously used by the "struct
ref_storage_be refs_be_packed" backend.

We never call any functions in the packed backend by using it as a
"normal" primary ref store, instead we'll always initialize a "files"
backend ref-store.

It will then via the "packed_ref_store" member of "struct
files_ref_store" call selected functions in the "packed" backend, and
we'll in addition call others via wrappers in refs.c.

So while these would arguably give us *slightly* more meaningful error
messages we'll NULL the missing members in the initializer anyway, so
we'll reliably get a segfault if we're ever changing the backend and
having it call something it doesn't have.

So there's no need for this verbose boilerplate, and as shown in a
subsequent commit it might even lead to some confusion about the
packed backend being a "real" backend. Let's make it clear that it's
not.

As an aside, this also fixes a warning emitted by SunCC in at least
versions 12.5 and 12.6 of Oracle Developer Studio:

    "refs/packed-backend.c", line 1599: warning: Function has no return statement : packed_create_symref
    "refs/packed-backend.c", line 1606: warning: Function has no return statement : packed_rename_ref)
    "refs/packed-backend.c", line 1613: warning: Function has no return statement : packed_copy_ref
    "refs/packed-backend.c", line 1648: warning: Function has no return statement : packed_create_reflog

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/packed-backend.c | 88 +++++--------------------------------------
 1 file changed, 9 insertions(+), 79 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 03002451f15..310c2a72026 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1591,81 +1591,11 @@ static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	return 0;
 }
 
-static int packed_create_symref(struct ref_store *ref_store,
-			       const char *refname, const char *target,
-			       const char *logmsg)
-{
-	BUG("packed reference store does not support symrefs");
-}
-
-static int packed_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	BUG("packed reference store does not support renaming references");
-}
-
-static int packed_copy_ref(struct ref_store *ref_store,
-			   const char *oldrefname, const char *newrefname,
-			   const char *logmsg)
-{
-	BUG("packed reference store does not support copying references");
-}
-
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	return empty_ref_iterator_begin();
 }
 
-static int packed_for_each_reflog_ent(struct ref_store *ref_store,
-				      const char *refname,
-				      each_reflog_ent_fn fn, void *cb_data)
-{
-	BUG("packed reference store does not support reflogs");
-	return 0;
-}
-
-static int packed_for_each_reflog_ent_reverse(struct ref_store *ref_store,
-					      const char *refname,
-					      each_reflog_ent_fn fn,
-					      void *cb_data)
-{
-	BUG("packed reference store does not support reflogs");
-	return 0;
-}
-
-static int packed_reflog_exists(struct ref_store *ref_store,
-			       const char *refname)
-{
-	BUG("packed reference store does not support reflogs");
-	return 0;
-}
-
-static int packed_create_reflog(struct ref_store *ref_store,
-				const char *refname, struct strbuf *err)
-{
-	BUG("packed reference store does not support reflogs");
-}
-
-static int packed_delete_reflog(struct ref_store *ref_store,
-			       const char *refname)
-{
-	BUG("packed reference store does not support reflogs");
-	return 0;
-}
-
-static int packed_reflog_expire(struct ref_store *ref_store,
-				const char *refname,
-				unsigned int flags,
-				reflog_expiry_prepare_fn prepare_fn,
-				reflog_expiry_should_prune_fn should_prune_fn,
-				reflog_expiry_cleanup_fn cleanup_fn,
-				void *policy_cb_data)
-{
-	BUG("packed reference store does not support reflogs");
-	return 0;
-}
-
 struct ref_storage_be refs_be_packed = {
 	.next = NULL,
 	.name = "packed",
@@ -1677,20 +1607,20 @@ struct ref_storage_be refs_be_packed = {
 	.initial_transaction_commit = packed_initial_transaction_commit,
 
 	.pack_refs = packed_pack_refs,
-	.create_symref = packed_create_symref,
+	.create_symref = NULL,
 	.delete_refs = packed_delete_refs,
-	.rename_ref = packed_rename_ref,
-	.copy_ref = packed_copy_ref,
+	.rename_ref = NULL,
+	.copy_ref = NULL,
 
 	.iterator_begin = packed_ref_iterator_begin,
 	.read_raw_ref = packed_read_raw_ref,
 	.read_symbolic_ref = NULL,
 
 	.reflog_iterator_begin = packed_reflog_iterator_begin,
-	.for_each_reflog_ent = packed_for_each_reflog_ent,
-	.for_each_reflog_ent_reverse = packed_for_each_reflog_ent_reverse,
-	.reflog_exists = packed_reflog_exists,
-	.create_reflog = packed_create_reflog,
-	.delete_reflog = packed_delete_reflog,
-	.reflog_expire = packed_reflog_expire
+	.for_each_reflog_ent = NULL,
+	.for_each_reflog_ent_reverse = NULL,
+	.reflog_exists = NULL,
+	.create_reflog = NULL,
+	.delete_reflog = NULL,
+	.reflog_expire = NULL,
 };
-- 
2.35.1.1384.g7d2906948a1

