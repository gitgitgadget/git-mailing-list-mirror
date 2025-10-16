Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186E2580FF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647710; cv=none; b=HFkhCHb/Gt8oeL7yWUTS5hfxHjbjubfad6Iv3MUboGUz135j0sIM6Ay6k5TDGjrPZAswXYdSkx2lWBLRdsmd405VoQsd5HWUwMlSLUCtPh83YdJA//h2Y7dvYdj7h3Gyzlb2fPX/oXMvJLZToSgfc+WVuu39EBiKFa2oK8E9FVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647710; c=relaxed/simple;
	bh=TkxnuFf0IefwyBJXERGQPUhOK+wocx0QWDKD3hGVgSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cEmBP6u+OMHte0+H/DAEXzuTRzwIS4Wpo4x4OU211ASp+le16c/LwxQdpZiQXyWIUN8ZmL15K9TyJc34+/ziK0on9tjIXBPcofpRDDlL7+OxlnoUVWExQlARqc6u2ZCKaq4znjrFEHpRIgWw9UbdZYGKDzBENAzkFoJhUnebxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F2+HUwSH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xN/OHZTe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2+HUwSH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xN/OHZTe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 049B1140010C;
	Thu, 16 Oct 2025 16:48:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 16:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760647708; x=1760734108; bh=zgaQCSLwD/
	PyXt7MX9ne3wUDPfenV4vHFm4zlD46Oj4=; b=F2+HUwSHNXvL4VNVXC5xdZVI9g
	UZ6T6CYRRvrJ9LZ7A5G/l1EVm05H29Ld8Myum3nRRFy6mXBaJcpe0YHei5E7C0ul
	tGzvh491lFqMCWbbeaU+0jDdrZNfJ+NDYJsJy7Jpz53BchmFU9nTbRXlTPH3UEEC
	Mfs5a+fGyyYC+5w84oVLbIwVEHQ1y0NXnvAVb/nSBzeGvG2wiQJTqOojTDnOWxEt
	Yy+PDV2Wm6+WPOlWtSswxJNm/RhHKeD+OARrR+enx4DSIq4bFqIHmbXLMku8wUEk
	LXAKgUI237p5wvzjzhteNMyogmASc0kuUeMz6KnhkL+Kcjor0zM6O9FD7jsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760647708; x=1760734108; bh=zgaQCSLwD/PyXt7MX9ne3wUDPfenV4vHFm4
	zlD46Oj4=; b=xN/OHZTeFYQoMtet38q0yKMqzW1nCHx3/UVRi0bS/S0CtWCP4Qm
	UWDiiRNHql9dXTrc+y2w5KryWk1EmawBe8aDUqlcchZzksAaAzv47dUialTPZKs9
	Nu0nTYwZnqlTK/1Gb177VQ1cj/Lu5fjnWbX7QxHSqwok073zCEfamc5UyiSiMrhI
	TgRVKxiXd9gp7KmvvsvriyaK/WvC86korZxuIEoznd6dH6UIu6zAkmt/C4/6wV9x
	2JuqPeAMX7PZDDTYPuxBNfC91a5l9UEP+gdNXdcg4Vm6/HY3mabRM88/cj8gsPkP
	d/XxO2WJOk4nBvP+qjGeNtawT9xfCgg3A+g==
X-ME-Sender: <xms:G1rxaKKZMRwCai1sIBv9YIOMnLCYJI4wHnm3Ez-SPbf8lKz8-LWouw>
    <xme:G1rxaEb6S60NDcrrl7HMOkDs5u-9IHKMG8ko2eRXpXrP_k9zU2GhJ5F5Y3XzBjMgI
    xF8Cz5d2BIv2dRdQe84_wJDh7KqeDG36atY2QKrH9QTBtDKnwMY2Q>
X-ME-Received: <xmr:G1rxaM9PAGTZfOw3qqhfvQtonYiiRQGGHaQm3w4bOJHX75Wls35TzflhBTzp8mt0IG4T_ApnyxYGPTUYDvzP206GxsKfsXJTkFVT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:G1rxaFZjWX-8JCqDFD-sRAYR-lOAmuXmdi9sFmfvoeXhRJwGhGqNjg>
    <xmx:G1rxaANkS_cu9f-9V7-E4sqg472XVPl15UxtnuUh_03TXcGnYbiLsg>
    <xmx:G1rxaBCnBSbOvN1HZUiQ4hAZYO12ahiFoqFGq8y6SSPxjc9nPOWfMw>
    <xmx:G1rxaHLdGpu-Dk9RjxM9k485I0nY5VdNcXLB3ljnYFVLkciEP7PYoQ>
    <xmx:G1rxaFPPMbLwRrPH_gj42T6desUxRPcbOKnqMpIYy0Bf72xhTnB_A0Kq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:48:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
