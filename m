Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD13346BF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651451; cv=none; b=RmbDeP36y3tI/5GYaei/zktmQSjWx2FSEqalvlA1TzOd0jx+mlUdlUswyErWBqgL9+YGYKK1KGTk3OUCRaQEzR+1CAOnwjR/cvJ441z97yntyhwnFqtNDkYm/DBYgh6WfR1eX8F3CGqYaeRXr1/4NWSqZcK+cfZXSSWUJScbVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651451; c=relaxed/simple;
	bh=FMWeJ9aq7zBdoM5dhT5rIoVzo7agU7Ncpht2j2rF1EY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oPgXYIAmIYSEvMzJ7stqwc7koRtp0WW8TqZmuckKhnaJ7IqNUMErR3rlXOroaPrB9Gl/8kBjzvZy4vMwweJCJn0CtwRZSkzfPiLXt40SkNmaZxe5cBvo69y052Y93Funj7BuMtkBjepgD2VKLeE72hLvCVzqnctGe4xPlTFiTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NnXZ0W7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F3fp1C08; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NnXZ0W7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3fp1C08"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 55E1F1D000AB;
	Thu, 16 Oct 2025 17:50:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 17:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760651446;
	 x=1760737846; bh=2mOXsSVRShbafwEXL/blulIrIVfWChMtPmHOv5donfo=; b=
	NnXZ0W7WS07FD0Q6l/dHEjgsnr/lFzt/OyzuNL9uIBJIYjuyLATFsxSLu+fGqqQB
	OECQ8ELmrIPOYpQFgul9jupCrGoAC5oXA9LYa5DIUqCjCGGxWEsWM0s0dKtroGS4
	K2dwTL8baBDedg+YOa3aqFDuJ3vGrqxpo183qT+tKZb70lQ/7wKzL3Thr31CohZD
	qsq3NdofFul1sC1b4mxcL4pEdIPt/FpOfTyN7pnKB2nynQKfK6vpAT9/+Y+oSTNL
	IcItgBqQNKPfhuH7k7SQOtTjFJ2iFWPmcEJEImTtEIYWoTsh6IqPAiUS+tahjepB
	yjl25TF/xmZEHc7S8qTFYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760651446; x=1760737846; bh=2
	mOXsSVRShbafwEXL/blulIrIVfWChMtPmHOv5donfo=; b=F3fp1C085KonWiQDD
	uAuoQAXWNPYpaAiZEK45Z7/XCFQj2jjd0k/s6K6kfh9Dj0SY0bVHjf+r60gzhlKD
	xDpxkStIQ2g8aA0r5sx5K0zMLrEzrUk0TGBRRrvShaVKA5Siy4cAg4OeWD3V7bgp
	RM0os3u8r59Gb1sOXnWhj4D5VFT5Lgnr1rYWYfKZwTA6WLB9NHJ7/7S51KvlOyTV
	hhGjxyk2Wi8ZJaB0IU/oxo2RD3/zIHYtcZUhmfoBfOXKmY84Hd1zsb8kbDa7H3Jz
	ghb3cufENzrwVPt5YZOaz47zYSxeaw2ZCNt3JhNYbyxvAtQs+258jhQ8omKWkys+
	QQMGA==
X-ME-Sender: <xms:tWjxaJVBXLojdeDq1Xb5E12IYSyjp8GMuDYnZvnHmgGqr62i3NWefeo>
    <xme:tWjxaEaeHsPIF7Pi-0vKcN4wjyftBXhCaNgUgTFlFTtRyJwpLYfJbBtS2KKVcpfaW
    tjUTd_b6Kor0G_1q2cP5S0nZ6hjlippvyEs2_0O-zDV5cCuuqITBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjrghmvghsrdgsohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tWjxaAA4vpzYLWhIwEpoYVCl4jI7CUj1wyYZ5chAOuOxqF-Muvb4Eg>
    <xmx:tWjxaAchKGslH9BKk4PpXtN6ZmnxWJxxAf61Vv4oGx5oVMBa4OJDeQ>
    <xmx:tWjxaLLX_BsTSnNbRS6ST2UZDXLV_PtQAgDb_iuwS_xftEzjzXK6qg>
    <xmx:tWjxaDeuIeaouooO7BEfJfN1CPcoAApyoa6MQM7vSNevnzLxLLIVOg>
    <xmx:tmjxaCViaz6iGmX2rkP8SLi0firvMkt3gxFAR78Djin5v9Y6BQWePFX->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA8541EA0062; Thu, 16 Oct 2025 17:50:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AThq61FNTfON
Date: Thu, 16 Oct 2025 23:50:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 git@vger.kernel.org
Message-Id: <2464e11c-32b4-4372-90b4-9a6302390e3d@app.fastmail.com>
In-Reply-To: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 0/3] add a message-id header to git
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 20:57, James Bottomley wrote:
> There has been some debate in the kernel community about how to link
> commits back to email, which is the basis of a lot of scripting we do
>
> https://lore.kernel.org/ksummit/a7878386f3546ba475cdf7250ab4f5a6af2a16=
76.camel@HansenPartnership.com/

