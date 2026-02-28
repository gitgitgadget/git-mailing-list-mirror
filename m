Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44C314B95
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262030; cv=none; b=OOmMfoTuEjVj2cR/u8MvNQ/BZnk5nUD6ClukAA4LZrtDYwirVV3aS/opXAyiasxfy5k5o3+AlVRovZTsRSr5cGyr4b9jVNBV48MOZ9uHBnwxm39Y9jy2YqiURENvaRmXTCXDJIfGGnVkEOCVh9QQAp9GPsTLK9yqgXN5sQSq2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262030; c=relaxed/simple;
	bh=fzYUA9h6kHpJsVvFa7O9QMQGZLEAU4MUFuJNjuZzvEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQEZLfbGbVYSe9EJBM9NA4JmNsqZa9mE5wk2I0/yvtYVg/vilIKiqK7C4wX2jpbNG6+83jrb0M7qNO3XriVwtUiiw1TBMTHBuwlI4RJSQ6C1RoAQr9aMvaAjkCCSpqt1B4Cbbnf20x8L565a7hW8icDe0GdqfHvN2Vj2Jo0fm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/kRu0Lx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/kRu0Lx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaf43014d0so22545465ad.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772262028; x=1772866828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbxbIiO/8vul8pI559ZQB8iauF1rQjV2SqwC8/Aa6xU=;
        b=G/kRu0LxAkJTJgYZJF3tJw9+qp6vukiRC/OZuEy8+OsEkbOgiqbuYldsUnTttZxbKn
         iY9gVihqyovbq7kvSbRKViQCWDHICoPluBx0e/8m0ILsD+v/NXrZOGSdIrE82u8YPUa8
         TJoSApNbrrVE098aRKV6xk9Zeah02zAJx++mtSqNX0ANwQfNqqZQpJsBnUljpilWYn6B
         bvffiFGM9WJLk8BYCAWXrQ/wxS4LOBK3P5L29llUSvva3B+omUdbhhesHFpzcahljp0x
         NxPf6OWU1qnXGZ6EpucoCq8o9s3T3DMxthnrH1D6Gp/CTfBNfd3lcciHLBpgx3QYTeFI
         DvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262028; x=1772866828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbxbIiO/8vul8pI559ZQB8iauF1rQjV2SqwC8/Aa6xU=;
        b=XzSN4HN6I9eEG2QsNnBysYdenIDzClJxYWF2gxRvm6qg8cgm+OxzDyn623eXfDiBuw
         zohQfc/xhmb7rPhOyQ7tmT/Rvgc6nFNbgrEjcuQ8fCwt2T7DSHvaXeBaXnVvtHsUom2B
         N1sfqXSCDyL4bULxPFUlXGvsRm2mmDJLProfIQDI0y+QEY3ofYPJwuUWBu0RP+DpZuNm
         uw/NO1fWQv/5n8m/jSYrUpYlIe6xnta9y6FNqiegA9puk0VZHQasPWZbkePsWOtYUXUs
         +9trtfCWz7oBSkoFNHMNf391sw63str15FpxDtwgAEE9THFuc6jhHMK+tX9yG6KuF+Vk
         XQqw==
X-Gm-Message-State: AOJu0YyABzSqbI+VfkNdUN58NxDXojwe6jYkRtP1UMdIQxD1uoDBVnUt
	YOwttvi6Oti5/iouVHTmiWxLcfVXredNQcBsgN2im5TgjG07Ci5/eK3AJxlpSWueKE+qQg==
X-Gm-Gg: ATEYQzw5tJmJXE5LSQDu70k3U4SjhE1xUcgVXn/rsmVWCfhwW+EEmyYqUC4T73cDyDi
	GBBWNa9Wgt3Z9UQWKFR+17WEei4exjqBBdVDQfpVjN61ZH188yBgxpG1bRWaP/bKinSznxTcUAr
	aPPTzD93ehRsRqrM9DgzrrEFJOEb2MKnMgQNEMSDxNzGpe4oDnILqry7XKeXE+tUFmB80cfirC/
	Wg3QvcbCdS7FBzlJDOZCBco4/3hfdmXoJrMBZUigVa+W/ttonXEVjWb01l9NeJ0KwCrrMpScw4n
	0l97HZHh+ZsD7Ew2/v2hIKK614pVh4OnRCPd5ypRr+ypuX4Fq5+pDJRGsj0pzaHyyzfzuqtJB84
	ze8XSOZ+Z3tT3+RItUvGjqCKLFZq0NF25/oUKOW+/cADibDZIDyBCPu4hwp/M/AnK6rCYtVL+6Q
	wxeEgM3RsqHRGNBU3bOoU0Bb5VyiqvJKeA55FY6UQ1gcDgxssHgO83QUxm3B1EPQawan/Dj6w75
	VG7
