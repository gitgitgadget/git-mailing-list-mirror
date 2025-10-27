Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEC26E6E5
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602061; cv=none; b=NWGG8ioTrvYgpQ6N57u81Gg3DWKgYeBEPENlio6aCu95Q+Ax7eFqOX8jvoCaIo4jKJfjpJPEmjZEWjnenoeENWz5sB1eJHbNzjLGF3qiK7ETt4Kw8Pl1MUP1cT4gWS+iFe1kWjJHLMRgFa4pQx73QcrJDeOmTgLit88UXthZ7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602061; c=relaxed/simple;
	bh=8683gSt8cAozYb89Fgiw9Rgss8oCMckX6E4t1u/iZMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IXZ6T4cCRouxmgmu8KeBxTxN+A08LuKtxEbz1kLfo33CIk+MctYZt7GuHxoxnWeyGeHtuqtwRd4U2iawUL4aptA3n//gzRBQ47e+8uv1nVYwpQ3KMuzqVT6A/2tcNAxhX/z0K9WuTNwfy6CI3zwmhgAiMO0PKlAAfMedRmmF6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gy57cTGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2cJQxzK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gy57cTGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2cJQxzK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B83B614003FD;
	Mon, 27 Oct 2025 17:54:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 17:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761602057; x=1761688457; bh=QOUm7Ih/4Q
	E7RcNdWTqZ0phLQvO3QhLYNp2bCS5R1aw=; b=Gy57cTGrJx7IPF6yDo4850WEd/
	G323UjBmJ2Ih3flgD7+dDHUM/1HpbhLq8KWNLThIsEQ9b84/TdrlZb5gnabr2qVH
	AW5RNSoPD58FoTEdeGTH47nFb+NwAjRmiXud9F2uo4dHXnbQH0emroT4r8/4pFbi
	0qLjTXqH6lNW4uFBa/N1F5ef6YJYXLxGQdqa7IYP17WVPWmZG5Gv8c2YtHtug7VP
	a/zen9oI+t29fL62llr6o/gsatmqmEV92vNbGYl/7xwBRwoa/sGbpcFCDZAKkUKU
	rRCk9mI2mSI/cjaAyDBhc+Iau0zQ1lFiU10lnoG8mxTul8CId8Nku4bwFyfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761602057; x=1761688457; bh=QOUm7Ih/4QE7RcNdWTqZ0phLQvO3QhLYNp2
	bCS5R1aw=; b=o2cJQxzKQafu1qUkxfNlToGtLBrcyJehF96+vGooueuwgaQaWJL
	+RrsOTLLBz/unsW5Mg6fiFcfqSu8KffNB/Z3AI9+KL2UDpcBaB63ky+Md0s828oI
	1xIIYNiZnVOEIII4AN612YMSUzR3/hymZfZBx4mfKk8fAi/j56TKsFDqIzsJqrY4
	8pLHvDgqf4craUhCUbu+t7Rr4/ed9hOsHxPtyuy2vYJOcK4c+8if/2aRXakegWT1
	7xcK24iZRSZ+abAeXvnpdl3WBuxTuvBjRSSCMgz0Hs+6n89iCTaHOS83Yw1FEmIL
	Vml53FGyLrc6PdpEUZsqqTKdyig4TDdDU9Q==
X-ME-Sender: <xms:Cer_aJJoacT1nfCdE8nPC9XSq30wM1C7fPUwbTvn-LLWIqMSdMPJww>
    <xme:Cer_aHa2OlY9dBR-vxZvUCe3C4EXAU65v2BmnHhI9VEgXjaWVS0TyxEstaGODLaBr
    Xkt-zxyVskHJj6RIsXhXIauO0cDDKeHDWe-cAekKbiYksbdT4Qz>
X-ME-Received: <xmr:Cer_aD-Q-er4hIEn5Ons-6neUrhtui9gExNtJrwCu6UGs9ln0h0BDHz6khKkk2ppfW9fAvGMAzoxsSjh1K3GxAnLp3cye7Vs9SBD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeludduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Cer_aAZznm5vdKhiPhkFNEW6wUEtEphT_M0r0r7Ln70hcUB0KmCVUQ>
    <xmx:Cer_aPMxC_o84DM9Akr9WWvnn6C6W4NTxp0t3XUKbLh-fj9WOdrKsA>
    <xmx:Cer_aED29Z2kyajyxdx1LnJD9-bgaZ0ED2ezTqLBpCZCgCOg_mi7DQ>
    <xmx:Cer_aOK00TNnzpoXsHOxoj7tUD9yOaPwni3rQ6NT3JxxvAbBAECDrA>
    <xmx:Cer_aMiC-ylGR9R-m01Y2lATyjazR6PyHU_kWq3zroEDSnqHTSYlZua2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 17:54:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v4] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Mon, 27 Oct 2025 19:32:17 +0000")
References: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
Date: Mon, 27 Oct 2025 14:54:15 -0700
Message-ID: <xmqqikg0f1tk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> new file mode 100644
> index 0000000000..e36e833f66
> --- /dev/null
> +++ b/Documentation/gitdatamodel.adoc
> @@ -0,0 +1,286 @@
> +gitdatamodel(7)
> +===============
> +
> +NAME
> +----
> +gitdatamodel - Git's core data model
> +
> +SYNOPSIS
> +--------
> +gitdatamodel
> +
> +DESCRIPTION
> +-----------
> +
> +It's not necessary to understand Git's data model to use Git, but it's
> +very helpful when reading Git's documentation so that you know what it
> +means when the documentation says "object", "reference" or "index".

