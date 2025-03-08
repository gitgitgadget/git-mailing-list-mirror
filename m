Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE061BEF74
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741440839; cv=none; b=FFLFQR927gE6xUt18ixhicLrMLP92wIJ5atvw5jTa2en/RxAKedOm0iRNcBiWhyE+4p+dP8iXfMVVUre2gllfbmHBV2hjSBQtUa35MEbJp+esUE5HsQOX01qb2Lw0OoxGYA+3glOJjjVqZ5ktsPGYItnsdmqTwVzT+KAE7urwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741440839; c=relaxed/simple;
	bh=pqJCDTFU7cLr8tDLIO4JjiRGC6RNwUJgKOpMI4PDmpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iH7wvG8T85bLVfFMoKBXCBnKNh9rndBu/h2FfQCRz5OivswPJedlQEVptCBXhJhYW4ls75+ojuAgpgpiexcD1vKL53LdkDurPmwYZOJHgst8vVgcY8dNsaFRKAk+mx1cps19367xmIMYp1d66eINLDIiIVlfiGYe1ObvtPES1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS/quNs/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS/quNs/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2254e0b4b79so7057625ad.2
        for <git@vger.kernel.org>; Sat, 08 Mar 2025 05:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741440836; x=1742045636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD0GcYqvYfoPH6WHSaGOCtV9Q/ixlWeRBeY5ej5YeGc=;
        b=bS/quNs/KdRSBapxTl5XAWJcj81iIwR5Wq3jTuDT0B+9zCch8LD6TreDkugspcfQYJ
         PkKOxtkcDPKMdmG6htjGLmoanhIoqvxc7dAcfWEqh1MxDIjPk50zSDadkFnYBVE3WwSk
         vJPqSIDdzsr3Vop/AkgJ+dlIkt7S5Io2izzwzPnq9qyZZviW9Tqgv3FLz2Mn2Wgxxmuu
         X+2QjJyHSUNusItphJgTyTXchKFCLKzwRnMZU/UJlSKQAoBArxUSkomqZ2/DNwnJGCNq
         91M968/chPQT+sf08DLrl8h4u6LHIIiK+tguSUcPFk7ondXQhwEghHvATsi8CaB6bo19
         gPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741440836; x=1742045636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD0GcYqvYfoPH6WHSaGOCtV9Q/ixlWeRBeY5ej5YeGc=;
        b=MrgLzKFTHP0w1lyOedffYqlv0RZCdFqYrlvwDU+2hRga8T5X3VPy0FVjZMGiKQcx5D
         JQ0iBur71MRprVghnB0GR8NRCVNZYGkf14UFWJVd/DLlEavzWUkiTH3wSYzLRIvKpCE+
         7ArXtI8ZRoybpItQaFzIj+uKXz1PiANymVHHE+kFmOvHQp0L0796T/pExa6XBR8mB9oc
         hB4zX6ZNHfQs/48GBZa/6uUotSwYJrAHzkXjsfGxnPFIfhpLw5PFmrZsc1fC6srGutQN
         P/vBjHePgKXbdu6B+lbSg7IhLc4xzvxO8h9ixwe53JRTMHGAxPxCWr7BTqH6m0DlqvTm
         twzg==
X-Gm-Message-State: AOJu0YwKNanRA337TtkFPAh/ilsaeVsOMwQf9J5qozhoM2ZSi716VhLc
	scSk5VUdv1dbyWk9acwPZD8HJoxI1GGatIitrAKZ4GL+vQrFUjxfwUb04w==
X-Gm-Gg: ASbGnct8RQPXUEAcgnjMFwd2KNrooRFI9ED+m+trIdNX1t9ODW3z4F8gVJhPFsgsYZs
	UPRyPcGPNGx95VW5Wz1PtRxsqUL0OxN6dDxUti2r9vYbw827mzVvrPydLWSwaWUl9xx7jpvDeka
	owTCbuAoGL83cxUp3Dkolz19eMIvomDuyy6vAwKtPUWq4V+obJ2y3O/6EAU+EKo2h2eTgkEJz7t
	rrFc8bUHQ3SzlYvcxN5WrZGYBv9qPfnlsQVfmHjGmMIwkF8Q63m55h2JJQD/JvyaHzIVbkBhm6x
	xBRrKnca3sTG/Oy+jfOZTWKD/6OY8KxuA0rckI2P
