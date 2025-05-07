Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40591E22E9
	for <git@vger.kernel.org>; Wed,  7 May 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650966; cv=none; b=bEw2C1UikP1a2djsWNIgzaElv28/EwZmpXpPUnn5ADFnNI4ecXhDMm6oWmWdOfPRjIRO8jhGlxFI2P2wYL7Gyfz8mKSPm9bjzkN9A9AQQ8sDYbedGA6XnyT9YE/j5cvU3da1j+KzwWfCqEA7srqvKloewUYcpSWg/VjFKwjm9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650966; c=relaxed/simple;
	bh=eR/AeMKo97SpJyK8c+5ppbn8oOdyQPxY+pL0mo9X2uM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BkUjnCuMsnWuhBdj6X6ou0cprzfDHo+bd+mWSUvlxoWLuCBhvbz6V4D6ZOdqGDyOwtWJuc0QHOJjpiTLmUkTQXmlO/2gWT59hjqW6h6DEDuSAhaZLwW8D5eATVnpPJhV/3kPTjh8hDSK6nx0RPdeOiP5RIPiESZJqidJqj8gx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LeOC0xJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azhYAHVs; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LeOC0xJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azhYAHVs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C18C114016C;
	Wed,  7 May 2025 16:49:22 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 07 May 2025 16:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746650962;
	 x=1746737362; bh=X2cupYqYZ5Mtf0mIZdgaRESEO/caV1Xkg1kOYzMYX7w=; b=
	LeOC0xJxiJbbdCz/hF1BJwuWo2P4A1FkERWeocF+2sC00e6JQxdLcjol0N2XaDUF
	2wNjpSLYRd5mYnY2nWiI9jRb1S4kzndQr1hGJZ9ypW7G15ZHZKjS010dPH4arglz
	luM+oy+xyxuRA3ubMYHcRhph2Mk2C64FrlZecZC/lV3S+77llOAijqoUJjXm33XB
	cxSgAsLNoHa3T77TUxnjcip2p5lb/Jge3197PIkE+mdTfBUP6m0aBifMsvHECbC9
	lH7Lh7tf25ZvTc/qbFvCeAZx4ZAOJLX6OlA1bUZORt28ZcGA9TgpBzylubBt8rSJ
	6rm9bsrmZkXNrXEVA2o5Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746650962; x=
	1746737362; bh=X2cupYqYZ5Mtf0mIZdgaRESEO/caV1Xkg1kOYzMYX7w=; b=a
	zhYAHVssrgmN0mlPlJ0ZhroKfbu4DZChYyEwRK/yMiOAD5ri+epsi7wxlzExEMSB
	nh9ClkwwCJ1PRrnXjBbQxwsAcTYzGu1UV93VH3lqCDxAbP6gSaNFME3y9xpIMGcd
	I/f8b/xPzD3RRuRA7em4DJ/FVqyQqm2DQcN9ZwyUzeWYsUXKhL0A2selSO42UeLW
	IYDi88Rm0X74PWMU2UKtgT4NuhqB6nWZ4VaPbFQ/jBoTTufQek7Bhsf3KVWt5PQJ
	dloGMt/V6tX7ihLcQL6VRdPaXl2pdP9gO0OVFJgYdxMdwmOqqPt6YODrC8atLi0b
	OasmTnjzcNxshEDDcK5lA==
X-ME-Sender: <xms:UscbaJRY1wrzTx0Td2eYeksAWhRfUiXZw8gqMcrlU-gP11YUqqgz0vU>
    <xme:UscbaCzLq18PA88ZkmRBjHZ3CHZUoy0ZE8zYBfKjQkJjPPUS_wCuYJ5VPZ19eWw7q
    Zqj_oa519H2a7DSuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgie
    fgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrvhgr
    rhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgr
    rhgtnhgrrhgtseigihhplhhinhhkrdgtohhm
X-ME-Proxy: <xmx:UscbaO1hn4C349RCpOIR4sXs6NtbzIXCxznScmurC3jJYTLUjFnMCw>
    <xmx:UscbaBAMNwcbvnByOczhmf-kJs_RVmcXr1Sg8srsz5zaUyiksE3OEg>
    <xmx:UscbaChHSsLQAmg_kobMibPvsRo_-1I_e9NGmykx3HaAQy3hobrVfg>
    <xmx:UscbaFrYVD9UsrAai8IJ9We8DyyELxQgamqA-jpWOCdr9u-9YNeEPQ>
    <xmx:UscbaJ5_c1VHGs1eOErRX3a1GNp1hZNMHlhFDqWJDnZI_0LUbw3XNWUh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2C2AD780069; Wed,  7 May 2025 16:49:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2ded8740debeeda3
Date: Wed, 07 May 2025 22:49:01 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Marc Branchaud" <marcnarc@xiplink.com>, "Toon Claes" <toon@iotcl.com>,
 git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
 "Derrick Stolee" <stolee@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <9a0c98d1-4a77-4f2e-9aa9-bbab11b3e44d@app.fastmail.com>
In-Reply-To: <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025, at 22:23, Marc Branchaud wrote:
> On 2025-05-07 10:22, Toon Claes wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>> I feel the need to get some bike-shedding off my chest, though:
>>
>> Always welcome!
>>
>>> "blame-tree" would be a terrible name for this command.
>>
>> Do you feel this way because "blame" as a negative conotation?
>
> Good question, but no, not at all.
>
> My concern is about having two commands to do blaming (or "crediting" =
or
> whatever anyone wants to call it), instead of just one.
>
>>> I think that if Git ends up with two blame-like commands it will
>>> merely solidify Git's reputation for obscurity.
>>
>> I think "blaming" is a well-concept in Git, and many people (familiar
>> with Git) would understand in instant what `blame-tree` would do.
>
> I agree that blaming is a well-(known) concept.  I also agree that most
> users would understand what blame-tree would do, *once they find it*.
>
> But I think that's beside the point I'm trying to make.  Git is
> notorious for making users learn countless commands, and having two
> slightly-different commands for blaming is just going to make that wor=
se.

Use a Git user I don=E2=80=99t see the problem.  `git --list-cmds=3Dbuil=
tins`
lists 144 commands.  Six of them are `-tree` commands.

It=E2=80=99s not been my understanding that people stumble upon niche co=
mmands
that easily.  Most questions I=E2=80=99ve seen about git-commit-tree(1) =
(one of
the `-tree` commands that seems to come up from time to time) seem to
come from a point of idle curiosity.  That=E2=80=99s questions that brin=
g it up
(i.e. potential user confusion).

(The first impression I got of `-tree` commands was that they were less
user-friendly commands for hardcore users.)

That=E2=80=99s just my perspective.  Do you have a case in mind where su=
ch a new
command could lead to user confusion?
