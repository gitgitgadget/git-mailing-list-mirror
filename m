Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49224E2F2F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547228; cv=none; b=eqqW6HdZultmmtoB7qsRuUAwY0K/nvqcGsHDxlWdc86iMaqWU4y+2bgoVQ+tLtkXtVHm2+kV1BwQAPARqLRuCyBrDU6HzM38sPiuBs/C0YjUkI/ShcyqLnhICBFKZSrTVS+4z4wMbbHppH4hhpbtizS7zfybH26aDeymgCHWOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547228; c=relaxed/simple;
	bh=qZ6C0Ixn9GPS1y7Rx/ca6U14uUAa9AvnaDlLM9Gnde8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SLVbSfZubt7CNfgosNh8fDJsDPYy4NCCroVm9oJ9N4VsU2i5zJjgMBUN5j1sXJR4JrJY+RvppYvR4ZfXy5WhQ59Z3RrSvhTqjWQOTc00SdIfMVZCsZKuzpxHzTCqA+WUY+hkxk5RpdYKnA7HXRrn9sGxCPtGmmadMg0bmCChctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEopl4Sy; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEopl4Sy"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6d7e06dbcccso2833789eaf.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547216; x=1792152016; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wcuBWEeDneKUtEu5R/XwaCT1BctPPH+LD94JIZg0A24=;
        b=OEopl4SyIwcKU9s2aITvL6n8YkxPTk3HHZ3vnTz/NnDyhfF8YTJr0Ct3SxenGB2UOd
         EKGQMTgBbK8ckNPdAKQcxffHPuUlaxUw66sYU0iD3DzmW+vxKT+c7rbqPdAl0+T+JVWe
         yDL/q7lzhjHGNfxYOwBP+IO7oAa3SxLLCOzjsILcn6x00Y03w4vs10YoHuLnTbF/u6L1
         0kCpvxB8Vg3zhQ8dAZePYL4Ynn4/a/SY4XphQMLGkLtEnNpmvLZ6I9e3CQgrfffP2aWV
         zwYEu5cXruZCeuaRD5NKWahXrdVTV8+1iUz4G5xFzsahqc2AsHfp0ijLQmHpzQK2t4dW
         Mn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547216; x=1792152016;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcuBWEeDneKUtEu5R/XwaCT1BctPPH+LD94JIZg0A24=;
        b=MHsS7PUsIH572ug6YaaGO1pDe9tXLpQ6cc0EJnIgCYoqSmhdCHM0mM7QbTHHXEu7YB
         bPvckjtxLNstyTBkmwUpR35sFCOXUD6Or3glKHBqEz53QUfVPD74U1XLzuQbuzchoHkQ
         1653LL5W/tbrtdTx06sayz2IxxciUs989Vxfs717CZVvkq5w4FUp+Dt+x5pXRlBTjYYg
         0Gh4ezCkKBGvGsQM07ELnaw0gZOvEdMcGjXquuUbgElgZWjhZhhu4gr27IF/+64y3Kf3
         y8dMJpKXR1xSZlH7KJMSHFE/MXmKQzYTM6n/DyJMDTf1W6mrUOVyUEmaLgPPRuxqzEAI
         MOCw==
X-Gm-Message-State: AFuF++n9FK4h4ggMJIja0DoYBoqxgOtm7nsPmWr1MoivpgINuBG1payw
	ORO7LAnEaf03fq7gs3gHdxnUmmHhQSyspZumpfqdmgiY8LFF8d/Ffp+Itvj+vg==
X-Gm-Gg: AYBFou3fNE8njl7c1Mzjtrv1eEe4hAQ6J62S6aQLOgiHb1M0lWeo9Z5MqA2xjpNN+Pq
	slXcK2Qu+z7awdl1lZkj3eEFtc+v9ILrqwSpYGb0qpannYV3bXcyYQbmaifRWD+wfYsfgvqNELM
	39h0Ls+RZ5Y4XphkNaDiL14mpOLYNmNicLeXb0Ff0ydH+rs3TcOZhcqPpmhh/H/HDR1C+ZKhfL9
	RKENfNE0tveU7cPRK6U9wTCBhFOVi0Q4PeArayy1O4hTpXiiVqctzcDG6WiPgMjVxsqCq11P64N
	BgA0AKqjTuPglGxrWsuw+/ozEAlr8LKH7vbBT0hGaynrBzwDHIopLs8+g7d6RAWkI3eXT0pTZeA
	p7HDivzG5B6NPklU4GNheyD2Exp4gk5zhKB8hI8BWaO60+jLygWQFjiF9jW8iaVOaI4HUewjQf7
	TLAFdwN2XngYtI0XmwLj39MFN209buCbEPU+4CT+GpDOe9+VuwCRXhzPUBQJVZkWJ9W1F6yJSwp
	rFLeJ8rpMd4+w==
