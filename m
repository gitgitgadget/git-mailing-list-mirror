Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F2146005
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446093; cv=none; b=tQ3HWtLfL+bUWZ0rxkmdYG5vrFyuN6DdazBAqdmwpjEU/rOT6duuAv/021/pMUFe2nJZIHl/n491IkwntyOpbCjrhY4q1JgmuXdxNRzN/9ox+StbDBNJ6wUqPCSzLmFtAFq/ngW3rvT6LGWgjlxYNBvqT4/IRjm7Ci66zd4BlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446093; c=relaxed/simple;
	bh=ttj4l1X72q09vwRr4GBizah96tWp7Ua6fl6M2SVz//0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7Kc7X4qGeUoIrfY8YpgoAP73gt2R6zs+tXKXYY/Tq/OrAx5/0XuJoVQ+YpTi0p4TQMCiyEJOON4aa7uE6J4dLebPiIpkQjIfIuWrbLYk6kWI2t2pW3rmCHVzstY4yxL9hqJCeWHrhy7MlOm9OHTh0sBo/SFsZZLHoe0zn/dRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcfu3Kpz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcfu3Kpz"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418c2bf2f90so5083965e9.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446086; x=1714050886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSVQvKsZHXk+fZ/19krXJCX2iuhfxUSQ53OG1rer458=;
        b=dcfu3KpzhEQeRwar8VRqFwmYbIF1AfTv1FN3CnXMaz6tuJ2KyLnIFhsSNH0MBu2DuS
         +8J66m+VbuYxP5K+SDWsS8cLlwfbLGMgox5rxNQlRQ/gKEyDHykHO4u2+9SORxJnpi05
         YXoK/YIBRudVRptRJguOnPCXYw2CNr57fUL3Tjv0k6eOOkZQAYWASjHOu9tsQSO1JsE6
         vKMIA6typLrhnJ9WLP7JXtqz+9rUS4t2+HA845//04gNaoSrfWkDfEhFy0s2xkAY/i8d
         XkLoFvTr1bunq1f52UBy/BfI9WLgEZ/aRmfAzqIr10wrEpeiMnFoPbXtmWZLUT9RQw+P
         Zeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446086; x=1714050886;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSVQvKsZHXk+fZ/19krXJCX2iuhfxUSQ53OG1rer458=;
        b=aO6rrzkT5P7Q+NdEqiTsAhwiDc/gjXt8NyCA4Ykjggg82ahwWbWDwlrve5e1oEOHiT
         HjfGM6B0zMTJjGZaKKpbvn3Kiq//bM0ph/N55e4tBO3eBfZl5cZm3QFD8DkHVoOUEgbF
         Hpn7ZVZqTD29+KEGjk4EdJSqLB7yUdDcWA0nf/Jmq7yc9SykRnPYuaj/R1oO8UDMRrPv
         qNvs6h8A4zyKQvPdUdBGJnjwwhci14meF+pU3vqcbk9nlqZNgJW2Udnq1iiC0Uo8UnID
         RF1pWtujGHOlbEoSYoPR+FORlQLeS8z388hajq7yL2YdVQZJ1UfydD9GcxLffZJwGm9V
         zuDw==
X-Gm-Message-State: AOJu0YyZvXBOE4MC0D+Ks7RJqekoIm+Y1+HZR6otF8geQlUjX+QLQe87
	T7gZfGBg7GhJ5M88O0fbiMVfZjQNj95uIUkHlBWxcEmCRsrKn9HKB7Tnuw==
X-Google-Smtp-Source: AGHT+IFEPRPeNcSqcrXuwZZmtUrrxCpOsQDB06vFoMy8lipXkVGEUaGtGBeTGgvxqPPEKp5f/Es1Fg==
X-Received: by 2002:a05:600c:4ec8:b0:418:bdcd:e59b with SMTP id g8-20020a05600c4ec800b00418bdcde59bmr1815217wmq.7.1713446086484;
        Thu, 18 Apr 2024 06:14:46 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm2682748wmo.34.2024.04.18.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:14:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: David Bimmler <david.bimmler@isovalent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 5/5] rebase -m: fix --signoff with conflicts
