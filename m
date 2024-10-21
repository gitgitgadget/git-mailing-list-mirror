Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A51953B9
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504007; cv=none; b=oR30fYoY4g5PIHmcvm4nZ0nk/hqUeKUzzy2kqfuhRCuNTITVPIm3ydBoMaslMPje7BQBL2DOPkkK5bft4mHvp6IkytlDDNQ63FJzzbsG7Cs9TbBTJsdiN1Km4YFkB8UyzBPzQhzDdfZaSx9MNiMfRyFCPvIiEEXx1SBR6SO+15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504007; c=relaxed/simple;
	bh=6X2WVZEMg6/X0b6L0fFXoFZS2KJm+qWaivzZF/t+dA4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mVGXoqPFTh3MdVuLXqsCW+sxYXG7xYYVlw7FC3tB4QP1tbSs4YapCocOo0QN2od5BUCqRYmeIAubeLLtS29vZsnPMkLiqMWo25EN56mK2dPvoOT/7n23ni5r7eowl1v8/rhsUfepQ+SE49YNcqmABSoD22F+rbDDfYrJMpX4acc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=g5dcnmJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHwnVbPl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="g5dcnmJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHwnVbPl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FB3C1140155;
	Mon, 21 Oct 2024 05:46:44 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 05:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729504004;
	 x=1729590404; bh=6X2WVZEMg6/X0b6L0fFXoFZS2KJm+qWaivzZF/t+dA4=; b=
	g5dcnmJYiGEBIrSxRr/FKMZwdkcaw+LPPSM4vmMBCZ6B55SiVMwFM5V41NXqVkRc
	GAkkYLNyrJtK4i8/lt1+E+dm6NkbwA4aszA+BcRkuOmf8zW3lX4A6CfKMpyns8Hu
	DlJaCcGQtjUclGDaF8Sr4Sph2ozADwBFK/oul66WWRzK6SBXfB1hOrzmE0Aogbl9
	q/Mnye9gKbyUN6iw7GU0Txz/R/BaPka31eXsYKENyi5dCXMH5v/K+XxIvJiOrWZO
	9H5Pwf2emjjC6+ohe0AxU+Xtv7h39UD2bEeIBqX3s+CQNpWZuAm/Fu43tY34MRBn
	UuO4eGi/NE4jtnuAzHAbJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729504004; x=
	1729590404; bh=6X2WVZEMg6/X0b6L0fFXoFZS2KJm+qWaivzZF/t+dA4=; b=K
	HwnVbPlmiSfewS465qQVvyoWVfeuiFjdTU2HURHdGrLk4nTR7sqg8iiHs+WbVnD4
	LWWdm0+GCE2j03MY8iK1iJEJxgMHY3x5jH5+qJNPBeaVEnai2Wx1eKjIYLfg0ZUt
	L77PHnFzgS6TzrU45dagRAG/wR5yAbbCiGykS3XQTuzZucUl/ZgCTcfxaU/FshQ/
	M+P23IoE5j1kdvjIWHO7wA3AMO3O4dMONf9rT3pLwP7OY1XRLOPaHp8X125E3RWD
	9mP6zHo0DFvQozpBQBueTI93bf4F5kmhLtHvh/RPnbCB7kgt2wymgJ0QurN7xMoK
	IDcA/8fkoPdqgvFo4ZgZw==
X-ME-Sender: <xms:BCMWZ5XcUHcYkYyEdMnfOskbKiQuojiuevZVzLWLDNeHaH7jiInVRjo>
    <xme:BCMWZ5nl7Up4wHf1XI4_WR_7Hnu_aeU6o1gxWnI8AfKcBQDpHk2yUEi_hFjco28Wc
    s5zmPYbslYH8MR1jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveeiledtke
    fgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BCMWZ1aQ_vEgJ-ZbPxK2L_kQkUR54mAhMR3velSUwBIqQDSz5bQGkA>
    <xmx:BCMWZ8UkPKcZe8Vkn3_p6HChXj_YItXhHWhWwDi9szzSOWkPedcimw>
    <xmx:BCMWZzlqhDV-lmWPBVaAIU9oMDGYqOKP2KRDV-Bz0PtaBSji1o3Ftw>
    <xmx:BCMWZ5cMQ5wB0We_Z5Vo4jRMAgFRBS9wNisyvyHc5EG_ib8zR_CqNA>
    <xmx:BCMWZ7sjZ7CZKhykZHJKbjQC_6vDovp50Q0QWnXvsFKHzol--OgEmr0I>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6419E780068; Mon, 21 Oct 2024 05:46:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 11:46:23 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <015d0995-c7db-45c9-9ad5-d4ea75d8f792@app.fastmail.com>
In-Reply-To: 
 <60af98cb2c7752edc7cd5c5fe8173dc5b2522a7b.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <60af98cb2c7752edc7cd5c5fe8173dc5b2522a7b.1728624670.git.ps@pks.im>
Subject: Re: [PATCH 06/21] diff-lib: fix leaking diffopts in `do_diff_cache()`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024, at 07:32, Patrick Steinhardt wrote:
> In `do_diff_cache()` we initialize a new `rev_info` and then overwrite
> its `diffopt` with a user-provided set of options. This can leak memory
> because `repo_init_revisions()` may end up allocating memory for the
> `diffopt` itself depending on the configuration. And as that field is

s/as that/since that/

=E2=80=9Csince=E2=80=9D communicates causality better.

> overwritten we won't ever free that.

s/free that/free it/

--=20
Kristoffer Haugsbakk