X-Google-Smtp-Source: AGHT+IGlNoYkjWxxionIe/we8hzUePFtL28kGG4g6D9ClZmkmKTA6kuCqwscMYnY1ggroJRIeZsNQw==
X-Received: by 2002:a17:902:f644:b0:224:76f:9e45 with SMTP id d9443c01a7336-22428a8c6femr130950445ad.21.1741440836236;
        Sat, 08 Mar 2025 05:33:56 -0800 (PST)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e9fbfsm46763585ad.92.2025.03.08.05.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 05:33:55 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v2] reftable: return proper error code from block_writer_add()
Date: Sat,  8 Mar 2025 19:03:49 +0530
Message-Id: <20250308133349.1591331-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306121324.1315290-1-meetsoni3017@gmail.com>
References: <20250306121324.1315290-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, block_writer_add() used to return generic -1, which forced
an assumption about the error type. Replace these generic -1 returns in
block_writer_add() and related functions with defined error codes.

Reviewed all call sites to ensure they check for nonzero error returns
rather than strictly -1, confirming that this change is safe.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
This patch attempts to avoid making an assumption regarding error codes
returned by block_writer_add().

Changes since v1:
  - Update commit message to specify safe usage of the patch.
  - Update function doc comment.
  - Propagate errors to `->key()` and `->encode()` functions instead of 
    making any assumptions.
 
Dropped Han-Wen Nienhuys <hanwen@google.com> from CC, as the email doesn't exist.
Range-diff against v1:
1:  10d8bbeebc < -:  ---------- reftable: return proper error code from block_writer_add()
-:  ---------- > 1:  7cdc7ce0ce reftable: return proper error code from block_writer_add()

 reftable/block.c  | 12 +++++------
 reftable/block.h  |  2 +-
 reftable/record.c | 53 +++++++++++++++++++++--------------------------
 reftable/writer.c | 11 ++--------
 4 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index b14a8f1259..89ab8bbc57 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -49,7 +49,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	if (is_restart)
 		rlen++;
 	if (2 + 3 * rlen + n > w->block_size - w->next)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	if (is_restart) {
 		REFTABLE_ALLOC_GROW_OR_NULL(w->restarts, w->restart_len + 1,
 					    w->restart_cap);
@@ -97,9 +97,9 @@ uint8_t block_writer_type(struct block_writer *bw)
 	return bw->block[bw->header_off];
 }
 
-/* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
-   success. Returns REFTABLE_API_ERROR if attempting to write a record with
-   empty key. */
+/* Adds the reftable_record to the block. Returns 0 on success and
+ * appropriate error codes on failure.
+ */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 {
 	struct reftable_buf empty = REFTABLE_BUF_INIT;
@@ -126,14 +126,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	n = reftable_encode_key(&is_restart, out, last, w->scratch,
 				reftable_record_val_type(rec));
 	if (n < 0) {
-		err = -1;
+		err = n;
 		goto done;
 	}
 	string_view_consume(&out, n);
 
 	n = reftable_record_encode(rec, out, w->hash_size);
 	if (n < 0) {
-		err = -1;
+		err = n;
 		goto done;
 	}
 	string_view_consume(&out, n);
diff --git a/reftable/block.h b/reftable/block.h
index bef2b8a4c5..0e7c680cf6 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -53,7 +53,7 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
 /* returns the block type (eg. 'r' for ref records. */
 uint8_t block_writer_type(struct block_writer *bw);
 
-/* appends the record, or -1 if it doesn't fit. */
+/* attempts to append the record. returns 0 on success or error code on failure. */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec);
 
 /* appends the key restarts, and compress the block if necessary. */
diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..d9fba8ff38 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -61,7 +61,7 @@ int put_var_int(struct string_view *dest, uint64_t value)
 	while (value >>= 7)
 		varint[--pos] = 0x80 | (--value & 0x7f);
 	if (dest->len < sizeof(varint) - pos)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(dest->buf, varint + pos, sizeof(varint) - pos);
 	return sizeof(varint) - pos;
 }
