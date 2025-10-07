Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F541AAC
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863362; cv=none; b=D4fWNI05u9j/EEn5dYZmUMeCJs1nu2AfsLzpAq50+ImWSyyfR5MfVQaD5dNPfDhiSDzX1rdnOIFXBOkn7nTKJHZh4XY0Fxw5IMBlCTYdEgpe1+METMvyptyeug9Ov5N9vo0DGSqqMqvjfZ/zVW7kBMo2Q0rWd9UPZa8hyLJDdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863362; c=relaxed/simple;
	bh=yC19XhUADTo9jP3YibXf68SZ8qt2rQ2LKSZUmTN+g/o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YUwS6QjrYdkERL3pSY9vZA4iLY3c/LBTH7dgydfM3/ObPFxOIIQre48cLZOxHAxQuC3Mh0hbKJIXgPIlpAPC+nvo8qVdzRQ3Ncpb6RJls9eivGpFCmxkXkSX7nuPdB7qTX4jM7Sp0nAN5OS8xQePRvlqIOvdHavNloi+pBWrzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=WObc9eKL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhBT7Z49; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="WObc9eKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhBT7Z49"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 385B714001A4;
	Tue,  7 Oct 2025 14:55:58 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 14:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759863358;
	 x=1759949758; bh=wLP6IUmdJgzzGiJ2vEhWMmV14RnFkBjjpxDCCVWR+5Y=; b=
	WObc9eKLBJ/qHPiBLJlfJ/Fnwx/f8MMS3mhkkPmp2GVZNDbz4u6gLJyeEzGbN/Cl
	LhYFZxUqfLIAo6PK11FXz1+X+3VGRUio5igo73ip/99IF0YQnCgHle0ITv/Eck6r
	zAwnKkQqgu7k5wlqTStbO7rayV9ruS+uHFojUnJb5w0BQTBwG2ba1o1mkga0qcXI
	iPbIL556BPi2SdB1vZWjL3VlUNnVHwNrxDIdC2GB1Lka2u/91WVTXn4R99OnTQoT
	q/092wsrJF6zv0GFcZTKN5v43mMDoIJ7V1mCB235VlJBY8JD0Q+24tahap6WJmJY
	NLdDUspPPoxqvyeovhfNEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759863358; x=
	1759949758; bh=wLP6IUmdJgzzGiJ2vEhWMmV14RnFkBjjpxDCCVWR+5Y=; b=M
	hBT7Z49bU2soS6iFYZDCRZJp8JfHdGIqjUvO4t35aRdhoL0BSE1lyJKoz3d0oNS1
	xX9HG94c94AYt/58vDh5O5Jt4RM/UPtlY6e4FqmNFmujZUS9tOiyel3oIpnN6/ok
	leT9kNHUYTiUkqGsk7kU8SuI13smu4lh6BvURP6eeAUGL98qJyIVS1tro/1+QnaF
	B4Vvkzq0tlc0+xMpH3jhADVPnRBd/7Y4s5RbIYs49IzkYlfDy/bv1+m9ekpRLUSn
	M1pXUAxhFj6q5IP1QU3nFA6Otb1C87VfTPgd37uRPT7UT9iBNBtruTxtvtghgcKg
	qnRxeDdlUKPnMgIPsyFzw==
