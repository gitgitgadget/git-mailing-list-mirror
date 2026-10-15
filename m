Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B3556B8A
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097890; cv=none; b=Qdk0wrJiVxqfjVdFbRPLHJ0XeHUstiXUmiYkAT76p3RIEbQvdFaYMEe+BbyKqZVunywVI5hEI8Co+t4I/Wvkl5KkGG99Vy/Juht2lLeKSzYo/3c+FhZDSHNcYuTFRMKhyHU4ySoHTpnB8Ezvj6uKXk5UL4uKsBKNiW9I2viXawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097890; c=relaxed/simple;
	bh=koEX9ZSrKXn7Nsx/ESESQqN58ORtmd7rFoonM0FcIxA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=es153zvdrd7+GkBRtbRpKFPUQr48We/DShLJIeEOay8V1OUU1nqiL5F+OWj0a5k5xVB15hKH0GZGg38ZvuLjmJOTxNPgxq3HaZrUBScoCrG7uQKLh/t6TJ+6iu+wa6XjXgUmVmbpEpizwLJqe+tfEhJJ3SCOzxRZ2sWJ6fIsrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okfVp0GN; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okfVp0GN"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so757609eec.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792097885; x=1792702685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A21YuZKnwzJ0v98VTwfGGxOcj9eLcv7Q4DVr2MxvwYA=;
        b=okfVp0GNWFV2Fus7QReKg006pFpzD6omOsE53nC257vwVXqNFkVEuEymLrEIdwvsIb
         CdtayNwo0M5rjieY0MO170QqNj32suZ92vEGZP0OypAe+G9zLgUkCsBq4MV4w1lXwPyL
         zbtbPCQil/d8uF7FYEEXqReZ5vNfZa9JZ3iSQv65bodpgLs+AYVm1ae2tK8x/3459xeA
         Zk+4oKBklFLgYpbFGewhHbWmT+QNLSdoNiSNic/9PxbHETNJaVUkzyqjEU+hyK3gOySa
         +Ud9rxWymQX+pBoSzYvfYVldfWradr+MdM3DYVjWPIPUghvtYXWVsW4UdKqC0pqT30sf
         RIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097885; x=1792702685;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A21YuZKnwzJ0v98VTwfGGxOcj9eLcv7Q4DVr2MxvwYA=;
        b=rxw92mFp9XtP7CL8JJ/E0Ob/WWGM3JS1fksTrMI/VwzUC7OP59SrNHKVXWlem0E2S2
         3TBs9m0W7pOYdIMWErwcoRfc/IwPd7L67WiBD6x91ZBjg/+1+DKhY3Hoo3VTBdRZqrqa
         xXlYZVJSNVcDr5UtJEsn+/Gi/bWwbH0axNGNW9Dtvi6W0rScnNnCBGJJPycZ5cpXnDro
         I1gW22P9vbPsrGbmtPh9njiGzTGRrDKe4UHrYQgZCVXMpOP2g6dvVUgWcNUg4roD2HwA
         bt6uF9OolVvmPvPNtnZKvrRsvkHMeYOL6uBRXQ14rHBN/1xECRCyAt0ZNNUPe8ehIdRZ
         QXXQ==
X-Gm-Message-State: AFq9FYK9Y9duMuhzg0e5csn3Qk7Mls/T7YAoO5EAd++sJwvMVctD/tjW
	dheaAJ2Y+0YDZmhEm/d125vqL+jmEYOmz2EofAK7QB2RlSfik69WmXvn6nLQHSia0aw=
X-Gm-Gg: AYBFou36iJCaH3EQHITZaKhu6Lkgw87AjRb4O8ZlPz3pfTWJCK/DYzP648HZgYR/R9v
	0qWyKFgxAhlZRB7vNwlD0MYci0T25gPhn8HjijR5YXvT6QKordyOYF6SEyBPZXynflweVBLutcz
	9ktT8S13BhhZXPISbY/kHpUB305FNG40ZRXkn5uVk4b88FTbB+qTYutLvro7w4aPDgYuCfA6G/6
	Yh0ui1C2sZWTgZvSVsQt7dpJtP1BzezATo4PnbguNRnpzZbPPVbBL+J5rXVowdhlYtwZRMym2Ta
	gTHeLOe5OItN4Ai2xwAcxIW0qxfDOSmQIypqtdkCpI9KhwHudhRZa27Gy3M1YCJj4kZ7H+9Q5MF
	l5WDcilMPm73RviX5k7qrUSvnj6+nkMCAMQKYLdmRepy2kogZZvBw6FZLb2ZizTkCzrgqA02dwZ
	2w6VdmzA+7Mn6ZUn4+CaNx86TmnBiU6KW57ILfpK3cz8dKqQkVpuZh3nNeYs7s1PtgF9plQYkz
