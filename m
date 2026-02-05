Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F77C2FC871
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312134; cv=none; b=XVS5LKN415Vr2Ew09bPkBMQNtIqsEdtIiIhIBl5sY+41Z1uUDR84TUckAxGha5QXAeVeRCqRk06w1ki0Ax9Biw9LcbvithMRhNj+IGHUQLqFqbt4cSGK9fcajSf060op69cJF58WLYc6FKVZ2o+d9t+jbgm25fqWaHYagMpSwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312134; c=relaxed/simple;
	bh=gSdrdmrprl0ConEjNwuMsX+80gtjR/VIkWUmA/YxfZM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IQJ0KQp7f7xy4YYJUVCA7j+QDuBt19HmETUyngH4kQ3ZWVCsJSdquxo1SIuwe18YrNInF4TkLzwmUUQKylrZxau4LLi+HMYRG5ORHpLW9VJu3KFeyeE+D/bAoYWrbK9FE1L/oFSVfT14Z3vqCMQJVr5jqJ/7evMaQL85BMlO9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VeJy7jq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BaSk6dVy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VeJy7jq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BaSk6dVy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EC5C14000E6;
	Thu,  5 Feb 2026 12:22:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770312133;
	 x=1770398533; bh=gSdrdmrprl0ConEjNwuMsX+80gtjR/VIkWUmA/YxfZM=; b=
	VeJy7jq2FVQjgHgcQR7oaX1blhUdQW6+kGfYVDJ1Y8WeEusVyyLQcFbUBZEJrF7M
	0SU5R67fcjJGXfwbL37tYM+czZiIS8CIuhZ1dTwoDROftUFPU4UrS0Ht893PBABL
	xtQlTxuvEey7wCl9KTAq5fg1AWuXmAmDJI/SPdZiVgd9XYXkcKYmkHbSNXhjyrxJ
	wz53iqorAyz/Gu2aZsM1IySspRz9JSCMAZb7cmVbH+3Mi4NT782TReN+s6VgiV1K
	kn2Ai5e/+2B0Hox4lgM97ZZy3J169GvWsN1ErHbdoO1DiXuk6WDdU+i+MQVv0xee
	iFiWq4LXE3W+MG2p6oP4fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770312133; x=
	1770398533; bh=gSdrdmrprl0ConEjNwuMsX+80gtjR/VIkWUmA/YxfZM=; b=B
	aSk6dVyInnoFHE1NBqd0IfaQDZgNj2/MCpnJHh5de0JxloNZXZSy6Fzs2clq8nZ1
	izHw2eBWnYf/NRChrtCSY1+68jxe7V53rQm37hr6fAkVIOjkgkwZ4tmyQT5c5Qyn
	Y3kqILWiwv8jjQPREAlyHlJoENomCfH9++bd3tDRT+ChVqutKWhAmTJJDhk5p5n5
	BTROyfLlp7Jk5I4eDKRrvns4MU0w8qsrVAUioiQzi+pwu3r1oXe2yRip7JQ06o7Y
	zDXSNPvyAS0PEVyBisxXUl6xrP8U/a0+zTiYtRrTIvVg9O8+fS2D4BOzdiYHWLpF
	XRtYHmnuVArhQqprTBRwg==
X-ME-Sender: <xms:xdGEacghhmij-7SJSWEETDjSWv6AVnptFWX6nJzm-GAepvcJnL5_j1k>
    <xme:xdGEaf3lZHOFFCxLZHMBWwMxuplE8ujTjo8tsRfwmJobOPJqxwtVjQZLfcnqAs3Sa
    rjpMbtllV03E2mj_-14K0-TgkmiHZZD4YUZvqkRtRe2KN_ABOqjYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:xdGEafIuLxghoWn2fnSDvbcY_0Tf8S_EX9UWV3k0Au517mJsupdLhg>
    <xmx:xdGEaQ93fKwwhEL0-eYpVI3pCTrohkICWoMEiONnY6abTJW0RGfHTw>
    <xmx:xdGEaSJhC7XTTxY3ECge1MvEWcjgaAZuNRdrkoLvI6frO7dmEHukKw>
    <xmx:xdGEaVk1C6UPWD3z-mJbSIgp44WLL1aKJQ1fyyau9bqn-dQzoXJndQ>
    <xmx:xdGEaatrzQjPDMNMaLVey3J-DPbW_D1dvpLjBozJMiIILcVeLuAL2S_g>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BFA81EA006B; Thu,  5 Feb 2026 12:22:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A478TlyV4oB-
Date: Thu, 05 Feb 2026 18:21:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <9143e1ba-38f9-471c-a241-5505fe33bb99@app.fastmail.com>
In-Reply-To: 
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 09/11] config-batch: add 'set' v1 command
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
