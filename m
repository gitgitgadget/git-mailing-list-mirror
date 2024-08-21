Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046D18C929
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244143; cv=none; b=losSX8ppeHMBbAMzlf9sFWFD8xLrUsu444mkntF0+6TvTxXx4cdNecAdWFmq0Q2Ol7kNkrcYIlyqqBOytCN7V8l2hBduWca2Yo3Qxp2GXSTZ1tKVnMy9K1ijzHihwP1YZJ+JylKixWYU2zfllNQP4QLWYFWq2gZOK9JmibtMUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244143; c=relaxed/simple;
	bh=61cKOBkwMaN3Pb6Bz8j2jjKcVO5mWqMNJZdQ2PWxCm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBiKAaFl7HrnhSjSpa7WxmCJgljTYNjwo3reUbr/0cLNXiVEEpSysPJMZ9DunahhK//munOwqOklrugou5fEiQGn2Ycw6WY6c0LK4r01r/K3b01kko9qpHnFVbHAHN2KptGgf2JkFv6mgdf2v3mjWLBP0YEq4ltArsZGtGpXa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWKge1CE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWKge1CE"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd895682fcso248236a12.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244141; x=1724848941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/AOHJYi9/WQuiiiDcao3F43bozZGndvsf3LEuJHY1M=;
        b=lWKge1CEtnhfuHS4rVec3G1Gw9YXtL7tFgYT1g/6Zskc8yx96ePETh6VH5WJ4VQvmL
         SETbkMJioX5khroYlU78iFVMZZR2xTr3j26n7sg5Wiwptfx6ggpRqRID6Ccfnol1vXsB
         Ya3OPV6g78SLHWGF/e8IJEyewIC1j6zpQ+5ZxdjpBCX/PFOAWzolY8CZjwhclCrPDJNY
         GoqfbiivtXDD+DbGZuzZhn1RXkksl9DY2hiTRBGQy3e4LEhPxZKgNK7X6+r+XY0m2/Yi
         pzjdBO5eb3pLEyG/CXwX0lxkxq6iPGb62PB1UQgxWUYgVnsrl7+slZMilnkbHGxeT6sI
         sHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244141; x=1724848941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/AOHJYi9/WQuiiiDcao3F43bozZGndvsf3LEuJHY1M=;
        b=VcnHXl+1nRqnFfQkhs4zFKUU9dASe28bMm67NWcH62Xs9k+GpMQgiRMFEdGI4xHWx6
         3FLeu/QoqFF2mRpXJ8linQTVBgiw5JkJPumjRLVbHpMIQrWGr3SPtctiLV4NqFN91kD3
         9KRq1Z6XAwkbtWhLwbhKQ76htIhGZaYigygB4ZLJlmWmsneC4gaybrxcTywGJ4fQ/wX8
         kE0aZ6KXuXz9hkPnRYxSfwder+xhkxWqioR9DFFjvdgiOiceqJKgg0kh3BBIlId+ZT4s
         KZk4U/2no8f8Cne1sWH1CG2r8EXpJbv0SOvTgL6bqbHmOaMXyRVdjKZaq0aZjBgWWUnn
         E6LQ==
X-Gm-Message-State: AOJu0YzWCVE3HMA3MvoM3W3Qownvi+ANmBXHqymJEtXnQUy3jMJ1L1do
	YDN6Iy1QwbDnA8kwMIHcLaVURvS8EMCQC+GqNPGqLUqSmIHKzFyp7BQitTJ1
X-Google-Smtp-Source: AGHT+IHvQveZ8cnGwnXFS94gXdH47oWKF8Y73EcsYbsSbCW2HojB2IuP7ghsjNTi4AGyZ+wKS2WvUw==
X-Received: by 2002:a05:6a21:2d07:b0:1c4:21c0:ea0f with SMTP id adf61e73a8af0-1cad8352b99mr2928611637.33.1724244141086;
        Wed, 21 Aug 2024 05:42:21 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:20 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 02/11] t: harmonize t-reftable-block.c with coding guidelines
Date: Wed, 21 Aug 2024 18:00:52 +0530
Message-ID: <20240821124150.4463-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harmonize the newly ported test unit-tests/t-reftable-block.c
with the following guidelines:
- Single line 'for' statements must omit curly braces.
- Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
- Array sizes and indices should preferably be of type 'size_t'and
  not 'int'.
- Return code variable should preferably be named 'ret', not 'n'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index f2b9a8a6f4..b1b238ac2a 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -16,20 +16,20 @@ static void t_block_read_write(void)
 {
 	const int header_off = 21; /* random */
 	char *names[30];
-	const int N = ARRAY_SIZE(names);
-	const int block_size = 1024;
-	struct reftable_block block = { NULL };
+	const size_t N = ARRAY_SIZE(names);
+	const size_t block_size = 1024;
+	struct reftable_block block = { 0 };
 	struct block_writer bw = {
 		.last_key = STRBUF_INIT,
 	};
 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
 	};
-	int i = 0;
-	int n;
+	size_t i = 0;
+	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	int j = 0;
+	size_t j = 0;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
@@ -40,26 +40,26 @@ static void t_block_read_write(void)
 
 	rec.u.ref.refname = (char *) "";
 	rec.u.ref.value_type = REFTABLE_REF_DELETION;
-	n = block_writer_add(&bw, &rec);
-	check_int(n, ==, REFTABLE_API_ERROR);
+	ret = block_writer_add(&bw, &rec);
+	check_int(ret, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
-		snprintf(name, sizeof(name), "branch%02d", i);
+		snprintf(name, sizeof(name), "branch%02"PRIuMAX, (uintmax_t)i);
 
 		rec.u.ref.refname = name;
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
 		names[i] = xstrdup(name);
-		n = block_writer_add(&bw, &rec);
+		ret = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
-		check_int(n, ==, 0);
+		check_int(ret, ==, 0);
 	}
 
-	n = block_writer_finish(&bw);
-	check_int(n, >, 0);
+	ret = block_writer_finish(&bw);
+	check_int(ret, >, 0);
 
 	block_writer_release(&bw);
 
@@ -68,9 +68,10 @@ static void t_block_read_write(void)
 	block_iter_seek_start(&it, &br);
 
 	while (1) {
-		int r = block_iter_next(&it, &rec);
-		check_int(r, >=, 0);
-		if (r > 0) {
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, >=, 0);
+		if (ret > 0) {
+			check_int(i, ==, N);
 			break;
 		}
 		check_str(names[j], rec.u.ref.refname);
@@ -85,20 +86,20 @@ static void t_block_read_write(void)
 		strbuf_reset(&want);
 		strbuf_addstr(&want, names[i]);
 
-		n = block_iter_seek_key(&it, &br, &want);
-		check_int(n, ==, 0);
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
 
-		n = block_iter_next(&it, &rec);
-		check_int(n, ==, 0);
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
 
 		check_str(names[i], rec.u.ref.refname);
 
 		want.len--;
-		n = block_iter_seek_key(&it, &br, &want);
-		check_int(n, ==, 0);
+		ret = block_iter_seek_key(&it, &br, &want);
+		check_int(ret, ==, 0);
 
-		n = block_iter_next(&it, &rec);
-		check_int(n, ==, 0);
+		ret = block_iter_next(&it, &rec);
+		check_int(ret, ==, 0);
 		check_str(names[10 * (i / 10)], rec.u.ref.refname);
 
 		block_iter_close(&it);
@@ -107,9 +108,8 @@ static void t_block_read_write(void)
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < N; i++)
 		reftable_free(names[i]);
-	}
 }
 
 int cmd_main(int argc, const char *argv[])
-- 
2.45.GIT

