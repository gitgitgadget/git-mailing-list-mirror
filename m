Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5242EA168
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019651; cv=none; b=FfIcYIhulFEG1oiZSUZpKMRT12t3AO7HL6tFxRmB2McCWOsd7jCUxkvG+yXPfM2R5wtIRXAXVcHoDQUrngAwMYVxiK8wBvYk9o9LpSZBhV0+jQbiNH7vo+KSfgKg5GoyfpEVLkvTCvEcSeb88+1eK1dOUk7pyZ2EWFm5vh+yCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019651; c=relaxed/simple;
	bh=chIUiwYh3aLSLGbv9aIxsLYtOp7yglDbk8V1FZZcIWE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oP9VqkWdnaAbeiLabtQbl9Sh7u+KX2eNdSS6cNLg6sH3xicVHV9xFMv4OEgMLTloWj9bx/HPSn0vFaOOgXugA62neLSvLdPxJkHxUh9rrws+E3MlMbm8kLNuqghiMrmOOZVDn6BjV+NpgaNdJ0FCjufciBUwGWPrRdYurqUe1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=TDYURDIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QdO+i3h5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="TDYURDIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QdO+i3h5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 06DC1EC0209;
	Thu,  9 Oct 2025 10:20:46 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 10:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760019646;
	 x=1760106046; bh=9mAVJVSAX4vKP8vC+CX9bz2r/PBjS9h4gKi81XXUgRM=; b=
	TDYURDInkoBrdUWASFwNqJ3BkPkmWLT0q53/0w1E/wKUcFtPPJIcoT54stprz6M+
	JqwdzV3oAWnymfRcVu7HatlSzd1v3a9Ob6S0akUXYNC1BkaApJrPJD7rWbr3hlRG
	3jNFazMfAy3euBS5WZZYn1EmH8oXVOOT+0YVebrfEnCXgwL4lQMFsKtgjefNwrR5
	bNepU1F/fqg65Q9Lmm6Xu2oazwOHlADD8qaz66hSSQndI7P3oomrzmDbMIrMSiSX
	EVTVSdjBDcoHkz4LwsPuJjhMKTc4yespveVTtA6/VBfRms5NR1Je+yIO+xpqiXwG
	ZRmHEqHNktdy+hXFZGHYTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760019646; x=1760106046; bh=9
	mAVJVSAX4vKP8vC+CX9bz2r/PBjS9h4gKi81XXUgRM=; b=QdO+i3h5OZNFODzQX
	zYISXDr0qgQM3Xo9i3zmoLQKIGdRaNOiGY8AqNuRQfRdR8hJAtLKISgiTPQhrGc2
	jjZFBs5KOnxJ9h7x7LYjRD3kYHg3u3EqJ8+OdVqkRBF8T5iU4z+s33+EnZipHeXH
	H28gUlRcfyhh9oDX6JBpuPe4W6bDo/zVwVSLMP+JxhSWk1nsMJX6uUWnu9Y6DzWW
	NwjYGm7auzgDfhUoGjZb/6JDW0XzI+qi00Aqt7s3DmAp4SzFAMpvYHV1YEwD3Vey
	2iecImgdeeMk32rBb1RHB03GXsg8Z4GbQUfj9G31n1y/NlaWi7z8wb0S89IhAGhA
	YaORw==
X-ME-Sender: <xms:vcTnaH7gfjOr81jhj3-VHtLIpAyhYVwH8PAAkgVm6LfA93BdhKuYow>
    <xme:vcTnaHudbf5rJ6XxPyuMKSqLzd4iLXzGUqSrM2MUQgO1IWG8z3N2ZatVfGRXbHFo4
    oposepBEGKfwOZYjYhhHujVJMgJ1GdZmk9buC7eb-j1hBw1p1i54zM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeigedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedflfhulhhirgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhs
    rdgtrgeqnecuggftrfgrthhtvghrnhepieekleekhfduieduvdeuleegudeivedvueeuve
    ejvdduteeugeegjedugeevtdfhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vcTnaCljWgXxmW3OrTiU1W8AjDQRmgoNzhAmyXGxBxC4tDccUOqzFw>
    <xmx:vcTnaHxXOZz76cD217NT2md9-lW1gP8hVxB4ETWAY18gRmLnDJfj9g>
    <xmx:vcTnaIMlGiHWijVirskk1F3STumgXPsU926-iEk6jmoemuaPzUtXLg>
    <xmx:vcTnaDSWMWJ0-JsHkNXRtHcqjWflvMebzhLvfCqWEWrkUjVnl2vJaw>
    <xmx:vcTnaIflBSOyUaVR2KK19FpTJDnDZT_HODJbm5OcofcY69SbCnQkXZaI>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B13DC780076; Thu,  9 Oct 2025 10:20:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Thu, 09 Oct 2025 10:20:14 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <b2a9b8ca-8f2a-40f0-a724-0da707902985@app.fastmail.com>
