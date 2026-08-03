Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CC37BE75
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750651; cv=none; b=LeO7A+wXz4vaaQNK2MKnq+jsJpJsFqpyyz5yfkQ6AAKXg9G3wx4tFEZhNIcuBkdATqJ1ovtpiQOHBCUeNedMnNMwxhLmbEEsmaf8HvYpU2enqsrBsql63E+qJi/a0NZ35D9WLZ9GkTl5CXXqCESbW245jONUApBy0bX8ggOidY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750651; c=relaxed/simple;
	bh=NAbihvyM+dSjwKEQeL4lwOK6h5LiG1S1prbd7P6ctd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feFyE1ATU2oP//dhWdIjJhb2re/yPgvTykkghBYPPomb1mMf1luxqObkktKnMiCkQf/pc0QEe0VQkZkhbgWqwPLsBcwykn9qLzFx+73tPAW9t2V3GrxZr6cv1lLLsGztTVmztOrjxu/da0MBBcoK1rT6QJCIQ/cB+cohERkxA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3IcgAhr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3IcgAhr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso11785195e9.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750648; x=1786355448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCpIyoRY40rTyeOROEoiK0wiOjukxx1cFK9dNYowkno=;
        b=V3IcgAhr7bh0w8H+N4dhaqwBFFoGLWnZ7B741MQNow0dopdaeWtl/RvX09Wi5HVI6k
         VeLk8qFvAhZNZ0lx1QySqD1jgDcwpF0q3GqypWxLlN1bbcky41VyrVeOpSUeTxXRQdZi
         Q67XbXaYSi/VRfWllwXAKDTW3s740oIUI1kK/eiMG6jwju+T1j07OcDP7uCbDLiwEzyp
         2lX0NHIyTR1Ucl3KrfpfQ+iyRrqqetQ12p1GX+XCr/+/k5Fz5ubElFOioFqZ/9QRAlWF
         8SiZgG0NAZJNjRwlIeT5TtZNbQvWrXqodTXZhr4Pk0kR6GVExgh2tmk9wF1tksAVmU6A
         KjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750648; x=1786355448;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCpIyoRY40rTyeOROEoiK0wiOjukxx1cFK9dNYowkno=;
        b=B+IkcFr2g4ZvinbHsk2I+wkKJkqwmZk8P1WF76vz/aORbVZx0wNS99OVttH/C+boIx
         h8fXAPGLeeF6HnAWg7wiDScLQt7qNt55E1aPKXVnnBy5atZKgNRfdN3UG1iLp1Ky+VqC
         Y8Qsuc4DNtHZWAHFnrZpuFfpgPB/XLrAQVO2M1j85xlOALw5QmAVpMVmkzCSzV5gTUyG
         5/f4Pz1YkX+um6ca9O0m1Q8clI1Qhi9U7/oWIXwe59quke3wJUUbX8yNTUHPHYk0TGA/
         S8QrDNhYmixetHHNMZ4zd7Za9NQYO5Wr4jDVN/RzzNBqXso+yb89BspCA22GzgaSmEhH
         TSWg==
X-Gm-Message-State: AOJu0Ywmig8iAZXO1T05v5VjvntxrdubObLeStuULenQVEOFjmo+k7ma
	YmK/HJjrY8RwQBPSz7xn76xW96gzplDk7D3WmTBrDWKw5ckPUKYdaftgAlEMWg==
X-Gm-Gg: AR+sD12vxIaa/7gvPuLLg0/Yl6FTduJ8dwTwA98cWeQhSqttmZcmJdjz2z45kNzIZfC
	HhkRYkkCII1ZfgVpd2W8g/VBAoUlLsStY66wndsA27F5NxVySHSTQtOFLBR7WiFfnPlsZHS1L/V
	3CGUNf2/6XusENkA9XL206wLJlum2tl4BM9qlfwaVAGizaGofCtPKNwbCvgDVTaW1rsdLfARh5w
	QvW5PDhoN8d5CBOISVXVf+pjbRlhVzHVzickUWCKGYDfjMixLopl1Xf4ubhhjdea0NMU4t6VnVg
	3KggEj7RVyml08OEEGbEGuNShlFGM2byBblKGJTI3Jno6tyBq9pqar/FEca1M0fY1QSOr4s5KYb
	tiiQ6EebpFoqHM67IBniylnhuaVQiU2EF9hFKflNJDTFqmBtIMJ7jnjcFkSqMkhzrVY5ZUkwfkm
	MO6JCeWU/uR+yM4nUpqZ6OiBxk3CVf/8mtdSooB7AgxggUqma/45nOlq6MH2QhYzvp
