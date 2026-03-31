Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009641B372
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973049; cv=none; b=gCJkSw0eGnEKnuGD23BGJ/W4U14o/qt2tMSEf5EUVLSR5Dopqb8tFrTy1B87JFdGPk3Ozw5hNlrrcVnJpkpQVSuAMwpYDrFYWe4e+IQEGaYkfxr3ov/EK0i79KkK1Xq1DXeTB+cR3b0qXzMqPWU+nw/VN+5SmUMXFdBY59D0JXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973049; c=relaxed/simple;
	bh=+5eCnMhRpeROLi+r9l9CdO+gvUagUT+XfdYahyRBTbE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DjfjwdxLr2eDZkQNlCmE577JI4t7UAn2bJRP25JzTf/S9pXv8OA66uauCiEg8kJGVly1eNlck/ZWq9FF294GQBXwiVghzTK+43nBW6KDE/8mE++aerRjGlJ5ssaz/NItJ14lzQ87Hme9eWLbi/M9qJoa+lRMVZMdsB7JxqiCChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JShzQKbA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOgUAL3f; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JShzQKbA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOgUAL3f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25F79140022E;
	Tue, 31 Mar 2026 12:04:07 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 12:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774973047;
	 x=1775059447; bh=UJQq48K+jPQcZ82/3Y+V8h/q+Rgn0xiFPPW/N1kLp8A=; b=
	JShzQKbAz4bd/X01O3orG08Pu4VyNRe1GMsiD5/Brb4CRGQv+J1I6X3iXxrgCwSa
	Cv0e/Vx03w4nv8K536JU/p/oUpBlX8DKAVaWh8/z66EfgC73NrhrMwuiX6WIp/uI
	ZIirLNp4NzTJYnyUANb/BtWwfzveRWyCO7G4pb39bi4TkvEvneKNEYKwNis1ELZs
	PEusq5xNJAXwIU4v/Iks8S9sup1lqBRaSEbJTf1ceyEmGgSfLuqTwiJpH3Bz+JLK
	6CjppRd7RKtFFe/YMMgcAocDXBlk6vDa7OR5qp47fFYuy0yC8L/aytgJBdOmYsPJ
	lUaj3XZQsFZ7eCePwVQWvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774973047; x=
	1775059447; bh=UJQq48K+jPQcZ82/3Y+V8h/q+Rgn0xiFPPW/N1kLp8A=; b=l
	OgUAL3fbd9tOnI0FfqVShNHQ9DhoT4vScVWgCgs/1wVlGpfxPXRkX3AL/SQVParI
	mws1+uzl+bOOrhPDjuVBxmjtXi0oFx93GHhd8hBk5frtazZW5+AgHDaakI0Zqd+s
	2cSn3SmSnfQtboJkI8rrjqDk18kSEwZeyDv38vo9rJzTAsWY+IpOrvmnDVt8CB0i
	9W93/LijnJ9wbEyQYn4TJWqGaewW7hv0uD1nVoE4iQjDbUJ0Fr37kOdUmSK6LlTP
	5tuUVILO88oiSXHJ3KjgjEJNhkXCIotFkZps3wInBaCGqVQlIsUn1+DlvWsyv5lU
	1kQR568E0tAtwXQi/of0Q==
X-ME-Sender: <xms:dvDLaeb1tvkjTv7igjn4-aUAtaHUashKjR9Zxo07PukmKmOaBm54DfE>
    <xme:dvDLacMqarOOTt5neBts87M_CWDXiMDZZFaHCScalWhAV8-OIRoD1tQzVUPz6ShB-
    _6YRsZY5Ctq_ZGgCHU3KugaIIBiq0jn0BpDyGHnZA5OqZi77hdK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhf
    fhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefgffdv
    hfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsges
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehlihhnuhhssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:d_DLaWF8Gm_M3SHjCvMaf10-UQYBNWKRf91WJBKvcVjg88gkNUN20w>
    <xmx:d_DLaQqLX8UdHNqGlPYax7KO5e3S950vbW3a-ktjGOThYDaolNgCYg>
    <xmx:d_DLaXb-RiD2n9QeHUxbaJ82hfmBSFwP3aeSIcxjanQd7xkr8zLaNg>
    <xmx:d_DLaRV70P72u_T5xag0vvdCvKCvHTqG0ZqDIVzscQbY6CedxyrTzA>
    <xmx:d_DLaSKa9YhYtebp42Ofp0TZ5qAsHSSsjct03yVwVZYjAO9H2-4uebaJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1AFE1EA006B; Tue, 31 Mar 2026 12:04:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Tue, 31 Mar 2026 18:03:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>
