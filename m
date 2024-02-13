Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17312572
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782967; cv=none; b=GEuhIi3CZ4Myz7dKqjnEJUpeijW079Fp2UsWhzyt3YnrZ5sNmsaWkt2DhUBjB+vO8VxxO593h7GgHgO6Y0xtcWa5GEycB8Q0mgD6agwxEBGnUvNYLXegmc5JWpba6bmerrD9MjhB2mDFcTzQ6dT3i3DhoMsacBycUzfh9KplKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782967; c=relaxed/simple;
	bh=vmEWZwqAR6sOm+B8zp3Y0oQfehM+znOW3pS+1R3Vux8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ln2fqDzj4PnO+dFL1nXgJfDJxKdETPp6kIvmbiGACkpwbXQ7P3vvcDxATsaM9U3388hDNIRDB2TuqgxTcwYAZZAJhCE1fWbnXJmZYUluFo94wQ4ttwVVf4KdUlggjEgxhhiK8bFjTQvu/LE7iIKm4DrlwfsJy/O2CeKLTJBwFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSAv+xUI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSAv+xUI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29026523507so2702892a91.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707782965; x=1708387765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92pPiw1WD471oxThWoE8guDWMNhJ++6geYQJOTAzC2Y=;
        b=SSAv+xUIcWhhbe4tUZ1VRQo01kizt9GmITE9vnEmjpcIW7JuyfKgVf/943kCtuD8Wq
         Sg8f8XNNMc12Pjyx/CixNfR5KpzTjKOWClEhI+WBWvxjz5QwAltnjtUH3ewd1D94wQx6
         vV07EwnObFR5nEqbvyj6gZfjFmBYS7GnuJGi+HwaRRDutmRpqa3thfbbbIqbkVzfy7GH
         Au5hBj9ALIKTzb07goHHsFh3B/B3fS1DEeoc50FQc0OEIl2Znuhr9wkOvERzmB7lT3ls
         cBFoIv8tdYZx0jOZQJradK66dQ9W4QWGhq60gf+J8Jn0VegQVXLmmt1X8vCeufjMPHU6
         vv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782965; x=1708387765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92pPiw1WD471oxThWoE8guDWMNhJ++6geYQJOTAzC2Y=;
        b=H/vHLjjlursS4iZurv7kXo4tFI2GTZaHklsJb5sfpAT4CC7DbnM8BKPxtAzEJ4ePPo
         q4Mhf7p06cR6acLSXh2VAIcdeI0ZsQbwVxlZGBVdHWDy7q79AGxQ4fdxADIAYE0RCEVD
         TSyWA9/2rV6s/1gW8TNNlctQaWq4wGpxHBq+IjuaEHQsqloUTeLGdIwydAX7rum1iB/c
         z8yzNz1/9HWV8Kzbeo4/jNuwSIHvphkEw7Z2HVFeWmL95tLhwyTe7YwGZ+Mp1CM5Wopm
         ynlFP/sV/v3Z4d1pPTXByMPiq+pfTNkQTJIeA5qbhgz7F6klrWsKh0fZJ+/8nQ+sluog
         DTpA==
X-Gm-Message-State: AOJu0YyrbrgGo6XVrxA+7DdqQMwn7YYK6cdsoolTRq+EheTjKKT5rPw2
	ckb3h3EoFEVe0dPfsMqPrkgsZXKz/ypXRxev+3xFfUfh1CDRHVh3etC0jx0L5NA=
