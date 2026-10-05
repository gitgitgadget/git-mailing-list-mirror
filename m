Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DC3314C3
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231618; cv=none; b=CGef2AncyiAWw+mJiFpWtIA18aEGiDLprAlNusOX9aV8ak/ccozqSs9D+ZWBmK0m+lZNHuFzXFMVRvmoZH9v/M1gq1CPLU+7Z1uLunwiD9al/g7nbvxixV2uWRpwJo36qqL+uDGe7t4HTsUPD39P2Y+2CZYEU1bqUpSEDlORvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231618; c=relaxed/simple;
	bh=0E62PQRt/AUCzfYRDyupK8XvsIYX+qjUsoxkfSjAmRs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SDbyWB/uY7/rCaohVA6mo6BwHTx1Qp6AgVTwpZjasLEUbtNl5RumI1UKlGZAUaPJcvLKoqf8CgqoQ0z6Z7K5GZcEABGB6FOIUOyplRu/EGyw+qgIMFqs5PQltb8uxIBcgiINDECZGdTH/Xuxc0OA4b21nESe9DMmPpyQYJTaJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elYWvmsF; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elYWvmsF"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3510f6f130bso1930129eec.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231615; x=1791836415; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t9e6gKNL5CusCDCLlCMj24hpPinl8QDAi8AAm0o4uxs=;
        b=elYWvmsFY97KUsuvT5ubo4xsal/TlOTSq0LMpj755i+aEeCUdT+XV9EBtZo1MRrSK8
         5l5y4b5UDWgH98035zulagIB6jGIoPth5oqQ+fxrsOuiKeD1xvLmL8ihhlkOxHeIEsLr
         Pb1UkEnhiSS6gsPGPYDezsiNBZ8duvj1MsIHFC0rbGT+G4wZEq7+b1Lmvf/Xz2RP9zCp
         fQZMAP94XGnPIvL8mnzBuuJ/0hpp5pJyzv491lpZ91KRYNVrdJjcPg08+2y+RuQ7qXij
         7iAgX9oO2B/vfGU5uoj1GUukhb1ZS2W4S0j7wpsCJ5Cjufh6coZ6mOAdBEFk2Ed+9GrB
         oYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231615; x=1791836415;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9e6gKNL5CusCDCLlCMj24hpPinl8QDAi8AAm0o4uxs=;
        b=HiuHZ71gQhHwtvZSaFJ9twX8hKj96SOpGCCJSLO1NraNGoCIwLs0gLkb4cVfb/HXe/
         Y4OUwn+peeaxJBzrnDGvVtAHmepe2sHNjbL4RAgqagx9sfBChxgyG7OntpFNGgrwLI4n
         28eA3jZqYuPyQucDby3091h+qJ1U1wfZTagkFK9ia5WgMv1GlTOc07WHWTXwk23hiB1z
         SY+e1ietaCJBEQ3nbptqt6MVCtepRF5JjRBzbrjXDdKfiNk45TTN0Xh47gCtQ+e9nwMy
         OZFscSEc1YxZ4KJMOIR6UdfUDcFY2Sc6XwXrWglVCaEDEtj9nsE+WNmey01ZwHTf129E
         yiKg==
X-Gm-Message-State: AFuF++nlY8zJyP74QxO9Er2r5cDV2EIwi/TBbHlDu4psNGTy75w24RIo
	cThYsaashv204s3LW1e5MyBaAuAPp35V/6kUJogwG1KFr9/5bCPRcLtN+Zb/ow==
X-Gm-Gg: AYBFou0UhPth5eG7z39vJBxpCgxJ2FYztjFsRTp4RuSZhiGORBEiFo43EphdowMM5XJ
	dEAj0MRtFMnS2DvtYeFLgzC0K4lk8/BJHWgPKOJhP9W4WQuJwyLPFzO+BgL7ZPVOX4MKYJCiYrM
	rQDUtWvx+8oe3tHta/x6FSIlhL+4G+tlHCOyeTNoSunjjBZMXMGVjUYHdvI5qiSjEG8UIVDYl8V
	vGdqgNhxeYrjMZWlCKs/XagetFOosjvd5L2RUITDIQY1ifjFL1O/m+A2o31nEd4A1BQmhOQvPM8
	vzfOS9NpbAzbBtYeiKfkcLn7R4ktXHZqnQ4nEri72k9PQ8nkJMY4AvCAqUTNywZxm4Xp8HXIcox
	JHuCu8HNyq7K/D1aopwqNTD+ESHZ7jjBMLQN9knki0M/CW7DfZRRzmv5DR6FgE/gEy3I7tHmX98
	l6PNQc3ahNkplDH4Dg74mR1bEkWlRARLMsGGZZkoJhszdVB8TZ8l5D3Isj4BmQhA9zb6NmtqKYk
	Wwaxdy4kg==
