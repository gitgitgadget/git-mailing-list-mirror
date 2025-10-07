Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E282DC76A
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843296; cv=none; b=OMMezxslLWLuozx5moz6yHMmb45opzWsINgaDK8SnwO+Ci2/96XPjl+hzuYW07C4qyzKf98FScLNfhw3/e57Zsa8kc7bAvLJe4kMSh985JwyL+ZyZXEZntPgVx/pIzR4qxyPWD9ddCyVrLxRZ0q9mWaRUAwgyd8mn2gzGYfKrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843296; c=relaxed/simple;
	bh=1J75ZTAfLqkqhFGOI4EYsb4JoEmCka7rXQPzIEk6N1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLp840jqgKmacZUpMDXk9hEw2z09R9TKmqTfNKOlWYLYbAKRFyU3R5zn3CEudcY9fk75lUAEDjHiPOXC1kQpvsMaWJ3teRCLEGfkBvDMOpnxHWCnzjYrso9r2daVPm8gVzvvX7dwwkQi5AJuZta9HEf/ti6ImUL43JyFTzzud8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B6IR7sox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJ9m1flZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B6IR7sox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJ9m1flZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF3271400291;
	Tue,  7 Oct 2025 09:21:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 09:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759843293;
	 x=1759929693; bh=C4tvBKGN5PrpIfXoUh0h3A0GeizmNSMXvJleQ8TKJBQ=; b=
	B6IR7soxaFb9G2Lptu+gzQ0uc5ElPoBzeepTOlayaezIF3Y7P3mk5w/co3GKxByA
	jyy7uzqVWXivjkkYZk5bUEOnUKCDctGwSOHgCIHG8b+q2fNcHxsOm1JTeCS1yMdH
	ulU+ePx1K93mJK7rXuyx5mrXR77UdDh8JaYCw3N632nCNDVYDoJf81DMZx3ah0jP
	Y+wtWhM8bZuH0lFLS+Poev6IvmFsQRT6qNRaYiHQ7MjKvkeQqwPgJBQVl2Ce3kyw
	SJwwppZu5rRyU9ycUTX7ucKZp+cYamjGEFDkJ/drIRVWLUsGWdITkzBSL4UH9OEx
	dxhgWDwMU6gMEaD68/QW8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759843293; x=
	1759929693; bh=C4tvBKGN5PrpIfXoUh0h3A0GeizmNSMXvJleQ8TKJBQ=; b=L
	J9m1flZEs4q6DNPmYhOlq7XkMkaxZdlsbLlPZEDxwS25gZRNJAabFVj+kUCzXw5W
	9VKiNODo97nb3Y1kGkAxEzNHHqu6tUApQPu3UIozL0iQMBnDESAEJcOueM+Eq62V
	fMKqNUAcA7P+y+kAEXBXX4fq2AiWAI0xsWhSHBA4699YL6R5SbXYTQFL/+azxGpv
	wOHvoytw0Fu9W34Ya5mm+PyjwUX2SUyZd3hGkpNDFYGIYtHdnQslEKLn/6wDoehA
	2lNvebj4AQTOCOChUQMlp0OxOlFQEkRALMewIrFlv+Q/5/3bhZx/vAJ4H3Ne0sSb
	1bQWdFBoMm1vSTiCIw+hQ==
X-ME-Sender: <xms:3RPlaAA0g8twiTCZlUesLeZCqBIlhriw239gYIMLDHLFEHitc9koLw>
    <xme:3RPlaJYKwpIi8liA71C1AKIoNgWO_9b-TJDSiZHFQVGhO73_hZxTJPYHT5KungFPA
    7_m68vDSmhO2ISX09f5euaF0xsW3f9sw_Cmd7iR40xpuK76vFda>
X-ME-Received: <xmr:3RPlaL7Ye0uHxWphwcfMB5WAwmjtbXJIZsm-Y5CiFa4HGDcfP6UTajvColFEtmVesLDCuNINjkzUMvv6pQ930pISC1K0KoGFb3lPgq-ZT0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrd
    hmihhlrghnvghsihhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvg
X-ME-Proxy: <xmx:3RPlaCYnP4Hao8zGJYlB-OA2Tlsy0gNBfCZujcU1PD2toNswfzF3zA>
    <xmx:3RPlaCiMLQUMKTf7v3BIB0wxtjwji0SETsyipONmTu8qW0WHbWwoLQ>
    <xmx:3RPlaL_2LAlUQMfWfOjdBMeA4xoRi6KQNc_kw0B22TXsklNzLbG4sQ>
    <xmx:3RPlaFrxIb74n6GyQw7Q6WFMwPm8TafdlZDV3de6yGyPVuVGLtbE4g>
    <xmx:3RPlaIapo0WXwqUQRWl6n6W7-EmMV22lSMB-ylkaT5EPnssxk73bXU5->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 09:21:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e83ed6e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 13:21:31 +0000 (UTC)
Date: Tue, 7 Oct 2025 15:21:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOUT2Phklc_ZDhy9@pks.im>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
 <aOTrC8CRZm5hERgr@pks.im>
 <aOTtPxsdzJLPCruk@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOTtPxsdzJLPCruk@kitsune.suse.cz>

On Tue, Oct 07, 2025 at 12:36:47PM +0200, Michal Suchánek wrote:
> On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
> > The question of course is how to get such roadmaps. The easiest way to
> > do it is probably to gather a list of known projects that would be
> > impacted and just shoot maintainers or representatives of those an
> > email? From the top of my head, that would include:
> > 
> >   - Implementations
> >       - libgit2
>           - pygit2
> >       - JGit
> >       - Gitoxide
> >       - go-git

pygit2 is merely a binding for libgit2, so I didn't include it in this
list. Same for other bindings like git2go or git2-rs.

> >   - Forges
> >       - GitHub
> >       - GitLab
> >       - Bitbucket
> >       - Forgejo
>         - Gitea
> >       - SourceHut

Yup, this one should be included here indeed.

Thanks!

Patrick
