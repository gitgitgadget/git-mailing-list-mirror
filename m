Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EA29A1
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744070; cv=none; b=MDgh8I15oGP9ldqH7j8y5WYVkgBUgk4zvoYM4s+RqEFQFNWXtNqMhC6WvGdA5duG4syqVp8eyOGMKkdgAlgJFT+5piuD0Ink+IUnBijIzQuy/x1/KvQM7KOTndIrpG/lKzPn/FGrjaTagBSzdPcNECVZ07wang+CfWf74tOUmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744070; c=relaxed/simple;
	bh=IrcchSOPBzmn+Ls1rgoORj+FqTty8qicSPDBiAxnudo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrdmF3H5zb8FzhDAJ+HruSHB7O4whQCg4McMNAy9ERCnUR4hd8jb1MCJVk8/+xYc+yB1GAcrkyKWGdnZL1ZoDUpIeP29IBAqiZ/UjXurfCvCZnvSrWhVkEofmrBt2P0+DCMv9TnKqnuJt09QKd+Sod11bwXmpUHXNgP0VT9gVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hn86Iq8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahalYq5s; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hn86Iq8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahalYq5s"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37C0F7A00A2;
	Tue,  6 Jan 2026 19:01:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 19:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767744067; x=1767830467; bh=qYU8Iju5EM
	4tvYHMbRhaNC2SKCXNN28xXDcVbHsAnJI=; b=hn86Iq8QJ+BfyQgpCSSyZ5nqQw
	4Jn5GjzXS4uPTFnruh9Q9egsBRoYzLH0gHU3MTRQYAQVnAmd9Pw8Q8r3bAWppsfU
	+AFAmC9XELwdXIJ5uzJ0OHbkJuM9+Q4JpkDfYMbT8KQB1mybWMnzUhP6QSgzOkFI
	4jI+8PEKbV30Zm6EAvRlub+bQ9jty57TJmTOsX1N2vU3zmHUbZPDzIfpRul3zNXd
	En4ekIYb7sdI30V7MLqXXs8fzAP3tPec20Ygxv18FHmklUgkpg8kQQaFziAoRkF/
	Ne4aZVxadT5Y/6CN/X550GhRS2h+6yoEPJ++I9o4ItnVT7z3qR+z2MhFt/MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767744067; x=1767830467; bh=qYU8Iju5EM4tvYHMbRhaNC2SKCXNN28xXDc
	VbHsAnJI=; b=ahalYq5sKL+NoQ73pHHl9Tiuqg7Cd4UqA7tLmpHgScugiiKfQmz
	ce4Wy5STepYZLbO4nozZui6FH57Ve0qdHsRDBiAHhdQnkHI695jEfe5tlg9udg4A
	uZVSEK+J49ztskPgjspaRIuqMzJejDhPb6SJIG++jo3Mk2NDSS1Pqshqswyp45m0
	Y+ROsJsExAkuCNSWd9ygKBZB7g4zUeg9MChYiWa1YnOscPpQ2XTb7Gtskczw01uT
	B8z5TwAms3FQjciH9nX/z7lynV9kRdP2+WULqz69DFKsIJ1K2oCEYGMGTbKNWowz
	7FeTOcdmnJFyU27Z9RLtrePLyEBEzFONobQ==
X-ME-Sender: <xms:QqJdaTB7RbmkBCXqG2oiljc0H1rqG6JfsxlGmZxllk7c1z4s1z3SNg>
    <xme:QqJdaR_uRchs0hTrwMME99qYXUAJI-Yle4G306Kc6-9JBFfTXanmFwkBvAEFL5Z9T
    2y2tT1apMDIYhqAM4G4DUAy0gKKuSGhY7vc3cJifeA1hoGwHt8o>
X-ME-Received: <xmr:QqJdafCsN2QwsGTnNZVFOTFd4M2uwV_V_k6zVf4XFNeczxkqE-KBbNuFZ_GYYzHf8jIXDRxqUz3kC2yk5kO6_0hMT8Z33t8yyA6lnD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehguhhsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QqJdaWQRyqTaSOD84gI2xmnn_9NU8C8GiLeFb9JU5M1kUxltQM9z3A>
    <xmx:QqJdaWteCQXoCFyqIRGMy8S1VLRjqbo2UW9RGttcVjHvdL4sPgZ7lg>
    <xmx:QqJdaS3MfXLdt0snz9GE8UJofmG7i83whKjTPboHQMmBpE_qVKfxcQ>
    <xmx:QqJdaXVhSgPIgy-eb0IpQsqUhgQYgb1HECkKfIK46meyCS3zfOQvpQ>
    <xmx:Q6JdaVaJeWgos_Y1pYPC9A0mFzkRHUTpNuRZgj7WCUfbm2MD-rwkhj5B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 19:01:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  Gusted <gusted@codeberg.org>,
  git@vger.kernel.org,  "Toon Claes" <toon@iotcl.com>
Subject: Re: git-last-modified on bare repository
In-Reply-To: <39eb6099-49ec-4ebd-8347-e2f2e18f3e8a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 06 Jan 2026 11:54:39 +0100")
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
	<aVvSwkK7RdpFDaVv@pks.im>
	<8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
	<aVvWDDtBeJMIF3F0@pks.im>
	<eecb1c9a-4dc9-4666-b2af-1e3478109db3@codeberg.org>
	<aVzcyYjR8l-xXD4L@pks.im>
	<39eb6099-49ec-4ebd-8347-e2f2e18f3e8a@app.fastmail.com>
Date: Wed, 07 Jan 2026 09:01:04 +0900
Message-ID: <xmqqbjj6jnpb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jan 6, 2026, at 10:58, Patrick Steinhardt wrote:
>> On Tue, Jan 06, 2026 at 10:42:55AM +0100, Gusted wrote:
>>> On 1/5/26 4:17 PM, Patrick Steinhardt wrote:
>>>>[snip]
>>>
>>> Yup, git from source works! Do you by any chance know if 05491b90ce is going
>>> to be in v2.52.1?
>>
>> No idea, point releases are typically done rather ad-hoc. Let me Cc
>> Junio though so that he's aware that we might want to pick this if we
>> ever release v2.52.1.
>
> `RelNotes` says that this will be merged to `maint` later which points
> at tag v2.52.0 currently.
>
>      * "git last-modified" used to mishandle "--" to mark the beginning of
>        pathspec, which has been corrected.
>        (merge 05491b90ce js/last-modified-with-sparse-checkouts later to maint).

These are really "if we will produce a release out of 'maint', the
topics marked with these can cleanly be merged to be part of it",
and does not answer "if we ever have 2.52.1?" at all, though ;-)

I am on a bereavement leave now, so expect that my response will be
leaky and slow.

