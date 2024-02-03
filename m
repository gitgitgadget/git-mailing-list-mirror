Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F15C8F8
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706962113; cv=none; b=NISugDRvEhLWWvn5evH06CxkBFizjPwOiAijKaO75ziVfcdXUi4mLba60Ijg12Bn5PuWbEGHFiVlTbyf0xyNS3KiDbfEwarbo74hqB/BE19V3lpDMYzDhIkdgeV4ttV28aaFqeXrmUZkdQAgSAjo2vr6woO2Y1cjfXtuz5UrFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706962113; c=relaxed/simple;
	bh=XW0SyDsjOiAX/xlimpr1812AdLsOVEcSkMbWSBxgVf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc/vYzJxBjZpJjuZcuUHLZ7t2eFHi9K0oBzHXjVQk3Jn0nvQw1EYudRX6dMK0kcgSRsZah+ab9/lR84n4seOKWn9Q9Jh9J5WI74iV9mkYcDHSxl8x0UDaaYzq1sHLmy76YXk2BnZdI7Sd0wcw6ip2XpXDbVetVZbQO1llxIk7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYHO58sd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYHO58sd"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so2487572a91.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706962111; x=1707566911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx2UhZ+sHPWMqfPWmo3ZfKLety3Rb14mMjiHxquNO7w=;
        b=MYHO58sdFLckZSiVxGv8DLMhWrMSQEOXcjapuHylog4M2EyIROBwUD2UjqSA18VuqH
         DiLTG1lHpb2MJCZ9GJypcaQ6/K3LJJ0/w8g8vPJ8A/Jitkcz8FaXedHpMcR/6YyXvAZn
         glyZX6ZbM2vByXFjamDOkbZ5dH0D85D9MCVylQRZC4NioeoBb2JWQvCpK8n+OhO/8Hmz
         ZFnSlDyS/ZY8KsxI9crDmVqsoaz9ng6ai0YGwhU8qoZJXDIQcZThCI0YPXO8pfO692E1
         0sIacapqdNEbMv/KW2O3JwakL0zU5v+gs7luqKs2tnklilX85lcP/MYc+vMQv/KtIiiD
         GZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706962111; x=1707566911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx2UhZ+sHPWMqfPWmo3ZfKLety3Rb14mMjiHxquNO7w=;
        b=TcvFuxGHKNtUvKTgn0gpGj+jL8kSoFyPunH28Uor/GcpCok9956FKUcZDosc1YsZAv
         XektYB5rB3/yfEN/N8Ta5h2qk1Ix7kzATyvoMNyOuv/qFMZF5QtF31wtYmC2vnxY3pxL
         +nu2XGjNQH+9ihb4VhV/INsnzYOOqTMpqtRL6p2alerFEiqlagflJN5a5v6MozPITy7P
         zmpA1ReW76QcN0P6xsKdjfzObrTcWUoorfekN2XKb8Dq9Y1LMlQ3Eg1eArMPtTzPVHlK
         o8gXUuTAdFqz+cr4ZqVUUI19BYpYsX/CUr1/HgKqMeFzWOGDrgOZfq6fcnEfwNchdn1U
         htbw==
X-Gm-Message-State: AOJu0YwbYl2LMTX8CZZJJIEHOrA67GTTalsCCVSAxxnnorH3JXpep7lF
	Z/2EiyTfChL6O+4t2lUlJfN7JYCl+S0Z/oopUQv0o9Lv3o17UZTpNxu0rvZZ
X-Google-Smtp-Source: AGHT+IH3zAKADkhj+msitygYbL/5GCcdrm+iMj5u70DTZ07VB2kg8SXMDib1AkFI/n9UMD59d+8cSg==
X-Received: by 2002:a17:90a:7563:b0:296:3480:c785 with SMTP id q90-20020a17090a756300b002963480c785mr4703863pjk.35.1706962110599;
        Sat, 03 Feb 2024 04:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVYYEknCoCTx0VFnL3kP56yUa562lUsM/Taiml8983Cf9dZlXY+JWLcXP7BkvhFsZoUhpHnZ+MvNqNPUtj6jwrnuP7F54fSzXdTIBPPrucpKO+W80k=
Received: from localhost.localdomain ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id x63-20020a17090a6c4500b00295fb7e7b87sm1876065pjj.27.2024.02.03.04.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 04:08:30 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 2/2] add-patch: classify '@' as a synonym for 'HEAD'
Date: Sat,  3 Feb 2024 16:55:50 +0530
Message-ID: <20240203112619.979239-6-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202150434.11256-1-shyamthakkar001@gmail.com>
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, (checkout, reset, restore) commands correctly take '@' as a
synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@' and
'HEAD', different prompts/messages are given by the commands mentioned
above. This is due to the literal and only string comparison with the word
'HEAD' in run_add_p(). Synonymity between '@' and 'HEAD' is obviously
desired, especially since '@' already resolves to 'HEAD'.

