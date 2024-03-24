Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B573FB8B
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318750; cv=none; b=pverTlPQ5o3njkajWYwEEDSeLVqSbNElvwFYvosJKbUJyP0/sdH5mDFe/3plPCyIUq+axzaplsDI3Yd1tQdDtUj6yYTy84QohcK3Z8OFygIiZdwAk0crvCYZXi65p1J6g5Ry5iXWCs4oTsuL8Y0OR5J+SFZxwACkYDLZX6tzdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318750; c=relaxed/simple;
	bh=J5PS/X3TltXwi6QdB1XA2pR31RkPq3mNfuGVmC0vY5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=p6VZcSltqgag4N/upXoDYem0Cy3dSn6qK+dHCpl7jcD8M9R+S6mO7mMngrKvgV8KFVkYgHjNXxYyyrqpxSkXq0Jpq4q020Td9uPuKsqGIZDbosM4NRYRtulGEGxaNTD+UghuzX/fDc9hloqQPobr1egiHNb3bLMkPEGl6qyrh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc6+XY8s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc6+XY8s"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41485fe355bso4547625e9.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711318746; x=1711923546; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75/8iULr/DRxQooUD8kC6xKdPlg68sjU5vMp4oHaDU0=;
        b=Sc6+XY8sV6sCjejAIUBvcViPtApmnKmy+uHPp9i5X8QIykv3AzD5IhShrgiMhpGLeh
         otH52f6dBh8azuHGfY5whi718i5ptSJTDyprhtjwBA/rQPQa0lcDkn8RRhFqhMa53PG+
         GA+Ybgt3RGGGGB+rCOWuZlDQvUzf8FBNwaBRLQWhUKf59eIgS4vWVr2kxzF0T60KJZtP
         1r4+ucXr+FxtwK1kcQAznKONSJ1plN6ovWrqQ7cdIQaS5q6jo1735Y4M+Fxu+WDA80LL
         fon34DPy2S/1B6rYFcK4dxQ2O7AQ/XqbfNIVhWfV7nWfUCOGLZEGuOsLb9wUBHa4z6uk
         BLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711318746; x=1711923546;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75/8iULr/DRxQooUD8kC6xKdPlg68sjU5vMp4oHaDU0=;
        b=VFQ/FS4+DVIOiGPWGsEl+uvyFJldgp4hsCEIww5iRpByB9xRtrS0x4z35MMbTw8Ojn
         ahS7KBnDIOh1NsQSFo4Y+Pn8TK9sJoAJadA65AUxueiwrzQ7JuTIR442qsJkh9jrIfWg
         GtApEbombFris51ZhuY4/y9BTA89eDtkW97CQ5PxQLIdPm1pl+5VopSlWj33VU1DznaZ
         X9Zf3bR6JJrM9HnBz8qyol9NLzI9hp6yrEgemForaXoN8/e/WmYnxNVFJp8Mo/wbCDhb
         /2YsdJE30m6IueslfhQ7eEhVsIc3vB8A6H9FGKrjUeu5VMvCNWUc/MmCKgJKubyjgoou
         OMSA==
X-Gm-Message-State: AOJu0Yy4ewlb36Rn/0inlZ+RayCLCT2gzknc2L33HU3RX9MIu887cd2p
	Oa3iyq0+UjMEXZlaSEAj4lIFygK7xn4GRfMFFvMTX052qXJnZRzVFctCyyg4
X-Google-Smtp-Source: AGHT+IEqEzje8sfJOWmsU8112SNTWhDIIveL4j6u7IGuGc0azGftZI/GbLgiKVZkiVtx+KlXh04r0Q==
X-Received: by 2002:a05:600c:1d08:b0:413:3941:d9ae with SMTP id l8-20020a05600c1d0800b004133941d9aemr3432498wms.31.1711318746226;
        Sun, 24 Mar 2024 15:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004147b5dd6f8sm6392917wms.9.2024.03.24.15.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:19:04 -0700 (PDT)
Message-Id: <5ae83d3f799e9ab84d5233f77cb91715415ae167.1711318740.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 22:18:59 +0000
Subject: [PATCH 4/4] doc: git-clone: apply new documentation guidelines
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

