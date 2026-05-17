Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CD3B52E2
	for <git@vger.kernel.org>; Sun, 17 May 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039135; cv=none; b=M3gn6k5eTC5kH7h7ZODJ2kOA+lh0eCoE+3CaAwRfgkO8uQFixK86BfmpygMTlYlcdU7w3lgnwXL4ruioQm1rmkX+HqfSXzzID1W3cPC3XFdJUhVTwMpvaK3j+6q0e1jTEU7EnJknHXlA1mRi0hRTwPevKhuSzDRqtLJdLWo7g2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039135; c=relaxed/simple;
	bh=3CMtQLVR6ihPMiBDJtFe800ZqVXiA6Pj+jMSCF9irko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=G2r+gCh7icFWHwCCrf9JnR18eMj2dZRhAavB300qvKNzNiV1JWKplUPC+MNc/vaHVXD8r2ROS0IcFPGqB2h1dVKzmWY7DeC1eLNje29ti0s7+i71HX3sFX23eQH0pQBcyrHRTSE/fCYFbFcEKlKHRvIROUmWZSkyr5QqO/W8AbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsn2EhUJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsn2EhUJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-452169ae568so865540f8f.3
        for <git@vger.kernel.org>; Sun, 17 May 2026 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779039132; x=1779643932; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1rc9vcBBTHjuGTjxcSIhwvnXao+03TLm9CYHVH6jgo=;
        b=dsn2EhUJ0w+zFVi1gmHJhvjuWR8kRs5nlz7Z4yp3H6r9VBAt29YSqoGObFYghO+ogU
         phyzT4udI/BBEeMujc/SnH3XayQn+uhOuw81knMcBU86VJ1OQiT10Ll3yJoZ4/boSgaN
         49ZbyvqiCSW7Oh/GQFJDUKZgaBI/VgKsKL87rA4N0F0tBWVWlCvBXp5qax8Y7yRnlhIx
         wF9tflqEAbaeAQBLjYDXuKvj6/0OAF/vyEhNaUIlkcZVNjxjGqEgZn4bO/PBK6HQ9dc4
         x3tFFb9SgnuQSV/1Vk10DqmoU/idP/mYa/EfrDyyrM4kKybh9OM2Vm/qe7gnp2J8IT3C
         zAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039132; x=1779643932;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q1rc9vcBBTHjuGTjxcSIhwvnXao+03TLm9CYHVH6jgo=;
        b=F9QTEK4rDp3lefI03ml8TihgCMK6gIYKafEC8RS3ZwW/mZe336/EyjFwKcIk6zbXzz
         bRJN7xj3H1BZo+s8xj+yVUBfdf/CYvIwP4WOgK72S26Zmb7YfB554EfB9kpe/Ol7JquD
         r8psIKTeBqn7HOJ/R6Za0Jkq/3nnsjA+ks8MLoHThzmaxAP/aC9U40LbL8eAW44Kmj3p
         J9CE1WES67E69NrcVMl6p0gkzh8Gs9KFV2J85bQsIeIvTReNe2NPihrTVZqrAnr0cnnE
         nUZUclzPG3x/k7IeEMudhFIM5ytwP4uLcFNpFZfcv99heH3Pb2RPr/NPGxXC4VCP2Dyn
         MfAQ==
X-Gm-Message-State: AOJu0YzcUKhzNjM+X5HrpoJpebATa7B9O9QbYvq7cVtvaKq8fXSB/b5K
	QwxFzs/cd3AE/4qEP+M6E+Gk+tkHnB4lhQiP2ZGUet0y/oeWIIVu05sYKgXftQ==
X-Gm-Gg: Acq92OHAdYjSyCutgFN6TITj+W1decLW7P/fRsv9BDd5SlAJLzWWy3bvLRjBms4CI2a
	uuiIJPlujDOmHUaXEwd+c1wMSkbyUR0rmrF/Wcok5Upd8cEdnvIZl7UFLvKd4ogwzQ7mRNqfzyE
	mXS7CiLSqtxLnr0pdjgxb3p8MNhShTgbLVj5SHw/4GFTiEp/qVWze3u2CGHY9tnkSMyPnbQ/JB5
	DEAGTQoMdQJtW7moO0aw7845Z0U24SxOZamXzBd8X0iLN0qayAGMn6zUtYxW0TbEsxbOv70rnUX
	Z8LI5P1UZDqryKYYEr8jnrYJh12nBJ8O7yZiRG3SrgajXc1YvvVJAb+W3VTftP9mu46Cw8ADcql
	+tcKPNAFsRTa84STcQ1pWENh1xz/6EVzoA9IUBPRpLXha/6w1BvSRE9bdYgaF7uNrcDky6L4EU9
	Si73IfmKioiyetFTGdT3IQob5nJtSnfIr4Yck145HL+SWPTd6n99EO+eQsHGu59kQ=
X-Received: by 2002:a5d:6e59:0:b0:452:c246:ab69 with SMTP id ffacd0b85a97d-45e5c5c8c03mr13764874f8f.13.1779039132273;
        Sun, 17 May 2026 10:32:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:56bf:1509:7310:4202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm32407810f8f.32.2026.05.17.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:32:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 17 May 2026 19:32:05 +0200
Subject: [PATCH v3] refs/files: skip lock files during consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-refs-fsck-skip-lock-files-v3-1-b24dfd673c7e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJT7CWoC/42NzQ6CMBAGX4X0bE1boIgn38N4KHULKz8lLBIN4
 d0teOFkvO0k387MjGBAIHaOZjbAhIS+CxAfImYr05XA8R6YKaG0SJTgAzjijmzNqcaeNz5cDhs
 gbrXLdSGtS+ITC/99mOJrc19vX6Zn8QA7rsJ1USGNfnhv8Umuu386k+SSW5XmKSihTaYvZWuwO
 VrfsrUzqb1J/TKpYMq1yNJMGkhzszcty/IBnD+XHh4BAAA=
