Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B6183CB0
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204836; cv=none; b=qhL4EGzK9AMlwJf8VqWKnYK6D6dnNnJaa7BBA8pEWKCEnXQxFmxDqcTApMN77+SqXs52fIhc6JPDUpXGJhuEjOmfB2nrQ2s15tyc8WPJPretEyjLn3r7whK93FboeaxhcPWUIIQOCB9JK5XRSG41CSwiZu/Lgda+0jqi3R+oK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204836; c=relaxed/simple;
	bh=puk3dyiUeIC7cHpxl8TkKAgRcyObvZhnTrSGpoN8hm0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=u+m0zZnburJm5nd3+VSRG2j6tAh8k3PN/PYz4zOjrA88zBMDQSir2ir6BCNs/YSE7HyLyfME5KaOQFIH4GdgC8ZrA8wA4OgOAagwzwU41Xvs1M2CvANQT+vT1u7QJb1IVd5/pQ36OQr0ffc8XLOvrBI6B9fzunclgQvSKMmbMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPLRgxe9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPLRgxe9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a3673e12c4so993728f8f.2
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204831; x=1748809631; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYnxBtEvB0nJquGAIak6GqZv1KkDX0UzuxEDVYoxb74=;
        b=cPLRgxe9NPH1uBwjz3XRizMU/s7o+WQ+6TMMp79ws4tGH/t8zfSQAbKYbnGi7tT0TQ
         tzac0X8u22qLq9+SMnexM7MXBSWq1bpxQRv71ZZq8EvvjkMZxa1Or2H1UpIGNPsLeMFR
         uhtJjCNuUZgQIu8dQJvuN65tcIuNbEskcYU+KbiciC5mX8DQ7RGol3fkp2EgfkXoUrYs
         rOsZY6MGDevh9t+Zy2KHO6MZYn2SaqAw48Q0cUuf7FNHBgXmX2f93n5QICF1ZYARy5mb
         mJexbHDdmWAAygmSsMccXuwCD7fZLNTOJ2tEbiAtShDnz5zfLENueUO5Fkf2bRP3p0fx
         oT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204831; x=1748809631;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYnxBtEvB0nJquGAIak6GqZv1KkDX0UzuxEDVYoxb74=;
        b=Acve2FNeD+9qB38/RM4C58HgBNKinBBoiwsI6AO6oGaZ+ARwzZWRUFgifcOUBDWbCx
         daFOhmSHBXS9mnu1MOy3jeNPG93+IRunSZh0sVY32rLiJ0FOF8U6WiYwN25OmAl17D+C
         Bq8xg+PAn7iGLFo7fHT5croG3HFGqa3ZqbL1me72nt6rvaHK3t/ltD4K/uFkMEQX7IBg
         ndt5vVObuwKoxFk8DyC6sumLo9ls2t8miJQ3Hs9BkkiNw2095Pdxqh2ICGiYuKuAikTU
         2k/TC4U2MkP4ov3o0Jp00d3TgJ/SsknE9G5g+ABWxfVqvEt1Bh6tsrFqapYJZImP1uY8
         UmNQ==
X-Gm-Message-State: AOJu0YycHkU0uTFiEyuNcPkxue/nTDPAKRJ4x4Umxx0mivC3QtQ+9xXR
	cRWGk6nHw1GEK/6I6m5lKFrvPnqEmBMmSZhNFjUz59UdpYq8L1o7shbBQjNErA==
X-Gm-Gg: ASbGnctH8vc2WPPFyprtEBsowBfNS1KYAbJsrSgoPRjGmZPPGsmspt4AWcV1qPSy2Gw
	U7Ydb4bX1fgYNch01rkHvl4J3fLiet6+uCEQPq1c6w0bdRmc1n5Rfl9rhzCDTDQ68NfumutbGxt
	ySQpa10kM+sRdnmhGrDLryc/0GBVjmtV0r4+KG2zqG5cWpp9wASllrzYdvzp2kuobfKl0tnfNl0
	tFwGsnmZ32xxNjFAojG1/8yHEcQoYoemLz1xe8tQoZEbjhwPeVrF4VxZ+qhWv81pNURUeaiFA2t
	hQ1n0eYO3wPA+5KPxGJucrXHEdYivIXPm5zCx0EBSQxefPwsq0w7
