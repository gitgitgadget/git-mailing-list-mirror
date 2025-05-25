Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD31C860E
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204843; cv=none; b=jul8cVBf0vHHATO5dVsN5StrUGivp6+WZcwDMHdsIsQP+QhTRjtNp6Gvf4mdqOcZ4Ls6YZL05ypP8Yi/HMDDuY+nP6rJOeLNWzh5UkmpUlvDp5r3YYqPBSQ2nyVHgWyjkehPwVwzCm4kmQQfeXb51a7030dWIkAYl8WehWZgdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204843; c=relaxed/simple;
	bh=OEWSZ/3vlBjwe/7TqMbVLKFDK9g7SEomRIgpxiAFDuA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SSjZzZBFXYSuHvS5n/J5zxf8ApxT58P4I7jdaHzot0kcDA8YDupTnJGfmcwR/iIVj/Buao4dQJlPRRtflyEdLLJnyXH/hkQM3wEiP18V1uEHryFtDY7KpxaDg0JFnmDJSKbkVGVBBIMx+aWnHI6GzHZhuqAT3/iGA+KdR/ZG1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK9N9klW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK9N9klW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4c6c0a9c7so1022954f8f.3
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204839; x=1748809639; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87N4pEz5xo1ynrZKrdeJwQDfvI9ayV0SThQKae/r73I=;
        b=gK9N9klWsZRQXqnXEO06ZTEocaFYo6a0K5AVzYzkdF9Y3tvJqns57hZVtsVeKqkicC
         99wUnFhnGWw+HXkDNDcYIb0tp2kzTyLMCJ5iOZQ4RL1iEyrnBdYL4TDol16yu8/mbDqt
         ne0w/E95RCN5EYJGGV9VbI1lQISaZDM3V4xpq2/Io2l2POV0V2dXNV7YSedNrEsVekSS
         +sZG+oyyCTPQ1s5kiB9oVHhw7HIsF6Vg/ew7+WcBva4WNg0Mv5YtL9P6PsPGFR9U+pAE
         Y7HEvVsOoSmwXFKiKChXAYdEzqyfTbmDuC3Spmwal36gM0XzVj/GGsZr+Z+g/+oWaycL
         gy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204839; x=1748809639;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87N4pEz5xo1ynrZKrdeJwQDfvI9ayV0SThQKae/r73I=;
        b=j026gGvXz1FO4Hoe1w86wNB8rVO8hi8TdNDNb3u9869U7UHFdzQBGnb6eUsKNXz7/2
         mao7ufLtTA4Et7hXKwHQ/70Q5nznqmMa+jl97gAO+EgoMHv3EUpTAtFZvRxY+4RQjd42
         IaR/Q3o3LbuJBZHHRtebC+LHapo9QMCvq2cTRxzLKmF3ARzDykdxAbvTVV4v3ikUgYiL
         2m3t9xaG6nUT40rUrxzwQVTALDcZzfxCB6p5+i6oxknrWY7RadDYAhGoJucn24QRf99z
         wxdg8Fmeh3k+Bwi3WDPzIiOWaw+uxBXDPxZmr/aGl9WbpbLxOS9V3ixqwkVhwu4Q+43W
         PDmw==
X-Gm-Message-State: AOJu0YxFoffJGlOdboeGQpm+J7OJuDvLABlaqLnI9M1M5ndam69QYuJa
	U1z+243ITkBkP7fBsc9mZnRw001KS9TsZW8vkhI2f1Zs9U0tcPUO5yJApeFD6g==
X-Gm-Gg: ASbGncs/oFUMntkDBL3/mDlGu+PE0dDqQRimqqpmqgfQTdkkDEsfo7tySJTKpHEvqY/
	EExqyBxK/N20ncwBYKQc2G2Nuzc/HkPy+UXKI+5iFQLj6aqcoo+s1tHNF5vtBlbfbpPUXl7xh4K
	/kQa1HxiJpn3RWYPLZOwJI6Y/8W3sdB6X3h6hDK5Ii29RF+FQU6VWirwwnp9f8C+p1DTwjn9Fqp
	BoyqfJ2PPOULc0NuTQ4uCqznlWA7en+FmXQrnX+dqcoM0xfGLGG/7s+SFgFF0dQvaoXIRP2c4a9
	/6KXJ2jnCGsom5GPRG9u0UKSX/GwpyVLV6xpjg988V6tSgT8FUQl