"While it is not necessary ..., it is helpful ..." may flow better
than "It is not necesary ..., but it is very helpful".

> +This means that if you have an object's ID, you can always recover its
> +exact contents as long as the object hasn't been deleted.

Somewhere in distant footnote, we may want to mention that objects
that are in use are never deleted, and when they get removed (i.e.,
garbage collection).  As part of the data model, "everything is
retained by default, until we can prove it is no longer reachable"
probably belongs somewhere.

> +Here's how each type of object is structured:
> +
> +[[commit]]
> +commit::
> +    A commit contains the full directory structure of every file
> +    in that version of the repository and each file's contents.

What you are describing here is more of the property of a tree; a
commit is a bit richer.

    A commit records a snapshot of the every file in the project at
    one point in time, records who contributed to create such a
    snapshot and why, and how that particular snapshot relates to
    other snapshots in the history.

> +    It has these these required fields

"these these".

> +Like all other objects, commits can never be changed after they're created.
> +For example, "amending" a commit with `git commit --amend` creates a new
> +commit with the same parent.

"same parent." -> "same parent, without modifying the original
commit object at all"?  Maybe redundant?  I dunno.

> +[[tree]]
> +tree::
> +    A tree is how Git represents a directory.

"a directory" -> "contents in a directory"?  I dunno.

> +    It can contain files or other trees (which are subdirectories).
> +    It lists, for each item in the tree:
> ++
> +1. The *filename*, for example `hello.py`
> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
> +  or <<commit,`commit`>> (a Git submodule, which is a
> +  commit from a different Git repository)

This is a bit of white lie.  A tree object entry never stores the
type of the object.  It records <mode, object name, path component>.

The second field you see in git ls-tree output is computed from the
object name (when the object is available) or inferred from the mode
bits.

> +3. The *file mode*. Git has these file modes. which are only
> +   spiritually related to Unix permissions:

In the cover letter part of the message I am responding to, I saw
repeated mention of "permissions should be "file mode"; let's be
consistent.

"Git has these file modes, which are ..." -> 

    Git uses the following file mode to represent what each tree
    entry is (because an object of the same type, e.g. "blob", is
    used to represent more than one kind of things).  The file mode
    are assigned to resemble Unix file mode.

    Note that Git does not _store_ permissions, and there are only
    two kinds of regular files; non-executable (100644) or
    executable (100755).  To Git, there are no files that are
    "readable only by the owner" etc., so file mode bits like
    100600, 100400, etc., are never used.

> +[[tag-object]]
> +tag object::
> +    Tag objects contain these required fields
> +    (though there are other optional fields):
> ++
> +1. The *ID* and *type* of the object (often a commit) that they reference

Not wrong per-se, but it is a bit curious to lump these two into a
single enumerated item here, unlike "author" and "committer" were
enumerated separately for commit objects.  If you are going to show
"cat-file -p" output for illustration, it may be help readers
understand them if you had them separately listed here.

> +2. The *tagger* and tag date
> +3. A *tag message*, similar to a commit message

> +[[index]]
> +THE INDEX
> +---------
> +The index, also known as the "staging area", is a list of files and
> +the contents of each file, stored as a <<blob,blob>>.
> +You can add files to the index or update the contents of a file in the
> +index with linkgit:git-add[1]. This is called "staging" the file for commit.
> +
> +Unlike a <<tree,tree>>, the index is a flat list of files.

This is a bit of white lie, as modern versions of Git could be
collapsing uninteresting parts of the directory structure as a
single tree in an index entry (this is called "sparse index"), and
can expand such collapsed "tree" in the index on-demand into its
constituent files and directories.  But I do not mind presenting the
traditional world model for conceptual simplicity.

> +When you commit, Git converts the list of files in the index to a
> +directory <<tree,tree>> and uses that tree in the new <<commit,commit>>.
> +
> +Each index entry has 4 fields:
> +
> +1. The *<<tree,file mode>>*
> +2. The *<<blob,blob>> ID* of the file

If you were to collapse descriptions like you did for tag objects
where ID and TYPE were treated as a unit, here is the place to do
so.  With the mode bits and object ID, we can represent regular
files that are non-executable, regular files that are executable,  
symbolic links, and submodules (if a sparse-index is in use, an
index entry could be a subdirectory, but I suggested above that we
can ignore them for simplicity).

But <<blob,blob>> is highly misleading.  Even if we ignore
sparse-index, we may see a commit object there.

    Each index entry records

    1. The object that occupies the path, as (file mode, object
       name) tuple.  Most often, it is a regular file whose contents
       are stored in a blob object, that is either non-executable
       (100644), executable (100755), or a symbolic link (120000),
       but the object can be a commit in another repository if it
       represents a submodule.

    2. The stage number, which is normally 0, but entries with
       higher stages for the same path are used during a conflicted
       merge.

    3. The path name for the index entry.

> +3. The *file path*, for example `src/hello.py`
> +4. The *stage number*, either 0, 1, 2, or 3. This is normally 0, but if
> +   there's a merge conflict there can be multiple versions of the same
> +   filename in the index.

If you are going by "ls-files -s" output, it may be better to swap 3
and 4 above for ease of understanding.

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
> +Every time a branch, remote-tracking branch, or HEAD is updated, Git
> +updates a log called a "reflog" for that <<references,reference>>.

If we want to avoid using word X while explaining X, then we can
rephrase it as "Git updates a record in the reflog for that
reference".