X-Received: by 2002:a05:7300:f3c5:b0:341:2466:2d68 with SMTP id 5a478bee46e88-34f219a4eb6mr13467922eec.38.1791231614356;
        Mon, 05 Oct 2026 13:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f5c6dsm861182eec.8.2026.10.05.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:20:13 -0700 (PDT)
Message-Id: <5fd36f91f086bbff929b267c6d74ebc822951da3.1791231610.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Oct 2026 20:20:09 +0000
Subject: [PATCH v2 1/2] doc: remove gittutorial-2
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
Cc: Tuomas Ahola <taahol@utu.fi>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

It hasn't been substantially updated for 20 years
(see `git diff e31952da5c52a4c1:Documentation/tutorial-2.txt
               0f8e75abebff0877:Documentation/gittutorial-2.adoc`)
and it's becoming out of date, for example:

- refs do not necessarily live in `.git/refs`
- we don't really call it "the index file" anymore, and we don't
  encourage users to think about the individual files in `.git` as much
  as we did 20 years ago

More importantly, this approach of introducing Git by learning about the
contents of `.git` does not work for most people learning Git for the
first time. It's interesting information for some people (maybe more
advanced users or folks with a strong computer science background, for
not appropriate for a general tutorial).

Right now `gittutorial-2` is meant to be a logical sequel to
`gittutorial` ("read gittutorial, then gittutorial-2").
Deleting `gittutorial-2` means that we can more easily rewrite the main
`gittutorial` (which is also not effective) in any way we want, without
having to make sure that `gittutorial-2` is the logical next step.

We have other documentation which can serve a similar purpose to
tutorial-2 and isn't framed as a general tutorial appropriate for
everyone.

Keep building the man page for now and leave behind a stub to
redirect folks to those other documents.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/gittutorial-2.adoc | 422 +------------------------------
 1 file changed, 6 insertions(+), 416 deletions(-)

diff --git a/Documentation/gittutorial-2.adoc b/Documentation/gittutorial-2.adoc
index 8bdb7d0bd3..6396e763c4 100644
--- a/Documentation/gittutorial-2.adoc
+++ b/Documentation/gittutorial-2.adoc
@@ -3,7 +3,7 @@ gittutorial-2(7)
 
 NAME
 ----
-gittutorial-2 - A tutorial introduction to Git: part two
+gittutorial-2 - Obsolete tutorial
 
 SYNOPSIS
 --------
@@ -13,423 +13,13 @@ git *
 DESCRIPTION
 -----------
 
-You should work through linkgit:gittutorial[7] before reading this tutorial.
+This tutorial has been deleted since it had become very stale.
 
-The goal of this tutorial is to introduce two fundamental pieces of
-Git's architecture--the object database and the index file--and to
-provide the reader with everything necessary to understand the rest
-of the Git documentation.
+See linkgit:gitdatamodel[7] for an explanation of how Git's core data
+structures work (objects, references and the index).
 
