Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE704214801
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897102; cv=none; b=DCDmzXJ9G3M+ZIXAnmIGbAZHEDfZE/BYD9YFnkA3k8Ji0oCFqIHc/67mbsqlqnDIZCoU4sF39Xebf27q4EqdIG55pTKpKU0o+h1qDSF1ghs6HAfpzu5OXAQlmBrpbGvkScCRnCAMUkNaIIzkHasaPxsdV4QSeJtBUJu17jANNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897102; c=relaxed/simple;
	bh=j8LCccg828/rjKgZK1ffUxPxj1XxhIrEIBy8sSKHEiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSfrtZQyGr0tUp3ufQGXEB4L2896fJHr4MlnBAxOFejulV3xoTX/8mIStevYUbaLmHQiMHplRSe5sknmRJuWJNPAPu2VgJnSz9GsxWTaGCOg9inESC97jbewZN2sJQtUo+Ny+IojqigxXP1nfj9O1eXmtZwXnArScCH0/2jsepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IMTiY3F5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CeKsFYL1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IMTiY3F5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CeKsFYL1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E96E37A07B8;
	Wed,  8 Oct 2025 00:18:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 00:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759897097; x=1759983497; bh=H72VgLig3H
	ZnaeTKKScVRpMDfjpmjWgIUgYZAiOTWic=; b=IMTiY3F5PmBo8B8dinWQLVnCCm
	1vZxD+f0yiMDwlrA5kJqqslzFiZBbUdElTdz8l5nTU844pqhE/ueuvZE+w09OBOl
	G5SX9VFALbXSnGDDGyknpqv+fq2CYeHOmM/+0cAwFLS7n2Xq6Z+9vy+Y/P3oHqij
	Jy8iKWlyk+Z2UEbzEIlEvkKtw0W0Ws9hHJGvlhGVEiZgImJfb7ysHGkkTb+BGGJs
	TiCk4zEUdmulkbpV4PPSTcHHtOvZTKlUeD6erVxm0XFv/RyCh3rx5VreYMvol6WP
	F+BX3deO0DcPnViY+677Vzl5+yMt5IJLLVLAd4M2qoWvxPSmKACRAjeLhT7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759897097; x=1759983497; bh=H72VgLig3HZnaeTKKScVRpMDfjpmjWgIUgY
	ZAiOTWic=; b=CeKsFYL1YAljnzsKRTuOpX9X03MMne8H+497sxltUM20vTLWosp
	DYYKYaJRFGoP606Vcr8lcCo87OwjgRiWvPN5fmreHUgncDlDoMzjkPqVHyJ4L08w
	QIUPnGKNbaBiBFmoNhNG/99HB6lBRjlctyDGV6vRjqNAQAiLFe7kWHWjU+gSJFYc
	lK6Qsy7g2l2LilseCQmVYUrLtxrLWzroGmCgfIFsNC0FZM61OGmgM3PANN83qZ0O
	4FwICGzg4P2N+VT0OpBiRZozh+OZYSDTHwXjZhSRoFDh2dPD73Gji+9l4XyiqF+3
	ozOFrM/+iK1L0XOX+EkqtcaMOd/mOpgxPYA==
X-ME-Sender: <xms:CeblaBOcQnkYDZz-DZ5Gso_It9jNuZuREpZiSgVwuVEG6vFtEPzSGQ>
    <xme:CeblaLZ964YKLT7s3wSqp0qoCuDzOGDS5sevijuWBpLzy3Eep7s7vPLzxdQBq_fJn
    fDrTvC6zbVxT9UcuC1y2CPR1_LGX0RS_XxPJpN8Wb7254J439FjcQ>
