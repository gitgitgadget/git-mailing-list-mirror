Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3B288A8
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571724; cv=none; b=TzXhO/jrepjEgytOc2cj625o5+i35fk1QGmAP4BmycleA9ZCYD4+i6LbuSnLzGkBDB0JPODOZyGaK3jtrYz4yWCi3BvAYtopUjtZKjJfBZe7fRp+LY7z47wesYVwJTNIYrIM7g6mcfNX5LXj6bzI7+Scjq9S70h2iTUtCXIn2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571724; c=relaxed/simple;
	bh=tU3DWAGQRz5CafXoeX0EnZHqxpolSWKS7wetwSFhEAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSeCSQLq86UHrzvdeCStvOPKSJbbkkLwg+uANvI+SlR+AdA3VXQfGBA6VnvzyiJidL6jDMN1eCMIiGxs1Ji0oCMv4GTIzGLBYOgVfpcq7Xg8+PgT7CiYD9p1eVnPjh2fH9SJllpOHAa4KToCD52BcXmlv4wAYffQdKeAeLYiUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tay4LSP1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAc5ZIby; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tay4LSP1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAc5ZIby"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E45C214000FD;
	Sat, 26 Jul 2025 19:15:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 26 Jul 2025 19:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753571720; x=1753658120; bh=tU3DWAGQRz
	5CafXoeX0EnZHqxpolSWKS7wetwSFhEAM=; b=Tay4LSP1pDDFCmrrZrBC2lcKkp
	TYmyXJ1yhoo/18cD6A6RII+zucj9KsRKNfSzOkbq7D+C4tvY43w6zvUnl9NNZUYo
	Qsr+jcz1uC5MHDtSu0BNPFlmRmYgrMXan35H0trNwQ7MlJeVTgatJh5YrxG5Q/EU
	HKCXRK6c6A3Czf5sPKfJMBg1LB8zJQe9u5xr/cmUPlW4GBnJ3djztUFCL5VclOh1
	51vr/LkjXZG2Chl2iGbc+vSJ1tTMdvUdRI9+CVqFqeWKQ8ZFtGEOqbB+qjg9LVIc
	UwDI8rWgWctvS1E1GBzmDDMAqEkypIw+UZrRGIo5lQp9Dkid3e3nAnH0n+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753571720; x=1753658120; bh=tU3DWAGQRz5CafXoeX0EnZHqxpolSWKS7we
	twSFhEAM=; b=UAc5ZIbyJCx9Q28WEU6yPU9Y75fiJi7c2WXfCubmTRhFLpaOnwR
	BAmNCOhI2lLYd0u1MAvUf53JgqUqlyD9W39DbyVKQuMImWnBd1XWY8t3hWfbEYrn
	g6S9tPx9PiFiVbSuyMDNBIm63vShk/JEyIo8lW3bGl/9GhqjdTtCaSLSoJKLtHqF
	AlRPZ9tt7AiwTd7pQJPye1yr13/luLVrcWotCo/gRGwYxziZadiLysQxBNyD+SQK
	Az7W6zn8xj6Tlr0dLOj9ymzm0U20+gIOcwB8c2rjHyF+N6/HeDl7T/45f2q9fk6V
	xdmBtTgJu5HseKgaYikpp5jjLe1bqq+umDg==
X-ME-Sender: <xms:iGGFaA-a_At1YUzYHyidbn1GvILlIUXb_q11OgEOgFTwfhK5B-E7HA>
    <xme:iGGFaGTuDgAspnFxe-rx1He8Eun7ybl6JRV7vzOw-kyJfdRiqACcJzWhXNgX7POG-
    303Qrf1qOv4Zr1WdA>
X-ME-Received: <xmr:iGGFaMfGaHvM6fSOmso2b29Zlx9_skBwkzaS7mM2u0iavPV5nkahoe0F1mcinl4ynzQNMXpsiJrW0Yst_EF1S83eYkv5FHBwO3lahk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepoh
    hsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:iGGFaCBBXMfuObRnecj9fsfjDJYXVG_Vv4j7yUU4v8JfIe2nOO543Q>
    <xmx:iGGFaGnal-Dob0p-dMoE32CDkczpI-1yHFv2atZZ8cH77cO2EXia0g>
    <xmx:iGGFaFewiOkaAfjebYoSIKMiiE9FFoK4QBK08rdrIQUMvsnL8Adh-g>
    <xmx:iGGFaCQ6Ps4vjrBoHwV8xKvda4X8rDACUa1VVjCerR2q3pc5QHFOfQ>
    <xmx:iGGFaOCd9obGCVU-B-E99BQk0sne-N2hk2-ca3fgzHLITZxyFB_jQSl->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 19:15:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com> (Phillip Wood's
	message of "Fri, 11 Jul 2025 16:09:17 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<xmqqjz4iv7mt.fsf@gitster.g>
	<f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
	<xmqqfrf5nxnq.fsf@gitster.g>
	<b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com>
Date: Sat, 26 Jul 2025 16:15:18 -0700
Message-ID: <xmqqh5yy1r3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm leaning towards dying to avoid any nasty surprises when the commit
> message contains lines beginning with '#'.
>
> I'll try and re-roll next week

What's the current state of this effort?
