Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C71D88D5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462123; cv=none; b=rY/xiK7vR9JOAlC8FXhyUAwSYoG/FJMgZ1fGKyjWjKTmUp9swLLykBW+lvXgWCsJZX3Ng8+K3q6Y3e3ul525IcqlN66SmTVAKgUX2AqPPISxqS33UHtlZN7xEX7wBTms8VRyDW92G70hcb3DLM7VjgZr0HMBSrTtrEMSmzHmyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462123; c=relaxed/simple;
	bh=GrSieV5mZaCyH48aU3EcZKk6s5lvG8BD5BhdvRR6Jfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJkaA7DQyHJ9oxuPX7pHVfXsT0O8sfuciEOP3dbXgVAKnRTSJHgo0oxiYNJtEzykdq7ub25oKOeFegpP+Nzw6kHL6L5bhk4tLKg99IGTDlMS7JtDfavVu791PfdmMqZMT2lLccbhnTotc8nbIMSzs9fcnithbx6udY2It7YycQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS+3wY1V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS+3wY1V"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2055a3f80a4so26704445ad.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462121; x=1726066921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nx6EgotcfCnji/fX78uCBdEQv0nkDKo0eneuBFd8+0=;
        b=HS+3wY1VEMYNHM7p0SybAkbmIf8KM7cTPRaMI82ChgRnHOPWNvgOWpi/dkSL0+4Y4h
         CjBxoH3iih7s+QR87ROgylJpNtWlML984W4bS0ZChuQBMMcbLC84yaifkVW+5KV14euo
         W21Y2HxbHmX+Rymuqs0AmieyIfhLjIKNLN7Bh8hhUL+bnn+Yo6f6oVnteCtyxKuOP47Y
         oFPZLyTgbiNAlcTcZkX7Efk0l77rv9wjgJBON1m1ZshjS+X6JVgckuCN19mZQFUWsuEt
         hyU/sZVFB57EeAMqMMPMLMprxUmZXrNqLwil77KDi6BY4QwEg72C1U1vLXLocvuYBfst
         SRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462121; x=1726066921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Nx6EgotcfCnji/fX78uCBdEQv0nkDKo0eneuBFd8+0=;
        b=aW3mKQmDek+1CDWKR1xdIyX+cDX5df0HWaS7YQFiVh+/vjOJaZZ6Wi5pP2JIhZc3CQ
         OpZysTYc9ZD+0tinZHiRemF8kzpcjAM/xazurZPork4ev0nH2u8SJ0xPow0dKOd+iwXK
         R6oeY5eB5mE9S+xKVLhQAO1rpxjbUdl2xvOKrHBBigdNX5ha9jeiXwcEAYVGTcd6k4Cj
         BVDXFN4tyaqq1sYZtMCBVcmydFbkuLi4qTX8158OjaO2iRKSatRtFL8bV8e5AH+1zFBg
         hivHp6yhPm7FGxABDU+/2ovGlmjZ1hYu0+8QT5p6aYvVtOkBJ0VJeVF/sHqVjl8xD+kf
         ozxA==
X-Gm-Message-State: AOJu0YzZGGjJyQYwtbbsZb2T1DLDd3r5H6yfMN2OvD/0vV/4rK3MME0w
	44UX9Cqb1s2wc62BWqtDnEA3Sr5t7j3Su8EL6FMXSEujRQId0OmpbaJdA2If
X-Google-Smtp-Source: AGHT+IEZSuR15uz9/mpHm5icfudqUqd75lriEMvt4+9YPmA0Si5PQ1NzqKGliVW8fRzmovf4r8kNkw==
X-Received: by 2002:a17:903:28f:b0:202:32cf:5dbe with SMTP id d9443c01a7336-205447b07ffmr146666425ad.58.1725462120410;
        Wed, 04 Sep 2024 08:02:00 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:02:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/6] t: harmonize t-reftable-stack.c with coding guidelines
Date: Wed,  4 Sep 2024 20:08:02 +0530
Message-ID: <20240904150132.11567-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240904150132.11567-1-chandrapratap3519@gmail.com>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harmonize the newly ported test unit-tests/t-reftable-stack.c
with the following guidelines:
- Single line 'for' statements must omit curly braces.
- Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
- Array sizes and indices should preferably be of type 'size_t' and
  not 'int'.
- Function pointers should be passed as 'func' and not '&func'.

While at it, remove initialization for those variables that are
re-used multiple times, like loop variables.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 110 +++++++++++++++-----------------
 1 file changed, 53 insertions(+), 57 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index de28fac466..c74660a1e2 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -81,7 +81,6 @@ static void t_read_file(void)
 	int n, err;
 	char **names = NULL;
 	const char *want[] = { "line1", "line2", "line3" };
-	int i = 0;
 
 	check_int(fd, >, 0);
 	n = write_in_full(fd, out, strlen(out));
