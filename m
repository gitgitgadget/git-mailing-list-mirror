Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CED3203A5
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894801; cv=none; b=MQBAmBBCVtKyOdROwfA4dx0CUMesjaO1ueFMGg9cHxEGUUOFu3Dp3djzTYZjvvnOk13PbvS2DpaFYBDmzqf41s8pA8Z5Ey2OEZwqrclzFyvcTffjlc4QT1XOyYYs1XYB7BGoDXjgEn/5ZvsstfZhMnRL/LnJxTRE7S9Kf3v03hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894801; c=relaxed/simple;
	bh=skJkn8SSCWGWGePr4heq9mjrPDoLDxc8ZG1N6qSldOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBbx3HXxU+AYTRbFWonyvQrgSkgaDOc6j/vKDqUefCaAMGTsfVNAEGU7xMOWptl7CcZ2vPK8dScHOL/B4WJb5032Svzi+rWq8llVW17pHlCGZDbpHz4EM2BdJ7cJg4JsVlc9TCJtE7WLORqHqpIrya2FwPr+yOF9mcot1cqQek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBPRVArC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBPRVArC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso50471915e9.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894797; x=1766499597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dW4Hl2Bf7JER+cznaOMfBNVx9tyO6Sy56wIcnolmf3g=;
        b=HBPRVArCMUaX1/ZYAVMd3TO2b10LpRQxM3olvV3Jvp0mmRB5tDJ3BT7A4aibtkkVIX
         KvpaLmF+yip1Xuu4bXksBIjwaiKRgUF4srMVUuk74JWY44hWB0HRCNaV2wOZO1mc875y
         0kVQCFuaB9UGYqpiXprf49SFbiwjqAh2vThfcD3CC291NEy3Q1/6DdgkyPze4HLY3Z0k
         c7sZ82sejcckONWzsCxmNCrgbRYGFeZ2QtvQ/1vW35whEj2j4xbk+BNv2CBbL/7LmL4U
         QVkmlSztN+2ZEco8xPDr0ZQ1xqesMm+lqgFSBYlKm3Nt30jM5SayrTAdQSi+BRRKK8Uw
         LFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894797; x=1766499597;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW4Hl2Bf7JER+cznaOMfBNVx9tyO6Sy56wIcnolmf3g=;
        b=iAFqa2AHeBJEt6UeQNPF5O0vUFPE2/u1Y8L0IiKnORb3OeokgIGIIfE1Rcmo+UKdrx
         7LPhPD/WNaEiPKcVuXkXhhVpFF8aCWF2YAKPG/U5qVhGUsiDJrvUNEmtxRMeN6I/yd0i
         qRm5F+tHV75YNopFEZtvUmlBUK9BuyWiBWSjdl+t5+pZ15dQZ5PNZ+0OoUgphQ8OsoJk
         sLohDtCRZhiRQF/NTyM+n9BvgJ+JFMyuiEztgNjlzVmLYX96ZJQa06VMmkj9b8OgUBqX
         4qjCOeoNllen1VgyyzAERoIwhHPTIpQpYJEpwYfHV4AHObhz2w7ntz6LRXEw0wL29CGz
         GkvQ==
X-Gm-Message-State: AOJu0YyRSnnSXe3AgozBIP770qh6/6A2XJlAAJ42mrcs9C8kXIg7Pl/m
	wcr427yFsHewY9hfRZg0qzf9UmemMwCAt7adVCLalB+6gl45bIwVlvPl8JX49g==
X-Gm-Gg: AY/fxX6xuFnfqma7DHMn7MyFhL8H8c1GxI/WvrAx5CVCg1CViJLT5IR83mRZNfIXSGU
	EIUQVbPNgk8oICulCFKXr7Vp7yN35wbVJGZUepNrXsHnGM+ObRuXcrkBMFz3BF/WpWgYDX06HHe
	I/PTJ9kkQhtGLIGNmsnVtuzSbrL8uK2yesWGWWmbWWyIDflDzpSA16wlL5v3kk6s/CMCoFbGWPu
	ckJ9V9nXgPTCSWtGX167Rx+NcWWxfX4X+BjiBZmH/hx/+rdk1AArPIFezNFeCJDHf54z5PwJCJJ
	AM11ELoPBGT+FmMdnaXBF1/Mp8yS6ctiqSWAqAbMyZQvNVZubCcrgKeNbVqLkQhzbgA6951uyyW
	q3itutxeyqOaQ2NPiyqRNDqsuGPKmetaF3QeV1ymzu5DtSf3f9Iy+TVqiX7Ce687O3IZV6dEdSC
	n2vK/ITRzhkOjFuAgpDUveKzBUkg==
X-Google-Smtp-Source: AGHT+IGJAbnK/z5wSXmCUC8c+efYJ19Yihi92SdmDSJRki6LuN6L8mvSgjb84eeH44sPoH8o/WFQNQ==
X-Received: by 2002:a05:600c:4f84:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-47a8f904528mr157520275e9.22.1765894797418;
        Tue, 16 Dec 2025 06:19:57 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd90e99e6sm11954465e9.2.2025.12.16.06.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:19:56 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3] replay: drop commits that become empty
Date: Tue, 16 Dec 2025 14:19:43 +0000
Message-ID: <73ba74b8a2e7aaa625e6f0689a9f900ceebaaa03.1765894781.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the changes in a commit being replayed are already in the branch
that the commits are being replayed onto, then "git replay" creates an
empty commit. This is confusing because the commit message no longer
matches the contents of the commit. Drop the commit instead. Commits
that start off empty are not dropped. This matches the behavior of
"git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
--empty-drop".

