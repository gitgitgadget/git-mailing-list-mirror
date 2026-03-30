Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26337AA77
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891299; cv=none; b=Xs2fyphvk85XvEW7S7k8NkkAyp8TFJ7DH2IhcClVa8BoAKNV7UFYVwQAch/OzD46UTchBBwDU/j9U2wofMwLUJHB8ERy1Qa/F9eg89fxNLG5m/TTqVCbMLPovk7PW1MucEF/1sCEsoo6sacMSzeqMLHdCoVEKsP8N2buoPdRmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891299; c=relaxed/simple;
	bh=G5PHvSBDmrRBAfL1Beeo9NKa1inZajrNJRi+AYsJh8g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f+VajbeVjqH3awmBIjZhPLiBgmyDpEloDMekHUsrCHYdbfvIRQEdaqCTpIpaLu6vLQHAO0Tulak0YC1ATYmNJgEmCQge/bK260wufwHvTTXmjOvbvydnSS9vd0dDAWhx1Mkt0OFPtUop46mPCSYheeEOGgCkJ5ret8lkPfNATz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WzNwE6Vh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6AXkbcLP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WzNwE6Vh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6AXkbcLP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F9A37A01A6;
	Mon, 30 Mar 2026 13:21:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 13:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774891295;
	 x=1774977695; bh=FUjUHoUPv/XWh2OLmlG22C6jHdbj1zv6TfQ5j1FkzSg=; b=
	WzNwE6VhxY3aajzzhWgvysMSLS/sDcVyn+AHdcYG6bkTmkfp3ATe5Zbnv0awsndh
	dlQFUYLr7p7Lx3QL6iCFjelRVL/mh4bzvz/knDhs0+w+83cFBIxFX6f2LjjXu5PW
	GYMYBUHAawBIcPB/hnobfiMMadSm4A8ook9ZDEdjmy+LAy6YLsstQeyhx4f/f7eV
	xSNYA3UaVitZ5iJSWooWsy4uy/CR721EF6Ydr4noG571VTodx0O0/Qcm0CXT1YL2
	RKsf9z3PbjaweV+86LJPpdmUZOPUo6Jzdm5MWRGoSyJ8A/e++2oE1HEvesFew4J0
	MHtEXFuLQu8lC/VDyOhe5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774891295; x=
	1774977695; bh=FUjUHoUPv/XWh2OLmlG22C6jHdbj1zv6TfQ5j1FkzSg=; b=6
	AXkbcLPZK3nM50AlIvticTGAYC9ACT1D0g2GtbqgCzV71iYuoL+qaXHxcwYS1CDt
	Sa4JSpyq/nkV2/BC183aT3q6bUevEkPglmusA6jHX+SDgiLfP3ietB7PIWKRO6ZF
	fKkKpq8IRHQopoIgtKM7zXbgpQ/82AU4v/DlefQ+yquUkIqn6GAjvxbp3oM4skhI
	NV1INs+7LKyPt7iiltH0D2M9tBNo4LlypnYEctRhYhGbq41qXVxPYtC4JE31Q1/j
	wFRlkVOn5W+PTBIFMlLKEJna5pzUFM/MC7UDJy/eFhlUwI8+9Idbz2qha4+HrnzM
	r6qmeKe3lZ0pJxEZk7yzg==
X-ME-Sender: <xms:HbHKaW6WOcWmzFd74jEVADtVqf5H95iRRbtFuI4sZ7YZ-Vofjk2Q9aA>
    <xme:HbHKaau0oqNHrUib1LwsgWMwefU3XZXgvCbbRTPra0qi_Mexl-kEd6nogQDri1HYu
    wIawDQMNC9GbEAlvVb21YuwJEVQpQV1TXcimJocZiKpkaQlhbYP1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedukedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhi
    rghsrdguvgdprhgtphhtthhopegsvghlkhhiugelkeesghhmrghilhdrtghomhdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    grrhgvsgesghhmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghr
    rggrmhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghpnhgvmhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:HbHKaTFYHCiWhcjickeNV6ooKsfSszniCUi2U6ZReX46ezUAZCuBAg>
    <xmx:HbHKacRRvp_UcA7u6IGp6kSvUwSxEVkhE7v34Z5HrE-0hPyPn7gqLA>
    <xmx:HbHKabSEEB25oR9rrXkbQM3R15XiO22abrBk55Ht93Oz2qB0TSMWvA>
    <xmx:HbHKaXcR2MdCW2E8FUexC4Viu-7qmoZtaezXlNEMN5AQBQiMXqVHfQ>
    <xmx:H7HKadsa-6A9Ek1n5eWplIXgo7VjZ-r9oUxYi81IutKCvIbxRi9yVO6S>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8D6F1EA006B; Mon, 30 Mar 2026 13:21:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIF3iC1xX5tJ
Date: Mon, 30 Mar 2026 19:20:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christian Couder" <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jakub Narebski" <jnareb@gmail.com>,
 "Markus Jansen" <mja@jansen-preisler.de>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
 =?UTF-8?Q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Jeff King" <peff@peff.net>, "Olamide Caleb Bello" <belkid98@gmail.com>,
 "Matthias Beyer" <mail@beyermatthias.de>,
 "Jacob Keller" <jacob.keller@gmail.com>,
 "Florian Weimer" <fweimer@redhat.com>, "Jakob Haufe" <sur5r@sur5r.net>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <b5c66f24-7bfd-464c-afb3-745bf3f49381@app.fastmail.com>
In-Reply-To: 
 <CAP8UFD2HhBq3MPD30jb0XJw0hciTyB=BNjcH9s9hjBoocFqQjg@mail.gmail.com>
References: 
 <CAP8UFD2HhBq3MPD30jb0XJw0hciTyB=BNjcH9s9hjBoocFqQjg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 133
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Git Rev News Draft wrote:

> On February 6, 2026, Matthias Beyer forwarded to the Git mailing list a
> surprising warning that had just circulated on Mastodon:
>
> [...]
>
> The thread also served as a useful reminder that this problem is not
> limited to email workflows: any project that generates patches from
> Git commits using `git-format-patch` and applies them with `patch(1)`
> or `git-am` is exposed to it. The practical advice for authors is
> simple: if you include diffs in commit messages for illustrative
> purposes, make sure to indent them consistently, and be aware that
> even that does not protect you from `patch(1)`.

Very nice treatment of this topic.

This is useful since there were so many subthreads.

-- 
Kristoffer Haugsbakk
