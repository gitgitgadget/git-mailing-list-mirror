Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF1A4EC65E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684451; cv=none; b=UUgYCv6fcjLiMW0A2+k2SyEDG++fRi6t8CStJc4WeRy4sg5FIHmNr+hYfEalQo12T0AcCNndKJQmMdOZnLSwcdBcegoGOwEQ6YlGLZcm0KUnjklIvMRYM1EMAu+sBzGQ4EPDNfMdSJNGqj4XMew8ZZhhitQUjeh7hubMnA0unkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684451; c=relaxed/simple;
	bh=JgmURsdQjpQ0gwUFLK5ICWYNkGE3glTnwamnzVPv3V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9PCwalcbciTXnPxIlNVUEoQYUbxQA+6eRJsk7WPwDfpDP71X/xk1lK+C2QTWP0NCl2t6pR9bUX2mLNe7U1VN7FHoF7o456+ajJTZDIElvOLWjqfli4NCclbEffWx+TV/sc9EdCdrdP48uuuBT1UDIiTsL6ZHSOYBMHgZGWRoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXTaTFYC; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXTaTFYC"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso3904955d50.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684449; x=1791289249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vE/mEgWo7BClm4LfewDRf1L1HflNgcwTNSGUyYfPOcI=;
        b=OXTaTFYCXScK+6wJ+YQRIi5HdGfqhCgnx9YBOVgcWr8kLdESAbOsxAvQ6cR7pLDJ78
         3x8Quz97LBXh5+PCc6tZlIsnpv66k9lYjOS/UI5GEpWrg2uf5IWHZQsMLu3wcWo5df21
         4cfedMVXf+IDdWC5EtDYrU5k3BVwbohW92CBM5f4g0Z0z2Uvi+6ul0Fhv12pCea8xQ7m
         jDKBD+q5HOyjKjpx6vd/UDqPGEdHDbheZaRA/S/2K8I5gNAZNSNaq7DMRj9uZ7kmlKUw
         DXsPZ2wV/Uvbbyau7/CxoRc/lBggq3EXUTtcFrBIs+0lwIjc+EsizdqBQpgh6fX+bZGK
         hVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684449; x=1791289249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vE/mEgWo7BClm4LfewDRf1L1HflNgcwTNSGUyYfPOcI=;
        b=pnk3pV0EVuv913TvZTgV/jZVHG8ATkeQiZEQSSLKFZyouxyTa8ZTbF/fV8SPtZyZRG
         pZHEIV5/vFVODhq61rPG1CvwzwByt5ZpN9zSosOuN9dXEqHS0mVCNovEXH/Tk5xWWmeE
         Cum4xKtaKNcS8WRDlCg/7Lhr8CIiLM/Vx/7u9Lv80zYL8Bn1syWDfzv897bAyQHOXn9L
         yKN4lCDd72d89l+A14ogKM6Y57/jfb5QVpoW83yTbssIhjLXP6RSWlm6U2pUGrTN+zIM
         8swuOMaAshrWjfdzpZDvS2LipOLsY5t5/WmLa+7fm0YGUswQwqHhaLJgfdE4w/EtU8bm
         NdfA==
X-Gm-Message-State: AFuF++lDJZ5DmiltXiY4ycHCVxKnnPF4bnIlimzW7ofPiQpm3Q+bXSUC
	y6ni96kulU78HLkVWgQZpzzOnf/4oW8oRo7abvsKFfaf8L6+ufViOSHDBV7UqQBE
X-Gm-Gg: AYBFou0i6tkUGxn7yVU0uXh4TAmsRilWjEugiUYrZgBnzPS/UgdD9RCI0i1+gHwWcOU
	rFBWDp9kgSstTQ4YDYqpP8TXzQSUu4wXf6gpZm6RuzntA8Xq4IJNUz/VR4nzqWErb+RwoFO2Iwi
	uFWS8fBM/iwkOuAkUTrPMrwmjx9hAv15Dhb1Ln5ztcrF4MV30ryir5poGyVieRaE8eoDohQdb1j
	iM41EOpTk7svljjj/lG3xbS/55AGs7933pu9gBfOr4kiPtC/Siv9X6mUi1ktHjORr+j1/Hk1BKu
	QRLBzSxvvDDD4pW3LMcwU/Aw4RQ1OXlb0FVNwiO9W/9r4MxjW8M6Q4QfRpsJDmwlcNeXtSGPotz
	jU/BAfQUZijFZrercz3xOhu9aLDMB2oXY7rLR6lHTS83yCMhM0fVXFqKk3eG8tbYQURdGSJnpzm
	WMpjsYkka7p8ulrB3cFq7aBizjeP4q3weNSnNKQh9uRiHXTMQUqzu8W+Y5Yudoh/gIG4oSHo0zY
	vL/pb6dNmSU3MGSdxpjgJp/zKtvWiRUO5iuKQ/iprkX71p1MWdeWo7S5qg1Em4D9qSAG8wx0TOx
	yunYC1UifkSfmlH4s7jXpzbCRHspUZ56
X-Received: by 2002:a05:690e:b82:b0:672:c9eb:4755 with SMTP id 956f58d0204a3-672ed088135mr7742630d50.23.1790684449034;
        Tue, 29 Sep 2026 05:20:49 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-674e5a7a556sm4499112d50.19.2026.09.29.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:20:48 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>,
	Adam Johnson <me@adamj.eu>
Subject: [PATCH v4 5/5] builtin/stash: merge index in-core
Date: Tue, 29 Sep 2026 08:18:31 -0400
Message-ID: <e21b832a6e1d99416a220bb5ca1f008777ef4e7d.1790684309.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790684309.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790684309.git.ben.knoble@gmail.com>
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
 builtin/stash.c  | 80 ++++++++++--------------------------------------
 t/t3903-stash.sh | 21 +++++++++++++
 t/t7600-merge.sh |  9 ++++++
 3 files changed, 47 insertions(+), 63 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d2b736d4e6..ec07547376 100644
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
@@ -674,29 +630,27 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
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
+			if (!result.clean) {
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