@@ -92,9 +91,8 @@ static void t_read_file(void)
 	err = read_lines(fn, &names);
 	check(!err);
 
-	for (i = 0; names[i]; i++) {
+	for (size_t i = 0; names[i]; i++)
 		check_str(want[i], names[i]);
-	}
 	free_names(names);
 	(void) remove(fn);
 }
@@ -123,7 +121,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		};
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
+		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf.buf;
 		set_test_hash(ref.value.val1, i);
 
@@ -164,12 +162,12 @@ static void t_reftable_stack_add_one(void)
 		.value_type = REFTABLE_REF_SYMREF,
 		.value.symref = (char *) "master",
 	};
-	struct reftable_ref_record dest = { NULL };
+	struct reftable_ref_record dest = { 0 };
 	struct stat stat_result = { 0 };
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_test_ref, &ref);
+	err = reftable_stack_add(st, write_test_ref, &ref);
 	check(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
@@ -234,16 +232,16 @@ static void t_reftable_stack_uptodate(void)
 	err = reftable_new_stack(&st2, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st1, &write_test_ref, &ref1);
+	err = reftable_stack_add(st1, write_test_ref, &ref1);
 	check(!err);
 
-	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	err = reftable_stack_add(st2, write_test_ref, &ref2);
 	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
 
 	err = reftable_stack_reload(st2);
 	check(!err);
 
-	err = reftable_stack_add(st2, &write_test_ref, &ref2);
+	err = reftable_stack_add(st2, write_test_ref, &ref2);
 	check(!err);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
@@ -264,7 +262,7 @@ static void t_reftable_stack_transaction_api(void)
 		.value_type = REFTABLE_REF_SYMREF,
 		.value.symref = (char *) "master",
 	};
-	struct reftable_ref_record dest = { NULL };
+	struct reftable_ref_record dest = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -274,7 +272,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_new_addition(&add, st);
 	check(!err);
 
-	err = reftable_addition_add(add, &write_test_ref, &ref);
+	err = reftable_addition_add(add, write_test_ref, &ref);
 	check(!err);
 
 	err = reftable_addition_commit(add);
@@ -298,12 +296,13 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 	struct reftable_write_options opts = {0};
 	struct reftable_addition *add = NULL;
 	struct reftable_stack *st = NULL;
