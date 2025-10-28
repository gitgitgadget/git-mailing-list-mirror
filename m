Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06E34D4F5
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682284; cv=none; b=oy3q+92qmr8FVROfJ0JTunIC5vGNrSpEryHMA3o7CIZdDMzhuW6jWCj6m22qKfs7gQfpILBjremTibcSgNFwHzqRmyUZUMmOj7vx7A2n0GPpqTErpuUG0V++RUYgKv8eYjfAJs7sHgyy4TG2Te905zn972ncu0wIcale0JrZPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682284; c=relaxed/simple;
	bh=eMLohjyw/XX+gfFVhrlMg9/cwqn9CW25NOXxKKgp05I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sZPhZ0mPNyYncqZbGeEjFofVYfn2TpbEgV6UTCJNqk0ZDIcjCow4TTUNdZJapv1KYb/AtzPZRAZkd1drAu1vrIhyGT+sMVLsKx1+wK4rAHsArLaoKGLU4I1Tr7y4pJooiqGxWQLOUGU5CRRlRjF2tEFAgOFlXLOfvThDl8q/VTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=A+pw3wtY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTQA1dmq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="A+pw3wtY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTQA1dmq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3D7F1400219;
	Tue, 28 Oct 2025 16:11:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 16:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761682280;
	 x=1761768680; bh=2CgCnu1Hv6Pe8UxU5OQhWIRSB6IzaUc6M3RajUK+Wac=; b=
	A+pw3wtYKNMrj6bMqSY+a9nHPFI4KJx44l1tlSPzZOKkFio7lG4641YXggwYbfHo
	owy9RVegbJiGMoLYK/fE4HUDgTRpNlbYjs4mSKLrNMscoInYhOOVXpIdYguCAMDw
	lO17VYyGeiGE2Ia9MoVYza1NK+oCg32cAEImopvSgIJVeLS+FuXSdBBNKSHquDDa
	L2iLeJRCkBMD+6t+W0f3B2TxpgjCHNu8irSC2xp8xJJXPb61mNod4wgq6voaIdzB
	VYMzGiVFXrJcBeXHb4FZ/oWz29l9TXF66nfdFXvyiC78Mcf0YmYkWpY6LpMO10Nt
	ZwfXunoD/Qi4wqOr2+9pmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761682280; x=
	1761768680; bh=2CgCnu1Hv6Pe8UxU5OQhWIRSB6IzaUc6M3RajUK+Wac=; b=G
	TQA1dmqupJRUp6MNLcICpn6CDb5i0WWhCXITkzWDeccRDp7I471F41S1CtQfzypI
	+oCVAP9C+x+a69597z2RQv0k/JkI6bzGXnohG3J4o/bz530/dwJGPLKSkisOCtjP
	A/P6NWfeorOcdt0RjXWuGV0eKMu4VpqP164y7VoxeVYT0c0bujTaLBzGChmqHun8
	xVCXu3NRnnJ9t/rwaRGafLYhsctuJoBFftBgiknICNgRBGlyQQgACMlvzQhGOBFS
	FdlUcfs4PZ6PQDuDh2Bl9k5zua4OQB1d85BBQYzWZ7AKfxvVLc/pTySE3mWMzdak
	83UYWfXgNwyVajwKzS0pw==
X-ME-Sender: <xms:aCMBae07XSM80VuwsDXkEp-P2zAnSDfrhospeUR26Vd3oCoupHKEnQ>
    <xme:aCMBab5FlHJR_2PsYAGAEmfnXXbzofSlQK_pFdU736sOzNIp6NJiiypslZBu2QddT
    uQKsib05XatL6iFfAVX4JMX__b1lOCD78rpdythVHvdO0bmckbQ__c8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedujeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aCMBacjbk1k6LuxT7AIRdV9E0NscLC48_eUrDgGrcT9VF0rZpS99Xg>
    <xmx:aCMBaeWzt-tY7Xwk9fen-tkrGS3UDCVHimc3clqM2Qv2pv780n0RTg>
    <xmx:aCMBabUlaTyHYEhhSnG2Bw20_jer8v7QdQf2ms1zAMwuWTgfIPetJw>
    <xmx:aCMBaejKsXiK5RthLj1muaB6mQpBpIJxusdDt3wJFRaIw2bn78exnA>
    <xmx:aCMBaXJY6BT4-OjNEGFJirCvKD1UDL7tyziEfEFP4FN_H0zwui2Pr7rj>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88905780076; Tue, 28 Oct 2025 16:11:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Tue, 28 Oct 2025 16:10:52 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <5b078fae-6fe9-4fde-ba84-1070761c168b@app.fastmail.com>
