Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44278688
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456342; cv=none; b=RJvZfRDSuicZnR7gVL/tuBlF/bSc7DbUcqrbqYQ6t56EXnpO9OSJjThKcbVLCobOedBEQ5xCkgYlbKefJrD1wNJKpCjZ6yETfeyA0cQJDB3KaQAevsPJ7kH4XrTe01a7PUIJP6PDrRErq+ladx6VxuPsx3JdqKiE0Jw3rEZdvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456342; c=relaxed/simple;
	bh=TPUpJc0vMFqDiwKGtoOGQU54KqeyazOz1n449a/++kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOvYqr902ZK1gOxNpqR4g1bnh0UHbAIxo1Z73pxFVqMGVKuaY2EYTTbPgMZRk2++kacslMJPeEQuHmkO7nFYv5mMOzRf/jKRjX7A8jYlwXUjfldR6KuPh1PIAh9iqDc3fd0wVMEPZf04RcuJBuSYJ/y/icSUWeQJmQIa1IzC8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0LSYfO4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0LSYfO4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3394ca0c874so3036898f8f.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708456338; x=1709061138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/dROSBYN2yCv5otNb/A06a8H+xXJ8z/CMmLTKfv9oQ=;
        b=Y0LSYfO4DobfX5+zmLzT1tecvSraHOjSXrJ77QHtpFCyHqvyO4bczP+PR3ZA+xtvWL
         kL1hxFAuBpxCpy1y3vRsJxQchXGuvqJJGVdng/baIV+bXoeSkffBlIaepJvTlvBB2KOa
         h9sNag5cCrF+mo0qU2jukH1vX4mqyVED/HeP5pOsnAF2nffbdySli10P/Y7+JmtDXZMr
         cv6tkDBQvpwrNCpQd7PBoGFesPJU20GT6QX/HBoUGf1pQDtnfsG/gG79UsXgJHlVzo/T
         ej4cuk4rNkkXL2j9BPXkN/u/Y9UATlwL2PyIOSiZ5k4sB1Mru7lR60m3+CmjgssMu3FL
         WV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456338; x=1709061138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/dROSBYN2yCv5otNb/A06a8H+xXJ8z/CMmLTKfv9oQ=;
        b=Eslx36RjEUW96KT8vhtrt6ARe+mbyRomGJdOc/ZMMLbUzT/Zn7HZ3X2JJALOQ4Di+j
         2qW+tP20UBY5iSqRoW6KpjVvlptLnTXPqMcttL2FojzgGfoxrns55Kv9VqlJ0LZoA9yI
         /+Mq7t2UWFLn15UYRVZDmWV6jrXs8a4ewap3e6vA4TtdUMsIYyJTqYLsrpdwXXP3cItR
         7HYad/4ZiQMw9Ly2gI7GqY3DSVDbgqHvMYTrsVL6xfLGfO6eDX+xXR+RPwWSrgzHbd6O
         idpO3j217oVibk0lwuR1dCB/txrru4Cu8IEnspxIOxs/u5yJKX2jP+YHyTdLhySq/LAI
         7puQ==
X-Gm-Message-State: AOJu0YyX3XS/3IqJiSBwbHa16u4xVHxSHsxxZMrVJ6vFhUhup1HMSers
	tixELTlTa1u8QGqS9PGs8y5w9GziTIEtuAzaPhlRtop96zyPjp7YnN6hJFMt
X-Google-Smtp-Source: AGHT+IGQ65PKYo9bVmTxzDXWSJTpidcMRWs1BUDXfdMcZ4rlQXS+LDMy5nwaxCznRXK/kLBriXh/fA==
X-Received: by 2002:a05:6000:1143:b0:33d:2180:30da with SMTP id d3-20020a056000114300b0033d218030damr8740716wrx.58.1708456338294;
        Tue, 20 Feb 2024 11:12:18 -0800 (PST)
Received: from gmail.com (198.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.198])
        by smtp.gmail.com with ESMTPSA id w2-20020adfec42000000b0033d13530134sm14278225wrn.106.2024.02.20.11.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:12:17 -0800 (PST)
Message-ID: <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
Date: Tue, 20 Feb 2024 20:12:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqttm3ouxy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20-feb-2024 10:24:25, Junio C Hamano wrote:

> I have slight aversion to non-words like "oldbranch" (not
> "old-branch"), but not that much.

I also have problems with <old...>.  What's the reference in "old"?

Prior to the restructuring of the whole file, we should probably do:

---- >8 --------- >8 --------- >8 --------- >8 ------
Subject: [PATCH] branch: adjust documentation

Adjust the terms we use in Documentation/git-branch.txt to what
we say in CodingGuideLines:

	If a placeholder has multiple words, they are separated by dashes:
	  <new-branch-name>
	  --template=<template-directory>

Best viewed with --word-diff.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 Documentation/git-branch.txt | 57 +++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0b08442932..d834d89a7f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -17,13 +17,13 @@ SYNOPSIS
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
 'git branch' [--track[=(direct|inherit)] | --no-track] [-f]
