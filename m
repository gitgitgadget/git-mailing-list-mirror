Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A80184548
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414763; cv=none; b=kd+NvupTvfZU0uoraKzGowEhZghUGlPZXGkPaPN8r4hDd4HCa8QM3Xl6rmjxldZTLO27d5TarxWz/4Yebx8BX/URAA21nZFLPZcXCl56W0Cjvrz0G+TjSd3ci+zKylP0KF+lOLscGAxQCPWzXFeNCuyf/5DQGGokKnXqhFi+s4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414763; c=relaxed/simple;
	bh=SjvaVqF/0tFFCzDzh1sX9G3SMc083IvPUB4+Oy4SsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+FgndO4Yxs0dpbNBq4bmFH8PooJgaPJe3GuXqeeEVuhlB5/EG4t/1Jtic7Fj1aN+yjL1sRpse8myS4cO1My6IOfC9NF4wHHqiRnQBbmx10OfZbSrlHd2460JaxXfdmotHrx02k+sEZIR+KNegSmKNOwBExPCgc7dMlZ41Z5ZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+hbZJac; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+hbZJac"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20231aa8908so16191625ad.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414761; x=1725019561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og22lXmSMHfmebFWp+3BwDDnJGGjTlPVVkU/dYB8GFU=;
        b=d+hbZJacxwYDP36XAABpjon7aVkE4s9p81iqkEOR+y1Bq1ISS3fAnAfp3Fv98YUgCr
         iJFYmkeecAuEfSIiYPJE6V92aVT61hQsf0embHhGffjgYDPiuY7zdK3fl63APV8AFqi5
         UG08IsJ/bYa8tmp23RSmrVwUXQ2ItajW3iFb2/yomqbe32Z+1x6qFvR/7pNJbd2N5yC5
         bJyRqQCAcf+qRrvUt3OtyJdi5os8Ytc6l8yO47r9fv3rPF/2FYeNo0V/4pSxNuGakSLP
         8RL6QioicAPPpcFXAKNm9Tv+eZkeZbt+FVBD1lmoa6w2bP8SY7IdYIMxYVoFck8N/I6h
         BXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414761; x=1725019561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=og22lXmSMHfmebFWp+3BwDDnJGGjTlPVVkU/dYB8GFU=;
        b=iMLT81t/Ebaq7CNWr+QrBkXpoxfuFMb5WbuK46DdwM69Yre3Is5aZQfI3gViPDqOQ/
         SeGZMA1N/7M5Z6tmo0imDkXdQQZtdVvDUBBj+RjLU8XRVa55lUxJwdaKXVv90b9Q3te6
         mmgAeyyG0t1nJOuMKrjsd9aQrp4l+gRjVopH7U6TBVJKahypnO42DEFWzAp0WB5QaobK
         kBZxvCoZi1XkopPSx+RseOxBeXhvAKV4Y6512GiCrgGM1EhpmsiH5ZrV+f9/UuY8bkra
         pnCcJZWeaNeu/TqHmZdnr0AZbX92bx9Mm7x2I7LXbGFyl1DguamQbF8VCr7agalTGzsU
         tbAg==
X-Gm-Message-State: AOJu0YyWa+YEFdx0ybbXwx+Z6gMvvG86hMBo9W4KKP3JWdhfk6DEDdFI
	QEYW/sZIM6GR1i1e/xCHZVv5tTHz1v8ypsATu+prGC90uUW8JOzzCwBLjg==
X-Google-Smtp-Source: AGHT+IGu71PGM41RuOsr4uFp+tOF8rNqeH51Z1g1HAzJsR1ZoMEyESevvaTq4M5mXUgpbh2KHSGA4Q==
X-Received: by 2002:a17:902:f681:b0:202:4b99:fd34 with SMTP id d9443c01a7336-2039e4c262fmr23093165ad.14.1724414760523;
        Fri, 23 Aug 2024 05:06:00 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:06:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/6] t: harmonize t-reftable-stack.c with coding guidelines
Date: Fri, 23 Aug 2024 17:18:47 +0530
Message-ID: <20240823120514.11070-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-stack.c | 114 +++++++++++++++-----------------
 1 file changed, 54 insertions(+), 60 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index cae86b4b91..c0acd7502c 100644
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
@@ -122,7 +120,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 			.value_type = REFTABLE_REF_VAL1,
 		};
 
-		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
+		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf.buf;
 		set_test_hash(ref.value.val1, i);
 
@@ -163,12 +161,12 @@ static void t_reftable_stack_add_one(void)
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
@@ -240,16 +238,16 @@ static void t_reftable_stack_uptodate(void)
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
@@ -270,7 +268,7 @@ static void t_reftable_stack_transaction_api(void)
 		.value_type = REFTABLE_REF_SYMREF,
 		.value.symref = (char *) "master",
 	};
-	struct reftable_ref_record dest = { NULL };
+	struct reftable_ref_record dest = { 0 };
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -280,7 +278,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_new_addition(&add, st);
 	check(!err);
 
