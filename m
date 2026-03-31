Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C1280CC1
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928302; cv=none; b=K9BG3KgNaly0Nh+dbjEl6wIUb/BMPpMEjILzqFdrqLq52r2lQTXiuKBtFYOAeHue1DboisLzcp9ROCL2VxZhM037y1hElGUQpxubxTHDDjZAoWFX6JV2ilr8ppstpNgTiTNi+3ITmq0L89SlzP9oHEEDMEFMXekMX7maTeD8bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928302; c=relaxed/simple;
	bh=su+PjIfYgfgUd9zmLoPzrek4ranGQs/q8Ml9zSV+Los=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBuR1yCjXKaJQrpc6LDvxhwFvhBM+ZA9aTTLMmpWiPyxABdtRcALFBdw9qQPp1hUL+16YSA1+7XKid345buWhJYPyFhkP1jsRQialjNXnP9tT94Z8FKERpKkyi/beya6ZmABtTaLfGHBZ/MYCuCu2yOXV7KJ3kJqo4JKWBo29PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cIwHMRFf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N9a+Y/zp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cIwHMRFf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N9a+Y/zp"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C4CD91D0028B;
	Mon, 30 Mar 2026 23:38:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 23:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774928299; x=1775014699; bh=V8E9omsAlH
	OYNeCTm5p+Q/mb+/EVYfMsu7HGe7qu1Uk=; b=cIwHMRFfZPbrR5/gfpsnsbZWjq
	kUmJxFEqW6AobuQx2FzvCbWRjJCBNcAolzx092l42XPQHCeZkq6m5DwbAb3gw4Dz
	MK+Fh3ik35DujWkmruNS8LkEwV1hOMsW3Kyw+BGj2bScclkyYM0d1oBxnZ6ge59y
	nB5suoJweIC78cB2d75uAuEcLuOv2JEGsJSHnOVQngzbxnr/Z/XoHMhkqpSqgWSO
	csCS54mc38zxdY4WokjOQYNtqskWymI9Xb2PcAwJkfN/lx9Xvqr92X0V45gmO8u2
	Le9xvLGr8+L7RvVEQzkiVSEDjvVeNbIoblsVouSxWje283+GZTQjxgpwpXHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774928299; x=1775014699; bh=V8E9omsAlHOYNeCTm5p+Q/mb+/EVYfMsu7H
	Ge7qu1Uk=; b=N9a+Y/zpzVYO+ekUPebA9ZsjCv3kGX2DzKXm7qNiCkS4W0UvWCD
	AHtzZojcrqh2FmkBHUK8B9nB5BZ6KinnFPDy8R6C2bXajIMd538wxVxmxDz/2ybG
	dLnv3VjISKchzwfPchdJQHKTG3mjzC6QU7VuVQULYAJkBobuzTJ3ujbiF/Mpqee6
	vxDZKzut0TvIeO4EP3YKHaU8ojnGMpbJOJ8AKt1BzP8I98jAT/8NspOiXfakwdH7
	03vp5boTbRsNTgnKECRnb3eHA0MrJUwEEM4YxQuxGDnDRzpplrS1Hb0Rl2qZvgl3
	Bf1GrTvOiP5iw3Ln4PJaaYepdrVrYAZfafw==
X-ME-Sender: <xms:qkHLaRvMH0Vsp-X2pFWsyoqIJY8VcHCWSe2gh7bpinVn0_5i2HIdGA>
    <xme:qkHLaSD5X-m4KiLz0ADAFFKbsyKzyIGfYhcvFtwO7-0hwPX0fjx3uxLQgmdC_-KTx
    rAaM9WIQB2Ni4QC_S3SjgdcNtsLA5dk0RKSXGWHAxcDQNSdv5VMpg>
X-ME-Received: <xmr:qkHLaUbd2htFr7MFu51sb4OiTjAnpbGvxo-tj5ekumzyojGaigzvU66IsP9zKhWuK33DntcYDNr8I4_CaBKQhuHM8d9I7AU-pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghshheskhgrmhgsrghnrg
    hrihgrrdhorhhgpdhrtghpthhtohepmhhikhgvlhdrfhhorhgtrggurgesghhmrghilhdr
    tghomhdprhgtphhtthhopehrrghlfhdrthhhihgvlhhofiesghhmrghilhdrtghomhdprh
    gtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsrghgrghs
    ughothhmvgesghhmrghilhdrtghomhdprhgtphhtthhopegujhhmtddtnhesmhgrihhlrd
    hruh
X-ME-Proxy: <xmx:qkHLaU96OOOYm3QmjwhNJ5wKac8T5_XZgPKcttPwnE6GgkBz6_O8ag>
    <xmx:qkHLaYiVFNTRcXZWYIPpiS5a9WnoOc4ugAf-12aFVME-P3cMOEl1Kw>
    <xmx:qkHLafgYAnSa0uymP7_Q8hb5zeHuiqyYq3jj3ENA8DIBDV_4KbbdTA>
    <xmx:qkHLaW6N79G84M8NWoCNIEInvqT2n0AKAt2KyRh2KAhV2DFzzII7mg>
    <xmx:q0HLabLKCZ0lpJcddoRtH-tVWgjd2fUIzPVliNFXwLU3AeMlA2kd6Gld>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 23:38:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  Git List <git@vger.kernel.org>,
  Alexander Shopov <ash@kambanaria.org>,  Mikel Forcada
 <mikel.forcada@gmail.com>,  Ralf Thielow <ralf.thielow@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,  Dimitriy Ryazantcev <DJm00n@mail.ru>,  Peter
 Krefting <peter@softwolves.pp.se>,  Emir SARI <bitigchi@me.com>,  Arkadii
 Yakovets <ark@cho.red>,  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?=
 <newcomerminecraft@gmail.com>,  Teng
 Long <dyroneteng@gmail.com>,  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v4 0/5] docs(l10n): AI agent instructions and workflow
 improvements
In-Reply-To: <CANYiYbFpexxr8hihAQA_v6Gr+mvxS=1GKToDVf-O2B9XXwEWaA@mail.gmail.com>
	(Jiang Xin's message of "Tue, 31 Mar 2026 08:52:46 +0800")
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
	<cover.1773704908.git.worldhello.net@gmail.com>
	<CANYiYbFpexxr8hihAQA_v6Gr+mvxS=1GKToDVf-O2B9XXwEWaA@mail.gmail.com>
Date: Mon, 30 Mar 2026 20:38:16 -0700
Message-ID: <xmqqfr5g4qjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> The l10n window for Git 2.54 will open soon. I will merge at least
> patch 1/5 ("l10n: add .gitattributes to simplify location filtering")
> into my tree. The new GitHub Actions workflow already supports checks
> based on the filter attribute.
>
> As for patches 2/5 through 5/5, would they also be appropriate to
> merge during this l10n window?

Up to you.  I didn't find anything questionable in these patches,
but the area the patches touch is in your bailiwick and ultimately
it is your call.


