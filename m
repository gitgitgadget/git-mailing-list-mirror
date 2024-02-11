Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B775DF21
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682982; cv=none; b=TZ2PoN4yZZHZIScMY7Y59yLLiLyWIp3Ml5TjXhVwBxXK/PJHbIQOUSmHEdMIUCDdHftQ+QqKVjfPZ8Hnupq56V0zWCLdpHvfJSZVCg/xD0VBH+jloFIX4JW+ySA5skUBXU0RjssQLzMvwm4NUvsLcTwBjpvCQ0FLn92PB7tBUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682982; c=relaxed/simple;
	bh=v+O36jV3M4nSECT2fFBb7aliu9XBnKCfxgrL+06yJWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwdwOmYVygLhqnTOkPX67wf7VWpnW+Cr/csckSU4llwA/R7PHd3+QEUmhcX8Ke+ZwoGYq/lWnUDKS7NmXz5PpTfHhV2R811D14VtgKqLFECaGDLaMXaBgOCQePqJ+CiZBO6naJJOczNWnpbJoBIQkNCGO+592ZpHpc27T7kpAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPD4RSy9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPD4RSy9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d731314e67so15708705ad.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707682980; x=1708287780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbiPYD2vgqal6Q3r1bnnqmBBiCjXaFS5T/jwiCRNAjg=;
        b=mPD4RSy93dSxxDuryTCE+p3NKQbHzLnSZ1s1SG5anoSMkaEh3XR52WOhmvt835FqaO
         LwAgZ+JwSOIPFe3N7dx44FLOAiv9iFgQOywjOSQQatq/ra/vU3u20PnDJquyJGIhugoh
         d1KXbweA4z+z67sD/Fvt1ZCVj7DLBT/w2qzxPu0IyQ6dxdhs4NGdFBXBp3KFxrjQxVZt
         EzHK/9EZ/7hx9Es2JWLIykhtwxKLBorUzXLQA/Tn2bXsoNoDlB8lj8Flnnl8+Y5oZ8jQ
         EyDP6WGBgl5lSH00hVEcrvBxkLaBgVmYmHGM5WfMZU4sUWGLBeZ0NQpl6xOvggErcEWU
         lFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682980; x=1708287780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbiPYD2vgqal6Q3r1bnnqmBBiCjXaFS5T/jwiCRNAjg=;
        b=Qk+6s3x8BuUjPyYTI1f8GIuscHYU1D4KtVuEJ7xDrKby5CFlntHpDZb6OuWgpo/QQV
         bF38XEYMQ44HvWmJehpo0RPgkuZb7a750I1gPuFBrjRsiLf04Y6YdWeyONCUvLU6Xaxc
         77h1wAsuJcd3SqjgGo1XQ/eIs5sX8pyXNZbNhtKtsmvinbUhsHoB5pGkLmDBYda2MxaT
         f5EYEsPbMf+0fif7fvx4M7CI+aFkhe6D76rZKnzRidZ4vTBerKtuJU2djJi6E8mRRqcJ
         /0+yuiEqgeGkibcFKmgIw2wQeKpGYurATcMFaPiaE+O79KSUrr1Wkz7Bbsc3K1giuQHB
         XkaA==
X-Gm-Message-State: AOJu0YzWM9dR5Tjb+Vq/doaXC2fua1IcQWp3gh00zOVplkBRpzOPQD2a
	rwkGZeMlfsfQHE0R+Wif/wRP6f/p88z1RwZfXLD4seu0Ll7hsgFFvNejEnTxAxc=
X-Google-Smtp-Source: AGHT+IGVrjSnayIolP32YasTqTXqAQKvqmee6wQy2xDXyMMUrG3WhDuKha1c0uPSgZnsjPR8l5cuEQ==
X-Received: by 2002:a17:902:650f:b0:1da:204f:c2b0 with SMTP id b15-20020a170902650f00b001da204fc2b0mr3340761plk.8.1707682979961;
        Sun, 11 Feb 2024 12:22:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGnoaTMI95Sfa5MdP7955yxqcGeqQx9f9Pl4sEJnTdnfdLZbUCp7+La2Djw0zN/9EmycnJljQJ6Fk5h4vBQKPIawm2z4iHuwIyOfz02zLUb6f66b9nSQ4nh5Byd67hj3+5ipdLQHMWreDkgpwv5A9jul4pwvjufU93GaLz8PI05X5yVaXFZhco
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d9fc826522sm4635470pll.239.2024.02.11.12.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:22:59 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v5 1/2] add-patch: classify '@' as a synonym for 'HEAD'
Date: Mon, 12 Feb 2024 01:50:11 +0530
Message-ID: <20240211202035.7196-4-shyamthakkar001@gmail.com>
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

