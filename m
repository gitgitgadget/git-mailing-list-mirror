Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C96522681
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168361; cv=none; b=kwVbMKV3ugieGvuin7H42IQg0qHfbdDpQe1AjcJH7FUt4IVLxeaeEJOwRBQyQxC+RfG+mmYXymHNZzA7x29jFtxvEJGlO3glY3hpG9w77t2QpCqX7GU1adsF2UfjuURFQfKHfLqQ9vJRCSP4gJCpty80BnTn1ks5jCLJoODQNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168361; c=relaxed/simple;
	bh=yTvsb8sL4m0RCjSNlyGZyMxTpNhiIAO1+v94Q+Q4lmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fbhha5+qk0XEfwZtkG4p8bznfHvenJ5YM7xQYAiOBNGCsyNtqF8N5eR9WwPS0zazOpeJFcxoSSosdNvMaNT8Rb5Q7w7Fm/2fd0TzIPGp3WlaCMIxtrGko5/hMHEMuBGLIhTawWai5rVh2LFBuImOGHTt36WPTyEpa9eMbnGS1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZO8tNuv; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZO8tNuv"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so837100d50.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790168358; x=1790773158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6USlIIkBhtsu12l/r9B4NP8hNKPeE3Wl1OzsZU4Kjo=;
        b=eZO8tNuvIc/v+58c8SFi8Q6lVa6vlYPrAvloWB7LsNReLps9j89CRNxIOeJL9bQntc
         4u22tX5NoJqev68ePVisIIZ/hSEmeG4MzoPWJO0nTnkSQvV/fy/rfTBRW56W5DDrCaG1
         gmBVuMXSMF63n6oRwQ1eCL4DW4FPXhBXQ4MOKgxUlMmZ+7pTFlV40ss/zDKJirRfTS3w
         7mOFV4rS/pyZBYW0Mn/cWOlLUgxuWTypiBBcZDkS6BcSrLjOVB8/QCR8mVtJVVJchlEB
         SQX7rMn5EMwCIrc8Leq8gua0Zvyw2O/0yYXTAii8QNSshOYrTL7MKcPgV54rdFurQFWl
         C1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168358; x=1790773158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z6USlIIkBhtsu12l/r9B4NP8hNKPeE3Wl1OzsZU4Kjo=;
        b=ttqUnEuaAqhGJwBDQBjGHJchmqXS1IpI/LJgIAjSWUHzwWKeDsvfrE808ixZ96pBhi
         6oQHl0Oh677VbC6IVRtsRpf1RA8kdTm9tajYv1Woc8Awh5RbnSxk4/iERQA77J37Uo+x
         szfus9jvx+h0Lv5qaq/R+9kEPFJK+p2aGhVCOWr7BaSLBf5EutoDDlRgTYj0RY0/g5lV
         0ImLyDyxbDEwbA2QHeTRNwloVQdjijT+hX3H7kKCYzWqMJNJ/B7bKl2AgEyeYluGhfAA
         tnSL/yg20h1X4CfjhZLxwNUQCoN3PTbTGzATMjKqZGI6TamZJdfoW2cVNFHxwW5MCROa
         ZSYg==
X-Gm-Message-State: AFuF++mQ7uK7XurreKoBfLmVVT7npWCKjC8Q6c+rIxkOjmWqHDNrGRO7
	ox0RTHfIEJOECLpjvaiucXZYO7KMvVWneCWVb20kRLXsVp8I08tRgtdb0VerSHwA
X-Gm-Gg: AYBFou2yOO6D2Kr3dtDeHk1s5OCXKyAAB3C9Ji1av9l971iN9WUVL1v29GAZe9yFI6p
	2RRbpDyrwdups2By4z194ibn4db6m3ARjFshCiiZRUSUVSQbNE64r13It77SdEy0DEyhfrgi//h
	BOJws6kLooux42ZeW8C992plsOxPPkq6N0RV1pOo8Ar0J7UgGEYCd4pFPF1D+4s6wnFs+tk/SRm
	Vau9wF0bVKlJF+pgBVpxXDHFFQ2hM1CqvpH6OrMjpzJsfMS0VbPAFhgFlABbvweeg0ROQOk/sy5
	m9dSWXDw5UMes71zD65rVwaoHLN9DVXbrrmNBiibIYUazJrRoqx1VmhxNOWNUn6zwVQC7HWWY2n
	R6tUgsgVkr50rmnQKU1i39fMvP0Gbhj2Hn2Jm6lMqGNJYKQyJUCQmuRSMx5F2QRs8hEvWfxFrHw
	mYt1I/L8iAAeiKzZHEjRobAoDOfLaFHvRXxFHRBpNeBp9AIz15zzXsjC/rx4jXnL7sjI1ri0/N2
	euZMBxr6tuWOz5/hV5OKyOep5dbE32zUBXgdGsWJSgXHxv3ZYM3/xGs9UNi32IFVLE5z3auJUa3
	nbjCCf+QmfcLpyZDTXzTe8M=
X-Received: by 2002:a53:ba8c:0:b0:671:70f1:3b49 with SMTP id 956f58d0204a3-672d599d4e9mr1156398d50.108.1790168358198;
        Wed, 23 Sep 2026 05:59:18 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d81ce7dcsm833063d50.18.2026.09.23.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:59:17 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Adam Johnson <me@adamj.eu>,
	Victoria Dye <vdye@github.com>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 4/4] builtin/stash: merge index in-core
Date: Wed, 23 Sep 2026 08:58:07 -0400
Message-ID: <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790168285.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
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

We *could* swap just the git-reset(1) subprocess with our internal
reset_tree() and refresh_index(), which would fix the bug. We'd much
prefer to clean up these vestiges of the shell-based git-stash, though.

Reported-by: Eli Barzilay <eli@barzilay.org>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c  | 78 ++++++++++--------------------------------------
 t/t7600-merge.sh |  9 ++++++
 2 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 043a38cc6d..219ca457be 100644
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
@@ -671,29 +627,27 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
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
+			o.branch1 = "Upstream index";
+			o.branch2 = "Stashed index changes";
+			o.ancestor = "Stash base";
 
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
+			merge_finalize(&o, &result);
 		}
 	}
 
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

