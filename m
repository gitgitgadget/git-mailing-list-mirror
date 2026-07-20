Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05627238C16
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586691; cv=none; b=Wa2j1kwc5qrrjKpcfXEo/Fr69etkVB87a0NGBdoBqAB2CMKnW0+0L4Z1DLPniGjalhOuKBQZ1KXc+CwTgOy6qMw8lWW87YFXcUEw4MmnwUeZ6dXdSCs+9iN54GMKTfSWs39khAgAtbgy57Xsj2PWPa1vUx6iRN4IE243mwywYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586691; c=relaxed/simple;
	bh=rhc418z548Im6VQ4lZ7cuyG3Eng3r6q4kGf4AtRm4IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbGA9OJujTnmeFsJgE3/X+/pf/IMTcBy0dN5ba884gNLmsk/GFB7TGGyBFpefvRYb6pNGJvUZNU/hk5Yt0lD5cC1R9t0WyW72RcgwDG9eoy5ZgZ62/0X9xpT3PQaOmaq7dKA/RftCOHVp1ltiLuYD+9LMkJaQmKjv5p8PqDZixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=hAEUx+G4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="hAEUx+G4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0dfdcf00so11049811cf.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784586689; x=1785191489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UahiKgHN/GG9jBgNCTQjv4b12OyhHSRTji9Sk6xDgpI=;
        b=hAEUx+G4N8ANSbkKAlpXDDEW+Pji6ywMzwOLVxiGa/Z6NRI2/YHRxYjSoIveouv0/3
         0U+7UVUqLdCfkYhSgSlbu3l2w/tnLcabMFEMxHSV7JWSjwSSFHjeBXo75MpO4BX9pMlp
         nYdtCZSflnE9CnHzwaM+FvniEQYgq4eWsDPvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586689; x=1785191489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UahiKgHN/GG9jBgNCTQjv4b12OyhHSRTji9Sk6xDgpI=;
        b=tTXNjnyNlqgC1WemBpt5bpaYc6bRg4DahrTHFZpsuuHMOesDN2bN20b8y6s76GwuyP
         ekB8uH/2ajaW3aE6XNkodV0afUIMpqkql8FhM0lELHg20lY25bb1mHONaoOqwb4yyFJ4
         RoTQmbTVbgf8pf4dFa1nIFBaCKUimMpCRFGICuzuGVrZJP5YyfxpoH9kPDlTKn2UKHbb
         NH0fd7IxTKlpmEmRQlB3SgIYb38wX+GskXUMl17J/uZgtifhbnNbxKOTnku5Of1ViiDG
         GvLEVlFodIzOuw2Xg4p2up00pN4D0vxlLXZbldwzvdSfXYeZCmW/BFdDGVV6RIDMlGhu
         VpIA==
X-Gm-Message-State: AOJu0YxiKXVDq6ArxCrFkujlIYdkgsPx7RqXb1kVX2VVD07Ti6LgkbNO
	zfjqGR2Dc0ISnYv2X+uZceW0MKUhLd/j5JZ53bC2wJubifLdtMmSJebdH5aIpMvO3lLHWC0ydK+
	p+P2juas=
X-Gm-Gg: AfdE7cnZdDHAAZzoA93d3v5i66g27+kG+qgHeW7jbwOgVtkTr3aSJv9dCKxFDwrjSt6
	44sDqmw/WN8AWjoW4CvYfMpwSRh2EhHMDWSgHqtPgmKe0OwpzPeDgEfB5NiV2u1h/VT83i1SqFu
	DzoxaNMj2ADMOxp+QA3bymR7zCOvXRWv4CR6IMW4GX3Ez1IT4Zx7k7GT74hnALVnzOOggZyu5WW
	eE1NpyxvHqEdWzIsFhz4w9u5ug14jjUfbMIQA/b8XX047g+PSpRKXUwgT16DOgpNMsjB9R4tbXu
	MZrkMeWYJRrIWDcS40MYBLqzf6kM03v/C7k07uxr4YG4o2bvJQHRV/KThze4yUZOEUEb3vk4ycX
	O8bkGHu+IUSiLEVI6KCjt/2ug9aMn4bzxAQLllAO+ZjtgcVNWZ7WGO40RQ0xb/fb26IDh0BbQYW
	KQOGZjJ7hl/u9xcWmBRq5NzIU6GbNlOA/nKszExOxJVxarH3miY3VhyRQfw6TTztzgnMF2sGZzu
	u+hNyI=
X-Received: by 2002:ac8:6145:0:20b0:51a:88bd:95a0 with SMTP id d75a77b69052e-5213c109e32mr94970211cf.1.1784586688743;
        Mon, 20 Jul 2026 15:31:28 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214d095ed4sm81232211cf.10.2026.07.20.15.31.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 15:31:27 -0700 (PDT)
