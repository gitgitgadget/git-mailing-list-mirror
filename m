Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF550433A9
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415987; cv=none; b=knOHZmqkBzuQQILsCIdX4tx55gSBwIon2EgaewMUsPnhHE2LPzr3vo1whPfbAzo+V9lop2nFaA7w3LfWcWNJJsi3hvDfA8JzR+H9J6wmWt6q3nVwJY4BfscJYURtskxMYqcEz5d/xeXU/dLQOIEJ8EwIRZT3b8VIDjoePIPfPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415987; c=relaxed/simple;
	bh=ESGll5xh+U+sTCSdkgxDrZC1rTHeLpgve/4jG8LsEcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sLrSkDzJJ2bFEqhTF9T43aw8SNT/AqEGWJGwjBul9FwgyOSbJKT9Gu+WV2LW1ArCNGKIw0mxVRAAjGMwsWGQZhs3zGJmnJX6dE3pDxxxP5TySkf/nVlCQEb7YrHAquTI0XGCy/Txp2QO9Ur3kjNXqYaOHuE89aw0vy2l5veF4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=V/te9syB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfG+zLQu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="V/te9syB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfG+zLQu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6F701140192;
	Tue,  3 Sep 2024 22:13:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Sep 2024 22:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725415984;
	 x=1725502384; bh=obbzn9WJUGRlVMKaDdv5pXKJQ8NwGqXq+16haTERYdM=; b=
	V/te9syBLX3MY3MkejFhZA2A766w5oMSazALNagyo03LehrnKz3QLIISKlNS95Zh
	gsMsa1VVNxecttEYPaXXaGDJOceJ41HIOHR+VZd8cBp9xUmT2RyZAZhXdkuBi9YO
	R7bJ4s2kUYa6M0yag2Ya24zGTdpp4vbctMxi9+HesYn2RfmaQewHKVk9aRTqiU2H
	2dLi5PHD3bSnI++i/ER47iG14L2LmEWxIPXb3vdHJJaPu6peUDTygVq2TZMF85M0
	ERWwj+dK2UXIuKDzw0vybFxCErQQXQYWGbBsmYWfUw0Cb9ABQvQb3oOX4XFr40iC
	2s46fUPnG/yLLBX/N0ljgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725415984; x=
	1725502384; bh=obbzn9WJUGRlVMKaDdv5pXKJQ8NwGqXq+16haTERYdM=; b=h
	fG+zLQuXJ0t0iURTLxBE06i7zqJwyeMtyQgswYiUJPcQIbWqLieGTc7fRZxZbNyH
	1uvbXZnIShMONVjBEnT5wQniCoBgxoMiRjXQQ/W6gqa8uLlvwhXWGZomU5UQ9wFQ
	aCDw0o0SGiRgJEq2aionRrYxdKuJppktmEiqOZZtHBFLGzKiUivaIdnStHguo+d6
	pcBfWgvGlh2FIiUsOnqNgrxwZaN0s6TIH9wYz/QqbIM8kAOJkAkxxG1f+iuu5D5Q
	l7BQ4LYlTuTUfylFPAXdrDV69Y6PaGeQ3Y2COXmLPLItjPn7pJs0T6LIUxB9/Qy9
	NEwwg6Z0D/L5ig5PNa7ZA==
X-ME-Sender: <xms:MMLXZodISy7Mej4G6w21wHjcUnO9eAQaeJmcsCEmCuHpWSqV_VzFkw>
    <xme:MMLXZqNHoY-le6B3WbFfGaldZJN12-wejRqdA9U2kypXmoF0zDUORB1tWZE0ZBFmw
    9C7CWCXbb5p9ZgPag>
X-ME-Received: <xmr:MMLXZphKrGn-F_w_mcp5yIpC1iCb5LOYU2RVDWD02rJCaNbGXIttnMFDW-qx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepffeukedtiefgjefhhefhgeelieeguddvveeujeej
    hfegtddviefhjeetudekjeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    lhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MMLXZt--Y6LcZ8-fj8Wet5AWj0crYP-qDJwnF5aTj0nY1mVyO8SUuA>
    <xmx:MMLXZktjzFW1GvjmgFAcpDHoS3UFELMhjesrzmorl0G37d4Mf4m2SQ>
    <xmx:MMLXZkFFRj3JVETlEoh-PEoW80TYDF_nTL9P-K5_42CL-t7v20qsug>
    <xmx:MMLXZjN0reF0GTO7Cd8_djRHEeS-ej0HOPHXzGGsAgZRKRrRAPYY_g>
    <xmx:MMLXZuUpjKKtnoWDJn4wKqN0WIaofGRlwbJ8NrPJM_yAu4w6DpY06L8P>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 22:12:58 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Sep 2024 12:12:54 +1000
Message-Id: <D3X4X0B5P0WG.1WHNSQNIRDHYW@jamesliu.io>
Cc: "Calvin Wan" <calvinwan@google.com>, "Justin Tobler"
 <jltobler@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] environment: guard reliance on
 `the_repository`
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
In-Reply-To: <cover.1725008897.git.ps@pks.im>

On Fri Aug 30, 2024 at 7:08 PM AEST, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my patch series which guards functions and
> variables in the environment subsystem that rely on `the_repository`
> with the `USE_THE_REPOSITORY_VARIABLE` define.
>
> Changes compared to v1:
>
>   - Clean up now-unnecessary and add newly-necessary includes.
>
>   - Stop reordering includes in "setup.c".
>
>   - Fix missing `USE_THE_REPOSITORY_VARIABLE` defines in Win32 code.
>
> Thanks!
>
> Patrick

Thanks Patrick, this is a nice series of cleanups! I've left a few
comments.

Apologies that I haven't been able to review these changes until now --
I've had to take some time off in the past week.

Cheers,
James
