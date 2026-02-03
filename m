Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7633D4100
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138231; cv=none; b=LQYbG6m6l+SaTbc0Pyno83Ahe0qkQgvkMT+cjvRij6+xJcYQPcHpgy60R2Q6oJxso+qgkdsH+H7naPeqgjUUZfxfOynSCna7lOujfDYR2dYG9hIW3kgEVV/BwvRjB6wFZzxp2HegwIMgBNRxBflSxrBsA8dVH4QC+oiwkhTnynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138231; c=relaxed/simple;
	bh=sGBZol8zCoTMPYMrI6Fm0nYcV03dj3lQ/AF9+aSKl1g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=kNt/DJOTzdnyibnjhXh6PeG/AVnHb9wdgTfzJo6/TInR1ukB9SISKnmH+LWRgF9g+1bcOCCHncH+m8Cuhkttt+HxX8kTeiatVC4kJz9GR5NxHQugnyvcTFjKwN4bLUVrUrZq9WS2+9qEq7uP8PJiu/2sc/IWhVmopx234obSflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygy1VU7j; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygy1VU7j"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b71557299dso5985707eec.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138225; x=1770743025; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJaF1xaJK8G9Mu9eDQd4W9pfvGZafh3w705HXTP9ZNg=;
        b=Ygy1VU7jU9enp9PjGIi7sD2kFxmzT4PTYBJNZMc4wvZBhLe9qQlpGs3SFzNXoDC3Pa
         az/SB2BjJHESvW+7KhoKhWMoHhAhMDN63L49FPoxTXtDI8tb8TPM1DefwEc8MWajFB6N
         G2INmA1zSCNKrxURsA4ju0ztcezcmgdWfCi/uypuC3TK7MFHnFD5SjQGSUkV+D0oEJNG
         VaEwkupUp+DabKtnccWULavHYqsOIqr/LqD8apAcr1ECVjJavrotYUj4FmaFJQkx2F5K
         U2oeYsSNGemt/Xe4CwGzozcez09oV3CwP3/+r/CFdfW/9K58ivk/YL/q4sZG42YtYu2p
         rKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138225; x=1770743025;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJaF1xaJK8G9Mu9eDQd4W9pfvGZafh3w705HXTP9ZNg=;
        b=GmMWWR3YcgkAKtB/Sj40Ou4+p20XdGoh9A03YCX/blnQJ1cNV04V4jAVTaenqXVv5Z
         Ql3bVFtXUsAo6NvmOmeYQ5yD1eNAPfUGPEQTPmRzok2cOmwHdXaBw7i+LLWXPO/7EvdK
         JDpx6T8QBrxjCGhDU4u1HMnOvgJInsF1M52hWgEnoQ/dOEZ8IEeXUHfKVpm5OFEWfbV1
         11B96mqxVgszatzVEmORbHYVb9p168i39Fufa1WWEs+BAmIUee0rZIkcBhw8qU+zwTgM
         kccysTBB/EobA7BzsXO+GisDYbrTmpKNKjErejd+Dbvc9Wrn5Yo/8YBnXUTuv65QEoQy
         ko+Q==
X-Gm-Message-State: AOJu0YyFiT4NkZQGtN+H7R+VD97T3E0I+MP09COunpL8FQNSlKAFiJBD
	TEZRN1bdPUO5XPe3Qz1Ac/ZilBaPKkNEr9QsjkzpXgtXKCuMCfYQlmW5pjAPITJ+
X-Gm-Gg: AZuq6aLaAt08Vshjmo1jjWGf7hrE5UsU4FSR23jYTEmQMYP/aflF3vPpmDlqd3jwVQV
	W4yaW6FLiSU5zAPtDnM2x4IB8mvdtyP0cBFv295KuuScXbyt341aMyAfizH8KLdNZtNv1nnWsMj
	Q2Fgjl8KCyoCmRELNG/DJMXVEdOUc7CsLDylYSTduF2Wdcjff05k31SGRlLJAx7pMJIaxLhgbIy
	9VgM+ENIVBHrDMkm/5JsXqLNimduaiP/tCMK82zLAVDuFnjkkE78DlESMdzX2TQdLW4P2h4mtwy
	u9Z5mZ43WBdeFRyfNf8Z2DT9FLBPGySaOd9rNY5e5gujIy2z5qa7fHvCXYno53JzXLWz5/TxqdT
	M8gJuYAxEVPbpMPcf6Q6XGrFncQYay0yHOtoeWy83excytp/zeEfPBhKZ7DqzGpXy2FQLMIt5qM
	6Ydlv/lK8U3BtN
X-Received: by 2002:a05:7300:a499:b0:2b8:273c:9cea with SMTP id 5a478bee46e88-2b8328bc075mr95628eec.18.1770138223409;
        Tue, 03 Feb 2026 09:03:43 -0800 (PST)
Received: from [127.0.0.1] ([20.169.75.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e4d0b4sm44165eec.9.2026.02.03.09.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:03:42 -0800 (PST)
Message-Id: <d0970653031fa82b6096506520fcfdd80c8b22d1.1770138215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
	<pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 17:03:34 +0000
Subject: [PATCH v3 3/4] doc: fix some style issues in git-clone and
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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

