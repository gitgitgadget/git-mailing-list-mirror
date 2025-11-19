Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497B301719
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588416; cv=none; b=iRpiFe+6XZBJKIFm6JCjO+3OtpwCLOxSvDdqek9CvBhkeCjuXszwWO8O2z3007zuOgWNLNiDMm3AsTK3uXZtjsUrCJftDs723E6KRU4cd7Y9dS3rG26Ijr1Wx9yBIBmt0vGlMnukKI71M/0szrlpi4OdQitre1KNZb9npWEhLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588416; c=relaxed/simple;
	bh=yHk7esnlOiyGcVsaWfk6slMUUkZ83/UJpIuygO0bfss=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=iGugHI9YE5bH045hcaQRKuClEGKexvwsHYT0j8DIDiG4MLR2Bs6pHxUl/MIjyktWpAgpgsoA1fw6rnVInclEx+o0h4Gcftc3937eVXoMuRcocvu1kYG2qXZWtkls9A1z7J2Id6mIVXhtGIoE0/DzCOtrmiWEnNyBLD7wSFeFdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAvE1D79; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAvE1D79"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-94903ea3766so7670939f.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588412; x=1764193212; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZnIAxY5XokAolJdwes/7BNirghr4YCkMPzDQZTwcVk=;
        b=BAvE1D79UX+u+wLOvWXaHEVJohAd+sHRTEVLlCwSEuxsnrJmU9ID0g8W42nGp5qAIN
         6AVg5RcPlboCki+rhvLoDNOmE6CnuR+QRFstxbNHnCGa7OdGhZmvchFlpu++vZOlnQ6v
         APED10LDjLbV6S+R+domCEh141Sz/U+k8FjyWBIjQ/mQjpwbiWk93eUJi0/bLdo7Ktjv
         Y4/P6WpGonLuv9jzLXKa7PXBHWtC6QGFhC8HDO4kFUry1ioYLHyx/388VlwPEbeaAh3a
         kFx0A/mDanDSjyf1WXHoKJpJ/ioPK0ZKT0LHp/+ttm7HuAUQ9wRhCPSgyDITv3gj2yVr
         6TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588412; x=1764193212;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZnIAxY5XokAolJdwes/7BNirghr4YCkMPzDQZTwcVk=;
        b=w8xks6Q2vnzzTqrpBvXESCe6H8UhkcBMcEFhAsoxwcRIQ4dYgVGKmHlRladf6ZqlP8
         6xoJ2qyOxiWlsA0tZKWUlaWiUnQ7UC5UpxyJCQKbmx3U2rhFvMUFiktumLNjr5WDylFG
         5Z25e6Fkq4W/B+JJfYmHtFhZtNWPjdV9TquvLb7ZrDtFUKt+QhZPMgQoAvVz+aAHaaZI
         3SmVrxCvxRhCf7k0Mtc7tdOQ9aV8JlxpIdXndflL4klBy/KL4y/av3U1+kuYMgDyL7Xx
         /MDKwXB3/AhdpEj7WA/XylCR0n4+t1PMT249YXjeWeNrVOqGI6m0KwgRqzaocA7r9wZi
         TQMA==
X-Gm-Message-State: AOJu0YxGQ5TKdakb3iieQ0jDzHP6VEwQSS4bsqs5KXkAr7yugSd0YEIE
	OCfTFob4AHZtX8UqNshn3xb+Z63JSirR04gk5x5D7GvFNH2D4vybkKW/x2+neQ==
