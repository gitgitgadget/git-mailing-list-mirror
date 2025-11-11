Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A743659E4
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874713; cv=none; b=Uh/CzWKnhbeNkuzuRD3+cU4omJg4V0aJYi8vgLTl4UNdf+1gG30ijKF3AM0wsnF26wVtJ5R1yPQo95XvkwZl88l0l59ImmNnra3WXdGFFznIT+NyNlJTyFqoBeAN0m5QoCzsAExVUH3TsXep9kKMeUe+iRnKJjY4MlpJ8a5+lhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874713; c=relaxed/simple;
	bh=ll0QZ+WxKCOWVcNO8xYyMCTnWXIRtMyzBGWMY6Gn1PY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OG3TSehjyhTKCVRYwWvNKwCwgMAwg1an0NzFGahaxSQ4/ZonCIqsXURFExGUVAnln6FGi8exPUDQSagfNS0v1xkxMvHKNoRD1a7zCO+FDgf3n+rYcIODL/P79qHxEKshSv4OB267KzHWdWG24Oli/cctg4NDOyjXoRanUs/FidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Z2dAQg3u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtI/lXS7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Z2dAQg3u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtI/lXS7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CA60AEC0218;
	Tue, 11 Nov 2025 10:25:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 11 Nov 2025 10:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762874709;
	 x=1762961109; bh=bPe2yQ79z7oR0Od4OD5Bo7ITBcEF3gMWFENxxM7GipI=; b=
	Z2dAQg3u1w8A7dp4r/fZ4dTBF9sIfhkiRlKxbLPptMoDaIUgQh6ZA1pjOkijNd8G
	VKt6zM3hhSTPdGM5ZhN2p2pDy4BlBE9WPndQg3sceO+e0vRtpL0PC3V5a9BfjVck
	+DQpp0dDdBTcJWDKnkJ8BtNx28XHnOSITIqIbGcqOZF561rmZ70UwgwAIvM+qVYM
	vDhBS8eWgUPKrh51DICCgK7WIWYXAKl5Wt2pz37pimqprWVttdA65bdyJmh+4tU4
	Ec0n3yPOtMXD3EbryenDYSMb2YuY3nZ98V+/zWgLpu0Finrku/JJiMFKfi+Zrt8r
	lGo4PT4m1KacdGfwb8PYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762874709; x=
	1762961109; bh=bPe2yQ79z7oR0Od4OD5Bo7ITBcEF3gMWFENxxM7GipI=; b=B
	tI/lXS7ht/2jskpPN76tddQJq9Y919E4SOLAqDtu8O3oYWJQFuSX9XttrZZWvcyT
	YFsJNbSa9bpzF/fEFAF3IMu1nlgKKjMxxf2nNgq9txTFX9ucQxWjguQ3txMysKwM
	CYyiPlquqAblASAoIGx7q6Y/i8zf7QtxrFwqRTWS5BbL1UZFEVhCcDDviU4EAsVI
	xeWl2bi837oueCHrmqgxHkd+UxIcvkajMmeKKxC6YY9VmMl3s6/ueuRa92sL4hQT
	xSWL6URATOz/etFCi3iyssjLETW34PAwIBmzlDjZqY8B9hU1C4mGxxKJ2tX8AX48
	YmhSTRutOZABAAjir6whA==
X-ME-Sender: <xms:VFUTaQ-o-jowRP2OMK2ulOB91MNyXLy0U20wvj-awF4A2TOQRxeNDA>
    <xme:VFUTaTjcGRuK6kOkVAWJIdYcwcURKYqg7PNBiHGDn1VUTXhHeG3uLmFfC8VDhwero
    4ZU8WvdCQTFFvGIWRv-cwzr8t2gGDCYV5b_WbDXbXRQNExFUOOqDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduheegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VFUTaSrD0hbqQ5fhDTvI3KD13runqGx-_nKvLy7tEivypGKcCSYZPw>
    <xmx:VFUTaZ9Euk09EA04x3Uyh5Jg7DAjPvQgH8kMc8rLSZzPRDktJKawxQ>
    <xmx:VFUTaefg__zCseL6Ok1C_7jeISerL4fmAYrroCFldOAQ5xTCBcdqQw>
    <xmx:VFUTaTJrJtNTmqFUDeJWraze1GzoQrQ6nQAXdds0_sl-NDVwepufwQ>
    <xmx:VVUTaaxVh-QLm8KjrmI8rrAhKfASirKmlZPJAZ5RCbcy9l6TMXmrmp_E>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD24E780054; Tue, 11 Nov 2025 10:25:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Tue, 11 Nov 2025 10:24:38 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
