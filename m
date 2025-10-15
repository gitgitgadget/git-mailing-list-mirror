Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F9303A10
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558345; cv=none; b=Vs6IY7u0E7CRglPlyTTaDZZu95XEE/YOYnBcYT8w6T/JUf3dubseAmm/jc34SC/V3ReGIwDoFEf7oEZPHDwjc5S8QuFMsFLMU+2SriT4jSkTlylHWSPbpDExn7e2YQ/V2cWjUraksE66aJQBIdMDEZJ/GHa1YezfcTFgNt3t5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558345; c=relaxed/simple;
	bh=MYzTX2baL4tOePG7siX6wf5bqmP1xlAXfE0fPuvfL3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjmg3sOkIs2lXihiNw4UeZnih1nG6q/FfNDNspbzzA1O0eIYMRoJ3J4F9Gk7u6k0Z4ejCWrxafkjMiNDSAAbm+dwyrhZlMmDK6z7EpQQgsuYD67uRB7uvvlWvSDxJ5e8bZ0GWZXQmtCegCv/AzItB2GgSfUjx38eiFza50eMZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W+sByJP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfiXwvAH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+sByJP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfiXwvAH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 83DC9EC0246;
	Wed, 15 Oct 2025 15:59:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 15 Oct 2025 15:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760558340; x=1760644740; bh=8DCaZVy+W3
	24A9tKJW59pFa5WaSTm+gBziC2TRki+iU=; b=W+sByJP6wm4g8/3+DziEIkJeyo
	EpdNLWEZvu3am+8tt0CAMkEit8idthBn0NpmOyndMc4RPgr4zOl6Aa9zVNWB5dhS
	m3RRrgHoPP+2x0CfBDzRy8+MhAM31kqmtSWZSOOp4ehdk7/PexlQVmyexfpL9fBh
	6y5nSCH+wRD3/zq9Ort40QyMmvgTBAb2JGJbo/8LcprQ7XA/2MmvRZvSiS6ZxFEk
	ghRzHxldVH2WqdqbYEE3RnKHkjXK2sk6VTizhIYpF+TVnPR2sz6A/8sr3vYtO7/w
	9HAXHiclNglbMC4sA/73m3c+Z7gPeQU+Lm03V9weX4Off0xt9fkBroKa9yYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760558340; x=1760644740; bh=8DCaZVy+W324A9tKJW59pFa5WaSTm+gBziC
	2TRki+iU=; b=qfiXwvAHhG7SzBPZlqIOtOC0El77vL3iDGrnY4aaCD5iaisoo2Y
	ZtuLO1Oi0ADSAS+DTOOj1wDMAGDzKT4JchbKuG+pv/NxLpIJD1wlTCHA8vHq1fAc
	u4nLdpGpnuNfsVMLsKGXo/Lad3mt2XF0g4+2P9HoZTPHS++O0IKVg4ewGxDVZHTQ
	DTfWROazTES86pMxzhim06jLJMh6jSfQSKORNQztKp88mMV4+ERBB3wuPK5+hSVx
	7ClnLmG8ruzYwGvO//0ZosOkWCDyKk17uYnT67b7vnzwIhnQl0iuyQ8QdIgFrA4O
	0DjAAwUh2UwVwH0Fef1t5vaTKfVRpZFihcw==
X-ME-Sender: <xms:BP3vaBub1nXKtzT5iAtQGzzPsGA-i2MY4VPoTT6fdw1fKO-5CLgxLw>
    <xme:BP3vaMtQbGG63Pp0rdlyy8vOrqHzWPXbKCKiR3IMUYjrlOZMMYIHKPaL91HN85xee
    9Cgps5zpl9KT6eNaNAGr01RWb6OXsY5KFs6Vruai0VtERT3JeTDMA>
X-ME-Received: <xmr:BP3vaHCkHDxoJ6VcBgafDTCqEnf7RfQhbrP7d8-W7NYVjcPa31JpnYt916g-0j6aKzTHTcfRQAMjcmtG4TZLq0WP6hkGFgmHepAB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BP3vaOMR3pncwgSnHHFMc7q7FqrMeXJ9Zjex1xzRBQO0P9eN_IVzVw>
    <xmx:BP3vaAxkmKZ49nzUnnqx6Db2Ob-Jwth-28AB5KLiqZmZYYLAgKMivA>
    <xmx:BP3vaOXAIs4CbFe-mkYvGdl5qbQ3PT7PyjsFACeBSVNmrkl978nuZw>
    <xmx:BP3vaCM7ENvOrAzLjnq6HrgSLQvaG_55_g6pNPa3ZroccbuF4Nymjg>
    <xmx:BP3vaGilDO8Q0mh_o__iF2_NXzDfF7v4jJ57z9Xv3XQYgbiH3V_y3A6R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 15:58:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
