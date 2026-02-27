Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4A347FEC
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211119; cv=none; b=KjQnrqSXM4FNmnLn5VryOXnCOdxTFRLBhN8WA99p7TIn+y1ZQ6lKusEhMTrBDbseastHPYYlo15u2BBFjauFBEKhxMCGNI44zWkeQV+YYi3ZmJ0uKl9xSz7Z8ubCZChk6ZFnJdca73VapHGfWDlpP19KIdE9wRWks4lQZdsHZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211119; c=relaxed/simple;
	bh=ee33yzLggVAYWVsGlrtDBpkwgkDx0oyB2SbEzWy6KrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5J9O/548PFXYjmzQnmO0xa/kd28OYo7uRwMTa07XQ6iiEBtQoZXMsz4+BkqNYDaKkkcFl3fFqtXqxNPJ4FlScA2Vs5lfxcLrZwhXW0PYX/WQk0mZpDjcPn0SwVKeBOqw5pqq/7gfLlXSEotcgZx3nanh1S6KlrpZP1aikGc3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD4C5oqz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD4C5oqz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3590d548576so1286328a91.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772211118; x=1772815918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ulHP/nPRTjuiPQR0Pszo25I2VbKlPvtUpc9XwQRr/s=;
        b=lD4C5oqzPGjMoNGybojVrRVg1I6RxpOHj86ZtcspdqD3dyjVuk6SeDlioXvIDnpJ+K
         kI5BI1i5DvnqSV2MTiOtyRoGG37S944tOhquJiofZWmSi3fGAEXl2myc7ZMIaZaLNRdK
         ggFc6ujOxS63lShLqM9IVu1/LryO/prg1vUaS55CU9ZdMNLNTpIcDitXzxr3Svf6urC5
         1lQ76zGxCU1pGS5VIufYHobTA3wJ6oWPYAghQ3xCfMdx5C+sEH/etvJOeuzBV2hQi0W1
         6NRpEoiP5XcNP5pluwS8n+Zxj5bYYUDdpc09rvLKwFrD4cn34JvIWT73EH0T6WeFYlyC
         QcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211118; x=1772815918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ulHP/nPRTjuiPQR0Pszo25I2VbKlPvtUpc9XwQRr/s=;
        b=cByx1xmdxOn/1ozfLhmZBV4RLtAeofyY2IEvGzjJ/4niJ1N2UvLtnv/fnzf3C1bF/6
         o8XeGqNakxHpnmxfZMAVQj+b2fxgSippXS5zmd/pP0rnQJ/+ey1S7iE+JBu6pSk3blsh
         HhlUE8yPy8FYAAgfECTUBWOKhXUPTWtelPQeWmE/gG6SNwElm6MP5wAWf0AQEu+793JZ
         BSkHZygyYxZyjXiRUNI7Axw2OGcAcBTU/TdIn50xbGnLlIGRgH+uRuii5XC3kG0IOMqa
         e6SfwRkkdzWB96AO1RnRgIaVOZ0A7KWsS/BU37LwWECmdRUgI+PvZlHxR1aqrRAvgbO0
         5lDA==
X-Gm-Message-State: AOJu0Yzoz25s2R6upkavBAyP/y2AKIZhv5ILedCAwl0/ftJ7k48PCKIp
	b7ANX1200bSyzo4uexMR9BMoagRGkqpdtEIKuXMF6xaU0SBAZESmonjOxy45bOArof7R3A==
X-Gm-Gg: ATEYQzwddO9qFOZ+68AwwSbu7W/997YUKsENaNBjCdbYXK9nWy//M731Ek9T3WnHrz9
	4Lt302iHg/x5rhuYSlQjQuP1pLgMrolHyAhWaODsCktru3nKhDhwxaoPUtUP2b8ytBFHm/1umAn
	rv+ZPIxiFgfMSro92AuyY6Wh4uoEhMyc/TYMDc+KTL6sYjmre5MK4E0j9aX8CoCpitB3aZqJ+2z
	6eRPwrTsZ+nMnkPxO0Usf7QF1IBc6jbY/3KaQtffmFSRcEa7liVmffsEGHo2lW7pKhuJMUNKFuZ
	6fzG0cfkd4qUhn2sYI5PbovhETlipE53CLeZ32Yss5fM2EeScjA+p2NR9LN5HcgWW+pY1Y6mKzo
	najXO+eGhnfcpL//R2rVPSqzqxE7Kr2ZkFvt3uMRZGYDwvmH5UohjEa7IiLqpszBFTuAWMc1Ej4
	ZGHzBncicRiD51a7zRqBCPvQ/FH/bK8ozu68vjax/pu2/1PO3rbVPihg23NZG7XJael/wBTqDI6
	6Gbnr0ViONgVA==