-The Git object database
------------------------
-
-Let's start a new project and create a small amount of history:
-
-------------------------------------------------
-$ mkdir test-project
-$ cd test-project
-$ git init
-Initialized empty Git repository in .git/
-$ echo 'hello world' > file.txt
-$ git add .
-$ git commit -a -m "initial commit"
-[master (root-commit) 54196cc] initial commit
- 1 file changed, 1 insertion(+)
- create mode 100644 file.txt
-$ echo 'hello world!' >file.txt
-$ git commit -a -m "add emphasis"
-[master c4d59f3] add emphasis
- 1 file changed, 1 insertion(+), 1 deletion(-)
-------------------------------------------------
-
-What are the 7 digits of hex that Git responded to the commit with?
-
-We saw in part one of the tutorial that commits have names like this.
-It turns out that every object in the Git history is stored under
-a 40-digit hex name.  That name is the SHA-1 hash of the object's
-contents; among other things, this ensures that Git will never store
-the same data twice (since identical data is given an identical SHA-1
-name), and that the contents of a Git object will never change (since
-that would change the object's name as well). The 7 char hex strings
-here are simply the abbreviation of such 40 character long strings.
-Abbreviations can be used everywhere where the 40 character strings
-can be used, so long as they are unambiguous.
-
-It is expected that the content of the commit object you created while
-following the example above generates a different SHA-1 hash than
-the one shown above because the commit object records the time when
-it was created and the name of the person performing the commit.
-
-We can ask Git about this particular object with the `cat-file`
-command. Don't copy the 40 hex digits from this example but use those
-from your own version. Note that you can shorten it to only a few
-characters to save yourself typing all 40 hex digits:
-
-------------------------------------------------
-$ git cat-file -t 54196cc2
-commit
-$ git cat-file commit 54196cc2
-tree 92b8b694ffb1675e5975148e1121810081dbdffe
-author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
-committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
-
-initial commit
-------------------------------------------------
-
-A tree can refer to one or more "blob" objects, each corresponding to
-a file.  In addition, a tree can also refer to other tree objects,
-thus creating a directory hierarchy.  You can examine the contents of
-any tree using ls-tree (remember that a long enough initial portion
-of the SHA-1 will also work):
-
-------------------------------------------------
-$ git ls-tree 92b8b694
-100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad    file.txt
-------------------------------------------------
-
-Thus we see that this tree has one file in it.  The SHA-1 hash is a
-reference to that file's data:
-
-------------------------------------------------
-$ git cat-file -t 3b18e512
-blob
-------------------------------------------------
-
-A "blob" is just file data, which we can also examine with cat-file:
-
-------------------------------------------------
-$ git cat-file blob 3b18e512
-hello world
-------------------------------------------------
-
-Note that this is the old file data; so the object that Git named in
-its response to the initial tree was a tree with a snapshot of the
-directory state that was recorded by the first commit.
-
-All of these objects are stored under their SHA-1 names inside the Git
-directory:
-
-------------------------------------------------
-$ find .git/objects/
-.git/objects/
-.git/objects/pack
-.git/objects/info
-.git/objects/3b
-.git/objects/3b/18e512dba79e4c8300dd08aeb37f8e728b8dad
-.git/objects/92
-.git/objects/92/b8b694ffb1675e5975148e1121810081dbdffe
-.git/objects/54
-.git/objects/54/196cc2703dc165cbd373a65a4dcf22d50ae7f7
-.git/objects/a0
-.git/objects/a0/423896973644771497bdc03eb99d5281615b51
-.git/objects/d0
-.git/objects/d0/492b368b66bdabf2ac1fd8c92b39d3db916e59
-.git/objects/c4
-.git/objects/c4/d59f390b9cfd4318117afde11d601c1085f241
-------------------------------------------------
-
-and the contents of these files is just the compressed data plus a
-header identifying their length and their type.  The type is either a
-blob, a tree, a commit, or a tag.
-
-The simplest commit to find is the HEAD commit, which we can find
-from .git/HEAD:
-
-------------------------------------------------
-$ cat .git/HEAD
-ref: refs/heads/master
-------------------------------------------------
-
-As you can see, this tells us which branch we're currently on, and it
-tells us this by naming a file under the .git directory, which itself
-contains a SHA-1 name referring to a commit object, which we can
-examine with cat-file:
-
-------------------------------------------------
-$ cat .git/refs/heads/master
-c4d59f390b9cfd4318117afde11d601c1085f241
-$ git cat-file -t c4d59f39
-commit
-$ git cat-file commit c4d59f39
-tree d0492b368b66bdabf2ac1fd8c92b39d3db916e59
-parent 54196cc2703dc165cbd373a65a4dcf22d50ae7f7
-author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143418702 -0500
-committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143418702 -0500
-
-add emphasis
-------------------------------------------------
-
-The "tree" object here refers to the new state of the tree:
-
-------------------------------------------------
-$ git ls-tree d0492b36
-100644 blob a0423896973644771497bdc03eb99d5281615b51    file.txt
-$ git cat-file blob a0423896
-hello world!
-------------------------------------------------
-
-and the "parent" object refers to the previous commit:
-
-------------------------------------------------
-$ git cat-file commit 54196cc2
-tree 92b8b694ffb1675e5975148e1121810081dbdffe
-author J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
-committer J. Bruce Fields <bfields@puzzle.fieldses.org> 1143414668 -0500
-
-initial commit
-------------------------------------------------
-
-The tree object is the tree we examined first, and this commit is
-unusual in that it lacks any parent.
-
-Most commits have only one parent, but it is also common for a commit
-to have multiple parents.   In that case the commit represents a
-merge, with the parent references pointing to the heads of the merged
-branches.
-
-Besides blobs, trees, and commits, the only remaining type of object
-is a "tag", which we won't discuss here; refer to linkgit:git-tag[1]
-for details.
-
-So now we know how Git uses the object database to represent a
-project's history:
-
-  * "commit" objects refer to "tree" objects representing the
-    snapshot of a directory tree at a particular point in the
-    history, and refer to "parent" commits to show how they're
-    connected into the project history.
-  * "tree" objects represent the state of a single directory,
-    associating directory names to "blob" objects containing file
-    data and "tree" objects containing subdirectory information.
-  * "blob" objects contain file data without any other structure.
-  * References to commit objects at the head of each branch are
-    stored in files under .git/refs/heads/.
-  * The name of the current branch is stored in .git/HEAD.
-
-Note, by the way, that lots of commands take a tree as an argument.
-But as we can see above, a tree can be referred to in many different
-ways--by the SHA-1 name for that tree, by the name of a commit that
-refers to the tree, by the name of a branch whose head refers to that
-tree, etc.--and most such commands can accept any of these names.
-
-In command synopses, the word "tree-ish" is sometimes used to
-designate such an argument.
-
-The index file
---------------
-
-The primary tool we've been using to create commits is `git-commit
--a`, which creates a commit including every change you've made to
-your working tree.  But what if you want to commit changes only to
-certain files?  Or only certain changes to certain files?
-
-If we look at the way commits are created under the cover, we'll see
-that there are more flexible ways creating commits.
-
-Continuing with our test-project, let's modify file.txt again:
-
-------------------------------------------------
-$ echo "hello world, again" >>file.txt
-------------------------------------------------
-
-but this time instead of immediately making the commit, let's take an
-intermediate step, and ask for diffs along the way to keep track of
-what's happening:
-
-------------------------------------------------
-$ git diff
---- a/file.txt
-+++ b/file.txt
-@@ -1 +1,2 @@
- hello world!
-+hello world, again
-$ git add file.txt
-$ git diff
-------------------------------------------------
-
-The last diff is empty, but no new commits have been made, and the
-head still doesn't contain the new line:
-
-------------------------------------------------
-$ git diff HEAD
-diff --git a/file.txt b/file.txt
-index a042389..513feba 100644
---- a/file.txt
-+++ b/file.txt
-@@ -1 +1,2 @@
- hello world!
-+hello world, again
-------------------------------------------------
-
-So 'git diff' is comparing against something other than the head.
-The thing that it's comparing against is actually the index file,
-which is stored in .git/index in a binary format, but whose contents
-we can examine with ls-files:
-
-------------------------------------------------
-$ git ls-files --stage
-100644 513feba2e53ebbd2532419ded848ba19de88ba00 0       file.txt
-$ git cat-file -t 513feba2
-blob
-$ git cat-file blob 513feba2
-hello world!
-hello world, again
-------------------------------------------------
-
-So what our 'git add' did was store a new blob and then put
-a reference to it in the index file.  If we modify the file again,
-we'll see that the new modifications are reflected in the 'git diff'
-output:
-
-------------------------------------------------
-$ echo 'again?' >>file.txt
-$ git diff
-index 513feba..ba3da7b 100644
---- a/file.txt
-+++ b/file.txt
-@@ -1,2 +1,3 @@
- hello world!
- hello world, again
-+again?
-------------------------------------------------
-
-With the right arguments, 'git diff' can also show us the difference
-between the working directory and the last commit, or between the
-index and the last commit:
-
-------------------------------------------------
-$ git diff HEAD
-diff --git a/file.txt b/file.txt
-index a042389..ba3da7b 100644
---- a/file.txt
-+++ b/file.txt
-@@ -1 +1,3 @@
- hello world!
-+hello world, again
-+again?
-$ git diff --cached
-diff --git a/file.txt b/file.txt
-index a042389..513feba 100644
---- a/file.txt
-+++ b/file.txt
-@@ -1 +1,2 @@
- hello world!
-+hello world, again
-------------------------------------------------
-
-At any time, we can create a new commit using 'git commit' (without
-the "-a" option), and verify that the state committed only includes the
-changes stored in the index file, not the additional change that is
-still only in our working tree:
-
-------------------------------------------------
-$ git commit -m "repeat"
-$ git diff HEAD
-diff --git a/file.txt b/file.txt
-index 513feba..ba3da7b 100644
---- a/file.txt
-+++ b/file.txt
-@@ -1,2 +1,3 @@
- hello world!
- hello world, again
-+again?
-------------------------------------------------
-
-So by default 'git commit' uses the index to create the commit, not
-the working tree; the "-a" option to commit tells it to first update
-the index with all changes in the working tree.
-
-Finally, it's worth looking at the effect of 'git add' on the index
-file:
-
-------------------------------------------------
-$ echo "goodbye, world" >closing.txt
-$ git add closing.txt
-------------------------------------------------
-
-The effect of the 'git add' was to add one entry to the index file:
-
-------------------------------------------------
-$ git ls-files --stage
-100644 8b9743b20d4b15be3955fc8d5cd2b09cd2336138 0       closing.txt
-100644 513feba2e53ebbd2532419ded848ba19de88ba00 0       file.txt
-------------------------------------------------
-
-And, as you can see with cat-file, this new entry refers to the
-current contents of the file:
-
-------------------------------------------------
-$ git cat-file blob 8b9743b2
-goodbye, world
-------------------------------------------------
-
-The "status" command is a useful way to get a quick summary of the
-situation:
-
-------------------------------------------------
-$ git status
-On branch master
-Changes to be committed:
-  (use "git restore --staged <file>..." to unstage)
-
-	new file:   closing.txt
-
-Changes not staged for commit:
-  (use "git add <file>..." to update what will be committed)
-  (use "git restore <file>..." to discard changes in working directory)
-
-	modified:   file.txt
-
-------------------------------------------------
-
-Since the current state of closing.txt is cached in the index file,
-it is listed as "Changes to be committed".  Since file.txt has
-changes in the working directory that aren't reflected in the index,
-it is marked "changed but not updated".  At this point, running "git
-commit" would create a commit that added closing.txt (with its new
-contents), but that didn't modify file.txt.
-
-Also, note that a bare `git diff` shows the changes to file.txt, but
-not the addition of closing.txt, because the version of closing.txt
-in the index file is identical to the one in the working directory.
-
-In addition to being the staging area for new commits, the index file
-is also populated from the object database when checking out a
-branch, and is used to hold the trees involved in a merge operation.
-See linkgit:gitcore-tutorial[7] and the relevant man
-pages for details.
-
-What next?
-----------
-
-At this point you should know everything necessary to read the man
-pages for any of the git commands; one good place to start would be
-with the commands mentioned in linkgit:giteveryday[7].  You
-should be able to find any unknown jargon in linkgit:gitglossary[7].
-
-The link:user-manual.html[Git User's Manual] provides a more
-comprehensive introduction to Git.
-
-linkgit:gitcvs-migration[7] explains how to
-import a CVS repository into Git, and shows how to use Git in a
-CVS-like way.
-
-For some interesting examples of Git use, see the
-link:howto-index.html[howtos].
-
-For Git developers, linkgit:gitcore-tutorial[7] goes
-into detail on the lower-level Git mechanisms involved in, for
-example, creating a new commit.
-
-SEE ALSO
---------
-linkgit:gittutorial[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
-linkgit:git-help[1],
-linkgit:giteveryday[7],
-link:user-manual.html[The Git User's Manual]
+See linkgit:gitcore-tutorial[7] for a practical tutorial on how to
+explore Git's internals.
 
 GIT
 ---
-- 
gitgitgadget

