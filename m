Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB4158553
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524165; cv=none; b=IIg6WjAZVSSXJBBfL2/tkDqiTKNUxlZp/nMOcywMkbNhD106BTRkTzRUaZJmL2TPNwNru227zjfBOipGrpQZinMQVfebCUkRXIBS0aDzxD4leKcZ0ch/zhFcpS8jBVfj2fKNmvXGRB5Zk7iEfZApge3qBy/YhQ68g9gfS2fV0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524165; c=relaxed/simple;
	bh=zHgYt5EMfHPid5ATZrHYDmyotN8vPAhsL4D345D80JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyJaic7YqpnH3Ptpf8tSJkkppDv3kSX+/d+NF77EwqG47z2OowgB5VK0VBv6CV6gLtHufqkLWM/ACwyRkEGJbyA6pxStINj891lth98ztUif6GpfqUb3AXqoBvLGzb3HdI1mcF+X4AVYhyTp6C5c75y9tRelM/RadQb3bUx5jek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqIA8j3h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqIA8j3h"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166360285dso124525315ad.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737524163; x=1738128963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28jZfOcxKfK2UzG27PNx/kXejqCrp9DUSkgWXfLGGg0=;
        b=cqIA8j3h19OgwyA8XVcrOkIB7zBHegj1V3gTpcMcrTkaAR7peVMgg0AqdlM+zYaxJ8
         uO3MXJMM0FcKdlJpTyEeNdDMO1u0eZGfMJgVac8G9VZOGbbV5RMiUdZkFS+L1N+MuvzA
         FM0GME99+CiDJEKdUxv0MbSfPEaTeRTZannOSzui2NuPuBAnZZ1SMPHd0Y3qP2cq4uK5
         0jdvskXrLuPJhmCRo4sCTs5Vt0h2wlWDVqE26ZTbLU6bK46CHr70nbde62fKfaJjK2zr
         anSLO5f4Ffz8cSaZy0EPG6iHssyWJ1CaFs2sC3P3yJ52uPm/43Co9ITe92C9sjK3EesD
         QHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737524163; x=1738128963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28jZfOcxKfK2UzG27PNx/kXejqCrp9DUSkgWXfLGGg0=;
        b=YIVXn4EoroGbGRpgG8+SnJjfqdkKjvF2eIx4zZ8ccBa48tTSlld+GTSEc8cFsjT/MB
         mQyoKjxm1EtJO32GfnCcX0bLgE46HVHwkWOS/bt+rnRSLSEw9RKCAzYUl1bWs+e5zbbm
         FGX8GajV6XLQDryGhlqqrsYTZBw/AH8Fc6Xfdyy1Z90aP6t++jfufb1lUbfOJ13+601C
         M1WB+hnQiZBOmfCtxj0mv9jhS5hpK4FxlfBgjqiM2ZTYdKCRbDaoyzy+1AYbbOz4Tm69
         u/cgFXRnPjWgu5UGSIdDL1fl6IqtYpt5SDZC2u7hQKCNXkxrfBKXXYEpBGQ6hFX1DZPr
         T+Dw==
X-Gm-Message-State: AOJu0YxnQZ9HaoUOSjuNpe/iEUtUPSicqyi8zs/jcPKwKjSpv5U0SO1N
	zp7ZFDbGyHEn/Wdav1++i28OD3EnikQ2sXRvCXq5T9O+3tqR1drI
X-Gm-Gg: ASbGncvxlNFUEL5/uz7zmzqdhz31182YNtUASjqBeoqhq8SfrD/q9CkSxRE9eSZWpVL
	uvLtDE3ARwx3J3KkDM+cnXKqCcLnKq1pY9t03dplGpFG8V5Fnj82qtA/PJQ307eshNJlcC4CBTb
	5Df0dgmmRo3ov3tTHHUOAG8n3uTdZUOxLY+vur/75Oieu7MTMRrWabdLfDmF/OKqz9T3R6lVdcN
	aopOrC7UauvyB590vw8/ZDfPLsWlRVXDjn6MuP8hnqbaIJvJg1a+lmxhyiNlqB6fDvp31OO
