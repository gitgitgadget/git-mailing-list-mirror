Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27010298253
	for <git@vger.kernel.org>; Fri, 23 May 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020934; cv=none; b=S5Qx+JTwEtmNrYvirN+HqTfPp3gMZ8WKjVDN9vl0S3Xu8QpFvZwkntZmcS9lryfXXVqPKwtJUQxAqIqIfubm4i8hiOwvT9xYa3Pbk/DPQaSqrGEPdaFkvMHr7Ho8bD8bHZ+8qV08C85Qp5aDVrHVBldrPbE+T8p9pvVLehmf7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020934; c=relaxed/simple;
	bh=CXkfgIHmUe49JwpZrteoU5tkp5u/V3m2nIuAFLmwhDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE3a6uwI5ymZ5qZDQCUZcmBDx7lS4lgJ7sdyJEm32XN8zKRS/gFku0PXXgxv5NpH8CDn4hnqsEX7SxPiMXjgt5p+p2Id4M4gg9oJq/wtz2egD7zGaByIJaJsOlFk93+pihmjfeFoFXwOtt3Lvh0NOLUuVyPcCqwUiONAFlQ2z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lK4XiDsK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lK4XiDsK"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-731e277a6b0so69709a34.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748020928; x=1748625728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8S0N2DtxhIpiQtf6Th97SxAoapYsrIMt2RQke2/VY4=;
        b=lK4XiDsKwupguBVI+tDTfhSiOYWX5Uk+enRvcYoqkppNGLyGthA8RJAxQsTisLIeRP
         Vft5WNy0lZAPN7t1Yj4fhFM7+nYPHYijiH6E7JR6h5HRwViV6BRZrp8tcvDAP1rHWN8q
         +lGj/ul3tMD64xamHRRawvzKY1JzNP/BZnhXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020928; x=1748625728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8S0N2DtxhIpiQtf6Th97SxAoapYsrIMt2RQke2/VY4=;
        b=P1KeiiFjK0DqyQ2NuvHnbU29gnCv8FS9iirDX58bSmXPRDGcUrs6AvWu4Su3E9aCur
         YGuDjCcR4Z7riYE3ASDcxcmc95j/1js6hI51J8pV0caVShzulA2KkokRt85l00vb4Gfp
         yXGE5IDRdiHyF/DJpTkIlsqSJeNFKRt1YA8S29CpnjbwGkl3FAYOuX9glm0fOFYf9fuL
         EFZm6XgfKLFoSvjU+OztbpobnRSk74oMeDnaU+5+gleOvvrETsCmxS/xnnDIA3LY8rh0
         7fpojBxZdj2U21QX6jfOD6u6FnQwE1sm/6mT4xoLO1mvIutwZlSWX1/QE3m1jRV5LW6W
         HsIQ==
X-Gm-Message-State: AOJu0Yxzw4gIlUcCDZoHHXyrOvGf3YNcUWnIqynU5K2UNTxBrf+UALrE
	xyYpIhc2Gn9cnTMNM8U/lreC64o4KckJFFuoExPjUNSHwxZrpzw0hIySwPpaGYuiNAMPLZkmwxH
	O9fTngQ==
X-Gm-Gg: ASbGncsgPEprLe9gczX2Y412aHBpZox6qrIlGrZqXUviaN/EIuUDXQxpgbgzMVBhEhE
	d9JqhUsWO7PQwDZtlVakdimFlIOng6MxRpwjd+G/RINVSb7SHRFnU0ZngMBToOZmFdHPcZYvZeA
	jzdXOAD4QZadedPH1dZ3c5/Ypdk5EQ/SRwJFdl0q+hVVOA4V3VnRf56kHr9KrGOsKJghlQB0D09
	rfnyEMi7OK+LldUlGBYhwDzMaFAGtglrFNXUWELYpWlnRchvCMFA2Z7Xnee4vQB7BdE29ZSA8k+
	RDWlkJoSzl9wUWPyOnB+ytokW+ouZFOi2t7+CpdYH0dmoPlYW1vGiPbvsWGB8NVO79AxcUU=
