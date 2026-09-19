Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DDA282F34
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853275; cv=none; b=pH+2p6wVJ6WECfh1MsFdvV2pLEzqyNaP2MFl8J1pTZ5cLnkdWIlqLJNhEtWbaHXVSzCbZ2LdvIj+wAcoQ6SX3UEE6jWFgVWl//9tYwnGpq9jDJKVvJJKTzkQKvnqC09Hg07nb0H7fyhN5HMKttxVgfhRZa4AM3OFh8Yccxoq6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853275; c=relaxed/simple;
	bh=622K+GbOcFpEuvwR/A+YAoLi1ZpkTexD0K8AGPN2n8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozlTNqAcvZ1enmVaKJieYmv3D5+uuaAc8Z7p/5ZXABG2DFQuGUtr2BfecQCCrTx2hoFMmXijKXuCtcUoKBVsabpi03Wt+iCmfeqDW0QqlBw7LTbTfU4JbxzJfyJmdr+YWwhfkSN7imo719bFMboQd023934A3ausni41GG8as5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1xexbY/; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1xexbY/"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac8d1eso13548487b3.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853273; x=1790458073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xpz8LSXJFzEt2lveMzg3TRFeBii0QUu77rxZ2/ox46M=;
        b=a1xexbY/N9XtbGLZ1xYah2kyviqCdb8KA9uxZy40WaKIz6+/eS2/YVeVRTtio+VU9v
         6Oo65a1qRnJh06OsB0kW/ocO1FeJfbuMHdI7NxdFCz3bteWhAYNmnG4FFPVxoaroCXnv
         Ng4jNNYeajDRxoQjgfWyFxmSwezkK+bZ1Tq07aQ1/jBx0KWxtJ7PjH1jRtRRdtx1f3hh
         symR2Zp+1VQY3WD0YKLRCI4zgQpErutkMOoewhKtm+QcjfkOcRYdYMA0NTRBgAkbtPea
         fhldzUidBfyLmZPwKvrS5dJZm08xhzzjIv/PIH3SUNrBapNB4NCZKRmXTASoYl8qkt0Y
         Jlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853273; x=1790458073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xpz8LSXJFzEt2lveMzg3TRFeBii0QUu77rxZ2/ox46M=;
        b=NhGxmrc8ElyBSZWg0cNFf+xBM9BUcxiglwvAcHXT/16S5CmfqV27/stcFDP8VDAv7q
         3oNbZzibKCp4ost2Zf6U7VW+1vK8s2SA2Jt3VXxzeFkAiePdzQtrjwPrAZ9Og7490qfO
         H0wGn00ja1hKMOui8nk8s0F/WpKMe9u/Sw0YPPLZ2hUCK0Pe1LHWt7WO9wqysltZ0FK3
         gu25AUzTqAvfEeFjUYZc4GfKrQMiZk7dhSaLvLVgP5YukVhdWOY7Y9o88YovCeTbxObO
         x85MmqgJo6AIY8LEQ/jl9MLBta9H8P4Ye19LK5jClUfIQsWhRZJbU/Zep6cOCwgmBk6f
         MAgg==
X-Gm-Message-State: AFuF++lOZpYCx3kjQfeYRXm6Znq1P0fYWnoyU9r+NzcwEEoDcv0nX3UO
	1h2SFJ6NXWtTPUKbqp/LHKhmjchT/EdbgwsU6APOb3b0gnvV18XVjxCwHGtRMquH
