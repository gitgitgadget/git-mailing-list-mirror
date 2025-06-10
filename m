Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C211A8401
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546470; cv=none; b=A37y2S0/QcVTTHwaqLeeEk5Zk2H7+nQG4QA1tpoGIeKWvqc059KYQSfbvBnkF1KHBEtvzHo9uHeQUAQicE4WadEdIKYW9a30iQ7kuaqX2Fb120QuZ2W1JWpRqNx3OW8nFzBgfuPUbn0V9Uvcyux1TTg5A+SOdGQYFXzckSlUYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546470; c=relaxed/simple;
	bh=1oLif27NMBc6qPOo6T8RItia94WHAGkP7/5jwMjsw4Q=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Xpr+851U1xUXEbNmJ5yU9TveyNeGZ1l6zV/hpI85VBUMr0JVCT/6w9bqs7N2Gysx8IuVsKREvfetIDHhnEecRjamudVvHqddNm/wGe4H4/1c6c5DylWxR0k6+3HQ6CBmXdv0I6YBeKmMpFDP3yG5qcQiH3DP2ym54ZqjYrsvXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frebhG2W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frebhG2W"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce671a08so32846495e9.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749546466; x=1750151266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ISyJu5/EwG4J4C28LdEfOk2eTd1l7GN7Pme9OcJ1GaQ=;
        b=frebhG2WuPdIzUWji5gm53AA/SZOWHPzb44zjR487HOdV+Z48Ce5wS5o+s2db9eWtc
         iOdR2AfB3Yhk+esgzk95ld8/V/nqvVOrOjSmm87talj34V/+GcGK17N3mLoZxsz6QhsJ
         SUBxwYMOOngfMMFmufNMA2joYZVHt8B51YVDjf55t1PC3b6TWbEDZwnmkQYxjYyjx3rC
         ie2K6Ly31LOfFbp/fCdpyqOUIm0B9Srbflz5wVcp9wdLXX8m+vSohbKhkhhxCU4oSpJ4
         k7YuUH0X9djSOU1zw9Xcf5F3OeDcATTOJxcijJ872OkHaxSC/YcNnCk/YMbvKWAj3lVH
         bx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546466; x=1750151266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISyJu5/EwG4J4C28LdEfOk2eTd1l7GN7Pme9OcJ1GaQ=;
        b=ew/IByKbfFZGevOWj7toTL1NgByQEvLROFXsgNM+Q8rY4g68KIec+BsYpjl2mGLyQO
         THWjctkKHjLhBtRrHALXcOKhNpMYDVc6tmuU31mNTJ/8vgjPYIFlVUQB3guxV5Kgc0L1
         WTuPqGk6B4nYuSZOGS2T//p+19KG6aqDFUkuJ6V2Umx1c37T1twJvgvqZedxJ6w6+9zj
         WV3tLBN3nvhF7ZoXl/N5fv8J0eGWRJ6yuYxH55r/zHhjPD5pY8LUT+pv/ZY7m90TYHVD
         Tp+p0amkf+mQSysG1FVdzWMGYxozCCvdEy7SxZD3sVyNtYv3LY9ML6Eh+C7CcoEZqECf
         PWbQ==
X-Gm-Message-State: AOJu0YwT7YsYzb2NZmi57tcCs4eC1QZ2n9S4NC2QC+b1bn86t2AohCeT
	19ViXu6cfSJ62ZtuNaD4U7AvY0+7IJtOZoST+0ViEGj8dC85u00poARB/qdsHg==
X-Gm-Gg: ASbGncsdyEAq1CESqDgQwYmpPrB72x4kSHkZkNSTnO0RfdAkFjXOGNjmhn/1Xc8Mx4U
	W7UFiSF9f3shdg33l97ETfoI8qNktpYGYwEIaou/94WNITIRN0MhnkOl/tzs9Zz8PKjIjA28B6E
	50EvT6+j0Hk362xIXQSqCVepLJjKru8sUXxik1AtYyvAHbupvOvzxfZCDw3M2aP21U+36doAiCK
	nOoqrvZXrNQ6QJFHp3qXqB6rCBpIFUmQSn3Wo5sykNoIUDaX/MRT7/ovG3p2+Tvd8PzxeYgO2YN
	R9rrgwSngjmom9uB28YHp/O+vZ/hKWLNLHClUARsSmWzSa1FdOuWVbkv/DVVVuE=