Therefore, make a new function user_meant_head() which takes the
revision string and compares it to 'HEAD' as well as '@'. However, in
builtin/checkout.c, there is a logic to convert all command line input
rev to the raw object name for underlying machinery (e.g., diff-index)
that does not recognize the <a>...<b> notation, but we'd need to leave
'HEAD' intact.  Now we need to teach that '@' is a synonym to 'HEAD'
 to that code and leave '@' intact, too.

There is one unintended side-effect/behavior change of this, even if
there exists a branch named '@', when providing '@' as a rev-source to
(checkout, reset, restore) commands in patch mode, it will consider it
as HEAD. This is due to the behavior of diff-index. However, naming a
branch '@' is an obvious foot-gun and there are many existing commands
which take '@' for 'HEAD' even if 'refs/heads/@' exists (e.g., 'git log
@', 'git push origin @' etc.). Therefore, this should be fine.

Also, add tests to check the above mentioned synonymity between 'HEAD'
and '@'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c               | 11 +++++++---
 builtin/checkout.c        | 11 +++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 18 +++++++++------
 t/t7105-reset-patch.sh    | 10 +++++++++
 5 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..7d565dcb33 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -378,6 +378,11 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	return 0;
 }
 
+static inline int user_meant_head(const char *rev)
+{
+	return !strcmp(rev, "HEAD") || !strcmp(rev, "@");
+}
+
 static int is_octal(const char *p, size_t len)
 {
 	if (!len)
@@ -1729,21 +1734,21 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		if (!revision || !strcmp(revision, "HEAD"))
+		if (!revision || user_meant_head(revision))
 			s.mode = &patch_mode_reset_head;
 		else
 			s.mode = &patch_mode_reset_nothead;
 	} else if (mode == ADD_P_CHECKOUT) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (user_meant_head(revision))
 			s.mode = &patch_mode_checkout_head;
 		else
 			s.mode = &patch_mode_checkout_nothead;
 	} else if (mode == ADD_P_WORKTREE) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (user_meant_head(revision))
 			s.mode = &patch_mode_worktree_head;
 		else
 			s.mode = &patch_mode_worktree_nothead;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..79e208ee6d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -539,12 +539,13 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * recognized by diff-index), we will always replace the name
 		 * with the hex of the commit (whether it's in `...` form or
 		 * not) for the run_add_interactive() machinery to work
-		 * properly. However, there is special logic for the HEAD case
-		 * so we mustn't replace that.  Also, when we were given a
-		 * tree-object, new_branch_info->commit would be NULL, but we
-		 * do not have to do any replacement, either.
+		 * properly. However, there is special logic for the 'HEAD' and
+		 * '@' case so we mustn't replace that.  Also, when we were
+		 * given a tree-object, new_branch_info->commit would be NULL,
+		 * but we do not have to do any replacement, either.
 		 */
-		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
+		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
+		    strcmp(rev, "@"))
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 747eb5563e..c4f9bf09aa 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -38,26 +38,32 @@ test_expect_success 'git checkout -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
-	set_and_save_state dir/foo work head &&
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_saved_state dir/foo
-'
-
-test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
-	test_write_lines n y y | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
-
-test_expect_success 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success "git checkout -p $opt with NO staged changes: abort" '
+		set_and_save_state dir/foo work head &&
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_saved_state dir/foo &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with NO staged changes: apply" '
+		test_write_lines n y y | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with change already staged" '
+		set_state dir/foo index index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success 'git checkout -p HEAD^...' '
 	# the third n is to get out in case it mistakenly does not apply
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index b5c5c0ff7e..3dc9184b4a 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -44,13 +44,17 @@ test_expect_success PERL 'git restore -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success PERL 'git restore -p --source=HEAD' '
-	set_state dir/foo work index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git restore -p --source=HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head index
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success PERL "git restore -p --source=$opt" '
+		set_state dir/foo work index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git restore -p --source=$opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head index &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success PERL 'git restore -p --source=HEAD^' '
 	set_state dir/foo work index &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 05079c7246..ec7f16dfb6 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -33,6 +33,16 @@ test_expect_success PERL 'git reset -p' '
 	test_grep "Unstage" output
 '
 
+for opt in "HEAD" "@"
+do
+	test_expect_success PERL "git reset -p $opt" '
+		test_write_lines n y | git reset -p $opt >output &&
+		verify_state dir/foo work head &&
+		verify_saved_state bar &&
+		test_grep "Unstage" output
+	'
+done
+
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
-- 
2.43.0

