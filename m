Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6252F88
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251925; cv=none; b=U7iVgUTCkUGDiI5j4OBOI0uIRsXXt8PvAh5YtS+7uq202TGQH1TPepibNkl887jlsUDfELb9+AlsRyCC29hnFK/B0wVBUC6CZ8r8C7TqAfnrVYZmb7OxTaDmP/MjgihdGi8R5QT1HL6sT29s+yBGQPGCfcMzZFdf56e7xQ3Kk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251925; c=relaxed/simple;
	bh=J2J3zA4wotrO+b02C3DY7rlHJktk4CN8hkUxkMF0RvM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dZp6Se1W1QjhdvGmO4GZQ5JvqVnQ1qQymJIHKoINkX2dVQvrjhUwpxEnl8SsGtTz6UZVd/wOk1LmZHrkf8eGBhLGmdYpRqIqshD1JOK2rRmjuwOuaKZ12KT5MYwKxvJU6Zfvfe9whJzRXOBVHsu+v3fyfaeVqqaPFDy1jkaup+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DXHNBYyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ostP5VuP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DXHNBYyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ostP5VuP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 438A5140020F;
	Tue,  4 Nov 2025 05:25:22 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 05:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762251922;
	 x=1762338322; bh=J2J3zA4wotrO+b02C3DY7rlHJktk4CN8hkUxkMF0RvM=; b=
	DXHNBYygiNhM7An+20ggRetyJ+0hQUYinF4zGWWh6ssoE3UlLZgguRWtTjNtnf9P
	hKfkp/+ywf2Oo9JaO7vHsXq7mZgTcy8Y0DcEZ0jZ9P0chfrBKFkTbVTKuxEwB4eH
	MBTd/fDBoE1636hTnyfrwceuq9BBZyUw9kwEu53lmadnOZZ7roUt2oUyN0x+vjYK
	6LelrJpCMJup2RDwhQ2nP0mA+iIoAXmM8iQuE5ENDvxTaCEPhwUDPxuWgdqi22/T
	xkVSGaVFAYX1/tcc9IefklDVyVGGa1FiEs+kacbv1WeiOHJEVGnr7dpr9Vvj5W5x
	wxIakw+eVW6Eyd6yMfL6dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762251922; x=1762338322; bh=J
	2J3zA4wotrO+b02C3DY7rlHJktk4CN8hkUxkMF0RvM=; b=ostP5VuPnK7IMCMh6
	OdFlLqt9QTcxmrsD+Q5JkniH0e96M5GyWwGCb7uduXbop79miksJuIxctzmjChxl
	GLyRx+ghXg1Qd+aSSoauxXerXoBRZIOtxAsnrSKiWK3Nk1M63AV4uxLf/jZPedKi
	L1MYtX9YUIUo+ZPIIJ1VehVjr3wLqPQf7oXZWxQNYsSptvQIqrVNR7tQ4do0IFPx
	srRzEysYXsN7OTHy/FXg1gVmMWhtPLiSX7/HBGvil9vjSk+MwnMnc37E+rPFZIVK
	3nleuluCRmCURsYOfHhygtwYKSQA0pGTKI0jWUhhTmxyuvryZ/pSUWWOcZKWdvtn
	/521w==
X-ME-Sender: <xms:ktQJafoMtX_FDz_Z3YV5zUwoFv6fcn3_8bP0ASKQN5GLRMrPyEP9bcw>
    <xme:ktQJaUf2xadZeeIgWgJLArkt-1X_aDYKaXneGQ6zhLUixD37IitBisH3NR92RiGAo
    rkk3FtGamQDDuv6MXD_tRBdqnS12pJ9RU_-7VnA_KX8HVwcJWh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffjeekvdejgeei
    geefjeekgeelveehieettedtvddvgefhgeehgeelleelveffudenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrhhorggthhesmhhrohgrtghhrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ktQJaaWmpHMlMkNu4dthKEvOsnuibCkrwklPBYBQtRSD3G8Vw5l-gQ>
    <xmx:ktQJaUh7yQiZJe-Olp2lcI-xke5mMNdFXJB-EPlkaTXmcLBHrM4Dig>
    <xmx:ktQJaV-rssL2LPNcB05vuMhBy9xWQQqVX74BfaHonKzX8_CDf13W9g>
    <xmx:ktQJaeA8NmdLYN8GKLXLqJdDOD-FUXrgY1EPQakckcpr87pyrMZ00g>
    <xmx:ktQJaXNtRD40Y13TFxHXYob12B68pXjZfzWUGh78TlFiJGzhGGIb7-I1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 049381EA0062; Tue,  4 Nov 2025 05:25:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqulyL1FVopc
Date: Tue, 04 Nov 2025 11:24:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Michael Roach" <mroach@mroach.com>, git@vger.kernel.org
Message-Id: <ed8a6d59-9b85-4ca6-a23a-1e43efaa7efa@app.fastmail.com>
In-Reply-To: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
References: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
Subject: Re: 
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025, at 10:22, Michael Roach wrote:
>[snip]
> For one of my files named `ensure-string-env.rb` was printed with part
> of the path in colour,
> and the first dash of the filename replaced with a colon.

I have seen something similar when using the Delta pager. I=E2=80=99m pr=
etty
sure that it replaced a hyphen with a colon.

https://github.com/dandavison/delta

I don=E2=80=99t think I=E2=80=99ve seen this behavior with `git --no-pag=
er`.

Don=E2=80=99t know about the coloring part (despite `--color=3Dnever`).

>[snip]
