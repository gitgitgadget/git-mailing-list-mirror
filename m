Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26930C60B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633690; cv=none; b=O3NyhHg+RfFNu1MZKEoxeXsiuMpgorG6i2CI1fnNUd5TC4g50cMom+2te3ME+GZumOI4WKbeCQgI0cNStv+al5l/9jJgexHtcUFapwVjY84wAHCMumoB3l7yQl4GhFCtuB8cWksRoKqrfW/iNEUpG8YiSqRps2yHG3BKf5WJ+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633690; c=relaxed/simple;
	bh=pQZE1fLk4C0ZAvgbMe3drIPi+aaJZJfenQZZsYF4XBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3hbM+qcOXH4T+KgguG2lIUJfdBSA5pA7JCamYMSOMRWufvW9HFeNIe3FR6qNYcptebqRKG76RjFU60sQ5lDqYADoeieoMntplcC0C9tQUTd1Rv0Qc6dcmPgqn/8N64c39GTB1CwjtlzaD4DQ8fsm0xyMAVuckRpV4NyfralwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YLHghZG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJ+4r+Yk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YLHghZG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJ+4r+Yk"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1A3F7A00B9;
	Thu, 16 Oct 2025 12:54:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 16 Oct 2025 12:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760633686; x=1760720086; bh=84w0UJoDI6
	5buaD7uJapN8YqYQAVG+mIJtP5PdR4bsA=; b=YLHghZG1cu0h7+4LJmD/izWHNV
	kt0l0N3qXMsncgvZy3/CXyFXY+GtG0PjyCYaC1B3r0hZhrJBOn+8NkDPrW0lxlz/
	7UvkoUkpMoDZFu9oiCaN7XMRqhYnRm6clYxHP7N6gnKbqkNDeMSCLDXNf2UmO3UB
	SfJZUiBLB2LUAx4T8D4wRsthNl8NY4qT4TcWvx3ez0VHE4OCDZJo4qr+iMNcY8JR
	SfTgLHnF2CL+KAKGq79WRQiIOdVE4XS37H5UnDyAlLzKeqvAyUsETpTqiinxciNJ
	nhmRTZ8eXbUt2padHbqmFPdrD0LRgXdjrtscD06DMN1hh0QEYHqx2MsE7Mbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760633686; x=1760720086; bh=84w0UJoDI65buaD7uJapN8YqYQAVG+mIJtP
	5PdR4bsA=; b=rJ+4r+YknUuw/3VOtkE8TevyQnj+Pio+sRC4TFwzvXHXZ3LUbkV
	lfWj5N9A94Ce7JKd3M8HpI3IKXFRK5bKTFXZNOlZzgSxXbvIIDr2Nvmm/Dr9d4Bq
	B+vnbtnBDhvMHHqxr73S55sEfgThgDxsaWuBzHfG2vGXzDCjJGo+yzz5X5BucJnX
	4nkGm37erOE/NyWpjLNPJ9jBV2zuCbc+KmMqpX8WACCIX+XdlXNp2P+qf1WouAnK
	kIvwLhyOJC3pOXuZy9+mNwInoLwbHd4eQxDoSec+iYe2Ybo/kvEsH0+RVVsFaoup
	3zQwj8NCer3/bbso1/dEVQG6RyJpvSsyWNg==
X-ME-Sender: <xms:ViPxaAshOIuqADXTOkBJmjiOvjgU4Jfl11a_vcZ7QY7e-HKhjfWoBw>
    <xme:ViPxaPv3h7OIJCR4-AS4IV9UPxvjJeh_uSmfOKQj8R9DLlC483oyLvPGaA5jzwBQp
    wSw-gqBGK6v4Yfdk0RLD5lZkHt181F3wGk-4U0HEweDS0LyAtFcqQ>
X-ME-Received: <xmr:ViPxaODzV8p7Rw67vxmA_HN86rKDOMuc4gNFpwjyNX6Bpz6YhsX9ggyDvgizyjcg3icwySdjeiLsdNfXMF3g3-LM4gPPq8Eg-F_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeikedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ViPxaJOEvc15BA4lw2QPCSzeu7SfJ46yg1hvm82cIS1BjaK_sl4VcQ>
    <xmx:ViPxaPxYBth72qMCpMsYfAM0I79NRsUhKIRuS8XU88qtBqvIMJGGBQ>
    <xmx:ViPxaBWrQ5GPO86ffHDQiT15hBIxNY3zlxJdKaNqNLyLVbcc3m7yKQ>
    <xmx:ViPxaJMRuwamKoZztXCMzKzSM7fhdDkkZwHISTcBqPhybIxczOF6LA>
    <xmx:ViPxaJgrduRVCeQcI6JSSxs84rXyUU5PlsNDzGmc-xkcV-nVmsNOk2Iv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 12:54:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
