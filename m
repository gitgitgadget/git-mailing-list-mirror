Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF413D53A
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949709; cv=none; b=RmqNN3xiBFaG/HbTeyaOPOzOu+hK8HprUDJ1aSfKB8E8ic+ls8VmLTDZX6M61zWQFsqgotpB3owo62jSVHn6MmePl6zXA6IGRT9DXEbQPIUTzx9uxU+/FX4fh409FtxuitQSO7H57Io2ZLvXAc4H+eOJwz4h/89Ma+BKVeQqF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949709; c=relaxed/simple;
	bh=uoJsoHG++tARpr7+ZrrF8iXyGEAqHJXxMRep/lp7SWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mITsnsuw4bhLZxbcrQIjpd2D2iAl84Rufdix2rj6YHLZ3qDpLkYD+rvxh3NYK4IX2JMhprSyZKUkfmi1/flcTOHcS1oyuAnzdVuCL+/Ilmipjt4jG9ID3PEnpTZMFxefxF3lT3QWXJrY7b+2QeoL/Ad1YiZPN53eJe0hUNKGzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORlc/ZO7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORlc/ZO7"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso1363966a12.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949706; x=1719554506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxXlvChIkI3a8xen9u27ZJG7F3HH800XXoiAUx+/lG8=;
        b=ORlc/ZO7sVfDYuDqHixwDacA64faohwJGcBHTt4+Cn3AnzKTlW148ay4Pr+nZYB5BC
         2F7RaMz3LB7oqYb0lfoeSgmaWxfXd5LxScEWfArBEEoavjMgGEKpaz7gArotBfN+tZsc
         TTsaSQp49bY02ukR8n4TxV0O1YdSD3UDGvMVWJbsux1Kvw45aXf9jNl7G4U/mAObih7z
         tyv7E5GX5LrxoL9j6lANBbsHRAX0J4m3vaWDeROSMhieiwCeni5n/S09+y5ALVN+hMTI
         GLxt8/3X3LwXOCxi+XBGVM+BHC3UTNWUE18f4e+JQ5Q/+Mb/PuVi5pXpUQbBQtjqudsO
         OHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949706; x=1719554506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxXlvChIkI3a8xen9u27ZJG7F3HH800XXoiAUx+/lG8=;
        b=r7bdjyrsLLfNiocaoJUvZ6HijFpd9sYieyuxql6lqO2KHYZnCql3ncNw68nchdj8F1
         dr8CgPtkf/XbtYvklLh/WAf6/vZI6WpdKYAbwXeajKziLrOpxGzn1k8fwNi9wMK6GSu/
         2Fu5/IiMI2qh7MDNgX5pSmn3Ls7i1sKhc5/x5MxsnXZO5UHi2U1UUsG99Fs108vSRIw5
         WKbNj3TDKLzlMLmZoodPUBpW0kSzFbBnZvcTTe9Mh7v3vX2xl6r+sXCaQasWa/iYgH1P
         sqs+x/qF1IvtNRpKOHIKzdyivJ4J8ZyIuwbAwT/d4PRU6iIciFAupmhlVo2FU1+MBbZi
         O9Cg==
X-Gm-Message-State: AOJu0YxJJMsSKnskJVM4KLVJh2xyD679alGcapIg7bzwIqmFf9QNc1eJ
	jB3dN/qzbwZmH4KdBTsdnItXRHMg6nM5eAeApoDMMiE6JIOm/0vfm0atyw==
X-Google-Smtp-Source: AGHT+IH281CwNsxfgoD7m2Pc7fKD5HBAchBU0/bBs7thbe/gvIIFEoVboO+Disrfll6XSwxS7Be0gQ==
X-Received: by 2002:a17:90a:e001:b0:2c7:9b9a:7619 with SMTP id 98e67ed59e1d1-2c7b5da88b7mr7180898a91.32.1718949706158;
        Thu, 20 Jun 2024 23:01:46 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:45 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/11] t-reftable-record: add comparison tests for ref records
Date: Fri, 21 Jun 2024 11:17:02 +0530
Message-ID: <20240621060018.12795-4-chandrapratap3519@gmail.com>
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

In the current testing setup for ref records, the comparison
functions for ref records, reftable_ref_record_cmp_void() and
reftable_ref_record_equal() are left untested.

Add tests for the same by using the wrapper functions
reftable_record_cmp() and reftable_record_equal() for
reftable_ref_record_cmp_void() and reftable_ref_record_equal()
respectively.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 4913a82441..d25d11c7e1 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -66,6 +66,38 @@ static void set_hash(uint8_t *h, int j)
 		h[i] = (j >> i) & 0xff;
 }
 
+static void test_reftable_ref_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = "refs/heads/master",
+			.u.ref.value_type = REFTABLE_REF_VAL1,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = "refs/heads/master",
+			.u.ref.value_type = REFTABLE_REF_DELETION,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = "HEAD",
+			.u.ref.value_type = REFTABLE_REF_SYMREF,
+			.u.ref.value.symref = "refs/heads/master",
+		},
+	};
+
+	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+
+	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+
+	in[1].u.ref.value_type = in[0].u.ref.value_type;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
+}
+
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -373,6 +405,7 @@ static void test_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
+	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
-- 
2.45.2.404.g9eaef5822c

