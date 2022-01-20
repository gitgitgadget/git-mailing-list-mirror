Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF2C433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbiATPMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376488AbiATPM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B8C06161C
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r7-20020a1c4407000000b0034e043aaac7so287314wma.5
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7yeGXzd+HLokH3mIqMgC6QPxufo4Z99YCUN5bOC8N9I=;
        b=d+nG9FZUDJe5q5FM3IzacJxO7ka9XH7uEDE+oE0X6roPrFFR3+PZ6yQy4wsnisuH6Y
         uO8fLE71GmH9Yd3eTqZBEIGhmvmFpHaYRVFLLhDF+A2eHQn7gqdvSGCzd3IfHRyMfw3B
         RKg2h7c2TagS3OIBxrzZGmd2Whq39sIeSTi6viIcVTeXJopvmdDg4Zneo8Y87+Yit1j6
         R4FnnmwnrPvpIWFrcwphxccSfo7XnwHE6swr1o4tONK6arYOjz7yX4YQjaoKqCcB7cdC
         erJS0GFu3GO77lY6+HGmdhJ1W2KJsbcLSOhz0Ej6XvDSsxtFWG0uO5lwI/0Rd52sBcnT
         ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7yeGXzd+HLokH3mIqMgC6QPxufo4Z99YCUN5bOC8N9I=;
        b=tjLu9FvR3emjUBbZ8edfyoYhPIqr8SON2Gqz+q7vmRTwUmJeePcKLnLJ+vxxdSFBhJ
         Vxn4tNc9w+/XhE4xKo9O5Ffw9lChL6Dlo9wvzUo0vJklEPd41DWTw4opJ5f+0LKLN4ir
         CTO34V1AGicw3oLjkSj9uHMMXC7nDE7tQodLcIR2I2FtlRzpTagMwVtXFQtdYaq9MwiR
         NyUebcGocdZqx3LXWUe6vWLUax47hP1xKGLSpU8Pp3pxyaugw2BjyqW7ruhCO+YDNZVn
         edr3BgnfUzQu4vSlbF5jCOzsaasQ0cjMf4Gay5KOpdroM//OUvUNd3H6HxO3MZQUeAm5
         NzHw==
X-Gm-Message-State: AOAM532BrWqkAAsZob3pf8nAdPLEAC1eEoP512Zjzh7//MmbNlraAZF2
        3+wassQ3hogRwmf4w12c0WjKUYaEYGQ=
X-Google-Smtp-Source: ABdhPJyjYI+I12ykxtrejUjftDSHbw5tBwsZol1heh4k8oMV4cRLlA6eNoRlK6GjEtBwHKHGu7bzwg==
X-Received: by 2002:a7b:cb83:: with SMTP id m3mr9458406wmi.150.1642691544334;
        Thu, 20 Jan 2022 07:12:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm7922447wmc.47.2022.01.20.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:23 -0800 (PST)
Message-Id: <951efcebcd2097ec3af71703290c9e8c293bef05.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:10 +0000
Subject: [PATCH v6 11/15] reftable: make reftable-record.h function signatures
 const correct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