Date: Thu, 18 Apr 2024 14:14:09 +0100
Message-ID: <4c8f8843780f3ac23262f1e45a5000d183adca6b.1713445918.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.44.0.661.ge68cfcc6c2f
In-Reply-To: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebasing with "--signoff" the commit created by "rebase --continue"
after resolving conflicts or editing a commit fails to add the
"Signed-off-by:" trailer. This happens because the message from the
original commit is reused instead of the one that would have been used
if the sequencer had not stopped for the user interaction. The correct
message is stored in ctx->message and so with a couple of exceptions
this is written to rebase_path_message() when stopping for user
interaction instead. The exceptions are (i) "fixup" and "squash"
commands where the file is written by error_failed_squash() and (ii)
"edit" commands that are fast-forwarded where the original message is
still reused. The latter is safe because "--signoff" will never
fast-forward.

Note this introduces a change in behavior as the message file now
contains conflict comments. This is safe because commit_staged_changes()
passes an explicit cleanup flag when not editing the message and when
the message is being edited it will be cleaned up automatically. This
means user now sees the same message comments in editor with "rebase
--continue" as they would if they ran "git commit" themselves before
continuing the rebase. It also matches the behavior of "git
cherry-pick", "git merge" etc. which all list the files with merge
conflicts.

The tests are extended to check that all commits made after continuing a
rebase have a "Signed-off-by:" trailer. Sadly there are a couple of
leaks in apply.c which I've not been able to track down that mean this
test file is no-longer leak free when testing "git rebase --apply
--signoff" with conflicts.

