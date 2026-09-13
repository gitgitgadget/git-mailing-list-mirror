Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC32BEC3F
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789269620; cv=none; b=Iw7JTBPZJlW0ix/j3T6PC2e8hYQxG7F0QF1QA3m3p/0eZ8oXlfemvrb4jSOAsZEqLSDSLcDMDblPwTG/kH5CQW37e2JnMiRHDWEqi1NpOgpGhXB0jwPhL2bYxlXYhcTpErQiqTttqm0x8WA2Dfk19NiDaMvua2J2NS3v7JRK+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789269620; c=relaxed/simple;
	bh=CBMRxbxT3ryEaJPPzGLIjiN3UodByHhOzOyXEwQq20Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J0cEaNdEAcQFWrPzTPanwixCrst35if8yF1gx10BWjsAcB3SBXKRfXrTWOCP10/nbgcYxwEIoXUGb3+NEHch/wNlJ4UaEOAMlm2B66t/ElBcYZO95luex3ecLp17PGvdA+Uzx8f+Lm/zxF/dkfQ2VAL7ny05bOtpwmKLFbH6e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwvTdTPS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwvTdTPS"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso11527555ad.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2026 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789269618; x=1789874418; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h3tqnVIEHoe1Z7bxeI0aQ7JEPxwEOj5SDYa8yr6fLV4=;
        b=bwvTdTPSyPgewkQoCqXO6MVVjx6RvthovI6xmaVJ14Zyp/w22cTVxzW28eJuaRoueo
         89stAU/XN0mx0nxX3JlzB9fXZQgenje/1YLtygfsKCKrFQtfTzAwhD9MfV2MBAy8OHbq
         mJxHvTocUM7xmH2ibTS58vLBGY5XgPOrLRstqGJLBLPxct0UmufQUwFYWuOyoWXG9HeB
         RRYVxKQyLPMgMCA82t+QrJqnV1V+TOwcDNNngxu6yFDSjZCjVQ3l4ZbacHQmOnmDixPr
         vfvSNuAxhvqQgYZe4F6D28dAF4n8Sw/wadVAnTGkOaCdu/War1RSmVaqvcjaO1nc33Hf
         Sy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789269618; x=1789874418;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3tqnVIEHoe1Z7bxeI0aQ7JEPxwEOj5SDYa8yr6fLV4=;
        b=nkmEDVQLmef3DvAdU6xKNqu3IatRS/YdkZsH0vBgSB5S0i9nCNAd7/z9XZNTWOZreR
         irEMXmlm8syllDXt5A1OTj5VKcEqstTiTd80CzATSSMnIPBxg8d6XVdu0XwKLOKM5NdI
         vqBdj3WDJqhI0Li0MnoOL3UqE/j3PHykXW2AuWSIBsy0zIW/QCXXmruZNBSDPzTmB/S0
         fiA0pAnFPYZvtzi6UsknwxJo0qmDbGL44kcMg/4m8QyqrZCsH81AHei0QD+MA9iZUPh3
         K8cSrnRCkx4wHD5ZuZ74RHipw5xAcnhP0iLJXL5zDyhHcumZVc6v9yF/+gz+YZHHqCE6
         +MrQ==
X-Gm-Message-State: AFuF++lgHtbXsDZf76LAP3viy8c7jDTGDAoxbCf94VkTL6JNgTsiwv0d
	THotsedPbc4J5MTj8Fkg0VaJ6jyvdUr263Z3GyXxgYdFnExlY9UmkKY6q/0/xdLv
X-Gm-Gg: AYBFou0FoC9uiCoRSaC6nFZwKUsCPaVNV8ISAMbUR9GEP0DsymwCAiavQYPtJhaj3XN
	0w211HLzEfSJySppRRYuGcvQAJ6hmp+tWA9+dzitQmQUdBpyF/PUFG2EqKNlFoIzf18QX634Wz/
	1PDQYdmdZIy5CuHzeCUnIXQyKhxAc8vf5XJjrHPyOZ+Yl+GYfoIWlLB9/d2Dh2oQdtUyc38odsA
	IUbWD6b7TaXRFxTzf7VujiKL21SVahtU0ak0gDhhtgEva51Caop+tPcqzpZHLRu42Wd6xbl26hE
	3K8nAqwDHKq6pJGGpY8MRJJtGqCSZJtizqryXGiWMWkXccQba9gdo8pnKbc10MTfblKcikh8ynP
	2at1OqVdnCjU8zmuOxX31NjBiF5my3yacGMaXoYuy+u/xp6PATlL1qYLKo2I6rV7E5pMe1GvZqg
	JgBxuMosVqYOdI0WyxUDg2YndWfQfCITBehf/lDi//6ZgSnX6nVRnIhyDPXsstKUCijUaioRTN
X-Received: by 2002:a17:90b:2741:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39d9bdbb0e4mr19159510a91.6.1789269617995;
        Sat, 12 Sep 2026 20:20:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.65.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba71cesm16836004c88.13.2026.09.12.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:20:17 -0700 (PDT)
Message-Id: <99aa34135c481e7cd7605788408055157d09fa19.1789269613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 03:20:13 +0000
Subject: [PATCH 2/2] worktree repair: avoid breaking unrelated .git file and
 gitdir
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Currently, `repair_gitfile()` does not verify whether the worktree ID
recorded in the .git file matches the worktree being repaired, which
can result in an unrelated .git file being corrupted. For instance,
if two worktree directories are swapped without using 'git worktree
move', running 'git worktree repair' in the main worktree accidentally
swaps the links between their .git files and gitdirs.

