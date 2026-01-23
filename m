Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD372C2360
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202914; cv=none; b=WMQWRvmlb3P7Xco4rOj9pynmxT8ZKczxi4Li64RTOzvxlMac5F+RQModXxaHpm9nT2HdHucMprFAyJOjdHVhaOHnU+oJAk0fz/PZKTRRO23X8ziOVuRBJE1Apz7ULjo2jiO7mSwSI/47xDSEv5ZY9ix/mD3unkSQveuID6gvc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202914; c=relaxed/simple;
	bh=yxemB6izilbn2ESbJcmpoBCkmCDr3zuos8juxXp8T7M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=H6kqVv7s931CoZkgj/C/VNCfLs+Nm2QKNHr7OP8vgRMUMO+scVavEUXNn3ccvMgVTunxUwOTwlz6adtLBTI5aIo8tQHZBeDAjTkYJiTkSyLIlWv45nyY53cm7hxq73GgfNp2EqYBwOVdrb3qJiW/cFYiHNEhm9Ec48872ifpi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+KeL/Co; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+KeL/Co"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6ac42b91eso322454485a.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769202911; x=1769807711; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osmEUWQ5UaHAxssc0rTNp1bUbWZOMDCXVcwe2+n8/oY=;
        b=O+KeL/CoSKfwdB46soGseG0l2Mh+oLZqfQOMmlnyTALHHHATbnniouOlP7ZBrvNk64
         olmm224Hw/1QD+pK0OWDDjSXKntianlZbI3/KCxacNhfnkdk0Jh3gm71FVpq8V7FPg7b
         5/+pNBWZ/K2qcaZX6xFJHcLbQLG5l88TBh2fL6lvNj9TmZcE7IYaXhYftCpYDJMUmLdT
         tdF4ImgRMPorMInAHbatKvGlxxwlzjcj917NpREF2m1Jzh75f6Q1Lw6zQwm0v/idgFBR
         ajeNH6nNmn6VNX2Sf6acDwhpmZbwMJcnLFRGWCtA+Xs5kX+ZsC9/EUWYlBeZigYdbjdg
         3GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202911; x=1769807711;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=osmEUWQ5UaHAxssc0rTNp1bUbWZOMDCXVcwe2+n8/oY=;
        b=PW5jPVkgVGkjawowC/BtJLwokPNJQ5fvQc3yR4bb83avMRyGHjkxdLPoo7i6aWvp0j
         crEO1JznIg0Vj+fNBvTihqSA8LBUp51EPzj/GhwHHfh2q8XA2VGVDKXBHORANrT5hiV2
         S+70tn3cYFNSdv3L9S3Kw3qkVGWfVzJxPxQM55UL/5ASbXWzvGUuVPIAo7z5B7wxY0+c
         r+pTXyDMjQAVo8e8B1E/icBoOyydrB2VhWOPkweu8dXi9N4+5LTHt8tG/W4MCB+kolHG
         wVQPJW51KvrAs0FaHsPnUnhltYActUXvfqNKZ2e05qHdjwbmW+cM4PQk+MZmPCPfUfY0
         9uXQ==
X-Gm-Message-State: AOJu0YxvpOmBB6lLKVFWQiUQm9u8nIeix2uH0D4JG7dYXFN47eeFNbZn
	SFfoU2FZZkvPz1eGpNkugMN/BUTokE3oYrW1Ww4OhXFgsVFbjm8ROes/hkUOD+ct
X-Gm-Gg: AZuq6aKEWUMZ3O2Gm1en8Fs63q4ZRKkiikUNLR6fn3mCjRx9A3kccC/iITVNcPrPQnN
	xSpTfqigvi5mU9xuo+vt2AL4b/qqhvJ6U1krQIF/Hxqb81W5WSvGx86qnE2gAo7Nc2tdbs1i02g
	7/mJ3dpZVgZRSaohLc/iT6J1HvLMl3IQ4W4k3xguIvSoMzSDw7ke75tFD/NdgBcMt8gC+UR+obs
	R4xifEbsWWKnsF8ELr8eP+9EAV/rmhKMJu6Iixlbyanp/43ovn1jCXOO9Cw/TDxunbNoL7IxmJx
	8xUitkLyhj6vvT3Sq8Y4SjsW0/DtALkXZoO2tXRaDsqD+3luuRZ8pzB7Rr+4UUZGvIZHcxVCgm9
	OhqfE7AlHyQsP6SHXXtRyMQNca6E7qa9hY4E/aeJKmiv2wZXnxt/pQUBaXk1UjHL64YCSa7JmGe
	sqqyn40W43yE9nQTk=
X-Received: by 2002:a05:620a:6ccc:b0:8c6:afa0:18ff with SMTP id af79cd13be357-8c6e2da8635mr509516785a.20.1769202910667;
        Fri, 23 Jan 2026 13:15:10 -0800 (PST)
Received: from [127.0.0.1] ([172.183.133.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491965708sm24107786d6.54.2026.01.23.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 13:15:10 -0800 (PST)
Message-Id: <bcd6fcd1190fe21c667b5253a4a33b833e658609.1769202903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Jan 2026 21:15:02 +0000
Subject: [PATCH 3/4] doc: fix some style issues in git-clone and
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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

