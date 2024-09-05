Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658121B1505
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573135; cv=none; b=Iq+E2E2TZ8GqsRoGYK9FCYqg7YuZpIEKiyzcTogA9Mq1HZA05mtz9AW1zXM7r/l5hzwfDkw4xAhYsLjgPzzdjTnT7Rmm8GScqMDsF3/LOBuumyfVNea/RC9E3hntZ/gmLCiMi5rWrCjaAzD3POuQeWPvH1fGGkrI6RUL7EFJYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573135; c=relaxed/simple;
	bh=Eaqgis0uSVGgXcr2Jmt79yrqrhPXTWxp+V+pT+l53MY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=BxgSDhh2tQfiPUGVN5pE/ka/R71ErO6YCXFzX+SZinrhUWwa7fVKVfdLqUTHODmGjtO6bT+SRFc2G4vqpfUA0P6049iIE9cunJ83OWc14XAJTQO/P/pWvtX9eugniK5c3s0OPMALw1C3ZDP6o4yNcd8/Zu7XUZbkR3cugEARSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDqABsQ4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDqABsQ4"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f50ca18a13so15933931fa.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725573131; x=1726177931; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qrMXREWBZ2YGOF2rrmabikA8Un0b7umLT0leYeINvA=;
        b=JDqABsQ4Y5sMkSGzIIxi4lRI6ZfnK1ODpLiEzFIXSgJjplqS6jWGYFvhwIqzfbUmXD
         FkKEr5KTlAOP4G8xn+AIsFcSVMv4scmrNI4PCK8hFdZlwDLuUMWw1LDu8h/BBOSyImY3
         9mw82cJOJz21h/8OCYgVcnYBzqmaYUTZ3ZMv7mDuu5Vcbi2hJmomRjfK0fT2ceBWbxys
         8EF21Vf9kj/bpbyve0aZN3ue8h2G26t7uWGtfptLum7Ebr7+wnGJWC1mILla3YoSWVi7
         rBQ/XBXIJMbpBUxnsEmG0Oq741JTSfxicZ4vs2lU7VqeM7KmMzz7WD3ahABY2rAl/YeA
         GRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573131; x=1726177931;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qrMXREWBZ2YGOF2rrmabikA8Un0b7umLT0leYeINvA=;
        b=hREbHjO03y6MMO+XgALZSG5JO6ZWDXO6xT8NWKwsR0LipWdpvD7ohWtHU5nWAvWpZ8
         JfO8zu56icNwnXQxjKyE2sxltUlSJACBbwA0PyzFU1AUaExtZkkM8TQc1YbYHbq81M9b
         jWEayuHgRiANgVsvjOmNvdriWgqR2ZS96NYzi1DjcTn90jniDmkFB70fF8lG0IAnOTW0
         P93RR0keIOChRfqPTpvgmpegWmUqDoehCZsTLDAp0BNdBpNtsnHYRBrTLS2Rna4YN4P4
         XHzfj9Whx1H+RKkXIM2xEE7VORVoN7t7kWwpnch4fM9C7pbCumVNtxGDYHnJ3R/U4Nq2
         jXdQ==
X-Gm-Message-State: AOJu0YyU4mTdM8LRTZUK7BBFRMMxp1hRaugfxFJ7MyIlnueDc2AYQjwQ
	tbtZCEz/wHKIXaZJtcZk2xxQwEbRoKjzPkkIyUAkYdOVTCJKdHxI0Yk5rw==
X-Google-Smtp-Source: AGHT+IF5NiTF9Q8gKu090uKvFQF39InD0psbxJ5WRB5uqbxMG7yYqFdM3mZeg02sx/7rwQL+ykk5Qw==
X-Received: by 2002:a05:651c:b13:b0:2f1:6cb1:44c0 with SMTP id 38308e7fff4ca-2f61038c633mr195528401fa.6.1725573130398;
        Thu, 05 Sep 2024 14:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56d405sm1680401a12.50.2024.09.05.14.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:52:09 -0700 (PDT)
Message-Id: <719188da711f9e2f66dea706b3df28e4930fa060.1725573126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 21:52:06 +0000
Subject: [PATCH v4 3/3] doc: apply synopsis simplification on git-clone and
 git-init
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the new synopsis formatting backend, no special asciidoc markup
is needed.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 78 ++++++++++++++++++-------------------
 Documentation/git-init.txt  | 35 +++++++----------
 Documentation/urls.txt      | 26 ++++++-------
 3 files changed, 67 insertions(+), 72 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8e925db7e9c..9c13f847da3 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -8,16 +8,16 @@ git-clone - Clone a repository into a new directory
 
 SYNOPSIS
 --------
