Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10192E36ED
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836128; cv=none; b=tOvSJD0fHwsijmx/tY5MP9egnO9NEEpKpMyEssCyDmhKj3MglmCgPGeE3boWqLxB7Vq9/fOnVWJyn4vLKRrXEYRDWIZkEMI6NBjfU7xsLJe0H01C+uTGCKpmkb+nOuZeqaGKAxS3FlOPgOUwewBAk+wgXhPO4CkwJKOslK9Wo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836128; c=relaxed/simple;
	bh=zXNyI3iAu+z2j6kPWQrmOBxju1A1wzpfLBcR+HeK48M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7D40tOIkjgnBXFw5PkaBTX8ESXruSAmuDaHv3ZDKhz5OD1nYS3FT5ngfSJ79bD2L9dZwI7l/MsBatG3UUHIm5v7YSHQhXRKra+1cTrZEzhIMtg46qJBBndle8d08T/Nu37XxX4UsIySxrTQYL/xOFq900wmNptOgKDmlS+nkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGcdqYhQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGcdqYhQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-749248d06faso2022848b3a.2
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836126; x=1752440926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw0+cyixDBek6HKBJK2biFdG5zoip9i4i8poQFGeNyg=;
        b=cGcdqYhQ1FSFDvxFDrAaBIYFZx9KCz4UYId0SYu3iIl6ANAlmDqWg85f5Yfqfiy8iN
         ZyQW8ApZD4UESDrnYHAevTnu3l6WmSQQQMeqZgDdhvtwREgmHk3vMO0REj64XAoGAhpJ
         YwHfm5wOSKIIuk66paa25X+3j14/QiIFOw0QC+LYcXND8GHDgnhJoBFpISTmZrtA7iL9
         DqphMnuhL0KxTnK+xlMO8IZRhtUt7tk+dh3fUR4e3OIN31oWSJ+V7IogUiMpluw7T1qa
         r83zK1auEa4OsEJNugmfnEvdY7RxlX+6I9SWjFq3E/rT9ucVLDYuTdEprAcYjIiJNeMy
         nCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836126; x=1752440926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw0+cyixDBek6HKBJK2biFdG5zoip9i4i8poQFGeNyg=;
        b=atxnROh+Dp6vCKur2gmYSf0mKo2cGIo4wf4uBodp50Y/6PLA8Hy25xCGkQoOdTy+lT
         yBoT6eNuP0MlN8iQCl/bN9ZXfVPDIw3/cuPexTkv/gH3poD8fBN2+RPPf/k4+LCnUdN+
         4sSfzXY7RH1N+3Y/Chx4QPlZ3OLWvbD2FXy9/x4Tw9oB9lZsnDmKjhKg/GSK+RP0lRWJ
         Bqn+GYr6F8s7TJr/QapVVfozFy5JljOt5B6bglXVb/5rD7Iqaj29VVHPNzN9RuM+hDnL
         3m9LOpEIDOMbVSFRdVK5qtEOuCmeKCGl7PU1+u+4sz1eyzNl/qkiAi/sAJtivlzU5gTt
         hquQ==
X-Gm-Message-State: AOJu0YwjRbYKpI8CtUJKTKbwEITNDDg1MJY71LE7xuwVv4mYYZcU2U0J
	XS4EY8pTYGOiOjT+r+sEZnS8hmwi8OnPI/goq4CoHCHjRLUP6fngDgzmihP9QbZvRow=
X-Gm-Gg: ASbGnct3n71vJ5SqcWq+XsQ0d303tYDqnLsHgwHhqVmwanupMSkpaOrMFUbLErzfXWn
	whNhbD5gdcApQPIWcLXH5+RMwHPZt+fZ1lGA4cI95baWL4eOravnFIO5LaxxuwVftD7RnaQd0aR
	2SZjxon45roK1V8OCXtQh9dbK6uVbNIRtexL5iLxP7nSO9AF09doK5pF6MLB2qJEg6sWahe0jlv
	+UDmtZMKlTn31HJcng8iunnRhC6X+VrhAAmO1ksBIDRPIy6OZE6tasXw2HjSaodHzJwq5FoItHC
	uIPrHrGOGJNupGJ406MnC6ewKoIeiCRRsaJKlfgcDN1zS2+A+eLCn9rwfvO8vZvTpK1IxBNkkRy
	XZ/p684IgWyU=
X-Google-Smtp-Source: AGHT+IGPWUuKXuDyiM/eDF6lNPPYXcNPPCz3aRpnIL4pVjyPDShud2DcydP7nX68OVePiejuzM/kgA==
X-Received: by 2002:a05:6300:14d:b0:1f5:8b9b:ab54 with SMTP id adf61e73a8af0-22720cbaf61mr9956594637.23.1751836126170;
        Sun, 06 Jul 2025 14:08:46 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:08:45 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 3/7] t/t1517: move ls-files -h test to t1517
Date: Mon,  7 Jul 2025 02:37:21 +0530
Message-ID: <20250706210725.79903-4-usmanakinyemi202@gmail.com>
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

The test 'ls-files does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t3004-ls-files-basic.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh   | 7 +++++++
 t/t3004-ls-files-basic.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 92ad159b58..e04be2d811 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -128,4 +128,11 @@ test_expect_success 'for-each-ref does not crash with -h' '
 	test_grep "[Uu]sage: git for-each-ref " usage
 '
 
+test_expect_success 'ls-files does not crash with -h' '
+	test_expect_code 129 git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage &&
+	test_expect_code 129 nongit git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage
+'
+
 test_done
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 4034a5a59f..a1078f8701 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -34,13 +34,6 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_grep "[Uu]sage: git ls-files " broken/usage
 '
 
-test_expect_success 'ls-files does not crash with -h' '
-	test_expect_code 129 git ls-files -h >usage &&
-	test_grep "[Uu]sage: git ls-files " usage &&
-	test_expect_code 129 nongit git ls-files -h >usage &&
-	test_grep "[Uu]sage: git ls-files " usage
-'
-
 test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	mkdir subs &&
 	ln -s nosuch link &&
-- 
2.50.0