X-Received: by 2002:a17:90b:38cf:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-35965cd1f69mr3638160a91.23.1772211117556;
        Fri, 27 Feb 2026 08:51:57 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c0c3:c84b:79ce:c00:91f6:37b5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc9c37sm5659688a91.8.2026.02.27.08.51.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Feb 2026 08:51:57 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] t3700: avoid suppressing git's exit code
Date: Fri, 27 Feb 2026 22:21:43 +0530
Message-ID: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When piping the output of git ls-files into grep, the exit code of
git ls-files is suppressed.

Avoid this by redirecting the output of git ls-files to a file and
then running grep on that file. This ensures that any crash in
git ls-files will be caught by the test suite.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t3700-add.sh | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index af93e53c12..66c6114b54 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -38,7 +38,8 @@ test_expect_success 'Test with no pathspecs' '
 '
 
 test_expect_success 'Post-check that foo is in the index' '
-	git ls-files foo | grep foo
+	git ls-files foo >actual &&
+	grep foo <actual
 '
 
 test_expect_success 'Test that "git add -- -q" works' '
@@ -195,8 +196,9 @@ test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries'
 	echo new > file &&
 	echo new > symlink &&
 	git add file symlink &&
-	git ls-files --stage | grep "^100755 .* 0	file$" &&
-	git ls-files --stage | grep "^120000 .* 0	symlink$"
+	git ls-files --stage >actual &&
+	grep "^100755 .* 0	file$" <actual &&
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
@@ -265,7 +269,7 @@ test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --ignore-errors . &&
-	git ls-files foo1 | grep foo1
+	git ls-files foo1 >actual && grep foo1 actual
 '
 
 rm -f foo2
@@ -277,7 +281,7 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
-	git ls-files foo1 | grep foo1
+	git ls-files foo1 >actual && grep foo1 actual
 '
 rm -f foo2
 
@@ -288,7 +292,8 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
-	! ( git ls-files foo1 | grep foo1 )
+	git ls-files foo1 >actual &&
+	! grep foo1 actual
 '
 rm -f foo2
 
@@ -299,7 +304,8 @@ test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides config' '
 	date >foo2 &&
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --no-ignore-errors . &&
-	! ( git ls-files foo1 | grep foo1 ) &&
+	git ls-files foo1 >actual &&
+	! grep foo1 actual &&
 	git config add.ignore-errors 0
 '
 rm -f foo2
@@ -309,7 +315,8 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
 	git ls-files fo\[ou\]bar | grep -F fo\[ou\]bar &&
-	! ( git ls-files foobar | grep foobar )
+	git ls-files foobar >actual &&
+	! grep foobar actual
 '
 
 test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
@@ -326,7 +333,8 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 
 test_expect_success '"add non-existent" should fail' '
 	test_must_fail git add non-existent &&
-	! (git ls-files | grep "non-existent")
+	git ls-files >actual &&
+	! grep "non-existent" actual 
 '
 
 test_expect_success 'git add -A on empty repo does not error out' '
@@ -536,9 +544,9 @@ test_expect_success 'all statuses changed in folder if . is given' '
 		touch x y z sub/a sub/dir/b &&
 		git add -A &&
 		git add --chmod=+x . &&
-		test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
+		test $(git ls-files --stage >actual && grep ^100644 actual | wc -l) -eq 0 &&
 		git add --chmod=-x . &&
-		test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
+		test $(git ls-files --stage >actual && grep ^100755 actual | wc -l) -eq 0
 	)
 '
 
@@ -574,4 +582,4 @@ test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
 	git add "$downcased"
 '
 
-test_done
+test_done
\ No newline at end of file
-- 
2.51.2

