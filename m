Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D01C9DF8
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726701810; cv=none; b=QvLfZppkhECvkWoWdQwh6kpywgWTfo+qADA9V7Kb1kSsFlKvoogNo0Eam2RIYXEkE4XiWK4hfJDnQf9hWtkYkW3aSpgH7czUi+ZeULr7Anpbl7t+gvpwTLv9yBxfnCKYLYAT8BeMxGj2TAj2OMWX62a9R0BmeHYpC6SE7/G9XHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726701810; c=relaxed/simple;
	bh=aUS8D7utfuvwDwCxsBfXlR+z6IydWRB78V2oZI3c/Lk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nxbyb5Bimufle2p/+qdzL+jFuKGmOqEmwU6isZEAFYSgfGQ39eJRt5ci6jcVPOQN42iQwwEFhsnsSrgtmXKZJMeR0D9Ev3Mph70Du6wEEgQleX/fOAKoZyX4z+fIYCiOMznLZahGS+ln/Krr4DFLXnbOAWSruBUXZZnva1PvdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=IWfCAI5D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6jcDO6n; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="IWfCAI5D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6jcDO6n"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B342B138023C;
	Wed, 18 Sep 2024 19:23:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Sep 2024 19:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726701805;
	 x=1726788205; bh=aUS8D7utfuvwDwCxsBfXlR+z6IydWRB78V2oZI3c/Lk=; b=
	IWfCAI5D2HMRa3LSjxnQkypUvZVp1Og6eALXwNgXm/X9S4ji1IKTqwQbqzrMrB7k
	t7iVdvYkyHpFQmlaeSgqJsRmMqo9PNbxnQYPXBxaYLS7YBtgivavUQ6WZ1PrxXUW
	ZidqGKZ3d/G6eMjT/E4Fom4eiIo1fI84MFynPINkioY+2tYA5gaitQRG5A2Nghbg
	0L06cK0aw8YK8fiD4Qzj/ilu2O9t4D6lyrpO3QEA8NX7bE7OJ8aSbM4zV8je4IaK
	PQOpUjsIWiySXFKyjNJDWbvlQHWamNIxZuO6y3ZCL0oHbvbdAui/2DMTp6ii4Gt2
	CQz2sVfm1NiRLFoss+AlWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726701805; x=
	1726788205; bh=aUS8D7utfuvwDwCxsBfXlR+z6IydWRB78V2oZI3c/Lk=; b=a
	6jcDO6nCIGsnAt2j25hJWhl+d7/q7Zt8/6BBO+Hek3hPyhOV/CcuoVMJgXCrWsJF
	S/dE7w9IKy/LLhnLqLyGwnt+EmH/REgAfTC+brCy53VycPsomQuUz7U3lND7WwK8
	k0iLAbez0iEmP2wKUQSCQ2VTn2sO6pQgA6T4bNkcISE9fOTenj5iL4bz9seeY6U8
	7TWAcv0nremxpZSAu/d9ConihpgPs1p2lvJ5wtE8onIxMQRIOZUTbBzQTc2jHbX+
	J+d4N0GBFXZNI36ooWg3oeaAcuuIXq9dmv5OfBi5fOK3c4YAVSIvlFH+a/awtTFj
	IP7kAv2sM+xS/Ya2xDBCw==
X-ME-Sender: <xms:7WDrZtyr_KW2GglZOn0y5TkZN_v_7YHAFR5eDPK3nWayFC9J0fi6Iw>
    <xme:7WDrZtTwwi1dF2i7HRPQcGo-pnGHAF4BBg_9qJnl7IVpheZ8kTHubKJNCWN192EUw
    PYmfMAL9-g-E0S6Yw>
X-ME-Received: <xmr:7WDrZnVaL3PB9v3AL5hMZ82HzfA4lcmhGghYy9qKtkQm9v-6wIowTPQ7qvkX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeltddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepfeefgfduveegfeduveevveekieffhfetffeukeff
    fffhgeelueekieffhedtveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:7WDrZvgNLrXAHix-2_GHHU7AFirSvZAQy4T6Jm2zF5oO81dmnPWSzg>
    <xmx:7WDrZvCGDLLUSix__3PjSB7anw_Bzpir9icTCoCHyL053dkd8hXz0A>
    <xmx:7WDrZoKwtxY-zfG1ZV3z2HlJAazblhLZlIIYa8u0LAco-gp_0Qr6CQ>
    <xmx:7WDrZuCEQJtUieH-MZQYricvzwEoW-0DamK6eWxrLmAeN2jVLKRisA>
    <xmx:7WDrZq_PKb9TgLw2Dq4MEMT2i6Gz0K6-uxslkD2JKf1XWQQNRGbPvMlu>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 19:23:23 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 09:23:21 +1000
Message-Id: <D49SPD0WS6X4.20XXOKHPNQNH6@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "karthik nayak" <karthik.188@gmail.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] reftable: graceful concurrent writes
X-Mailer: aerc 0.18.2
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726653185.git.ps@pks.im>
In-Reply-To: <cover.1726653185.git.ps@pks.im>

On Wed Sep 18, 2024 at 7:59 PM AEST, Patrick Steinhardt wrote:
> Hi,
>
> this is the third version of my patch series that implements support for
> graceful concurrent writes with the reftable backend.
>
> There is only a single change compared to v2, namely that we handle `0`
> and `-1` for the lock timeout config. With `0` we fail immediately, with
> `-1` we lock indefinitely. This matches semantics of loose and packed
> ref locking.

I guess you meant "we retry indefinitely" here :D

>
> Thanks!
>
> Patrick

Thanks Patrick, no more comments from me!

Cheers,
James
