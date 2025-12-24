Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213F199920
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619691; cv=none; b=dSWK5wkhvdTnDvUTao2BxETEh1N8N1qG/Crx+nnLW1fiUzfgSZ7DV2r4wwU8mCiMndLad16k/Swp/xvKvEhOCwPnvKwUPGeFGk0h01DRiVCxybhVymCwmlOP8l3T85ul9XV6Y78ZiMOAWR/jXqv611iGCRFuMZOe1qwMKnxlALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619691; c=relaxed/simple;
	bh=AjcIJguNRDGwbcKor1Nun026sfv+tB7ADGL0TVgjTCo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZP8k+GKFGGcINBHTOJdX4dD6KFJbukUi0y5lV5RCqXm6/dxD1XmAUttLI7ZbyQwJ43wjK7Du01G91bhmjoDDhkhD/HkbeIFxkLFt16huZ4JgOjouqaEFFZJWYr+09uPw2kaWZJ0+zU/iRDgfc9cOA66lgNxZad1vbRKz6NFDxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVgx3A+k; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVgx3A+k"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ec756de0so637612885a.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619688; x=1767224488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V9dXP1fRmJd6WfKY67avG2LEnisbGdMa//eiMhVOTQ=;
        b=lVgx3A+kVAiS9P3qOokuqDa5AWG9t/u64VMhUXnRPsI/LBKnn8993+EgivM1q6F8SM
         4y0VchyZhIr9ikFPsz6h11ssw+UWpQj/D6O/LC+V1I78J8GThUN/sBxkX4CLMVaUNj7F
         HmY7XyUrVt7nWEqPiPZjk9wsUzlLrWSm0ot7Etn7jjHeCLADZN4zTuzWX/Qk/kiAgAbP
         flqVMAGU44YA94h4jT/SDp02N8jYRmQAVhhy5q35KDtFhyWeD05oqdvxXFk4kWC8epFe
         2QcnRLBh75bvVsVyQw0eZqG3zzZojKU9m23R/fDUwZwzWdUkXHYSRKFr/cm7SJLOSZ9w
         EFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619688; x=1767224488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9V9dXP1fRmJd6WfKY67avG2LEnisbGdMa//eiMhVOTQ=;
        b=hwIiMwtFuAOLC2irS8Jmukw6pd7xjCiqi2xo2vlbLz3CrXRA/cZ5prev8dg8XC77cU
         myzFUen9ZRtJKdMBbi4/3yRsRJR6UpKTsO5mXLdbxrAT+bZwP+/tQ7v3jHvLIpBA+PgL
         nLK1GmXMjDNsibCqOSOmjRfvjXyXULNeotgWlYBvNWZV0ih2reAkAIV6TQtdZU/0f4RN
         ZCeOJMr/WKsfVZ4Apk4sqcZX5ljLEcZ/syy2bQYvNNWkygCPNkueXb2Bx23hFQMUjFzZ
         WfnKH51BP2g6s64hYHDIkhiXU/LhbfYf5dKtdBvrjRgeNDTHUAdLxaYARJDimU7nus1S
         PPHg==
X-Gm-Message-State: AOJu0YyBLLfsbfDgknuP88zy8EC3zqtHwXxbO8T/yhsgi/cMDzIks/lN
	Ujus9wXf4HZf7siDwKzIaCNpcVU3QjVT826nvccTC6n1Idm8eHTP8RX5Svbtfg==
X-Gm-Gg: AY/fxX71lRepYV6usPD2tEFsy+LuHFzxAz95hdAG/ylmyFvx+CHO6Gup2E9ihJ9cc9p
	zJibjb2Wg/3VqDTimX/GkgE0GVEcwhzd9/YbhoV9cuyw0UE5QcO6xJYwmUvZ/rBZxUEJR0pHWcY
	CY1IsAu8fQso0RJvc3vKhqfBoajOFm27onlIWm2zX7wKSqD2LHp18ZM6GBnxQO+hjLMk1W0X4O2
	8Sx1Y+Tj+xoEpxxNyQ0wsmQ/QZ3By+pPLt2+sBRhLJQC4FWarzJIwb9wh1/gR+1T0UxI987xTkG
	Sca4nWsL8l6M6+OotF064aL3dg1Z4O2Slo/+iryqfbjDoJTPEtjc3zkQZ4/uTORIRPFP+EJ7irM
	gHt0WeaAJWN67d1impB7hHwn50G5oUWB21LijyNYM41g9IBvLjXCrseu9CpyieAjjYjJQw4sROF
	nDpIbWrM5vfK1GoPwZHNsOOgGw
