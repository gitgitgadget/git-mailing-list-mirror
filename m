Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F745D5D0
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932212; cv=none; b=sSgTpgCPVBBCi0aG+EXxvm2CfdopL0n7Q65yTWSnu0v7vzaGZC+3Tw/SInJLrgo+8+CCgA+rBftjl3K6lZpdE/fyT+TMa4STHO6+4W1DcdO30mXKtCG/Fx9zVJf29Bbfy4M4xUtiR6DXbRZBELQyXUDNPb1BBIO1LiSkK1b3xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932212; c=relaxed/simple;
	bh=QpSqFmCXWI2qiMpvOIHCtvhA9roYgntNEyfu7FpHuBE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XnDXIB4h9nkGrpljpZIZoFWfCGQtUeHWy4jL6h/rGjkJYVmxZ5zyjTdZWzRkq2sQNZpNGjMhLwsqfYtbEvT6oUEFH7dzDIC8JJHk9osKM/U8ZqXdLdI1wt7bzhcKkFbyXyPlBmMLmQyorB7ae17HXpzcnWM1BdrtYsoqwvnnAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqEJHPp7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqEJHPp7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e27035206so645148b3a.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932210; x=1786537010; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GIxfxglBUaMVSr9Db6xMAFHWg+2KKJ0TDXSruLfokLM=;
        b=sqEJHPp7QuFbOTImAqc8p7W0d495uiCvA2rhRDyEcY32KWLuxMq3RB5fieDi+4CBej
         o+mcc3+/+zSa3kDbbapKgsCy5ZMPc4s2SYsUQU1gPfAY9gVC/O/pNpQ3n/alF3Cmbx68
         lKl+fMxRBVLWy5DGHn60RDREdYNnIo84bJrqjrKIs8ZuHeUm8yegwvlG02IP9C+aodcy
         hBdjapBK4Yca8Z6bGp2McgZVTm/Z0Y4/YACfgZ59dVkkjw1WureZzGIqxFSECMnztBjy
         Fb8VO/P7+ia7XjSHEfAQfPoSmT9mVeq+2bMHNpqdFBTnQYTDYLkR95EPPp2z49oFJX9Y
         RWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932210; x=1786537010;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIxfxglBUaMVSr9Db6xMAFHWg+2KKJ0TDXSruLfokLM=;
        b=guaa7aYfrR6nLVSPlBPUHhYZPPotjBl7oqnq6yFsMhTAxRXZnFPjMtA5MB7Y2bfB4q
         WZGzH6b/5UTRFavMMDlFlhBS4yh4HtMepBF1AO8RSGMHnER5rZVbA23W3qqacV2UYtTg
         BCTa3tfQ36Dn7156mFpaMDpkP3tSfz6JJ9Hwgs0cejhfS91Ru7nrRuxgSXDfA+ppA5MS
         lOD7bYXdhayoe3AIvw5KWZc9KsMN2PTptOQWun4+S5hjseAxRSST0FqIpirn7e/04oa6
         suDyQi9gLlC36MKB99hun60GHzr39VqMBInGtDk0iilF36cp5aXKkwWA5c6lFOjV4hCw
         U0KQ==
X-Gm-Message-State: AOJu0YxdEkPtJyuNZRd1++oCONkoAQCd+WmEEBmPyeX3VDsDyE39IJZf
	W7yQWIo16Khhtj1mRd4fV0GdZu/8/W8gDYn3bLlrCKAasfrssu9kmOXP/3Af2g==
X-Gm-Gg: AR+sD10NHJNg7q+68ssxe9d02wvuAffz626Qz/GtR8gpSUH08zide6vt7J2442CUAn7
	+9Zmf8f+i8QO3amrTRdYnUDXHvDHqK9sfqzAnTtVtjKu/HyPj6T3VQ+hZAi6Au8i7Oy3lNsx7lN
	qfE7TSAxdfJK+1bMF47Mluh0kPYDI5wiHRQZNWRozPT5yGSmI5Z1UmOgDnFKWlpWKY22cA31StN
	bpDO/X71IABsua2c3Hd+dhUlfJI2659n8yKImBRhLnvJA1R3+RbUPLn3Ys1pzVF090EG75kg44b
	NWKzlRRut+DE1yK7k6inNXsOb37uGbRYsGxNxkyo58JcE24cnkswMqZooWm0geWMGctl+dI4G+C
	3To2txOtliIlA/D9qnv8eiRWHJZjY5U+RBUMLWLlqXxI8sdmKLMgxbIpSkcVJvVsfF0AVwfUS6J
	SE7SX+2vjkdRGkNnbHcqTnb9wc34/lonxJmf8bjdEE3dKbD8jxuEWKX+nR7KAAQ3qHTEVb1SY=
