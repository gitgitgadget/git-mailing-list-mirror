Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A9370D52
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560743; cv=none; b=YqFrrRWBkyFKEVukrEbC/UHX0zL/C3hsBR8TBm9poIe4XVEIFNTfHCS5IgX1s3Os7iZrz41mKAOp2Uw71qkO+xZldSU5gcGDR9YYQBNwXHJsNgMgil0Ada0eJQ4O+oCaP3Q8bokSz6s+TveXWEkVFk/Tw6k837pzUIOM17jv3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560743; c=relaxed/simple;
	bh=BWv0Yj6QEFztnJj9AdJ9jMzMdFEvjbHDLkB2sRapuyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GffINRGYlwLLl8ZYnLtN+btMJgvHSbs81I6KgKgVrK6rEM68FSX/DRTlkHaJwglQmrl5iHjDEFpACDwdKucEU/q6nhwFE6rw/9DHy4A0WqXB3ZVysOPEVIzYGm2DDqFjs5OxlKfrtHWjdyzyRdivCZm+MI5UqQTIlZMFpr7M+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBlpv8u/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBlpv8u/"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82748095963so2971401b3a.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560741; x=1773165541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7hBcnnY2xWSLv0OAn8l9rm6TOPs941UEb4Xb9T5hao=;
        b=hBlpv8u/S19T1GU+h2TFSHdOlHZrGl5xq2K9NooKDljYTvMiSI+QaEOeuz++waG+q7
         h664VjUR6AnYl/5OiDSW4+GZhPIRxaOCqwlWaxbDMa9OKdzNkjmaseQS3ZznZXS+QrYs
         1KVtr2U/FiwxW18/mcAVqe9EfrUlDlDmmay3WWO6l4PkD6g9/oFHSMuRbrbvfB7WjX02
         JiO8jAHHk96D6OxPj/qYEUpkYEhfw6QjHsGIv//BlWSvtITrK+sScToa0RjlBLsAa0Vf
         1K6RkBN2lYjhdTkgAoX+xQL6gG+DyBPWhguBODxRRTIBMikMkh7TPbwtaxZfUMu7d6cs
         hjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560741; x=1773165541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x7hBcnnY2xWSLv0OAn8l9rm6TOPs941UEb4Xb9T5hao=;
        b=wG/r1CZOfI1mB6NsclQShI3K9HWCQ9MLLw57pUwsAvP7rFsjScgWvs79R2og7tiz9b
         tM0LQcrhrUA8gpnI39tZhN6j6dsee+uE+kds/tthCJBMK/P7kkj8oYUfXsC0WZjpsMW+
         kUfe78/vKfNt+1fmsnvoYBNh3nr6qdC1ang6xGTJaYYlE74lRNh4h8B6mY2DGpwd15M0
         cEMgH6fWX6m8QRmNw6oEcDCvi/l6+t+vp4Cmbd/kzHU6KJ5a7PQsLFTFse5lpws+AxBL
         2A9JZkmBrkRkhWVSdS3yrqbA7XtX9DsvWzczkj5y7hhfUF0jqJKxH5NC9L6g7q1hSNRq
         4G3g==
X-Gm-Message-State: AOJu0YwvK3Ui0dh3lM8/+ePupNaTdIDHQnTTz10Xutrso9sr/9fZws63
	98YIwaxbWZCRzxwf/dHyUHyTLxKgMeR+tbBIeJR+nbiBqxrx7HxV9Up52p+67WvInW/BbA==