X-Google-Smtp-Source: AGHT+IF/n073eAq8636YNFaARib2qThpOhB7mt0UL1ZmrmI8rf8bg7qIe+MSk5blRT2nq59ERp+zqg==
X-Received: by 2002:a5d:4d50:0:b0:3a4:d004:94ac with SMTP id ffacd0b85a97d-3a4d004968dmr3422066f8f.40.1748204831145;
        Sun, 25 May 2025 13:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c591c044sm7534322f8f.52.2025.05.25.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:10 -0700 (PDT)
Message-Id: <23eef28b5a4b33219e92e1462688df1bb11e522f.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:01 +0000
Subject: [PATCH 1/9] doc: convert git-checkout manpage to new style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/checkout.adoc |  14 +-
 Documentation/git-checkout.adoc    | 228 ++++++++++++++---------------
 2 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index a32302299380..e35d21296978 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -1,9 +1,9 @@
-checkout.defaultRemote::
+`checkout.defaultRemote`::
 	When you run `git checkout <something>`
 	or `git switch <something>` and only have one
 	remote, it may implicitly fall back on checking out and
 	tracking e.g. `origin/<something>`. This stops working as soon
-	as you have more than one remote with a `<something>`
+	as you have more than one remote with a _<something>_
 	reference. This setting allows for setting the name of a
 	preferred remote that should always win when it comes to
 	disambiguation. The typical use-case is to set this to
@@ -12,17 +12,17 @@ checkout.defaultRemote::
 Currently this is used by linkgit:git-switch[1] and
 linkgit:git-checkout[1] when `git checkout <something>`
 or `git switch <something>`
-will checkout the `<something>` branch on another remote,
+will checkout the _<something>_ branch on another remote,
 and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
 
-checkout.guess::
+`checkout.guess`::
 	Provides the default value for the `--guess` or `--no-guess`
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
 
-checkout.workers::
+`checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
 	than one, Git will use as many workers as the number of logical cores
@@ -30,13 +30,13 @@ checkout.workers::
 	all commands that perform checkout. E.g. checkout, clone, reset,
 	sparse-checkout, etc.
 +
-Note: Parallel checkout usually delivers better performance for repositories
+NOTE: Parallel checkout usually delivers better performance for repositories
 located on SSDs or over NFS. For repositories on spinning disks and/or machines
 with a small number of cores, the default sequential checkout often performs
 better. The size and compression level of a repository might also influence how
 well the parallel version performs.
 
-checkout.thresholdForParallelism::
+`checkout.thresholdForParallelism`::
 	When running parallel checkout with a small number of files, the cost
 	of subprocess spawning and inter-process communication might outweigh
 	the parallelization gains. This setting allows you to define the minimum
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a66c53a5cd1e..ee83b6d9ba9a 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -7,54 +7,54 @@ git-checkout - Switch branches or restore working tree files
 
 SYNOPSIS
 --------
-[verse]
-'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] --detach [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] <commit>
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
-'git checkout' [-f] <tree-ish> [--] <pathspec>...
-'git checkout' [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
+[synopsis]
+git checkout [-q] [-f] [-m] [<branch>]
+git checkout [-q] [-f] [-m] --detach [<branch>]
+git checkout [-q] [-f] [-m] [--detach] <commit>
+git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
+git checkout [-f] <tree-ish> [--] <pathspec>...
+git checkout [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
+git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
+git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
+git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
-or the specified tree.  If no pathspec was given, 'git checkout' will
+or the specified tree.  If no pathspec was given, `git checkout` will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' [<branch>]::
-	To prepare for working on `<branch>`, switch to it by updating
+`git checkout [<branch>]`::
+	To prepare for working on _<branch>_, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	`HEAD` at the branch. Local modifications to the files in the
 	working tree are kept, so that they can be committed to the
-	`<branch>`.
+	_<branch>_.
 +
-If `<branch>` is not found but there does exist a tracking branch in
-exactly one remote (call it `<remote>`) with a matching name and
+If _<branch>_ is not found but there does exist a tracking branch in
+exactly one remote (call it _<remote>_) with a matching name and
 `--no-guess` is not specified, treat as equivalent to
 +
 ------------
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-You could omit `<branch>`, in which case the command degenerates to
+You could omit _<branch>_, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
 if it exists, for the current branch.
 
-'git checkout' -b|-B <new-branch> [<start-point>]::
+`git checkout (-b|-B) <new-branch> [<start-point>]`::
 
 	Specifying `-b` causes a new branch to be created as if
 	linkgit:git-branch[1] were called and then checked out.  In
 	this case you can use the `--track` or `--no-track` options,
-	which will be passed to 'git branch'.  As a convenience,
+	which will be passed to `git branch`.  As a convenience,
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
-If `-B` is given, `<new-branch>` is created if it doesn't exist; otherwise, it
+If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
 is reset. This is the transactional equivalent of
 +
 ------------
@@ -67,30 +67,30 @@ successful (e.g., when the branch is in use in another worktree, not
 just the current branch stays the same, but the branch is not reset to
 the start-point, either).
 
-'git checkout' --detach [<branch>]::
-'git checkout' [--detach] <commit>::
+`git checkout --detach [<branch>]`::
+`git checkout [--detach] <commit>`::
 
-	Prepare to work on top of `<commit>`, by detaching `HEAD` at it
+	Prepare to work on top of _<commit>_, by detaching `HEAD` at it
 	(see "DETACHED HEAD" section), and updating the index and the
 	files in the working tree.  Local modifications to the files
 	in the working tree are kept, so that the resulting working
 	tree will be the state recorded in the commit plus the local
 	modifications.
 +
-When the `<commit>` argument is a branch name, the `--detach` option can
+When the _<commit>_ argument is a branch name, the `--detach` option can
 be used to detach `HEAD` at the tip of the branch (`git checkout
 <branch>` would check out that branch without detaching `HEAD`).
 +
-Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
+Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]::
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
 	Overwrite the contents of the files that match the pathspec.
-	When the `<tree-ish>` (most often a commit) is not given,
+	When the _<tree-ish>_ (most often a commit) is not given,
 	overwrite working tree with the contents in the index.
-	When the `<tree-ish>` is given, overwrite both the index and
-	the working tree with the contents at the `<tree-ish>`.
+	When the _<tree-ish>_ is given, overwrite both the index and
+	the working tree with the contents at the _<tree-ish>_.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -100,7 +100,7 @@ specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
+`git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
 	This is similar to the previous mode, but lets you use the
 	interactive interface to show the "diff" output and choose which
 	hunks to use in the result.  See below for the description of