Message-Id: <660b739f-a738-4359-92bd-cb24f5bcd624@app.fastmail.com>
In-Reply-To: <8E736B70-424E-48AC-A6D0-9A8B091D21F6@gmail.com>
References: <5ba0bbcb-25a7-4ad0-ac1d-c86508eaffdd@app.fastmail.com>
 <8E736B70-424E-48AC-A6D0-9A8B091D21F6@gmail.com>
Subject: Re: [PATCH 2/2] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, at 14:35, Ben Knoble wrote:
>> Le 30 mars 2026 =C3=A0 18:26, Kristoffer Haugsbakk <kristofferhaugsba=
kk@fastmail.com> a =C3=A9crit :
>>>[snip]
>>
>> Key & value.
>>
>> Something like:
>>
>>    Just like *trailer* we emphasize these two first standalone word
>>    mentions (key and value).
>>
>> They are the only emphasized words in the diff. Although I *have* rel=
ied
>> too much on the diff context before.
>
> Perhaps =E2=80=9Cwe emphasize the introduction of the terms =E2=80=98k=
ey=E2=80=99 and =E2=80=98value=E2=80=99=E2=80=9D
> (much like a technical manual or paper may emphasize the first use of a
> new word or abbreviation, making subsequent uses link to it so readers
> can find the definition)?

I think I=E2=80=99ll steal that. Thanks!

> I do find it interesting that the introduction is with an example
> rather than a definition.

The example is from Linus Arver in d57fa7fc (doc: trailer: add more
examples in DESCRIPTION, 2023-06-15).[1] The version before that[2]
indirectly showed a `token: value` example (=E2=80=9Cwill appear in the =
output
like=E2=80=9D) after five paragraphs.

=E2=80=A0 1: One review comment: https://lore.kernel.org/git/xmqqmt2emwl=
j.fsf@gitster.g/
=E2=80=A0 2: `git show d57fa7fc73202af226b6c0^1:Documentation/git-interp=
ret-trailers.txt`

> This suits =E2=80=9Clearning order=E2=80=9D (concrete->abstract), but =
not necessarily
> =E2=80=9Creference order=E2=80=9D (where I just want to get to the def=
inition). Hm.
>
> I=E2=80=99m not sure I have any concrete suggestions, though.

I think the only practical starting point for this format is the
simplest case first, namely:

1. One line per trailer (c.f. the value takes up multiple lines)
2. Non-empty values (see `--trim-empty`)
3. Default separator
4. No non-trailer lines
5. No configuration

Currently that starts off with two examples. But let=E2=80=99s try the o=
ther
way around:

***

A _trailer_ in its simplest form is a key-value pair with a colon as a
separator. The _key_ consists of ASCII alphanumeric characters and
hyphens (`-`). A _trailer block_ consists of one or more such
trailers. The trailer block needs to be preceded by a blank
line.[**1**] In other words:

    <text>

    <key>: <value>

Where <key> consists of ASCII alphanumeric characters and hyphens. For
example:

[we=E2=80=99re back to the original example]
------------------------------------------------
subject

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

Signed-off-by: Alice <alice@example.com>
Signed-off-by: Bob <bob@example.com>
------------------------------------------------

***

Also optionally interject some words about commit messages and whatnot
(or even tag messages for that matter, now).

I was originally feeling skeptical of changing to something like
reference-first. But I like this now that I have gone through the
exercise of trying it out. So thanks for mentioning it. ;)

[**1**]: git-commit(1) stripspace behavior etc. doesn=E2=80=99t make this
         obvious but you can have just a blank line and then a trailer b=
lock. You
         don=E2=80=99t need any text before the blank line. `LF` indicat=
es the blank
         line:

               LF
               Signed-off-by: Me
