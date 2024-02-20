Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADD14A4E6
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460761; cv=none; b=CJcSuOZG+0NZF99oqBY3AIMxcnxK2eq8iZiF9WYVI7G+AILhAVn5TwJLBqKIHd7z3F6E2Ik44T+Vk53wMPDuEgtBBXjy/P/xxLz5bEEwxrDIl2JXSofaJA3PkxbYvmSw39uRoXTsThYl45R3J+qBSQEa9Zl8PAjLy2HjjUSO2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460761; c=relaxed/simple;
	bh=nYsZ92mwHgzFr3lR6l/6Rc/cZqMTJJv1F6I2j4ZAALY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RjuNM8Y2MMXbtRg1HwA+Pfq2bFrredlEH7Z3o7Vq7ibUSK9GUs5Pg+8UDI/OcweXGemKDiP7kbaETgx4p+Vx6UUvHEqzYyn30qtXrkhUOrGcAsPKQh/aWRdaF+rfa7eLTLA09wEYsFQR5GpljSkBXSp0dVeFV08jPJSQP/dB/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbKpR6FA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbKpR6FA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4126d65ace3so9704415e9.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 12:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708460758; x=1709065558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KXX/+naSBA4JoMwXV0Nu1sxaPUxfW/NgzxUCiuumdGY=;
        b=PbKpR6FArxr5IGzcWOyYHHnzOyEa46RzdSNihUS/gjEdTqB/WqD0TfCemFbe6ehmIh
         EI/NRZHk/UPAix36V+ruZHY+XIBhRnGV+OgLEuyI33H+OT94tnMRfJqg2Aq0CFIkGoC1
         +iVvR3YjY8rhCREnqbbVOjNvdBXel+rbnUKVSYZ30IzzGKapZje0BOeGv2Dt3TsxNiP0
         mCU3+UW/O/DEAlQy4QQpKqcRW2ClQWObiZy4jJDtEGngbrMy4Y2fV/MAYYuB7I3/nAi0
         LCily52LS0O09NJ/EG8zKc5cEzwlGIehzhobVkZP2leUaIUxxesukNoJFBsT9PGLhF9v
         2Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460758; x=1709065558;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXX/+naSBA4JoMwXV0Nu1sxaPUxfW/NgzxUCiuumdGY=;
        b=ocGx5LiTfvqSDhY9J/Sek8hLDJjKSAYdiRvE9SkLb273Ennr3UjU1fE0I8T5WwDyEf
         4vZXAI8DeAiSeqRWVR5Wz/b+xmlm1notMiZnFmftcwYHp/CqQ9s3u8NT2ZjIOPDBRgfO
         KPb4y78i3sULCu8jgMKMtHWFMy3hHB3inkJA7UFd191ucGuvwa35ZTo8578cQ66k/7Qy
         00QtoAryjDin7kQnwGinkNqTTH3f7Wq6OgGd9U1YwxFdsGvqkCCV91O1NIRvP+XNJ6Yb
         3BbacTdLHkZZOZynzR3fp7dv6T/mojzytFktTADnL5lX91iUX9bIDFPNk34LmkZGKz58
         ayig==
X-Gm-Message-State: AOJu0YxjRrye59MLHiRFhDZUKJfsVAXzW+Q+9/umuqIbvsV104zWPwTr
	cSMtd43Y1J/SCimg11lczT7UUrIutkdJqAyTg4rQg79P9yai1zj8
X-Google-Smtp-Source: AGHT+IF34ek9ZZmxHW2NN6VhXcZFqrRQDyYq/nlk7ervBvNOElMxlG0l/eWUlCYmlOF//PU3ZzljEQ==
X-Received: by 2002:adf:ee41:0:b0:33d:1f11:33c1 with SMTP id w1-20020adfee41000000b0033d1f1133c1mr8717171wro.55.1708460757637;
        Tue, 20 Feb 2024 12:25:57 -0800 (PST)
Received: from gmail.com (198.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.198])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe705000000b0033b8305ffe2sm14515491wrm.87.2024.02.20.12.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 12:25:57 -0800 (PST)
Message-ID: <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
Date: Tue, 20 Feb 2024 21:25:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] branch: adjust documentation
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
Content-Language: en-US
In-Reply-To: <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adjust the placeholders we use in Documentation/git-branch.txt to what
we say in CodingGuideLines:

	If a placeholder has multiple words, they are separated by dashes:
	  <new-branch-name>
	  --template=<template-directory>

Best viewed with --word-diff.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

 Documentation/git-branch.txt | 54 +++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0b08442932..489507e25f 100644
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
+The command's second form creates a new branch head named <new-branch>
 which points to the current `HEAD`, or <start-point> if given. As a
 special case, for <start-point>, you may use `"A...B"` as a shortcut for
 the merge base of `A` and `B` if there is exactly one merge base. You
@@ -61,7 +61,7 @@ can leave out at most one of `A` and `B`, in which case it defaults to
 `HEAD`.
 
 Note that this will create the new branch, but it will not switch the
-working tree to it; use "git switch <newbranch>" to switch to the
+working tree to it; use "git switch <new-branch>" to switch to the
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
+	Reset <new-branch> to <start-point>, even if <new-branch> exists
 	already. Without `-f`, 'git branch' refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status, or whether it even
@@ -124,8 +124,8 @@ OPTIONS
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).
 +
-Note that 'git branch -f <branchname> [<start-point>]', even with '-f',
-refuses to change an existing branch `<branchname>` that is checked out
+Note that 'git branch -f <new-branch> [<start-point>]', even with '-f',
+refuses to change an existing branch `<new-branch>` that is checked out
 in another worktree linked to the same repository.
 
 -m::
@@ -255,7 +255,7 @@ how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
 	linkgit:git-config[1]. Currently, only branch creation is
 	supported.
 +
-When used in branch creation, a new branch <branchname> will be created
+When used in branch creation, a new branch <new-branch> will be created
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
@@ -300,8 +300,8 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	Only list branches whose tips are not reachable from the
 	specified commit (HEAD if not specified). Implies `--list`.
 
-<branchname>::
-	The name of the branch to create or delete.
+<new-branch>::
+	The name of the branch to create.
 	The new branch name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
@@ -311,14 +311,10 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	given as a branch name, a commit-id, or a tag.  If this
 	option is omitted, the current HEAD will be used instead.
 
-<oldbranch>::
+<branch>::
 	The name of an existing branch.  If this option is omitted,
 	the name of the current branch will be used instead.
 
-<newbranch>::
-	The new name for an existing branch. The same restrictions as for
-	<branchname> apply.
-
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending
 	order of the value. You may use the --sort=<key> option
-- 
2.44.0.rc2
