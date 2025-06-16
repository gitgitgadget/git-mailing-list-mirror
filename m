Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8214A4F9
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750039715; cv=none; b=KG/6dfgdlHOlrO8PKErWclD3QScHVw0PCyZ3ZsC/FO9cqCX1+Sml44uIK9lXLmKxf2iRaepf1QWMqCFgMl4SDgU8jXIBaooTgUepFT9Ljcs9rUcH6pMu3RvE2aveMcLv1fUX3e0ijDQ5ISeypuyMfuYEPsWeU7R24CfnSr02eaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750039715; c=relaxed/simple;
	bh=bsX/O/GParfEHk+9IcJaFnSdZi2/UXHM4xoiD2G8Z9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXxY2JD+Lx9KlC5OSu6w3WxuWN6tKz08Aerih9DWsTUgPvtsmpB6J+KbXqkH8QhXTmkzCTbSzofaZ6Hej4DR7XjeRN108yB7KA0L6A9VCT3RPucCrwA/DzLzx65tzhVix7wIcUi+rozmanj+zO/vKwQLecFcr41KBwq17R8gC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaKOaYvj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaKOaYvj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7482377b086so2257970b3a.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 19:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750039712; x=1750644512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gr/Soy1VKjVdJ8HhcoqvGHnaVJnlK4n6e+mBxCRtZXw=;
        b=HaKOaYvjmBOT+dA8xQrzIKvEpxQCJWQiqP/TXPc8MXYRhP/04aFwLFFH9tSKw1tb0x
         wXh/AzDf1HPrtrpDcRa9ABxd0pex7m3bT8sdnSZ63V8fduLWMMbS4ouNmD9pboFFi/YO
         euTFWDONmBWDc0GihjOk1jjIq02UYdY8it2rHq1NmMoAOSA1f7MzdR9RZmwtiMY6Fsut
         fp8AaXsXy8hX+U3F4OG0SIgvtXd27mWDqQww0A7gQYD6qIHPnzk41lL1bKQNXtekm/Kp
         gBcMsMG8GKSG6GEr5xApKWAm8Yf1PlFyf3pXr+k25Ch07SlUsoq8qGFBWS9wdf1BoAZx
         hMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750039712; x=1750644512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr/Soy1VKjVdJ8HhcoqvGHnaVJnlK4n6e+mBxCRtZXw=;
        b=JAOO/3uyUQQdyHXCzToW+OWNjWp5FuNCEwjW6/5fhd1sSoAAXin6M7/avkk9RcDTkc
         9KMsqL/RUj9TWb6aNgEtPfAB7wfyY2W/1GLfIFbM+KqRlgmRPrpTh1hsJFwC0DhWaXhq
         a9R11CkwbrbokNLKVLGPC1NLfbca2xVYvVUbB1NTDQUA50tpHsbN0oXJpt/fk5I1oWMZ
         p6xLHxa131jnvWgh9GTHVjoKF9HuGHmX3vMFJhIVWTf9v0APg2BtcSX0SEZN8IkoWk2K
         hrAwDT1RtZ8EieCpg7ca3D8R+DIvkCbzeu91BtBAQPR065FdTxEM7qFk/UfbiKjlcc7o
         lzRg==
X-Gm-Message-State: AOJu0YxrxnFjsycztDwNspaShFg2L5yKJOPUtSdwv8bEGvg967p8Btvf
	qEhspOuDPlOJ5I1bnXa+lsmN+YdBYZ05wu6+CCKpWLrA6BbE11H0NSrtzK9s7j+h
X-Gm-Gg: ASbGncu6wV7G5oH2+ZddkKHtOdRE6J/TDAG0b8r0iJfX6Lcq+l7QUFHYoc9oJXXUG0N
	Jio60gQhjOsAQc6wVOX/2BZj8R6Ji0vKyWr0C/xCaFnttMF7zHA+tSiE98t3RaTqQnLxjaFWEFS
	D0sEUTNm1lJXCVBEk/1Gj8tbR91BV6XwZuSUY6JpYIXcGbCRIiTVhkHDxaIlC5V2LcT4rzLkR1O
	7H1g2hCs2GGNOvjfoQvuUODO/Hp2HCZ756MPrefwdy74L1h7wQgopJIx4x0/oa3ftDCGifQmJdz
	zh8zPHrPT0BX22b7iaE0cBVbjtGQq9kj3pTVhdMnqcpo0m0zAUE/7YxJnFiAA+KNTtrUerph5J4
	OH1e7lyfxovAI/bjzeDBPV6p2/lkkyg==
