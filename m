Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D484778E
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725769107; cv=none; b=GrVAvDICqSv/H9USuRtGM7pJYVjlqGENQWPOD3YVHtlOYUBljLlobfiUYUMO8Ns8WYnbUk3nDsx6/sN13HSjohqqLJZ1JH3uf8fRllziGH6BGW1Di8XVrh5r+EwVhdyGObhWxNw8t6CwExOyyVuKYSB7IYUQa5QtKFbuV09EC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725769107; c=relaxed/simple;
	bh=DBRmz9W9jJzQ65wdmJMwNjL0jiB8TSQ6cKe3/zSeVbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAtLt5Ub4iPN6qVSN2+os5VAIF5+fk3Tvc/YVVzr9Wl4+BUqNXROVJ3FQpXZChto8nDhuIe6b0123QKcyd7y4nGRUVqmghKOy6W9TTIk8rw8RcJLZgll542inrtSmUP2RmYGsAjZJgEH7ROlDGOPm45BhnVvpbH0XqQ1LCCU7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d750SwwV; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d750SwwV"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-277dd761926so2148517fac.2
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 21:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725769103; x=1726373903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj/H6FcwBJjot8IO6TmX1ODF7nzFRPEYNcE+QoteqAM=;
        b=d750SwwVWTTQv92DSB0GFob7v4qevvrnMOnbh4wHH7DQ/hA/WbeWmP2mzWiUEvZ/23
         1C/wLDf4/R6MzSa2Z71DBZ8JSwLDqVUb/yKJxv+cc5PE/L3OpzVT8OlQIUfSvQWUhFlK
         a876L94J1EFcFZ63uqj5ZrT4HNvUr924nsACXQ0dTiERVb8SB+ko+uFV3ViHzp5yPbkY
         D5zEKPkUt6/JcX0n7KBFZXHmBs/vZWQzSx4m8WOGBI/U7at1fbz0O2YN0uucfGGAtwGA
         5W9Faaq1mdXWU6qdyA1W7rzWC8fHRK4tYf7mh5+BqrPnSO9Mw/juXJkU9I5ICl9RwnSp
         olEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725769103; x=1726373903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj/H6FcwBJjot8IO6TmX1ODF7nzFRPEYNcE+QoteqAM=;
        b=r2ojIEKXHa6UP2DvrA3JmGYtohxJD1IF30zWK8N3u2Q3CwQaYAzUI10Fhbe+mK+q5D
         wC1L6QqVQQnxQ/n8Ybvth+Yg9h15pOeL1uMpe+ieY36U2qSZYUeyAWAD1hJruDH0lxH7
         zpG07Ry7cSTH8jRXnI+ddn3Et1cPRfD+9DG1pzIzBLZyIKY5xRxa8pMZlUHCJJA+l6Yx
         F+zD17eR1HSMnoTJnhjowzc6tAyc9mVFXPeWAaItr/j31RvjYBxIPfMbJG72F8mbfAgF
         EB2Voh1vMjQ09KwOMs+noldtZHAicQIneCdSJ8FPNSL86I6Nh8t1+OsM8bD1TCFzh5jE
         AG0A==
X-Gm-Message-State: AOJu0YxHLPF0yE81x9gYINWGYOIfujx+bgiC6nDmxEHXqQ756PqqWMLA
	Di2coi1zn1lxaJ8BdxInevFO1GNk1RBHIJLzRhfVta7Om8saalXRPIAFEaq0iDs=
X-Google-Smtp-Source: AGHT+IFFvqtThXvSz5WZzAFY0jBnaHYG41T+PcHzYK9ZVhpo+vPEZkRhXHRgToNeYT9NR/VjneCDbg==
X-Received: by 2002:a05:6870:1593:b0:25e:eab:6d32 with SMTP id 586e51a60fabf-27b82dd1e7cmr8949728fac.5.1725769103297;
        Sat, 07 Sep 2024 21:18:23 -0700 (PDT)
Received: from Ubuntu.. ([27.59.86.31])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596883csm1533253b3a.121.2024.09.07.21.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 21:18:22 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 6/6] t-reftable-stack: add test for stack iterators
Date: Sun,  8 Sep 2024 09:36:01 +0530
Message-ID: <20240908041632.4948-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240908041632.4948-1-chandrapratap3519@gmail.com>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-stack.c | 83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 4acf07ab0c..d62a9c1bed 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -544,6 +544,88 @@ static void t_reftable_stack_add(void)
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
+
+		err = reftable_stack_add(st, write_test_log, &arg);
+		check(!err);
+	}
+
+	reftable_stack_init_ref_iterator(st, &it);
+	reftable_iterator_seek_ref(&it, refs[0].refname);
+	for (i = 0; ; i++) {
+		struct reftable_ref_record ref = { 0 };
+
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
+
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
@@ -1225,6 +1307,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
 	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
 	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
+	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
 	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
 	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
 	TEST(t_reftable_stack_read_across_reload(), "stack iterators work across reloads");
-- 
2.45.GIT

