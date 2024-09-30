Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD374185B74
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734992; cv=none; b=uAPyaFq2TxO8l2zRR1v8aU6tPygIARzn2vTeHc5thGqOhIszdyOM+FA1Hb9JhcxAPJTW4IyMPIp2pdPEvHh0mhN1ZXTwCDZcFqPbPmADqwSANYgLnPa7eCORGDJW37Vcr4f+awWkrJmJxH/QwfFRyoMUhZ+ewHgtpg/ydkmJ4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734992; c=relaxed/simple;
	bh=AyYtkn5kziBopm23xH1ih6GdB47ntvH/pARkJU12LP0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rk5G3LiVQWD7uxrHl0yAYsiI0DTm+8smQpnqkJh2NEb9dMzbdayFDQH4n2UnW5GTsJ92IEthBBWzGsx9sabzQyvHd4dxKXYN1IWzaqK7IMFfkdj4jiseBtUhYH0bI1oZ4ucliL/nhb8ZR74+vLkpomq8MmblVX5Co+ncxRCZx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c1phPZst; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NqZL9zVC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c1phPZst";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqZL9zVC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D7FE513809A8;
	Mon, 30 Sep 2024 18:23:08 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 18:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727734988;
	 x=1727821388; bh=3qyCvzHJCV1C57FiYYnp13ADv7KDO5w2SG81MPZAy2I=; b=
	c1phPZstikvecJWINEGFiPKiHjxt+N4lMmZdKrk/6KCYQ0dFyjPItNmbO3jNihme
	4Dnv6MYdHMKN1OBkaTxNcpMlMJ7vkBmbQf1dRe+QuhS0erRbXK/az4xorWWfTwve
	qR1DLaHUvFn7jonQGD8fJpZ3v3Klg3uVuOhu/53dejpIIIzeQyOAAR9AylT0aGV7
	ru7qZdvafueVjvdQXWHMRTmtNW/pn6YzE4bxb4YRua2xHEtAcD6lYqilJTGC8N45
	LC6FC0Nc0Yl0PcNPA1A6RD75kvPA8hin11G42Syr+0OWExYQGRj5sMTb14+7CpW1
	b0caLyfiCxMueu64rsbteA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727734988; x=
	1727821388; bh=3qyCvzHJCV1C57FiYYnp13ADv7KDO5w2SG81MPZAy2I=; b=N
	qZL9zVCNHRpHVAYH8v4FdLjmCBZLVcTKX0BhLP5B11iDqub9IscCCc+cEgO+YGY5
	mGA+SvH2L4wgd7NFxLirZqvrnKrgQoi8DMckZlQ8d/SXbAS3lfhCpLbUu1heJBIx
	dXK6NKGyzwBPyu6mfcbfreYrsKTEnOe57XkZoDe2lvyncQphk/gjCu5TFmMUzn+9
	Rc4MQSc2l6tMAvh1sB04DyY1gxkLEEN3CAzGSoiFCI4q/yLHfUKk042bkA7jdrdK
	KbesBCK2i8tLbFUJZxF4fxLrF1bAcbrT+dMU1ONg0bifSSC1lIvSu+OANQb5he0x
	DuV/igT6exmuGzrSMghww==
X-ME-Sender: <xms:zCT7ZqVF1G5ZaXsFmh4zIABAJR3murHNjaEPBb-_t96pFlvfyKWUCR8>
    <xme:zCT7ZmkBBnk9rZpaR6AcVSgd-IZqfkvteKfbbhpJlAjVt5tTHZlSaEO4hd1IYpJwv
    fLIOTAOjMAO1A9w9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfduhfejie
    fggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehshhihmhgvghgrsehshhihmhgvghgrrdhorhhgrdhukh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zCT7ZuZH_z723vidKjYo-hqjyKpk5JYyTtxJlmhYwqEbxAN1158V-Q>
    <xmx:zCT7ZhWtNS7RSUbVrcSZ5H0LH21wmiW2TRXuW9syyNg7uOewxNMwcw>
    <xmx:zCT7ZklU--ehmJv6QNqmIUOHEDZtmYHg16l3un2UzFoo2R_fkVMS-g>
    <xmx:zCT7ZmcV7xXsN1dSj38qk9YSmu3ORN8tz2XdK0f3RqtrJDcABDf1Xw>
    <xmx:zCT7Zgtmy3XmS0i8A3_gfoeRxa2WVDN0BqoNsraekU57BHk3Q2tRquBC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94604780068; Mon, 30 Sep 2024 18:23:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Oct 2024 00:22:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Dom (shymega) Rodriguez" <shymega@shymega.org.uk>,
 "git MAILING LIST" <git@vger.kernel.org>
Message-Id: <c1cba0df-a8a9-4f33-954e-765a5b2cea8c@app.fastmail.com>
In-Reply-To: 
 <biapebw5nsonirhirnunsgu4wnbynt4zdn4rud5kdvwljnpz63@3hc3ujx2gosw>
References: <biapebw5nsonirhirnunsgu4wnbynt4zdn4rud5kdvwljnpz63@3hc3ujx2gosw>
Subject: Re: Rewriting history - email/author change on match?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024, at 00:04, Dom (shymega) Rodriguez wrote:
> Hello,
>
> I've got a few private repos that I am the sole contributor to, but so=
me
> commits are under my usual Git author+email. These commits are
> automated, and I'd like to rewrite commits that match the commit messa=
ge
> (the message is consistent) and the 'old' author+email to a new
> author+email, but retain the commit message.
>
> The tool that springs to mind is `git-filter-branch`. However, I've al=
so
> come across `git-filter-repo` on GitHub.
>
> I'm a little confused, and I wanted to ask for advice on the list. I d=
id
> try using `git-filter-branch`, but got lost quickly with
> `--commit-filter/`--msg-filter`.

git-filter-repo(1) is better=E2=80=94even `man git-filter-branch` recomm=
ends it.

> I also found a 'users' Git mailing list on Google Groups, but by the
> warning I got from Google, it has a spam issue. If this is the wrong
> place to ask for help, please do let me know.

Yes.  That place is dead.  Avoid it.

Or it was when I looked at it back in February.

https://lore.kernel.org/git/339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fas=
tmail.com/

--=20
Kristoffer Haugsbakk
