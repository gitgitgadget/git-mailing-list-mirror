Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8583955C4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384730; cv=none; b=bxGDUEtAaTJ9+USn3m0AOltphgX/XsQ4dMyVICoZbCKIktnKH3SjYT1b3mJj6F+rbH8yYZfRyDYXuxSs591wYlZwK883je4G4OEE8FcBDtvtWADANpNPeQ2j2ylqFM2V9liqiXnwPIxv+TL9c52HveSsqrb3VSHjJlXmwJWBvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384730; c=relaxed/simple;
	bh=6sxhZt+FjTfaLCoTHsOFIzhVR9d7VAhGBfaQP6d/8YY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ankfcom+yPQcF70iRdeK9oOwrOP2qoeYhB/kkAdRFiE0p1vmisJet7LKMpRbHCmAy9UPvhbAXOVi2ktwfxdOeL2ogJMe7HB0YA/+5oTYErtp71iOMmnV8fF1Y3D4PjQvI+1FondU9+a12bSH6ErVRVuTftkZIOzNOHYmGfO7Te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpiEeNHW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpiEeNHW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e5d0ee1951so10512015ad.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384724; x=1791989524; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1CkASThfhP0uhR04SC3+WAPxEZRP1gJNDEgJrTNnJGo=;
        b=XpiEeNHWzUf/1QSpX4JgyAkjriIVTQZukPURQ8psH9EaXw9Na8raslyUHgB57H0uBO
         3fqMZUJDUsC/PIcA+9PfVFXdFdCEtC7/raFM8Uwho8mhy/xE1eqIMZ3vuWgnWLXFdQgt
         two/Y5D84ThW//dyI+Xw6Y9/LCgyX8rDjVvUcg/rkdmTk4rfDATpz3/7ZhJp4MsrcOXe
         ZjcqnK7jCBwZXaW8jgom9WcHlt7xR8YbcpKPjYwk+3e0LJG15O6EQYBIaAsaq/TBZw+B
         rmYzuzQZIUtRJMZyPW5T0/L+BVU9rsVEq4ak2E4es5/I0J0KE4PQ5NUetTtRdpouPcZw
         FPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384724; x=1791989524;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1CkASThfhP0uhR04SC3+WAPxEZRP1gJNDEgJrTNnJGo=;
        b=idR0YG6nS6cUGbdtyVdHWK+9hTlxJZmDyZrlJM+OdzF01Fj/T/wd2qora4fssqke9p
         Km4k8LuKxB8Tfm4SoLNjM4ib4dXeoQjNh3MGwV5/NKgt/Xwc1k4gAXqjoNQYP+NtNaiH
         4xd7hTx6rDavxjgDZ4N1l0Cv874P6nR1am8B0DzjBzjbur/pXXoWY/wrx1V+apT4YTZI
         qapuCiZtkwbK2dJYbAcO7DBUe9Zm01NqddhkvYaT8mwR4rW/BvD4roqhJW8+1LtgCbvK
         NqUT0i0EW9tJDuR7YI/zxwFzg7pb4J82SEmlzGrtCAVWWtLqcBu9ha1as1JBE8MbJYH+
         8+tg==
X-Gm-Message-State: AFq9FYIPOXT7LbHfSYr/yfr/GRSZfvS2yJO3yh2HpZ+VmLIhvDwiQHoK
	/JZ2LDvxTJ2+jejQqLEI4xMlt4atqqV+Ujq/ddYt9oFi6DcsPf4PjhmbG0AGOA==
X-Gm-Gg: AYBFou1Kl9Iv6Lo/KBvwR4fiQrKp4qgXdjDZpfPe0W3OABNZguQ4BaqwL1DEEAgYElx
	ETtyU8YoTJtpSR6GwvciONuRdcRGgrus+jlUAZNb5X+N0YDEn5VSUdv3jiG2scacYOC7XKoK51c
	JTJT6eSIeKCaizJx/kXZgvmyvA+4NHIkX2VqZ+72XwzMtpGjogxoE16+AgLRtdaoyc5S4h8Rh9e
	AzDYPCJqMfYruhqqQpeglFTTcuSaTOCsrnV3BZtIc7OCe8e34IhBwCteHh/5K4FzkAIsX0ZZbGw
	EnOEh1h9scGFn5zki3JETMgtwof1NJXDeMagLumaopgHYoOIi7CoZM8ae6SrH0ctZbESuQE2hBt
	W1dSOmAcNtam0mc5VWoI/3JpTDZkK+rQ+UZK/q8G6ZwS+0o3lWnJdEMDEWXTejmQDEj+ZCskdMs
	Xoo95scplhrLagDWQSqY3u925qu8FzElKV4Bjba+zm2CO+kL5WiP8VjPyiDsDKZhH72lDcayDnS
	E6s3e4UrA==
