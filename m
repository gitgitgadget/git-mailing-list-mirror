Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69D3955EC
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989887; cv=none; b=caPZbPDML8Vn9OImdj2MKmjw/7mMaAfZSJ+YKeGjPL7pD1SYssQfkbKqQDpSwTmG/OwflgHZXSvNB2Qib+LrGwYw/NFJLeJ+0ujnW27M3cm7EWKUGsl+bh39jLZaCqSRwu1SmrsoVrfe7gP0KpMFuN/CrAp+jNTQD8IP8fv3wxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989887; c=relaxed/simple;
	bh=428qrIQ/Iu2JEBgYCURmlj36Y3QGu4w7dplFAQoK2eE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=a0f4OUlImBjEWNXFhIW/Jb5fVomil6l9j5I85361baA2ApjKZfgS6oDdNSQZbSK5IDB5I42ZSOR24bsOoM39WABjozAw+x3rMteOSstuBMwEjD3XNkjPwMaf0Dq0xxfBckmOE/6U2k9qobyiuaCf9/S8Ajl4Dk+t5egGe6lseXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYFUySL5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYFUySL5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso298613b3a.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791989886; x=1792594686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uMHV0ciaecmHJrRax51lnepv0Gh9kYoH1KbA6biNSpw=;
        b=PYFUySL5ElgSK8DUVLaEryzjHGcCSib9HJt0Nh5/d3vQyQ0s3rPycWM5QSfszE6m1s
         5WixF19v9ddseMHQvcgkZk03hy5MIW/xJE9i+aEb4/+3Y8azQnZYRAenA3xYDwMjgwpP
         r4Izjz5S3kWk+K2YJn+jIl19FiffWHcx8y6+uI3YqHGdDipeS/PgBFY1g6dASCYcck29
         3mFlAAzuW2x6QMAWf6PbV4Y3pFjOUQ2iiE5xpYhi1u8YBS6aaWaPkbeQzb48kbUcBWwp
         6435ltVYZ7wJJRDbWV6zMbgU+/pmFbRqZOmS2lyx77orIDwz5N9XiDouZV7k8i29L33Q
         aEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989886; x=1792594686;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uMHV0ciaecmHJrRax51lnepv0Gh9kYoH1KbA6biNSpw=;
        b=db38ZXZQVIUJ7Xq2lRTUMqU3AjYyGpROMjd8N7S0W2HMGnUgOYgkEpdHbr0PqP9e7K
         ex7Bubn5actgw9kQPDsLOZbhjOiEKAaPIdTfFacG2+LrtzKEPrMl8fO2lcK0x+W2gEph
         NrNyGuhiwTMAOQWLOIs56zFFLcbw6GnrqdLn8SU/c1XnmsR+oT9u1KC2M19yX9cVfnei
         LB9NHOSFKciVyhEU2gSzghbq/873sdmqHHsc98aqh5GaDk931jwABqrm4icTOOu2xtWc
         L/rPjXf9JgHqSIojOU7g4CeT2iF0ETINU2oisKKt9S8xKacJJis4seb8vq5uQOmfuKvq
         RIKA==
X-Gm-Message-State: AFq9FYJF2g0XbYlA1rgeOKq4n2r6tx19YNbHlMhp2fJzlEYpXEleNXUC
	mhwqf1d840cDSzpGO0ao5Ib9mUfWlxPEMfljeP64o6qOWT9NyOxg+KR9lWJUWg==
X-Gm-Gg: AYBFou2NlcYZLX8YQogWpS9B/SjivIQJTiU8LR5mJngHzNa+VcJserMZhbl0kx5lYjh
	tsh/1unt0rPW2lFpRF3j8Y+hJvi34dWcwxgkbrjhiIRdXeUEVKQV2ot4ggjslnE5AmRzAcsifHL
	pxIo8XrocDq8cE8Om03PGRqLl8R3yifpSlQBM+//la5IeQaRGXD7HtHHAfk5S2OywlU9Vj7QvPY
	9ZuHDW9UaiG9YSqZwFV7wMXmBJHNaiebECnhzHTxydsPIdm+ufOty0jQXJ1PB2ByOSV+dQbDRvv
	iGX3mgyZhE4Yds+XjyEN3MhZJ7CQ8L35gCnVioi9MODuCrqZd9f6qBLssYqk9ftjHKnN4YQC/m3
	o/gkExubbp3uezcHvTxkRHFvQIPC1ELKaso176e1mufiu8Q7cn7Vx5s6cvQAdd1izLzfgxdFdZ5
	U/fupCHmdPaQUZYY5SUePKtEZiXUp4CZpWyyjR8FG1b5RjX6bX9PSnZq+0BSVS5vaD+qLWpVRJs
	w==