Heavily apply literal and placeholder markup everywhere.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/clone.txt |  23 +++++--
 Documentation/git-clone.txt    | 120 ++++++++++++++++-----------------
 Documentation/urls.txt         |  22 +++---
 3 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index d037b57f729..0e0a8a1ae4a 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -1,13 +1,22 @@
-clone.defaultRemoteName::
+`clone.defaultRemoteName`::
 	The name of the remote to create when cloning a repository.  Defaults to
-	`origin`, and can be overridden by passing the `--origin` command-line
+	`origin`.
+ifdef::git-clone[]
+	It can be overridden by passing the `--origin` command-line
+	option.
+endif::[]
+ifndef::git-clone[]
+	It can be overridden by passing the `--origin` command-line
 	option to linkgit:git-clone[1].
+endif::[]
+`clone.rejectShallow`::
+	Reject cloning a repository if it is a shallow one. This can be overridden by
+	passing the `--reject-shallow` option on the command line.
+ifndef::git-clone[]
+	See linkgit:git-clone[1]
+endif::[]
 
-clone.rejectShallow::
-	Reject cloning a repository if it is a shallow one; this can be overridden by
-	passing the `--reject-shallow` option on the command line. See linkgit:git-clone[1]
-
-clone.filterSubmodules::
+`clone.filterSubmodules`::
 	If a partial clone filter is provided (see `--filter` in
 	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
 	the filter to submodules.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f90977a8519..134b5278ca1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,15 +9,15 @@ git-clone - Clone a repository into a new directory
 SYNOPSIS
 --------
 [verse]
-'git clone' [--template=<template-directory>]
-	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
-	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--dissociate] [--separate-git-dir <git-dir>]
-	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
-	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
-	  [<directory>]
+`git clone` [`--template=`{empty}__<template-directory>__]
+	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
+	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
+	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
+	  [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
+	  [`--recurse-submodules`[`=`{empty}__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
+	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]`reject-shallow`]
+	  [`--filter=`{empty}__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
+	  [_<directory>_]
 
 DESCRIPTION
 -----------
@@ -31,7 +31,7 @@ currently active branch.
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
 arguments will in addition merge the remote master branch into the
-current master branch, if any (this is untrue when "--single-branch"
+current master branch, if any (this is untrue when `--single-branch`
 is given; see below).
 
 This default configuration is achieved by creating references to
@@ -42,12 +42,12 @@ configuration variables.
 
 OPTIONS
 -------
--l::
---local::
+`-l`::
+`--local`::
 	When the repository to clone from is on a local machine,
 	this flag bypasses the normal "Git aware" transport
 	mechanism and clones the repository by making a copy of
-	HEAD and everything under objects and refs directories.
+	`HEAD` and everything under objects and refs directories.
 	The files under `.git/objects/` directory are hardlinked
 	to save space when possible.
 +
@@ -67,14 +67,14 @@ links.
 source repository, similar to running `cp -r src dst` while modifying
 `src`.
 
---no-hardlinks::
+`--no-hardlinks`::
 	Force the cloning process from a repository on a local
 	filesystem to copy the files under the `.git/objects`
 	directory instead of using hardlinks. This may be desirable
 	if you are trying to make a back-up of your repository.
 
--s::
---shared::
+`-s`::
+`--shared`::
 	When the repository to clone is on the local machine,
 	instead of using hard links, automatically setup
 	`.git/objects/info/alternates` to share the objects
@@ -101,7 +101,7 @@ If you want to break the dependency of a repository cloned with `--shared` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
---reference[-if-able] <repository>::
+`--reference`[`-if-able`] _<repository>_::
 	If the reference _<repository>_ is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference _<repository>_.  Using
@@ -115,7 +115,7 @@ objects from the source repository into a pack in the cloned repository.
 *NOTE*: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
 
---dissociate::
+`--dissociate`::
 	Borrow the objects from reference repositories specified
 	with the `--reference` options only to reduce network
 	transfer, and stop borrowing from them after a clone is made
@@ -126,43 +126,43 @@ objects from the source repository into a pack in the cloned repository.
 	same repository, and this option can be used to stop the
 	borrowing.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Operate quietly.  Progress is not reported to the standard
 	error stream.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Run verbosely. Does not affect the reporting of progress status
 	to the standard error stream.
 
---progress::
+`--progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
---server-option=<option>::
+`--server-option=`{empty}__<option>__::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
 	character.  The server's handling of server options, including
 	unknown ones, is server-specific.
-	When multiple `--server-option=<option>` are given, they are all
+	When multiple `--server-option=`{empty}__<option>__ are given, they are all
 	sent to the other side in the order listed on the command line.
 
--n::
---no-checkout::
+`-n`::
+`--no-checkout`::
 	No checkout of HEAD is performed after the clone is complete.
 
---[no-]reject-shallow::
+`--`[`no-`]`reject-shallow`::
 	Fail if the source repository is a shallow repository.
 	The `clone.rejectShallow` configuration variable can be used to
 	specify the default.
 
---bare::
+`--bare`::
 	Make a 'bare' Git repository.  That is, instead of
 	creating _<directory>_ and placing the administrative
-	files in `<directory>/.git`, make the _<directory>_
+	files in _<directory>_`/.git`, make the _<directory>_
 	itself the `$GIT_DIR`. This obviously implies the `--no-checkout`
 	because there is nowhere to check out the working tree.
 	Also the branch heads at the remote are copied directly
@@ -171,28 +171,28 @@ objects from the source repository into a pack in the cloned repository.
 	used, neither remote-tracking branches nor the related
 	configuration variables are created.
 
---sparse::
+`--sparse`::
 	Employ a sparse-checkout, with only files in the toplevel
 	directory initially being present.  The
 	linkgit:git-sparse-checkout[1] command can be used to grow the
 	working directory as needed.
 
---filter=<filter-spec>::
+`--filter=`{empty}__<filter-spec>__::
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied _<filter-spec>_ is used for
 	the partial clone filter. For example, `--filter=blob:none` will
 	filter out all blobs (file contents) until needed by Git. Also,
-	`--filter=blob:limit=<size>` will filter out all blobs of size
+	`--filter=blob:limit=`{empty}__<size>__ will filter out all blobs of size
 	at least _<size>_. For more details on filter specifications, see
 	the `--filter` option in linkgit:git-rev-list[1].
 
---also-filter-submodules::
+`--also-filter-submodules`::
 	Also apply the partial clone filter to any submodules in the repository.
 	Requires `--filter` and `--recurse-submodules`. This can be turned on by
 	default by setting the `clone.filterSubmodules` config option.
 
---mirror::
+`--mirror`::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
 	source to local branches of the target, it maps all refs (including
@@ -200,14 +200,14 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
--o <name>::
---origin <name>::
+`-o` _<name>_::
+`--origin` _<name>_::
 	Instead of using the remote name `origin` to keep track of the upstream
 	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from the
 	config.
 
--b <name>::
---branch <name>::
+`-b` _<name>_::
+`--branch` _<name>_::
 	Instead of pointing the newly created HEAD to the branch pointed
 	to by the cloned repository's HEAD, point to _<name>_ branch
 	instead. In a non-bare repository, this is the branch that will
@@ -215,18 +215,18 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.
 
--u <upload-pack>::
---upload-pack <upload-pack>::
+`-u` _<upload-pack>_::
+`--upload-pack` _<upload-pack>_::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
 
---template=<template-directory>::
+`--template=`{empty}__<template-directory>__::
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
--c <key>=<value>::
---config <key>=<value>::
+`-c` __<key>__{empty}`=`{empty}__<value>__::
+`--config` __<key>__{empty}`=`{empty}__<value>__::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -239,25 +239,25 @@ objects from the source repository into a pack in the cloned repository.
 Due to limitations of the current implementation, some configuration
 variables do not take effect until after the initial fetch and checkout.
 Configuration variables known to not take effect are:
-`remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
+`remote.`{empty}__<name>__{empty}`.mirror` and `remote.`{empty}__<name>__{empty}`.tagOpt`.  Use the
 corresponding `--mirror` and `--no-tags` options instead.
 
---depth <depth>::
+`--depth` _<depth>_::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of commits. Implies `--single-branch` unless
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches. If you want to clone submodules shallowly,
 	also pass `--shallow-submodules`.
 
---shallow-since=<date>::
+`--shallow-since=`{empty}__<date>__::
 	Create a shallow clone with a history after the specified time.
 
---shallow-exclude=<revision>::
+`--shallow-exclude=`{empty}__<revision>__::
 	Create a shallow clone with a history, excluding commits
 	reachable from a specified remote branch or tag.  This option
 	can be specified multiple times.
 
---[no-]single-branch::
+`--`[`no-`]`single-branch`::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
 	branch remote's `HEAD` points at.
@@ -267,7 +267,7 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
---no-tags::
+`--no-tags`::
 	Don't clone any tags, and set
 	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
 	that future `git pull` and `git fetch` operations won't follow
@@ -279,7 +279,7 @@ maintain a branch with no references other than a single cloned
 branch. This is useful e.g. to maintain minimal clones of the default
 branch of some repository for search indexing.
 
---recurse-submodules[=<pathspec>]::
+`--recurse-submodules`[`=`{empty}__<pathspec>__]::
 	After the clone is created, initialize and clone submodules
 	within based on the provided _<pathspec>_.  If no _=<pathspec>_ is
 	provided, all submodules are initialized and cloned.
@@ -295,46 +295,46 @@ the clone is finished. This option is ignored if the cloned repository does
 not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
 or `--mirror` is given)
 
---[no-]shallow-submodules::
+`--`[`no-`]`shallow-submodules`::
 	All submodules which are cloned will be shallow with a depth of 1.
 
---[no-]remote-submodules::
+`--`[`no-`]`remote-submodules`::
 	All submodules which are cloned will use the status of the submodule's
 	remote-tracking branch to update the submodule, rather than the
 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
 	`git submodule update`.
 
---separate-git-dir=<git-dir>::
+`--separate-git-dir=`{empty}__<git-dir>__::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
 	then make a filesystem-agnostic Git symbolic link to there.
 	The result is Git repository can be separated from working
 	tree.
 
---ref-format=<ref-format>::
+`--ref-format=`{empty}__<ref-format>__::
 
 Specify the given ref storage format for the repository. The valid values are:
 +
 include::ref-storage-format.txt[]
 
--j <n>::
---jobs <n>::
+`-j` _<n>_::
+`--jobs` _<n>_::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
-<repository>::
+_<repository>_::
 	The (possibly remote) _<repository>_ to clone from.  See the
 	<<URLS,GIT URLS>> section below for more information on specifying
 	repositories.
 
-<directory>::
+_<directory>_::
 	The name of a new directory to clone into.  The "humanish"
 	part of the source repository is used if no _<directory>_ is
 	explicitly given (`repo` for `/path/to/repo.git` and `foo`
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
---bundle-uri=<uri>::
+`--bundle-uri=`{empty}__<uri>__::
 	Before fetching from the remote, fetch a bundle from the given
 	_<uri>_ and unbundle the data into the local repository. The refs
 	in the bundle will be stored under the hidden `refs/bundle/*`
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 0b9e0c4302d..f1a0c275ee1 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -57,11 +57,11 @@ endif::git-clone[]
 accept a suitable bundle file. See linkgit:git-bundle[1].
 
 When Git doesn't know how to handle a certain transport protocol, it
-attempts to use the `remote-<transport>` remote helper, if one
+attempts to use the `remote-`{empty}__<transport>__ remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
 may be used:
 
-- _<transport>_::_<address>_
+- _<transport>_::__<address>__
 
 where _<address>_ may be a path, a server and path, or an arbitrary
 URL-like string recognized by the specific remote helper being
@@ -72,10 +72,11 @@ you want to use a different format for them (such that the URLs you
 use will be rewritten into URLs that work), you can create a
 configuration section of the form:
 
-------------
-	[url "<actual-url-base>"]
-		insteadOf = <other-url-base>
-------------
+[verse]
+--
+	[url "__<actual-url-base>__"]
+		insteadOf = _<other-url-base>_
+--
 
 For example, with this:
 
@@ -91,10 +92,11 @@ rewritten in any context that takes a URL to be "git://git.host.xz/repo.git".
 If you want to rewrite URLs for push only, you can create a
 configuration section of the form:
 
-------------
-	[url "<actual-url-base>"]
-		pushInsteadOf = <other-url-base>
-------------
+[verse]
+--
+	[url "__<actual-url-base>__"]
+		pushInsteadOf = _<other-url-base>_
+--
 
 For example, with this:
 
-- 
gitgitgadget