X-Google-Smtp-Source: AGHT+IGneJtmF6RyT+2UfVFFKCeroqktgL+hoMzb5FsnO6ALeMWP3an8pQmh8V98ogc1K6uYtHnTtA==
X-Received: by 2002:a5d:5f8a:0:b0:3a4:d9fa:f1ea with SMTP id ffacd0b85a97d-3a4d9faf3c3mr385375f8f.7.1748204838724;
        Sun, 25 May 2025 13:27:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29619sm226541145e9.7.2025.05.25.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:18 -0700 (PDT)
Message-Id: <088a4c9cbfcd0928f4e8e112880ccf49569c339c.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:09 +0000
Subject: [PATCH 9/9] doc: convert git-switch manpage to new synopsis style
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
 Documentation/git-switch.adoc | 114 +++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index f55315c51ea0..9f62abf9e2b8 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -7,11 +7,11 @@ git-switch - Switch branches
 
 SYNOPSIS
 --------
-[verse]
-'git switch' [<options>] [--no-guess] <branch>
-'git switch' [<options>] --detach [<start-point>]
-'git switch' [<options>] (-c|-C) <new-branch> [<start-point>]
-'git switch' [<options>] --orphan <new-branch>
+[synopsis]
+git switch [<options>] [--no-guess] <branch>
+git switch [<options>] --detach [<start-point>]
+git switch [<options>] (-c|-C) <new-branch> [<start-point>]
+git switch [<options>] --orphan <new-branch>
 
 DESCRIPTION
 -----------
@@ -33,33 +33,33 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 OPTIONS
 -------
-<branch>::
+_<branch>_::
 	Branch to switch to.
 
-<new-branch>::
+_<new-branch>_::
 	Name for the new branch.
 
-<start-point>::
+_<start-point>_::
 	The starting point for the new branch. Specifying a
