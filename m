Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13B36EAA4
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636302; cv=none; b=XW2z/pAN3JB3UiDUnOCKV26cwD+CEAP7cX7iyVQ8GplJcGQXveOIXFIUytS1IeHo+si81+Z9Kqh1LQeIf0ouxYTj13YN1WmL5MYR7vybbuqezI7SkUlgytFLh2CiZlVBev20QyP4vScmdkpjPyLPFNKpgzN0MSmwuXuYNZtyKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636302; c=relaxed/simple;
	bh=psbWUjc7dvt8PaR37UbkrU0h5n++ImrTrtRp6eOB3XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eGmw860zJ8tcZUb9imBgBf8xy0nXpLKMu2k23i0u/dNY7Oc82nrgyfqvCdbKu+2L1XkkY+iy+4NrjP2zJuXnWk8kLL8ClNnJTL+inR/1xWl26a5GdMpGCPkMYLhsYVPdHBimthBCf+MiqNm0ZoOCPsfd7M5+DeZY1GSDIIlgDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkIwiu2o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkIwiu2o"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801bc32725so21712825e9.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770636301; x=1771241101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnGO+bzeUs2ZKiAxIjw8TfkleCg5DiDYVaAhBIAO4rg=;
        b=hkIwiu2oIGkioUgYF7BdyHXBpEruNpBT7t8CRat/f+B3U4uEbNVhXKAo/BxawUY3sx
         6bG0VY4c4FKK+O5Ow1qNmoPouQddFbs/zF+owAVY7gWvsefQhJvj9r7h6hZkk5M37TYJ
         0KUIqeWayGemwxY5FJbmEKLCZnjghK9OLamnTi4dG+BApwTxzVY5BimV6f0ip933h5QD
         bEQUNIHPnCq6rD098Uu8SENQtdwhIJAMPHhW+HSuzj1qiuMyIq7dVTBXmZ56/E+uXH6v
         iZ/TmLhtcFHb8/Jvoat+9bIm9melfEWaoQqBZL423JnZFz7V1JqB8duiteDQMbEMimfc
         nblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770636301; x=1771241101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnGO+bzeUs2ZKiAxIjw8TfkleCg5DiDYVaAhBIAO4rg=;
        b=AazWGs7wiWzWFxOPeUsPp7MhRSMru5Yk7n1usE2r/b8AezvXsMHeSqkICKySULF6dx
         8ir+iALPHswYZbdj2NRjyG3uWE3BlQYKEJ+QTeov9K2FETug0rwobQ7HuhXwcLEiAoQd
         9EbHOfDg06UtX/fGTuIUDC/Q+565tBtge3PVP2gZIFHpFjWpitQzssfB52TKpxPJYTZJ
         R/f4QhAtRKfyZh5W+wFE/ZfVbH621c+0302Qbt0RBfCU+jYlmhOxaKEVp+Q3+q/jAKDR
         Wa+bcA85+w7kVm6xBPKw5w4SbcSQsLVovPSeAzhDdqT5GJ+x7/nr1fSEB9IodiMifKbR
         OyLg==
X-Gm-Message-State: AOJu0YzZ1t6wStJaCTcWo34cF/B6c0eAMU6AX+JrvmxdUALLjDZPfADm
	UbQlG/rXEuX/n5Sk49qazyHlHyEoB7WpFsaIYB0gzS9/IZ7vA1TTiBykVjX5bg==
X-Gm-Gg: AZuq6aLsCQN8nzJ623FcrlTuF2KDdxOexcZwBMZQJX6ro79kAc4ik05uX4ysd2iNh91
	2bbhwQqZHBhioAO9oDraD441jTI8aopyudRfCYYG686PU9r+VR87j29crcHWLRqeJ76234Kuk9v
	38MSugO5fstYjk/2/1Y5AtDZd0fhudxqMB4E/rpl2/GZcvyU7aKION2x85i9cYIwfoCUkB26K3J
	aBi5eSTOMq4Iw8tTunD5yA62u+j5l4k4DyRdjA+7p8TGb0JBoJ+JpuA5LBgBDBi8q+dFgXXr1BU
	MYSQBDgDwHVZORyDKlTmhPaP11nkryRPDHRxd086IlOu4fpsE1bWcmzPCglxWMrlXVOb6NrObXw
	1IneSAT+SpM/JtDLMsodPyJuE9z5sywhsfqMPerh+b9hsO+IJg2KxSggd2FfmcNHJ0TsMSibnR1
	fevmsl
