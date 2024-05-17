Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C6947A
	for <git@vger.kernel.org>; Fri, 17 May 2024 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715917644; cv=none; b=ixcoOuzJB76o+3wypv5X/OQYtR8TnCJCXbg1qicllb8h7JH8mzUm3yFpJaeNy/8OwuGaOOxrZq/gfCYLp6kYDZS09THRg7702seUIUxiVGYdcWSujsr1wL0/RNBsof+kZEJ4sgM+xzKJVBkS7X+Z9hOTiQHa4+Dy//Ra/cuXrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715917644; c=relaxed/simple;
	bh=QUX5SeO0hix6KgHvDpKpqG4ikcWaMeKP49pEmmVWPjY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l5bk5/zanSTc+ByUwunhLhzJgWdJC341josuOAKX1Mmhzv7A1qbAswfjpmzlYmsubh0rD3DSn4KOg8RR4OUMssLZxaBpwK4okK9OdHzDYzTgi/rX9JR4L6bvbwFn/VAZJ03oRju/SEQaCXofsdRco3CwsFtTZ6OkJKCSRxPh2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtZmUFzX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtZmUFzX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-351b683f2d8so4388116f8f.3
        for <git@vger.kernel.org>; Thu, 16 May 2024 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715917641; x=1716522441; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wERnsrYIu8lXJPrOK4hFv5hApe2GoCMn7sDOTIkGlUk=;
        b=FtZmUFzXbm4XDjzjUlSC7VT211H5fUD0OA/T8UemgKFK15cqDaWWlVcgb7HYg/dDnr
         /knekjaWef2vt67viCGZfngLuBxb0BTYCNiuAjDIePkysHempvOgQnO13YVNNe/XVoVL
         MyqsjWvLfxkkeV0O+yaPielG5ik1Ta26Rati+O4lPr0V1MPwuYbjq6FUWfIWw1p9D9HY
         VfsTUYAd1bZkaOMnXO+cKxfFYqC76RFs/2MJSK9JwoPh3W6r0d3AJD3IRDFSmvbJjZtG
         +516CQ7IwwFhAfGPjUfSNb9N7MnafP7bnIbx/BF0ZsP66P746hK7u5ID5wez13AU+NsB
         U+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715917641; x=1716522441;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wERnsrYIu8lXJPrOK4hFv5hApe2GoCMn7sDOTIkGlUk=;
        b=FNh+cmp2+kQH5RC0Puu8isCMBvKYwSySquncwP2oNPyGahq0RubQ2jdf+TLnFusWQ6
         cs37ssGxa0f+/UznLSU49x/irJUvhI8aAo3E5kcYwQ/GrdBS7zMiRjTU9SZSS93RiKzV
         GlHtYYvXd1HrOe+0G5sUBRTFoibHDyHhxt/i9jnW/ca+rqFiYHBaVtw39CVQtKeMoyfM
         AxZXABJ3nUldIeeNpnRIhTFgot5icCxQ7qiBd1QsORGf47JnoVR94Rka10ROV/0T6koc
         uOP7HhN5RaOQ6XJ0Z4WKGpbroQeVnJFL3UPp6V1wvMqmj3otVmUaoow+zqFxi60ZQVpk
         jUew==
X-Gm-Message-State: AOJu0YzC5e5qHaAEEATvMeSsUF/fs+2DyJaNERt2oLbl6QQ1+fXNQGhd
	/JFZNM5dZuqbzzxC7M1EV15zCTAsuq/hLy5vOu69qrqIDDUbQXrr+q2cNA==
X-Google-Smtp-Source: AGHT+IEgcuxe/t38LyTx9BDi9Cgu4QzdzewGXfGFju4VkGUzA5a9BmDM+nouh8QXTSGBULLfkQbrOw==
X-Received: by 2002:adf:f0cf:0:b0:34d:86ef:eefa with SMTP id ffacd0b85a97d-3504aa66a84mr14643520f8f.65.1715917640798;
        Thu, 16 May 2024 20:47:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bcf9sm20644841f8f.6.2024.05.16.20.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 20:47:20 -0700 (PDT)