If a branch points to a commit that is dropped it will be updated
to point to the last commit that was not dropped. This can be seen
in the new test where "topic1" is updated to point to the rebased
"C" as "F" is dropped because it is already upstream. While this is
a breaking change, "git replay" is marked as experimental to allow
improvements like this that change the behavior.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Changes since v2:

 - added a couple of commas to the commit message as suggested by Junio

Changes since v1:

 - modified test to update refs as suggested by Elijah. I've kept
   --ancestry-path --branches rather than switching to --contained as
   I think it is useful to have test coverage for those options and it
   means we can check that empty commits are dropped with out replying
   on --contained working.

This patch is based on ps/history

I think dropping commits that become empty is the sensible default,
if it turns out that some users are relying on the current behavior
we can add an option to retain the empty commits.

Base-Commit: d37c42ea661434c347d2047f01b338341099fa60
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay-drop-commits-that-become-empty%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/d37c42ea6...73ba74b8a
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-drop-commits-that-become-empty/v3

 Documentation/git-replay.adoc |  4 +++-
 replay.c                      | 10 +++++++---
 t/t3650-replay-basics.sh      | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index dcb26e8a8e8..96a3a557bf3 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -59,7 +59,9 @@ The default mode can be configured via the `replay.refAction` configuration vari
 	be passed, but in `--advance <branch>` mode, they should have
 	a single tip, so that it's clear where <branch> should point
 	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
-	"Commit Limiting" options below.
+	"Commit Limiting" options below. Any commits in the range whose
+	changes are already present in the branch the commits are being
+	replayed onto will be dropped.
 
 include::rev-list-options.adoc[]
 
diff --git a/replay.c b/replay.c
index 13983dbc566..2864c213993 100644
--- a/replay.c
+++ b/replay.c
@@ -88,12 +88,12 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
 					  struct merge_result *result)
 {
 	struct commit *base, *replayed_base;
-	struct tree *pickme_tree, *base_tree;
+	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
 	base = pickme->parents->item;
 	replayed_base = mapped_commit(replayed_commits, base, onto);
 
-	result->tree = repo_get_commit_tree(repo, replayed_base);
+	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 	base_tree = repo_get_commit_tree(repo, base);
 
@@ -103,13 +103,17 @@ struct commit *replay_pick_regular_commit(struct repository *repo,
 
 	merge_incore_nonrecursive(merge_opt,
 				  base_tree,
-				  result->tree,
+				  replayed_base_tree,
 				  pickme_tree,
 				  result);
 
 	free((char*)merge_opt->ancestor);
 	merge_opt->ancestor = NULL;
 	if (!result->clean)
 		return NULL;
+	/* Drop commits that become empty */
+	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
+	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
+		return replayed_base;
 	return replay_create_commit(repo, result->tree, pickme, replayed_base);
 }
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index cf3aacf3551..9d4b0dd1a77 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -25,6 +25,8 @@ test_expect_success 'setup' '
 	git switch -c topic3 &&
 	test_commit G &&
 	test_commit H &&
+	git switch -c empty &&
+	git commit --allow-empty --only -m empty &&
 	git switch -c topic4 main &&
 	test_commit I &&
 	test_commit J &&
@@ -106,6 +108,25 @@ test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
 	test_cmp expect result-bare
 '
 
+test_expect_success 'commits that become empty are dropped' '
+	# Save original branches
+	git for-each-ref --format="update %(refname) %(objectname)" \
+		refs/heads/ >original-branches &&
+	test_when_finished "git update-ref --stdin <original-branches &&
+		rm original-branches" &&
+	# Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
+	git replay --advance main topic1^! &&
+
+	# Replay all of A..empty onto main (which includes topic1 & thus F
+	# in the middle)
+	git replay --onto main --branches --ancestry-path=empty ^A \
+		>result &&
+	git log --format="%s%d" L..empty >actual &&
+	test_write_lines >expect \
+		"empty (empty)" "H (topic3)" G "C (topic1)" "F (main)" "M (tag: M)" &&
+	test_cmp expect actual
+'
+
 test_expect_success 'replay on bare repo fails with both --advance and --onto' '
 	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
 '

Range-diff against v2:
1:  9a81644a0ec ! 1:  73ba74b8a2e replay: drop commits that become empty
    @@ Commit message
         replay: drop commits that become empty
     
         If the changes in a commit being replayed are already in the branch
    -    that the commits are being replayed onto then "git replay" creates an
    +    that the commits are being replayed onto, then "git replay" creates an
         empty commit. This is confusing because the commit message no longer
         matches the contents of the commit. Drop the commit instead. Commits
         that start off empty are not dropped. This matches the behavior of
         "git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
         --empty-drop".
     
    -    If a branch points to a commit that is dropped it will be updated to
    -    point to the last commit that was not dropped. This can been seen
    +    If a branch points to a commit that is dropped it will be updated
    +    to point to the last commit that was not dropped. This can be seen
         in the new test where "topic1" is updated to point to the rebased
         "C" as "F" is dropped because it is already upstream. While this is
    -    a breaking change "git replay" is marked as experimental to allow
    +    a breaking change, "git replay" is marked as experimental to allow
         improvements like this that change the behavior.
     
         Helped-by: Elijah Newren <newren@gmail.com>
-- 
2.52.0.362.g884e03848a9