In-Reply-To: <xmqqfrakyj0w.fsf@gitster.g>
References: <xmqqo6pde90w.fsf@gitster.g>
 <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com> <xmqqa50v4x8n.fsf@gitster.g>
 <150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
 <xmqqfrakyj0w.fsf@gitster.g>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(this message got a bit long but the tl;dr is: maybe
"a branch is a label for a commit ID" would work?)

On Tue, Nov 11, 2025, at 5:13 AM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> Like you noticed in the tag object section, I think saying that the tag
>> object "refers to an object" works well in that context, but in the context
>> of explaining what a branch is it makes the text more confusing.
>
> Sorry, but I do not understand your objection, as I cannot see what
> confusion it would bring in in saying "a ref refers to an object"
> (or "a branch refers to a commit object"). 

> A ref refers to an
> object, just like a tag field in a tag object or a tree-entry in a
> tree object refer to another object.  They do so by recording the
> name of the object they refer to.  So what's so confusing if we said
> that straight?

My main strategy for figuring out if something is confusing or not is
to talk to a few different users of the software and to ask them what
they think. I have a pretty empirical approach to figuring out if an
explanation is clear or not, if people think it's clear, then it's clear.
(the question of "accuracy" is separate of course)

From experience talking to people about references in Git I know
that this particular thing is extremely easy to get wrong, I used to
often try to explain branches by saying something like "A branch
to a commit" and I would get kind of a blank stare, which is why
I'm so cautious about the phrasing here.

The reason I started with "a branch is a name for a commit ID"
initially is that I've found that people respond well to that phrasing
in the past, and I don't think it gives a misleading impression about
what a branch is. But I thought your point that (in the context
of this document) the term "name" could perhaps be confused
with "object name" was reasonable, so I've been trying to
come up with an alternative.

It's always a little tricky to explain from first principles _why_
something is confusing, when I started working on explaining Git a
couple of years ago I would have thought that many of your suggested
phrasings would be an effective way to explain how Git branches work to
people and I was very surprised to see how careful I had to be around
the phrasing to get folks to understand how branches work.


> Are you saying that the noun "reference" (or "ref") is a sufficient
> clue to readers that their objective is to "refer to" something, so
> "refers to" is a redundant thing to say?
>
> Maybe its just me, but I find it a quite roundabout thing to say
> that a ref refers to an object name (or "ID" if you like), simply
> because name or ID *is* a way to refer to the thing that is assigned
> that name, so you are making a ref to refer to something ("name")
> that refers to what it ("ref") originally wanted to refer to
> ("object").

My thought process is sort of like this: I have two descriptions of
"a Git branch" that people have responded well to in the past in
practice:

1. a branch is a name for a commit ID (you said that the use of
   "name" could be confused with "object name", which
   I thought was fair)
2. a branch is a file that contains a commit ID (people often
   respond very well to how concrete this is, but it refers to
   Git's implementation which we're trying to avoid in this context)

So I'm trying to find a different wording that's similar to one of these
two phrasings that I know are effective, but that doesn't have those
problems.

Some of the options we've discussed are:

- "a branch refers to a commit ID" (which as you've said has kind of a
  "type" issue since technically the branch refers to a commit, though
  when I've discussed it people they don't seem to think it's a problem
  in practice)
- "a branch refers to a commit, using its ID" (we had a long discussion
  about how "using its ID" can lead the reader to think "wait, how else
  could you refer to a commit", which in the context of trying to learn
  what a branch is an unproductive distraction)
- "a branch records a commit ID" (from my discussions I'm pretty sure the
  word "records" does not work, I think it's because introducing a new
  verb like "records" is always a bit dangerous)

One idea I just had is "a branch is a label for a commit ID", which
I think avoids the issue with "name" from earlier.

> That is what I find the most strange in the construction "A branch
> refers to ID" at the conceptual level.  I am much less unhappy with
> "A branch records an ID", but stopping at that may make readers ask
> the obvious question "what goal does that design aim to achieve?"
> (whose answer is of course "to refer to the object that is assigned
> that ID").
>
> "A branch refers to a commit object by recording its object name",
> "A branch records the ID of a commit it refers to", "A branch
> records the ID of the commit at the tip of its history".  Any of the
> phrasing that does not make "ID" the object/target of the verb
> "refer to" would work to avoid that strange construction.
>
> By the way, Ben used a word "unwelcome", but the words that are more
> appropriate to describe my reaction were "frustrated" (for not being
> able to explain what I know to be true clearly to make others
> understand) and "disappointed".
