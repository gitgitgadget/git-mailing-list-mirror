Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AD3009DA
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545183; cv=none; b=q5gn9cAomshiVZ1fNYQQWxLND6LoVDKybGX+XttrZgPjU/aZ7/03gS3ZtbILJxuT+H4hIjJjNGyLdhcTSanFG6PTghtv/xHPmY79YZh4sZhgORH2ZfX2viMWITVlU5o6FiuSHA0dQiWl5zYtzQTTn+Wz7hZW5z+UtKt8xGFzZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545183; c=relaxed/simple;
	bh=WKtYoZCwi87KaRHfP58FzH+FAfR20tq+YtgNOG9P5xY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bHvqXZhRqmSRZ56kKTd1OJel6RZuSSHFNilysM2TQQdYg/GqI8WhuZnpHBfZ0dvKM5tQICklL7TbpbnQfurD7PXP21+pGq8/vs4M9lSEHK6M1loiMdgir0li4Ls0B0qvdUls+CP8QjWSar5PGjlC/fB6T3JHof3CEq+7dYGNAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rly4XrLo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rly4XrLo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so976807b3a.2
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762545179; x=1763149979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HpaM7E7cSIyIA+4dH6mRGdQwL+9dIxAr6G5dFU/Dhw=;
        b=Rly4XrLo38tI9t0+VjAcwukLCG4/uYepoeCIPZtJLOf8frseVIGsd5xAtUgqH1OqU2
         qLwaZO1beoijCNMJNHJsZv2TbeLyUCBE9fStTuGkX4+qsMd2UFbe7bW/ZNSUieXCBtig
         uyYB+Tvb8ZkqO+HGZDLm9yepXw5iZGw3pGSz1iKhsDwAG9wlN6xcWu+kG7MfclzNihCb
         6WNVTdDRCvFpYyJCliab+ggxwyPxhVCl51iG7+GTJwJCVnw+m9RSoZw+Wr9f7SD/J35C
         v3zEcLVjbYu/tc7UB/o3bCno3IucU5gsgCYaDqEC9YOSLC8OaMsUgj9wN1TnAJJMtk8G
         Brlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762545179; x=1763149979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+HpaM7E7cSIyIA+4dH6mRGdQwL+9dIxAr6G5dFU/Dhw=;
        b=mgCO6xa/ovthfazKaN6i6aGDCMl8SOKN7TuUK/gR/ZhGXZmHSHAV1arojfP9VTkWCP
         Nw4qSGCobBjg2lD9/oHlw0ECRPrqQZuaoXu+MA6D+i3lkKQncj1l4LAD9kBKhfn99WNQ
         /1qdhZSr8TFW7Yc1y4NF0hmE+NGsURfqxc91qK+A8hTqdRbu+jCc7YyTZhqWlVkE3TpK
         kSdLYmn/zhMLSzjMlIlqr7z46stIWsz5TEBI/23RXaBVVW0XT4uSRyTwUM8vdyZMQw33
         +P6+Ussq25hqlW/qcqtQKMLg4R9DRGEOkZ/EDK4ee2sE4MMnMNT1G7O+vp9lAPKs/qWu
         C87Q==
X-Gm-Message-State: AOJu0YxkBLiuBoA2s6eBj2E4EDy2w9UsQNY8NbNs9IiaAMQgk98WQi8Y
	SQbeVD3pGQIqhFcodtyO1rRy/mWxGF13v6RFEJ6ofUcozVpeeWHF2HFeljQTddxa
X-Gm-Gg: ASbGncswNghU6CgPePGIvJnqzXQvIhJT9GMwTSDHMqPdB+IJK69WeU6D8fSyatEFtZA
	Zn2mQmRiN7q4Bd4bzzOFoFVcx5jVqWpZ/6WAbMlAHDiifxrZxzLVsv5h5BbMZkKN+y46dfPshhI
	cfTxF3JM8XjOe0dUAFhWqHcGPyZ717e226HkAj2HDY6kjB4IfjKs5K29CWMR6l8YEVFy6MkN2/z
	XFq1W5qQZrgTNPOC6QIJRkOHYHGPkggQMu1JLVA9bT4F86C0/lWWd09SDKKXKt3DlZTrhO8kXDE
	dSHVDfDKRswERHQ296NIvEKxSYZKS90FQ5mJ9v5ObmIv0IaoqDutbugfoLq+ug/PFpMqXWGtV63
	ffXeDTE2P8N8NBNn+Crtb0OKGlKFyxAKI/QyoFsksQJwSF0Sw3YZxv6r/5hw1FN0Fmw0mpUN7iI
	s72QI=
