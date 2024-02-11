Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A435DF21
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682986; cv=none; b=K4zK5KT8dC57wNX+dPWpltkX573WV7Qp8AaiaE5VI++aiD6eTWug6gc6Hl9AVC+3GGM4t4PVggaUxYpLMViG/Dvt0I+Crk6sMeSBAjU8TnCzPsI45WYmSkTL+xjAuUjAY9fZRncV9rGWdWGZH0+Xdh/GW3pk3i1/g7oKXmJIw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682986; c=relaxed/simple;
	bh=gl4fDVXkes38m2psWlgLdstoIaF94CX+Mhs8TccbIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsMvFN7S1x8QzMfuK6H1qkc/xb7Fj6jqwQUTkPsdiL4T/MbWJIillJ7r9Qva1fFPM/ZszuWGazicNH/fWWUpORXuFd9QwsKW5pqQDTKGQJSbDG5LchBpd/y2jvCB0ugdfSPGIz7yL/1NBWLb2cKWu94SX1WL61VCq2ohTRJAVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFjcdUQo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFjcdUQo"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93f2c3701so12860605ad.3
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 12:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707682984; x=1708287784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiKlbICSqQfpWxT6a1xXmoJ+7L0+0rP1nr+yox91XZY=;
        b=dFjcdUQooR0aJZ0tUUEyl48hN88UnCfoCGCF7qIW240BBhykLhoB4Yef2g/PrLy7gf
         e06rfWGF2uEXGDUKvQrikVdGHMDSutZI1XvBkDI00VxsJmnbOFy5ZKP1uJbwtw1DvWtC
         XkNvhh/f6wPCRxUwxmq7J65vtm/zU8Ecc+A42yN5hs+bTh8eAzWvp2JDKsurTKikC5kG
         lYSC1U+1EBkiQnMCa2XZLQqm4Qz4Aizh0stFoHPG9KJJ0UDiE8cokjPhy+SBv/Wl8YzR
         avdO9KoY1cXr1tXbnUekqWrkX1O//NcxL0QEfLanG023/OgAf8c6tkFYc0MKbar8AzmI
         df9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682984; x=1708287784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiKlbICSqQfpWxT6a1xXmoJ+7L0+0rP1nr+yox91XZY=;
        b=OHLbprcxGsjtFYH0F0adAHg9PQUR0mM6XhQ3/CU3/yrlgFev1gl3cxPP+ON+a5WlA3
         tWZ89s3kPuq987ceGQzX195+r4yy/GXSNs/tKtLUZLqYAAe8Lfsr217qC4aNHUcOZ4Ak
         XUNLV9w9v3N9K+UqLE5F5QYgdhpHFO4u3LrU9gNBO12cOtRvS9uk84wDlHHgAyI5byyW
         o7kQZyM5q1LTxoRxecM8nn1BGXt25c6/9+3N40kKItdKHddi92XLbiZfjoMjMdm1bO7T
         woKQi/dbwUPXHnzTlv6Ffa3TgxhUWjQhabBJGorGBp2FLNXsiU5LsJsyM0tM3F3dpRw7
         tKUQ==
X-Gm-Message-State: AOJu0YyhtvehNPNpl1qkjsw57mi5uJ/XEIi1RSzE8NOTLkCM/qKT2j1G
	nBBtPEPRq4UldfBoV9Mnwlc8d5G6N/tvNZC/6Rj/O+ZwqbWgdqKfa1EauCQA58s=
X-Google-Smtp-Source: AGHT+IEsVhojNfcMQlAr5rIKxrWv0C9/wbg0x0iIpQMITCR3/XW/j/srkes1wzE5HcI8aSHlUpPNNQ==
X-Received: by 2002:a17:902:fc8e:b0:1d9:9c67:58eb with SMTP id mf14-20020a170902fc8e00b001d99c6758ebmr5677786plb.30.1707682983911;
        Sun, 11 Feb 2024 12:23:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqJEtoGMDslxvV60Qlz3PWM301b6+dFcMPc2WO11nKwjH4YLaJnLWPHd2V+UN1BUdzXPnd/rlQwCbqoEdZUHzRlRJMCa6bkxE1E7kdFSR8La/j8/0yvlpWY3Xq/OjcJrPqKN6utO8rs69ATY2hTc8zvnjs+hAWZVAdJmm2cid8NRfmmvj5E3IH
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d9fc826522sm4635470pll.239.2024.02.11.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:23:03 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v5 2/2] add -p tests: remove PERL prerequisites
Date: Mon, 12 Feb 2024 01:50:12 +0530
Message-ID: <20240211202035.7196-5-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206225122.1095766-3-shyamthakkar001@gmail.com>
References: <20240206225122.1095766-3-shyamthakkar001@gmail.com>
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
index 0f597416d8..4e7ad2b0f3 100755
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
 		test_write_lines n y | git reset -p $opt >output &&
 		verify_state dir/foo work head &&
 		verify_saved_state bar &&
@@ -36,28 +36,28 @@ do
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
@@ -69,27 +69,27 @@ test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
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

