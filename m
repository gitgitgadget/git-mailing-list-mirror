Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA450E594
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803560; cv=none; b=QyrROfPmkSsiIBuDnSktTyC6LsqOGT2wRsx5/1JDpnPI2Bk7S/t7ThT5OuCcO51A4aIrAGqOCfOd1ZT8hl7qjJfNXGvUe96DqTmbSCnXjhoRwtBzUg+efqza4Yfhus3If08I21k+BUlqVQyPRXY3xLh/NcWlq4ItmuVXOgnlukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803560; c=relaxed/simple;
	bh=7b8JmMGhGnLottcnx8qrcFByFo8cx/vxt2aDbWoDyhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWBf54XUL5FTBL4vNFeq4nnA1ADl5A2nVDcHhOcBf0RD4DN45YhFv/polsFOD20RPhU3fwsNzPe/I1uy0AGUxq8R129AT/hDG26HKvBU9F6pjeWFPA7KzFzdM/Bkd5w+nC7lMrdCFK0ECSs5eiYz47nqt9HPba4WbKHWoutCagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO1biZao; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO1biZao"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-66f7a9afe43so5068166d50.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803553; x=1791408353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAEk4mcv0uBWcKkgKU8m0zivsQP8Zq2cyLcpfwfPnlY=;
        b=hO1biZao9pkSzt01TubYJbNDEyrHK8iR55lFYq6HJa/dwiMxA1iUMlWwz3I3WQyuXR
         G1ig/hnA5BJaCho5E1T2lkJECP0yZMzOVV/SgL2NS7VDnNOBhZbULmTq9UtpWkwJDegD
         0NsUZwUH/eZWM399qWHPXJFc39q8ZgME+GBBb7g1adJWz8B9VOOXcl4V1IIOR03cJgUn
         kR7b2reNNxBT1H/ICVTyIB7S/4qZAP/TrtBBKK6PrFjOeVeWsmNz5tbYotePJhjSKAMa
         uZOqRbepSjBvWCt3amolrgqJpNU17g0YEilZAnn3rGb+UqDzShgwuKii40RiHFt2RB0T
         GolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803553; x=1791408353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAEk4mcv0uBWcKkgKU8m0zivsQP8Zq2cyLcpfwfPnlY=;
        b=MCY+RP8qkkKF1KRgaskcTsibw2dZVKMjrgJGm80v8317iD0zJLFZSv3aYFiORAENQ7
         Tik6eUs6e0iX5kv8DoDBlTB95BxxB+O7tYtA/nfMYjlkQxn+cNoVVoGeuSooQ0JRIGNJ
         TDT0cYgRKH85qVZM7VnX5kgbqxYdOqY/LQNMN+bmNIPo1KEvoa+LoD01AEGX1toD43as
         /DskYP00gQIPWVcbHWR8v/4Wf80FzV4OpcrRATUlqOUtgg8hA/cAxoqX76bAC7irNi2a
         Szst2oa+xuLESvmjdnHcK4afjzCPPsRxplZYqzyySILBH2JjZQKph3mGytuXcm2BE7NW
         GnGw==
X-Gm-Message-State: AFq9FYIn1T7QbtRM2Hyot+t6ESq++wZeYyVhTaQzPdg5uSwDC4CLvmo5
	D1fOCo4a0ReWcq8NAeiGYCWM57xlLGVP7uAfwjbdo3nXqmEfyAs5Uu79KBZeh7j5
