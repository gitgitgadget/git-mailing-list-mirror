Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385B23A989
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512881; cv=none; b=ERcSjLMSVkJFg4ft4fIHR5Fmzd4pT9B9fLXUxgfOc2RTOcTWAP76wadswWPA6Agw0oXXxvE8xwn+ZrI9KI2ZBcFqnTHx41pmMOAHHuaJbyFCEoZS2GyKBdwrRrRHZY60R6S4TdGxhYDp7Z+A1wBAV4TjoUDsgQVNvm4nWvNCRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512881; c=relaxed/simple;
	bh=TvLw5qasmlpJKlJcqCf0AHPLDFGXCJE0yvVNSoZ6Of4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=oGAk2W8rqOUrUbZosUdM3EjkkruODqTE2cKlfErzrfAJmYazib3YfuMUhK5rfSpwilqEDl8tmaN+ty6ItZ+Kg3Ls4vw6U1boG5JGkOYb2ltvlmo/Rvynt5Tvt2owlbx8vH30u5FlMWVL2f+Zxf1RRjF9kkPVmh4jlSZASIYgkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0DixxnZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0DixxnZ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8571a0947d1so261910685a.0
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512878; x=1760117678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hYBRUhXBCmr2JFlQmC+RIt0T5bHSZUF5Nbs7UY5EouY=;
        b=f0DixxnZfqUPXVxtfKv3Ep2JsFMPJk+b/Z+o+MPakMQx7T8qp5Qr76az2zxIpbUoRF
         l5hrvtTTal0uvJzT5kbA1eBEvGCYXCNVgJfClaC+HeeSGrdq5yIrHoB8MJOwmhLJUXSA
         pBe7PYx39oR6w7JXAKLY0F+UvxuAdT23QfwQDqSPTXM079B5lzzzKQIG57WkkVEckc5V
         NDZ6lzzwlvtDFpzyPSeuppcA9d/iwng3l6ko2gif70dn5gT9+qLDbIPBmHrxIOQF/NvI
         oEna6ry8DBKVGvncU3QBmxddCcsLuh6SC0Me+bYrc3nKmW9zBWR25HDC7b/gUJvfFUQd
         Kkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512878; x=1760117678;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYBRUhXBCmr2JFlQmC+RIt0T5bHSZUF5Nbs7UY5EouY=;
        b=Bm7Bkfy2pLArPRb/W4RC7AkwdT2Nd6+LlouKK4TJkJk/lnN+35hZvnGKyoe/3wKRpA
         TYPrrCEQTlO7wVJd/6YJ2gN7Vu2SUcdYQu0Xoy5sG8nkl45gUByqsFUA2a9j/eO1ZbU9
         WPTHQmBRxCEvmMKJlZMigyq4ndB6iX3LyIeuZF0sypzoL209KolB88jNAWaIN3Vjh9Gx
         iu1f9GVCzVhYGmVOwgcmkJ0E1/Uf9Fk0lmbpiYhDu+G62Y/q0eBiJlai1sUA7zvdFiYY
         kyggB5sdw0tUhxLW50/VPQvqbr/grKVv1l30HqjZ5SW3DbYNw77v54Gu2vGdwF8JtNol
         gy+w==
X-Gm-Message-State: AOJu0YxunSA+BGathTWCl476nDbbaB1pV0v/Gwao+OiXoJ/uCTQg3Og3
	vyEZnOfsaGBfrZa1WLa1kd7ybBmLBa5ssSSQrJzFDq2mXb6GIQSoKYPy1NzWtQ==
