Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D637D12D
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172074; cv=none; b=DaT+9+ATLN8z4VPfea7cwDG6v0XxhF9f4zlJFNih7nV+4R7oQRWoeNjPW6zG+yjFECw2a06KCCTPeP1EbxvVARzIMyDhN8NhuhpC0u5wHZyA5i35TOLUlGEOUC76oI55fYVnqXrB69Jl+cdWb+XUbbkn24vUCOH1BWgWGAmqzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172074; c=relaxed/simple;
	bh=BaAio2/RNEKJ1OZgXfFxZb+t4U5uuaiUUdF/gLDy0A8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kD33MllC3KEFGvejkUDagvEfhYQiI7ss/jM5ZK5DH+tz8QvSHefuyeFLOD8Q+P23Svc/JuRIr9r9wmjkwUxiGKy0k+0yOS83jXLQ4Tv1VSgDxPTtafeFUXezydscsxnfaAF2uFC9b044SrNLfbkqJ/osTbozXd+a9nnSa9L3bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sT580wEq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jWJ1waeq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sT580wEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jWJ1waeq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E88D1D000FD;
	Tue, 19 May 2026 02:27:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 02:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779172071; x=1779258471; bh=vM5k2uciKz
	GUthwh7St93mwDB51VJZ4qnfT7AH00uik=; b=sT580wEqlyEd2VapTeZQuYPzTH
	KmmpINztyS7RRFtYUBXKzAj5DJpAkVPDQSo/D1dTym87rtua1a3b/oLCMhFRUdef
	+3zDOANXzlT1Bcub1hC6A0Hp1niaLvphdtrN6ecKTAqaScJAGWDaeeYpBMwxkYeh
	3cVfsL+Ccwl3djuISeMBJdGWoUvjivgEnhFAZ1euFTYE09KrpjmBUvkjGmnkSugm
	IM2gk7fJj6rB49Gu6nXtqYHOORW+3mmEWUzJLsv0NFx3hI9BztccdlJGmJ2fL/sC
	Ahe3d9kIPOz+rzj1h4V0o96VaIGwt6LzUvM04ZngbdAQX09E2MTTYrnOmMIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779172071; x=1779258471; bh=vM5k2uciKzGUthwh7St93mwDB51VJZ4qnfT
	7AH00uik=; b=jWJ1waeq67OmHApOJ8skrDa2i/etZ5clIke0NY4O7aobdaURewz
	mibIEZqEXih6bN+vcxs5ropD5ye/1zXTR3VOKgw4g7lepzuqoZWb3ulhnbtryron
	1YwhnuXbYsFvPgEUNXIWtsDouWaYKjUSRN8zqJ4mldxz7N3axMQwaybJ30oWuLFE
	SbbNiat8tLhx6NJenXoOE6kPb+4T7uvmtiZp2COHKzWZPdHdt0ObrlOiJJi2XpGs
	Sz/XUT0w6xhEOMRs5kc5eMoOLa2S0ohnA1uRkQzjGAE0q3TpeFb4uRhPrqhZcmzr
	e3RkIQt1feqiKODyfRy+vIdg4pyf2C3E4KQ==
X-ME-Sender: <xms:5gIMalvzRWMnLVlznFQdDGdQTzKYBq1QDg_BlxDpc30KmtOLoZQQ_A>
    <xme:5gIMarBGHNcTGY2B0ZGJ8kxJnHvPDk3JGfmBAYyjpMrw9DfI8E-f_y-FUCVM8OT9N
    zESeOyk-fP8EbHP1WqD57wWGiDNSyENE2HNOzc151ACPkavDW16cNg>
X-ME-Received: <xmr:5gIMatNxcjwBjDr8b1kj5Tm3QQkf72vYsQHemEz-uUYlKR4DXI5ijMHVSW1ZYzChwBoPax9nALxUrcymkcpQvVeWuAUnDVSi8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hrpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhn
    rdguvghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgv
    khesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5gIMajAK96d9CfxudNgcuzqOXAc1odLYB2MvKjeOWvBV08BCRJowow>
    <xmx:5gIMam5OtNeyU-5F72-Eap2749nQjUldmyti4h46zZVVN7D6kAYA8w>
    <xmx:5gIMal6wpmCbAVjN66s9IUl8cfoJKJ-9FpKmI2hdWg_OzqeSmsb1XA>
    <xmx:5gIMagT11ZeWSNnScz113zWN-rSuxbIkSM9Fz9odMhcTvaOa8OcyTQ>
    <xmx:5wIMaiyPVpKMamINCbqFdrYONkcne45Z3dHz8JsNHya1C3uQuAHU3e1h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 02:27:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v7] revision.c: implement --max-count-oldest
In-Reply-To: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
	(Mirko Faina's message of "Sat, 16 May 2026 01:29:55 +0200")
References: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
	<463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
Date: Tue, 19 May 2026 15:27:49 +0900
Message-ID: <xmqqse7n7w2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> +		 * graph_update() as it doesn't do the actualy printing, we'd

"actually"?

