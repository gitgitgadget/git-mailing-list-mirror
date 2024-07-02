Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6C14D42C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906621; cv=none; b=RN6gWoQYj822vRBFnwuOSVEFAL6fuG0/3R/D1HlwK0P2arCVJOBaRg2q30PjOHk+VcvoZI0a5U+fDYFi6ijPIfYDNf/f9bSnmn/4PU2YkJzPD3C7A/RdUZD1+gne6Jq3deNxb+9eX96vzsXfpQLG1AOBAyBe9aQdGIaqxQrhohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906621; c=relaxed/simple;
	bh=Oz7FLGLPnsDV+1o1uOShkAwc+m5xj3WMKalwkxe/NpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1zetxVBqN464OOuUo9DcL8g/E7JaLqi6SuT1YgH2rSMDeHNzBzz6YUYU/7TzIQfYs8AjBc8U+zdeOaGkiylhHf2h6ELx9wJVVWUz7tP+cbvKx4VJ2xtdanh2weOMwKPCA8Zt2jqnBJHatRUR1gDu27ppKj8IIdmGOtaHeSQ/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxHNl1oF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxHNl1oF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-701b0b0be38so3129962b3a.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906619; x=1720511419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkmOFTD/g7Ed01jSdr/oGiWRDpD+kvQlw386TLsQwVk=;
        b=JxHNl1oF5u2NiPjhZTFvEENEWwRf1111BHdn3Luj9wk7Tdx/EwZc3DTBva1Z6fxgjC
         wDhuOpOV2Zl07vOvdfg8TuOTRsbECowxuoe3xHL+pWv0l8uUWqfO1h8jlgp76PIcNPMp
         cnoioGTIy+Z894u/GVg4i444MBNG5XTfGQgge7qpmVMyyDj8lx2/S/xFZMXQOoB4Bd8B
         eZrc8TV15jnK7Ptt4lCH+ro2sasgzzTZ7cczPNVsBpXkCleMfl3SV7bTUoMB0LHOlwA7
         rzmqygkk8rOtv0QP4HIMZASwnG3FJpWU0zt+O9eokNGVypFRuLh0Im2itLL02EgDrHRD
         sQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906619; x=1720511419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkmOFTD/g7Ed01jSdr/oGiWRDpD+kvQlw386TLsQwVk=;
        b=ZkX4qbAnV8V1H1KZluJ9rmXmCv1W+QNY+R/fFPdL9FBKKvJ67j6snoNoVQI00EKkNl
         MJz66/t0J6eJ++1L/2OjQAGxi4kPtTof6bJFEQiinXaDxEKQC/fr/iq2GUO0tui/uOA4
         IOaKVsUJXM/fjnigBhfPE1LbceHIyoHT68FewLro/e0emy70ALPZX3T5vDcS5hTWIP52
         mO65PpRdsK0mkfdnDXijY7YtjxCK/6GRkBWJ6mGBtpAJyauQ0NxlFqxv6XESL93m3Wog
         sZaHvzQmtrukFnuJzK9y5TJ/X09StZEuhviqyGmmP54Ki4kmjzYsCZL8z19ZyXvqOloX
         QhEw==
X-Gm-Message-State: AOJu0Yw/lDdMHA6BolfbMG41ekqdnq+BZGpK9x2IktoNepfetxYA3NF6
	cPs9s16wuuoVsnDY/SWEmIhHiaqgALFc7+aH2qDllahJbFh5a5HgobO/hu1r454=
X-Google-Smtp-Source: AGHT+IFqCl0aC9xVexbe2vb66XyUF72dS0B7IS03ehkoRO9Fcpt6c47wHiWWKF6PFxBpVn/4vlpCHg==
X-Received: by 2002:a05:6a00:240d:b0:706:251d:d98 with SMTP id d2e1a72fcca58-70aaad2c0femr9018118b3a.4.1719906619440;
        Tue, 02 Jul 2024 00:50:19 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:19 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 11/11] t-reftable-record: add tests for reftable_log_record_compare_key()
Date: Tue,  2 Jul 2024 12:52:24 +0530
Message-ID: <20240702074906.5587-12-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_log_record_compare_key() is a function defined by
reftable/record.{c, h} and is used to compare the keys of two
log records when sorting multiple log records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index c0668cd8b4..cb649ee419 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -205,6 +205,35 @@ static void t_reftable_log_record_comparison(void)
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
+static void t_reftable_log_record_compare_key(void)
+{
+	struct reftable_log_record logs[3] = {
+		{
+			.refname = (char *) "refs/heads/a",
+			.update_index = 1,
+		},
+		{
+			.refname = (char *) "refs/heads/b",
+			.update_index = 2,
+		},
+		{
+			.refname = (char *) "refs/heads/a",
+			.update_index = 3,
+		},
+	};
+
+	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
+	check_int(reftable_log_record_compare_key(&logs[1], &logs[0]), >, 0);
+
+	logs[1].update_index = logs[0].update_index;
+	check_int(reftable_log_record_compare_key(&logs[0], &logs[1]), <, 0);
+
+	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), >, 0);
+	check_int(reftable_log_record_compare_key(&logs[2], &logs[0]), <, 0);
+	logs[2].update_index = logs[0].update_index;
+	check_int(reftable_log_record_compare_key(&logs[0], &logs[2]), ==, 0);
+}
+
 static void t_reftable_log_record_roundtrip(void)
 {
 	struct reftable_log_record in[] = {
@@ -510,6 +539,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(t_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(t_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
+	TEST(t_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

