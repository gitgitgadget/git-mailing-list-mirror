Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ABA194A52
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785775; cv=none; b=uMeE9/hw0sYTyLdSOhQ9BvLOimr9Bm7iQMPPmcmTVxYuVBcdAUfeeyb+FQetHd6lFpImL0lqpu4liIyhjwjakG8nmSXn60nduzb2eekTkH+z74D8WKret6RvBJTb/Fn+9dNXpfC8O5XIgLArscLSKqxtvHVFg3vilPJzU7RAhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785775; c=relaxed/simple;
	bh=ZgYJS9FJ+kYWce1LJnJV279bbYBPaLhtmpq/JA15WUY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OA9oK72sPszCMm7QgFf3YF5SmI5hipROm1dEXBRdygtNPqRkVXoJ/aNJJQuzbc8TE9mjIXcd2KtNGt2mg8jXX17ivrV0VWKHWFEi3r50FslRWFG01sTv2j2wG9+3595B6ds2pjnS0yYooq/zJUzCsDmIeKVR/GvSG17jj9zrKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7UEnAB3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7UEnAB3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso14900315e9.3
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731785771; x=1732390571; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX8qAB/CYlQSsBQAIX2SXb4bfy3bhNcI8ah7NaOigxs=;
        b=b7UEnAB3vjT0whFq9ZQc4ARF0CqSP5SKEsrnmWsrmPrnhl/HluKb49eTfqQN5ZV5hD
         AejCgMRaRPWSx0Oe08BQ1Bul/5umRJ63kIDpE5y/b1NbLK+HKgzT9/BQcwoJYK0atS2F
         JDWO3R3I11/pVOcqJOER1u8QwB9n8CYgU+gja8M0EyftTLeQ50+2V2SfUFtNiB5hnhvv
         mRyTjvfFihDXtBeyMX+HazAHd22UL41fjpy1mN8bvmx2RjAhdIGoXLkcCCbK6vcTcMGR
         6LJ0ZiWgE9gqfLkGM+jrJODgsRtA2RurRdW9AhYTVBeJgt+aZZdS3NLeuxh1ZXQYinCx
         +bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731785771; x=1732390571;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX8qAB/CYlQSsBQAIX2SXb4bfy3bhNcI8ah7NaOigxs=;
        b=Rs0fxmt7HOLOtNacngwnKaq9+qnatq52sjPQ0ZAgt4KyRyqCb6krHkWBAfx+FJLSZr
         50Tj21/GcThluP2RaqXFH+HLvNRN3onSrrKIVj8JhPhnEC8r078J+pCcADAppldve3me
         gb0jMlWe6BYSDX2xVVmtQqA+soK/V6GpNLpyDchj8oO1ZaYMjsyUG+Tmr3q7HJIh1HRA
         JiZcynLJNpHxHrn36OxmjylsSD/rnuN7sA9WWxZvimIke8Gik0jlPcQU8WPMoD2kXjNu
         Qp1Ypnb8foijm1pEqXvozDwSzPQwWbcgFtvn1jCj20tSz1i1rnrEcmaq6KlWOyatPFj8
         w9Qg==
X-Gm-Message-State: AOJu0Yz+NrAyDL/Fz8B/GIhhu4DeE1iXq3EEd2Zv8i6W2V2YGBVmVKV9
	fJKhMPjOlk6MrCkKsDEX9roh90dsWzctknr5ZfdF7xJpFVoT9JcGquY1Hw==
X-Google-Smtp-Source: AGHT+IFwemcCG4Dsli9YCh8YKMgVxx/7J8rMz7jw1PPoKVVI5gBpTBQnt4AA0t6irW8FXB6dFRDT5w==
X-Received: by 2002:a05:600c:3584:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-432df72c841mr60005975e9.11.1731785771280;
        Sat, 16 Nov 2024 11:36:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae15d89sm8170345f8f.77.2024.11.16.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 11:36:10 -0800 (PST)