X-Gm-Gg: ASbGncv7VkCQ7hWCrRD+di8AfDgKHIddNo9avycZpJRLJyzHh578cP+C/3eGvRz5Qn7
	/Ocq19k1B2nbJgWTb1s6RuCzYhFC4F7gYVXjJ6aE0JeoMoAttBSxY84AbUOWT8S1s4oSfGMzafF
	cKHViKjFnAzrK33KE3DxNDc3sbG00stO11Mwfbnu73tr253TL2KdU2HH+waHhtEw0zzD9+w2Tq8
	okwA/9BLKJHmeN4ZEGWhIhcmXjyuwf8zcV3QchYUIgcrXdsjYqzBluG9zfMkM7D3OTcWdG7ZX8O
	3elmUyvYkHhg1r8oiWu2Vv+0PivdqHWUYvomLUXIJ4xU9JaQXvXKxWegpNBait6pAgsdJmQf9Ht
	7LYuEyYnwqcGxiBKRb3rWJmBfBDP2vgjInILW/mmQu822b4NYLhopVaM0EwwYCb3H2zEFQeo5o7
	Lm8OC2VcEbr1GL
X-Google-Smtp-Source: AGHT+IGWiJYutL1Z2QapYSwW0EevFr2c/fJKsSV5x2kOKe9FGoCpR0tavfpWtxehwPUgga1usZRsXw==
X-Received: by 2002:a05:6638:6f07:b0:551:45bc:e4e6 with SMTP id 8926c6da1cb9f-5b954047d36mr692304173.7.1763588411868;
        Wed, 19 Nov 2025 13:40:11 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.50])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b212basm170738173.36.2025.11.19.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:40:11 -0800 (PST)
Message-Id: <e5526eaf58ce37507a3e9a9265476720399ad42e.1763588404.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
References: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 21:40:04 +0000
Subject: [PATCH 3/3] doc: convert git push to synopsis style
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
 Documentation/config/push.adoc | 113 +++++++-------
 Documentation/git-push.adoc    | 267 ++++++++++++++++++---------------
 2 files changed, 201 insertions(+), 179 deletions(-)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index 0acbbea18a..d9112b2260 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -1,15 +1,15 @@
-push.autoSetupRemote::
-	If set to "true" assume `--set-upstream` on default push when no
+`push.autoSetupRemote`::
+	If set to `true` assume `--set-upstream` on default push when no
 	upstream tracking exists for the current branch; this option
-	takes effect with push.default options 'simple', 'upstream',
-	and 'current'. It is useful if by default you want new branches
+	takes effect with `push.default` options `simple`, `upstream`,
+	and `current`. It is useful if by default you want new branches
 	to be pushed to the default remote (like the behavior of
-	'push.default=current') and you also want the upstream tracking
+	`push.default=current`) and you also want the upstream tracking
 	to be set. Workflows most likely to benefit from this option are
-	'simple' central workflows where all branches are expected to
+	`simple` central workflows where all branches are expected to
 	have the same name on the remote.
 
-push.default::
+`push.default`::
 	Defines the action `git push` should take if no refspec is
 	given (whether from the command-line, config, or elsewhere).
 	Different values are well-suited for
@@ -18,24 +18,28 @@ push.default::
 	`upstream` is probably what you want.  Possible values are:
 +
 --
-
-* `nothing` - do not push anything (error out) unless a refspec is
-  given. This is primarily meant for people who want to
-  avoid mistakes by always being explicit.
-
-* `current` - push the current branch to update a branch with the same
-  name on the receiving end.  Works in both central and non-central
-  workflows.
-
-* `upstream` - push the current branch back to the branch whose
-  changes are usually integrated into the current branch (which is
-  called `@{upstream}`).  This mode only makes sense if you are
-  pushing to the same repository you would normally pull from
-  (i.e. central workflow).
-
-* `tracking` - This is a deprecated synonym for `upstream`.
-
-* `simple` - push the current branch with the same name on the remote.
+`nothing`;;
+do not push anything (error out) unless a refspec is
+given. This is primarily meant for people who want to
+avoid mistakes by always being explicit.
+
+`current`;;
+push the current branch to update a branch with the same
+name on the receiving end.  Works in both central and non-central
+workflows.
+
+`upstream`;;
+push the current branch back to the branch whose
+changes are usually integrated into the current branch (which is
+called `@{upstream}`).  This mode only makes sense if you are
+pushing to the same repository you would normally pull from
+(i.e. central workflow).
+
+`tracking`;;
+this is a deprecated synonym for `upstream`.
+
+`simple`;;
+push the current branch with the same name on the remote.
 +
 If you are working on a centralized workflow (pushing to the same repository you
 pull from, which is typically `origin`), then you need to configure an upstream
