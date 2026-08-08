Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339333A783B
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177305; cv=none; b=Bg2cAoynsTsFt/HMQddxVApSm9HkOBbZz688xpx+U0GpR/WbQHR9HFSgsVLjoyJXNPgDFFZInUT5Ge7UpmX6vt9JSvPUcpNGI05BBpjh1eQ/F6hrURtOVMLfjT7X+ahKvtnl7/62gMtYu6SAR59NWYFrhRp5gg09olf5da1dvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177305; c=relaxed/simple;
	bh=ZMDkRNf+QZypxyKgCMfFoS57V7lIZOh7Ta7UVsiA0fE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PCd3QqihvtDT+iGf88igXMKG9vWMPGSKAR4eUMFlqjpqhrlGeED4QIpqLu092Xm9s/IDZOQLj83ywRQOyyJ7ZVMCK/lKFLsrnaZNENSgG/d4FF4PikFiIJAoBOgFtu0JtyEQXy4+G9NHpuOJWlOWLwucw2tyOXOkniUQhQqWdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGtahsmp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGtahsmp"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-936623c6dd3so133700585a.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786177303; x=1786782103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dkT8EHBVkgEQCVMeFtjbV+OgpU4MiQVb8CVWMLiI8xg=;
        b=gGtahsmp4GW7BDMb1gbgBTgGQpW4nx4ZylrsgIeNeyMXCoqneoHdpe67XXM8OLLNvB
         QfZfPK0IcEajTFIitdjQgrkg72TooO0Bv1PWXKSzpk5MDlKjVnmI+g1zq+eidcd+UCfk
         kLOOtQFOgd3uLhhiKa3JVPTZ1yI0brF34K3RRCE8Gtdx7CRuMcOW5XETW9lmPaj3t/vQ
         acu/2rxJiMGRKkNSDXiRH2vEwS7l1vJzEIA+aTau0UygLtX4v44LGELAtDmcQAHhtz/F
         xeNFMZuv+j7W/gUVHHiJWRJWWXKGLDc2xHirRI063IU7Ez9nF/eojUKMzzx5Ifol5DfZ
         3Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786177303; x=1786782103;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dkT8EHBVkgEQCVMeFtjbV+OgpU4MiQVb8CVWMLiI8xg=;
        b=e04Izb5Bu9UKQjgO0Qtv7KMZdZtwLU7hRh9ASYzMkF46hZSvFzsoGP8Av5RUsg89cj
         KM2ii9uxMgf08MXColOL/8bZz9AQ54zyjX3mC38VCwmXqVg6lfeR73Fp2/DlZWK3VOcr
         C0WCZW+jZqT/Cx50XgIDw2MardihyOtopJkce+ktG58RpNgoko0PEaAB1hAgMWnDMCCD
         6Gbf6C5bKGR4kXj9a6Dbr1J/e4TsA76QexfuZmHsy/xT3H36Pm0Y0MAG6t8Gsr9L3vTp
         MBiU+LmJHe59e1TBqoeTd4iakbSu0AuxBaMYuMwcukfIKgXPaLiqKgwDz1OPE3nhf0ej
         nBAA==
X-Gm-Message-State: AOJu0YxPI8kkW9c0yMnRNL7ip6vfE4T20GcS1fQ2DrBVPZQ559myyjtt
	5KQok4r3x6wMaQSzadqcwHfAXkGsnchdvfkqOTeyJbiZGjriSXKrJFIov0CfSA==
X-Gm-Gg: AR+sD11zf3PaLRUznN5ktxiQepwas4B6XJx+FEl+NT3IKbtc9D4g6/jQYZxCnqXIfDF
	a0G80VjMdGWyHl76tn7EBk/FiWhnC11JD/dEkXWzcG0ivzQLwlO1efj+22vuhRyFhMwlRAx1CRh
	nh8nFmqvyLY0gWhUvnpOlGRbILBbWtShYbY2D5IowTOictXZ1sNV+Dn0uNhoPmplsnqzZVmaY8B
	8Z8CnNwQVf+NWBpP7360yGVpKYTPZXUMt7yjPQsVrozihF9DuHzk7njFyKhKTUstgELJHA8L9A7
	fpCnqNHpmOte5JpHWmhi1zkSf8qFVK7M7a5dW0K2k8CDP4kc8R43+nc5fiqOU3yc11F/ura+M3d
	GREL66cBs1AioKn+qMAOe2skcMK77ZD/HxPaKfLQV36+K9nnkLHXKC91VUWgxdy4dzGoI4tm92s
	JsLTjwq4CH2btMka348IkrbY4hzXv5AWcIopM6ZUkVull2dqRfEhCGc9VOvWSuUtI=