-[verse]
-`git clone` [++--template=++__<template-directory>__]
-	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
-	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
-	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
-	  [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`] [`--no-tags`]
-	  [++--recurse-submodules++[++=++__<pathspec>__]] [++--++[++no-++]{empty}++shallow-submodules++]
-	  [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]
-	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
-	  [_<directory>_]
+[synopsis]
+git clone [--template=<template-directory>]
+	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
+	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
+	  [--dissociate] [--separate-git-dir <git-dir>]
+	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
+	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
+	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
+	  [<directory>]
 
 DESCRIPTION
 -----------
@@ -52,7 +52,7 @@ OPTIONS
 	to save space when possible.
 +
 If the repository is specified as a local path (e.g., `/path/to/repo`),
-this is the default, and --local is essentially a no-op.  If the
+this is the default, and `--local` is essentially a no-op.  If the
 repository is specified as a URL, then this flag is ignored (and we
 never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
@@ -64,8 +64,8 @@ prevent the unintentional copying of files by dereferencing the symbolic
 links.
 +
 *NOTE*: this operation can race with concurrent modification to the
-source repository, similar to running `cp -r src dst` while modifying
-`src`.
+source repository, similar to running `cp -r <src> <dst>` while modifying
+_<src>_.
 
 `--no-hardlinks`::
 	Force the cloning process from a repository on a local
@@ -101,7 +101,7 @@ If you want to break the dependency of a repository cloned with `--shared` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
-`--reference`[`-if-able`] _<repository>_::
+`--reference[-if-able] <repository>`::
 	If the reference _<repository>_ is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference _<repository>_.  Using
@@ -142,17 +142,17 @@ objects from the source repository into a pack in the cloned repository.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
-++--server-option=++__<option>__::
+`--server-option=<option>`::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
 	character.  The server's handling of server options, including
 	unknown ones, is server-specific.
-	When multiple ++--server-option=++__<option>__ are given, they are all
+	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
 `-n`::
 `--no-checkout`::
-	No checkout of HEAD is performed after the clone is complete.
+	No checkout of `HEAD` is performed after the clone is complete.
 
 `--`[`no-`]`reject-shallow`::
 	Fail if the source repository is a shallow repository.
@@ -162,7 +162,7 @@ objects from the source repository into a pack in the cloned repository.
 `--bare`::
 	Make a 'bare' Git repository.  That is, instead of
 	creating _<directory>_ and placing the administrative
-	files in _<directory>_`/.git`, make the _<directory>_
+	files in `<directory>/.git`, make the _<directory>_
 	itself the `$GIT_DIR`. This obviously implies the `--no-checkout`
 	because there is nowhere to check out the working tree.
 	Also the branch heads at the remote are copied directly
@@ -177,13 +177,13 @@ objects from the source repository into a pack in the cloned repository.
 	linkgit:git-sparse-checkout[1] command can be used to grow the
 	working directory as needed.
 
-++--filter=++__<filter-spec>__::
+`--filter=<filter-spec>`::
 	Use the partial clone feature and request that the server sends
 	a subset of reachable objects according to a given object filter.
 	When using `--filter`, the supplied _<filter-spec>_ is used for
 	the partial clone filter. For example, `--filter=blob:none` will
 	filter out all blobs (file contents) until needed by Git. Also,
-	++--filter=blob:limit=++__<size>__ will filter out all blobs of size
+	`--filter=blob:limit=<size>` will filter out all blobs of size
 	at least _<size>_. For more details on filter specifications, see
 	the `--filter` option in linkgit:git-rev-list[1].
 
@@ -208,11 +208,11 @@ objects from the source repository into a pack in the cloned repository.
 
 `-b` _<name>_::
 `--branch` _<name>_::
-	Instead of pointing the newly created HEAD to the branch pointed
-	to by the cloned repository's HEAD, point to _<name>_ branch
+	Instead of pointing the newly created `HEAD` to the branch pointed
+	to by the cloned repository's `HEAD`, point to _<name>_ branch
 	instead. In a non-bare repository, this is the branch that will
 	be checked out.
-	`--branch` can also take tags and detaches the HEAD at that commit
+	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
 `-u` _<upload-pack>_::
@@ -221,12 +221,12 @@ objects from the source repository into a pack in the cloned repository.
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
 
-++--template=++__<template-directory>__::
+`--template=<template-directory>`::
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
-`-c` __<key>__++=++__<value>__::
-`--config` __<key>__++=++__<value>__::
+`-c` `<key>=<value>`::
+`--config` `<key>=<value>`::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -239,25 +239,25 @@ objects from the source repository into a pack in the cloned repository.
 Due to limitations of the current implementation, some configuration
 variables do not take effect until after the initial fetch and checkout.
 Configuration variables known to not take effect are:
-++remote.++__<name>__++.mirror++ and ++remote.++__<name>__++.tagOpt++.  Use the
+`remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
 corresponding `--mirror` and `--no-tags` options instead.
 
-`--depth` _<depth>_::
+`--depth <depth>`::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of commits. Implies `--single-branch` unless
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches. If you want to clone submodules shallowly,
 	also pass `--shallow-submodules`.
 
-++--shallow-since=++__<date>__::
+`--shallow-since=<date>`::
 	Create a shallow clone with a history after the specified time.
 
-++--shallow-exclude=++__<revision>__::
+`--shallow-exclude=<revision>`::
 	Create a shallow clone with a history, excluding commits
 	reachable from a specified remote branch or tag.  This option
 	can be specified multiple times.
 
-`--`[`no-`]`single-branch`::
+`--[no-]single-branch`::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
 	branch remote's `HEAD` points at.
@@ -279,13 +279,13 @@ maintain a branch with no references other than a single cloned
 branch. This is useful e.g. to maintain minimal clones of the default
 branch of some repository for search indexing.
 
-`--recurse-submodules`[`=`{empty}__<pathspec>__]::
+`--recurse-submodules[=<pathspec>]`::
 	After the clone is created, initialize and clone submodules
-	within based on the provided _<pathspec>_.  If no _=<pathspec>_ is
+	within based on the provided _<pathspec>_.  If no `=<pathspec>` is
 	provided, all submodules are initialized and cloned.
 	This option can be given multiple times for pathspecs consisting
 	of multiple entries.  The resulting clone has `submodule.active` set to
-	the provided pathspec, or "." (meaning all submodules) if no
+	the provided pathspec, or "`.`" (meaning all submodules) if no
 	pathspec is provided.
 +
 Submodules are initialized and cloned using their default settings. This is
@@ -295,23 +295,23 @@ the clone is finished. This option is ignored if the cloned repository does
 not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
 or `--mirror` is given)
 