X-Google-Smtp-Source: AGHT+IFqQJohSa+tNLiAZzTAnZP8DZCfPrKXzLcRSEBuLWWgVYSgbm6qYAR1KZYI3u0HOvLMAee8iA==
X-Received: by 2002:a17:90a:bc94:b0:297:cb0:c2e0 with SMTP id x20-20020a17090abc9400b002970cb0c2e0mr5362659pjr.43.1707782964610;
        Mon, 12 Feb 2024 16:09:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZ9Tr9+Z64HtPi4fgqOqy2I+bDmtFWu/iLEDoqwTFToEjur4mSj/4V/m+Hxb3zW74jn1JWwLVrO6IPjfZMNT6cxEg4Vzko6+dsnpnqCglc/u8YeKuEwguLzYaS5MdaYjFOZFRnUJuTFR/oHGRRNcYSnIaayH+Hdr4Z0+U87XiAEBRNOqNP7b9i
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090acb1500b00296b57ac914sm1097980pjt.38.2024.02.12.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:09:24 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v6 2/2] add -p tests: remove PERL prerequisites
Date: Tue, 13 Feb 2024 05:35:30 +0530
Message-ID: <20240213000601.520731-5-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211202035.7196-2-shyamthakkar001@gmail.com>
References: <20240211202035.7196-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Perl version of the add -i/-p commands has been removed since
20b813d (add: remove "add.interactive.useBuiltin" & Perl "git
add--interactive", 2023-02-07)

Therefore, Perl prerequisite in the test scripts which use the patch
mode functionality is not neccessary.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t2024-checkout-dwim.sh       |  2 +-
 t/t2071-restore-patch.sh       | 28 ++++++++++++++--------------
 t/t3904-stash-patch.sh         |  6 ------
 t/t7105-reset-patch.sh         | 22 +++++++++++-----------
 t/t7106-reset-unborn-branch.sh |  2 +-
 t/t7514-commit-patch.sh        |  6 ------
 6 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index a97416ce65..a3b1449ef1 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -113,7 +113,7 @@ test_expect_success 'checkout of branch from multiple remotes fails with advice'
 	test_grep ! "^hint: " stderr
 '
 
-test_expect_success PERL 'checkout -p with multiple remotes does not print advice' '
+test_expect_success 'checkout -p with multiple remotes does not print advice' '
 	git checkout -B main &&
 	test_might_fail git branch -D foo &&
 
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 3dc9184b4a..27e85be40a 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -4,7 +4,7 @@ test_description='git restore --patch'
 
 . ./lib-patch-mode.sh
 
-test_expect_success PERL 'setup' '
+test_expect_success 'setup' '
 	mkdir dir &&
 	echo parent >dir/foo &&
 	echo dummy >bar &&
@@ -16,28 +16,28 @@ test_expect_success PERL 'setup' '
 	save_head
 '
 
-test_expect_success PERL 'restore -p without pathspec is fine' '
+test_expect_success 'restore -p without pathspec is fine' '
 	echo q >cmd &&
 	git restore -p <cmd
 '
 
 # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
 
-test_expect_success PERL 'saying "n" does nothing' '
+test_expect_success 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
 	test_write_lines n n | git restore -p &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
 
-test_expect_success PERL 'git restore -p' '
+test_expect_success 'git restore -p' '
 	set_and_save_state dir/foo work head &&
 	test_write_lines n y | git restore -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'git restore -p with staged changes' '
+test_expect_success 'git restore -p with staged changes' '
 	set_state dir/foo work index &&
 	test_write_lines n y | git restore -p &&
 	verify_saved_state bar &&
@@ -46,7 +46,7 @@ test_expect_success PERL 'git restore -p with staged changes' '
 
 for opt in "HEAD" "@"
 do
-	test_expect_success PERL "git restore -p --source=$opt" '
+	test_expect_success "git restore -p --source=$opt" '
 		set_state dir/foo work index &&
 		# the third n is to get out in case it mistakenly does not apply
 		test_write_lines n y n | git restore -p --source=$opt >output &&
@@ -56,7 +56,7 @@ do
 	'
 done
 
-test_expect_success PERL 'git restore -p --source=HEAD^' '
+test_expect_success 'git restore -p --source=HEAD^' '
 	set_state dir/foo work index &&
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines n y n | git restore -p --source=HEAD^ &&
@@ -64,7 +64,7 @@ test_expect_success PERL 'git restore -p --source=HEAD^' '
 	verify_state dir/foo parent index
 '
 
-test_expect_success PERL 'git restore -p --source=HEAD^...' '
+test_expect_success 'git restore -p --source=HEAD^...' '
 	set_state dir/foo work index &&
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines n y n | git restore -p --source=HEAD^... &&
@@ -72,7 +72,7 @@ test_expect_success PERL 'git restore -p --source=HEAD^...' '
 	verify_state dir/foo parent index
 '
 
-test_expect_success PERL 'git restore -p handles deletion' '
+test_expect_success 'git restore -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
 	test_write_lines n y | git restore -p &&
@@ -85,21 +85,21 @@ test_expect_success PERL 'git restore -p handles deletion' '
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
 # the failure case (and thus get out of the loop).
 
-test_expect_success PERL 'path limiting works: dir' '
+test_expect_success 'path limiting works: dir' '
 	set_state dir/foo work head &&
 	test_write_lines y n | git restore -p dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'path limiting works: -- dir' '
+test_expect_success 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
 	test_write_lines y n | git restore -p -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
+test_expect_success 'path limiting works: HEAD^ -- dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines y n n | git restore -p --source=HEAD^ -- dir &&
@@ -107,7 +107,7 @@ test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 	verify_state dir/foo parent head
 '
 
-test_expect_success PERL 'path limiting works: foo inside dir' '
+test_expect_success 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
 	test_write_lines y n n | (cd dir && git restore -p foo) &&
@@ -115,7 +115,7 @@ test_expect_success PERL 'path limiting works: foo inside dir' '
 	verify_state dir/foo head head
 '
 
-test_expect_success PERL 'none of this moved HEAD' '
+test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index accfe3845c..368fc2a6cc 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -3,12 +3,6 @@
 test_description='stash -p'
 . ./lib-patch-mode.sh
 
-if ! test_have_prereq PERL
-then
-	skip_all='skipping stash -p tests, perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 453872c8ba..f4f3b7a677 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -5,7 +5,7 @@ test_description='git reset --patch'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
-test_expect_success PERL 'setup' '
+test_expect_success 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
@@ -19,7 +19,7 @@ test_expect_success PERL 'setup' '
 
 # note: bar sorts before foo, so the first 'n' is always to skip 'bar'
 
-test_expect_success PERL 'saying "n" does nothing' '
+test_expect_success 'saying "n" does nothing' '
 	set_and_save_state dir/foo work work &&
 	test_write_lines n n | git reset -p &&
 	verify_saved_state dir/foo &&
@@ -28,7 +28,7 @@ test_expect_success PERL 'saying "n" does nothing' '
 
 for opt in "HEAD" "@" ""
 do
-	test_expect_success PERL "git reset -p $opt" '
+	test_expect_success "git reset -p $opt" '
 		set_and_save_state dir/foo work work &&
 		test_write_lines n y | git reset -p $opt >output &&
 		verify_state dir/foo work head &&
@@ -37,28 +37,28 @@ do
 	'
 done
 
-test_expect_success PERL 'git reset -p HEAD^' '
+test_expect_success 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar &&
 	test_grep "Apply" output
 '
 
-test_expect_success PERL 'git reset -p HEAD^^{tree}' '
+test_expect_success 'git reset -p HEAD^^{tree}' '
 	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar &&
 	test_grep "Apply" output
 '
 
-test_expect_success PERL 'git reset -p HEAD^:dir/foo (blob fails)' '
+test_expect_success 'git reset -p HEAD^:dir/foo (blob fails)' '
 	set_and_save_state dir/foo work work &&
 	test_must_fail git reset -p HEAD^:dir/foo &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
+test_expect_success 'git reset -p aaaaaaaa (unknown fails)' '
 	set_and_save_state dir/foo work work &&
 	test_must_fail git reset -p aaaaaaaa &&
 	verify_saved_state dir/foo &&
@@ -70,27 +70,27 @@ test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
 # the failure case (and thus get out of the loop).
 
-test_expect_success PERL 'git reset -p dir' '
+test_expect_success 'git reset -p dir' '
 	set_state dir/foo work work &&
 	test_write_lines y n | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'git reset -p -- foo (inside dir)' '
+test_expect_success 'git reset -p -- foo (inside dir)' '
 	set_state dir/foo work work &&
 	test_write_lines y n | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'git reset -p HEAD^ -- dir' '
+test_expect_success 'git reset -p HEAD^ -- dir' '
 	test_write_lines y n | git reset -p HEAD^ -- dir &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'none of this moved HEAD' '
+test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index d20e5709f9..88d1c8adf4 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -34,7 +34,7 @@ test_expect_success 'reset $file' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL 'reset -p' '
+test_expect_success 'reset -p' '
 	rm .git/index &&
 	git add a &&
 	echo y >yes &&
diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index 998a2103c7..b4de10a5dd 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -3,12 +3,6 @@
 test_description='hunk edit with "commit -p -m"'
 . ./test-lib.sh
 
-if ! test_have_prereq PERL
-then
-	skip_all="skipping '$test_description' tests, perl not available"
-	test_done
-fi
-
 test_expect_success 'setup (initial)' '
 	echo line1 >file &&
 	git add file &&
-- 
2.43.0

