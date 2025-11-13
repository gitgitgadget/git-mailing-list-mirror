Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13029CEB
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065130; cv=none; b=qN0pLboxatPBozBCneActse8b+z4oDkVPJXnkSy9Fsd4UO4JFzfKv276pdK20G7ewLwLoahw8doGnHr6+goMdE4FK1if1s9vIDgPUcmJdwo78EURDnVMKLcDt4kIpEHdjhmccydS3Y+LbAW/pDgUY5Pys+AzNG83cadOk1Bt1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065130; c=relaxed/simple;
	bh=VZmlE+3S3j3aHxnXrjFnq8AjZOVAjKxm8BVt9qRFWTU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lTZVZ5t+GsXJ5Xn8mKRQ+3jNPxTC5LDMPBpnd6mgDMIJw8ghPt6GCwPvBvjg+/qBrODV25I4Jlx0bWL281YPTfEwpDYFUg87SpFwCwMCSr0T5j6ADHJK3ojzxdwtggsGSTEo3hSRzoq1wKP+VVR7kFNnEZkfzLRlW2ICesQZGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=X0SqRVzf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zw8E1HZI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="X0SqRVzf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zw8E1HZI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A93341D0018C;
	Thu, 13 Nov 2025 15:18:47 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 13 Nov 2025 15:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763065127;
	 x=1763151527; bh=2vGGMENUIhuaztPGKMf6Jys3qqzrVpcXnsoJOTleBhI=; b=
	X0SqRVzfT1b5kzoqdVTAl+bEmOC3Ok1w3PoI1esp6HTtDfJqFFILdPtGYjAiVAdk
	B4Qy7tegxsC2T/vw0E3Mb5qnYmhM91yYehZni2zWuVpJ0nf3Vwk4CavJbmnqkr6D
	zgF1BHrbnM/IRGkMSTz5elkt3ABfLD4wuLvu+oZNo8mnEbrykUm3ozLhwC9/WBjq
	YCrlerFC60/9Nv2zxnrVUNI4msciMMOwSiBuLy1BJt6vQozJoAcQAJeoG2YOXb26
	75b9gcYwsY9Zz0mzFb1kHmE4nIHGUFu+y3CQ+qxlMk1+faQzgptmYvMIL0DfJiEQ
	PFXLcAvvz9eDTZ+OPc+5Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763065127; x=
	1763151527; bh=2vGGMENUIhuaztPGKMf6Jys3qqzrVpcXnsoJOTleBhI=; b=Z
	w8E1HZI3Dd1LzSFJNlTJ0pRJMlnquCl/B4YgvqEGUI9r/uXiupbuiNJS8QC5z1pJ
	34Gyg97BrwQ5gS0x26GdLuKknlJ43xLQyl8E5hO+vutQO6ys2oWniQ4NnttieqZn
	xNiifyerrGCjP1K9CpTvlrYASLmZCaobOkk8JsYvgMClOX+L1gZuby/baoxmBW4z
	HfaN23S0RCDL8F8E0GtmDJ7AwFOY1u0/7W3qIFc6G0L0TM9up6b9eHKvO24V05Pz
	PCoeu/2Dd9HWwu+6XLGRYY4+QNx4XbxrZEMEIpdVHtcQ7VYywn1mcYphRNxdFrPm
	Jq6ePtd/eczrrHQOWVHxQ==
X-ME-Sender: <xms:Jz0WadnkLFxGs6kTv9TBirupQIHcpRdvzu90dWI7XdTmjpAC9zJcgg>
    <xme:Jz0WaTo6U5Z--9H5fIaN0whFDRO_dhz11OrlMzmbYZvc3TziIGnA766sOvlyFBxmL
    vKPtIZ1sCy-RJOuN2mHRKmfg_5i_9yGCRKmnzOAiEhDUpsesJXNT0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgefhueeujeevgeeigeevgfeiveeuuefgleefieeifeffgeegteekfeejfeegiedunecu
    ffhomhgrihhnpehplhhovhgvrhdrtghomhdpfihiiigrrhguiihinhgvshdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgr
    sehjvhhnshdrtggrpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jz0WaTTcGNtBhj2KkoKx1Ked_jijHlhUjnpAhcgUpOzi9nlea6WxYQ>
    <xmx:Jz0WaeHpSZt3fZCDEgR0WgjA05u_lQOwgMEicLOVOmXuM-sKZCakZg>
    <xmx:Jz0WaQGKeqY7M-LuPX6tOVbwI2hlh-9ZnF8FS-Q8Y4rr_drtFTpMgQ>
    <xmx:Jz0WaUTHRaBQGvsJ1LEMac3Fl1jN8s3NyyXLbxkiVZ4pc8ABln2IVQ>
    <xmx:Jz0WaW5hn7Ez6AF9ZOK-oSjihsM8Jrq69oXyoFICuVzCr1B33JWgLv4F>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 36753780070; Thu, 13 Nov 2025 15:18:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Thu, 13 Nov 2025 15:18:25 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <160ef4a8-8e9c-4034-9607-2f268fdbf29d@app.fastmail.com>
