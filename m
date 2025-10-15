Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B2258CCC
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537041; cv=none; b=dfXzmBzY2TdnthnbxagkqhoGrDhGEjcdDvHy+753BvzFPPv1o7l3Q2O02Rwma/dSZudju2R502LvboRUkjDJ/3uRB8thTL2sggXJeHFK4lC72jQkPoQoHuPAGHB1MMRdtz8BPtJEhBj3CLPqyziERfGq/Fz7TEGHRR/TuMBb/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537041; c=relaxed/simple;
	bh=Z7QWxldjYzlmQJCwMmQMjH9mlTIj5xOcO7TWXIbRuDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA8DlaF+r6nuMfaRumbnB6ssM9g2cZnIfCw08TIiVmNNToLe5jYGl26vqqHNGD+T5qaYFptMH7e9EaijsaHn/LDZhbFaXZbh125ti5WmrsB/436k1bJCMPyDsTdXQVeQSm6MFfMyA/a18RUsPOmwWVua2gBBo/pCJ0pAK0RRSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO/fstqI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO/fstqI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso898356a12.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537037; x=1761141837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Cs74Sk6o40T3XHzkZaswjcYmOXpTzEqgyH8XiA34y8=;
        b=SO/fstqIWozjVnzSvz3v596j2allHaowYItlzL6SbV0CF8Cjo6x+xC4AhQVDMfxI4N
         IvbhqsXTJzi7tzg+zMv/J0PNOUu2mvFjyzvCB2UyZEK5E+SfNiJ76PXiPN4/1HiczLjZ
         T2WLadYzKsxDq5BerHZJZK7m8Vz9w8IyZid0Ne2+X3COMKoLfoFtiWkhbnTxyhNYErTW
         I9iE12dIFNnFn4qrdyQ3kzHxOF1OwECrb92fpNCzHn4Qdloj7G3cvJ09AdYhwSx4ZdXJ
         aZBVyisQMWcjuHASDGGajaV5NUbnCUx/0gtxIDY6XPSXhI1Q6Da3kLvXfUWaB6vZ6o2z
         Ftmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537037; x=1761141837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Cs74Sk6o40T3XHzkZaswjcYmOXpTzEqgyH8XiA34y8=;
        b=Avf6LPDMc6+dNM4aAaKiVwUPKCPGDFSV64qLkqG7DxgbT5FtZWyPn16uOdb19BsARH
         BGwN8f1Oqv9/6ftmE2sOi+fM2qlaitvWo8Jz6PvmiJORWJJwsgFCTL1Cr8JloQ/l5SrQ
         VLMAC+t5tXwIq5d5cH9hGVLCnugdFl8b0Uyll/OiAcuAfkxGXFF76jHHll/R7dvSf8Sw
         IXQ03FiqQ6nSUp+4t1xVzmP6fek2Rxq5znOVHdhwospQg689NZzX+otHydEk/9QYpX//
         /sBH7dDPYVvR3S1LocLCifpvxgdniaRgw0SvdId5qnqp7fxJj7PlUUmSgGIOCCcrPRoK
         e89w==
X-Gm-Message-State: AOJu0YzKUo+wqoaN5PYo6atPKD1hymqkFFPH3KrP+Ip+d2lIj5gF6EWy
	lU3epZNF9Wt5bJN5P+/gFvQnANIgC7dl5HaagaOxkc1H76tnhVeRyDydmXQxnTUusq/gu5GZ
X-Gm-Gg: ASbGncsWpKGqRYOn45L9Rn8LwBLckmxNgwWZm7LuUFGKFw/pRtz6K9Jyi31F1Hhv59T
	DSzSO4s6KZoTo271qFZX5LWzHcLp0Q1vtUM1tJ/EjRrF5yZdtADu6UQ7ux1swaubtuleHkKj1qE
	K5z34U+qUPdgihiOaeniV7dTfs7y37R2A90F7aVsi4pyk2ydbMJJ7vLVh+7zGM9hQy1Q6bEx9q3
	g5JMJBQAivmX8035/j8KU7ZNmS1QPTu9CtByaR78cXZhmHZ//7C1EjhvGdEanDaTkNUIkNFJCC6
	E4Pk24r2d5n5U2EM7YiksWcic9AmTHjUzQsc0aUdJ4o4f3qu9MBxqCQerx8Bn73FQ7WZTKnx385
	NMkIvZ7YzSd+dpKDrpeKjY/TUpBKidFPQHwx5bB9MkeAVbUrXyiBd7yxWGrxVHsvz1xuN/9Zb6R
	yQWBoh0XDZRdnyM63AwZgHvhQTn8Qtq02f4jFWQcxRYcJO4wnPUbBsDso4AhikiG3UXhWmErEDe
	a0+6dHufSF51jNyU/98pDF/zgqzC5/O6quOwNXGoHrjCrRS237pn6OA297Zak5gmokQEuRNJagZ
	DdpfxUJYiHo=
