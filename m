Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D551FFC48
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838086; cv=none; b=AflxcgsQqQFQPFVfD3Q6YmvkRFj3x9jyLxhpGhofSgdbWBhOmQuw1Ap/3Nr2bTgm78kxEOydtbvIw6ROexPUk6BglWewiOgAq3vjyZHbeing2Mi/hkHTCoTHCrT+E25Z0oRmW6lZbTfw2Xp8V7lSpPQZv5gixeekGZMCMyhAkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838086; c=relaxed/simple;
	bh=zXNyI3iAu+z2j6kPWQrmOBxju1A1wzpfLBcR+HeK48M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyuqgvLYk0t5jlUQxDfOC7BwY/tzIPMpttuNYNJ6fOm2N/nUlxGvB8dwoVfPfFajKuwV3IK7T2u2obAZBv8028k51NU0UE8J6Wq/hd6t+UY9OZcXKHxj7Nxn+u8rZUCha1ZF4Ze6RjWa/qWPFlEOhVjpt77VcipdV7vVrNtg/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyNvBGLu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyNvBGLu"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3061046b3a.2
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838084; x=1752442884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw0+cyixDBek6HKBJK2biFdG5zoip9i4i8poQFGeNyg=;
        b=JyNvBGLuAVAvZzTKqh6xbeIee+QLWpw+YG06XlIpsH930o/HeWxI5/vHBCLijkn5Rc
         FFUiucN+ThBuvUu9FF4rzVuEC/FieMHpesCs2NkPboji16qynZu0JsvZ9uZ0SOknZHmT
         81ZOhxFjDPnviCIOb0m5B0z5kDFb4wHmbSgSyNJ84bXbs9eLgoAUgS3yTb/0YIbzEatO
         VkYPHv0pi+sI/tNpg3XFKyW9kYEvY5sV5abprxf/0o9FyXgWd8wb3ZypopUWuM8p2cPs
         2n+MEnldZurb5J1NWskqtij1t5Ukiy5A+cvt8hnCiaSlGjoNyeDaIHijbX4/kXETkVer
         fxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838084; x=1752442884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw0+cyixDBek6HKBJK2biFdG5zoip9i4i8poQFGeNyg=;
        b=oLYlmSaq5oF9qXa24cLkoD8BO57zSBztUstSezn2S7c2RjwQIAoV8XeX9QVmBpHJiX
         asrMtCIGEEF6chkZWKz+Qw4ifYwIFD3Dhcqr8TxycyVDLhY5GXuErSMMK3rNBN+e2Thl
         s7dB5ZGG5mV02/Ingjaf7OCvB4KWMi1CCPrcM0DJtUKZI95odoTdpAyOFgU1mxuIUAtX
         ORRq4aRDCBIBhwokS0GXmqOdZS9ouZe3pqlBChwPpH/troU0z0LZHwnw+g0LWjAOhhaS
         7kEwyWQ9h8WEf1Layj6KY7VOKQk6fuOh9K2xY3MoGYLCYgAFnTuVtnWdu0/i/SL+KJ3V
         tFDw==
X-Gm-Message-State: AOJu0Yx0bfgZJTjsXTyMt1z4ikzHncSuoMPwGm/Fry5d2QULgJkj4kA+
	OWacw8TxBqshYVTNz3kD07BIQDPCZusfdTSvbndx6ic34vBCMU8azBfJp58R/mqGRSw=
X-Gm-Gg: ASbGncskcY/ajIYIPwdCMa8a7zhKk9BAg/BheNqzOACV5SGD8oxZq1HjfmV0nL3lYD1
	oI/a/mwDdHb+ucty7x6VgFd13fwQIXvRIiV6lhd3cv3625BM6pWKN0mnlSgkT/531Q/pWV/z9wY
	PBcum4H1Y+Dq3htyGj2mW0dx5sR/Vl1K/jtF9QZaQROqKlfs5Lp9AX3AQEX2qAu5j4niKJ38e/7
	F1PwUW7qkc/1NAiNFptUBUwNMIBieHv1hgn4KTImSErZIXQBSaVhtz930iI0tJjJBdEUKIYfbJM
	tebWB5G/vRPuBkIEM3SeDxBtrrjVD3PDLTeMFCUJTOpgq49pbn7han3iPmoQ1R/GvNk81FOQgNB
	NlYdXfIAmXQE=
X-Google-Smtp-Source: AGHT+IFD/tv+voImnBgtQ1UUtvY86ES5ZviDyWYNCZ04z/vxFGIHav+QAGi08PZl+3I574ZLPfhpJg==
X-Received: by 2002:a05:6a00:1411:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-74ce658a5f3mr14720346b3a.1.1751838084069;
        Sun, 06 Jul 2025 14:41:24 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:23 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 3/7] t/t1517: move ls-files -h test to t1517
Date: Mon,  7 Jul 2025 03:11:04 +0530
Message-ID: <20250706214108.714499-4-usmanakinyemi202@gmail.com>
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