In-Reply-To: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Tue, 14 Oct 2025 21:12:26 +0000")
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 12:58:58 -0700
Message-ID: <xmqqv7kgszr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +[[commit]]
> +commits::
> +    A commit contains these required fields
> +    (though there are other optional fields):
> ++
> +1. All the *files* in the commit, stored as the *<<tree,tree>>* ID of
> +   the commit's base directory.

"all the files' exact contents at the time of the commit" is what we
mean here, and once readers know what a tree is, the above sentence
would be understood as such, but "All the files" felt somewhat
fuzzy.  I wonder if presenting objects in bottom-up fashion makes it
easier to see?  Learn that a blob records exact content of a file,
then learn that a tree records the set of paths with exact contents
stored at these paths, and after that, learn that a commit records a
tree, hence a snapshot of the whole set of contents.  I dunno...

> +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
> +  regular commits have 1 parent, merge commits have 2 or more parents
> +3. An *author* and the time the commit was authored
> +4. A *committer* and the time the commit was committed.
> +   If you cherry-pick (linkgit:git-cherry-pick[1]) someone else's commit,
> +   then they will be the author and you'll be the committer.

It felt a bit odd to single-out cherry-pick here.

I think the important thing to become aware of for the readers at
this point is that the author and committer can be different people,
and it does not matter how one commits somebody else's patch at the
mechanical level.

Perhaps replace "If you cherry-pick..." with something like "note: a
change authored by a person at some point in time can be committed
by another person at a different time, and these fields are to
record both persons' contributions separately", perhaps, if we
really want to say more.

> +Git does not store the diff for a commit: when you ask Git for a
> +diff it calculates it on the fly.

I think this is an attempt to demystify "are we really storing
snapshot for each commit?" thing, but then "when you ask Git to show
the commit, it calculates the diff from its parent on the fly" might
achieve that better, perhaps?

> +[[tree]]
> +trees::
> +    A tree is how Git represents a directory. It lists, for each item in
> +    the tree:
> ++
> +[[file-mode]]
> +1. The *file mode*, for example `100644`. The format is inspired by Unix
> +   permissions, but Git's modes are much more limited. Git only supports these file modes:
> ++
> +  - `100644`: regular file (with type `blob`)
> +  - `100755`: executable file (with type `blob`)
> +  - `120000`: symbolic link (with type `blob`)
> +  - `040000`: directory (with type `tree`)
> +  - `160000`: gitlink, for use with submodules (with type `commit`)

It is not really "supporting" file modes.  Rather, Git only records
5 kinds of entities associated with each path in a tree object, and
uses numbers taht remotely resemble POSIX file modes to represent
these 5 kinds.

Perhaps "supports" -> "uses"?

> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
> +  or <<commit,`commit`>> (a Git submodule, which is a
> +  commit from a different Git repository)
> +3. The <<object-id,*object ID*>>
> +4. The *filename*

Here it may be worth noting that this "filename" is a single
pathname component (roughly, what you would see in non-recursive
"ls").  In other words, it may be a directory name.

I wonder if we need to say "<blob> (a file, or a symbolic link)"?

> +[[blob]]
> +blobs::
> +    A blob is how Git represents a file. A blob object contains the
> +    file's contents.

"represents a file" hints as if the thing may know its name, but
that is not the case (its name is given only by surrounding tree).

"A blob is how Git represents uninterpreted series of bytes, and
most commonly used to store file's contents." or something, perhaps?

> +When you make a new commit, Git only needs to store new versions of
> +files which were changed in that commit. This means that commits
> +can use relatively little disk space even in a very large repository.

That invites the "aren't we storing a delta after all, then?"
confusion.

"Git only needs to newly store new versions of files and
directories.  Files and directories that were not modified by the
commit are shared with its parent commit".

> +NOTE: All of the examples in this section were generated with
> +`git cat-file -p <object-id>`, which shows the contents of a Git object.

Was this necessary to say this?  Blobs, Commits, and Tags are
textual, so "-p" does very minimum thing, but Trees are binary
garbage, so "-p" output is heavily massaged version of the contents.

> +[[branch]]
> +branches: `refs/heads/<name>`::
> +    A branch is a name for a commit ID.

Well a commit ID is an alternative way to refer to a commit object
*name*, so it is a bit strange to say "a name for a commit ID".

Perhaps "A branch ref stores a commit ID." is better?

> +[[tag]]
> +tags: `refs/tags/<name>`::
> +    A tag is a name for a commit ID, tag object ID, or other object ID.

Likewise.  "A tag ref stores any kind of object ID, but commonly
they are commit objects or tag objects"

> +    Tags that reference a tag object ID are called "annotated tags",
> +    because the tag object contains a tag message.
> +    Tags that reference a commit, blob, or tree ID are
> +    called "lightweight tags".
> ++
> +Even though branches and tags are both "a name for a commit ID", Git
> +treats them very differently.
> +Branches are expected to change over time: when you make a commit, Git
> +will update your <<HEAD,current branch>> to reference the new changes.

