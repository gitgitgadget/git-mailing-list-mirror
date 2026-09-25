Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A54F55CB
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369640; cv=none; b=r4w31BDCdUntlGYJVlikPHCuqkz2w6/8+lQ+YhU43myqjO+XhAs7Xddj1tcSu/BHYykIWaKIsn7RZJfaUcx+L2Z894Hjr3cJmZxeSY7xfQ06Pds0VMmj45awhPwVLGx+AhvKoaWDijiOASMqvbpj8GEye12eH8+rF+EIM0w6RGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369640; c=relaxed/simple;
	bh=qPTgysM3ICic66Tz6kFHHb3+NeR2fW5OZgDGpSBoeFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQ18yZPzQDsyM3QZRq8k5LCDDliAynf93HfVFz/azj92F4W+aOohSA1uXP2YYvtSeVzayCidJpBIyfP2kQWFE30v2+z/JyM7SZJGeYwBtWX98Gmi0hWK9cGTIj9OL4Ezbt5rQ3Ef6SK+iYyc1RVt7rHiTNkLqDaiv8jDZ7DZXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmonette.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=layJk5CY; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmonette.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="layJk5CY"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939062ecda9so247108985a.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790369637; x=1790974437; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4/mf5aiJsfzLtEn3eGuWFZouLuCM9lKr9ZZO4rrw1Q=;
        b=layJk5CYpZ6Ov5WYJQExTxgjyICnlrvEDbfFWWS8zd4pHF7Qhoh8IW+b6t2MpVK5/o
         rRTHBd4NMoHlq3FKf66ZwL8A7RZne+KSALeXcaGlgRCn0Vt1Hn5MXLHoY6z30PR7Ca4R
         Sw85uF6JO80a7XyHvz6Y5V/aBC0djeOInfRQXbm+h6KZthBsFkFI9WOpuIO7Cyo0IdVb
         AUHu18dKmX1CsAWNIPLydtz1EVygNcyrodiuk6wZtZYqk/0VVAAy6kAq3mAKDvnBLOeo
         rE8YQH0nVV/I2aTWg7sodmgAPQsNJJoUIdKY5hVxCgVhe9wGmnfVneOUDtC4Jvkpov5K
         s52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369637; x=1790974437;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o4/mf5aiJsfzLtEn3eGuWFZouLuCM9lKr9ZZO4rrw1Q=;
        b=WJ8fbKlovn9fq8yUiXWUL0RaekQMUL8UKdnzuLJpTAUlnt7agIKg0z0+brkCQ7AdaY
         EHyWYi2ZQRGraQNsO227Q/OJdj5PvZfT0iKfG3ROe0DUFp1qRawSaWjiW4+YYTVW2ntm
         SpDZos7cNjP0PezlhojMFce7l9eL3resgxXnnIcxmmuxCNs0VhoJ7TXf7EClfLc0z/Rp
         iNp6toG12GQvnDdE25UAtggZXbYQg8aQx2Lp2Pe2cFXqVurrhpuWYuS4gRYLPRaWttOO
         HBgqf9BRffsoL5tdcKWVeY9H0CWxRHS758jF1KxJtCbdA0EPc3Ip+lMURhPo4EEbzxYN
         nqFg==
X-Gm-Message-State: AFuF++kftF5hdpxVCFBuli2y7yKX8vRiZYUcv5JYrPRsRiH9PUXWk6nr
	zScsRSlYfLL85EtVXi6CZ5+Fsm+tEKtbKgCGXKlE9Bwu283LdyTmRuV1Kt1wBYSsLLyhWAKI/Os
	o7dTz4rhzis/qAM892jw5e8S8Brzfygct9P7VBXIUA6TBwoZwzliq2i3NHYzr6i08HbDRgxRMBy
	IsfLopNJJFkQ3bSi8lYjP9Vv1CwwljJ3pMVNtnyILoMkA=