`repair_worktree_at_path()` proceeds even if it fails to infer the
gitdir path. This can result in the corruption of an unrelated
gitdir. For instance, if we copied a linked worktree to a new location
X, running 'git worktree repair X' in a working tree which does not
belong to the original repository can accidentally overwrite the
gitdir in the original repository (the scope of impact should be
limited to the repository where the command was executed).

Resolve these issues by validating the worktree ID and stopping the
repair when the ID does not match or the gitdir path cannot be
inferred.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 t/t2406-worktree-repair.sh | 33 +++++++++++++++++++++++++++------
 worktree.c                 | 18 ++++++++++++++----
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index d4e53d492b..2ffa123f42 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -56,15 +56,12 @@ test_expect_success 'repair missing .git file' '
 '
 
 test_expect_success 'repair bogus .git file' '
-	test_corrupt_gitfile "echo \"gitdir: /nowhere\" >corrupt/.git" \
+	test_corrupt_gitfile "echo \"contents not started with gitdir:\" >corrupt/.git" \
 		".git file broken"
 '
 
-test_expect_success 'repair incorrect .git file' '
-	test_when_finished "rm -rf other && git worktree prune" &&
-	test_create_repo other &&
-	other=$(git -C other rev-parse --absolute-git-dir) &&
-	test_corrupt_gitfile "echo \"gitdir: $other\" >corrupt/.git" \
+test_expect_success 'repair unlinked .git file' '
+	test_corrupt_gitfile "echo \"gitdir: /nowhere/worktrees/corrupt\" >corrupt/.git" \
 		".git file incorrect"
 '
 
@@ -89,6 +86,18 @@ test_expect_success 'repair .git file from bare.git' '
 	test_cmp expect actual
 '
 
+test_expect_success 'skip unrelated .git file' '
+	test_when_finished "rm -rf corrupt other && git worktree prune" &&
+	git worktree add --detach corrupt &&
+	rm -rf corrupt &&
+	git worktree add --detach other &&
+	mv other corrupt &&
+	cat corrupt/.git >expect &&
+	test_must_fail git worktree repair 2>err &&
+	test_cmp expect corrupt/.git &&
+	test_grep "unrelated .git file" err
+'
+
 test_expect_success 'invalid worktree path' '
 	test_must_fail git worktree repair /notvalid >out 2>err &&
 	test_must_be_empty out &&
@@ -113,6 +122,18 @@ test_expect_success 'repo not found; .git not referencing repo' '
 	test_grep ".git file does not reference a repository" err
 '
 
+test_expect_success 'repo not found; .git not for worktree' '
+	test_when_finished "rm -rf side other-repo && git worktree prune" &&
+	test_create_repo other-repo &&
+	git worktree add --detach side &&
+	cat .git/worktrees/side/gitdir >expect &&
+	cp -R side other-repo/side &&
+	test_must_fail git -C other-repo worktree repair side >out 2>err &&
+	test_cmp expect .git/worktrees/side/gitdir &&
+	test_must_be_empty out &&
+	test_grep ".git file is not for a linked worktree" err
+'
+
 test_expect_success 'repo not found; .git file broken' '
 	test_when_finished "rm -rf orig moved && git worktree prune" &&
 	git worktree add --detach orig &&
diff --git a/worktree.c b/worktree.c
index 7af13898d0..88da599ab6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -640,7 +640,11 @@ int other_head_refs(struct repository *repo,
 static const char *get_worktree_id(const char *dotgit_contents)
 {
 	const char *slash = find_last_dir_sep(dotgit_contents);
-	if (!slash)
+	const char *prefix = "/worktrees";
+	int prefixlen = strlen(prefix);
+	if (!slash ||
+	    slash - dotgit_contents < prefixlen ||
+	    strncmp(slash - prefixlen, prefix, prefixlen))
 		return "";
 	return slash + 1;
 }
@@ -692,8 +696,10 @@ static void repair_gitfile(struct worktree *wt,
 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 		err == READ_GITFILE_ERR_IS_A_DIR)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
-	else if (err || !is_git_directory(backlink.buf))
+	else if (err)
 		repair = _(".git file broken");
+	else if (strcmp(get_worktree_id(dotgit_contents), wt->id))
+		fn(1, wt->path, _("unrelated .git file"), cb_data);
 	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
 	else if (use_relative_paths == is_absolute_path(dotgit_contents))
@@ -815,7 +821,7 @@ static ssize_t infer_backlink(struct repository *repo,
 	if (!*id)
 		goto error;
 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
-	if (!is_directory(inferred->buf))
+	if (!is_git_directory(inferred->buf))
 		goto error;
 
 	return inferred->len;
@@ -882,6 +888,10 @@ void repair_worktree_at_path(struct repository *repo,
 		fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
 		goto done;
 	}
+	if (!inferred_backlink.len) {
+		fn(1, dotgit.buf, _("unable to locate repository; .git file is not for a linked worktree"), cb_data);
+		goto done;
+	}
 
 	/*
 	 * If we got this far, either the worktree's .git file pointed at a
@@ -899,7 +909,7 @@ void repair_worktree_at_path(struct repository *repo,
 	 * in the *original* repository, not in the "copy" repository).
 	 * Therefore, we prioritize inferred_backlink over backlink.
 	 */
-	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf))
+	if (fspathcmp(backlink.buf, inferred_backlink.buf))
 		strbuf_swap(&backlink, &inferred_backlink);
 
 	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
-- 
gitgitgadget
