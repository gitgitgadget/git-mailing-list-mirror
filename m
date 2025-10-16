Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7333469FC
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628018; cv=none; b=udghq9bd9caTbAv/fdM2dNFU8oUmnBtZ2zSXaqfXE+xZbZlanl5xw5i8ciA6cMVOUBfMs/xpM8qxvGSMhW99oXh7M2z7e9oH6d7bPU+H+ZuADKoyfCHZA32hi4UDUbgTXafe/R60QMM13IvHqpo10VAglLeASPEuC7u77loZZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628018; c=relaxed/simple;
	bh=IwY+OyOTfCJQEzxSTiiMABK38qMUekl/ctx07Ltg2H8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ntcOtKhnSW+SdL+dnhuC2lk/abNA7071mbpJ8/r64rSSsheA2N677snCG/5ie1uRZn+xxh6BAC+ILRuLyX+l/DiMas3eZUJMZ4j3CEY8khmGFzSGKiFaVRzM9s12kuFevFLMb+03w4JfZnS87JFSxHspIA+ud/cUvCSM+4Yp0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=DAEdaB7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZGCD86R; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="DAEdaB7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZGCD86R"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 119AB1D0013B;
	Thu, 16 Oct 2025 11:20:15 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 11:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760628014;
	 x=1760714414; bh=6Efu+1eMdDAW5KkWdLbUD6StcjB9AtUHIjNIzHyFR24=; b=
	DAEdaB7T8QMDppee8yX8yuYcbPNlc24N/EBkVB/N2Uzgc9T/LueFLphuF2ZDZePA
	TDRAAvPbAV+0dEtvYyxDYOJOHlZ1m2nm6W59MsNr18AuBjFqoRDBBz99S3xqdoAK
	rsBc8yVkZrQTMiKEFFj44DYhkSDS8Zj57QSz2aapJnVIoelib9ERA7mWs0jnKgjm
	M3K4bslaNKx4OfvC5IpHzBH9vKlJ7qiTV8ov3a6l1Miu+h/RSdj9qW7YqkfZWmF9
	01ENzZsmlz+efLNQevjMln4l3OvuoPtOuQIh96VFL3nD58n4aFgvukiEKTVYdbE0
	Sxe22oP/WYWCR/Yh3L1kTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760628014; x=
	1760714414; bh=6Efu+1eMdDAW5KkWdLbUD6StcjB9AtUHIjNIzHyFR24=; b=c
	ZGCD86REM332I4s+cZAIB87EAysID6bwCgj+DBLMPNvzMjgPn026Fq3ARQNVmAw1
	Zq5kWTajW3vadu205mC6QO+qA9+RrNtafRaIw1DCHfprNQaCIvZj28Z6raddIjAk
	4DHvPHbT1O2Phb5RHqBUr/LSjuCzTphoRQeh9EQrs/FLXBzVFSIECxP/c1O6mbRo
	VNKb0L2JVhCS+faQQ5tVhUJvMTRu8r9zOnpWJVrflsPEA5R2buwEqCAGgJJ4+fD4
	7mQqaeLE7raf6qm5tkK1c6oWaHvclUv095FzDoPZTKc4hRV0nPbD0GZQTpCQaz6d
	f6QaNXeqSazfEJVPIUEoQ==
X-ME-Sender: <xms:Lg3xaMx-C6Tw04ZCV-gj_3JfkNseTmhoGZH6H-ZZ5RIMvOx20VlzwA>
    <xme:Lg3xaLEYb9S5plY8CGYy_OuYZB44ONq9e1K9ZAf9yI3F_3r95aXLEbifFk_LHBwe8
    c_uLO_dUvXnyflgdrpFRDx931kNvUpWmHSGST3RefD_EidvMX8ovLqh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Lg3xaAfHK5gD64F0Ku5z2CbaVtPNTRRTH4GJXpXS_Zxadc9AiaFeIA>
    <xmx:Lg3xaLh31Y-0tosvePGh-FiKY345i4uBnMhPPdNt0xY23hWW-oSg6Q>
    <xmx:Lg3xaIwYiVuf0Ird0NCqV0Ro7BSwje_x0YJwJ7ldgx_uvDlgiZ-HyA>
    <xmx:Lg3xaHNarb2ved8jLZJ3l13Psx9GU3h5Ea84yywDPmFq2jbv6q8IiA>
    <xmx:Lg3xaAUCv_Do9VKRhnWOgc2sC8IwGSKx-rGuJO1KG1JWjtPVFZ6cI6ZI>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5833578012B; Thu, 16 Oct 2025 11:20:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Thu, 16 Oct 2025 11:19:46 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <0eb276ef-7b1a-4e79-93da-13a83226aa01@app.fastmail.com>