X-ME-Sender: <xms:PWLlaPQwSGAmuKDmnRkdxWTRjDnjxtzVGP0nlKOK-AvjeaV_hcgtvw>
    <xme:PWLlaLnjNm9zZ0VJyK8-qaBMq8lqCAr9CL64afGR14G8Aw_F98YDwF-UupCqQi8OS
    k78QEeEqKoDRH3E-RZYOVlz0kA_fhig1TGvIW04I2AO8Wt4D1DCBYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdduudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epteejveehjeejudfhvefggeegtdetueeikeffuedtgfeggedugfekieduffetgeelnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PWLlaKszdEfQHMi3TmBxAO0wWTpaKyu8uGP_O4KH_syG0hNgGMUsBw>
    <xmx:PWLlaHMlVKeI55ZSGSeYxvuSDZ0XJ0YnwwO9OPNwiVZGSjZyV68tVQ>
    <xmx:PWLlaI2_3oLhxWlRLcxxn5UjYMzueH_4ec_JlSBXKmf7GcLTNOAMXA>
    <xmx:PWLlaDO-fb9zNTvppMMTiZy_nFso-5OKiiL8h8gE4_OZXUOtKlRFDw>
    <xmx:PmLlaHJpcjQrFRVXYlQHSMeIJ-k31iKbxXivKI4xZvcz_gPtJS-HMK4B>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DAFA178012B; Tue,  7 Oct 2025 14:55:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Tue, 07 Oct 2025 14:55:37 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <dbf0727d-66bf-4698-aa21-d69da86027c3@app.fastmail.com>
In-Reply-To: <aOUkZa4_fq1hho7Q@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <aOUkZa4_fq1hho7Q@pks.im>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Oct 7, 2025, at 10:32 AM, Patrick Steinhardt wrote:
> On Fri, Oct 03, 2025 at 05:34:36PM +0000, Julia Evans via GitGitGadget wrote:
>> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
>> new file mode 100644
>> index 0000000000..4b2cb167dc
>> --- /dev/null
>> +++ b/Documentation/gitdatamodel.adoc
>> @@ -0,0 +1,226 @@
>> +gitdatamodel(7)
>> +===============
>> +
>> +NAME
>> +----
>> +gitdatamodel - Git's core data model
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +It's not necessary to understand Git's data model to use Git, but it's
>> +very helpful when reading Git's documentation so that you know what it
>> +means when the documentation says "object" "reference" or "index".
>
> There's a missing comma after "object".

Will fix.

>> +
>> +Git's core operations use 4 kinds of data:
>> +
>> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
>> +2. <<references,References>>: branches, tags,
>> +   remote-tracking branches, etc
>> +3. <<index,The index>>, also known as the staging area
>> +4. <<reflogs,Reflogs>>
>
> This list makes sense to me. There's of course more data structures in
> Git, but all the other data structures shouldn't really matter to users
> at all as they are mostly caches or internal details of the on-disk
> format.
>
> There's potentially one exception though, namely the Git configuration.
> I'd claim that Git "uses" the Git configuration similarly to how it uses
> the others, but I get why it's not explicitly mentioned here.
>
>> +[[objects]]
>> +OBJECTS
>> +-------
>> +
>> +Commits, trees, blobs, and tag objects are all stored in Git's object database.
>> +Every object has:
>> +
>> +1. an *ID*, which is the SHA-1 hash of its contents.
>
> I think this needs to be adapted to not single out SHA-1 as the only
> hashing algorithm. We already support SHA-256, so we should definitely
> say that the algorithm can be swapped. Maybe something like:
>
>   An *object ID*, which is the cryptographic hash of its contents. By
>   default, Git uses SHA-1 as object hash, but alternative hashes like
>   SHA-256 are supported.

Makes sense. I might just say "cryptographic hash of its type and contents"
and leave it that. I'm not sure it's worth getting into details
of the exact hash function.

>> +  It's fast to look up a Git object using its ID.
>> +  The ID is usually represented in hexadecimal, like
>> +  `1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a`.
>> +2. a *type*. There are 4 types of objects:
>> +   <<commit,commits>>, <<tree,trees>>, <<blob,blobs>>,
>> +   and <<tag-object,tag objects>>.
>> +3. *contents*. The structure of the contents depends on the type.
>
> Nit: every object also has an object size. Not sure though whether it's
> fine to imply that with "contents".

I think it is.

