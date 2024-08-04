Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F69139CFF
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801943; cv=none; b=NiRGqt79RANCmmdbTSwSQphYMGgvcFZNzhT8bsOzFR0qwzjDm0enCpCeeAxQZJrUzz7GLGNtKUn9Pg/lJSX/fDaiDSbCdtgqb7jf+B30e3Eeo0y1lzDOgYC4z0YdRofSWlsHFJAFP7fcZIFua7V2LuzciH9cjdVmC/283kt7qo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801943; c=relaxed/simple;
	bh=M5q+O/AF3rBeHdlPHwClE09H0DAMfVwWiF0FrFa0DEE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XeOE2e6suusT5WJyeLYcxpuMtST3jwySz3fXOgC2DKO9/p/do0mG1eKmEcMZ+QN6jlyQOIHLFzGWa+0V6wTfdOaFSiGxRwwd8Kh88EyeMlDdW+4hw6u3+WEoPb2vbLq1Cmy3h8z6xfkVLJDumjdaqW3m020n2vQltjREpMzSJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReyBg5oB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReyBg5oB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280bca3960so68551755e9.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722801940; x=1723406740; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERahp9qjwu2Vhx74GqJDJZP6nHzRCYxNG2NWR9limE8=;
        b=ReyBg5oBIzZA6dRMDFxC6DBMEWY353zUKAnqiiY+2GSmJGiNIxLTCTfUJ0p2KNRqO0
         fvaLWEsczJoB9ShhSZWyMTXcfod616Sj5LV42KXI4IzKi5tq219wnE8AOiY6jIQvGQy+
         LWGnBVgBSzg1jigjRMprMUNw4SjQpCqQISNoK4dYz7VvXyOSAE2ko3N/VuqctDKfDqe2
         xJx9JfgPcgbpDI09FSZecbEDhREw0DF7yG2O7T9twtxKMHgqbY0so/jvf3jqfmhAjaHF
         c7ivaekzhQq/hBqrCctxsEk0hbDubCxIi117Ko4jQ+MsndJQWxOmRVEpaEKSsdKXfM2S
         oP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722801940; x=1723406740;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERahp9qjwu2Vhx74GqJDJZP6nHzRCYxNG2NWR9limE8=;
        b=UPgnvjpe0I20y52TfSRoLrdW4SeHgV6yf5PcrAOopsd1JEkA5GVoToEyZYWBtcTIg1
         S6VPqRvTbkC+PWS/YnpLeRt7jc7rqy1lpU5y1For3q+1r4nvhvW8DfsWPrxKpykG6qbK
         UcvhkcgmWqXqoTxqdDW/iXyt4OYKR2wheLOWXBKl8ZvTLQWotdqVEzbh18pprF5HidDW
         D+wZ6zbQnBjJdj7G//ZtS+76ujH0aCt+vgZjw8IzxiG8HVrnIJVfLQaavYpJ5L7esZSo
         yArz6BnjHnVFPozcm1zGKsn9+6lfLCWQS6KR97watyssti7pupzSrhuWfASAxzi9hNSw
         1uog==
X-Gm-Message-State: AOJu0Yz+C3+2LyAKtd+wCkqr45xUBunwtFm+m9g0OhMksK1IYu1euzBu
	vaHRFblHS/loX70Gal4K8sQAtCfw8v0/gZmXT1BH8sX4BbnyybT1qSgNLg==
X-Google-Smtp-Source: AGHT+IH0dBauC7jJ3vPuyRJ5rvRBenigbhbkoK7Z/9mQqKWvlQa2olNGjuPiUYxpsELj6s6WXM3DmQ==
X-Received: by 2002:a05:600c:1912:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-428e6b04311mr62225765e9.21.1722801939103;
        Sun, 04 Aug 2024 13:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a862sm173531125e9.4.2024.08.04.13.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:05:38 -0700 (PDT)
