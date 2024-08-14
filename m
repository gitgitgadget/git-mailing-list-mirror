Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AA20B0F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665796; cv=none; b=fX/9b9Olg1ydHDV4GqFKtRPRpOAvJq9ocv+pfYvXJWYL2txFdr5IrtqEAHomR3MkzXmm60F07sN1Z2q7A5R5K0rYYGfbcd8+bP65RKOu+bQoq4cGIa9b3jeN3KHMrwO2s71bFDs+abPIdAcXuDe8H0Fqp0ShMSr+r2Td76dQDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665796; c=relaxed/simple;
	bh=63cZGeyAoQR9tS+Rkzp/XH6vo3iNSHY1w8t2aFV+Qug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DJYDFYmLnhF4GxKwq7YRdfX6ezu2voGzM/58N671rXsIak1WuAy3vysydZUg7ooAHavYjh2xciK9s3d772d5BM+IIuOSl4iquBFvOc4ZY53B6JTcw7A/iuC5k+3iIiXhkHPI6PjP7ZdImUpxmNHeEywiRiFmc8+wqEawr9J+y2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAqpTyTe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAqpTyTe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368313809a4so742359f8f.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723665792; x=1724270592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0lHya3OwlT4hoJ9snUBrnHVE8gulUjNA6buTD8okZA=;
        b=OAqpTyTeWduf1MXgFPAN3/m0aNJyth0JnNsOC9FQ65tRiDUCOZ/aBrp3UgyPOIIGP7
         UYXLs3DH1zc08MrDDyBY3D0fLD7lqzW34nDm6QIsXoIOWoSnNKmgR5WZ6eUlOToUlMDR
         2t2OQ8BLmkM7azQ69WwWo72Kl3TrxTdigyNOfl8OomBy/mLU1yMoTQ0btYepiAQJQyAZ
         odcTzGmIEmFsSLWs+71kfJxQZAYxKF1H37GMXKZIVNDVBHU5kYePjt3bbxt2pi3jpbhy
         43ZXYSWTmyJ/3riYQelKNl0mxGq5tbEP3htuSRIITDneT7wcfIuklMN/64DSPrfbvpPH
         iagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665792; x=1724270592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0lHya3OwlT4hoJ9snUBrnHVE8gulUjNA6buTD8okZA=;
        b=LbvffZwURGiOPSzATO6FktSqa9PYWRcwgImGY0LxT5tFukXjGWUKvTwMcwMJRib+DX
         9BuOzas8MNmfr5d2eO3ySE74VKgh49WzpiFHkJU7uvxZOzkQhLHOqFS1Au5nOjoYSrZn
         M/ObEzDFXvYn7WSrUPKLI+7TYmwGc4cCgSFP2js+p9BoMSqVkhqPJ1GrxNLFN+VHfIil
         8HPFcpdihuCyd0XHUmJ4wDHVxh3rDGhm+2JL2lvaZuXtkbA7DsDjk5/foPFUO875BrCu
         DK/wfyLKK9t9v5p9qnzfral7hF5SWWj0fZHrlItBty9RcuGCkZ4W3czBN5sd9GBvV+oX
         xB0Q==
X-Gm-Message-State: AOJu0YwwElE31xbAW3P0LWkPLsyPSDKMv/DFR8ydd5qBVwzY1y31aEbI
	KsITDck2ZE9KYhF7xQx+ZiVW6V6y5LLx0oaeGgp6ziLDEDpbNqd9WTPpPA==
X-Google-Smtp-Source: AGHT+IER3q1rM+DR/OYgp0TTC1y29mYPhRpX3giy7mPS0AsQ10lEgVjPM0O2YHicsXo4LgeSFqZyJQ==
X-Received: by 2002:a5d:47a3:0:b0:368:3ee9:e119 with SMTP id ffacd0b85a97d-37186df4d45mr567520f8f.29.1723665791847;
        Wed, 14 Aug 2024 13:03:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bcd0sm13708498f8f.12.2024.08.14.13.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:03:11 -0700 (PDT)
Message-Id: <pull.1766.v3.git.git.1723665790460.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
References: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 20:03:10 +0000
Subject: [PATCH v3] git-svn: mention `svn:global-ignores` in help+docs
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
    Alex Galvin <agalvin@comqi.com>

From: Alex Galvin <agalvin@comqi.com>

