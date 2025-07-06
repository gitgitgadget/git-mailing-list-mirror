Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CB1DDC1E
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836139; cv=none; b=aRmIhb+N6y9+npA7SgZUuzJ/5na2HiqPuAojyxd7rLkfU/okFtjAmZM0+pIgl1/6QvxENvvknIlDt0LmPMWuFJ4mth7nMYXNfg1bxppAQv6JXPruopEXHIO5XNjGa7JT3Lg/LZFLQ3G4xZDiTiTUHm65a/BiMnzkafLMgLI6QeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836139; c=relaxed/simple;
	bh=qNze35MgPi+5knen13lYeCLPF79RoKcrJIbb4HcZvrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AENcTHilT1v4ZzInz8IbBwmkv1V2qLpOZ2V6T9zCCRZ4dQgO2iBRSrxHBcWM3DCWWcByjc4nd9o3mMpyjHF1pGmqe4P7vu0KBLhXFyAH+8LKCVbNGr8mth9M5XPF4kwDPCStzZY+e3MwXtBZcL6pnzFxxsJUBQ/fVpJkafHpAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMQRWEho; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMQRWEho"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1342805b3a.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836137; x=1752440937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHUkZQwyNfT9bd2zYgGVuigW8XA1GHIA7l3jy9szCqI=;
        b=kMQRWEhoNOWcrH8gmdWs4em10e6hbcqCdi7qg97grfq/wyymynGo4HiXhrUx4e5zTe
         V98vAeaYAfw4z5Zz45SC5lJlu0cvPp87i3NAzsDQbopu9JeZNuyaqyP8OjMk4pdrNc5k
         IqzZaXHhP4jhxNcs9tV9OYHjbWpa3cGshf9N5/vwNs7+WHL6JUTWyR//hG5kwLEu1V91
         1KJjgDD9BDYUgvIsVVRnjqs3MeXUvi9ORG8+WuBuZgFh5NzU9ncvLAAL6OoN9joW8Bx+
         Ydqzieu3lKwm8KQQL4wlwkvlsqoSAdUyS7jA4J5YMZ57epvCJIQ/E7iRtDFaw6jaMdG+
         GfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836137; x=1752440937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHUkZQwyNfT9bd2zYgGVuigW8XA1GHIA7l3jy9szCqI=;
        b=fgQMKY1PFAguvOlKougkjygfCxsrQ02ITF4QXCVHCoEPdOEySq9znx1r2X3q+xhAkU
         dHixmqOAA3hS4jJB9qf0/M65Q9HTrh/63AmQKC4MPhbGAbsuRRekPZOouiS+jMUUoYl1
         szAxS0bWW5rSXE7lKnbWY+NxcwuFz3CSFSHWVtIjEydCA0ERgifypFRdjlf4SAf7aJLC
         JIKhDvT8FgNFXbVLqrs15KN0nOwlCOEnEJvYfotebpy7Fw6ApyU38aji3SAnHNc/yeoC
         nM5/77ua0qsspk14zQIFZYyIIhZz4PW+JlSGrrlW/FegPZaPaZjdCq5V3o5S9utRyYWM
         CrtQ==
X-Gm-Message-State: AOJu0Yyine4yRmnsV6Z4dWfIWhJMnhN14kJpZbtVfjnCH6txAXVk1Qc6
	L7F2s5V/7lo+5cknMT9tahNf7Bf+2h7PsDeDII614KO+wdbeChIUILAjrfCsYpetx0M=
X-Gm-Gg: ASbGncsMX8IkcNXsdkDcAYOouBTGLaLvvvD7c00GpJ5ZU8w2nIOuoK+aJ72EblY8Rii
	uI/FL69iOHI3Mp8+vEpxABOTG3ciPGvhwWC4QIc8L2DmdlrZ66dvRw8X8j1gZPc+94AK+dv8FZ5
	xCW9Y/YOlRnJ4vL0iX4vZ0w6pyHBiTy4cY6BNFBjNvNjDLCrqGfS+ISVI7dPi/xxH2Zv4SyY+74
	crChUMxvBLqv6TvYQF732aG9JtWBExPnUExaTRtjLZQXXQCzhRKT32aa97Exk3JbYLd6+K+6iKh
	p8i/FSAL7O1IMwyd6oxOj+r63Jx1QqDNcRNV8pK/Bo9L7PuNmjKc3dOm3qJ79vkVdqcxuJTICZV
	GwyheBQxK9dw=
X-Google-Smtp-Source: AGHT+IE1Fu0VH2yxEMHmoC2Bx7gxWF3Q6vM8XRHoOB+6j0xefzrpcYCfGZCERMko0sQ3WXO7vCcDfg==
X-Received: by 2002:a05:6a00:17a5:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74ce86d45b6mr13352247b3a.0.1751836137134;
        Sun, 06 Jul 2025 14:08:57 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:08:56 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 5/7] t/t1517: move send-pack -h test to t1517
Date: Mon,  7 Jul 2025 02:37:23 +0530
Message-ID: <20250706210725.79903-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
References: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'send-pack does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t5400-send-pack.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t5400-send-pack.sh    | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 5b4373f8cd..a140b5cc38 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -142,4 +142,11 @@ test_expect_success 'pack-refs does not crash with -h' '
 	test_grep "[Uu]sage: git pack-refs " usage
 '
 
+test_expect_success 'send-pack does not crash with -h' '
+	test_expect_code 129 git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage &&
+	test_expect_code 129 nongit git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage
+'
+
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 83b42ff073..571e8f1bc5 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -55,13 +55,6 @@ test_expect_success setup '
 	echo Rebase &&
 	git log'
 
-test_expect_success 'send-pack does not crash with -h' '
-	test_expect_code 129 git send-pack -h >usage &&
-	test_grep "[Uu]sage: git send-pack " usage &&
-	test_expect_code 129 nongit git send-pack -h >usage &&
-	test_grep "[Uu]sage: git send-pack " usage
-'
-
 test_expect_success 'pack the source repository' '
 	git repack -a -d &&
 	git prune
-- 
2.50.0