X-Received: by 2002:a05:6820:1992:b0:6c4:50e0:4e0 with SMTP id 006d021491bc7-6ef0e5e401bmr1074380eaf.32.1791547216239;
        Fri, 09 Oct 2026 05:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6eef6e22b46sm1517278eaf.0.2026.10.09.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:14 -0700 (PDT)
Message-Id: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:07 +0000
Subject: [PATCH v2 0/6] [doc] Add new page on merge conflicts
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>

Handling merge conflicts is difficult, and currently Git's guidance on merge
conflicts isn't giving users the information they need to navigate the
process. As usual, the process I used to write this was to collect comments
from Git users on the existing documentation, and then address those issues.
I listed the specific issues we're aiming to solve in the first commit
message in the series.

This patch series introduces a new manual page, gitmergeconflicts, which
explains the process of explaining a merge conflict with examples. It also
links to that new page from the commands which can cause merge conflicts,
instead of trying to reexplain the process every time.

Changed in v2:

 * [x] Explain what a merge conflict is (thanks to Junio & Ben)
 * [x] rewrite the "ours" vs "theirs" section (thanks to Patrick for the
   comments)
 * [x] add git log --merge (thanks to Ben)
 * [x] Leave most of the content of git cherry-pick as-is, to make this
   patch set smaller (thanks to Junio)
 * [x] remove the SYNOPSIS since hopefully that won't be required anymore by
   the time this is merged
 * [x] Fix a typo in git revert (s/reverted conflict/reverted commit/)
 * [x] 's/the the/the/' (thanks to Patrick)
 * [x] s/[doc] Thing/doc: thing/ in commit messages (thanks to Tuomas)'
 * [x] squash the commit fixing the linter error (thanks to Junio)
 * [x] list reviewers in Reviewed-by

Some things that we discussed but stayed the same:

 * "git commit does the same thing as git merge --continue" seems to be true
   so we can leave it
 * Don't involve git am and git apply in this.
 * Junio suggested another diff3 example but I feel like there are already a
   lot of examples
 * We've still removed one mention of MERGE_HEAD in the git merge man page
   without replacing it. It's mentioned in other places though.

Thanks to Lobo, Adam Svahn, Louis Vanier, David Turner, Ben Zanin, Salih,
and about 12 others who gave feedback on both the original git merge man
page, as well as the proposed improvements.

Julia Evans (6):
  doc: add new gitmergeconflicts man page
  doc: git-merge: link to new merge conflicts guide
  doc: git-rebase: link to new merge conflicts guide
  doc: git-revert: link to new merge conflicts guide
  doc: git-cherry-pick: link to new merge conflicts guide
  doc: git-pull: link to new merge conflicts guide

 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/git-cherry-pick.adoc   |  11 +-
 Documentation/git-merge.adoc         | 125 +---------
 Documentation/git-pull.adoc          |   3 +-
 Documentation/git-rebase.adoc        |  13 +-
 Documentation/git-revert.adoc        |   5 +
 Documentation/gitmergeconflicts.adoc | 333 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 10 files changed, 362 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/gitmergeconflicts.adoc


base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2237%2Fjvns%2Fmerge-conflicts-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2237/jvns/merge-conflicts-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2237

