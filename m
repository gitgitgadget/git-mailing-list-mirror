Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4291FDA61
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783158592; cv=none; b=qczh2QYyYATd2iKWA+QdoEFRS97Si5J2FDyjF96bM1KIbxEVKMXvcXPx6Y4zy4pNyX4IOVF2opqoc7092rQhwGvt3G+X072jqCYMbKezwfnebaTcyfl0qThro3OAdMX862+hl+TQCQKgmK3kv8QnffzolRuj/g3vTrsEgPDcf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783158592; c=relaxed/simple;
	bh=jH0vx5soQsrKaKpgsWiwS2auTdRZ24HdojNGmvwSXeI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sXBB9xs9g7dVmX77ZnCkxCqURwYvnlDIMWTRx4JdXNkFiBgxKuZWbdT2AiVZM/YWbhVErj5zi3EKS5Ao+2D6thDZ6pMUYvNJErmuhkzsiO8NPZXX1YXAb1vzv7HH84euoa9AKbR1lzVzWin4acEg81D1BMDYwiLpqnB0CNUacRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UDYtqSHG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnMnnwKt; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UDYtqSHG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnMnnwKt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 859E81D00009;
	Sat,  4 Jul 2026 05:49:49 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 04 Jul 2026 05:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783158589;
	 x=1783244989; bh=ejuCRDnAfeQgtSO4NiW1rSHfZY9o+Q04S7EYtOEpY/I=; b=
	UDYtqSHGLzGs6Ja52cJs5hxBaQ/iW8ErnXzWiMuaLoskmaaYYCo00Ru645EoXh+I
	1EBAi5IEhsTpE0IVqa/oDThg6qLwFruBO+0bBVMDv4PdxQalo07Z65E9n+mzbI3U
	p+dAtaZCiyPCtYXL+lvmJY0uCCbem76gfdWG9KwMnTsAW8L2cD3cBS5RBRbzMbZh
	syb55TIuLxgSubY4ZtRGMQiO2vAqxtTraJkC8JNuTTkmwKXxFfj3bU6jCVhpjokl
	Y7tDIq092K5ZiYPXR3+3a0uEiFr43uZVf4eUnqmJOVtretIZyfZ4OPfh6d0bV/fE
	8zTTAPJ10tna6DfR5ZsZbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783158589; x=
	1783244989; bh=ejuCRDnAfeQgtSO4NiW1rSHfZY9o+Q04S7EYtOEpY/I=; b=X
	nMnnwKtayJAdpfv+6Oe3BEvt5VzWFOyCkl6nsXMvMa0ZY2X6hanc7ttDxtl+C+V0
	RZGPLVcIiyfpwcS18UG9dsr+xCAwEmxbMcu2/++hEvKAnMNOlGRPLmH7rYlD4Rew
	uJvZRPPXTWYI6soEtqU5vZh/rLz+PKtkj9ux+PbXZxC82YDxOSDUWruynvfn7/nW
	3ScV0fEc4tNojybj5mmTD0/zWZW4JGrCE142KtDhY3Jhrfi9xmV+SmdSslZIEexM
	ClS+ChwCbr3yQ606lBPP+h4KywxoP3JZ+CEVpKvfj7w+8RTSFripJfAGNOegD19T
	43bbHiqjuZAPbw/eINHsA==
X-ME-Sender: <xms:PNdIaqBeeUM_kQa-GP8t3M9qhqIuK7x_0IXSgGCJgz_J4QcCRBffrkU>
    <xme:PNdIavXdv5xIseBEzmw7aLjqBHoU7wardiaKBeCdDo-Y4GaOjJBS4yMA1oQWhu0jt
    2vqG3nRatcVffwZRiJOD91qwbs6XIh-Ra6-BBFXims_kSQklYcB>