In-Reply-To: <xmqqv7kgszr1.fsf@gitster.g>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
 <xmqqv7kgszr1.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 15, 2025, at 3:58 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +[[commit]]
>> +commits::
>> +    A commit contains these required fields
>> +    (though there are other optional fields):
>> ++
>> +1. All the *files* in the commit, stored as the *<<tree,tree>>* ID of
>> +   the commit's base directory.
>
> "all the files' exact contents at the time of the commit" is what we
> mean here, and once readers know what a tree is, the above sentence
> would be understood as such, but "All the files" felt somewhat
> fuzzy.  I wonder if presenting objects in bottom-up fashion makes it
> easier to see?  Learn that a blob records exact content of a file,
> then learn that a tree records the set of paths with exact contents
> stored at these paths, and after that, learn that a commit records a
> tree, hence a snapshot of the whole set of contents.  I dunno...

Will try "The contents of all the *files* in the commit..." to make it a little
more explicit that it's a snapshot.

>> +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
>> +  regular commits have 1 parent, merge commits have 2 or more parents
>> +3. An *author* and the time the commit was authored
>> +4. A *committer* and the time the commit was committed.
>> +   If you cherry-pick (linkgit:git-cherry-pick[1]) someone else's commit,
>> +   then they will be the author and you'll be the committer.
>
> It felt a bit odd to single-out cherry-pick here.
>
> I think the important thing to become aware of for the readers at
> this point is that the author and committer can be different people,
> and it does not matter how one commits somebody else's patch at the
> mechanical level.
>
> Perhaps replace "If you cherry-pick..." with something like "note: a
> change authored by a person at some point in time can be committed
> by another person at a different time, and these fields are to
> record both persons' contributions separately", perhaps, if we
> really want to say more.

I'll just delete the comment about cherry-pick.
I think it's already obvious (from the fact that are two different fields)
that the author and committer can be different (and happen at
different times), and if we don't want to explain why that might
happen there's no need to say more.

>> +Git does not store the diff for a commit: when you ask Git for a
>> +diff it calculates it on the fly.
>
> I think this is an attempt to demystify "are we really storing
> snapshot for each commit?" thing, but then "when you ask Git to show
> the commit, it calculates the diff from its parent on the fly" might
> achieve that better, perhaps?

Sure, can change it to that.

>> +[[tree]]
>> +trees::
>> +    A tree is how Git represents a directory. It lists, for each item in
>> +    the tree:
>> ++
>> +[[file-mode]]
>> +1. The *file mode*, for example `100644`. The format is inspired by Unix
>> +   permissions, but Git's modes are much more limited. Git only supports these file modes:
>> ++
>> +  - `100644`: regular file (with type `blob`)
>> +  - `100755`: executable file (with type `blob`)
>> +  - `120000`: symbolic link (with type `blob`)
>> +  - `040000`: directory (with type `tree`)
>> +  - `160000`: gitlink, for use with submodules (with type `commit`)
>
> It is not really "supporting" file modes.  Rather, Git only records
> 5 kinds of entities associated with each path in a tree object, and
> uses numbers taht remotely resemble POSIX file modes to represent
> these 5 kinds.
>
> Perhaps "supports" -> "uses"?

"Uses" sounds good to me.

>> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
>> +  or <<commit,`commit`>> (a Git submodule, which is a
>> +  commit from a different Git repository)
>> +3. The <<object-id,*object ID*>>
>> +4. The *filename*
>
> Here it may be worth noting that this "filename" is a single
> pathname component (roughly, what you would see in non-recursive
> "ls").  In other words, it may be a directory name.
>
> I wonder if we need to say "<blob> (a file, or a symbolic link)"?

I'm inclined to leave this alone because arguably a symbolic link is
a file but I don't feel strongly about this.

>> +[[blob]]
>> +blobs::
>> +    A blob is how Git represents a file. A blob object contains the
>> +    file's contents.
>
> "represents a file" hints as if the thing may know its name, but
> that is not the case (its name is given only by surrounding tree).
>
> "A blob is how Git represents uninterpreted series of bytes, and
> most commonly used to store file's contents." or something, perhaps?

