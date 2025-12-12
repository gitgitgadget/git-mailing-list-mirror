Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98975225779
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765544665; cv=none; b=th5oFrOylZhtyEkut2q6eGEdP+EnHD755v/FFExHXDQuA7AIiIVPGZFnUVWGrgjkbaiJmlXAmWHvoHvQOby71UsF4X9KQY/Bb6LxKbG56gUDb9ZnjGkTdINQPLsXZTtMuvnAkz/FjKVS4KqBqmA6cF+g8iH402mohigE7en/6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765544665; c=relaxed/simple;
	bh=qmRV/ZX6dfDyyb0dLwOgfwwbYBICdaXnOpTXoJE2XNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sM7SgI+x9eFVRk6+LpehmanqbRmgCBP2vKfF9EnHs9BtHXNWvCSMyWkeDrVIZb+UR7ogjJXhm7rac1NrZEsgz0A66fWbNgJrBqLBZMKoPFv/NNSWJ/u41EcPum3jaqEZKo49neyZBjQFYGtXTx9v9PP2S6Ya4409AduNW3lPbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bOh7hiQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mGgSX+MG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bOh7hiQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGgSX+MG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 808057A018F;
	Fri, 12 Dec 2025 08:04:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 12 Dec 2025 08:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765544662;
	 x=1765631062; bh=G4aYcUGPpI9Zx9Kcqbv/0vepZABLfUEkL/apGMivWVw=; b=
	bOh7hiQ7+l+0rhYEIOCiiDiRSJyUQKYMKZI676cHjVUVZ8yIRia7yB/ZnzpUr2SC
	HKMs7cfQsn9kdWptE2iP72Fk934l5R+zZk+SGIsXmmL256yRiu3QfhKk+Wzu4RWU
	aAdbopvcn0OnF40YHGaIH00OX3IqOTvruts6QKewG5+WB4cdm6Yp4wia9yTY1PQn
	ovhosCF6y0Z0WHQpKJLE8ZoQbBxR4RyS5qc6kYQgZf/sajAiBKFljC1oTj5TH3zY
	GUkyEtvKTrdaPN/jFIPTHQGcw5LV10T+WL/dot8GyPUNfwuONR2GAqbdJy3HuqCd
	pwZn1xJ9dSZ2XDKQfJYjvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765544662; x=
	1765631062; bh=G4aYcUGPpI9Zx9Kcqbv/0vepZABLfUEkL/apGMivWVw=; b=m
	GgSX+MG+hncRjctV+A1PVYBlfhvd6ol6lYRfZ+j5I9a1OdsB3993mZ67JKifSwIi
	UAZk1IATKG8qXTBUjijutDPvHbYfowmNnk5fkqWafl7ylGIj1hIVRyJkxbRgIh7v
	y1VFuUP3esS5s32mcU1+I3m2XJMKo1XJalmrLj8qBbn4vzVaQBEtXGCoUoqzX645
	Ra65uu+/vV1XltTVH6cRk3f0/X19BZoneZO4FlPi2dsm4+qmsFwdjVfZd63NtYcS
	Ac80mmssOsmBmqikC95cuD/ioIVqUzRhJNZUwNJp7EnM0Ym9AydIxTci4t0l4ZwP
	MEjCJyalNQxkyjG4mlzxQ==
X-ME-Sender: <xms:1hI8aYlBkMZv1D1mi5hw6SnLQdm96JqdFfiVVBpDNH08zixxVsHIYw>
    <xme:1hI8aevjxXn0FOJvD2pKItvDyM5JHVG6IY7-wx6KKwHyfHb_kEVhIUoXBpQ0ImsfJ
    kZ62ZUnb22qdUG4ceOXE4JoIZzaKxM8iFd0DliD4-B5dMHk2MVF1w>
X-ME-Received: <xmr:1hI8ae-_vS0Tr1YZ1fU0kg6G-oBQlfjEXKlqD0L-_WCtXfc4motlvgGI_MhEaWm6zhrD1BXf7EfA7hCMQdAc5HoicQpn7yPX1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefffeehffefffdvffeguefgudevtddvueefgeelteefheeljefhtdejtefg
    heelnecuffhomhgrihhnpegsrhgvfidrshhhpdhfihhnkhhprhhojhgvtghtrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoheptggrrhgv
    nhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvght
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1hI8aQOdMKxDP-PSFardfkCIGrJx4nJJRF9hhKOUTn0WbSQ47aN2Tw>
    <xmx:1hI8aUFJnYuOSrI73mxIxoeit7y5rMJgT4WiXaR7H2s4OhJrm3R1fg>
    <xmx:1hI8aWTwsKtSFMBXaYrhc3bZ5w7C5e-b_ZxVyzllXd7NPiaYkUQvAQ>
    <xmx:1hI8aZt6ubxh-beg3rHAk1WPp0krrGuPHDxEi3s-lIGKq5FMCygjRQ>
    <xmx:1hI8aTNqSMD29S8alqsaShE3kM-jnl56B9pbkgHZ17-CrVa1nVaBGj37>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 08:04:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  Git
 List
 <git@vger.kernel.org>,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re* [PATCH] config.mak.uname: use iconv from Homebrew on macOS
In-Reply-To: <3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 12 Dec 2025 10:16:02 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
	<qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
	<1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
	<xmqq7buthgq4.fsf@gitster.g>
	<vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
	<xmqq7buse906.fsf@gitster.g>
	<3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de>
Date: Fri, 12 Dec 2025 22:04:20 +0900
Message-ID: <xmqqms3nc0mj.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> If the latter, perhaps we can say something in the proposed commit
>> log message to explain having both /opt/{homebrew,local}/ is
>> necessary (and why)?
>
> Homebrew uses /opt/homebrew for Apple Silicon and /usr/local for macOS
> Intel (https://docs.brew.sh/Installation).

Yup, that would be perfect.  Concisely explains why /opt/homebrew
and /usr/local are used in the patch.

I presume these are the default for homebrew and users could change
them to what suit their needs, but even then, what you did in your
patch is good; we are merely setting the appropriate defaults, and
those who customize these paths know that they must customize these
paths not just when they install homebrew but when building other
software packages like ours.

> Fink uses /opt/sw
> (https://www.finkproject.org/faq/general.php?phpLang=en#why-sw).

Perhaps they have a symlink or something from /sw to /opt/sw, then,
as our Makefile only talks about /sw and /opt/sw

Thanks.
