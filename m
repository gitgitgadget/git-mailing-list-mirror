Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD015699D
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728192821; cv=none; b=S9DY7umZhNulHgqX8xiy6wUs79hKNmHau40RtDNpEjGKXm5dJPgOG43/+wwSq+jtLwF34yeyww8N6n4NbhEsDV1yveqZoNJXLgpjv/c5F+sxj7yIaR0jFtjJtITuyqkMM+e8/8VyT6KMovo6ARoowD9xXC39/wQDqulopv5Kf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728192821; c=relaxed/simple;
	bh=owFjzM6Zz+SyJMZqfVQc30yJHNdk0ERaHy/Q0RIfi1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WIvxfmmy4kpq1iMelvehXTf+4tLb9htnAZ8H1yMQUmZurpQaMaVPPAMECFnByJRcQ/0CoHnLpEuGsV4Yw3RiXjLIlFpxVSjsChaHrKNTZQWQX5Vq7KWyjkpWx5Zt99neeh1Azlg75bx09TB7jSscV4rPx7qU3lSsoSewYQ4l+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdYLtGdM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdYLtGdM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so581575566b.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728192817; x=1728797617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4p2QSui+vyEyJ0gzbiiM5suTNuak3CdBBaZFCxSNac=;
        b=FdYLtGdMYsKiM3CYNHydmuR85QB4/5mHBOMsZ+rCRo1+UTdDDqFyPgd39hijN74Kf8
         w00NRjymOTMMpYc5XqwX/mO6FgULAOFH0/fON5QQmsIYpszma+ukn+yOVRv8gWFm0XP2
         qT6x+KYDFLOckqlIesRPJe6l3Vqe13puDT3AvghhCvy7/zLGBu18fVfAOPExzJjGaF+M
         cfM8cXjNpzwl3ndst6TbJamqxRICpB8NMfVAoMtxyvju+DOU5LyU1Ha45ULcxd+pOwke
         WVgKEuYNYCCsK3A3h9JgxkoApb8HQTUsqJ/IjYgkXuwTBj7OdTSGf0zdM/4NnE6gE1CL
         MkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728192817; x=1728797617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4p2QSui+vyEyJ0gzbiiM5suTNuak3CdBBaZFCxSNac=;
        b=c/S0B6qnxeWO7MBnxZ7bZoxwnM+SRkpOZ4LHLw7k9v7MuP5WHgSaFzvnOFCicnqnjm
         /IoPQ6OeDn3r+ca31KefH1gu6cc914TTM3q/b0joQyVdlLGqu9O7xsHPLM5ijmvp5k7Y
         QNICu8UqwmbB4qc7MYJZaMjy9ykCtO1J/eimldZR4eV553f30k9qwkXGx+W6FtDtf9c+
         aAqxjOtAXwKfveo3k7iOPPviW+mN/M68UosE7QwUewkjI0GVcrU2Xvko5tZ9AruP2YGw
         ITIwrBeoX7o0AWx38Ka4hlfiEztMbn5qVv2827YNHtu4WR1deQtzq5E6onxXvGo5MNj1
         D+zA==
X-Gm-Message-State: AOJu0Yzl3pcanrcxuT4AHFEKjtRoOzYvHbkUnnM5kjHMPOxk4xaI6VKP
	JT8k7di4Ggs1ofvwdD7TXRSp8cn0J8BF/iXgnCA+GpML2CSphmzw2YAjrA==
X-Google-Smtp-Source: AGHT+IGAUshsUmL1565h4Txm87IrUMNfJDd9jO+JYgpXgAbjyIKV9tg0z/Pgx5WLhNcIJCK81qKa6w==
X-Received: by 2002:a17:907:2d91:b0:a99:ec6:a820 with SMTP id a640c23a62f3a-a991bce3ffcmr699107366b.2.1728192817161;
        Sat, 05 Oct 2024 22:33:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e62392csm216813366b.52.2024.10.05.22.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 22:33:36 -0700 (PDT)
Message-Id: <4199434bd6ef2142192d1c720ccd877b1a80536b.1728192815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 05:33:34 +0000
Subject: [PATCH 2/2] [Outreachy][Patch v2] t3404: avoid losing exit status to
 pipes
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes since v1:
- Added "tr -d '[:space:]'" to handle whitespace on macOS

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t3404-rebase-interactive.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 33ea1f05e2c..3d8de69d6ee 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -401,7 +401,7 @@ test_expect_success 'multi-squash only fires up editor once' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
+	count=$(grep ONCE output | wc -l | tr -d '[:space:]') &&
 	test 1 = "$count"
 '
 
@@ -416,7 +416,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep NEVER output | wc -l) &&
+	count=$(grep NEVER output | wc -l | tr -d '[:space:]') &&
 	test 0 = "$count" &&
 	git checkout @{-1} &&
 	git branch -D multi-fixup
@@ -436,7 +436,7 @@ test_expect_success 'commit message used after conflict' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
+	count=$(grep ONCE output | wc -l | tr -d '[:space:]') &&
 	test 1 = "$count" &&
 	git checkout @{-1} &&
 	git branch -D conflict-fixup
@@ -456,7 +456,7 @@ test_expect_success 'commit message retained after conflict' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep TWICE output | wc -l) &&
+	count=$(grep TWICE output | wc -l | tr -d '[:space:]') &&
 	test 2 = "$count" &&
 	git checkout @{-1} &&
 	git branch -D conflict-squash
@@ -501,7 +501,7 @@ test_expect_success 'squash ignores comments' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
+	count=$(grep ONCE output | wc -l | tr -d '[:space:]') &&
 	test 1 = "$count" &&
 	git checkout @{-1} &&
 	git branch -D skip-comments
@@ -519,7 +519,7 @@ test_expect_success 'squash ignores blank lines' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
+	count=$(grep ONCE output | wc -l | tr -d '[:space:]') &&
 	test 1 = "$count" &&
 	git checkout @{-1} &&
 	git branch -D skip-blank-lines
-- 
gitgitgadget