Message-Id: <515ddbf1dceacc0c186e3d31c13e76a5afc6c45f.1722801936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Aug 2024 20:05:32 +0000
Subject: [PATCH 1/5] doc: git-diff: apply new documentation guidelines
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
 Documentation/git-diff.txt | 101 +++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index c065f023eca..7db497ec48d 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,13 +8,13 @@ git-diff - Show changes between commits, commit and working tree, etc
 
 SYNOPSIS
 --------
-[verse]
-'git diff' [<options>] [<commit>] [--] [<path>...]
-'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
-'git diff' [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
-'git diff' [<options>] <commit>...<commit> [--] [<path>...]
-'git diff' [<options>] <blob> <blob>
-'git diff' [<options>] --no-index [--] <path> <path>
+[synopsis]
+git diff [<options>] [<commit>] [--] [<path>...]
+git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
+git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
+git diff [<options>] <commit>`...`<commit> [--] [<path>...]
+git diff [<options>] <blob> <blob>
+git diff [<options>] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
@@ -23,7 +23,7 @@ between the index and a tree, changes between two trees, changes resulting
 from a merge, changes between two blob objects, or changes between two
 files on disk.
 
-'git diff' [<options>] [--] [<path>...]::
+`git diff` [_<options>_] [`--`] [_<path>_...]::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -31,7 +31,7 @@ files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' [<options>] --no-index [--] <path> <path>::
+`git diff` [_<options>_] `--no-index` [`--`] _<path>_ _<path>_::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
@@ -40,82 +40,82 @@ files on disk.
 	or when running the command outside a working tree
 	controlled by Git. This form implies `--exit-code`.
 
-'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::
+`git diff` [_<options>_] `--cached` [`--merge-base`] [_<commit>_] [`--`] [_<path>_...]::
 
 	This form is to view the changes you staged for the next
-	commit relative to the named <commit>.  Typically you
+	commit relative to the named _<commit>_.  Typically you
 	would want comparison with the latest commit, so if you
-	do not give <commit>, it defaults to HEAD.
-	If HEAD does not exist (e.g. unborn branches) and
-	<commit> is not given, it shows all staged changes.
-	--staged is a synonym of --cached.
+	do not give _<commit>_, it defaults to `HEAD`.
+	If `HEAD` does not exist (e.g. unborn branches) and
+	_<commit>_ is not given, it shows all staged changes.
+	`--staged` is a synonym of `--cached`.
 +
-If --merge-base is given, instead of using <commit>, use the merge base
-of <commit> and HEAD.  `git diff --cached --merge-base A` is equivalent to
+If `--merge-base` is given, instead of using _<commit>_, use the merge base
+of _<commit>_ and `HEAD`.  `git diff --cached --merge-base A` is equivalent to
 `git diff --cached $(git merge-base A HEAD)`.
 
-'git diff' [<options>] [--merge-base] <commit> [--] [<path>...]::
+`git diff` [_<options>_] [`--merge-base`] _<commit>_ [`--`] [_<path>_...]::
 
 	This form is to view the changes you have in your
-	working tree relative to the named <commit>.  You can
-	use HEAD to compare it with the latest commit, or a
+	working tree relative to the named _<commit>_.  You can
+	use `HEAD` to compare it with the latest commit, or a
 	branch name to compare with the tip of a different
 	branch.
 +
-If --merge-base is given, instead of using <commit>, use the merge base
-of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
+If `--merge-base` is given, instead of using _<commit>_, use the merge base
+of _<commit>_ and `HEAD`.  `git diff --merge-base A` is equivalent to
 `git diff $(git merge-base A HEAD)`.
 
-'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
+`git diff` [_<options>_] [`--merge-base`] _<commit>_ _<commit>_ [`--`] [_<path>_...]::
 
 	This is to view the changes between two arbitrary
-	<commit>.
+	_<commit>_.
 +
-If --merge-base is given, use the merge base of the two commits for the
+If `--merge-base` is given, use the merge base of the two commits for the
 "before" side.  `git diff --merge-base A B` is equivalent to
 `git diff $(git merge-base A B) B`.
 
-'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
+`git diff` [_<options>_] _<commit>_ __<commit>__++...++__<commit>__ [`--`] [_<path>_...]::
 
 	This form is to view the results of a merge commit.  The first
-	listed <commit> must be the merge itself; the remaining two or
+	listed _<commit>_ must be the merge itself; the remaining two or
 	more commits should be its parents.  Convenient ways to produce
 	the desired set of revisions are to use the suffixes `^@` and
-	`^!`.  If A is a merge commit, then `git diff A A^@`,
+	`^!`.  If `A` is a merge commit, then `git diff A A^@`,
 	`git diff A^!` and `git show A` all give the same combined diff.
 
-'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
+`git diff` [_<options>_] __<commit>__++..++__<commit>__ [`--`] [_<path>_...]::
 
 	This is synonymous to the earlier form (without the `..`) for
-	viewing the changes between two arbitrary <commit>.  If <commit> on
+	viewing the changes between two arbitrary _<commit>_.  If _<commit>_ on
 	one side is omitted, it will have the same effect as
-	using HEAD instead.
+	using `HEAD` instead.
 
-'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
+`git diff` [_<options>_] __<commit>__++...++__<commit>__ [`--`] [_<path>_...]::
 
 	This form is to view the changes on the branch containing
-	and up to the second <commit>, starting at a common ancestor
-	of both <commit>.  `git diff A...B` is equivalent to
+	and up to the second _<commit>_, starting at a common ancestor
+	of both _<commit>_.  `git diff A...B` is equivalent to
 	`git diff $(git merge-base A B) B`.  You can omit any one
-	of <commit>, which has the same effect as using HEAD instead.
+	of _<commit>_, which has the same effect as using `HEAD` instead.
 
 Just in case you are doing something exotic, it should be
-noted that all of the <commit> in the above description, except
+noted that all of the _<commit>_ in the above description, except
 in the `--merge-base` case and in the last two forms that use `..`
-notations, can be any <tree>. A tree of interest is the one pointed to
-by the ref named `AUTO_MERGE`, which is written by the 'ort' merge
+notations, can be any _<tree>_. A tree of interest is the one pointed to
+by the ref named `AUTO_MERGE`, which is written by the `ort` merge
 strategy upon hitting merge conflicts (see linkgit:git-merge[1]).
 Comparing the working tree with `AUTO_MERGE` shows changes you've made
 so far to resolve textual conflicts (see the examples below).
 
-For a more complete list of ways to spell <commit>, see
+For a more complete list of ways to spell _<commit>_, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
-However, "diff" is about comparing two _endpoints_, not ranges,
-and the range notations (`<commit>..<commit>` and
-`<commit>...<commit>`) do not mean a range as defined in the
+However, `diff` is about comparing two _endpoints_, not ranges,
+and the range notations (__<commit>__++..++__<commit>__ and
+__<commit>__++...++__<commit>__) do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
-'git diff' [<options>] <blob> <blob>::
+`git diff` [_<options>_] _<blob>_ _<blob>_::
 
 	This form is to view the differences between the raw
 	contents of two blob objects.
@@ -125,22 +125,22 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
--1 --base::
--2 --ours::
--3 --theirs::
+`-1` `--base`::
+`-2` `--ours`::
+`-3` `--theirs`::
 	Compare the working tree with the "base" version (stage #1),
 	"our branch" (stage #2) or "their branch" (stage #3).  The
 	index contains these stages only for unmerged entries i.e.
 	while resolving conflicts.  See linkgit:git-read-tree[1]
 	section "3-Way Merge" for detailed information.
 
--0::
+`-0`::
 	Omit diff output for unmerged entries and just show
 	"Unmerged".  Can be used only when comparing the working tree
 	with the index.
 
-<path>...::
-	The <paths> parameters, when given, are used to limit
+_<path>_...::
+	The _<path>_ parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
 	names and get diff for all files under them).
 
@@ -225,11 +225,12 @@ CONFIGURATION
 
 include::includes/cmd-config-section-all.txt[]
 
+:git-diff: 1
 include::config/diff.txt[]
 
 SEE ALSO
 --------
-diff(1),
+`diff`(1),
 linkgit:git-difftool[1],
 linkgit:git-log[1],
 linkgit:gitdiffcore[7],
-- 
gitgitgadget

