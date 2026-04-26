Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F1145B3F
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777188299; cv=none; b=o8YQFTosvb+xWWH3KJop3q8kQk2jqPvr/8GjSXfDcjowMq1C0Wcfpe/XLqS+YklqxFEaaW3jqNrnaKBLFSI/3zi/MPoZhBt7vKpAaLu9LCZWDqpyy7oft0tFy8AEKl94rbfaxXJIZAHn4rHjUGw2FOoQUEyEyagR2936FzL8Zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777188299; c=relaxed/simple;
	bh=gxIL2eiPTAqwQPH6d3h/f02hVtZceyDbfIlTxQAglro=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UYtEDVJ9ABg9B/NtAzZkfKQfqo9qZC1EMj7yir8RkC+OBEPKirpigtAGhjKX90vpxgm8wqq08dV4mkNPpVl8E6EATlZCsbX49dbel68bCqUXXzAVBn2vocNvr0cjweh1al/HYZn76VHJCXSjrK100e0SQkSHvEXlAOj4fvWHgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzYAMtqy; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzYAMtqy"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2dee127b3c5so13831835eec.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777188297; x=1777793097; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEwKjl2AdLynLDQ8on6ffIegJXhSkmzn0MSFxliwnLc=;
        b=hzYAMtqy7adJklJC3JxsP+BQ31sM5TuRZhUclcJk+ygl9+sp9VZST3KrBGmR47R8WF
         p2vG35TEtvNLgi3vQv9LpGHn08XW1Ao0kWwtCtGT/iIvqf3ucpsC15NTTnkZivOnL2Co
         bBgNrcVgQ9PVbjI/0noACsTuhBuccLLVTWR12qcVuOYyriWhpBE+FtORpaAgSNDk44fQ
         vtLlVw73tOnlHXqO7B/Xyik+rprdhktS6jfMZRw2fBJ311emVFRsh9N5OO+4zlQNIoTF
         nhnqevyxCWdG7ioKQmfdI272yoqHMrUxsutKHMIyfAtoYUiM0xIaAVNGOm+dllsPlAzn
         U6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777188297; x=1777793097;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEwKjl2AdLynLDQ8on6ffIegJXhSkmzn0MSFxliwnLc=;
        b=RQCz+MQ3wdvL7enNpghWtw5h/u10vhoZFWtIkemZKpSF9piNd7K0PXRo6n6gWU6Eqo
         lJqLthdjEivXetonV7AaLWL/VGOvxjudxjKwZu+2VyT/6Qu0fsDpucGTIL+vmYtai7Ei
         tBfw9cXePRHSKAjeCZCe8kx9FIoHyptWmg6G5Rd0hL3RjHCfrcD2/qBKQJZl65fRHME+
         x0UaAZjC1lcE5pjKHBL4cKIbCd79Nd+iLZsnMtEW5L+NVWZjueAmtEXQN5al1dODXeqQ
         kBlumKAkW0ocnjUJMBir2P50hclIjWg3hJ2+D9l9Z2VySsyz14AAH9NaWQIdFYw+3pZg
         0Z0A==
X-Gm-Message-State: AOJu0YyppGSdiiDD5AaPtHu2fOLmDNeeJeCBMRog691jATJaylcnDRjF
	lle1a3bJU1PiFmmo96m0xOo09Kw9QsvO7cY26ZG0EYGipEiGRUzHfCvyem1sHw==
X-Gm-Gg: AeBDieua6NKaJCJR9+obgXpeifOtWyXcpNToJFOWwCUxW3u3dwfG/dE52P3l3/0vebb
	iJopj8YAWbiY1VeUgCvckCTnLEodijnDenJOqZ+NrsB7dmENG7qq4wvF3Zecf2+MCfLz6B47amB
	hVfNdZHAXfRwSTF9NGtBgOtNAW1CKdQHetIj2BXjtUgayeBFWiNvPBTkII5/nsW96zr+LXlw47m
	ajOoK4E9w09H973xXmaGt1ztk8ySFDlkn4bC2WJGipc4lhXLEE1sEHiQ/GcDt5XUePCixYkaeN/
	lyv1hy/3WjWvaMdcHC8o94jD36JcATnurnuz13MZZQvpYkdEcpH0izsWchm6Z07/MAY8lOkkQi3
	qHLD5fWOu0GQoim1nOmQacnPpccsjWFelS3WgUEJAYY25Tnt6IrIeXWxKGp97DshMlE1B7sopY9
	KYd5re2OU1l0vwV6fDjNdCqO9lv8Fgey6bYxKTBQ==