X-Gm-Gg: ASbGncsb3baPWn3DTF/2QYWaaWyuINRl1DPbxHSGEayNrYq/dfsqv53dBizrokA+UTx
	auCC/EX/yPnxJmSQ7wlOgc6rF5q3h9no0zHp4JFucDPKhom7T2ZFCotD0aabXtvsMlpIH5xh3YK
	sRfE1qXSlBbhKdqQjW15hOrf8CWDnYKiW3AWB082CdX/NSSNdWrXZytkyfQoINdGrhHN3XilWye
	GMTM+X/+sej2jrVAPL9bG32CsvNRjkZdjVDtSGr7RqjE8kUnrS7BITm4VKTHNxD4bRNS6uwk+mN
	0Frkhlgvrdh7N6ICn+Fa6k9cz4ugc2KeUeeEHjJxEFj8UIBxoSgSWcQHN7lqzr640kOZo5/L5XY
	whYgg7d/HZnx1wwyoUN29lZnPGqcWl06fIa8wZQhd2Sd0IQ==
X-Google-Smtp-Source: AGHT+IHlb2UW4jJ63YqD9P1NtUnUzWLnyCbj5O6fwYYwMw60xQL+318PH0mJfiNowWxwM43rJdsZtQ==
X-Received: by 2002:a05:620a:191d:b0:864:8707:edb with SMTP id af79cd13be357-8776b713391mr1127419485a.24.1759512877499;
        Fri, 03 Oct 2025 10:34:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877787451c5sm467782285a.33.2025.10.03.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:34:36 -0700 (PDT)
Message-Id: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Oct 2025 17:34:36 +0000
Subject: [PATCH] doc: add a explanation of Git's data model
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Git very often uses the terms "object", "reference", or "index" in its
documentation.

However, it's hard to find a clear explanation of these terms and how
they relate to each other in the documentation. The closest candidates
currently are:

1. `gitglossary`. This makes a good effort, but it's an alphabetically
    ordered dictionary and a dictionary is not a good way to learn
    concepts. You have to jump around too much and it's not possible to
    present the concepts in the order that they should be explained.
2. `gitcore-tutorial`. This explains how to use the "core" Git commands.
   This is a nice document to have, but it's not necessary to learn how
   `update-index` works to understand Git's data model, and we should
   not be requiring users to learn how to use the "plumbing" commands
   if they want to learn what the term "index" or "object" means.
3. `gitrepository-layout`. This is a great resource, but it includes a
   lot of information about configuration and internal implementation
   details which are not related to the data model. It also does
   not explain how commits work.

The result of this is that Git users (even users who have been using
Git for 15+ years) struggle to read the documentation because they don't
know what the core terms mean, and it's not possible to add links
to help them learn more.

Add an explanation of Git's data model. Some choices I've made in
deciding what "core data model" means:

1. Omit pseudorefs like `FETCH_HEAD`, because it's not clear to me
   if those are intended to be user facing or if they're more like
   internal implementation details.
2. Don't talk about submodules other than by mentioning how they
   relate to trees. This is because Git has a lot of special features,
   and explaining how they all work exhaustively could quickly go
   down a rabbit hole which would make this document less useful for
   understanding Git's core behaviour.
3. Don't discuss the structure of a commit message
   (first line, trailers, GPG signatures, etc).
   Perhaps this should change.

Some other choices I've made:

1. Mention packed refs only in a note.
2. Don't mention that the full name of the branch `main` is
   technically `refs/heads/main`. This should likely change but I
   haven't worked out how to do it in a clear way yet.
3. Mostly avoid referring to the `.git` directory, because the exact
   details of how things are stored change over time.
   This should perhaps change from "mostly" to "entirely"
   but I haven't worked out how to do that in a clear way yet.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: Add a explanation of Git's data model

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1981%2Fjvns%2Fgitdatamodel-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1981/jvns/gitdatamodel-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1981

 Documentation/Makefile          |   1 +
 Documentation/gitdatamodel.adoc | 226 ++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 Documentation/gitdatamodel.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..5f4acfacbd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -52,6 +52,7 @@ MAN7_TXT += gitcli.adoc
 MAN7_TXT += gitcore-tutorial.adoc
 MAN7_TXT += gitcredentials.adoc
 MAN7_TXT += gitcvs-migration.adoc
