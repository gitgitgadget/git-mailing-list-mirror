Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB22ED87F
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312628; cv=none; b=fhtgBh4TwAqr/kRdujUf1XcDXIoONJuM5Cas++4tEgZ7wlCVBWyLVkp4ykGOLMyI7puoofLVs/oUu5DYzgQWjz5sh+/Ed05bkXRxKsTA9WgqetxofQEbdLwjmp2Olemc0hORAoEkrHQFe5D7Xsib1W6gVCNFhMMs0tC+6Dc/Bzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312628; c=relaxed/simple;
	bh=QlkJNIerWrORSZ8izTgSQJort4JdWL2U2CE40DdCkcQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Vzzaff9IkZXgNm6IG+/pfQr9KTADfne37WUEHt34PmcFpwtueIYQAdgfn7zVMyoQnyrszdJylHADwq1m3eJPt1b2I5AI8j4VnpcIbS7ERWcmElXFHe5cfh8KykedeZknQNUrKNXtEo02HtUt1FHuIh7uPZM9C556FyzbSb3xk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mqn6eplh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5WYwDMQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mqn6eplh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5WYwDMQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BA1914001B6;
	Thu,  5 Feb 2026 12:30:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770312627;
	 x=1770399027; bh=j+iaKwMFySGp7JwAdtzl76UQNH5kIlCbSCeVkPupjb4=; b=
	mqn6eplhV5zT4Ua5H8wN0oAgjf6sepKgMdUT7m44I0ckCWW2+HlW7E3A9ni6ZGYM
	XhAhdcrEAueu2Y5KHYEICn0wErMFA3Jmsiyqd8hql8rzJMzycWdI4cY+R8kRqxkn
	U3T8kOBUug1/wLa7Tvx5fXgHhuEpBY01v315VmWBOCsilJ10lGOWe5HhKFmwDJ4b
	wLG2FJ4fyaBwSwhE6Mwi9BlFg9exaGhbENHfMSSHyeFlW2t7ITRzQXIMdISoJcBg
	ylH25vDOXY0NGKqvDXo8n+D+N9jz1q90aPRQvKJWVyFCzyHvoKHI/Amqdp7L2tcM
	4RjIyOY6Iy0JPogmg9T4qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770312627; x=
	1770399027; bh=j+iaKwMFySGp7JwAdtzl76UQNH5kIlCbSCeVkPupjb4=; b=h
	5WYwDMQD8fNZ7+Flfzci3aEhMM3rJJedZThkncGnqE4Oz4ZuUFWzeMuhKHsNxEe3
	2HTGHG+bs5KuYAdBT1c2H5bY/R2kVXaK8vsQlbPDA2N7iSiINYZ+nsqpMhLBDyAB
	WDoGGUD2rTnsuSoqpFEt4Haiwnc2Uw/2nF5NXl6eraHRK3o7g47zFktiGfIe9IlT
	3xolmSdrDZ3CBASyfPAM2y+JP01jLiSfKeNNxv2t/0APQg8bN9bxCjx5in61iLCv
	05J90ijmH+ceenE7L4HA+OVuDO/n4ZeFHhwITwaXpJFeXGYF7xWIsNSUQQswD8CP
	0rppm/8Ivvr7mZlpJI1zw==
X-ME-Sender: <xms:s9OEacsKLfi6e-U-MXT9Zv7dIaP8_aOcXAaKG1_LzKGYYSmgaxoEQgE>
    <xme:s9OEaUTOkvseCHHUG28dU7ActzJVb8DFXrS8IaACTav32CGoUsuq2rUbMZmApW110
    VAls2VG1GZB5HMMer9EAxhZIQqibsCFVt3ds4jrN5Z6y-6_DHV12w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:s9OEaUXDDWGVRmIZJcLIrCLMB2u4tVUp2oCtCZy0Q7OnhqTcYvP38g>
    <xmx:s9OEaWYwCGM9U0wK44k3H9C2Zv41KaROUg9ZIm9_73cUU8BtEbNBeQ>
    <xmx:s9OEaS11QUVtSgJIscQFBEZ2-C95rJgULjr2eXyDfIwdubndt77ffA>
    <xmx:s9OEaQigN6YMcJa4SHkf-Ale841zA7XP6eOL1Znltd9txDU18p87Aw>
    <xmx:s9OEaSoejZlsTCz7sQHzgock_hBuRNOLoXsX67LK88mBAxnZy2SYBLHC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0772C1EA0068; Thu,  5 Feb 2026 12:30:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOUi-D7n37j7
Date: Thu, 05 Feb 2026 18:30:06 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <7c465b00-67c2-464b-b3db-d40685db7d2d@app.fastmail.com>
In-Reply-To: 
 <ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <ecd26a0f1fad5615aea07a388e34f02e9f33b870.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 02/11] config-batch: create parse loop and unknown command
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 15:19, Derrick Stolee via GitGitGadget wrote:
>[snip]
>  DESCRIPTION
>  -----------
> -TODO
> +Tools frequently need to change their behavior based on values stored in
> +Git's configuration files. These files may have complicated conditions
> +for including extra files, so it is difficult to produce an independent
> +parser. To avoid executing multiple processes to discover or modify
> +multiple configuration values, the `git config-batch` command allows a
> +single process to handle multiple requests using a machine-parseable
> +interface across `stdin` and `stdout`.

I really like that the doc itself motivates the command. Many man pages
on git(1) just tells you what it does as if you would already know why
you need it.

> +
>[snip]
