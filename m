Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57729DB6E
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775985058; cv=none; b=DS5Y83NxUtXsaNVVu30ERbhASsgzTD60uOm8Ao0uNGP/z97BeUM2k9YQCQz+h8QCl0wxDZKlVMG4WQ7iSBae841+brGfFTRuXxWaU+CU4hjLjHKUTvHao4ihW6nXwFhTYfJoRjWpKTRdkdFEg+tCf3/2AJctQbjxyREY8bzVUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775985058; c=relaxed/simple;
	bh=fV/OvmHpFkI9L1w7LCHVQ17tTFGXJ/WPF+3wNE5fDAo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZtE9o78x8ZC7iHOW461/T070uU4FWtXrk6tkG5L82q5DEj5fWuN4M+BCZ8QNpFQoU4lGqtGJL0ANhqUPUc6Jvd/CZpdcfisJECkT24/HPKWUDicBWFYe1u1lDYsoiRChYbKaENDD+A5g5SOJTf1KBnkXpRGl0tXIU0drzBNBS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SfHIzbDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CyzSTFKY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SfHIzbDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CyzSTFKY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AF6DEC0414;
	Sun, 12 Apr 2026 05:10:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 12 Apr 2026 05:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775985055;
	 x=1776071455; bh=fV/OvmHpFkI9L1w7LCHVQ17tTFGXJ/WPF+3wNE5fDAo=; b=
	SfHIzbDByhrPuUl3jzK6ptctG5zS0ibLXdpQsvOZwaC/v5vKWr2LRkGXATrRDrgN
	39SXVP1OwUwWOw2v+TiI+7OFXpMz3U2SQZ4qX4n67MjpXhJJPbg/8UgB0IidB6DQ
	1y3l0Ce/jcmmhEHRacQ9GbUUrewymXZEufMhPgI+2PvMpEv6PbwzCZ4qaqxcvr6P
	TJ21IFS6+CBqLjy8CAJh8bGadAF581yDHgVnexr9z29Psgt8lVcsi+CXN2Ujsjtk
	lUSWtg2kt/zo09dqVi2dcrfZDooMSIzD3TZgsxgWgrs2Fthw45zII4qEyCaPlR+h
	mhvUEZovEo9VYyMNHxcIDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775985055; x=
	1776071455; bh=fV/OvmHpFkI9L1w7LCHVQ17tTFGXJ/WPF+3wNE5fDAo=; b=C
	yzSTFKYGjxYGkfWwRKRrcTmVLCAR+CoIn329TXz2eFa+cQ+J4/skP1fHA1qNOXcx
	LssoRBvN1EtyJ1QFw0p+YHdvSCRlBk/p1L+ev7LPWVOE9lyuU94O6FL1wT49VN12
	+GkObluPF9l7tQtpKlXQifDtfja281VIFXK3bu24UGvX2Ay08/Q0OaisOLPng9xR
	UPKpFGebWXlENAHbjacrwWE9SZUM+RVXcfo9YYy5eK1wSIaj7wkaGYkcF+233m+O
	Bke2zulTSST94bThbUOaWr353dPuQvQG/2VWLuAZI66Q7f/XKVgXgeaOpYuVBQL8
	u9YSjEmUi5f9xngx+bqcg==
X-ME-Sender: <xms:n2HbafEvVCZSEVX_wTsWOOphiMe2H6mhC50ZTx20pKHeEdinh-x-V8s>
    <xme:n2HbaXLDpQC_UulVbDciYcAtfsUChQJkFhQ5j4h5JVAnZ2v1_194FUYoZX6On65t5
    bHEoAxgggA9Ur7rh2AhGN5MMrJK44KI1wzDewN--sq8C6VyXAYbNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefgeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:n2HbaVx1Pni_SDdXpZKgTpkC4E1Lw_3klmbhp2CbsGzWsuVC8_gtTg>
    <xmx:n2HbaTPpsnDSn3UrKjGagUCbVoOGPKvDN4C_BwPin28bOiQYmjCF0A>
    <xmx:n2HbaW6ae9gF8BWadJ1Ml7fpvs_UTR3zjCZpjHjhXzNrsxyzkckPdQ>
    <xmx:n2HbaUOAX5i25ALycrUqlrIHmi87STgOjMQJc5C5N08VkGUJhHmang>
    <xmx:n2HbaRneN1QrV0RkyScpp2zv4JJGBCyRzLBh-PwLDfX-rA0ckqmrL39O>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6359D1EA006B; Sun, 12 Apr 2026 05:10:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A__05JlRJZT-
Date: Sun, 12 Apr 2026 11:10:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <ee8d43cc-c38b-4a55-8237-94f92034d62f@app.fastmail.com>
In-Reply-To: <20260411215518.GA1651019@coredump.intra.peff.net>
References: <20260411190625.GA754966@coredump.intra.peff.net>
 <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
 <236b32a3-a04b-4d20-8290-02a464037b1d@app.fastmail.com>
 <20260411214213.GA1563438@coredump.intra.peff.net>
 <20260411215518.GA1651019@coredump.intra.peff.net>
Subject: Re: [PATCH v2] gitglossary: fix indentation of sub-lists
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026, at 23:55, Jeff King wrote:
> On Sat, Apr 11, 2026 at 05:42:13PM -0400, Jeff King wrote:
>
>> > I think the first thing is caused by the context already being in an
>> > open block?
>>
>> Yes. Looks like asciidoc learned to handle nested entries better, but
>> perhaps asciidoctor didn't.
>>
>> I think I've found a workaround, which I'll post in a moment. Thanks =
for
>> reporting.
>
> Here it is.
>
> -- >8 --
> Subject: [PATCH] gitglossary: fix indentation of sub-lists
>
>[snip]
>
> Usually we'd fix this by using "--" markers, which put the sub-list in=
to
> its own block. But there's a catch: in some of these spots we are
> already in an open block, and nesting open blocks is a problem. It see=
ms
> to work for me using Asciidoc 10.2.1, but Asciidoctor 2.0.26 makes a
> mess of it (our intent to open a new block seems to close the old one).
>
> Fortunately there's a work-around: when using a "+" list-continuation,
> the number of empty lines above the continuation indicates which level
> of parent list to continue. So by adding an empty line after our
> unordered list (before the "+"), we should be able to continue the
> definition list item.

Nice.

>
> But asciidoc being asciidoc, of course that is not the end of the stor=
y.

Ouch.

> That technique works fine for the "glob" and "attr" lists in this patc=
h,
> but under the "refs" item it works for only 1 of the 2 lists! I can't
> figure out why, and this may be an asciidoctor bug. But we can work

You mention =E2=80=9Casciidoc being asciidoc=E2=80=9D but here it seems =
to be
about Asciidoctor?

> around it by using "--" open-block markers here, since we're not
> already in an open block.
>
> So using the extra blank line for the first two instances, and "--"
> markers for the second two, this patch produces identical output from
> "doc-diff HEAD^ HEAD" for both --asciidoctor and --ascii modes.

Nit: s/--ascii/--asciidoc/

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>[snip]