X-Received: by 2002:a05:600c:4e8c:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-48320212d56mr174418955e9.24.1770636300300;
        Mon, 09 Feb 2026 03:25:00 -0800 (PST)
Received: from fedora ([159.146.42.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm238416045e9.1.2026.02.09.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 03:24:59 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH v2] t2003: modernize path existence checks using test helpers
Date: Mon,  9 Feb 2026 14:24:44 +0300
Message-ID: <20260209112444.1268765-1-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The old style 'test -f' and 'test -d' checks are silent on failure,
which makes debugging difficult.

Replace them with the 'test_path_is_*' helpers which provide verbose
error messages when a test fails.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
Thank you for the review.

Changes since v1:

- Fixed subject line.
- Split the command chain.

 t/t2003-checkout-cache-mkdir.sh | 50 ++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index ff163cf675..19166adf0f 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -24,27 +24,28 @@ test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
 	mkdir path2 &&
 	ln -s path2 path1 &&
 	git checkout-index -f -a &&
-	test ! -h path1 && test -d path1 &&
-	test -f path1/file1 && test ! -f path2/file1
+	test_path_is_dir_not_symlink path1 &&
+	test_path_is_file path1/file1 &&
+	test_path_is_missing path2/file1
 '
 
 test_expect_success 'use --prefix=path2/' '
 	rm -fr path0 path1 path2 &&
 	mkdir path2 &&
 	git checkout-index --prefix=path2/ -f -a &&
-	test -f path2/path0 &&
-	test -f path2/path1/file1 &&
-	test ! -f path0 &&
-	test ! -f path1/file1
+	test_path_is_file path2/path0 &&
+	test_path_is_file path2/path1/file1 &&
+	test_path_is_missing path0 &&
+	test_path_is_missing path1/file1
 '
 
 test_expect_success 'use --prefix=tmp-' '
 	rm -fr path0 path1 path2 tmp* &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test -f tmp-path1/file1 &&
-	test ! -f path0 &&
-	test ! -f path1/file1
+	test_path_is_file tmp-path0 &&
+	test_path_is_file tmp-path1/file1 &&
+	test_path_is_missing path0 &&
+	test_path_is_missing path1/file1
 '
 
 test_expect_success 'use --prefix=tmp- but with a conflicting file and dir' '
@@ -52,10 +53,10 @@ test_expect_success 'use --prefix=tmp- but with a conflicting file and dir' '
 	echo nitfol >tmp-path1 &&
 	mkdir tmp-path0 &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test -f tmp-path1/file1 &&
-	test ! -f path0 &&
-	test ! -f path1/file1
+	test_path_is_file tmp-path0 &&
+	test_path_is_file tmp-path1/file1 &&
+	test_path_is_missing path0 &&
+	test_path_is_missing path1/file1
 '
 
 test_expect_success SYMLINKS 'use --prefix=tmp/orary/ where tmp is a symlink' '
@@ -63,10 +64,10 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary/ where tmp is a symlink' '
 	mkdir tmp1 tmp1/orary &&
 	ln -s tmp1 tmp &&
 	git checkout-index --prefix=tmp/orary/ -f -a &&
-	test -d tmp1/orary &&
-	test -f tmp1/orary/path0 &&
-	test -f tmp1/orary/path1/file1 &&
-	test -h tmp
+	test_path_is_dir tmp1/orary &&
+	test_path_is_file tmp1/orary/path0 &&
+	test_path_is_file tmp1/orary/path1/file1 &&
+	test_path_is_symlink tmp
 '
 
 test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
@@ -74,9 +75,9 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
 	mkdir tmp1 &&
 	ln -s tmp1 tmp &&
 	git checkout-index --prefix=tmp/orary- -f -a &&
-	test -f tmp1/orary-path0 &&
-	test -f tmp1/orary-path1/file1 &&
-	test -h tmp
+	test_path_is_file tmp1/orary-path0 &&
+	test_path_is_file tmp1/orary-path1/file1 &&
+	test_path_is_symlink tmp
 '
 
 test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
@@ -84,10 +85,9 @@ test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
 	mkdir tmp1 &&
 	ln -s tmp1 tmp-path1 &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test ! -h tmp-path1 &&
-	test -d tmp-path1 &&
-	test -f tmp-path1/file1
+	test_path_is_file tmp-path0 &&
+	test_path_is_dir_not_symlink tmp-path1 &&
+	test_path_is_file tmp-path1/file1
 '
 
 test_expect_success 'apply filter from working tree .gitattributes with --prefix' '
-- 
2.52.0

