Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2823A9AD
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767530584; cv=none; b=QcOwndtHC54veWUtcOU9ExJm5ylBfJd955fiF/PR6nk1F/ACmmUl7WPKTFADtaYFjG3z7F3i4SlmPzYO1LzWhPu8vbK4Vyj30VYfeLVYv03Pq3eAhtLdn2cGbJIvc3G6UWjWxearyTgT8FVjgB0/9HteaktvOEIjPBlxZRg/1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767530584; c=relaxed/simple;
	bh=u6VZxMjcBsyt0hBgl+Z4++NxTp0osNM/U0+kSEz+VlE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODeWM6CGqq/RODpzPszz0+pMhUnYL+hdkP/LTniNoL1UAeZih/PJqJDHr4c/jBcyfk7hN9BnR8K92CAtIfkbuXR5PFxe1VUEXF5hzsrNOgZNyrF9yjO0uZRQKJWdy4oKO0IYsoG3E/rq9lixUbfq2scstiy/rbn4XUvhed6TMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kztnDfWY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kztnDfWY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0834769f0so129390085ad.2
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767530580; x=1768135380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Ii2mzs0WiasoFerJAZQIh/ke7ybaA821q2ww/GT+U=;
        b=kztnDfWYrwskv8ItaF1cH2I8rKJHhXed1c9Xh++AsShCMh32YxwifVGevxC0s6D+An
         HisZLV3/1Lzz9FHQKRTTESZBvktAyDPmrPYC2C88ZrVPLbT26HU7s6NuHQoO7jjaH3GA
         nqQl6w1xp6CwWXJxKia1NWzTAvhzihnfpcJHAxtV1iX8icaS2Ml7VQ9IH5SS2mDCjJHo
         mZQQfllUCsZ/RFEWBcbi+Jne/VZtcPdfz9JdHMLWucapRRHkgvhk55RWQmAXZs5pzooz
         UQ2AZUxIZuqySHWZG3px0Ro2nari/SZVqaI0xMJoeLEL2l9Fnxwx4NWzPd3TFyWDyfQj
         7yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767530580; x=1768135380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32Ii2mzs0WiasoFerJAZQIh/ke7ybaA821q2ww/GT+U=;
        b=MlqqUVa/GLE9zHtP7Qph4PTzNupFcYvgovh2ayWkcTYtk8KGOVsVZN76O951RZEfI3
         JnC1Kw0Jn2+hohDUGgjGkwrB9stmQa0ZZHlY2Z3MX/7BjX894Zi6C43qeBd7tYFJ/PZ2
         sa7U9KSja9BhrZ3PhMa+Zy/uIDGkDKyKJPxauk9yHEl9sqGaMwEUaKyuygCzBxFgkM/Y
         0cZfC+oVAysymX5fAMhGwjs/BZB2RDp21XXoS0AMV6Pi8Ixv1j34Qq2bXuw7dsDc22Ix
         s462yqetnL/L2wERVxAHvel7RUrUqnKvQo4X6r+AxI9lUsDwA/3NrBgN5DDBN/mcaLyt
         u8Rg==
X-Gm-Message-State: AOJu0Yyr0IH4Wmx2jv2QSU8fl9WtoNc0dJT+ezY0izTRoLOuwu60qWiq
	ZNevyv/TLqiKN8lJIjZWEHWLqeF5qzyUaObHo7DNn+qpSsDq0kx6HQ93XL/GQA==
X-Gm-Gg: AY/fxX7OuMDl7wi/Qk+bkZvE2bw54kxY5iv5EXU05wzbWVXkzMwlBxnF9cwUidU4vsJ
	83zWWlb8KGO0zfLkfOpvw3FQXkPSBjPRHyVsrelElyAvPePrZJr1RCIaTcs655Pooj17JIcU+i3
	WoaTL+7e0B+Lk/xG/r+1zWrxY8dIHn4/9qlve0sgcSHI19pVQWvvaBEqN+UqOUXLHuAne3Qc6tD
	6Ncqi0S/5a7ZmkBVnBNu3v2STlv+HA/P5GKxwtXjtxw81z3rlalqjaj+NAwznHnXYMPyMk3DNsO
	+yhqXZlYm1n/Ce1bs3LOXzFf7C7w9c3+SZ6OrYp11eT07XWJUfsTA+Q0XgJ2p3uCM7nNnmjf/HZ
	VHKoJSiVY8H+aAUtx6rHUgT4JB92E2iCkvFxkioVefQUhTu/9YP30wdNEehYlT/IIEuyj3C3bBN
	O48ikXdXc57IsE2nVGTRDMEudtUpSjbsYS
X-Google-Smtp-Source: AGHT+IEyRYzMudxeUMlcBGiK7ZKdaiDJwh9SkM5VCCCK9ugxamMFygwNaWwpgglGTBtl723uJfFssA==
X-Received: by 2002:a17:902:f64c:b0:2a0:8be7:e3d0 with SMTP id d9443c01a7336-2a2f22052eemr403899265ad.10.1767530580134;
        Sun, 04 Jan 2026 04:43:00 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb25sm431029155ad.56.2026.01.04.04.42.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:42:59 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH v3] t1300: use test helpers instead of test builtins
Date: Sun,  4 Jan 2026 12:41:53 +0000
Message-ID: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
References: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version updates the commit message to avoid calling `test` a shell
primitive, as suggested.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 t/t1300-config.sh             | 8 ++++----
 t/t2021-checkout-overwrite.sh | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 358d636379..9850fcd5b5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1232,12 +1232,12 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
-	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_symlink myconfig &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index a5c03d5d4a..38c41ae373 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -27,7 +27,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 	git rm --cached a/b &&
 	git commit -m "un-track the file" &&
 	test_must_fail git checkout start &&
-	test -f a/b
+	test_path_is_file a/b
 '
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
@@ -49,7 +49,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 
 test_expect_success SYMLINKS 'the symlink remained' '
 
-	test -h a/b
+	test_path_is_symlink a/b
 '
 
 test_expect_success 'cleanup after previous symlink tests' '
-- 
2.43.0

