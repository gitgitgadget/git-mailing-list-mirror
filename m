Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A792D3756
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227376; cv=none; b=OW9r04J5cMHXqd8XUkl26Qx4z48WZRCEU3pU0pUrv9jOzExFd/30A7pfQyDwobUKTA2A3iJI0PyoS2nk2yQiRNYtzCFm9j4pv4ZoZvzuDiEAMFNTiNMYcqpSZpCkIvy4DdoGv5J3LjPPSKjljPNWw4w6x33asDO7kKhxB5K+irE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227376; c=relaxed/simple;
	bh=WiXTx6HIKIpuKvf8vfQKf9nqyg2SUpo0Mcs+nXLo1Ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KD0E7FlADZC4ZYiTYKi7F+yTUDug5rwgXAWbMCoNdUs+e0GOIb0koDymD98mwDH/0bTASes9Tg71SSITJIaUGhPbtsm5xXQ/GWKa2TFAV8IKt6FWwuQP0+9DYol44cH5IG/40XMoxX1TWkFG8Yv9jxe+rG7YwnXkm+DEk2WrPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mgJiHk1P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U0tVKYT8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mgJiHk1P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0tVKYT8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EB945EC019E;
	Thu, 18 Sep 2025 16:29:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 18 Sep 2025 16:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758227373; x=1758313773; bh=WiXTx6HIKI
	puKvf8vfQKf9nqyg2SUpo0Mcs+nXLo1Ng=; b=mgJiHk1PKvpDynMMg7ZwWAEAif
	Z6YtrBpm8TPQWClKSC8E3KxzQWzOL11waiOUT1/oAyuNvznNalEZfPVGawkhHl12
	keax78on7OI99rSjNw8xmAv07s1rUe+ckCZtgSfU0HG1dHN5N2BpBrONunzMGci0
	+TOGnw3780vt2lC2wtT5bLtHHMjE9QLbSN4J+wswPWOgVLRhLZBMIq4O1jIDWU6h
	kcYM/GeVpwnj24sQjHjJMEl9G7amhrETXmnza0773S2QXkZVf+mA/xvOzQPHH9Aq
	ao/RRNh5AlkIlXeI1v1FJvxGKPTg34lrMeIU6en03bK3CppQgh0lXQRleFYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758227373; x=1758313773; bh=WiXTx6HIKIpuKvf8vfQKf9nqyg2SUpo0Mcs
	+nXLo1Ng=; b=U0tVKYT8GxE6PvFv184rkY4KjVH6l7wgXSZug/kg2nyi4j4rn7M
	fP2xQdvlsYMdk7Tvxt80Dyl1Ty5KPkRUHIdimU5X8BMsxSAl5WfgbugzvAtggNPT
	yHeFsrRDxqBAGxf26yDCy+zuegW9fwrIP5BGPE8OsRmN0JRTl8esBvfDMHiuBg2/
	tI5o4PAZLavKSFitGS5feWR9qfP3qK9lL6T1IcBDLW/Ul/SDmz4ccJ399uPRgmOd
	uQjIEkQ8eEtyYtprYARMFiQvRwlowPw35gWc+nAIqEnHn1tZv0iaETIoy5q/6LRv
	j52/pb4GumPRkZ9nUaMkclU3BB6JtWDC99w==
X-ME-Sender: <xms:rWvMaApZDVVt22aU-KFKSHjLpZdsHlNOXiF-IuIT6Vd6LMUQIglWdw>
    <xme:rWvMaCJ4-JhTJ2gIBBaYt37kLKRnFPhWuXcD_BFZI4tXnSTa4aGu52rj9-l8tQR-H
    SCRP_O_8nrkEOq0PA>
X-ME-Received: <xmr:rWvMaLrcsh7mq7gv745mtZ1vB-tcbQ6dMpHoHfZR8mMSkaABQHADlNJv4GX9SkDUK5TQ1Bo71xItT97ElEs1dK91TEfcPq_NDT9vMNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rWvMaCzUBMFQyOd1UVO0daogVsErMHZ3MqDBCCdpRNAkR-Ka6Pxqbg>
    <xmx:rWvMaHM4OkorPx3rH7QNFCerI0mHfkpW44ksHyo0HXBAS3SYenyASQ>
    <xmx:rWvMaP6ivgOU_5PIKsJNtOg3XwvmG1AKgiWxSBy3c5E2lJdjRyUT0g>
    <xmx:rWvMaInbNFz6APB3mx7ptg8zT_DyknX2rKQbToi5t542ToxntSedKQ>
    <xmx:rWvMaKKEaQ_0B48w9PmC49L9Cehmz18BXE1Qc_vLMaDewU1rhtbnMo0_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 16:29:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [QUESTION] how to find options set by scalar?
In-Reply-To: <evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
	(Matthew Hughes's message of "Thu, 18 Sep 2025 20:32:37 +0100")
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
	<aMkVqNbdgxqBJ9K4@pks.im>
	<evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
Date: Thu, 18 Sep 2025 13:29:32 -0700
Message-ID: <xmqqikhf7bdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Hughes <matthewhughes934@gmail.com> writes:

> I was also looking through the list of config options (within
> `set_recommended_config`) and thought it might also be useful to comment why
> each those settings are recommended in the context of working within a large
> repository.

That would be ultra useful.
