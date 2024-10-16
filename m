Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4A18C02F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112138; cv=none; b=j42hpw0dLQsdo8972w/sdJLusRBnz0kTUs/yKk9sMffKHIKkCGhrYmJWA1+HqZn/gNEToS3JPKu6essS/N+Ls3m6x5UM4GuHzsOkZdNq9GUHbyPmVYF1flw8Njhtsn0gT20Zll4Gv2DXgEQ/pxSTXBDrYLiXEU/ylEWfeIU3t4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112138; c=relaxed/simple;
	bh=2+qXMLZcwj3Jmmh3AFgS/0ZMrpsLz7uytEo7XLBokjk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L5pdnwQ5hdYVC2jwmPDP10yyWCJBbiNzH6op0Q6b7UXS1lAHCCEPUYLNDVY+Xl3dUzKQtkYPHmQWdJs3FDxrXyN10A+rIHifoO2jDgncH1NMyEmkFqAr70mzNObnxHeggg5ECSqSqYyOaXpxc6CSMp6qkJq+t4SwViLknSS3oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bii++spe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGl5Z5ly; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bii++spe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGl5Z5ly"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 558661380244;
	Wed, 16 Oct 2024 16:55:35 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 16 Oct 2024 16:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729112135;
	 x=1729198535; bh=6puO5q+mB6P/4VdOVLHGb3eURnq5l/Bk/eQ74Ef8RDU=; b=
	bii++speNKnZq1YbjFQjtujqR+RqXB6uhCFgWC+pwZ88QFHchTPo3qdH1Qk8QsKs
	lEqJu0t7mPO3GKp6x5lCFFWdq6ZwH0O/jOuCfKtTNedoFLs7xWYhR+bzT78nePkg
	cqftsDg8fYCaKiLppPiTwZb3dlrSwb4KRcGCeog7GRuKMSEmaMGNmOB9nlNrYkY2
	7oTptNsCKXfeUUKWF8PFCTtnbNUVQ/ONu+NdnFAxhxRxIwkG1l9jVCF3V1wEq2DU
	Bj3yohKLhf9sIry80kF9xgSHCmnCFVIN/AZ2wxZst7U9xl6n+Lok6R//XT3KwMDx
	j/BqhpwxQna5jz4B1o2/og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729112135; x=
	1729198535; bh=6puO5q+mB6P/4VdOVLHGb3eURnq5l/Bk/eQ74Ef8RDU=; b=g
	Gl5Z5lyEfjkrTRnOrZv9OywcerzBDL7acuqY/Ulh0QjvYN3NdzkVhFnkOSeHa0Ow
	AxVtVmdRBYnI1KS4pSQq58TbhQnsep3oY4A5oqPZ+elALl+aZpSRqglrGfO8lJHv
	KliGdOqOBh+ia1GVqVOONVt+ooE1uOgRdM7etpUbdo6gZZlYyrhdRFFFrDQMVffQ
	NgVHmDHXGotTsC0063RyE4H5pyVYFOCGKc7bGEIiTHDKn6lyvQdwADPTg1hJvb5l
	OkqGn6GGOICYky/zJBjzh6k/SBtwLiWeP27bhN/ZcW7p5kZa2bZQ57EKD/pBd/M/
	EKEa3zh/on8jGt0F/U+Kg==
X-ME-Sender: <xms:RigQZ31AWI676kUlHnPc9GWEV8eYKNfQcUMyrvfASp064FUTzgvInME>
    <xme:RigQZ2HftQbmouQXF7CwYWpTjM1Ask_H_BSPiwITGCzyDVyR2EZn9UrOPA9SCbCno
    -eZrlxH4-ZcbmOUvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RigQZ36a7URX7bd9GZhWhAhVaSKOQ9tddfoxDNOWrFaiDTnEsLCzVw>
    <xmx:RigQZ81nA8cRGvSyyo_3UlBQMSoaRXmMBYCwlQipflgAKTRvF6ni-g>
    <xmx:RigQZ6Ek9X4dzlyzTP16laH2xkHonkhLfqGNtrW5zjvNcrYQzLYC9Q>
    <xmx:RigQZ9_amzBF4ZCmV6In2dC2z579oIItGX0a-JI0ByiKUbmZ72pqAg>
    <xmx:RygQZ_6--pghvbKpm4yWM-qQ95U274PysR3jx9GDFdpawksxHaoicjkg>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8786D780068; Wed, 16 Oct 2024 16:55:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 22:55:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <3af2273a-891d-4179-96c3-865b0e64bf08@app.fastmail.com>
In-Reply-To: <ZxAnO5zH1vtgRvLk@nand.local>
References: 
 <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name>
 <dec48e2d37cc4edafb51476284ce3fece4718ce7.1729017728.git.code@khaugsbakk.name>
 <ZxAnO5zH1vtgRvLk@nand.local>
Subject: Re: [PATCH 4/6] doc: update-ref: remove confusing paragraph
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024, at 22:51, Taylor Blau wrote:
> [=E2=80=A6]
>
> I think that it is worth saying that this concept is explained well
> throughout other parts of the documentation, including other parts of
> 'git-update-ref(1)', as well as the glossary content.
>
> I don't think that you necessarily need to mention that here. But at
> least I was initially confused thinking that this patch proposed
> removing the only mention of the special "ref:" syntax for symbolic
> references.
>
> But it does not, so I think that this patch as you wrote it is good.
> Let's keep reading...

You/a reader in general being in doubt is enough reason to mention some
other documentation source.  I=E2=80=99ll fix in the next version.

And thanks for reading!
