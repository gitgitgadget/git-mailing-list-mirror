Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0B2C9D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847540; cv=none; b=H9g9n+/J/EJKlHZrQGE7ZkJwxZZVSdyT3SPsGaQ5Tr2vGza0pU6A/9pUDMXBTRED9bOaPcoyZkTU24EILQwvgXjx7nV1k0pS7Xm7qcKvjxICgqk9JCaon7WSsdzyxg3l7VrRIIoD94O1kwePxoIUSFZ/7H04F+4KYkzRSn8beyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847540; c=relaxed/simple;
	bh=6KpnbSeB1Hwrd1VrmXgZlP5Ul06xwFwcv/dKio4AJ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt4j6S3Xcaz7vBBElkYIMeinOJ9UtJi6q3XwJBpuJtyPaPZ2EYn8w4zyPt3Ftgo52UqW5VEgXpZsCrOARyTX2F+EPTi88QHp8RFD9RH/Wr8mo08/94gDKqmkJvW3B5EVaq4szuAvzacAdWiSgCzibnMgsYzPU4VScuGXeFdUxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=STMlYg4E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCTR+39j; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="STMlYg4E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCTR+39j"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D73B0EC0040;
	Tue,  7 Oct 2025 10:32:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 10:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759847536; x=1759933936; bh=OPgql2LvKU
	3k2vUX/HvtCC4efH85PShtJa44g/HuGw0=; b=STMlYg4EDq/9gqYQdLr0dm8Etc
	Bv9hqsIRxSrcJ5WhWXzh9O7xBHtYWkM4ev47npRnN19k92qpn7syIZMu7A3N5j8Z
	u0JCH9lcqmqUvQJQ1Gmxy+yCEEXLyJ/d2bL2/67fs3ntjyUQVaLx7JfPMNB72ybs
	3PnOwLL2IXpxM8Mkiw2QG5SYcNHIO0XBNHLTBqjQpllcGR/U7Ctjj9NIt1j2umwa
	Llc0QhifHmQR7JIbufjMQ+JeDOZ9iciIV2dz5IChWRQk5ZkNhpovYiPCHPHUbB2U
	lisxKD5heUXA03uQ3OAZpubXxOuuz+hF3rMHtstt7twQ6sFZpcsTSqLj8RQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759847536; x=1759933936; bh=OPgql2LvKU3k2vUX/HvtCC4efH85PShtJa4
	4g/HuGw0=; b=XCTR+39j0u+allgdPIf7JWyCZHKmV9GVSAaoO+/uVA91QUWuY7O
	eHr1OVJJSXg+JpAXdqaCKTv41GQ9gGp4lE+nwOS62LLhFuU8HvAo4IIHPgViyFLM
	4F3t/TtVAm8Xg4h2PRf1dZZx3TTpgM6EJ+JS9CQ0lbW6nkLGFuNFz/IQi3Zb0ip9
	mKZ75pPYNV00ryaiOlikQCBUpojLfUjLmWTuYM1BBXNqXvrp5V00S2SQclaQ3p1e
	LziJ6XoWQ8zKES1MN1YlUnV1q8fB9gFiXV0ZgbRgAdIyYwPmf09/tGC/dg3FEsKC
	Tb1PzlXCLZ7Recb1BamQmp98aLiYqFvMYxA==
X-ME-Sender: <xms:cCTlaPfcvnZxADb-NkKipdrrDbrh6LBqk6wnmjqCO1d0QzAYFkur9g>
    <xme:cCTlaMr2T6HlMuUyoD_hUa0iI_QFWCWDQTKSXy_JR0DY06RFlq2cuq7CRUg6CgN8j
    oXTZ-xvE5jGmPy_T1T6XhEOU4yjNbWgCwiLmWcb6tmhGB1GqX4Z6A>