X-Received: by 2002:a17:903:2ac3:b0:2dd:ad73:c936 with SMTP id d9443c01a7336-2e6003bdaf7mr21292635ad.23.1791384723584;
        Wed, 07 Oct 2026 07:52:03 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.5.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fe0c1sm12413425ad.21.2026.10.07.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:52:02 -0700 (PDT)
Message-Id: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 14:52:01 +0000
Subject: [PATCH] doc: checkout: rewrite detached HEAD state explanation
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

The current explanation has the following issues:

- Says detached HEAD state is useful but doesn't explain why
- Takes many paragraphs before explaining what detached HEAD state is
- It's common for users to accidentally end up in detached HEAD state,
  but it doesn't explain why that might happen
- One of the UI improvements in `git switch` is to make it harder
  to detach accidentally, but that isn't advertised.
  See 7968bef06b (switch: only allow explicit detached HEAD, 2019-03-29)
- Too many confusing diagrams

Write a new explanation addressing these issues, and put it in a
standalone guide so that we can easily reference it from advice
("see `git help detachedhead`").
The result is a shorter guide that covers more material.

The framing that "Git considers commits that aren't on a branch/other
reference to be garbage" is taken from Steve Klabnik's tutorial
https://steveklabnik.github.io/jujutsu-tutorial/branching-merging-and-conflicts/anonymous-branches.html.
It's funny and it's consistent with the way Git uses the term
"garbage collection".

Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: checkout: rewrite detached HEAD state explanation
    
    Often when rewriting these explanations I go through a process where I
    ask users' feedback on the old explanation. Here I didn't do that
    basically because that process takes a long time and I'm working on a
    bunch of other time consuming docs projects so I did a quick rewrite
    based on my previous experience explaining detached HEAD state to folks.
    
    I thought this could be a nice quick docs win on a topic which many
    users find quite confusing. If the changes here are too controversial I
    can drop it for now.
    
    Also if folks object to making a separate git help detachedhead guide
    I'm happy to drop that too. Personally I'm excited about the idea of
    being able to reference the guides in our advice (which is one of our
    best tools for getting users info about how to use Git!), but it's not
    possible to let users jump to a subsection, so this is sort of a hack
    around that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2250%2Fjvns%2Fdetached-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2250/jvns/detached-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2250

 Documentation/detached-head.adoc   |  43 ++++++++++
 Documentation/git-checkout.adoc    | 129 +----------------------------
 Documentation/gitdetachedhead.adoc |  14 ++++
 advice.c                           |   1 +
 command-list.txt                   |   1 +
 5 files changed, 60 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/detached-head.adoc
 create mode 100644 Documentation/gitdetachedhead.adoc

diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
new file mode 100644
index 0000000000..1e00712124
--- /dev/null
+++ b/Documentation/detached-head.adoc
@@ -0,0 +1,43 @@
+`HEAD` is where Git stores your current branch. `HEAD` can either be:
+
+1. A branch, which is your current branch.
+2. A commit ID, when you don't have a current branch.
+   This is called "detached HEAD state".
+
+It can sometimes be useful for `HEAD` to be a commit ID.
+For example, it lets you look at an old version of your code
+(with `git checkout COMMIT_ID`).
+
+The only problem is that if you create new commits while in detached
+HEAD state, those commits won't be on a branch. This makes those new
+commits much harder to find later. Also, Git considers commits that
+aren't on any branch (or a tag or other reference) to be garbage.
+Git will eventually permanently delete those "garbage" commits during
+garbage collection.
+
+There are 3 main ways you can end up in detached HEAD state
+unintentionally:
+
+1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
+2. `git checkout v1.3`, where v1.3 is a tag name
+3. `git checkout origin/main`, where `origin/main` is
+   a remote-tracking branch
+
+Checking out a tag puts you in detached HEAD state because `HEAD` can
+only be a branch or a commit, not a tag or any other reference.
+So `git checkout TAG` will set HEAD to the commit for that tag.
+
+The easiest way to avoid accidentally ending up in detached HEAD state
+is to use linkgit:git-switch[1] instead of linkgit:git-checkout[1] to
+switch branches. `git switch` won't let you detach unless you explicitly
+pass the `--detach` argument.
+
+To get back onto a branch, you can:
+
+1. Switch to the branch you want to be on, with `git switch BRANCHNAME`.
+2. Create a new branch at the current commit, with `git switch -c BRANCHNAME`.
+   You might want to do this if you've created new commits, so that you can
+   find the commit later and so that it won't be garbage collected.
+
+If you create commits in detached HEAD state that aren't on a branch,
+you can find them later using linkgit:git-reflog[1].
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 2aefea0228..4e9e94e24d 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -376,135 +376,8 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 [[DETACHED_HEAD]]
 DETACHED HEAD
 -------------