@@ -44,16 +48,17 @@ branch with the same name.
 This mode is the default since Git 2.0, and is the safest option suited for
 beginners.
 
-* `matching` - push all branches having the same name on both ends.
-  This makes the repository you are pushing to remember the set of
-  branches that will be pushed out (e.g. if you always push 'maint'
-  and 'master' there and no other branches, the repository you push
-  to will have these two branches, and your local 'maint' and
-  'master' will be pushed there).
+`matching`;;
+push all branches having the same name on both ends.
+This makes the repository you are pushing to remember the set of
+branches that will be pushed out (e.g. if you always push `maint`
+and `master` there and no other branches, the repository you push
+to will have these two branches, and your local `maint` and
+`master` will be pushed there).
 +
 To use this mode effectively, you have to make sure _all_ the
 branches you would push out are ready to be pushed out before
-running 'git push', as the whole point of this mode is to allow you
+running `git push`, as the whole point of this mode is to allow you
 to push all of the branches in one go.  If you usually finish work
 on only one branch and push out the result, while other branches are
 unfinished, this mode is not for you.  Also this mode is not
@@ -66,24 +71,24 @@ new default).
 
 --
 
-push.followTags::
+`push.followTags`::
 	If set to true, enable `--follow-tags` option by default.  You
 	may override this configuration at time of push by specifying
 	`--no-follow-tags`.
 
-push.gpgSign::
-	May be set to a boolean value, or the string 'if-asked'. A true
+`push.gpgSign`::
+	May be set to a boolean value, or the string `if-asked`. A true
 	value causes all pushes to be GPG signed, as if `--signed` is
-	passed to linkgit:git-push[1]. The string 'if-asked' causes
+	passed to linkgit:git-push[1]. The string `if-asked` causes
 	pushes to be signed if the server supports it, as if
-	`--signed=if-asked` is passed to 'git push'. A false value may
+	`--signed=if-asked` is passed to `git push`. A false value may
 	override a value from a lower-priority config file. An explicit
 	command-line flag always overrides this config option.
 
-push.pushOption::
+`push.pushOption`::
 	When no `--push-option=<option>` argument is given from the