@@ -129,10 +129,10 @@ static int encode_string(const char *str, struct string_view s)
 	size_t l = strlen(str);
 	int n = put_var_int(&s, l);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 	if (s.len < l)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(s.buf, str, l);
 	string_view_consume(&s, l);
 
@@ -148,18 +148,18 @@ int reftable_encode_key(int *restart, struct string_view dest,
 	uint64_t suffix_len = key.len - prefix_len;
 	int n = put_var_int(&dest, prefix_len);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&dest, n);
 
 	*restart = (prefix_len == 0);
 
 	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&dest, n);
 
 	if (dest.len < suffix_len)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
 	string_view_consume(&dest, suffix_len);
 
@@ -324,30 +324,27 @@ static int reftable_ref_record_encode(const void *rec, struct string_view s,
 	struct string_view start = s;
 	int n = put_var_int(&s, r->update_index);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	switch (r->value_type) {
 	case REFTABLE_REF_SYMREF:
 		n = encode_string(r->value.symref, s);
-		if (n < 0) {
-			return -1;
-		}
+		if (n < 0)
+			return n;
 		string_view_consume(&s, n);
 		break;
 	case REFTABLE_REF_VAL2:
-		if (s.len < 2 * hash_size) {
-			return -1;
-		}
+		if (s.len < 2 * hash_size)
+			return REFTABLE_ENTRY_TOO_BIG_ERROR;
 		memcpy(s.buf, r->value.val2.value, hash_size);
 		string_view_consume(&s, hash_size);
 		memcpy(s.buf, r->value.val2.target_value, hash_size);
 		string_view_consume(&s, hash_size);
 		break;
 	case REFTABLE_REF_VAL1:
-		if (s.len < hash_size) {
-			return -1;
-		}
+		if (s.len < hash_size)
+			return REFTABLE_ENTRY_TOO_BIG_ERROR;
 		memcpy(s.buf, r->value.val1, hash_size);
 		string_view_consume(&s, hash_size);
 		break;
@@ -531,24 +528,22 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 	uint64_t last = 0;
 	if (r->offset_len == 0 || r->offset_len >= 8) {
 		n = put_var_int(&s, r->offset_len);
-		if (n < 0) {
-			return -1;
-		}
+		if (n < 0)
+			return n;
 		string_view_consume(&s, n);
 	}
 	if (r->offset_len == 0)
 		return start.len - s.len;
 	n = put_var_int(&s, r->offsets[0]);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	last = r->offsets[0];
 	for (i = 1; i < r->offset_len; i++) {
 		int n = put_var_int(&s, r->offsets[i] - last);
-		if (n < 0) {
-			return -1;
-		}
+		if (n < 0)
+			return n;
 		string_view_consume(&s, n);
 		last = r->offsets[i];
 	}
@@ -783,7 +778,7 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 		return 0;
 
 	if (s.len < 2 * hash_size)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 
 	memcpy(s.buf, r->value.update.old_hash, hash_size);
 	memcpy(s.buf + hash_size, r->value.update.new_hash, hash_size);
@@ -791,22 +786,22 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 
 	n = encode_string(r->value.update.name ? r->value.update.name : "", s);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	n = encode_string(r->value.update.email ? r->value.update.email : "",
 			  s);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	n = put_var_int(&s, r->value.update.time);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	if (s.len < 2)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 
 	put_be16(s.buf, r->value.update.tz_offset);
 	string_view_consume(&s, 2);
@@ -814,7 +809,7 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 	n = encode_string(
 		r->value.update.message ? r->value.update.message : "", s);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	return start.len - s.len;
diff --git a/reftable/writer.c b/reftable/writer.c
index f3ab1035d6..5cb9d0bf85 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -327,18 +327,11 @@ static int writer_add_record(struct reftable_writer *w,
 		goto done;
 
 	/*
-	 * Try to add the record to the writer again. If this still fails then
-	 * the record does not fit into the block size.
-	 *
-	 * TODO: it would be great to have `block_writer_add()` return proper
-	 *       error codes so that we don't have to second-guess the failure
-	 *       mode here.
+	 * Try to add the record to the writer again.
 	 */
 	err = block_writer_add(w->block_writer, rec);
-	if (err) {
-		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
+	if (err)
 		goto done;
-	}
 
 done:
 	return err;
-- 
2.34.1