X-Received: by 2002:a05:6a00:450b:b0:84a:2c46:3fdb with SMTP id d2e1a72fcca58-84f2dfd0762mr7190430b3a.5.1785932210068;
        Wed, 05 Aug 2026 05:16:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.3.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708bfae6sm1456623a12.20.2026.08.05.05.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:16:49 -0700 (PDT)
Message-Id: <pull.2192.v2.git.1785932208004.gitgitgadget@gmail.com>
In-Reply-To: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 12:16:47 +0000
Subject: [PATCH v2] worktree add: shouldn't dwim if -b or -B is given
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
Cc: Jacob Abel <jacobabel@nullpo.dev>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

git worktree add <path> <branch> DWIMs <branch> to a
remote-tracking branch when neither -b, -B, nor --detach
is given.

However, git worktree add -b <new-branch> <path> <branch> can
still DWIM <branch>, causing <new-branch> to be ignored.

This is a regression introduced in v2.42.0
(128e5496b325640f0a09cc1d5b1e346c069b410f).

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: shouldn't dwim if -b or -B is given

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2192%2Fyoichi%2Fworktree-add-should-not-dwim-with-b-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2192/yoichi/worktree-add-should-not-dwim-with-b-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2192

Range-diff vs v1:

 1:  908a32fb56 ! 1:  b00f6c2fa1 worktree add: shouldn't dwim if -b or -B is given
     @@ Metadata
       ## Commit message ##
          worktree add: shouldn't dwim if -b or -B is given
      
     -    'git worktree add <path> <branch>' DWIMs <branch> to a
     +    git worktree add <path> <branch> DWIMs <branch> to a
          remote-tracking branch when neither -b, -B, nor --detach
          is given.
      
     -    However, 'git worktree add -b <new-branch> <path> <branch>' can
     +    However, git worktree add -b <new-branch> <path> <branch> can
          still DWIM <branch>, causing <new-branch> to be ignored.
      
          This is a regression introduced in v2.42.0
     @@ Commit message
      
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
     - 
       		/* DWIM: Infer --orphan when repo has no refs. */
       		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
     --	} else if (ac == 2) {
     -+	} else if (ac == 2 && !new_branch) {
     - 		struct object_id oid;
     - 		struct commit *commit;
     - 		char *remote;
     + 	} else if (ac == 2) {
     +-		struct object_id oid;
     +-		struct commit *commit;
     +-		char *remote;
     +-
     +-		commit = lookup_commit_reference_by_name(branch);
     +-		if (!commit) {
     +-			remote = unique_tracking_name(branch, &oid, NULL);
     +-			if (remote) {
     +-				new_branch = branch;
     +-				branch = new_branch_to_free = remote;
     ++		if (!new_branch) {
     ++			struct object_id oid;
     ++			struct commit *commit;
     ++			char *remote;
     ++
     ++			commit = lookup_commit_reference_by_name(branch);
     ++			if (!commit) {
     ++				remote = unique_tracking_name(branch, &oid, NULL);
     ++				if (remote) {
     ++					new_branch = branch;
     ++					branch = new_branch_to_free = remote;
     ++				}
     + 			}
     + 		}
     + 
      
       ## t/t2400-worktree-add.sh ##
      @@ t/t2400-worktree-add.sh: test_expect_success '"add" <path> <branch> dwims' '
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" <path> <branch> dwims' '
       '
       
      +test_expect_success '"add" <path> <branch> does not dwim with -b' '
     -+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
     ++	test_when_finished rm -rf repo_upstream repo_dwim wt &&
      +	setup_remote_repo repo_upstream repo_dwim &&
     -+	git init repo_dwim &&
      +	(
      +		cd repo_dwim &&
     -+		test_must_fail git worktree add -b branch ../foo foo
     ++		test_must_fail git worktree add -b branch ../wt foo 2>actual &&
     ++		test_grep "^fatal: invalid reference: foo" actual
      +	)
      +'
      +


 builtin/worktree.c      | 22 ++++++++++++----------
 t/t2400-worktree-add.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..cc46c1b415 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -898,16 +898,18 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
-		struct object_id oid;
-		struct commit *commit;
-		char *remote;
-
-		commit = lookup_commit_reference_by_name(branch);
-		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
-			if (remote) {
-				new_branch = branch;
-				branch = new_branch_to_free = remote;
+		if (!new_branch) {
+			struct object_id oid;
+			struct commit *commit;
+			char *remote;
+
+			commit = lookup_commit_reference_by_name(branch);
+			if (!commit) {
+				remote = unique_tracking_name(branch, &oid, NULL);
+				if (remote) {
+					new_branch = branch;
+					branch = new_branch_to_free = remote;
+				}
 			}
 		}
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..ba3bec078f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> does not dwim with -b' '
+	test_when_finished rm -rf repo_upstream repo_dwim wt &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	(
+		cd repo_dwim &&
+		test_must_fail git worktree add -b branch ../wt foo 2>actual &&
+		test_grep "^fatal: invalid reference: foo" actual
+	)
+'
+
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&

base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
-- 
gitgitgadget
