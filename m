Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E047829C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906598; cv=none; b=FJIW7h4EelXchMjny46q2gqC6OZ9/LEKil336FXYWmTdMXRpALsEUsaIh2eatE+ZP1wtCxETDCvoyUjvMNB97ex8USUbXJyzfC+6xjwrE7Vo5TTzmz3e5ng//tXpcfsP/PHcdV18EOTurWsJLOf+Jd9hbngld/6iVUgD46FNR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906598; c=relaxed/simple;
	bh=F5bLrlEWWUDXQsHpj3313xyBzLdZk6CM1Y8+etrKs2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmWGVVG+DXgVeijQ7LXkydbBatBXpBA2/xJ5glmuPEd9kcV5R1J3+/pKVeV5SIDWF7aQnIAD0C/KqCFDl2teyofxlbuiXNeiLf7amaYX77l7YD+K9PhyGYWqeyvH/sKAQlO+D5Lz7TBGlXCAwREgGt6rF+TD1Yk7uWsWX878sCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yuq7EQxA; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuq7EQxA"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d846f4360cso449001b6e.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906595; x=1720511395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtKV7FnKyM99LU76K4C/3KT2JrZsiw6RCQIs6XSjxSI=;
        b=Yuq7EQxASmY1+SmolmAfWZUVJZfvLvM6yYr1HpLYb22ug3oKunTHAPnwyEFYeplEkn
         eaQVbmgTRXwN42P67+Tne2UWOy1/GjzDrq8wf2vcVbnq6PhLgo6/uxMWIgJWJFSFKOr2
         /gbtocH/K7N9AKCkwgY9QN4svNO8nbhVVSr0z6+xwlCCYzrDp6cqXXJyH2AYo+5GRGXG
         NlyoXJPhafUUkq1waTzq2LPdHvlqM7lm33/r2ZRIsSjbLm3Lqt+2KDRszHQbYAnKCImM
         MVbowcshNCZ+CbhOVC5EL7BEI6Ohrx8cwzAWE7BsBhQjVD3SZE4MRHfnUrsmEtYys+Eg
         ztWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906595; x=1720511395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtKV7FnKyM99LU76K4C/3KT2JrZsiw6RCQIs6XSjxSI=;
        b=ccC8UjKvGVQl27AVey/eNmQJcaq4fhAnBYdZF7QQgiWiaBmovNtjCGRnh4x8qLoVde
         Webqx8V4WVF2AKX/ptQLiM8nIlSnlHPpSHcMkj3yrMPVCZeB4omPe9YYPKR/4kSs9mAg
         m6vek7GsqAOV+5KNz8Vr3DxKtA/ZbH2EOqwq/z6dSa/WIzdISFe9YG/Ka3+3FqN1G9YL
         fk6aTvTfTddutC+BBucNncTQEMg3rClBekiPyW0ijsTq4VTsRvUHbxaGcjM5YV/MWUtD
         +ve8wqKONFk+goGMVzlbZ8OSE9huZLbrVJPVA9N4F308aBUXvj//pGwhbesi3yAV2Klc
         xWQw==
X-Gm-Message-State: AOJu0Yz/AX91BCFlgKI8p4H7UxB5i6J8unuABtrfU7LwusIbR1u2BleP
	4mxgoRX4Hdu1c2onmP4L/MsUSTiJ2HqZ5zHFi+HVd1en7eqfisV2mlA45rBFfsg=
X-Google-Smtp-Source: AGHT+IFHUpdr4ahk6870BkMlwwRf1m2M2vyF2gljE0otp3/JUUT0uT6+qK0hIZAqgZF3pbHolbgzmw==
X-Received: by 2002:a05:6808:1823:b0:3d5:6410:7dd8 with SMTP id 5614622812f47-3d6b2b23729mr10862652b6e.12.1719906595055;
        Tue, 02 Jul 2024 00:49:55 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:49:54 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/11] t-reftable-record: add comparison tests for index records
Date: Tue,  2 Jul 2024 12:52:17 +0530
Message-ID: <20240702074906.5587-5-chandrapratap3519@gmail.com>
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
index 99534acd17..e8db337eb8 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -357,6 +357,43 @@ static void t_reftable_obj_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
+static void t_reftable_index_record_comparison(void)
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
 static void t_reftable_index_record_roundtrip(void)
 {
 	struct reftable_record in = {
@@ -405,6 +442,7 @@ int cmd_main(int argc, const char *argv[])
 {
 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
+	TEST(t_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