-`HEAD` normally refers to a named branch (e.g. `master`). Meanwhile, each
-branch refers to a specific commit. Let's look at a repo with three
-commits, one of them tagged, and with branch `master` checked out:
 
-------------
-           HEAD (refers to branch 'master')
-            |
-            v
-a---b---c  branch 'master' (refers to commit 'c')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-When a commit is created in this state, the branch is updated to refer to
-the new commit. Specifically, `git commit` creates a new commit `d`, whose
-parent is commit `c`, and then updates branch `master` to refer to new
-commit `d`. `HEAD` still refers to branch `master` and so indirectly now refers
-to commit `d`:
-
-------------
-$ edit; git add; git commit
-
-               HEAD (refers to branch 'master')
-                |
-                v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-It is sometimes useful to be able to checkout a commit that is not at
-the tip of any named branch, or even to create a new commit that is not
-referenced by a named branch. Let's look at what happens when we
-checkout commit `b` (here we show two ways this may be done):
-
-------------
-$ git checkout v2.0  # or
-$ git checkout master^^
-
-   HEAD (refers to commit 'b')
-    |
-    v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-Notice that regardless of which checkout command we use, `HEAD` now refers
-directly to commit `b`. This is known as being in detached `HEAD` state.
-It means simply that `HEAD` refers to a specific commit, as opposed to
-referring to a named branch. Let's see what happens when we create a commit:
-
-------------
-$ edit; git add; git commit
-
-     HEAD (refers to commit 'e')
-      |
-      v
-      e
-     /
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-There is now a new commit `e`, but it is referenced only by `HEAD`. We can
-of course add yet another commit in this state:
-
-------------
-$ edit; git add; git commit
-
-	 HEAD (refers to commit 'f')
-	  |
-	  v
-      e---f
-     /
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-In fact, we can perform all the normal Git operations. But, let's look
-at what happens when we then checkout `master`:
-
-------------
-$ git checkout master
-
-               HEAD (refers to branch 'master')
-      e---f     |
-     /          v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-It is important to realize that at this point nothing refers to commit
-`f`. Eventually commit `f` (and by extension commit `e`) will be deleted
-by the routine Git garbage collection process, unless we create a reference
-before that happens. If we have not yet moved away from commit `f`,
-any of these will create a reference to it:
-
-------------
-$ git checkout -b foo  # or "git switch -c foo"  <1>
-$ git branch foo                                 <2>
-$ git tag foo                                    <3>
-------------
-<1> creates a new branch `foo`, which refers to commit `f`, and then
-    updates `HEAD` to refer to branch `foo`. In other words, we'll no longer
-    be in detached `HEAD` state after this command.
-<2> similarly creates a new branch `foo`, which refers to commit `f`,
-    but leaves `HEAD` detached.
-<3> creates a new tag `foo`, which refers to commit `f`,
-    leaving `HEAD` detached.
-
-If we have moved away from commit `f`, then we must first recover its object
-name (typically by using git reflog), and then we can create a reference to
-it. For example, to see the last two commits to which `HEAD` referred, we
-can use either of these commands:
-
-------------
-$ git reflog -2 HEAD # or
-$ git log -g -2 HEAD
-------------
+include::detached-head.adoc[]
 
 [[ARGUMENT_DISAMBIGUATION]]
 ARGUMENT DISAMBIGUATION
diff --git a/Documentation/gitdetachedhead.adoc b/Documentation/gitdetachedhead.adoc
new file mode 100644
index 0000000000..0aeecd159c
--- /dev/null
+++ b/Documentation/gitdetachedhead.adoc
@@ -0,0 +1,14 @@
+gitdetachedhead(7)
+===============
+
+NAME
+----
+gitdetachedhead - How detached HEAD state works
+
+DESCRIPTION
+-----------
+include::detached-head.adoc[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/advice.c b/advice.c
index 401d047391..43f86c2eaf 100644
--- a/advice.c
+++ b/advice.c
@@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
 	"\n"
 	"  git switch -\n"
 	"\n"
+	"Run `git help detachedhead` to learn more.\n"
 	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
 
 	fprintf(stderr, fmt, new_name);
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..313689335f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -218,6 +218,7 @@ gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
 gitdatamodel                            guide
+gitdetachedhead                         guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
