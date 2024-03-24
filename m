Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FD3F8D1
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318749; cv=none; b=P85S1KOguPcLbyb5o15m32ixqSWKdmZRy4TWBvo2cKXc29E++meeC1w9O50ItDcIfYMzVXvXvX7MZtZvDR+x2jrf32wAG0+a022+mWVAm5J0kUG8LV6BH/blBt/na85nhL9IQZlKDRyApewmwyw60neTK01kciNSVGpU5WgpG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318749; c=relaxed/simple;
	bh=uc2jIJdTSiwr2a2/9QM49rlFK8FvJ4vj8ILD2ub9/DQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KVUyKNREfsxb4TGS9d8FD1LUotsBY6Sy63tz5834dN2yQfKZ3zCu7QLeCJHAGUgaV+7f7Y1fU/aTRF6U+IJq38veBf+th6gXLqMY+x/DgQtCAmaKG0k2QFJAFAvCN5Qk8Tw43U81/M/r7kYV2xEmqqR7Gwa6mI0ndIZ1+djei7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7dV8Sqe; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7dV8Sqe"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d476d7972aso61896441fa.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711318745; x=1711923545; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpUV4VZwVVBFFsgAJl9tELMS4GewbewW/eKWWwgUmc0=;
        b=a7dV8SqePrB9d0erwOw3yPBw4/UHXY80q0buBpRU3K+lhHobNJtqqUjQZiDuIeIvXQ
         nAHhArlH8tmHgFqzIT+OGpbxsJtt9Egsjgd606gVnn37KpFX1TYdA7+1U9BteE4KRx/9
         /Y091b94c91UVYkh7/LnrTeJlSMEBnZghAgg8vNKNPRf2uXWGZftgwSkaCbV57/ZbAQW
         meT80+TWep92yQovLR9zYao0EPhdNyEr5EF60sh9+Kt6OMKHaCP20BGqLOljI/XGS1Kc
         dfM16I41ZesvifI5InUeK8zze9T9fRublzx8Srcb4CUWqPp0PxxC8e4aPJYz+AFMF7AD
         hC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711318745; x=1711923545;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpUV4VZwVVBFFsgAJl9tELMS4GewbewW/eKWWwgUmc0=;
        b=kgpdI7Ev9XDlKoIYdQgN/rrM58+uGMJaddLV0NJ7GDpCC9CJWchhbvGjYZRVIxPJcj
         klCKgg29UrzxeDNOPo/5MKIe4Q0M4TZ/ax1o4dsgntenLJXdo0Jmw4HhLcrpGfz5uR5Z
         nW7sX/aIvLOCdE792cufRjU45BPi3YoH1sLUZRaHnl+EGvbdlUEEhOeoXWDW5cqXlke2
         MCEhalG8yDVCv4UHrlOdxgWR0QsGuzhoKl/e7nqqd0VHJ4WXrNppjTcqrELPjWNxYQo+
         kuZEWyrEhjzdhE/awIizGAQBfR0w+dBaESdpwO/cymlv6w/2JFuYjO78TjlqL93Fc9bL
         Hokg==
X-Gm-Message-State: AOJu0YyCILRRxdV8p8uftC8q4KMLiLJS4oT/X4mEKE4NSl155gJWw+Ug
	2w865yg46Hdwhrkc/2PqNzzrTnkILyWpXVhGFUDokxaiNuv3Uj2BxaRePPy/
X-Google-Smtp-Source: AGHT+IHbGJJkpSWb3G07vi2WELmu71IxL0dbh+fDYby+jtV4/FAAzv/WPjLTmSM4afNScc43wzrRgg==
X-Received: by 2002:a2e:8416:0:b0:2d6:93c9:1f87 with SMTP id z22-20020a2e8416000000b002d693c91f87mr3530942ljg.4.1711318744445;
        Sun, 24 Mar 2024 15:19:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a05600c384c00b0041488691eacsm2465649wmr.18.2024.03.24.15.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:19:03 -0700 (PDT)