X-Received: by 2002:a05:6a00:3404:b0:881:4b47:f31a with SMTP id d2e1a72fcca58-897c6539ee1mr14687193b3a.11.1791989885629;
        Wed, 14 Oct 2026 07:58:05 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.61.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d8052ba4asm1216478b3a.60.2026.10.14.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:58:04 -0700 (PDT)
Message-Id: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
From: "Matthew Suozzo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 14:58:03 +0000
Subject: [PATCH] reftable/record: bound an object record's offset count by its
 length
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Matthew Suozzo <m@suozzo.co>,
    Matthew Suozzo <m@suozzo.co>

From: Matthew Suozzo <m@suozzo.co>

An object record's count of offsets is a 64-bit varint from the table,
and reftable_obj_record_decode() allocates the offsets array from it
through REFTABLE_ALLOC_ARRAY(), which takes a size_t. Where size_t is
32 bits, a count of 2^32 + 1 allocates room for one offset, and the
loop, which runs to the full count, writes an offset from the table
for each varint left in the block past the end of the array. Where
size_t is 64 bits, a large count only makes a large allocation that
the decode then fails to fill.

Nothing in Git reaches this decoder from a repository: a block of a
type other than the one wanted is refused before its records are
decoded, and the object index, the only reader of object blocks, is
used only by the unit tests. The decoder is still wrong.

Each offset takes at least a byte, so refuse a count larger than what
is left of the record.

The Makefile did not build the reftable record unit tests (the Meson
build does). Add the suite there so that the new test runs in both.

Assisted-by: Claude Opus 5.5, Claude Fable 5.1
Signed-off-by: Matthew Suozzo <m@suozzo.co>
---
    reftable/record: bound an object record's offset count by its length

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2255%2Fmsuozzo%2Freftable-obj-record-count-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2255/msuozzo/reftable-obj-record-count-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2255

 Makefile                         |  1 +
 reftable/record.c                |  4 ++++
 t/unit-tests/u-reftable-record.c | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Makefile b/Makefile
index a96be506b5..66b7270fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -1551,6 +1551,7 @@ CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-readwrite
+CLAR_TEST_SUITES += u-reftable-record
 CLAR_TEST_SUITES += u-reftable-stack
 CLAR_TEST_SUITES += u-reftable-table
 CLAR_TEST_SUITES += u-reftable-tree
diff --git a/reftable/record.c b/reftable/record.c
index 1fce441930..96eceddca7 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -589,6 +589,10 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	if (count == 0)
 		return start.len - in.len;
 
+	/* each offset takes at least a byte */
+	if (count > in.len)
+		return REFTABLE_FORMAT_ERROR;
+
 	REFTABLE_ALLOC_ARRAY(r->offsets, count);
 	if (!r->offsets)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
index 9c95083ef4..0165b74bcb 100644
--- a/t/unit-tests/u-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -524,6 +524,41 @@ void test_reftable_record__obj_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
+void test_reftable_record__obj_record_decode_count_larger_than_record(void)
+{
+	struct reftable_buf key = REFTABLE_BUF_INIT, scratch = REFTABLE_BUF_INIT;
+	struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_OBJ };
+	uint8_t buffer[32];
+	struct string_view dest = { .buf = buffer, .len = sizeof(buffer) }, in;
+	int n;
+
+	/*
+	 * A count of offsets that a 32-bit size_t truncates to one,
+	 * followed by two offsets.
+	 */
+	n = put_var_int(&dest, ((uint64_t)1 << 32) + 1);
+	cl_assert_gt_i(n, 0);
+	string_view_consume(&dest, n);
+	n = put_var_int(&dest, 1);
+	cl_assert_gt_i(n, 0);
+	string_view_consume(&dest, n);
+	n = put_var_int(&dest, 1);
+	cl_assert_gt_i(n, 0);
+	string_view_consume(&dest, n);
+
+	in.buf = buffer;
+	in.len = sizeof(buffer) - dest.len;
+
+	cl_assert_equal_i(reftable_buf_addstr(&key, "\x01\x02"), 0);
+	cl_assert_equal_i(reftable_record_decode(&rec, key, 0, in,
+						 REFTABLE_HASH_SIZE_SHA1, &scratch),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_record_release(&rec);
+	reftable_buf_release(&key);
+	reftable_buf_release(&scratch);
+}
+
 void test_reftable_record__index_record_comparison(void)
 {
 	struct reftable_record in[3] = {

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