-	[--recurse-submodules] <branchname> [<start-point>]
-'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
-'git branch' --unset-upstream [<branchname>]
-'git branch' (-m | -M) [<oldbranch>] <newbranch>
-'git branch' (-c | -C) [<oldbranch>] <newbranch>
-'git branch' (-d | -D) [-r] <branchname>...
-'git branch' --edit-description [<branchname>]
+	[--recurse-submodules] <new-branch> [<start-point>]
+'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branch>]
+'git branch' --unset-upstream [<branch>]
+'git branch' (-m | -M) [<branch>] <new-branch>
+'git branch' (-c | -C) [<branch>] <new-branch>
+'git branch' (-d | -D) [-r] <branch>...
+'git branch' --edit-description [<branch>]
 
 DESCRIPTION
 -----------
@@ -53,7 +53,7 @@ branches not merged into the named commit will be listed.  If the <commit>
 argument is missing it defaults to `HEAD` (i.e. the tip of the current
 branch).
 
-The command's second form creates a new branch head named <branchname>
+The command's second form creates a new branch head named <branch>
 which points to the current `HEAD`, or <start-point> if given. As a
 special case, for <start-point>, you may use `"A...B"` as a shortcut for
 the merge base of `A` and `B` if there is exactly one merge base. You
@@ -61,7 +61,7 @@ can leave out at most one of `A` and `B`, in which case it defaults to
 `HEAD`.
 
 Note that this will create the new branch, but it will not switch the
-working tree to it; use "git switch <newbranch>" to switch to the
+working tree to it; use "git switch" to switch to the
 new branch.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
@@ -72,17 +72,17 @@ the remote-tracking branch. This behavior may be changed via the global
 overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream-to`.
 
-With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
-If <oldbranch> had a corresponding reflog, it is renamed to match
-<newbranch>, and a reflog entry is created to remember the branch
-renaming. If <newbranch> exists, -M must be used to force the rename
+With a `-m` or `-M` option, <branch> will be renamed to <new-branch>.
+If <branch> had a corresponding reflog, it is renamed to match
+<new-branch>, and a reflog entry is created to remember the branch
+renaming. If <new-branch> exists, -M must be used to force the rename
 to happen.
 
 The `-c` and `-C` options have the exact same semantics as `-m` and
 `-M`, except instead of the branch being renamed, it will be copied to a
 new name, along with its config and reflog.
 
-With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
+With a `-d` or `-D` option, `<branch>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
 
@@ -107,7 +107,7 @@ OPTIONS
 --create-reflog::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@\{yesterday}".
+	based sha1 expressions such as "<branch>@\{yesterday}".
 	Note that in non-bare repositories, reflogs are usually
 	enabled by default by the `core.logAllRefUpdates` config option.
 	The negated form `--no-create-reflog` only overrides an earlier
@@ -116,7 +116,7 @@ OPTIONS
 
 -f::
 --force::
-	Reset <branchname> to <start-point>, even if <branchname> exists
+	Reset <branch> to <start-point>, even if <branch> exists
 	already. Without `-f`, 'git branch' refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status, or whether it even
@@ -124,8 +124,8 @@ OPTIONS
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).
 +
-Note that 'git branch -f <branchname> [<start-point>]', even with '-f',
-refuses to change an existing branch `<branchname>` that is checked out
+Note that 'git branch -f <branch> [<start-point>]', even with '-f',
+refuses to change an existing branch `<branch>` that is checked out
 in another worktree linked to the same repository.
 
 -m::
@@ -255,7 +255,7 @@ how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
 	linkgit:git-config[1]. Currently, only branch creation is
 	supported.
 +
-When used in branch creation, a new branch <branchname> will be created
+When used in branch creation, a new branch <branch> will be created
 in the superproject and all of the submodules in the superproject's
 <start-point>. In submodules, the branch will point to the submodule
 commit in the superproject's <start-point> but the branch's tracking
@@ -270,12 +270,12 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 
 -u <upstream>::
 --set-upstream-to=<upstream>::
-	Set up <branchname>'s tracking information so <upstream> is
-	considered <branchname>'s upstream branch. If no <branchname>
+	Set up <branch>'s tracking information so <upstream> is
+	considered <branch>'s upstream branch. If no <branch>
 	is specified, then it defaults to the current branch.
 
 --unset-upstream::
-	Remove the upstream information for <branchname>. If no branch
+	Remove the upstream information for <branch>. If no branch
 	is specified it defaults to the current branch.
 
 --edit-description::
@@ -300,24 +300,21 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	Only list branches whose tips are not reachable from the
 	specified commit (HEAD if not specified). Implies `--list`.
 
-<branchname>::
+<branch>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
+	If ommited, the current branch will be used instead.
 
 <start-point>::
 	The new branch head will point to this commit.  It may be
 	given as a branch name, a commit-id, or a tag.  If this
 	option is omitted, the current HEAD will be used instead.
 
-<oldbranch>::
-	The name of an existing branch.  If this option is omitted,
-	the name of the current branch will be used instead.
-
-<newbranch>::
-	The new name for an existing branch. The same restrictions as for
-	<branchname> apply.
+<new-branch>::
+	The name for new branch. The same restrictions as for
+	<branch> apply.
 
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending
-- 
2.44.0.rc2