-	err = reftable_addition_add(add, &write_test_ref, &ref);
+	err = reftable_addition_add(add, write_test_ref, &ref);
 	check(!err);
 
 	err = reftable_addition_commit(add);
@@ -304,12 +302,13 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
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
@@ -317,7 +316,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		};
 		char name[100];
 
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = name;
 
 		/*
@@ -330,7 +329,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		err = reftable_stack_new_addition(&add, st);
 		check(!err);
 
-		err = reftable_addition_add(add, &write_test_ref, &ref);
+		err = reftable_addition_add(add, write_test_ref, &ref);
 		check(!err);
 
 		err = reftable_addition_commit(add);
@@ -361,7 +360,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 		.value_type = REFTABLE_REF_VAL1,
 		.value.val1 = {0x01},
 	};
-	struct reftable_write_options opts = {0};
+	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st;
 	struct strbuf table_path = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
@@ -423,10 +422,10 @@ static void t_reftable_stack_update_index_check(void)
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
@@ -442,7 +441,7 @@ static void t_reftable_stack_lock_failure(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
-		err = reftable_stack_add(st, &write_error, &i);
+		err = reftable_stack_add(st, write_error, &i);
 		check_int(err, ==, i);
 	}
 
@@ -452,7 +451,6 @@ static void t_reftable_stack_lock_failure(void)
 
 static void t_reftable_stack_add(void)
 {
-	int i = 0;
 	int err = 0;
 	struct reftable_write_options opts = {
 		.exact_log_message = 1,
@@ -461,18 +459,18 @@ static void t_reftable_stack_add(void)
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
@@ -486,7 +484,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
 		check(!err);
 	}
 
@@ -495,7 +493,7 @@ static void t_reftable_stack_add(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -503,7 +501,7 @@ static void t_reftable_stack_add(void)
 	check(!err);
 
 	for (i = 0; i < N; i++) {
-		struct reftable_ref_record dest = { NULL };
+		struct reftable_ref_record dest = { 0 };
 
 		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
 		check(!err);
@@ -513,7 +511,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		struct reftable_log_record dest = { NULL };
+		struct reftable_log_record dest = { 0 };
 		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
 		check(!err);
 		check(reftable_log_record_equal(&dest, logs + i,
@@ -581,11 +579,11 @@ static void t_reftable_stack_log_normalize(void)
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
@@ -594,7 +592,7 @@ static void t_reftable_stack_log_normalize(void)
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
-	err = reftable_stack_add(st, &write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg);
 	check(!err);
 	err = reftable_stack_read_log(st, input.refname, &dest);
 	check(!err);
@@ -608,16 +606,15 @@ static void t_reftable_stack_log_normalize(void)
 
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
@@ -643,7 +640,7 @@ static void t_reftable_stack_tombstone(void)
 		}
 	}
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
 		check(!err);
 	}
 
@@ -652,7 +649,7 @@ static void t_reftable_stack_tombstone(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -701,12 +698,12 @@ static void t_reftable_stack_hash_id(void)
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
@@ -749,21 +746,20 @@ static void t_reflog_expire(void)
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
@@ -778,7 +774,7 @@ static void t_reflog_expire(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, &write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg);
 		check(!err);
 	}
 
@@ -806,9 +802,8 @@ static void t_reflog_expire(void)
 
 	/* cleanup */
 	reftable_stack_destroy(st);
-	for (i = 0; i <= N; i++) {
+	for (i = 0; i <= N; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	clear_dir(dir);
 	reftable_log_record_release(&log);
 }
@@ -830,7 +825,7 @@ static void t_empty_add(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, &write_nothing, NULL);
+	err = reftable_stack_add(st, write_nothing, NULL);
 	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
@@ -857,8 +852,8 @@ static void t_reftable_stack_auto_compaction(void)
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i;
-	int N = 100;
+	int err;
+	size_t i, N = 100;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -871,9 +866,9 @@ static void t_reftable_stack_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
-		snprintf(name, sizeof(name), "branch%04d", i);
+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
 
 		err = reftable_stack_auto_compact(st);
@@ -935,7 +930,8 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 	struct reftable_stack *st = NULL;
 	struct strbuf refname = STRBUF_INIT;
 	char *dir = get_tmp_dir(__LINE__);
-	int err, i, n = 20;
+	int err;
+	size_t i, n = 20;
 
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
@@ -955,10 +951,10 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		st->opts.disable_auto_compact = i != n;
 
 		strbuf_reset(&refname);
-		strbuf_addf(&refname, "branch-%04d", i);
+		strbuf_addf(&refname, "branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = refname.buf;
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref);
 		check(!err);
 
 		/*
@@ -1039,10 +1035,8 @@ static void t_reftable_stack_compaction_concurrent(void)
 static void unclean_stack_close(struct reftable_stack *st)
 {
 	/* break abstraction boundary to simulate unclean shutdown. */
-	int i = 0;
-	for (; i < st->readers_len; i++) {
+	for (int i = 0; i < st->readers_len; i++)
 		reftable_reader_free(st->readers[i]);
-	}
 	st->readers_len = 0;
 	FREE_AND_NULL(st->readers);
 }
-- 
2.45.GIT

