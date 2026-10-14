Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1C48D883
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012847; cv=none; b=M1GuYgy20PiHElIUvoJtwYyUBPdplCYD3L7V2jbb6FsCs0LioI9K0FMIFm0LbzMpuY/XsyGMlND1IcD6c9okpO5GDPLjuqSgAoulJVQsXkUoGuwmhwPlmyGM5D4aU07/Tc9MwkdqPK3OD9FiPO+Z1f8Q+wfCz6aNltAg5HO8OR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012847; c=relaxed/simple;
	bh=Y0oEe12YAR3D1Jq8GQFse6c+XIXu0dl30a4tfO1j3ZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ootyr417xfTCBhChxBjSQOKjiD6RENjVgftwrhgjvh4+fLpwsYEtA+x4vuHQFEQaTOlBc32SWMVCFIj4up5x0nnX1GtesHJvGjFcN9jb9HbURuIdM+CI/DSQ1Grh0UwfcoWEUefeIYzydJk4Qo5VjWfCFWXWKKb5Q9i1O0u95x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1eFZJhd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1eFZJhd"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-918f75a68f0so73616596d6.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012845; x=1792617645; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wiEzGyBOz9u+iThC6kHzi9xw+cYoSbmHeSEUn1FKztU=;
        b=U1eFZJhdbwfmeNHGKjb0ZbZ3BPZYQSAVJ3sHIdM7PL+rX/sYdPjtEzrBUyaRwyvoUM
         WRsocWlFmUlFzCAVqEtOY/mfL1Sd5sVnbxdGf9C18/UOYwXybkVMC6M2GQRv71q9mh1l
         RNabSQlZsZGXeaw6wMVZZFTDgego2QMfDUGOEIf6N3DuuaYzqLwZJAi3KwcQ2z+MQcLr
         58ydrl/uAb5dIDR+063P1coQzXl1E+A5kZbRVf48oe2K3SDXQdgJ0Qoub5ssF/yjD86i
         5xRHuF0c86UXX2EX85IASVP/nSxnuosKKVoJ2jRd494VoI+ZLZkbYNaGI8EHHnkXwoP0
         AUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012845; x=1792617645;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wiEzGyBOz9u+iThC6kHzi9xw+cYoSbmHeSEUn1FKztU=;
        b=pRIlzibTkHcsbE8eSYuqRCQFp8SwdLlxKYF+hnVc1Kcnv6FnFdguFkwTifia/4ZZdR
         eXiK44r/Nkr5tBiM2xz7lVjzLl+mjiLwUyjtrNr/vxorp882odWNQl/JFosC+e+AgL/T
         IReToUJrX4l1902c/r8STS64eV6Dptv6mP7wxF/n0hfIFHSs326kobXpA+Muxpxwd65K
         C+vRDj9Snwaw+q4KBp2V6JKats4hMae1jqwt9dLH+7qQVYiyPlqa1L0igVODeLeem+5I
         dshgiTm/V6nLCyZik1jQwlMAwBVk/8nCgXGtAIzgz0LpXOpa+1X/Rx5ScHj9d0ai8cxV
         jk7w==
X-Gm-Message-State: AFq9FYIJjWeyTOealD0QdYn3QTfFADPrKsiRhI6r/7w07N2mcabhVTDf
	hzDoxtO6D1CAz8csmj2TGM3yM4wW8cvlZP+dr7dSEsUpp16YCGskULinIF62br2wQrE=
X-Gm-Gg: AYBFou25+RN9/57+FZixTSv6rs6hBCLTH1hTT1QVsPak13w91RgaZsbEMQ4QT+DNikO
	3SYYgjbD3T5IpuHypkiFURLaE6yv0ls4BWpPYb2jQs7UYmsm9g+3WfFKNi7ULJaYzi2OsJ/PJ50
	o2r7aHHTE6LipT59Tu6BNdQUwydB1H631G2WpvrvI+NrC06NeizpKkEyu+zjaQUqAvKbnQAOhCh
	ZPfm1g5wrli+Edp+Dib1W9b8NPuvCAEm4j7W3GK01NfTcYDsbu3vYy75xGsKScx3uk+BPK1W+SK
	kpAYRqs386zVK6jnPR8jjXWf3R+JR+M3GBxB6A3iu1U2rXseFcZGgFrYporb+e05Xzr4jLa0YqM
	cZ1K82IM+Slczauvxfgbjg5L0pmXyJG0GvrU4f/d4uTkSUACp3pVEBKFaK4D5fjbiX/d/myHHsZ
	kRGVGRGmeMGZQEN9sGddVbOuHPpAigxfXUpJtx/Xyu7teBiZ/DKWCz0UzgKGCLJdo+ite57MbU/
	HCKWz0uhlWz
X-Received: by 2002:a05:620a:660a:b0:93c:7955:afd9 with SMTP id af79cd13be357-93ebd27ab42mr2693343185a.52.1792012844977;
        Wed, 14 Oct 2026 14:20:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.220.125.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50a4f82sm584561385a.43.2026.10.14.14.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:20:44 -0700 (PDT)
Message-Id: <015602168c8532c07b94c9f50925bf5d5a2ef7c8.1792012836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:20:36 +0000
Subject: [PATCH v2 5/5] worktree repair: avoid breaking unrelated .git file
 and gitdir
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
 worktree.c                 | 20 ++++++++++++++++----
 2 files changed, 43 insertions(+), 10 deletions(-)

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
index 879941a977..86094307b1 100644
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
@@ -888,6 +894,12 @@ void repair_worktree_at_path(struct repository *repo,
 		   cb_data);
 		goto done;
 	}
+	if (!inferred_backlink.len) {
+		fn(1, dotgit.buf,
+		   _("unable to locate repository; .git file is not for a linked worktree"),
+		   cb_data);
+		goto done;
+	}
 
 	/*
 	 * If we got this far, either the worktree's .git file pointed at a
@@ -905,7 +917,7 @@ void repair_worktree_at_path(struct repository *repo,
 	 * in the *original* repository, not in the "copy" repository).
 	 * Therefore, we prioritize inferred_backlink over backlink.
 	 */
-	if (inferred_backlink.len && fspathcmp(backlink.buf, inferred_backlink.buf))
+	if (fspathcmp(backlink.buf, inferred_backlink.buf))
 		strbuf_swap(&backlink, &inferred_backlink);
 
 	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
-- 
gitgitgadget
