Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5E283FDF
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104022; cv=none; b=Ij+ebLCH7kBuHDVXh0HivlrIgbpDBtzmqmXI+5NbQUyDqxdQLQNEeVmQ3Ntojm6CIF4YxPtb6t9/a1z+5UgTI6Tlt070h0qPI4pqnfNqLhYTXlInq2MXGUSUyV7Qbcv35fVY0gfYty6/TdfxoRlGguDZZFi5C1l3x20Giaj0N48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104022; c=relaxed/simple;
	bh=xCMhQ4vN2ETNntum0F8vooCuG5fEw6WixPC+QsY9tRw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sczxiXJ9+daDwiPfW9p/444ndFz3dcRoYf1I7Gbqc8JH5od952w9jSLM52IqL76fwYEHkGDVLtThmqpK6XWuo9HzT5JPNhBsfCdZmpd1kq7kG3vJKixbAn7loGhiF1evnMDVxv933yaVcRQFu5UI4WhtOldHjbOkci0ApIBiDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DgVqTFnT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IAwVBFV4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DgVqTFnT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IAwVBFV4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5222514000DE;
	Mon, 25 Aug 2025 02:40:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 25 Aug 2025 02:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756104018;
	 x=1756190418; bh=xCMhQ4vN2ETNntum0F8vooCuG5fEw6WixPC+QsY9tRw=; b=
	DgVqTFnTZLMTtFODbON+tnPku0WuoYV/29T/IGA9wvNg4VV+gIropbYFzrM+XfrX
	SwFwLo1chqb1sT5ovCFAchPSUP/2jGZcJ//mtr+nI53yCGWGaKLiHlVCDDuLkxSQ
	PBqD+8GwcGHdCq9stNfm9R9E+EJaNp34QhMLruiFOg3I02S23pnbLvX5vWeDIG8n
	dHTkE1/wTCNPHvtczFGxJ7lMZIeGuxM3ZOUkINGRumnNnYFrVFBAefiK+hfZvahb
	6JfC2tj4+zgpWPzoS3JuzRGN6FJOcfwurhmB4R8mXBxZzd06maynTw1vu577AqKH
	XkqP94+V56kcVtpa45kupw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1756104018; x=1756190418; bh=x
	CMhQ4vN2ETNntum0F8vooCuG5fEw6WixPC+QsY9tRw=; b=IAwVBFV4z28e4prRB
	d/vHDI3Rttw+vop9BiUULUBcFNzpHJIO+wtv8gwsmOqvj7BxaTwUzY+xoQyI7c9p
	m/91tR4j6B78bQNZ1STuWwgI9XXnWq4wRq4SGnciWYDB6kmIwpbxOAVEeHiQClgU
	374H02/ZMVkldIQ+8rzwGrAIq9AS9RWwANtarXSThup3dn3xmJIgpdcXe/9v5eYP
	bRCekjDrcsyWkjV7CjxI+ZfyYRi6ijh6BU+KsEJf6F7PR/98jkxw6GqHQFLMxI/p
	WGMWX+iX+jXICpL/amzsjc3HlFrjz0MrTY23bW8Kbpjk9FWYSMP7e0sZr9rBzvhW
	mQzEA==
X-ME-Sender: <xms:UgWsaDq2zwyZsQU0MFsTdfKlV1rNmbTdbUP-3bbP_zgkppDfrwwzuo0>
    <xme:UgWsaNrOlqMTqvYyTk8ISofoTykg-E9dN8RHbXJYHwOGSkPuz8gn353uCzqFdULJY
    ylXTns-HrVB-QzE8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegurghvihguohhffhesrggtmhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UgWsaPsd390cVYPVgSYWhOum1jSrAr2HBlvRIe-cUbfSSPRFqdADFA>
    <xmx:UgWsaJbDGSTozCvadXQj3oIMHAo6U9YKW-sQcuMMK97vnMcHIq5l7g>
    <xmx:UgWsaEv2kIQcd9Yg3WID29fQcv9ed3EaAJi4sBD8AftE9QD1tqmXmQ>
    <xmx:UgWsaLHyuKF2KMUA-4zd7sHs8shSmm7TzeZ0mPLUhWGY9IvVGqFxLA>
    <xmx:UgWsaDRIwUEHW9QPUex30BBGtoPX2yOxdsdaS69JimlNurLQ1LjTFzJ9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 119421EA0066; Mon, 25 Aug 2025 02:40:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXklr0NmqSqF
Date: Mon, 25 Aug 2025 08:39:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Monte Davidoff" <davidoff@acm.org>, git@vger.kernel.org
Message-Id: <3ee1ba17-47c3-4090-82c4-73548006f800@app.fastmail.com>
In-Reply-To: <9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org>
References: <9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org>
Subject: Re: Still use git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025, at 00:01, Monte Davidoff wrote:
> I still use "git whatchanged".
>
> This is regarding the removal nomination message in git 2.51.0.
>
> Thanks,
> Monte

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

... with some caveats about timestamps?=E2=80=AF[1]

=F0=9F=94=97 1: https://lore.kernel.org/git/877byxbtiw.fsf@gmail.com/

--=20
Kristoffer Haugsbakk
