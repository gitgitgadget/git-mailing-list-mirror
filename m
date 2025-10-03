Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738B227EA4
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759528039; cv=none; b=Mb5KQ9ljTBRB6FLI/SFeC4S4YGbNYZeZSfbDbs2fnTugg2YL4X0D+BrQK9oaTlBZ50JOpjBSoE6ehutdvvxe2v4gkVU0WbxSzxhc6Ker1YKllihkOzqhRPwqPtwwhzbgkeuPqb5S+CbIQg8SS4bD1I61yJtjZK2kNKMywzTetzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759528039; c=relaxed/simple;
	bh=6heGvP/XmrlRov4YRGiQlYhWRIZEEB93C4D5BQBUizQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AjM8aEhkly87PYDgOe3wNaa7oC8oiPlswTAzv91V/Qkh9v1ck0zCoXTvnj4y/lIvZTdKLikrQsDuXD1a8an0BI6EWQWHtxec8XZ9WdycEX5XuCuruoDRakbGhQZQ2nbWp0TA403TkFuK77Eme9RgV+IamIp987Bkz8cxvEDPOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=L2SHA62N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xrbQ52LJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="L2SHA62N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrbQ52LJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FB7AEC0689;
	Fri,  3 Oct 2025 17:47:15 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 03 Oct 2025 17:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759528035;
	 x=1759614435; bh=QncpdYS7MJIP62SXqUdbYtn42znD/CXMIVKcX8tBMzA=; b=
	L2SHA62NnTXvJo8HC0kbvCTTJPpf5OhoZrBrIDF1Wf1uxSpeL2o9D4AL3ASqonhK
	gZlh1xFY/x2r5j9skXAf72nhO1llKoTUZ4+EZQq/+wB42SKTNrw2nFKPvl+3H5To
	4YPmhCMLfwJlYIyQjDLI+hNLoTWgOrXmpNzlwi8QzfyV9LHZmuxNlho+wpDYFqnJ
	RkjmY0FyIWLoERDgfGSheFbZPQw+Zqrj1xjn3vdBnfE/X/dMN6o6qRYQIZbd3zb9
	XoOgRdNtahhw1tqirr6MDvf6zhUCvPwRTDuvJfhukGtNTgemTKriL9TuOsm3zhIt
	1R2kiM2qFYBb5KUZ8ENxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759528035; x=
	1759614435; bh=QncpdYS7MJIP62SXqUdbYtn42znD/CXMIVKcX8tBMzA=; b=x
	rbQ52LJWkScm4xESkU4emgYrEJl8xi66dsskh8UJ9jIV+6Qp1GJ9g/HCURTqx/JI
	SbxBMo5DVwp+aCc2cmpz3zacLArPDeKRfXipB+tJFVGCwkwLwLDig45M5ay68H2C
	p6H6nF6ounO+SuNghVrSG6lZk/sOHbqQTuMdo446ZGczVWylLy1NxtjIETYOCMK+
	0SAzrCiQsnxkAETtfRsaTbzyXfKn68GfaFn3uSCdkYCo/IIGY73UvWk36dQkFWKO
	pqJFExe5KbG5v3qhmXgQyl+CmEkipdjbNK7DEQYl56cGYme0cpj5McRT2XtFT409
	1SkBLjQ6dl4WHD4D99e6g==
X-ME-Sender: <xms:Y0TgaKlocVGv6Mf3wLahLC8TQyhZxw7eWSaQ5EZOH6BhbFLTQINHmHM>
    <xme:Y0TgaMo5rHYkBOurkCG1kjFHT4QCkXQG1nAbkOwNbRzBOcz0miJxbIm1aUhea8gqx
    _rLOEGuQ5l0Tvpe2jLZrV6R5Oc1xK1jSyeP7E7QMtZdqIRfN1S6Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeltddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y0TgaPgSuOhNcer2Mxa9HWANukSGNeDW8ay--LT4bO1yvrQynIWKJg>
    <xmx:Y0TgaDxn1eyyp6TByUVuiah4-0oZXyrY-i6xRMfwbVldtZqVTYGiig>
    <xmx:Y0TgaCJYTi94NSZLSQyjPnVFnMOnPFteYlmv5aSGz9Zt6oCIG2cM_A>
    <xmx:Y0TgaKSTc02jIWkb_s2VKScwMYELyX5G9PBklmjK7zLQfTgX7s-B6A>
    <xmx:Y0TgaPc68KDkc37d9gsx5E16KnQE4BT1s9udmkddMiyh2_sOE76IqXV9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1BF481EA006B; Fri,  3 Oct 2025 17:47:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Asrm_GTbWIKg
