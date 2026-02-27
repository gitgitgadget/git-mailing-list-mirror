Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A43A1A48
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217946; cv=none; b=Qs3E+LjF88WXwoPqk7aE/2ROlIOqUl5Tz4U1Mre1133J1XAD+PO91U3wNPIjO2lYVpcO8vvx9xMSumNQKvqT03Nv7vZFNm84zJIIe3Kf+xF3ihE0/iEo23M/7jN/XXP3NMFQ+bJ9AJx5iEuEPSW48RbFI5AUcfobr5Zr6QR9SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217946; c=relaxed/simple;
	bh=RNft3HPUn27FuK7ViZ/IOvajOziWQoWaZMpoMTuHTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G360Ov6SGq7/R0rfy/YAtJtid41wOz/N8GruYr8007tYlLjjZEAUYx+DJ3w/ZVbn5nIZZSw+c0Lvvdu/o/V12swSc8aIjj4P1ik8NtdbLdEPOSzH+ujVwsZoqHeg4iGH+gI3Jqhl6D4fTtGDOwquEE+qQ1n9p3FE59g0/gbSVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz43x3nR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz43x3nR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso20676155e9.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217942; x=1772822742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9x1sfRFJQEuKCvge1H/kIp/dBKgiT58RwX2rGgYNWlA=;
        b=iz43x3nRDbI5h3DE+/+BbxE7ag1DxU2IFa7J7ZJxQqoPO7YfrPfb1nhsOHDSfTPvxb
         l/CHRElxTwkk5bGNwx361s736c8Z4qGnJaY2fqVfFIb1JhQLzHRZgD/LSLHic9HzuR3k
         tRmBEZGwsa9ZItKe1wAMeeKPYOgO1G/qKiD3m34CWfu0bSXf8SCTENZfLpPE8JnCCYXa
         /vxZMIF+GdubZ++vOfKQ4WhhGjUzuS1uI5uJSYpkMasOgAR1wWUHazwtvNfLCA3fuLCn
         MDUn3ZcoaGFv7QIau95wKYeqbfmImdAubiHlkLMGrRB+cTUY2scvmBuDwhiBUwwNZo/m
         umHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217942; x=1772822742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x1sfRFJQEuKCvge1H/kIp/dBKgiT58RwX2rGgYNWlA=;
        b=Sq+UUzggAXthkSpY1ZKvK/paRZo6a++cVAW+BfT/auuRmax76hE6kxcPkKZaYAT4LU
         y+z6v4GkMWxUIhHyKhcwFnMXPIWbGJ4fP5htgKFgciKrvbunDt7vf9ZaddEKEymXbSz4
         +m4VQ0qYMGKFq7NX2xUrZ2/SIlpkQqKHasvzundFwy9weVAb5e2lwJQXT5qyFXzlQ/qI
         RcpTWwk5WKjTbdgCqdlbyGRQkJkLcp4mx52WhJRUTB/sxxFQRZB5+uvalHit7M89xsGf
         PK9HXR/SKVjMR9wKTXMbzOQl7r0rUnfJSALZVpPmUbw3FhH/awF9br8zwYxX9O6BQD5D
         5zFQ==
X-Gm-Message-State: AOJu0YyXRfaszAQGnX39fe05zBLijipfOV+u1gQllwg9P+1RwIZYgWtG
	4bmvhk1noan+8+QwbpQ5jiil/sxTkbIkMcJh6JVPHKOPGWIgttQasuC4t+B8Ihc=
X-Gm-Gg: ATEYQzwL+53JEv0cxTOS7f/BIHau48zwx5/Jr/EQ2lsNphXswPpaB0whN5Z8SB7ZDuR
	zbzs51ciEa6cR3+VDSDUdxgHJZo0PmWRx4NK7Yfw3+inBlDK1dVKQfbXIi13taX205Wsl36tsRj
	TlPHI1tsu8I9bQmAUYVlFIW/LguMlggpLCV+aAGYx88F67DN5AriUVJP+IhiG0e5qu/JhOmb4y7
	KpboaCOUOstrFja2+LugJCYmk5sFry9GfVNyLjes7x3qKUa75WII6L/kKYmouWDoxty7wBobgOX
	ETJBcwZxQQyFY3AX0mP5yC3uHdsplTZuS7boRt6SyeuFv2Mwmje2UnhtllsPGi98NedSFnfTXro
	43nDZiicSGhtDn4Te/HLiuNdQYzJ8sCgxCTKNbkdYyhOn/lg1/UmPG89c3llWs4jKlY/fn3zd+p
	fAnS/C9kc956ky+Z4mglZV0fEzpXxESGIxex33iHJwPHPNm52JnFk8aXdY/grpgdZF6g9rShauL
	9na1MFCzAciQpApoPvFn6gSSrAaaSHN/QBS
X-Received: by 2002:a05:600c:1c28:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-483c9bc5643mr68246505e9.3.1772217942243;
        Fri, 27 Feb 2026 10:45:42 -0800 (PST)
Received: from Mac.lan (93-35-141-155.ip55.fastwebnet.it. [93.35.141.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm8587301f8f.3.2026.02.27.10.45.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Feb 2026 10:45:41 -0800 (PST)
From: Francesco Paparatto <francescopaparatto@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	Francesco Paparatto <francescopaparatto@gmail.com>
Subject: [GSoC PATCH] t3310: replace test -f/-d with test_path_is_file/test_path_is_dir
Date: Fri, 27 Feb 2026 19:45:38 +0100
Message-ID: <20260227184538.4718-1-francescopaparatto@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style path assertions with modern helpers that provide
clearer diagnostic messages on failure. That's because when test -f fails, the
output gives no indication of what went wrong.

These instances were found using: git grep "test -[efd]" t/ as suggested in the microproject ideas.

Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 597df5ebc0..f0054b0a39 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -260,7 +260,7 @@ test_expect_success 'change notes in z' '
 '
 
 test_expect_success 'cannot do merge w/conflicts when previous merge is unfinished' '
-	test -d .git/NOTES_MERGE_WORKTREE &&
+	test_path_is_dir .git/NOTES_MERGE_WORKTREE &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should indicate what is wrong
 	test_grep -q "\\.git/NOTES_MERGE_\\* exists" output
@@ -320,7 +320,7 @@ w notes on 1st commit
 EOF
 
 test_expect_success 'can do merge without conflicts even if previous merge is unfinished (x => w)' '
-	test -d .git/NOTES_MERGE_WORKTREE &&
+	test_path_is_dir .git/NOTES_MERGE_WORKTREE &&
 	git notes merge x &&
 	verify_notes w &&
 	# Verify that other notes refs has not changed (x and y)
@@ -564,10 +564,10 @@ EOF
 	# NOTES_MERGE_* refs and .git/NOTES_MERGE_* state files must remain
 	git rev-parse --verify NOTES_MERGE_PARTIAL &&
 	git rev-parse --verify NOTES_MERGE_REF &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
-	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
+	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
 	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
 	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
-- 
2.52.0