In-Reply-To: <0eb276ef-7b1a-4e79-93da-13a83226aa01@app.fastmail.com> (Julia
	Evans's message of "Thu, 16 Oct 2025 11:19:46 -0400")
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<xmqqv7kgszr1.fsf@gitster.g>
	<0eb276ef-7b1a-4e79-93da-13a83226aa01@app.fastmail.com>
Date: Thu, 16 Oct 2025 09:54:45 -0700
Message-ID: <xmqq347i948a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>> +[[tree]]
>>> +trees::
>>> +    A tree is how Git represents a directory. It lists, for each item in
>>> +    the tree:
>>> ++
>>> +[[file-mode]]
>>> +1. The *file mode*, for example `100644`. The format is inspired by Unix
>>> +   permissions, but Git's modes are much more limited. Git only supports these file modes:
>>> ++
>>> +  - `100644`: regular file (with type `blob`)
>>> +  - `100755`: executable file (with type `blob`)
>>> +  - `120000`: symbolic link (with type `blob`)
>>> +  - `040000`: directory (with type `tree`)
>>> +  - `160000`: gitlink, for use with submodules (with type `commit`)
>>
>> It is not really "supporting" file modes.  Rather, Git only records
>> 5 kinds of entities associated with each path in a tree object, and
>> uses numbers taht remotely resemble POSIX file modes to represent
>> these 5 kinds.
>>
>> Perhaps "supports" -> "uses"?
>
> "Uses" sounds good to me.

Also "much more limited" is misleading.  We only represent 5 kinds
of things, so we use only 5 mode-bits-looking numbers.

>>> +2. The *type*: either <<blob,`blob`>> (a file), `tree` (a directory),
>>> +  or <<commit,`commit`>> (a Git submodule, which is a
>>> +  commit from a different Git repository)
>>> +3. The <<object-id,*object ID*>>
>>> +4. The *filename*
>>
>> Here it may be worth noting that this "filename" is a single
>> pathname component (roughly, what you would see in non-recursive
>> "ls").  In other words, it may be a directory name.

Comments?

>>> +[[blob]]
>>> +blobs::
>>> +    A blob is how Git represents a file. A blob object contains the
>>> +    file's contents.
>>
>> "represents a file" hints as if the thing may know its name, but
>> that is not the case (its name is given only by surrounding tree).
>>
>> "A blob is how Git represents uninterpreted series of bytes, and
>> most commonly used to store file's contents." or something, perhaps?
>
> I'll say "A blob is how Git represents a file's contents", unless Git has
> another use for blobs that I don't know about (I think it's not
> that much of a stretch to say that a symbolic link is a special kind
> of file where the "contents" are the the link destination).

A few configuration variables like mailmap.blob name a blob object,
for which _only_ its contents, i.e., the sequence of bytes, matter
and where they originally were stored does not matter.

But we are falling into the area of tautology, as any sequence of
bytes can be stored in a file so they can be called "contents of a
file".  But the point is that these bytes do not have to be stored
to become a blob (think: "git cat-file -t blob -w --stdin").

> I think it's always clearer to be more specific when possible, if there's only
> one purpose for blobs it's unnecessary (and IMO a bit misleading, because
> it makes the reader wonder if there are other purposes that they should
> know about) to say that blobs can be used to store any arbitrary bytes for
> any purpose.

I do not think describing other use cases is unnecessary.  Even if
we limit ourselves to discuss a single purpose for blob, i.e. to
represent the contents of a file, we should stress that blob is to
store _only_ contents, and not other aspects of the file (e.g., in
what paths with what mode), and that is where my reaction to "how
Git reprsents a file" comes from.

>>> +[[branch]]
>>> +branches: `refs/heads/<name>`::
>>> +    A branch is a name for a commit ID.
>>
>> Well a commit ID is an alternative way to refer to a commit object
>> *name*, so it is a bit strange to say "a name for a commit ID".
>>
>> Perhaps "A branch ref stores a commit ID." is better?
>
> I think I'll leave this alone, none of the many test readers reported
> being confused by it.

Would a confused person report that they are confused? ;-)

> I see that you don't like the "name for a commit ID" phrasing :)
> Maybe there's another way to say it, though again none of the test
> readers said they were confused by this or disagreed with the phrasing.

Yes, I get that given "refs/heads/main", you want to say "main" is
one of the ways to have repo_get_oid() to yield the commit object,
and you are using "name" in that sense, but it is more like a ref
can be used to name an object.  It is *not* the name of the object,
because the object can have other names, and more importantly, it
(i.e., to give a name for an object) is not the only thing that a
ref can do.  And that is why I do not like that phrasing, combined
with the target of giving that name is spelled "a commit ID".  The
commit ID is already another way to name the thing the refname can
be also used to name: a commit object.  A commit object and a commit
object name are different things.  The latter is a name that can
refer to the former.  And a ref can be used just like the latter to
refer to the former (i.e. "commit object").

By the way, I do like the way many of your responses are "will think
about it more", not "I'll take your version".

Very much appreciated.

Thanks.
