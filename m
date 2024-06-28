Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612380C0C
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556661; cv=none; b=orDCMeTZMeXt2+asfp69xSiNsUB+fuS1U7jAQ8s48H9iZVRiE57k0/1R4zu8n1llF/RnHOgqSrKWoy8CBCzTcd/UR/CwLUDnw0D4mVb3AZaCwSVil4ekdiRO3pjzAaID6fmwRCDWKV6eg+BoElT7GmfbVzaBIqVvZXkNEO/nSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556661; c=relaxed/simple;
	bh=T+1tfK67SzEbhuCd9Z0woKSeZywierHZz0RNb4XgviU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSfjJKu7EURvQSmYdQr9t8UDjJJNfk3KtdF+hR1LSu3rS0nhEcCUyIpVChF/q9GBUhvHG6bC6QbI/dRaxrravvGeGkZ+r9lzJ/yFnAoJfK7znou8VIHZycE1xVB67XvYged+Vl1xvuxn8PcMbpHPbgnIrLB3j8kfV4MUpHlErQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ydsD7G; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ydsD7G"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2598ae41389so134370fac.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556659; x=1720161459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHPJSar1HmgdZVZs1GFo6+wyK1RzKRckDCfAbp/EbXE=;
        b=e4ydsD7GcBl3N2Dg9i1D78HtUvX745lmQTTYR+SbManNhuoxcnClIP9WNkExhFONsy
         YMvgXoNFH7lRB9nf4r4EjanghQzQ5VwZLkIZTtb2Q+Edf86zsiDFLI8KPPaFYI92WUrE
         IBCRQVBcdBpeuPrve0/nuCCdK6HZ2Gwt59NTKLab0mYwNeB/0+YkFxLLTuSaxT9QNFzl
         Vd4hQifOkL5a/mExvXymZnshnbAF4BqBVUPe+sCzMga40JQE1xMmqMvM7dPZrjOtUs2V
         Gh5EEBGZw7Wyt3czILbR2I18NhFU74sksiLsDfoDLVC8qYmdmgtQF1J5mO2zY+Dl7pKd
         YDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556659; x=1720161459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHPJSar1HmgdZVZs1GFo6+wyK1RzKRckDCfAbp/EbXE=;
        b=I9BJRCiDdzrCas6u5c782E73H1rZ3TBO8xiBCbNiiELs5uBUTBmOuMI8KSy5IsmZP/
         iwdMQJmFI2Pc4Jns8A7gX2V0DoXSbBTE8tL7vM/njkhh1Iw1ho8D4hqQKoLWztMRfIL0
         pwFSqcS0SmKyUC3TjO8gDwZauC9H246PnMZokKXrqlBdjnOXzZV0XfFQhLULFWjAYsIu
         uHCZu5X3PFsynSp2O1C0wX/+3nY+difNu1FNv6q9XzqN1FBnOoH0Y2RUPHV0fNP//JEm
         iJHIWdptPFTU7FMF0b4J+NHYmCgtIw7tKkfAk0EQEzfVmZ7fbmo6OqdwmjKqIL6M8EYG
         3SoA==
X-Gm-Message-State: AOJu0YzvlhLPdC4FVCFhThfmbZFj4ww6d9MGIVNyHG4oeTgoPBtmJZCS
	2ovXcJfbLkGgCpNKfD7MKI74Et1ewXupf+j2yQoTgPpMJBnfcMziZ4DKHUSXs/g=
X-Google-Smtp-Source: AGHT+IH9WJKfNBNMUfPQn6D93Rb+mbseAJ1B4Db4QpTbxLXVf+4KetIegO+zaK/EPOB2mx7aBuhk7g==
X-Received: by 2002:a05:6870:c68d:b0:254:aada:cc8b with SMTP id 586e51a60fabf-25d06ce3ab7mr15586734fac.31.1719556658675;
        Thu, 27 Jun 2024 23:37:38 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:38 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 11/11] t-reftable-record: add tests for reftable_log_record_compare_key()
Date: Fri, 28 Jun 2024 11:49:41 +0530
Message-ID: <20240628063625.4092-12-chandrapratap3519@gmail.com>
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

reftable_log_record_compare_key() is a function defined by
reftable/record.{c, h} and is used to compare the keys of two
log records when sorting multiple log records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index f45f2fdef2..cac8f632f9 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -208,6 +208,37 @@ static void test_reftable_log_record_comparison(void)
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
+static void test_reftable_log_record_compare_key(void)
+{
+	struct reftable_log_record logs[14] = { 0 };
+	size_t N = ARRAY_SIZE(logs), i;
+
+	for (i = 0; i < N; i++) {
+		if (i < N / 2) {
+			logs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
+			logs[i].update_index = i;
+		} else {
+			logs[i].refname = xstrdup("refs/heads/master");
+			logs[i].update_index = i;
+		}
+	}
+
+	QSORT(logs, N, reftable_log_record_compare_key);
+
+	for (i = 1; i < N / 2; i++)
+		check_int(strcmp(logs[i - 1].refname, logs[i].refname), <, 0);
+	for (i = N / 2 + 1; i < N; i++)
+		check_int(logs[i - 1].update_index, >, logs[i].update_index);
+
+	for (i = 0; i < N - 1; i++) {
+		check_int(reftable_log_record_compare_key(&logs[i], &logs[i]), ==, 0);
+		check_int(reftable_log_record_compare_key(&logs[i + 1], &logs[i]), >, 0);
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_log_record_release(&logs[i]);
+}
+
 static void test_reftable_log_record_roundtrip(void)
 {
 	struct reftable_log_record in[] = {
@@ -513,6 +544,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
+	TEST(test_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