X-Google-Smtp-Source: AGHT+IFLuPlHpPB9kfJDEw6OJdpRGEByL+lPMj9ULGjpBpwlq5v1EL4c1VzAETjrDQfadlnJ0WBdqA==
X-Received: by 2002:a05:620a:7106:b0:8a3:f8c2:5ee4 with SMTP id af79cd13be357-8c08f6814cfmr2989321685a.37.1766619687936;
        Wed, 24 Dec 2025 15:41:27 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm1375010285a.29.2025.12.24.15.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:27 -0800 (PST)
Message-Id: <441678939f30ba6cc07e7e8d4a41c72d0fd7427f.1766619672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:11 +0000
Subject: [PATCH v6 5/6] Add warning for malformed statusGoalBranch config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Warn when repo.settings.statusGoalBranch has invalid format
and skip the goal branch comparison. Also update test to
compare full checkout output instead of grepping.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/t6040-tracking-info.sh | 49 +++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 00dadc03e7..598dd89483 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -310,7 +310,7 @@ test_expect_success 'status shows ahead of both tracked branch and origin/main'
 		cd test &&
 		git checkout work >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work
@@ -318,6 +318,8 @@ Your branch is ahead of '\''origin/feature'\'' by 2 commits.
   (use "git push" to publish your local commits)
 
 Ahead of '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -327,11 +329,13 @@ test_expect_success 'checkout shows ahead of both tracked branch and origin/main
 		cd test &&
 		git checkout main >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git checkout work 2>&1 | grep -E "(Switched|Your branch|Ahead of)" | head -3
+		git checkout work 2>&1
 	) >actual &&
 	cat >expect <<-\EOF &&
 Switched to branch '\''work'\''
 Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
 Ahead of '\''origin/main'\'' by 3 commits.
 EOF
 	test_cmp expect actual
@@ -367,7 +371,7 @@ test_expect_success 'status shows ahead of tracked and diverged from origin/main
 		cd test &&
 		git checkout work2 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work2
@@ -375,6 +379,8 @@ Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
   (use "git push" to publish your local commits)
 
 Diverged from '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -397,7 +403,7 @@ test_expect_success 'status shows diverged from tracked and behind origin/main'
 		cd test &&
 		git checkout work2b >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -6
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work2b
@@ -406,6 +412,8 @@ and have 1 and 1 different commits each, respectively.
   (use "git pull" if you want to integrate the remote branch with yours)
 
 Behind '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -430,7 +438,7 @@ test_expect_success 'status shows behind tracked and ahead of origin/main' '
 		cd test &&
 		git checkout work3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work3
@@ -438,6 +446,8 @@ Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forw
   (use "git pull" to update your local branch)
 
 Ahead of '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -456,7 +466,7 @@ test_expect_success 'status prefers upstream remote over origin for comparison'
 		cd test &&
 		git checkout work >/dev/null &&
 		git config repo.settings.statusGoalBranch upstream/main &&
-		git status --long -b | head -5
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work
@@ -464,6 +474,8 @@ Your branch is ahead of '\''origin/feature'\'' by 2 commits.
   (use "git push" to publish your local commits)
 
 Diverged from '\''upstream/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -484,13 +496,15 @@ test_expect_success 'status shows up to date with tracked but diverged from defa
 		cd test &&
 		git checkout synced_feature >/dev/null &&
 		git config repo.settings.statusGoalBranch upstream/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''upstream/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -512,13 +526,15 @@ test_expect_success 'status shows up to date with tracked but diverged from orig
 		cd test &&
 		git checkout synced_feature2 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature2
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -536,13 +552,15 @@ test_expect_success 'status shows up to date with tracked but shows default bran
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -552,12 +570,13 @@ test_expect_success 'status with repo.settings.statusGoalBranch unset shows no d
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config --unset repo.settings.statusGoalBranch 2>/dev/null || true &&
-		git status --long -b | head -3
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -567,13 +586,15 @@ test_expect_success 'status with repo.settings.statusGoalBranch set uses configu
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/main &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
 Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -583,13 +604,14 @@ test_expect_success 'status with repo.settings.statusGoalBranch set to different
 		cd test &&
 		git checkout work >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/feature &&
-		git status --long -b | head -4
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch work
 Your branch is ahead of '\''origin/feature'\'' by 2 commits.
   (use "git push" to publish your local commits)
 
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
@@ -599,12 +621,13 @@ test_expect_success 'status with repo.settings.statusGoalBranch set to non-exist
 		cd test &&
 		git checkout synced_feature3 >/dev/null &&
 		git config repo.settings.statusGoalBranch origin/nonexistent &&
-		git status --long -b | head -3
+		git status --long -b
 	) >actual &&
 	cat >expect <<-\EOF &&
 On branch synced_feature3
 Your branch is up to date with '\''origin/feature'\''.
 
+nothing to commit, working tree clean
 EOF
 	test_cmp expect actual
 '
-- 
gitgitgadget

