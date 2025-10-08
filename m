Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BF16F288
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931627; cv=none; b=fesx8QsIMRp1wLSCbr6hu0I+rKMQsRfxMzL4EG9mABrZM64skS+PoYikIebJxtaSj2rv615J8ETTlM78egzBQVAJi7hJnLc8UM+Aq2h/SORxMSgGexQFIzDLIIvQYY1KhuPiY6fMoh2P3PmmPbG7vDOZ7nNY54YIYweUS7yElwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931627; c=relaxed/simple;
	bh=grlNuOuSEmxLjX4EKs5vV5SAYNXNF1jJ3k5jRXx+9gs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fxPU9LlokaQ5ndR5DNN7//4EoO+tP+InF0FeWE+nbb2AwiOqaqTnvKMMlHT1GQFpSxKk639gBAP814HaXsiuXtTcDsTmm+evIQBkIQ3kd5H5vDYNmAV0lseOJ9ymYzKtIHHoH3uZm9LOsqRlj7jVre+K/bnG0qNFcdOhhiRn3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzojydMM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzojydMM"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781010ff051so5282868b3a.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759931623; x=1760536423; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+gzvwzJ1JKWPQJut/A0pULx8tHmnzLuJIQjEpOWKl0=;
        b=SzojydMM+riWZ0Jc8QDm8bUNRR4zku9Lo9uano4to5HV8WnjJDyXcmJ2pP/qVj2hFT
         UTqbIX5/urPz1QBuWazaEVsz9e8uo0JHS0g/6u8tycC8/sWQi7w8NKI76ew4E/4+bYCu
         +7PtAK0nxffuNkhiUT3EF7kS11ijF5v1Ormkb2trywX29FH9IMQz9bowHvBDjptej7S6
         muvJSSmO21LXGbXA/0TH9yC/nQMYgNHUQ8J0InttB9hnxFpHQJBdLj3hh34Qo/j71vG/
         WkaCu3/j5Pcw5XUplUqZBVs5LsAqM5KAc17KrZwiV6J3ecvhwmfwMALVE7P8S3QNbdUd
         PNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931623; x=1760536423;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+gzvwzJ1JKWPQJut/A0pULx8tHmnzLuJIQjEpOWKl0=;
        b=Eg9DNaaOchcY/OTrjzUTQXP83fWpO87ZV9oRcc9DJhF1wfHc3d80vb9qEFv/spHTEI
         YBfH4OHKdzBQ3FGL896uPwiXdoahDbw1PVPjVr7FamL3CpM/pigbcZQlEICpD3zvCte1
         uNIpn5OVHpTrttYs4eZGfPqZZ0dTNH+G7nVm7UUcd0lw7M4YzYwFTgGvAy/UyjCEMQ6q
         G0iDljSmN9giNQKvFpry1yFnvHXCX7TMB3ouZrR2a6sMtbBKzCgqiKcgEJxTkN5D5KaS
         ueoUsOLk09GTFyOcWNZ7X2Gg0YWNGQqywdxp4syuSAlGs+cgmllCbLld9XjS/wPbQ5hY
         CENA==
X-Gm-Message-State: AOJu0YwPUOy7xeHU2M/cKGiF6I7UsYHPW5BvHBWc2U3/6fZQ94iv/rPG
	bhZIfz+q6+Sn9gqvQM/sKUGPrBagUdJjpaCoA/34xoHV+DUM+0v0FrLj87m4yA==
X-Gm-Gg: ASbGncuOWEJW2iBpRqfI1mr5SYB6GWjHD/g1UXUMVCzbZx6CU5GylaFdSl5fWZrAlZM
	SUWqj8TerRQGBalaC9XVf6q55BSAwHJ/zAfRObbFOEDSWzhPzUWBFNx5qOYlG3Mamb3jAYyEeDY
	7v33ARTZyJnkwvg928hM/1UcT6HJzMatqWz/6bpLwdBpWLLmFkAxq3SKAv0shAgKIms0vGv35m3
	BT8+gWJsYQ2orqiWrAGlk/0lzCRtggYET9+zeJrvO+BMjylO6aiVU67xVst92kM8Anu2Nm1I5sB
	JBaDtYXakVX48YshvtMqr5rm7YL7Xy/vot4ldkKyjLKt0MaeVOc1NIIFuHsgjgW3p2+5f9d3ZJQ
	zXZ8bdG0WA0M0weuhoTFdM990WNjmIMJWShvrYvBix6L9+dwA/w==
