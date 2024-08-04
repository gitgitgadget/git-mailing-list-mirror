Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004CA17C68
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801944; cv=none; b=jMyTSBpKdQinMDyjL9VLKp0lATRvVRuByjBlxy0i4o6sHdAXRVZM0OUEUfUCPHVpGefsDLVQDLiB4UgCok5iCK0GGjODoSCkbiqE4KblZC4T16OxK1FRIte2nHY5S1Z9EIqhWUR0XYAEQu0TLX2+obTyZ/e4vhH36FYIe0lDHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801944; c=relaxed/simple;
	bh=W3t2TCpFTQXN0ie1WVRTAx7FScRhX9hj+3hYfEne7xc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NjXxcqgzPw++B5dL5Qrd/n+geNpl7ydzZzApM+JtNeL4i8/xf9deHY8Q9MEd4EQ7V1t3SQlE+apYizhN0VrXMSJm903GUTbxDlOIVnfcDZFIYHFVVDxQZKZd/SLXrTN/BgM/M/fA84oKZwYrnaFDmgLxY/MZJlrikTzG/zQy5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF5ZieoZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF5ZieoZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36bd70f6522so519027f8f.1
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722801941; x=1723406741; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihP7HZqNXu4iXWp6WLEqGREVTCYDzk0zkZUaxOS0ats=;
        b=AF5ZieoZOZ5Sgp+ZJEg/PF0WDqfUztY93uS4oW/ngQ6hrTecJpMr6EZ/9/8QQ5QoKw
         6Wr7RSXL2gj1h+fbiTuHRZTJw9Qhm9+r5oTjqLex5MWX88XXb8zKfLcNdonuAQGfx2Wn
         peRkx5OzmTDFX2jU7RbajUe6irledqzD5pZI5pF814wJ7b7Xdaa15DVYW0tGwAfkS7Hu
         B0z/4q39Qh3FeP8HDBqZAUJTBew+bj+e3QNuDZYj/HkrLgWrLPQYz/5jcTKRoYIKZGnu
         7E9StBm+8jP3DNIz/E64macNMtU69WONupfvIhyW1cv8jNqVlRxrhRmhFEGWJQsnNFDz
         Vz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722801941; x=1723406741;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihP7HZqNXu4iXWp6WLEqGREVTCYDzk0zkZUaxOS0ats=;
        b=O1RPWVIY5dCOM0Paj8WFfZfPi1hw2BzWAhYynUnGf9Cs62RdhlGehY5jyGsAOWaOEn
         N0vmCqgyqvBBr4WVEwLCzfXFLoS1biil944A7ig0RosBQ1DnrLRQUmU8NDrULr/gHy6M
         KpoAQYcYdJn+iNmnOx0gC5g02yPiAnD7+P76sPcebI7rtqScXRkLSZNVfbHf6N0Ducrs
         gZPkTJogQluJwTOCeow6U8d/zvv8nBZ8kwai0w926pFQGysFeDBurxAFaQ35miFUGops
         uniJOXmhHmz2RKghuxqrH0Bztq3+3j6UG/whmguJG9kxLOhWfpGw2mOZG3zJfY+FwVIS
         73jA==
X-Gm-Message-State: AOJu0YziBWb81mxjRFQ8KXaOj/T/VwM6QaOZZquHn6DD5wJiIuF7GhFo
	7MVCXmNVSQ7J+cGMwCgx45Tj9Yp0J3i+XXijORvVtZWwHNFT99sXjXwR2Q==
X-Google-Smtp-Source: AGHT+IFZinUOJJYb0/c8+ThQX8G8t+ilqcD+cEIatCOp6GctzYGRflI3Hl9BJJDQaBAVHb8V7ZPJag==
X-Received: by 2002:a5d:6b09:0:b0:36b:8f4c:71d4 with SMTP id ffacd0b85a97d-36bbc0e6360mr6350823f8f.28.1722801940699;
        Sun, 04 Aug 2024 13:05:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd05ad0csm7827625f8f.79.2024.08.04.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:05:40 -0700 (PDT)
Message-Id: <81b5782d152d87a695e9a2dc685bb2006dbf5190.1722801936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Aug 2024 20:05:34 +0000
Subject: [PATCH 3/5]  doc: git-diff: apply format changes to diff-format
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
 Documentation/diff-format.txt | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index a3ae8747a22..34e703d58c4 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -1,25 +1,25 @@
 Raw output format
 -----------------
 
-The raw output format from "git-diff-index", "git-diff-tree",
-"git-diff-files" and "git diff --raw" are very similar.
+The raw output format from `git-diff-index`, `git-diff-tree`,
+`git-diff-files` and `git diff --raw` are very similar.
 
 These commands all compare two sets of things; what is
 compared differs:
 
-git-diff-index <tree-ish>::
+`git-diff-index` _<tree-ish>_::
         compares the <tree-ish> and the files on the filesystem.
 
-git-diff-index --cached <tree-ish>::
+`git-diff-index --cached` _<tree-ish>_::
         compares the <tree-ish> and the index.
 
-git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
+`git-diff-tree` [`-r`] _<tree-ish-1>_ _<tree-ish-2>_ [_<pattern>_...]::
         compares the trees named by the two arguments.
 
-git-diff-files [<pattern>...]::
+`git-diff-files` [_<pattern>_...]::
         compares the index and the files on the filesystem.
 
-The "git-diff-tree" command begins its output by printing the hash of
+The `git-diff-tree` command begins its output by printing the hash of
 what is being compared. After that, all the commands print one output
 line per changed file.
 
@@ -54,19 +54,19 @@ That is, from the left to the right:
 
 Possible status letters are:
 
-- A: addition of a file
-- C: copy of a file into a new one
-- D: deletion of a file
-- M: modification of the contents or mode of a file
-- R: renaming of a file
-- T: change in the type of the file (regular file, symbolic link or submodule)
-- U: file is unmerged (you must complete the merge before it can
+- `A`: addition of a file
+- `C`: copy of a file into a new one
+- `D`: deletion of a file
+- `M`: modification of the contents or mode of a file
+- `R`: renaming of a file
+- `T`: change in the type of the file (regular file, symbolic link or submodule)
+- `U`: file is unmerged (you must complete the merge before it can
   be committed)
-- X: "unknown" change type (most probably a bug, please report it)
+- `X`: "unknown" change type (most probably a bug, please report it)
 
-Status letters C and R are always followed by a score (denoting the
+Status letters `C` and `R` are always followed by a score (denoting the
 percentage of similarity between the source and target of the move or
-copy).  Status letter M may be followed by a score (denoting the
+copy).  Status letter `M` may be followed by a score (denoting the
 percentage of dissimilarity) for file rewrites.
 
 The sha1 for "dst" is shown as all 0's if a file on the filesystem
@@ -86,7 +86,7 @@ verbatim and the line is terminated by a NUL byte.
 diff format for merges
 ----------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff --raw"
+`git-diff-tree`, `git-diff-files` and `git-diff --raw`
 can take `-c` or `--cc` option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
@@ -128,7 +128,7 @@ other diff formats
 ------------------
 
 The `--summary` option describes newly added, deleted, renamed and
-copied files.  The `--stat` option adds diffstat(1) graph to the
+copied files.  The `--stat` option adds `diffstat`(1) graph to the
 output.  These options can be combined with other options, such as
 `-p`, and are meant for human consumption.
 
-- 
gitgitgadget