-`--`[`no-`]`shallow-submodules`::
+`--[no-]shallow-submodules`::
 	All submodules which are cloned will be shallow with a depth of 1.
 
-`--`[`no-`]`remote-submodules`::
+`--[no-]remote-submodules`::
 	All submodules which are cloned will use the status of the submodule's
 	remote-tracking branch to update the submodule, rather than the
 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
 	`git submodule update`.
 
-`--separate-git-dir=`{empty}__<git-dir>__::
+`--separate-git-dir=<git-dir>`::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
 	then make a filesystem-agnostic Git symbolic link to there.
 	The result is Git repository can be separated from working
 	tree.
 
-`--ref-format=`{empty}__<ref-format>__::
+`--ref-format=<ref-format>`::
 
 Specify the given ref storage format for the repository. The valid values are:
 +
@@ -334,7 +334,7 @@ _<directory>_::
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
-`--bundle-uri=`{empty}__<uri>__::
+`--bundle-uri=<uri>`::
 	Before fetching from the remote, fetch a bundle from the given
 	_<uri>_ and unbundle the data into the local repository. The refs
 	in the bundle will be stored under the hidden `refs/bundle/*`
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index daff93bd164..315f7f7530c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,12 +8,12 @@ git-init - Create an empty Git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
-[verse]
-`git init` [`-q` | `--quiet`] [`--bare`] [++--template=++__<template-directory>__]
-	  [`--separate-git-dir` _<git-dir>_] [++--object-format=++__<format>__]
-	  [++--ref-format=++__<format>__]
-	  [`-b` _<branch-name>_ | ++--initial-branch=++__<branch-name>__]
-	  [++--shared++[++=++__<permissions>__]] [_<directory>_]
+[synopsis]
+git init [-q | --quiet] [--bare] [--template=<template-directory>]
+	 [--separate-git-dir <git-dir>] [--object-format=<format>]
+	 [--ref-format=<format>]
+	 [-b <branch-name> | --initial-branch=<branch-name>]
+	 [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
@@ -25,11 +25,11 @@ directory with subdirectories for `objects`, `refs/heads`,
 commits will be created (see the `--initial-branch` option below
 for its name).
 
-If the `$GIT_DIR` environment variable is set then it specifies a path
+If the `GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
 
 If the object storage directory is specified via the
-`$GIT_OBJECT_DIRECTORY` environment variable then the sha1 directories
+`GIT_OBJECT_DIRECTORY` environment variable then the sha1 directories
 are created underneath; otherwise, the default `$GIT_DIR/objects`
 directory is used.
 
@@ -51,26 +51,22 @@ Only print error and warning messages; all other output will be suppressed.
 Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
 current working directory.
 
-++--object-format=++__<format>__::
-
+`--object-format=<format>`::
 Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
 values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
 include::object-format-disclaimer.txt[]
 
-++--ref-format=++__<format>__::
-
+`--ref-format=<format>`::
 Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
 include::ref-storage-format.txt[]
 
-++--template=++__<template-directory>__::
-
+`--template=<template-directory>`::
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
-++--separate-git-dir=++__<git-dir>__::
-
+`--separate-git-dir=<git-dir>`::
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
 repository.  This file acts as a filesystem-agnostic Git symbolic link to the
@@ -78,15 +74,14 @@ repository.
 +
 If this is a reinitialization, the repository will be moved to the specified path.
 
-`-b` _<branch-name>_::
-++--initial-branch=++__<branch-name>__::
-
+`-b <branch-name>`::
+`--initial-branch=<branch-name>`::
 Use _<branch-name>_ for the initial branch in the newly created
 repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
-++--shared++[++=++(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
+`--shared[=(false|true|umask|group|all|world|everybody|<perm>)]`::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 7cec85aef17..9c871e716a1 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,19 +10,19 @@ Git supports ssh, git, http, and https protocols (in addition, ftp
 and ftps can be used for fetching, but this is inefficient and
 deprecated; do not use them).
 
-The native transport (i.e. git:// URL) does no authentication and
+The native transport (i.e. `git://` URL) does no authentication and
 should be used with caution on unsecured networks.
 
 The following syntaxes may be used with them:
 
-- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
-- ++git://++__<host>__{startsb}:__<port>__{endsb}++/++__<path-to-git-repo>__
-- ++http++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
-- ++ftp++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
+- `ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>`
+- `git://<host>[:<port>]/<path-to-git-repo>`
+- `http[s]://<host>[:<port>]/<path-to-git-repo>`
+- `ftp[s]://<host>[:<port>]/<path-to-git-repo>`
 
 An alternative scp-like syntax may also be used with the ssh protocol:
 
-- {startsb}__<user>__++@++{endsb}__<host>__++:/++__<path-to-git-repo>__
+- `[<user>@]<host>:/<path-to-git-repo>`
 
 This syntax is only recognized if there are no slashes before the
 first colon. This helps differentiate a local path that contains a
@@ -30,17 +30,17 @@ colon. For example the local path `foo:bar` could be specified as an
 absolute path or `./foo:bar` to avoid being misinterpreted as an ssh
 url.
 
-The ssh and git protocols additionally support ++~++__<username>__ expansion:
+The ssh and git protocols additionally support `~<username>` expansion:
 
-- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
-- ++git://++__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
-- {startsb}__<user>__++@++{endsb}__<host>__++:~++__<user>__++/++__<path-to-git-repo>__
+- `ssh://[<user>@]<host>[:<port>]/~<user>/<path-to-git-repo>`
+- `git://<host>[:<port>]/~<user>/<path-to-git-repo>`
+- `[<user>@]<host>:~<user>/<path-to-git-repo>`
 
 For local repositories, also supported by Git natively, the following
 syntaxes may be used:
 
 - `/path/to/repo.git/`
-- ++file:///path/to/repo.git/++
+- `file:///path/to/repo.git/`
 
 ifndef::git-clone[]
 These two syntaxes are mostly equivalent, except when cloning, when
@@ -57,11 +57,11 @@ endif::git-clone[]
 accept a suitable bundle file. See linkgit:git-bundle[1].
 
 When Git doesn't know how to handle a certain transport protocol, it
-attempts to use the `remote-`{empty}__<transport>__ remote helper, if one
+attempts to use the `remote-<transport>` remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
 may be used:
 
-- _<transport>_::__<address>__
+- `<transport>::<address>`
 
 where _<address>_ may be a path, a server and path, or an arbitrary
 URL-like string recognized by the specific remote helper being
-- 
gitgitgadget