Range-diff vs v1:

 1:  ad4853dc36 ! 1:  ab0344f947 [doc] Add new gitmergeconflicts man page
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] Add new gitmergeconflicts man page
     +    doc: add new gitmergeconflicts man page
      
          Introduce a new page, `gitmergeconflicts`, that explains the process of
          handling a merge conflict in a way that addresses the following issues,
     @@ Commit message
          interface between similar commands.
      
          Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
     +    Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     +    Reviewed-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     + ## .gitattributes ##
     +@@ .gitattributes: CODE_OF_CONDUCT.md -whitespace
     + /t/oid-info/* text eol=lf
     + /Documentation/git-merge.adoc conflict-marker-size=32
     + /Documentation/git-merge-file.adoc conflict-marker-size=32
     ++/Documentation/gitmergeconflicts.adoc conflict-marker-size=32
     + /Documentation/gitk.adoc conflict-marker-size=32
     + /Documentation/user-manual.adoc conflict-marker-size=32
     + /t/t????-*.sh conflict-marker-size=32
     +
       ## Documentation/Makefile ##
      @@ Documentation/Makefile: MAN7_TXT += gitdiffcore.adoc
       MAN7_TXT += giteveryday.adoc
     @@ Documentation/gitmergeconflicts.adoc (new)
      +----
      +gitmergeconflicts - Guide to handling merge conflicts
      +
     -+
     -+SYNOPSIS
     -+--------
     -+Guide to handling merge conflicts
     -+
     -+
      +DESCRIPTION
      +-----------
      +
     @@ Documentation/gitmergeconflicts.adoc (new)
      +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
      +  for how to find the command to run.
      +
     ++WHAT IS A MERGE CONFLICT?
     ++-------------------------
     ++
     ++When Git merges two commits together, it looks at the changes that
     ++each side has made and combines those changes. For example, if one side
     ++edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
     ++the same file, then it can easily combine them since there's no overlap.
     ++
     ++But if both sides edited overlapping lines of the same file (for example
     ++one side edited lines 1-5 and the other edited lines 3-6), Git will
     ++not try to guess how to combine those changes. This is called a "merge
     ++conflict".
     ++
     ++When this happens, Git shows you both sides' edits and asks you to pick
     ++how to resolve them. It:
     ++
     ++* Stages all of the files which were successfully merged
     ++* For the files with conflicts, it marks them as conflicted, puts both
     ++  sides' edits in the file, and leaves <<markers, merge conflict markers>>
     ++  that you need to resolve.
      +
      +[[markers]]
      +MERGE CONFLICT MARKERS
      +----------------------
      +
     -+Merge conflicts happen when both of the sides being merged edit the same
     -+area of a file. When this happens, Git will update the conflicted file
     ++When there's a merge conflict, Git will update the conflicted file
      +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
      +For example, here's a merge conflict where both sides edited a list of
      +fruits in different ways:
     @@ Documentation/gitmergeconflicts.adoc (new)
      +   below for how to find the command to run.
      ++
      +Note: During a `git merge`, `git commit` and `git merge --continue` do
     -+the the same thing.
     ++the same thing.
      +
      +
      +[[example]]
     @@ Documentation/gitmergeconflicts.adoc (new)
      +* You can set the configuration option `merge.conflictstyle=diff3`.
      +  See <<diff3,DIFF3 AND ZDIFF3>> below for more.
      +
     ++* `git log --merge -p <filename>`  will list all commits which
     ++  caused the merge conflict for `<filename>`, and the diff
     ++  of how they changed the file.
     ++
      +* Look at the original files.  `git show :1:filename` shows the
      +  common ancestor, `git show :2:filename` shows the "ours"
      +  version, and `git show :3:filename` shows the "theirs"
     @@ Documentation/gitmergeconflicts.adoc (new)
      +"OURS" AND "THEIRS"
      +-------------------
      +
     -+Git refers to the first part of a merge conflict (between `<<<<<<<`
     -+and `=======`) as "ours" and the second part (between `=======` and
     -+`>>>>>>>`) as "theirs".
     ++Sometimes during a merge conflict, Git will use the terms "ours" and
     ++"theirs" (or "us" and "them"). For example, `git status` might say that
     ++a file was `deleted by us`.
      +
     -+Normally, "ours" is the commit that was checked out before you started
     -+the merge, and "theirs" is the other commit.
     ++"Ours" and "theirs" are both commits: "ours" is the current
     ++`HEAD` commit, and "theirs" is the other side being merged.
      +
     -+But when the merge conflict was caused by a `git rebase`, it's the
     -+opposite: "theirs" is the commit that was checked out before you started
     -+the merge. This is because under the hood, `git rebase main` checks out
     -+the `main` commit first before doing the merge operation.
     ++The first part of a merge conflict (between `<<<<<<<` and `=======`) is
     ++from the "ours" side, and the second part (between `=======` and
     ++`>>>>>>>`) is from the "theirs" side.
     ++
     ++----
     ++FRUITS = [
     ++    "apple",
     ++<<<<<<< HEAD
     ++    "cherry",                      <- ours
     ++=======
     ++    "banana",                      <- theirs
     ++>>>>>>> add-fruit
     ++    "mango",
     ++    "orange",
     ++]
     ++----
     ++
     ++During a rebase, it can seem "upside down" because the "ours" commit is
     ++from the branch you're rebasing on (for instance `main` in `git rebase
     ++main`).
      +
      +These terms in Git all mean the same thing when dealing with a merge
      +conflict:
      +
     -+* "common ancestor", "base", and "stage 1"
     -+* "ours", "us", "stage 2", and `HEAD`
     -+* "theirs", "them", and "stage 3"
     ++* "common ancestor" and "base". The files from this commit are "in stage 1".
     ++* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
     ++* "theirs", "them". The files from this commit are "in stage 3".
     ++
     ++If you're confused about what something like "deleted by us" means, it's
     ++often easiest to use some of the tools from
     ++<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
     ++Finding the commit that deleted the file and seeing why is usually more
     ++helpful than trying to abstractly reason through what "us" means.
      +
      +[[automerge]]
     -+Example of using `AUTO_MERGE`
     ++EXAMPLE OF USING `AUTO_MERGE`
      +-----------------------------
      +
      +`git diff AUTO_MERGE` will show what changes you've made so far to
      +resolve conflicts. `AUTO_MERGE` is a reference that Git creates during a
      +merge. It contains the result of running the merge algorithm.
      +
     -+For example, if we resolved the conflict the way we did in the
     -+<<example,example above>>, the diff would look like this:
     ++For example, if we resolved the conflict by adding both "banana" and
     ++"cherry" in order, the diff would look like this:
      +
      +----
      + FRUITS = [
     @@ Documentation/gitmergeconflicts.adoc (new)
      ++    "cherry",
      +     "mango",
      +     "orange",
     -+]
     ++ ]
      +----
      +
      +[NOTE]
     @@ Documentation/meson.build: manpages = {
         'gitnamespaces.adoc' : 7,
         'gitremote-helpers.adoc' : 7,
         'gitrevisions.adoc' : 7,
     +
     + ## command-list.txt ##
     +@@ command-list.txt: githooks                                userinterfaces
     + gitignore                               userinterfaces
     + gitk                                    mainporcelain
     + gitmailmap                              userinterfaces
     ++gitmergeconflicts                       guide
     + gitmodules                              userinterfaces
     + gitnamespaces                           guide
     + gitprotocol-capabilities                developerinterfaces
 2:  a1686a2d82 ! 2:  d5241eb901 [doc] git-merge: link to new merge conflicts guide
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] git-merge: link to new merge conflicts guide
     +    doc: git-merge: link to new merge conflicts guide
      
          All of the info about merge conflicts has been moved to the new guide
      
 3:  128d69e482 ! 3:  72b1207045 [doc] git-rebase: link to new merge conflicts guide
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] git-rebase: link to new merge conflicts guide
     +    doc: git-rebase: link to new merge conflicts guide
      
          Remove some of the detail about how to handle a merge conflict, since
          it's explained in detail in the new guide, and there probably isn't
 4:  ab459231e0 ! 4:  cfa0a8254a [doc] git-revert: link to new merge conflicts guide
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] git-revert: link to new merge conflicts guide
     +    doc: git-revert: link to new merge conflicts guide
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-revert.adoc: both will discard uncommitted changes in your wor
       See "Reset, restore and revert" in linkgit:git[1] for the differences
       between the three commands.
       
     -+If there have been new commits since the reverted conflict, there may
     ++If there have been new commits since the reverted commit, there may
      +be a merge conflict. See linkgit:gitmergeconflicts[7]
      +(or `git help mergeconflicts`) for a guide to handling merge conflicts.
      +
 5:  03a6b43b58 ! 5:  62b70e9a02 [doc] git-cherry-pick: link to new merge conflicts guide
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] git-cherry-pick: link to new merge conflicts guide
     +    doc: git-cherry-pick: link to new merge conflicts guide
      
          Remove the discussion of merge conflicts and replace it with a link to
          the guide.
     @@ Documentation/git-cherry-pick.adoc: Given one or more existing commits, apply th
       
      -When it is not obvious how to apply a change, the following
      -happens:
     --
     --1. The current branch and `HEAD` pointer stay at the last commit
     --   successfully made.
     --2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
     --   introduced the change that is difficult to apply, unless the
     --   `--no-commit` option was given.
     --3. Paths in which the change applied cleanly are updated both
     --   in the index file and in your working tree.
     --4. For conflicting paths, the index file records up to three
     --   versions, as described in the "TRUE MERGE" section of
     --   linkgit:git-merge[1].  The working tree files will include
     --   a description of the conflict bracketed by the usual
     --   conflict markers `<<<<<<<` and `>>>>>>>`.
     --5. No other modifications are made.
     --
     --See linkgit:git-merge[1] for some hints on resolving such
     --conflicts.
      +When it is not obvious how to apply a change, there may
      +be a merge conflict. See linkgit:gitmergeconflicts[7]
      +(or `git help mergeconflicts`) for a guide to handling merge conflicts.
     ++
     ++When a merge conflict happens:
       
     + 1. The current branch and `HEAD` pointer stay at the last commit
     +    successfully made.
     +@@ Documentation/git-cherry-pick.adoc: happens:
     +    conflict markers `<<<<<<<` and `>>>>>>>`.
     + 5. No other modifications are made.
     + 
     +-See linkgit:git-merge[1] for some hints on resolving such
     +-conflicts.
     +-
       OPTIONS
       -------
     + <commit>...::
      @@ Documentation/git-cherry-pick.adoc: $ git cherry-pick -Xpatience topic^  <4>
       SEE ALSO
       --------
 6:  d3904f0ca7 ! 6:  ac77db6762 [doc] git-pull: link to new merge conflicts guide
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] git-pull: link to new merge conflicts guide
     +    doc: git-pull: link to new merge conflicts guide
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
 7:  4505fdc9a6 < -:  ---------- [doc] ignore conflict markers in gitmergeconflicts.adoc

-- 
gitgitgadget