X-ME-Proxy-Cause: dmFkZTFmBii2pC1D4s0Ynj/3AE/WSBlV8fsq/uaQOU2Sg8WHRfkJmylkTyJ42bL5uIbFtC
    ZJmPEdCSDxV2zqUk0stW2Gmrwcj5HCPIko3upcckDNeQ0+pPYUX16ZcwzMFIKJmg/liVhd
    BGou9IU/w2kLyuv8aMXJOasrzCw9w7fo9I2kiVL2gMx86iLlFm7suHblDciEwkPwf+jqLt
    mxAqVvcwdgzvdg5w5X2NwT6bzNwUfPArP4599UpABzC4o7ohUMMZehm0PX/pnwyfKhTHqF
    2YAbYl0QLM9FY2Vwkab59NjUT/a5BHGomxMjyhQP8gBpzsDHZgzIz0wZgVKGKVTgety2g/
    r11HwjY4IhwEjzqYvLddioSGQasrnf4Yvzj7HWee/pTsybqqDxJ2a8ebflkvrheG3kNXhp
    5CJqGRksKPnlZ+T42mCkxW7nTxKsb0Ja/IEHGvF7OwsguA8fBX3uWfI9gFay27SwFXcVBR
    uMy3j2M+8dzaMxwobuQ1wmiZOLlyw+dcTZpi/thgmV/SwIKmnldfrZ3kkDcBqykaXORDoY
    ROOUFuM16hDGkR6iajYLPrZmGuOvInIkD7oxZ5DURlfUHEDRzWkutUvp7n4Z+YmftBfCSm
    vvgfrRuJqv9TIl0hXHe4PXy2klOdsayxiW+ZkRso5JEPNPH4lTpwp6ZKUfMA
X-ME-Proxy: <xmx:PNdIap_PZOcRo_tVenBF_1nCeB338F8rQsevXXOfRphrvb3e4YEYaQ>
    <xmx:PNdIair2lW7E-NRSq1hoT47JkQSm8dOcvi3JRwCgxbcpN4V-LhsRoQ>
    <xmx:PNdIarS7O60b5gMSamnTxMGN_iHLq4iEmJAsIaTD2t3bFSV-u_xMKg>
    <xmx:PNdIatNZpKDBYpJ5LF4oQ4cP0WICs_-VCahkd71VUXoNS-W8RyXxtQ>
    <xmx:PddIauGgLkph_vTziHQYuhcxSY0eGOvlc9_JaEzQUqmsruj10StzeT9l>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 559CB3020081; Sat,  4 Jul 2026 05:49:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIieKx0iZG-B
Date: Sat, 04 Jul 2026 11:49:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christian Couder" <christian.couder@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Taylor Blau" <me@ttaylorr.com>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Toon Claes" <toon@iotcl.com>,
 "Christian Couder" <chriscool@tuxfamily.org>
Message-Id: <4320d6a6-eda7-472e-b416-65bced3e9481@app.fastmail.com>
In-Reply-To: <20260527140820.1438165-9-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
 <20260527140820.1438165-9-christian.couder@gmail.com>
Subject: Re: [PATCH v4 8/8] doc: promisor: improve acceptFromServer entry
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 27, 2026, at 16:08, Christian Couder wrote:
> The entry for the `promisor.acceptFromServer` in
> "Documentation/config/promisor.adoc" has a number of issues:

(This series is now in `next` so this is not a review comment)

>[snip]
>  Documentation/config/promisor.adoc | 53 ++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/config/promisor.adoc
> b/Documentation/config/promisor.adoc
> index 455ce40be8..f07a2e883b 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -32,24 +32,41 @@ variable is set to "true", and the "name" and "url"
> fields are always
>  advertised regardless of this setting.
>[snip]
> ++
> +The available options are:
> ++
> +* `none` (default): No promisor remote advertised by a server will be
> +  accepted.

Why did you use an unordered/bullet list instead of a description list?

> ++
> +* `knownUrl`: The client will accept promisor remotes that are already
> +  configured on the client and have both the same name and the same URL
> +  as advertised by the server. This is more secure than `all` or
> +  `knownName`, and should be used if possible instead of those options.
> ++
> +* `knownName`: The client will accept promisor remotes that are already
> +  configured on the client and have the same name as those advertised
> +  by the server. This is not very secure, but could be used in a corporate
> +  setup where servers and clients are trusted to not switch names and URLs.
> ++
> +* `all`: The client will accept all the promisor remotes a server might
> +  advertise. This is the least secure option and should only be used in
> +  fully trusted environments.
> ++
> +Name and URL comparisons are case-sensitive. See linkgit:gitprotocol-v2[5]
> +for protocol details.
>
>  promisor.acceptFromServerUrl::
>  	A glob pattern to specify which server-advertised URLs a
> --
> 2.54.0.275.g96c817d129.dirty
