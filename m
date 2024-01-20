Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090BA4D
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705716981; cv=none; b=imKBJHUS4JesAXRt0Bb6FPWSWaDZhDKxs43Ffb8YJWPa3H22z114/VmaZOVJlydHQWwaVd10UiRcgJyMU/LJNgdyyKm4K3mUV2A8FGgZrJH2ton/RDdXAY8Vs0DIC8iqN30LaX8rezpzyII1Eld1JM59lt0pwc45nf4hT+d75xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705716981; c=relaxed/simple;
	bh=zJgNYbIG2Z2hPLFEnYC1IjQsT76SOdMn8pRli5LRpP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWjOnfUMJyMPYKQ1KOQCWb484C6H9X2TH2DCjD2VGUFSxnoQ5BIGPpdi4pdT3EKEcPLxvmLoEH+FlKgRp8z07OcrM2j7FARH7tc3h5ks7d+jq1h1sZDcQPTm35Mx69yqZ9lWTtTraxDGuNlOQcusRIuIYkb21juqCC5/0C7tECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgkhOcDG; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgkhOcDG"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-337c5bcf79fso1287466f8f.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 18:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705716978; x=1706321778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW7NBKAf0oylc50OTLSJlhlPelzL81+QLOSsuIiTCZg=;
        b=bgkhOcDGfwKTN0N0SJijm315MYNV2Kb+E25zDebwo9AA0Dhfa5siswOK0lZdHk77U3
         GpfQxlKI7rsYxfNbq3Z2xOTK7FZUPIjRK2Dk6l7sL3cMB/ki1p1H/zNO+eke0KGOrWGg
         uy4vGKaVSrM4heNBnlrS4+MyE+9B33a6fEMFJurnuSsdV9LYFVI4PnaXvc9DL60vSO9X
         T0x3QogBlP8+yWaewbCX4pJYSk1XkQJG+OPgZNCN5qSXs0FmlgRwMLgcqGluCwCcEywn
         EnsCmf9Ub0eaRFYXakXWMfx6tljYvMGRPE45A//sQ5SMe5RzVIZmA2sTw2gAJ1oISnem
         GhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705716978; x=1706321778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW7NBKAf0oylc50OTLSJlhlPelzL81+QLOSsuIiTCZg=;
        b=iYhdn9ZZ3PytGOjaZQkaB0xKGxGkcvf5RnbmLLjRHUAPNfdEPHAcG7f5jf54+W+DtO
         aIedOMferz3FqPUQ0PxipKyWbD6RkD8E6uQxc+0+I1GlpDvz9ovZcPapb9P6hhMyCM6S
         5h/R3xSZpeItBG05gCO9HB99nwoikYDfv9sn4nCtBLKZGBf7Lx/TntKbg274FcjHWkCM
         0g8XQQazENey2PWkWSJFY7YHzd3nTdkMsrZ6c6aEqkPweU1gl0lK9ShOGLOpTbJaG0Uj
         5mKUg4HMXHG5mZDgksujBFP5/R+HU956HWEFMnuDmpP1Fr8FWocdCl+h8wIDVhs8rCX/
         H0yg==
X-Gm-Message-State: AOJu0Yyv1UZ3Qc+Sk1ViE+vP86wT3UBAwxSpHeq/wu/CJmg+sDIcJdl+
	8hKIiJDhitizoimFJ3Y6zViAmGVnFPu6I1ayxno0qB5qLPtywqIyrvG+iOJrs+k=
X-Google-Smtp-Source: AGHT+IEBZmu4wSHtbqTupJVb3vlZWKRneYeRZax+AADtYjMkFf5udeaasZ+jxXtL/U8QlrDj9rGwOA==
X-Received: by 2002:adf:a2d5:0:b0:337:c91d:e80b with SMTP id t21-20020adfa2d5000000b00337c91de80bmr312741wra.13.1705716977803;
        Fri, 19 Jan 2024 18:16:17 -0800 (PST)
Received: from localhost.localdomain ([41.202.207.146])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d5081000000b00337d9b772c6sm3258412wrt.37.2024.01.19.18.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:16:17 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	Achu Luma <ach.lumap@gmail.com>
Subject: [Outreachy][PATCH v4] t2400: avoid losing exit status to pipes
Date: Sat, 20 Jan 2024 03:15:47 +0100
Message-ID: <20240120021547.199-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20231204153740.2992-1-ach.lumap@gmail.com>
References: <20231204153740.2992-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the preceding command in a pipe is disregarded. So
if that preceding command is a Git command that fails, the test would
not fail. Instead, by saving the output of that Git command to a file,
and removing the pipe, we make sure the test will fail if that Git
command fails.

Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 The difference between v3 and v4 is:
 - Changed subject to better reflect what the patch is doing.
 - Updated the commit message.

 t/t2400-worktree-add.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 3742971105..b597004adb 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -490,7 +490,8 @@ test_expect_success 'put a worktree under rebase' '
 		cd under-rebase &&
 		set_fake_editor &&
 		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-		git worktree list | grep "under-rebase.*detached HEAD"
+		git worktree list >actual &&
+		grep "under-rebase.*detached HEAD" actual
 	)
 '

@@ -531,7 +532,8 @@ test_expect_success 'checkout a branch under bisect' '
 		git bisect start &&
 		git bisect bad &&
 		git bisect good HEAD~2 &&
-		git worktree list | grep "under-bisect.*detached HEAD" &&
+		git worktree list >actual &&
+		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
 		! test -d new-bisect
 	)
--
2.43.0.windows.1

