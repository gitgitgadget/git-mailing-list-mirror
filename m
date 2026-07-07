Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61393169AD2
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432541; cv=none; b=KcBL37k0JAjEIRp3R8UZZPUmnFwPzMs9FYj3AaHBoxJQ11ZbZofZiCSldWAkM22UJimgGY/mvRwsZxZIbCh02BAJJbC8/KiWmDsygiZ+NqPhyjtj33vjzd2HrR5TrGVZpkaoRLfqZpanNUi4rc89bsccaN6ElSjWRXIaWp3SgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432541; c=relaxed/simple;
	bh=2RDSYzH16JHWPzhG+r05uJsJ3tzgDyRiOsqNc9V0X2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tThTgA5l5ATmSDGP32WLGqUEze1/JyNPeElCAZCoDtpxvQ85fszeh1WrsE95teWQo9+u3qHvfO0qIKPKp8iEO0nDWUNSGNkryqA1Ahh6oAOeD4M83tLumyQuGZUk+wtNHX2Zg75YAmeVkUPj1li93y6qjRpAG+/E9RXAN0mQ3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUAzDi07; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUAzDi07"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-381191ea2adso1222752a91.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432540; x=1784037340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldz887rB6LDnvECG/EriGdBRKY5zvKZKKlewBrqkIUI=;
        b=CUAzDi070xpTQAYB7Ve14IJhNaCK3VqQ8PZDaT4LG8MI6TQz8Hk62aCWiPrZ3Wv+xv
         iVRWei46U4KyrPKGgJIJZiO2UAYtU73G7gf3Lifh4nj8PW/BO0WHzVXZgSFBMucrkTJy
         j0nAMNrXcVZSdUw226iA7o871tg/kzV4SRIdx9GlkRZcX3r81aCbYjbejwgMTqx9Qlv6
         Z+spz+Q9cukn1tCZMFrDa+MXfHp/WASTi55NkpL3YydxZ4+vyfcCDkqCuEp2yoBUT4my
         bjq3s/m42Y0NHljm2R5vp00W7ow/HASzKecplqMc59LTKOh+NiMyIyoEjsoCoOGvy7Mm
         oAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432540; x=1784037340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldz887rB6LDnvECG/EriGdBRKY5zvKZKKlewBrqkIUI=;
        b=ZG/RvOADeWb/Q1mzFvo8yhbah7ik4SkDBveEEMPnqCWMyY2qRifQ4M6BOXRWN9+oAt
         pWPS/tw8Xa4x7HtZE1S5CGnfNQyEj0hihFGSmRVRXIGyxSjvcmQH/xp/q9oXbPhHgwFe
         i/t63ZFtW46FGcQNCR8/Lnlchtl0bInhCzEpp4iYt4VSYcg1FA82JBPqy5N1EHpyt23F
         KtRxg1G5z6JPMZvF+gqRGVE8g6/aeA/ePwvLPwd8Bv2nENojugs87g0nykHV/dBRcTGe
         yEFSFqTc37iSd5m3A4729Qc4eMI4WnMhJzpv71sZctLZXvdlKpIoMJu6Q7pE/4rxtXN6
         RO4Q==
X-Gm-Message-State: AOJu0Yy33Jj4Y/d0WXelWWqNw1wH4OadN/B0Kd0jyrQI5+YFdafYkByd
	HcGuB0vPe4CHyO8szcnPzxaIPgCqtRxucX2Fl/UJwgv31CMw5khujedzMK+ynTVfP4Q=