X-Google-Smtp-Source: AGHT+IH197uLKwcbW8EXoUzW5jbon86teTgj6x3/LbZuyFkI2T8S0tfnHA6ZPLuzgsmOKo0k+EDpiw==
X-Received: by 2002:a05:6402:1ec5:b0:637:ab6d:71c0 with SMTP id 4fb4d7f45d1cf-639d5b5f6b3mr25543670a12.7.1760537037083;
        Wed, 15 Oct 2025 07:03:57 -0700 (PDT)
Received: from localhost.localdomain (185-100-234-112.hosted-by-worldstream.net. [185.100.234.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm13569524a12.37.2025.10.15.07.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:03:56 -0700 (PDT)
From: Solly <solobarine@gmail.com>
To: git@vger.kernel.org
Cc: Solly <solobarine@gmail.com>
Subject: [PATCH v2 1/1] t2401: update path checks using test_path helpers
Date: Wed, 15 Oct 2025 15:03:29 +0100
Message-Id: <20251015140329.13691-2-solobarine@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015140329.13691-1-solobarine@gmail.com>
References: <20251014161446.6135-1-solobarine@gmail.com>
 <20251015140329.13691-1-solobarine@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update old-style shell path checks to use the modern test
helpers 'test_path_is_file' and 'test_path_is_dir' for improved
runtime diagnosis.

Signed-off-by: Solly <solobarine@gmail.com>
---
 t/t2401-worktree-prune.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index fe671d4197..f8f28c76ee 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -24,8 +24,8 @@ test_expect_success 'prune files inside $GIT_DIR/worktrees' '
 Removing worktrees/abc: not a valid directory
 EOF
 	test_cmp expect actual &&
-	! test -f .git/worktrees/abc &&
-	! test -d .git/worktrees
+	test_path_is_missing .git/worktrees/abc &&
+	test_path_is_missing .git/worktrees
 '
 
 test_expect_success 'prune directories without gitdir' '
@@ -36,8 +36,8 @@ Removing worktrees/def: gitdir file does not exist
 EOF
 	git worktree prune --verbose 2>actual &&
 	test_cmp expect actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	test_path_is_missing .git/worktrees/def &&
+	test_path_is_missing .git/worktrees
 '
 
 test_expect_success SANITY 'prune directories with unreadable gitdir' '
@@ -47,8 +47,8 @@ test_expect_success SANITY 'prune directories with unreadable gitdir' '
 	chmod u-r .git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "Removing worktrees/def: unable to read gitdir file" actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	test_path_is_missing .git/worktrees/def &&
+	test_path_is_missing .git/worktrees
 '
 
 test_expect_success 'prune directories with invalid gitdir' '
@@ -57,8 +57,8 @@ test_expect_success 'prune directories with invalid gitdir' '
 	: >.git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "Removing worktrees/def: invalid gitdir file" actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	test_path_is_missing .git/worktrees/def &&
+	test_path_is_missing .git/worktrees
 '
 
 test_expect_success 'prune directories with gitdir pointing to nowhere' '
@@ -67,8 +67,8 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "Removing worktrees/def: gitdir file points to non-existent location" actual &&
-	! test -d .git/worktrees/def &&
-	! test -d .git/worktrees
+	test_path_is_missing .git/worktrees/def &&
+	test_path_is_missing .git/worktrees
 '
 
 test_expect_success 'not prune locked checkout' '
@@ -76,23 +76,23 @@ test_expect_success 'not prune locked checkout' '
 	mkdir -p .git/worktrees/ghi &&
 	: >.git/worktrees/ghi/locked &&
 	git worktree prune &&
-	test -d .git/worktrees/ghi
+	test_path_is_dir .git/worktrees/ghi
 '
 
 test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees &&
 	git worktree add jlm HEAD &&
-	test -d .git/worktrees/jlm &&
+	test_path_is_dir .git/worktrees/jlm &&
 	rm -rf jlm &&
 	git worktree prune --verbose --expire=2.days.ago &&
-	test -d .git/worktrees/jlm
+	test_path_is_dir .git/worktrees/jlm
 '
 
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
 	git worktree add --detach "$PWD/nop" main &&
 	git worktree prune &&
-	test -d .git/worktrees/nop
+	test_path_is_dir .git/worktrees/nop
 '
 
 test_expect_success 'prune duplicate (linked/linked)' '
@@ -103,8 +103,8 @@ test_expect_success 'prune duplicate (linked/linked)' '
 	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
 	git worktree prune --verbose 2>actual &&
 	test_grep "duplicate entry" actual &&
-	test -d .git/worktrees/w1 &&
-	! test -d .git/worktrees/w2
+	test_path_is_dir .git/worktrees/w1 &&
+	test_path_is_missing .git/worktrees/w2
 '
 
 test_expect_success 'prune duplicate (main/linked)' '
@@ -116,7 +116,7 @@ test_expect_success 'prune duplicate (main/linked)' '
 	mv repo wt &&
 	git -C wt worktree prune --verbose 2>actual &&
 	test_grep "duplicate entry" actual &&
-	! test -d .git/worktrees/wt
+	test_path_is_missing .git/worktrees/wt
 '
 
 test_expect_success 'not prune proper worktrees inside linked worktree with relative paths' '
-- 
2.34.1