X-Change-ID: 20260420-refs-fsck-skip-lock-files-c6f96b1cf438
In-Reply-To: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5041; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3CMtQLVR6ihPMiBDJtFe800ZqVXiA6Pj+jMSCF9irko=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGoJ+5rJ/4mS21eWWddiuM3hiSxJ7zUqTfXqi
 xZNUbCLiJ9R1okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqCfuaAAoJED7VnySO
 Rox/4rwL/2SbwGG5AAmXgMiiBSzAb7Z2Q1g3Hy5CdIa2KCPx482WjYk1axvEWdmac8Gv0ejAwDR
 Zu3Yn/onCL/eeIG0LDcoRb/eypFtNe81fLDjL1Ir+DjqUlTn8pUNDbE+rHOveFmIhU0qWqBXzzO
 nMgYWNu74cQyd0v9CxDjXmbgkT5JIbWZgjjH4ui+vTrX3TmfQFbXf2+1vkn9/2k3T1Nn69qA1mg
 /dfiftGJRURU+biiA8Erd/PwRUX5VCIXlWJgWcZb3kEpN8eQAqjbpwNWcSjahT26KELvPGDo6EQ
 aO8JU5bMO9L/81zrP/fOKBsu8SqTwlmCOD4SABG9ACuawwejnH5wftoCQURoYggLVxBWGZtEk8b
 wm50x8Ovox6ipVFqzK57fQONxL9FNgUV11C4qnVpG/ialgH2fAfz0C1Id2jYiVj+PFow0gLxC8h
 3oPbk5PjyPUnILmhW0EK24imXkQNTYbfmStIrHIYBpishkEjhHGk6TgmXTeqS8KO4cAG4+4uyI5
 tI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Consistency checks in the files reference backend involve two steps:

1. Iterate over all entries within the 'refs/' directory and call
`files_fsck_ref()` on each.
2. Iterate over all root refs via `for_each_root_ref()` and call
`files_fsck_ref()` on each.

`files_fsck_ref()` then runs all fsck checks defined in
`fsck_refs_fn[]`. Step 2 goes through the refs API and only sees valid
refs, but step 1 iterates the directory directly and may also encounter
intermediate '*.lock' files.

Currently, `files_fsck_refs_name()`, one of the functions in
`fsck_refs_fn[]`, filters out lock files itself. The other function,
`files_fsck_refs_content()`, has no such check and would parse the lock
file. Any new function added to `fsck_refs_fn[]` would have the same
problem.

Move the filter up into `files_fsck_refs_dir()`, where the directory
iteration happens. Since step 2 cannot produce lock files, this is the
only site where the filter is needed, and individual checks no longer
have to re-implement it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Fix grammar in the commit message.
- Link to v2: https://patch.msgid.link/20260422-refs-fsck-skip-lock-files-v2-1-9607571ae59a@gmail.com

Changes in v2:
- Modified the commit message to clarify the changes made and reasoning.
- Modify the comment in the code to be more accurate.
- Add another additional test for bare lock files.
- Link to v1: https://patch.msgid.link/20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com
---
 refs/files-backend.c     | 22 +++++++++++-----------
 t/t0602-reffiles-fsck.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3b0c25f84..1504a1e2f3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3864,22 +3864,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refname,
-				const char *path,
+				const char *path UNUSED,
 				int mode UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *filename;
 	int ret = 0;
 
-	filename = basename((char *) path);
-
-	/*
-	 * Ignore the files ending with ".lock" as they may be lock files
-	 * However, do not allow bare ".lock" files.
-	 */
-	if (filename[0] != '.' && ends_with(filename, ".lock"))
-		goto cleanup;
-
 	if (is_root_ref(refname))
 		goto cleanup;
 
@@ -3939,6 +3929,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct dir_iterator *iter;
+	const char *filename;
 	int iter_status;
 	int ret = 0;
 
@@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 			strbuf_addf(&refname, "worktrees/%s/", wt->id);
 		strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
+		filename = basename((char *) iter->path.buf);
+
+		/*
+		 * Ignore the files ending with ".lock" as they may be lock files.
+		 * However, do not skip invalid refnames with '.lock' suffix.
+		 */
+		if (filename[0] != '.' && ends_with(filename, ".lock"))
+			continue;
+
 		if (files_fsck_ref(ref_store, o, refname.buf,
 				   iter->path.buf, iter->st.st_mode) < 0)
 			ret = -1;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 3c1f553b81..13259821a0 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -87,6 +87,47 @@ test_expect_success 'ref name should be checked' '
 	)
 '
 
+test_expect_success 'lock files should be ignored' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		touch .git/refs/heads/branch-1.lock &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		echo "foobar" >.git/refs/heads/branch-2 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2: badRefContent: foobar
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'bare lock files should not be ignored' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		# invalid refname should be reported
+		cp .git/refs/heads/branch-1 .git/refs/heads/.branch-1.lock &&
+		# invalid refname and content should be reported
+		touch .git/refs/heads/.lock &&
+
+		test_must_fail git refs verify 2>err &&
+		test_grep "error: refs/heads/.branch-1.lock: badRefName: invalid refname format" err &&
+		test_grep "error: refs/heads/.lock: badRefName: invalid refname format" err &&
+		test_grep "error: refs/heads/.lock: badRefContent: " err
+	)
+'
+
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&