X-Gm-Gg: AfdE7ckRgHpD6M1JVPXf9hbcVbw9D2NjJzSOdxLFV9Trgcj+zZbNdOD2B7dCqjyyJGV
	jz0B8SmVvCMI8kgKXG1YvDBueOsdvvdM9sGaAeNAETBEeGaINlNJeiATjt3TKT7enPA7sns0b7B
	0NpdcM2WU8yJxc926w+mJF5ELkh+/+3o/WPwfBo95nX81zxoHgU9hKp7BH71qtIYCreUocVVcOn
	WpRQLayZ7ujMtbXpIeDBmnIW/nIpZvm8tHSKGrOyu5L2TAUSrSMCii+z7ywc2viGYfFNS27D60L
	ATqzZu6gFeeiFRQiSQNfSoghOHx4GR17spEwOlmzLlqfHFq1lnMfbuLSKj3RdMe+ycTMZMS18eV
	mA9AyAKhhgpK7dGRmUFcfefBTWjC7JdrpMmRV3jizwWCk2xCUhnO5e15IYvA8wXxi1oUtGcLkOY
	Rueheyrnfnav8PjenIV+OcNyaRipQ74R2rJn4R4jgWPpMRpB8PACc6XR1A93LffKugnQ==
X-Received: by 2002:a05:6a20:c79b:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c08ed4916fmr6525447637.5.1783432539528;
        Tue, 07 Jul 2026 06:55:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f0:17:596c:8cc6:bfdf:497:d4a7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56d64sm8837214eec.17.2026.07.07.06.55.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 06:55:38 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v2] t1410-reflog.sh: avoid suppressing git's exit code in pipelines
Date: Tue,  7 Jul 2026 19:25:30 +0530
Message-ID: <20260707135530.17389-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqechf8ryu.fsf@gitster.g>
References: <xmqqechf8ryu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piping git commands directly to wc -l suppresses the exit code of
git, hiding potential failures from the test suite. Capture the
output to a temporary file first, then count the lines separately
to preserve the exit code. Where the expected count is known ahead
of time, use test_stdout_line_count instead.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---
 t/t1410-reflog.sh | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..8e018d172b 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -244,26 +244,30 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&
 
-	HEAD_entry_count=$(git reflog | wc -l) &&
-	main_entry_count=$(git reflog show main | wc -l) &&
-
-	test $HEAD_entry_count = 5 &&
-	test $main_entry_count = 5 &&
-
+	test_stdout_line_count = 5 git reflog &&
+	git reflog >reflog_output &&
+	HEAD_entry_count=$(wc -l <reflog_output) &&
+	test_stdout_line_count = 5 git reflog show main &&
+	git reflog show main >reflog_main_output &&
+	main_entry_count=$(wc -l <reflog_main_output) &&
 
 	git reflog delete main@{1} &&
 	git reflog show main > output &&
 	test_line_count = $(($main_entry_count - 1)) output &&
-	test $HEAD_entry_count = $(git reflog | wc -l) &&
+	git reflog >reflog_output &&
+	test $HEAD_entry_count = $(wc -l <reflog_output) &&
 	! grep ox < output &&
 
 	main_entry_count=$(wc -l < output) &&
 
 	git reflog delete HEAD@{1} &&
-	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
-	test $main_entry_count = $(git reflog show main | wc -l) &&
+	git reflog >reflog_output &&
+	test $(($HEAD_entry_count -1)) = $(wc -l <reflog_output) &&
+	git reflog show main >reflog_main_output &&
+	test $main_entry_count = $(wc -l <reflog_main_output) &&
 
-	HEAD_entry_count=$(git reflog | wc -l) &&
+	git reflog >reflog_output &&
+	HEAD_entry_count=$(wc -l <reflog_output) &&
 
 	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
 	git reflog show main > output &&
@@ -319,13 +323,12 @@ test_expect_success 'git reflog expire unknown reference' '
 	test_must_fail git reflog expire does-not-exist 2>stderr &&
 	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
 '
-
 test_expect_success 'checkout should not delete log for packed ref' '
-	test $(git reflog main | wc -l) = 4 &&
+	test_stdout_line_count = 4 git reflog main &&
 	git branch foo &&
 	git pack-refs --all &&
 	git checkout foo &&
-	test $(git reflog main | wc -l) = 4
+	test_stdout_line_count = 4 git reflog main
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
-- 
2.54.0

