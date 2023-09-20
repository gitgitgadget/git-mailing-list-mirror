Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B0CE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjITNDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjITNDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6BD9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:03:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401ec23be82so73323745e9.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214978; x=1695819778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvnwH1d73BqygRjdJIWg0ni/cz6gniyXZB1jpR5fK00=;
        b=etRDObMp/yh1insEceuVTBaqCR3WD97bAj0yoW090iG1OQRrq2Xt3wIYpcr8ahDfpv
         Ri66ypwG6eFJZcukLkJLEYKNtVEyCfkdMF/+1luFTeqXS1agftDcB0uh7H3KvqeI15Z8
         D4Ah0CWHbFurnrmuXOdGO/KFiWPTUOpDWwLF8YU0/OUNj3YDT+TsdVsbg9PzedocUfQ4
         2shf5TdZU3M5zyYRTjXCDzL/RpRgK3cHGpV5oEsPZspAf1ADeNv6L5usP7npJUdnQE+s
         1IcchNTM1Yk3vaL5lZrC6F2zDyE2kVgDnqEebcLkUeYG8LHiwrNpntA5DvmgItNzQXV3
         bwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214978; x=1695819778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvnwH1d73BqygRjdJIWg0ni/cz6gniyXZB1jpR5fK00=;
        b=j3Yra9Eebyoeyod7Zt3ApC8BN0a7SGvtfSQuao+uyiDo4Lczs9w1yUiuOHX12kR7cQ
         u/6k0JsycEH1v2n5SzwgdLWn12N1UW5tU3pVtxQzmHOGVX9fw9fVG0jM1cj/bvvkgtGa
         uozHxmQFeFejZSs0owwJjzjdlDEVlArkIsZKWZwuWkIt/R6TdZquk3ISftXVjDF2Dxna
         aTD98nSnGtU4LTGpUIeQfHCF/XKtVKZNLmGnIwnPlFuqJCstZtw/8uJmi2Qg7/pyMzEO
         Vkdz4h2mDt2HFqbNwiQN1xpemN8LRlmJq+Voc5rT5qfK9jnUDqh00RRY6sROLqJ6mBlf
         5kOQ==
X-Gm-Message-State: AOJu0YxvHUaISFxen96MO5BVuFRxJHIuGUM5LnCtGz8J/69uJZcj8pZ6
        pXsmVjvomVR8M8q9+Nwe7mK3LYa5tGg=
X-Google-Smtp-Source: AGHT+IF01jVti56nUWYJNgqJF628gxDY21f0IhVCBP+eJBwG/0d6rWvkrDTPiGXdkcJI+dRxftFAFg==
X-Received: by 2002:a1c:4b19:0:b0:3fb:b5c0:a079 with SMTP id y25-20020a1c4b19000000b003fbb5c0a079mr2372395wma.21.1695214977950;
        Wed, 20 Sep 2023 06:02:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020adfe682000000b0031fe0576460sm8775079wrm.11.2023.09.20.06.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:57 -0700 (PDT)
Message-ID: <2cf743031abbbd3de94d98dc883dfc01f327aadc.1695214969.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:48 +0000
Subject: [PATCH v2 6/6] refs: always try to do packed transactions for
 reftable
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

Reftable updates are cheap (compared to packed-refs updates), so do them
always. This also helps exercise this code more in tests.

This should commit should not be merged currently. It fails 55 tests
when running with GIT_TEST_REFTABLE.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2cd596bbeba..0d61a18b4ba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2800,6 +2800,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
 	struct ref_transaction *packed_transaction = NULL;
+	int is_reftable = !strcmp(refs->packed_ref_store->be->name, "reftable");
 
 	assert(err);
 
@@ -2809,6 +2810,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	CALLOC_ARRAY(backend_data, 1);
 	transaction->backend_data = backend_data;
 
+	if (is_reftable) {
+		packed_transaction = ref_store_transaction_begin(
+			refs->packed_ref_store, err);
+		if (!packed_transaction) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto cleanup;
+		}
+		backend_data->packed_transaction = packed_transaction;
+	}
+
 	/*
 	 * Fail if a refname appears more than once in the
 	 * transaction. (If we end up splitting up any updates using
@@ -2881,9 +2892,9 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if (ret)
 			goto cleanup;
 
-		if (update->flags & REF_DELETING &&
-		    !(update->flags & REF_LOG_ONLY) &&
-		    !(update->flags & REF_IS_PRUNING)) {
+		if (is_reftable || (update->flags & REF_DELETING &&
+				    !(update->flags & REF_LOG_ONLY) &&
+				    !(update->flags & REF_IS_PRUNING))) {
 			/*
 			 * This reference has to be deleted from
 			 * packed-refs if it exists there.
@@ -2909,8 +2920,9 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	}
 
 	if (packed_transaction) {
-		backend_data->packed_transaction_needed = is_packed_transaction_needed(refs->packed_ref_store,
-										       packed_transaction);
+		backend_data->packed_transaction_needed = is_reftable ||
+			is_packed_transaction_needed(refs->packed_ref_store,
+						     packed_transaction);
 		if (backend_data->packed_transaction_needed) {
 			ret = ref_transaction_prepare(packed_transaction, err);
 			/*
-- 
gitgitgadget
