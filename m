Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574F1FC7
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544254; cv=none; b=uSELJ4FlIp/xulEil5knGiZxj6GCN0EhALTYWUc08tCYQF+6sNiceF5D63+LIBvzP2u6aeF6/YdzBIzU9+ymcd0S3BXQ5PqccKOI+6pf0/JWwjdLF0+VMiVtLmEI1bVWDq4lGqJrbQEwyiAPE0sgoIXe8y15TqN+0UAxsNHva3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544254; c=relaxed/simple;
	bh=ekjt/iMF8WlL2MaWCgjTx7xHJfZPAHUV//TH6xpMnZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZje73oARgmxZDQMRckFmXp46VG6h1B689KrOpjWfALNTOrmsflH0D2gmRYMv4RvLntnrDWFxC0aenACx1qpq26lOfincDK++8uRe8sMWkLKO1PiEUOw4LNqHTkFx5dImE15ihj8LUKleWlA6DeOIEMO8rR5yqyK+mtF+hDRHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eBU9ItZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRPX43t5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eBU9ItZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRPX43t5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D64D1D000CD;
	Mon, 11 May 2026 20:04:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 20:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778544251; x=1778630651; bh=Eu42NkgXCS
	OQefyzU0u2LqfckPEjz+Ut1AY4HKMG0kI=; b=eBU9ItZb2mVw0DwnxW1lhtT9g4
	Iglh78N13838TVdj5TljiDXCNOzLXwxBM55zHSrp69M7snUn5G/n+lDokzC88Ych
	JmKr6BN/hKAD3TKA7cIzaiMRXD2kagBBCX45ljZD9cohxqQLGOMOGRWLkVh9T+qC
	f1BxeF2aDul4vsHZbEPprFdi/jQDSV9YbMZpHtYBxg8JFQVhL78oaWWAoOliCDFv
	D3BLYrxxU9EakyN8ZSnv1TuwwHSsXS0icwM6GIazmYD3/SMJ+1Helgk+EejDFmgr
	cyk7Q7T+WGOg5KxvPsQQFkmHIqxWt1hUTZNJM3bqEwcAqZam0X4tP4WcTcag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778544251; x=1778630651; bh=Eu42NkgXCSOQefyzU0u2LqfckPEjz+Ut1AY
	4HKMG0kI=; b=KRPX43t5JKZxJ9/oyZFtGtO/JftY8lyDVL7BWkdtJOyPKpN7w97
	8J/e74Iq0vcsBrI4XITopMg30+KrTk8BqLsGpdLlIBf7Soqy/GikNvrXaY7PHpLS
	qIvdoMWrcSMhwLoS99I39f55xpEA8FyTzJ4LXmjPLp18OWSKLTCP216GsuaBwbgA
	WoClPtPhSpXh16VQ/JbuFcjyOER/Vb/BIQkEtzgaV16i58ijjzniUt7udhmrHGiA
	1szZ2TT1q+iYXAG3les2/xU4YzPu+lgNVgBLqZn0mfegz0hkPuaEOzvDNsoUyfi4
	AkCEMVWUWrIoxf1A+JJgm4IQRR+pmFzERow==
X-ME-Sender: <xms:e24Caum_Dl_XiqdUGXQf4nHwdvr23r6qx8TnHo1SF5c0LUY4_Ejeiw>
    <xme:e24CaibzSiqK3Q7UjxtnItk82SIUxinXF9E6j2st0-m_cfHuvFLdfUZ7yoca-FmmP
    36-0dmXDuou1bD5wvjhJ6NH85tMz1aoMpW7B6jipb_dJAxt2jrQ>
X-ME-Received: <xmr:e24CahHkC-dYleMlEWy_cCiHp4r1x7aJT_CmITjbIjomjfTY_czCclLSmoLGoFTeP3mrZLJPQPh_02vARnhtwQB_K0p3rutAPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhgrvhhivghrsggrshhsihesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggsrhgrhhgrmhgr
    uggvkhhunhhlvgehtdesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvg
    gsrdguvgdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:e24CapZiGD288XAhfYgiZv0_9d_hld7uKnkwc1FLdzESkaCYqbxa9g>
    <xmx:e24CatyVWj7M3kpWROTfZwo_4UpUyv27vnZlZ4YptyEVBcFeI9EezQ>
    <xmx:e24CajTuB7f547yXmrBbE8lzjLrkRElmqtjpfuB1yZeKxCGUf4NvKw>
    <xmx:e24CaiKNE1IJUO3S4gO6s70Vil4a_ujNhDoSafZWOTjg-PaXER93rA>
    <xmx:e24Can34SssO0sIT6k1oWiRki104so0cpj0iZB7kKLdn9HZv1GFnEhS9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 20:04:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Javier Bassi
 <javierbassi@gmail.com>,  git@vger.kernel.org,  Abraham Samuel Adekunle
 <abrahamadekunle50@gmail.com>,  Rene Scharfe <l.s.r@web.de>,  Elijah
 Newren <newren@gmail.com>,  Ruben Justo <rjusto@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with
 --word-diff
In-Reply-To: <CALnO6CCR9bQ71LR_buEAzX4UcR4sERnaVLc6_19sJUfXyi-HPA@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 11 May 2026 15:16:48 -0400")
References: <20260506235459.529862-1-javierbassi@gmail.com>
	<e640ac2d-9e46-4f1e-9aef-deac80c65361@gmail.com>
	<CALnO6CCsOMyLxAhGW10L4duaahUORwedfmtdpY3zDGpQcZoP2Q@mail.gmail.com>
	<xmqqqznix0ko.fsf@gitster.g>
	<CALnO6CCR9bQ71LR_buEAzX4UcR4sERnaVLc6_19sJUfXyi-HPA@mail.gmail.com>
Date: Tue, 12 May 2026 09:04:10 +0900
Message-ID: <xmqqo6ilqyrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> >      :show <opts>
> ...
> - ":" is an exception to single-key mode and always allows more text
> to compose a longer-form "command". The first command could be "print"
> which takes options of this kind.
>
> Since ":" would be new, exempting it from single-key mode shouldn't be
> too jarring I guess.

OK.  And we can use ':blah' to rarely used actions and give them
descriptive names.  Makes sense.  word-diff sounds like a good
candidate but it is not immediately obvious to me if machinery to
set up the "colon is special and handles longhand commands with
possible arguments" is worth doing.