X-ME-Received: <xmr:CeblaNoSfPEj8EwFtIy1K6lkGyk1du4V7UNJl008-Dq2WqRa18hkkVW3gvzwJWzTpvI7gKamH65JTFJZeOnBHMo7T_kBlLWOJ6ai3d7r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CeblaHZmhqCiAfq7RRaj0XGhw5dEL_QYesXpHGpkayzxP2i_Q3qsYA>
    <xmx:CeblaNQfcUzsDHXseXVjD1fU_zo2nO5IHK09P2TRcZrFiN4JljRYHw>
    <xmx:CeblaG6GxGiJPvQmpE8TYttC6OO87V7Vt3Oydxm8mokSwXR_8bUqYg>
    <xmx:CeblaKwar-umYxxKVFsHXsiXmQPRdTCUaY1LuaBz5caI060R4aUujw>
    <xmx:CeblaHYnxSeqvd9k9_AFZV3VeS9EJqqkSaGQ9hOXI5Ar0UzRE7eFatiV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 00:18:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2689f5a3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 04:18:15 +0000 (UTC)
Date: Wed, 8 Oct 2025 06:18:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Message-ID: <aOXmA5L5LsUuXWEh@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <aOUkZa4_fq1hho7Q@pks.im>
 <dbf0727d-66bf-4698-aa21-d69da86027c3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf0727d-66bf-4698-aa21-d69da86027c3@app.fastmail.com>

On Tue, Oct 07, 2025 at 02:55:37PM -0400, Julia Evans wrote:
> On Tue, Oct 7, 2025, at 10:32 AM, Patrick Steinhardt wrote:
> > On Fri, Oct 03, 2025 at 05:34:36PM +0000, Julia Evans via GitGitGadget wrote:
> >> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> >> new file mode 100644
> >> index 0000000000..4b2cb167dc
> >> --- /dev/null
> >> +++ b/Documentation/gitdatamodel.adoc
[snip]
> >> +[[tree]]
> >> +trees::
> >> +    A tree is how Git represents a directory. It lists, for each item in
> >> +    the tree:
> >> ++
> >> +1. The *permissions*, for example `100644`
> >
> > I think we should rather call these "mode bits". These bits are
> > permissions indeed when you have a blob, but for subtrees, symlinks and
> > submodules they aren't.
> 
> I think it's a bit strange to call them mode bits since I thought they were stored
> as ASCII strings and it's basically an enum of 5 options, but I see your point.
> I think "file mode" will work and that's used elsewhere.
> 
> I wonder if it would make sense to list all of the possible file modes if
> this isn't documented anywhere else, my impression is that it's a short
> list and that it's unlikely to change much in the future.

Agreed, that seems reasonable to me.

> And listing them all might make it more clear that Git's file modes don't
> have much in common with Unix file modes.
> I looked for where this is documented and it looks like the only place is
> in `man git-fast-import` . That man page says that there are just 5 options
> (040000, 160000, 100644, 100755, 120000)
> 
> >> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
> >> +  or <<commit,`commit`>> (a Git submodule)
> >
> > There's also symlinks.
> 
> I created a test symlink and it looks like symlinks are stored as type "blob".
> I might say which type corresponds to which file mode,
> though I'm not sure what type corresponds to the "gitlink" mode (commit?).

Yeah, gitlinks are used for submodules. They point to an object ID that
refers to a commit in the submodule itself.

> I think these are the 5 modes and what they mean / what type they
> should have. Not sure about the gitlink mode though.
> 
>   - `100644`: regular file (with type `blob`)
>   - `100755`: executable file (with type `blob`)
>   - `120000`: symbolic link (with type `blob`)
>   - `040000`: directory (with type `tree`)
>   - `160000`: gitlink, for use with submodules (with type `commit`)

This list looks good to me. gitlinks are somewhat special given that
they refer to a commit stored in the submodule repository, not in the
repository that has the gitlink. But the expectation is that the object
name should always resolve to a commit indeed.