In-Reply-To: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I collected some feedback from Git users on this v2 document. I'm expecting more
feedback, but here's an initial brain dump of my notes. I mostly wrote this for
my own use but I thought it might be interesting to other folks too.

intro:
- Say that we're going to explain what "objects", "references" etc are.
  (so that readers know they're not expected to know what those words mean yet)
- It's confusing that tags are both "an object" and "a reference".
  Need to think about whether there's a way to address this, I was hoping
  that using the terms "tag object" and "tag" would be enough but maybe not.
- Give a 1-sentence intro to "reflog" (easy)

commits:
- The order the fields are given in don't match the order in the
  example, maybe they should.
- "All the files in the commit, stored as a tree" is throwing a few
  people off. I think we should communicate something like "a tree hash
  that describes the root of the project and then by extension the whole
  project", but phrased more clearly. Will figure that out.
- "Are commits stored as a diff?" (2 people asked where diffs come
  from, I think we need to add a note saying that diffs are calculated
  at runtime, it's a very common misconception and I think it should
  be easy to clear up)
- "What's the difference between an author and committer?
  (I actually don't know either, will try to find out and see if it's
  straightforward to add a short note explaining it)
- In the note about commits being amended: one person suggested saying
  "creates a new commit with the same parent" which I think might be clearer.

trees:
- One person asks what a "working tree" is.
  I don't think this is a good place for that, but it made me wonder if
  "the current working directory" has a place in this document.
  I feel like no but not 100% sure.
- 2 people want to know more about "The file mode, for example 100644".
  Moving "Git only supports these file modes..." further up so that folks
  can immediately see what the options are here should help with this.
- On "so git-gc(1) periodically compresses objects to save disk space",
  there are a few follow up comments wondering about more, which makes me
  think the comment about compression is actually a distraction.
  I'll say something simpler instead, from Junio's suggestion.


tag objects:
- Requests for an example, will add one.
- Requests to explain the difference between
  "lightweight" and "annotated" tags, will add.

references:

- Two people pointed out that because references are often stored as files,
  you can't have two references named `julia/ticket-number` and
  `julia/ticket-number/task-name`.
  I'm not sure if this is a fundamental limit of the refs data model
  (does the reftable backend have the same limitation?), but it could be
  a good reason to mention that refs are often stored as files, because
  it makes it obvious that you can't have a file and a directory with
  the same name.
  Obviously this is an issue that is affecting people relatively often
  in practice though so I think it's worth mentioning in some way.


branches:

HEAD:
- One person asks if there are any other symbolic references other than HEAD,
  or if they can make their own symbolic references. I don't know and I don't
  know if this is worth mentioning.
- `HEAD: HEAD` looks weird, it made sense when it was `HEAD: .git/HEAD`.
  Will think about how to fix this.
- Several people are asking for more detail about detached HEAD state.
  My current idea here is to just give an example of a way you can end up
  in detached HEAD state. ("by checking out a tag"), but in an ideal world
  it would be easy to find out what it means, how it happens, what it implies,
  and how you might adjust your workflow to avoid it (by using `git switch`).
  But we can't get into all of that here.
  I'd love to just link to a more detailed explanation of detached HEAD state
  but I'm not totally satisfied with the one that's currently in `man git-checkout`.
  It may be best to just leave this in a slightly suboptimal state, write
  a really clear explanation of detached HEAD state somewhere else, and
  then link to it.

the index:
- "permissions" should be "file mode" (like with trees)
- "filename" should be "file path"
- The index can also be locked. Might be worth mentioning.
- This doesn't explain what "staged" means, perhaps mention
  the relationship to `git add`

reflogs
- Mention the role of the reflog in retrieving "lost" commits or
  undoing bad rebases.
- How can you see the full data in the reflog?
  `git reflog show` doesn't list the user who made the change
  git reflog show <refname> --format="%h | %gd | %gn <%ge> | %gs" --date=iso
  works but it's really a mouthful, not sure I want to include all that

Overall: several people suggested mentioning more about where things
are stored in the `.git` directory, which I just removed.

I think I want to avoid this (not sure yet), but I'm going to think
about the underlying motivation for this suggestion and see if it can be
addressed in a different way.

Some ideas for what functions discussing the `.git` directory has:

1. Like I mentioned above with branches, sometimes the implementation causes
   some extra constraints like "you can't have branches `julia/ticket`
   and `julia/ticket/task`". So often people like to know a little
   about the implementation because it can help predict some of the
   holes in the abstractions you're using.
2. It lets you view the "raw" data, so you can be totally sure about
   what Git is storing. This is nice because Git's UI can be very
   inconsistent sometimes, so looking at the raw data gives a sense of
   certainty about what's actually there.

I tried to put together a list of ways to look at the "raw" data without
looking in the `.git` directory. The ways for objects and the index are great,
but for references and the reflog they involve these pretty complex format
strings, I'm not confident I've gotten the format strings right and IMO
they don't inspire a lot of confidence.

View an object with:
----
git cat-file -p <object-id>
----

View a reference with:

----
git for-each-ref <ref-name> --include-root-refs  --format="%(refname) %(if)%(symref)%(then)%(symref)%(else)%(objectname:short)%(end)"
----

View the index with:

----
git ls-files --stage
----

View the reflog for a reference with:

----
git reflog show <refname> --format="%h | %gd | %gn <%ge> | %gs" --date=iso
----


On Fri, Oct 3, 2025, at 1:34 PM, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> Git very often uses the terms "object", "reference", or "index" in its
> documentation.
>
> However, it's hard to find a clear explanation of these terms and how
> they relate to each other in the documentation. The closest candidates
> currently are:
>
> 1. `gitglossary`. This makes a good effort, but it's an alphabetically
>     ordered dictionary and a dictionary is not a good way to learn
>     concepts. You have to jump around too much and it's not possible to
>     present the concepts in the order that they should be explained.
> 2. `gitcore-tutorial`. This explains how to use the "core" Git commands.
>    This is a nice document to have, but it's not necessary to learn how
>    `update-index` works to understand Git's data model, and we should
>    not be requiring users to learn how to use the "plumbing" commands
>    if they want to learn what the term "index" or "object" means.
> 3. `gitrepository-layout`. This is a great resource, but it includes a
>    lot of information about configuration and internal implementation
>    details which are not related to the data model. It also does
>    not explain how commits work.
>
> The result of this is that Git users (even users who have been using
> Git for 15+ years) struggle to read the documentation because they don't
> know what the core terms mean, and it's not possible to add links
> to help them learn more.
>
> Add an explanation of Git's data model. Some choices I've made in
> deciding what "core data model" means:
>
> 1. Omit pseudorefs like `FETCH_HEAD`, because it's not clear to me
>    if those are intended to be user facing or if they're more like
>    internal implementation details.
> 2. Don't talk about submodules other than by mentioning how they
>    relate to trees. This is because Git has a lot of special features,
>    and explaining how they all work exhaustively could quickly go
>    down a rabbit hole which would make this document less useful for
>    understanding Git's core behaviour.
> 3. Don't discuss the structure of a commit message
>    (first line, trailers, GPG signatures, etc).
>    Perhaps this should change.
>
> Some other choices I've made:
>
> 1. Mention packed refs only in a note.
> 2. Don't mention that the full name of the branch `main` is
>    technically `refs/heads/main`. This should likely change but I
>    haven't worked out how to do it in a clear way yet.
> 3. Mostly avoid referring to the `.git` directory, because the exact
>    details of how things are stored change over time.
>    This should perhaps change from "mostly" to "entirely"
>    but I haven't worked out how to do that in a clear way yet.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>     doc: Add a explanation of Git's data model
>
> Published-As: 
> https://github.com/gitgitgadget/git/releases/tag/pr-1981%2Fjvns%2Fgitdatamodel-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
> pr-1981/jvns/gitdatamodel-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1981
>
>  Documentation/Makefile          |   1 +
>  Documentation/gitdatamodel.adoc | 226 ++++++++++++++++++++++++++++++++
>  2 files changed, 227 insertions(+)
>  create mode 100644 Documentation/gitdatamodel.adoc
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6fb83d0c6e..5f4acfacbd 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -52,6 +52,7 @@ MAN7_TXT += gitcli.adoc
>  MAN7_TXT += gitcore-tutorial.adoc
>  MAN7_TXT += gitcredentials.adoc
>  MAN7_TXT += gitcvs-migration.adoc
> +MAN7_TXT += gitdatamodel.adoc
>  MAN7_TXT += gitdiffcore.adoc
>  MAN7_TXT += giteveryday.adoc
>  MAN7_TXT += gitfaq.adoc
> diff --git a/Documentation/gitdatamodel.adoc 
> b/Documentation/gitdatamodel.adoc
> new file mode 100644
> index 0000000000..4b2cb167dc
> --- /dev/null
> +++ b/Documentation/gitdatamodel.adoc
> @@ -0,0 +1,226 @@
> +gitdatamodel(7)
> +===============
> +
> +NAME
> +----
> +gitdatamodel - Git's core data model
> +
> +DESCRIPTION
> +-----------
> +
> +It's not necessary to understand Git's data model to use Git, but it's
> +very helpful when reading Git's documentation so that you know what it
> +means when the documentation says "object" "reference" or "index".
> +
> +Git's core operations use 4 kinds of data:
> +
> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
> +2. <<references,References>>: branches, tags,
> +   remote-tracking branches, etc
> +3. <<index,The index>>, also known as the staging area
> +4. <<reflogs,Reflogs>>
> +
> +[[objects]]
> +OBJECTS
> +-------
> +
> +Commits, trees, blobs, and tag objects are all stored in Git's object 
> database.
> +Every object has:
> +
> +1. an *ID*, which is the SHA-1 hash of its contents.
> +  It's fast to look up a Git object using its ID.
> +  The ID is usually represented in hexadecimal, like
> +  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
> +2. a *type*. There are 4 types of objects:
> +   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
> +   and <<tag-object,tag objects>>.
> +3. *contents*. The structure of the contents depends on the type.
> +
> +Once an object is created, it can never be changed.
> +Here are the 4 types of objects:
> +
> +[[commit]]
> +commits::
> +    A commit contains:
> ++
> +1. Its *parent commit ID(s)*. The first commit in a repository has 0 
> parents,
> +  regular commits have 1 parent, merge commits have 2+ parents
> +2. A *commit message*
> +3. All the *files* in the commit, stored as a *<<tree,tree>>*
> +4. An *author* and the time the commit was authored
> +5. A *committer* and the time the commit was committed
> ++
> +Here's how an example commit is stored:
> ++
> +----
> +tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
> +parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
> +author Maya <maya@example.com> 1759173425 -0400
> +committer Maya <maya@example.com> 1759173425 -0400
> +
> +Add README
> +----
> ++
> +Like all other objects, commits can never be changed after they're 
> created.
> +For example, "amending" a commit with `git commit --amend` creates a 
> new commit.
> +The old commit will eventually be deleted by `git gc`.
> +
> +[[tree]]
> +trees::
> +    A tree is how Git represents a directory. It lists, for each item 
> in
> +    the tree:
> ++
> +1. The *permissions*, for example `100644`
> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
> +  or <<commit,`commit`>> (a Git submodule)
> +3. The *object ID*
> +4. The *filename*
> ++
> +For example, this is how a tree containing one directory (`src`) and 
> one file
> +(`README.md`) is stored:
> ++
> +----
> +100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
> +040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
> +----
> ++
> +*NOTE:* The permissions are in the same format as UNIX permissions, but
> +the only allowed permissions for files (blobs) are 644 and 755.
> +
> +[[blob]]
> +blobs::
> +    A blob is how Git represents a file. A blob object contains the
> +    file's contents.
> ++
> +Storing a new blob for every new version of a file can get big, so
> +`git gc` periodically compresses objects for efficiency in 
> `.git/objects/pack`.
> +
> +[[tag-object]]
> +tag objects::
> +    Tag objects (also known as "annotated tags") contain:
> ++
> +1. The *tagger* and tag date
> +2. A *tag message*, similar to a commit message
> +3. The *ID* of the object (often a commit) that they reference
> +
> +[[references]]
> +REFERENCES
> +----------
> +
> +References are a way to give a name to a commit.
> +It's easier to remember "the changes I'm working on are on the `turtle`
> +branch" than "the changes are in commit bb69721404348e".
> +Git often uses "ref" as shorthand for "reference".
> +
> +References that you create are stored in the `.git/refs` directory,
> +and Git has a few special internal references like `HEAD` that are 
> stored
> +in the base `.git` directory.
> +
> +References can either be:
> +
> +1. References to an object ID, usually a <<commit,commit>> ID
> +2. References to another reference. This is called a "symbolic 
> reference".
> +
> +Git handles references differently based on which subdirectory of
> +`.git/refs` they're stored in.
> +Here are the main types:
> +
> +[[branch]]
> +branches: `.git/refs/heads/<name>`::
> +    A branch is a name for a commit ID.
> +    That commit is the latest commit on the branch.
> +    Branches are stored in the `.git/refs/heads/` directory.
> ++
> +To get the history of commits on a branch, Git will start at the commit
> +ID the branch references, and then look at the commit's parent(s),
> +the parent's parent, etc.
> +
> +[[tag]]
> +tags: `.git/refs/tags/<name>`::
> +    A tag is a name for a commit ID, tag object ID, or other object ID.
> +    Tags are stored in the `refs/tags/` directory.
> ++
> +Even though branches and commits are both "a name for a commit ID", Git
> +treats them very differently.
> +Branches are expected to be regularly updated as you work on the 
> branch,
> +but it's expected that a tag will never change after you create it.
> +
> +[[HEAD]]
> +HEAD: `.git/HEAD`::
> +    `HEAD` is where Git stores your current <<branch,branch>>.
> +    `HEAD` is normally a symbolic reference to your current branch, for
> +    example `ref: refs/heads/main` if your current branch is `main`.
> +    `HEAD` can also be a direct reference to a commit ID,
> +    that's called "detached HEAD state".
> +
> +[[remote-tracking-branch]]
> +remote tracking branches: `.git/refs/remotes/<remote>/<branch>`::
> +    A remote-tracking branch is a name for a commit ID.
> +    It's how Git stores the last-known state of a branch in a remote
> +    repository. `git fetch` updates remote-tracking branches. When
> +    `git status` says "you're up to date with origin/main", it's 
> looking at
> +    this.
> +
> +[[other-refs]]
> +Other references::
> +    Git tools may create references in any subdirectory of `.git/refs`.
> +    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
> +    and linkgit:git-notes[1] all create their own references
> +    in `.git/refs/stash`, `.git/refs/bisect`, etc.
> +    Third-party Git tools may also create their own references.
> ++
> +Git may also create references in the base `.git` directory
> +other than `HEAD`, like `ORIG_HEAD`.
> +
> +*NOTE:* As an optimization, references may be stored as packed
> +refs instead of in `.git/refs`. See linkgit:git-pack-refs[1].
> +
> +[[index]]
> +THE INDEX
> +---------
> +
> +The index, also known as the "staging area", contains the current 
> staged
> +version of every file in your Git repository. When you commit, the 
> files
> +in the index are used as the files in the next commit.
> +
> +Unlike a tree, the index is a flat list of files.
> +Each index entry has 4 fields:
> +
> +1. The *permissions*
> +2. The *<<blob,blob>> ID* of the file
> +3. The *filename*
> +4. The *number*. This is normally 0, but if there's a merge conflict
> +   there can be multiple versions (with numbers 0, 1, 2, ..)
> +   of the same filename in the index.
> +
> +It's extremely uncommon to look at the index directly: normally you'd
> +run `git status` to see a list of changes between the index and 
> <<HEAD,HEAD>>.
> +But you can use `git ls-files --stage` to see the index.
> +Here's the output of `git ls-files --stage` in a repository with 2 
> files:
> +
> +----
> +100644 8728a858d9d21a8c78488c8b4e70e531b659141f 0 README.md
> +100644 665c637a360874ce43bf74018768a96d2d4d219a 0 src/hello.py
> +----
> +
> +[[reflogs]]
> +REFLOGS
> +-------
> +
> +Git stores the history of branch, tag, and HEAD refs in a reflog
> +(you should read "reflog" as "ref log"). Not every ref is logged by
> +default, but any ref can be logged.
> +
> +Each reflog entry has:
> +
> +1. *Before/after *commit IDs*
> +2. *User* who made the change, for example `Maya <maya@example.com>`
> +3. *Timestamp*
> +4. *Log message*, for example `pull: Fast-forward`
> +
> +Reflogs only log changes made in your local repository.
> +They are not shared with remotes.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
>
> base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
> -- 
> gitgitgadget