X-Google-Smtp-Source: AGHT+IFy9myNfJLcniYFJBP9dmJ2ZHU5hvGYmWnzq9Ol3X9007bDB1ZvJIDpMHFUOafe4PJ/b2axnQ==
X-Received: by 2002:a05:622a:114f:b0:494:993d:ec30 with SMTP id d75a77b69052e-49f465595d0mr297521cf.16.1748020917004;
        Fri, 23 May 2025 10:21:57 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae3cd517sm116219891cf.10.2025.05.23.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:21:56 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 1/2] t4129: test that git apply warns for unexpected mode changes
Date: Fri, 23 May 2025 13:21:53 -0400
Message-ID: <20250523172154.93810-2-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523172154.93810-1-mark@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org>
 <20250523172154.93810-1-mark@chromium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no test covering what commit 01aff0a (apply: correctly reverse
patch's pre- and post-image mode bits, 2023-12-26) addressed. Prior to
that commit, git apply was erroneously unaware of a file's expected mode
while reverse-patching a file whose mode was not changing.

Add the missing test coverage to assure that git apply is aware of the
expected mode of a file being patched when the patch does not indicate
that the file's mode is changing. This is achieved by arranging a file
mode so that it doesn't agree with patch being applied, and checking git
apply's output for the warning it's supposed to raise in this situation.
Test in both reverse and normal (forward) directions.

Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 t/t4129-apply-samemode.sh | 61 +++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 2149ad5da44c..082e56db651e 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -102,15 +102,23 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_file_mode_staged () {
+	git ls-files --stage -- "$2" >ls-files-output &&
+	test_grep "^10$1 " ls-files-output
+}
+
+test_file_mode_HEAD () {
+	git ls-tree HEAD -- "$2" >ls-tree-output &&
+	test_grep "^10$1 " ls-tree-output
+}
+
 test_expect_success 'git apply respects core.fileMode' '
 	test_config core.fileMode false &&
 	echo true >script.sh &&
 	git add --chmod=+x script.sh &&
-	git ls-files -s script.sh >ls-files-output &&
-	test_grep "^100755" ls-files-output &&
+	test_file_mode_staged 0755 script.sh &&
 	test_tick && git commit -m "Add script" &&
-	git ls-tree -r HEAD script.sh >ls-tree-output &&
-	test_grep "^100755" ls-tree-output &&
+	test_file_mode_HEAD 0755 script.sh &&
 
 	echo true >>script.sh &&
 	test_tick && git commit -m "Modify script" script.sh &&
@@ -126,7 +134,50 @@ test_expect_success 'git apply respects core.fileMode' '
 	test_grep ! "has type 100644, expected 100755" err &&
 
 	git apply --cached patch 2>err &&
-	test_grep ! "has type 100644, expected 100755" err
+	test_grep ! "has type 100644, expected 100755" err &&
+	git reset --hard
+'
+
+test_expect_success 'setup: git apply [--reverse] warns about incorrect file modes' '
+	test_config core.fileMode false &&
+
+	touch mode_test &&
+	git add --chmod=-x mode_test &&
+	test_file_mode_staged 0644 mode_test &&
+	test_tick && git commit -m "add mode_test" &&
+	test_file_mode_HEAD 0644 mode_test &&
+
+	echo content >>mode_test &&
+	test_tick && git commit -m "append to mode_test" mode_test &&
+	test_file_mode_HEAD 0644 mode_test &&
+
+	git format-patch -1 --stdout >patch &&
+	test_grep "^index .* 100644$" patch &&
+
+	git add --chmod=+x mode_test &&
+	test_file_mode_staged 0755 mode_test &&
+	test_tick && git commit -m "make mode_test executable" &&
+	test_file_mode_HEAD 0755 mode_test
+'
+
+test_expect_success 'git apply --reverse warns about incorrect file modes' '
+	test_config core.fileMode false &&
+
+	git apply --index --reverse patch 2>err &&
+	test_grep "has type 100755, expected 100644" err &&
+	test_file_mode_staged 0755 mode_test &&
+	test_tick && git commit -m "undo append" &&
+	test_file_mode_HEAD 0755 mode_test
+'
+
+test_expect_success 'git apply warns about incorrect file modes' '
+	test_config core.fileMode false &&
+
+	git apply --index patch 2>err &&
+	test_grep "has type 100755, expected 100644" err &&
+	test_file_mode_staged 0755 mode_test &&
+	test_tick && git commit -m "redo append" &&
+	test_file_mode_HEAD 0755 mode_test
 '
 
 test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
-- 
2.49.0