X-Google-Smtp-Source: AGHT+IEwVeI9a9AYE5SOKfP2DRcWnEDIFZ2S4HFJrlkCgz+ZrZRmKRhAxsQE8g6GPOtAJhru5Sp35w==
X-Received: by 2002:a05:6a00:b95:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-7489d006780mr10562271b3a.12.1750039712264;
        Sun, 15 Jun 2025 19:08:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:868:d051:698d:a998:a481:27a6:8366])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489008229fsm5767081b3a.106.2025.06.15.19.08.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Jun 2025 19:08:31 -0700 (PDT)
From: Rodrigo Michelassi <rodmichelassi@gmail.com>
To: git@vger.kernel.org
Cc: icaselli@usp.br
Subject: [PATCH] replace 'test -[efd]' with 'test_path_is_[file,dir,executable]'
Date: Sun, 15 Jun 2025 23:08:27 -0300
Message-Id: <20250616020827.10820-1-rodmichelassi@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: rodrigocmichelassi <rodmichelassi@gmail.com>

'test_path_is_file', 'test_path_is_dir' and 'test_file_is_executable' are modern path checking methods in Git's development. Replace the basic shell commands 'test -f', 'test -d' and 'test -e', respectively, with this approach

Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>

Co-authored-by: Isabella Caselli <icaselli@usp.br>
Signed-off-by: Isabella Caselli <icaselli@usp.br>
---
 t/t2400-worktree-add.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 90638fa886..7ab38ac4c4 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -42,8 +42,8 @@ test_expect_success '"add" using - shorthand' '
 
 test_expect_success '"add" refuses to checkout locked branch' '
 	test_must_fail git worktree add zere main &&
-	! test -d zere &&
-	! test -d .git/worktrees/zere
+	! test_path_is_dir zere &&
+	! test_path_is_dir .git/worktrees/zere
 '
 
 test_expect_success 'checking out paths not complaining about linked checkouts' '
@@ -70,14 +70,14 @@ test_expect_success '"add" worktree' '
 test_expect_success '"add" worktree with lock' '
 	git worktree add --detach --lock here-with-lock main &&
 	test_when_finished "git worktree unlock here-with-lock || :" &&
-	test -f .git/worktrees/here-with-lock/locked
+	test_path_is_file .git/worktrees/here-with-lock/locked
 '
 
 test_expect_success '"add" worktree with lock and reason' '
 	lock_reason="why not" &&
 	git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
 	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
-	test -f .git/worktrees/here-with-lock-reason/locked &&
+	test_path_is_file .git/worktrees/here-with-lock-reason/locked &&
 	echo "$lock_reason" >expect &&
 	test_cmp expect .git/worktrees/here-with-lock-reason/locked
 '
@@ -412,14 +412,14 @@ test_expect_success '"add --orphan" with empty repository' '
 test_expect_success '"add" worktree with orphan branch and lock' '
 	git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
 	test_when_finished "git worktree unlock orphan-with-lock || :" &&
-	test -f .git/worktrees/orphan-with-lock/locked
+	test_path_is_file .git/worktrees/orphan-with-lock/locked
 '
 
 test_expect_success '"add" worktree with orphan branch, lock, and reason' '
 	lock_reason="why not" &&
 	git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
 	test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
-	test -f .git/worktrees/orphan-with-lock-reason/locked &&
+	test_path_is_file .git/worktrees/orphan-with-lock-reason/locked &&
 	echo "$lock_reason" >expect &&
 	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '
@@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked checkout' '
 
 test_expect_success '"add" worktree with --no-checkout' '
 	git worktree add --no-checkout -b swamp swamp &&
-	! test -e swamp/init.t &&
+	! test_path_is_executable swamp/init.t &&
 	git -C swamp reset --hard &&
 	test_cmp init.t swamp/init.t
 '
@@ -497,7 +497,7 @@ test_expect_success 'put a worktree under rebase' '
 
 test_expect_success 'add a worktree, checking out a rebased branch' '
 	test_must_fail git worktree add new-rebase under-rebase &&
-	! test -d new-rebase
+	! test_path_is_dir new-rebase
 '
 
 test_expect_success 'checking out a rebased branch from another worktree' '
@@ -535,7 +535,7 @@ test_expect_success 'checkout a branch under bisect' '
 		git worktree list >actual &&
 		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
-		! test -d new-bisect
+		! test_path_is_dir new-bisect
 	)
 '
 
@@ -1165,7 +1165,7 @@ test_expect_success '"add" not tripped up by magic worktree matching"' '
 
 test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
 	git worktree add --detach ".  weird*..?.lock.lock" &&
-	test -d .git/worktrees/---weird-.-
+	test_path_is_dir .git/worktrees/---weird-.-
 '
 
 test_expect_success '"add" should not fail because of another bad worktree' '
-- 
2.39.5 (Apple Git-154)