Message-Id: <310f09fc81c75ef03eb00629db6302d1904585fe.1711318740.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 22:18:58 +0000
Subject: [PATCH 3/4] doc: git-init: apply new documentation formatting
 guidelines
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/init.txt |  4 +--
 Documentation/git-init.txt    | 46 +++++++++++++++++------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index dd1d8332737..af03acdbcbb 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -3,8 +3,8 @@ ifndef::git-init[]
 :see-git-init: (See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 endif::[]
 
-init.templateDir::
+`init.templateDir`::
 	Specify the directory from which templates will be copied. {see-git-init}
-init.defaultBranch::
+`init.defaultBranch`::
 	Allows overriding the default branch name e.g. when initializing
 	a new repository.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 2f864e11ed9..ac4c4a80e26 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,11 +9,11 @@ git-init - Create an empty Git repository or reinitialize an existing one
 SYNOPSIS
 --------
 [verse]
-'git init' [-q | --quiet] [--bare] [--template=<template-directory>]
-	  [--separate-git-dir <git-dir>] [--object-format=<format>]
-	  [--ref-format=<format>]
-	  [-b <branch-name> | --initial-branch=<branch-name>]
-	  [--shared[=<permissions>]] [<directory>]
+`git init` [`-q` | `--quiet`] [`--bare`] [`--template=`{empty}__<template-directory>__]
+	  [`--separate-git-dir` _<git-dir>_] [`--object-format=`{empty}__<format>__]
+	  [`--ref-format=`{empty}__<format>__]
+	  [`-b` _<branch-name>_ | `--initial-branch=`{empty}__<branch-name>__]
+	  [`--shared`[`=`{empty}__<permissions>__]] [_<directory>_]
 
 
 DESCRIPTION
@@ -41,35 +41,35 @@ the repository to another place if `--separate-git-dir` is given).
 OPTIONS
 -------
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 
 Only print error and warning messages; all other output will be suppressed.
 
---bare::
+`--bare`::
 
 Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
 current working directory.
 
---object-format=<format>::
+`--object-format=`{empty}__<format>__::
 
 Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
 values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
 include::object-format-disclaimer.txt[]
 
---ref-format=<format>::
+`--ref-format=`{empty}__<format>__::
 
 Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
 include::ref-storage-format.txt[]
 
---template=<template-directory>::
+`--template=`{empty}__<template-directory>__::
 
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---separate-git-dir=<git-dir>::
+`--separate-git-dir=`{empty}__<git-dir>__::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
@@ -78,15 +78,15 @@ repository.
 +
 If this is a reinitialization, the repository will be moved to the specified path.
 
--b <branch-name>::
---initial-branch=<branch-name>::
+`-b` _<branch-name>_::
+`--initial-branch=`{empty}__<branch-name>__::
 
 Use _<branch-name>_ for the initial branch in the newly created
 repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|<perm>)]::
+`--shared`[`=`(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -99,14 +99,14 @@ The option can have the following values, defaulting to `group` if no value
 is given:
 +
 --
-umask::
-false::
+`umask`::
+`false`::
 
 Use permissions reported by umask(2). The default, when `--shared` is not
 specified.
 
-group::
-true::
+`group`::
+`true`::
 
 Make the repository group-writable, (and g+sx, since the git group may not be
 the primary group of all users). This is used to loosen the permissions of an
@@ -115,13 +115,13 @@ permission bits (e.g. if umask is `0022`, using `group` will not remove read
 privileges from other (non-group) users). See `0xxx` for how to exactly specify
 the repository permissions.
 
-all::
-world::
-everybody::
+`all`::
+`world`::
+`everybody`::
 
 Same as `group`, but make the repository readable by all users.
 
-<perm>::
+_<perm>_::
 
 _<perm>_ is a 3-digit octal number prefixed with `0` and each file
 will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
-- 
gitgitgadget

