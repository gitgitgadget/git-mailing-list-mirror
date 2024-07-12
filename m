Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196C1C695
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763488; cv=none; b=NinAsiM1KvXPMBesBi8uQ8hC97PGQvGjhnzf/j6PlMvGZdsNlqz76oTM9dMXDlYjuvAWc87N09guj78hBGP9kcUST7X+JpFIHR8RSfK6gJ6YNvhyiR5A7dPPJTOUbxAozMv8ML05udKc07U1WNo4HP4YVBmrG0cTKxYgyndrmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763488; c=relaxed/simple;
	bh=00e1kN6/SKqHL5GZqiUCqWh9sg5zKKxoH48JjofguzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF89q/mbmn701bQiHeYf+tU/8yTylWds+yO1rT4jlkqdBczVHOr7S+pqqkMWVgNiMKePdgcGeG2LH0mDKyao1FWyTRKIpglL42hD/RCFphHulPbFjpXPtiQVLji+bSr20hTs3BekZXjlLi6UNsyJPPVjMo08kca9mzLFzLWbBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+U8MWzh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+U8MWzh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b48dfd6a2so1392785b3a.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763485; x=1721368285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgFjkKLbBIGxt6XBAj88PZ7GtKvgwfaKOYBMfRAL2Xs=;
        b=I+U8MWzhF4YEBWW8Z4DHErEDCnH+fXf93Z3gHct+pTqIsTN4D4d4TOfZDYAimjqQ5t
         ubyUPhhse0Y/mJIGLuvWwQl53lfjZ/kKk6GMEu6MAwcE00jj9mPWLK5fOzxulBp0j/nD
         cFALZY/9W2+/JE/fX1LtkpkXB5UK5o97t6qBf+AZC+aIgKW3bkXucsNbrtpS/bhGgHst
         ziI+Z4eNCKe1lhV8WxH++ygx9+sczqJU8xJrgEle5Fjg0xHQDW+wB1MF6Uzb06CByzbi
         rwxT9ErUnbdc82hB/RXONwVIT6WgJOqSyQ/u6GP8f45t42zoEqPLwm8/Zk8UmbQjw4dj
         Ciew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763485; x=1721368285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgFjkKLbBIGxt6XBAj88PZ7GtKvgwfaKOYBMfRAL2Xs=;
        b=EkIUeuEMa7f7XKNbHqhicN7Rh5vYOXj+RgMEXH8I4WUM51oUedJh++kOSDIHM/WJdd
         DX6dlpnDlExvAOvo9wVrDP+AnRC3se00nOzyQOmFiD4ryDwVVHCCEW3KiqN6sLlW457G
         H9R78BupCvh6UX8xr/4TxHr0Z4cMlzJqgP9DiZ2mZ9qfawQGsbaKRxYGPj4iken51KC0
         paxGw5p54n94iJWFMB9wImfpY/80a45jSzQqSTKVTk6P6sg3GOna26wFjrCglH7KpPMe
         xPv+2ACKRzCX9h88FNtvrLQNQesbV7iQDkTfznjXuiCXt7f0RvQ4MO7QVeFRWb8f8d7o
         UiSA==
X-Gm-Message-State: AOJu0Yxz6geavnqkvQwUmvA3RF7j/OhJt9b5NGqvWtjH/qqhRDcCam6g
	Z3jpGW4YPx9STGCvNoBML0fyIf/tLdrrpCeNDG5/9Dq9llCX/YQO98P6Sw==
X-Google-Smtp-Source: AGHT+IH77zDDLvex4epOmpoCOloPMiLiLpje7S0Fy5MY6mEMrgbgQkNBpqDicaihUmPZsGPXiB2hdQ==
X-Received: by 2002:a05:6a00:1ad3:b0:70b:1c7e:82af with SMTP id d2e1a72fcca58-70b435ef881mr13273165b3a.25.1720763485031;
        Thu, 11 Jul 2024 22:51:25 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:24 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 4/7] t-reftable-merged: improve the const-correctness of helper functions
Date: Fri, 12 Jul 2024 11:09:00 +0530
Message-ID: <20240712055041.6476-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t-reftable-merged.c, a number of helper functions used by the
tests can be re-defined with parameters made 'const' which makes
it easier to understand if they're read-only or not. Re-define
these functions along these lines.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index f4c14c5d47..ff2f448bb6 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
 
-static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
+static ssize_t strbuf_add_void(void *b, const void *data, const size_t sz)
 {
 	strbuf_add(b, data, sz);
 	return sz;
@@ -27,7 +27,7 @@ static int noop_flush(void *arg)
 }
 
 static void write_test_table(struct strbuf *buf,
-			     struct reftable_ref_record refs[], size_t n)
+			     struct reftable_ref_record refs[], const size_t n)
 {
 	uint64_t min = 0xffffffff;
 	uint64_t max = 0;
@@ -62,9 +62,8 @@ static void write_test_table(struct strbuf *buf,
 	reftable_writer_free(w);
 }
 
-static void write_test_log_table(struct strbuf *buf,
-				 struct reftable_log_record logs[], size_t n,
-				 uint64_t update_index)
+static void write_test_log_table(struct strbuf *buf, struct reftable_log_record logs[],
+				 const size_t n, const uint64_t update_index)
 {
 	int err;
 
@@ -90,8 +89,8 @@ static void write_test_log_table(struct strbuf *buf,
 static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
-			  struct reftable_reader ***readers, size_t *sizes,
-			  struct strbuf *buf, size_t n)
+			  struct reftable_reader ***readers, const size_t *sizes,
+			  struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_table *tabs;
@@ -116,7 +115,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	return mt;
 }
 
-static void readers_destroy(struct reftable_reader **readers, size_t n)
+static void readers_destroy(struct reftable_reader **readers, const size_t n)
 {
 	for (size_t i = 0; i < n; i++)
 		reftable_reader_free(readers[i]);
@@ -267,8 +266,8 @@ static void t_merged_refs(void)
 static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
-			      struct reftable_reader ***readers, size_t *sizes,
-			      struct strbuf *buf, size_t n)
+			      struct reftable_reader ***readers, const size_t *sizes,
+			      struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
 	struct reftable_table *tabs;
-- 
2.45.GIT

