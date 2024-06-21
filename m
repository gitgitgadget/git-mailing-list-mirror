Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C116938C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949736; cv=none; b=LdFLB2NmbsSDNbCg2pZl4DfRG4baUr78ftO2HOxiPDouyGD6w3wg9+Rsx62IKIgJaPCUyjvxKk/o0Q2dNDFPnLoxsNy7PRNgbwjWwmKQ95Tmh0dVE8XHYvoOcMeamxz4pQAsvwgw1WVL2XjPI6iEyV8QWmYtNmFUdyiXgjk+L58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949736; c=relaxed/simple;
	bh=fZGm9Vq39DWbz4PFlFJIeOvlYJ8fwLz+L0/EY8iEM/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOrNjeq1laTOpjFT+KbxsNYw0zjxEapZzN2MHCf/7EL+TCh2Lr4orRQvhV2lkivTB9C8LRGUJoh6X0tbf5ttzA9cGDbochn29mnXsDW7T1QuOwc+WP452pc8q2yi/7quTevOJ4T57vlz0HCd+CmJB1PoKuMTG7p+Jkxm6UIaKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCzYWFLl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCzYWFLl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7152e097461so773964a12.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949733; x=1719554533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNj73H7WYin+GIFCl/UxITc6e+Ekj70DYfq7txp4Bng=;
        b=mCzYWFLluNJ3pQANZZqSkBOtonX/EBty3duCjdnrN0Dlj/AgqBlqYRGYXJbk1NgNC7
         VfCNuxCdjLKKVRQT3dM8TvJWoRvBjzCH7nI4avN6VhD3vKt9BVX2p287ako6nniL6bA3
         xtMF+fk6uCPhx+HW4oaLRoa8RjgbgZicZTqdhc4094XMrLt8/Ffe6YUCgaCyQwkjs9bJ
         MOIOw+/oM5M4kpPP50WSgNn9uh45tPEPjbqWMnPXuRqb96cKivT43d3WmWeZMSOJIADC
         yTDPMnHCTF59cCUY9L1ZfoeH2V12n/Q5aVTGz4Ft9kCn6krKiZ6gQg7VURYQM/4gWgPX
         +vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949733; x=1719554533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNj73H7WYin+GIFCl/UxITc6e+Ekj70DYfq7txp4Bng=;
        b=qKlN26MDAr95JfvhcwI88Igex55tfRYe+Qv0EnpNNhFumcRwYKcr+CmBbVtBIvcPfk
         7AshJqraVUGmi3tbj7K6wHfSIZqSIlswFlqr4gbUW0xSY2fIV0Tiqs+BXQ773pm8cX0o
         6SDFAR0q6xODSR5KAhTzB1bCpix0wgtVp8YMxWg9Bs1BBupHCxa1DemXI0Jm0AlMPPQb
         efl2jBSGeSF6qSkzbT0QAri4AV40nkdgfVsipxDE1zhE9Jg6SlgP9z3lfNWip9raYGTb
         luI07Am/A8Sr7CgHVU+ApamlzOBFH8bZgWd0vx0K8PxZhWqiRb9Bc6ToY3Ljm9VUaMhV
         2P5w==
X-Gm-Message-State: AOJu0Yx55jM2Z1860AauREeJltolKAIc9U3yF/9S3C010lK1xdyrvaBA
	o9oQu0isAhG4b4ensxDMoXlHNklaz5NhwLNkbNEVM5KjDhe71mIoCBgwWQ==
X-Google-Smtp-Source: AGHT+IFDb+PCXIa5ShC+9ARO69CwEOe0tRs6/Q24F6dC4nJKwHl8nvxfyrgBMZT6fw2lfoRnc8RomQ==
X-Received: by 2002:a17:90a:69a4:b0:2c7:45a:d237 with SMTP id 98e67ed59e1d1-2c7b3b0eab9mr10567132a91.12.1718949733071;
        Thu, 20 Jun 2024 23:02:13 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:02:12 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/11] t-reftable-record: add tests for reftable_log_record_compare_key()
Date: Fri, 21 Jun 2024 11:17:10 +0530
Message-ID: <20240621060018.12795-12-chandrapratap3519@gmail.com>
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

reftable_log_record_compare_key() is a function defined by
reftable/record.{c, h} and is used to compare the keys of two
log records when sorting multiple log records using 'qsort'.
In the current testing setup, this function is left unexercised.
Add a testing function for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index e04aac8d7d..2765701214 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -211,6 +211,32 @@ static void test_reftable_log_record_comparison(void)
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
+static void test_reftable_log_record_compare_key(void)
+{
+	struct reftable_log_record logs[14] = { 0 };
+	size_t N = ARRAY_SIZE(logs), i;
+	char refname[100];
+
+	for (i = 0; i < N; i++) {
+		if (i < N / 2) {
+			xsnprintf(refname, sizeof(refname), "%02"PRIuMAX, (uintmax_t)i);
+			logs[i].refname = xstrdup(refname);
+			logs[i].update_index = i;
+		} else {
+			logs[i].refname = xstrdup("refs/heads/master");
+			logs[i].update_index = i;
+		}
+	}
+
+	QSORT(logs, N, reftable_log_record_compare_key);
+
+	for (i = 1; i < N; i++)
+		check(reftable_log_record_compare_key(&logs[i - 1], &logs[i]) < 0);
+
+	for (i = 0; i < N; i++)
+		reftable_log_record_release(&logs[i]);
+}
+
 static void test_reftable_log_record_roundtrip(void)
 {
 	struct reftable_log_record in[] = {
@@ -516,6 +542,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
 	TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
+	TEST(test_reftable_log_record_compare_key(), "reftable_log_record_compare_key works");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

