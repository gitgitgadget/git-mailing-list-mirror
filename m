Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92648336EFE
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351154; cv=none; b=JNgTKIfnY5Sp1nV67XBvOSN1yOrRiddTqR8/aULiKUCfn0oDp7cd1bWBVavil2xYB8dFYKpvhnShdSgt29U6HW6WlEco7JG4Erw1ghox5HQ+LwwlXSbrTQFZFxA1SFfVbDPvi6Kb/oiv7ssI+rla/KkYbUjvBJ+pezP1wqnt1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351154; c=relaxed/simple;
	bh=VsFAtbj89NPgpTPyc8BykHNhzMnH2frjdx6zMZxEjl4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NxC4Jzm0ehMy+LJsnEYsxLzGQ8lcc4nsQ9J3BwSw25vUZtYNQPYgDdQUcH7VNVCFzYWdRRIxpDdwetepMnGvPwPjJTnDk2qAe7bJVNxVEq3vR41ALgULG7Nvy+5Yt8hRLidDOrSB1F3h+hH+hdwfPSh3cG1lVBkhNtPnBwN+C5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H12TBN+b; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H12TBN+b"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b71515d8adso1531264eec.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 20:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770351153; x=1770955953; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXb6jtWtsvwj0aJTTFsuSlLG5Vf/fdWvqhNiQp2xIxE=;
        b=H12TBN+bYYYKnj2uYHZCHUUwpdkaWsEYFA8fCz01loKH+i+rR+0kSEJl3EaMfh9o47
         +HOK6brRinaE5Ok4YqFigwK/RVqlifBrTzmCSU/J7JFvVPcqtWhuiUdHpp1yFCBzvOYZ
         QNUbuYRy+du0h3Y7waaEKbh3q3pXbx8Ik8dV1HFf7aapcmgUz8yAvDFtSSSS/qahSed7
         ydVE83t57/hEjBnMW38rSJpr8VWlGa+Z3VqzJGyngqJTsevXRwIsgtIyLdp1Jxwcfggi
         +6UTwZkv6p2MM92MgSUVmX4XhBMlpcyj+sy2cuzmjCdIfVvjvZboFBSaQFnDR1SgDN5v
         pKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351153; x=1770955953;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXb6jtWtsvwj0aJTTFsuSlLG5Vf/fdWvqhNiQp2xIxE=;
        b=HqSVihsmIwfGGNDXOn8PTW8U01bY/9GhRUSZmiZA9ooAF1seulx8Jajx5bt0HVL4oz
         OPTpIRdDmbiX+FayQ9dz485XCgXVG3mWYZNUd1uNsUywrOxruMkiwjrP0/2rBoW2V17F
         SPHQkzcxNCoXwu3mTYDAhtLlspXHokGsEa4i9UXcOJIahKZ3U4cxNwwysBwrPFeUvQGl
         butlFg/k33k1GtFEU1wk3+mG157vC4nT1osDjaO3YVjK2ZFShdFyTPBw/pAL2xNTkt0P
         DNWFICCgHjPRnZXxSxxSwaiqUkIUPsYFyOnCG3mNSZhJsOE1y4DVYqGbZNlmuv3VdQY2
         ePkA==
X-Gm-Message-State: AOJu0YwwTQ7cU7VFVdmAiCZOqP/4swBQ9AfwiMplTDahiajkwidpb+k/
	nSz3BgbeC1HvF8qnS8are5E9YulKJBF0hqoWC990FtNBfCgwchNqdgKnHJqC0Q==
X-Gm-Gg: AZuq6aJsXr/vJEm93NCoX2MDyqqmE6L/j8yJgsT2Zx6O8fLZ7sDAooYUca6XRjjKRZ5
	iQQNXLbuRrOkVnmAr+YIc4ebnrdb3z6JyC50iEXsOXyHzGZroqvhlcRobdUbAr6YdylyBQ23FaT
	pdDgCn9CKI4pxEMWcy04YBKr3OrtImJJAfdEpBjW3xC/fhJKcG4ju8H+g3u3vSG/ngOvs4azZTD
	RDtnLwLd4gebWdsfXLy1kPz0GDJsqJGXwbD9cACF6KFzzdai55Mq+ywb5j2u7YmSsiVjBQRXHAw
	LYR6nyRjew0meIzC32c0m0P5dVL+v8PSn6IExmHg8whIqSrNPRmLXojxI7/y5DsP5MoYFmuySva
	i6HXQXpZvvs5XMPX6IC8aIzYXq7JUpyDSA2bfhMCBoGEwO/MIyeC/uEAAy92S6Bfw9Xd8St75Dm
	dtB+pEBaESXUL9qhPdJ25dXA==
X-Received: by 2002:a05:7300:cb1a:b0:2ab:ca55:89b1 with SMTP id 5a478bee46e88-2b856a5b2f7mr511310eec.40.1770351153221;
        Thu, 05 Feb 2026 20:12:33 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af7806sm1004727eec.10.2026.02.05.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 20:12:32 -0800 (PST)
Message-Id: <fe928fe0edbe933a0984300334c324f8a80e3df5.1770351146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
References: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
	<pull.2036.v4.git.1770351146.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 04:12:25 +0000
