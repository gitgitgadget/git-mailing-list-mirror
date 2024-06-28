Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3957EEE4
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556640; cv=none; b=a/gBM0GC2QvFrEyQ5oMeoxouwrK16Q8kgeW6CsiOxJF+7HcbGH/e12Dqhk+JWf5485/2ecEbEG646uAkgVTSMV+V5y11+lQD6/xHANG3QhDvbdN8HtVNRMktuR+0pyzNvxsBp57UQcoIFJml3Ad0i4CPMqWLaOH3jsrTn9Vgi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556640; c=relaxed/simple;
	bh=tJRnzruNQbL9u6f52Inm/dlFtFVFl1JHwLfWG5fXhOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS10oJ8a2qvL4vc2olXBQyjMB80Qg7k66qjpIx8IwNpEfwJP8aCRUoh6MaB474PGztFb5fwUPYVLxEbKfWtE0osqrJdD6NK872KR2cvKbVxMIJ6kaQFCto1HNMA3vj5Vx41EFOMC+qJ1xfsaKNydoNcWflZuZhk/QaoWnKPhHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXuDvmrp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXuDvmrp"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70675977d0eso238873b3a.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556638; x=1720161438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGsl7AtgnA+dBBrXfzwaiRwNb/aaQ6maeeZJKQxk3dg=;
        b=WXuDvmrpW+UF0zN8B/erYIohTDQtvcqBzsvOi8p9rFEvsveia6KNTYRc2Cx+Kd4bXW
         bsaV8jfLTVddyrg1w8v1QXjMiFIP7mkqscezK7XkPNpB6nQWYwEVyqsmxLSjVpsIaeo2
         duRAUj2m0/t9ow64r9y6rLeftKScfqenE9yFlHnaNQAffeU4Tfu6NTG0C0pMBQxJJ2UH
         t7MDiacNjzLnOPh4ckowa6kmuUtKP9hfBn13b5tbwGPOR9jW07LgHEt4wjEy9AaUG8lR
         qa4lWz0or22Pz6+VH4be03D6brDOWCRzr4oSD/r+2O6B/0dDpAu6Y8/0yswJKYsjTTrW
         vRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556638; x=1720161438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGsl7AtgnA+dBBrXfzwaiRwNb/aaQ6maeeZJKQxk3dg=;
        b=VYol/H5sp2bosgbPNXgg0wTm3L1cyyDYhFd+bV85GxncsbOa1pXL3ZjphMo8z05PD8
         q2jNkalLvK9bb+9eLe1qS0cKsi/PkrQK4TBtoABAjhdWnPAczfE0GFp0f8XZiJBFVkGn
         EqVgQM5I0Lean6z/omhFiST0nRdkrJIARcNjZHQ5jV1D5TIRihZOx9zaeHq3mDAHtmu/
         1fwYS5gA2Kww2WHhLWUa6WKoqIRKD966M1RfsbdNpx+bS4eBVqRq+0qtLo6P27ZjX5wH
         LHmXfugqclFAjTrFjHSzzXAtFBadHgFc+XK1CND+nA/Xh9AZSLY8X8TKIPfU3GlLqWWN
         LIYA==
X-Gm-Message-State: AOJu0Yz8s4NeBg/0meBwwf2fy3+APve1sD2VWni5UHmhQdrDQkasIhMr
	tfRK7Eg0DMdPYZEqWIih23X2mEHfEhuAR2Wgaq0gjahjC+El1ldzknwU3/hozj0=
X-Google-Smtp-Source: AGHT+IF06TF7zvw4SxNBlWg26XmC7a5NvyQUypAKFXGlDhZ+KY3ets0jnQXfRJLxC5UnNmWt4YMlLQ==
X-Received: by 2002:a05:6a00:80d5:b0:706:3329:5533 with SMTP id d2e1a72fcca58-7067469450amr13930810b3a.24.1719556637871;
        Thu, 27 Jun 2024 23:37:17 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 04/11] t-reftable-record: add comparison tests for index records
Date: Fri, 28 Jun 2024 11:49:34 +0530
Message-ID: <20240628063625.4092-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for index records, the comparison
functions for index records, reftable_index_record_cmp() and
reftable_index_record_equal() are left untested.

Add tests for the same by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() for
reftable_index_record_cmp() and reftable_index_record_equal()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index aaa49e76af..e242a3923c 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -357,6 +357,43 @@ static void test_reftable_obj_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
+static void test_reftable_index_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_INDEX,
+			.u.idx.offset = 22,
+			.u.idx.last_key = STRBUF_INIT,
+		},
+		{
+			.type = BLOCK_TYPE_INDEX,
+			.u.idx.offset = 32,
+			.u.idx.last_key = STRBUF_INIT,
+		},
+		{
+			.type = BLOCK_TYPE_INDEX,
+			.u.idx.offset = 32,
+			.u.idx.last_key = STRBUF_INIT,
+		},
+	};
+	strbuf_addstr(&in[0].u.idx.last_key, "refs/heads/master");
+	strbuf_addstr(&in[1].u.idx.last_key, "refs/heads/master");
+	strbuf_addstr(&in[2].u.idx.last_key, "refs/heads/branch");
+
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+
+	in[1].u.idx.offset = in[0].u.idx.offset;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
+		reftable_record_release(&in[i]);
+}
+
 static void test_reftable_index_record_roundtrip(void)
 {
 	struct reftable_record in = {
@@ -405,6 +442,7 @@ int cmd_main(int argc, const char *argv[])
 {
 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
+	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

