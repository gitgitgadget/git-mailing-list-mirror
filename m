Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6830CD8D
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367280; cv=none; b=m32VgmRif5S2+QsOpcVZ4CAKLEE6PJWp1vqIJwDoK9BAhBtQHdwlJXPmbuw30K7ybC10wZNG15Z4rUVllpsQUFDpgy/Pp2C9hc7Tn5TzL00RZxeY7xahHDGt5PML/JG9QZjE//LEiHyUaGtGK3tNoRDModXQWtOrd+lt4esHxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367280; c=relaxed/simple;
	bh=hricIYmFt1e+qAHhzNtO1X/v2nnal7B656obH3RVfXw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rRa/zrcgWyvu7YU+YHP2U2mx2X0mWDNSKrpaQR83wQoVx61UVjugVuRgd1BIQTHha7VH+EA61OtIJDDL+q+BkOEQ9Lo9EziNt1p7w12UchgcfMsT3C4OdAaTZHEzMsGXp5sVSGq9BFFuXuh6F0Duk16AsfkMOQ94efDEu9i8NOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LwpENn34; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uVOXrzqC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LwpENn34";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uVOXrzqC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E3901D00471;
	Mon, 13 Oct 2025 10:54:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 10:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760367277;
	 x=1760453677; bh=jktA66fx+hqnwjRrgkZ/ruT7jkZKJloAf4Jcfo09648=; b=
	LwpENn34W7h2do0xvZ7eiWWrqkDLnD/LnjMIQ13DdXLEvPDCehu1/1HiZrZPGxZd
	drkPzwJcDFwFpxyCsdoIrQG/dQ0MlDtVQ50Glng8MzxQucrj9jD+kslCwv/GvFET
	vlL5Gt7yyPgnmP+U+cMznA5jvN3oaKMbFDXlbcnqqBrN0oVo+oA06TMpxhMcoROZ
	BrtPHyHb9OkmQorzkaDd/WJ1lbf9rBjWnh23AGV7vO1kPcWek+IZz1ABvaUsQ3Zw
	gZiuGDwdnpFZc0nb5TgdHhj9HHMT/d85q1vqUj6kEzbuxnf7+3pnXB0kKY/RRmfM
	adlClWYd0zQTvO5+7lx5ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760367277; x=
	1760453677; bh=jktA66fx+hqnwjRrgkZ/ruT7jkZKJloAf4Jcfo09648=; b=u
	VOXrzqCdmSWajLzTtBd4CttDi/WRPk+9qir+HCN7NE7pssc0b0DKmZSmuZOPUB7l
	S7K9i4f317nJzEzYbDZZaRPgCRFJz5a4jauhr9LEyd2uRm0/xE1+FA6/Ep6dqyJI
	QbpOvM+PKFj8TqALL0hZ+jdpbt0bVnKesBuPd8i8IzBi7ehDR3oWEJDiP3sVdpFJ
	OOaeqrcYBNMVHnMinf+yBpvR5DZUvIg5sontjgNGgkCtwKc/vFxpF36MpN9h6cJg
	dnMmFFMUaVe/UeeBGv+3AoGCEyBMTXflYIsV5kCkRbgvtY8dwScLERuWfvlegdzF
	IQt1XH29C+HOx/lF+Zr9w==
X-ME-Sender: <xms:rBLtaEa2Wpc6yjvZ4FPFMocUK99C5_rW1cQJA5aaMAJoYt7T6ARIl5c>
    <xme:rBLtaKNTeYnzIFWkw71Je8ZOr8Kcoo287d5gAOctMH1UtmLqm904tG650F1rgUheb
    DPX22_JiKxOZYpWy5qArYaOVkUPoMKOgWOzLrDhPy3Xg3WP5Pfz_5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rBLtaO2SmoN_5jnpJZ6FE_vt6dg8GjI11oD_0g6btzN7KrSACNfx6A>
    <xmx:rRLtaI0AGMoecwjCAyRlnoxrhl52OEVMfxlxfWLhtYjxOrSP6cYfvw>
    <xmx:rRLtaJ9lFM-HobPTMupd67tCH0ekAvutXqXJ2fEE9VMeww2lTXlYtA>
    <xmx:rRLtaN2fIRqeFhaOz5X18CuwJEWGnB-8f8DU0fmoRaUjCenlb-KLiA>
    <xmx:rRLtaP6P9-8XjX48YRNxRfxNWkiSjgF9No_Z4jeGEvzAsUIQbWqTw2Na>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DAE051EA0062; Mon, 13 Oct 2025 10:54:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBFpqMSI4bk
Date: Mon, 13 Oct 2025 16:54:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <c29d957e-7dd2-4bd4-9ce8-9caa56d1cbdf@app.fastmail.com>
In-Reply-To: <d0dcaea3-844f-497a-adca-6241bf39db41@free.fr>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
 <d0dcaea3-844f-497a-adca-6241bf39db41@free.fr>
Subject: Re: [PATCH] doc: patch-id: convert to the modern synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025, at 08:48, Jean-No=C3=ABl Avila wrote:
>[snip feedback]

Thank you.  I=E2=80=99ve updated for v2.

>
>>
>> ---unstable::
>> +`--unstable`::
>>  	Use an "unstable" hash as the patch ID. With this option,
>>  	the result produced is compatible with the patch-id value produced
>>  	by git 1.9 and older and whitespace is ignored.  Users with pre-exi=
sting
>
> Thanks for jumping in the synopsis squad bandwagon!

:)
