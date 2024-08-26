Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D901991CD
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693837; cv=none; b=bOhvurEgHwkLFYv/JZCuid1m0qRg8aTu/PffL5Pf+e+owWg7b+OtIR0fb5F0qoGKuin4wdAAFM7JmBNdMltBYzu5Gqu7j9eXkNezn1xJs7t9GLBu03wkKcjMZ7CzfFyRx9rq/UmsgGiUrv1eQZ6mHtSc3JpfA0TISq2oXPN7g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693837; c=relaxed/simple;
	bh=arSn3QATBz3eY0o8IS2dA7wBiqRTfVzXe4siGWshL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sntal9j2AJ2CPcQ5tTvvxjWpg6oYdbevYZDWgXCIDfE+StDrISZ4srX+U4hMhLQn5Y8p0RnlxHsblJEXNsQIxkS0JsXWEaa6t/IbUQaDt0mbIiaktk5DtW65+1SVY27smowe05iXbveEdxB46e0Eq3qtIizNIuI8yzP84GWBUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN8O4jFE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN8O4jFE"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714262f1bb4so3291360b3a.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693835; x=1725298635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rjbKDHhyqTyeDZiqbcbkK2OhtNmaAgd080tOfwqLi4=;
        b=IN8O4jFEMKAF1piXicHX5M15CaDpVqmj5T/uOotrozL2t4m0JPUXrQi93iN8PaGVFW
         0jApOG+bVdG4thX8P4cJI6DpnfNM5eYqgJUUld5qvbxatgFPvzA2EDBwc6PJnUYPr6+p
         C2IdBEpVF/aIP17a+vgONGaHkBUzhkqprVAM2VJACmDME8Q7LzVUIkVgRieHZlUi7TK9
         cAwLVhN8heXNfWY1GLcibsyCLUGtmaTN0gviOVEzbYfXSrEYDQoqMQyi/nAKdJbZ8iuH
         3x0lKL571avh0ddMb3w0VRyetSXjCUcc5Pnaf8FokFyCbTer3VkbwG8DCtF7oZmVG8Nf
         Z0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693835; x=1725298635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rjbKDHhyqTyeDZiqbcbkK2OhtNmaAgd080tOfwqLi4=;
        b=q6LvkkbFWessvVpkCvWg4RZDfDAoerQtp9paIiQce5jX8cB8JJGhJAJEcNVxIdHWVy
         vTTXi3aJcNlbvSTwY3/4snLirU1EHdWks7E3yw7qd7PVZUS5SlFQ1u3G9/bKcOZDodzR
         6AQDGJo/mT92nC88B6wUBPeoww/CWxOSXSzy6VqY8wL/K60+YnkbHNT68XaC8ZWJVbx8
         nGSYJrGJT4hBjsuu7xuGHeI87h4/6uf7JIr0LsXQv1pgjXeC11/sFe6lbWG8eqDByHbp
         avYmY6NOLN3LNSkp1DcCJVrJnuNiGtmmlsp2M1N6Z+pSyzj4OLaLyAQNqqmnaBApeFlq
         Rv2w==
X-Gm-Message-State: AOJu0YwAe/Vpr/5B67NNRkkvSbIIyHZwD1fbCgSL97hKRGr4ReUJfyKZ
	4unasRlV3xnKzRUrhrGceMrrDCDkOB2odGGLihOrI1/PS6NXX83E22xW777T
X-Google-Smtp-Source: AGHT+IGcMdwDmy6R5QG9B4QbqJRwt1dUvW61q3p98qnbvIFVFbD5YN4NG/1BsJjJfkdlmaX00ROpSQ==
X-Received: by 2002:a05:6a00:66d1:b0:714:186a:ae0b with SMTP id d2e1a72fcca58-71445e77f21mr10192990b3a.24.1724693834856;
        Mon, 26 Aug 2024 10:37:14 -0700 (PDT)
Received: from Ubuntu.. ([106.216.108.198])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd9casm7997999a12.53.2024.08.26.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:37:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/6] t-reftable-stack: add test for non-default compaction factor
Date: Mon, 26 Aug 2024 22:59:45 +0530
Message-ID: <20240826173627.4525-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240826173627.4525-1-chandrapratap3519@gmail.com>
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240826173627.4525-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a recent codebase update (commit ae8e378430, merge branch
'ps/reftable-write-options', 2024/05/13) the geometric factor used
in auto-compaction of reftable tables was made configurable. Add
a test to verify the functionality introduced by this update.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 41 +++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 4c694329e8..e8c137529e 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -837,12 +837,12 @@ static void t_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
-static int fastlog2(uint64_t sz)
+static int fastlogN(uint64_t sz, uint64_t N)
 {
 	int l = 0;
 	if (sz == 0)
 		return 0;
-	for (; sz; sz /= 2)
+	for (; sz; sz /= N)
 		l++;
 	return l - 1;
 }
@@ -875,11 +875,43 @@ static void t_reftable_stack_auto_compaction(void)
 
 		err = reftable_stack_auto_compact(st);
 		check(!err);
-		check(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
+		check(i < 2 || st->merged->stack_len < 2 * fastlogN(i, 2));
 	}
 
 	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
-	       (uint64_t)(N * fastlog2(N)));
+	       (uint64_t)(N * fastlogN(N, 2)));
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void t_reftable_stack_auto_compaction_factor(void)
+{
+	struct reftable_write_options opts = {
+		.auto_compaction_factor = 5,
+	};
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	int err;
+	size_t N = 100;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (size_t i = 0; i < N; i++) {
+		char name[20];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.value_type = REFTABLE_REF_VAL1,
+		};
+		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		check(!err);
+
+		check(i < 5 || st->merged->stack_len < 5 * fastlogN(i, 5));
+	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -1086,6 +1118,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
 	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
 	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
+	TEST(t_reftable_stack_auto_compaction_factor(), "auto-compaction with non-default geometric factor");
 	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
 	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
 	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
-- 
2.45.GIT