@@ -108,19 +108,19 @@ file can be discarded to re-create the original conflicted merge result.
 
 OPTIONS
 -------
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
--f::
---force::
+`-f`::
+`--force`::
 	When switching branches, proceed even if the index or the
 	working tree differs from `HEAD`, and even if there are untracked
 	files in the way.  This is used to throw away local changes and
@@ -129,13 +129,13 @@ OPTIONS
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
 
---ours::
---theirs::
+`--ours`::
+`--theirs`::
 	When checking out paths from the index, check out stage #2
-	('ours') or #3 ('theirs') for unmerged paths.
+	(`ours`) or #3 (`theirs`) for unmerged paths.
 +
-Note that during `git rebase` and `git pull --rebase`, 'ours' and
-'theirs' may appear swapped; `--ours` gives the version from the
+Note that during `git rebase` and `git pull --rebase`, `ours` and
+`theirs` may appear swapped; `--ours` gives the version from the
 branch the changes are rebased onto, while `--theirs` gives the
 version from the branch that holds your work that is being rebased.
 +
@@ -149,22 +149,22 @@ as `ours` (i.e. "our shared canonical history"), while what you did
 on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
--b <new-branch>::
-	Create a new branch named `<new-branch>`, start it at
-	`<start-point>`, and check the resulting branch out;
+`-b <new-branch>`::
+	Create a new branch named _<new-branch>_, start it at
+	_<start-point>_, and check the resulting branch out;
 	see linkgit:git-branch[1] for details.
 
--B <new-branch>::
-	Creates the branch `<new-branch>`, start it at `<start-point>`;
-	if it already exists, then reset it to `<start-point>`. And then
+`-B <new-branch>`::
+	Creates the branch _<new-branch>_, start it at _<start-point>_;
+	if it already exists, then reset it to _<start-point>_. And then
 	check the resulting branch out.  This is equivalent to running
-	"git branch" with "-f" followed by "git checkout" of that branch;
+	`git branch` with `-f` followed by `git checkout` of that branch;
 	see linkgit:git-branch[1] for details.
 
--t::
---track[=(direct|inherit)]::
+`-t`::
+`--track[=(direct|inherit)]`::
 	When creating a new branch, set up "upstream" configuration. See
-	"--track" in linkgit:git-branch[1] for details.
+	`--track` in linkgit:git-branch[1] for details.
 +
 If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