Git-SVN was previously taught to use the svn:global-ignores property as
well as svn:ignore when creating or showing .gitignore files from a
Subversion repository. However, the documentation and help message still
only mentioned svn:ignore. Update Git-SVN's documentation and help
command to mention support for the new property. Also capitalize the
help message for the 'mkdirs' command, for consistency.

Signed-off-by: Alex Galvin <agalvin@comqi.com>
---
    git-svn: mention svn:global-ignores in help+docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1766%2Fav-gal%2Fgit-svn-doc-globalignores-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1766/av-gal/git-svn-doc-globalignores-v3
Pull-Request: https://github.com/git/git/pull/1766

Range-diff vs v2:

 1:  d0b5df150e9 ! 1:  a6d93512218 git-svn: mention `svn:global-ignores` in help+docs
     @@
       ## Metadata ##
     -Author: Alex Galvin <alex.v.galvin@gmail.com>
     +Author: Alex Galvin <agalvin@comqi.com>
      
       ## Commit message ##
          git-svn: mention `svn:global-ignores` in help+docs
      
     -    Git-SVN was previously taught to use the svn:global-ignores attribute
     -    as well as svn:ignore when creating or showing .gitignore files from a
     -    Subversion repository. However, the documentation and help message
     -    still only mentioned svn:ignore. This commit updates Git-SVN's
     -    documentation and help command to mention support for the new attribute.
     +    Git-SVN was previously taught to use the svn:global-ignores property as
     +    well as svn:ignore when creating or showing .gitignore files from a
     +    Subversion repository. However, the documentation and help message still
     +    only mentioned svn:ignore. Update Git-SVN's documentation and help
     +    command to mention support for the new property. Also capitalize the
     +    help message for the 'mkdirs' command, for consistency.
      
          Signed-off-by: Alex Galvin <agalvin@comqi.com>
      
     @@ git-svn.perl: my %cmd = (
       			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
       	'create-ignore' => [ \&cmd_create_ignore,
      -			     'Create a .gitignore per svn:ignore',
     -+			     "Create a .gitignore per directory with an SVN ignore property",
     ++			     "Create a .gitignore per directory with SVN ignore properties",
       			     { 'revision|r=i' => \$_revision
       			     } ],
       	'mkdirs' => [ \&cmd_mkdirs ,


 Documentation/git-svn.txt | 14 +++++++-------
 git-svn.perl              |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 43c68c2ec44..bcf7d84a87d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -431,14 +431,14 @@ Any other arguments are passed directly to 'git log'
 	independently of 'git svn' functions.
 
 'create-ignore'::
-	Recursively finds the svn:ignore property on directories and
-	creates matching .gitignore files. The resulting files are staged to
-	be committed, but are not committed. Use -r/--revision to refer to a
-	specific revision.
+	Recursively finds the svn:ignore and svn:global-ignores properties
+	on directories and creates matching .gitignore files. The resulting
+	files are staged to be committed, but are not committed. Use
+	-r/--revision to refer to a specific revision.
 
 'show-ignore'::
-	Recursively finds and lists the svn:ignore property on
-	directories.  The output is suitable for appending to
+	Recursively finds and lists the svn:ignore and svn:global-ignores
+	properties on directories. The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
 'mkdirs'::
@@ -871,7 +871,7 @@ Tracking and contributing to the trunk of a Subversion-managed project
 # Now commit your changes (that were committed previously using Git) to SVN,
 # as well as automatically updating your working HEAD:
 	git svn dcommit
-# Append svn:ignore settings to the default Git exclude file:
+# Append svn:ignore and svn:global-ignores settings to the default Git exclude file:
 	git svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
diff --git a/git-svn.perl b/git-svn.perl
index a2a46608c9b..01e7a70de1c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -219,11 +219,11 @@ my %cmd = (
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' => [ \&cmd_create_ignore,
-			     'Create a .gitignore per svn:ignore',
+			     "Create a .gitignore per directory with SVN ignore properties",
 			     { 'revision|r=i' => \$_revision
 			     } ],
 	'mkdirs' => [ \&cmd_mkdirs ,
-	              "recreate empty directories after a checkout",
+	              "Recreate empty directories after a checkout",
 	              { 'revision|r=i' => \$_revision } ],
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
@@ -234,7 +234,7 @@ my %cmd = (
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
-	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
+	'show-ignore' => [ \&cmd_show_ignore, "Show .gitignore patterns from SVN ignore properties",
 			{ 'revision|r=i' => \$_revision
 			} ],
 	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",

base-commit: cabe67c0d1819fd1e33079e92615c6c7a3dc560d
-- 
gitgitgadget
