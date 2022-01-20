Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ABFC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376567AbiATPMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376538AbiATPMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B7C061756
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so7234177wmb.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EQ7LuISxS+OlxHRMui8s5gta6TAMzHzfTV3N4opZx10=;
        b=jx0xj6Egeb1hwz7Z9Hb9cocIJlQalN0akv9grnwD/6whpSjDEuMWm6ZDRi7v3oQe4n
         icQNntxOBi6vM6bmOS7vsyGqClE7phy2Yl+e+b1H0vMKtSlmFZWz35WSSMvccNstIRHA
         l33EoFR+3Q6urj41nT/cRfOm1aIeiQMz8AWSqiGrQuXU+izJAWYAJeOD+18icNw9FkvG
         snRMjP7WJIWeHLiplQCHUZYkXdJF6u0yWhF2wqazNsm3VEQyKXmUCANqI0EQ5ncKymkW
         gKzmCD8z61hh1E1DBf1ftmUUVlaMz+v81KfY2ybqlJsbrm6Dw6qH2IbL+vLg3fTWIi+j
         ftyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EQ7LuISxS+OlxHRMui8s5gta6TAMzHzfTV3N4opZx10=;
        b=NnmkzR0ZtiTRlw2dqL7YmSaibrDanMce5GIzsW6ScGhx4yVJnHZZa1mZCGzPiqh2Kt
         yrrmnbbgqlXQ/Id86y0OKcNqVIPMBjpiDyXC1ThKPBU9AGLYujAA9KnftBBw37JtitqH
         Is7jTlNsodScZPQcWxlAyOOoQCAkiuGVtVWxudgJrJ/qu9BZkFuYlyR+eyh2bFNi7il4
         PYm/mNDYNivi6EPUSDZX1TAL+I/xm47ssjtWh3eaP9nBguVkyEg3LhhDKxVp7vuGsSNI
         4mSrJ4+UE/qLlG/WjnI767cYVuFNzGlnaqA4yv0OIiRR8xNjGh9v7lnZ0uK7rsbpBzrK
         wk6Q==
X-Gm-Message-State: AOAM533cskjzbfuYRmhh5tNaVGsu4tWBEdH44Gni5s6dByMhhEJJySHA
        d0nzzb8Xfrd4ZxLExk9menUyB7YMDH4=
X-Google-Smtp-Source: ABdhPJxMo0Ja1Ifi8c6LRAWvffPpsrt6Q4dIop4sQ/R5fgV0tBxyuwCJ2SX+7mAFaLOpfaN+r+jSaQ==
X-Received: by 2002:a05:6000:15c9:: with SMTP id y9mr32613823wry.689.1642691547669;
        Thu, 20 Jan 2022 07:12:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm2905957wru.40.2022.01.20.07.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:27 -0800 (PST)
Message-Id: <82f140cab5c30b59de534d773a5d00343e0868f9.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:14 +0000
Subject: [PATCH v6 15/15] reftable: add print functions to the record types
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

This isn't used per se, but it is useful for debugging, especially
Windows CI failures.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c      | 85 +++++++++++++++++++++++++++++++++++-------
 reftable/record.h      |  4 ++
 reftable/record_test.c | 21 ++++++++++-
 3 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index a8cee628942..fbaa1fbef56 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -255,8 +255,8 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
 	}
 }
 