From: tnyman@openai.com
To: git@vger.kernel.org
Cc: Ted Nyman <tnyman@openai.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH 2/2] stash: avoid sparse-index expansion for in-cone paths
Date: Mon, 20 Jul 2026 15:31:21 -0700
Message-ID: <20260720223118.62821-6-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720223118.62821-4-tnyman@openai.com>
References: <20260720223118.62821-4-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ted Nyman <tnyman@openai.com>

`git stash push -- <pathspec>` expands a sparse index before checking
whether the pathspec matches any tracked paths. This is unnecessary
when the pathspec is wholly inside the sparse-checkout cone and makes
a path-limited stash proportional to the size of the full index.

Use `pathspec_needs_expanded_index()` to expand only when a pathspec
can match part of a sparse-directory entry, as `git rm` and `git
reset` already do. Keep the full-index behavior for pathspecs that
need it.

Add compatibility coverage for literal, prefixed, wildcard, file,
multiple, staged, and missing pathspecs. Add the corresponding
path-limited stash case to p2000.

On a cone-mode repository with 349,525 tracked paths and 49 sparse
index entries, the best of three runs changed from 18.87s to 0.06s.
Trace2 reported four index expansions before this change and none
after it.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 builtin/stash.c                          |  4 +-
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index c4809f299a313b..72c52571f8c06c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1702,8 +1702,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	if (!include_untracked && ps->nr) {
 		char *ps_matched = xcalloc(ps->nr, 1);
 
-		/* TODO: audit for interaction with sparse-index. */
-		ensure_full_index(the_repository->index);
+		if (pathspec_needs_expanded_index(the_repository->index, ps))
+			ensure_full_index(the_repository->index);
 		for (size_t i = 0; i < the_repository->index->cache_nr; i++)
 			ce_path_match(the_repository->index, the_repository->index->cache[i], ps,
 				      ps_matched);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index aadf22bc2f0bb2..548a61cd9064bc 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -108,6 +108,7 @@ test_perf_on_all () {
 
 test_perf_on_all git status
 test_perf_on_all 'git stash && git stash pop'
+test_perf_on_all "git stash push -- $SPARSE_CONE/a && git stash pop"
 test_perf_on_all 'echo >>new && git stash -u && git stash pop'
 test_perf_on_all git add -A
 test_perf_on_all git add .
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d0b42371663f9d..4140c4d8ef2436 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1598,6 +1598,61 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash pop
 '
 
+test_expect_success 'sparse-index is not expanded: stash in-cone pathspec' '
+	init_repos &&
+
+	echo unrelated >>sparse-index/deep/e &&
+	echo literal >>sparse-index/deep/a &&
+	ensure_not_expanded stash push -- deep/a &&
+	test_grep ! literal sparse-index/deep/a &&
+	test_grep unrelated sparse-index/deep/e &&
+	ensure_not_expanded stash pop &&
+	test_grep literal sparse-index/deep/a &&
+
+	echo prefixed >>sparse-index/deep/a &&
+	ensure_not_expanded -C deep stash push -- a &&
+	test_grep ! prefixed sparse-index/deep/a &&
+	test_grep unrelated sparse-index/deep/e &&
+	ensure_not_expanded stash pop &&
+	test_grep prefixed sparse-index/deep/a &&
+
+	echo wildcard >>sparse-index/deep/a &&
+	ensure_not_expanded stash push -- "deep/a*" &&
+	test_grep ! wildcard sparse-index/deep/a &&
+	test_grep unrelated sparse-index/deep/e &&
+	ensure_not_expanded stash pop &&
+	test_grep wildcard sparse-index/deep/a &&
+
+	echo pathspec-file >>sparse-index/deep/a &&
+	echo deep/a >pathspec-file &&
+	ensure_not_expanded stash push --pathspec-from-file=../pathspec-file &&
+	test_grep ! pathspec-file sparse-index/deep/a &&
+	test_grep unrelated sparse-index/deep/e &&
+	ensure_not_expanded stash pop &&
+	test_grep pathspec-file sparse-index/deep/a &&
+
+	echo multiple-a >>sparse-index/deep/a &&
+	echo multiple-e >>sparse-index/deep/e &&
+	ensure_not_expanded stash push -- deep/a deep/e &&
+	test_grep ! multiple-a sparse-index/deep/a &&
+	test_grep ! multiple-e sparse-index/deep/e &&
+	ensure_not_expanded stash pop &&
+	test_grep multiple-a sparse-index/deep/a &&
+	test_grep multiple-e sparse-index/deep/e &&
+
+	echo staged >>sparse-index/deep/a &&
+	git -C sparse-index add deep/a &&
+	ensure_not_expanded stash push --staged -- deep/a &&
+	test_grep ! staged sparse-index/deep/a &&
+	test_grep unrelated sparse-index/deep/e &&
+	ensure_not_expanded stash pop --index &&
+	test_grep staged sparse-index/deep/a &&
+	test_must_fail git -C sparse-index diff --cached --quiet -- deep/a &&
+
+	ensure_not_expanded ! stash push -- deep/does-not-exist &&
+	test_grep "did not match any file" sparse-index-error
+'
+
 test_expect_success 'describe tested on all' '
 	init_repos &&
 
