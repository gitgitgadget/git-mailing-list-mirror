Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD617176236
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971076; cv=none; b=nUJEGnwDFhD0sivEzpDqf6qGy74LgiYXUt1EA40AxgOEOPbYMhoAFLYM1ZxSqG/wbMuimHqDRDDYsCPtTH9TmfdsEnRsP60eMtC/TEri/xKWDJS3SJtVOlbNbdSqbpJI05A79aSfy5He7LHpbWFvEZhOZrPJSQCvsV5xyDDaiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971076; c=relaxed/simple;
	bh=C+rt4kgPBITUeCtMbdeCdOEB9OGFuMd6xgbnL0s+xik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9OyrR9poYXrpZT3te8Uo0WLEVC77cdzfTZT7qnGdpoImKBUdHKDjKEikaLnOWqzFZ/EzQ8k+OcNrTrfAq7Sy1aDl+AlmX6BkLa57tTdnPyNbKwJsm+6Q02UjHKkdmYL6L4OIyD1x+2b1XSpXlUdxJaacNw8EjsW56uWXuuijpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbiH9XBf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbiH9XBf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9aeb96b93so14681575ad.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971073; x=1719575873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIx8GS86bk8SfKIL2syVgphvVAr1B/g2nHCWHuiaV5U=;
        b=IbiH9XBfvzwlpwIvKUc1vmyjP7prVcHGlMd4jQcDiawZNg2woiHqspx2xQUTpI2125
         4clq2ZHyDkxW7EiU93jhvYJ1TKj5E3BmB1MBw5IIKZWvaDqnb0CEOvUuuHiyZ8/60m8x
         ZvPeOqi46uc2MEsoAR53018HyL8Tg2zGpSeKeCtAprAiYIbqj3lRiZwcO3/43912JkV9
         y03HUFYLGc5RpkBNUse4Z0djLM5p59ej94tMwaqICyTtqIEre74QgJKU1j0GyJQEDL+Y
         K4chw/9ureb6lmAYEkXFYRmCpqHsLCMgMqcL5pDrJf7207Rs0kk4S0U6AzT5mfW+mI+1
         Sf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971073; x=1719575873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIx8GS86bk8SfKIL2syVgphvVAr1B/g2nHCWHuiaV5U=;
        b=n248qcX20tnKPPA5YYnsgopnFbCWWSgwNu2W3Dumj/qyfECMvjAKfhy3Vd1W1QuVER
         /V0kmFB9wXGSiVq725+s0QiX5xI7rL6pU+8hG2/TWYn3F+M0FgKtismMCS0V3tSk5WEs
         wapCjwtrHrlL4qwqTQhnM/CbzEtC6cTD1hsqQ6PUIsOplDOgIGRr7HiPWs4aJZrNz8im
         owmJ6tjIqvp2iVEnhsdAaONB6T6IquySCNdICBnXCHz99jIfUdyUFZtGR9eYmq5F/C9D
         mU2O0fYvKpYyZ5y47WzqdvKEMpSD0F2q3ihas/CLznwKZBMDFj9mo4nYwTa71yGloZNV
         deIw==
X-Gm-Message-State: AOJu0Yyy5GVTeMY9Hn5hTkylDsevBpd+OVABmMLsWj1riBLwKZcpErFj
	4udyhYJ6D29qIXm5VVt0Gkb6nJirUVSawg0qG6qsnwSdwPDl9tn45HdeTg==
X-Google-Smtp-Source: AGHT+IFENjEVZZTHYF+ZuHO7elkKDUgxmkny8hqCo7M9bGfuXA4Ml5aRrk15L/VPK8jy8E/4pV6IQA==
X-Received: by 2002:a17:903:190:b0:1f9:ad09:e677 with SMTP id d9443c01a7336-1f9ad09e7aamr91394345ad.60.1718971073144;
        Fri, 21 Jun 2024 04:57:53 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:57:52 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/11] t-reftable-record: add comparison tests for index records
Date: Fri, 21 Jun 2024 17:20:59 +0530
Message-ID: <20240621115708.3626-5-chandrapratap3519@gmail.com>
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
index c74fdbecf8..9644f1de71 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -365,6 +365,43 @@ static void test_reftable_obj_record_roundtrip(void)
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
@@ -413,6 +450,7 @@ int cmd_main(int argc, const char *argv[])
 {
 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
+	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

