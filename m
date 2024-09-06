Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C51CA6AA
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623118; cv=none; b=MEL4sGMqy32UPyHd0X1ynhdV/V4iS4f8pOeyxVhOlCI4YynaJUWa5UoDMF/HuR0Ffm1us4lZeDqYv73KbT7LPvUn8iBNjv/fh0EEQfLUZKRwV3NU/vGV9MACOJWb0vM6UiquDqwLE53PiVsbJ359sAt3AyuPKaSDnNqC96A83rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623118; c=relaxed/simple;
	bh=DBRmz9W9jJzQ65wdmJMwNjL0jiB8TSQ6cKe3/zSeVbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpsQZp56KFpAwiysoSfqskfoyfJLSwKKyfGEJb0pHiU9N2ChPRAmcrjXalj9pDxEHgkF2BHIwaGy7ki/z9vqtI0M+PqiSfQ43GwO4Z7ee5aPgi8pgYdTu/nOcS8B4LXIqQInKMRO5X/hsPuxDv5ElpdrwCgKerlJeRVvau6OyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibej90Jn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibej90Jn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so1442960a12.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623116; x=1726227916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj/H6FcwBJjot8IO6TmX1ODF7nzFRPEYNcE+QoteqAM=;
        b=ibej90JnBFau507K+wwjBNuaK2UunAx/1saRbYLnVwqrL38kux4Xi27vM4J+Q5yekv
         xN/HjIp4ePywE0NxjKDGV55PkWDA3gzWEcvL9x9YnvBZ/NgYDgeQ8GWwW1mZAp1YertZ
         ebDGxS1Nl1xaUB8/8v93U9CRVRizm86lXVGT3g307/8NPPv7AzvMJj+yJ717MW8I7QF0
         BRm3g46xuD9rzR/trpWWNT01xtLQobXFzn4cnD1OOLOuHVG/NRwEGwXeZH25fdj7jxyc
         CFsqd5fe8xeaEnAzBewdiuxliBK6TuHb32beFBVf8CErsUbXPAc8E7bbEnVdA6ljay/x
         zVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623116; x=1726227916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj/H6FcwBJjot8IO6TmX1ODF7nzFRPEYNcE+QoteqAM=;
        b=ssB8OXG0SeuzqeDFXXxlQCDy0d1SFqOLkcvhySjPknb3WElrPPDwagV4HrRiOwFbBp
         veTlYCzvkMzXkHZCYKWfGKoi4y/e2eQ8r3noC18lyQUyLao0wr5Ga/+oAQvpf6/LUu1T
         EA/4d3Qxo9otLa0/1vdChm0smZPdbY5gONnhTwLXgeYLxViAQpsNBtlUEeJiArDh9pLi
         Dp/xLTMCcyeM9Vd8Ce/9IgJpC3FK7MxHf9FLl7w0PKfnLUob1B4uozkHV1NPTC82Te7v
         Xd5nwGSU6Kovz2ktILhhcQh4JRlkwePZzDbPQQwj7o/2llN1gYHZz1EZHretpbBcUNj0
         2LSg==
X-Gm-Message-State: AOJu0YxT/bE96dlYX4FbnBWt495DiZ/tL7MXcIRVmRNN4R/y2zz9zZ7P
	2s6sx2e93WXr8NyobFwJqANrB+EAhn6n/aAt232kC+bRtPJYadXtQ/H+Y7Y5
X-Google-Smtp-Source: AGHT+IGPpw07/5cRp48aRlHNHB8ooJVH9zNleOs2CWfwJvyI5UNTingxpkkfKA1iEd70kNmiTjcXbw==
X-Received: by 2002:a05:6a21:393:b0:1ca:da66:ade5 with SMTP id adf61e73a8af0-1cf1d073f95mr2155211637.1.1725623115767;
        Fri, 06 Sep 2024 04:45:15 -0700 (PDT)
Received: from Ubuntu.. ([106.221.74.130])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae91371bsm41903685ad.26.2024.09.06.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:45:15 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/7] t-reftable-stack: add test for stack iterators
Date: Fri,  6 Sep 2024 16:59:15 +0530
Message-ID: <20240906113746.8903-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com>
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240906113746.8903-1-chandrapratap3519@gmail.com>
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