@@ -176,14 +176,14 @@ off of `origin/hack` (or `remotes/origin/hack`, or even
 guessing results in an empty name, the guessing is aborted.  You can
 explicitly give a name with `-b` in such a case.
 
---no-track::
+`--no-track`::
 	Do not set up "upstream" configuration, even if the
 	`branch.autoSetupMerge` configuration variable is true.
 
---guess::
---no-guess::
-	If `<branch>` is not found but there does exist a tracking
-	branch in exactly one remote (call it `<remote>`) with a
+`--guess`::
+`--no-guess`::
+	If _<branch>_ is not found but there does exist a tracking
+	branch in exactly one remote (call it _<remote>_) with a
 	matching name, treat as equivalent to
 +
 ------------
@@ -192,10 +192,10 @@ $ git checkout -b <branch> --track <remote>/<branch>
 +
 If the branch exists in multiple remotes and one of them is named by
 the `checkout.defaultRemote` configuration variable, we'll use that
-one for the purposes of disambiguation, even if the `<branch>` isn't
+one for the purposes of disambiguation, even if the _<branch>_ isn't
 unique across all remotes. Set it to
 e.g. `checkout.defaultRemote=origin` to always checkout remote
-branches from there if `<branch>` is ambiguous but exists on the
+branches from there if _<branch>_ is ambiguous but exists on the
 'origin' remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
@@ -204,28 +204,28 @@ linkgit:git-config[1].
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
--l::
+`-l`::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
--d::
---detach::
+`-d`::
+`--detach`::
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
 	This is the default behavior of `git checkout <commit>` when
-	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
+	_<commit>_ is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
---orphan <new-branch>::
-	Create a new unborn branch, named `<new-branch>`, started from
-	`<start-point>` and switch to it.  The first commit made on this
+`--orphan <new-branch>`::
+	Create a new unborn branch, named _<new-branch>_, started from
+	_<start-point>_ and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
 	history totally disconnected from all the other branches and
 	commits.
 +
 The index and the working tree are adjusted as if you had previously run
 `git checkout <start-point>`.  This allows you to start a new history
-that records a set of paths similar to `<start-point>` by easily running
+that records a set of paths similar to _<start-point>_ by easily running
 `git commit -a` to make the root commit.
 +
 This can be useful when you want to publish the tree from a commit
@@ -235,20 +235,20 @@ whose full history contains proprietary or otherwise encumbered bits of
 code.
 +
 If you want to start a disconnected history that records a set of paths
-that is totally different from the one of `<start-point>`, then you should
+that is totally different from the one of _<start-point>_, then you should
 clear the index and the working tree right after creating the orphan
 branch by running `git rm -rf .` from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
 working tree, by copying them from elsewhere, extracting a tarball, etc.
 
---ignore-skip-worktree-bits::
-	In sparse checkout mode, `git checkout -- <paths>` would
-	update only entries matched by `<paths>` and sparse patterns
+`--ignore-skip-worktree-bits`::
+	In sparse checkout mode, `git checkout -- <path>...` would
+	update only entries matched by _<paths>_ and sparse patterns
 	in `$GIT_DIR/info/sparse-checkout`. This option ignores
-	the sparse patterns and adds back any files in `<paths>`.
+	the sparse patterns and adds back any files in `<path>...`.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	When switching branches,
 	if you have local modifications to one or more files that
 	are different between the current branch and the branch to
@@ -269,40 +269,40 @@ used when checking out paths from a tree-ish.
 +
 When switching branches with `--merge`, staged changes may be lost.
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
-	"merge" (default), "diff3", and "zdiff3".
+	`merge` (default), `diff3`, and `zdiff3`.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively select hunks in the difference between the
-	`<tree-ish>` (or the index, if unspecified) and the working
+	_<tree-ish>_ (or the index, if unspecified) and the working
 	tree.  The chosen hunks are then applied in reverse to the
-	working tree (and if a `<tree-ish>` was specified, the index).
+	working tree (and if a _<tree-ish>_ was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
-edits from your current working tree. See the ``Interactive Mode''
+edits from your current working tree. See the "Interactive Mode"
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 Note that this option uses the no overlay mode by default (see also
 `--overlay`), and currently doesn't support overlay mode.
 
---ignore-other-worktrees::
+`--ignore-other-worktrees`::
 	`git checkout` refuses when the wanted branch is already checked
 	out or otherwise in use by another worktree. This option makes
 	it check the branch out anyway. In other words, the branch can
 	be in use by more than one worktree.
 
---overwrite-ignore::
---no-overwrite-ignore::
+`--overwrite-ignore`::
+`--no-overwrite-ignore`::
 	Silently overwrite ignored files when switching branches. This
 	is the default behavior. Use `--no-overwrite-ignore` to abort
 	the operation when the new branch contains ignored files.
 
---recurse-submodules::
---no-recurse-submodules::
+`--recurse-submodules`::
+`--no-recurse-submodules`::
 	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
@@ -311,25 +311,25 @@ Note that this option uses the no overlay mode by default (see also
 	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
 	submodule.
 
---overlay::
---no-overlay::
+`--overlay`::
+`--no-overlay`::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-	working tree, but not in `<tree-ish>` are removed, to make them
-	match `<tree-ish>` exactly.
+	working tree, but not in _<tree-ish>_ are removed, to make them
+	match _<tree-ish>_ exactly.
 
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+`--pathspec-from-file=<file>`::
+	Pathspec is passed in _<file>_ instead of commandline args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
+	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with NUL character and all other characters are taken
+	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
 <branch>::
@@ -343,33 +343,33 @@ You can use the `@{-N}` syntax to refer to the N-th last
 branch/commit checked out using "git checkout" operation. You may
 also specify `-` which is synonymous to `@{-1}`.
 +
-As a special case, you may use `A...B` as a shortcut for the
-merge base of `A` and `B` if there is exactly one merge base. You can
-leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+As a special case, you may use `<rev-a>...<rev-b>` as a shortcut for the
+merge base of _<rev-a>_ and _<rev-b>_ if there is exactly one merge base. You can
+leave out at most one of _<rev-a>_ and _<rev-b>_, in which case it defaults to `HEAD`.
 
-<new-branch>::
+_<new-branch>_::
 	Name for the new branch.
 
-<start-point>::
+_<start-point>_::
 	The name of a commit at which to start the new branch; see
 	linkgit:git-branch[1] for details. Defaults to `HEAD`.
 +
-As a special case, you may use `"A...B"` as a shortcut for the
-merge base of `A` and `B` if there is exactly one merge base. You can
-leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+As a special case, you may use `<rev-a>...<rev-b>` as a shortcut for the
+merge base of _<rev-a>_ and _<rev-b>_ if there is exactly one merge base. You can
+leave out at most one of _<rev-a>_ and _<rev-b>_, in which case it defaults to `HEAD`.
 
-<tree-ish>::
+_<tree-ish>_::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
 +
-As a special case, you may use `"A...B"` as a shortcut for the
-merge base of `A` and `B` if there is exactly one merge base. You can
-leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+As a special case, you may use `<rev-a>...<rev-b>` as a shortcut for the
+merge base of _<rev-a>_ and _<rev-b>_ if there is exactly one merge base. You can
+leave out at most one of _<rev-a>_ and _<rev-b>_, in which case it defaults to `HEAD`.
 
-\--::
+`--`::
 	Do not interpret any more arguments as options.
 
-<pathspec>...::
+`<pathspec>...`::
 	Limits the paths affected by the operation.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
@@ -391,7 +391,7 @@ a---b---c  branch 'master' (refers to commit 'c')
 ------------
 
 When a commit is created in this state, the branch is updated to refer to
-the new commit. Specifically, 'git commit' creates a new commit `d`, whose
+the new commit. Specifically, `git commit` creates a new commit `d`, whose
 parent is commit `c`, and then updates branch `master` to refer to new
 commit `d`. `HEAD` still refers to branch `master` and so indirectly now refers
 to commit `d`:
@@ -510,11 +510,11 @@ ARGUMENT DISAMBIGUATION
 -----------------------
 
 When there is only one argument given and it is not `--` (e.g. `git
-checkout abc`), and when the argument is both a valid `<tree-ish>`
-(e.g. a branch `abc` exists) and a valid `<pathspec>` (e.g. a file
+checkout abc`), and when the argument is both a valid _<tree-ish>_
+(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
 or a directory whose name is "abc" exists), Git would usually ask
 you to disambiguate.  Because checking out a branch is so common an
-operation, however, `git checkout abc` takes "abc" as a `<tree-ish>`
+operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
 in such a situation.  Use `git checkout -- <pathspec>` if you want
 to checkout these paths out of the index.
 
-- 
gitgitgadget