X-Gm-Gg: AYBFou1bJUMidfz2yuZ7otiBwjNDkF54Hsr2XEKUEkr3TKKxxNQEEz3Lyn2qehT0vg+
	CLD2kL0eeV6CioERY3cYkCaH/AvNT2Cwl+Va218qc9EdE8KLWl6cnRcW/5fR2pVYaHjUxByceIL
	SfEkCXrP9Vx8mYuVA6HIdoTIrx/d9U9fbS3AaqEkPaYZx6R4wpJ8TBzDMm5iP7LTLGFZEHbyMY7
	Np/O9lfbnq+qsiGPJiMwezxlDCF4hG/yMJP2UBEtdlyOAXcrh5Sa3FTWJ7uZmOZn5VxuYhH43bL
	fnefXvrZFrB4tjmRnUTxQHAlKh1LiB9dDfD07EpMXlOLyiqGCKdlkH69fK1GRe81ZYmEjzHqV7v
	z2NrHSgVPfxh0Y17/yXLqWN9TZJUBAkVIQKssWRG5hiccZEkI7dIC6kIJwxSlQ5EPizRxbSEzgY
	1Zi7cmUxCYUPmgQYyDmEChbB3Ua0vdmfuO71vPRWz+Z4BTCg2dJWXIemGlGM8h6y5FYfOvIwyxw
	YoQgZdF0Fethj4NijZcbnhRYTWu18eUbZhH4E/aAgF4hgxrm5yxIe0qmjeZIKIMyE967I8GyXfR
	JyCdoppgHZHUIJ0TNbfIHQ==
X-Received: by 2002:a05:690e:429c:20b0:66f:c1bc:c088 with SMTP id 956f58d0204a3-676835a849bmr968089d50.80.1790803552933;
        Wed, 30 Sep 2026 14:25:52 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691a15e97sm264063d50.20.2026.09.30.14.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:25:52 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adam Johnson <me@adamj.eu>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 4/4] builtin/stash: merge index in-core
Date: Wed, 30 Sep 2026 17:24:41 -0400
Message-ID: <ca3de1d4a3895fcce620eb4ab5b8a1cc708a7362.1790803471.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790803471.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790803471.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git stash apply --index" does a 2-step dance to report index conflicts
before carrying out the main unstash: first, attempt to merge the index
(and remember the name of the resulting tree). If that succeeds, reset
the index and carry on unstashing the working tree, then use the
remembered index tree to unstash the index.

The "merge the index" step is performed on the actual index by a
combination of git-diff-tree(1) and git-apply(1), which incurs an extra
cost to git-reset(1) to cleanup. This also introduces an autostash bug
when stash.index is true: "git reset" eventually wants to
remove_merge_branch_state(), which calls save_autostash() due to
a03b55530a (merge: teach --autostash option, 2020-04-07). This can
happen from a "git merge --autostash", which itself calls
save_autostash(). Operating on the file-system in this way is not
re-entrant, so we end up trying to lock a now-deleted MERGE_AUTOSTASH
ref [1]. This bug has lurked for a while, but it would have been
impossible to trigger without the availability of stash.index to force
the autostash apply into index mode.

[1]: https://lore.kernel.org/git/CALO-guvbk2TcrVwzdNQ3yRpzHr0HHZ3h1wite0Xp0sUyAT4otA@mail.gmail.com/

Fortunately, we can achieve 2 goals at once: avoid round-tripping to the
file-system (and invoking expensive subprocesses) by performing the
merge in-core. If there are conflicts, we discard the resulting tree, so
we don't see the usual branch and ancestor labels, but the merge
subroutines insist on their presence, so use something simple.

We need to take care to get the order of trees right when merging. Add a
test that covers this case.

We *could* swap just the git-reset(1) subprocess with our internal
reset_tree() and refresh_index(), which would fix the bug. We'd much
prefer to clean up these vestiges of the shell-based git-stash, though.

Reported-by: Eli Barzilay <eli@barzilay.org>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c  | 83 ++++++++++++------------------------------------
 t/t3903-stash.sh | 21 ++++++++++++
 t/t7600-merge.sh |  9 ++++++
 3 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d2b736d4e6..fa3deeecbe 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -422,50 +422,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	return ret;
 }
 
