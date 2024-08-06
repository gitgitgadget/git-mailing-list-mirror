Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC918D659
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954053; cv=none; b=KXNmxD5MGmuFW+xE9Vip27Rprjzi7zIKI9UDEasBxzBjXBYqKcy3e8xcLZpuGL70jfzz1koNjZ1ZoaQZmHvrZdQFn9TpUxzX4MBGMV8fVhq9J0A0ERrEOLpcy3dBGBeoc29WQsrR3kENrWimZeodNx2HhFVYpZiZ9JLcY8vcYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954053; c=relaxed/simple;
	bh=F5t5BXczl9RG3iElJ4AUo2xgQuwpnDXo41JVrdoX1r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKiueGcTUJseTA1QEF2Uf8kDtQ87h44lvlrlmeJLshSqgFSxxEsDOl/mnXTWRnm4ceweXmagq/gzLS/kdHbHFbcrEa1NFcK9dfFiLTHM6NzGjYU1wqOYeF/6iKqaTy0Z1IiI9ZqgTTGEh8rWWt0grcdG7DAkLM2pnd2JkC0iqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmwC/MLj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmwC/MLj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d19d768c2so480553b3a.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954050; x=1723558850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kWfABUEeGuz8pA0bE/5S3/sJ/eOIZlZnG5puvJ46rM=;
        b=GmwC/MLj/wLvjRqUV7ZrXys9ABxV4Ez7DAmMIp9saCZer2BJkDFz5Hx0YviwjVKgs/
         0sgQgGXsPaQObd6gwqwJYWsiQtbtps61t9J9Zlo3SxCIVSKzyFJ2ONOYUU9vAmscdiLT
         5eb/Z2dDSnCacvYcGiJd9n7rl/31jOspWvxcjJK5C32Gw087VC44Z5YLWz0CCc/bfbno
         9CtdyCzZrWyTtg1hzTBAcHl/X8+rT9Tl7IdGC55Z3jEjuL0P8Dc1QDO7BMflcdmbbUpQ
         eWuUAWzYf/NVOPC/kwr6b29z3Jv1PH87W1LlSoN5OjQ+QZ3RRzbomIG8UbfOeuGKLsLE
         DqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954050; x=1723558850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kWfABUEeGuz8pA0bE/5S3/sJ/eOIZlZnG5puvJ46rM=;
        b=cJIpRVMzHHwimkzqcpu2vVGePLQRQ2lpoxS1DG3WYDN/g5Cgh4LIV48Tf6pMkcJUTm
         eeTHZrWdHqS6M3ti4Z9bljeG1LXL/OBiPUUt5UjPKfU9DBtkaUBCWyWeBACUrkKk8/rr
         HwpAcJw5zcfQez/5ctMiN+JWfL4n2xRMcE/8Uyq1fXVVYtSwCm2wcwl78oJ087mdtoc+
         xqOAEfrHAwCKqZA3n00BCl8G7QIiVxKtPkRNso0jx4wEHVnEXoVQqOXFdOq90ep3Dg0p
         0Fc0Fx2w/wze3+OgrI7ZpfM3K2X3WCqaLV6A097joSIYJXLsXScmRjLp5/8nB5J/q6Hn
         Sb7w==
X-Gm-Message-State: AOJu0YxeoZxY8bVLZuv9l0fbrLM1ZT9ixv1yta+zEf2dRXmpj3jr8FmB
	s1nM0IOOifGDifks7C2Wk4LQgKp7WJ03lEoKVNZfSj0PClS/Zwm9GHf3ZYAbxUlfyA==
X-Google-Smtp-Source: AGHT+IG/1Lg4aO34zbv82NgtFlnro/meRFcfJUKSPhYNhabDfkyHULvMpEmDbbnnhd7KFY/y/qYn3A==
X-Received: by 2002:a05:6a00:1744:b0:70d:2693:d208 with SMTP id d2e1a72fcca58-7106cfd19a6mr15796187b3a.15.1722954050106;
        Tue, 06 Aug 2024 07:20:50 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:20:49 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/6] t: harmonize t-reftable-stack.c with coding guidelines