Message-Id: <pull.1731.v3.git.1715917639587.gitgitgadget@gmail.com>
In-Reply-To: <pull.1731.v2.git.1715836731784.gitgitgadget@gmail.com>
References: <pull.1731.v2.git.1715836731784.gitgitgadget@gmail.com>
From: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 03:47:19 +0000
Subject: [PATCH v3] merge: avoid write merge state when unable to write index
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
Cc: Kyle Zhao <kylezhao@tencent.com>,
    Kyle Zhao <kylezhao@tencent.com>

From: Kyle Zhao <kylezhao@tencent.com>

When running a merge while the index is locked (presumably by another
process), the merge state is written, the index is not updated, and then
the merge fails. This can cause unexpected results.

i.g. if another running process is "git commit", MERGE_HEAD and other state
files we write on our side will be taken into account by them and cause them
to record a merge, even though they may have been trying to record something
entirely different.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    merge: avoid write merge state when unable to write index
    
    In some of our monorepos, code is sometimes lost after merging.
    
    After investigation, we discovered the problem.
    
    This happens if we perform "git pull" or "git merge" when another git
    process is writing to the index, especially in a monorepo (because its
    index will be larger).
    
    How to reproduce:
    
    git init demo
    cd demo
    touch 1.txt && git add . && git commit -m "1"
    git checkout -b source-branch
    touch 2.txt && git add . && git commit -m "2"
    git checkout master
    echo "1" >> 1.txt && git add . && git commit -m "3"
    # another git process runnning
    touch .git/index.lock
    git merge source-branch
    # another git process finished
    rm .git/index.lock
    git commit -m "4"
    
    
    Then the modifications from the source branch are lost.
    
    Regards, Kyle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1731%2Fkeyu98%2Fkz%2Ffix-merge-when-index-lock-exists-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1731/keyu98/kz/fix-merge-when-index-lock-exists-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1731

Range-diff vs v2:

 1:  86101e5b778 ! 1:  138fe0a054d merge: avoid write merge state when unable to write index
     @@ Metadata
       ## Commit message ##
          merge: avoid write merge state when unable to write index
      
     -    Currently, when index.lock exists, if a merge occurs, the merge state
     -    will be written and the index will be unchanged.
     +    When running a merge while the index is locked (presumably by another
     +    process), the merge state is written, the index is not updated, and then
     +    the merge fails. This can cause unexpected results.
      
     -    If the user exec "git commit" instead of "git merge --abort" after this,
     -    a merge commit will be generated and all modifications from the source
     -    branch will be lost.
     +    i.g. if another running process is "git commit", MERGE_HEAD and other state
     +    files we write on our side will be taken into account by them and cause them
     +    to record a merge, even though they may have been trying to record something
     +    entirely different.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
      
       ## builtin/merge.c ##
      @@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct commit_list *common,
     - 
       	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
       					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
     --					 NULL) < 0)
     + 					 NULL) < 0)
      -		return error(_("Unable to write index."));
     -+					 NULL) < 0) {
     -+		error(_("Unable to write index."));
     -+		return 2;
     -+	}
     ++		die(_("Unable to write index."));
       
       	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
       	    !strcmp(strategy, "ort")) {
     @@ t/t7600-merge.sh: test_expect_success 'merge c1 with c2' '
      +test_expect_success 'merge c1 with c2 when index.lock exists' '
      +	test_when_finished rm .git/index.lock &&
      +	git reset --hard c1 &&
     -+	touch .git/index.lock &&
     ++	: >.git/index.lock &&
      +	test_must_fail git merge c2 &&
      +	test_path_is_missing .git/MERGE_HEAD &&
      +	test_path_is_missing .git/MERGE_MODE &&


 builtin/merge.c  |  2 +-
 t/t7600-merge.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6a6d3798858..12c1b048fe1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -699,7 +699,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
 					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
 					 NULL) < 0)
-		return error(_("Unable to write index."));
+		die(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
 	    !strcmp(strategy, "ort")) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5ff073099a..c1958095dcf 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -236,6 +236,16 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
+test_expect_success 'merge c1 with c2 when index.lock exists' '
+	test_when_finished rm .git/index.lock &&
+	git reset --hard c1 &&
+	: >.git/index.lock &&
+	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_MODE &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_expect_success 'merge --squash c3 with c7' '
 	git reset --hard c3 &&
 	test_must_fail git merge --squash c7 &&

base-commit: 19fe900cfce8096b7645ec9611a0b981f6bbd154
-- 
gitgitgadget
