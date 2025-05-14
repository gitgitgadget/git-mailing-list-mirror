Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1B1C68A6
	for <git@vger.kernel.org>; Wed, 14 May 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235361; cv=none; b=G8Oglx/L6e1mI0Y396CvwshSy+XHro7dEY60PfYj3+W6reX2DrfhQ3Zgem+jf3rk9vjHIxv/vZIpgSSfIuOtUp6DVmE9d3AgL5LSNtMc5lcCtoJGeOhfVrwi19zdvsYP9JyjzxLjxHjPTSE8PAuXcIWATO8HJltXjDT2LgPK5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235361; c=relaxed/simple;
	bh=EtpHtdDSulTdfSr/yXVFiKRV66E8yqmjO79Anzt0Plc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q4cJ2LzwGl7oPANfWsfvY1z92R0LvHsHiaqT4TzRojXeGxKfsC4c0wwBo7LA7cJHRoxtPFdZWUAKwM0B1aqRJU+NEl4FSrzN5TQg8BN6qsPX5Iq+2CxP316ZepY6MTopsn3Jae5oSfDSqGqlOgc2DKfxgwxKkBj0OShNfhcJiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JEkHRdZL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9Rc4+9M; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JEkHRdZL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9Rc4+9M"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F2D513801D7;
	Wed, 14 May 2025 11:09:15 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Wed, 14 May 2025 11:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747235355;
	 x=1747321755; bh=NnDe1zTXs0E6xe31GnnEbigut9DNn/qHzlLNYODw8Q4=; b=
	JEkHRdZLC6hZdMNT9seecGXmORV7vclYEpoyFnRPwe4pouwI/IxoThcFZKc3N6IL
	/Ef/Wnc/kIWX0TPvopjIi9w3kjajsBMxdybNyrSPjx8O8zRTSyriDFYI8zmR6a59
	sh/y9SKZUwaaTlP5x/n23gUD6xlyKkZJzrSNZNwogxNZpMgIFxxGw6hlfzaGuTZY
	/UvX6sjuCtPi3q8LEkXicUyyUmJk0NIeZybqIo/8Wa4E1UNMxZNk1XOWQRJx6ljO
	ExRJtv1j8PvVErNCb7VHIthbPJHbEEJsCBiSzMHWMAMIRPPiPn/0ucX5ygb1S+Jy
	Ij02qP8zU4NWlwN4XsM8nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747235355; x=
	1747321755; bh=NnDe1zTXs0E6xe31GnnEbigut9DNn/qHzlLNYODw8Q4=; b=s
	9Rc4+9MzPfTjEP22Ftq63jolYJzmVcGrSju4yKWrWa/NGSGlm+Yd7qm9CAvJbkZ1
	weLAyz4iw5yySkX6u3KtpkFMojrYzXxCVeAhnM5UEQW0+OLROcy5un+0kQg+i4+H
	pe/CoQ2pjHlB0krLvNC8nsHYW5l9+wpCgKtPi99GFBwrWpwT9tpEzRU/7Hrys+5w
	+JXzERv0Kvt25FWifUGbqKHja/djUhnEoqigI3yKdtYdSxEwYQCYbkr4nUIqu58G
	wMDuu7Ontsq53+0l01rIuF+SjmvB5cNeCL8cgWIhSmiK7URc84rfJUugOqujvz97
	6PUVV9FWhUiXATDAWMGaA==
X-ME-Sender: <xms:GrIkaDEnmpZTHIUg9z5OwRZlXQ1uyOLh9hxoCYxDOVUr-ln9MHvXxhg>
    <xme:GrIkaAXS-oWMLF9aUQ52jU4rblyP2RXpwTEP9sNkTogIsXBu7ndQkllsKoYlhbrWA
    a6bKCfUuP19pSUd5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejud
    egveefvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlihhpmhgvthiighgvrhessghluhgvfi
    hinhdrtghhpdhrtghpthhtoheprhgvmhhosegsuhgvnhiilhhirdguvghvpdhrtghpthht
    ohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthhopegvkhgvmhhpih
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GrIkaFJCeE6F8xmAPGG6vNr5aEFufSyl9Y_urZundEaERRtONbRr9A>
    <xmx:GrIkaBFVRfm8GXyTB8kSIfIvaIHqUdYPBWqyQWo2DsGIVjpxowpyFw>
    <xmx:GrIkaJVC4tJ6XgUbytDMPJmewsdLi9bVAYr561Cu5q69KoBdDFLnBg>
    <xmx:GrIkaMPTaiqD3jv93nuRwjvqgxRD1G3GA2_DO1G4JCBtI1tyKqipZg>
    <xmx:G7IkaDgLzyPKWCkq5himh8DnSe4ybOvIR_-kGL_AcU-neT6zA62AiH5u>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76F5A280008A; Wed, 14 May 2025 11:09:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T605e17f7f4eceb22
Date: Wed, 14 May 2025 17:08:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Martin von Zweigbergk" <martinvonz@google.com>
Cc: "Git Mailing List" <git@vger.kernel.org>,
 "Edwin Kempin" <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 remo@buenzli.dev, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Message-Id: <a07f1102-1596-45b0-bdef-346f4fdcc3fe@app.fastmail.com>
In-Reply-To: <xmqqwmbuybhg.fsf@gitster.g>
References: 
 <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <xmqqzfgrjyws.fsf@gitster.g>
 <CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
 <xmqqwmbuybhg.fsf@gitster.g>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on change-id commit
 footer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