X-Received: from qknxj8.prod.google.com ([2002:a05:620a:5bc8:b0:93c:41a9:7282])
 (user=pmonette job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4502:b0:93b:d79a:c469 with SMTP id af79cd13be357-93c43e3e7f9mr656074585a.65.1790369636555;
 Fri, 25 Sep 2026 13:53:56 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:53:48 -0400
In-Reply-To: <20260925205348.1210154-1-pmonette@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925205348.1210154-1-pmonette@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925205348.1210154-3-pmonette@google.com>
Subject: [PATCH 2/2] replay: add the -S option
From: Patrick Monette <pmonette@google.com>
To: git@vger.kernel.org
Cc: newren@gmail.com, ps@pks.im, toon@iotcl.com, 
	Patrick Monette <pmonette@google.com>
Content-Type: text/plain; charset="UTF-8"

`git replay` currently doesn't support signing. In fact, there is a
FIXME to address this.

Add the -S option and its related options --gpg-sign and --no-gpg-sign.

Signed-off-by: Patrick Monette <pmonette@google.com>
---
 Documentation/git-replay.adoc |  10 +++-
 builtin/replay.c              |  12 +++-
 replay.c                      |  12 ++--
 replay.h                      |   6 ++
 t/meson.build                 |   1 +
 t/t3651-replay-gpg-sign.sh    | 107 ++++++++++++++++++++++++++++++++++
 6 files changed, 141 insertions(+), 7 deletions(-)
 create mode 100755 t/t3651-replay-gpg-sign.sh

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 58b4c0c470..2e5caba0be 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
-			     [--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>
+			     [--ref=<ref>] [--ref-action=<mode>] [--linearize] [-S[<keyid>]] <revision-range>
 
 DESCRIPTION
 -----------
@@ -106,6 +106,14 @@ behavior of git-rebase(1)'s `--no-rebase-merges` option.)
 `--contained`. To linearize several branches, replay them in separate
 `git replay` invocations.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+--no-gpg-sign::
+	GPG-sign commits. The `keyid` argument is optional and
+	defaults to the committer identity; if specified, it must be
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand a `--gpg-sign` option given earlier on the command line.
+
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
 	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
diff --git a/builtin/replay.c b/builtin/replay.c
index d39626a37d..87c628e2ed 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -85,7 +85,7 @@ int cmd_replay(int argc,
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
-		   "[--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>"),
+		   "[--ref=<ref>] [--ref-action=<mode>] [--linearize] [-S[<keyid>]] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -113,6 +113,16 @@ int cmd_replay(int argc,
 			     PARSE_OPT_NONEG),
 		OPT_BOOL(0, "linearize", &opts.linearize,
 			 N_("drop merge commits, replaying only non-merge commits")),
+		{
+			.type = OPTION_STRING,
+			.short_name = 'S',
+			.long_name = "gpg-sign",
+			.value = &opts.sign_commit,
+			.argh = N_("key-id"),
+			.help = N_("GPG-sign commits"),
+			.flags = PARSE_OPT_OPTARG,
+			.defval = (intptr_t) "",
+		},
 		OPT_END()
 	};
 
diff --git a/replay.c b/replay.c
index ad87863565..9a84e297b1 100644
--- a/replay.c
+++ b/replay.c
@@ -85,13 +85,13 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    enum replay_mode mode,
+				    const char *sign_commit)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
 	char *author = NULL;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
@@ -288,7 +288,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
-					  enum replay_empty_commit_action empty)
+					  enum replay_empty_commit_action empty,
+					  const char *sign_commit)
 {
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 	struct commit *new_commit;
@@ -363,7 +364,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	}
 
 	new_commit = create_commit(repo, result->tree, pickme, replayed_base,
-				   mode);
+				   mode, sign_commit);
 	if (!new_commit)
 		result->clean = -1;
 	return new_commit;
@@ -486,7 +487,8 @@ int replay_revisions(struct rev_info *revs,
 
 			last_commit = pick_regular_commit(revs->repo, commit, base,
 							  &merge_opt, &result,
-							  mode, opts->empty);
+							  mode, opts->empty,
+							  opts->sign_commit);
 		}
 
 		if (!last_commit)