Date: Tue,  6 Aug 2024 19:43:38 +0530
Message-ID: <20240806142020.4615-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
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
- Array sizes and indices should preferably be of type 'size_t'and
  not 'int'.
- Function pointers should be passed as 'func' and not '&func'.

While at it, remove initialization for those variables that are
re-used multiple times, like loop variables.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 128 +++++++++++++++-----------------
 1 file changed, 61 insertions(+), 67 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index c578659017..e033feb8ee 100644
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
@@ -135,12 +133,12 @@ static void t_reftable_stack_add_one(void)
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
@@ -212,16 +210,16 @@ static void t_reftable_stack_uptodate(void)
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
@@ -242,7 +240,7 @@ static void t_reftable_stack_transaction_api(void)
 		.value_type = REFTABLE_REF_SYMREF,
 		.value.symref = (char *) "master",
 	};
-	struct reftable_ref_record dest = { NULL };
+	struct reftable_ref_record dest = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -252,7 +250,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_new_addition(&add, st);
 	check(!err);
 
-	err = reftable_addition_add(add, &write_test_ref, &ref);
+	err = reftable_addition_add(add, write_test_ref, &ref);
 	check(!err);
 
 	err = reftable_addition_commit(add);
@@ -276,7 +274,8 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 	struct reftable_write_options opts = {0};
 	struct reftable_addition *add = NULL;
 	struct reftable_stack *st = NULL;
-	int i, n = 20, err;
+	size_t i, n = 20;
+	int err;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -289,7 +288,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		};
 		char name[100];
 
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = name;
 
 		/*
@@ -302,7 +301,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		err = reftable_stack_new_addition(&add, st);
 		check(!err);
 
-		err = reftable_addition_add(add, &write_test_ref, &ref);
+		err = reftable_addition_add(add, write_test_ref, &ref);
 		check(!err);
 
 		err = reftable_addition_commit(add);
@@ -395,10 +394,10 @@ static void t_reftable_stack_update_index_check(void)
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
@@ -414,7 +413,7 @@ static void t_reftable_stack_lock_failure(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
-		err = reftable_stack_add(st, &write_error, &i);
+		err = reftable_stack_add(st, write_error, &i);
 		check_int(err, ==, i);
 	}
 
@@ -424,8 +423,7 @@ static void t_reftable_stack_lock_failure(void)
 
 static void t_reftable_stack_add(void)
 {
-	int i = 0;
-	int err = 0;
+	int err;
 	struct reftable_write_options opts = {
 		.exact_log_message = 1,
 		.default_permissions = 0660,
@@ -433,18 +431,18 @@ static void t_reftable_stack_add(void)
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	struct reftable_ref_record refs[2] = { { NULL } };
-	struct reftable_log_record logs[2] = { { NULL } };
+	struct reftable_ref_record refs[2] = { { 0 } };
+	struct reftable_log_record logs[2] = { { 0 } };
 	struct strbuf path = STRBUF_INIT;
 	struct stat stat_result;
-	int N = ARRAY_SIZE(refs);
+	size_t N = ARRAY_SIZE(refs), i;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
-		snprintf(buf, sizeof(buf), "branch%02d", i);
+		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
 		refs[i].refname = xstrdup(buf);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
@@ -458,7 +456,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
 		check(!err);
 	}
 
@@ -467,7 +465,7 @@ static void t_reftable_stack_add(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -475,7 +473,7 @@ static void t_reftable_stack_add(void)
 	check(!err);
 
 	for (i = 0; i < N; i++) {
-		struct reftable_ref_record dest = { NULL };
+		struct reftable_ref_record dest = { 0 };
 
 		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
 		check(!err);
@@ -485,7 +483,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		struct reftable_log_record dest = { NULL };
+		struct reftable_log_record dest = { 0 };
 		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
 		check(!err);
 		check(reftable_log_record_equal(&dest, logs + i,
@@ -524,7 +522,7 @@ static void t_reftable_stack_add(void)
 
 static void t_reftable_stack_log_normalize(void)
 {
-	int err = 0;
+	int err;
 	struct reftable_write_options opts = {
 		0,
 	};
@@ -553,11 +551,11 @@ static void t_reftable_stack_log_normalize(void)
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
@@ -566,7 +564,7 @@ static void t_reftable_stack_log_normalize(void)
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
-	err = reftable_stack_add(st, &write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg);
 	check(!err);
 	err = reftable_stack_read_log(st, input.refname, &dest);
 	check(!err);
@@ -580,16 +578,15 @@ static void t_reftable_stack_log_normalize(void)
 
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
+	struct reftable_ref_record refs[2] = { { 0 } };
+	struct reftable_log_record logs[2] = { { 0 } };
+	size_t N = ARRAY_SIZE(refs), i;
+	struct reftable_ref_record dest = { 0 };
+	struct reftable_log_record log_dest = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -615,7 +612,7 @@ static void t_reftable_stack_tombstone(void)
 		}
 	}
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
 		check(!err);
 	}
 
@@ -624,7 +621,7 @@ static void t_reftable_stack_tombstone(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -673,12 +670,12 @@ static void t_reftable_stack_hash_id(void)
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
@@ -721,21 +718,20 @@ static void t_reflog_expire(void)
 	char *dir = get_tmp_dir(__LINE__);
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
-	struct reftable_log_record logs[20] = { { NULL } };
-	int N = ARRAY_SIZE(logs) - 1;
-	int i = 0;
+	struct reftable_log_record logs[20] = { { 0 } };
+	size_t N = ARRAY_SIZE(logs) - 1, i;
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
@@ -750,7 +746,7 @@ static void t_reflog_expire(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -778,9 +774,8 @@ static void t_reflog_expire(void)
 
 	/* cleanup */
 	reftable_stack_destroy(st);
