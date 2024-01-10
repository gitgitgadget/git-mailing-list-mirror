Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6F4D107
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghYS3hid"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9cb95ddd1so1952419b3a.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 08:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704904661; x=1705509461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAD8UO/0kPoZiOZi40X2NsRWth7FJsaNFNU+Mu/XsVM=;
        b=ghYS3hid40CszuVDkcjsgDW31/Zo9AqT3g+ysrTnSkgIfHMUJlcErV7xX9Zl9CnqOx
         IvVymm26gIGONjisTIA58KApCmbKEv1yTIdLJ8bVwIeO71FZTmDtcRTF4hEyFY3o+dpO
         MmumiLOFZRuBLoB11Gh9VJiSdz0vvRmPyRLglgsiIPQMoRpTXId+by4iDI8/zTiNjree
         7bYDl1S4hNltnFjiB96H5ZzpV/PDsSfzE5f1BNPL8Z+2K44n0D2FzHs+Jxx/4Ezb+FYu
         qYfZGPciUxFp+u40W8RnqJ6ds8JEKFcLJeEEnMCom+gwHmhYA/awjLIS2pi/BW0MKo/y
         XTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904661; x=1705509461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAD8UO/0kPoZiOZi40X2NsRWth7FJsaNFNU+Mu/XsVM=;
        b=URw3kDgv9E/3OEE4SuIA+2Bf1kHsahSIrqjJ/F/lwFTjPANgXSJdT/FpoUO241IZqd
         Fg4rTtBadkhDUfAaopo0ePYbD14AWEtO9yfaVaoZgxyUjCs5nLXXP9s/82+T1HkBZ+u2
         lfKGmVUhYncy+LJ7Ox6jss6pIyx5ltICVUDzdYNIGrqgxucgX2+qAKFjtyvFmJTytFO2
         pDjhGwOvHb/rT+X0P1Wkkv2L8cfVeze67vm4hOIPbrKlxpNSTBk1fVZLUIAeRsExL1Ta
         xts44Mb+rAEGDzT41NPIC89hcrfQIEatNhJBDDQRbZXOMyGyGrR8Mw5Cfw7p82dpN4CP
         Uv1A==
X-Gm-Message-State: AOJu0Yxb1vejCWQRuvEmWJXkSCiWDLtr5QI0fh3pDX5anWV3capinT8Z
	xn3Hr5AQIRw/suZtpxDMXvX5MzQZEMP5PheWCZ8=
X-Google-Smtp-Source: AGHT+IFdg+6NSq7dRkMMhK4I2YRJo08lBdlshUWbSaMw7NzJRRecvXGS/oJ7oqs45pS01AglPjkmuw==
X-Received: by 2002:a05:6a00:4641:b0:6da:c8b7:d58d with SMTP id kp1-20020a056a00464100b006dac8b7d58dmr1525459pfb.15.1704904660887;
        Wed, 10 Jan 2024 08:37:40 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id fb11-20020a056a002d8b00b006daca8ecb85sm3692310pfb.139.2024.01.10.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:37:40 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 2/2] t7501: add tests for --amend --signoff
Date: Wed, 10 Jan 2024 22:05:20 +0530
Message-ID: <20240110163622.51182-6-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109165304.8027-2-shyamthakkar001@gmail.com>
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for amending the commit to add Signed-off-by trailer. And
also to check if it does not add another trailer if one already exists.

Currently, there are tests for --signoff separately in t7501, however,
they are not tested with --amend.

Therefore, these tests belong with other similar tests of --amend in
t7501-commit-basic-functionality.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index e005175d0b..546d60d7fc 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,8 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# fixme: test the various index usages, test reflog,
-# signoff
+# fixme: test the various index usages, test reflog
 
 test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -430,6 +429,30 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'amend commit to add signoff' '
+
+	test_commit "msg" file content &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	msg
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+
+'
+
+test_expect_success 'amend does not add signoff if it already exists' '
+
+	test_commit --signoff "tenor" file newcontent &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	tenor
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+
+'
+
 test_expect_success 'commit mentions forced date in output' '
 	git commit --amend --date=2010-01-02T03:04:05 >output &&
 	grep "Date: *Sat Jan 2 03:04:05 2010" output
-- 
2.43.0

