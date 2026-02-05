Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F202DAFA5
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312039; cv=none; b=AqE/vZ0ebXhPco6HEAH9VSkrNbFOaR2xgF9fXwrFoc8DqQvP+hAdieN1b2+QVqfyLscFsxn6e3dKbKupwO+zTsZ/Vajngm8DJ0Jqcu6OThO5IFSF71RM4BONZkKB5QXpbzzj/7nWcUzbwexf22zsV5WHmRPPaFBJrjylWh9U4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312039; c=relaxed/simple;
	bh=aafN6PSfGiT/pRy+IR9VsK2R7fAx2mBS5912w2a3PSg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sRXtq+MMSn8nQXMkHOT19cEg/17MRorAf83teLD0fj+6b394MOF4xImI+Y4YNIjmnz24LnlMFupJMoBejr+zcIOKSkvP0/ZyScyxzfoEU6kP6OrfKMNKsN8CIwsWZIubly6Gv44XK4gxK3PeiWoqQGTUvkLIcoSsrfmLfSrmpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MZ8LcBKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wo7m7neS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MZ8LcBKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wo7m7neS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 02104EC0564;
	Thu,  5 Feb 2026 12:20:38 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770312037;
	 x=1770398437; bh=aafN6PSfGiT/pRy+IR9VsK2R7fAx2mBS5912w2a3PSg=; b=
	MZ8LcBKFxDaZKy8ymAUZcUJWlecXx1lALW2vP61pAD/mkyhJelzi8rHWmbU4wweZ
	T+On9OIktBKNTiHyaJbqhThVllSy0L99G6N/UIpJ7e2aPNYSmN1GoARGoO2Mu9tC
	GyhX2iBG+4Y2rdFGTylSdsWkTJ04X905CWIVxzlEDf7epcFXkune1zqEQYWsf73t
	I7x2iImq0OocjRK6wv+043PvIHhh16tII+mNk1cIRkGQCxUPJOXY040Lj7gMmM20
	Blb5hReLlKpVKbjCjso/cMmUGVpTXuAjf/4skI4f3I8ehZIMYgYB1/MbP+i8gw7h
	uIIROqOBIYVAL5cOVwMIkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770312037; x=
	1770398437; bh=aafN6PSfGiT/pRy+IR9VsK2R7fAx2mBS5912w2a3PSg=; b=w
	o7m7neSfjMN4YHAkLZOfUA+YWXIzsBHHOvRfxnwmKLziZfmwVwWIK5MVETw7sh/3
	2n5BQqylnMoQ6h2zMfJiK3f3OmYjxBU8gaa0MIDY0MlkfVyRdf9I3xgik69mTsl5
	Vt6EIhzNcdFg4FU2JV4516RCcEzAzdMXXijkOcROqvBP1sHWN4GdN176j0xCeKO9
	WIv2e1/QGEp7ZByBLiYbc7M4jlcvJVJ++fVguBK1gUsr2Jclkso9scQujGKQJ7nu
	B4pW0Z5Alm0zgXZ5QHPrZyJxkR5eCUmmH9bhxPXBlN1DsA+9NoBIoJW4MnwlXyRO
	/Rh1w9/14W0w9cZEwf4Yw==
X-ME-Sender: <xms:ZdGEaeOo0UxciWL5wN4aDpwIaGMua4ybwKCGDZB_03G_wqlrbG6GQ38>
    <xme:ZdGEaXyu03l4ZCqlODhTlChvsUOPgC9C29Q-jZIoXuXFFeosvVyJMUAfB9yZkVitj
    oe3uzlMnGM8kAe9UWqJa3VbpInAaqzu-zsvaWD4fTwtq-Dy_Kb26A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZdGEad1bGRCXRQHiTaYGkQlYmQqkmskaxNK9qZ_DlUIjCvHvDfJN3Q>
    <xmx:ZdGEaR65MNKE_KnMvNlfnoln3e7KImA3k1IUQqjEVd3c04UCHd8Kbw>
    <xmx:ZdGEaYX7-J1KlJDbx7sJrtHY-4tSck9NkXN2oiMuE7nUc00diyd3FQ>
    <xmx:ZdGEaYDjLnjwyd5e8B2FiDDd-uMllDPs313Md0E8PYEQyY3lW7zlmg>
    <xmx:ZdGEaSJAeRPAjr6gWhagt7y2BDxXdezRRcSPVxjMKntvXJb0Vu5wy0zO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6F9B1EA006B; Thu,  5 Feb 2026 12:20:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah_pycf7BWl-
Date: Thu, 05 Feb 2026 18:20:17 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <f4bc400d-183c-406f-9f8c-bfed973c2eb1@app.fastmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools querying config
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:
> This RFC explores a new git config-batch builtin that allows tools to
> interact with Git's config data with multiple queries using a single
> process. This is an orthogonal alternative to the effort to create a stable,
> linkable config API. Both approaches have different strengths.
>[snip]

This sounds incredibly useful. Thanks!
