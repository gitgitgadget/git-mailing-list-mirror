Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61911386C14
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570583; cv=none; b=IVoRuFyP1IsJPPAugaGFaKSZ4xceN1Vtr7al/LR2XBi5JrJWaum0vBBCBwfgwcmQd8SECTF7m1RcI1ijyjo5Qbbj02BkhLYFtgqFomc3Jp8k6Ia33WfMzp2AaZlLa5RsIdRCdgKos4277FSb+8D9p367Kl9/n2zwn6T2W8EBLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570583; c=relaxed/simple;
	bh=8KKOqhrPzBxzSFn/fCar+9e/qq6ea4lUK4oWd5YeDak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqJ7X4NyiwuZi8OnNtD3hSeU0xNF0UEenMICmHEI5eSmgqFBJWWGAfs4v02hezMzaAr5L5QO0MyjNQFaAxPXdowm0dDsoMd6ZaC484qM1AZvqa7KqEbc3Sni9uNqxVmSKFoNuDizRRtL3RDVPtSFdFnCEKqiANhRmHK/GcFCMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwndLNFz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwndLNFz"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824af5e5c81so6340008b3a.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 12:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570580; x=1773175380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6/xKzdbKgFs/K+ZgNxkkOfjFWhWdJ5S7Wisj0E7d6M=;
        b=iwndLNFzlzZOF9a2JWg9tq7Gwc9kpd2vF7ZrTFKmHeuUkZg982/rd23QrTRhzPj8Zi
         aifQrAI+wy+iNv7CAkch9GPfpX4cP7+43XlxNDZ5Jf3m8ibxT0YHE+xmcSOD6x4Bkoum
         e8IJeDtCrkNqOKaz3kcfCKTUyr7GRtidpZpYq2tMHDl0TTQjCmnXLLjznhDVNZln0ToU
         uqjnKtg1sGcbyMJmffgjp1gGVEJnHc2kCzxkezUxV3ZQhPMiPIt9orcplPoJeIfDHpFp
         pLO4icNRR8i+0/34W4g3sj4P4BcIzpIylEK79wjUf6WqHbrf6QWMIfPuCYayUkhPkcJJ
         dJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570580; x=1773175380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6/xKzdbKgFs/K+ZgNxkkOfjFWhWdJ5S7Wisj0E7d6M=;
        b=LvDfA80cmsiUiwuxamKdSIE0VRt7Pb3xnARPYo5iB1TcAe9AuiUZ8IXVsdIxcJVfLL
         MegWYo4Pim/3gcjC7v459jy0JQM/g15RCDyGLAQ9vT3RSninnq6tx1O9vfSBhwk93DBq
         R7CNkNp391gHvnubsDMP6Ne1+fns5UT128vuIBHYmhSDozUM+lzgAfgYqL6VUUGsafwT
         ozwUiSxmGnY6lCWXHt1Nrnf7++a9CsYYrFi62p8bhrsmd9Oy+OaNrnK9liUNmBsxHGx/
         kZW4c7Csf5XnA35ozKgzi5eCB54Uq80ZJFQ9amAq3jnYC9qSLPRidz4uWZpb1SWtgpKb
         l8Qg==
X-Gm-Message-State: AOJu0YyoHrHU1X9rrZOWL3f66eu2/PsqMCfHCb2eTYUs2NGZKysyMiq5
	scgbTHXhBnk/s9kVSGNIxCyxCI/WfpZJUuMDJYLMw98P1XvHQ0W1iCfQHxI1AtmztMY=
X-Gm-Gg: ATEYQzynbNLu2VXeul+wR8A6KzxAlAJObAVlO+rM/KRhvOyMYdNrWICroQ3hw55fpi2
	uoAAlfz2ReHLhJTMKfo29OZiFT2JWqgVaqDCT2dsnmWSU0pddVcI3bXHw68PY2OG81nLwe3eBDy
	kgmpo0f41ag0wzB44T5GrR1eV+kiEQJSCRObI4SBCfy1L3pg7Tt3V5FKVbMj1BHpTPdbSQb533y
	lAhUjJ/cOo0o5LG+YzakSa+ieNa0z643tUBB0fuONHVvBz5TSMi8irgAJ/NFAIMkVHd8bPxaUiV
	Re7Li5+v/HsN3Vc1z1/vgJhDyoOk9nT627MlaZ3BosgLsFTI3XUCzpGMam63y0Jdyx5rhtj89Si
	cbomcSsXIN7sqAl5H8exooDk19jYtf/pEw+MvsKp3LJSXxNse3jr2p4vD70hY6inec3xI0f/xS0
	JKu9DomxuE4Ba0hZOFJi2+YAo90/Oc/Wo9uFSmnnzzkwA5P+Mc2sUoJ8aGHYYNnRtEn5IL0Q==