In-Reply-To: <xmqqikg0f1tk.fsf@gitster.g>
References: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
 <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <xmqqikg0f1tk.fsf@gitster.g>
Subject: Re: [PATCH v4] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> +
>> +It's not necessary to understand Git's data model to use Git, but it's
>> +very helpful when reading Git's documentation so that you know what it
>> +means when the documentation says "object", "reference" or "index".
>
> "While it is not necessary ..., it is helpful ..." may flow better
> than "It is not necesary ..., but it is very helpful".
>
>> +This means that if you have an object's ID, you can always recover its
>> +exact contents as long as the object hasn't been deleted.
>
> Somewhere in distant footnote, we may want to mention that objects
> that are in use are never deleted, and when they get removed (i.e.,
> garbage collection).  As part of the data model, "everything is
> retained by default, until we can prove it is no longer reachable"
> probably belongs somewhere.

Agreed, I really like this idea. Came up with the following, which I'll put at
the bottom of the "References" section if I don't come up with a better idea.
(I don't feel strongly about where exactly it should go):

NOTE: Objects will only be deleted if they aren't "reachable" from any reference.
An object is "reachable" if we can find it by following tags to whatever
they tag, commits to their parents or trees, and trees to the trees or
blobs that they contain.
For example, if you amend a commit, with `git commit --amend`,
the old commit will usually not be reachable, so it may be deleted eventually.

>> +Here's how each type of object is structured:
>> +
>> +[[commit]]
>> +commit::
>> +    A commit contains the full directory structure of every file
>> +    in that version of the repository and each file's contents.
>
> What you are describing here is more of the property of a tree; a
> commit is a bit richer.
>
>     A commit records a snapshot of the every file in the project at
>     one point in time, records who contributed to create such a
>     snapshot and why, and how that particular snapshot relates to
>     other snapshots in the history.

I don't understand the goal of explaining a commit in detail in
paragraph form when we already explain everything in a commit right
below this.

My goal of this intro sentence is just to emphasize what I think is the
least obvious point in that list, which is that commits contain every file. 

Happy to change it to something shorter like
"A commit records a snapshot of the every file in the project" if you
prefer that wording.

>> +    It has these these required fields
>
> "these these".

Oops, will fix

>> +Like all other objects, commits can never be changed after they're created.
>> +For example, "amending" a commit with `git commit --amend` creates a new
>> +commit with the same parent.
>
> "same parent." -> "same parent, without modifying the original
> commit object at all"?  Maybe redundant?  I dunno.
>
>> +[[tree]]
>> +tree::
>> +    A tree is how Git represents a directory.
>
> "a directory" -> "contents in a directory"?  I dunno.
>
>> +    It can contain files or other trees (which are subdirectories).
>> +    It lists, for each item in the tree:
>> ++
>> +1. The *filename*, for example `hello.py`
>> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
>> +  or <<commit,`commit`>> (a Git submodule, which is a
>> +  commit from a different Git repository)
>
> This is a bit of white lie.  A tree object entry never stores the
> type of the object.  It records <mode, object name, path component>.
>
> The second field you see in git ls-tree output is computed from the
> object name (when the object is available) or inferred from the mode
> bits.

Thanks, I didn't realize how tree object entries were stored.
Will remove "type".

>> +3. The *file mode*. Git has these file modes. which are only
>> +   spiritually related to Unix permissions:
>
> In the cover letter part of the message I am responding to, I saw
> repeated mention of "permissions should be "file mode"; let's be
> consistent.
>
> "Git has these file modes, which are ..." -> 

Makes sense. Will change to "Unix file modes" from "Unix permissions".
I don't think this needs a more dramatic rewrite though.

>     Git uses the following file mode to represent what each tree
>     entry is (because an object of the same type, e.g. "blob", is
>     used to represent more than one kind of things).  The file mode
>     are assigned to resemble Unix file mode.
>
>     Note that Git does not _store_ permissions, and there are only
>     two kinds of regular files; non-executable (100644) or
>     executable (100755).  To Git, there are no files that are
>     "readable only by the owner" etc., so file mode bits like
>     100600, 100400, etc., are never used.
>
>> +[[tag-object]]
>> +tag object::
>> +    Tag objects contain these required fields
>> +    (though there are other optional fields):
>> ++
>> +1. The *ID* and *type* of the object (often a commit) that they reference
>
> Not wrong per-se, but it is a bit curious to lump these two into a
> single enumerated item here, unlike "author" and "committer" were
> enumerated separately for commit objects.  If you are going to show
> "cat-file -p" output for illustration, it may be help readers
> understand them if you had them separately listed here.

Agreed, I'll split them into two items.

>> +2. The *tagger* and tag date
>> +3. A *tag message*, similar to a commit message
>
>> +[[index]]
>> +THE INDEX
>> +---------
>> +The index, also known as the "staging area", is a list of files and
>> +the contents of each file, stored as a <<blob,blob>>.
>> +You can add files to the index or update the contents of a file in the
>> +index with linkgit:git-add[1]. This is called "staging" the file for commit.
>> +
>> +Unlike a <<tree,tree>>, the index is a flat list of files.
>
> This is a bit of white lie, as modern versions of Git could be
> collapsing uninteresting parts of the directory structure as a
> single tree in an index entry (this is called "sparse index"), and
> can expand such collapsed "tree" in the index on-demand into its
> constituent files and directories.  But I do not mind presenting the
> traditional world model for conceptual simplicity.

I didn't know that, thanks. I guess I'll leave it the way it is for now.
It could be good to add a footnote, but I don't actually know how
to add footnotes in this document format.

>> +When you commit, Git converts the list of files in the index to a
>> +directory <<tree,tree>> and uses that tree in the new <<commit,commit>>.
>> +
>> +Each index entry has 4 fields:
>> +
>> +1. The *<<tree,file mode>>*
>> +2. The *<<blob,blob>> ID* of the file
>
> If you were to collapse descriptions like you did for tag objects
> where ID and TYPE were treated as a unit, here is the place to do
> so.  With the mode bits and object ID, we can represent regular
> files that are non-executable, regular files that are executable,  
> symbolic links, and submodules (if a sparse-index is in use, an
> index entry could be a subdirectory, but I suggested above that we
> can ignore them for simplicity).
>
> But <<blob,blob>> is highly misleading.  Even if we ignore
> sparse-index, we may see a commit object there.

Thanks, I didn't realize that. Will change to say that it can be a blob
or commit ID. I don't think that collapsing will help, IMO it's
important to keep a consistent format.

>     Each index entry records
>
>     1. The object that occupies the path, as (file mode, object
>        name) tuple.  Most often, it is a regular file whose contents
>        are stored in a blob object, that is either non-executable
>        (100644), executable (100755), or a symbolic link (120000),
>        but the object can be a commit in another repository if it
>        represents a submodule.
>
>     2. The stage number, which is normally 0, but entries with
>        higher stages for the same path are used during a conflicted
>        merge.
>
>     3. The path name for the index entry.
>
>> +3. The *file path*, for example `src/hello.py`
>> +4. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
>> +   there's a merge conflict there can be multiple versions of the same
>> +   filename in the index.
>
> If you are going by "ls-files -s" output, it may be better to swap 3
> and 4 above for ease of understanding.

Good point, will do.

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
>> +Every time a branch, remote-tracking branch, or HEAD is updated, Git
>> +updates a log called a "reflog" for that <<references,reference>>.
>
> If we want to avoid using word X while explaining X, then we can
> rephrase it as "Git updates a record in the reflog for that
> reference".

I think the current phrasing is okay. I also didn't respond to some of the
phrasing suggestions above if I didn't understand the goal of them.
Hope that's okay.
