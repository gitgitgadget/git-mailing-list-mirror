Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34314535A
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949705; cv=none; b=Fre9I2AzUYHvpqTJAO7SABFeDZKfDa1TrTQX8B1x/nx6TBAbF50owcR5jCysxKsrDBGtGHXrS7JJ4kxWazYvkEfFJ4/TuOQtrqV3hO904ggFyLk3tdVJLkLABLhWdkNQrIYjgNPFtB9lqq10qeg7F2phkZL3XkEstls4RNLJHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949705; c=relaxed/simple;
	bh=5if+8SD6LhrJhmKRnvQ+3TZt2O4YWU98B16DY9y1mBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJXJufDIulK6pRgKNjRD24jln0NuDV1EcbW4+7Va69i/7q5dXOBo27agy3sucHY+7vpCUVE9hlYvHaheNkxGLfqvqKreHL/WD25JWsZ9ErTqdHqq3gevtP8wHri8QiKWtG56RDVhIVWf642V4zQs8/kjhJz+Udhigr8KMYB0N8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBLy9ODu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBLy9ODu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso1075364a12.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949703; x=1719554503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfAHEKpGa3XV8xLDle5D7onb3U5kCj2qSA9C2RPk7+o=;
        b=CBLy9ODuXWc1O94n1EVIPY8eloHJKUlV4efKLjqNTa+1AnxzggkXJrqC16h4S/zQcC
         iigOqpefTStDkPZU/Y7cg9d01OyMjkHCkme1YzP44/M2p0xMWI5M1wyB9orHEPcV7RZb
         pFkFg8e4He1NX0iatBYPKNa24P0/D8M7t8KyOBWLAr4c+eNgAOVYaX7iHTjk5U/UeX0K
         FjOB3ux5IsZXHQK3E3PyETY7ckjQ1y5M/LjbckJi3E7GkEkq3VGIOr83qmk0gkh3FbTL
         uAfGC2yCzEI/JnJOMPk0qrC3zGtVpXR4eaxvkBzzXGiGc6ywfP5R/jg/oJP2IiBRI2eC
         C0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949703; x=1719554503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfAHEKpGa3XV8xLDle5D7onb3U5kCj2qSA9C2RPk7+o=;
        b=fTaLku7Q56AV1sW655N2w24jC53UeRK/UWCcZmGZr7PTnwTDzi2I9KFBZF1p7pcMEB
         5urio2gH35b1dKFcLMsZi04ygfzKUlicV5zlQQ17gRS/FcIUVRYEKvPs8x9rxQ0d8072
         4LwazcnmOJ3Bg7FYeNG/Tnfl41JmhOJlP03952OczCggmtkcysy/gg37a4EkZl7N/bG/
         fDlofmTR7Yx2HIWOja24fbVGmIENXSLxIyzZhxL0i563ntMSJwnpJoaOeyX72LNmUOmj
         VS6VrqrqOBJ6MMA7p18z6KoENSoW1FuLXo1iucUF/7Sa6tj2ZVoF2utgHb1f5hrLXleS
         Iy0w==
X-Gm-Message-State: AOJu0YyW2aDZHs7Qt4ON77YjZc1Wr7W1QQ4kaPGEkfoQf835Q6q/hBTy
	FVhR9cmLgtZ1HzHeofHc8RcTDu0+nlR+UBgU1omgf9vIkyzfs+sBdsylZg==
X-Google-Smtp-Source: AGHT+IH4x49PG04hudWM+egolIQZmRVqF1WR1n9DM0ZZHOwamRHdLw1qcREQsi++WrZqBdqHEJROwQ==
X-Received: by 2002:a17:90a:e2d5:b0:2c3:296a:caad with SMTP id 98e67ed59e1d1-2c7b4e4c7b7mr8601865a91.0.1718949702760;
        Thu, 20 Jun 2024 23:01:42 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:42 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/11] t-reftable-record: add reftable_record_cmp() tests for log records
Date: Fri, 21 Jun 2024 11:17:01 +0530
Message-ID: <20240621060018.12795-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for log records, only
reftable_log_record_equal() among log record's comparison functions
is tested. Modify the existing tests to exercise
reftable_log_record_cmp_void() as well.

This can be achieved by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() instead of
reftable_log_record_cmp_void() and reftable_log_record_equal()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 37 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 1b357e6c7f..4913a82441 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -123,24 +123,35 @@ static void test_reftable_ref_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void test_reftable_log_record_equal(void)
+static void test_reftable_log_record_comparison(void)
 {
-	struct reftable_log_record in[2] = {
+	struct reftable_record in[3] = {
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 42,
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = "refs/heads/master",
+			.u.log.update_index = 42,
 		},
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 22,
-		}
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = "refs/heads/master",
+			.u.log.update_index = 22,
+		},
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = "refs/heads/main",
+			.u.log.update_index = 22,
+		},
 	};
 
-	check(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
-	in[1].update_index = in[0].update_index;
-	check(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
-	reftable_log_record_release(&in[0]);
-	reftable_log_record_release(&in[1]);
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	/* comparison should be reversed for equal keys */
+	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
+
+	in[1].u.log.update_index = in[0].u.log.update_index;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
 static void test_reftable_log_record_roundtrip(void)
@@ -362,7 +373,7 @@ static void test_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
+	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

