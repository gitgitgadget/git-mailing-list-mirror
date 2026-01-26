Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C62E6CAB
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462754; cv=none; b=JkZ9QCqo7Bw0KrKoYAzq/vuzNPSA/AgFX+BtRA0/NEhauwhkNLFW3H4JjLDvtBB7JEMPyHEFgblQ+5J9fJOCjv4USpgce2DvlimD02Q0GBuX1MxaUK1OmYijZNgYG27f2K9+aQ4MF47vbUYaM+8TjvffqE1p1aGnEwvIxK82Sf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462754; c=relaxed/simple;
	bh=yxemB6izilbn2ESbJcmpoBCkmCDr3zuos8juxXp8T7M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XBCGyF0qRa+w/OOt4BXnOxEfiqDXsKrepmWKv6kqtYkwfy/gBDh6r0yLIK0DiSHX87klQj0oWdON7JNtjRvXm9y6JA8kFfWPSjqjFW26so/REMfaQ8v0dCtHq/zaFw9A93QrfeU5/DDP6SA0MfQK2qYXqS7IqdRBacXNagv3wLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP6zCJEv; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP6zCJEv"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b785801c93so919384eec.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 13:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769462752; x=1770067552; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osmEUWQ5UaHAxssc0rTNp1bUbWZOMDCXVcwe2+n8/oY=;
        b=fP6zCJEvrKMfIc/u3HE9u7oaUxTxd4ZR95L9/sRie9cNq6RYLFci3uOdiipFoa1F1v
         tRiZ/vCL55gtFHxQhbcREoaIoCSR5Orx69a9nYn/PoofQpdMlrio1IIK0d+DR2hCfqFE
         kaJV3xWlweXhDv+ZDtgHSHmaB/viwFCPX7SrzDJHXWBvE9i3colb4UGqKWGMEHh9lhyL
         49yhxY+lkkvWET78cvwK56Ma4d1gxUO0EflwhP1svKi/vp6BmG+TbUMj0tVtGs2A9VsJ
         19gQIYwcfs3Q5lRh1NNlbu0UcdgrMpKNWnzWXfNKyVgrBXdiOSVm7uOtZ1ZiG26RTqFg
         jH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769462752; x=1770067552;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osmEUWQ5UaHAxssc0rTNp1bUbWZOMDCXVcwe2+n8/oY=;
        b=vU0iCDr8B9K4NDQJU7D0CG1uvBJeNU/GMh8zLXQY9E8V8PaXeoxVNYQycQ6lqk1NzC
         egqhc3q8MurBgDo0+g1Q395VRHfG2DUxlnOsjWi9kJZKMotctnAjxsRYBfaS6QU3Hj4G
         fnbVehwYlt+6EW7cAXW+uwpddhSXPq9rSl3SL38vYEpOVWuK9Y7fe1mUtodiCiafHVKf
         rhugh+EbLzJxKbN2Vaj55lZMKzyYnsuTgxfp5O8vdMKdf2qACd0TgCQxgyudR8/ETmDV
         JGJrQu/G91tgvdR5hKU2IPXrB5Z+bB6/ueYrCv4ZPKiN95eSu7iOfdci4oe1EPpGuI8K
         mYtQ==
X-Gm-Message-State: AOJu0YytOQ7+37SNCjvx7QQMEGK04FUm9LHFSQHn9VQA1wf/pGBJePGw
	a2IWomnXJlql0jh2sXQf4YgvvQhMGzbkJ6nbNUkubsW5BurlPWcyAsE9Qpj/vw==
X-Gm-Gg: AZuq6aL3dmcFAb4RyLzpoRzeK0KvBMhCXUBsMzP6UALKTZKJGTUT64hH/Rnty/PzHI9
	ZGjrTrn2s0WbVrva52TiJrqlrY/ITIjd0xcxWMyV/nG5QRkM68boSIysoAvEcisZe/gSRUEy/43
	0Y9vyQARg7i8yH80O/xt9zuf/+q03R8pruWjWbPWdlDP56wXNE5/fpXngDc2gJ6gWiLnvnftKdh
	3/G9a9PBvq4u12XCtZZWx1ja0/QvtxGh2X1s2FRhihL5BRefbVR1YA7UyQPwv2sKbE6FSBh0Vmf
	fWzCMeubs7HNfBpSAwytOLN8FihcqjHIy8768fxgnr2BdwRvxB529VJckHSUbhVTQgp0Q5cYkbT
	yAIC8vZjQRbL9qBc0RT/k4ZuRUHnAS7xze30ZXbOLWmfdG5bRWxumJPm4kZ98+L4DLqyb+SSN+b
	pelZT5FMAzMZmi
X-Received: by 2002:a05:7300:ec16:b0:2b7:19f2:6b59 with SMTP id 5a478bee46e88-2b76432b8c5mr3618811eec.9.1769462751324;
        Mon, 26 Jan 2026 13:25:51 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6e9933sm16880658eec.13.2026.01.26.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:25:50 -0800 (PST)
Message-Id: <bcd6fcd1190fe21c667b5253a4a33b833e658609.1769462744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
	<pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Jan 2026 21:25:43 +0000
Subject: [PATCH v2 3/4] doc: fix some style issues in git-clone and
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
---
 Documentation/for-each-ref-options.adoc |  4 ++--
 Documentation/git-clone.adoc            | 30 ++++++++++++-------------
 2 files changed, 17 insertions(+), 17 deletions(-)

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
index 7a0e147384..fceeb43475 100644
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
+`--reference <repository>`::
+`--reference-if-able <repository>`::
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
@@ -214,10 +216,9 @@ objects from the source repository into a pack in the cloned repository.
 
 `-b <name>`::
 `--branch <name>`::
-	Instead of pointing the newly created `HEAD` to the branch pointed
-	to by the cloned repository's `HEAD`, point to _<name>_ branch
-	instead. In a non-bare repository, this is the branch that will
-	be checked out.
+	Point the newly created `HEAD` to _<name>_ branch instead of the branch
+	pointed to by the cloned repository's `HEAD`. In a non-bare repository,
+	this is the branch that will be checked out.
 	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
@@ -232,9 +233,8 @@ objects from the source repository into a pack in the cloned repository.
 
 `-u <upload-pack>`::
 `--upload-pack <upload-pack>`::
-	When given, and the repository to clone from is accessed
-	via ssh, this specifies a non-default path for the command
-	run on the other end.
+	Specify a non-default path for the command run on the other end when the
+	repository to clone from is accessed via ssh.
 
 `--template=<template-directory>`::
 	Specify the directory from which templates will be used;
-- 
gitgitgadget