-	for (i = 0; i <= N; i++) {
+	for (i = 0; i <= N; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	clear_dir(dir);
 	reftable_log_record_release(&log);
 }
@@ -802,7 +797,7 @@ static void t_empty_add(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_nothing, NULL);
+	err = reftable_stack_add(st, write_nothing, NULL);
 	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
@@ -829,8 +824,8 @@ static void t_reftable_stack_auto_compaction(void)
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i;
-	int N = 100;
+	int err;
+	size_t N = 100, i;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -843,9 +838,9 @@ static void t_reftable_stack_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
 
 		err = reftable_stack_auto_compact(st);
@@ -866,7 +861,8 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 	struct reftable_stack *st = NULL;
 	struct strbuf refname = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i, n = 20;
+	int err;
+	size_t i, n = 20;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -886,10 +882,10 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		st->opts.disable_auto_compact = i != n;
 
 		strbuf_reset(&refname);
-		strbuf_addf(&refname, "branch-%04d", i);
+		strbuf_addf(&refname, "branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = refname.buf;
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
 
 		/*
@@ -913,8 +909,8 @@ static void t_reftable_stack_compaction_concurrent(void)
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i;
-	int N = 3;
+	int err;
+	size_t N = 3, i;
 
 	err = reftable_new_stack(&st1, dir, &opts);
 	check(!err);
@@ -927,9 +923,9 @@ static void t_reftable_stack_compaction_concurrent(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st1, &write_test_ref, &ref);
+		err = reftable_stack_add(st1, write_test_ref, &ref);
 		check(!err);
 	}
 
@@ -949,10 +945,8 @@ static void t_reftable_stack_compaction_concurrent(void)
 static void unclean_stack_close(struct reftable_stack *st)
 {
 	/* break abstraction boundary to simulate unclean shutdown. */
-	int i = 0;
-	for (; i < st->readers_len; i++) {
+	for (size_t i = 0; i < st->readers_len; i++)
 		reftable_reader_free(st->readers[i]);
-	}
 	st->readers_len = 0;
 	FREE_AND_NULL(st->readers);
 }
@@ -962,8 +956,8 @@ static void t_reftable_stack_compaction_concurrent_clean(void)
 	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i;
-	int N = 3;
+	int err;
+	size_t N = 3, i;
 
 	err = reftable_new_stack(&st1, dir, &opts);
 	check(!err);
@@ -976,9 +970,9 @@ static void t_reftable_stack_compaction_concurrent_clean(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st1, &write_test_ref, &ref);
+		err = reftable_stack_add(st1, write_test_ref, &ref);
 		check(!err);
 	}
 
-- 
2.45.GIT