X-Received: by 2002:a17:902:da8f:b0:2ad:a9a9:4bde with SMTP id d9443c01a7336-2ae2e4b55f6mr54256495ad.40.1772262028232;
        Fri, 27 Feb 2026 23:00:28 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:ad51:cd15:ad04:c285:fe0c:c693])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b5813sm77151355ad.63.2026.02.27.23.00.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Feb 2026 23:00:27 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] t3700: avoid hidden failures and use test_grep helper
Date: Sat, 28 Feb 2026 12:30:20 +0530
Message-ID: <20260228070020.89668-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
References: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pipelines involving git commands with temporary files to ensure
that any crashes or unexpected exit codes from the git commands are
properly caught by the test suite. A simple pipeline like
'git foo | grep bar' ignores the exit code of 'git', which can
hide regressions.

Additionally, replace standard 'grep' with the 'test_grep' helper.
This improves debuggability by automatically dumping the contents of
the 'actual' file when a match is not found. In cases where we were
counting lines with 'wc -l' to ensure a pattern was absent,
simplify to 'test_grep !'.

Suggested-by: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Inter-patch notes (v1 -> v2):
 - Replaced standard 'grep' with 'test_grep' for better diagnostics.
 - Used 'test_grep !' for negative assertions as per project style.
 - Simplified 'wc -l' logic to 'test_grep !' to avoid subshells.
 - Removed unnecessary '<' redirection from function calls.

 t/t3700-add.sh | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 66c6114b54..d61bf784d2 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -39,7 +39,7 @@ test_expect_success 'Test with no pathspecs' '
 
 test_expect_success 'Post-check that foo is in the index' '
 	git ls-files foo >actual &&
-	grep foo <actual
+	test_grep foo actual
 '
 
 test_expect_success 'Test that "git add -- -q" works' '
@@ -197,8 +197,8 @@ test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries'
 	echo new > symlink &&
 	git add file symlink &&
 	git ls-files --stage >actual &&
-	grep "^100755 .* 0	file$" <actual &&
-	grep "^120000 .* 0	symlink$" actual
+	test_grep "^100755 .* 0	file$" actual &&
+	test_grep "^120000 .* 0	symlink$" actual
 '
 
 test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over stage 1' '
@@ -215,8 +215,8 @@ test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over st
 	echo new > symlink &&
 	git add file symlink &&
 	git ls-files --stage >actual &&
-	grep "^100755 .* 0	file$" actual &&
-	grep "^120000 .* 0	symlink$" actual
+	test_grep "^100755 .* 0	file$" actual &&
+	test_grep "^120000 .* 0	symlink$" actual
 '
 
 test_expect_success 'git add --refresh' '
@@ -258,7 +258,7 @@ test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unr
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
 	git ls-files foo1 >actual &&
-	! grep foo1 actual
+	test_grep ! foo1 actual
 '
 
 rm -f foo2
@@ -293,7 +293,7 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
 	git ls-files foo1 >actual &&
-	! grep foo1 actual
+	test_grep ! foo1 actual
 '
 rm -f foo2
 
@@ -305,7 +305,7 @@ test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides config' '
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --no-ignore-errors . &&
 	git ls-files foo1 >actual &&
-	! grep foo1 actual &&
+	test_grep ! foo1 actual &&
 	git config add.ignore-errors 0
 '
 rm -f foo2
@@ -316,7 +316,7 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	git add '\''fo\[ou\]bar'\'' &&
 	git ls-files fo\[ou\]bar | grep -F fo\[ou\]bar &&
 	git ls-files foobar >actual &&
-	! grep foobar actual
+	test_grep ! foobar actual
 '
 
 test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
@@ -334,7 +334,7 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 test_expect_success '"add non-existent" should fail' '
 	test_must_fail git add non-existent &&
 	git ls-files >actual &&
-	! grep "non-existent" actual 
+	test_grep ! "non-existent" actual 
 '
 
 test_expect_success 'git add -A on empty repo does not error out' '
@@ -544,9 +544,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
 		touch x y z sub/a sub/dir/b &&
 		git add -A &&
 		git add --chmod=+x . &&
-		test $(git ls-files --stage >actual && grep ^100644 actual | wc -l) -eq 0 &&
+		git ls-files --stage >actual &&
+		test_grep ! "^100644" actual &&
 		git add --chmod=-x . &&
-		test $(git ls-files --stage >actual && grep ^100755 actual | wc -l) -eq 0
+		git ls-files --stage >actual &&
+		test_grep ! "^100755" actual
 	)
 '
 
@@ -582,4 +584,4 @@ test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
 	git add "$downcased"
 '
 
-test_done
\ No newline at end of file
+test_done
-- 
2.51.2

