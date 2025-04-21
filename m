Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9A42A82
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267442; cv=none; b=JKhgyQN/H8b0pdm4r/njpakdZvuyjD1bE8ara6vRqvwj/Ap+X8Bmu3nWhQrcHB+KK48SwL7NiDVvTD1ySQCh7CvaI24s2YBT47CxuOSvU7OJDmK07Xnd36tzbR+MT63YxCDVyZkRvHxm0rtfg4vnTLmtEiHFO3z/4Cfsv8/Lquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267442; c=relaxed/simple;
	bh=6Mc7U10uCLeIeizmk4fqlfQ4nA7Ckgu5T9gHwtL41UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLkx6D1oMg5u2IgliORBDATxo1BN8bZv3XUNNP8NJBTwez3ZrANJ7APgFlMoqW/aTGALcpk+jbQWC6DjP3mCqf6xDf/uReUeXv1QDWXJPlDdKC6p3AV2djld0PIs0aIJMICDg+6ynPFpxX9UibvM744ZkFEqwRmwlBFsmpxZkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ei7cx1QR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ciW35Yya; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ei7cx1QR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ciW35Yya"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 901A31140197;
	Mon, 21 Apr 2025 16:30:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 21 Apr 2025 16:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1745267438;
	 x=1745353838; bh=lF3EE58Sqg2RzAr0RWWp25XLKXLOlQzhvAr8PXLXWQA=; b=
	Ei7cx1QRjasgPkkVsGDtgLgOZjm5/65jjYKYMTXhwc+lflvASV4znB9uFFmqehVt
	lewTqbO5oujdVd0AGgODorm5ftr4jqwXqNTjDR5B+EY+Lrt8LEfSCuWpdteErHl6
	rVH20ZBDzsSvdybrEObP797auufPT62qDwFvjtg2V+ZbMIfpzmZx7M4dkfSDs7zj
	UyV6DEJJ850yF7i/y5zqoEQef475FfwXLWh0oCbi7L6ZSfwUlNu8WZB3xUK+4nKY
	/AUu+PxfEFlA4sxhOExi6mtlI9Mj9awpH1eKgT4Ghnl2KvIWke2xgNJybHanW0KY
	mIakv1mJYs/Nrvs/BlrALA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745267438; x=
	1745353838; bh=lF3EE58Sqg2RzAr0RWWp25XLKXLOlQzhvAr8PXLXWQA=; b=c
	iW35Yya0UYuSM8UlZJDh8Km2S1fKO3muBl1w+VMpytu/ITRjBmv7y2WipLduIyNR
	Xjm8JBs+DKEowNTr3Q8pHLYKKI4J63b96VAilgkdte39Ri42FMsvqlr8q8IRIOhB
	cPTbNzwxv9UsRO092OmCSaDeS1G7RgJYjBQE//6Zu4Inhc4JD1IOe1fiKiP2T02E
	CQ4ixPTD1+7OaocDodrh/tom8bHEF6ou6yjG1VH3xcwuTWWcLDYIOVRFFkQMm0Pa
	Ck8uALKzou/Ro6A8N1eQMn6nlyqO1appVHpP8DCFy5yi/1kh/aZeFMaOVaQWAvnp
	jWraGFsC/C5g2zZRISwRQ==
X-ME-Sender: <xms:7aoGaCUTC-WNXQvoMJ8fNHPVgWNWvMEG9pJHVg_uqFmTiLKbiKDvVg>
    <xme:7aoGaOmA_Hxy1L5XW0S5AGJ1sZDVro3Y5GOKVNZcVMZlGF7x3Wa8NdedMblhF3mzh
    x0eu9UP4A0B2ZDYSg>
X-ME-Received: <xmr:7aoGaGaRgO-OGUAu-9yrQG-HotpVztC1XlzvWE_Ta5Rn6jjLJX9C02b1xN3rndFgPgBr7LIoqlTYJNejTKmM3v83fw7BBDZtsNYq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedukeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrggsihhjrg
    gtiihlvgifvghlihesnhgrsghijhgrtgiilhgvfigvlhhirdighiiipdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehglhgvnhgtsg
    iisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7qoGaJX4Sj-zrYt5kuIgP2zdm8xnhfsgpLmBulFoxqj0DkFDLjhS0w>
    <xmx:7qoGaMl54em53BxCNA2UpISbfZJ_fd_L3dnRaR1DJcH83qVuoklqsw>
    <xmx:7qoGaOcMnjzdbGIXoz1fl4juE3lTbyeelgx24kCB1lheAJc7EZUQtg>
    <xmx:7qoGaOGZdHjBa0wG7xVJZ5Y0B5NMOFHo9Zqx0XMynuZfKd3aYJLyNQ>
    <xmx:7qoGaNtm0GvClOktWhQsJZmkeTTTUJwr1t5w1wXT7jRP1TAvjoQwr1z7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 16:30:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  Elijah Newren <newren@gmail.com>,  Glen
 Choo <glencbz@gmail.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Make remaining usage strings and string tables const
In-Reply-To: <daj53eijkqzsjy5cvuxchea4qm3pbiu673ehetihfffyvwzhgs@tarta.nabijaczleweli.xyz>
	("Ahelenia =?utf-8?Q?Ziemia=C5=84ska=22's?= message of "Mon, 21 Apr 2025
 10:56:13 +0200")
References: <daj53eijkqzsjy5cvuxchea4qm3pbiu673ehetihfffyvwzhgs@tarta.nabijaczleweli.xyz>
Date: Mon, 21 Apr 2025 13:30:36 -0700
Message-ID: <xmqqv7qx5kb7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz> writes:

> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---

I've looked at these changes (I wouldn't claim with fine toothed
comb, though) and they looked correct.  Most of the changes are to
ensure not just the strings are not writable through the pointers in
the arrays but the arrays themselves cannot be modified to hold
pionters that point elsewhere.

Functions like parse_revision_opt() declare their parameter for the
usage string array as

	const char *const usagestr[]

but that merely promises to the caller that the function would not
touch the strings or the pointers in the incoming array, so the
callers declaring the array they pass, like blame_opt_usage[] here,

> -static const char *blame_opt_usage[] = {
> +static const char *const blame_opt_usage[] = {
>  	blame_usage,
>  	"",
>  	N_("<rev-opts> are documented in git-rev-list(1)"),
>  	NULL
>  };

much looser to allow swapping the pointers in the array is *not* a
problem per-se, but as long as the compiler would not barf after
this patch, we know these callers that use these arrays are not
doing such mutations to these arrays themselves, so it is good.

Thanks.
