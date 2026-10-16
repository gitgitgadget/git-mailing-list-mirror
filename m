Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1B38B7AA
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125117; cv=none; b=Icn/dOTj+himqwYY0lCYacSixIEae9A4Aj110LOXHBrdqsb/XcJ8dJMyoG63gZnwGdCzCy29ARBSj0Bi8QOYVWiorNbNBTmp1WdjhoMRDEoov1Vmg5OUV31asnahMNNb1csc+MEZVCJJ5ilOWhPKVSUIWL182ZGLQoA1gcTR1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125117; c=relaxed/simple;
	bh=ipo+rf5bnFpjITlicaSGyM36HfTQpfTubBOGcNQN2JM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=M63rLIGKDL1Hb4JgPSYA7TemV21/eJ2tsGOCbgaaXCR7/MQinOzuprvA43sS/TF9uRixczE82ItWGnM3K7JOwMp7mP8OhuITLYFppE03Cv38NXhkZkL9JoJOPnd0FQmL1G02B9wepQkiov4fRY5UhQlg4kftKVEcUHmFxTryXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq69WICO; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq69WICO"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35ef6b49813so3364453eec.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792125115; x=1792729915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PinLiH3IEzEymzyz1xpBtJy7z+PSmNPYoaUca7H9YaQ=;
        b=Vq69WICOJ9qkAeOdIHXLD80FchRasrSzqeGIxkuYuiEhjhs9s6K32+o1n5FsRhVBLN
         /ifu+ggPKyEbgibQXHkWXfkzvet8QOWv3I0A7hiFxZrBO0JvzBadlKZ1m6GdJcmm6NgB
         z0RgLwiFFLUenRg1BSgNqyg/bPV99ybM2T5kB/NTV9s+JasxEyVOZK7HdZuZSdpca7aX
         jI7qiz2ZU/XL2b7XCGWws9spmTvmlpbwKj9NnULivvBBo4teOnilT0DSS49/75zhlA0C
         GRdh1fbgZc2CG86ulmgoomRf7GS84vFVljb4eqiYs+T1uj+yW0FKZsi4oTDpwJ/IGNdY
         ltzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125115; x=1792729915;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PinLiH3IEzEymzyz1xpBtJy7z+PSmNPYoaUca7H9YaQ=;
        b=XFV+3zJ6IM8mHwZFZrHA1DR5rssFNdYARAw3rCy2Gnv8N9u54DWvwOnxy8ALzlbmCJ
         E2DNxILXgKBV328AOBpvFTNlR+VFmG4kXHXO50FavmaLO2CH4uzxmVlx/ADUTBIP78mi
         qxgWA6u829sU4Z/0SqBS6Pit5CNil0g6I7SH9/ErhR+Y18vqI/saGrxbz642KTkMOYXN
         8UyKU+udm6wyUOCKi5b+tMvZG9WatTiC7YJWa/bQb6sodNkbyTICsUzgqfcOgPp3TLuW
         Zx9Ro63mTv56V3H3XAd5LOgiyv3mH8ljhsX2635dfovP+p/aJZ3SJR/eQe+wyLrDcGwJ
         QeQQ==
X-Gm-Message-State: AFq9FYJqIfKeoEegzti1zOGdzQUMVtrMUwxlDByF0fXB4aBBMQLNIrUg
	96VJr3bu7W4tUVbk/4M8LCqKfFKZmd/lTGNPjR16pK7y78q4L0TJIgBkOXTnyQ==
X-Gm-Gg: AYBFou1lce6tbPu6hvKq6I//Gp5S2K4IiUwQusqDXfg0PkO/CUWJCJmgewoQcaQp/ph
	N4zUzMuWDe2r13lN9GJa9MD1VG6n8asUhLyY3pGwPPIs6lHRNckAJvgaIMV/oBkXEWtIo0+34N/
	reRI+m7V05gMchBuJp1eKM2hHosixNbRP+OAKz862wPghXFAAU5R9wYG42Wz1HlcbQ8UtFg2Dpk
	bnmM3h3uaVfc53QCRh169Bwfw/jRgE6sqVv7F3Mr9yKZKV3Akn5w0YLl8dQ3A6VL8DCoEwVueMs
	Oqt7vK8y5yv1rhWvNubQMX/4GThHKDuMSBClOgIgeb9B2pG5juBs1R8cbG5lKsWG+YjgfkOWXmD
	WEakWUu/19tyYH9ncyr47rtab9Rvcmod/4Wak2g+EkfMUJqF3nMFJszBj3MV9TSg1B388M6QrYq
	4GR1UYvE9ooAOd8nnpuPmdQTGgXri3HdTkd6J6iemzvLxxf4avqmslDkByVPq0DS6CGnGbI51c
X-Received: by 2002:a05:7022:7e08:b0:144:fdf0:9d91 with SMTP id a92af1059eb24-16a61695832mr39040568c88.24.1792125115039;
        Thu, 15 Oct 2026 21:31:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.178.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f5a13sm2448409c88.12.2026.10.15.21.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:31:52 -0700 (PDT)
Message-Id: <pull.2259.git.1792125111461.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 04:31:51 +0000
Subject: [PATCH] [Outreachy PATCH] t2403: modernize test for directory
 existence
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Shashank S <shashu8660@gmail.com>,
    Shashank <shashu8660@gmail.com>

From: Shashank <shashu8660@gmail.com>

Replace the old-style shell `test -d` commands with Git's modern
`test_path_is_dir` helper function.

This provides better debugging output if the tests were to fail,
as the helper prints a clear error message rather than just failing
silently like `test -d` does.

Signed-off-by: Shashank <shashu8660@gmail.com>
---
    [Outreachy PATCH] t2403: modernize test for directory existence

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2259%2Fshashu8660%2Foutreachy1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2259/shashu8660/outreachy1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2259

 t/t2403-worktree-move.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 69768c1207..85793f9460 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -182,7 +182,7 @@ test_expect_success 'force remove worktree with untracked file' '
 
 test_expect_success 'remove missing worktree' '
 	git worktree add to-be-gone &&
-	test -d .git/worktrees/to-be-gone &&
+	test_path_is_dir .git/worktrees/to-be-gone &&
 	mv to-be-gone gone &&
 	git worktree remove to-be-gone &&
 	test_path_is_missing .git/worktrees/to-be-gone
@@ -191,7 +191,7 @@ test_expect_success 'remove missing worktree' '
 test_expect_success 'NOT remove missing-but-locked worktree' '
 	git worktree add gone-but-locked &&
 	git worktree lock gone-but-locked &&
-	test -d .git/worktrees/gone-but-locked &&
+	test_path_is_dir .git/worktrees/gone-but-locked &&
 	mv gone-but-locked really-gone-now &&
 	test_must_fail git worktree remove gone-but-locked &&
 	test_path_is_dir .git/worktrees/gone-but-locked

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
