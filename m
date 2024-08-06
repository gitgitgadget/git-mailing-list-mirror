Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53E1D47BC
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954064; cv=none; b=Gbdng/Ho83JdpKq5p/egcCfiLzAgDbzPGcgclMlPIn6BpjU7w1+nQZAscRX47mOIzhc6mNfZMmQUgSSj8NWvKx3VeJEPjfIP7H86xQSTPBTdN5BnMRYIhnOU2nXJQnPzkHFPGViWuldGsnmWdhXTMCTjCvY8kJ8moGkoe5K4XPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954064; c=relaxed/simple;
	bh=5+ASgjHrFWdQT21/Bj9gxlkYg1pbAgcJ3E5wvYjVaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukbaNeVDQ7U35Prb6ig3SnfuGRf+PH3KdKmpnIjw+tTkupk413Ux1E3O7OqeviS/6Y86gAylSqYfH+f3NCQiCPIPC5TP5KgZt2DwlViwsx/wY3paEvRNbyXnkiKYBaendLUaFfZtDVJhel/C35QUYF23cQWHRg7hjCZE8ukmm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwE+wO5F; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwE+wO5F"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d162eef54so505142b3a.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954062; x=1723558862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaCVkVcsNkbzUv4nc9PD9hvNW+AWvk32ThdoHlCYhck=;
        b=bwE+wO5FilldUHwwhbHQ+IR5or3Tob8UwHQTvQBF5qYU/PfM+ZzaTCvDeifzFW07eC
         GMtooIC+/tObMi+XkLG/ZGaRARt0uzeL92iWVvSTxstvuCOKRyI0pQqEyFXB5qZFspE2
         BB3Aq9gdkP+IJoJkxR/b7ynxM7Uqq2Y4duGCKtIXHpVRO1jsctRXpvZXCW/xZlnnFgyP
         lcKZl7bRbpjYWGyTzCjn73Zq49XNo5d6Q3rdle9k/CB0ZFOwRv8tVKWoZrQEsXwAjK48
         ix9R9YV7yJG3apa74uRPQ0hw1df7wupy3eR/jbEJbhYRS4JK+geOLhfubn1bTwfeahjj
         Nb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954062; x=1723558862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaCVkVcsNkbzUv4nc9PD9hvNW+AWvk32ThdoHlCYhck=;
        b=UNQ4bJJ2TMgImbDt3t1sfnfIXPWyY+qO9bee5+nrpHd9jiPUu+pnHwlxjWPYkIklmG
         c4bnsyU5Q5n406n1XX032n/hdPAQQhSzw4pKR/P9gv0Lg207PKGIgxs864Q6LpQiV01d
         OjmhjTATv8lmr5x4jKX/ws+brPIznCNJ9L54nLrjE3Wb6e3LQaRn9ETxUUmQ5bJsY3KI
         KG/UshbB6FDpt9I3Zpbv9SXafTSOE1+WTtznhB2pbxoZQIBXOd1K0oL1yT155uBcet3v
         fEEeJNx7XkigXFB7KzAZB/tUcKF/eHzIP51YPA3N3QgQePLYmOimBuxF/F0d05FJMGU9
         NwmA==
X-Gm-Message-State: AOJu0Yzs2IBb2j/ZNSunx4ky7vYdZ+6FauD+yk56JaXeoiTHiTTXMota
	3a+h6evIiC+ED7nAGLrtK6/wKTf/4H+DitdoQwQBGyIHAVZUL+Qb1MD8qgSnP7w4MA==
X-Google-Smtp-Source: AGHT+IHPETgAAojXJ/94pptY56TrG8tiN3YgIN+yJIACj3CBJ0C+YFhhOH8nuNJzg2key0tnuRwAWg==
X-Received: by 2002:a05:6a20:6a24:b0:1c4:b62f:feb2 with SMTP id adf61e73a8af0-1c699559ce2mr16467916637.18.1722954061445;
        Tue, 06 Aug 2024 07:21:01 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:21:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/6] t-reftable-stack: add test for stack iterators
Date: Tue,  6 Aug 2024 19:43:42 +0530
Message-ID: <20240806142020.4615-7-chandrapratap3519@gmail.com>
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

reftable_stack_init_ref_iterator and reftable_stack_init_log_iterator
as defined by reftable/stack.{c, h} initialize a stack iterator to
iterate over the ref and log records in a reftable stack respectively.
Since these functions are not exercised by any of the existing tests,
add a test for them.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 5228872450..1ec8e4afc0 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -521,6 +521,87 @@ static void t_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
+static void t_reftable_stack_iterator(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	struct reftable_ref_record refs[10] = { { 0 } };
+	struct reftable_log_record logs[10] = { { 0 } };
+	struct reftable_iterator it = { 0 };
+	size_t N = ARRAY_SIZE(refs), i;
+	int err;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (i = 0; i < N; i++) {
+		char buf[20];
+		xsnprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
+		refs[i].refname = xstrdup(buf);
+		refs[i].update_index = i + 1;
+		refs[i].value_type = REFTABLE_REF_VAL1;
+		set_test_hash(refs[i].value.val1, i);
+
+		logs[i].refname = xstrdup(buf);
+		logs[i].update_index = i + 1;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+		logs[i].value.update.email = xstrdup("johndoe@invalid");
+		logs[i].value.update.message = xstrdup("commit\n");
+		set_test_hash(logs[i].value.update.new_hash, i);
+	}
+
+	for (i = 0; i < N; i++) {
+		err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		check(!err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		err = reftable_stack_add(st, &write_test_log, &arg);
+		check(!err);
+	}
+
+	reftable_stack_init_ref_iterator(st, &it);
+	reftable_iterator_seek_ref(&it, refs[0].refname);
+	for (i = 0; ; i++) {
+		struct reftable_ref_record ref = { 0 };
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0)
+			break;
+		check(!err);
+		check(reftable_ref_record_equal(&ref, &refs[i], GIT_SHA1_RAWSZ));
+		reftable_ref_record_release(&ref);
+	}
+	check_int(i, ==, N);
+
+	reftable_iterator_destroy(&it);
+
+	reftable_stack_init_log_iterator(st, &it);
+	reftable_iterator_seek_log(&it, logs[0].refname);
+	for (i = 0; ; i++) {
+		struct reftable_log_record log = { 0 };
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0)
+			break;
+		check(!err);
+		check(reftable_log_record_equal(&log, &logs[i], GIT_SHA1_RAWSZ));
+		reftable_log_record_release(&log);
+	}
+	check_int(i, ==, N);
+
+	reftable_stack_destroy(st);
+	reftable_iterator_destroy(&it);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_release(&refs[i]);
+		reftable_log_record_release(&logs[i]);
+	}
+	clear_dir(dir);
+}
+
 static void t_reftable_stack_log_normalize(void)
 {
 	int err;
@@ -1046,6 +1127,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
 	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
 	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
+	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
 	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
 	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
 	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
-- 
2.45.GIT