Subject: [PATCH v4 3/4] doc: fix some style issues in git-clone and
 for-each-ref-options
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

 * spell out all forms of --[no-]reject-shallow in git-clone
 * use imperative mood for the first line of options
 * Use asciidoc NOTE macro
 * fix markups

Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/for-each-ref-options.adoc |  4 +-
 Documentation/git-clone.adoc            | 52 ++++++++++++-------------
 Documentation/ref-storage-format.adoc   |  4 +-
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
index f13efb5f25..54e2fa95c2 100644
--- a/Documentation/for-each-ref-options.adoc
+++ b/Documentation/for-each-ref-options.adoc
@@ -30,8 +30,8 @@ TAB %(refname)`.
 
 `--color[=<when>]`::
 	Respect any colors specified in the `--format` option. The
-	_<when__ field must be one of `always`, `never`, or `auto` (if
-	`<when>` is absent, behave as if `always` was given).
+	_<when>_ field must be one of `always`, `never`, or `auto` (if
+	_<when>_ is absent, behave as if `always` was given).
 
 `--shell`::
 `--perl`::
diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 7a0e147384..959ca40733 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -84,7 +84,7 @@ _<src>_.
 	with the source repository.  The resulting repository
 	starts out without any object of its own.
 +
-*NOTE*: this is a possibly dangerous operation; do *not* use
+NOTE: this is a possibly dangerous operation; do *not* use
 it unless you understand what it does. If you clone your
 repository using this option and then delete branches (or use any
 other Git command that makes any existing commit unreferenced) in the
@@ -104,7 +104,8 @@ If you want to break the dependency of a repository cloned with `--shared` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
-`--reference[-if-able] <repository>`::
+`--reference=<repository>`::
+`--reference-if-able=<repository>`::
 	If the reference _<repository>_ is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference _<repository>_.  Using
@@ -115,7 +116,7 @@ objects from the source repository into a pack in the cloned repository.
 	directory is skipped with a warning instead of aborting
 	the clone.
 +
-*NOTE*: see the NOTE for the `--shared` option, and also the
+NOTE: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
 
 `--dissociate`::
@@ -140,14 +141,14 @@ objects from the source repository into a pack in the cloned repository.
 	to the standard error stream.
 
 `--progress`::
-	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless `--quiet`
+	Report progress status on the standard error stream
+	by default when attached to a terminal, unless `--quiet`
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
 `--server-option=<option>`::
 	Transmit the given string to the server when communicating using
-	protocol version 2.  The given string must not contain a NUL or LF
+	protocol version 2.  The given string must not contain a _NUL_ or _LF_
 	character.  The server's handling of server options, including
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
@@ -158,9 +159,10 @@ objects from the source repository into a pack in the cloned repository.
 
 `-n`::
 `--no-checkout`::
-	No checkout of `HEAD` is performed after the clone is complete.
+	Do not checkout `HEAD` after the clone is complete.
 
-`--`[`no-`]`reject-shallow`::
+`--no-reject-shallow`::
+`--reject-shallow`::
 	Fail if the source repository is a shallow repository.
 	The `clone.rejectShallow` configuration variable can be used to
 	specify the default.
@@ -206,18 +208,17 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
-`-o <name>`::
-`--origin <name>`::
+`-o<name>`::
+`--origin=<name>`::
 	Instead of using the remote name `origin` to keep track of the upstream
 	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from the
 	config.
 
-`-b <name>`::
-`--branch <name>`::
-	Instead of pointing the newly created `HEAD` to the branch pointed
-	to by the cloned repository's `HEAD`, point to _<name>_ branch
-	instead. In a non-bare repository, this is the branch that will
-	be checked out.
+`-b<name>`::
+`--branch=<name>`::
+	Point the newly created `HEAD` to _<name>_ branch instead of the branch
+	pointed to by the cloned repository's `HEAD`. In a non-bare repository,
+	this is the branch that will be checked out.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
@@ -230,18 +231,17 @@ objects from the source repository into a pack in the cloned repository.
 	name.
 	This option is incompatible with `--branch` and `--mirror`.
 
-`-u <upload-pack>`::
-`--upload-pack <upload-pack>`::
-	When given, and the repository to clone from is accessed
-	via ssh, this specifies a non-default path for the command
-	run on the other end.
+`-u<upload-pack>`::
+`--upload-pack=<upload-pack>`::
+	Specify a non-default path for the command run on the other end when the
+	repository to clone from is accessed via ssh.
 
 `--template=<template-directory>`::
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
-`-c <key>=<value>`::
-`--config <key>=<value>`::
+`-c<key>=<value>`::
+`--config=<key>=<value>`::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -257,7 +257,7 @@ Configuration variables known to not take effect are:
 `remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
 corresponding `--mirror` and `--no-tags` options instead.
 
-`--depth <depth>`::
+`--depth=<depth>`::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of commits. Implies `--single-branch` unless
 	`--no-single-branch` is given to fetch the histories near the
@@ -339,8 +339,8 @@ Specify the given ref storage format for the repository. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
-`-j <n>`::
-`--jobs <n>`::
+`-j<n>`::
+`--jobs=<n>`::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
diff --git a/Documentation/ref-storage-format.adoc b/Documentation/ref-storage-format.adoc
index 14fff8a9c6..6a8db4712b 100644
--- a/Documentation/ref-storage-format.adoc
+++ b/Documentation/ref-storage-format.adoc
@@ -1,3 +1,3 @@
-* `files` for loose files with packed-refs. This is the default.
-* `reftable` for the reftable format. This format is experimental and its
+`files`;; for loose files with packed-refs. This is the default.
+`reftable`;; for the reftable format. This format is experimental and its
   internals are subject to change.
-- 
gitgitgadget

