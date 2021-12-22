Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F77C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbhLVS46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbhLVS4q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1AFC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q16so6769515wrg.7
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7yeGXzd+HLokH3mIqMgC6QPxufo4Z99YCUN5bOC8N9I=;
        b=AlJ4s6VuUIBw28gTq8Z491wrrMbH2sSM6EP3y6gVVMTFcIWOV9oMuyF1hfdXGu84Ix
         yve3q+QScKuUTdEXMjoImo1zTcxash3yvWvBdv2zYLAJnmtDAi6mBWy0cEnTjcXpPRcd
         u/CMsjbjNYEUb58mnmBHrfmY0XU8X3SXQDbx9AM8oaCk0E0xbCOKUjPA89NLy09/izNW
         xaqAazF4Tfp1DS2+qLuafWllIDaWhEP9Kx5hQ2oWYklkSlyBmNi/Intrgq4+IWXosG8F
         aLCJz3J3mvxoSl8yy3kpav/PnJHO7aWrYWjH6IBe1giQjS3N3JqBDiWoJVeheimIBN7O
         kudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7yeGXzd+HLokH3mIqMgC6QPxufo4Z99YCUN5bOC8N9I=;
        b=timXKxQTOvKw5OquYpvdIumF+qFsc3TyDGaBoS+5tKVEclrk0FElezwlhXMaXPudq8
         7NWWn+C2DfNTVHFlmopPhhhiM/Y8GCPTHnDCmywRI6UJSi/v0egLNLeB3MS9kNfOZWW5
         Xa71fT8p2Zk/7mtn649XtJNOZiqGVpqwxP4PSQeJeaOJV2TbkBe3sQOqPOcgXN0hSfTZ
         P9czqT85FRK/l+Ns+0OEhMUKZLIic0htTgT2lYSw2EUE1W18VcRPrXy7D5kYGJAt3FXB
         ounU6Fmo1A6S9QDSl5rffBfTYKGZmZ+XpvykG3XYpeV5e6oAO/F0Je2Y+mQi0urZBAk6
         J0Xg==
X-Gm-Message-State: AOAM532ROHI674cwdTCfSBLhYcnpoExBHNFoDkRd0iVXEIDlMCSNASKi
        F5kGoO1UmN5hy03jdWBhGldmJIWMK38=
X-Google-Smtp-Source: ABdhPJzKQHcaK73xa4wmw+Y5lOr5OJd15SgmIKFKonEQG/eJqNojUzfvHTE1wUs3CJia2q32SK8m8Q==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr2947660wrs.554.1640199404377;
        Wed, 22 Dec 2021 10:56:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c187sm5904064wme.33.2021.12.22.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:44 -0800 (PST)
Message-Id: <1e50924894fcc07ee74a88a8b9f44547db01a3df.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:31 +0000
Subject: [PATCH v5 11/16] reftable: make reftable-record.h function signatures
 const correct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c          | 14 +++++++-------
 reftable/reftable-record.h | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8bbcbff1e69..f7c77c51539 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -72,7 +72,7 @@ int reftable_is_block_type(uint8_t typ)
 	return 0;
 }
 
-uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec)
+uint8_t *reftable_ref_record_val1(const struct reftable_ref_record *rec)
 {
 	switch (rec->value_type) {
 	case REFTABLE_REF_VAL1:
@@ -84,7 +84,7 @@ uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec)
 	}
 }
 
-uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec)
+uint8_t *reftable_ref_record_val2(const struct reftable_ref_record *rec)
 {
 	switch (rec->value_type) {
 	case REFTABLE_REF_VAL2:
@@ -251,7 +251,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 	}
 }
 
-void reftable_ref_record_print(struct reftable_ref_record *ref,
+void reftable_ref_record_print(const struct reftable_ref_record *ref,
 			       uint32_t hash_id)
 {
 	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
@@ -881,8 +881,8 @@ static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
 	return !memcmp(a, b, sz);
 }
 
-int reftable_log_record_equal(struct reftable_log_record *a,
-			      struct reftable_log_record *b, int hash_size)
+int reftable_log_record_equal(const struct reftable_log_record *a,
+			      const struct reftable_log_record *b, int hash_size)
 {
 	if (!(null_streq(a->refname, b->refname) &&
 	      a->update_index == b->update_index &&
@@ -1150,8 +1150,8 @@ static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
 	return a == b;
 }
 
-int reftable_ref_record_equal(struct reftable_ref_record *a,
-			      struct reftable_ref_record *b, int hash_size)
+int reftable_ref_record_equal(const struct reftable_ref_record *a,
+			      const struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
 	if (!null_streq(a->refname, b->refname))
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 5370d2288c7..67104f8fbfe 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -49,25 +49,25 @@ struct reftable_ref_record {
 
 /* Returns the first hash, or NULL if `rec` is not of type
  * REFTABLE_REF_VAL1 or REFTABLE_REF_VAL2. */
-uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec);
+uint8_t *reftable_ref_record_val1(const struct reftable_ref_record *rec);
 
 /* Returns the second hash, or NULL if `rec` is not of type
  * REFTABLE_REF_VAL2. */
-uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec);
+uint8_t *reftable_ref_record_val2(const struct reftable_ref_record *rec);
 
 /* returns whether 'ref' represents a deletion */
 int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
 
 /* prints a reftable_ref_record onto stdout. Useful for debugging. */
-void reftable_ref_record_print(struct reftable_ref_record *ref,
+void reftable_ref_record_print(const struct reftable_ref_record *ref,
 			       uint32_t hash_id);
 
 /* frees and nulls all pointer values inside `ref`. */
 void reftable_ref_record_release(struct reftable_ref_record *ref);
 
 /* returns whether two reftable_ref_records are the same. Useful for testing. */
-int reftable_ref_record_equal(struct reftable_ref_record *a,
-			      struct reftable_ref_record *b, int hash_size);
+int reftable_ref_record_equal(const struct reftable_ref_record *a,
+			      const struct reftable_ref_record *b, int hash_size);
 
 /* reftable_log_record holds a reflog entry */
 struct reftable_log_record {
@@ -104,8 +104,8 @@ int reftable_log_record_is_deletion(const struct reftable_log_record *log);
 void reftable_log_record_release(struct reftable_log_record *log);
 
 /* returns whether two records are equal. Useful for testing. */
-int reftable_log_record_equal(struct reftable_log_record *a,
-			      struct reftable_log_record *b, int hash_size);
+int reftable_log_record_equal(const struct reftable_log_record *a,
+			      const struct reftable_log_record *b, int hash_size);
 
 /* dumps a reftable_log_record on stdout, for debugging/testing. */
 void reftable_log_record_print(struct reftable_log_record *log,
-- 
gitgitgadget

