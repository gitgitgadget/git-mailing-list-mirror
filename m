Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645342AF14
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671382; cv=none; b=Mqj8R+law2yN1Dt+IN8uyasLvC99r9WvBnlzVj9csmvsBw9IK53T13m3ydxeI5B4J2pzS32Nxaovf624UmGllzL+hJxmuihcmDRtO/yb9nptBH+5ggbERQo5VmeUuGSv+1q0jq6jfiW+agB9C8Mw4lxDAI7/58q6KYbW+Vj6/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671382; c=relaxed/simple;
	bh=bhAX5721o2KSltEaib5kjdaQQwCMIsfYm+J+Xq7Nsi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFRG1FqUcYMjCApllAJrWwXcNrW/VkhWMO7/UjWchZCvmjDAYQlsO10ppG0LwY7HJJvImDPESZc8cSk9RwIqXNuHp0kjvo5cEU6TkjLgTk7j+SQkcK7104NBMeccwI3sxXVQ8KfPTw8PW7u4Uz8D+eiSK1/aqngZFH9CUEq9cQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cOVbkZiB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ml7C3P6u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cOVbkZiB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ml7C3P6u"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36163254023C;
	Thu,  3 Apr 2025 05:09:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 03 Apr 2025 05:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743671378; x=1743757778; bh=qTqBKcJuHv
	s7O+ueAbyKKKQi+Nl7EH6JknYW3TN6CvA=; b=cOVbkZiBgC5aBMtiJywck4HckF
	kd6VWGWYBGS1P7p1AaB1oS6cRXU4pFi+HSShEthAEwzvH1oaqEh41j0dqee4mPrZ
	+y/LiuED1d7FzNTztUQfNByj3Ai2q5/dPi2KCiXEVoo1us111dn9GYIh+OQupQCN
	5pwAG8lzqjJc0E6VcHxP94ockDD+9N4S7Eh9J+lkQFchUvU1oa7FJTSiCIVt82o8
	zu4nxEw9qPpWw1Q4x23Et1R41W1TLF48qtsP2JAM3uGzEYlcOPhzVmDkUNBYbk8C
	iQAlRI07+/qZbodE9i2BKIsetaezH4/qoH7zv8MxsLA9xRR+Xmu4AQKg8wOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743671378; x=1743757778; bh=qTqBKcJuHvs7O+ueAbyKKKQi+Nl7EH6JknY
	W3TN6CvA=; b=ml7C3P6ujKzp7bCnkQTmQ9DD6pc8QdsnqJdGHDRU8wkPCE2fEZT
	Kw2DpZNLGSpiGwgEMNUPnSzZ8NFllnNzhn1q74TVKitG4k+0zYz1A56B4jHnFY2i
	6P4Q3TPS7QSjUYMyEw+tyf6CFTkatJ2jfLHwPqeLe7favMYbUcTknMZfU8kS8aJ/
	m8ECgi2+aYV0Gc7w4/CXf1pplmeZ7iONLVtZ4hD3iX+UVoCCpR7xnznU06lKo73u
	+baCtgN579grleNouxPQkNHNyzA0d+3nlfeSZHdda1p1pgcglIoChjlO/uCxlP9Z
	JP39y1XEqyX+Sbt0ZNUqVWT/zwI2JC3CIlA==
X-ME-Sender: <xms:UVDuZ_2K6wd_AY1WvZvETpt4n_LlrRdInu4VrDHOfNdqVv2iWHLCTA>
    <xme:UVDuZ-GXW83tl_oS0F0ACmZX_awOLwe_26E08MBEeQS770CZNxgm9W9Xj9yAOIGw6
    xbZfyXERqkfH1z-AA>
X-ME-Received: <xmr:UVDuZ_4oQNMYBgzVRG6Nf3iWYocWvMm8qmz8tvZFF_eYq5jJempNTk0jMtzOf-rZwSNdDKHjbVqX3ZanRKRzBPbikrzqs68gRl5H4LJnb8m3pVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomh
    dprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehm
    rghrthhinhhvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghmohessghuvghniihlihdruggv
    vhdprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthh
X-ME-Proxy: <xmx:UVDuZ00UMepHxtx43q-FJL0Tcd4zCOyDR7fr46xyOPLXZO3xc8NqKg>
    <xmx:UVDuZyGXYogml8hTkGWcwNNrpgsQiL03rBqf-lGRt3pRTA3rxjG52Q>
    <xmx:UVDuZ1-bFBeiTz8MGV1HiAbn2vfq0jC9aXCRIp1LWCLEet8O7bDZiQ>
    <xmx:UVDuZ_kSj2dukdM2g4Hg2fkccFfLPc7Y1luygQoP3FWrjyh3ugcH-w>
    <xmx:UlDuZ1HhI3bxGk4p3nEfRaTNuEwinyhIV1q7gx9vao8OiKPnS1rTODRB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 05:09:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1bfb17e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 09:09:33 +0000 (UTC)
Date: Thu, 3 Apr 2025 11:09:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z-5QR57zgSsm6jNP@pks.im>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>

Hi Martin,

