Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547051C8603
	for <git@vger.kernel.org>; Tue, 20 May 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759033; cv=none; b=EgcWA7FjfcUv1ce7gDWqmEuT0GeL9wsiYIKmzpHfLSo334pP/w9tnBWiF9rLBdI1VapFMVTlegrF37apT/yi4uXm53KYZCtrrZ6Mr9QlQQ9sQ+cPoCnKg+zztvj1TVJUuKxhXI/g9f5sLk4ago1Zu+zuoHUCLCfrIR4Sz/9lDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759033; c=relaxed/simple;
	bh=2VIH8cIuf1nYzsvmhiM8G01GYwVuPy/Cgelg/xRBa68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnHtqY/hlvbqAFwXNNL6u0AUk7gZoHXPMks1X4mbjFUlXTix6qPLTlrVx7nSs0NVMPpvaOsTWRozTAATvqrDMPE91yswX0fDVV9dAU96MdiWufwlciAxAbZpXE63iZ4dh24HyrM6OMvWR5GKRb4a9dy3PUTP59PXaIa3lX1sgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE8IX+Gl; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE8IX+Gl"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fe83c8cbdbso2139765b6e.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759031; x=1748363831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJdoIDuU398L0TlWHG16A8lORA2pH4Du37cxrEJIhag=;
        b=BE8IX+GlECX88d5CRcVWjTAuswp41Bz3XQjPTAbTytgBKFq6fV5BcsI9/F1uTEtEv2
         2cpbMrfX4ZsSeD5zzPu8pDp49TmrjVn1FD0FFm3zY/e6neBl9fd+l81tvCYXHNURCyWA
         R1/uOs6D9T1ktH/vlOUF2H1dsAJRWC1gTBPAuDFN9T1wUP/Gov6R9mLeeiDRAKjkGsp7
         Oor3yC6c8ct0iUX18zBOVcRbqV4mNO2x9A81KTHnAhPlE5iMAoYINHIFQaYqpcoH/m9q
         1uOrddQC4KmX9A9Akxza/yR6e4pIScMXPe199xSL9WdsEUYOqoxYEtZaKyxqHHtsPCtA
         sFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759031; x=1748363831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJdoIDuU398L0TlWHG16A8lORA2pH4Du37cxrEJIhag=;
        b=r925GVHF6x4uWwjBa4PlQTZR81G5EVd5k5dt77jU8p6aaQdHigsBSykumJBiXb6e8h
         Zt2lXqwGzZaeCR+XcidctH/ErMWpndrdyHloQHNIrpW0A0EBiTeaMnmLI9xT4icMK41t
         3P/Cixp/tqP+ucIsVk+UxLEEhTi1YSWxfcWoeNYB5UrwUnJESt8a86baF9jFhwsgb+7+
         18vVrDocNyOUrmPfBd/3mMRdzJ6HWZXM9zSBKev6nRrGKV4xuwEeOXsciT146GCir+ZA
         81eH8xZTW9BhrWX/Voib9xF6Y2/nCTvh+4G6J5nN8DR9Ug24HF4AT9AZICZ5tptCUaYz
         PiQA==
X-Gm-Message-State: AOJu0YyvYclsAMaWvQrwk8DBPGYer8u6/A/AGDwOu5uzbC5KOyoxtAaU
	mKBk4AVWuAPFUpGBgDwIUSD3U9tSqumWkLFk6B3UlZlpMGgjLVCXK4i2HPFFgtYT
X-Gm-Gg: ASbGnctxeTYQivoECeMIUvKULBdKXTWmKAB52ko+Dp3smPWn0PFXyEMy/vIrpJbatCW
	kgzxM/VsPlOK51qfWb4KQTsraD4vOXw6+DHYxH5H2ebtuTGhOepknUCh2dxP2jDfjhmtoBPSqLZ
	ovp8oUnF1z1uUvmv1cASWVxqB+WX4fRu9F7tuMJudq4ppjXcbvbP3jUcDVPi8XpwVIBYlsvFpg5
	1hmjkmilB9gEuJeUWrOjmBiex8dIhXtU/tpUFFgfqycZT99vQUkleTbWbJLk1X9Hn3MifaS7G2A
	CRrF12FcdwUMjmd4jntOyf53fjZBlLizDc9QTemyl+/fFhggdWgZK5I+NhY=
X-Google-Smtp-Source: AGHT+IG7W6pAHLQqBITVvOMKKYhfwZXbw7Tbvk2o5yugOCzJAO0jC1ohBdT7N1zNA+DCyHwMOjmAAQ==
X-Received: by 2002:a05:6808:11d1:b0:400:a250:9819 with SMTP id 5614622812f47-404da7368fdmr9664844b6e.12.1747759031074;
        Tue, 20 May 2025 09:37:11 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-609f4be9734sm1903975eaf.7.2025.05.20.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:37:10 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/2] t5410: test receive-pack connectivity check
Date: Tue, 20 May 2025 11:32:17 -0500
Message-ID: <20250520163218.263921-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250520163218.263921-1-jltobler@gmail.com>
References: <20250520014920.201736-1-jltobler@gmail.com>
 <20250520163218.263921-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of git-recieve-pack(1), the connectivity of objects is checked.
Add a test validating that git-receive-pack(1) fails due to an incoming
packfile that would leave the repository with missing objects. Instead
of creating a new test file, "t5410" is generalized for receive-pack
testing.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/meson.build                                 |  2 +-
 ...ck-alternates.sh => t5410-receive-pack.sh} | 23 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)
 rename t/{t5410-receive-pack-alternates.sh => t5410-receive-pack.sh} (57%)

diff --git a/t/meson.build b/t/meson.build
index 43c9750b88..6b7c0b167b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -628,7 +628,7 @@ integration_tests = [
   't5407-post-rewrite-hook.sh',
   't5408-send-pack-stdin.sh',
   't5409-colorize-remote-messages.sh',
-  't5410-receive-pack-alternates.sh',
+  't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack.sh
similarity index 57%
rename from t/t5410-receive-pack-alternates.sh
rename to t/t5410-receive-pack.sh
index 4e82fd102e..9afea54a26 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git receive-pack with alternate ref filtering'
+test_description='git receive-pack'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -41,4 +41,25 @@ test_expect_success 'with core.alternateRefsPrefixes' '
 	test_cmp expect actual.haves
 '
 
+test_expect_success 'receive-pack missing objects fails connectivity check' '
+	test_when_finished rm -rf repo remote.git setup.git &&
+
+	git init repo &&
+	git -C repo commit --allow-empty -m 1 &&
+	git clone --bare repo setup.git &&
+	git -C repo commit --allow-empty -m 2 &&
+
+	# Capture git-send-pack(1) output sent to git-receive-pack(1).
+	git -C repo send-pack ../setup.git --all \
+		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+
+	# Replay captured git-send-pack(1) output on new empty repository.
+	git init --bare remote.git &&
+	git receive-pack remote.git <out >actual 2>err &&
+
+	test_grep "missing necessary objects" actual &&
+	test_grep "fatal: Failed to traverse parents" err &&
+	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
+'
+
 test_done
-- 
2.49.0.111.g5b97a56fa0