I'll say "A blob is how Git represents a file's contents", unless Git has
another use for blobs that I don't know about (I think it's not
that much of a stretch to say that a symbolic link is a special kind
of file where the "contents" are the the link destination).

I think it's always clearer to be more specific when possible, if there's only
one purpose for blobs it's unnecessary (and IMO a bit misleading, because
it makes the reader wonder if there are other purposes that they should
know about) to say that blobs can be used to store any arbitrary bytes for
any purpose.

If there is another purpose I think we should give an example.

>> +When you make a new commit, Git only needs to store new versions of
>> +files which were changed in that commit. This means that commits
>> +can use relatively little disk space even in a very large repository.
>
> That invites the "aren't we storing a delta after all, then?"
> confusion.
>
> "Git only needs to newly store new versions of files and
> directories.  Files and directories that were not modified by the
> commit are shared with its parent commit".

I agree it makes it sound a little bit like we're storing a delta.
Will think about how to phrase this differently.

>> +NOTE: All of the examples in this section were generated with
>> +`git cat-file -p <object-id>`, which shows the contents of a Git object.
>
> Was this necessary to say this?  Blobs, Commits, and Tags are
> textual, so "-p" does very minimum thing, but Trees are binary
> garbage, so "-p" output is heavily massaged version of the contents.

Ah, I didn't know how trees were stored, thanks. 
I can remove "which shows the contents of a Git object", people
can read the man page for `git cat-file` if they want details.

>> +[[branch]]
>> +branches: `refs/heads/<name>`::
>> +    A branch is a name for a commit ID.
>
> Well a commit ID is an alternative way to refer to a commit object
> *name*, so it is a bit strange to say "a name for a commit ID".
>
> Perhaps "A branch ref stores a commit ID." is better?

I think I'll leave this alone, none of the many test readers reported
being confused by it.

>> +[[tag]]
>> +tags: `refs/tags/<name>`::
>> +    A tag is a name for a commit ID, tag object ID, or other object ID.
>
> Likewise.  "A tag ref stores any kind of object ID, but commonly
> they are commit objects or tag objects"
>
>> +    Tags that reference a tag object ID are called "annotated tags",
>> +    because the tag object contains a tag message.
>> +    Tags that reference a commit, blob, or tree ID are
>> +    called "lightweight tags".
>> ++
>> +Even though branches and tags are both "a name for a commit ID", Git
>> +treats them very differently.
>> +Branches are expected to change over time: when you make a commit, Git
>> +will update your <<HEAD,current branch>> to reference the new changes.
>
> This sentence talks about branch moving because it advances with
> more commits.  Did we want to say "HEAD" here before we explain what
> it is?  "HEAD" can move for another reason (i.e. branch switching)
> and using "HEAD" in the context of talking about growing history
> might invite confusion.  I dunno.

The text says "current branch", it just cross-references the "HEAD" section in the
HTML version if someone wants to read about what is meant by "current branch".

>> +Tags are usually not changed after they're created.
>
>> +[[HEAD]]
>> +HEAD: `HEAD`::
>> +    `HEAD` is where Git stores your current <<branch,branch>>.
>
> Hmm...
>
>> +    `HEAD` can either be:
>> +    1. A symbolic reference to your current branch, for example `ref:
>> +       refs/heads/main` if your current branch is `main`.
>> +    2. A direct reference to a commit ID. This is called "detached HEAD
>> +	   state", see the DETACHED HEAD section of linkgit:git-checkout[1] for more.
>
> These two are very reasonable.  But "your current <<branch>>" refers
> only to #1.
>
>     `HEAD` refers to the commit your current work is based on, and
>     it is the commit that will become the first parent of the commit
>     once your current work is concluded.  It can either be ...
>
> perhaps.

I like the idea of mentioning that HEAD will be the parent commit
of any commit that you make. Will think about how to incorporate
that, and about how to resolve " `HEAD` is where Git stores your
current <<branch,branch>>." being not exactly true.

>> +[[remote-tracking-branch]]
>> +remote tracking branches: `refs/remotes/<remote>/<branch>`::
>
> Please always write "remote-tracking" with a hyphen (see glossary).

Will fix.