-void reftable_ref_record_print(const struct reftable_ref_record *ref,
-			       uint32_t hash_id)
+static void reftable_ref_record_print_sz(const struct reftable_ref_record *ref,
+					 int hash_size)
 {
 	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
 	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
@@ -265,14 +265,14 @@ void reftable_ref_record_print(const struct reftable_ref_record *ref,
 		printf("=> %s", ref->value.symref);
 		break;
 	case REFTABLE_REF_VAL2:
-		hex_format(hex, ref->value.val2.value, hash_size(hash_id));
+		hex_format(hex, ref->value.val2.value, hash_size);
 		printf("val 2 %s", hex);
 		hex_format(hex, ref->value.val2.target_value,
-			   hash_size(hash_id));
+			   hash_size);
 		printf("(T %s)", hex);
 		break;
 	case REFTABLE_REF_VAL1:
-		hex_format(hex, ref->value.val1, hash_size(hash_id));
+		hex_format(hex, ref->value.val1, hash_size);
 		printf("val 1 %s", hex);
 		break;
 	case REFTABLE_REF_DELETION:
@@ -282,6 +282,11 @@ void reftable_ref_record_print(const struct reftable_ref_record *ref,
 	printf("}\n");
 }
 
+void reftable_ref_record_print(const struct reftable_ref_record *ref,
+			       uint32_t hash_id) {
+	reftable_ref_record_print_sz(ref, hash_size(hash_id));
+}
+
 static void reftable_ref_record_release_void(void *rec)
 {
 	reftable_ref_record_release(rec);
@@ -443,6 +448,12 @@ static int reftable_ref_record_equal_void(const void *a,
 	return reftable_ref_record_equal(ra, rb, hash_size);
 }
 
+static void reftable_ref_record_print_void(const void *rec,
+					   int hash_size)
+{
+	reftable_ref_record_print_sz((struct reftable_ref_record *) rec, hash_size);
+}
+
 static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.key = &reftable_ref_record_key,
 	.type = BLOCK_TYPE_REF,
@@ -453,6 +464,7 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.release = &reftable_ref_record_release_void,
 	.is_deletion = &reftable_ref_record_is_deletion_void,
 	.equal = &reftable_ref_record_equal_void,
+	.print = &reftable_ref_record_print_void,
 };
 
 static void reftable_obj_record_key(const void *r, struct strbuf *dest)
@@ -471,6 +483,21 @@ static void reftable_obj_record_release(void *rec)
 	memset(obj, 0, sizeof(struct reftable_obj_record));
 }
 
+static void reftable_obj_record_print(const void *rec, int hash_size)
+{
+	const struct reftable_obj_record *obj = rec;
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
+	struct strbuf offset_str = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < obj->offset_len; i++)
+		strbuf_addf(&offset_str, "%" PRIu64 " ", obj->offsets[i]);
+	hex_format(hex, obj->hash_prefix, obj->hash_prefix_len);
+	printf("prefix %s (len %d), offsets [%s]\n",
+	       hex, obj->hash_prefix_len, offset_str.buf);
+	strbuf_release(&offset_str);
+}
+
 static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
 					  int hash_size)
 {
@@ -617,31 +644,41 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.release = &reftable_obj_record_release,
 	.is_deletion = &not_a_deletion,
 	.equal = &reftable_obj_record_equal_void,
+	.print = &reftable_obj_record_print,
 };
 
-void reftable_log_record_print(struct reftable_log_record *log,
-			       uint32_t hash_id)
+static void reftable_log_record_print_sz(struct reftable_log_record *log,
+					 int hash_size)
 {
 	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 
 	switch (log->value_type) {
 	case REFTABLE_LOG_DELETION:
-		printf("log{%s(%" PRIu64 ") delete", log->refname,
+		printf("log{%s(%" PRIu64 ") delete\n", log->refname,
 		       log->update_index);
 		break;
 	case REFTABLE_LOG_UPDATE:
 		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
-		       log->refname, log->update_index, log->value.update.name,
-		       log->value.update.email, log->value.update.time,
+		       log->refname, log->update_index,
+		       log->value.update.name ? log->value.update.name : "",
+		       log->value.update.email ? log->value.update.email : "",
+		       log->value.update.time,
 		       log->value.update.tz_offset);
-		hex_format(hex, log->value.update.old_hash, hash_size(hash_id));
+		hex_format(hex, log->value.update.old_hash, hash_size);
 		printf("%s => ", hex);
-		hex_format(hex, log->value.update.new_hash, hash_size(hash_id));
-		printf("%s\n\n%s\n}\n", hex, log->value.update.message);
+		hex_format(hex, log->value.update.new_hash, hash_size);
+		printf("%s\n\n%s\n}\n", hex,
+		       log->value.update.message ? log->value.update.message : "");
 		break;
 	}
 }
 
+void reftable_log_record_print(struct reftable_log_record *log,
+				      uint32_t hash_id)
+{
+	reftable_log_record_print_sz(log, hash_size(hash_id));
+}
+
 static void reftable_log_record_key(const void *r, struct strbuf *dest)
 {
 	const struct reftable_log_record *rec =
@@ -959,6 +996,11 @@ static int reftable_log_record_is_deletion_void(const void *p)
 		(const struct reftable_log_record *)p);
 }
 
