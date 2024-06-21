Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B7172BC7
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971094; cv=none; b=hK2a0jgYP1f6E+WdFR4fkZlWCjbQ11+Dd88F1XESIc6IQJXx3yXy60f/ZJxraA6Lu8nEc2RX270Yy2hXgsa5hjuDNnUR/7yT0d4Vre8IfkiPIQsgxxEJrYEbXZInmXleLCvFftekHSZtUmOXkFa75iyfM8j4FQcE2DjIHgbOAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971094; c=relaxed/simple;
	bh=Ndcdob8r2Jh31THxqrvZ/dBBj/oUcVHXieE00bMNQp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6cZWEn4URDjFBhrJH2WtY/pZuRybesdl46OXQC16T+dXcOnczYAbHVBZcLvbEaw1JW2EbQIg+NmHNeCKb2m7XmZcaNb8IOLyO+6CjsWYSjVppubcVoQjxg8NsR1DOTez4ffxWnOmltCofwpf8FDqJ2qNmV62c7Dr/KXqJNnHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmmiOg/J; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmmiOg/J"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70436ac8882so1566098b3a.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971092; x=1719575892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2ZmXn/Tj+1LbTcgE/6nRbu6BlL4xXg9bIFlee029iQ=;
        b=UmmiOg/J3OAfByEnt0P5Qgn5lDM6CjxNolrx/mGSjWrVMMsigu6MJuMucwH30DvmZo
         uRdOxleQnYrycTFXbmODiBQK7pjIP/QZxUVLIv4kuX14BbJJwpkqEA96FRqefzFt3V/K
         TyP72T2x2olhfM/Hod8oBIOj52mfL0mp+ycqp9aXDUADp7LIgoPHsNMOwH6oSoHO43JH
         fRFy8uVi+eTa3TNH7ISHd+SaR2ZK4LhlWvfke2zHscfQz68doKpA1IbiGVQt7x4YkpwY
         inPMlJHYvLsul+OxNZS15Kwyv+n80IOg9M98MECEPhJj52sa4KgC1x6j3TFVu37Im10M
         D04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971092; x=1719575892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2ZmXn/Tj+1LbTcgE/6nRbu6BlL4xXg9bIFlee029iQ=;
        b=oIKS0ddNI30aemzbFSneHKUP6NV8pF/oXzFxH/Qq0Dixjs11DUwdmKHHJmiJQN8anX
         l+rUQGdamoZigb8xQECkG7/wSk2PrgkrDs/RXekUxYbbdb4imolOM3mA8xiPJjbq+hm5
         QHFbYty7z8lwboNvzQZo15efk+LdSRyNSRxStTzkqEEq4w62XHr2kWEyBwecbIe46/BH
         zs4M16ulhmxbwN3CLchDlmamMIZGy65/IrGsA5E+PheLYi00tsFZ1mPMYxbZz350/TCK
         6xCkwls7mDwboFWxR9R1SD2l6UwdA7x7KDqqxXCGmWLn1WMkA5mtOItyC73x1Ks46d25
         W5yg==
X-Gm-Message-State: AOJu0YwTuHHCDQiZx90BBh9RcwkicHfCCxgsPj6jQ7z0/VCXrSiYV2zX
	vBZOSVfgxQfZalSWYtQN4jsJYeGHN+HZl+AHbWeYOt7TGuPAgXeuFOdABg==
X-Google-Smtp-Source: AGHT+IH7cihgg6f3Z5zXuFSfghCF/kRJ0PX90wTOxwBGSjCOzdW8QRNaMJGU0brV4y7dVMe0xUEMyA==
X-Received: by 2002:a05:6a20:c507:b0:1b7:b55:c87a with SMTP id adf61e73a8af0-1bcbb6037bemr8000743637.53.1718971092286;
        Fri, 21 Jun 2024 04:58:12 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:58:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
Date: Fri, 21 Jun 2024 17:21:05 +0530
Message-ID: <20240621115708.3626-11-chandrapratap3519@gmail.com>
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

reftable_ref_record_compare_name() is a function defined by
reftable/record.{c, h} and is used to compare the refname of two
ref records when sorting multiple ref records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 99ebfafe0b..b949617c88 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -101,6 +101,23 @@ static void test_reftable_ref_record_comparison(void)
 		reftable_record_release(&in[i]);
 }
 
+static void test_reftable_ref_record_compare_name(void)
+{
+	struct reftable_ref_record recs[14] = { 0 };
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++)
+		recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
+
+	QSORT(recs, N, reftable_ref_record_compare_name);
+
+	for (i = 1; i < N; i++)
+		check(reftable_ref_record_compare_name(&recs[i - 1], &recs[i]) < 0);
+
+	for (i = 0; i < N; i++)
+		reftable_ref_record_release(&recs[i]);
+}
+
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -501,6 +518,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
+	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