>> +    A remote-tracking branch is a name for a commit ID.
>
> Either "A remote-tracking branch stores a commit object name" or "A
> remote-tracking branch points at a commit object", followed by "in
> order to keep track of the last-nown state of ..." in a single
> sentence.

I see that you don't like the "name for a commit ID" phrasing :)
Maybe there's another way to say it, though again none of the test
readers said they were confused by this or disagreed with the phrasing.

>> +[[index]]
>> +THE INDEX
>> +---------
>> +
>> +The index, also known as the "staging area", contains a list of every
>> +file in the repository and its contents. When you commit, the files in
>> +the index are used as the files in the next commit.
>
> It is hard to define what "every file in the repository" really is.
> Files that you removed last week do not count.  Files added in your
> wip branch elsewhere are obviously not yet in the index when you are
> working on your primary branch.

Agreed, I'm not so happy with "every file in the repository" either.
My intent was to make it clear that it's not "just the files you `git add`ed".
I'll think about a different phrasing that communicates the same thing.
Perhaps mentioning how it relates to the HEAD commit would help.

>> +You can add files to the index or update the version in the index with
>> +linkgit:git-add[1]. Adding a file to the index or updating its version
>> +is called "staging" the file for commit.
>
> It may be worth to clarify by saying "staging the contents of the
> file" (you can edit the file further after you "git add") that you
> are taking a snapshot at the time you ran "git add", instead of
> giving a general instruction to "keey an eye on this file" to Git
> (if it were, then the next "git commit" would behave more like "git
> add -u && git commit").

Maybe, will think about this too.

>> +[[reflogs]]
>> +REFLOGS
>> +-------
>> +
>> +Git stores a history called a "reflog" for every branch, remote-tracking
>> +branch, and HEAD. This means that if you make a mistake and "lose" a
>> +commit, you can generally recover the commit ID by running
>> +`git reflog <reference>`.
>> +
>> +Each reflog entry has:
>> +
>> +1. Before/after *commit IDs*
>> +2. *User* who made the change, for example `Maya <maya@example.com>`
>> +3. *Timestamp* when the change was made
>> +4. *Log message*, for example `pull: Fast-forward`
>> +
>> +Reflogs only log changes made in your local repository.
>> +They are not shared with remotes.
>
> Technically it is correct that before/after are recorded, but there
> is no way for the end-user to interact with them.  "git reflog"
> walking these entries will only give you a single commit object.
> The username is also recorded, but I do not think of a way to view
> the information, let alone using it for querying.

You can view the username with git reflog --format="%gn <%ge>".
(according to `man git-log`). I don't see a way to view the old commit ID.

Perhaps we should include the username but not the old commit ID then.
I'm not sure.

> Especially when the reftable backend is in use, you cannot even read
> the raw representation like you can do with files backend (where
> something like "cat .git/logs/HEAD" would let you peek into the
> details).  I am not sure if we want to go into this detail.
>
> Perhaps drop everything after "Each reflog entry has:"?

Perhaps we could give a stripped down list, like

1. The new *commit ID* the reference points to
2. *Timestamp* when the change was made
3. *Log message*, for example `pull: Fast-forward`

And then instead of giving the contents of `.git/logs/HEAD`
(which as you say includes some fields that there's no way
for the user to interact with), instead we could just show the
output of `git reflog main`, like this:

    You can view the reflog for `git reflog`, for example here's the reflog
    for a `main` branch which has changed twice:

    $ git reflog main --date=iso --no-decorate
    750b4ea main@{2025-09-29 15:17:05 -0400}: commit: Add README
    4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit

I added `--no-decorate`  there because the decorations are a distraction
when talking about the data model.

This version omits the username which is a little weird (it is possible to
access the username) but mentioning the username is a little weird
too because it raises some questions that are hard to answer about
what that field is for, and you have to pass an obscure format string
to view it. Not sure what's best here.

>> +For example, here's how the reflog for `HEAD` in a repository with 2
>> +commits is stored:
>> +
>> +----
>> +0000000000000000000000000000000000000000 4ccb6d7b8869a86aae2e84c56523f8705b50c647 Maya <maya@example.com> 1759173408 -0400      commit (initial): Initial commit
>> +4ccb6d7b8869a86aae2e84c56523f8705b50c647 750b4ead9c87ceb3ddb7a390e6c7074521797fb3 Maya <maya@example.com> 1759173425 -0400      commit: Add README
>> +----

Thanks for the review.
- Julia