>> +Once an object is created, it can never be changed.
>> +Here are the 4 types of objects:
>> +
>> +[[commit]]
>> +commits::
>> +    A commit contains:
>> ++
>> +1. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
>> +  regular commits have 1 parent, merge commits have 2+ parents
>
> I'd say "at least two parents" instead of "2+ parents".
>
>> +2. A *commit message*
>> +3. All the *files* in the commit, stored as a *<<tree,tree>>*
>> +4. An *author* and the time the commit was authored
>> +5. A *committer* and the time the commit was committed
>> ++
>> +Here's how an example commit is stored:
>> ++
>> +----
>> +tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
>> +parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
>> +author Maya <maya@example.com> 1759173425 -0400
>> +committer Maya <maya@example.com> 1759173425 -0400
>> +
>> +Add README
>> +----
>
> In practice, commits can have other headers that are ignored by Git. But
> that's certainly not part of Git's core data model, so I don't think we
> should mention that here.
>
>> +Like all other objects, commits can never be changed after they're created.
>> +For example, "amending" a commit with `git commit --amend` creates a new commit.
>> +The old commit will eventually be deleted by `git gc`.
>
> If we mention git-gc(1) I think it would make sense to use
> `linkgit:git-gc[1]` instead to provide a link to its man page.

Agreed.

>> +[[tree]]
>> +trees::
>> +    A tree is how Git represents a directory. It lists, for each item in
>> +    the tree:
>> ++
>> +1. The *permissions*, for example `100644`
>
> I think we should rather call these "mode bits". These bits are
> permissions indeed when you have a blob, but for subtrees, symlinks and
> submodules they aren't.

I think it's a bit strange to call them mode bits since I thought they were stored
as ASCII strings and it's basically an enum of 5 options, but I see your point.
I think "file mode" will work and that's used elsewhere.

I wonder if it would make sense to list all of the possible file modes if
this isn't documented anywhere else, my impression is that it's a short
list and that it's unlikely to change much in the future.

And listing them all might make it more clear that Git's file modes don't
have much in common with Unix file modes.
I looked for where this is documented and it looks like the only place is
in `man git-fast-import` . That man page says that there are just 5 options
(040000, 160000, 100644, 100755, 120000)

>> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
>> +  or <<commit,`commit`>> (a Git submodule)
>
> There's also symlinks.

I created a test symlink and it looks like symlinks are stored as type "blob".
I might say which type corresponds to which file mode,
though I'm not sure what type corresponds to the "gitlink" mode (commit?).

I think these are the 5 modes and what they mean / what type they
should have. Not sure about the gitlink mode though.

  - `100644`: regular file (with type `blob`)
  - `100755`: executable file (with type `blob`)
  - `120000`: symbolic link (with type `blob`)
  - `040000`: directory (with type `tree`)
  - `160000`: gitlink, for use with submodules (with type `commit`)

>> +3. The *object ID*
>> +4. The *filename*
>> ++
>> +For example, this is how a tree containing one directory (`src`) and one file
>> +(`README.md`) is stored:
>> ++
>> +----
>> +100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
>> +040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
>> +----
>> ++
>> +*NOTE:* The permissions are in the same format as UNIX permissions, but
>> +the only allowed permissions for files (blobs) are 644 and 755.
>> +
>> +[[blob]]
>> +blobs::
>> +    A blob is how Git represents a file. A blob object contains the
>> +    file's contents.
>> ++
>> +Storing a new blob for every new version of a file can get big, so
>> +`git gc` periodically compresses objects for efficiency in `.git/objects/pack`.
>
> I would claim that it's not necessary to mention object compression.
> This should be a low-level detail that users don't ever have to worry
> about. Furthermore, packing objects isn't only relevant in the context
> of blobs: trees for example also tend to compress very well as there
> typically is only small incremental updates to trees.

I discussed why I think this important in another reply,
https://lore.kernel.org/all/51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com/,
will paste what I said here. I'll think about this more though.

paste follows:

That's true! The reason I think this is important to mention is that I find
that people often "reject" information that they find implausible, even
if it comes from a credible source. ("that can't be true! I must be
not understanding correctly. Oh well, I'll just ignore that!")

I sometimes hear from users that "commits can't be snapshots", because
it would take up too much disk space to store every version of
every commit. So I find that sometimes explaining a little bit about the
implementation can make the information more memorable.

Certainly I'm not able to remember details that don't make sense
with my mental model of how computers work and I don't expect other
people to either, so I think it's important to give an explanation that
handles the biggest "objections".

>> +[[tag-object]]
>> +tag objects::
>> +    Tag objects (also known as "annotated tags") contain:
>> ++
>> +1. The *tagger* and tag date
>> +2. A *tag message*, similar to a commit message
>> +3. The *ID* of the object (often a commit) that they reference
>
> They can also be signed, if we want to mention that.

I guess that's true for commit objects too. Not sure whether to
mention it either, can add it if others think it's important.

>> +[[references]]
>> +REFERENCES
>> +----------
>> +
>> +References are a way to give a name to a commit.
>> +It's easier to remember "the changes I'm working on are on the `turtle`
>> +branch" than "the changes are in commit bb69721404348e".
>> +Git often uses "ref" as shorthand for "reference".
>> +
>> +References that you create are stored in the `.git/refs` directory,
>> +and Git has a few special internal references like `HEAD` that are stored
>> +in the base `.git` directory.
>
> This isn't true anymore with the introduction of the reftable backend,
> which is slated to become the default backend. I'd argue that this is
> another implementation detail that the user shouldn't have to worry
> about.

Makes sense, will fix. (as well as other references to the .git prefix and
"subdirectories").

>> +References can either be:
>> +
>> +1. References to an object ID, usually a <<commit,commit>> ID
>> +2. References to another reference. This is called a "symbolic reference".
>> +
>> +Git handles references differently based on which subdirectory of
>> +`.git/refs` they're stored in.
>
> So instead of saying "subdirectory", I'd rather say "reference
> hierarchy".
>
> In general, I think we should explain that references are layed out
> in a hierarchy. This is somewhat obvious with the "files" backend, as we
> use directories there. But as we move on to the "reftable" backend this
> may become less obvious over time.

That makes sense.

>> +[[tag]]
>> +tags: `.git/refs/tags/<name>`::
>> +    A tag is a name for a commit ID, tag object ID, or other object ID.
>> +    Tags are stored in the `refs/tags/` directory.
>> ++
>> +Even though branches and commits are both "a name for a commit ID", Git
>> +treats them very differently.
>> +Branches are expected to be regularly updated as you work on the branch,
>> +but it's expected that a tag will never change after you create it.
>
> This sounds a bit like the user itself needs to update the branch. How
> about this instead:
>
>     Even though branches and commits are both "a name for a commit ID", Git
>     treats them very differently:
>
>         - Branches can be checked out directly. If so, creating a new
>           commit will automatically update the checked-out branch to
>           point to the new commit.
>
>         - Tags cannot be checked out directly and don't move when
>           creating a new commit. Instead, one can only check out the
>           commit that a branch points to. This is called "detached
>           HEAD", and the effect is that a new commit will not update 

I think mentioning that branches can be checked out and that tags can't
is a good idea.

>> +[[HEAD]]
>> +HEAD: `.git/HEAD`::
>> +    `HEAD` is where Git stores your current <<branch,branch>>.
>> +    `HEAD` is normally a symbolic reference to your current branch, for
>> +    example `ref: refs/heads/main` if your current branch is `main`.
>> +    `HEAD` can also be a direct reference to a commit ID,
>> +    that's called "detached HEAD state".
>> +
>> +[[remote-tracking-branch]]
>> +remote tracking branches: `.git/refs/remotes/<remote>/<branch>`::
>> +    A remote-tracking branch is a name for a commit ID.
>> +    It's how Git stores the last-known state of a branch in a remote
>> +    repository. `git fetch` updates remote-tracking branches. When
>> +    `git status` says "you're up to date with origin/main", it's looking at
>> +    this.
>
> This misses "refs/remotes/<remote>/HEAD". This reference is a symbolic
> reference that indicates the default branch on the remote side.

Is "refs/remotes/<remote>/HEAD" a remote-tracking branch?
I've never thought about that reference and I'm not sure what to call it.

>> +[[other-refs]]
>> +Other references::
>> +    Git tools may create references in any subdirectory of `.git/refs`.
>> +    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
>> +    and linkgit:git-notes[1] all create their own references
>> +    in `.git/refs/stash`, `.git/refs/bisect`, etc.
>> +    Third-party Git tools may also create their own references.
>> ++
>> +Git may also create references in the base `.git` directory
>> +other than `HEAD`, like `ORIG_HEAD`.
>
> Let's mention that such references are typically spelt all-uppercase
> with underscores between. You shouldn't ever create a reference that is
> for example called ".git/foo".
>
> We enforce this restriction inconsistently, only, but I don't think that
> should keep us from spelling out the common rule.

That makes sense. I'm also not sure whether third-party
Git tools are "supposed" to create references outside of "refs/",
or whether that's common. 

>> +*NOTE:* As an optimization, references may be stored as packed
>> +refs instead of in `.git/refs`. See linkgit:git-pack-refs[1].
>
> I'd drop this note. It's an internal implementation detail and only true
> for the "files" backend. The "reftable" backend stores references quite
> differently and doesn't really "pack" references.
>
>> +[[index]]
>> +THE INDEX
>> +---------
>> +
>> +The index, also known as the "staging area", contains the current staged
>
> Honestly, I always forget which of these two nouns we are supposed to
> use nowadays. I think consensus was to use "index" and avoid using
> "staging area"? Not sure though, but I think we should only mention
> one of these.
>
>> +version of every file in your Git repository. When you commit, the files
>> +in the index are used as the files in the next commit.
>> +
>> +Unlike a tree, the index is a flat list of files.
>> +Each index entry has 4 fields:
>> +
>> +1. The *permissions*
>> +2. The *<<blob,blob>> ID* of the file
>> +3. The *filename*
>> +4. The *number*. This is normally 0, but if there's a merge conflict
>
> I think we don't call this "number", but "stage".

Thanks, I see that it's sometimes called "stage number" which is a little
easier to search for so I'll call it that.

>> +   there can be multiple versions (with numbers 0, 1, 2, ..)
>> +   of the same filename in the index.
>> +
>> +It's extremely uncommon to look at the index directly: normally you'd
>> +run `git status` to see a list of changes between the index and <<HEAD,HEAD>>.
>> +But you can use `git ls-files --stage` to see the index.
>> +Here's the output of `git ls-files --stage` in a repository with 2 files:
>> +
>> +----
>> +100644 8728a858d9d21a8c78488c8b4e70e531b659141f 0 README.md
>> +100644 665c637a360874ce43bf74018768a96d2d4d219a 0 src/hello.py
>> +----
>> +
>> +[[reflogs]]
>> +REFLOGS
>> +-------
>> +
>> +Git stores the history of branch, tag, and HEAD refs in a reflog
>> +(you should read "reflog" as "ref log"). Not every ref is logged by
>> +default, but any ref can be logged.
>
> If we mention this here, do we maybe want to mention how the user can
> decide which references are logged?

Do you mean by using the setting `core.logAllRefUpdates`?

>> +Each reflog entry has:
>> +
>> +1. *Before/after *commit IDs*
>
> This will probably misformat as we have three asterisks here, not two.
>
>> +2. *User* who made the change, for example `Maya <maya@example.com>`
>> +3. *Timestamp*
>
> Suggestion: "*Timestamp* when that change has been made".

Makes sense.

>> +4. *Log message*, for example `pull: Fast-forward`
>> +
>> +Reflogs only log changes made in your local repository.
>> +They are not shared with remotes.
>
> We may want ot mention that you can reference reflog entries via
> `refs/heads/<branch>@{<reflog-nr>}`.
>
> In general, one thing that I think would be important to highlight in
> this document is revisions. Most of the commands tend to not accept
> references, but revisions instead, which are a lot more flexible. They
> use our do-what-I-mean mechanism to resolve, but also allow the user to
> specify commits relative to one another. It's probably sufficient though
> to mention them briefly and then redirect to girevisions(7).

Will think about this, I'm not sure how to best incorporate that.
Maybe under the commits section.

> Thanks for working on this!

Thanks for the review!

- Julia