Date: Fri, 03 Oct 2025 23:46:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Julia Evans" <julia@jvns.ca>
Message-Id: <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com>
In-Reply-To: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025, at 19:34, Julia Evans via GitGitGadget wrote:
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
> 2. `gitcore-tutorial`. This explains how to use the "core" Git command=
s.
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
> Git for 15+ years) struggle to read the documentation because they don=
't
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

I don=E2=80=99t think it=E2=80=99s worth mentioning this at all.  More o=
n that later.

> 2. Don't mention that the full name of the branch `main` is
>    technically `refs/heads/main`. This should likely change but I
>    haven't worked out how to do it in a clear way yet.

I think this is worth getting into.  This is a pretty
user-facing concept.

> 3. Mostly avoid referring to the `.git` directory, because the exact
>    details of how things are stored change over time.
>    This should perhaps change from "mostly" to "entirely"
>    but I haven't worked out how to do that in a clear way yet.

I think that=E2=80=99s good.  I mean, I think us users don=E2=80=99t nee=
d that level of
detail and shouldn=E2=80=99t be =E2=80=9Cinspired=E2=80=9D to muck with =
the internals.  If that
makes sense.  (See later)

>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>     doc: Add a explanation of Git's data model
>[snip]
> diff --git a/Documentation/Makefile b/Documentation/Makefile
>[snip]
> diff --git a/Documentation/gitdatamodel.adoc
> b/Documentation/gitdatamodel.adoc
> new file mode 100644
> index 0000000000..4b2cb167dc
> --- /dev/null
> +++ b/Documentation/gitdatamodel.adoc
> @@ -0,0 +1,226 @@
> +gitdatamodel(7)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

I haven=E2=80=99t gone hunting through the docs to see if this is covered
elsewhere.  But the thrust of all the things here definitely feel to me
like something that should be presented and documented in such a way.

> +
> +Git's core operations use 4 kinds of data:

Maybe small numerals should be spelled as words in running text?

> +
> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
> +2. <<references,References>>: branches, tags,
> +   remote-tracking branches, etc
> +3. <<index,The index>>, also known as the staging area
> +4. <<reflogs,Reflogs>>

Reflogs is certainly auxiliary ref data. What makes it qualify as
one-of-the-four?  I am open to it being both, to be clear.

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

As a curious Git user this seems correct.

> +
> +[[commit]]
> +commits::
> +    A commit contains:
> ++
> +1. Its *parent commit ID(s)*. The first commit in a repository has 0
> parents,

Maybe this is a subjective style thing but is it necessary to use =E2=80=
=9C(s)=E2=80=9D
when the context makes clear that it could be zero to many?

    Its *parent commit IDs. ...

> +  regular commits have 1 parent, merge commits have 2+ parents

s/2+/two or more/ ?

Same point as the =E2=80=9Cnumeral=E2=80=9D one above.

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

Maybe this could be moved to a part about what happens (eventually) to
unreachable objects?

Mentioning `git gc` and how things will get deleted raises
questions naturally. Like why would they be deleted? Okay
that=E2=80=99s clear: the previous commit will be replaced by the
amended one. Then when it is not reachable by anything
(even the reflog) it will get garbage collected.

It all follows. But is the reader necessarily mature enough
in their understanding to make the inference?

This is a long-winded way of saying: if you=E2=80=99re gonna discuss
`git gc` you might need to go into all of these concepts.

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
> +*NOTE:* The permissions are in the same format as UNIX permissions, b=
ut
> +the only allowed permissions for files (blobs) are 644 and 755.
> +

