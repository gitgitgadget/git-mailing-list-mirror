Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DA175552
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971072; cv=none; b=ZHMTzbhRPnTOk1bYrli/9FIT0KpaOJic/rpSgATcC1UvobbI28Zas2RGGD/wMbVUuN+12znM6+V3+UnrdgdTAsZQKyy8Uf044a7cIZXGsKlprqKr/8WEyq6NltizCBHdbojKqPxAdF0h28nxxVi20neIdBgm4AxBWiGINA1Y7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971072; c=relaxed/simple;
	bh=WcGJUDtVloXLVEimVxi+h81ea7dMs2LptXCXDaFIr/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g26cvMdZHZtVIVo0EkMbtZL5FGz3iWfj6YXAARnqomzyoBowJLKc+U2pHfa1A+t2ntNZlwjPuoUbFMngUz5m8Z+vCzV7oAFK1/1YF0/XQiQdlthMK0PeVx3QMvL0I9wFJ6srrxgCypZC9jbKOWsLVolRxQ4398XlzU0DDU9Ch3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2GNMn04; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2GNMn04"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7061365d2f3so1507953b3a.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971070; x=1719575870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iufUZiGIAT1BA18rMIbcTdxJaeP/q47DamJEmXGPIiA=;
        b=f2GNMn045ffnkw2v9dXr4Sil13mbMdjQA9KVjJ3jwb5JyoTPGkgaqoUujsbA9+lCUT
         gL2xC0CRLuLCCKIo9bdl8UNsewKTu2Ym6ENLD9FX8xvQ/LsmmrJylpM1pMofsdt1xeUd
         teeTI+5LE/i5tSzBd7IgCznwl9E77lpeDN0xNiSqajcBuby5CyxDCCfmOoLumUyvO+x9
         a2E66Jnbq6DUtshsgTWgARMVMQ2T5BUju60rWujmoBEanM041+lAHJT3FkXRw4K/wKax
         Y/A4VIjeoFsAqXcyp0BsXKH71lQUk3BUW2Tn59eafzgdTyeoTnQ5m7jsOqk8nW/enNyu
         DsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971070; x=1719575870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iufUZiGIAT1BA18rMIbcTdxJaeP/q47DamJEmXGPIiA=;
        b=L4tghD+eG/vC+58kNb/aTpyDM02R4kplW6C1kv+GRHymDklPJgNnSFmWEPZ3wXQf7S
         aADyaIb0BkJ/VS9KTGbUeODeWu6PwVeuEMJLCICA6s15VZpe3YnxUoAC1ILIwIPyfiYd
         4OvQkb2j86RjxBqcgV9eXiDIS9jdNdZVTVqw17eWtrYn/Q3A3uEPonGS9wDmkDlAhE8I
         widojAAwpKWjs9bvkUGUoEpOwtk9kZzLnyBWMxrmZy2XfAnAlpVT6qKU3V7ZnV/Bx5uD
         gbYbdoMOWR10Nc0MCUglrQCn2kMEl21Zr8qq33jqmNpBC0I9/7kMfZ+n4G6KQYuR8Z0t
         3jCg==
X-Gm-Message-State: AOJu0Yz8rtpwoGz35ssXdJSwP151MgQvFok7WtBf3T/CBRk1lULBTIHI
	SJMmwttY+18hGr25fJ3pLoIyV0/FPQP+Rkc80XljD4SyRbShhQyz8Enuiw==
X-Google-Smtp-Source: AGHT+IFlv01Wv7B6pfJepT7lqbI584j/YhtDh9dmIbZiJq9aZDP7XIqgAAUSU8tByJIxuHmb/S3Ytw==
X-Received: by 2002:a05:6a20:bc82:b0:1b7:4527:e291 with SMTP id adf61e73a8af0-1bcbb3f3793mr8151974637.17.1718971070071;
        Fri, 21 Jun 2024 04:57:50 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:49 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/11] t-reftable-record: add comparison tests for ref records
Date: Fri, 21 Jun 2024 17:20:58 +0530
Message-ID: <20240621115708.3626-4-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-record.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 0cf223e51b..c74fdbecf8 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -66,6 +66,41 @@ static void set_hash(uint8_t *h, int j)
 		h[i] = (j >> i) & 0xff;
 }
 
+static void test_reftable_ref_record_comparison(void)
+{
+	struct reftable_record in[3] = {
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = xstrdup("refs/heads/master"),
+			.u.ref.value_type = REFTABLE_REF_VAL1,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = xstrdup("refs/heads/master"),
+			.u.ref.value_type = REFTABLE_REF_DELETION,
+		},
+		{
+			.type = BLOCK_TYPE_REF,
+			.u.ref.refname = xstrdup("HEAD"),
+			.u.ref.value_type = REFTABLE_REF_SYMREF,
+			.u.ref.value.symref = xstrdup("refs/heads/master"),
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
+
+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
+		reftable_record_release(&in[i]);
+}
+
 static void test_reftable_ref_record_roundtrip(void)
 {
 	struct strbuf scratch = STRBUF_INIT;
@@ -376,6 +411,7 @@ static void test_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
+	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
-- 
2.45.2.404.g9eaef5822c

