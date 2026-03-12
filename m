Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685C288C96
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339264; cv=none; b=hUMy4JjAz2zZj+Nzka3EL3H8OEIQ396vEHeRymOPSsyk/ZgiAg4cmi+VQ2pO7VnLJa4uE/45ZFQ3OZEqWa6spwB7HQpncQFmRmAmAx7CQhipCoEDVZJxzlokyWIiExuHKvEKPCxOVpJA1yPPv/u7S4v1Y60i97YEB2YJAAWSDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339264; c=relaxed/simple;
	bh=0hsh/+6XlydqLxd6r4UxcQZuWGxb44Ohc2G3D1euMag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ncr50OfN2X+HQ58rgUYcto1kldi4dQIAEX7PNv4CHU36tnLdLRKu31uvv3MGvJpXjWkHe3s0eopHatxyjKrgIh9hMzdYmS3br6qAJPmghvX5N0IKVXsd9LHXXJYPQS5FQBtj2ZC0atrZ2J97OPelEUg9qCx67jFvIMdmVHEOsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R+hm27fe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrpVUUPZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R+hm27fe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrpVUUPZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B381EC05C8;
	Thu, 12 Mar 2026 14:14:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 14:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773339260;
	 x=1773425660; bh=0hsh/+6XlydqLxd6r4UxcQZuWGxb44Ohc2G3D1euMag=; b=
	R+hm27feeQQAwPUkGzbPg0X3aNVzO49LgPZcXKhgF5BgcL1CgGK1zkfdOAuM8QV+
	So6j28y6U950ZpBem1X7qhuGrk4YcTXXgH+ngY6vzdJm2Whk6PbEm6WyDF6/hrVX
	Yi9BTZe+vfv0ZL4V0BSY2cSmU41vVglpuMvoREowk0vbcDb8cqj3NV46wRfA6qt9
	NVBKYAA2fvBYkSRFl5enWRPjXHdXLE2X17zke950dm1jIG1Nc60WzXxRxHGmSiVm
	eEbaSOJ1LDYkUCT565An09vMIqs5aDJNAwOjkxHs5mmQdl7d7RJCyEUnsBXtClgH
	TpycOtA8+Cpixjl8CTVuTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773339260; x=
	1773425660; bh=0hsh/+6XlydqLxd6r4UxcQZuWGxb44Ohc2G3D1euMag=; b=U
	rpVUUPZIgOh27IbMDEJ5CTF581y+u4FN2XZTIy1nRsTq+GvO6sLeccbavH4mH4mo
	aW+BeLqb1IcUVVXoLmKXTnnqqHR8HMi5AqOSr4DgOJ0/8NVAMYIX90+OLUu+veS8
	04IJ9JnwmzlLdO5taVy8d0z2Tt9KEnxS9yaDpPWApEr8ZPy8lmqM4CopicdApJVZ
	fRBYSpaoHXi7XuTSYEcwW0sbg8ASAXbYsZqcyoillEJgciluwY0vTTw7GE63GNp1
	7fd9L7BKHSQ1Bi49Eo8ybPlwgPFhnaUvdVcrdSzTWd/0cy0xsA5EOMGi7gL3bdBd
	JUxWJOioGp2f4OMTPYrbQ==
X-ME-Sender: <xms:fAKzaRZhIY-545Mgmzlzu6tQQH_t1Q2O_vOponeOq8N0mXqdgZmVEA>
    <xme:fAKzafQA5Z3g84C91UhOxeZxWN8OYHib0ydaEOE04ddC_OVCGU0jmCpXibzZgem1F
    uXymZl0rjGAo7FG4tTKr7o2QDz2T_88sU47BFof0lglSj37nTtopg>
X-ME-Received: <xmr:fAKzacQyXxVQRklLteaUCaP8N2msqM3-9cLHmSQROzZ5W9zF2LvIj6DToiVY_9hHPoX_iY6o-FxZPHkGdruf2HC1X5X4oI0jYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fAKzabTfdet_6hu1UX3b-5biCc3PoVqRq_V2CEfltMy9WG_h338RgA>
    <xmx:fAKzaZ60Ma8p6NjCaVCxWEr0TcUVsacog8v_jCcg-xAHzO5rjxLflQ>
    <xmx:fAKzaf00FMpEUS5g46CBx0IoST77rh0E4CLDHUjXyYeuoF4rXoxrEw>
    <xmx:fAKzacAlq8eP_ldzHRpAV9yzMxzh3q2yragSYApqDymUOdn3cNs-BQ>
    <xmx:fAKzafcZAU9Demc1rc8Vesak50kV-IUOwudbs45VJZ5gDYN671eroOSE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:14:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  kristofferhaugsbakk@fastmail.com,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 3/3] doc: config: convert trailers section to synopsis
 style
In-Reply-To: <3411126.44csPzL39Z@piment-oiseau> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message
	of "Thu, 12 Mar 2026 18:48:49 +0100")
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
	<doc_interpret-tr_config.48d@msgid.xyz>
	<3411126.44csPzL39Z@piment-oiseau>
Date: Thu, 12 Mar 2026 11:14:18 -0700
Message-ID: <xmqq1phogbk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> Hello,
>
> Except the replacement of <keyAlias> by <key-alias>, this is all good.
>
> Thanks

Thanks for a review (and of courese, thanks for working on it,
Kristoffer).

Will mark the topic as "expecting a hopefully small and final
reroll".