X-Gm-Gg: AYBFou1vzsk7Ydep+rnhSq6pYFJpzDwAhxZMXMLkI0TiG6FY9AnO/E+J0ZZUVHhqXQD
	ooeo7n6Z3pzjFenYaB5x/5DVN3IihI51gNaWoX1jDb0+1NbWPkZSh1QSNDMH59rwU/NnXgUIW2J
	dtDDsLVKRetDPwV7BlyiAZ+1NqF71KvaxS+265/F00rpgvMlRUo6A1t9iMkjM3y5s/kum6lpnlW
	K6/bffebJbDcAO+6yC3RMxnDMEfko4ulSydNIQlq8L/CDZUX/XRUn4K5gZAx5L5o2OIm15QpzFC
	i12UCJyh2FEy4K69h6jNkF2jxeZfhOE9B53k7lwtwlPLmzzJowPDptZ3i22D32Q+8U77iRKfQaG
	MCzUX5tkHfPbBzhWMIBY3xvndbb+VeHl5O1WivWDqQTIeFY77l5F0bp1FqKXbIYeRkAJscCKLOP
	rSrI8dGDteoOUtkVnbUvSnXm5we11WFfh84A4duuADz1/Fwxe5gqClU7g5OuKaCXJ2XxFwVh4M4
	9x0XpliCKOKhMx2OdO0Oh9PLgmJLX1l8LHYLuwxtW+QAepGASUR9RkYtOXM804GJZwqx3j4KC0O
	nx2dI81trn3SfrDcXNR7cw==
X-Received: by 2002:a05:690c:e181:20b0:873:5c0f:290 with SMTP id 00721157ae682-8973721a936mr15153267b3.58.1789853272912;
        Sat, 19 Sep 2026 14:27:52 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4751bae9sm11756497b3.28.2026.09.19.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:27:52 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Adam Johnson <me@adamj.eu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 2/2] builtin/stash: merge index in-core
Date: Sat, 19 Sep 2026 17:26:36 -0400
Message-ID: <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1789853192.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
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
merge in-core. Since the results are never seen, we don't need to set
the usual branch and ancestor labels.

We *could* swap just the git-reset(1) subprocess with our internal
reset_tree() and refresh_index(), which would fix the bug. We'd much
prefer to clean up these vestiges of the shell-based git-stash, though.

Reported-by: Eli Barzilay <eli@barzilay.org>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---

Notes (benknoble/commits):
    We *could* leave the asserts in, but then we somewhat uselessly set the
    conflict labels, which I did in the original patch [1]. Phillip
    suggested we don't need them, and I otherwise agree.
    
    [1]: https://lore.kernel.org/git/CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com/
    
    In all the versions of 231e2dd49d (merge-ort: add some high-level
    algorithm structure, 2020-12-13) I could find on the mailing list, the
    "assert(opt->ancestor)" is present without explanation or comment, so
    I'm not in a good place to assess the impact of removing it and its
    compatriots.
    
    Cc: Elijah Newren <newren@gmail.com>

 builtin/stash.c  | 76 +++++++++---------------------------------------
 merge-ort.c      |  3 --
 t/t7600-merge.sh |  9 ++++++
 3 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dfea2d2c4c..9fc1a25e3d 100644
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
@@ -669,29 +625,25 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
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
+			init_basic_merge_options(&o, the_repository);
 
-			ret = apply_cached(&out);
-			strbuf_release(&out);
-			if (ret)
+			o.verbosity = 0;
+
+			head = lookup_tree(o.repo, &c_tree);
+			merge = lookup_tree(o.repo, &info->i_tree);
+			merge_base = lookup_tree(o.repo, &info->b_tree);
+
+			merge_incore_nonrecursive(&o, head, merge, merge_base,
+						  &result);
+
+			if (!result.clean)
 				return error(_("conflicts in index. "
 					       "Try without --index."));
 
-			discard_index(the_repository->index);
-			repo_read_index(the_repository);
-			if (write_index_as_tree(&index_tree, the_repository->index,
-						repo_get_index_file(the_repository), 0, NULL))
-				return error(_("could not save index tree"));
-
-			reset_head();
-			discard_index(the_repository->index);
-			repo_read_index(the_repository);
+			oidcpy(&index_tree, &result.tree->object.oid);
+			clear_merge_options(&o);
 		}
 	}
 
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..f69a49d48a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5035,8 +5035,6 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	trace2_region_enter("merge", "sanity checks", opt->repo);
 	assert(opt->repo);
 
-	assert(opt->branch1 && opt->branch2);
-
 	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
 	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
 	assert(opt->rename_limit >= -1);
@@ -5409,7 +5407,6 @@ void merge_incore_nonrecursive(struct merge_options *opt,
 	trace2_region_enter("merge", "incore_nonrecursive", opt->repo);
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
-	assert(opt->ancestor != NULL);
 	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
 	merge_start(opt, result);
 	/*
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

