Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE2CC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3DC611CE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbhI1PMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbhI1PME (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F8DC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so58740941wrq.4
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EMVtUg7BUbZOO34LavBA1ufSr2HlXQJEPWRmUflUrwU=;
        b=gInySPTwKtPczQ7YiYHDnJNo/O2w5WHi1usmZBlrllSQSdCFU5ACaz1ayWXMkx0uU/
         Yj5nh1FS5RBde4/5xTcqoXQaAfxNTohUf8S5hFi41YECQfFHhngn0Muyxx3ZMtdHRpxj
         4ZCmjtR1WJZhtuRuR9jJ6cThD8DoWJq1cT1w1QLCVBZB0DRoPnGOiWtUsF7XoUxWaTSX
         /y88BaeMwHcQ+KXEu6B6Q0TTwDs6lUs1x/Jnb6pAQ6H9vZRXLhzhVXKKT8uLKl+PxpbG
         58MULYNtqgV5ZCxJi6esQbLZrs9Irdur2kUYYRpkpQk82S/x5ulhO4+aktm48XGFgzAZ
         8SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EMVtUg7BUbZOO34LavBA1ufSr2HlXQJEPWRmUflUrwU=;
        b=NuRoy7ulDeGZFQSkhXnt9J0Z+Bva9Og82r7v0c52vmDzOYhaf5xXv4/kLS0xXCczMd
         QYfP+dmUP/KcWf9eMjXrpfgcbk+vGhTKlRpEnKbslhYdGEOYDlwdOzVorZI55FXHyho6
         tLjixHeFlMzA3kEfRbgY3rlokeCrv512MwwgYhxAcnNML3JsFJG1HpQHpG1u4H96DfNn
         y4fOS+UYZgJXZ8bcwdp1EL4qUd6XI7/yQTWBuNzeZvIwz9W72bgpYG5GEMxi1zRdpy05
         NeA1eiiJ/0SG2NRxjnQRkVb1mFFR4JHdRoVI40NiDWkijIf/51OvAi+dXTXrwhzDwo9K
         DcEw==
X-Gm-Message-State: AOAM531urZlwF9R2gwzcyiHBguca1EXP32g9ATlvxpcBigEDA+Oha78C
        MxMDDQfqSAabJwj+U0tCd6807TyI/Lo=
X-Google-Smtp-Source: ABdhPJyq4M486+dyZZEtONa6oDCp8YvJlsJuFXxzD3Fw35STf7w/WpO+OOSmeo3F7quC+8Ns8T2MYg==
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr586249wrq.383.1632841822957;
        Tue, 28 Sep 2021 08:10:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm3306598wmq.19.2021.09.28.08.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:22 -0700 (PDT)
Message-Id: <55e66b7a74fcb6861ed5f27bb82cfceefa4c7b2a.1632841817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:10:03 +0000
Subject: [PATCH v3 06/19] reftable: (de)serialization for the polymorphic
 record type.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable format is structured as a sequence of blocks, and each block
contains a sequence of prefix-compressed key-value records. There are 4 types of
records, and they have similarities in how they must be handled. This is
achieved by introducing a polymorphic 'record' type that encapsulates ref, log,
index and object records.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                   |    2 +
 reftable/constants.h       |   21 +
 reftable/record.c          | 1212 ++++++++++++++++++++++++++++++++++++
 reftable/record.h          |  139 +++++
 reftable/record_test.c     |  412 ++++++++++++
 reftable/reftable-record.h |  114 ++++
 t/helper/test-reftable.c   |    2 +-
 7 files changed, 1901 insertions(+), 1 deletion(-)
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/reftable-record.h

diff --git a/Makefile b/Makefile
index eaca0da79a0..7cbc8f95c8b 100644
--- a/Makefile
+++ b/Makefile
@@ -2431,7 +2431,9 @@ REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/record.o
 
+REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 
diff --git a/reftable/constants.h b/reftable/constants.h
new file mode 100644
index 00000000000..5eee72c4c11
--- /dev/null
+++ b/reftable/constants.h
@@ -0,0 +1,21 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef CONSTANTS_H
+#define CONSTANTS_H
+
+#define BLOCK_TYPE_LOG 'g'
+#define BLOCK_TYPE_INDEX 'i'
+#define BLOCK_TYPE_REF 'r'
+#define BLOCK_TYPE_OBJ 'o'
+#define BLOCK_TYPE_ANY 0
+
+#define MAX_RESTARTS ((1 << 16) - 1)
+#define DEFAULT_BLOCK_SIZE 4096
+
+#endif
diff --git a/reftable/record.c b/reftable/record.c
new file mode 100644
index 00000000000..6a5dac32dc6
--- /dev/null
+++ b/reftable/record.c
@@ -0,0 +1,1212 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+/* record.c - methods for different types of records. */
+
+#include "record.h"
+
+#include "system.h"
+#include "constants.h"
+#include "reftable-error.h"
+#include "basics.h"
+
+int get_var_int(uint64_t *dest, struct string_view *in)
+{
+	int ptr = 0;
+	uint64_t val;
+
+	if (in->len == 0)
+		return -1;
+	val = in->buf[ptr] & 0x7f;
+
+	while (in->buf[ptr] & 0x80) {
+		ptr++;
+		if (ptr > in->len) {
+			return -1;
+		}
+		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
+	}
+
+	*dest = val;
+	return ptr + 1;
+}
+
+int put_var_int(struct string_view *dest, uint64_t val)
+{
+	uint8_t buf[10] = { 0 };
+	int i = 9;
+	int n = 0;
+	buf[i] = (uint8_t)(val & 0x7f);
+	i--;
+	while (1) {
+		val >>= 7;
+		if (!val) {
+			break;
+		}
+		val--;
+		buf[i] = 0x80 | (uint8_t)(val & 0x7f);
+		i--;
+	}
+
+	n = sizeof(buf) - i - 1;
+	if (dest->len < n)
+		return -1;
+	memcpy(dest->buf, &buf[i + 1], n);
+	return n;
+}
+
+int reftable_is_block_type(uint8_t typ)
+{
+	switch (typ) {
+	case BLOCK_TYPE_REF:
+	case BLOCK_TYPE_LOG:
+	case BLOCK_TYPE_OBJ:
+	case BLOCK_TYPE_INDEX:
+		return 1;
+	}
+	return 0;
+}
+
+uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec)
+{
+	switch (rec->value_type) {
+	case REFTABLE_REF_VAL1:
+		return rec->value.val1;
+	case REFTABLE_REF_VAL2:
+		return rec->value.val2.value;
+	default:
+		return NULL;
+	}
+}
+
+uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec)
+{
+	switch (rec->value_type) {
+	case REFTABLE_REF_VAL2:
+		return rec->value.val2.target_value;
+	default:
+		return NULL;
+	}
+}
+
+static int decode_string(struct strbuf *dest, struct string_view in)
+{
+	int start_len = in.len;
+	uint64_t tsize = 0;
+	int n = get_var_int(&tsize, &in);
+	if (n <= 0)
+		return -1;
+	string_view_consume(&in, n);
+	if (in.len < tsize)
+		return -1;
+
+	strbuf_reset(dest);
+	strbuf_add(dest, in.buf, tsize);
+	string_view_consume(&in, tsize);
+
+	return start_len - in.len;
+}
+
+static int encode_string(char *str, struct string_view s)
+{
+	struct string_view start = s;
+	int l = strlen(str);
+	int n = put_var_int(&s, l);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+	if (s.len < l)
+		return -1;
+	memcpy(s.buf, str, l);
+	string_view_consume(&s, l);
+
+	return start.len - s.len;
+}
+
+int reftable_encode_key(int *restart, struct string_view dest,
+			struct strbuf prev_key, struct strbuf key,
+			uint8_t extra)
+{
+	struct string_view start = dest;
+	int prefix_len = common_prefix_size(&prev_key, &key);
+	uint64_t suffix_len = key.len - prefix_len;
+	int n = put_var_int(&dest, (uint64_t)prefix_len);
+	if (n < 0)
+		return -1;
+	string_view_consume(&dest, n);
+
+	*restart = (prefix_len == 0);
+
+	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
+	if (n < 0)
+		return -1;
+	string_view_consume(&dest, n);
+
+	if (dest.len < suffix_len)
+		return -1;
+	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
+	string_view_consume(&dest, suffix_len);
+
+	return start.len - dest.len;
+}
+
+int reftable_decode_key(struct strbuf *key, uint8_t *extra,
+			struct strbuf last_key, struct string_view in)
+{
+	int start_len = in.len;
+	uint64_t prefix_len = 0;
+	uint64_t suffix_len = 0;
+	int n = get_var_int(&prefix_len, &in);
+	if (n < 0)
+		return -1;
+	string_view_consume(&in, n);
+
+	if (prefix_len > last_key.len)
+		return -1;
+
+	n = get_var_int(&suffix_len, &in);
+	if (n <= 0)
+		return -1;
+	string_view_consume(&in, n);
+
+	*extra = (uint8_t)(suffix_len & 0x7);
+	suffix_len >>= 3;
+
+	if (in.len < suffix_len)
+		return -1;
+
+	strbuf_reset(key);
+	strbuf_add(key, last_key.buf, prefix_len);
+	strbuf_add(key, in.buf, suffix_len);
+	string_view_consume(&in, suffix_len);
+
+	return start_len - in.len;
+}
+
+static void reftable_ref_record_key(const void *r, struct strbuf *dest)
+{
+	const struct reftable_ref_record *rec =
+		(const struct reftable_ref_record *)r;
+	strbuf_reset(dest);
+	strbuf_addstr(dest, rec->refname);
+}
+
+static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
+					  int hash_size)
+{
+	struct reftable_ref_record *ref = rec;
+	const struct reftable_ref_record *src = src_rec;
+	assert(hash_size > 0);
+
+	/* This is simple and correct, but we could probably reuse the hash
+	 * fields. */
+	reftable_ref_record_release(ref);
+	if (src->refname) {
+		ref->refname = xstrdup(src->refname);
+	}
+	ref->update_index = src->update_index;
+	ref->value_type = src->value_type;
+	switch (src->value_type) {
+	case REFTABLE_REF_DELETION:
+		break;
+	case REFTABLE_REF_VAL1:
+		ref->value.val1 = reftable_malloc(hash_size);
+		memcpy(ref->value.val1, src->value.val1, hash_size);
+		break;
+	case REFTABLE_REF_VAL2:
+		ref->value.val2.value = reftable_malloc(hash_size);
+		memcpy(ref->value.val2.value, src->value.val2.value, hash_size);
+		ref->value.val2.target_value = reftable_malloc(hash_size);
+		memcpy(ref->value.val2.target_value,
+		       src->value.val2.target_value, hash_size);
+		break;
+	case REFTABLE_REF_SYMREF:
+		ref->value.symref = xstrdup(src->value.symref);
+		break;
+	}
+}
+
+static char hexdigit(int c)
+{
+	if (c <= 9)
+		return '0' + c;
+	return 'a' + (c - 10);
+}
+
+static void hex_format(char *dest, uint8_t *src, int hash_size)
+{
+	assert(hash_size > 0);
+	if (src) {
+		int i = 0;
+		for (i = 0; i < hash_size; i++) {
+			dest[2 * i] = hexdigit(src[i] >> 4);
+			dest[2 * i + 1] = hexdigit(src[i] & 0xf);
+		}
+		dest[2 * hash_size] = 0;
+	}
+}
+
+void reftable_ref_record_print(struct reftable_ref_record *ref,
+			       uint32_t hash_id)
+{
+	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
+	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
+	switch (ref->value_type) {
+	case REFTABLE_REF_SYMREF:
+		printf("=> %s", ref->value.symref);
+		break;
+	case REFTABLE_REF_VAL2:
+		hex_format(hex, ref->value.val2.value, hash_size(hash_id));
+		printf("val 2 %s", hex);
+		hex_format(hex, ref->value.val2.target_value,
+			   hash_size(hash_id));
+		printf("(T %s)", hex);
+		break;
+	case REFTABLE_REF_VAL1:
+		hex_format(hex, ref->value.val1, hash_size(hash_id));
+		printf("val 1 %s", hex);
+		break;
+	case REFTABLE_REF_DELETION:
+		printf("delete");
+		break;
+	}
+	printf("}\n");
+}
+
+static void reftable_ref_record_release_void(void *rec)
+{
+	reftable_ref_record_release(rec);
+}
+
+void reftable_ref_record_release(struct reftable_ref_record *ref)
+{
+	switch (ref->value_type) {
+	case REFTABLE_REF_SYMREF:
+		reftable_free(ref->value.symref);
+		break;
+	case REFTABLE_REF_VAL2:
+		reftable_free(ref->value.val2.target_value);
+		reftable_free(ref->value.val2.value);
+		break;
+	case REFTABLE_REF_VAL1:
+		reftable_free(ref->value.val1);
+		break;
+	case REFTABLE_REF_DELETION:
+		break;
+	default:
+		abort();
+	}
+
+	reftable_free(ref->refname);
+	memset(ref, 0, sizeof(struct reftable_ref_record));
+}
+
+static uint8_t reftable_ref_record_val_type(const void *rec)
+{
+	const struct reftable_ref_record *r =
+		(const struct reftable_ref_record *)rec;
+	return r->value_type;
+}
+
+static int reftable_ref_record_encode(const void *rec, struct string_view s,
+				      int hash_size)
+{
+	const struct reftable_ref_record *r =
+		(const struct reftable_ref_record *)rec;
+	struct string_view start = s;
+	int n = put_var_int(&s, r->update_index);
+	assert(hash_size > 0);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+
+	switch (r->value_type) {
+	case REFTABLE_REF_SYMREF:
+		n = encode_string(r->value.symref, s);
+		if (n < 0) {
+			return -1;
+		}
+		string_view_consume(&s, n);
+		break;
+	case REFTABLE_REF_VAL2:
+		if (s.len < 2 * hash_size) {
+			return -1;
+		}
+		memcpy(s.buf, r->value.val2.value, hash_size);
+		string_view_consume(&s, hash_size);
+		memcpy(s.buf, r->value.val2.target_value, hash_size);
+		string_view_consume(&s, hash_size);
+		break;
+	case REFTABLE_REF_VAL1:
+		if (s.len < hash_size) {
+			return -1;
+		}
+		memcpy(s.buf, r->value.val1, hash_size);
+		string_view_consume(&s, hash_size);
+		break;
+	case REFTABLE_REF_DELETION:
+		break;
+	default:
+		abort();
+	}
+
+	return start.len - s.len;
+}
+
+static int reftable_ref_record_decode(void *rec, struct strbuf key,
+				      uint8_t val_type, struct string_view in,
+				      int hash_size)
+{
+	struct reftable_ref_record *r = rec;
+	struct string_view start = in;
+	uint64_t update_index = 0;
+	int n = get_var_int(&update_index, &in);
+	if (n < 0)
+		return n;
+	string_view_consume(&in, n);
+
+	reftable_ref_record_release(r);
+
+	assert(hash_size > 0);
+
+	r->refname = reftable_realloc(r->refname, key.len + 1);
+	memcpy(r->refname, key.buf, key.len);
+	r->update_index = update_index;
+	r->refname[key.len] = 0;
+	r->value_type = val_type;
+	switch (val_type) {
+	case REFTABLE_REF_VAL1:
+		if (in.len < hash_size) {
+			return -1;
+		}
+
+		r->value.val1 = reftable_malloc(hash_size);
+		memcpy(r->value.val1, in.buf, hash_size);
+		string_view_consume(&in, hash_size);
+		break;
+
+	case REFTABLE_REF_VAL2:
+		if (in.len < 2 * hash_size) {
+			return -1;
+		}
+
+		r->value.val2.value = reftable_malloc(hash_size);
+		memcpy(r->value.val2.value, in.buf, hash_size);
+		string_view_consume(&in, hash_size);
+
+		r->value.val2.target_value = reftable_malloc(hash_size);
+		memcpy(r->value.val2.target_value, in.buf, hash_size);
+		string_view_consume(&in, hash_size);
+		break;
+
+	case REFTABLE_REF_SYMREF: {
+		struct strbuf dest = STRBUF_INIT;
+		int n = decode_string(&dest, in);
+		if (n < 0) {
+			return -1;
+		}
+		string_view_consume(&in, n);
+		r->value.symref = dest.buf;
+	} break;
+
+	case REFTABLE_REF_DELETION:
+		break;
+	default:
+		abort();
+		break;
+	}
+
+	return start.len - in.len;
+}
+
+static int reftable_ref_record_is_deletion_void(const void *p)
+{
+	return reftable_ref_record_is_deletion(
+		(const struct reftable_ref_record *)p);
+}
+
+static struct reftable_record_vtable reftable_ref_record_vtable = {
+	.key = &reftable_ref_record_key,
+	.type = BLOCK_TYPE_REF,
+	.copy_from = &reftable_ref_record_copy_from,
+	.val_type = &reftable_ref_record_val_type,
+	.encode = &reftable_ref_record_encode,
+	.decode = &reftable_ref_record_decode,
+	.release = &reftable_ref_record_release_void,
+	.is_deletion = &reftable_ref_record_is_deletion_void,
+};
+
+static void reftable_obj_record_key(const void *r, struct strbuf *dest)
+{
+	const struct reftable_obj_record *rec =
+		(const struct reftable_obj_record *)r;
+	strbuf_reset(dest);
+	strbuf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
+}
+
+static void reftable_obj_record_release(void *rec)
+{
+	struct reftable_obj_record *obj = rec;
+	FREE_AND_NULL(obj->hash_prefix);
+	FREE_AND_NULL(obj->offsets);
+	memset(obj, 0, sizeof(struct reftable_obj_record));
+}
+
+static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
+					  int hash_size)
+{
+	struct reftable_obj_record *obj = rec;
+	const struct reftable_obj_record *src =
+		(const struct reftable_obj_record *)src_rec;
+
+	reftable_obj_record_release(obj);
+	*obj = *src;
+	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
+	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
+
+	obj->offsets = reftable_malloc(obj->offset_len * sizeof(uint64_t));
+	COPY_ARRAY(obj->offsets, src->offsets, obj->offset_len);
+}
+
+static uint8_t reftable_obj_record_val_type(const void *rec)
+{
+	const struct reftable_obj_record *r = rec;
+	if (r->offset_len > 0 && r->offset_len < 8)
+		return r->offset_len;
+	return 0;
+}
+
+static int reftable_obj_record_encode(const void *rec, struct string_view s,
+				      int hash_size)
+{
+	const struct reftable_obj_record *r = rec;
+	struct string_view start = s;
+	int i = 0;
+	int n = 0;
+	uint64_t last = 0;
+	if (r->offset_len == 0 || r->offset_len >= 8) {
+		n = put_var_int(&s, r->offset_len);
+		if (n < 0) {
+			return -1;
+		}
+		string_view_consume(&s, n);
+	}
+	if (r->offset_len == 0)
+		return start.len - s.len;
+	n = put_var_int(&s, r->offsets[0]);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+
+	last = r->offsets[0];
+	for (i = 1; i < r->offset_len; i++) {
+		int n = put_var_int(&s, r->offsets[i] - last);
+		if (n < 0) {
+			return -1;
+		}
+		string_view_consume(&s, n);
+		last = r->offsets[i];
+	}
+	return start.len - s.len;
+}
+
+static int reftable_obj_record_decode(void *rec, struct strbuf key,
+				      uint8_t val_type, struct string_view in,
+				      int hash_size)
+{
+	struct string_view start = in;
+	struct reftable_obj_record *r = rec;
+	uint64_t count = val_type;
+	int n = 0;
+	uint64_t last;
+	int j;
+	r->hash_prefix = reftable_malloc(key.len);
+	memcpy(r->hash_prefix, key.buf, key.len);
+	r->hash_prefix_len = key.len;
+
+	if (val_type == 0) {
+		n = get_var_int(&count, &in);
+		if (n < 0) {
+			return n;
+		}
+
+		string_view_consume(&in, n);
+	}
+
+	r->offsets = NULL;
+	r->offset_len = 0;
+	if (count == 0)
+		return start.len - in.len;
+
+	r->offsets = reftable_malloc(count * sizeof(uint64_t));
+	r->offset_len = count;
+
+	n = get_var_int(&r->offsets[0], &in);
+	if (n < 0)
+		return n;
+	string_view_consume(&in, n);
+
+	last = r->offsets[0];
+	j = 1;
+	while (j < count) {
+		uint64_t delta = 0;
+		int n = get_var_int(&delta, &in);
+		if (n < 0) {
+			return n;
+		}
+		string_view_consume(&in, n);
+
+		last = r->offsets[j] = (delta + last);
+		j++;
+	}
+	return start.len - in.len;
+}
+
+static int not_a_deletion(const void *p)
+{
+	return 0;
+}
+
+static struct reftable_record_vtable reftable_obj_record_vtable = {
+	.key = &reftable_obj_record_key,
+	.type = BLOCK_TYPE_OBJ,
+	.copy_from = &reftable_obj_record_copy_from,
+	.val_type = &reftable_obj_record_val_type,
+	.encode = &reftable_obj_record_encode,
+	.decode = &reftable_obj_record_decode,
+	.release = &reftable_obj_record_release,
+	.is_deletion = not_a_deletion,
+};
+
+void reftable_log_record_print(struct reftable_log_record *log,
+			       uint32_t hash_id)
+{
+	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
+
+	switch (log->value_type) {
+	case REFTABLE_LOG_DELETION:
+		printf("log{%s(%" PRIu64 ") delete", log->refname,
+		       log->update_index);
+		break;
+	case REFTABLE_LOG_UPDATE:
+		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
+		       log->refname, log->update_index, log->value.update.name,
+		       log->value.update.email, log->value.update.time,
+		       log->value.update.tz_offset);
+		hex_format(hex, log->value.update.old_hash, hash_size(hash_id));
+		printf("%s => ", hex);
+		hex_format(hex, log->value.update.new_hash, hash_size(hash_id));
+		printf("%s\n\n%s\n}\n", hex, log->value.update.message);
+		break;
+	}
+}
+
+static void reftable_log_record_key(const void *r, struct strbuf *dest)
+{
+	const struct reftable_log_record *rec =
+		(const struct reftable_log_record *)r;
+	int len = strlen(rec->refname);
+	uint8_t i64[8];
+	uint64_t ts = 0;
+	strbuf_reset(dest);
+	strbuf_add(dest, (uint8_t *)rec->refname, len + 1);
+
+	ts = (~ts) - rec->update_index;
+	put_be64(&i64[0], ts);
+	strbuf_add(dest, i64, sizeof(i64));
+}
+
+static void reftable_log_record_copy_from(void *rec, const void *src_rec,
+					  int hash_size)
+{
+	struct reftable_log_record *dst = rec;
+	const struct reftable_log_record *src =
+		(const struct reftable_log_record *)src_rec;
+
+	reftable_log_record_release(dst);
+	*dst = *src;
+	if (dst->refname) {
+		dst->refname = xstrdup(dst->refname);
+	}
+	switch (dst->value_type) {
+	case REFTABLE_LOG_DELETION:
+		break;
+	case REFTABLE_LOG_UPDATE:
+		if (dst->value.update.email) {
+			dst->value.update.email =
+				xstrdup(dst->value.update.email);
+		}
+		if (dst->value.update.name) {
+			dst->value.update.name =
+				xstrdup(dst->value.update.name);
+		}
+		if (dst->value.update.message) {
+			dst->value.update.message =
+				xstrdup(dst->value.update.message);
+		}
+
+		if (dst->value.update.new_hash) {
+			dst->value.update.new_hash = reftable_malloc(hash_size);
+			memcpy(dst->value.update.new_hash,
+			       src->value.update.new_hash, hash_size);
+		}
+		if (dst->value.update.old_hash) {
+			dst->value.update.old_hash = reftable_malloc(hash_size);
+			memcpy(dst->value.update.old_hash,
+			       src->value.update.old_hash, hash_size);
+		}
+		break;
+	}
+}
+
+static void reftable_log_record_release_void(void *rec)
+{
+	struct reftable_log_record *r = rec;
+	reftable_log_record_release(r);
+}
+
+void reftable_log_record_release(struct reftable_log_record *r)
+{
+	reftable_free(r->refname);
+	switch (r->value_type) {
+	case REFTABLE_LOG_DELETION:
+		break;
+	case REFTABLE_LOG_UPDATE:
+		reftable_free(r->value.update.new_hash);
+		reftable_free(r->value.update.old_hash);
+		reftable_free(r->value.update.name);
+		reftable_free(r->value.update.email);
+		reftable_free(r->value.update.message);
+		break;
+	}
+	memset(r, 0, sizeof(struct reftable_log_record));
+}
+
+static uint8_t reftable_log_record_val_type(const void *rec)
+{
+	const struct reftable_log_record *log =
+		(const struct reftable_log_record *)rec;
+
+	return reftable_log_record_is_deletion(log) ? 0 : 1;
+}
+
+static uint8_t zero[GIT_SHA256_RAWSZ] = { 0 };
+
+static int reftable_log_record_encode(const void *rec, struct string_view s,
+				      int hash_size)
+{
+	const struct reftable_log_record *r = rec;
+	struct string_view start = s;
+	int n = 0;
+	uint8_t *oldh = NULL;
+	uint8_t *newh = NULL;
+	if (reftable_log_record_is_deletion(r))
+		return 0;
+
+	oldh = r->value.update.old_hash;
+	newh = r->value.update.new_hash;
+	if (!oldh) {
+		oldh = zero;
+	}
+	if (!newh) {
+		newh = zero;
+	}
+
+	if (s.len < 2 * hash_size)
+		return -1;
+
+	memcpy(s.buf, oldh, hash_size);
+	memcpy(s.buf + hash_size, newh, hash_size);
+	string_view_consume(&s, 2 * hash_size);
+
+	n = encode_string(r->value.update.name ? r->value.update.name : "", s);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+
+	n = encode_string(r->value.update.email ? r->value.update.email : "",
+			  s);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+
+	n = put_var_int(&s, r->value.update.time);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+
+	if (s.len < 2)
+		return -1;
+
+	put_be16(s.buf, r->value.update.tz_offset);
+	string_view_consume(&s, 2);
+
+	n = encode_string(
+		r->value.update.message ? r->value.update.message : "", s);
+	if (n < 0)
+		return -1;
+	string_view_consume(&s, n);
+
+	return start.len - s.len;
+}
+
+static int reftable_log_record_decode(void *rec, struct strbuf key,
+				      uint8_t val_type, struct string_view in,
+				      int hash_size)
+{
+	struct string_view start = in;
+	struct reftable_log_record *r = rec;
+	uint64_t max = 0;
+	uint64_t ts = 0;
+	struct strbuf dest = STRBUF_INIT;
+	int n;
+
+	if (key.len <= 9 || key.buf[key.len - 9] != 0)
+		return REFTABLE_FORMAT_ERROR;
+
+	r->refname = reftable_realloc(r->refname, key.len - 8);
+	memcpy(r->refname, key.buf, key.len - 8);
+	ts = get_be64(key.buf + key.len - 8);
+
+	r->update_index = (~max) - ts;
+
+	if (val_type != r->value_type) {
+		switch (r->value_type) {
+		case REFTABLE_LOG_UPDATE:
+			FREE_AND_NULL(r->value.update.old_hash);
+			FREE_AND_NULL(r->value.update.new_hash);
+			FREE_AND_NULL(r->value.update.message);
+			FREE_AND_NULL(r->value.update.email);
+			FREE_AND_NULL(r->value.update.name);
+			break;
+		case REFTABLE_LOG_DELETION:
+			break;
+		}
+	}
+
+	r->value_type = val_type;
+	if (val_type == REFTABLE_LOG_DELETION)
+		return 0;
+
+	if (in.len < 2 * hash_size)
+		return REFTABLE_FORMAT_ERROR;
+
+	r->value.update.old_hash =
+		reftable_realloc(r->value.update.old_hash, hash_size);
+	r->value.update.new_hash =
+		reftable_realloc(r->value.update.new_hash, hash_size);
+
+	memcpy(r->value.update.old_hash, in.buf, hash_size);
+	memcpy(r->value.update.new_hash, in.buf + hash_size, hash_size);
+
+	string_view_consume(&in, 2 * hash_size);
+
+	n = decode_string(&dest, in);
+	if (n < 0)
+		goto done;
+	string_view_consume(&in, n);
+
+	r->value.update.name =
+		reftable_realloc(r->value.update.name, dest.len + 1);
+	memcpy(r->value.update.name, dest.buf, dest.len);
+	r->value.update.name[dest.len] = 0;
+
+	strbuf_reset(&dest);
+	n = decode_string(&dest, in);
+	if (n < 0)
+		goto done;
+	string_view_consume(&in, n);
+
+	r->value.update.email =
+		reftable_realloc(r->value.update.email, dest.len + 1);
+	memcpy(r->value.update.email, dest.buf, dest.len);
+	r->value.update.email[dest.len] = 0;
+
+	ts = 0;
+	n = get_var_int(&ts, &in);
+	if (n < 0)
+		goto done;
+	string_view_consume(&in, n);
+	r->value.update.time = ts;
+	if (in.len < 2)
+		goto done;
+
+	r->value.update.tz_offset = get_be16(in.buf);
+	string_view_consume(&in, 2);
+
+	strbuf_reset(&dest);
+	n = decode_string(&dest, in);
+	if (n < 0)
+		goto done;
+	string_view_consume(&in, n);
+
+	r->value.update.message =
+		reftable_realloc(r->value.update.message, dest.len + 1);
+	memcpy(r->value.update.message, dest.buf, dest.len);
+	r->value.update.message[dest.len] = 0;
+
+	strbuf_release(&dest);
+	return start.len - in.len;
+
+done:
+	strbuf_release(&dest);
+	return REFTABLE_FORMAT_ERROR;
+}
+
+static int null_streq(char *a, char *b)
+{
+	char *empty = "";
+	if (!a)
+		a = empty;
+
+	if (!b)
+		b = empty;
+
+	return 0 == strcmp(a, b);
+}
+
+static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
+{
+	if (!a)
+		a = zero;
+
+	if (!b)
+		b = zero;
+
+	return !memcmp(a, b, sz);
+}
+
+int reftable_log_record_equal(struct reftable_log_record *a,
+			      struct reftable_log_record *b, int hash_size)
+{
+	if (!(null_streq(a->refname, b->refname) &&
+	      a->update_index == b->update_index &&
+	      a->value_type == b->value_type))
+		return 0;
+
+	switch (a->value_type) {
+	case REFTABLE_LOG_DELETION:
+		return 1;
+	case REFTABLE_LOG_UPDATE:
+		return null_streq(a->value.update.name, b->value.update.name) &&
+		       a->value.update.time == b->value.update.time &&
+		       a->value.update.tz_offset == b->value.update.tz_offset &&
+		       null_streq(a->value.update.email,
+				  b->value.update.email) &&
+		       null_streq(a->value.update.message,
+				  b->value.update.message) &&
+		       zero_hash_eq(a->value.update.old_hash,
+				    b->value.update.old_hash, hash_size) &&
+		       zero_hash_eq(a->value.update.new_hash,
+				    b->value.update.new_hash, hash_size);
+	}
+
+	abort();
+}
+
+static int reftable_log_record_is_deletion_void(const void *p)
+{
+	return reftable_log_record_is_deletion(
+		(const struct reftable_log_record *)p);
+}
+
+static struct reftable_record_vtable reftable_log_record_vtable = {
+	.key = &reftable_log_record_key,
+	.type = BLOCK_TYPE_LOG,
+	.copy_from = &reftable_log_record_copy_from,
+	.val_type = &reftable_log_record_val_type,
+	.encode = &reftable_log_record_encode,
+	.decode = &reftable_log_record_decode,
+	.release = &reftable_log_record_release_void,
+	.is_deletion = &reftable_log_record_is_deletion_void,
+};
+
+struct reftable_record reftable_new_record(uint8_t typ)
+{
+	struct reftable_record rec = { NULL };
+	switch (typ) {
+	case BLOCK_TYPE_REF: {
+		struct reftable_ref_record *r =
+			reftable_calloc(sizeof(struct reftable_ref_record));
+		reftable_record_from_ref(&rec, r);
+		return rec;
+	}
+
+	case BLOCK_TYPE_OBJ: {
+		struct reftable_obj_record *r =
+			reftable_calloc(sizeof(struct reftable_obj_record));
+		reftable_record_from_obj(&rec, r);
+		return rec;
+	}
+	case BLOCK_TYPE_LOG: {
+		struct reftable_log_record *r =
+			reftable_calloc(sizeof(struct reftable_log_record));
+		reftable_record_from_log(&rec, r);
+		return rec;
+	}
+	case BLOCK_TYPE_INDEX: {
+		struct reftable_index_record empty = { .last_key =
+							       STRBUF_INIT };
+		struct reftable_index_record *r =
+			reftable_calloc(sizeof(struct reftable_index_record));
+		*r = empty;
+		reftable_record_from_index(&rec, r);
+		return rec;
+	}
+	}
+	abort();
+	return rec;
+}
+
+/* clear out the record, yielding the reftable_record data that was
+ * encapsulated. */
+static void *reftable_record_yield(struct reftable_record *rec)
+{
+	void *p = rec->data;
+	rec->data = NULL;
+	return p;
+}
+
+void reftable_record_destroy(struct reftable_record *rec)
+{
+	reftable_record_release(rec);
+	reftable_free(reftable_record_yield(rec));
+}
+
+static void reftable_index_record_key(const void *r, struct strbuf *dest)
+{
+	const struct reftable_index_record *rec = r;
+	strbuf_reset(dest);
+	strbuf_addbuf(dest, &rec->last_key);
+}
+
+static void reftable_index_record_copy_from(void *rec, const void *src_rec,
+					    int hash_size)
+{
+	struct reftable_index_record *dst = rec;
+	const struct reftable_index_record *src = src_rec;
+
+	strbuf_reset(&dst->last_key);
+	strbuf_addbuf(&dst->last_key, &src->last_key);
+	dst->offset = src->offset;
+}
+
+static void reftable_index_record_release(void *rec)
+{
+	struct reftable_index_record *idx = rec;
+	strbuf_release(&idx->last_key);
+}
+
+static uint8_t reftable_index_record_val_type(const void *rec)
+{
+	return 0;
+}
+
+static int reftable_index_record_encode(const void *rec, struct string_view out,
+					int hash_size)
+{
+	const struct reftable_index_record *r =
+		(const struct reftable_index_record *)rec;
+	struct string_view start = out;
+
+	int n = put_var_int(&out, r->offset);
+	if (n < 0)
+		return n;
+
+	string_view_consume(&out, n);
+
+	return start.len - out.len;
+}
+
+static int reftable_index_record_decode(void *rec, struct strbuf key,
+					uint8_t val_type, struct string_view in,
+					int hash_size)
+{
+	struct string_view start = in;
+	struct reftable_index_record *r = rec;
+	int n = 0;
+
+	strbuf_reset(&r->last_key);
+	strbuf_addbuf(&r->last_key, &key);
+
+	n = get_var_int(&r->offset, &in);
+	if (n < 0)
+		return n;
+
+	string_view_consume(&in, n);
+	return start.len - in.len;
+}
+
+static struct reftable_record_vtable reftable_index_record_vtable = {
+	.key = &reftable_index_record_key,
+	.type = BLOCK_TYPE_INDEX,
+	.copy_from = &reftable_index_record_copy_from,
+	.val_type = &reftable_index_record_val_type,
+	.encode = &reftable_index_record_encode,
+	.decode = &reftable_index_record_decode,
+	.release = &reftable_index_record_release,
+	.is_deletion = &not_a_deletion,
+};
+
+void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
+{
+	rec->ops->key(rec->data, dest);
+}
+
+uint8_t reftable_record_type(struct reftable_record *rec)
+{
+	return rec->ops->type;
+}
+
+int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
+			   int hash_size)
+{
+	return rec->ops->encode(rec->data, dest, hash_size);
+}
+
+void reftable_record_copy_from(struct reftable_record *rec,
+			       struct reftable_record *src, int hash_size)
+{
+	assert(src->ops->type == rec->ops->type);
+
+	rec->ops->copy_from(rec->data, src->data, hash_size);
+}
+
+uint8_t reftable_record_val_type(struct reftable_record *rec)
+{
+	return rec->ops->val_type(rec->data);
+}
+
+int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
+			   uint8_t extra, struct string_view src, int hash_size)
+{
+	return rec->ops->decode(rec->data, key, extra, src, hash_size);
+}
+
+void reftable_record_release(struct reftable_record *rec)
+{
+	rec->ops->release(rec->data);
+}
+
+int reftable_record_is_deletion(struct reftable_record *rec)
+{
+	return rec->ops->is_deletion(rec->data);
+}
+
+void reftable_record_from_ref(struct reftable_record *rec,
+			      struct reftable_ref_record *ref_rec)
+{
+	assert(!rec->ops);
+	rec->data = ref_rec;
+	rec->ops = &reftable_ref_record_vtable;
+}
+
+void reftable_record_from_obj(struct reftable_record *rec,
+			      struct reftable_obj_record *obj_rec)
+{
+	assert(!rec->ops);
+	rec->data = obj_rec;
+	rec->ops = &reftable_obj_record_vtable;
+}
+
+void reftable_record_from_index(struct reftable_record *rec,
+				struct reftable_index_record *index_rec)
+{
+	assert(!rec->ops);
+	rec->data = index_rec;
+	rec->ops = &reftable_index_record_vtable;
+}
+
+void reftable_record_from_log(struct reftable_record *rec,
+			      struct reftable_log_record *log_rec)
+{
+	assert(!rec->ops);
+	rec->data = log_rec;
+	rec->ops = &reftable_log_record_vtable;
+}
+
+struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *rec)
+{
+	assert(reftable_record_type(rec) == BLOCK_TYPE_REF);
+	return rec->data;
+}
+
+struct reftable_log_record *reftable_record_as_log(struct reftable_record *rec)
+{
+	assert(reftable_record_type(rec) == BLOCK_TYPE_LOG);
+	return rec->data;
+}
+
+static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
+{
+	if (a && b)
+		return !memcmp(a, b, hash_size);
+
+	return a == b;
+}
+
+int reftable_ref_record_equal(struct reftable_ref_record *a,
+			      struct reftable_ref_record *b, int hash_size)
+{
+	assert(hash_size > 0);
+	if (!(0 == strcmp(a->refname, b->refname) &&
+	      a->update_index == b->update_index &&
+	      a->value_type == b->value_type))
+		return 0;
+
+	switch (a->value_type) {
+	case REFTABLE_REF_SYMREF:
+		return !strcmp(a->value.symref, b->value.symref);
+	case REFTABLE_REF_VAL2:
+		return hash_equal(a->value.val2.value, b->value.val2.value,
+				  hash_size) &&
+		       hash_equal(a->value.val2.target_value,
+				  b->value.val2.target_value, hash_size);
+	case REFTABLE_REF_VAL1:
+		return hash_equal(a->value.val1, b->value.val1, hash_size);
+	case REFTABLE_REF_DELETION:
+		return 1;
+	default:
+		abort();
+	}
+}
+
+int reftable_ref_record_compare_name(const void *a, const void *b)
+{
+	return strcmp(((struct reftable_ref_record *)a)->refname,
+		      ((struct reftable_ref_record *)b)->refname);
+}
+
+int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref)
+{
+	return ref->value_type == REFTABLE_REF_DELETION;
+}
+
+int reftable_log_record_compare_key(const void *a, const void *b)
+{
+	const struct reftable_log_record *la = a;
+	const struct reftable_log_record *lb = b;
+
+	int cmp = strcmp(la->refname, lb->refname);
+	if (cmp)
+		return cmp;
+	if (la->update_index > lb->update_index)
+		return -1;
+	return (la->update_index < lb->update_index) ? 1 : 0;
+}
+
+int reftable_log_record_is_deletion(const struct reftable_log_record *log)
+{
+	return (log->value_type == REFTABLE_LOG_DELETION);
+}
+
+void string_view_consume(struct string_view *s, int n)
+{
+	s->buf += n;
+	s->len -= n;
+}
diff --git a/reftable/record.h b/reftable/record.h
new file mode 100644
index 00000000000..498e8c50bf4
--- /dev/null
+++ b/reftable/record.h
@@ -0,0 +1,139 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef RECORD_H
+#define RECORD_H
+
+#include "system.h"
+
+#include <stdint.h>
+
+#include "reftable-record.h"
+
+/*
+ * A substring of existing string data. This structure takes no responsibility
+ * for the lifetime of the data it points to.
+ */
+struct string_view {
+	uint8_t *buf;
+	size_t len;
+};
+
+/* Advance `s.buf` by `n`, and decrease length. */
+void string_view_consume(struct string_view *s, int n);
+
+/* utilities for de/encoding varints */
+
+int get_var_int(uint64_t *dest, struct string_view *in);
+int put_var_int(struct string_view *dest, uint64_t val);
+
+/* Methods for records. */
+struct reftable_record_vtable {
+	/* encode the key of to a uint8_t strbuf. */
+	void (*key)(const void *rec, struct strbuf *dest);
+
+	/* The record type of ('r' for ref). */
+	uint8_t type;
+
+	void (*copy_from)(void *dest, const void *src, int hash_size);
+
+	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
+	 * vs ref deletion) */
+	uint8_t (*val_type)(const void *rec);
+
+	/* encodes rec into dest, returning how much space was used. */
+	int (*encode)(const void *rec, struct string_view dest, int hash_size);
+
+	/* decode data from `src` into the record. */
+	int (*decode)(void *rec, struct strbuf key, uint8_t extra,
+		      struct string_view src, int hash_size);
+
+	/* deallocate and null the record. */
+	void (*release)(void *rec);
+
+	/* is this a tombstone? */
+	int (*is_deletion)(const void *rec);
+};
+
+/* record is a generic wrapper for different types of records. */
+struct reftable_record {
+	void *data;
+	struct reftable_record_vtable *ops;
+};
+
+/* returns true for recognized block types. Block start with the block type. */
+int reftable_is_block_type(uint8_t typ);
+
+/* creates a malloced record of the given type. Dispose with record_destroy */
+struct reftable_record reftable_new_record(uint8_t typ);
+
+/* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Returns
+ * number of bytes written. */
+int reftable_encode_key(int *is_restart, struct string_view dest,
+			struct strbuf prev_key, struct strbuf key,
+			uint8_t extra);
+
+/* Decode into `key` and `extra` from `in` */
+int reftable_decode_key(struct strbuf *key, uint8_t *extra,
+			struct strbuf last_key, struct string_view in);
+
+/* reftable_index_record are used internally to speed up lookups. */
+struct reftable_index_record {
+	uint64_t offset; /* Offset of block */
+	struct strbuf last_key; /* Last key of the block. */
+};
+
+/* reftable_obj_record stores an object ID => ref mapping. */
+struct reftable_obj_record {
+	uint8_t *hash_prefix; /* leading bytes of the object ID */
+	int hash_prefix_len; /* number of leading bytes. Constant
+			      * across a single table. */
+	uint64_t *offsets; /* a vector of file offsets. */
+	int offset_len;
+};
+
+/* see struct record_vtable */
+
+void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
+uint8_t reftable_record_type(struct reftable_record *rec);
+void reftable_record_copy_from(struct reftable_record *rec,
+			       struct reftable_record *src, int hash_size);
+uint8_t reftable_record_val_type(struct reftable_record *rec);
+int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
+			   int hash_size);
+int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
+			   uint8_t extra, struct string_view src,
+			   int hash_size);
+int reftable_record_is_deletion(struct reftable_record *rec);
+
+/* zeroes out the embedded record */
+void reftable_record_release(struct reftable_record *rec);
+
+/* clear and deallocate embedded record, and zero `rec`. */
+void reftable_record_destroy(struct reftable_record *rec);
+
+/* initialize generic records from concrete records. The generic record should
+ * be zeroed out. */
+void reftable_record_from_obj(struct reftable_record *rec,
+			      struct reftable_obj_record *objrec);
+void reftable_record_from_index(struct reftable_record *rec,
+				struct reftable_index_record *idxrec);
+void reftable_record_from_ref(struct reftable_record *rec,
+			      struct reftable_ref_record *refrec);
+void reftable_record_from_log(struct reftable_record *rec,
+			      struct reftable_log_record *logrec);
+struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *ref);
+struct reftable_log_record *reftable_record_as_log(struct reftable_record *ref);
+
+/* for qsort. */
+int reftable_ref_record_compare_name(const void *a, const void *b);
+
+/* for qsort. */
+int reftable_log_record_compare_key(const void *a, const void *b);
+
+#endif
diff --git a/reftable/record_test.c b/reftable/record_test.c
new file mode 100644
index 00000000000..f4ad7cace41
--- /dev/null
+++ b/reftable/record_test.c
@@ -0,0 +1,412 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "record.h"
+
+#include "system.h"
+#include "basics.h"
+#include "constants.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static void test_copy(struct reftable_record *rec)
+{
+	struct reftable_record copy =
+		reftable_new_record(reftable_record_type(rec));
+	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
+	/* do it twice to catch memory leaks */
+	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
+	switch (reftable_record_type(&copy)) {
+	case BLOCK_TYPE_REF:
+		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
+						 reftable_record_as_ref(rec),
+						 GIT_SHA1_RAWSZ));
+		break;
+	case BLOCK_TYPE_LOG:
+		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
+						 reftable_record_as_log(rec),
+						 GIT_SHA1_RAWSZ));
+		break;
+	}
+	reftable_record_destroy(&copy);
+}
+
+static void test_varint_roundtrip(void)
+{
+	uint64_t inputs[] = { 0,
+			      1,
+			      27,
+			      127,
+			      128,
+			      257,
+			      4096,
+			      ((uint64_t)1 << 63),
+			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
+	int i = 0;
+	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
+		uint8_t dest[10];
+
+		struct string_view out = {
+			.buf = dest,
+			.len = sizeof(dest),
+		};
+		uint64_t in = inputs[i];
+		int n = put_var_int(&out, in);
+		uint64_t got = 0;
+
+		EXPECT(n > 0);
+		out.len = n;
+		n = get_var_int(&got, &out);
+		EXPECT(n > 0);
+
+		EXPECT(got == in);
+	}
+}
+
+static void test_common_prefix(void)
+{
+	struct {
+		const char *a, *b;
+		int want;
+	} cases[] = {
+		{ "abc", "ab", 2 },
+		{ "", "abc", 0 },
+		{ "abc", "abd", 2 },
+		{ "abc", "pqr", 0 },
+	};
+
+	int i = 0;
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct strbuf a = STRBUF_INIT;
+		struct strbuf b = STRBUF_INIT;
+		strbuf_addstr(&a, cases[i].a);
+		strbuf_addstr(&b, cases[i].b);
+		EXPECT(common_prefix_size(&a, &b) == cases[i].want);
+
+		strbuf_release(&a);
+		strbuf_release(&b);
+	}
+}
+
+static void set_hash(uint8_t *h, int j)
+{
+	int i = 0;
+	for (i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++) {
+		h[i] = (j >> i) & 0xff;
+	}
+}
+
+static void test_reftable_ref_record_roundtrip(void)
+{
+	int i = 0;
+
+	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
+		struct reftable_ref_record in = { NULL };
+		struct reftable_ref_record out = { NULL };
+		struct reftable_record rec_out = { NULL };
+		struct strbuf key = STRBUF_INIT;
+		struct reftable_record rec = { NULL };
+		uint8_t buffer[1024] = { 0 };
+		struct string_view dest = {
+			.buf = buffer,
+			.len = sizeof(buffer),
+		};
+
+		int n, m;
+
+		in.value_type = i;
+		switch (i) {
+		case REFTABLE_REF_DELETION:
+			break;
+		case REFTABLE_REF_VAL1:
+			in.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
+			set_hash(in.value.val1, 1);
+			break;
+		case REFTABLE_REF_VAL2:
+			in.value.val2.value = reftable_malloc(GIT_SHA1_RAWSZ);
+			set_hash(in.value.val2.value, 1);
+			in.value.val2.target_value =
+				reftable_malloc(GIT_SHA1_RAWSZ);
+			set_hash(in.value.val2.target_value, 2);
+			break;
+		case REFTABLE_REF_SYMREF:
+			in.value.symref = xstrdup("target");
+			break;
+		}
+		in.refname = xstrdup("refs/heads/master");
+
+		reftable_record_from_ref(&rec, &in);
+		test_copy(&rec);
+
+		EXPECT(reftable_record_val_type(&rec) == i);
+
+		reftable_record_key(&rec, &key);
+		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+		EXPECT(n > 0);
+
+		/* decode into a non-zero reftable_record to test for leaks. */
+
+		reftable_record_from_ref(&rec_out, &out);
+		m = reftable_record_decode(&rec_out, key, i, dest,
+					   GIT_SHA1_RAWSZ);
+		EXPECT(n == m);
+
+		EXPECT(reftable_ref_record_equal(&in, &out, GIT_SHA1_RAWSZ));
+		reftable_record_release(&rec_out);
+
+		strbuf_release(&key);
+		reftable_ref_record_release(&in);
+	}
+}
+
+static void test_reftable_log_record_equal(void)
+{
+	struct reftable_log_record in[2] = {
+		{
+			.refname = xstrdup("refs/heads/master"),
+			.update_index = 42,
+		},
+		{
+			.refname = xstrdup("refs/heads/master"),
+			.update_index = 22,
+		}
+	};
+
+	EXPECT(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	in[1].update_index = in[0].update_index;
+	EXPECT(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	reftable_log_record_release(&in[0]);
+	reftable_log_record_release(&in[1]);
+}
+
+static void test_reftable_log_record_roundtrip(void)
+{
+	int i;
+	struct reftable_log_record in[2] = {
+		{
+			.refname = xstrdup("refs/heads/master"),
+			.update_index = 42,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = {
+				.update = {
+					.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
+					.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
+					.name = xstrdup("han-wen"),
+					.email = xstrdup("hanwen@google.com"),
+					.message = xstrdup("test"),
+					.time = 1577123507,
+					.tz_offset = 100,
+				},
+			}
+		},
+		{
+			.refname = xstrdup("refs/heads/master"),
+			.update_index = 22,
+			.value_type = REFTABLE_LOG_DELETION,
+		}
+	};
+	set_test_hash(in[0].value.update.new_hash, 1);
+	set_test_hash(in[0].value.update.old_hash, 2);
+	for (i = 0; i < ARRAY_SIZE(in); i++) {
+		struct reftable_record rec = { NULL };
+		struct strbuf key = STRBUF_INIT;
+		uint8_t buffer[1024] = { 0 };
+		struct string_view dest = {
+			.buf = buffer,
+			.len = sizeof(buffer),
+		};
+		/* populate out, to check for leaks. */
+		struct reftable_log_record out = {
+			.refname = xstrdup("old name"),
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value = {
+				.update = {
+					.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
+					.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
+					.name = xstrdup("old name"),
+					.email = xstrdup("old@email"),
+					.message = xstrdup("old message"),
+				},
+			},
+		};
+		struct reftable_record rec_out = { NULL };
+		int n, m, valtype;
+
+		reftable_record_from_log(&rec, &in[i]);
+
+		test_copy(&rec);
+
+		reftable_record_key(&rec, &key);
+
+		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+		EXPECT(n >= 0);
+		reftable_record_from_log(&rec_out, &out);
+		valtype = reftable_record_val_type(&rec);
+		m = reftable_record_decode(&rec_out, key, valtype, dest,
+					   GIT_SHA1_RAWSZ);
+		EXPECT(n == m);
+
+		EXPECT(reftable_log_record_equal(&in[i], &out, GIT_SHA1_RAWSZ));
+		reftable_log_record_release(&in[i]);
+		strbuf_release(&key);
+		reftable_record_release(&rec_out);
+	}
+}
+
+static void test_u24_roundtrip(void)
+{
+	uint32_t in = 0x112233;
+	uint8_t dest[3];
+	uint32_t out;
+	put_be24(dest, in);
+	out = get_be24(dest);
+	EXPECT(in == out);
+}
+
+static void test_key_roundtrip(void)
+{
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+	struct strbuf last_key = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
+	struct strbuf roundtrip = STRBUF_INIT;
+	int restart;
+	uint8_t extra;
+	int n, m;
+	uint8_t rt_extra;
+
+	strbuf_addstr(&last_key, "refs/heads/master");
+	strbuf_addstr(&key, "refs/tags/bla");
+	extra = 6;
+	n = reftable_encode_key(&restart, dest, last_key, key, extra);
+	EXPECT(!restart);
+	EXPECT(n > 0);
+
+	m = reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
+	EXPECT(n == m);
+	EXPECT(0 == strbuf_cmp(&key, &roundtrip));
+	EXPECT(rt_extra == extra);
+
+	strbuf_release(&last_key);
+	strbuf_release(&key);
+	strbuf_release(&roundtrip);
+}
+
+static void test_reftable_obj_record_roundtrip(void)
+{
+	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
+	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
+	struct reftable_obj_record recs[3] = { {
+						       .hash_prefix = testHash1,
+						       .hash_prefix_len = 5,
+						       .offsets = till9,
+						       .offset_len = 3,
+					       },
+					       {
+						       .hash_prefix = testHash1,
+						       .hash_prefix_len = 5,
+						       .offsets = till9,
+						       .offset_len = 9,
+					       },
+					       {
+						       .hash_prefix = testHash1,
+						       .hash_prefix_len = 5,
+					       } };
+	int i = 0;
+	for (i = 0; i < ARRAY_SIZE(recs); i++) {
+		struct reftable_obj_record in = recs[i];
+		uint8_t buffer[1024] = { 0 };
+		struct string_view dest = {
+			.buf = buffer,
+			.len = sizeof(buffer),
+		};
+		struct reftable_record rec = { NULL };
+		struct strbuf key = STRBUF_INIT;
+		struct reftable_obj_record out = { NULL };
+		struct reftable_record rec_out = { NULL };
+		int n, m;
+		uint8_t extra;
+
+		reftable_record_from_obj(&rec, &in);
+		test_copy(&rec);
+		reftable_record_key(&rec, &key);
+		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+		EXPECT(n > 0);
+		extra = reftable_record_val_type(&rec);
+		reftable_record_from_obj(&rec_out, &out);
+		m = reftable_record_decode(&rec_out, key, extra, dest,
+					   GIT_SHA1_RAWSZ);
+		EXPECT(n == m);
+
+		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
+		EXPECT(in.offset_len == out.offset_len);
+
+		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
+			       in.hash_prefix_len));
+		EXPECT(0 == memcmp(in.offsets, out.offsets,
+				   sizeof(uint64_t) * in.offset_len));
+		strbuf_release(&key);
+		reftable_record_release(&rec_out);
+	}
+}
+
+static void test_reftable_index_record_roundtrip(void)
+{
+	struct reftable_index_record in = {
+		.offset = 42,
+		.last_key = STRBUF_INIT,
+	};
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+	struct strbuf key = STRBUF_INIT;
+	struct reftable_record rec = { NULL };
+	struct reftable_index_record out = { .last_key = STRBUF_INIT };
+	struct reftable_record out_rec = { NULL };
+	int n, m;
+	uint8_t extra;
+
+	strbuf_addstr(&in.last_key, "refs/heads/master");
+	reftable_record_from_index(&rec, &in);
+	reftable_record_key(&rec, &key);
+	test_copy(&rec);
+
+	EXPECT(0 == strbuf_cmp(&key, &in.last_key));
+	n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+	EXPECT(n > 0);
+
+	extra = reftable_record_val_type(&rec);
+	reftable_record_from_index(&out_rec, &out);
+	m = reftable_record_decode(&out_rec, key, extra, dest, GIT_SHA1_RAWSZ);
+	EXPECT(m == n);
+
+	EXPECT(in.offset == out.offset);
+
+	reftable_record_release(&out_rec);
+	strbuf_release(&key);
+	strbuf_release(&in.last_key);
+}
+
+int record_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_reftable_log_record_equal);
+	RUN_TEST(test_reftable_log_record_roundtrip);
+	RUN_TEST(test_reftable_ref_record_roundtrip);
+	RUN_TEST(test_varint_roundtrip);
+	RUN_TEST(test_key_roundtrip);
+	RUN_TEST(test_common_prefix);
+	RUN_TEST(test_reftable_obj_record_roundtrip);
+	RUN_TEST(test_reftable_index_record_roundtrip);
+	RUN_TEST(test_u24_roundtrip);
+	return 0;
+}
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
new file mode 100644
index 00000000000..5370d2288c7
--- /dev/null
+++ b/reftable/reftable-record.h
@@ -0,0 +1,114 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_RECORD_H
+#define REFTABLE_RECORD_H
+
+#include <stdint.h>
+
+/*
+ * Basic data types
+ *
+ * Reftables store the state of each ref in struct reftable_ref_record, and they
+ * store a sequence of reflog updates in struct reftable_log_record.
+ */
+
+/* reftable_ref_record holds a ref database entry target_value */
+struct reftable_ref_record {
+	char *refname; /* Name of the ref, malloced. */
+	uint64_t update_index; /* Logical timestamp at which this value is
+				* written */
+
+	enum {
+		/* tombstone to hide deletions from earlier tables */
+		REFTABLE_REF_DELETION = 0x0,
+
+		/* a simple ref */
+		REFTABLE_REF_VAL1 = 0x1,
+		/* a tag, plus its peeled hash */
+		REFTABLE_REF_VAL2 = 0x2,
+
+		/* a symbolic reference */
+		REFTABLE_REF_SYMREF = 0x3,
+#define REFTABLE_NR_REF_VALUETYPES 4
+	} value_type;
+	union {
+		uint8_t *val1; /* malloced hash. */
+		struct {
+			uint8_t *value; /* first value, malloced hash  */
+			uint8_t *target_value; /* second value, malloced hash */
+		} val2;
+		char *symref; /* referent, malloced 0-terminated string */
+	} value;
+};
+
+/* Returns the first hash, or NULL if `rec` is not of type
+ * REFTABLE_REF_VAL1 or REFTABLE_REF_VAL2. */
+uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec);
+
+/* Returns the second hash, or NULL if `rec` is not of type
+ * REFTABLE_REF_VAL2. */
+uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec);
+
+/* returns whether 'ref' represents a deletion */
+int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
+
+/* prints a reftable_ref_record onto stdout. Useful for debugging. */
+void reftable_ref_record_print(struct reftable_ref_record *ref,
+			       uint32_t hash_id);
+
+/* frees and nulls all pointer values inside `ref`. */
+void reftable_ref_record_release(struct reftable_ref_record *ref);
+
+/* returns whether two reftable_ref_records are the same. Useful for testing. */
+int reftable_ref_record_equal(struct reftable_ref_record *a,
+			      struct reftable_ref_record *b, int hash_size);
+
+/* reftable_log_record holds a reflog entry */
+struct reftable_log_record {
+	char *refname;
+	uint64_t update_index; /* logical timestamp of a transactional update.
+				*/
+
+	enum {
+		/* tombstone to hide deletions from earlier tables */
+		REFTABLE_LOG_DELETION = 0x0,
+
+		/* a simple update */
+		REFTABLE_LOG_UPDATE = 0x1,
+#define REFTABLE_NR_LOG_VALUETYPES 2
+	} value_type;
+
+	union {
+		struct {
+			uint8_t *new_hash;
+			uint8_t *old_hash;
+			char *name;
+			char *email;
+			uint64_t time;
+			int16_t tz_offset;
+			char *message;
+		} update;
+	} value;
+};
+
+/* returns whether 'ref' represents the deletion of a log record. */
+int reftable_log_record_is_deletion(const struct reftable_log_record *log);
+
+/* frees and nulls all pointer values. */
+void reftable_log_record_release(struct reftable_log_record *log);
+
+/* returns whether two records are equal. Useful for testing. */
+int reftable_log_record_equal(struct reftable_log_record *a,
+			      struct reftable_log_record *b, int hash_size);
+
+/* dumps a reftable_log_record on stdout, for debugging/testing. */
+void reftable_log_record_print(struct reftable_log_record *log,
+			       uint32_t hash_id);
+
+#endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 3b58e423e7b..09d4b83ef9b 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -4,6 +4,6 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	basics_test_main(argc, argv);
-
+	record_test_main(argc, argv);
 	return 0;
 }
-- 
gitgitgadget

