Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2E12D1F1
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949714; cv=none; b=ABkJ3zjwm10FeF/G4H7+1asVyFwqLYt+D5u4EzK3Da/SLEd9MOLNsp6GXhaKNFVRiK1Uw3XrtaguVrTYZXUrJJbf/zQ/+5FTGqbrfmnIcFxIbRMd74aD0gHzoYOfaviGnjPvF/AGW+KfyOwOXII20TuFGp3uCB3uJoTOa0dwxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949714; c=relaxed/simple;
	bh=ze9UNMvk1PdVPQ1skTFc1t38TQNJY5R9jCuIqkZCahA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzc2+QG4I5WAl5IlXsiJuSo0Iczb9nkdMpG+D4svogqGSsG8xyUbneN9GuLCusBF3VMS/KqEcwwEUePIIZgnrm+dmcwiWD8nuaVfPNbCluOev7ssgB1iRkJtISkrW4lWPrhn1dPiEpIMK/fLOQHOyPPxeJjmzIEHt8DfF+Y2+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCOjmpso; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCOjmpso"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c80657e4a3so738895a91.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718949710; x=1719554510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah6uiyzYH4PMxVjnjQ06uamLIux3nuA+ksFWHV+28Nk=;
        b=BCOjmpsovhdE2pEyzknemfnR4j8uOHVO/Xa8zaqdWQFjPjW6iyek5KZKLp8euMHGYw
         KWmBU1EtvmU1pl/0W3rOpgDY1VrlF5B2DyFPWM6EOy0apUrepfGkDC1z7K3yLz3XEhI8
         dHrGa6pJhHhJQjl59rGg6uiDD3VgIfsBG2iS8sv+4xXtf/lmaDJl/mH0M63zS0VUO6Z+
         6oPWM3ZbHhD+SZ0GmFdbjkqUi1Jd0IYbTN63uV9z2D3KMkeUwxvwA+OfPnqu6jNZj2CB
         AuaHMOcw/GXNsdgqxxA5rZgKn5lA8gY2FoGgXj5seXvOtYSjrg6dJNyg1f0xnqdU+UnN
         7P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949710; x=1719554510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah6uiyzYH4PMxVjnjQ06uamLIux3nuA+ksFWHV+28Nk=;
        b=VPujJA6xmOOlj12QD3hR2WGe72/v1jg3Lxcbki/HCc2XdSqgPGIFWO51xAeGatXj66
         k8PH+eiPlgxHMXxHpgnOHssKQ4b8anMR8N4mJRAxKSxZAuP3nACCm9FQpFkClToASRQw
         TEUKHHTvC/+DhrMwM5WJ4hrE0iHMpmIGKnOc5089vGiEJYa4GTeK7cwUcviHLlwaEct5
         H1knPS5y9BwuioTIRqcq0L120YjAizKLMGCL/IXPGYKtw8CK5wBbUQWwHR9Dg/yuvu31
         4MKExujwaS1EBYmn1qGbg5DcA9i2bDsNjMKSudqxgH09MmjhCspcD7vpESiXimyMgNqz
         zjLw==
X-Gm-Message-State: AOJu0YxLxazjP5B3zGGK2ZLiYNq66bDNFEC9RXbwctzaSbbNnAWUUSUI
	uM8L3QMxv8od9/F79FQU3kjhwbwBDq18ChR7fv5Lfg7/tNKEx8VTGV0nrg==
X-Google-Smtp-Source: AGHT+IFEXRhW7cmdbNbmSaR7DLNEEtORMYjDNQ7ETd6YlCOzaOohAyXiZTFwMHHfGCdg5fboHBumHw==
X-Received: by 2002:a17:90a:df0c:b0:2c2:f6e9:54fe with SMTP id 98e67ed59e1d1-2c7b5ca5289mr6820536a91.27.1718949709469;
        Thu, 20 Jun 2024 23:01:49 -0700 (PDT)
Received: from Ubuntu.. ([106.206.192.103])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c81fe88e0fsm498661a91.3.2024.06.20.23.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:01:49 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/11] t-reftable-record: add comparison tests for index records
Date: Fri, 21 Jun 2024 11:17:03 +0530
Message-ID: <20240621060018.12795-5-chandrapratap3519@gmail.com>
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
index d25d11c7e1..1d102fb547 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -359,6 +359,43 @@ static void test_reftable_obj_record_roundtrip(void)
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
@@ -407,6 +444,7 @@ int cmd_main(int argc, const char *argv[])
 {
 	TEST(test_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
+	TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
 	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
 	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
 	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
-- 
2.45.2.404.g9eaef5822c