In-Reply-To: <03db91a6-148b-436f-8afa-0273a1f5d508@app.fastmail.com> (Julia
	Evans's message of "Thu, 16 Oct 2025 14:59:01 -0400")
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<xmqqv7kgszr1.fsf@gitster.g>
	<0eb276ef-7b1a-4e79-93da-13a83226aa01@app.fastmail.com>
	<xmqq347i948a.fsf@gitster.g>
	<03db91a6-148b-436f-8afa-0273a1f5d508@app.fastmail.com>
Date: Thu, 16 Oct 2025 13:48:26 -0700
Message-ID: <xmqqbjm63751.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>>> It is not really "supporting" file modes.  Rather, Git only records
>>>> 5 kinds of entities associated with each path in a tree object, and
>>>> uses numbers taht remotely resemble POSIX file modes to represent
>>>> these 5 kinds.
>>>>
>>>> Perhaps "supports" -> "uses"?
>>>
>>> "Uses" sounds good to me.
>>
>> Also "much more limited" is misleading.  We only represent 5 kinds
>> of things, so we use only 5 mode-bits-looking numbers.
>
> What does it mislead the reader to think? My goal is to communicate that
> if you want to tell Git to remember that a file's Unix permissions were
> 700, that's not possible.

Yes, rewording "support" to "use" is one good way to do so.  But
"limited" implies that lifting the limitation would allow you to
store more.  That is the misguided thinking I want to avoid here.
There is no limitations to lift.  We only differentiate 5 kinds
hence we only use 5 permission-bit-looking numbers.  We do not
differenciate a file with permission 0600 from aother with 0644.

>>>> Here it may be worth noting that this "filename" is a single
>>>> pathname component (roughly, what you would see in non-recursive
>>>> "ls").  In other words, it may be a directory name.
>>
>> Comments?
>
> Oops, missed this in my first pass.
>
> I looked at them man pages for a couple of commands ("mv", "cp")
> and it looks like it's normal to refer to files and directories jointly
> as "files", or refer to them as having a "file name". So I think it's okay
> to call it a "file name" even if the "file" may be a directory.

Ah, not that part.  I was more interested in seeing how we express
"in these names, there won't be any slashes".

>>>>> +[[blob]]
>>>>> +blobs::

By the way, I kept forgetting to mention, but why are all of these
listed terms plural (not just object types but also "branches" and
"tags"?

> But it's not true that Git treats blobs as opaque binary data, unlike
> other blob storage systems, Git has diff and merge algorithms to
> interpret the contents of the file to some extent and try to do useful
> things with them.

Yes, but diff and merge happens way above the object layer, where
the question "what is blob" has a meaning.  And these "blobs are
recorded in a tree together with other blobs and trees recursively,
and the single top-level tree describes a snapshot of a single
state, which is recorded in a commit" data model descriptions is
exactly about the lower-level object layer.

> Another goal we could have is to be clear that there are no limits to
> what kind of files you can store in Git: you can equally well store text
> files and binary files.

That is a natural consequence of blobs being nothing more than
uninterpreted sequence of bytes.

>>> I see that you don't like the "name for a commit ID" phrasing :)
>>> Maybe there's another way to say it, though again none of the test
>>> readers said they were confused by this or disagreed with the phrasing.
>>
>> Yes, I get that given "refs/heads/main", you want to say "main" is
>> one of the ways to have repo_get_oid() to yield the commit object,
>> and you are using "name" in that sense, but it is more like a ref
>> can be used to name an object.  It is *not* the name of the object,
>> because the object can have other names, and more importantly, it
>> (i.e., to give a name for an object) is not the only thing that a
>> ref can do.  
>
> That's interesting,  what else can a ref do other than to give a name to
> an object?

For example, a ref is a key to reflog, so obvoiusly it is more than
just a single commit.  If you say "git checkout main" and "git
checkout main^{commit}", they refer to the same commit, but the
former is a sign that you want the next commit you make from that
state to grow that branch (and not any other branch you may have
that happen to be pointing at the same commit), while the other one
is not.

>> And that is why I do not like that phrasing, combined
>> with the target of giving that name is spelled "a commit ID".  The
>> commit ID is already another way to name the thing the refname can
>> be also used to name: a commit object.  A commit object and a commit
>> object name are different things.  The latter is a name that can
>> refer to the former.
>
> I'm curious about why it's important to you to make this distinction
> between a commit ID and a commit object. To me the commit ID and the
> commit object come as a package, since the commit ID is calculated from
> the commit object.

It may be the most natural name for the commit object, but that does
not mean the name is the object.  Let's not go phylosophical.
