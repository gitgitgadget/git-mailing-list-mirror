Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2391CC14A
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573169; cv=none; b=Z7XhpmvRoFXUAQdTqURY/U58u1clP1M5Mb1k7Em3bvuKl0/0hf+gx0IWHOzP9bL/CBzyzU34+gpIU++wdCcDfgZFdFOfRX7V2wllWgMQasuqfpjeM3f6w9mVcH3cjb+3h5v4dnz9iiy3pIhruwMpUXgHwoiByOd44yHl5Sul33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573169; c=relaxed/simple;
	bh=kGFiLh81dri5rjRJ+C5kmJKqt0Vvrg5uq2et22ssE2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJGXr/VbLwQLk/Vt4oAJAryH1JRNJu9+7Gh2OAkQQ9UsvYL4/Ecb2Db0sj0iyDvbxju0PrJ6dx15YCDUcZtUY4lu8gw7Mtb+RmrX4semAu1JprrexZEAxA/ukc0goxWWoPniSuL7IaAOTIxNznS8hx2tVELSzoKZu00d47A911Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz4AK6wL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz4AK6wL"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so1288163e87.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573165; x=1729177965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQvhMmnV3IetmaaN+wMAw8ZgwV1pzTdc5/nVQGCYV5o=;
        b=kz4AK6wLWnSZShT0bpgZuOvV8g8Xmy8WUVvHDzIk4QlRw9y/oznAZK/MPGIoFh5XtU
         Eidk2m/FurjcSdVSK+4b+w2GtF6HzNDI3GgQmaY5pg5iG8MfM0nwGOEGrBCFMHFZd7hx
         xu4WyJiGQJnTXYvvyUd6X8A91OzNLo0k68qEsY86EgC1gYbRkf2A1AhUo2U0qQv+r//4
         WcST9XBtht8YZl6N2p/XQ8mZW3T7bYedezY8sq8HQ9jOgw+jr2yyAsc+M3ZMQaUsBeID
         JGZukWRR1Dvi1gbnu9npGZ7hr3PgPPUh6HjhRF9VFJNQqWok1jXQiDohWlfnzvx6wszx
         O9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573165; x=1729177965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQvhMmnV3IetmaaN+wMAw8ZgwV1pzTdc5/nVQGCYV5o=;
        b=ZfxwVVm6lWrf5+Luo2s75cNZIZavVkT4H7/l2UgS7MhVbHZJNeaH/stWw26mu4Jd/+
         /ihtv18HWud42yUjQpHx89U7FNJ5ps43lfBG9TX9iMyQxlyq+Bmalaqkc1Pi2kcDkp90
         j0S3XsHMor/0+iG7ksX9sbiwrpJANx0Q9ozLcNwVTdq3kklsXs6VZoybnKL3xD0XTakS
         Qhwl5uDVtui84vgG2DwD5KUkQVzKDpT2jjY8Kwr/F/nDKdKo4LEKN6wNmdvsIR9uEnrb
         Skntvr+Zp3JVaZnozIVhk+sCOhf5KTptZt9cDRYfwyPs0w8DJGRY/w3ChZwv6gZUw++h
         /v0w==
X-Gm-Message-State: AOJu0Yx4bpBdXaHJ6TMkKCiyvHSDR0cNxmC7bLhMuHKorl08yKIC6vjv
	EXs5M2UQkGbo5HUXJjNzrpe3xbJV1IVAQmVvYssmKcEpKwgmPAA7T7MUJusu4Zo=
X-Google-Smtp-Source: AGHT+IE0LsjfNfS/TLuVCOTWmXd3xS68xT0t3bRM+8Q7gsD5CDlmd+viN97ZsXGRaxzQ8Zor1+mrHg==
X-Received: by 2002:a05:6512:3ca9:b0:539:88cd:bf06 with SMTP id 2adb3069b0e04-539c92b1baemr2796003e87.48.1728573165284;
        Thu, 10 Oct 2024 08:12:45 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:44 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 5/7] t/perf: fix typos
Date: Thu, 10 Oct 2024 18:11:23 +0300
Message-ID: <20241010151223.311719-6-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/perf/p7527-builtin-fsmonitor.sh | 2 +-
 t/perf/perf-lib.sh                | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmonitor.sh
index c3f9a4caa4..90164327e8 100755
--- a/t/perf/p7527-builtin-fsmonitor.sh
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -95,7 +95,7 @@ test_expect_success "Setup borrowed repo (fsm+uc)" "
 # time is not useful.
 #
 # Create a temp branch and do all work relative to it so that we don't
-# accidentially alter the real ballast branch.
+# accidentally alter the real ballast branch.
 #
 test_expect_success "Setup borrowed repo (temp ballast branch)" "
 	test_might_fail git -C $REPO checkout $BALLAST_BR &&
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index ab0c763411..8ab6d9c469 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -282,7 +282,7 @@ test_perf_ () {
 #	Run the performance test script specified in perf-test with
 #	optional prerequisite and setup steps.
 # Options:
-#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--prereq prerequisites: Skip the test if prerequisites aren't met
 #	--setup "setup-steps": Run setup steps prior to each measured iteration
 #
 test_perf () {
@@ -309,7 +309,7 @@ test_size_ () {
 #	prerequisites and setup steps. Returns the numeric value
 #	returned by size-test.
 # Options:
-#	--prereq prerequisites: Skip the test if prequisites aren't met
+#	--prereq prerequisites: Skip the test if prerequisites aren't met
 #	--setup "setup-steps": Run setup steps prior to the size measurement
 
 test_size () {
-- 
2.43.0

