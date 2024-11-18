Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37818A92D
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967560; cv=none; b=ldYMo0TPhKT5Wspi1Sx1Ng6yWAyzT+VTcloFbAbXx94Ma1f6jwa/zo5GGiV2zHTSJGEi8uZWYEiygWjTrZCJnz/IUrcjmgOYFqmUCAZBDIXOSIeeouxh4vjw8f5zKssEwq4sZt2CVGyPDLLbcgyRN/1CDJaEImX17dvgnSnNV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967560; c=relaxed/simple;
	bh=Ta2/FsrjQ1mbkf/7EZxiIrxDXDahOy5qju4k3NO3dJs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=YOkcMj97cvVN8eNIoupZCmO5IANAnmhEE84vD7oHc7OMDjUvcdzi9f4vQsAJPwLa7Jt6iwLbrcQx/9s7hy7lw8z+TINW9/0cFa7EPWzT2Adwzcba6H4rfqM1hriSr0nLPtaYu8BgiWVJ9QHNe5v8FaOu/qTL4w2+DhF6XgVB5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpWyJ/dP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpWyJ/dP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431616c23b5so27317695e9.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731967556; x=1732572356; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn5fCLeHrbLpKoz3pTsnm85hQFhHs8ia1oVXwdXP9K8=;
        b=hpWyJ/dPMmoHonYhrxOtvXcI/f0+Rpuc44JB499MYpg7FX7mlx1vqCFaJWeJhZVLIg
         WTuZRZF0cZp5xs1DCnvilSl4F/RDXtRJnKuzBMPzK1J50odG9C8HjDfyCPCe3faxCXIb
         D7XblFWGMclPWHZbFLvFiI1S1ExbU+bRfKOCCvR3vEsxwcVeiARGeUBDUB6ljwf4tm2i
         WcEy45JRIisAtHs72mK3G7rueC8mNLwsrvNGABXnfx98GvOoLIJ8ujldobPOfEHJv+/8
         tOa0JCmzlFS5ZcQ/LbtzBEJDEMu7ltKbZWR18dBmbvWBx06RAdIrjhS1gqgrPhAeVl9f
         C2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967556; x=1732572356;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mn5fCLeHrbLpKoz3pTsnm85hQFhHs8ia1oVXwdXP9K8=;
        b=CS+WA1KE9VmL8oEXNY/TAiuev1u7u21q/UVCc1+3vt/VeTVSMqgfT4pJFQSJoyWNmM
         fWbzROH6cW4aUNUsrnB+Rk6qVectnk+aiDevm/npURsAwoADmAS+djcQ81JQhC+ZHOQQ
         Z0PAOwM4V97hl09UhD+gUHVX/q0JWqGBIOGQT4mAa8y1QLDMqKCYGYL66GY8L3w+LNFw
         NujYVL3UwnfpD35Soch3Pl6GukVkyF3HCEJDQ3WVD9nCVSZLuc+Sa426P9ga/p4+Zq+5
         qmUfFrAP5UjBLSmTs1nPuwPttZlbVl0qXnTy6acoTvR6JjOr4G/7/FOmJAqf/h2DbXEW
         l4FA==
X-Gm-Message-State: AOJu0Yz3iX7mZBaW/yLg00cwbraSowcWXj7FgAWN1Z3HrBsHGHzbBdO8
	7Xa8G9Btyhf2m9Q/Fd9jiKrUzw+UzZU+sRuLMXFQ12N9P+E5v/7tPSCfLg==
X-Google-Smtp-Source: AGHT+IG9vy6xAAF3WZi34OV41w9JSUYT8XwBdEL6XMqwBqTGk3KVvX/Sgl7CBiKFK78X5Kx+HbYk4w==
X-Received: by 2002:a05:600c:2181:b0:431:4a82:97f2 with SMTP id 5b1f17b1804b1-432f57a9a26mr7268045e9.6.1731967556327;
        Mon, 18 Nov 2024 14:05:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7206csm168146095e9.7.2024.11.18.14.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:05:55 -0800 (PST)
Message-Id: <fd3ee137fe4f22eb864f1f972c216b7a7f05d0f9.1731967553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Nov 2024 22:05:49 +0000
Subject: [PATCH v4 1/5] doc: git-diff: apply new documentation guidelines
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
 Documentation/git-diff.txt | 122 ++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index c065f023eca..e19f31e8b9d 100644
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
@@ -125,22 +125,31 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
--1 --base::
--2 --ours::
--3 --theirs::
-	Compare the working tree with the "base" version (stage #1),
-	"our branch" (stage #2) or "their branch" (stage #3).  The
-	index contains these stages only for unmerged entries i.e.
-	while resolving conflicts.  See linkgit:git-read-tree[1]
-	section "3-Way Merge" for detailed information.
+`-1`::
+`--base`::
+`-2`::
+`--ours`::
+`-3`::
+`--theirs`::
+	Compare the working tree with
++
+--
+ * the "base" version (stage #1) when using `-1` or `--base`,
+ * "our branch" (stage #2) when using `-2` or `--ours`, or
+ * "their branch" (stage #3) when using `-3` or `--theirs`.
+--
++
+The index contains these stages only for unmerged entries i.e.
+while resolving conflicts.  See linkgit:git-read-tree[1]
+section "3-Way Merge" for detailed information.
 
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
 
@@ -225,11 +234,12 @@ CONFIGURATION
 
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

