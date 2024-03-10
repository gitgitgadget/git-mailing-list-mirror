Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4A39FC6
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097836; cv=none; b=ae68J+tKuaCwOz1jKklWnSUOc3yR/HLKIb0hvMt0KPFIML54ct1yF7ZPHLJupz14ZL8SIu3LAXpXMDknpdpZBjUCE23fNYz+zRzSP/0ua9lMq2gGWpPCiLQ54dCw6hKUQxg8nYeZ47RC+6wLxKuXgLNHpq7b83USJX88zqszfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097836; c=relaxed/simple;
	bh=s8rsLfJ0It10V/qP3mN+GKVVFkpCsROWXbJxOt3hkOc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=l2aareehsjaGbJMbcdnO1aE6/Kd16LevffL1XGRuo/lQbAZIwb/wb9JJ9IPmhmr1am+4uRm5Q7HQfe95k+Sm9QlIDifL1Jw3Kz0aCXXQk8gVkHnfu0Z7PFZh06TOYmsuE25k2G82KfhJC31lcv7oyyUhLBEKZIv6JITgkBNdbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFVCxKNQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFVCxKNQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e93514a6aso301150f8f.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097832; x=1710702632; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=791zlujvpnIKZ7sWFnggdeQ38j2Ml+BtSpVAUgB3EpM=;
        b=lFVCxKNQkijEPTmBljKnEzX6cA9XB89ojp1PMVb1/Wp+iwEX57YLimXN+Gn/+ogH11
         nUUsjsBgipIgqAwuWPNZQ2Cvq4gWXUSK8FnrN46JMrx0Hv0Y/lvI61Wg4Kr8Sl0n2PZl
         8dRymlfH0hZkWTdybv89Q7rAvXEPZzaEpe7MA1eeKtN3/k8EY0QGxQ4rN7LuMAkpyr6D
         D0lJuAkdho0ry4DTJGOSHOcy3kpgxPUBW4VDZQL+TRTc1PMXGO/avg945MaPRk6D1CN1
         qCccTSxgXVq7w8qFp8m0f8MnQWUIycOvQI6HSOxMgXlGaH1/h0Pi2CaTqLaTa+Y+LCWo
         Txrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097832; x=1710702632;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=791zlujvpnIKZ7sWFnggdeQ38j2Ml+BtSpVAUgB3EpM=;
        b=SOQBTTl3b4Gt+dn58DiDKEx/oAWHvOjrs6QZUViF2rANmAtPUxQvzxpd7dwtBIo3hK
         ulR6ffGYU7nb5Rm5cVpupBY5LucfOTSiB+xTMYYDNxlggP9eM6aYk4gwkoi2/RU/2sjs
         1OD8qn5IQ5GINDDk4+3TCd4SdIYboEngBRyCFxl4AXctKhV1+n0bWloenoFUOT1hLCP1
         mg3V3lIoNrW11ydhaRJ1DPaDJQ8iFHRmyrPoGe/34qsu0l/c323yhFYUn8IsefTs0NkB
         V7icSGUgY5UVS9Dxu6YnPYa9yF9nW4uEso/8ULIaH5eZSwNOktqpLXpa909atH+YjzNc
         42VA==
X-Gm-Message-State: AOJu0YxHDrCTdSMP9xM5sBRd3Oe0abOs2PoawF3GSK7KmxBXS4J1E1Lr
	v9of9I8s4IJq6Amg0Ijl+c3g2Vq5b9HHIsEdcR96RUWDO5iLpi4BDJukl95M
X-Google-Smtp-Source: AGHT+IFHQBg0N3wvP1lI80V5LQf2R6a2kbk8llxg7ObwuzlW73OTW7pL1zUypFxYuMpTlz9v03F3xw==
X-Received: by 2002:adf:fc46:0:b0:33e:745a:d98e with SMTP id e6-20020adffc46000000b0033e745ad98emr3200525wrs.23.1710097832056;
        Sun, 10 Mar 2024 12:10:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y9-20020a056000108900b0033e206a0a7asm4557560wrw.26.2024.03.10.12.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:31 -0700 (PDT)
Message-ID: <908b45b8a4c3ac7e1846e9cf323bb4ace7140dc1.1710097830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:25 +0000
Subject: [PATCH 1/6] doc: git-init: format verbatim parts
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

Verbatim parts are all formatted as `fixed font`.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-init.txt | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index e8dc645bb59..7ff7d8e7ee0 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -33,10 +33,10 @@ If the object storage directory is specified via the
 are created underneath; otherwise, the default `$GIT_DIR/objects`
 directory is used.
 
-Running 'git init' in an existing repository is safe. It will not
+Running `git init` in an existing repository is safe. It will not
 overwrite things that are already there. The primary reason for
-rerunning 'git init' is to pick up newly added templates (or to move
-the repository to another place if --separate-git-dir is given).
+rerunning `git init` is to pick up newly added templates (or to move
+the repository to another place if `--separate-git-dir` is given).
 
 OPTIONS
 -------
@@ -53,8 +53,8 @@ current working directory.
 
 --object-format=<format>::
 
-Specify the given object format (hash algorithm) for the repository.  The valid
-values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
+Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
+values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
 include::object-format-disclaimer.txt[]
 
@@ -90,12 +90,12 @@ customized via the `init.defaultBranch` configuration variable).
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
-repository.  When specified, the config variable "core.sharedRepository" is
+repository.  When specified, the config variable `core.sharedRepository` is
 set so that files and directories under `$GIT_DIR` are created with the
 requested permissions.  When not specified, Git will use permissions reported
-by umask(2).
+by `umask(2)`.
 +
-The option can have the following values, defaulting to 'group' if no value
+The option can have the following values, defaulting to `group` if no value
 is given:
 +
 --
@@ -109,21 +109,21 @@ specified.
 Make the repository group-writable, (and g+sx, since the git group may not be
 the primary group of all users). This is used to loosen the permissions of an
 otherwise safe umask(2) value. Note that the umask still applies to the other
-permission bits (e.g. if umask is '0022', using 'group' will not remove read
-privileges from other (non-group) users). See '0xxx' for how to exactly specify
+permission bits (e.g. if umask is `0022`, using `group` will not remove read
+privileges from other (non-group) users). See `0xxx` for how to exactly specify
 the repository permissions.
 
 'all' (or 'world' or 'everybody')::
 
-Same as 'group', but make the repository readable by all users.
+Same as `group`, but make the repository readable by all users.
 
 '<perm>'::
 
 '<perm>' is a 3-digit octal number prefixed with `0` and each file
-will have mode '<perm>'. '<perm>' will override users' umask(2)
-value (and not only loosen permissions as 'group' and 'all'
-do). '0640' will create a repository which is group-readable, but
-not group-writable or accessible to others. '0660' will create a repo
+will have mode '<perm>'. '<perm>' will override users'`umask(2)`
+value (and not only loosen permissions as `group` and `all`
+do). `0640` will create a repository which is group-readable, but
+not group-writable or accessible to others. `0660` will create a repo
 that is readable and writable to the current user and group, but
 inaccessible to others (directories and executable files get their
 `x` bit from the `r` bit for corresponding classes of users).
@@ -172,7 +172,7 @@ $ git add .     <2>
 $ git commit    <3>
 ----------------
 +
-<1> Create a /path/to/my/codebase/.git directory.
+<1> Create a `/path/to/my/codebase/.git` directory.
 <2> Add all existing files to the index.
 <3> Record the pristine state as the first commit in the history.
 
-- 
gitgitgadget

