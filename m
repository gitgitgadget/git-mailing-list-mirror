Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B41FF60A
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257190; cv=none; b=WQzpeGRIja0gcmsQhD3aiD9aAmOiP0YD6wOP8CZg3qPCnIXxmRD5afcTqiY1JA1VCwjVvpbWX7NC0MtZhpUgUqV8UalcSV60HTAeuTX+HJgWSsxDhInY2GIaXDk2OMJwdgmvEGdFew+WjR22jSOMKULlon54IsdPvjsUkXpjIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257190; c=relaxed/simple;
	bh=jcjcWiVztj+5yco3ihYWItONbKQf+xNvpyp58mSRVYE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GyxBM3JEmam3gVRAg5LPqamAVmha6hFaQfve2SePOF0rOXV6Lp0oa58AF2W9/UFJIsNsR6tUPoVKiPxNaUHseKd/SseawU52kuBLhudy/O+FZVyNO2La9/D4DydW5f6791BoIQPrtTPJFXeh6pJ5SQivPud5I0eRjOZLCnB3HQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KoZ8d7+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3+hKQw+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KoZ8d7+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3+hKQw+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 404C3138038E;
	Wed, 18 Jun 2025 10:33:07 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 18 Jun 2025 10:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750257187;
	 x=1750343587; bh=jcjcWiVztj+5yco3ihYWItONbKQf+xNvpyp58mSRVYE=; b=
	KoZ8d7+qm+tvSup0qtyjej5Tq5Uz05gQf+2dpUvYDoEiJJfgFZz6g+fp5uz3OuQU
	Hdu2hb8s8UNu8cOi4i0nPLcZF2anT6Ny52DnVWQS8nMIWnA2qL6TunbT5dMT4fqc
	BcaPFXrdhU4k9mYNQP3x2Um/DNC97xmd/a1Cag41nKM+5t2L9OFoRSE0KlpYcdqV
	SE/AfdeY+mParz1G0gmdxlonGWu4LH3t39ASAM/4hfzszgcFwLkGqbvTm4aX3AG+
	awbpN2KJtk0Oj6UtNSKNqtz6KhYyF4Rd7kjW8FxWuXC+OGwpm3gpP1Lk3d99N7QB
	DnRJiL7P7HOwkpR271og9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750257187; x=
	1750343587; bh=jcjcWiVztj+5yco3ihYWItONbKQf+xNvpyp58mSRVYE=; b=e
	3+hKQw+Y8Iv5fl429WCQj54J7L7XxYX0jgBHCqcj4EjLjymvyeNYn326hQjjG9AP
	fLbw1M7TPZLCfUppA7/pb4qM/U0qZLaA81ZB5K4aOjWlWkQt8TejDxKnGZ09my4F
	WLDNAXy/aOME73JWscwmvjx0OhU6qyOoYFShnrNAN9wx3MeXaq+fn5jDLZ+zT7E2
	XdQUL6yp3BROFy+quoKkV7E+8nXvSazMTaaWrSjDW8n9Yd5qs79OuRIuCn5XFKvB
	YXWcDMFl0cXtjoh30OuIZExFaqOPZ6oGNPevcjaPrtUJG3Uu4VYy+g7VgOt1BkZ9
	04WdzWMamviES86z2EUZg==
X-ME-Sender: <xms:I85SaCaKGmXMqBfJSoBXtoRum7L8i-Wt8pSM-S56zNYWvFBk4G_TPNk>
    <xme:I85SaFYSaXuaMi1f5XeQfo6gzGik_DGz_Shc-duiL3oAvR4VZwia9aFIhkk5EQiWE
    UF6Of9SPr4UPuXvxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghrvghn
    rghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:I85SaM9q3mTu2kzVz64J80ld5sK2JyOG61uWd0QwFA63OfZcIgtCqg>
    <xmx:I85SaErgYATaol0biw-uZJsJicN5ZQ6VOs2K9eJqInKbQLrvs8vJiw>
    <xmx:I85SaNq_PRPRcxXtrOWZaXr4kNKQu4doHbsJ2n1QXnxO7fC3o7MfhQ>
    <xmx:I85SaCQohxWZNJeH8KJbR2VB9ZPSE0jfgldVog3u1Tk6N-Anixc2Kw>
    <xmx:I85SaFESknkAvo6Hc0l7ffY6JDvvQoG_CoC9z0aL-9EZt34Ir-NBv8CQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 002041EA0065; Wed, 18 Jun 2025 10:33:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T48bd716820b4caa7
Date: Wed, 18 Jun 2025 16:32:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: "Jacob Keller" <jacob.keller@gmail.com>
Message-Id: <ffd2cf3e-95b7-4c4f-bf99-3dd624481c5c@app.fastmail.com>
In-Reply-To: <20250618062331.78059-1-carenas@gmail.com>
References: <20250618062331.78059-1-carenas@gmail.com>
Subject: Re: [PATCH] portability: allow building in systems without d_type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025, at 08:23, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> Since 09fb155f11 (diff --no-index: support limiting by pathspec,
> 2025-05-21) will fail to build in platforms that don't have a
> d_type member on their struct dirent (ex: AIX, NonStop).

s/build in/build on/

--=20
Kristoffer Haugsbakk