X-Received: by 2002:a05:7300:c8cb:b0:35f:f4c3:6403 with SMTP id 5a478bee46e88-35ff4d2b879mr2188037eec.36.1792097884204;
        Thu, 15 Oct 2026 13:58:04 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.196.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm445494eec.26.2026.10.15.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:58:03 -0700 (PDT)
Message-Id: <pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com>
In-Reply-To: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 20:58:02 +0000
Subject: [PATCH v3] doc: checkout: rewrite detached HEAD state explanation
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
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
("see `git help detached-head`").
The result is a shorter guide that covers more material.

The framing that "Git considers commits that aren't on a branch/other
reference to be garbage" is taken from Steve Klabnik's tutorial
https://steveklabnik.github.io/jujutsu-tutorial/branching-merging-and-conflicts/anonymous-branches.html.
It's funny and it's consistent with the way Git uses the term
"garbage collection".

Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: checkout: rewrite detached HEAD state explanation
    
    This is a pretty quick rewrite where we didn't get any user feedback. If
    we really want to make sure it's clear to users as possible, we should
    IMO do a second stage later where we ask users which parts are unclear.
    
    Changes in v2:
    
     * Make the meson.build and Makefile changes (thanks to Kristoffer)
     * Rename to gitdata-model (thanks to Kristoffer)
     * Mention commits will be deleted after 90 days to make it seem less
       scary (thanks to Kristoffer)
     * Add an "easily" qualifier to "it lets you look at an old version of
       your code", to avoid implying that this is the only way (thanks to
       Junio)
     * Mention that Git will warn you when switching branches if you're
       leaving commits behind (thanks to Junio)
     * Remove "unintentionally" (thanks to Junio)
     * Mention git help datamodel (thanks to Junio)
    
    Changes in v3:
    
    I went through the style comments from v1.
    
    content changes:
    
     * Change "90 days" to "30 days" (thanks to Junio)
     * Say that HEAD is where Git stores your "current branch or commit" to
       make the first sentence read better (thanks to Junio)
     * Mention git switch --detach a little earlier (thanks to Kristoffer)
     * Replace "the only problem" with "it's important to know that" (thanks
       to Junio)
    
    formatting changes etc:
    
     * Replace help detachedhead with help detached-head (thanks to Junio)
     * Fix spacing in command-list.txt (thanks to Junio)
     * Get Marie's signoff (thanks to Junio)
    
    non-changes: Left these phrases alone because I don't think the proposed
    changes would make it more clear.
    
     * "3 main ways you can end up in detached HEAD state"
     * "to look at an old version of your code"
     * "avoid accidentally ending up"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2250%2Fjvns%2Fdetached-head-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2250/jvns/detached-head-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2250