X-Received: by 2002:a05:693c:3007:b0:2df:5715:82ca with SMTP id 5a478bee46e88-2e46557d3b3mr20063683eec.11.1777188296651;
        Sun, 26 Apr 2026 00:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cff04sm38206630eec.23.2026.04.26.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 00:24:56 -0700 (PDT)
Message-Id: <pull.2281.v3.git.git.1777188295021.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v2.git.git.1777140755373.gitgitgadget@gmail.com>
References: <pull.2281.v2.git.git.1777140755373.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 07:24:54 +0000
Subject: [PATCH v3] checkout: add --fetch to fetch remote before resolving
 start-point
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A common workflow is:

    git fetch origin
    git checkout -b new_branch origin/some-branch

The first command exists purely so the second sees an up-to-date view
of the remote. If it is forgotten, origin/some-branch points at a stale
commit and the new local branch is created from the wrong start point.

Teach checkout (and switch) a --fetch flag that folds the two steps
into one:

    git checkout --fetch -b new_branch origin/some-branch

When --fetch is given and <start-point> is in <remote>/<branch> form,
run "git fetch <remote> <branch>" before resolving the ref. This
narrows the fetch to the requested branch so that other
remote-tracking branches are left untouched -- many tools rely on the
stability of remote-tracking refs between explicit fetches. If
<start-point> is a bare remote name like "origin" (which resolves to
that remote's default branch), "git fetch <remote>" is run instead,
since the target branch is not known up front. Abort the checkout if
the fetch fails.

Also add a checkout.fetch config to enable this by default.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    checkout: add --fetch to fetch remote before resolving start-point
    
    When <start-point> is in <remote>/<branch> form, only fetch that one
    branch instead of the whole remote, so unrelated remote-tracking
    branches stay stable. The bare-remote form (e.g. "origin") still fetches
    everything.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v3
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v2:

 1:  13074c9fea ! 1:  df7b63862c checkout: add --fetch to fetch remote before resolving start-point
     @@ Commit message
      
              git checkout --fetch -b new_branch origin/some-branch
      
     -    When --fetch is given and <start-point> names a configured remote
     -    (either bare, like "origin", or prefixed, like "origin/foo"), fetch
     -    that remote before resolving the ref. Abort the checkout if the fetch
     -    fails.
     +    When --fetch is given and <start-point> is in <remote>/<branch> form,
     +    run "git fetch <remote> <branch>" before resolving the ref. This
     +    narrows the fetch to the requested branch so that other
     +    remote-tracking branches are left untouched -- many tools rely on the
     +    stability of remote-tracking refs between explicit fetches. If
     +    <start-point> is a bare remote name like "origin" (which resolves to
     +    that remote's default branch), "git fetch <remote>" is run instead,
     +    since the target branch is not known up front. Abort the checkout if
     +    the fetch fails.
      
          Also add a checkout.fetch config to enable this by default.
      
     @@ Documentation/git-checkout.adoc: linkgit:git-config[1].
       
      +`--fetch`::
      +`--no-fetch`::
     -+	If _<start-point>_ names a configured remote -- either bare,
     -+	like `origin` (which resolves to the remote's default branch),
     -+	or in _<remote>/<branch>_ form -- run `git fetch` on that
     -+	remote before resolving _<start-point>_. If the fetch fails,
     -+	the checkout is aborted and no local branch is created.
     ++	If _<start-point>_ refers to a remote-tracking branch, fetch
     ++	from that remote before resolving it. When _<start-point>_ is
     ++	in _<remote>/<branch>_ form, only that branch is updated; when
     ++	it is a bare remote name (e.g. `origin`), the whole remote is
     ++	fetched. If the fetch fails, the checkout is aborted.
      ++
      +The default behavior can be set via the `checkout.fetch` configuration
      +variable.
     @@ Documentation/git-switch.adoc: ambiguous but exists on the 'origin' remote. See
       
      +`--fetch`::
      +`--no-fetch`::
     -+	If _<start-point>_ names a configured remote -- either bare,
     -+	like `origin` (which resolves to the remote's default branch),
     -+	or in _<remote>/<branch>_ form -- run `git fetch` on that
     -+	remote before resolving _<start-point>_. If the fetch fails,
     -+	the switch is aborted and no local branch is created.
     ++	If _<start-point>_ refers to a remote-tracking branch, fetch
     ++	from that remote before resolving it. When _<start-point>_ is
     ++	in _<remote>/<branch>_ form, only that branch is updated; when
     ++	it is a bare remote name (e.g. `origin`), the whole remote is
     ++	fetched. If the fetch fails, the switch is aborted.
      ++
      +The default behavior can be set via the `checkout.fetch` configuration
      +variable.
     @@ builtin/checkout.c: struct branch_info {
      +	}
      +
      +	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
     ++	if (slash && slash[1])
     ++		strvec_push(&cmd.args, slash + 1);
      +	cmd.git_cmd = 1;
      +	free(remote_name);
      +	if (run_command(&cmd))
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD
      +'
      +
     ++test_expect_success 'checkout --fetch <remote>/<branch> leaves other tracking branches untouched' '
     ++	git checkout main &&
     ++	git -C fetch_upstream checkout -b fetch_target &&
     ++	test_commit -C fetch_upstream u_target_pre &&
     ++	git -C fetch_upstream checkout -b fetch_other &&
     ++	test_commit -C fetch_upstream u_other_pre &&
     ++	git fetch fetch_upstream &&
     ++	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
     ++	git -C fetch_upstream checkout fetch_target &&
     ++	test_commit -C fetch_upstream u_target_post &&
     ++	git -C fetch_upstream checkout fetch_other &&
     ++	test_commit -C fetch_upstream u_other_post &&
     ++	git checkout --fetch -b local_target fetch_upstream/fetch_target &&
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
     ++	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
     ++'
     ++
      +test_expect_success 'checkout --fetch with bare remote name fetches the remote' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_new2 &&


 Documentation/config/checkout.adoc |  5 +++
 Documentation/git-checkout.adoc    | 11 +++++
 Documentation/git-switch.adoc      | 11 +++++
 builtin/checkout.c                 | 50 +++++++++++++++++++++-
 t/t7201-co.sh                      | 68 ++++++++++++++++++++++++++++++
 t/t9902-completion.sh              |  1 +
 6 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index e35d212969..c95f72b38e 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -22,6 +22,11 @@ commands or functionality in the future.
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
 
+`checkout.fetch`::
+	Provides the default value for the `--fetch` or `--no-fetch`
+	option in `git checkout` and `git switch`. See
+	linkgit:git-switch[1] and linkgit:git-checkout[1].
+
 `checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..f5cc1ced74 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -201,6 +201,17 @@ linkgit:git-config[1].
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
+`--fetch`::
+`--no-fetch`::
+	If _<start-point>_ refers to a remote-tracking branch, fetch
+	from that remote before resolving it. When _<start-point>_ is
+	in _<remote>/<branch>_ form, only that branch is updated; when
+	it is a bare remote name (e.g. `origin`), the whole remote is
+	fetched. If the fetch fails, the checkout is aborted.
++
+The default behavior can be set via the `checkout.fetch` configuration
+variable.
+
 `-l`::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..29743bafea 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -110,6 +110,17 @@ ambiguous but exists on the 'origin' remote. See also
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
+`--fetch`::
+`--no-fetch`::
+	If _<start-point>_ refers to a remote-tracking branch, fetch
+	from that remote before resolving it. When _<start-point>_ is
+	in _<remote>/<branch>_ form, only that branch is updated; when
+	it is a bare remote name (e.g. `origin`), the whole remote is
+	fetched. If the fetch fails, the switch is aborted.
++
+The default behavior can be set via the `checkout.fetch` configuration
+variable.
+
 `-f`::
 `--force`::
 	An alias for `--discard-changes`.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..8d810fe2fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -30,7 +30,9 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "run-command.h"
 #include "setup.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -61,6 +63,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int fetch;
 	int discard_changes;
 	int accept_ref;
 	int accept_pathspec;
@@ -112,6 +115,36 @@ struct branch_info {
 	char *checkout;
 };
 
+static void fetch_remote_for_start_point(const char *arg)
+{
+	const char *slash;
+	char *remote_name;
+	struct remote *remote;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	if (!arg || !*arg)
+		return;
+
+	slash = strchr(arg, '/');
+	if (slash == arg)
+		return;
+	remote_name = slash ? xstrndup(arg, slash - arg) : xstrdup(arg);
+
+	remote = remote_get(remote_name);
+	if (!remote || !remote_is_configured(remote, 1)) {
+		free(remote_name);
+		return;
+	}
+
+	strvec_pushl(&cmd.args, "fetch", remote_name, NULL);
+	if (slash && slash[1])
+		strvec_push(&cmd.args, slash + 1);
+	cmd.git_cmd = 1;
+	free(remote_name);
+	if (run_command(&cmd))
+		die(_("failed to fetch start-point '%s'"), arg);
+}
+
 static void branch_info_release(struct branch_info *info)
 {
 	free(info->name);
@@ -1237,6 +1270,10 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.fetch")) {
+		opts->fetch = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
@@ -1942,8 +1979,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
-					     &new_branch_info, opts, &rev);
+		int n;
+
+		if (opts->fetch)
+			fetch_remote_for_start_point(argv[0]);
+
+		n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+					 &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -2052,6 +2094,8 @@ int cmd_checkout(int argc,
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
 			 N_("auto advance to the next file when selecting hunks interactively")),
+		OPT_BOOL(0, "fetch", &opts.fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
 		OPT_END()
 	};
 
@@ -2102,6 +2146,8 @@ int cmd_switch(int argc,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "fetch", &opts.fetch,
+			 N_("fetch from the remote first if <start-point> is a remote-tracking branch")),
 		OPT_END()
 	};
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..cf2ceb4052 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -801,4 +801,72 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'setup upstream for --fetch tests' '
+	git checkout main &&
+	git init fetch_upstream &&
+	test_commit -C fetch_upstream u_main &&
+	git remote add fetch_upstream fetch_upstream &&
+	git fetch fetch_upstream &&
+	git -C fetch_upstream checkout -b fetch_new &&
+	test_commit -C fetch_upstream u_new
+'
+
+test_expect_success 'checkout --fetch -b picks up branch created upstream after clone' '
+	git checkout main &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
+	git checkout --fetch -b local_new fetch_upstream/fetch_new &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD
+'
+
+test_expect_success 'checkout --fetch <remote>/<branch> leaves other tracking branches untouched' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_target &&
+	test_commit -C fetch_upstream u_target_pre &&
+	git -C fetch_upstream checkout -b fetch_other &&
+	test_commit -C fetch_upstream u_other_pre &&
+	git fetch fetch_upstream &&
+	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
+	git -C fetch_upstream checkout fetch_target &&
+	test_commit -C fetch_upstream u_target_post &&
+	git -C fetch_upstream checkout fetch_other &&
+	test_commit -C fetch_upstream u_other_post &&
+	git checkout --fetch -b local_target fetch_upstream/fetch_target &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
+'
+
+test_expect_success 'checkout --fetch with bare remote name fetches the remote' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_new2 &&
+	test_commit -C fetch_upstream u_new2 &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2 &&
+	git checkout --fetch -b local_from_remote fetch_upstream &&
+	git rev-parse --verify refs/remotes/fetch_upstream/fetch_new2
+'
+
+test_expect_success 'checkout --fetch aborts and does not create branch on fetch failure' '
+	git checkout main &&
+	test_might_fail git branch -D bogus &&
+	test_must_fail git checkout --fetch -b bogus fetch_upstream/does_not_exist &&
+	test_must_fail git rev-parse --verify refs/heads/bogus
+'
+
+test_expect_success 'checkout.fetch=true enables fetching without --fetch' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_cfg &&
+	test_commit -C fetch_upstream u_cfg &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_cfg &&
+	git -c checkout.fetch=true checkout -b local_cfg fetch_upstream/fetch_cfg &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_cfg HEAD
+'
+
+test_expect_success 'switch --fetch -c picks up branch created upstream after clone' '
+	git checkout main &&
+	git -C fetch_upstream checkout -b fetch_switch &&
+	test_commit -C fetch_upstream u_switch &&
+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
+	git switch --fetch -c local_switch fetch_upstream/fetch_switch &&
+	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..dc1d63669f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2602,6 +2602,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
 	--auto-advance Z
+	--fetch Z
 	--progress Z
 	--guess Z
 	--no-guess Z

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