This sentence talks about branch moving because it advances with
more commits.  Did we want to say "HEAD" here before we explain what
it is?  "HEAD" can move for another reason (i.e. branch switching)
and using "HEAD" in the context of talking about growing history
might invite confusion.  I dunno.

> +Tags are usually not changed after they're created.

> +[[HEAD]]
> +HEAD: `HEAD`::
> +    `HEAD` is where Git stores your current <<branch,branch>>.

Hmm...

> +    `HEAD` can either be:
> +    1. A symbolic reference to your current branch, for example `ref:
> +       refs/heads/main` if your current branch is `main`.
> +    2. A direct reference to a commit ID. This is called "detached HEAD
> +	   state", see the DETACHED HEAD section of linkgit:git-checkout[1] for more.

These two are very reasonable.  But "your current <<branch>>" refers
only to #1.

    `HEAD` refers to the commit your current work is based on, and
    it is the commit that will become the first parent of the commit
    once your current work is concluded.  It can either be ...

perhaps.

> +[[remote-tracking-branch]]
> +remote tracking branches: `refs/remotes/<remote>/<branch>`::

Please always write "remote-tracking" with a hyphen (see glossary).

> +    A remote-tracking branch is a name for a commit ID.

Either "A remote-tracking branch stores a commit object name" or "A
remote-tracking branch points at a commit object", followed by "in
order to keep track of the last-nown state of ..." in a single
sentence.

> +[[index]]
> +THE INDEX
> +---------
> +
> +The index, also known as the "staging area", contains a list of every
> +file in the repository and its contents. When you commit, the files in
> +the index are used as the files in the next commit.

It is hard to define what "every file in the repository" really is.
Files that you removed last week do not count.  Files added in your
wip branch elsewhere are obviously not yet in the index when you are
working on your primary branch.

> +You can add files to the index or update the version in the index with
> +linkgit:git-add[1]. Adding a file to the index or updating its version
> +is called "staging" the file for commit.

It may be worth to clarify by saying "staging the contents of the
file" (you can edit the file further after you "git add") that you
are taking a snapshot at the time you ran "git add", instead of
giving a general instruction to "keey an eye on this file" to Git
(if it were, then the next "git commit" would behave more like "git
add -u && git commit").

> +[[reflogs]]
> +REFLOGS
> +-------
> +
> +Git stores a history called a "reflog" for every branch, remote-tracking
> +branch, and HEAD. This means that if you make a mistake and "lose" a
> +commit, you can generally recover the commit ID by running
> +`git reflog <reference>`.
> +
> +Each reflog entry has:
> +
> +1. Before/after *commit IDs*
> +2. *User* who made the change, for example `Maya <maya@example.com>`
> +3. *Timestamp* when the change was made
> +4. *Log message*, for example `pull: Fast-forward`
> +
> +Reflogs only log changes made in your local repository.
> +They are not shared with remotes.

Technically it is correct that before/after are recorded, but there
is no way for the end-user to interact with them.  "git reflog"
walking these entries will only give you a single commit object.
The username is also recorded, but I do not think of a way to view
the information, let alone using it for querying.

Especially when the reftable backend is in use, you cannot even read
the raw representation like you can do with files backend (where
something like "cat .git/logs/HEAD" would let you peek into the
details).  I am not sure if we want to go into this detail.

Perhaps drop everything after "Each reflog entry has:"?

> +For example, here's how the reflog for `HEAD` in a repository with 2
> +commits is stored:
> +
> +----
> +0000000000000000000000000000000000000000 4ccb6d7b8869a86aae2e84c56523f8705b50c647 Maya <maya@example.com> 1759173408 -0400      commit (initial): Initial commit
> +4ccb6d7b8869a86aae2e84c56523f8705b50c647 750b4ead9c87ceb3ddb7a390e6c7074521797fb3 Maya <maya@example.com> 1759173425 -0400      commit: Add README
> +----
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> index e423e4765b..20ba121314 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -297,8 +297,8 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	identified by its <<def_object_name,object name>>. The objects usually
>  	live in `$GIT_DIR/objects/`.
>  
> -[[def_object_identifier]]object identifier (oid)::
> -	Synonym for <<def_object_name,object name>>.
> +[[def_object_identifier]]object identifier, object ID, oid::
> +	Synonyms for <<def_object_name,object name>>.
>  
>  [[def_object_name]]object name::
>  	The unique identifier of an <<def_object,object>>.  The
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index e34965c5b0..ace0573e82 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -192,6 +192,7 @@ manpages = {
>    'gitcore-tutorial.adoc' : 7,
>    'gitcredentials.adoc' : 7,
>    'gitcvs-migration.adoc' : 7,
> +  'gitdatamodel.adoc' : 7,
>    'gitdiffcore.adoc' : 7,
>    'giteveryday.adoc' : 7,
>    'gitfaq.adoc' : 7,
>
> base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
