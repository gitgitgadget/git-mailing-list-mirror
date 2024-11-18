Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F213DBBE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967562; cv=none; b=XJALQEaY8uPhj55u0Gn3HjDHFtMAhfuzKHKTEod0o0ZkWVPz/klVauMGXzSv4sQCTSJtWWhaT9zfi16qwaGoXL2Jfqow5QRV7bsymS5hj+BVkZFQ5Bu7hVEWYXOF+sRCYdkV9ydWKGIbZWyyC9a26glom2iNpVOJnztuEW8DOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967562; c=relaxed/simple;
	bh=pG6TIZ6xgd+s1fIdq8rfLkuWWrAPW2H9w5TlT5+aHZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rEcvUMD3Y0qavSXljfXiJL+OMMkUcAcWKo3MlPmbFY0cFEO+ao37x3h2gj2Fo8fHw2xUlt+ISPJ8AeJNGkcLciN6C19gaEX/SuCG77kawBfRy3Nfadb/E526HNvXEC0sRndXiMhR7ugfq0CMPYxSi2DGLfRqLkXAAkyuD260fu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG+d8/po; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG+d8/po"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so39181315e9.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731967558; x=1732572358; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGYn9kokVEziW7GMIR8t/uCLNBW/YLPTAxPVqIWcoe8=;
        b=EG+d8/poohNyIgQrJj6D2zWr6Z3YhHQGdKtQhy4tCHjNCbk+y0/CByvJ1qUrZdHn7V
         NDlDlFAErMcdx/5gwLGlMqlS9lAGOpyIOmpZxpqoRhdIldTsOELybMYp5jpwIGUSF/4E
         OEV+8HdJAsU/pQ9trUkPYtYOp7OkbADxilhXRARx27ve6YBu7T6MLtCzxluC2lsz9W0c
         si2mFxacd5Fur7vnUdTB64+EfYBELK2UMUdTnlNVEKZc4Vu78v6jj53pS8cTA3JJXVAC
         rvRXSBd/pYDeqkgSMC/vwNG6PN7CooPmrDHzBHhtv9V6kftjV2L8wgKdQViNPDWtzch8
         M3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967558; x=1732572358;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGYn9kokVEziW7GMIR8t/uCLNBW/YLPTAxPVqIWcoe8=;
        b=r/Kb43AY6JBw2opSfkmHxArihX9zNMhszdv+b94Sx8pqgiRVKX+tS514CWfctZ6GMS
         zgrWse2gWb3ys7acvP62YMOubysRsqccyl6UsqlEM1G/hhDJNLB5YTmEtBEdfWZhHn1b
         A2klQ8rS3OSGAZxQ5OHlIK0oe69fvo2SJyXWRpEmJNdokhLzmgWDiVspVLegeP06cXdd
         P5ey8hlbczom+CQzfBRNWdHCtQyOSHyqud08CyF/BYRiHHTPmASmg69CS3NmRSkCUw99
         nmjGaRd4T1K0ouyoRz7VzPfXfClH1+FRJTvDKnW+FIoFVMa93O9QXz/A3pN3qJ5H61jM
         z6SA==
X-Gm-Message-State: AOJu0Yx0any5V6MmGEZsxaNeWX5p7hUyDGPXeLyJ4yTwqkYgBn9TucTS
	9plpRD4xax2D5SZv196wWK09ApYjQRmRLKtGTMYXGvcpBXqpIGgC3FHkFg==
X-Google-Smtp-Source: AGHT+IGHQFJFGpLMbB8+844afALwdLM9mjJ60CMYj8tZYdZvdHLa0sgAiZIdYTTt71D27LBQ0EU5pQ==
X-Received: by 2002:a05:600c:3ca9:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-432df72ab6bmr119374745e9.8.1731967558067;
        Mon, 18 Nov 2024 14:05:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80a28sm169548055e9.24.2024.11.18.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:05:57 -0800 (PST)
Message-Id: <aca3573cd95f0a9eb27e36914a27614d23eb9a0d.1731967553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Nov 2024 22:05:51 +0000
Subject: [PATCH v4 3/5] doc: git-diff: apply format changes to diff-format
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-format.txt | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index a3ae8747a22..c72fb379867 100644
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
-        compares the <tree-ish> and the files on the filesystem.
+`git-diff-index <tree-ish>`::
+	compares the _<tree-ish>_ and the files on the filesystem.
 
-git-diff-index --cached <tree-ish>::
-        compares the <tree-ish> and the index.
+`git-diff-index --cached <tree-ish>`::
+	compares the _<tree-ish>_ and the index.
 
-git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
+`git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]`::
         compares the trees named by the two arguments.
 
-git-diff-files [<pattern>...]::
+`git-diff-files [<pattern>...]`::
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

