Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8F3191B4
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203284; cv=none; b=EJVzcCaFNVAAzKephXc+hJJuCbpkMxeiYY4mzyaozSQ7M+aBbrC3SU1tNtynFXPk1mLqRM8dib6QpYSAjvHCe5kLUhgBo7adXU3Ajosktu/YUjC8rzjSVkju9WjrfQ7oHsLEV5AmqDziYVmv1oGhnd3wC4vt+FzVnGiBNaIIEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203284; c=relaxed/simple;
	bh=0oT3uKtXO/vM2PYBRaITsKVSYn8JVqsmuFc2IFenPVA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E3mEY5b7T6zVGspVLjHFT9Y0opVcFvqd2fhM9pHGh7PKmn5s5UR0ggDrs/Zf5t56ZAWDnfGX+AYiHZ8F9DvJP1ZLDfIKlPiGedD0k4Fm1r8OBqfX+GDt0WdgHgDbSjeelrWk/snXwEul7R2yyejHsmRte85OrtpGa5WAPzSsrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=d9jzUj6w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msa/2L3C; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="d9jzUj6w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msa/2L3C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CCE57A0075;
	Mon, 12 Jan 2026 02:34:42 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 02:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768203282;
	 x=1768289682; bh=0oT3uKtXO/vM2PYBRaITsKVSYn8JVqsmuFc2IFenPVA=; b=
	d9jzUj6wZTkYXJE6GESJvZb55qfkn8q4Ton5GRlQbFu8MjySUWH2WF9/jhu+UGNX
	IBBIrzRIwdCgQtf8qBThybyu7dGhBU+u9p0WaqN0aCzsGgQdlqeBYhPeeVUno2Yd
	IqWEvP/6Qh8kPIyRDDVpQVvuBx1bdvLsPxhlmPn1fHHmNgLSALenXwUiWgQdx8XL
	O+xBpcWnEOfPVXY8rDDnDB+QmgpoyZKqNq0zQ2P5ymas4EL/MHliFZn+o5l/3O7u
	evwDma3uBkGuQVKkuG4m7Gkk5NnwP5Ni3VHw4bFhKb+f5b4P2QEfukX/+FkhAWYG
	mXSnwUN8J2s8SxqY6lxivw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768203282; x=
	1768289682; bh=0oT3uKtXO/vM2PYBRaITsKVSYn8JVqsmuFc2IFenPVA=; b=m
	sa/2L3CuSygHTHmQTceyGUNkR7ODG8+BHqgekXkGgZ4Li93XTvEdNLwrSFpPb0gx
	m9tSF/iuC3DaZJ+zziJ3nHfoHIkAX1qppYnR5d08a0wB2NxsoJzPI2FnnylMcqGC
	6+zbo3YPjXj6/8YZvA2nWIoazWHahCuPeUE7ocVhOzyNNJ694gweK06rAO/s5kLx
	UJUb1WsF9dxH2jP5naMb3vX4Q/OW4i03hR6qoRtDvWaFNh7dr+DUC6mkgM6FX2Pm
	ZkZJ8VUQYfPkUwu6v7CqzrwI8Al/qkHKmkzeItdEajHyr/hOHxIgJwF1WPvOKZ0c
	daBhw/pO7Fsp6jENKUChA==
X-ME-Sender: <xms:EaRkaWEUr5cw2-sJ2_XnpJJWRs_pxCcDkHiIlz4xdXzyQ0axIViDbBU>
    <xme:EaRkaSKn1aQVPhj1WUlt1i0SMSM2hftMbfBfKUxLVXsEknTTvpBIXofl3E92G0c47
    goKWsM9hn17Vqsf3UOH3RGYM0CglcaRPkqgiQyonZA04Ppvu-Eqpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EaRkaXtS3CqYzjGPYqyD8BvobkI8UsoYQi1_9uyNbeTRtOCsGJgtsQ>
    <xmx:EaRkaWSubb616muBC2sbgxeY7FJkNxjKfZv5ldPsolDoPYvrZQhHmg>
    <xmx:EaRkaVNO0shWo05DAvQ9b5NC17YZfPosK8MK3lC9wVbWVY3d8_JpLw>
    <xmx:EaRkaTY5BPHTpMC1oFffhTFKzLJj1ChaqW7NxD8rP1xG3QtfT5LFhA>
    <xmx:EqRkafhNjYv8QfEmr71svi2AFjqNcs3tvqCCxCKWvFYkbJ5s5CnDWDxx>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DFCFB1EA0066; Mon, 12 Jan 2026 02:34:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFA_5TjvXxjF
Date: Mon, 12 Jan 2026 08:34:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, "Josh Soref" <gitgitgadget@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <2bf70c65-3d8d-414c-b4d0-9fe0a3decd15@app.fastmail.com>
In-Reply-To: <20260102112037.35360-1-haraldnordgren@gmail.com>
References: <757d6df5-7834-4ff2-8302-8edd8e990970@app.fastmail.com>
 <20260102112037.35360-1-haraldnordgren@gmail.com>
Subject: Re: Another look?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026, at 12:20, Harald Nordgren wrote:
>[snip]
> Did you have some time to also look at the code? Would be nice to move=
 this
> along if possible.

I=E2=80=99m not the right person to review this. ;)
