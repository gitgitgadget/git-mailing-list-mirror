Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155E33F5A0
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728214; cv=none; b=HNOTKNSqPRD6PybWqTIg+X4AB3u80phybnV6fgpxsNJwSW1mYy6X5HCjr7Y8j8z1iMeLfGY4ShjDyW0KTBlhVHGHLwGiMHthYbhbfCHAW9yd5n9UJ2XAAFlJRoi7548P5p17wfMwQR50zqxvCOCEJAgEPT1JpsuAJ8Xzh01liWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728214; c=relaxed/simple;
	bh=gqOAicK77uyXeab052nn0XNXw6NjCXrMc6aq/QB9wFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3Cy3RG5Cz29qsSEfIneRh/4LgXRIgQ/ZUowJtK9pSH7cLjv9pvGLJMASIxwDN/nEzvBy5ldRfCRirX8UdXjwvNH4TqCGfMYthG62qVOGb/kEW0kJxaDSKdYCYHm4JIgGoioR/fsQoPnMQAiQAxK5rFsAAUUQfERdn1pySb31Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfh2wrWL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfh2wrWL"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c766a95a72dso2146878a12.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728212; x=1775333012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5Pz2xZ9yxuDtwOodehPrM+tMmCay9wgw7gHCLRaYog=;
        b=sfh2wrWLkznjkVRYTXMoxjaLHzCWlaGq0MXcgKCEz5cjjR4sKMCa6x/bpAP9u5+Nor
         iHEA2wGsZKuR0xahzAdYNuj02+9fZQVj0u5WCu8gjgqO56doCWmjM8PV/nl95NDm578T
         Ys3hq7vPP0+PLdl1YO5Ik2gdsQAjPyDiIc0WZMhCHfHSJiS+6xywDWvggAI7x/Nf347H
         +4KnIwh6AQHjUDgVC4W8AwD6TTJMjDwGtJNtZ8iKsECdTi8akfqib67q5XuQLxKGQ+NJ
         x+rrGIfv+1dO7nihY+hdVA4AJq7kEUqHZlhQhd3JNmlS6xFJCKkm43htvrQvsfJ1fUQX
         LELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728212; x=1775333012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5Pz2xZ9yxuDtwOodehPrM+tMmCay9wgw7gHCLRaYog=;
        b=fq5KJ3INmpZwQJ0BFR1rMK+YyZOl8aW2v9WPqyK5q72hjAefktcBbzzbYutf5jybue
         O9XSiYlthI3zu/p3+xQ84CvRPl+wdot6fxJwFImL+sAT9OU7IwJEBlrj/J8bPnaaK/u4
         gb0y2QICCyU27asm4INrFCYnsg2ojNWXiq+gNNf6uUTqBL5f1rUtOeFbdaVOf6rwJRe6
         aoiciEZ8Ag6DbV3IDmfTFa4h3GOInU03NXyA7HwXUbP/J2WsNVzr0MbJ6MPtdU4oMhlm
         /YsSZwp2iCYZty3MFZkIvFQSnOIDS77f/07JiyiwftkAeLe58PF2nRWRajt1H2qXjrJI
         N2LQ==
X-Gm-Message-State: AOJu0YxbbPfEQgQu+uT3brD9cvBR2B98oI0z0WHG5aKBoCpI4PZJXzj6
	R0aeSdDsZ5zYP2opPkOIXDxvZ3dZ+EDP2SJmcIjeaJVCooUlcNsPcPtwSHQnSNiI
X-Gm-Gg: ATEYQzzeynt9KDUDuyD0KDMvtmrgOF2nxmHDG+nW8Q9v9Wv/o+iJW/QSWweaOVbnXjY
	VuMqr7fpBDGuJp5xmpcF/6lOJ6ecSe4H3d7OCdQAygNkx5AV+GEx62LuaNFyNn9NmIG4rijgJIf
	b5g0DEOa3Jw8o/LVeP199T2e4CJD+anKg+HWDgnwpCdhAK2wbNIIH1EktMsO5lEWimyathHQoFt
	yaMQnSCdxbdCmmriu2rgOA+c/qxgUX/0Ygn+BBg32I+pSMC3J9kxW6b/UxSQF79NGxzLBmDFhDN
	xV3D68PtPAKUtsDpYq60k+LS9lelhdUq1VfClTytvBmy5Cl80KP8ft5qbP32ZXgew+wrVDrZ2dr
	r9ITPTj4Chik7OIOALT7ItPLp5C6p4nM5uVKAfrnHJ/bbVKwocy4nlNbDlbWMgBt4YVfZfuChgm
	Qt3MCF8VhJHlmv1OQh0GSCfCEmUSpO9CFf6VqYLWOaJ9uOy+EhpYQDngGHCz7NGX3gAIJ7JzKBt
	zNmRRRD6+dQSepTXsWq
X-Received: by 2002:a05:6a21:3298:b0:398:9b6e:339a with SMTP id adf61e73a8af0-39c877ea538mr7472134637.6.1774728211920;
        Sat, 28 Mar 2026 13:03:31 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:31 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 16/16] t2206: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:55 +0900