X-Google-Smtp-Source: AGHT+IEV25udoGZ8jIvVnTJCvFHWk12QiyE+mBVHcThrNE8lGdDpmZyIvKg6bxZggH2L59G/6SUP3g==
X-Received: by 2002:a05:6a20:12d5:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1eb21177f19mr29884182637.0.1737524163081;
        Tue, 21 Jan 2025 21:36:03 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72db4e718efsm9369207b3a.152.2025.01.21.21.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 21:36:02 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 22 Jan 2025 06:35:47 +0100
Subject: [PATCH v3 1/3] refs: mark `ref_transaction_update_reflog()` as
 static
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-461-corrupted-reftable-followup-v3-1-ae5f88bf04fa@gmail.com>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
In-Reply-To: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zHgYt5EMfHPid5ATZrHYDmyotN8vPAhsL4D345D80JE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeQg72OO3PWxNsss5YjgK2QGHsq4uqiAgyDZ
 LDwbTKb4zSfBokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnkIO9AAoJED7VnySO
 Rox/5KcMAI4guM4JRs4Kp08GDTwIRCpxYhdB268F513Vu3PcXxxjN0lxfrnmKFcWqHKbg7+GArl
 KG8BWte2Vf7Kp6JivkKNbyNy0YuVolPmg5qA8TNh53wEuXmLDK+vKXtbKYrcpsGKPwcRkEZFr/n
 LWaRyEPvzKQkc5QugpuaVloiqQnygRVdRvN1pBZGkiPU+/bNjmYAjT5iqrjxf8AFLbyzDo8maTE
 s93ksskVb3sw9cjEqa8qTrwHoAIzYKat9rumEon4iznx48xSKjNL4RfsBTPWCBGkjOsc/Iw8JA/
 vTKHdAxlW4Pse3HtkuekxRIhfIpCLqK+NEJ57zuGOV6lJKHpMX5QEGgTksi8CUhUG2wYcnsWhVV
 CrRWMyE0dbMumG0KDzg/aolKVmd0Orp0MU1r3Pj9El1p0zr4W4ntsrCnnqVeUjFsXwV39tP3YoI
 luvRq/Ynwq5T3T2L36EPWPoospCJyMz5wdhubDjfvRCl/A+NL5KraEdtCCN9kWbKfWBa75VLgu6
 dM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update_reflog()` function is only used within
'refs.c', so mark it as static.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 22 +++++++++++++++-------
 refs.h | 14 --------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index f7b6f0f897eb58665e10a2efd3eb53c3f72abe61..ad6d774717150f1fe68a59c629e05e49a469693f 100644
--- a/refs.c
+++ b/refs.c
@@ -1318,13 +1318,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_update_reflog(struct ref_transaction *transaction,
-				  const char *refname,
-				  const struct object_id *new_oid,
-				  const struct object_id *old_oid,
-				  const char *committer_info, unsigned int flags,
-				  const char *msg, unsigned int index,
-				  struct strbuf *err)
+/*
+ * Similar to`ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When not used, the
+ * updates default to being ordered by refname.
+ */
+static int ref_transaction_update_reflog(struct ref_transaction *transaction,
+					 const char *refname,
+					 const struct object_id *new_oid,
+					 const struct object_id *old_oid,
+					 const char *committer_info,
+					 unsigned int flags,
+					 const char *msg,
+					 unsigned int index,
+					 struct strbuf *err)
 {
 	struct ref_update *update;
 
diff --git a/refs.h b/refs.h
index a0cdd99250e8286b55808b697b0a94afac5d8319..09be47afbee51e99f4ae49588cd65596ccfcb07e 100644
--- a/refs.h
+++ b/refs.h
@@ -771,20 +771,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
-/*
- * Similar to`ref_transaction_update`, but this function is only for adding
- * a reflog update. Supports providing custom committer information. The index
- * field can be utiltized to order updates as desired. When not used, the
- * updates default to being ordered by refname.
- */
-int ref_transaction_update_reflog(struct ref_transaction *transaction,
-				  const char *refname,
-				  const struct object_id *new_oid,
-				  const struct object_id *old_oid,
-				  const char *committer_info, unsigned int flags,
-				  const char *msg, unsigned int index,
-				  struct strbuf *err);
-
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be

-- 
2.47.0