X-Received: by 2002:a05:600c:6989:b0:495:6338:1453 with SMTP id 5b1f17b1804b1-4980c680bd5mr233435605e9.16.1785750648195;
        Mon, 03 Aug 2026 02:50:48 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.7/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:27 +0100
Message-ID: <2ccc83c776ed77a80cc5e0584367540d231311de.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Fix squashing into a merge

If the first commit of the range is a merge then the squashed commit
should also be a merge. Unfortunately, we assume that the first
commit in the range only has a single parent, but do not error out
if that's not the case. This means that fixing up a merge drops the
second and later parents. Correct this by using the list of parents
from the first commit in the range when creating the squashed commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/history.c         | 20 +++++++-------------
 t/t3455-history-squash.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 894da69f31..e21ef31e7e 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1276,14 +1276,13 @@ static int squash_check_subject(struct repository *repo,
 static int resolve_squash_range(struct repository *repo,
 				bool update_branches,
 				int argc, const char **argv,
-				struct commit **base_out,
 				struct commit **oldest_out,
 				struct commit **tip_out,
 				char **message_out)
 {
 	struct rev_info revs;
 	struct subject_data subject_data = SUBJECT_DATA_INIT;
-	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
+	struct commit *commit, *oldest = NULL, *tip = NULL;
 	size_t i;
 	int ret, tip_count = 0;
 	struct ref_filter filter = REF_FILTER_INIT;
@@ -1426,9 +1425,6 @@ static int resolve_squash_range(struct repository *repo,
 				    "untouched."));
 		goto out;
 	}
-	base = oldest->parents->item;
-
-	*base_out = base;
 	*oldest_out = oldest;
 	*tip_out = tip;
 	*message_out = strbuf_detach(&subject_data.squash_message, NULL);
@@ -1466,10 +1462,9 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
-	struct commit *base, *oldest, *tip, *rewritten;
+	struct commit *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
 	char *message_template = NULL;
-	struct commit_list *parents = NULL;
 	struct rev_info revs = { 0 };
 	int ret;
 
@@ -1488,7 +1483,7 @@ static int cmd_history_squash(int argc,
 	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
 
 	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
-				   argc, argv, &base, &oldest, &tip,
+				   argc, argv, &oldest, &tip,
 				   &message_template);
 	if (ret < 0)
 		goto out;
@@ -1497,13 +1492,13 @@ static int cmd_history_squash(int argc,
 	if (ret < 0)
 		goto out;
 
-	base_tree_oid = &repo_get_commit_tree(repo, base)->object.oid;
+	base_tree_oid = &repo_get_commit_tree(repo,
+					oldest->parents->item)->object.oid;
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
-	commit_list_append(base, &parents);
 
 	ret = commit_tree_ext(repo, "squash", oldest, message_template,
-			      parents,
-			      base_tree_oid, tip_tree_oid, &rewritten, flags);
+			      oldest->parents, base_tree_oid, tip_tree_oid,
+			      &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
 		goto out;
@@ -1521,7 +1516,6 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
-	commit_list_free(parents);
 	release_revisions(&revs);
 	free(message_template);
 	return ret;
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 26c4b4e29e..1713d6dcc3 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -347,6 +347,32 @@ test_expect_success 'squash commit uses last "amend!" message' '
 	# amend! message that targets commit that is not in range is rejected
 	test_must_fail git history squash HEAD~3.. 2>err &&
 	test_grep "^error: cannot squash .* target is not being squashed" err
+'
+
+test_expect_success 'squashing fixups into a merge' '
+	test_when_finished \
+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
+		 git branch -D feature" &&
+	git checkout -f start &&
+	test_commit F1 &&
+	git checkout -b feature start &&
+	test_commit F2 &&
+	git merge F1 &&
+	echo fixed >F1.t &&
+	cat >msg <<-EOF &&
+	amend! $(git rev-parse HEAD)
+
+	merge F1 and F2
+
+	reworded
+	EOF
+
+	git commit -a -F msg &&
+	git history squash HEAD^^! HEAD &&
+	test_cmp_rev HEAD^1 F2 &&
+	test_cmp_rev HEAD^2 F1 &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	sed 1,2d msg | test_commit_message HEAD
 '
 
 test_expect_success '--update-refs=head only moves HEAD' '
-- 
2.54.0.200.gfd8d68259e3