What a thread!

On Tue, Apr 8, 2025, at 16:27, Junio C Hamano wrote:
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
>>> A set of individual commits that share the same "change ID" is,
>>> unlike reflog entries which is an ordered set of tip of topics, not
>>> inherently ordered.  This is inevitable in the distributed world
>>> where many people can simultaneously work on improving a single
>>> "change" in many different ways, but making it difficult if not
>>> impossible to see how things evolved, simply because you first need
>>> to figure out the order of these commits that share the same "change
>>> ID".  Some may be independently evolved from the same ancestor
>>> iteration.  Some may be repeatedly worked on on a single strand of
>>> pearls (much like how development recorded in reflog entries of a
>>> single branch in a single user set-up goes).  I guess you would need
>>> a way to record the predecessor vs successor relationship of various
>>> commits that share the same "change ID", much like commits form DAG
>>> to represent ancestor vs descendant relationship.
>>
>> That is correct. The change ID should be sufficient for handling
>> simple distributed cases involving a single remote but it's not a full
>> replacement for something like Mercurial's Changeset Evolution [1].
>
> Just a random thought.  We could very easily replace "change ID"
> with a concept of predecessor-successor commits.
>
> Just like we can represent parents-children NxM transitive relation
> only with 0 or more "parent" commit object headers, we can record
> zero or more "predecessor" trailer in the commit log.
>
>  (1) a commit with no "predecessor" is like "root commit" in the
>      commit history topology.  It is a brand new change that took
>      inspiration from nobody else and that is not a polished form of
>      any other existing commit.
>
>  (2) a commit created as a refinement for one or more existing
>      commits record each of them as "predecessor" to it.  Having
>      more than one of them is like a "merge commit" in the commit
>      history topology and represents that two patches were squashed
>      into one.
>
>  (3) Splitting an originally large change into multiple changes can
>      be represented the same way.  They share the same commit as
>      their "predecessor".  Perhaps you have originally two-commit
>      series, A and B, and split them differently in such a way that
>      C has half of a and D has the rest of A plus B.  In which case,
>      C has A as its predecessor while D has both A and B as its
>      predecessor.
>
>  (4) Just like we can use auxiliary data structures like bitmaps to
>      figure out reachability without following all the links in the
>      commit history topology, we should be able to learn how a new
>      change was born, and trace how it evolved into newer iteration
>      of the moral equivalent of the change, possibly as a series
>      with mutiple commits, using auxiliary data structure, which
>      would represent predecessor-successor NxM transitive relation
>      in a similar way in a form that is efficient to access.
>
> Something like this should allow us avoid relying on "change ID"s
> that can collide elsewhere in the world without having a central
> authority to assign them.

I have a few submissions where I recorded the commit hash and the
previous commits in the email headers.

https://lore.kernel.org/git/0ab05a4cf09ba02016b4493936ad1b092b1326aa.173=
0979849.git.code@khaugsbakk.name/

For this one (v3):[1]

```
X-Commit-Hash: 0ab05a4cf09ba02016b4493936ad1b092b1326aa
X-Previous-Commits: c50f9d405f9043a03cb5ca1855fbf27f9423c759 63a431537b7=
8e2d84a172b5c837adba6184a1f1b
```

=E2=80=A2 `X-Commit-Hash`: my local commit for this patch
=E2=80=A2 `X-Previous-Commits`: the two previous commits (v1 and v2 in a=
rbitrary order)

Version 1 just has the hash:

https://lore.kernel.org/git/63a431537b78e2d84a172b5c837adba6184a1f1b.172=
9451376.git.code@khaugsbakk.name/

```
X-Commit-Hash: 63a431537b78e2d84a172b5c837adba6184a1f1b
```

And v2:

https://lore.kernel.org/git/c50f9d405f9043a03cb5ca1855fbf27f9423c759.173=
0234365.git.code@khaugsbakk.name/

```
X-Commit-Hash: c50f9d405f9043a03cb5ca1855fbf27f9423c759
X-Previous-Commits: 63a431537b78e2d84a172b5c837adba6184a1f1b
```

=E2=80=A0 1: The hash is in the message-id in my case.  But I wanted a d=
edicated
    field instead of taking it out of the msg id.  And the msg id makeup
    doesn=E2=80=99t seem documented.  I=E2=80=99ve already seen a thread=
 where someone
    relied on parsing data out of the msg id until it changed from under
    them.

>  (4) Just like we can use auxiliary data structures like bitmaps to
>      figure out reachability without following all the links in the
>      commit history topology, we should be able to learn how a new
>      change was born, and trace how it evolved into newer iteration
>      of the moral equivalent of the change, possibly as a series
>      with mutiple commits, using auxiliary data structure, which
>      would represent predecessor-successor NxM transitive relation
>      in a similar way in a form that is efficient to access.

I don=E2=80=99t know if this is related but it would be amazing if we us=
ers
could define custom indexes on the DB.  Maybe people won=E2=80=99t agree=
 on what
a change-id should mean (judging by this thread?) but with custom
indexes you could maybe get fast queries for whatever =E2=80=9Cid=E2=80=9D=
 you want to define.

Unrelated example: defining an index on `git patch-id --stable` for
quick *cherry* checks without making your own table with:

```
<rev list> | git diff-tree --patch --stdin \
    | git patch-id --stable
```
