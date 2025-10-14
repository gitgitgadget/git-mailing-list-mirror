Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8C306B1A
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476352; cv=none; b=J9BFcikHeEgoHvHk9G05ETTRmJ06L7VAqwh+ZncmCr5hRQXLWA7jbd0ZeaS3byyYQurSRGBCwCqss0h1OKNSKxqoN6iSteBnPCW7JXP4EcoEglGATTKHte+FrsamLPUZHeF6fONxwi2ORPxjBG4bBuD8PvWHvdjADMkgbG0FmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476352; c=relaxed/simple;
	bh=QULKuBhFvZkyjVOqlNIASDqLOpa5L7dGYdqvDjZ6/+4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iwOwt2RAhE1N8tzBkVWbfxs4lj2vn+pPkDvN37YKdZS7ALR6zhxPqbgND6AMi6xZDo1j/7jvclOSTzt3uoHw07/FuTIZOcfmsYopNwHvEv/ky8+q/DXS3bf9BiVABKrQsdcvv3zOoZz183DjSSor2BB5ll1zNmXcsWZLoiY3Vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHdxsZzg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHdxsZzg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85a4ceb4c3dso729495585a.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760476348; x=1761081148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M0cMhVBQ6b3Ib7At02DAS1XouHRQtDvt/BxI0DHLUQ=;
        b=YHdxsZzgtZO0mwZgeI45AV52VOhch6erXcNUyPmZqmJQqHGbTgKdCxMqAxNzS/h2jT
         rUGnsBentS0mhZ8JWToeektgIVIHMKcDSCHxFbi1+mwnSl0ff3nG9Ln6ViUeWKcdozvv
         GlP7hoSh52VomOKZTmsd3Y/Q6EsvLHq7hiWSiqCSwb9JjYYwBksDa2iEPmJFUrBQ32vh
         1IypBrJXVFBDi47ZG9vDYfCOMDe0vpdR40xAma1cDriP5S9PFH3PhSra5ZoXl3Us/uDw
         0upnSZ2JIDIVXVYNf/79H+IZ1h23v53KvCo2PG17gwYcxhTZ32Oie/qdIZ7WQbtO1LGz
         ilmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760476348; x=1761081148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M0cMhVBQ6b3Ib7At02DAS1XouHRQtDvt/BxI0DHLUQ=;
        b=v8I5+JWf2oHknLywsJNsq9iqmk/DVh7VJSwkps/NOkMRhEg+ZU9PENi4ckqTu52hey
         PmGXpTAgFOsLRXCcXMVWGB27BIpFBJa5EapxgWAk3GFFgmgVQnTACqF0n0tMyv2FI7ji
         ZSEgoiq19ow7JCJ0ssmgmEBYvGT6Vcwjsa3InFe7Fm0FmdL18BifP0OUzwT9/wPPfdlA
         iBAhsv2jH7rv9ZzTD87aPKXco4DJMtc/8By5e9t/NSAuvIt7HZbG3Q9V7fYaoo3eCFHO
         LcbRiGGyXItq59TRv5Cr3z6o5pbY7MTACZkLPNStTUEAGCdqNO72sROE+mEc6DBp0qUC
         q0MA==
X-Gm-Message-State: AOJu0Ywi7fifmLwjc8poYbxnGAbnSTa9Zh9jV0J4gfCfNcMVtODTO/qO
	rI8RS3on8PFpc+Y8xM3SG2/ETwXMltWV1yy44g7mxT/ZHQE9cnMZ11F7/PZqaCjD
