Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8404266B1
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312572; cv=none; b=YVMU6ZjDsWYKtvpUzPyw3vDYHaFgHf6EBr9Bl8nBG95K7fkMJO+faBxwbzJb+Y796ChoQ6uUTDf6qQ0axcrnLdSteNMX75d+2IPg2DrqcgF/ZSkXBvJnY8mJXQT1E7Leh9GIVA/28bqa9DmVl0oxGeQZrJhiU48vqrIzMY6vztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312572; c=relaxed/simple;
	bh=gSdrdmrprl0ConEjNwuMsX+80gtjR/VIkWUmA/YxfZM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BTD/uzm/8ku06Bh9A7fN9Vq8a7i6Lyi30gkJh55XJDAkYQI2vkebHhZECJchTH4dwOLaYJ8PuqiXqD7FZtkGZ5TuWTXHYUjH/cAUwb9SYirCu6iSHcVG/31Oq788Sfw6DkBk3/sB7UzJ/UI0aMkGkxm13t6t7QIT3Es5QwkcEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LC6g2Dwb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GX4jICuN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LC6g2Dwb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GX4jICuN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D03DDEC00C6;
	Thu,  5 Feb 2026 12:29:31 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770312571;
	 x=1770398971; bh=gSdrdmrprl0ConEjNwuMsX+80gtjR/VIkWUmA/YxfZM=; b=
	LC6g2DwbV+aPy34wRpYk8jKESN/qvuaFG912Xs7SX8ImDU16Jjq+T+km3rZ4PQc2
	xH23Af2nhA50WI70/j3lY7rovYQzCMCCyblEhVJZynhpbn7WacMOtZyn2oHvj/1i
	6GXWJSzMLi+oV/KUZwpAOAriWPpy/821MP0dpN6cmboCOJZhPa8HTKOmdCj3EYvv
	CuC12anIYsz0mWGmxfIIUCzZXF8PMd8myKsSiy9ZiESpHBX9PWALHdbqu6PnE0U/
	lICW/UgzVjyue9k0+keKs4Sp5cH/rSPOuIWoUNRGZ6+XMeAZJswOlXoiSpjFC/xo
	RDO9razlbfnO9Pwl9+4RlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770312571; x=
	1770398971; bh=gSdrdmrprl0ConEjNwuMsX+80gtjR/VIkWUmA/YxfZM=; b=G
	X4jICuNX4k/UeNz5XQ2dtGKlIxNo0wspJPjYG27/FIsbyC9aA8OyVr/f4LSps6jB
	DM7QenHqU119cCxQA0VjPSg0SkVLK5FUqmbwCOwXgV9N7PoH3eW91XoXgsN8QAdP
	R7QV+W0qnYFFgrMyK09B9Mwbh4541y8jNdfRgGe8R0A8MgxtKAi4/6sUT5keQgut
	ZpGcIp2EpNg+dji73lt/2d7lyNjH8jLbzrvAEvwHp+MUMOqSS8NYn2/2e3ouIU69
	0B1i0likt6MF08+2c8yUFf/cqc89v4C7XjqzmUJ4dZ28C8KCyrwacndNXIWT+VMh
	TVbJdXdOP7wLUoOdvEkRQ==
X-ME-Sender: <xms:e9OEabRsqzU3wFGMu_NQ46ub6NfuQTdseiRM6KriXbt5AGQ05f50RcE>
    <xme:e9OEaXnUJQdm7QapaxZipffdXeX-8zC3-pFDIHebtY_2SfWMa3LdlrbhG1DXZ9KDI
    oF8KI2qsCwL6AA20y72tX4p4ngGvJ52O1NIZb5uKc_Qh9zIquXKBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:e9OEaR5pthvYG9hMLevUGObhrRHYVpcWATsqNhOU4QIRLn97yoWjbQ>
    <xmx:e9OEacvD43PFaTF31lqtSEJCUbUc7JwWDbjuF_YFkhqLarvTw6RElg>
    <xmx:e9OEaS71RzCIAMfnwZFi_eS4w0R9Omeeg_Eq47Vukv6xkoyZ9z5vRQ>
    <xmx:e9OEaXUG6W0ej_WDh8Q88d4KRWXSc-iStTNTwEiSZ3n_WEolEodW2g>
    <xmx:e9OEaQfu7EgvGUNUUbCsA1J1gyC5xhZEDtMWSc6u8j_lBF7H6HKmQ04a>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ABDE01EA006C; Thu,  5 Feb 2026 12:29:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhnYvctSBUNN
Date: Thu, 05 Feb 2026 18:29:01 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <da3ae8d0-dda1-4b27-9e37-995dd8b89a1f@app.fastmail.com>
In-Reply-To: 
 <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 01/11] config-batch: basic boilerplate of new builtin
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:
>[snip]
> +git-config-batch(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-config-batch - Get and set options using machine-parseable
> interface
> +
> +
> +SYNOPSIS
> +--------
> +[verse]

There=E2=80=99s work lead by Jean-No=C3=ABl Avila to use `[synopsis]` in=
stead of
`[verse]`.[1] Would it make sense to start off with that?

=E2=80=A0 1: E.g. acffc5e9 (doc: convert git-remote to synopsis style, 2=
025-12-20)

> +'git config-batch' <options>
> +
> +DESCRIPTION
> +-----------
>[snip]
