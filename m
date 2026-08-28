Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17C2E7F25
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908090; cv=none; b=bnJih3CpPAgepMpHeePfA5tg8SaeAs0SLxP8IHng5tLjhqjvo03xYJ/F3p5rUlD38nKc7p/Ts4B7a25r/0FexTC5RJFwsCYDNm8e6uTFXg56MV64oJhSi/O+VtwgkJWC/XLhCeC8qo2f3/r7KasvUQqg3mXy4vNYDrVyNtwRZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908090; c=relaxed/simple;
	bh=FpwtHaCi8oZloV5nvw3psfVtMotenDREYCfLN6pcxlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n6OUA3Aq9cnFFhHNbTNJyBUCwGJaAZxaXR98+srlKcU1lFKLHrytptRap3Lfeaf/Xm7tezI/18jJNbDnaPAoVxL9f7pffcE27ZirmsO06QlUJfZ9pck/IQKz2cGvptWgKspBsNdioGYA1XzhxzXm6I/hPGob3tsyqwBkxaDGSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+6RgaCX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+6RgaCX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so5912745ad.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787908088; x=1788512888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ige02oeVeHctzbOzXHnOb/6Kp0o1EZ8p5BJvWQGjoWY=;
        b=K+6RgaCXEtDtyAbxHt5x4kfhlIY9w2QGwJH3YRnq/AfUgZE+8CKIDgBWIK6Km4T5AG
         JMGnQsNwK1HJQdcqrUVbXG14n6Mip3cqL1Jp2xUqygu1fcuRqtXhRguqZxPHdaFkWNxq
         93ttDrP5Ju8eOq+PYKMKN1H7wlmSL2CXf5ocrgKn0XNqkEZIHNf+uojdHFnYek69uEA0
         orzDtSv/p0AgFdC0dr3w0bQh/kTNbNL8Zz2BuEFLp2irk7U6c9hKB1LtKWm7B/gOcZRV
         BZIDQDlbgcJ5s5S0pRPwMBa2gTpw4GT8+7jE4Pn8Twt6oxApQrrxcLJeADjC24VUHuAI
         Nqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908088; x=1788512888;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ige02oeVeHctzbOzXHnOb/6Kp0o1EZ8p5BJvWQGjoWY=;
        b=EJ40/Ux+/0LGZ46vGjGwHuxZ616dZ6FjPPPtHSwaRQli+se3WnmxjkV9qaRvmLbY2I
         5MK84YUA1psurMWD+WFH+WOp3341D245WaBmVtojMgOwsI0v6/ylQBsTQj79tV8/2oh5
         Y9oe1mNSpqaGT4mSavFGfnsvc3+qxGY8/XSZ9rMfyzZiCzqr3MMK1ChnG6woI8ux39zn
         szjQmCTK3YqZozgxIxuZ+w4Q4UYuZcCLPSKPvuchdsJzwixJ8tf+ZF5nQiUp9alfY3VM
         6T5Nl8+AY4NIuRo4/jaiSIK0WrtCH2D4GrawS7aVR30HADnffq4AqhdplGmKqoqhC8NX
         7EiA==
X-Gm-Message-State: AFuF++kwwX2lRU4ZlmavQSEk5WNkTfYWw1L0MTWjQRcREsUtLOTM4E8o
	OUL/LvNOJXzUJH+EFodmS2ofIMpsaFEMNb2FuyxR9qbUnMZkb+KKRBzg4ZlK+A==
X-Gm-Gg: AR+sD11cTMM4BXUG1cPe7aJLOxFss3JsJo7+z8urjcMRIXwnHCb5kx5OPzPRhv5WDBO
	eWkSIkSnBbv2aMmdDo7NI5ouf4amoTYSIBQOdBOw2Cbll69U/1ozbpFaHDfq2Knqs+Wx2O8S0Cd
	Nn6GGvW7YYuVAzUFk/qTRWB9bEvozGYHjiyEfdetrUsjAgTNGs6GGnIs3oMcnaHgCapf1TB8k+T
	ZGZicxrn0KB4JNT5+b3XocA4liJ5GoFkQ5gINq0hcBpL4wRY/8frbpVNXNppIt5rrkp0NfNPpVN
	AGS6zSTpdXhnJG04/16iJc4YLxsoshORmXH0EWWSa+dZGf5Ae2XKys/OO8j+rOZHDkhtpTKcAhV
	0Fz3/LCesFB0PAlC5U2VtmrZlackWivPtcqKZW68zkwWI/kuXXSvnt6SQceHMsFYJKdhT85wJ2R
	zpYuwz+yRVQxq6QN6o/UV/uO/EVUzPDrO4hg4M2vQmRk8y5VkNMbXRJiJd4P3y+Y7R
X-Received: by 2002:a17:903:19e5:b0:2d7:b5a:b1bb with SMTP id d9443c01a7336-2d74dc800d5mr117721955ad.8.1787908088020;
        Fri, 28 Aug 2026 02:08:08 -0700 (PDT)
Received: from [100.87.176.22] ([112.79.22.96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f80a0a5sm4246984eec.11.2026.08.28.02.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:08:07 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Fri, 28 Aug 2026 14:38:01 +0530
Subject: [PATCH] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-typo-fix-v1-1-24e80a87ed53@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyML3ZLKgnzdtMwKXXMjwyRzc0NzcyBDCai8oCgVKAw2Kjq2thYA/B8
 13VoAAAA=
X-Change-ID: 20260828-typo-fix-721b77177721
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787908085; l=1243;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=FpwtHaCi8oZloV5nvw3psfVtMotenDREYCfLN6pcxlI=;
 b=/UKOyA1L5atEP87qqU5M0aIOnMlSvMESrd1pg6iDEEmqTfAH1truMGzCwn9Y2tILflmXofvt7
 E2QmQkQ7881AbBeTNeFP+n7OI+Wgxjj+sVs5eini1UycQl+ipYjcUSA
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

The patch fixes two typos in two places.
versoncmp.c:            "fractionnal" -> "fractional"
t/t0022-crlf-rename.sh: "similiarity" -> "similarity"

NFC only updating a comment and a test_description

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 t/t0022-crlf-rename.sh | 2 +-
 versioncmp.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 9bd863a970..328c6e5903 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='ignore CR in CRLF sequence while computing similiarity'
+test_description='ignore CR in CRLF sequence while computing similarity'
 
 . ./test-lib.sh
 
diff --git a/versioncmp.c b/versioncmp.c
index 3a81b17bc1..f1e451755a 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -15,7 +15,7 @@
 
 /*
  * states: S_N: normal, S_I: comparing integral part, S_F: comparing
- * fractionnal parts, S_Z: idem but with leading Zeroes only
+ * fractional parts, S_Z: idem but with leading Zeroes only
  */
 #define  S_N    0x0
 #define  S_I    0x3

---
base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
change-id: 20260828-typo-fix-721b77177721

