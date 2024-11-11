Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A501A3031
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343995; cv=none; b=XHCmXOCHrnlWzNf7iJwl1LsbPiYg7ZmuJ9GnGw9RTlDCTnQWLI348qDfFNSVCLyy94krmWIe7/LNjxgq7hrNsTN/HmyLeMheEeAR0eJKDwB71mbVf/J6dXyox8EwSz/if5ZX8Ry57kOpY/yN17a/k6qAUrcrKakzOptP0aMYz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343995; c=relaxed/simple;
	bh=pG6TIZ6xgd+s1fIdq8rfLkuWWrAPW2H9w5TlT5+aHZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=W4ZaqZyyNgOzPNwK0rrDqyW2NJklB20tTm1Ux3ukhuUyzaW3zRcuGsdxZ59wTKyov3MwRpIDHO3ksDZDzqCa4C+NaOfox0y/k4/ma2FAV6VR3JVpjqAt72zgTatJy3KsjJ4FrkpIPbUYlextkiUnXVxY+uC6a9+WPhwZVDUiqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/gioZu4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/gioZu4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d3ecad390so3337204f8f.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343992; x=1731948792; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGYn9kokVEziW7GMIR8t/uCLNBW/YLPTAxPVqIWcoe8=;
        b=R/gioZu43kSC3Lpcmz+4CWJ8f6N0uW7ANNd+ir9WiOoGT65dmTzLY9QFb0P9N3AD+Q
         51gxBLdTEtf1pqPQa2/d5hEJsi7HoxDcQXOrXB6at/iXgUJ5qJGVEmOm+Y3YoKrI36No
         TeFwKUgjnY8hP5mHRnRHmJq+JgEL9FwTID2S+wVenVkLrQT/5FA8fsG3UwQyRh1EJL7H
         IFs8lUEa6JtkfM3NeeYoSA2sSxTYOi3U6V9vKya2eBPlo7aIj9Yf2QXoI37NrWr/WBpu
         HTd04E+WFsMF4gljtgiG5yqs9IT46HZQlmsqZ7LE755pBF0O4/IytdzIF7pEaB5Tt306
         GneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343992; x=1731948792;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGYn9kokVEziW7GMIR8t/uCLNBW/YLPTAxPVqIWcoe8=;
        b=DzSVnSAjvc6tms7rPcdxCZtCwW4rKaprj9mUn7oa8fyC8SWs44tizipZlBj/Naf+kv
         TJyqVDWEjLwnop3z9+WbY2RE+gJfRFCrdYL/KBU3KnEmSyMXHL0hD29x0gIXNFXbWRsx
         OmHzAlfhA670fttaAanPbLACp1zlvO6Q7hfNW2GJRycP9KeDr2HS967GDhyI8Rik5MH2
         Lan62I8z+XQ4WYir5OyqWsKeEENYNPJWXNm2tUhCRFD9k9sVNcgh0kbda7L3ZnEETwM1
         y3X6UIyUOQTH1jVbu+M2YDRmxdzvzRoPKdR0qOF+yOIp31fvqqJNhkguJjLSHBgVKL/p
         02Gw==
X-Gm-Message-State: AOJu0YyH5FJ5gjTEhaHVHMSIfYUlnzWW75ob8HztnksVcwJCP58O/Xbe
	q2QtQ4L27WaB5TFvQLC/r23ycv5SNH1YNWy1HY4I22skS0/JeoHUVlFk3A==
X-Google-Smtp-Source: AGHT+IELXA02vYuEfSGfD/fBxD4SF66VrZ0awuOU6pRgTVcXK8Tq7wfLF1LFvK3SRd5ieSuFKg7RnA==
X-Received: by 2002:a05:6000:1f87:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-381f0f5e2ddmr12025629f8f.14.1731343989967;
        Mon, 11 Nov 2024 08:53:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5f82sm185519795e9.42.2024.11.11.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:53:09 -0800 (PST)
Message-Id: <8fec37ee17481039998af65ce1abec753cf30897.1731343985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 16:53:03 +0000
Subject: [PATCH v2 3/5] doc: git-diff: apply format changes to diff-format
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