X-Gm-Gg: ASbGncsdUgqoRnZHs7+rlALo10u1aOo6TTtcUX4aPrN5fDpwEF81vItNCKkfpS6xyWk
	wVw2/tU/mhrRb4WFEabsgUb/lIuKlHEw/jBxJffkCn0d/79SnK+F4D2BbP8Q8fJAPnmt2CTVLHO
	p0uokhVLDez7kNbNJAfITSZFrjM8tpCNFapVt1JH8ca0cLLKiQHsq/DsmN81pnmWKMTF+m54FLP
	MCS8311/AjJnWyT/xOh2eZk5rMijEhXH1N3LibsmJB+hivKSJzgRlSpvTUFo17XrhEEpRjsT4U7
	OVR70P508gLznoDL88a6rJXsirc3svhp0L2/vNYV/Cn6XjVV3jlwYpYwpyCjvRBqp60kKfoC4Ud
	QOJ72tAThjh1ozvCoEICAIn4nI0z+Gh+5xrZ+mQSfKSk=
X-Google-Smtp-Source: AGHT+IEsowFvyTHlyWJQLwTVboO7/evSOCXxP1g9jR1alvL3ZG9BnF1BI3ronxc1dQbNJw+C8qOyOw==
X-Received: by 2002:a05:622a:4899:b0:4d8:ce8f:dff8 with SMTP id d75a77b69052e-4e6eacb38c2mr353838861cf.7.1760476347167;
        Tue, 14 Oct 2025 14:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c55659sm5969081cf.8.2025.10.14.14.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 14:12:26 -0700 (PDT)