In-Reply-To: <2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com>
References: <xmqqo6pde90w.fsf@gitster.g>
 <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com> <xmqqa50v4x8n.fsf@gitster.g>
 <150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
 <xmqqfrakyj0w.fsf@gitster.g>
 <2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
 <xmqqa50rqcy1.fsf@gitster.g> <xmqqo6p6q32v.fsf@gitster.g>
 <2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025, at 2:50 PM, Julia Evans wrote:
> On Wed, Nov 12, 2025, at 5:49 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> If we do not hesitate using a new word and introduce "label", "a
>>> branch works as a label for a commit object" may probably work,
>>> probably.
>>
>> Another thing.
>>
>> Do we want to limit the definition of "branch" very narrowly, i.e.,
>> "subset of refs whose refname begins with refs/heads/"? =20
>>
>> Or do we want to give a description at a bit higher conceptual
>> level, something like:
>>
>>   A branch is a mechanism to help you grow one line of history (in
>>   the sea/cloud of commits) by (1) keeping track of the commit it
>>   currently is at (by recording its ID in the ref used to implement
>>   the branch), (2) allowing you easily record a new commit you
>>   create while you are on it as a child of the current commit (by
>>   allowing the symbolic ref "HEAD" to point the ref used to
>>   implement the branch), (3) keeping the description of the theme of
>>   the particular line of history being developed there (by using
>>   "branch.<name>.description" configuration variable for the branch)
>>   which is incorporated when the branch gets merged to an
>>   integration branch, and (4) keeping track of how the branch has
>>   grown over time (in the reflog for the ref used to implement the
>>   branch).
>>
>> We can limit ourselves to view a "branch" as a narrow subset of a
>> ref that can point at a single commit in the dag of commits, and it
>> can be updated at any time to point another different commit that
>> has no relation to the previous commit.
>
> =EF=BB=BF=EF=BB=BF=EF=BB=BFI think talking too much about the intentio=
ns behind branches runs
> the risk of getting into a discussion from Git workflows which IMO
> is definitely out of scope for this document. For example "which is
> incorporated when the branch gets merged to an integration branch" is
> talking about a specific Git workflow.
>
> From my point of view as a Git user one of Git's biggest strengths is =
its
> flexibility; because branches _can_ be moved to point at a different
> commit at any time in various ways (via `git reset --hard`, `git rebas=
e`, or
> `git commit --amend`), there's a lot of flexibility in how someone can
> choose to use Git, including never using branches at all.=20
> (the flexibility is also one of the things that makes Git hard of cour=
se :) )
>
> So I'd prefer to keep editorializing about what a branch "means"
> to a minimum.

To immediately contradict myself a bit: after sending this I thought to
look through Mark Dominus's great blog posts about Git to see if
he has anything to say about this, and I came across this article:
https://blog.plover.com/prog/git/branches.html, called "I wish people
would stop insisting that Git branches are nothing but refs".

It reminded me that of course in Git the word "branch" often is used
to mean "a sequence of commits", for example if I make a branch called
`topic` and add 2 commits to it I might say that that "branch" is that
sequence of two commits. I think the way Dominus talks about this is
very interesting:

	The reason people say this, the disconnection is that the Git software
	doesn't have any formal representation of branches. Conceptually, the
	branch is there; the git commands just don't understand it. This is the
	most important mismatch between the conceptual model and what the Git
	software actually does.

To me the sticky point is that "the branch is these two commits" is an i=
mportant
and useful concept in Git, but it doesn't really _exist_ in Git's data m=
odel,
because Git only stores a branch as a reference to a commit.

One way I've resolved this in the past is to say something like
"you can think about a branch in 3 different ways!"
https://wizardzines.com/comics/whats-a-branch/

The idea there is to talk about how a branch might be _conceptually_
"a line of development", but that Git doesn't have anything in its data
model to track what the "base" of the line of development is, so any
time you want Git to think of a branch as "these 2 commits" you need to
give it a way to determine the base.

> Right now we have this, which tries to explain a very small amount
> about how branches are used that should apply to almost
> all Git workflows:
>
> "Even though branches and tags both refer to a commit ID, Git treats
> them very differently. Branches are expected to change over time: when
> you make a commit, Git will update your current branch to point to the
> new commit. "
>
>> Once we stop limiting ourselves and explain the purpose of using a
>> "branch", "it can be updated to point any random commit" stops being
>> entirely true.  While the "git branch -f" command can be used to do
>> so, doing so all the time would go against what makes a branch a
>> branch, i.e. to keep track of the process of growing the history,
>> and it is expected that it would be a lot more common for the commit
>> pointed at by the branch ref to move by growing the history with
>> "git commit", refining the history with "git rebase", etc.  But that
>> can only follow if readers understand the branch as more than "just
>> a ref whose name begins with refs/heads/".
>>
>> I am not sure what level the data model description you are writing
>> should be at.  The current description seems to concentrate too
>> narrowly on "a branch is a specialization of a ref" aspect, and
>> while it is not incorrect as a description of a building block of a
>> tool set to implement a workflow, it might be too limiting to form
>> a proper mental model.  I dunno.