X-Google-Smtp-Source: AGHT+IEf6+LCJ+Yv8C0QR/+WOflDO1RpDvCrjQ1yC6tFRYLcPjMkthHJx4EKKavZyHoSs9TdGHRaNA==
X-Received: by 2002:a05:600c:34c1:b0:450:cf46:5510 with SMTP id 5b1f17b1804b1-45201436a61mr146963505e9.29.1749546465689;
        Tue, 10 Jun 2025 02:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213709637sm134205045e9.26.2025.06.10.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:07:45 -0700 (PDT)
Message-Id: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
From: "Andrea Stacchiotti via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Jun 2025 09:07:44 +0000
Subject: [PATCH] branch: move multiple branches in a single --force
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
Cc: Andrea Stacchiotti <andreastacchiotti@gmail.com>,
    Andrea Stacchiotti <andreastacchiotti@gmail.com>

From: Andrea Stacchiotti <andreastacchiotti@gmail.com>

Using either the 1-arg or 2-args form of --force
it is possible to only move one branch at a time,
to HEAD and <arg2> respectively.

Allow moving multiple branches to a single target by giving
'git branch --force b1 b2 b3 ... dest' cp-like semantics,
all the branches are moved/created to 'dest'.

The convention extends the 2-args form in the same way
'cp a b c ... dest' would do.

There could be another potential interpretation of
`--force a b c`: moving all 3 to HEAD, but the 2-args
form already changed the semantics to cp-like instead
of appending an implicit HEAD, so this seems the least
surprising way to support multiple moves.

No such change is done to the move/copy paths,
as such paths would error out anyway by trying
to create multiple branches of the same name.

Signed-off-by: Andrea Stacchiotti <andreastacchiotti@gmail.com>
---
    branch: Move multiple branches in a single --force

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1992%2F12345ieee%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1992/12345ieee/master-v1
Pull-Request: https://github.com/git/git/pull/1992

 Documentation/git-branch.adoc |  2 +-
 builtin/branch.c              | 26 ++++++++++++++------------
 t/t3200-branch.sh             |  7 +++++++
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424d..817b4a5d3f6 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -17,7 +17,7 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
 git branch [--track[=(direct|inherit)] | --no-track] [-f]
-	   [--recurse-submodules] <branch-name> [<start-point>]
+	   [--recurse-submodules] <branch-name>... [<start-point>]
 git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
 git branch --unset-upstream [<branch-name>]
 git branch (-m|-M) [<old-branch>] <new-branch>
diff --git a/builtin/branch.c b/builtin/branch.c
index c150131bd9f..8ba04568c15 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -31,7 +31,7 @@
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
-	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
+	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name>... [<start-point>]"),
 	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
@@ -992,9 +992,9 @@ int cmd_branch(int argc,
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
-	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
-		const char *branch_name = argv[0];
-		const char *start_name = argc == 2 ? argv[1] : head;
+	} else if (!noncreate_actions && argc > 0) {
+		const char *start_name = argc == 1 ? head : argv[argc - 1];
+		int iters = argc == 1 ? 1 : argc - 1;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
@@ -1003,15 +1003,17 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		if (recurse_submodules) {
-			create_branches_recursively(the_repository, branch_name,
-						    start_name, NULL, force,
-						    reflog, quiet, track, 0);
-			ret = 0;
-			goto out;
+		for (int i = 0; i < iters; i++) {
+			const char *branch_name = argv[i];
+
+			if (recurse_submodules)
+				create_branches_recursively(the_repository, branch_name,
+								start_name, NULL, force,
+								reflog, quiet, track, 0);
+			else
+				create_branch(the_repository, branch_name, start_name, force, 0,
+						reflog, quiet, track, 0);
 		}
-		create_branch(the_repository, branch_name, start_name, force, 0,
-			      reflog, quiet, track, 0);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e720dc10d..7cd31ca7820 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -60,6 +60,13 @@ test_expect_success 'git branch --force abc should succeed when abc exists' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --force br1 br2 abc should create 2 new branches' '
+	git branch --force br1 br2 abc &&
+	test_ref_exists refs/heads/br1 &&
+	test_ref_exists refs/heads/br2 &&
+	git branch -d br1 br2
+'
+
 test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c &&
 	test_ref_exists refs/heads/a/b/c

base-commit: 4c0e625c091d4c648cec7319bafaed3cc81658e5
-- 
gitgitgadget