-	int i, n = 20, err;
+	size_t n = 20;
+	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	for (i = 0; i <= n; i++) {
+	for (size_t i = 0; i <= n; i++) {
 		struct reftable_ref_record ref = {
 			.update_index = reftable_stack_next_update_index(st),
 			.value_type = REFTABLE_REF_SYMREF,
@@ -311,7 +310,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		};
 		char name[100];
 
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = name;
 
 		/*
@@ -324,7 +323,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		err = reftable_stack_new_addition(&add, st);
 		check(!err);
 
-		err = reftable_addition_add(add, &write_test_ref, &ref);
+		err = reftable_addition_add(add, write_test_ref, &ref);
 		check(!err);
 
 		err = reftable_addition_commit(add);
@@ -355,7 +354,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 		.value_type = REFTABLE_REF_VAL1,
 		.value.val1 = {0x01},
 	};
-	struct reftable_write_options opts = {0};
+	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st;
 	struct strbuf table_path = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
@@ -417,10 +416,10 @@ static void t_reftable_stack_update_index_check(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_test_ref, &ref1);
+	err = reftable_stack_add(st, write_test_ref, &ref1);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_test_ref, &ref2);
+	err = reftable_stack_add(st, write_test_ref, &ref2);
 	check_int(err, ==, REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -436,7 +435,7 @@ static void t_reftable_stack_lock_failure(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
-		err = reftable_stack_add(st, &write_error, &i);
+		err = reftable_stack_add(st, write_error, &i);
 		check_int(err, ==, i);
 	}
 
@@ -446,7 +445,6 @@ static void t_reftable_stack_lock_failure(void)
 
 static void t_reftable_stack_add(void)
 {
-	int i = 0;
 	int err = 0;
 	struct reftable_write_options opts = {
 		.exact_log_message = 1,
@@ -455,18 +453,18 @@ static void t_reftable_stack_add(void)
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_ref_record refs[2] = { { NULL } };
-	struct reftable_log_record logs[2] = { { NULL } };
+	struct reftable_ref_record refs[2] = { 0 };
+	struct reftable_log_record logs[2] = { 0 };
 	struct strbuf path = STRBUF_INIT;
 	struct stat stat_result;
-	int N = ARRAY_SIZE(refs);
+	size_t i, N = ARRAY_SIZE(refs);
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
-		snprintf(buf, sizeof(buf), "branch%02d", i);
+		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 		refs[i].refname = xstrdup(buf);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
@@ -480,7 +478,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
 		check(!err);
 	}
 
@@ -489,7 +487,7 @@ static void t_reftable_stack_add(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -497,7 +495,7 @@ static void t_reftable_stack_add(void)
 	check(!err);
 
 	for (i = 0; i < N; i++) {
-		struct reftable_ref_record dest = { NULL };
+		struct reftable_ref_record dest = { 0 };
 
 		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
 		check(!err);
@@ -507,7 +505,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		struct reftable_log_record dest = { NULL };
+		struct reftable_log_record dest = { 0 };
 		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
 		check(!err);
 		check(reftable_log_record_equal(&dest, logs + i,
@@ -575,11 +573,11 @@ static void t_reftable_stack_log_normalize(void)
 	check(!err);
 
 	input.value.update.message = (char *) "one\ntwo";
-	err = reftable_stack_add(st, &write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg);
 	check_int(err, ==, REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
-	err = reftable_stack_add(st, &write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg);
 	check(!err);
 
 	err = reftable_stack_read_log(st, input.refname, &dest);
@@ -588,7 +586,7 @@ static void t_reftable_stack_log_normalize(void)
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
-	err = reftable_stack_add(st, &write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg);
 	check(!err);
 	err = reftable_stack_read_log(st, input.refname, &dest);
 	check(!err);
@@ -602,16 +600,15 @@ static void t_reftable_stack_log_normalize(void)
 
 static void t_reftable_stack_tombstone(void)
 {
-	int i = 0;
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
-	struct reftable_ref_record refs[2] = { { NULL } };
-	struct reftable_log_record logs[2] = { { NULL } };
-	int N = ARRAY_SIZE(refs);
-	struct reftable_ref_record dest = { NULL };
-	struct reftable_log_record log_dest = { NULL };
+	struct reftable_ref_record refs[2] = { 0 };
+	struct reftable_log_record logs[2] = { 0 };
+	size_t i, N = ARRAY_SIZE(refs);
+	struct reftable_ref_record dest = { 0 };
+	struct reftable_log_record log_dest = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -637,7 +634,7 @@ static void t_reftable_stack_tombstone(void)
 		}
 	}
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
 		check(!err);
 	}
 
@@ -646,7 +643,7 @@ static void t_reftable_stack_tombstone(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -695,12 +692,12 @@ static void t_reftable_stack_hash_id(void)
 	struct reftable_stack *st32 = NULL;
 	struct reftable_write_options opts_default = { 0 };
 	struct reftable_stack *st_default = NULL;
-	struct reftable_ref_record dest = { NULL };
+	struct reftable_ref_record dest = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_test_ref, &ref);
+	err = reftable_stack_add(st, write_test_ref, &ref);
 	check(!err);
 
 	/* can't read it with the wrong hash ID. */
@@ -743,21 +740,20 @@ static void t_reflog_expire(void)
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	struct reftable_log_record logs[20] = { { NULL } };
-	int N = ARRAY_SIZE(logs) - 1;
-	int i = 0;
+	struct reftable_log_record logs[20] = { 0 };
+	size_t i, N = ARRAY_SIZE(logs) - 1;
 	int err;
 	struct reftable_log_expiry_config expiry = {
 		.time = 10,
 	};
-	struct reftable_log_record log = { NULL };
+	struct reftable_log_record log = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
 	for (i = 1; i <= N; i++) {
 		char buf[256];
-		snprintf(buf, sizeof(buf), "branch%02d", i);
+		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 
 		logs[i].refname = xstrdup(buf);
 		logs[i].update_index = i;
@@ -772,7 +768,7 @@ static void t_reflog_expire(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -800,9 +796,8 @@ static void t_reflog_expire(void)
 
 	/* cleanup */
 	reftable_stack_destroy(st);
-	for (i = 0; i <= N; i++) {
+	for (i = 0; i <= N; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	clear_dir(dir);
 	reftable_log_record_release(&log);
 }
@@ -824,7 +819,7 @@ static void t_empty_add(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_nothing, NULL);
+	err = reftable_stack_add(st, write_nothing, NULL);
 	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
@@ -851,8 +846,8 @@ static void t_reftable_stack_auto_compaction(void)
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i;
-	int N = 100;
+	int err;
+	size_t i, N = 100;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -865,9 +860,9 @@ static void t_reftable_stack_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
 
 		err = reftable_stack_auto_compact(st);
@@ -929,7 +924,8 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 	struct reftable_stack *st = NULL;
 	struct strbuf refname = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i, n = 20;
+	int err;
+	size_t i, n = 20;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -949,10 +945,10 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		st->opts.disable_auto_compact = i != n;
 
 		strbuf_reset(&refname);
-		strbuf_addf(&refname, "branch-%04d", i);
+		strbuf_addf(&refname, "branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = refname.buf;
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
 
 		/*
-- 
2.45.GIT

