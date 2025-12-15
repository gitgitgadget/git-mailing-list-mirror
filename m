Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C582D9EEF
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811660; cv=none; b=Kg5Nc/KlInwSwngauCr8YrNq9UWBzFVaJhHTB0oWb/A/ZXgCbnF+ErFqkz1IyaIugTnl9Mi+5zjLnd1k0OCPhHwmhtNEKuGG762QfCDlI+m7Gm3nZIplm3WW55ZgcpNFASi1tz1LFzo3MrCTAGLeBjYCkNhkLtnyCFOJ6cbgGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811660; c=relaxed/simple;
	bh=RmeNFOuHyYOUTu8I29rRuxQN3Xco9xFXJpsSOrhx4QQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WDb8uYYlmvugrq4w7F266twD17tq9zvouVuBJCsQ1/fZS6mWOamIYiOrUaoCnGzxGHWwaYV9RwAw2ccpMwU6FECrAU4MYvDvKDbuzYaUotVeg2Dx+he6CAYcZ7TLQUPpJEiUuxfbCFx3v1DQV82J4jMwJPerB2sC7M0aecmyWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=d59q5oQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NV6hZjIb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="d59q5oQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NV6hZjIb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E4CAD1D000AA;
	Mon, 15 Dec 2025 10:14:17 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 10:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765811657;
	 x=1765898057; bh=SWxgfwUf2DortezZhY/XbfBsxsfXQVL98u96Yhsh4d4=; b=
	d59q5oQIHjryEDG0K9/l7YV45Eo8UsIdF3wBUMYbsq6SQYUvHccUS3Dr61l8OE77
	UvQInQ34T3Nz+VepUSBvpU1LXVGAIM1f8pK+Al++W9fzsiMVXrq9ySlaY0z+g4cF
	sNK1tzwzieoQQqj0+ON6yNWWrE0aFbGqef8ZzlnV3yeLgyQpqi0l3IXli7PQ4Y33
	3JhmDLvDKBtfQp1JexY7BuGsV7PeFB3GCW4RhYwX2uoelXi0TYTRpv/+T93fsyjC
	4OfrEc6fV0jv/TIV5xYsbmnm1zuDBcaX1TxR2WTyojwQRfXETL9fUIzazF/R2rB1
	1M5VaiW7XPa9VfY5ZWn+mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765811657; x=1765898057; bh=S
	WxgfwUf2DortezZhY/XbfBsxsfXQVL98u96Yhsh4d4=; b=NV6hZjIbWtm92vu83
	f1YKMFzaWbnbprSIgqw2aEoAirmVEGdjo7/mqrWThQc+HCbTyzjJ2PF+0UzNvqo3
	iSu4ynixRL/wcwvsQvk9wgezaF5FrwTmwMW+EPj3eCsauF76MRlighE6GcA1howF
	Ht3im5AJM/5PljoNZoKJ+ZdfUy9jBRv68cWdULe8ecojs34VlaRFosLHEgfc/AZk
	zctx8a+2pDzkXJsdTAYk16TXmFNFMMG0CvcLbEczGPh3orT45eyCMCb5HBBqwhKr
	YME3Gj+Jj8R/h9v6Gli8c1QekFdcdk8nc6LyhdfFAY7V5l3byRbJ+BTI03oqU9DM
	BCwQw==
X-ME-Sender: <xms:ySVAaWHej3uzSsoJyMLStdeWw6Y0kco5_TnCGMwGeb3EWKb4OmIKnPg>
    <xme:ySVAaSKpB9kesCXmRb8vje7U4okrjVafdZKcaHCcUOByrRCWkRZN0QiR1gxdVDNiP
    7xselLJp5xcrcn53JPFsQHMgUBQ5T3DvPgHzEp068vKjtJasJOEUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefjedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeiffehgeetieffgeevveefjeehtdegudegteffjedvtedufffhteei
    ueffhffhgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehkgehhvhguudesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ySVAacyfgp45bPmVYaTNYvYJOtvtpYdbblV91f-Iiyv37bjC2QiLrQ>
    <xmx:ySVAaeOaGTlK6kRe5C2qi59xRrNdJiN_OHT8owll_inFA7sX52LvAQ>
    <xmx:ySVAaV5iGd71aEUHVC-FdMOJrTdy5CIDmgJa-Ae3xtrin2bcx_w0XA>
    <xmx:ySVAaXNBby8WjwKIRbH7rJbbV5L95-4LZdlAZ_GomqufU6X26ufnkA>
    <xmx:ySVAae5nPTy_v8aMjxplIJWfMKt_dMtRwrUHr0mJtvVALO40S93HLP6x>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A33551EA0066; Mon, 15 Dec 2025 10:14:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEXwK9LrGp-F
Date: Mon, 15 Dec 2025 16:13:56 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Milos Markovic" <k4hvd1@gmail.com>, git@vger.kernel.org
Message-Id: <8bcfe2fe-3522-413f-b4d1-13e048028296@app.fastmail.com>
In-Reply-To: 
 <CAKRouPtDrCgUk1bQeF+ao04rtK_jg8KxD6Oju8vw8H-ZYt-7Ow@mail.gmail.com>
References: 
 <CAKRouPtDrCgUk1bQeF+ao04rtK_jg8KxD6Oju8vw8H-ZYt-7Ow@mail.gmail.com>
Subject: Re: git new features: following and priority branches with new git flow
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 15, 2025, at 11:15, Milos Markovic wrote:
> Dear all,
>
> After decades of using git (as dev, as manager and as a cto), and
> considering different git flows I noticed some gaps.
>
> Briefly, different git flows perceive branches equally and shape
> history from developers perspective. I realized that if the
> perspective is written from a devops perspective ( focusing on higher
> priority branches, like prod first , than qa, and with least focus on
> dev) the source history could be organized differently ( from my
> perspective a bit better). We used the following approach for a couple
> of years.
>
> Therefore I invite you to check the following workflow here
> https://github.com/k4hvd1/rebaser-flow .
>
> It would be my pleasure to discuss new features in git and how this
> approach could be used. Finally if it makes sense for you I will show
> you other materials and we could think about implementing it in git .
>
> Regards
> Milos

Those `gitscript.sh` should be shell functions. They will not work
unless your default shell is Bash.

E.g.

    git config --global alias.pld  '![[ $(git rev-parse --abbrev-ref HEAD) == "dev" ]] && git fetch --all &&  git rebase origin/dev && git rebase origin/qa && git rebase origin/production'