X-ME-Received: <xmr:cCTlaF6Ye2mDuAZShXq3g_oeFP-BxhzHBKm23PzmmDCpLg-yEhatNPoel8xvtCIHo1OcklMZmXRM06Y6_JwNNCgxuySBSZH_FffgknpCYgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:cCTlaKrX9td4doRbJAXm_FlIJuvEuPx7n6g2crsnDpM_uJWS8bCp6g>
    <xmx:cCTlaPgK9mBigm3CGdn2yrdrKyvFRuJ1RzJHw6xAiG5r4IltUgttcw>
    <xmx:cCTlaML8zo2DKnIeB4wUGhLLqEylQ-9edIwYCSo0BjvqKT9dOl1E6Q>
    <xmx:cCTlaHD04gQVHE3VH8WzMSNxV9IfIULcRnD6hkuiK0QGeeSbZt4alQ>
    <xmx:cCTlaIpBgLFqG-qnCPjCDTLMxXMXwkp4AeMiETEQ101JD7JC1YJD83GZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 10:32:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ec0eb1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 14:32:14 +0000 (UTC)
Date: Tue, 7 Oct 2025 16:32:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Message-ID: <aOUkZa4_fq1hho7Q@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>

On Fri, Oct 03, 2025 at 05:34:36PM +0000, Julia Evans via GitGitGadget wrote:
> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
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

There's a missing comma after "object".

> +
> +Git's core operations use 4 kinds of data:
> +
> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
> +2. <<references,References>>: branches, tags,
> +   remote-tracking branches, etc
> +3. <<index,The index>>, also known as the staging area
> +4. <<reflogs,Reflogs>>

This list makes sense to me. There's of course more data structures in
Git, but all the other data structures shouldn't really matter to users
at all as they are mostly caches or internal details of the on-disk
format.

There's potentially one exception though, namely the Git configuration.
I'd claim that Git "uses" the Git configuration similarly to how it uses
the others, but I get why it's not explicitly mentioned here.

> +[[objects]]
> +OBJECTS
> +-------
> +
> +Commits, trees, blobs, and tag objects are all stored in Git's object database.
> +Every object has:
> +
> +1. an *ID*, which is the SHA-1 hash of its contents.

I think this needs to be adapted to not single out SHA-1 as the only
hashing algorithm. We already support SHA-256, so we should definitely
say that the algorithm can be swapped. Maybe something like:

  An *object ID*, which is the cryptographic hash of its contents. By
  default, Git uses SHA-1 as object hash, but alternative hashes like
  SHA-256 are supported.

> +  It's fast to look up a Git object using its ID.
> +  The ID is usually represented in hexadecimal, like
> +  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
> +2. a *type*. There are 4 types of objects:
> +   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
> +   and <<tag-object,tag objects>>.
> +3. *contents*. The structure of the contents depends on the type.

Nit: every object also has an object size. Not sure though whether it's
fine to imply that with "contents".

> +Once an object is created, it can never be changed.
> +Here are the 4 types of objects:
> +
> +[[commit]]
> +commits::
> +    A commit contains:
> ++
> +1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
> +  regular commits have 1 parent, merge commits have 2+ parents

I'd say "at least two parents" instead of "2+ parents".

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

In practice, commits can have other headers that are ignored by Git. But
that's certainly not part of Git's core data model, so I don't think we
should mention that here.

> +Like all other objects, commits can never be changed after they're created.
> +For example, "amending" a commit with `git commit --amend` creates a new commit.
> +The old commit will eventually be deleted by `git gc`.

If we mention git-gc(1) I think it would make sense to use
`linkgit:git-gc[1]` instead to provide a link to its man page.

> +[[tree]]
> +trees::
> +    A tree is how Git represents a directory. It lists, for each item in
> +    the tree:
> ++
> +1. The *permissions*, for example `100644`

I think we should rather call these "mode bits". These bits are
permissions indeed when you have a blob, but for subtrees, symlinks and
submodules they aren't.

> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
> +  or <<commit,`commit`>> (a Git submodule)

There's also symlinks.

> +3. The *object ID*
> +4. The *filename*
> ++
> +For example, this is how a tree containing one directory (`src`) and one file
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
> +`git gc` periodically compresses objects for efficiency in `.git/objects/pack`.

I would claim that it's not necessary to mention object compression.
This should be a low-level detail that users don't ever have to worry
about. Furthermore, packing objects isn't only relevant in the context
of blobs: trees for example also tend to compress very well as there
typically is only small incremental updates to trees.

> +[[tag-object]]
> +tag objects::
> +    Tag objects (also known as "annotated tags") contain:
> ++
> +1. The *tagger* and tag date
> +2. A *tag message*, similar to a commit message
> +3. The *ID* of the object (often a commit) that they reference

They can also be signed, if we want to mention that.

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
> +and Git has a few special internal references like `HEAD` that are stored
> +in the base `.git` directory.