X-Received: by 2002:a05:620a:2b81:b0:930:bd6c:9c32 with SMTP id af79cd13be357-9367b64095amr443986985a.12.1786177303026;
        Sat, 08 Aug 2026 01:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e226895sm332676585a.23.2026.08.08.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:21:42 -0700 (PDT)
Message-Id: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 08 Aug 2026 08:21:41 +0000
Subject: [PATCH] worktree add: improve message for ambiguous remote branch
 name
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
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Display a descriptive message when DWIM fails.

Add advice on how to work around this by specifying the fully
qualified name or by setting checkout.defaultRemote.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: improve message for ambiguous remote branch name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

 builtin/worktree.c      | 30 ++++++++++++++++++++++++++----
 t/t2400-worktree-add.sh | 21 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..46bc305116 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -116,6 +116,16 @@ static const char * const git_worktree_unlock_usage[] = {
 	NULL
 };
 
+static const char message_advice_ambiguous_remote_tracking_branch[] =
+	N_("If you meant to create a worktree from a remote tracking branch on,\n"
+	   "e.g. 'origin', you can do so by fully qualifying the name:\n"
+	   "\n"
+	   "    git worktree add <path> origin/<name>\n"
+	   "\n"
+	   "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+	   "one remote, e.g. the 'origin' remote, consider setting\n"
+	   "checkout.defaultRemote=origin in your config.");
+
 struct add_opts {
 	int force;
 	int detach;
@@ -764,7 +774,7 @@ static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
 	return 1;
 }
 
-static char *dwim_branch(const char *path, char **new_branch)
+static char *dwim_branch(const struct add_opts *opts, const char *path, char **new_branch)
 {
 	int n;
 	int branch_exists;
@@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char **new_branch)
 
 	*new_branch = branchname;
 	if (guess_remote) {
+		int num_matches = 0;
 		struct object_id oid;
-		char *remote = unique_tracking_name(*new_branch, &oid, NULL);
+		char *remote = unique_tracking_name(*new_branch, &oid, &num_matches);
+		if (!opts->quiet && !remote && num_matches > 1) {
+			if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+				advise(_(message_advice_ambiguous_remote_tracking_branch));
+			warning(_("'%s' matched multiple (%d) remote tracking branches\n"), branchname, num_matches);
+		}
 		return remote;
 	}
 	return NULL;
@@ -890,7 +906,7 @@ static int add(int ac, const char **av, const char *prefix,
 		opts.orphan = dwim_orphan(&opts, !!opt_track, 0);
 	} else if (ac < 2) {
 		/* DWIM: Guess branch name from path. */
-		char *s = dwim_branch(path, &new_branch_to_free);
+		char *s = dwim_branch(&opts, path, &new_branch_to_free);
 		if (s)
 			branch = branch_to_free = s;
 		new_branch = new_branch_to_free;
@@ -904,10 +920,16 @@ static int add(int ac, const char **av, const char *prefix,
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
+			int num_matches = 0;
+			remote = unique_tracking_name(branch, &oid, &num_matches);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet && advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
+					advise(_(message_advice_ambiguous_remote_tracking_branch));
+				}
+				die(_("'%s' matched multiple (%d) remote tracking branches"), branch, num_matches);
 			}
 		}
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..4d21c8eba4 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
@@ -669,6 +669,23 @@ test_expect_success 'git worktree add --guess-remote sets up tracking' '
 		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
+test_expect_success 'git worktree add --guess-remote with ambiguous name' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git remote add upstream2 ../repo_a &&
+		git fetch upstream2 &&
+		git worktree add --guess-remote ../foo 2>actual &&
+		test_grep "matched multiple (2) remote tracking branches" actual
+	) &&
+	(
+		cd foo &&
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		test_cmp_rev refs/heads/main refs/heads/foo
+	)
+'
 test_expect_success 'git worktree add --guess-remote sets up tracking (quiet)' '
 	test_when_finished rm -rf repo_a repo_b foo &&
 	setup_remote_repo repo_a repo_b &&

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
