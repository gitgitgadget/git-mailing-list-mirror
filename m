Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053521A0BF1
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672751; cv=none; b=jsa4lj+9TF5H61OZioI6cTNjzvzpej/+0cA+CfnVsFZlVai2P9OJlBasFP1BWel7uyCn9ndIfWfqmZ3hgMrVfPQQLa+TWZgyMt8K3CAxKIxskPnsAHlELdP0aKp6UNZ8hVOdFU3u7zbrSadJc0ljAL9vD00/bkhhrDJ/nyjEKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672751; c=relaxed/simple;
	bh=rtZ67vU9A5Q0OZjTe3pvJsvmD0VbCYE9wza0w4v3Qbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2cQov2rM2zgo1F2XG8ys/TJQC2mB16rVo4QKRDzN7e4NcRhi4pS/vkiR/di+JeGXyEnNAFSJE87h39Y+DC76ehYySelJjYr1s4TgLFwBvm92hBOgUhB+rhVbDLVdVD6gQ8u7yjYJc+aOlwODm+sruf+XkOO8tJLBcufFrw16gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6rEphE1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6rEphE1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a31d7107faso3449515ad.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 09:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768672749; x=1769277549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhiTVgTvWwMRVpWnIujBiUTjGCJBDGx5yr1T5Nk6cTA=;
        b=W6rEphE1g2Zv+OZUABuEoia2NH4IE6YtoZAEu4TVpEOxcePjHJlY01oT9411Nk7Wme
         fKXsnmMh/18TuzhbYkjE5GfUjnmUNVx9BzBSR+x2A10FEJ3EMaUVYeI0tB6S7e9m8l8H
         R3LsftVqy6uIITx+JwTUmWo0VTr9UOHb0nDJG8dL/MKmH8yRj8j5s1qnAqJ3GuPkzRCD
         ZcAc0XZa4ZGpNyad2bjx3ynoiz249LYuTEJk3n/OygZzkMHz/zGUxGRpkJbKQy47DfDF
         xAJrTNds8Mbt8VtBymfu7cfHVvukBTwn3Ceh4hs5qwVcJdO+dvafb/Dq+u/xHPISeU/+
         24Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768672749; x=1769277549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhiTVgTvWwMRVpWnIujBiUTjGCJBDGx5yr1T5Nk6cTA=;
        b=xKFup03zSJiBAQmvqce5vslzMD6uReQ96Nh4S8i+upfonAbIQwkmpqm/ixcl2+pTHr
         Gafx0TaBVwL16dXURoELxywX8J0tpInRUrYUzQYmKnARVYPU994oN9EgYwX31EOMdKug
         X9HYrwbEwUh5zfp5st404aGKMlSazjYHwhF+G5/NSJXo7xQuqxRexl2/YLBV+QYX9XEg
         kDv3RyfHMP2jNfJSE1MdYNHAIrcOP1dnReL3tvX/AhTi7V0vyaHgp/2US6GSksqT43HK
         +eEFiv/YonIyHlYcseMUy7EZtDBjDvvq3qoKQbTyWC9HYasFQm/iW+6AoqtoWb14tMF7
         7+ew==
X-Gm-Message-State: AOJu0YzxvWQQFHAr6RKJtB2i7In/XsoxlTcZg7ASrW3YV47A/xoe6whO
	cUgh/dSH8UzYd+V/TZMDKS10ysZj9seuv+Da3MRQrwqnk0M+MpaH86gE+gRSB3KJX0k=
X-Gm-Gg: AY/fxX4paFqk0+jz1S4nSIGMc8G/1sBBZ7ue86su1lLK1WGY51QPTcOnivfRuK7C0ss
	IRld+OsEJ+/kj3IybNOQb5NZ5c0TrYs/YrVquYfo0NdtbaCmZXQtZTjf6wgPm9P16zG10rDyte/
	bOax0qzsfm1BYqezwVyuermMa/HipSCCclJJoswYNFxGojCzwPz2yNwUqJeJo0sHoJs989wfsg0
	6MxiGc8rnpga1oCYt8TLMAtziaMBo8R1WIeomxr+lQX3dqyu0JGE+4650qOq+zkotg2+mcjpNq+
	2Ofe1qDslAXrc9Hf0LH02inlVgfwxXESIuepfhoOR16ZX4DWrM15fx8edY87eipOybdlEbjBcR0
	BrMwO2O7rssLDKDqEhWMsul++9r47F4aRfiAUeBVeJscPMc9j5rkOrFuoDr4747o35qW32Rtb26
	hzv8nKyIVSIYiGYxnBvM0ETagegqk9zG6CCdZ7qw==
X-Received: by 2002:a17:902:f68b:b0:2a0:879c:ed37 with SMTP id d9443c01a7336-2a717528552mr46593695ad.2.1768672748822;
        Sat, 17 Jan 2026 09:59:08 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b3asm5012334a12.24.2026.01.17.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 09:59:08 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v1] t2203: avoid masking exit codes in git status
Date: Sun, 18 Jan 2026 01:58:47 +0800
Message-ID: <20260117175847.334666-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test script t2203-add-intent.sh uses the pattern `git status | grep
-v` in multiple places. This pipeline masks the exit code of `git status`.
If `git status` crashes, `grep -v` will successfully filter nothing
and return 0, causing the test to pass incorrectly.

Update the tests to use an intermediate file, ensuring that the exit
codecof `git status` is checked and any crash is caught immediately.

In one instance, we also need to update the grep pattern to ignore the
temporary file it self, to avoid causing a regression in the test output
comparison.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 t/t2203-add-intent.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 192ad14b5f..ac8bafa680 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -16,7 +16,8 @@ test_expect_success 'intent to add' '
 '
 
 test_expect_success 'git status' '
-	git status --porcelain | grep -v actual >actual &&
+	git status --porcelain >tmp &&
+	grep -v -e actual -e tmp tmp >actual &&
 	cat >expect <<-\EOF &&
 	DA 1.t
 	A  elif
@@ -26,7 +27,8 @@ test_expect_success 'git status' '
 '
 
 test_expect_success 'git status with porcelain v2' '
-	git status --porcelain=v2 | grep -v "^?" >actual &&
+	git status --porcelain=v2 >tmp &&
+	grep -v "^?" tmp >actual &&
 	nam1=$(echo 1 | git hash-object --stdin) &&
 	nam2=$(git hash-object elif) &&
 	cat >expect <<-EOF &&
@@ -171,17 +173,20 @@ test_expect_success 'rename detection finds the right names' '
 		mv first third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status >tmp &&
+		grep -v "^?" tmp >actual.1 &&
 		test_grep "renamed: *first -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain >tmp &&
+		grep -v "^?" tmp >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		 R first -> third
 		EOF
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 >tmp &&
+		grep -v "^?" tmp >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
 		EOF
@@ -211,11 +216,13 @@ test_expect_success 'double rename detection in status' '
 		mv second third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status >tmp &&
+		grep -v "^?" tmp >actual.1 &&
 		test_grep "renamed: *first -> second" actual.1 &&
 		test_grep "renamed: *second -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain >tmp &&
+		grep -v "^?" tmp >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		R  first -> second
 		 R second -> third
@@ -223,7 +230,8 @@ test_expect_success 'double rename detection in status' '
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 >tmp &&
+		grep -v "^?" tmp >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	second

base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
-- 
2.43.0