diff --git a/replay.h b/replay.h
index 2c71afbfde..7e93ab9565 100644
--- a/replay.h
+++ b/replay.h
@@ -67,6 +67,12 @@ struct replay_revisions_options {
 	 * Whether to linearize the commits (i.e. drop merge commits).
 	 */
 	int linearize;
+
+	/*
+	 * If non-NULL, GPG-sign the new commits. An empty string signs with
+	 * the default key (the committer identity); otherwise, the key ID.
+	 */
+	const char *sign_commit;
 };
 
 /* This struct is used as an out-parameter by `replay_revisions()`. */
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..93c01e26a2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -426,6 +426,7 @@ integration_tests = [
   't3601-rm-pathspec-file.sh',
   't3602-rm-sparse-checkout.sh',
   't3650-replay-basics.sh',
+  't3651-replay-gpg-sign.sh',
   't3700-add.sh',
   't3701-add-interactive.sh',
   't3702-add-edit.sh',
diff --git a/t/t3651-replay-gpg-sign.sh b/t/t3651-replay-gpg-sign.sh
new file mode 100755
index 0000000000..61a3375b52
--- /dev/null
+++ b/t/t3651-replay-gpg-sign.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='git replay --[no-]gpg-sign'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+if ! test_have_prereq GPG
+then
+	skip_all='skip all git replay --[no-]gpg-sign tests, gpg not available'
+	test_done
+fi
+
+# Checks that "topic" was replayed onto "main", and that the replayed
+# commits are all signed ("signed") or all unsigned ("unsigned").
+check_replayed () {
+	git merge-base --is-ancestor main topic &&
+	git rev-list main..topic >replayed &&
+	test_line_count = 2 replayed &&
+	for commit in $(cat replayed)
+	do
+		case "$1" in
+		signed)
+			git verify-commit $commit || return 1
+			;;
+		unsigned)
+			test_must_fail git verify-commit $commit || return 1
+			;;
+		esac
+	done
+}
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	git switch -c topic A &&
+	echo C >C &&
+	git add C &&
+	git commit -S -m C &&
+	git tag C &&
+	echo D >D &&
+	git add D &&
+	git commit -S -m D &&
+	git tag D &&
+	git switch main
+'
+
+test_expect_success 'replay without --gpg-sign does not sign' '
+	git branch -f topic D &&
+	git verify-commit C &&
+	git verify-commit D &&
+	git replay --onto main A..topic &&
+	check_replayed unsigned
+'
+
+test_expect_success 'replay --gpg-sign signs with the default key' '
+	git branch -f topic D &&
+	git replay --gpg-sign --onto main A..topic &&
+	check_replayed signed &&
+	echo "C O Mitter <committer@example.com>" >expect &&
+	git log -1 --format="%GS" topic >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay -S<keyid> signs with the given key' '
+	git branch -f topic D &&
+	git replay -SB7227189 --onto main A..topic &&
+	git rev-list main..topic >replayed &&
+	test_line_count = 2 replayed &&
+	echo D4BE22311AD3131E5EDA29A461092E85B7227189 >expect &&
+	for commit in $(cat replayed)
+	do
+		git log -1 --format="%GP" $commit >actual &&
+		test_cmp expect actual || return 1
+	done
+'
+
+test_expect_success 'replay --no-gpg-sign countermands --gpg-sign' '
+	git branch -f topic D &&
+	git replay --gpg-sign --no-gpg-sign --onto main A..topic &&
+	check_replayed unsigned
+'
+
+test_expect_success 'replay ignores commit.gpgSign' '
+	git branch -f topic D &&
+	git -c commit.gpgSign=true replay --onto main A..topic &&
+	check_replayed unsigned
+'
+
+test_expect_success 'replay fails and updates no ref when signing fails' '
+	git branch -f topic D &&
+	test_must_fail git replay -Snonexistent-key --onto main A..topic &&
+	test_cmp_rev D topic
+'
+
+test_expect_success 'replay --ref fails and updates no ref when signing fails' '
+	git branch -f topic D &&
+	test_must_fail git replay -Snonexistent-key --onto main \
+		--ref refs/heads/other A..topic &&
+	test_must_fail git rev-parse --verify refs/heads/other &&
+	test_cmp_rev D topic
+'
+
+test_done
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