Message-Id: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
In-Reply-To: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Oct 2025 21:12:26 +0000
Subject: [PATCH v3] doc: add a explanation of Git's data model
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
    
    Changes in v3:
    
    I asked for feedback from Git users on Mastodon and got 220 pieces of
    feedback from 48 different users. People seemed very excited to read
    about Git's data model. Usually I judge explanations by what folks
    report learning from them. Here people reported learning:
    
     * how branches are stored (that a branch is "a name for a commit")
     * how objects work
     * that Git has separate "author" and "committer" fields
     * that amending a commit does not change it
     * that a tree is "just a directory" (not something more complicated),
       and how trees are stored
     * that Git repos can contain symlinks
     * that Git saves modes separately from the OS.
     * how the stage number works
     * that when you git add a file, Git will create an object
     * that third-party tools can create their own refs.
     * that the reflog stores the history of branches (not just HEAD), and
       what reflogs are for
    
    Also (of course) there were quite a few points of confusion! The main 4
    pieces of feedback were
    
     1. The index section doesn't explain what the word "staged" means, and
        one person says that it makes it sounds like only files that you
        "git add"ed are in the index. Rewrite the explanation to avoid using
        the word "staged" to define the index and instead define the word
        "staging".
     2. Explain the difference between "annotated tags" and "lightweight
        tags" (done)
     3. Add examples for tag objects and reflogs (done)
     4. Mention a little more about where things are stored in the .git
        directory, which I'd removed in v2. This seems most important for
        .git/refs, so I added a hopefully accurate note about how refs are
        stored by default, with a comment about one of the major
        implications. I did not discuss where objects or the index are
        stored, because I don't think the implementation details of how
        objects are stored are as important, and there are better tools for
        viewing the "raw" state of objects and the index (with git cat-file
        -p or git ls-files --staged).
    
    Here's every other change I made in response to the feedback, as well as
    a few comments that I did not address.
    
    intro:
    
     * Give a 1-sentence intro to "reflog"
    
    objects:
    
     * people really like having git ls-files --stage as a way to view the
       index, so add git cat-file -p as well in a note
    
    commits:
    
     * 2 people asked "Are commits stored as a diff?". Say that diffs are
       calculated at runtime, this is very important.
     * The order the fields are given in don't match the order in the
       example. Make them match.
     * "All the files in the commit, stored as a tree" is throwing a few
       people off. Be clearer that it's the tree ID of the base directory.
     * Several people asked "What's the difference between an author and
       committer? I added an example using git cherry-pick that I'm not 100%
       happy with (what if the reader doesn't know what cherry-pick does?).
       There might be a better example to give here.
     * In the note about commits being amended: one person suggested saying
       "creates a new commit with the same parent" to make it clearer what
       the relationship between the new and old commit are. I liked that
       idea so I did it.
    
    trees:
    
     * file modes. 2 people want to know more about "The file mode, for
       example 100644". Also 2 people are curious about what relationship
       these have to Unix permissions. Say that they're inspired by Unix
       permissions, and move the list of possible file modes up to make the
       relationship clearer
     * On "so git-gc(1) periodically compresses objects to save disk space",
       there are a few follow up comments wondering about more, which makes
       me think the comment about compression is actually a distraction. Say
       something simpler instead, ("Git only needs to store new versions of
       files which were changed in that commit"), from Junio's suggestion
     * Re "commit (a Git submodule)": 2 people say it's not clear how trees
       relate to submodules. Say that it refers to a commit in a different
       repository.
     * One person says they're not sure if the "object ID" is a hash. Link
       it to the definition of "object ID".
    
    tag objects:
    
     * Requests for an example, added one.
     * Requests to explain the difference between "lightweight" and
       "annotated" tags, added it.
    
    tags:
    
     * one person thinks "It’s expected that a tag will never change after
       you create it." is too strong (since of course you can change it with
       git tag -f). Say instead that tags are "usually" not changed.
    
    HEAD:
    
     * Several people are asking for more detail about detached HEAD state.
       There's actually quite a lot to talk about here (what it means, how
       it happens, what it implies, and how you might adjust your workflow
       to avoid it by using git switch). I don't think we can get into all
       of that here, so refer to the DETACHED HEAD section of git-checkout
       instead. I'm not totally happy with the current version of that
       section but that seems like the most practical solution right now.
    
    remote-tracking branches:
    
     * discuss refs/remotes/<remote>/HEAD.
    
    the index:
    
     * "permissions" should be "file mode" (like with trees). Changed.
     * "filename" should be "file path". Changed.
     * the stage number can only be 0, 1, 2, or 3, since it's 2 bits. Also
       maybe say that the numbers have specific meanings. Said it can only
       be 0/1/2/3 but did not give the specific meanings.
    
    reflogs
    
     * Request for an example. Added one.
     * It's not clear if there's one reflog per branch/tag/HEAD, or if
       there's one universal reflog. Make this clearer.
     * Mention the role of the reflog in retrieving "lost" commits or
       undoing bad rebases.
    
    Not fixed:
    
     * intro: A couple of people say that it's confusing that tags are both
       "an object" and "a reference". Handled this by just explaining the
       difference between an annotated and a lightweight tag further down.
       I'd like to make this clearer in the intro but not sure if there's a
       way to do it.
     * commits and tag objects: one person asks if there's a reference for
       the other "optional fields", like "encoding" and "gpgsig". I couldn't
       find one, so left this as is.
     * HEAD: A couple of people ask if there are any other symbolic
       references other than HEAD, or if they can make their own symbolic
       references. I don't know the answer to this.
     * HEAD: the HEAD: HEAD thing looks weird, it made more sense when it
       was HEAD: .git/HEAD. Will think about this.
     * reflogs: One person asks: if reflogs only store local changes, why
       does it track the user who made the change? Is that for remote
       operations like fetches and pulls? Or for cases where more than one
       user is using the same repo on a system? I don't know the answer to
       this.
     * reflogs: How can you see the full data in the reflog? git reflog show
       doesn't list the user who made the change. git reflog show <refname>
       --format="%h | %gd | %gn <%ge> | %gs" --date=iso seems to work but
       it's really a mouthful, not sure it's useful to include all that.
     * index: Is it worth mentioning that the index can be locked? I don't
       have an opinion about this.
     * other: One person asks what a "working tree" is. It made me wonder if
       "the current working directory" has a place in Git's data model. My
       feeling is "no" but I could be convinced otherwise.
     * overall: "How can Git be so fast? If I switch branches, how does it
       figure out what to add, remove or replace?". I don't think this is
       the right place for that discussion but it would
     * there are some docs CI errors I haven't figured out yet (IDREF
       attribute linkend references an unknown ID "tree")

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1981%2Fjvns%2Fgitdatamodel-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1981/jvns/gitdatamodel-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1981

