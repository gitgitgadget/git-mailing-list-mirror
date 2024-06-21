Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB5174ECA
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971069; cv=none; b=ULlxqVVzeRoM4H+e6au7tGPbbi5OCVpcRlo70tjgtq1abKZ/e6I8ZKyZXw8YdzEitZGGePYZapTVqd35SL7/PuEieDpc0TLPArbr3Ld1UR9cWDI+yC0aSDUyrvKRvUGc6m9XK67X6m+Ra2ShJaRoGV0cEv9SXuUTYI1XKWm56gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971069; c=relaxed/simple;
	bh=9c9jQ0KFEYeHYQ36bjp542+Yn4z95zobLhSO6s7RcMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gncSPAcE23FUNxfSmV2ktGkwRKjGw2/hkWcuf7fxmUdO3GiCS4biQq5gcbczKg0Zz+p2KuL/suzxtSwf1YapI1W8V2/SwSO/HOz36VgyBvAOmX+m3apFTn2v6NJNhdpEyCy1BVyGF99+pkoHfvu3FSsROZsI112sLPKu0bzxtCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3EnsMk/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3EnsMk/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9aeb96b93so14681105ad.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971067; x=1719575867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojuWJXrxweF+iwiFe0whhzIAzLxRXjoT7fSsoiqm8A8=;
        b=T3EnsMk/y/cXhbi6Oisu+a2tS5rGxuJh/WfY4+rODPs3Nim4Lc1IMguzFiCvZrOQK1
         7oKEiyPwKtRuNkZLVWiwDqcJqkJ1lCkRyLKY+eyX4r13Rmt6+QpuE7tFIay8ryyAa49v
         nII18H/DW0dBrPS2lTXPNSx92ak9JQL6eRq7Qq/+ZKPYPqqSeH/J0aJqYaoIqu/fZzn3
         MPYrdAQFPvmIfN6wLnXmydSQHLXqe5NqFmLVMDxS9FjBBOjM6mlrWX7lSQNanEBBQV1M
         gdEbmfktiD6RKUID8F/Et5VG4D8MlN6qB+h2Bt3TH0ZsdfHOivELAZw+PgDEx5ogEUhb
         rIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971067; x=1719575867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojuWJXrxweF+iwiFe0whhzIAzLxRXjoT7fSsoiqm8A8=;
        b=ETRwa6Rk7tF+iX/ZV7DnRxhTSf13SkCVvQXCn2MgSdV5NQkPEcu6FLPdOF/3lhXeH5
         TaC5uN74EZUbD52qMaWYxJi3kkhD1Rp4r3sBDbm2X27JZbkdk+zVRtuZB9rfZPI2AL8E
         9gbMUQng7xgRue6NpSPWztU7NB+p2XV85X05znLeI2Rc8y0O9SsR0NpXYBJGXdDaJB6p
         WCoXwqpvpE5v/785QtnUnZW5s3P99wYZqSN3Cc6BBHIsxdTD0HS4TSVgTTcevSx1fclq
         QlVgcjfjzfw6+A+KWs8gPJjiq0i4Zb53j4dTNRlDiswcwJCjS5BPyXaL9YdwJ6dYJHNa
         sZpg==
X-Gm-Message-State: AOJu0YyLgBfORjan6hZtD80obwSC1My0ca/Z/QL3ihQGTkuwIDCbFhbj
	AK332u62g56HLbBYcGfOxPuREhP6iFNLkYBDcOHuwTTIj/i4dBBo8sGc2w==
X-Google-Smtp-Source: AGHT+IExOLrpKnJWrqBG2mXzharR31dfxXHSDhIz0NkE02ZVMJqTkbtIzy50+ANS8wdcrq/fjIr9Zw==
X-Received: by 2002:a17:903:2341:b0:1f9:df62:6a9a with SMTP id d9443c01a7336-1f9df626c31mr33264065ad.20.1718971066942;
        Fri, 21 Jun 2024 04:57:46 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:46 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/11] t-reftable-record: add reftable_record_cmp() tests for log records
Date: Fri, 21 Jun 2024 17:20:57 +0530
Message-ID: <20240621115708.3626-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621115708.3626-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for log records, only
reftable_log_record_equal() among log record's comparison functions
is tested.

Modify the existing tests to exercise reftable_log_record_cmp_void()
(using the wrapper function reftable_record_cmp()) alongside
reftable_log_record_equal().
Note that to achieve this, we'll need to replace instances of
reftable_log_record_equal() with the wrapper function
reftable_record_equal().

Rename the now modified test to reflect its nature of exercising
all comparison operations, not just equality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 40 +++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 1b357e6c7f..0cf223e51b 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -123,24 +123,38 @@ static void test_reftable_ref_record_roundtrip(void)
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
+			.u.log.refname = xstrdup("refs/heads/master"),
+			.u.log.update_index = 42,
 		},
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 22,
-		}
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = xstrdup("refs/heads/master"),
+			.u.log.update_index = 22,
+		},
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = xstrdup("refs/heads/main"),
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
+
+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
+		reftable_record_release(&in[i]);
 }
 
 static void test_reftable_log_record_roundtrip(void)
@@ -362,7 +376,7 @@ static void test_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
+	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