Message-ID: <20260328200255.247759-17-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t2206-add-submodule-ignored.sh to redirect git-cmds output
to a temporary file instead of piping it directly to not hide the
exit code of git commands behind pipes, as a crash in git might
go unnoticed.

Some tests run inside a subdirectory that is itself a git repo and
use 'git add .' on the whole working tree, so the temporary file is
written as '../actual' to keep it outside the inner repo and prevent
it from being accidentally staged.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t2206-add-submodule-ignored.sh | 45 +++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/t/t2206-add-submodule-ignored.sh b/t/t2206-add-submodule-ignored.sh
index e581e87ab2..7141012e50 100755
--- a/t/t2206-add-submodule-ignored.sh
+++ b/t/t2206-add-submodule-ignored.sh
@@ -45,9 +45,11 @@ test_expect_success 'main: add submodule with default config'  '
 	cd main &&
 	git submodule add ../sub &&
 	git commit -m "add submodule" &&
-	git log --oneline --name-only | grep "^sub$" &&
+	git log --oneline --name-only >actual &&
+	test_grep "^sub$" actual &&
 	git -C sub reset --hard v2.0 &&
-	git status --porcelain | grep "^ M sub$" &&
+	git status --porcelain >actual &&
+	test_grep "^ M sub$" actual &&
 	echo
 '
 #3
@@ -58,8 +60,10 @@ test_expect_success 'main: submodule config ignore=all'  '
 	git config -f .gitmodules submodule.sub.ignore all &&
 	GIT_TRACE=1 git add . &&
 	git commit -m "update submodule config sub.ignore all" &&
-	! git status --porcelain | grep "^.*$" &&
-	! git log --oneline --name-only | grep "^sub$" &&
+	git status --porcelain >../actual &&
+	test_must_be_empty ../actual &&
+	git log --oneline --name-only >../actual &&
+	test_grep ! "^sub$" ../actual &&
 	echo
 '
 #4
@@ -69,8 +73,10 @@ test_expect_success 'sub: change to different sha1 and check status in main'  '
 	cd "${base_path}" &&
 	cd main &&
 	git -C sub reset --hard v1.0 &&
-	! git status --porcelain | grep "^ M sub$" &&
-	git status --ignore-submodules=none --porcelain | grep "^ M sub$" &&
+	git status --porcelain >../actual &&
+	test_grep ! "^ M sub$" ../actual &&
+	git status --ignore-submodules=none --porcelain >../actual &&
+	test_grep "^ M sub$" ../actual &&
 	echo
 '
 
@@ -80,7 +86,8 @@ test_expect_success 'main: check normal add and status'  '
 	cd "${base_path}" &&
 	cd main &&
 	GIT_TRACE=1 git add . &&
-	! git status --porcelain | grep "^ M sub$" &&
+	git status --porcelain >../actual &&
+	test_grep ! "^ M sub$" ../actual &&
 	echo
 '
 
@@ -91,7 +98,8 @@ test_expect_success 'main: check --force add . and status'  '
 	cd "${base_path}" &&
 	cd main &&
 	GIT_TRACE=1 git add --force . &&
-	! git status --porcelain | grep "^M  sub$" &&
+	git status --porcelain >../actual &&
+	test_grep ! "^M  sub$" ../actual &&
 	echo
 '
 
@@ -101,8 +109,10 @@ test_expect_success 'main: check --force add . and status'  '
 test_expect_success 'main: check _add sub_ and status'  '
 	cd "${base_path}" &&
 	cd main &&
-	GIT_TRACE=1 git add sub 2>&1 | grep "Skipping submodule due to ignore=all: sub" &&
-	! git status --porcelain | grep "^M  sub$" &&
+	GIT_TRACE=1 git add sub >../actual 2>&1 &&
+	test_grep "Skipping submodule due to ignore=all: sub" ../actual &&
+	git status --porcelain >../actual &&
+	test_grep ! "^M  sub$" ../actual &&
 	echo
 '
 
@@ -118,15 +128,20 @@ test_expect_success 'main: check force add sub and ./sub/ and status'  '
 	cd main &&
 	echo "Adding with --force should work: git add --force sub" &&
 	GIT_TRACE=1 git add --force sub &&
-	git status --porcelain | grep "^M  sub$" &&
+	git status --porcelain >../actual &&
+	test_grep "^M  sub$" ../actual &&
 	git restore --staged sub &&
-	! git status --porcelain | grep "^M  sub$" &&
+	git status --porcelain >../actual &&
+	test_grep ! "^M  sub$" ../actual &&
 	echo "Adding with --force should work: git add --force ./sub/" &&
 	GIT_TRACE=1 git add --force ./sub/ &&
-	git status --porcelain | grep "^M  sub$" &&
+	git status --porcelain >../actual &&
+	test_grep "^M  sub$" ../actual &&
 	git commit -m "update submodule pointer" &&
-	! git status --porcelain | grep "^ M sub$" &&
-	git log --ignore-submodules=none --name-only --oneline | grep "^sub$" &&
+	git status --porcelain >../actual &&
+	test_grep ! "^ M sub$" ../actual &&
+	git log --ignore-submodules=none --name-only --oneline >../actual &&
+	test_grep "^sub$" ../actual &&
 	echo
 '
 
-- 
2.43.0

