Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A67146A66
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842636; cv=none; b=VC7kXGPuLPHM2NB449xqfcWKzO4D0n5bivfZVGpfE3oIDWYAz6lCYKB2vlf+VKceRpEMmheWqbsHI8npmNxYG/Ch8YoKgDM1PKbwp1sG+6CriQHt+JgekpkvqZGpxEPyZJwc0k4l3QVAy5LfxRyv/yJ20D0BNyewC7R9odMPpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842636; c=relaxed/simple;
	bh=rwPint/2Ap/AnA3xqvVqYEZhErtvvmAdyUHKUBU+ITc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z3rvQCPn/D2B1/AU4fDowQ7YSIKObS1H1KyTmTcok1Ag5je2i3m2HYC5z7JA/r4KpqdbD6Bz9b05FG09GnO89vnLQQACPG7c9fYXfKtJf/4ThSczuM9yq/YHhQ9ScqpKxARMKZ/+BjMnY4ytMUbY3M0J0kV6qMc5H282C6a3Os0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Vrj/KeLh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtrtmIS7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Vrj/KeLh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtrtmIS7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B61C7A024E;
	Mon, 15 Dec 2025 18:50:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 18:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765842633;
	 x=1765929033; bh=a2ywqidEkJD+S7q2BCH+0bhHwH9g7+qQ+CYbupLBz90=; b=
	Vrj/KeLhUrA7zEnEgGRqK94DasP3QeMAWQ85FnV5XBuPcnQMe70tzm+binurB7bx
	ZIWziEU0j3U36u6TuQ415iNYQEcqDhnMKZ4RUwH4PAzgmDTvHl4QDwq/POB1k7Ex
	ZGAZkST5eQcSUx3zxTJTFe1oc+XqZpCbGPvN4A4fO+j0oh9VKnLGZXII+kZEeZtK
	K80cDraGyqosbQcGIfWklgQJ/xs9AZTDXVqaNZ0oCdhI0qm7nqfHS8conExJXSUL
	S8ilOoxS33ytBoLjWAtWKvIa3CLcqRcqcxLh73QMH4p7lb3LHiXkcAk74Dm6nQiH
	3Ni1Tr3JUo3Gl++YXPgftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765842633; x=
	1765929033; bh=a2ywqidEkJD+S7q2BCH+0bhHwH9g7+qQ+CYbupLBz90=; b=K
	trtmIS7fno2k6XEVMPkxluXi5Kz7sZcLUqx5Gzv2toL/MQC+Aqmt+ZYcZpS8+/iJ
	GQT932Xy/uvtKlfWZWNsk1VI+Vh39t+DlgnJ5Hyv5aalVKE9CdU3/wSwVeXV5sBa
	c1jYA3jIdDrVOlzO11OJYhRYOanPNayqOHPepFlosjZRxZmgHklByDqw6F5hHWkI
	wktCAnzknC56yGmnuBe6QiS04opoNS6ckxOwIFg27nY7wDJ8CueIJguSEps7xtgl
	s8cmYZlfVPlKKf0jJpkalCA1MgupcnqYUj1Cm4Q6ySO73yoewIFbWxCXPYU4dtd7
	Z7/+opS9QZYr2hmiEXjiQ==
X-ME-Sender: <xms:yZ5AaRTOi3xEaZ-1is4OmN_5bIR7aL1lZNEXZhxRiAj5nA4tF_F_E18>
    <xme:yZ5AaVmKq9DUvm3alHiTks2x92ShmW7mrATPL5U9G50eHNNBiYN9-6yyUalfBzcXO
    ULafCQpXXp9dYmsysQW7A9g2MJMydk6ohNNCgXyQwfpeh_P-58I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghs
    rdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yZ5AaRTa-gxyyR_Ei56lOHBlzsVAb8yTcwlL3yfCnohwMcKdW5c37w>
    <xmx:yZ5AaVvxXNgdGdgJxYS-IE1fM7t8l2cjqxW-6SAAgcW3k7dREDwCvQ>
    <xmx:yZ5AaV38Vhj72AvCVugDDJ4AaoT6cEsoZSrUm45S0qP1oj7yS9PUTQ>
    <xmx:yZ5AaeUFT85c3FkQUTfzWzy1h9qHE235qd0cHDeBFDFr6gFyYAnmdQ>
    <xmx:yZ5AaZp743mhkj2Ojenc3__U7J-eo6tmpawaDOnQw8h-YaC6U3yJ1LNt>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A3771EA0066; Mon, 15 Dec 2025 18:50:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ate3QFRcz-LV
Date: Tue, 16 Dec 2025 00:50:12 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthias Beyer" <mail@beyermatthias.de>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>, git@vger.kernel.org
Message-Id: <efe4cbc5-bad5-4ded-9f65-1326cc102543@app.fastmail.com>
In-Reply-To: 
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy history
 editing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 10, 2025, at 11:37, Matthias Beyer wrote:
>>[snip]
>>
>> Is that because you have branches that you don't want to rewrite because
>> they've been merged upstream or is there another reason? If we start
>> rewriting multiple branches we should probably check that we're not
>> rewriting something that has been merged upstream but if I rewrite a commits
>> that's an ancestor of several branches it would be very helpful to rewrite
>> them all at the same time to keep them in sync.
>
> Its mostly because I don't like too much magic and because I think being
> explicit is always better than not.

That the first thing here is not magic but the other thing is seems
arbitrary:

1. Change these commits, i.e. make new commits and all their descendants
2. Update all branches that point at the commits that have now been
   replaced

These two feel conceptually similar to me in terms of complexity, and
neither of them are magical.

>
> So from my POV, I would expect "the simple case" to be "the simple CLI
> call" and if I want the tool to do magic and "rewrite all the
> things"^tm, that I would need to specify a flag for that.