X-Google-Smtp-Source: AGHT+IG4pRegU0LAW/VDRfVRaxw9VXFNaGALBvaaaEfhph05D4gDdS/tB5Uz4j4bK21XqE2sl9k4zA==
X-Received: by 2002:a05:6a00:b4f:b0:781:2271:50ed with SMTP id d2e1a72fcca58-793851362cdmr4065954b3a.5.1759931622892;
        Wed, 08 Oct 2025 06:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205331asm18990495b3a.49.2025.10.08.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:53:42 -0700 (PDT)
Message-Id: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
In-Reply-To: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 13:53:41 +0000
Subject: [PATCH v2] doc: add a explanation of Git's data model
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Julia Evans <julia@jvns.ca>,
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
   (first line, trailers etc).
4. Don't mention configuration.
5. Don't mention the `.git` directory, to avoid getting too much into
   implementation details

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: Add a explanation of Git's data model
    
    Changes in v2:
    
    The biggest change is to remove all mentions of the .git directory, and
    explain references in a way that doesn't refer to "directories" at all,
    and instead talks about the "hierarchy" (from Kristoffer and Patrick's
    reviews).
    
    Also:
    
     * objects: Mention that an object ID is called an "object name", and
       update the glossary to include the term "object ID" (from Junio's
       review)
     * objects: Replace "SHA-1 hash" with "cryptographic hash" which is more
       accurate (from Patrick's review)
     * blobs: Made the explanation of git gc a little higher level and took
       some ideas from Patrick's suggested wording (from Patrick's and
       Kroftoffer's reviews)
     * commits: Mention that tag objects and commits can optionally have
       other fields. I didn't mention the GPG signature specifically, but
       don't have any objections to adding it. (from Patrick and Junio's
       reviews)
     * commits: Remove one of the mentions of git gc, since it perhaps opens
       up too much of a rabbit hole: "how does git gc decide which commits
       to clean up?". (from Kristoffer's review)
     * tag objects: Add an example of how a tag object is represented (from
       user feedback on the draft)
     * index: Use the term "file mode" instead of "permissions", and list
       all allowed file modes (from Patrick's review)
     * index: Use "stage number" instead of "number" for index entries (from
       Patrick's review)
     * reflogs: Remove "any ref can be logged", it raises some questions of
       "how do you tell Git to log a ref that it isn't normally logging?"
       and my guess is that it's uncommon to ask Git to log more refs. I
       don't think it's a "lie" to omit this but I can bring it back if
       folks disagree. (from Patrick's review)
     * reflogs: Fix an error I noticed in the explanation of reflogs: tags
       aren't logged by default and remote-tracking branches are, according
       to man git-config
     * branches and tags: Be clearer about how branches are usually updated
       (by committing), and make it a little more obvious that only branches
       can be checked out. This is a bit tricky because using the word
       "check out" introduces a rabbit hole that I want to avoid (what does
       "check out" mean?). I've dealt this by just talking about the
       "current branch" (HEAD) since that is defined here, and making it
       more explicit that HEAD must either be a branch or a commit, there's
       no "HEAD is a tag" option. (from Patrick's review)
     * tags: Explain the differences between annotated and lightweight tags
       (this is the main piece of user feedback I've gotten on the draft so
       far)
     * Various style/typo changes ("2 or more", linkgit:git-gc[1], removed
       extra asterisks, added empty SYNOPSIS, "commits -> tags" typo fix,
       add to meson build)
    
    non-changes:
    
     * I still haven't mentioned things that aren't part of the "data
       model", like revision params and configuration. I think there could
       be a place for them but I haven't found it yet.
     * tag objects: I noticed that there's a "tag" header field in tag
       objects (like tag v1.0.0) but I didn't mention it yet because I
       couldn't figure out what the purpose of that field is (I thought the
       tag name was stored in the reference, why is it duplicated in the tag
       object?)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1981%2Fjvns%2Fgitdatamodel-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1981/jvns/gitdatamodel-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1981

Range-diff vs v1:

 1:  fcbd21b6da ! 1:  3b38a88dc7 doc: add a explanation of Git's data model
     @@ Commit message
             down a rabbit hole which would make this document less useful for
             understanding Git's core behaviour.
          3. Don't discuss the structure of a commit message
     -       (first line, trailers, GPG signatures, etc).
     -       Perhaps this should change.
     -
     -    Some other choices I've made:
     -
     -    1. Mention packed refs only in a note.
     -    2. Don't mention that the full name of the branch `main` is
     -       technically `refs/heads/main`. This should likely change but I
     -       haven't worked out how to do it in a clear way yet.
     -    3. Mostly avoid referring to the `.git` directory, because the exact
     -       details of how things are stored change over time.
     -       This should perhaps change from "mostly" to "entirely"
     -       but I haven't worked out how to do that in a clear way yet.
     +       (first line, trailers etc).
     +    4. Don't mention configuration.
     +    5. Don't mention the `.git` directory, to avoid getting too much into
     +       implementation details
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/gitdatamodel.adoc (new)
      +----
      +gitdatamodel - Git's core data model
      +
     ++SYNOPSIS
     ++--------
     ++gitdatamodel
     ++
      +DESCRIPTION
      +-----------
      +
      +It's not necessary to understand Git's data model to use Git, but it's
      +very helpful when reading Git's documentation so that you know what it
     -+means when the documentation says "object" "reference" or "index".
     ++means when the documentation says "object", "reference" or "index".
      +
      +Git's core operations use 4 kinds of data:
      +
     @@ Documentation/gitdatamodel.adoc (new)
      +Commits, trees, blobs, and tag objects are all stored in Git's object database.
      +Every object has:
      +
     -+1. an *ID*, which is the SHA-1 hash of its contents.
     ++1. an *ID* (aka "object name"), which is a cryptographic hash of its
     ++  type and contents.
      +  It's fast to look up a Git object using its ID.
     -+  The ID is usually represented in hexadecimal, like
     ++  This is usually represented in hexadecimal, like
      +  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
      +2. a *type*. There are 4 types of objects:
      +   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
     @@ Documentation/gitdatamodel.adoc (new)
      +
      +[[commit]]
      +commits::
     -+    A commit contains:
     ++    A commit contains these required fields
     ++    (though there are other optional fields):
      ++
      +1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
     -+  regular commits have 1 parent, merge commits have 2+ parents
     ++  regular commits have 1 parent, merge commits have 2 or more parents
      +2. A *commit message*
      +3. All the *files* in the commit, stored as a *<<tree,tree>>*
      +4. An *author* and the time the commit was authored
     @@ Documentation/gitdatamodel.adoc (new)
      ++
      +Like all other objects, commits can never be changed after they're created.
      +For example, "amending" a commit with `git commit --amend` creates a new commit.
     -+The old commit will eventually be deleted by `git gc`.
      +
      +[[tree]]
      +trees::
      +    A tree is how Git represents a directory. It lists, for each item in
      +    the tree:
      ++
     -+1. The *permissions*, for example `100644`
     ++1. The *file mode*, for example `100644`
      +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
      +  or <<commit,`commit`>> (a Git submodule)
      +3. The *object ID*
     @@ Documentation/gitdatamodel.adoc (new)
      +040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
      +----
      ++
     -+*NOTE:* The permissions are in the same format as UNIX permissions, but
     -+the only allowed permissions for files (blobs) are 644 and 755.
     ++Git only supports these file modes:
     +++
     ++  - `100644`: regular file (with type `blob`)
     ++  - `100755`: executable file (with type `blob`)
     ++  - `120000`: symbolic link (with type `blob`)
     ++  - `040000`: directory (with type `tree`)
     ++  - `160000`: gitlink, for use with submodules (with type `commit`)
      +
      +[[blob]]
      +blobs::
      +    A blob is how Git represents a file. A blob object contains the
      +    file's contents.
      ++
     -+Storing a new blob for every new version of a file can get big, so
     -+`git gc` periodically compresses objects for efficiency in `.git/objects/pack`.
     ++
     ++NOTE: Storing a new blob for every new version of a file can use a
     ++lot of disk space. To handle this, Git periodically runs repository
     ++maintenance with linkgit:git-gc[1]. Part of this maintenance is
     ++compressing objects so that if a small part of a file was changed, only
     ++the change is stored instead of the whole file.
      +
      +[[tag-object]]
      +tag objects::
     -+    Tag objects (also known as "annotated tags") contain:
     ++    Tag objects (also known as "annotated tags") contain these required fields
     ++    (though there are other optional fields):
      ++
      +1. The *tagger* and tag date
      +2. A *tag message*, similar to a commit message
     -+3. The *ID* of the object (often a commit) that they reference
     ++3. The *ID* and *type* of the object (often a commit) that they reference
     ++
     ++Here's how an example tag object is stored:
     ++
     ++----
     ++object 750b4ead9c87ceb3ddb7a390e6c7074521797fb3
     ++type commit
     ++tag v1.0.0
     ++tagger Maya <maya@example.com> 1759927359 -0400
     ++
     ++Release version 1.0.0
     ++----
      +
      +[[references]]
      +REFERENCES
     @@ Documentation/gitdatamodel.adoc (new)
      +branch" than "the changes are in commit bb69721404348e".
      +Git often uses "ref" as shorthand for "reference".
      +
     -+References that you create are stored in the `.git/refs` directory,
     -+and Git has a few special internal references like `HEAD` that are stored
     -+in the base `.git` directory.
     -+
      +References can either be:
      +
      +1. References to an object ID, usually a <<commit,commit>> ID
      +2. References to another reference. This is called a "symbolic reference".
      +
     -+Git handles references differently based on which subdirectory of
     -+`.git/refs` they're stored in.
     -+Here are the main types:
     ++References are stored in a hierarchy, and Git handles references
     ++differently based on where they are in the hierarchy.
     ++Most references are under `refs/`. Here are the main types:
      +
      +[[branch]]
     -+branches: `.git/refs/heads/<name>`::
     ++branches: `refs/heads/<name>`::
      +    A branch is a name for a commit ID.
      +    That commit is the latest commit on the branch.
     -+    Branches are stored in the `.git/refs/heads/` directory.
      ++
      +To get the history of commits on a branch, Git will start at the commit
      +ID the branch references, and then look at the commit's parent(s),
      +the parent's parent, etc.
      +
      +[[tag]]
     -+tags: `.git/refs/tags/<name>`::
     ++tags: `refs/tags/<name>`::
      +    A tag is a name for a commit ID, tag object ID, or other object ID.
     -+    Tags are stored in the `refs/tags/` directory.
     ++    Tags that reference a tag object ID are called "annotated tags",
     ++    because the tag object contains a tag message.
     ++    Tags that reference a commit ID, blob ID, or tree ID are
     ++    called "lightweight tags".
      ++
     -+Even though branches and commits are both "a name for a commit ID", Git
     ++Even though branches and tags are both "a name for a commit ID", Git
      +treats them very differently.
     -+Branches are expected to be regularly updated as you work on the branch,
     -+but it's expected that a tag will never change after you create it.
     ++Branches are expected to change over time: when you make a commit, Git
     ++will update your <<HEAD,current branch>> to reference the new changes.
     ++It's expected that a tag will never change after you create it.
      +
      +[[HEAD]]
     -+HEAD: `.git/HEAD`::
     ++HEAD: `HEAD`::
      +    `HEAD` is where Git stores your current <<branch,branch>>.
     -+    `HEAD` is normally a symbolic reference to your current branch, for
     -+    example `ref: refs/heads/main` if your current branch is `main`.
     -+    `HEAD` can also be a direct reference to a commit ID,
     -+    that's called "detached HEAD state".
     ++    `HEAD` can either be:
     ++    1. A symbolic reference to your current branch, for example `ref:
     ++       refs/heads/main` if your current branch is `main`.
     ++    2. A direct reference to a commit ID.
     ++        This is called "detached HEAD state".
      +
      +[[remote-tracking-branch]]
     -+remote tracking branches: `.git/refs/remotes/<remote>/<branch>`::
     ++remote tracking branches: `refs/remotes/<remote>/<branch>`::
      +    A remote-tracking branch is a name for a commit ID.
      +    It's how Git stores the last-known state of a branch in a remote
      +    repository. `git fetch` updates remote-tracking branches. When
     @@ Documentation/gitdatamodel.adoc (new)
      +
      +[[other-refs]]
      +Other references::
     -+    Git tools may create references in any subdirectory of `.git/refs`.
     ++    Git tools may create references anywhere under `refs/`.
      +    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
      +    and linkgit:git-notes[1] all create their own references
     -+    in `.git/refs/stash`, `.git/refs/bisect`, etc.
     ++    in `refs/stash`, `refs/bisect`, etc.
      +    Third-party Git tools may also create their own references.
      ++
     -+Git may also create references in the base `.git` directory
     -+other than `HEAD`, like `ORIG_HEAD`.
     -+
     -+*NOTE:* As an optimization, references may be stored as packed
     -+refs instead of in `.git/refs`. See linkgit:git-pack-refs[1].
     ++Git may also create references other than `HEAD` at the base of the
     ++hierarchy, like `ORIG_HEAD`.
      +
      +[[index]]
      +THE INDEX
     @@ Documentation/gitdatamodel.adoc (new)
      +1. The *permissions*
      +2. The *<<blob,blob>> ID* of the file
      +3. The *filename*
     -+4. The *number*. This is normally 0, but if there's a merge conflict
     ++4. The *stage number*. This is normally 0, but if there's a merge conflict
      +   there can be multiple versions (with numbers 0, 1, 2, ..)
      +   of the same filename in the index.
      +
     @@ Documentation/gitdatamodel.adoc (new)
      +REFLOGS
      +-------
      +
     -+Git stores the history of branch, tag, and HEAD refs in a reflog
     -+(you should read "reflog" as "ref log"). Not every ref is logged by
     -+default, but any ref can be logged.
     ++Git stores the history of your branch, remote-tracking branch, and HEAD refs
     ++in a reflog (you should read "reflog" as "ref log").
      +
      +Each reflog entry has:
      +
     -+1. *Before/after *commit IDs*
     ++1. Before/after *commit IDs*
      +2. *User* who made the change, for example `Maya <maya@example.com>`
     -+3. *Timestamp*
     ++3. *Timestamp* when the change was made
      +4. *Log message*, for example `pull: Fast-forward`
      +
      +Reflogs only log changes made in your local repository.
     @@ Documentation/gitdatamodel.adoc (new)
      +GIT
      +---
      +Part of the linkgit:git[1] suite
     +
     + ## Documentation/glossary-content.adoc ##
     +@@ Documentation/glossary-content.adoc: This commit is referred to as a "merge commit", or sometimes just a
     + 	identified by its <<def_object_name,object name>>. The objects usually
     + 	live in `$GIT_DIR/objects/`.
     + 
     +-[[def_object_identifier]]object identifier (oid)::
     +-	Synonym for <<def_object_name,object name>>.
     ++[[def_object_identifier]]object identifier, object ID, oid::
     ++	Synonyms for <<def_object_name,object name>>.
     + 
     + [[def_object_name]]object name::
     + 	The unique identifier of an <<def_object,object>>.  The
     +
     + ## Documentation/meson.build ##
     +@@ Documentation/meson.build: manpages = {
     +   'gitcore-tutorial.adoc' : 7,
     +   'gitcredentials.adoc' : 7,
     +   'gitcvs-migration.adoc' : 7,
     ++  'gitdatamodel.adoc' : 7,
     +   'gitdiffcore.adoc' : 7,
     +   'giteveryday.adoc' : 7,
     +   'gitfaq.adoc' : 7,


 Documentation/Makefile              |   1 +
 Documentation/gitdatamodel.adoc     | 248 ++++++++++++++++++++++++++++
 Documentation/glossary-content.adoc |   4 +-
 Documentation/meson.build           |   1 +
 4 files changed, 252 insertions(+), 2 deletions(-)
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
index 0000000000..c3a25ea8d2
--- /dev/null
+++ b/Documentation/gitdatamodel.adoc
@@ -0,0 +1,248 @@
+gitdatamodel(7)
+===============
+
+NAME
+----
+gitdatamodel - Git's core data model
+
+SYNOPSIS
+--------
+gitdatamodel
+
+DESCRIPTION
+-----------
+
+It's not necessary to understand Git's data model to use Git, but it's
+very helpful when reading Git's documentation so that you know what it
+means when the documentation says "object", "reference" or "index".
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
+1. an *ID* (aka "object name"), which is a cryptographic hash of its
+  type and contents.
+  It's fast to look up a Git object using its ID.
+  This is usually represented in hexadecimal, like
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
+    A commit contains these required fields
+    (though there are other optional fields):
++
+1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
+  regular commits have 1 parent, merge commits have 2 or more parents
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
+
+[[tree]]
+trees::
+    A tree is how Git represents a directory. It lists, for each item in
+    the tree:
++
+1. The *file mode*, for example `100644`
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
+Git only supports these file modes:
++
+  - `100644`: regular file (with type `blob`)
+  - `100755`: executable file (with type `blob`)
+  - `120000`: symbolic link (with type `blob`)
+  - `040000`: directory (with type `tree`)
+  - `160000`: gitlink, for use with submodules (with type `commit`)
+
+[[blob]]
+blobs::
+    A blob is how Git represents a file. A blob object contains the
+    file's contents.
++
+
+NOTE: Storing a new blob for every new version of a file can use a
+lot of disk space. To handle this, Git periodically runs repository
+maintenance with linkgit:git-gc[1]. Part of this maintenance is
+compressing objects so that if a small part of a file was changed, only
+the change is stored instead of the whole file.
+
+[[tag-object]]
+tag objects::
+    Tag objects (also known as "annotated tags") contain these required fields
+    (though there are other optional fields):
++
+1. The *tagger* and tag date
+2. A *tag message*, similar to a commit message
+3. The *ID* and *type* of the object (often a commit) that they reference
+
+Here's how an example tag object is stored:
+
+----
+object 750b4ead9c87ceb3ddb7a390e6c7074521797fb3
+type commit
+tag v1.0.0
+tagger Maya <maya@example.com> 1759927359 -0400
+
+Release version 1.0.0
+----
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
+References can either be:
+
+1. References to an object ID, usually a <<commit,commit>> ID
+2. References to another reference. This is called a "symbolic reference".
+
+References are stored in a hierarchy, and Git handles references
+differently based on where they are in the hierarchy.
+Most references are under `refs/`. Here are the main types:
+
+[[branch]]
+branches: `refs/heads/<name>`::
+    A branch is a name for a commit ID.
+    That commit is the latest commit on the branch.
++
+To get the history of commits on a branch, Git will start at the commit
+ID the branch references, and then look at the commit's parent(s),
+the parent's parent, etc.
+
+[[tag]]
+tags: `refs/tags/<name>`::
+    A tag is a name for a commit ID, tag object ID, or other object ID.
+    Tags that reference a tag object ID are called "annotated tags",
+    because the tag object contains a tag message.
+    Tags that reference a commit ID, blob ID, or tree ID are
+    called "lightweight tags".
++
+Even though branches and tags are both "a name for a commit ID", Git
+treats them very differently.
+Branches are expected to change over time: when you make a commit, Git
+will update your <<HEAD,current branch>> to reference the new changes.
+It's expected that a tag will never change after you create it.
+
+[[HEAD]]
+HEAD: `HEAD`::
+    `HEAD` is where Git stores your current <<branch,branch>>.
+    `HEAD` can either be:
+    1. A symbolic reference to your current branch, for example `ref:
+       refs/heads/main` if your current branch is `main`.
+    2. A direct reference to a commit ID.
+        This is called "detached HEAD state".
+
+[[remote-tracking-branch]]
+remote tracking branches: `refs/remotes/<remote>/<branch>`::
+    A remote-tracking branch is a name for a commit ID.
+    It's how Git stores the last-known state of a branch in a remote
+    repository. `git fetch` updates remote-tracking branches. When
+    `git status` says "you're up to date with origin/main", it's looking at
+    this.
+
+[[other-refs]]
+Other references::
+    Git tools may create references anywhere under `refs/`.
+    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
+    and linkgit:git-notes[1] all create their own references
+    in `refs/stash`, `refs/bisect`, etc.
+    Third-party Git tools may also create their own references.
++
+Git may also create references other than `HEAD` at the base of the
+hierarchy, like `ORIG_HEAD`.
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
+4. The *stage number*. This is normally 0, but if there's a merge conflict
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
+Git stores the history of your branch, remote-tracking branch, and HEAD refs
+in a reflog (you should read "reflog" as "ref log").
+
+Each reflog entry has:
+
+1. Before/after *commit IDs*
+2. *User* who made the change, for example `Maya <maya@example.com>`
+3. *Timestamp* when the change was made
+4. *Log message*, for example `pull: Fast-forward`
+
+Reflogs only log changes made in your local repository.
+They are not shared with remotes.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index e423e4765b..20ba121314 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -297,8 +297,8 @@ This commit is referred to as a "merge commit", or sometimes just a
 	identified by its <<def_object_name,object name>>. The objects usually
 	live in `$GIT_DIR/objects/`.
 
-[[def_object_identifier]]object identifier (oid)::
-	Synonym for <<def_object_name,object name>>.
+[[def_object_identifier]]object identifier, object ID, oid::
+	Synonyms for <<def_object_name,object name>>.
 
 [[def_object_name]]object name::
 	The unique identifier of an <<def_object,object>>.  The
diff --git a/Documentation/meson.build b/Documentation/meson.build
index e34965c5b0..ace0573e82 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -192,6 +192,7 @@ manpages = {
   'gitcore-tutorial.adoc' : 7,
   'gitcredentials.adoc' : 7,
   'gitcvs-migration.adoc' : 7,
+  'gitdatamodel.adoc' : 7,
   'gitdiffcore.adoc' : 7,
   'giteveryday.adoc' : 7,
   'gitfaq.adoc' : 7,

base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
-- 
gitgitgadget
