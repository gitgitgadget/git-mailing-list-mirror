Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50279314D05
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063438; cv=none; b=BUQmmrFb1QDdMNBpoo4skuT0ssAvpSdZjFwcHfa1N13GAaEXWoxHmZ2LlGmP57o3XUG/LaSg6sF6FwGyr44p3khur1et1Op/r/DFxq/mBrpBsWdAPbr+LJtF/zFaxRD7igXL6458T+9FA08YAvjsKUViIQmYq91yrOKbtyqbEEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063438; c=relaxed/simple;
	bh=jWLZtEq6MBRYl9whnDmLgTCy1eTpoYfzb3mIw6lCCuk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fGSfV6iAqynzY0hlqmOS03T5Ak1QqT+R00TcMy7n+bWu+CRpBeFpqpaxIBaBWQQFwaH68TrBlmPm+YMa9lgdAE4yxTNBBvFX5n12z4y4gOoKNHWKh9sKtndDvfJqH2I+j5r04OL+w0jiMHnawBbM0wI9lpjtdTY+hj+BBlIDmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=o4bxB2Dt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7drlqVN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="o4bxB2Dt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7drlqVN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49EA57A01B7;
	Thu, 13 Nov 2025 14:50:35 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 13 Nov 2025 14:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763063435;
	 x=1763149835; bh=t+V8NtCtzB1t0VuLt2HlT2EtGbFvaATlGbxPMkFN7bI=; b=
	o4bxB2DtXzpP7cbUsunkScKgOYMxya3CfdgxeFNPv4+yxBpdbzPKDbSGzMgmWgTz
	oWMMckaqZ6G/Q11UyXaWEb3M2/Fk2hhZZ+5rUKJmk9BERE9adou5W0urphhzu7bD
	PvfbOGu+X1hXRtq7BGwwL0OSf3cH5IJnVopS/pefGhBsC3Ze8Tkn+gV+hz3jdKJd
	5uk3SAQVNoB1JTxGczyjrW9OzwG6IpMt5sH/qFOhwx+crgLlPjuTRCcaddb11Ucn
	jfS4KNhiVv2UiF/q33cRhIEX4wo/7KjoyxAlbpDmQVtRfGbOyMiebmmJ0Yu+/cNJ
	P0MINBCU7K2K1rWtyF1Rag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763063435; x=
	1763149835; bh=t+V8NtCtzB1t0VuLt2HlT2EtGbFvaATlGbxPMkFN7bI=; b=O
	7drlqVNnlqXjIstFdEmKuqURvIVOyyQOJ08tpsvXLGiH8sLBl+pawN+EVXC+MPao
	7oHdh713AKHq5mhlBGNjBLMwBdNv4Cu0MiYC1QgGLU6JixeUgJlMDTOtIta2FWdI
	AcJIBaq+Ktw1dEGdVqLG8T5cx1ooB1u1mJlZp59DS3LgnnyuLwd73RDqMwwb0O82
	3wMHT8g/pJqEV1JxJFShL/pfDZ7TJqmMGtx8rmiLtfmIqjC69hDkDE1QF3G2LmxC
	3tMMhMLg/lq84TsWOi4vxEDpYxGRDzr14GPfNbyN1FPMr0rFDLee8SMZ2yDQR9Wu
	HlHiPJbyj4dSLYyROTUYQ==
X-ME-Sender: <xms:ijYWaXuzVrxsFrOHpY1crJ0rd-YhLwtILMBlyCF16NNjWVZol5nA0w>
    <xme:ijYWaTTBHRGbx0SxNYNsIaSROBI-_4XhYwGomPcY5HTknBwcWQEfUyIWB06TU0TRt
    AcmNQbiht80GQL3KBNs5jKGZA0GzGS0zNMmu0977HE388CfbkrJGgf5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epfeeiieeggedtfeekjefgvdetjeffhfevuedutdetvdejgfegveffhfelgedvvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ijYWaRY2qf8L-lpbsVvlH2jui8d3dv6veNwWsCQ0qwTvDSahVt_MPA>
    <xmx:ijYWaRs72bVLR_K1df20u1JWAhhccyiwq2GIONhU9Dg7GqkhACHNPA>
    <xmx:ijYWabM78uVcxgyvrKW1KrzIC7jTAPLilXvbYr54kKajzltpje1jzQ>
    <xmx:ijYWaQ5c-lsyuJQzmKC91URYIBbmIBxigDm0Yb6eGC-9oSbHHkeRfQ>
    <xmx:izYWaSi_kJDCAVDPg2FsFq32jyMHLbhU3NEWit_SoV267JroL5pRdtIJ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4368780070; Thu, 13 Nov 2025 14:50:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Thu, 13 Nov 2025 14:50:13 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com>
