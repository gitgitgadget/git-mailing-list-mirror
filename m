Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CA1C68F
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260337; cv=none; b=FFC+0d0XpvPKVraB3AA0DyzXElKorJh1w9SOzFZ1ImSiGpslgGfEw9xWSfjGgmw6x/M07ywhcGv8hQ2A57Ayy7NDxTd4fxAr/0Fdpu5nI7j+Na+Ay+Zjrf+UKJlm7GZIeojvhEej4I9AghDae/CHsyz1nlzEVnufj41GXulgt3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260337; c=relaxed/simple;
	bh=6ec2bdsuTMuroQ4E35vXOtkIaYmz3t7UIlvaNBg/Ljc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+OyVdmObaZw9arIxoJgX+FTtMq4Ff+3vUXlZE3wQQPuyzIrQfC0caVNlNW4LLd6OKy+BRewPYsrPzAMlKK8iCEZPL1ANMsZq/HXag/kQsQzl7PBb9+wTYXt+FJgSwzX2DevC1Qe08bGnlwf4wyQRuii+3SnzKnEZ2j1ghzBrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTBRYiUe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTBRYiUe"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2909978624eso906a91.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 14:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707260335; x=1707865135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNLUdmy/+b5Lm/CfOkIR8ER/NgOrIBatIucmGzVtfHk=;
        b=bTBRYiUe/8n0+Ch66zW4XtlvNFK8mz2YinyHoWjcKPBVxB0G5b37snY+hKUSGQNrSU
         IWko+629TJOtwCgyE7j0CiWTnegVrGtwIcG9bVVTfC6EgN/6aJlKVQyCWkdUgHRVcOCX
         MBBURvPZKmCAawKNu3JwKIOSJrMutYnCUXXEqmvz/8UHS8lAA6APoBMke0ad2pZrrGx7
         EFmmusY8enrAIl3mgTJzUhWRabqA/Wuyb3ovBUYw0eilvhhnCK0Dt4Ngy8cuAbCWng+5
         32/MJBGuRRF2gMRuTPgiEuXTGifZYVjG/8LLWtvvPhaZUoqjt1SjXkbk9+rBuqgMLUz3
         22fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260335; x=1707865135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNLUdmy/+b5Lm/CfOkIR8ER/NgOrIBatIucmGzVtfHk=;
        b=vCFO6/dIpvUTvgp4IQsAfFXhfnZXkwwuJ4zerhYRUZJj6fSgV2F/3p4WTThx0oXHFG
         fDkEY+RRYsQt1YqARDVqQWAocv1wIWho/tboCTx0JUIeuznba6WpisEil+Hn3hAUheIr
         1xK5BiUfNXdBoFi/LZFSo5RwkPoyLuOJ1nyPDwgWMZOeh/Q80dm9z8r4Do3G8GdZXDGE
         y7YwwQ0N1R9WA4yMFxy+B6JwUt33Yt/FFDGDmF66SwWE0dGpwWwG5VUBTp8MtLGYGqmO
         pcvhvE+sHgwKkYjCREOdQ/aAu5kJaJtM1ZqSfJTLoIzFpGMkQ+mGTSxofInudv4yTL3V
         qVpg==
X-Gm-Message-State: AOJu0Ywk6dpKvWOnf1kbVdhURI5TpFU2/pWUeWc5hYh/3heqcm2T+58J
	mEhgZxP/YuL/OW8Zg6e5RmDUnJEPCjq/lWqDRKJ2JKXHcPHxufBblSXlTV1u
X-Google-Smtp-Source: AGHT+IGDUhq4yLBMgzm+kzPfIs5fuz0ULPNfJcxft445O0AKXexqweuhQOVT+lhWSeBFj3cvXjHR0Q==
X-Received: by 2002:a17:90b:ecc:b0:296:65c5:d69b with SMTP id gz12-20020a17090b0ecc00b0029665c5d69bmr1074809pjb.6.1707260334800;
        Tue, 06 Feb 2024 14:58:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR1enmdMu1du34f+MNZqBSvhP/v/wnJOs4rANvxIgdhMPuSvQbl+6+aPbxkvrW/x2ym6bGfm3XvERyhjJa91y6N/vk3p8Xp3HTpXvtKZ1tg8bjaILQECYQLEbzHCCEHMYv8dwrNDn9ojRYHczpk6A=
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090aca1400b00290f9e8b4f9sm46741pjt.46.2024.02.06.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:58:54 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 3/3] add -p tests: remove Perl prerequisite
Date: Wed,  7 Feb 2024 04:20:39 +0530
Message-ID: <20240206225122.1095766-7-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203112619.979239-2-shyamthakkar001@gmail.com>
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
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

Therefore, Perl prerequisite in t2071-restore-patch and
t7105-reset-patch is not necessary.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t2071-restore-patch.sh | 26 +++++++++++++-------------
 t/t7105-reset-patch.sh   | 22 +++++++++++-----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index dbbefc188d..27e85be40a 100755
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
 
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 7147148138..3691b94d1b 100755
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
@@ -19,14 +19,14 @@ test_expect_success PERL 'setup' '
 
 # note: bar sorts before foo, so the first 'n' is always to skip 'bar'
 
-test_expect_success PERL 'saying "n" does nothing' '
+test_expect_success 'saying "n" does nothing' '
 	set_and_save_state dir/foo work work &&
 	test_write_lines n n | git reset -p &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'git reset -p' '
+test_expect_success 'git reset -p' '
 	test_write_lines n y | git reset -p >output &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar &&
@@ -43,28 +43,28 @@ do
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
@@ -76,27 +76,27 @@ test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
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
 
-- 
2.43.0

