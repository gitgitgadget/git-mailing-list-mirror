Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466906A328
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711192; cv=none; b=sI9Us5L+9x+ZYmAQTOEleTWhdC1k04VIcjo5hqScUOkTmrmnxzF+hmPmcJixdIczLqIuV9MJC9lp4GDjon9PKB4ftg8QIZr6i1boWhe4r4bh3ZHmbYtAGJ00T+m3rV8A5nJ6fbBYCxV03GBCY/weY2qSYUnGKubE7k4We6ye07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711192; c=relaxed/simple;
	bh=Z3z6hoexu4De7PPb6veFl353WEPyq7lQxHwGxreiwpk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=suBlCI8o+z6FWM/0tLDf7VQUGtWJ0Ah7XpC8/EfGO1JbmNuIHk++zorGFAEuvpTCww1wcvtt7ZJux/Lz3hu3wYC2Br9PgWY4/mh4uGVWjXRHVr2BHiCl41zqQrYs+vhbP0bECVxD+q3NZtBhz05bH8ftNxIKdVbDlbOEfRzsuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1SNVWGC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1SNVWGC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-414925ba716so11337545e9.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711711187; x=1712315987; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWbMMLXM0bYPbwqG/b5bxDhnjdqYdBaEv8zcsk+XyU0=;
        b=k1SNVWGCALMspJ2U9F4SyCDEPPiud2s04MaNc1AWh6XvgPMspUTTopLiNV2pdeyjdn
         OLDXRS5+xVc/wDfLbrKRcwLT5MFOhnU0p+lC9P2UlbAFA2JQZGBLLpJ7Q80mt7OwPogf
         tWRxSKawydUVdXXrpmAOQ3IclgUQdp+jgoDbq0yVFGd7E+rO7Hc//FQKj2XC+Vv1Q8A+
         oOf67/slTxXEpv8QI8XTnwMNgp4a2Pq6QB7KIMqumHyqLnxThPGaXO2TojhWOPBMHNeR
         t4Nq5S3jdxLoU4GCJu3/9Sy56GevzT/aW+mu5URyfA4a11CdvctvWbTq6ZO6+/O/aLds
         ra1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711187; x=1712315987;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWbMMLXM0bYPbwqG/b5bxDhnjdqYdBaEv8zcsk+XyU0=;
        b=mE/UHsb9oM/PSzQNXJdHVIw53R7ht4ByquvSbXeurTRwrJXvZmTaZmg85NFnfLtxCG
         7vUBecLJulimqx0a2F/QLw86cOJb6OmReqJJemahRE3AoPB3K2cSBmyCNuZYaCC80DkM
         nVde40CkpsQs7nzVHxrgt9a38MUEkDkCvva/Fjww1PlNEepgukWPDgl3KILFjeDoFeR4
         w3hkzWtN/gizh1BVSdRG1+85PLlH15rptnI4dq/TynI7zQpY6Nq4p+YR5rZzD2DHcLBb
         cYMjJAw+vNpoHyWPJc3sj9v5xNcVb35hRlxO+nNX7A/XD7/iiKjytEyuu8RoyZ1/myzp
         5PFQ==
X-Gm-Message-State: AOJu0YyUHywSg2FPVVZUqTAi5BNvLHQ2xSkvfq3IvzzPtbPN4mur2H4v
	moRET+IQFLbUMTgikZiZZlXvEGwIPBwB+7qup2Tb2K73d9RkpqOZSFYGoiEB
X-Google-Smtp-Source: AGHT+IEr/CeLDWf+1sMh4lOAToBGbyZqgk2Xz98Re5wRxPBB/31m2SJ0YwkuCNZhMS9JlwBRKIVR6A==
X-Received: by 2002:a05:600c:35d6:b0:415:46be:6239 with SMTP id r22-20020a05600c35d600b0041546be6239mr1417666wmq.36.1711711187511;
        Fri, 29 Mar 2024 04:19:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b004146750314csm8313810wms.3.2024.03.29.04.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:19:47 -0700 (PDT)
Message-Id: <ad7986e4c3918e2f8ebb35339fe11d1d5f58156a.1711711181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
	<pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:19:39 +0000
Subject: [PATCH v2 3/5] doc: git-init: apply new documentation formatting
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    Jeff King <peff@peff.net>,
    Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/init.txt |  4 +--
 Documentation/git-init.txt    | 56 +++++++++++++++++------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

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
index 2f864e11ed9..daff93bd164 100644
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
+`git init` [`-q` | `--quiet`] [`--bare`] [++--template=++__<template-directory>__]
+	  [`--separate-git-dir` _<git-dir>_] [++--object-format=++__<format>__]
+	  [++--ref-format=++__<format>__]
+	  [`-b` _<branch-name>_ | ++--initial-branch=++__<branch-name>__]
+	  [++--shared++[++=++__<permissions>__]] [_<directory>_]
 
 
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
+++--object-format=++__<format>__::
 
 Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
 values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
 +
 include::object-format-disclaimer.txt[]
 
---ref-format=<format>::
+++--ref-format=++__<format>__::
 
 Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
 include::ref-storage-format.txt[]
 
---template=<template-directory>::
+++--template=++__<template-directory>__::
 
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---separate-git-dir=<git-dir>::
+++--separate-git-dir=++__<git-dir>__::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
@@ -78,53 +78,53 @@ repository.
 +
 If this is a reinitialization, the repository will be moved to the specified path.
 
--b <branch-name>::
---initial-branch=<branch-name>::
+`-b` _<branch-name>_::
+++--initial-branch=++__<branch-name>__::
 
 Use _<branch-name>_ for the initial branch in the newly created
 repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|<perm>)]::
+++--shared++[++=++(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
 repository.  When specified, the config variable `core.sharedRepository` is
 set so that files and directories under `$GIT_DIR` are created with the
 requested permissions.  When not specified, Git will use permissions reported
-by `umask(2)`.
+by `umask`(2).
 +
 The option can have the following values, defaulting to `group` if no value
 is given:
 +
 --
-umask::
-false::
+`umask`::
+`false`::
 
-Use permissions reported by umask(2). The default, when `--shared` is not
+Use permissions reported by `umask`(2). The default, when `--shared` is not
 specified.
 
-group::
-true::
+`group`::
+`true`::
 
-Make the repository group-writable, (and g+sx, since the git group may not be
+Make the repository group-writable, (and `g+sx`, since the git group may not be
 the primary group of all users). This is used to loosen the permissions of an
-otherwise safe umask(2) value. Note that the umask still applies to the other
+otherwise safe `umask`(2) value. Note that the umask still applies to the other
 permission bits (e.g. if umask is `0022`, using `group` will not remove read
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
-will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
+will have mode _<perm>_. _<perm>_ will override users' `umask`(2)
 value (and not only loosen permissions as `group` and `all`
 do). `0640` will create a repository which is group-readable, but
 not group-writable or accessible to others. `0660` will create a repo
-- 
gitgitgadget