This isn't true anymore with the introduction of the reftable backend,
which is slated to become the default backend. I'd argue that this is
another implementation detail that the user shouldn't have to worry
about.

> +References can either be:
> +
> +1. References to an object ID, usually a <<commit,commit>> ID
> +2. References to another reference. This is called a "symbolic reference".
> +
> +Git handles references differently based on which subdirectory of
> +`.git/refs` they're stored in.

So instead of saying "subdirectory", I'd rather say "reference
hierarchy".

In general, I think we should explain that references are layed out
in a hierarchy. This is somewhat obvious with the "files" backend, as we
use directories there. But as we move on to the "reftable" backend this
may become less obvious over time.

> +Here are the main types:
> +
> +[[branch]]
> +branches: `.git/refs/heads/<name>`::

Here and in the other cases we should then strip the `.git/` prefix.

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
> +Branches are expected to be regularly updated as you work on the branch,
> +but it's expected that a tag will never change after you create it.

This sounds a bit like the user itself needs to update the branch. How
about this instead:

    Even though branches and commits are both "a name for a commit ID", Git
    treats them very differently:

        - Branches can be checked out directly. If so, creating a new
          commit will automatically update the checked-out branch to
          point to the new commit.

        - Tags cannot be checked out directly and don't move when
          creating a new commit. Instead, one can only check out the
          commit that a branch points to. This is called "detached
          HEAD", and the effect is that a new commit will not update 

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
> +    `git status` says "you're up to date with origin/main", it's looking at
> +    this.

This misses "refs/remotes/<remote>/HEAD". This reference is a symbolic
reference that indicates the default branch on the remote side.

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

Let's mention that such references are typically spelt all-uppercase
with underscores between. You shouldn't ever create a reference that is
for example called ".git/foo".

We enforce this restriction inconsistently, only, but I don't think that
should keep us from spelling out the common rule.

> +*NOTE:* As an optimization, references may be stored as packed
> +refs instead of in `.git/refs`. See linkgit:git-pack-refs[1].

I'd drop this note. It's an internal implementation detail and only true
for the "files" backend. The "reftable" backend stores references quite
differently and doesn't really "pack" references.

> +[[index]]
> +THE INDEX
> +---------
> +
> +The index, also known as the "staging area", contains the current staged

Honestly, I always forget which of these two nouns we are supposed to
use nowadays. I think consensus was to use "index" and avoid using
"staging area"? Not sure though, but I think we should only mention
one of these.

> +version of every file in your Git repository. When you commit, the files
> +in the index are used as the files in the next commit.
> +
> +Unlike a tree, the index is a flat list of files.
> +Each index entry has 4 fields:
> +
> +1. The *permissions*
> +2. The *<<blob,blob>> ID* of the file
> +3. The *filename*
> +4. The *number*. This is normally 0, but if there's a merge conflict

I think we don't call this "number", but "stage".

> +   there can be multiple versions (with numbers 0, 1, 2, ..)
> +   of the same filename in the index.
> +
> +It's extremely uncommon to look at the index directly: normally you'd
> +run `git status` to see a list of changes between the index and <<HEAD,HEAD>>.
> +But you can use `git ls-files --stage` to see the index.
> +Here's the output of `git ls-files --stage` in a repository with 2 files:
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

If we mention this here, do we maybe want to mention how the user can
decide which references are logged?

> +Each reflog entry has:
> +
> +1. *Before/after *commit IDs*

This will probably misformat as we have three asterisks here, not two.

> +2. *User* who made the change, for example `Maya <maya@example.com>`
> +3. *Timestamp*

Suggestion: "*Timestamp* when that change has been made".

> +4. *Log message*, for example `pull: Fast-forward`
> +
> +Reflogs only log changes made in your local repository.
> +They are not shared with remotes.

We may want ot mention that you can reference reflog entries via
`refs/heads/<branch>@{<reflog-nr>}`.

In general, one thing that I think would be important to highlight in
this document is revisions. Most of the commands tend to not accept
references, but revisions instead, which are a lot more flexible. They
use our do-what-I-mean mechanism to resolve, but also allow the user to
specify commits relative to one another. It's probably sufficient though
to mention them briefly and then redirect to girevisions(7).

Thanks for working on this!

Patrick