-	`<start-point>` allows you to create a branch based on some
-	other point in history than where HEAD currently points. (Or,
+	_<start-point>_ allows you to create a branch based on some
+	other point in history than where `HEAD` currently points. (Or,
 	in the case of `--detach`, allows you to inspect and detach
 	from some other point.)
 +
-You can use the `@{-N}` syntax to refer to the N-th last
-branch/commit switched to using "git switch" or "git checkout"
+You can use the `@{-<N>}` syntax to refer to the _<N>_-th last
+branch/commit switched to using `git switch` or `git checkout`
 operation. You may also specify `-` which is synonymous to `@{-1}`.
 This is often used to switch quickly between two branches, or to undo
 a branch switch by mistake.
 +
-As a special case, you may use `A...B` as a shortcut for the merge
-base of `A` and `B` if there is exactly one merge base. You can leave
-out at most one of `A` and `B`, in which case it defaults to `HEAD`.
-
--c <new-branch>::
---create <new-branch>::
-	Create a new branch named `<new-branch>` starting at
-	`<start-point>` before switching to the branch. This is the
+As a special case, you may use `<rev-a>...<rev-b>` as a shortcut for the merge
+base of _<rev-a>_ and _<rev-b>_ if there is exactly one merge base. You can leave
+out at most one of _<rev-a>_ and _<rev-b>_, in which case it defaults to `HEAD`.
+
+`-c <new-branch>`::
+`--create <new-branch>`::
+	Create a new branch named _<new-branch>_ starting at
+	_<start-point>_ before switching to the branch. This is the
 	transactional equivalent of
 +
 ------------
@@ -67,32 +67,32 @@ $ git branch <new-branch>
 $ git switch <new-branch>
 ------------
 +
-that is to say, the branch is not reset/created unless "git switch" is
+that is to say, the branch is not reset/created unless `git switch` is
 successful (e.g., when the branch is in use in another worktree, not
 just the current branch stays the same, but the branch is not reset to
 the start-point, either).
 
--C <new-branch>::
---force-create <new-branch>::
-	Similar to `--create` except that if `<new-branch>` already
-	exists, it will be reset to `<start-point>`. This is a
+`-C <new-branch>`::
+`--force-create <new-branch>`::
+	Similar to `--create` except that if _<new-branch>_ already
+	exists, it will be reset to _<start-point>_. This is a
 	convenient shortcut for:
 +
 ------------
-$ git branch -f <new-branch>
-$ git switch <new-branch>
+$ git branch -f _<new-branch>_
+$ git switch _<new-branch>_
 ------------
 
--d::
---detach::
+`-d`::
+`--detach`::
 	Switch to a commit for inspection and discardable
 	experiments. See the "DETACHED HEAD" section in
 	linkgit:git-checkout[1] for details.
 
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
@@ -101,9 +101,9 @@ $ git switch -c <branch> --track <remote>/<branch>
 +
 If the branch exists in multiple remotes and one of them is named by
 the `checkout.defaultRemote` configuration variable, we'll use that
-one for the purposes of disambiguation, even if the `<branch>` isn't
+one for the purposes of disambiguation, even if the _<branch>_ isn't
 unique across all remotes. Set it to e.g. `checkout.defaultRemote=origin`
-to always checkout remote branches from there if `<branch>` is
+to always checkout remote branches from there if _<branch>_ is
 ambiguous but exists on the 'origin' remote. See also
 `checkout.defaultRemote` in linkgit:git-config[1].
 +
@@ -112,19 +112,19 @@ ambiguous but exists on the 'origin' remote. See also
 The default behavior can be set via the `checkout.guess` configuration
 variable.
 
--f::
---force::
+`-f`::
+`--force`::
 	An alias for `--discard-changes`.
 
---discard-changes::
+`--discard-changes`::
 	Proceed even if the index or the working tree differs from
 	`HEAD`. Both the index and working tree are restored to match
 	the switching target. If `--recurse-submodules` is specified,
 	submodule content is also restored to match the switching
 	target. This is used to throw away local changes.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	If you have local modifications to one or more files that are
 	different between the current branch and the branch to which
 	you are switching, the command refuses to switch branches in
@@ -138,25 +138,25 @@ paths are left unmerged, and you need to resolve the conflicts
 and mark the resolved paths with `git add` (or `git rm` if the merge
 should result in deletion of the path).
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
-	"merge" (default), "diff3", and "zdiff3".
+	`merge` (default), `diff3`, and `zdiff3`.
 
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
 
--t::
---track [direct|inherit]::
+`-t`::
+`--track[ (direct|inherit)]`::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
@@ -171,22 +171,22 @@ given name has no slash, or the above guessing results in an empty
 name, the guessing is aborted.  You can explicitly give a name with
 `-c` in such a case.
 
---no-track::
+`--no-track`::
 	Do not set up "upstream" configuration, even if the
 	`branch.autoSetupMerge` configuration variable is true.
 
---orphan <new-branch>::
-	Create a new unborn branch, named `<new-branch>`. All
+`--orphan <new-branch>`::
+	Create a new unborn branch, named _<new-branch>_. All
 	tracked files are removed.
 
---ignore-other-worktrees::
+`--ignore-other-worktrees`::
 	`git switch` refuses when the wanted ref is already
 	checked out by another worktree. This option makes it check
 	the ref out anyway. In other words, the ref can be held by
 	more than one worktree.
 
---recurse-submodules::
---no-recurse-submodules::
+`--recurse-submodules`::
+`--no-recurse-submodules`::
 	Using `--recurse-submodules` will update the content of all
 	active submodules according to the commit recorded in the
 	superproject. If nothing (or `--no-recurse-submodules`) is
@@ -239,7 +239,7 @@ $ git switch -
 ------------
 
 You can grow a new branch from any commit. For example, switch to
-"HEAD~3" and create branch "fixup":
+"`HEAD~3`" and create branch "`fixup`":
 
 ------------
 $ git switch -c fixup HEAD~3
@@ -251,8 +251,8 @@ name:
 
 ------------
 $ git switch new-topic
-Branch 'new-topic' set up to track remote branch 'new-topic' from 'origin'
-Switched to a new branch 'new-topic'
+Branch `new-topic` set up to track remote branch `new-topic` from `origin`
+Switched to a new branch `new-topic`
 ------------
 
 To check out commit `HEAD~3` for temporary inspection or experiment
-- 
gitgitgadget