In that email:

JB> There has been a lot of discussion on the tooling list about how the
JB> loss of link trailers has updated both tooling and triaging issues.

I know of a recent[1] negative opinion about `Link`:

LT> It's not that it isn't "useful to me". It's that it HURTS, and it's
LT> entirely redundant.
LT>
LT> It literally wastes my time. Yes, I have the option to ignore them,
LT> but then I ignore potentially *good* links.

But has there been a decision that they are going away?  Do you have a
link to that discussion?  Just curious to know more. :)

[1]: https://lore.kernel.org/all/CAHk-=3DwhP2zoFm+-EmgQ69-00cxM5jgoEGWyA=
YVQ8bQYFbb2j=3DQ@mail.gmail.com/

You might know that the Git project tracks Message-ID for all commits in
`refs/notes/amlog`.  This is straightforward when only the maintainer
applies emails.  And up until three hours ago I thought it couldn=E2=80=99=
t work
beyond on person.

But maybe it could?

1. Everyone who wants to makes or shares a hook to add the Message-ID
2. (and maybe try to upstream a built-in way; this would be simpler to
   upstream than a new commit header)
3. Push out the notes ref along with all the other refs
4. The tooling (programs) fetch and merge all of them (from the repos
   they know about)
5. With only a collection of remotes that run a hook to add a line to
   each incoming commit: the tools can merge all repos since people will
   not apply a patch and get a hash collision with someone somewhere
   else
6. (=E2=80=9Cthe tools=E2=80=9D here since you seem to focus on CI or ge=
neral tooling)
7. Consumers can fetch this note and have all known mappings

Would this work among nice, cooperating individuals?  (That don=E2=80=99=
t try to
confuse the tooling by notes for commits that already exist in other
repos.  For some reason.)

A more careful/structured implementation could also check that the
incoming notes are all (1) only additions, (2) one-line notes, (3) only
annotate commits that the notes-committer has committed (note committer
and commit committer are the same...).  But I guess for (3) to be
meaningful you have to manually map repositories to committers.
E.g. repository for Bob may only annotate commits by himself.  Or you
can sign the note commits if that is necessary.

Related sub-discussion on the linked thread:

https://lore.kernel.org/ksummit/68ee73dcd10ee_2f89910075@dwillia2-mobl4.=
notmuch/

On the one hand, pushing and fetching notes does not necessarily sound
like it would fit in an email workflow (*too* integrated with git(1)?).
But your reply here does not mention that kind of objection so I will
soldier on:

https://lore.kernel.org/ksummit/146639e2bc8b5327f57e4297f5a0fcfd3c86d95c=
.camel@HansenPartnership.com/

JB> I think part of the problem with notes is they're designed not to be
JB> shared.

They aren=E2=80=99t designed to not to be shared, but you are getting at=
 a real
usability downside for individuals. They are =E2=80=9Cdesigned=E2=80=9D =
to be hard to
consume/fetch in setups where every single user needs to set up a
refspec in order to fetch them for them to be useful.

But you seem to focus on tooling.  For tooling they shouldn=E2=80=99t be=
 any
harder to set up than anything else.

So yeah the downside is for individuals who just want to be able to
opt-in to pretty-print the Message-IDs; they would have to set up a
refspec to get the Message-IDs, just like they do here in Git.

They don=E2=80=99t get it for free from the Git commit object itself.

JB> So there are lots of diverse internal uses for notes that
JB> aren't just the annotations you're thinking of here, so when I push =
to
JB> a notes tree, I'd likely have to filter and when I pull from it I
JB> wouldn't necessarily want everyone else's notes ... it's like when y=
ou
JB> forget to add --no-tags to a pull from someone else's tree and you g=
et
JB> a load of their internal tags that contaminates your internal tag po=
ol.

You get all the blobs for the notes.  They take up disk space but they
don=E2=80=99t pollute things beyond that.

JB> Yes, but not all subsystems would care about everything even in this
JB> notes driven annotations model ... so you either have to have filter=
 on
JB> pull or strict rules about what goes in, which then causes issues wi=
th
JB> local notes uses.

With one blessed notes namespace for Message-IDs, where=E2=80=99s the po=
tential
conflict?  Those who care can fetch.

See previous paragraphs about merging notes across repositories.

With all that naively said: note objections by Konstantin Ryabitsev.

https://lore.kernel.org/ksummit/20251015-versed-active-silkworm-bb87bd@l=
emur/

>
> However, this problem is one that goes beyond the kernel, so having

Are there examples of projects where this is a pressing need?  I would
imagine it is not for smaller email-based projects.

I=E2=80=99m asking because it is good to be specific in the cover letter=
 for a
major change.  More than just stating that other cases exist.

>[snip]