-static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *w_commit_hex = oid_to_hex(w_commit);
-
-	/*
-	 * Diff-tree would not be very hard to replace with a native function,
-	 * however it should be done together with apply_cached.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "diff-tree", "--binary", "--no-color", NULL);
-	strvec_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
-
-	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
-}
-
-static int apply_cached(struct strbuf *out)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	/*
-	 * Apply currently only reads either from stdin or a file, thus
-	 * apply_all_patches would have to be updated to optionally take a
-	 * buffer.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "apply", "--cached", NULL);
-	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
-}
-
-static int reset_head(void)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	/*
-	 * Reset is overall quite simple, however there is no current public
-	 * API for resetting.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
-
-	return run_command(&cp);
-}
-
 static int is_path_a_directory(const char *path)
 {
 	/*
@@ -674,29 +630,30 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		    oideq(&c_tree, &info->i_tree)) {
 			has_index = 0;
 		} else {
-			struct strbuf out = STRBUF_INIT;
+			struct merge_result result = { 0 };
 
-			if (diff_tree_binary(&out, &info->w_commit)) {
-				strbuf_release(&out);
-				return error(_("could not generate diff %s^!."),
-					     oid_to_hex(&info->w_commit));
-			}
+			o.branch1 = "Current index";
+			o.branch2 = "Stashed index changes";
+			o.ancestor = "Stash base";
 
-			ret = apply_cached(&out);
-			strbuf_release(&out);
-			if (ret)
+			head = lookup_tree(o.repo, &c_tree);
+			merge = lookup_tree(o.repo, &info->i_tree);
+			merge_base = lookup_tree(o.repo, &info->b_tree);
+
+			merge_incore_nonrecursive(&o, merge_base, head, merge,
+						  &result);
+
+			if (result.clean < 0) {
+				merge_finalize(&o, &result);
+				return error(_("index merge failed"));
+			} else if (!result.clean) {
+				merge_finalize(&o, &result);
 				return error(_("conflicts in index. "
 					       "Try without --index."));
-
-			discard_index(the_repository->index);
-			repo_read_index(the_repository);
-			if (write_index_as_tree(&index_tree, the_repository->index,
-						repo_get_index_file(the_repository), 0, NULL))
-				return error(_("could not save index tree"));
-
-			reset_head();
-			discard_index(the_repository->index);
-			repo_read_index(the_repository);
+			} else {
+				oidcpy(&index_tree, &result.tree->object.oid);
+				merge_finalize(&o, &result);
+			}
 		}
 	}
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70af58e161..70c6031958 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -395,6 +395,27 @@ setup_stash() {
 	test_cmp expect-index actual-index
 '
 
+# the later "stash -k" test is not expecting us to muck with file so much, so
+# reset when finished
+test_expect_success 'stash apply --index merges the correct trees' '
+	head=$(git rev-parse HEAD) &&
+	test_when_finished "git reset --hard $head" &&
+	test_write_lines A B C >file &&
+	git commit -m setup file &&
+	test_write_lines A B staged >file &&
+	git add file &&
+	test_write_lines A B unstaged >file &&
+	git stash &&
+	test_write_lines committed B C >file &&
+	git commit -m to-be-merged file &&
+	git stash pop --index &&
+	git show :file >actual &&
+	test_write_lines committed B staged >expect &&
+	test_cmp expect actual &&
+	test_write_lines committed B unstaged >expect &&
+	test_cmp expect file
+'
+
 test_expect_success 'stash -k' '
 	echo bar3 >file &&
 	echo bar4 >file2 &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 64fe21717d..8f6109fb91 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -801,6 +801,15 @@ verify_no_mergehead () {
 	test_cmp result.1-5 file
 '
 
+test_expect_success 'fast-forward merge with --autostash, stash.index' '
+	git reset --hard c0 &&
+	git stash clear &&
+	echo staged >>z && git add z &&
+	git -c stash.index=true merge --autostash c1 2>err &&
+	test_grep "Applied autostash." err &&
+	test_stdout_line_count = 0 git stash list
+'
+
 test_expect_success 'failed fast-forward merge with --autostash' '
 	git reset --hard c0 &&
 	git merge-file file file.orig file.5 &&
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

