Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E274BE1
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500389; cv=none; b=VlT5NmXM0YMxyvw+g9zyxWIEBqS7laSOGuHDwIwXuImecrpIGqiR685C9b3lOE0md3QObUUQMwuxvj55pq2tJvqengsW0g7N2wTVi2o/p/eZlExMzcPKQZoaPqvSzvC8OPT/JXgOv6d61t9QbeViE/ALazVPzQjUiEJkBW1fu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500389; c=relaxed/simple;
	bh=EVD5ngrcFeWt9rSUuBmqq+pZ7YhXTPs7TFiaBlyx2gs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eY/QQemC8wKxXfyxEP6SSGr3x3ByrNaaNuTPUCRJwIejp93pc2jjGHb0R3hMKXICXB0P5cCjghCe7zWRkeiap2rWupLMhj6EYOBPsBqZINLBL/Z6AAlBuQoWv3iYmCISSOHEHbevDz0D/+YmeVlIKLLilWZF36b4PSD7mblR36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drIY/sgL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drIY/sgL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso6417875e9.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723500385; x=1724105185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g45RxW9yOgG2rHxgamUtInUFrbrgtldPXpCr5qi8N4Y=;
        b=drIY/sgLexdpYLxOqaVhZM55GFlRhK1eDF3y7fO+sSnmM0P5CVDVtz2t49uc38Q68V
         spoifYkKW93zkkspUZeJx0w+JXY0kmWAM8SKfe1If2Pw/Oe8NVkdTkRtHResqN5erVUe
         D/vFnbiYgax63/8FBGyXpedwwSj3UeQGgMmNn4u+C92ARRygSHE1XDfVwXwI4eEpSpiR
         Csxu9Wp6EJZwniv3oNbS4iguuL0dGO/Vi9AsEKLtVM90foTgFd9agx60S56dN7ru6i7m
         wIvoV5JNHYf5MPvYE8rCDjYvYSOKnCoPI2ufEEuOGBbBq6KphJHsoDh6SpChrVQn7yrf
         wyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723500385; x=1724105185;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g45RxW9yOgG2rHxgamUtInUFrbrgtldPXpCr5qi8N4Y=;
        b=tWjADLnjP0NjoZzuBeUFP7P8OzkDraoLvgAdHocyw9d6pWJrgQfTGwk44gjw1U88AZ
         DlZM6CZoCufAxXsMSfxgv+rLbumTeD09bPgOlf4hnyjcqL+HcVIE3jwl00HHwFvADV0A
         f90gWyaw13WFrtiznb7vxw8AVe1dBKOAAQTmsaSq/A+b/KnIIL4wgnXzbk+I39O9+Zu9
         7N1p3q9gQgyAU4Rah1bnYC97EUrHV08sQuODREnqE/x+AW51mX6ButMjO9sgmDWm54lp
         OvZxnjKnaILWlHijuiarJKC+U4pOyJW5NamncjQyZErGvXmAG2DGfWU2imJwEmiQJaAb
         R0cw==
X-Gm-Message-State: AOJu0YwdKDWDW8VmXWnr3gN9jaWiih8Yui6LAlzAa3g70651CgI4iA0H
	3Cxlm013s0xCkJ2WTOp2ezU5s6G0iKWuU/eqb7tlPJsppzsinOLS4aCq6A==
X-Google-Smtp-Source: AGHT+IH8n7AzCjYnXKO8tQe2VLNY5YJsqtHyqrXP9IqMZ/R4PwqTIGgvSSpuxVNpaSIck72A0DbWmA==
X-Received: by 2002:a05:600c:1c17:b0:426:6981:1bd with SMTP id 5b1f17b1804b1-429d6280c76mr6946805e9.5.1723500385248;
        Mon, 12 Aug 2024 15:06:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750e510sm115461695e9.13.2024.08.12.15.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 15:06:24 -0700 (PDT)
Message-Id: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 22:06:23 +0000
Subject: [PATCH] git-svn: mention `svn:globalignores` in help+docs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alex Galvin <agalvin@comqi.com>,
    Alex Galvin <alex.v.galvin@gmail.com>

From: Alex Galvin <alex.v.galvin@gmail.com>

Git-SVN was previously taught to use the svn:globalignores attribute
as well as svn:ignore when creating or showing .gitignore files from
a Subversion repository. However, the documentation and help message
still only mentioned svn:ignore. This commit updates Git-SVN's
documentation and help command to mention the newly supported attribute.

Signed-off-by: Alex Galvin <alex.v.galvin@gmail.com>
---
    git-svn: mention svn:globalignores in help+docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1766%2Fav-gal%2Fgit-svn-doc-globalignores-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1766/av-gal/git-svn-doc-globalignores-v1
Pull-Request: https://github.com/git/git/pull/1766

 Documentation/git-svn.txt | 14 +++++++-------
 git-svn.perl              |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 43c68c2ec44..af69b07caf0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -431,14 +431,14 @@ Any other arguments are passed directly to 'git log'
 	independently of 'git svn' functions.
 
 'create-ignore'::
-	Recursively finds the svn:ignore property on directories and
-	creates matching .gitignore files. The resulting files are staged to
-	be committed, but are not committed. Use -r/--revision to refer to a
-	specific revision.
+	Recursively finds the svn:ignore and svn:globalignores properties on
+	directories and creates matching .gitignore files. The resulting
+	files are staged to be committed, but are not committed. Use
+	-r/--revision to refer to a specific revision.
 
 'show-ignore'::
-	Recursively finds and lists the svn:ignore property on
-	directories.  The output is suitable for appending to
+	Recursively finds and lists the svn:ignore and svn:globalignores
+	properties on directories. The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
 'mkdirs'::
@@ -871,7 +871,7 @@ Tracking and contributing to the trunk of a Subversion-managed project
 # Now commit your changes (that were committed previously using Git) to SVN,
 # as well as automatically updating your working HEAD:
 	git svn dcommit
-# Append svn:ignore settings to the default Git exclude file:
+# Append svn:ignore and svn:globalignores settings to the default Git exclude file:
 	git svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
diff --git a/git-svn.perl b/git-svn.perl
index a2a46608c9b..f3d8cf2c2c1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -219,7 +219,7 @@ my %cmd = (
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' => [ \&cmd_create_ignore,
-			     'Create a .gitignore per svn:ignore',
+			     'Create a .gitignore per directory with svn:ignore and svn:globalignores',
 			     { 'revision|r=i' => \$_revision
 			     } ],
 	'mkdirs' => [ \&cmd_mkdirs ,
@@ -234,7 +234,7 @@ my %cmd = (
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
-	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
+	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore and svn:globalignores listings",
 			{ 'revision|r=i' => \$_revision
 			} ],
 	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",

base-commit: cabe67c0d1819fd1e33079e92615c6c7a3dc560d
-- 
gitgitgadget