In-Reply-To: <xmqqo6p6q32v.fsf@gitster.g>
References: <xmqqo6pde90w.fsf@gitster.g>
 <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com> <xmqqa50v4x8n.fsf@gitster.g>
 <150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
 <xmqqfrakyj0w.fsf@gitster.g>
 <2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
 <xmqqa50rqcy1.fsf@gitster.g> <xmqqo6p6q32v.fsf@gitster.g>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Nov 12, 2025, at 5:49 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> If we do not hesitate using a new word and introduce "label", "a
>> branch works as a label for a commit object" may probably work,
>> probably.
>
> Another thing.
>
> Do we want to limit the definition of "branch" very narrowly, i.e.,
> "subset of refs whose refname begins with refs/heads/"? =20
>
> Or do we want to give a description at a bit higher conceptual
> level, something like:
>
>   A branch is a mechanism to help you grow one line of history (in
>   the sea/cloud of commits) by (1) keeping track of the commit it
>   currently is at (by recording its ID in the ref used to implement
>   the branch), (2) allowing you easily record a new commit you
>   create while you are on it as a child of the current commit (by
>   allowing the symbolic ref "HEAD" to point the ref used to
>   implement the branch), (3) keeping the description of the theme of
>   the particular line of history being developed there (by using
>   "branch.<name>.description" configuration variable for the branch)
>   which is incorporated when the branch gets merged to an
>   integration branch, and (4) keeping track of how the branch has
>   grown over time (in the reflog for the ref used to implement the
>   branch).
>
> We can limit ourselves to view a "branch" as a narrow subset of a
> ref that can point at a single commit in the dag of commits, and it
> can be updated at any time to point another different commit that
> has no relation to the previous commit.

=EF=BB=BF=EF=BB=BF=EF=BB=BFI think talking too much about the intentions=
 behind branches runs
the risk of getting into a discussion from Git workflows which IMO
is definitely out of scope for this document. For example "which is
incorporated when the branch gets merged to an integration branch" is
talking about a specific Git workflow.

From my point of view as a Git user one of Git's biggest strengths is its
flexibility; because branches _can_ be moved to point at a different
commit at any time in various ways (via `git reset --hard`, `git rebase`=
, or
`git commit --amend`), there's a lot of flexibility in how someone can
choose to use Git, including never using branches at all.=20
(the flexibility is also one of the things that makes Git hard of course=
 :) )

So I'd prefer to keep editorializing about what a branch "means"
to a minimum.

Right now we have this, which tries to explain a very small amount
about how branches are used that should apply to almost
all Git workflows:

"Even though branches and tags both refer to a commit ID, Git treats
them very differently. Branches are expected to change over time: when
you make a commit, Git will update your current branch to point to the
new commit. "

> Once we stop limiting ourselves and explain the purpose of using a
> "branch", "it can be updated to point any random commit" stops being
> entirely true.  While the "git branch -f" command can be used to do
> so, doing so all the time would go against what makes a branch a
> branch, i.e. to keep track of the process of growing the history,
> and it is expected that it would be a lot more common for the commit
> pointed at by the branch ref to move by growing the history with
> "git commit", refining the history with "git rebase", etc.  But that
> can only follow if readers understand the branch as more than "just
> a ref whose name begins with refs/heads/".
>
> I am not sure what level the data model description you are writing
> should be at.  The current description seems to concentrate too
> narrowly on "a branch is a specialization of a ref" aspect, and
> while it is not incorrect as a description of a building block of a
> tool set to implement a workflow, it might be too limiting to form
> a proper mental model.  I dunno.
