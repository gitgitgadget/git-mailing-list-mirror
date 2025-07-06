Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E82BCF4D
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838079; cv=none; b=H1jzXiyVBTiYtammvJAUaG93A38Bzs1aI6O31mg1oASUDUZlpeS20Tt//fxfcB9ovjR43wQRg/Inx17ZCulub9X+325I2Zf8LT0IRjtX06RIfBPO4zFa10udpGbZ7f4SlNl1s3LECePsTq4v0nTDD7TEkhAl901zZTC8//TBj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838079; c=relaxed/simple;
	bh=Wxpfx0SJUKa6J17R3++gOKIZyxEG3mAOZTG+HsmIog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYyFtPCSXUHRdbT0/Jm5BxHLNw8DbnVeabkriVbmJDlq7yXJrNOKY0CIA/KWRbdkEfR7qfBUShEhUc7tbDnZP5o7XrgUxgZKu5I1CVYveR/Ut4Cz9n/ord2DIIJ3PiPMOym/Nx2scpobd8KP+9lL2LBJVri6nhMB9S966o7ls/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UytSiIME; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UytSiIME"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so1665927a12.3
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838077; x=1752442877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJOI6HgiPGraAU45KBdwd4Xa3NlBPbAtWRCajr1UXSc=;
        b=UytSiIMED5+QSVInQkSe+ml5/wKmdjsD+u38nKYUfSLKCZX4La89ep17/Yu1eQLCUk
         v6zxEcIrIT+Ht0eN5K9PL6j8JFyLUFQFQD5ugu1i4Pefz0xUeZoCm8tp2mg9Af2d4ePM
         GSGzKLIB3kAd1SdIn8jSd1n2koHQGdHymzM+bA4FSfJmMXkpy3Ac/JLjfl08Aj+zrlmM
         lXVs/O3kINoHYBbSM8ukaQCNWeZ1i82cJ+Kadwgu8pmNXb3hqyGTr50o/Lw3H5idWgBr
         2g7pKSPkzzphldEh/TVtRIYpXZXDdDEJtae4sRr/SFJzJLzhQHzgM4tYWSNW4rpk1Rqa
         t8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838077; x=1752442877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJOI6HgiPGraAU45KBdwd4Xa3NlBPbAtWRCajr1UXSc=;
        b=rCJxpyLUYcAeSC4EO0rVhFbkLXixtjfMXO5PUuxwFkeC9l90/+wiQVpHoD2QecqBQ8
         6P+7uJGW9Iw1Wd2xOB55t0eFUxgCkRiQxaOljsLv48LSraM0dc1vw1QDtBA+mnf3bwOk
         Plz7FAsKz4F1Z8374bnTp1qrlZgQUhMcIi/MrgOzpGXuOqiR+tSCjj9luU94Jh5pf3fw
         AL/pPROyMvCED0YIiBfMfO61/z6+x2ekegOOBsDMQ72667+NdgO1RWSWh5m0DWOEl3zL
         5FEWmiy17Q9jNRYXXU3WVtvf2YOnaV9HfvVHjpJ5OFPkOpgNv0zRw3b0F/fBaziv+Qaq
         E1Mw==
X-Gm-Message-State: AOJu0YwtSOc5TPQg/7blt3G/XrX5qUIXbrKUW6ryZbfd+2QUcGU1D/Cx
	EjoUglkVAMPIIHSczgYpP3LF77NX2+sG3CtwR6L+ukTpd5CtCLVog362TmcS9wVS1c0=
X-Gm-Gg: ASbGncv7ytLZodnXUoSYwm5ycRnEhrKIKe4/FXvZsyZN9C80R+y8ciZal17Z+3BjwYD
	GIDhunDZxH/0bb3HScvvijGmELkiXRokY6NtLr02Zrouf6YIb8UDAOo9h6bNpdilYyNtboXUv7u
	kbh2Ara7Wmd0RrOGZQyR18guUQWJNfp2ZpTUUaM2QYfnuqCPYq/0UejDHuSwL6qBcDk/q+MjEmh
	1l2uPK1a/gHGUFvuM6Wvr3XHoNvE4mMeebq2DiYPR4oAneqe/ZQAcdBKgJmbYPYlN0u32PShPaQ
	ezzCbBaioqwGYbXlFHdhbbZd/f6usDVYbZzCYfg9GfVTsqh/ZJtTx6ZCMKGYVurlDhWh0nkWXza
	mkJYWD25YFnY=
X-Google-Smtp-Source: AGHT+IFGAgthsKkJ5p6hQ5cBKcectKNJmSzdkho0Zoib84OkS+dssQVTewt0D9u9Y6LPaDjB04empQ==
X-Received: by 2002:a05:6a21:7a43:b0:223:76d2:5a7 with SMTP id adf61e73a8af0-225b948850fmr16724740637.24.1751838077202;
        Sun, 06 Jul 2025 14:41:17 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:16 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 1/7] t/t1517: move checkout-index -h test to t1517
Date: Mon,  7 Jul 2025 03:11:02 +0530
Message-ID: <20250706214108.714499-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'checkout-index does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t2006-checkout-index-basic.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh         | 7 +++++++
 t/t2006-checkout-index-basic.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6824581317..98a453db58 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -114,4 +114,11 @@ test_expect_success 'update-server-info does not crash with -h' '
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
+test_expect_success 'checkout-index does not crash with -h' '
+	test_expect_code 129 git checkout-index -h >usage &&Add commentMore actions
+	test_grep "[Uu]sage: git checkout-index " usage &&
+	test_expect_code 129 nongit git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage
+'
+
 test_done
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index fedd2cc097..bac231b167 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -21,13 +21,6 @@ test_expect_success 'checkout-index -h in broken repository' '
 	test_grep "[Uu]sage" broken/usage
 '
 
-test_expect_success 'checkout-index does not crash with -h' '
-	test_expect_code 129 git checkout-index -h >usage &&
-	test_grep "[Uu]sage: git checkout-index " usage &&
-	test_expect_code 129 nongit git checkout-index -h >usage &&
-	test_grep "[Uu]sage: git checkout-index " usage
-'
-
 test_expect_success 'checkout-index reports errors (cmdline)' '
 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
 	test_grep not.in.the.cache stderr
-- 
2.50.0