Message-Id: <6841bd5825be8e7b17c2f9c3a997de29ffa3a540.1731785769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Nov 2024 19:36:04 +0000
Subject: [PATCH v3 1/5] doc: git-diff: apply new documentation guidelines
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

The documentation for git-diff has been updated to follow the new
documentation guidelines. The following changes have been applied to
the series of patches:

- switching the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- use _<placeholder>_ instead of <placeholder> in the description
- use `backticks for keywords and more complex option
descriptions`. The new rendering engine will apply synopsis rules to
these spans.
- prevent git-diff from self-referencing itself via gitlink macro when
the generated link would point to the same page.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-diff.txt | 108 +++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index c065f023eca..dfa031d7386 100644
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
+git diff [<options>] <commit>...<commit> [--] [<path>...]
+git diff [<options>] <blob> <blob>
+git diff [<options>] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
@@ -23,7 +23,7 @@ between the index and a tree, changes between two trees, changes resulting
 from a merge, changes between two blob objects, or changes between two
 files on disk.
 
-'git diff' [<options>] [--] [<path>...]::
+`git diff [<options>] [--] [<path>...]`::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -31,7 +31,7 @@ files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' [<options>] --no-index [--] <path> <path>::
+`git diff [<options>] --no-index [--] <path> <path>`::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
@@ -40,82 +40,82 @@ files on disk.
 	or when running the command outside a working tree
 	controlled by Git. This form implies `--exit-code`.
 
-'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::
+`git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
 
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
+`git diff [<options>] [--merge-base] <commit> [--] [<path>...]`::
 
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
+`git diff [<options>] [--merge-base] <commit> <commit> [--] [<path>...]`::
 
 	This is to view the changes between two arbitrary
-	<commit>.
+	_<commit>_.
 +
-If --merge-base is given, use the merge base of the two commits for the
+If `--merge-base` is given, use the merge base of the two commits for the
 "before" side.  `git diff --merge-base A B` is equivalent to
 `git diff $(git merge-base A B) B`.
 
-'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
+`git diff [<options>] <commit> <commit>...<commit> [--] [<path>...]`::
 
 	This form is to view the results of a merge commit.  The first
-	listed <commit> must be the merge itself; the remaining two or
+	listed _<commit>_ must be the merge itself; the remaining two or
 	more commits should be its parents.  Convenient ways to produce
-	the desired set of revisions are to use the suffixes `^@` and
-	`^!`.  If A is a merge commit, then `git diff A A^@`,
+	the desired set of revisions are to use the suffixes `@` and
+	`^!`.  If `A` is a merge commit, then `git diff A A^@`,
 	`git diff A^!` and `git show A` all give the same combined diff.
 
-'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
+`git diff [<options>] <commit>..<commit> [--] [<path>...]`::
 
 	This is synonymous to the earlier form (without the `..`) for
-	viewing the changes between two arbitrary <commit>.  If <commit> on
+	viewing the changes between two arbitrary _<commit>_.  If _<commit>_ on
 	one side is omitted, it will have the same effect as
-	using HEAD instead.
+	using `HEAD` instead.
 
-'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
+`git diff [<options>] <commit>...<commit> [--] [<path>...]`::
 
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
+and the range notations (`<commit>..<commit>` and `<commit>...<commit>`)
+do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
-'git diff' [<options>] <blob> <blob>::
+`git diff [<options>] <blob> <blob>`::
 
 	This form is to view the differences between the raw
 	contents of two blob objects.
@@ -125,22 +125,27 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
--1 --base::
--2 --ours::
--3 --theirs::
+`-1`::
+`--base`::
+
+or `-2`::
+`--ours`::
+
+or `-3`::
+`--theirs`::
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
+`<path>...`::
+	The _<path>_ parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
 	names and get diff for all files under them).
 
@@ -225,11 +230,12 @@ CONFIGURATION
 
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