-	command line, `git push` behaves as if each <value> of
-	this variable is given as `--push-option=<value>`.
+	command line, `git push` behaves as if each _<option>_ of
+	this variable is given as `--push-option=<option>`.
 +
 This is a multi-valued variable, and an empty value can be used in a
 higher priority configuration file (e.g. `.git/config` in a
@@ -109,26 +114,26 @@ This will result in only b (a and c are cleared).
 
 ----
 
-push.recurseSubmodules::
-	May be "check", "on-demand", "only", or "no", with the same behavior
-	as that of "push --recurse-submodules".
-	If not set, 'no' is used by default, unless 'submodule.recurse' is
-	set (in which case a 'true' value means 'on-demand').
+`push.recurseSubmodules`::
+	May be `check`, `on-demand`, `only`, or `no`, with the same behavior
+	as that of `push --recurse-submodules`.
+	If not set, `no` is used by default, unless `submodule.recurse` is
+	set (in which case a `true` value means `on-demand`).
 
-push.useForceIfIncludes::
-	If set to "true", it is equivalent to specifying
+`push.useForceIfIncludes`::
+	If set to `true`, it is equivalent to specifying
 	`--force-if-includes` as an option to linkgit:git-push[1]
 	in the command line. Adding `--no-force-if-includes` at the
 	time of push overrides this configuration setting.
 
-push.negotiate::
-	If set to "true", attempt to reduce the size of the packfile
+`push.negotiate`::
+	If set to `true`, attempt to reduce the size of the packfile
 	sent by rounds of negotiation in which the client and the
-	server attempt to find commits in common. If "false", Git will
+	server attempt to find commits in common. If `false`, Git will
 	rely solely on the server's ref advertisement to find commits
 	in common.
 
-push.useBitmaps::
-	If set to "false", disable use of bitmaps for "git push" even if
-	`pack.useBitmaps` is "true", without preventing other git operations
-	from using bitmaps. Default is true.
+`push.useBitmaps`::
+	If set to `false`, disable use of bitmaps for `git push` even if
+	`pack.useBitmaps` is `true`, without preventing other git operations
+	from using bitmaps. Default is `true`.
diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 864b0d0467..e5ba3a6742 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -8,13 +8,13 @@ git-push - Update remote refs along with associated objects
 
 SYNOPSIS
 --------
-[verse]
-'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-q | --quiet] [-v | --verbose]
-	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
-	   [--[no-]signed|--signed=(true|false|if-asked)]
-	   [--force-with-lease[=<refname>[:<expect>]] [--force-if-includes]]
-	   [--no-verify] [<repository> [<refspec>...]]
+[synopsis]
+git push [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+	 [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-q | --quiet] [-v | --verbose]
+	 [-u | --set-upstream] [-o <string> | --push-option=<string>]
+	 [--[no-]signed | --signed=(true|false|if-asked)]
+	 [--force-with-lease[=<refname>[:<expect>]] [--force-if-includes]]
+	 [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
 -----------
@@ -35,7 +35,7 @@ To decide which branches, tags, or other refs to push, Git uses
 
 1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
    or the `--all`, `--mirror`, or `--tags` options
-2. The `remote.*.push` configuration for the repository being pushed to
+2. The `remote.<name>.push` configuration for the repository being pushed to
 3. The `push.default` configuration. The default is `push.default=simple`,
    which will push to a branch with the same name as the current branch.
    See the <<CONFIGURATION,CONFIGURATION>> section below for more on `push.default`.
@@ -49,25 +49,25 @@ You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
 
-
-OPTIONS[[OPTIONS]]
-------------------
-<repository>::
+[[OPTIONS]]
+OPTIONS
+-------
+_<repository>_::
 	The "remote" repository that is the destination of a push
 	operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
 
-<refspec>...::
+`<refspec>...`::
 	Specify what destination ref to update with what source object.
 +
-The format for a refspec is [+]<src>[:<dst>], for example `main`,
+The format for a refspec is `[+]<src>[:<dst>]`, for example `main`,
 `main:other`, or `HEAD^:refs/heads/main`.
 +
-The `<src>` is often the name of the local branch to push, but it can be
+The _<src>_ is often the name of the local branch to push, but it can be
 any arbitrary "SHA-1 expression" (see linkgit:gitrevisions[7]).
 +
-The `<dst>` determines what ref to update on the remote side. It must be the
+The _<dst>_ determines what ref to update on the remote side. It must be the
 name of a branch, tag, or other ref, not an arbitrary expression.
 +
 The `+` is optional and does the same thing as `--force`.
@@ -78,23 +78,23 @@ and destination, or with a shorter form (for example `main` or
 `main:other`). Here are the rules for how refspecs are expanded,
 as well as various other special refspec forms:
 +
- *  `<src>` without a `:<dst>` means to update the same ref as the
-    `<src>`, unless the `remote.<repository>.push` configuration specifies a
-    different <dst>. For example, if `main` is a branch, then the refspec
+ *  _<src>_ without a `:<dst>` means to update the same ref as the
+    _<src>_, unless the `remote.<repository>.push` configuration specifies a
+    different _<dst>_. For example, if `main` is a branch, then the refspec
     `main` expands to `main:refs/heads/main`.
- *  If `<dst>` unambiguously refers to a ref on the <repository> remote,
+ *  If _<dst>_ unambiguously refers to a ref on the <repository> remote,
     then expand it to that ref. For example, if `v1.0` is a tag on the
     remote, then `HEAD:v1.0` expands to `HEAD:refs/tags/v1.0`.
- *  If `<src>` resolves to a ref starting with `refs/heads/` or `refs/tags/`,
+ *  If _<src>_ resolves to a ref starting with `refs/heads/` or `refs/tags/`,
     then prepend that to <dst>. For example, if `main` is a branch, then
     `main:other` expands to `main:refs/heads/other`
  *  The special refspec `:` (or `+:` to allow non-fast-forward updates)
     directs Git to push "matching" branches: for every branch that exists on
     the local side, the remote side is updated if a branch of the same name
     already exists on the remote side.
- *  <src> may contain a * to indicate a simple pattern match.
+ *  _<src>_ may contain a `*` to indicate a simple pattern match.
     This works like a glob that matches any ref matching the pattern.
-    There must be only one * in both the `<src>` and `<dst>`.
+    There must be only one `*` in both the `<src>` and `<dst>`.
     It will map refs to the destination by replacing the * with the
     contents matched from the source. For example, `refs/heads/*:refs/heads/*`
     will push all branches.
@@ -102,11 +102,11 @@ as well as various other special refspec forms:
     This specifies refs to exclude. A ref will be considered to
     match if it matches at least one positive refspec, and does not
     match any negative refspec. Negative refspecs can be pattern refspecs.
-    They must only contain a `<src>`.
+    They must only contain a _<src>_.
     Fully spelled out hex object names are also not supported.
     For example, `git push origin 'refs/heads/*' '^refs/heads/dev-*'`
     will push all branches except for those starting with `dev-`
- *  If `<src>` is empty, it deletes the `<dst>` ref from the remote
+ *  If _<src>_ is empty, it deletes the _<dst>_ ref from the remote
     repository. For example, `git push origin :dev` will
     delete the `dev` branch.
  *  `tag <tag>` expands to `refs/tags/<tag>:refs/tags/<tag>`.
@@ -121,12 +121,12 @@ as well as various other special refspec forms:
 
 Not all updates are allowed: see PUSH RULES below for the details.
 
---all::
---branches::
+`--all`::
+`--branches`::
 	Push all branches (i.e. refs under `refs/heads/`); cannot be
 	used with other <refspec>.
 
---prune::
+`--prune`::
 	Remove remote branches that don't have a local counterpart. For example
 	a remote branch `tmp` will be removed if a local branch with the same
 	name doesn't exist any more. This also respects refspecs, e.g.
@@ -134,7 +134,7 @@ Not all updates are allowed: see PUSH RULES below for the details.
 	make sure that remote `refs/tmp/foo` will be removed if `refs/heads/foo`
 	doesn't exist.
 
---mirror::
+`--mirror`::
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/` (which includes but is not
 	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
@@ -145,26 +145,26 @@ Not all updates are allowed: see PUSH RULES below for the details.
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do everything except actually send the updates.
 
---porcelain::
+`--porcelain`::
 	Produce machine-readable output.  The output status line for each ref
 	will be tab-separated and sent to stdout instead of stderr.  The full
 	symbolic names of the refs will be given.
 
--d::
---delete::
+`-d`::
+`--delete`::
 	All listed refs are deleted from the remote repository. This is
 	the same as prefixing all refs with a colon.
 
---tags::
+`--tags`::
 	All refs under `refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
 	line.
 
---follow-tags::
+`--follow-tags`::
 	Push all the refs that would be pushed without this option,
 	and also push annotated tags in `refs/tags` that are missing
 	from the remote but are pointing at commit-ish that are
@@ -172,29 +172,34 @@ Not all updates are allowed: see PUSH RULES below for the details.
 	with configuration variable `push.followTags`.  For more
 	information, see `push.followTags` in linkgit:git-config[1].
 
---signed::
---no-signed::
---signed=(true|false|if-asked)::
+`--signed`::
+`--no-signed`::
+`--signed=(true|false|if-asked)`::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
-	logged.  If `false` or `--no-signed`, no signing will be
-	attempted.  If `true` or `--signed`, the push will fail if the
-	server does not support signed pushes.  If set to `if-asked`,
-	sign if and only if the server supports signed pushes.  The push
-	will also fail if the actual call to `gpg --sign` fails.  See
-	linkgit:git-receive-pack[1] for the details on the receiving end.
-
---atomic::
---no-atomic::
+	logged. Possible values are:
+`false`;;
+`--no-signed`;;
+no signing will be attempted.
+`true`;;
+`--signed`;;
+the push will fail if the server does not support signed pushes.
+`if-asked`;;
+sign if and only if the server supports signed pushes.  The push
+will also fail if the actual call to `gpg --sign` fails.  See
+linkgit:git-receive-pack[1] for the details on the receiving end.
+
+`--atomic`::
+`--no-atomic`::
 	Use an atomic transaction on the remote side if available.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
--o <option>::
---push-option=<option>::
+`-o <option>`::
+`--push-option=<option>`::
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
-	must not contain a NUL or LF character.
+	must not contain a _NUL_ or _LF_ character.
 	When multiple `--push-option=<option>` are given, they are
 	all sent to the other side in the order listed on the
 	command line.
@@ -202,22 +207,22 @@ Not all updates are allowed: see PUSH RULES below for the details.
 	line, the values of configuration variable `push.pushOption`
 	are used instead.
 
---receive-pack=<git-receive-pack>::
---exec=<git-receive-pack>::
+`--receive-pack=<git-receive-pack>`::
+`--exec=<git-receive-pack>`::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
-	a directory on the default $PATH.
+	a directory on the default `$PATH`.
 
---force-with-lease::
---no-force-with-lease::
---force-with-lease=<refname>::
---force-with-lease=<refname>:<expect>::
-	Usually, "git push" refuses to update a remote ref that is
+`--force-with-lease`::
+`--no-force-with-lease`::
+`--force-with-lease=<refname>`::
+`--force-with-lease=<refname>:<expect>`::
+	Usually, `git push` refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 +
 This option overrides this restriction if the current value of the
-remote ref is the expected value.  "git push" fails otherwise.
+remote ref is the expected value.  `git push` fails otherwise.
 +
 Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
@@ -239,16 +244,16 @@ current value to be the same as the remote-tracking branch we have
 for them.
 +
 `--force-with-lease=<refname>`, without specifying the expected value, will
-protect the named ref (alone), if it is going to be updated, by
+protect _<refname>_ (alone), if it is going to be updated, by
 requiring its current value to be the same as the remote-tracking
 branch we have for it.
 +
-`--force-with-lease=<refname>:<expect>` will protect the named ref (alone),
+`--force-with-lease=<refname>:<expect>` will protect _<refname>_ (alone),
 if it is going to be updated, by requiring its current value to be
-the same as the specified value `<expect>` (which is allowed to be
+the same as the specified value _<expect>_ (which is allowed to be
 different from the remote-tracking branch we have for the refname,
 or we do not even have to have such a remote-tracking branch when
-this form is used).  If `<expect>` is the empty string, then the named ref
+this form is used).  If _<expect>_ is the empty string, then the named ref
 must not already exist.
 +
 Note that all forms other than `--force-with-lease=<refname>:<expect>`
@@ -256,7 +261,7 @@ that specifies the expected current value of the ref explicitly are
 still experimental and their semantics may change as we gain experience
 with this feature.
 +
-"--no-force-with-lease" will cancel all the previous --force-with-lease on the
+`--no-force-with-lease` will cancel all the previous `--force-with-lease` on the
 command line.
 +
 A general note on safety: supplying this option without an expected
@@ -276,23 +281,29 @@ If your editor or some other system is running `git fetch` in the
 background for you a way to mitigate this is to simply set up another
 remote:
 +
-	git remote add origin-push $(git config remote.origin.url)
-	git fetch origin-push
+----
+git remote add origin-push $(git config remote.origin.url)
+git fetch origin-push
+----
 +
 Now when the background process runs `git fetch origin` the references
 on `origin-push` won't be updated, and thus commands like:
 +
-	git push --force-with-lease origin-push
+----
+git push --force-with-lease origin-push
+----
 +
 Will fail unless you manually run `git fetch origin-push`. This method
 is of course entirely defeated by something that runs `git fetch
 --all`, in that case you'd need to either disable it or do something
 more tedious like:
 +
-	git fetch              # update 'master' from remote
-	git tag base master    # mark our base point
-	git rebase -i master   # rewrite some commits
-	git push --force-with-lease=master:base master:master
+----
+git fetch              # update 'master' from remote
+git tag base master    # mark our base point
+git rebase -i master   # rewrite some commits
+git push --force-with-lease=master:base master:master
+----
 +
 I.e. create a `base` tag for versions of the upstream code that you've
 seen and are willing to overwrite, then rewrite history, and finally
@@ -308,26 +319,26 @@ verify if updates from the remote-tracking refs that may have been
 implicitly updated in the background are integrated locally before
 allowing a forced update.
 
--f::
---force::
+`-f`::
+`--force`::
 	Usually, `git push` will refuse to update a branch that is not an
 	ancestor of the commit being pushed.
 +
 This flag disables that check, the other safety checks in PUSH RULES
-below, and the checks in --force-with-lease. It can cause the remote
+below, and the checks in `--force-with-lease`. It can cause the remote
 repository to lose commits; use it with care.
 +
 Note that `--force` applies to all the refs that are pushed, hence
 using it with `push.default` set to `matching` or with multiple push
-destinations configured with `remote.*.push` may overwrite refs
+destinations configured with `remote.<name>.push` may overwrite refs
 other than the current branch (including local refs that are
 strictly behind their remote counterpart).  To force a push to only
 one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
---force-if-includes::
---no-force-if-includes::
+`--force-if-includes`::
+`--no-force-if-includes`::
 	Force an update only if the tip of the remote-tracking ref
 	has been integrated locally.
 +
@@ -343,72 +354,78 @@ a "no-op".
 +
 Specifying `--no-force-if-includes` disables this behavior.
 
---repo=<repository>::
-	This option is equivalent to the <repository> argument. If both
+`--repo=<repository>`::
+	This option is equivalent to the _<repository>_ argument. If both
 	are specified, the command-line argument takes precedence.
 
--u::
---set-upstream::
+`-u`::
+`--set-upstream`::
 	For every branch that is up to date or successfully pushed, add
 	upstream (tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` in linkgit:git-config[1].
 
---thin::
---no-thin::
+`--thin`::
+`--no-thin`::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
 	receiver share many of the same objects in common. The default is
 	`--thin`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Suppress all output, including the listing of updated refs,
 	unless an error occurs. Progress is not reported to the standard
 	error stream.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Run verbosely.
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
+	by default when it is attached to a terminal, unless `-q`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---no-recurse-submodules::
---recurse-submodules=check|on-demand|only|no::
+`--no-recurse-submodules`::
+`--recurse-submodules=(check|on-demand|only|no)`::
 	May be used to make sure all submodule commits used by the
 	revisions to be pushed are available on a remote-tracking branch.
-	If 'check' is used Git will verify that all submodule commits that
+	Possible values are:
+`check`;;
+        Git will verify that all submodule commits that
 	changed in the revisions to be pushed are available on at least one
 	remote of the submodule. If any commits are missing the push will
-	be aborted and exit with non-zero status. If 'on-demand' is used
+	be aborted and exit with non-zero status.
+`on-demand`;;
 	all submodules that changed in the revisions to be pushed will be
-	pushed. If on-demand was not able to push all necessary revisions it will
-	also be aborted and exit with non-zero status. If 'only' is used all
-	submodules will be pushed while the superproject is left
-	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
-	to override the push.recurseSubmodules configuration variable when no
-	submodule recursion is required.
-+
-When using 'on-demand' or 'only', if a submodule has a
-"push.recurseSubmodules={on-demand,only}" or "submodule.recurse" configuration,
-further recursion will occur. In this case, "only" is treated as "on-demand".
-
---verify::
---no-verify::
+	pushed. If `on-demand` was not able to push all necessary revisions it will
+	also be aborted and exit with non-zero status.
+`only`;;
+	all submodules will be pushed while the superproject is left
+	unpushed.
+`no`;;
+	override the `push.recurseSubmodules` configuration variable when no
+	submodule recursion is required. Similar to using `--no-recurse-submodules`.
+
++
+When using `on-demand` or `only`, if a submodule has a
+`push.recurseSubmodules=(on-demand|only)` or `submodule.recurse` configuration,
+further recursion will occur. In this case, `only` is treated as `on-demand`.
+
+`--verify`::
+`--no-verify`::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
-	default is --verify, giving the hook a chance to prevent the
-	push.  With --no-verify, the hook is bypassed completely.
+	default is `--verify`, giving the hook a chance to prevent the
+	push.  With `--no-verify`, the hook is bypassed completely.
 
--4::
---ipv4::
+`-4`::
+`--ipv4`::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
 
--6::
---ipv6::
+`-6`::
+`--ipv6`::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
 
 include::urls-remotes.adoc[]
@@ -427,16 +444,16 @@ representing the status of a single ref. Each line is of the form:
  <flag> <summary> <from> -> <to> (<reason>)
 -------------------------------
 
-If --porcelain is used, then each line of the output is of the form:
+If `--porcelain` is used, then each line of the output is of the form:
 
 -------------------------------
  <flag> \t <from>:<to> \t <summary> (<reason>)
 -------------------------------
 
-The status of up-to-date refs is shown only if --porcelain or --verbose
+The status of up-to-date refs is shown only if `--porcelain` or `--verbose`
 option is used.
 
-flag::
+_<flag>_::
 	A single character indicating the status of the ref:
 (space);; for a successfully pushed fast-forward;
 `+`;; for a successful forced update;
@@ -445,7 +462,7 @@ flag::
 `!`;; for a ref that was rejected or failed to push; and
 `=`;; for a ref that was up to date and did not need pushing.
 
-summary::
+_<summary>_::
 	For a successfully pushed ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
@@ -586,7 +603,7 @@ Updating A with the resulting merge commit will fast-forward and your
 push will be accepted.
 
 Alternatively, you can rebase your change between X and B on top of A,
-with "git pull --rebase", and push the result back.  The rebase will
+with `git pull --rebase`, and push the result back.  The rebase will
 create a new commit D that builds the change between X and B on top of
 A.
 
@@ -604,12 +621,12 @@ accepted.
 There is another common situation where you may encounter non-fast-forward
 rejection when you try to push, and it is possible even when you are
 pushing into a repository nobody else pushes into. After you push commit
-A yourself (in the first picture in this section), replace it with "git
-commit --amend" to produce commit B, and you try to push it out, because
+A yourself (in the first picture in this section), replace it with `git
+commit --amend` to produce commit B, and you try to push it out, because
 forgot that you have pushed A out already. In such a case, and only if
 you are certain that nobody in the meantime fetched your earlier commit A
-(and started building on top of it), you can run "git push --force" to
-overwrite it. In other words, "git push --force" is a method reserved for
+(and started building on top of it), you can run `git push --force` to
+overwrite it. In other words, `git push --force` is a method reserved for
 a case where you do mean to lose history.
 
 
@@ -627,18 +644,18 @@ EXAMPLES
 	variable) if it has the same name as the current branch, and
 	errors out without pushing otherwise.
 +
-The default behavior of this command when no <refspec> is given can be
+The default behavior of this command when no _<refspec>_ is given can be
 configured by setting the `push` option of the remote, or the `push.default`
 configuration variable.
 +
 For example, to default to pushing only the current branch to `origin`
-use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
+use `git config remote.origin.push HEAD`.  Any valid _<refspec>_ (like
 the ones in the examples below) can be configured as the default for
 `git push origin`.
 
 `git push origin :`::
 	Push "matching" branches to `origin`. See
-	<refspec> in the <<OPTIONS,OPTIONS>> section above for a
+	_<refspec>_ in the <<OPTIONS,OPTIONS>> section above for a
 	description of "matching" branches.
 
 `git push origin master`::
-- 
gitgitgadget