Reported-by: David Bimmler <david.bimmler@isovalent.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c               | 23 +++++++---
 t/t3428-rebase-signoff.sh | 96 ++++++++++++++++++++++++++++++++-------
 t/t3434-rebase-i18n.sh    |  2 +-
 3 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 31e4d3fdec0..e29a01944be 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3636,13 +3636,24 @@ static int error_with_patch(struct repository *r,
 			    struct replay_opts *opts,
 			    int exit_code, int to_amend)
 {
-	if (commit) {
-		if (make_patch(r, commit, opts))
+	struct replay_ctx *ctx = opts->ctx;
+
+	/*
+	 * Write the commit message to be used by "git rebase
+	 * --continue". If a "fixup" or "squash" command has conflicts
+	 * then we will have already written rebase_path_message() in
+	 * error_failed_squash(). If an "edit" command was
+	 * fast-forwarded then we don't have a message in ctx->message
+	 * and rely on make_patch() to write rebase_path_message()
+	 * instead.
+	 */
+	if (ctx->have_message && !file_exists(rebase_path_message()) &&
+	    write_message(ctx->message.buf, ctx->message.len,
+			  rebase_path_message(), 0))
+		return error(_("could not write commit message file"));
+
+	if (commit && make_patch(r, commit, opts))
 			return -1;
-	} else if (copy_file(rebase_path_message(),
-			     git_path_merge_msg(r), 0666))
-		return error(_("unable to copy '%s' to '%s'"),
-			     git_path_merge_msg(r), rebase_path_message());
 
 	if (to_amend) {
 		if (intend_to_amend())
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 1bebd1ce74a..6f57aed9fac 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -5,12 +5,17 @@ test_description='git rebase --signoff
 This test runs git rebase --signoff and make sure that it works.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
 	git commit --allow-empty -m "Initial empty commit" &&
 	test_commit first file a &&
+	test_commit second file &&
+	git checkout -b conflict-branch first &&
+	test_commit file-2 file-2 &&
+	test_commit conflict file &&
+	test_commit third file &&
 
 	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
 
@@ -28,6 +33,22 @@ test_expect_success 'setup' '
 	Signed-off-by: $ident
 	EOF
 
+	# Expected commit message after conflict resolution for rebase --signoff
+	cat >expected-signed-conflict <<-EOF &&
+	third
+
+	Signed-off-by: $ident
+
+	conflict
+
+	Signed-off-by: $ident
+
+	file-2
+
+	Signed-off-by: $ident
+
+	EOF
+
 	# Expected commit message after rebase without --signoff (or with --no-signoff)
 	cat >expected-unsigned <<-EOF &&
 	first
@@ -39,8 +60,12 @@ test_expect_success 'setup' '
 # We configure an alias to do the rebase --signoff so that
 # on the next subtest we can show that --no-signoff overrides the alias
 test_expect_success 'rebase --apply --signoff adds a sign-off line' '
-	git rbs --apply HEAD^ &&
-	test_commit_message HEAD expected-signed
+	test_must_fail git rbs --apply second third &&
+	git checkout --theirs file &&
+	git add file &&
+	git rebase --continue &&
+	git log --format=%B -n3 >actual &&
+	test_cmp expected-signed-conflict actual
 '
 
 test_expect_success 'rebase --no-signoff does not add a sign-off line' '
@@ -51,28 +76,65 @@ test_expect_success 'rebase --no-signoff does not add a sign-off line' '
 
 test_expect_success 'rebase --exec --signoff adds a sign-off line' '
 	test_when_finished "rm exec" &&
-	git commit --amend -m "first" &&
-	git rebase --exec "touch exec" --signoff HEAD^ &&
+	git rebase --exec "touch exec" --signoff first^ first &&
 	test_path_is_file exec &&
 	test_commit_message HEAD expected-signed
 '
 
 test_expect_success 'rebase --root --signoff adds a sign-off line' '
-	git commit --amend -m "first" &&
+	git checkout first &&
 	git rebase --root --keep-empty --signoff &&
 	test_commit_message HEAD^ expected-initial-signed &&
 	test_commit_message HEAD expected-signed
 '
 
-test_expect_success 'rebase -i --signoff fails' '
-	git commit --amend -m "first" &&
-	git rebase -i --signoff HEAD^ &&
-	test_commit_message HEAD expected-signed
-'
-
-test_expect_success 'rebase -m --signoff fails' '
-	git commit --amend -m "first" &&
-	git rebase -m --signoff HEAD^ &&
-	test_commit_message HEAD expected-signed
-'
+test_expect_success 'rebase -m --signoff adds a sign-off line' '
+	test_must_fail git rebase -m --signoff second third &&
+	git checkout --theirs file &&
+	git add file &&
+	GIT_EDITOR="sed -n /Conflicts:/,/^\\\$/p >actual" \
+		git rebase --continue &&
+	cat >expect <<-\EOF &&
+	# Conflicts:
+	#	file
+
+	EOF
+	test_cmp expect actual &&
+	git log --format=%B -n3 >actual &&
+	test_cmp expected-signed-conflict actual
+'
+
+test_expect_success 'rebase -i --signoff adds a sign-off line when editing commit' '
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 edit 3 edit 2" \
+			git rebase -i --signoff first third
+	) &&
+	echo a >a &&
+	git add a &&
+	test_must_fail git rebase --continue &&
+	git checkout --ours file &&
+	echo b >a &&
+	git add a file &&
+	git rebase --continue &&
+	echo c >a &&
+	git add a &&
+	git log --format=%B -n3 >actual &&
+	cat >expect <<-EOF &&
+	conflict
+
+	Signed-off-by: $ident
+
+	third
+
+	Signed-off-by: $ident
+
+	file-2
+
+	Signed-off-by: $ident
+
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index e6fef696bbc..a4e482d2cd0 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -71,7 +71,7 @@ test_rebase_continue_update_encode () {
 		git config i18n.commitencoding $new &&
 		test_must_fail git rebase -m main &&
 		test -f .git/rebase-merge/message &&
-		git stripspace <.git/rebase-merge/message >two.t &&
+		git stripspace -s <.git/rebase-merge/message >two.t &&
 		git add two.t &&
 		git rebase --continue &&
 		compare_msg $msgfile $old $new &&
-- 
2.44.0.661.ge68cfcc6c2f