X-Received: by 2002:a05:6a21:9cca:b0:395:101e:9b40 with SMTP id adf61e73a8af0-395c3a1bc30mr17145537637.1.1772570580196;
        Tue, 03 Mar 2026 12:43:00 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:562e:3a88:890e:9f53:fad:871d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm15348524a12.24.2026.03.03.12.42.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 12:42:59 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v3 1/2] t3700: avoid suppressing git's exit code
Date: Wed,  4 Mar 2026 02:10:28 +0530
Message-ID: <20260303204029.52952-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
References: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pipelines involving git commands with temporary files (actual)
to ensure that any crashes or unexpected exit codes from the git
commands are properly caught by the test suite. A simple pipeline
like 'git foo | grep bar' ignores the exit code of 'git', which
can hide regressions.

In cases where we were counting lines with 'wc -l' to ensure a
pattern was absent, simplify the logic to use '! grep' to avoid
subshells entirely.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t3700-add.sh | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index af93e53c12..c9ce2f758c 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -38,7 +38,8 @@ test_expect_success 'Test with no pathspecs' '
 '
 
 test_expect_success 'Post-check that foo is in the index' '
-	git ls-files foo | grep foo
+	git ls-files foo >actual &&
+	grep foo actual
 '
 
 test_expect_success 'Test that "git add -- -q" works' '
@@ -195,8 +196,9 @@ test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries'
 	echo new > file &&
 	echo new > symlink &&
 	git add file symlink &&
-	git ls-files --stage | grep "^100755 .* 0	file$" &&
-	git ls-files --stage | grep "^120000 .* 0	symlink$"
+	git ls-files --stage >actual &&
+	grep "^100755 .* 0	file$" actual &&
+	grep "^120000 .* 0	symlink$" actual
 '
 
 test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over stage 1' '
@@ -212,8 +214,9 @@ test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over st
 	echo new > file &&
 	echo new > symlink &&
 	git add file symlink &&
-	git ls-files --stage | grep "^100755 .* 0	file$" &&
-	git ls-files --stage | grep "^120000 .* 0	symlink$"
+	git ls-files --stage >actual &&
+	grep "^100755 .* 0	file$" actual &&
+	grep "^120000 .* 0	symlink$" actual
 '
 
 test_expect_success 'git add --refresh' '
@@ -254,7 +257,8 @@ test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unr
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
-	! ( git ls-files foo1 | grep foo1 )
+	git ls-files foo1 >actual &&
+	! grep foo1 actual
 '
 
 rm -f foo2
@@ -265,7 +269,8 @@ test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --ignore-errors . &&
-	git ls-files foo1 | grep foo1
+	git ls-files foo1 >actual &&
+	grep foo1 actual
 '
 
 rm -f foo2
@@ -277,7 +282,8 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
-	git ls-files foo1 | grep foo1
+	git ls-files foo1 >actual &&
+	grep foo1 actual
 '
 rm -f foo2
 
@@ -288,7 +294,8 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
-	! ( git ls-files foo1 | grep foo1 )
+	git ls-files foo1 >actual &&
+	! grep foo1 actual
 '
 rm -f foo2
 
@@ -299,7 +306,8 @@ test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides config' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --no-ignore-errors . &&
-	! ( git ls-files foo1 | grep foo1 ) &&
+	git ls-files foo1 >actual &&
+	! grep foo1 actual &&
 	git config add.ignore-errors 0
 '
 rm -f foo2
@@ -308,8 +316,10 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	git reset --hard &&
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
-	git ls-files fo\[ou\]bar | grep -F fo\[ou\]bar &&
-	! ( git ls-files foobar | grep foobar )
+	git ls-files fo\[ou\]bar >actual &&
+	grep -F fo\[ou\]bar actual &&
+	git ls-files foobar >actual &&
+	! grep foobar actual
 '
 
 test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
@@ -326,7 +336,8 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 
 test_expect_success '"add non-existent" should fail' '
 	test_must_fail git add non-existent &&
-	! (git ls-files | grep "non-existent")
+	git ls-files >actual &&
+	! grep "non-existent" actual
 '
 
 test_expect_success 'git add -A on empty repo does not error out' '
@@ -536,9 +547,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
 		touch x y z sub/a sub/dir/b &&
 		git add -A &&
 		git add --chmod=+x . &&
-		test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
+		git ls-files --stage >actual &&
+		! grep ^100644 actual &&
 		git add --chmod=-x . &&
-		test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
+		git ls-files --stage >actual &&
+		! grep ^100755 actual
 	)
 '
 
-- 
2.51.2

