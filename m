Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5636921B
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598380; cv=none; b=d7ayG9zkg3bd8iAsqzCFfgZiGVVV7HXcmuZ4Oy4JtyoSPAXNgxyvXSch9r3j4FABXVQwIE0QiLCRazbakjDHKAg4qDEsTQaJziSfZQhlY7Co6Dt+jsBvUh8BBHruebxxkRHEZYdmR528yXfplGUk0os5z6FIUZYsoWOYHmGV9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598380; c=relaxed/simple;
	bh=p0ZrU6m+7mco1xK6JHEqctSaiqZ+8gGMt6hFE7ITBuQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uCSMZ+jionuJzWiTBiWgZ4XspuqNJYbHbP6cATLiJHAY0Du7Ww53Ma0ohadgX3NcuqYiacG3i0u4VKlFrmczZnYhCbIKzF/tfn+6l1kr7RdlX+7+YieadoZOOezPsNyVBuiinIco1AVZMsR4w+ZnLrHwprkbXQLnc02kJmQewRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=o5QXEFWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mg1IVedI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="o5QXEFWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mg1IVedI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EA8271D00056;
	Tue, 12 May 2026 11:06:17 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 11:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778598377;
	 x=1778684777; bh=A0O+U8L1SA1wBnoUm564L+GQAbW9ZaRkn+rmUum+qkA=; b=
	o5QXEFWOAT/EYDq24K/tn1yWi8i1QdB2Ra05/0DYmaKjV9vFoqrEGIRyu8AFwomV
	+yi9l6W3W+urlhUFoaGBweP44EQB0lkP/uTqNsths3kED4Nx63+x+CIJq4PVtFdG
	U1AoJLjcvrjUZKDU7QixCmiFxVt4hVhFR0/nHKNzSSyJuTcvRE9rRiOk6XQryJM8
	MwILVcth9PCtzcbZbfP8Jemu0yPp8SxpAaXe38aoQ58x7WCddwryLk1OlkkzA8j5
	LgjsW7hXj/LM08YhIHXE/50Xi3BC5aeE8ngZdak9Fj+QwULxfOE8ScEbwOAtKI8u
	j6/8qN2aoSl1tgGOqJU4nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778598377; x=
	1778684777; bh=A0O+U8L1SA1wBnoUm564L+GQAbW9ZaRkn+rmUum+qkA=; b=m
	g1IVedId6A7QUi3hN2j9dMq+MLKRtpfmVMAOyXg2UbLHC7qLAiwokhu+2UctqEX7
	oIPBg+diDkQzhiAL9emZSaXrWLn/kbyltoQZ/eD9yp3fasvLb2mMYE8n+3gNwWyY
	LXQraTIFzrJud/cAq19ZMIhVfGKtLM7/CSDNo6IjVNdUp/jOxpjvp/D5lM4rlvJC
	3Bri+vJJQaUsfGkWlTrx0AC8GKznX2+bN+GgJRTEeu2VyTItDmrLZK3RbAIXTUb+
	3/adHkgKIbmMzDJ6J9O5j/pWWjqLo8Z5nPcCnkQttSZ0cN1mOntr9iolw6wgUk+b
	uLmDJiPXLVMQoji5Z9Kjg==
X-ME-Sender: <xms:6UEDaviF8CnNa0cIp-LaBdRFnkuQgJjG2PK5uVjB2DAv-mkZlLdwu28>
    <xme:6UEDam2u9F-ruEGcsGw2ZDeF-7qaFsFwRlTAE-UCRq2ZkpZBFFpyBek_ohHTRnUOn
    jC5gb-5xe5On8crQ0qhZF3JaiSKE4FvZ-B-3RoqKqay5GFQhfPbzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6UEDasZ7vhSuIYNAh1hkmjRewjuW0rHAaUocXXB0oyXdybLHeOLw7Q>
    <xmx:6UEDaoEFhlU0fPwnFal7YvwtoJxJFq7Z9v0bLileVAr_YD2t4Qp7xA>
    <xmx:6UEDalISowvj2nVtuYtIpaVTLdUA4eWg5EIjwqN2NtprXxlnSyqdIQ>
    <xmx:6UEDarPYychTwIDYq31C2Ksww1MJR5xJ-exwTMOX67F6sLTyiN-frw>
    <xmx:6UEDaiTl_FjHBX_zwEUlPMB_kO22t5tEC4WHG6ndcufmj9aR4g5VpwkA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47AF8C4006F; Tue, 12 May 2026 11:06:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 May 2026 17:05:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Usman Akinyemi" <usmanakinyemi202@gmail.com>
Cc: "Christian Couder" <christian.couder@gmail.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <d6566004-f803-4824-b050-f086b6d6d76c@app.fastmail.com>
In-Reply-To: <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
References: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
 <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
 <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
Subject: Re: [RFC PATCH v5 3/3] push: support pushing to a remote group
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026, at 17:34, Usman Akinyemi wrote:
> `git fetch` accepts a remote group name (configured via `remotes.<name=
>`
> in config) and fetches from each member remote. `git push` has no
> equivalent =E2=80=94 it only accepts a single remote name.
>
>[snip]
>
> +This means the user is responsible for ensuring that the sequence of
> +individual pushes makes sense. If `git push r1`` would fail for a giv=
en

Double backticks (s/`git push r1``/`git push r1`/).

> +set of options and arguments, then `git push all-remotes` will fail in
> +the same way when it reaches r1. The group push does not do anything

s/r1/`r1`/ ? Goes for the others here as well

> +special to make a failing individual push succeed.
> +
>  OUTPUT
>  ------
>[snip]