+static void reftable_log_record_print_void(const void *rec, int hash_size)
+{
+	reftable_log_record_print_sz((struct reftable_log_record*)rec, hash_size);
+}
+
 static struct reftable_record_vtable reftable_log_record_vtable = {
 	.key = &reftable_log_record_key,
 	.type = BLOCK_TYPE_LOG,
@@ -968,7 +1010,8 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.decode = &reftable_log_record_decode,
 	.release = &reftable_log_record_release_void,
 	.is_deletion = &reftable_log_record_is_deletion_void,
-	.equal = &reftable_log_record_equal_void
+	.equal = &reftable_log_record_equal_void,
+	.print = &reftable_log_record_print_void,
 };
 
 static void reftable_index_record_key(const void *r, struct strbuf *dest)
@@ -1043,6 +1086,13 @@ static int reftable_index_record_equal(const void *a, const void *b, int hash_si
 	return ia->offset == ib->offset && !strbuf_cmp(&ia->last_key, &ib->last_key);
 }
 
+static void reftable_index_record_print(const void *rec, int hash_size)
+{
+	const struct reftable_index_record *idx = rec;
+	/* TODO: escape null chars? */
+	printf("\"%s\" %" PRIu64 "\n", idx->last_key.buf, idx->offset);
+}
+
 static struct reftable_record_vtable reftable_index_record_vtable = {
 	.key = &reftable_index_record_key,
 	.type = BLOCK_TYPE_INDEX,
@@ -1053,6 +1103,7 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.release = &reftable_index_record_release,
 	.is_deletion = &not_a_deletion,
 	.equal = &reftable_index_record_equal,
+	.print = &reftable_index_record_print,
 };
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
@@ -1255,3 +1306,9 @@ struct reftable_record reftable_new_record(uint8_t typ)
 	}
 	return clean;
 }
+
+void reftable_record_print(struct reftable_record *rec, int hash_size)
+{
+	printf("'%c': ", rec->type);
+	reftable_record_vtable(rec)->print(reftable_record_data(rec), hash_size);
+}
diff --git a/reftable/record.h b/reftable/record.h
index 010a322e901..fd80cd451d5 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -61,6 +61,9 @@ struct reftable_record_vtable {
 
 	/* Are two records equal? This assumes they have the same type. Returns 0 for non-equal. */
 	int (*equal)(const void *a, const void *b, int hash_size);
+
+	/* Print on stdout, for debugging. */
+	void (*print)(const void *rec, int hash_size);
 };
 
 /* returns true for recognized block types. Block start with the block type. */
@@ -112,6 +115,7 @@ struct reftable_record {
 
 /* see struct record_vtable */
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
+void reftable_record_print(struct reftable_record *rec, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
 uint8_t reftable_record_type(struct reftable_record *rec);
 void reftable_record_copy_from(struct reftable_record *rec,
diff --git a/reftable/record_test.c b/reftable/record_test.c
index c6fdd1925a9..f91ea5e8830 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -25,6 +25,10 @@ static void test_copy(struct reftable_record *rec)
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
 	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
+
+	puts("testing print coverage:\n");
+	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
+
 	reftable_record_release(&copy);
 }
 
@@ -176,7 +180,8 @@ static void test_reftable_log_record_equal(void)
 static void test_reftable_log_record_roundtrip(void)
 {
 	int i;
-	struct reftable_log_record in[2] = {
+
+	struct reftable_log_record in[] = {
 		{
 			.refname = xstrdup("refs/heads/master"),
 			.update_index = 42,
@@ -197,10 +202,24 @@ static void test_reftable_log_record_roundtrip(void)
 			.refname = xstrdup("refs/heads/master"),
 			.update_index = 22,
 			.value_type = REFTABLE_LOG_DELETION,
+		},
+		{
+			.refname = xstrdup("branch"),
+			.update_index = 33,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = {
+				.update = {
+					.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
+					.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
+					/* rest of fields left empty. */
+				},
+			},
 		}
 	};
 	set_test_hash(in[0].value.update.new_hash, 1);
 	set_test_hash(in[0].value.update.old_hash, 2);
+	set_test_hash(in[2].value.update.new_hash, 3);
+	set_test_hash(in[2].value.update.old_hash, 4);
 	for (i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
-- 
gitgitgadget