X-Google-Smtp-Source: AGHT+IH2Tt7/A5LNCSenNiS9p2iXAGh3ld9geUANDLhoZePD81oemxqGEAF/WksgVB+CrI72YVf6Uw==
X-Received: by 2002:a05:6a21:3290:b0:341:78fa:1514 with SMTP id adf61e73a8af0-353a375f586mr400119637.34.1762545178795;
        Fri, 07 Nov 2025 11:52:58 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902ba5d10sm5854874a12.35.2025.11.07.11.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:52:58 -0800 (PST)
Message-Id: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
In-Reply-To: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
References: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Nov 2025 19:52:57 +0000
Subject: [PATCH v6] doc: add an explanation of Git's data model
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
    
    changes in v4:
    
    This is a combination of trying to make some of the intro text a little
    more "friendly" for someone new to Git's data model, avoiding implying
    things that are false, and removing information that isn't relevant to
    the data model.
    
    intro:
    
     * Add a 1-line description of what a "reflog" is (from user feedback)
    
    objects:
    
     * Start with a "friendly" description of what an object is, similar to
       what we do for references and the reflog
     * Rename "commits" to "commit" and similarly for trees etc (from
       Junio's review)
     * Remove the explanation of what git cat-file -p does, since it might
       be misleading and if people want to know they can read the man page
       (from Junio's review)
    
    commits:
    
     * Start by saying that the commit contains the full directory structure
       of all the files (from Junio's comment about how it may not be clear
       that the commit contains all the files' exact contents at the time of
       the commit)
     * Remove the comment about cherry-pick (from Junio's review)
     * Replace "ask Git for a diff" with "ask Git to show the commit with
       git show" (from Junio's review)
    
    trees:
    
     * Make the description a little more friendly
     * Reorder so that "type" is defined before we refer to the "type"
     * Say that file modes are "only spiritually related" to Unix
       permissions instead of talking about what Git "supports" (from
       Junio's review)
    
    blobs:
    
     * Try to make it clearer how "commits use relatively little disk space"
       is true while not implying that commits are diffs, by using an
       example (from Junio's review)
    
    branches:
    
     * Replace "a branch is a name for a commit ID" with "a branch refers to
       a commit ID" (except in the intro sentence for the "references"
       section). Similarly for tags etc. (from Junio's review)
     * Remove the note about how branches are stored in .git (from Junio's
       review)
    
    HEAD:
    
     * Be clearer that HEAD is not always the current branch, because there
       may not be a current branch (from Junio's review)
    
    index:
    
     * Be a little more specific about how exactly the index is converted
       into a commit. (from Junio's comment about how it's not clear what
       "every file in the repository" means)
    
    reflog:
    
     * Be clearer that there are many reflogs (one for each reference with a
       log), not just one reflog (from Junio and Patrick's reviews)
     * Omit the user and "Before" commit IDs from the list of fields,
       because you usually don't see them (from Junio's review)
     * Show the output of git reflog main in the example instead of the
       contents of the reflog file, to avoid showing the user and before
       commit ID
    
    changes in v5:
    
    Mostly smaller tweaks this time. The only major addition is to add a
    note about how unreachable objects may be deleted.
    
    From Junio's review:
    
     * Remove "type" in the description of what's in a tree (since I have
       learned that is not a separate field, it's part of the file mode)
     * Fix a typo ("these these")
     * Remove the intro sentence about what a "commit" is and instead only
       describe its contents in the list of fields, to avoid implying that a
       commit is the same as a tree
     * Say "Unix file modes" instead of "Unix permissions"
     * In the tag objects contents: make "ID" and "type" separate list items
       since they're separate fields
     * in the index section:
       * list all of the possible file modes (since from my understanding
         there are fewer allowed file modes here than in a tree)
       * mention that the object can be either a commit or blob
       * make the order match the order in git ls-files
    
    changes in v6:
    
     * Make punctuation more consistent (from Patrick's review)
     * Explain more about when exactly amended commits will get deleted
       (when their reflog entry expires), from Junio's review
     * Be more explicit that there are only 5 file modes in Git (from
       Junio's review)
     * Make tag object description clearer (from Junio's review)
     * We had a long discussion about the phrasing of "A branch refers to a
       commit ID" but I didn't come up with any ideas for how to improve the
       phrasing so I left it as is.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1981%2Fjvns%2Fgitdatamodel-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1981/jvns/gitdatamodel-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1981

Range-diff vs v5:

 1:  d342255dad ! 1:  6e2a7bbe6b doc: add an explanation of Git's data model
     @@ Documentation/gitdatamodel.adoc (new)
      ++
      +1. The full directory structure of all the files in that version of the
      +   repository and each file's contents, stored as the *<<tree,tree>>* ID
     -+   of the commit's base directory.
     ++   of the commit's base directory
      +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
      +  regular commits have 1 parent, merge commits have 2 or more parents
      +3. An *author* and the time the commit was authored
     -+4. A *committer* and the time the commit was committed.
     ++4. A *committer* and the time the commit was committed
      +5. A *commit message*
      ++
      +Here's how an example commit is stored:
     @@ Documentation/gitdatamodel.adoc (new)
      +    It lists, for each item in the tree:
      ++
      +1. The *filename*, for example `hello.py`
     -+2. The *file mode*. Git has these file modes. which are only
     -+   spiritually related to Unix file modes:
     ++2. The *file mode*. These are all of the file modes in Git.
     ++   They're only spiritually related to Unix file modes.
      ++
      +  - `100644`: regular file (with <<object,object type>> `blob`)
      +  - `100755`: executable file (with type `blob`)
     @@ Documentation/gitdatamodel.adoc (new)
      +    Tag objects contain these required fields
      +    (though there are other optional fields):
      ++
     -+1. The object *ID* it references
     -+2. The object *type*
     ++1. The *ID* of the object it references
     ++2. The *type* of the object it references
      +3. The *tagger* and tag date
      +4. A *tag message*, similar to a commit message
      +
     @@ Documentation/gitdatamodel.adoc (new)
      +References can either refer to:
      +
      +1. An object ID, usually a <<commit,commit>> ID
     -+2. Another reference. This is called a "symbolic reference".
     ++2. Another reference. This is called a "symbolic reference"
      +
      +References are stored in a hierarchy, and Git handles references
      +differently based on where they are in the hierarchy.
     @@ Documentation/gitdatamodel.adoc (new)
      +Git may also create references other than `HEAD` at the base of the
      +hierarchy, like `ORIG_HEAD`.
      +
     -+NOTE: Git may delete objects that aren't "reachable" from any reference.
     ++NOTE: Git may delete objects that aren't "reachable" from any reference
     ++or <<reflogs,reflog>>.
      +An object is "reachable" if we can find it by following tags to whatever
      +they tag, commits to their parents or trees, and trees to the trees or
      +blobs that they contain.
     -+For example, if you amend a commit, with `git commit --amend`,
     ++For example, if you amend a commit with `git commit --amend`,
     ++there will no longer be a branch that points at the old commit.
     ++The old commit is recorded in the current branch's <<reflogs,reflog>>,
     ++so it is still "reachable", but when the reflog entry expires it may
     ++become unreachable and get deleted.
     ++
      +the old commit will usually not be reachable, so it may be deleted eventually.
      +Reachable objects will never be deleted.
      +


 Documentation/Makefile              |   1 +
 Documentation/gitdatamodel.adoc     | 302 ++++++++++++++++++++++++++++
 Documentation/glossary-content.adoc |   4 +-
 Documentation/meson.build           |   1 +
 4 files changed, 306 insertions(+), 2 deletions(-)
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
index 0000000000..b54ff0e52b
--- /dev/null
+++ b/Documentation/gitdatamodel.adoc
@@ -0,0 +1,302 @@
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
+All of the commits and files in a Git repository are stored as "Git objects".
+Git objects never change after they're created, and every object has an ID,
+like `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
+
+This means that if you have an object's ID, you can always recover its
+exact contents as long as the object hasn't been deleted.
+
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
+Here's how each type of object is structured:
+
+[[commit]]
+commit::
+    A commit contains these required fields
+    (though there are other optional fields):
++
+1. The full directory structure of all the files in that version of the
+   repository and each file's contents, stored as the *<<tree,tree>>* ID
+   of the commit's base directory
+2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
+  regular commits have 1 parent, merge commits have 2 or more parents
+3. An *author* and the time the commit was authored
+4. A *committer* and the time the commit was committed
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
+Git does not store the diff for a commit: when you ask Git to show
+the commit with linkgit:git-show[1], it calculates the diff from its
+parent on the fly.
+
+[[tree]]
+tree::
+    A tree is how Git represents a directory.
+    It can contain files or other trees (which are subdirectories).
+    It lists, for each item in the tree:
++
+1. The *filename*, for example `hello.py`
+2. The *file mode*. These are all of the file modes in Git.
+   They're only spiritually related to Unix file modes.
++
+  - `100644`: regular file (with <<object,object type>> `blob`)
+  - `100755`: executable file (with type `blob`)
+  - `120000`: symbolic link (with type `blob`)
+  - `040000`: directory (with type `tree`)
+  - `160000`: gitlink, for use with submodules (with type `commit`)
+
+3. The <<object-id,*object ID*>> with the contents of the file or directory
++
+For example, this is how a tree containing one directory (`src`) and one file
+(`README.md`) is stored:
++
+----
+100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
+040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
+----
+
+[[blob]]
+blob::
+    A blob object contains a file's contents.
++
+When you make a commit, Git stores the full contents of each file that
+you changed as a blob.
+For example, if you have a commit that changes 2 files in a repository
+with 1000 files, that commit will create 2 new blobs, and use the
+previous blob ID for the other 998 files.
+This means that commits can use relatively little disk space even in a
+very large repository.
+
+[[tag-object]]
+tag object::
+    Tag objects contain these required fields
+    (though there are other optional fields):
++
+1. The *ID* of the object it references
+2. The *type* of the object it references
+3. The *tagger* and tag date
+4. A *tag message*, similar to a commit message
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
+`git cat-file -p <object-id>`.
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
+References can either refer to:
+
+1. An object ID, usually a <<commit,commit>> ID
+2. Another reference. This is called a "symbolic reference"
+
+References are stored in a hierarchy, and Git handles references
+differently based on where they are in the hierarchy.
+Most references are under `refs/`. Here are the main types:
+
+[[branch]]
+branches: `refs/heads/<name>`::
+    A branch refers to a commit ID.
+    That commit is the latest commit on the branch.
++
+To get the history of commits on a branch, Git will start at the commit
+ID the branch references, and then look at the commit's parent(s),
+the parent's parent, etc.
+
+[[tag]]
+tags: `refs/tags/<name>`::
+    A tag refers to a commit ID, tag object ID, or other object ID.
+    There are two types of tags:
+    1. "Annotated tags", which reference a <<tag-object,tag object>> ID
+       which contains a tag message
+    2. "Lightweight tags", which reference a commit, blob, or tree ID
+       directly
++
+Even though branches and tags both refer to a commit ID, Git
+treats them very differently.
+Branches are expected to change over time: when you make a commit, Git
+will update your <<HEAD,current branch>> to point to the new commit.
+Tags are usually not changed after they're created.
+
+[[HEAD]]
+HEAD: `HEAD`::
+    `HEAD` is where Git stores your current <<branch,branch>>,
+    if there is a current branch. `HEAD` can either be:
++
+1. A symbolic reference to your current branch, for example `ref:
+   refs/heads/main` if your current branch is `main`.
+2. A direct reference to a commit ID. In this case there is no current branch.
+   This is called "detached HEAD state", see the DETACHED HEAD section
+   of linkgit:git-checkout[1] for more.
+
+[[remote-tracking-branch]]
+remote-tracking branches: `refs/remotes/<remote>/<branch>`::
+    A remote-tracking branch refers to a commit ID.
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
+
+NOTE: Git may delete objects that aren't "reachable" from any reference
+or <<reflogs,reflog>>.
+An object is "reachable" if we can find it by following tags to whatever
+they tag, commits to their parents or trees, and trees to the trees or
+blobs that they contain.
+For example, if you amend a commit with `git commit --amend`,
+there will no longer be a branch that points at the old commit.
+The old commit is recorded in the current branch's <<reflogs,reflog>>,
+so it is still "reachable", but when the reflog entry expires it may
+become unreachable and get deleted.
+
+the old commit will usually not be reachable, so it may be deleted eventually.
+Reachable objects will never be deleted.
+
+[[index]]
+THE INDEX
+---------
+The index, also known as the "staging area", is a list of files and
+the contents of each file, stored as a <<blob,blob>>.
+You can add files to the index or update the contents of a file in the
+index with linkgit:git-add[1]. This is called "staging" the file for commit.
+
+Unlike a <<tree,tree>>, the index is a flat list of files.
+When you commit, Git converts the list of files in the index to a
+directory <<tree,tree>> and uses that tree in the new <<commit,commit>>.
+
+Each index entry has 4 fields:
+
+1. The *file mode*, which must be one of:
+  - `100644`: regular file (with <<object,object type>> `blob`)
+  - `100755`: executable file (with type `blob`)
+  - `120000`: symbolic link (with type `blob`)
+  - `160000`: gitlink, for use with submodules (with type `commit`)
+2. The *<<blob,blob>>* ID of the file,
+   or (rarely) the *<<commit,commit>>* ID of the submodule
+3. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
+   there's a merge conflict there can be multiple versions of the same
+   filename in the index.
+4. The *file path*, for example `src/hello.py`
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
+Every time a branch, remote-tracking branch, or HEAD is updated, Git
+updates a log called a "reflog" for that <<references,reference>>.
+This means that if you make a mistake and "lose" a commit, you can
+generally recover the commit ID by running `git reflog <reference>`.
+
+A reflog is a list of log entries. Each entry has:
+
+1. The *commit ID*
+2. *Timestamp* when the change was made
+3. *Log message*, for example `pull: Fast-forward`
+
+Reflogs only log changes made in your local repository.
+They are not shared with remotes.
+
+You can view a reflog with `git reflog <reference>`.
+For example, here's the reflog for a `main` branch which has changed twice:
+
+----
+$ git reflog main --date=iso --no-decorate
+750b4ea main@{2025-09-29 15:17:05 -0400}: commit: Add README
+4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
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