Currently, (restore, checkout, reset) commands correctly take '@' as a
synonym for 'HEAD'. However, in patch mode different prompts/messages
are given on command line due to patch mode machinery not considering
'@' to be a synonym for 'HEAD' due to literal string comparison with
the word 'HEAD', and therefore assigning patch_mode_($command)_nothead
and triggering reverse mode (-R in diff-index). The NEEDSWORK comment
suggested comparing commit objects to get around this. However, doing
so would also take a non-checked out branch pointing to the same commit
as HEAD, as HEAD. This would cause confusion to the user.

Therefore, after parsing '@', replace it with 'HEAD' as reasonably
early as possible. This also solves another problem of disparity
between 'git checkout HEAD' and 'git checkout @' (latter detaches at
the HEAD commit and the former does not).

Trade-offs:
- Some of the errors would show the revision argument as 'HEAD' when
  given '@'. This should be fine, as most users who probably use '@'
  would be aware that it is a shortcut for 'HEAD' and most probably
  used to use 'HEAD'. There is also relevant documentation in
  'gitrevisions' manpage about '@' being the shortcut for 'HEAD'. Also,
  the simplicity of the solution far outweighs this cost.

- Consider '@' as a shortcut for 'HEAD' even if 'refs/heads/@' exists
  at a different commit. Naming a branch '@' is an obvious foot-gun and
  many existing commands already take '@' for 'HEAD' even if
  'refs/heads/@' exists at a different commit or does not exist at all
  (e.g. 'git log @', 'git push origin @' etc.). Therefore this is an
  existing assumption and should not be a problem.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c                |  8 -------
 builtin/checkout.c         |  4 +++-
 builtin/reset.c            |  4 +++-
 t/t2016-checkout-patch.sh  | 46 +++++++++++++++++++++-----------------
 t/t2020-checkout-detach.sh | 12 ++++++++++
 t/t2071-restore-patch.sh   | 18 +++++++++------
 t/t7105-reset-patch.sh     | 15 ++++++++-----
 7 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..68f525b35c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		/*
-		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
-		 * compare the commit objects instead so that other ways of
-		 * saying the same thing (such as "@") are also handled
-		 * appropriately.
-		 *
-		 * This applies to the cases below too.
-		 */
 		if (!revision || !strcmp(revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..067c251933 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1224,7 +1224,9 @@ static void setup_new_branch_info_and_source_tree(
 	struct tree **source_tree = &opts->source_tree;
 	struct object_id branch_rev;
 
-	new_branch_info->name = xstrdup(arg);
+	/* treat '@' as a shortcut for 'HEAD' */
+	new_branch_info->name = !strcmp(arg, "@") ? xstrdup("HEAD") :
+						    xstrdup(arg);
 	setup_branch_path(new_branch_info);
 
 	if (!check_refname_format(new_branch_info->path, 0) &&
diff --git a/builtin/reset.c b/builtin/reset.c
index 8390bfe4c4..f0bf29a478 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -281,7 +281,9 @@ static void parse_args(struct pathspec *pathspec,
 			verify_filename(prefix, argv[0], 1);
 		}
 	}
-	*rev_ret = rev;
+
+	/* treat '@' as a shortcut for 'HEAD' */
+	*rev_ret = !strcmp("@", rev) ? "HEAD" : rev;
 
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
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
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8202ef8c74..bce284c297 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -45,6 +45,18 @@ test_expect_success 'checkout branch does not detach' '
 	check_not_detached
 '
 
+for opt in "HEAD" "@"
+do
+	test_expect_success "checkout $opt no-op/don't detach" '
+		reset &&
+		cat .git/HEAD >expect &&
+		git checkout $opt &&
+		cat .git/HEAD >actual &&
+		check_not_detached &&
+		test_cmp expect actual
+	'
+done
+
 test_expect_success 'checkout tag detaches' '
 	reset &&
 	git checkout tag &&
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
index 05079c7246..0f597416d8 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -26,12 +26,15 @@ test_expect_success PERL 'saying "n" does nothing' '
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'git reset -p' '
-	test_write_lines n y | git reset -p >output &&
-	verify_state dir/foo work head &&
-	verify_saved_state bar &&
-	test_grep "Unstage" output
-'
+for opt in "HEAD" "@" ""
+do
+	test_expect_success PERL "git reset -p $opt" '
+		test_write_lines n y | git reset -p $opt >output &&
+		verify_state dir/foo work head &&
+		verify_saved_state bar &&
+		test_grep "Unstage" output
+	'
+done
 
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
-- 
2.43.0