Range-diff vs v2:

 1:  83139be46f ! 1:  0ab8814664 doc: checkout: rewrite detached HEAD state explanation
     @@ Commit message
      
          Write a new explanation addressing these issues, and put it in a
          standalone guide so that we can easily reference it from advice
     -    ("see `git help detachedhead`").
     +    ("see `git help detached-head`").
          The result is a shorter guide that covers more material.
      
          The framing that "Git considers commits that aren't on a branch/other
     @@ Commit message
          "garbage collection".
      
          Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
     +    Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/Makefile ##
     @@ Documentation/Makefile: MAN7_TXT += gitcore-tutorial.adoc
      
       ## Documentation/detached-head.adoc (new) ##
      @@
     -+`HEAD` is where Git stores your current branch. `HEAD` can either be:
     ++`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
      +
      +1. A branch, which is your current branch.
      +2. A commit ID, when you don't have a current branch.
     @@ Documentation/detached-head.adoc (new)
      +For example, it lets you easily look at an old version of your code
      +(with `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`).
      +
     -+The only problem is that if you create new commits while in detached
     -+HEAD state, those commits won't be on a branch. This makes those new
     -+commits much harder to find later. Also, Git considers commits that
     -+aren't on any branch (or a tag or other reference) to be garbage.
     ++But it's important to know that if you create new commits while in
     ++detached HEAD state, those commits won't be on a branch. This makes
     ++those new commits much harder to find later. Also, Git considers commits
     ++that aren't on any branch (or a tag or other reference) to be garbage.
      +Git will eventually permanently delete those "garbage" commits during
     -+garbage collection. Those commits will be deleted after 90 days by
     ++garbage collection. Those commits will be deleted after 30 days by
      +default, see linkgit:git-gc[1] for more.
      +
      +There are 3 main ways you can end up in detached HEAD state:
     @@ advice.c: void detach_advice(const char *new_name)
       	"\n"
       	"  git switch -\n"
       	"\n"
     -+	"Run `git help detachedhead` to learn more.\n"
     ++	"Run `git help detached-head` to learn more.\n"
       	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
       
       	fprintf(stderr, fmt, new_name);
     @@ command-list.txt: gitcore-tutorial                        guide
       gitcredentials                          guide
       gitcvs-migration                        guide
       gitdatamodel                            guide
     -+gitdetached-head                         guide
     ++gitdetached-head                        guide
       gitdiffcore                             guide
       giteveryday                             guide
       gitfaq                                  guide


 Documentation/Makefile              |   1 +
 Documentation/detached-head.adoc    |  57 ++++++++++++
 Documentation/git-checkout.adoc     | 129 +---------------------------
 Documentation/gitdetached-head.adoc |  14 +++
 Documentation/meson.build           |   1 +
 advice.c                            |   1 +
 command-list.txt                    |   1 +
 7 files changed, 76 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/detached-head.adoc
 create mode 100644 Documentation/gitdetached-head.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..5892f48b06 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -54,6 +54,7 @@ MAN7_TXT += gitcore-tutorial.adoc
 MAN7_TXT += gitcredentials.adoc
 MAN7_TXT += gitcvs-migration.adoc
 MAN7_TXT += gitdatamodel.adoc
+MAN7_TXT += gitdetached-head.adoc
 MAN7_TXT += gitdiffcore.adoc
 MAN7_TXT += giteveryday.adoc
 MAN7_TXT += gitfaq.adoc
diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
new file mode 100644
index 0000000000..d8e59e10c6
--- /dev/null
+++ b/Documentation/detached-head.adoc
@@ -0,0 +1,57 @@
+`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
+
+1. A branch, which is your current branch.
+2. A commit ID, when you don't have a current branch.
+   This is called "detached HEAD state".
+
+It can sometimes be useful for `HEAD` to be a commit ID.
+For example, it lets you easily look at an old version of your code
+(with `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`).
+
+But it's important to know that if you create new commits while in
+detached HEAD state, those commits won't be on a branch. This makes
+those new commits much harder to find later. Also, Git considers commits
+that aren't on any branch (or a tag or other reference) to be garbage.
+Git will eventually permanently delete those "garbage" commits during
+garbage collection. Those commits will be deleted after 30 days by
+default, see linkgit:git-gc[1] for more.
+
+There are 3 main ways you can end up in detached HEAD state:
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
+If you switch branches after making commits in detached HEAD state, Git
+will warn you that you might be about to "lose" those commits and print
+out the commit ID. You can also always find those commits later using
+linkgit:git-reflog[1].
+
+Here's what that warning looks like:
+
+-------------------------
+Warning: you are leaving 1 commit behind, not connected to
+any of your branches:
+
+  48c09f6 3
+-------------------------
+
+For a more in-depth explanation of how `HEAD` works in Git,
+see linkgit:gitdatamodel[7] (`git help datamodel`).
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
diff --git a/Documentation/gitdetached-head.adoc b/Documentation/gitdetached-head.adoc
new file mode 100644
index 0000000000..a477060db2
--- /dev/null
+++ b/Documentation/gitdetached-head.adoc
@@ -0,0 +1,14 @@
+gitdetached-head(7)
+===================
+
+NAME
+----
+gitdetached-head - How detached HEAD state works
+
+DESCRIPTION
+-----------
+include::detached-head.adoc[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index cfa9c67609..6b3141647f 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -197,6 +197,7 @@ manpages = {
   'gitcredentials.adoc' : 7,
   'gitcvs-migration.adoc' : 7,
   'gitdatamodel.adoc' : 7,
+  'gitdetached-head.adoc' : 7,
   'gitdiffcore.adoc' : 7,
   'giteveryday.adoc' : 7,
   'gitfaq.adoc' : 7,
diff --git a/advice.c b/advice.c
index 401d047391..8d2c1ff1ee 100644
--- a/advice.c
+++ b/advice.c
@@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
 	"\n"
 	"  git switch -\n"
 	"\n"
+	"Run `git help detached-head` to learn more.\n"
 	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
 
 	fprintf(stderr, fmt, new_name);
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..7fb57765fb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -218,6 +218,7 @@ gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
 gitdatamodel                            guide
+gitdetached-head                        guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
