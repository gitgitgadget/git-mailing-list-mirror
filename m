Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCC3594A
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120635; cv=none; b=NkXitR6fow7GG5Apzy8rS93Z9bgqYkK1P5Q5sndGE5yzgh0WGu/06JUnPYMFIQvep2kIIk9JyYpblqjkiyMxaGY+xbPMJev5dEa/1PvEPmvzHuwhAG/5U/r5DYoLOO0JxcqTwxpMwy3/QB6mN/TRwWIFNCVKvn28CS5/dceRTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120635; c=relaxed/simple;
	bh=oQ3bbauwYFEPRrY0r4VGLrM56mxiD2WcBP8j8wHTETY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGXKzCZK3AtryYsGOhEz+EWiXW0eTMuxD5I0EsUT9e+2Hvl0/PyIgIokC1odRnuH1cUhbrthgj8uMtcHslhTVlH7lz3NFLgnwP8xdrsscguKrDBWcT4wE2poXH3zwcSp1mvFjbwL5sTSIgCWEHeBzWde/J1sz6Ytpxcw2buu7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ElJSJHH/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJiHM3Tq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ElJSJHH/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJiHM3Tq"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id AD8D01D0014D;
	Fri, 10 Oct 2025 14:23:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 14:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760120632;
	 x=1760207032; bh=MLzctVGPH2KQs+NASyJufOzgadSav+eOPJ3jUdujGHo=; b=
	ElJSJHH/2mE/SiICR+QDpJZE4H/HTkWHEbJ0LQldictPuO9/MFG2ef0zfOr1AnK1
	GIBzNRXi/b3iiqINk6LAUuDUBP/t3O0syBFWWkjEmv/Og14GTSJKNZL4RU7f7KWt
	x8fs3SeiYfsC6HDM6RI2FLFmGQkNA7KRjguD5EPNDmctva243he7OcgYKzu2EeZQ
	Li3zgmDxpcwHBv3jO6HYYPYrtTnOaOPDmIkLN84cxs/1P9m/5ZgYKvSREzk3R5UK
	nm+o96Y51VRHaz4LA/ZUh0cNzlL84b7uaGbJxR3WYttx8GV/4gJMS7QlsJTPmUCK
	7ofSub2sv4PBWXrT6jVsyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760120632; x=
	1760207032; bh=MLzctVGPH2KQs+NASyJufOzgadSav+eOPJ3jUdujGHo=; b=A
	JiHM3Tq1PsqCPC9bWWMCtHuFmzQ6+71EaVYDXRUxJvQ1NKpUbt6ga6D2v6kDsXwi
	hxcuZR3g/kNxct0CuptQCoooYc6X3BECMVlQpJa6OykCs+El73+Mc33NJjeYcC0n
	EGHxXZPRn4ABGqyQOQBVCpKLUuUs8BpyuIcqdSJjPr1Y8gE70DjDZxZU1S7eZQ5o
	q80da0Lanvz8hxSNhIseSyntfyXJQxLcoSO5lFrxamTnf1V9tqqtvaI0Z7G3T3Ay
	pJEgb4cRORJIZ1GD/B1RGfX/aqVRRYLrtxnIwwkYA59H2AG00YiASbHmkK2MU3oX
	lqUH1arlVZyPXXZZZGQSQ==
X-ME-Sender: <xms:OE_paI2L0SNGAeUAMupvbrFNXvNFIUBQJKOhe9lgMfLssl250LWGkQ>
    <xme:OE_paJ__wYob-3jbXdzHVDP9BH2H7aKyIR-WsjKWzLNC1qgGKlOUREihha5B_DoR5
    brgBzFIFGEPUyc-oL0p7uFeewnNR9FlE-WExhLyTh5mJjgEbFU_eg>
X-ME-Received: <xmr:OE_paJND6Ysm4csQvYC6cXGhUJqlNuK5Va7FM5ydb_z0msewdNQL8U3A_h9QStpIYt0m2D4YiqjhUZ_XfCLQMjm3eQQSLUIEan6->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OE_paNcBLXD-W7BpVVKY41_C4hqKne-bDCOSoNFJPILRJ4cXMb3heg>
    <xmx:OE_paIWvGozlZbcM8B--6hJcSxfCOwHwF-KwCMzRxQoQPBmYwThOwg>
    <xmx:OE_paFiTpslg9FnM1JlHoKpOfwufpA_eD_c3Pf_1_WOEtOBj1O-Wag>
    <xmx:OE_paH8Up_8wWwmBZn7LxYtmbIJ7VUkeRDHehbrD77lAwpAC13Fwfg>
    <xmx:OE_paArn7G4tDNFDEsO9_-7NGoAbEBF_IQ60EGEhp3bWBa0b2OmWCKXU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 14:23:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: convert git-stash.adoc to synopis style
In-Reply-To: <5929880.DvuYhMxLoT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 10 Oct 2025 19:43:17 +0200")
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
	<bb0f530b-96f3-4655-8448-1d322413cd1f@free.fr>
	<xmqqsefqah44.fsf@gitster.g> <5929880.DvuYhMxLoT@cayenne>
Date: Fri, 10 Oct 2025 11:23:50 -0700
Message-ID: <xmqqh5w68vk9.fsf@gitster.g>
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

>> > Wil try and reroll.
>> 
>> This is already in 'next', isn't it, though?
>
> That's fine. I couldn't come up with a substitution scheme that would work 
> correctly for both asciidoc.py and asciidoctor.
>
> So let's just let this patch as it is and recall that attributes are not a 
> panacea.

OK.  Let me make sure that I did not mark the topic as "on hold".

Thanks.
