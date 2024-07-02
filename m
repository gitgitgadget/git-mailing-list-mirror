Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3214D2BF
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906591; cv=none; b=d0Id2tHabhszljzj3Mlpe/iicjlGaAxhbDDuL+3Ye7WG/WBdTf6AEQbib16IrJPX1tUzELg19Klf/5vBjE8GvWBP18LuA3xRw2dit8weP1xK5qcCZnA9degDZYsWSpCeulSDBeumwZJW3zyyCRQMSEYEqav+nob21/W0r2B1V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906591; c=relaxed/simple;
	bh=vo5Co2h+DLd2xY9andqvyIo/UE0tdrjeSh9dsLiK3/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHCNMwooY7E1doW23S8eVFN6U4BnkQ4p04n4m9zkPYi1NQAC2UTu2LUNo/IbKHuswVVerAe41ML/kz8OaR4/cuZdjXXuS35v6/aQabxQkiGFtsw97BZIVGyi67QsL6guFJik64fTXzjmzVmzlVFnpF6YN1c+EpnQt7Y8tdUVWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSh/1/Cq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSh/1/Cq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70670fb3860so2380508b3a.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906588; x=1720511388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRSX5JZuaV1ReK+PxniiN8ERDcaaohcGmBRdbjkQOnk=;
        b=fSh/1/Cq3XlEtVTtBGbAC5VyAOa6ihPtNinpz1CKaqjcc+uiQ1fyINlDndWKrmTl55
         YmngSdtqNuPZd+FTnmhwhchbeTjlPvBUR6TxfLIvnhMWA9i9e/ImnOkXj5Xw1GVeqEL6
         BeHMT9JXxEWnEBGjJWah3vCTVuQOmIKumBopOLndtidz2Pn/Cr0DfX5n1Xs2G+HeJxhq
         jt1wNU/n/FmMtwZ/KaxEJWSPyBX7t0F+ploQXmfOIoS7trQuq9tqhR6765TcYPM4uXyE
         Lv/IWTQVWTLUMyJJSkVhkYosjE5ExaKW2IpFNaSMEnweOaAmO9lvvDE9r2JYtcD5PkRq
         79Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906588; x=1720511388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRSX5JZuaV1ReK+PxniiN8ERDcaaohcGmBRdbjkQOnk=;
        b=fH8HxvSBk781IC0nnYSxbSPIs4K45aU/wdhGUPdGHl7BXslCqonZVO1f8ktK7GsTLv
         9f+SK8BYC01PLIsOiCnkv7zwBQgY8FDLoVtadSkckgAIUbp51rRWIRdX8/xoh0As1sba
         47qKDUkqzHoTV7FiPSBbKDwcCP7mDej3w+pE653QpFp2mFG5YDn4pIW+l5YBEKKY4v8Q
         wzmnJtfVh4CxgT21lgJaNKNwPlwZ1FLaXAKtQdiKSpuncfOu035LKdDKVpe/W9LXQTcp
         n3TPsr1kKIBFGmf6/RJl5vHCEhcNxQkivFu3vIxyeCbTH15HhTER2LMmN51CBDng4hv5
         ZyjA==
X-Gm-Message-State: AOJu0Yyz0ooOoe9K7eCEImpMJRke2rkJk2AZM6K227/2xmQlr1yYsgGB
	DG+0xEPSdK7PL8MI3QYjjWTlSN9OV1FlkmfualATkGt/UtNoLJaSiLNIPz3s5O0=
X-Google-Smtp-Source: AGHT+IFI44vJ0dlyMiF62gHB0+VPwFSUvPI2s94YxQTt/yK5ZjOQgfe7hYxI76e6X3eziZBijxYxZA==
X-Received: by 2002:a05:6a00:ccf:b0:704:1c78:4f8a with SMTP id d2e1a72fcca58-70aaadd0f42mr7452284b3a.21.1719906587908;
        Tue, 02 Jul 2024 00:49:47 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:49:47 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 02/11] t-reftable-record: add reftable_record_cmp() tests for log records
Date: Tue,  2 Jul 2024 12:52:15 +0530
Message-ID: <20240702074906.5587-3-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-record.c | 38 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index e799464c36..dd64e71f3b 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -120,24 +120,36 @@ static void t_reftable_ref_record_roundtrip(void)
 	strbuf_release(&scratch);
 }
 
-static void t_reftable_log_record_equal(void)
+static void t_reftable_log_record_comparison(void)
 {
-	struct reftable_log_record in[2] = {
+	struct reftable_record in[3] = {
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 42,
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/master",
+			.u.log.update_index = 42,
 		},
 		{
-			.refname = xstrdup("refs/heads/master"),
-			.update_index = 22,
-		}
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/master",
+			.u.log.update_index = 22,
+		},
+		{
+			.type = BLOCK_TYPE_LOG,
+			.u.log.refname = (char *) "refs/heads/main",
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
+	/* comparison should be reversed for equal keys, because
+	 * comparison is now performed on the basis of update indices */
+	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
+
+	in[1].u.log.update_index = in[0].u.log.update_index;
+	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
 static void t_reftable_log_record_roundtrip(void)
@@ -359,7 +371,7 @@ static void t_reftable_index_record_roundtrip(void)
 
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(t_reftable_log_record_equal(), "reftable_log_record_equal works");
+	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
 	TEST(t_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(t_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(t_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