Range-diff vs v2:

 1:  3b38a88dc7 ! 1:  39da4e04cf doc: add a explanation of Git's data model
     @@ Documentation/gitdatamodel.adoc (new)
      +2. <<references,References>>: branches, tags,
      +   remote-tracking branches, etc
      +3. <<index,The index>>, also known as the staging area
     -+4. <<reflogs,Reflogs>>
     ++4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
      +
      +[[objects]]
      +OBJECTS
     @@ Documentation/gitdatamodel.adoc (new)
      +Commits, trees, blobs, and tag objects are all stored in Git's object database.
      +Every object has:
      +
     ++[[object-id]]
      +1. an *ID* (aka "object name"), which is a cryptographic hash of its
      +  type and contents.
      +  It's fast to look up a Git object using its ID.
     @@ Documentation/gitdatamodel.adoc (new)
      +    A commit contains these required fields
      +    (though there are other optional fields):
      ++
     -+1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
     ++1. All the *files* in the commit, stored as the *<<tree,tree>>* ID of
     ++   the commit's base directory.
     ++2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
      +  regular commits have 1 parent, merge commits have 2 or more parents
     -+2. A *commit message*
     -+3. All the *files* in the commit, stored as a *<<tree,tree>>*
     -+4. An *author* and the time the commit was authored
     -+5. A *committer* and the time the commit was committed
     ++3. An *author* and the time the commit was authored
     ++4. A *committer* and the time the commit was committed.
     ++   If you cherry-pick (linkgit:git-cherry-pick[1]) someone else's commit,
     ++   then they will be the author and you'll be the committer.
     ++5. A *commit message*
      ++
      +Here's how an example commit is stored:
      ++
     @@ Documentation/gitdatamodel.adoc (new)
      +----
      ++
      +Like all other objects, commits can never be changed after they're created.
     -+For example, "amending" a commit with `git commit --amend` creates a new commit.
     ++For example, "amending" a commit with `git commit --amend` creates a new
     ++commit with the same parent.
     +++
     ++Git does not store the diff for a commit: when you ask Git for a
     ++diff it calculates it on the fly.
      +
      +[[tree]]
      +trees::
      +    A tree is how Git represents a directory. It lists, for each item in
      +    the tree:
      ++
     -+1. The *file mode*, for example `100644`
     ++[[file-mode]]
     ++1. The *file mode*, for example `100644`. The format is inspired by Unix
     ++   permissions, but Git's modes are much more limited. Git only supports these file modes:
     +++
     ++  - `100644`: regular file (with type `blob`)
     ++  - `100755`: executable file (with type `blob`)
     ++  - `120000`: symbolic link (with type `blob`)
     ++  - `040000`: directory (with type `tree`)
     ++  - `160000`: gitlink, for use with submodules (with type `commit`)
     ++
      +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
     -+  or <<commit,`commit`>> (a Git submodule)
     -+3. The *object ID*
     ++  or <<commit,`commit`>> (a Git submodule, which is a
     ++  commit from a different Git repository)
     ++3. The <<object-id,*object ID*>>
      +4. The *filename*
      ++
      +For example, this is how a tree containing one directory (`src`) and one file
     @@ Documentation/gitdatamodel.adoc (new)
      +100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
      +040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
      +----
     -++
     -+Git only supports these file modes:
     -++
     -+  - `100644`: regular file (with type `blob`)
     -+  - `100755`: executable file (with type `blob`)
     -+  - `120000`: symbolic link (with type `blob`)
     -+  - `040000`: directory (with type `tree`)
     -+  - `160000`: gitlink, for use with submodules (with type `commit`)
     ++
      +
      +[[blob]]
      +blobs::
      +    A blob is how Git represents a file. A blob object contains the
      +    file's contents.
      ++
     -+
     -+NOTE: Storing a new blob for every new version of a file can use a
     -+lot of disk space. To handle this, Git periodically runs repository
     -+maintenance with linkgit:git-gc[1]. Part of this maintenance is
     -+compressing objects so that if a small part of a file was changed, only
     -+the change is stored instead of the whole file.
     ++When you make a new commit, Git only needs to store new versions of
     ++files which were changed in that commit. This means that commits
     ++can use relatively little disk space even in a very large repository.
      +
      +[[tag-object]]
      +tag objects::
     -+    Tag objects (also known as "annotated tags") contain these required fields
     ++    Tag objects contain these required fields
      +    (though there are other optional fields):
      ++
     -+1. The *tagger* and tag date
     -+2. A *tag message*, similar to a commit message
     -+3. The *ID* and *type* of the object (often a commit) that they reference
     ++1. The *ID* and *type* of the object (often a commit) that they reference
     ++2. The *tagger* and tag date
     ++3. A *tag message*, similar to a commit message
      +
      +Here's how an example tag object is stored:
      +
     @@ Documentation/gitdatamodel.adoc (new)
      +Release version 1.0.0
      +----
      +
     ++NOTE: All of the examples in this section were generated with
     ++`git cat-file -p <object-id>`, which shows the contents of a Git object.
     ++
      +[[references]]
      +REFERENCES
      +----------
     @@ Documentation/gitdatamodel.adoc (new)
      +    A tag is a name for a commit ID, tag object ID, or other object ID.
      +    Tags that reference a tag object ID are called "annotated tags",
      +    because the tag object contains a tag message.
     -+    Tags that reference a commit ID, blob ID, or tree ID are
     ++    Tags that reference a commit, blob, or tree ID are
      +    called "lightweight tags".
      ++
      +Even though branches and tags are both "a name for a commit ID", Git
      +treats them very differently.
      +Branches are expected to change over time: when you make a commit, Git
      +will update your <<HEAD,current branch>> to reference the new changes.
     -+It's expected that a tag will never change after you create it.
     ++Tags are usually not changed after they're created.
      +
      +[[HEAD]]
      +HEAD: `HEAD`::
     @@ Documentation/gitdatamodel.adoc (new)
      +    `HEAD` can either be:
      +    1. A symbolic reference to your current branch, for example `ref:
      +       refs/heads/main` if your current branch is `main`.
     -+    2. A direct reference to a commit ID.
     -+        This is called "detached HEAD state".
     ++    2. A direct reference to a commit ID. This is called "detached HEAD
     ++	   state", see the DETACHED HEAD section of linkgit:git-checkout[1] for more.
      +
      +[[remote-tracking-branch]]
      +remote tracking branches: `refs/remotes/<remote>/<branch>`::
     @@ Documentation/gitdatamodel.adoc (new)
      +    repository. `git fetch` updates remote-tracking branches. When
      +    `git status` says "you're up to date with origin/main", it's looking at
      +    this.
     +++
     ++`refs/remotes/<remote>/HEAD` is a symbolic reference to the remote's
     ++default branch. This is the branch that `git clone` checks out by default.
      +
      +[[other-refs]]
      +Other references::
     @@ Documentation/gitdatamodel.adoc (new)
      ++
      +Git may also create references other than `HEAD` at the base of the
      +hierarchy, like `ORIG_HEAD`.
     +++
     ++NOTE: By default, Git references are stored as files in the `.git` directory.
     ++For example, the branch `main` is stored in `.git/refs/heads/main`.
     ++This means that you can't have branches named both `maya` and `maya/some-task`,
     ++because there can't be a file and a directory with the same name.
      +
      +[[index]]
      +THE INDEX
      +---------
      +
     -+The index, also known as the "staging area", contains the current staged
     -+version of every file in your Git repository. When you commit, the files
     -+in the index are used as the files in the next commit.
     ++The index, also known as the "staging area", contains a list of every
     ++file in the repository and its contents. When you commit, the files in
     ++the index are used as the files in the next commit.
     ++
     ++You can add files to the index or update the version in the index with
     ++linkgit:git-add[1]. Adding a file to the index or updating its version
     ++is called "staging" the file for commit.
      +
     -+Unlike a tree, the index is a flat list of files.
     ++Unlike a <<tree,tree>>, the index is a flat list of files.
      +Each index entry has 4 fields:
      +
     -+1. The *permissions*
     ++1. The *<<file-mode,file mode>>*
      +2. The *<<blob,blob>> ID* of the file
     -+3. The *filename*
     -+4. The *stage number*. This is normally 0, but if there's a merge conflict
     -+   there can be multiple versions (with numbers 0, 1, 2, ..)
     -+   of the same filename in the index.
     ++3. The *file path*, for example `src/hello.py`
     ++4. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
     ++   there's a merge conflict there can be multiple versions of the same
     ++   filename in the index.
      +
      +It's extremely uncommon to look at the index directly: normally you'd
      +run `git status` to see a list of changes between the index and <<HEAD,HEAD>>.
     @@ Documentation/gitdatamodel.adoc (new)
      +REFLOGS
      +-------
      +
     -+Git stores the history of your branch, remote-tracking branch, and HEAD refs
     -+in a reflog (you should read "reflog" as "ref log").
     ++Git stores a history called a "reflog" for every branch, remote-tracking
     ++branch, and HEAD. This means that if you make a mistake and "lose" a
     ++commit, you can generally recover the commit ID by running
     ++`git reflog <reference>`.
      +
      +Each reflog entry has:
      +
     @@ Documentation/gitdatamodel.adoc (new)
      +Reflogs only log changes made in your local repository.
      +They are not shared with remotes.
      +
     ++For example, here's how the reflog for `HEAD` in a repository with 2
     ++commits is stored:
     ++
     ++----
     ++0000000000000000000000000000000000000000 4ccb6d7b8869a86aae2e84c56523f8705b50c647 Maya <maya@example.com> 1759173408 -0400      commit (initial): Initial commit
     ++4ccb6d7b8869a86aae2e84c56523f8705b50c647 750b4ead9c87ceb3ddb7a390e6c7074521797fb3 Maya <maya@example.com> 1759173425 -0400      commit: Add README
     ++----
     ++
      +GIT
      +---
      +Part of the linkgit:git[1] suite


 Documentation/Makefile              |   1 +
 Documentation/gitdatamodel.adoc     | 281 ++++++++++++++++++++++++++++
 Documentation/glossary-content.adoc |   4 +-
 Documentation/meson.build           |   1 +
 4 files changed, 285 insertions(+), 2 deletions(-)
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
index 0000000000..f49574dfae
--- /dev/null
+++ b/Documentation/gitdatamodel.adoc
@@ -0,0 +1,281 @@
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
+4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
+
+[[objects]]
+OBJECTS
+-------
+
+Commits, trees, blobs, and tag objects are all stored in Git's object database.
+Every object has:
+
+[[object-id]]
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
+1. All the *files* in the commit, stored as the *<<tree,tree>>* ID of
+   the commit's base directory.
+2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
+  regular commits have 1 parent, merge commits have 2 or more parents
+3. An *author* and the time the commit was authored
+4. A *committer* and the time the commit was committed.
+   If you cherry-pick (linkgit:git-cherry-pick[1]) someone else's commit,
+   then they will be the author and you'll be the committer.
+5. A *commit message*
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
+For example, "amending" a commit with `git commit --amend` creates a new
+commit with the same parent.
++
+Git does not store the diff for a commit: when you ask Git for a
+diff it calculates it on the fly.
+
+[[tree]]
+trees::
+    A tree is how Git represents a directory. It lists, for each item in
+    the tree:
++
+[[file-mode]]
+1. The *file mode*, for example `100644`. The format is inspired by Unix
+   permissions, but Git's modes are much more limited. Git only supports these file modes:
++
+  - `100644`: regular file (with type `blob`)
+  - `100755`: executable file (with type `blob`)
+  - `120000`: symbolic link (with type `blob`)
+  - `040000`: directory (with type `tree`)
+  - `160000`: gitlink, for use with submodules (with type `commit`)
+
+2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
+  or <<commit,`commit`>> (a Git submodule, which is a
+  commit from a different Git repository)
+3. The <<object-id,*object ID*>>
+4. The *filename*
++
+For example, this is how a tree containing one directory (`src`) and one file
+(`README.md`) is stored:
++
+----
+100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
+040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
+----
+
+
+[[blob]]
+blobs::
+    A blob is how Git represents a file. A blob object contains the
+    file's contents.
++
+When you make a new commit, Git only needs to store new versions of
+files which were changed in that commit. This means that commits
+can use relatively little disk space even in a very large repository.
+
+[[tag-object]]
+tag objects::
+    Tag objects contain these required fields
+    (though there are other optional fields):
++
+1. The *ID* and *type* of the object (often a commit) that they reference
+2. The *tagger* and tag date
+3. A *tag message*, similar to a commit message
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
+NOTE: All of the examples in this section were generated with
+`git cat-file -p <object-id>`, which shows the contents of a Git object.
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
+    Tags that reference a commit, blob, or tree ID are
+    called "lightweight tags".
++
+Even though branches and tags are both "a name for a commit ID", Git
+treats them very differently.
+Branches are expected to change over time: when you make a commit, Git
+will update your <<HEAD,current branch>> to reference the new changes.
+Tags are usually not changed after they're created.
+
+[[HEAD]]
+HEAD: `HEAD`::
+    `HEAD` is where Git stores your current <<branch,branch>>.
+    `HEAD` can either be:
+    1. A symbolic reference to your current branch, for example `ref:
+       refs/heads/main` if your current branch is `main`.
+    2. A direct reference to a commit ID. This is called "detached HEAD
+	   state", see the DETACHED HEAD section of linkgit:git-checkout[1] for more.
+
+[[remote-tracking-branch]]
+remote tracking branches: `refs/remotes/<remote>/<branch>`::
+    A remote-tracking branch is a name for a commit ID.
+    It's how Git stores the last-known state of a branch in a remote
+    repository. `git fetch` updates remote-tracking branches. When
+    `git status` says "you're up to date with origin/main", it's looking at
+    this.
++
+`refs/remotes/<remote>/HEAD` is a symbolic reference to the remote's
+default branch. This is the branch that `git clone` checks out by default.
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
++
+NOTE: By default, Git references are stored as files in the `.git` directory.
+For example, the branch `main` is stored in `.git/refs/heads/main`.
+This means that you can't have branches named both `maya` and `maya/some-task`,
+because there can't be a file and a directory with the same name.
+
+[[index]]
+THE INDEX
+---------
+
+The index, also known as the "staging area", contains a list of every
+file in the repository and its contents. When you commit, the files in
+the index are used as the files in the next commit.
+
+You can add files to the index or update the version in the index with
+linkgit:git-add[1]. Adding a file to the index or updating its version
+is called "staging" the file for commit.
+
+Unlike a <<tree,tree>>, the index is a flat list of files.
+Each index entry has 4 fields:
+
+1. The *<<file-mode,file mode>>*
+2. The *<<blob,blob>> ID* of the file
+3. The *file path*, for example `src/hello.py`
+4. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
+   there's a merge conflict there can be multiple versions of the same
+   filename in the index.
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
+Git stores a history called a "reflog" for every branch, remote-tracking
+branch, and HEAD. This means that if you make a mistake and "lose" a
+commit, you can generally recover the commit ID by running
+`git reflog <reference>`.
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
+For example, here's how the reflog for `HEAD` in a repository with 2
+commits is stored:
+
+----
+0000000000000000000000000000000000000000 4ccb6d7b8869a86aae2e84c56523f8705b50c647 Maya <maya@example.com> 1759173408 -0400      commit (initial): Initial commit
+4ccb6d7b8869a86aae2e84c56523f8705b50c647 750b4ead9c87ceb3ddb7a390e6c7074521797fb3 Maya <maya@example.com> 1759173425 -0400      commit: Add README
+----
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