+MAN7_TXT += gitdatamodel.adoc
 MAN7_TXT += gitdiffcore.adoc
 MAN7_TXT += giteveryday.adoc
 MAN7_TXT += gitfaq.adoc
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
new file mode 100644
index 0000000000..4b2cb167dc
--- /dev/null
+++ b/Documentation/gitdatamodel.adoc
@@ -0,0 +1,226 @@
+gitdatamodel(7)
+===============
+
+NAME
+----
+gitdatamodel - Git's core data model
+
+DESCRIPTION
+-----------
+
+It's not necessary to understand Git's data model to use Git, but it's
+very helpful when reading Git's documentation so that you know what it
+means when the documentation says "object" "reference" or "index".
+
+Git's core operations use 4 kinds of data:
+
+1. <<objects,Objects>>: commits, trees, blobs, and tag objects
+2. <<references,References>>: branches, tags,
+   remote-tracking branches, etc
+3. <<index,The index>>, also known as the staging area
+4. <<reflogs,Reflogs>>
+
+[[objects]]
+OBJECTS
+-------
+
+Commits, trees, blobs, and tag objects are all stored in Git's object database.
+Every object has:
+
+1. an *ID*, which is the SHA-1 hash of its contents.
+  It's fast to look up a Git object using its ID.
+  The ID is usually represented in hexadecimal, like
+  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
+2. a *type*. There are 4 types of objects:
+   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
+   and <<tag-object,tag objects>>.
+3. *contents*. The structure of the contents depends on the type.
+
+Once an object is created, it can never be changed.
+Here are the 4 types of objects:
+
+[[commit]]
+commits::
+    A commit contains:
++
+1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
+  regular commits have 1 parent, merge commits have 2+ parents
+2. A *commit message*
+3. All the *files* in the commit, stored as a *<<tree,tree>>*
+4. An *author* and the time the commit was authored
+5. A *committer* and the time the commit was committed
++
+Here's how an example commit is stored:
++
+----
+tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
+parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
+author Maya <maya@example.com> 1759173425 -0400
+committer Maya <maya@example.com> 1759173425 -0400
+
+Add README
+----
++
+Like all other objects, commits can never be changed after they're created.
+For example, "amending" a commit with `git commit --amend` creates a new commit.
+The old commit will eventually be deleted by `git gc`.
+
+[[tree]]
+trees::
+    A tree is how Git represents a directory. It lists, for each item in
+    the tree:
++
+1. The *permissions*, for example `100644`
+2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
+  or <<commit,`commit`>> (a Git submodule)
+3. The *object ID*
+4. The *filename*
++
+For example, this is how a tree containing one directory (`src`) and one file
+(`README.md`) is stored:
++
+----
+100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
+040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
+----
++
+*NOTE:* The permissions are in the same format as UNIX permissions, but
+the only allowed permissions for files (blobs) are 644 and 755.
+
+[[blob]]
+blobs::
+    A blob is how Git represents a file. A blob object contains the
+    file's contents.
++
+Storing a new blob for every new version of a file can get big, so
+`git gc` periodically compresses objects for efficiency in `.git/objects/pack`.
+
+[[tag-object]]
+tag objects::
+    Tag objects (also known as "annotated tags") contain:
++
+1. The *tagger* and tag date
+2. A *tag message*, similar to a commit message
+3. The *ID* of the object (often a commit) that they reference
+
+[[references]]
+REFERENCES
+----------
+
+References are a way to give a name to a commit.
+It's easier to remember "the changes I'm working on are on the `turtle`
+branch" than "the changes are in commit bb69721404348e".
+Git often uses "ref" as shorthand for "reference".
+
+References that you create are stored in the `.git/refs` directory,
+and Git has a few special internal references like `HEAD` that are stored
+in the base `.git` directory.
+
+References can either be:
+
+1. References to an object ID, usually a <<commit,commit>> ID
+2. References to another reference. This is called a "symbolic reference".
+
+Git handles references differently based on which subdirectory of
+`.git/refs` they're stored in.
+Here are the main types:
+
+[[branch]]
+branches: `.git/refs/heads/<name>`::
+    A branch is a name for a commit ID.
+    That commit is the latest commit on the branch.
+    Branches are stored in the `.git/refs/heads/` directory.
++
+To get the history of commits on a branch, Git will start at the commit
+ID the branch references, and then look at the commit's parent(s),
+the parent's parent, etc.
+
+[[tag]]
+tags: `.git/refs/tags/<name>`::
+    A tag is a name for a commit ID, tag object ID, or other object ID.
+    Tags are stored in the `refs/tags/` directory.
++
+Even though branches and commits are both "a name for a commit ID", Git
+treats them very differently.
+Branches are expected to be regularly updated as you work on the branch,
+but it's expected that a tag will never change after you create it.
+
+[[HEAD]]
+HEAD: `.git/HEAD`::
+    `HEAD` is where Git stores your current <<branch,branch>>.
+    `HEAD` is normally a symbolic reference to your current branch, for
+    example `ref: refs/heads/main` if your current branch is `main`.
+    `HEAD` can also be a direct reference to a commit ID,
+    that's called "detached HEAD state".
+
+[[remote-tracking-branch]]
+remote tracking branches: `.git/refs/remotes/<remote>/<branch>`::
+    A remote-tracking branch is a name for a commit ID.
+    It's how Git stores the last-known state of a branch in a remote
+    repository. `git fetch` updates remote-tracking branches. When
+    `git status` says "you're up to date with origin/main", it's looking at
+    this.
+
+[[other-refs]]
+Other references::
+    Git tools may create references in any subdirectory of `.git/refs`.
+    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
+    and linkgit:git-notes[1] all create their own references
+    in `.git/refs/stash`, `.git/refs/bisect`, etc.
+    Third-party Git tools may also create their own references.
++
+Git may also create references in the base `.git` directory
+other than `HEAD`, like `ORIG_HEAD`.
+
+*NOTE:* As an optimization, references may be stored as packed
+refs instead of in `.git/refs`. See linkgit:git-pack-refs[1].
+
+[[index]]
+THE INDEX
+---------
+
+The index, also known as the "staging area", contains the current staged
+version of every file in your Git repository. When you commit, the files
+in the index are used as the files in the next commit.
+
+Unlike a tree, the index is a flat list of files.
+Each index entry has 4 fields:
+
+1. The *permissions*
+2. The *<<blob,blob>> ID* of the file
+3. The *filename*
+4. The *number*. This is normally 0, but if there's a merge conflict
+   there can be multiple versions (with numbers 0, 1, 2, ..)
+   of the same filename in the index.
+
+It's extremely uncommon to look at the index directly: normally you'd
+run `git status` to see a list of changes between the index and <<HEAD,HEAD>>.
+But you can use `git ls-files --stage` to see the index.
+Here's the output of `git ls-files --stage` in a repository with 2 files:
+
+----
+100644 8728a858d9d21a8c78488c8b4e70e531b659141f 0 README.md
+100644 665c637a360874ce43bf74018768a96d2d4d219a 0 src/hello.py
+----
+
+[[reflogs]]
+REFLOGS
+-------
+
+Git stores the history of branch, tag, and HEAD refs in a reflog
+(you should read "reflog" as "ref log"). Not every ref is logged by
+default, but any ref can be logged.
+
+Each reflog entry has:
+
+1. *Before/after *commit IDs*
+2. *User* who made the change, for example `Maya <maya@example.com>`
+3. *Timestamp*
+4. *Log message*, for example `pull: Fast-forward`
+
+Reflogs only log changes made in your local repository.
+They are not shared with remotes.
+
+GIT
+---
+Part of the linkgit:git[1] suite

base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
-- 
gitgitgadget
