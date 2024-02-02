Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C31145B25
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886325; cv=none; b=fijypTwkdwl8f7GYKHnDDJ5U2Gy1mL1kO0zlw+028y2fCzR7xEPhk9i6yTpY0mAlqQW6SJoCswS5argCCtVi9ZhnehSY01xj2CArWDZmmPmpco4wZMmukfH8HtIK7ivI01HWiPL1SPQfH0r+2iBamFGMuMiw0UH77vjT+5/QU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886325; c=relaxed/simple;
	bh=wb229yN0WSlBcH5eQR3QELLZ7SIfhEG51UDD16kC+bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE717Qfsc6KdNcDbB7ixL/KiebqmErz5SkpZsezJrnNqVIOE4JwVPqwQTToQLjv/fXU9jEaLNqYAxmNvnU3ug7opy4jXbRqF6KBs62E1MwW5Pw+xqiHYLZC3s6VjYKuo/IVS7i5T4+rHAbTTdfC/XDF7f4owOhZAn36I//DJfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXQbVUPv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXQbVUPv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso16688695ad.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886323; x=1707491123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqYuzq0vkUmK+XQGvVMb48XeTdAe2e6HVOd1L9X+S+M=;
        b=VXQbVUPvqIBPiS9F4pAFau0R9zgewrygz7Eaj9miUMgdE3W8lF1gsreCt9qXVrTwLb
         F2XA22oeLVvdBE4mmeA9Wod1NhUykZfKs34VHsFijtvEdClMze4+QICc/lihVBS/uWnv
         6qX3BjfNiRVyhC3nWVV3TeF+QXb03PaZgJOiFZwqSDy4vwtjrk87/iKufDQrQSBwmKB+
         fiofqPphMbjPH5r9Ms3B38mXBiwBo1bCuL3DYQyBFwKfDc9t2PqxdMbQpUuMKTP56qrQ
         p1pob4HXNytSzOgP7Ns+KDQuJiE/Pk4qibtk2PSniZa6N/kXHp/QTht/xFrvuRtrG9BA
         ZFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886323; x=1707491123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqYuzq0vkUmK+XQGvVMb48XeTdAe2e6HVOd1L9X+S+M=;
        b=v1RVvr33j3SJv+YYM8QrmX3KDwlAvBEuQpOlojjhKW4TH/kiWYhgSbX5EN1znjNIG8
         ZLCEfUkvQQaqdSw2F427f77cEqwpj3fUzOUcbdw/ig5TadjXjtQ/4/b6NVxXAhIdlW1H
         y2qm2h1XVU8/aZrkfUuHMp7Vl5AyxbZ99gOHqgTyOmVU8cbgbbYx7G6EjGNG3E9MHaos
         QFOub1dgLISxuVBt3zo1XnIzyDWwABqJnfrvRfGOevy/j5Hey5LY7810R0zNXX+w7bdg
         AW7EOpuNSGqyYqCNOSV52vkfXEUNk4Lcx/hgHjXk+mXb1vd3og+xKVNig//CX5b1bgDv
         uPhw==
X-Gm-Message-State: AOJu0YwXQoIdHGeEShvTLjRy4OVwm6D9jT+kjjssyfmB85b+e1Jg9vp8
	wj68D3q52ItwAGp6qosFwzJnVDzXC+h9zSRuajTreyh9m0Vj0c1jeAXV9C5ksZo=
X-Google-Smtp-Source: AGHT+IFojo1CuQus2xebk+bKmI46VQ0e5554L2xja3iXZGt0gbeXqTpIZUYP1UR++MAJJ7uXG9zZug==
X-Received: by 2002:a17:903:1210:b0:1d8:debb:4125 with SMTP id l16-20020a170903121000b001d8debb4125mr2124751plh.38.1706886322561;
        Fri, 02 Feb 2024 07:05:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXR1IRmDLjn3KfqvfnAbcHi5wKrUKBTlWz+uGSWl/vNAZhhaTFv1W7KoZ/fyBcVO7Uxdpu51WiOCEbmi8Vtl47HwOoTvnxixL8Sc4oZMARjq8sfs5A=
Received: from localhost.localdomain ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm1685423pls.206.2024.02.02.07.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:05:22 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 2/2] add-patch: classify '@' as a synonym for 'HEAD'
Date: Fri,  2 Feb 2024 20:33:50 +0530
Message-ID: <20240202150434.11256-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202150434.11256-1-shyamthakkar001@gmail.com>
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240202150434.11256-1-shyamthakkar001@gmail.com>
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
builtin/checkout.c, there is some logic to convert all revs besides
'HEAD' to hex revs due to 'diff-index', which is used in patch mode
machinery, not being able to handle '<a>...<b>' revs. Therefore, in
addition to 'HEAD', do not convert '@' as well, so it can be later
used in assigning patch_mode_(...)_head.

There is one unintended side-effect/behavior change of this, even if
there exists a branch named '@', when providing '@' as a rev-source to
(checkout, reset, restore) commands in patch mode, it will consider it
as HEAD. This is due to the behavior of diff-index. However, naming a
branch '@' is an obvious foot-gun and there are many existing commands
which take '@' for 'HEAD' even if 'refs/heads/@' exists (e.g., 'git log
@', 'git push origin @' etc.). Therefore, this should be fine.

Also, add tests to check the above mentioned synonymity between 'HEAD'
and '@'.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c               | 11 +++++++---
 builtin/checkout.c        | 11 +++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 18 +++++++++------
 t/t7105-reset-patch.sh    | 10 +++++++++
 5 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..6c70a0240c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -378,6 +378,11 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	return 0;
 }
 
+static inline int is_rev_head(const char *rev)
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
+		if (!revision || is_rev_head(revision))
 			s.mode = &patch_mode_reset_head;
 		else
 			s.mode = &patch_mode_reset_nothead;
 	} else if (mode == ADD_P_CHECKOUT) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (is_rev_head(revision))
 			s.mode = &patch_mode_checkout_head;
 		else
 			s.mode = &patch_mode_checkout_nothead;
 	} else if (mode == ADD_P_WORKTREE) {
 		if (!revision)
 			s.mode = &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (is_rev_head(revision))
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