X-Gm-Gg: ATEYQzybqD5s/6lW5CoJCavFpviY/yUcBsCkJrlJC/SpM3SY15xWMzQHLBxwazE8cWS
	f4UMiO+DwLghXWsG/6ktkS49ZRGQpSk72oefNz3lGt+UmfHxZ17tpe7zoHqG7no+IpMXVVogwOt
	4nqskmWbQpK2BU1tC2/G0rkAS0M0RVji0ZfAxbRMnf2EopUp2/U6DSdeCbyhjYmL8l4pfpd5f0N
	S6RLGCy/bRsUER2OwHjZPzF6rQF+ChmmGfQhY3K9Uz8ZJyHddYcPkJjbhLVAO3BUfAlUhhduqlI
	IG58OYfnftXBHtGSaWZb2wcLt5vCQL2zZc4ltqhchXad9Z5cX2Wi0xphiqmXfugvsS55AV2DsAp
	CxEksZKEaj78gOuP+AGz1AbVbLroTK92AN1dXa+OMF9Gshgov9Myv2niwrsjJBjvOs9PAejBgv8
	ZnhGYki/HnjTAGPxwPJdic5mlWbJ9qQboWgWfWlb4VFkAs/CCE6gLJKz79W8ADsXOFWpAj6etQG
	k2HLn+A9dG+RgQ9Tg3qVIT9fUxu3EfD/Wsd7zS2eUNdjRqiSfk3ulPlSmDcJqhIO6Ag
X-Received: by 2002:a05:6a00:a055:10b0:821:8492:7f66 with SMTP id d2e1a72fcca58-8274d9566ecmr9175538b3a.22.1772560740860;
        Tue, 03 Mar 2026 09:59:00 -0800 (PST)
Received: from ThinkPad-E14-Gen-6.. ([220.158.168.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a059e89sm16216764b3a.60.2026.03.03.09.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:59:00 -0800 (PST)
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Subject: [PATCH 2/2] t7412: modernize path checks to use test helper functions
Date: Tue,  3 Mar 2026 23:27:50 +0530
Message-ID: <20260303175750.361563-2-ysinghcin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303175750.361563-1-ysinghcin@gmail.com>
References: <20260303175750.361563-1-ysinghcin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 11 raw 'test -f', 'test -d', and '! test -e' calls with the
corresponding test library helpers:

  - 'test -f' -> 'test_path_is_file'
  - 'test -d' -> 'test_path_is_dir'
  - '! test -e' -> 'test_path_is_missing'

These helpers emit a descriptive message on failure, 
making failing tests easier to diagnose than the silent 
pass/fail of the raw shell primitives.

Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
---
 t/t7412-submodule-absorbgitdirs.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 41ee035e3c..cdc7f59e12 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -34,8 +34,8 @@ test_expect_success 'absorb the git dir' '
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
 	git fsck &&
-	test -f sub1/.git &&
-	test -d .git/modules/sub1 &&
+	test_path_is_file sub1/.git &&
+	test_path_is_dir .git/modules/sub1 &&
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
@@ -47,9 +47,9 @@ test_expect_success 'absorbing does not fail for deinitialized submodules' '
 	git submodule deinit --all &&
 	git submodule absorbgitdirs 2>err &&
 	test_must_be_empty err &&
-	test -d .git/modules/sub1 &&
-	test -d sub1 &&
-	! test -e sub1/.git
+	test_path_is_dir .git/modules/sub1 &&
+	test_path_is_dir sub1 &&
+	test_path_is_missing sub1/.git
 '
 
 test_expect_success 'setup nested submodule' '
@@ -72,8 +72,8 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
-	test -f sub1/nested/.git &&
-	test -d .git/modules/sub1/modules/nested &&
+	test_path_is_file sub1/nested/.git &&
+	test_path_is_dir .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
@@ -109,9 +109,9 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
-	test -f sub1/.git &&
-	test -f sub1/nested/.git &&
-	test -d .git/modules/sub1/modules/nested &&
+	test_path_is_file sub1/.git &&
+	test_path_is_file sub1/nested/.git &&
+	test_path_is_dir .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
@@ -155,7 +155,7 @@ test_expect_success 'absorbing the git dir fails for incomplete submodules' '
 	test_must_fail git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
 	git -C sub2 fsck &&
-	test -d sub2/.git &&
+	test_path_is_dir sub2/.git &&
 	git status >actual &&
 	git -C sub2 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-- 
2.53.0.290.g4805bb9930