On Wed, Apr 02, 2025 at 11:48:01AM -0700, Martin von Zweigbergk wrote:
> Hi,
> 
> The Gerrit, GitButler, and Jujutsu projects all have a concept of
> a "change id", and it behaves in a similar way between the three
> tools. The change id is conceptually associated with a commit.
> It follows a commit as its rewritten (e.g. by amending and
> rebasing). The three projects currently store and format the
> change id differently. We would like to unify that so we can
> interoperate better. We hope the Git project is also interested
> in preserving and using this header.
> 
> There are many benefits to having a change id even if it's just
> local. I mentioned some in my email to this mailing list in [1].
> For example, it enables
> `git rebase main <change ID>; git switch <change ID>` without
> requiring the user to look up the hash of the rewritten commit.
> If the change id also transferred between repos and preserved by
> a forge (such as Gerrit), it enables the change id to be used to
> identify a code review.

Agreed, change IDs solve a couple of issues that many users face:

  - You can reliably track how a patch evolves over time. This helps
    various different tools to track identity of commits, like for
    example forges, but also tools like git-range-diff(1).

  - It becomes trivial to see whether a commit has been cherry-picked
    into another branch. We do have git-cherry(1) to do that right now,
    but that command is based on heuristics and fails as soon as the
    patch itself needed to be adapted.

  - Working with history rewrites becomes easier in the general case as
    you don't have to adapt to constantly changing commit IDs.

The mere fact that different tools eventually ended up with similar
designs around change IDs is a good indicator that there is a real need
for them out there.

> Here's how the change ids are currently stored and formatted:
> 
>  * Gerrit currently stores change ids in a commit trailer called
>    `Change-Id`. It always starts with the letter 'I' and is
>    followed by 40 hex digits. For example:
>    `Change-Id: Ib563e78c3fedcff262255fa025441daa3202311b`.
> 
>  * GitButler currently stores change ids in a commit footer
>    called `gitbutler-change-id` (older versions used
>    `change-id`). It's written as 32 hex digits separated by
>    dashes as in the UUID  format. For example:
>    `gitbutler-change-id  7d0fbc63-032d-413c-8ae8-610fbeb713c0`.
> 
>  * Jujutsu currently stores change ids in a local storage outside
>    of the Git repo and is therefore not part of the Git commit
>    id. It is stored as 16 bytes. It is rendered to the user as
>   "reverse hex" using 'z' through 'k' as hex digits ('z' = 0,
>   'k' = 15). This allows even short prefixes to be distinguished
>    from commit  ids, which is a very useful property when used in
>    the CLI.
> 
> As mentioned, the three projects would like to use the same
> storage and format. I think we have a consensus to store it in a
> Git commit header called `change-id` as a 32 reverse-hex digis.
> For example: `change-id ywlktllmukprnxnmzzprukpuwyztylwt`.

I don't mind the actual format too much at this point, so I won't
comment on this part.

> There is a design doc [2] about the impact on Gerrit and how to
> handle various cases where the client doesn't understand the
> `change-id` header. That also includes some discussion about
> whether cherry-picking should preserve the change id or create a
> new one. I think there is a lot of value in having a
> standardized header regardless of what we decide about
> cherry-picks.
> 
> So, to be clear, this is mostly a heads up at this point; we don't
> depend on any immediate changes from the Git project.

Scott has already been reaching out to me before your mail, and I also
mentioned to him that I have been thinking about the problem of change
IDs for quite a while already. This has mostly been triggered by Jujutsu
and how it uses change IDs, which is one of the good improvements over
Git from my perspective.

While there may not be a need to do anything in Git itself I would think
that supporting change IDs natively in Git would still be sensible.
Sure, you can emulate them via commit trailers. But I don't consider
trailers to be particularly great as a storage format for this metadata.
After all, you will want to filter the commit graph by change ID for
some of the usecases, and doing that based on a loosely-defined format
probably isn't great.

So what would it take to get change IDs into Git? I think the most
important items would be:

  - Generating and writing change IDs in commands that support them.
    This includes e.g. git-commit(1), git-commit-tree(1), git-merge(1),
    git-merge-tree(1). This should of course be completely optional and
    probably be disabled by default.

  - Making tools that rewrite commits aware of change IDs so that they
    know to retain change IDs. This involves e.g. git-cherry-pick(1),
    git-rebase(1), git-replay(1).

  - Extending revisions to allow specifying commits by change ID.

  - Allowing us to filter commit graphs by change ID.

I don't think any of these should be particularly hard to do. Sure,
addressing and filtering commits by change IDs would be slowish at first
because we have to basically read all commits, but this is something
that can be sped up via indices.

The biggest question is of course backwards compatibility -- can we
introduce a change ID into the commit metadata without breaking existing
users? I guess you'll already have a lot of experience with this given
that you essentially already inject change IDs into metadata, and tools
generally handle this just fine?

I'd certainly be happy to help out with an effort to introduce change
IDs into Git if the community is amenable to such a proposal.

Patrick

NB: I'm also quite happy that Jujutsu brings a bit of a new contender
    to Git into the picture. It has a lot of nice ideas, and in the best
    case Git might be able to learn a few nice tricks from JJ. After
    all, I think we can all benefit from some friendly competition.
