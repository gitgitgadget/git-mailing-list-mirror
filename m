Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAA2E36EB
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754186882; cv=none; b=JbwWhSXm6t9PuFfKJ7daFTtehbkiOFVez4/bhfZmx0cJSi71naliP36R94Ml90aS4b0dFMv9TLjjnovogR7Oqfl2QT+3K/zx6SEPmMgHOyxdFuDZKmK3CVAUkrD01BCFyyCjGzB+tPEGui1MIoQNUKAOi4De+/E0MTSMUyqyKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754186882; c=relaxed/simple;
	bh=+yAH69ZIVDoKxXEKJWgz3fhWv3yXkTNhUAhXLctVnIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWhK5Xe7eG7VTo9dpk6g2SJ7MC1gA+evad6CIwcBdS12qEImdJKUvM4b966qzohmAgb50ZZ/cQE1lMjhzeRNnnZ7Kz6mmFHJqJ2gtbeE1V71F03t0alGHRtF3FG4q4TF8xYXGLyQj/Zpc6grurMQBgHbtxy4GYbJqB1Tuddd5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6mmOGey; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6mmOGey"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so2362903a12.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 19:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754186880; x=1754791680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U14jUZdhne3ROsFbLbAz2oA+yLNeEuPayA4YtT/Rh9o=;
        b=T6mmOGeybeBLvD4wNFobZIKijSP7w+RnSDcTKnbBxEu0ocAeRyC7vO6wbCz/1f9O4i
         01jYMi+y+MyvvfkEVrn+Ol+N1YhpqK+KnUAOZS03IyiwZ7BrfdSkEwBCe5KxwJFLwGBz
         o//S1PsXSPtCos37gL7WRqvRL3nCa9cywS6M87uyk5xcS1KJXlveqcebIp2bpmvg6wX3
         de0WpUMajwOYirA9jErQpK8KlIS+WMXMKX78IopmkH0OVHjdzinG/57Al9CtO19SPAvq
         fhmro4wbqdQDtFMZ0dFNTUUz9sh5euIVxpoPFKPbhwPieUfR0UcLuD0JoddWiuKrCd3x
         MOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754186880; x=1754791680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U14jUZdhne3ROsFbLbAz2oA+yLNeEuPayA4YtT/Rh9o=;
        b=nUjMJq+SLu52PiF43d2MnuqOtD0vac4CLNYRGNah9txb4qgp0L+l/9cxs4psw88oLe
         65IBvfNYua46BU5aRVXP2rxv3NHFEPSfEGCoRM8Kz6OOhK9XbtfkMEt+/n/NUqfuLNDv
         9ozmt516Zkg9mFOLw/hH9uFIff0i0CfdM6R6kViHixZ25XYY8Bolk6j83NJrhLCjdgSC
         eZYXs7NnbK03VCMh6lyQqAE8OtYVrssjDc1mXdJlG0hHqpRYwYvLZrWLQdMbCMi0Z98w
         W21eGGRjEHuLuQbcfZ7PiNej48aUPe9GD3lRcP5O47DCohRKqzEzsLMac8u6MftUuPSy
         2E3w==
X-Forwarded-Encrypted: i=1; AJvYcCUPXD0yRIlfXpY6YawWrFO3I1qWUpO6bTTXWgbQN282Zw7I//XFgXwaYmhbdVGsWa3GZ14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAe6n2N2f/QgZVlqsEm0Tc7PFzpPSHc0q+Wbpp1ccTdVonR0P
	lHagCfYmhCXz8cbdZuYfcHwPpfG5qK8bCRzO+sfMzS6n784IgKsEH3YJ
X-Gm-Gg: ASbGnctUN94omVNmcqIOCHmlV+u4YtNDPpyXXBEI1nEtmgKAyn+cbJyajHmxOKQXgEV
	XJqmo7IriQsdWMh+KDwXXc4p2yCn5Ha0aEKALt46DC5FrBptmxQeFhxJ/VkXj4OOkpBLaojnp7R
	J/ihSoVZFsWo17hj774RR6rpT9Drc03w/2PkUWDMkYu0sbWnGBQ+8Wv52TOgHMpC7BBjGqT0Gsc
	gn+nkn5/wkvT9Y8a5pFQzR4wNO6kSuaLFCoSsYn0OUZcXwoLzTlmQFCe6hnr6O1g8pEPpsr7S4g
	Tf7Rfoq+4a08Z5pegHBDAK8CaCsyd2lOkf6Ex4X6xTiTFkw1QxW9O0f9qjP2Wd1sX83JG7S9oct
	wY+jUjeyBHi7V9t9fwhOLNN0hUHAT/5VEdxzPsKf6H08leFb7IAI=
X-Google-Smtp-Source: AGHT+IHn8XPVPcl5fwmQjvXcx15CZSPLKkltddY4BFXE6SDYVPIzc74dS3DgAVTonZLwo1lC8046SA==
X-Received: by 2002:a17:90b:2e44:b0:31f:32f:3a87 with SMTP id 98e67ed59e1d1-321162b7660mr7193841a91.26.1754186880393;
        Sat, 02 Aug 2025 19:08:00 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f530sm6466535a12.1.2025.08.02.19.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:08:00 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: ben.knoble@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH V5 3/3] t5304: move `prune -h` test from t1517
Date: Sun,  3 Aug 2025 07:37:44 +0530
Message-ID: <20250803020744.1037392-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t1517 is now focused on testing subcommands outside a repository.
Move the in-repo `-h` test for `prune` to t5304, which covers
this command.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 -------
 t/t5304-prune.sh        | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 3623272db3..8a417af47a 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,13 +107,6 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
-test_expect_success 'prune does not crash with -h' '
-	test_expect_code 129 git prune -h >usage &&
-	test_grep "[Uu]sage: git prune " usage &&
-	test_expect_code 129 nongit git prune -h >usage &&
-	test_grep "[Uu]sage: git prune " usage
-'
-
 for cmd in $(git --list-cmds=main)
 do
 	cmd=${cmd%.*} # strip .sh, .perl, etc.
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 1f1f664871..2be7cd30de 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -364,4 +364,9 @@ test_expect_success 'gc.recentObjectsHook' '
 	git cat-file -p $BLOB
 '
 
+test_expect_success 'prune does not crash with -h' '
+	test_expect_code 129 git prune -h >usage &&
+	test_grep "[Uu]sage: git prune " usage
+'
+
 test_done
-- 
2.50.1