Makes sense.

> +[[blob]]
> +blobs::
> +    A blob is how Git represents a file. A blob object contains the
> +    file's contents.
> ++
> +Storing a new blob for every new version of a file can get big, so
> +`git gc` periodically compresses objects for efficiency in
> `.git/objects/pack`.

This gets into mentioning implementation files(?) like you mentioned in
the commit message.

1. That it=E2=80=99s a packfile and where it is might be too much detail=
 for
   this doc
2. I vaguely recall documents discussing what happens to =E2=80=9Cstorin=
g every
   version=E2=80=9D discussing deltas instead of packs? Again, I am not =
a Git
   developer though.

> +
> +[[tag-object]]
> +tag objects::
> +    Tag objects (also known as "annotated tags") contain:
> ++
> +1. The *tagger* and tag date
> +2. A *tag message*, similar to a commit message
> +3. The *ID* of the object (often a commit) that they reference

s/often/typically/ ?

I know it can get tedious to caveat the 99% cases with things that are
technically possible.  Maybe if it gets =E2=80=9Cbad enough=E2=80=9D the=
re could be a
part that explains/distinguishes the high-level/porcelain Git use and
what is technically possible: you make a `git tag -a`, which is on a
commit... except if you accidentally run it on top of an existing
tag. Then even the porcelain won=E2=80=99t protect you from making a=20
tag-on-tag. (But it will issue a warning I guess.) Hmm. Now I don=E2=80=99=
t know.

> +
> +[[references]]
> +REFERENCES
> +----------
> +
> +References are a way to give a name to a commit.
> +It's easier to remember "the changes I'm working on are on the `turtl=
e`
> +branch" than "the changes are in commit bb69721404348e".
> +Git often uses "ref" as shorthand for "reference".

Good.

> +
> +References that you create are stored in the `.git/refs` directory,
> +and Git has a few special internal references like `HEAD` that are
> stored
> +in the base `.git` directory.

Implementation file details.

You also mention `.git/refs/heads/<name>` below.  But refs aren=E2=80=99=
t stored
as files if you are using the *reftable* backend.  And that backend will
become the default for new repositories in Git 3.0, I think.

How does reftable work?  I don=E2=80=99t know.  But I don=E2=80=99t thin=
k we need to
know after reading this doc. :)

To be clear: how files are stored might not matter here.

> +
> +References can either be:
> +
> +1. References to an object ID, usually a <<commit,commit>> ID
> +2. References to another reference. This is called a "symbolic
> reference".

You seem to have used `**` when introducing terms:

    This is a *symbolic reference*

>[snip ref stuff]
> +
> +[[HEAD]]
> +HEAD: `.git/HEAD`::
> +    `HEAD` is where Git stores your current <<branch,branch>>.
> +    `HEAD` is normally a symbolic reference to your current branch, f=
or
> +    example `ref: refs/heads/main` if your current branch is `main`.
> +    `HEAD` can also be a direct reference to a commit ID,
> +    that's called "detached HEAD state".
> +
> +[[remote-tracking-branch]]
> +remote tracking branches: `.git/refs/remotes/<remote>/<branch>`::
> +    A remote-tracking branch is a name for a commit ID.
> +    It's how Git stores the last-known state of a branch in a remote
> +    repository. `git fetch` updates remote-tracking branches. When
> +    `git status` says "you're up to date with origin/main", it's look=
ing at
> +    this.

Looks good.

> +
> +[[other-refs]]
> +Other references::
> +    Git tools may create references in any subdirectory of `.git/refs=
`.
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

I don=E2=80=99t know if this is relevant for both ref backends. And does=
 it
matter?

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

You=E2=80=99ve heard of the re-flog too?

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

Makes sense.

> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

I appreciate that this is the first version and you might have plans
after this one. But I wonder if this doc could use a fair number of
`gitlink` to branch out to all the other parts. Like git-reflog(1),
gitglossary(7).

Thanks for starting on a whole new doc. That must take quite
some effort.