[snip]
> >> +[[blob]]
> >> +blobs::
> >> +    A blob is how Git represents a file. A blob object contains the
> >> +    file's contents.
> >> ++
> >> +Storing a new blob for every new version of a file can get big, so
> >> +`git gc` periodically compresses objects for efficiency in `.git/objects/pack`.
> >
> > I would claim that it's not necessary to mention object compression.
> > This should be a low-level detail that users don't ever have to worry
> > about. Furthermore, packing objects isn't only relevant in the context
> > of blobs: trees for example also tend to compress very well as there
> > typically is only small incremental updates to trees.
> 
> I discussed why I think this important in another reply,
> https://lore.kernel.org/all/51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com/,
> will paste what I said here. I'll think about this more though.
> 
> paste follows:
> 
> That's true! The reason I think this is important to mention is that I find
> that people often "reject" information that they find implausible, even
> if it comes from a credible source. ("that can't be true! I must be
> not understanding correctly. Oh well, I'll just ignore that!")
> 
> I sometimes hear from users that "commits can't be snapshots", because
> it would take up too much disk space to store every version of
> every commit. So I find that sometimes explaining a little bit about the
> implementation can make the information more memorable.
> 
> Certainly I'm not able to remember details that don't make sense
> with my mental model of how computers work and I don't expect other
> people to either, so I think it's important to give an explanation that
> handles the biggest "objections".

Hm, fair I guess. In any case, if we want to mention this I'd leave away
the details how exactly Git achieves this. E.g. we could say something
like:

    Storing a new blob for every new version of a file can result to a
    lot of duplication. Git regularly runs repository maintenance to
    optimize to counteract this. Part of the maintenance involves
    compression of objects, where incremental changes to the same object
    are optimized to be stored as deltas, only.

We skip over the details, but this should give enough pointers to an
interested reader to go dig deeper. We could also generalize this to
objects in general, not only blobs.

[snip]
> >> +[[HEAD]]
> >> +HEAD: `.git/HEAD`::
> >> +    `HEAD` is where Git stores your current <<branch,branch>>.
> >> +    `HEAD` is normally a symbolic reference to your current branch, for
> >> +    example `ref: refs/heads/main` if your current branch is `main`.
> >> +    `HEAD` can also be a direct reference to a commit ID,
> >> +    that's called "detached HEAD state".
> >> +
> >> +[[remote-tracking-branch]]
> >> +remote tracking branches: `.git/refs/remotes/<remote>/<branch>`::
> >> +    A remote-tracking branch is a name for a commit ID.
> >> +    It's how Git stores the last-known state of a branch in a remote
> >> +    repository. `git fetch` updates remote-tracking branches. When
> >> +    `git status` says "you're up to date with origin/main", it's looking at
> >> +    this.
> >
> > This misses "refs/remotes/<remote>/HEAD". This reference is a symbolic
> > reference that indicates the default branch on the remote side.
> 
> Is "refs/remotes/<remote>/HEAD" a remote-tracking branch?
> I've never thought about that reference and I'm not sure what to call it.

No, it's not. I think the term we use is "remote reference".

> >> +[[other-refs]]
> >> +Other references::
> >> +    Git tools may create references in any subdirectory of `.git/refs`.
> >> +    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
> >> +    and linkgit:git-notes[1] all create their own references
> >> +    in `.git/refs/stash`, `.git/refs/bisect`, etc.
> >> +    Third-party Git tools may also create their own references.
> >> ++
> >> +Git may also create references in the base `.git` directory
> >> +other than `HEAD`, like `ORIG_HEAD`.
> >
> > Let's mention that such references are typically spelt all-uppercase
> > with underscores between. You shouldn't ever create a reference that is
> > for example called ".git/foo".
> >
> > We enforce this restriction inconsistently, only, but I don't think that
> > should keep us from spelling out the common rule.
> 
> That makes sense. I'm also not sure whether third-party
> Git tools are "supposed" to create references outside of "refs/",
> or whether that's common. 

They really shouldn't, and to the best of my knowledge they don't. There
is only a rather limited number of root references with very specific
use cases. And nowadays we have also tightened the meaning of pseudo
refs, of which there are only two ("FETCH_HEAD" and "MERGE_HEAD").

[snip]
> >> +[[reflogs]]
> >> +REFLOGS
> >> +-------
> >> +
> >> +Git stores the history of branch, tag, and HEAD refs in a reflog
> >> +(you should read "reflog" as "ref log"). Not every ref is logged by
> >> +default, but any ref can be logged.
> >
> > If we mention this here, do we maybe want to mention how the user can
> > decide which references are logged?
> 
> Do you mean by using the setting `core.logAllRefUpdates`?

Yeah. Otherwise the reader won't have any pointers to figure out _how_
they can change this. I don't think we have a man page that provides a
better overview than this configuration.

Thanks!

Patrick
