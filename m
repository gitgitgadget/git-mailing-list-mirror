Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D091DB548
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462133; cv=none; b=TwZCNKqVVwjlnpjnnKyq4pbHccXl7f/oqf+JTwJAGGV3Il3s3xYCAo36ygnrxZohZAGXLFnAjgRyHNbuiHtqe7xoaCfllR0QSw+oUZ48iWFR+4XCxshE3U0EV6cwa8M9V7twYJtx12zMoai+DRVSjpLeNNOGM+f3tNRaDhw72II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462133; c=relaxed/simple;
	bh=sXcZykDbgKoBZpg63KYosbbolzYdzZ/75ZYgUjKAQQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJHzW8MENlQCUUc7FLYxzuBY4KE5U8i1CPRLrrdhJDxULE4xBZltf/ShKEXPNEr4hVrA1mrj6VlnzpXAiU0WbyRX16oc8yQv3e0xWNysXcdHwsGmoOtll90TZbv/iFphVk68e1orcyyTaIGu9HyX5cTvzuJ+ifPr2XPaEg/w/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAJA7hSE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAJA7hSE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068a7c9286so22399955ad.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462131; x=1726066931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOqzxdPGbfjryZSvC16y94IhLIMAw5TQfSsAsPzNiHE=;
        b=KAJA7hSEZ3rI3ZsiBGBTMVQ4M0DVkkJOD8h8LlsJmFl/mb6nTF9JnILfSfOEn+ixRD
         yphRgm49++Zv1qLI6HBo7VvTrM5Y5EJUAEIQSQw3JdTOs2nVb8Wk3zKaR9sg8glYXFs8
         CvZhn8aGE/5QEBdTIjf4cub9Me0fFCG4rcrwUffgyMsYli9cD0QHSJ9EHkpt7ddRyzyb
         i7MZwuGwVnwEul5qt4ZLpUnIoEqB0KjIbzKV53cNlmR7ovcsWlXYva3NMIRoXka3nZHj
         OTztPyfatocMs1v6ZfZxJGerJnVt4gSLSA0vchbq6n+dM9tFElkcyRhvIRS8GA0xiLd4
         X87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462131; x=1726066931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOqzxdPGbfjryZSvC16y94IhLIMAw5TQfSsAsPzNiHE=;
        b=ak7HcfCc+Tp8ksvnT78idxwOM7/4RX6BO2iqqVCg90y1oyEc28N23m8vfEEUFeMBcD
         B81HXHlLoJOwKStyyB4hwns2aB9A33g1KT6a9vLZmdE37fKvsQCcUjA7xSEfsuH6Eht9
         PrbA3t1BbrwZIr2ioFE/owlkHk1OI/akDj+LQPIiY+t6CYPIz6FPuO1pnaMy+Tv/5V9+
         6jKZzhK86sGb5bh+JbRFlsgAMCpxNJLSi9b7h3nIeZiPHJclOhMyL0BGzz8LoGyL8F9n
         gtM2ePH6DaaR0U8KtrQIVvx6FlfdRgDRrGnqg6PMzy5qF9DRsy1wMFjWMFW1AIBRKdpK
         CtMw==
X-Gm-Message-State: AOJu0YzFxU19stXnDpJ1g0Jd57bnyzpqIgD3HCOjEk4uLVzzPXc4i6ZZ
	ZJ15EIB0aD9P7rXhBRnx2MQvULpfo54eoHk8crjkjErwRBQAq0RN8oqnJp/V
X-Google-Smtp-Source: AGHT+IE/vKbjIPVezlDndJ57LhooVS3zUBMd40AKmHdOC4QRD75tjx2/oXODzpwwOxfXhv3LmUjlZA==
X-Received: by 2002:a17:903:32c8:b0:205:5a3f:76b5 with SMTP id d9443c01a7336-205841a6315mr124684915ad.28.1725462131386;
        Wed, 04 Sep 2024 08:02:11 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:02:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 6/6] t-reftable-stack: add test for stack iterators
Date: Wed,  4 Sep 2024 20:08:06 +0530
Message-ID: <20240904150132.11567-7-chandrapratap3519@gmail.com>
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

reftable_stack_init_ref_iterator and reftable_stack_init_log_iterator
as defined by reftable/stack.{c,h} initialize a stack iterator to
iterate over the ref and log records in a reftable stack respectively.
Since these functions are not exercised by any of the existing tests,
add a test for them.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 4acf07ab0c..e209652031 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -544,6 +544,85 @@ static void t_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
+static void t_reftable_stack_iterator(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	struct reftable_ref_record refs[10] = { 0 };
+	struct reftable_log_record logs[10] = { 0 };
+	struct reftable_iterator it = { 0 };
+	size_t N = ARRAY_SIZE(refs), i;
+	int err;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (i = 0; i < N; i++) {
+		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
+		refs[i].update_index = i + 1;
+		refs[i].value_type = REFTABLE_REF_VAL1;
+		set_test_hash(refs[i].value.val1, i);
+
+		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
+		logs[i].update_index = i + 1;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+		logs[i].value.update.email = xstrdup("johndoe@invalid");
+		logs[i].value.update.message = xstrdup("commit\n");
+		set_test_hash(logs[i].value.update.new_hash, i);
+	}
+
+	for (i = 0; i < N; i++) {
+		err = reftable_stack_add(st, write_test_ref, &refs[i]);
+		check(!err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		err = reftable_stack_add(st, write_test_log, &arg);
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
 	int err = 0;
@@ -1225,6 +1304,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
 	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
 	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
+	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
 	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
 	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
 	TEST(t_reftable_stack_read_across_reload(), "stack iterators work across reloads");
-- 
2.45.GIT

