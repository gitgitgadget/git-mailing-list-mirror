Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97E248886
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986784; cv=none; b=qCMklraS8mFs1PFalv0lQBTMLgCLSMs0BlmDkEK8O4AP6RfFGNFmljyavczDl8ow95rSHBkoX2bYBZ5plR4QFstx2ViAK+NJT+7FF3NMRUdzIJWdhKehoZkcdOHYcqCuMPAYrLO6svICBARb8maPydUdEBVmkGHZ8+IFSSbLlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986784; c=relaxed/simple;
	bh=LdXXmv/QHUO2brz8EhfE1I0K8fKMq8PRre9trE2FFnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gaP1bye0WrFXp8r990MrNO7LyxZFIL2t7XkwsiMinqyMD5PrUdQ0T8KwPL4LVlck97ox8uz6jPCxYnwUcUkXrt9ybbp0HwVPjT+8w+tPgSZ4vZWfukwQOLTG/oHz32x3DJjeoHhzDAeyKe1YR4YKb7fCa/T4NEZcFfJbzHkOVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NfsCvQxv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2uOawpoA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NfsCvQxv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2uOawpoA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 809721400243;
	Fri, 20 Mar 2026 02:06:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 02:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773986782; x=1774073182; bh=dnUuy0lqPv
	VLOaPmWQlLFGR/apaQkcphKFOiXqm9k9Y=; b=NfsCvQxvPbYUMs/kWbLoyHFjAZ
	zB3m4WcPEgU9beQaNP78yI8pUM+Dlk8NfPRGZAIl11eBd/O+RWHjH8aqJe93o+ku
	PZvS8BdWLKAweTT2LBCPk1saR/NEiQwknKl3+ioJwxntN69iXnf2mk6aZQkJ1p0N
	UEvJ6UVJ+3Q/HdOho68/e/SgCdxq5Q4UXD6wXNrs8FEH0WCKfiqS7izKybFiTsQt
	gmv+Z/qpmGNNxlX4o+9GQoXUnxB+YG1GhWTY8wx/VAH2vXcsjC8ZAx6n0wcLb/az
	iQeT6xT7Csdpn6GKdWVShF0vWRNrLAFbcrMj8p7+ToUFM9prv40zoaz4ps7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773986782; x=1774073182; bh=dnUuy0lqPvVLOaPmWQlLFGR/apaQkcphKFO
	iXqm9k9Y=; b=2uOawpoAfdzbex4H8xduBgI/e2JTGD8IkG3KbkomHKF9kaG/PK6
	aZfwLtS8RJdBy4tb0siAzC6IgaxJ3GCt8wzB2hX9vdllcCDzn3jzxVgattdPtZoP
	FWRWhCBuZ+kgpbZMvEshNpZpOtmBEvFpdegZqWjhkGdYPqVub1K1I7XO8pW9eWEV
	jhKLriduu/D4Z4RozPtMaLCSld4IoVzD4jqblANOPjZdgp2OOVZe/uthwP/VZSI9
	DX9e6Pvd438zTz7aGSxisSP7ZeNMuZWcqcBEsZARIrNF3R4UQnVucDSQj/2pVUmP
	epqJbt4k0pozJZhKCl8DoueV2tmcHOBeNvw==
X-ME-Sender: <xms:3uO8aTJhrLGzUKCFrozxm58Uha5foOLV8-GHgr6cgSol-fr1MzVfaQ>
    <xme:3uO8aelFoi3EBHvK_wEfzlUA2Z25NKEwKfCUfmn8lO5qqP2q1BAgzBKgEhunz9xoz
    uNBOtp_MM59avYCrJMi63LWzh178gFFLCC5j-OQxJzoJNUU1uIruA>
X-ME-Received: <xmr:3uO8aZEiMe4GdttpsYlhrtE7FBL4POPJPN-lwpb4lqHY64be7IpD_LAT-YI1OZYIlYH-VHdIYznucaGSaAWBXi7CZlK0EhKwEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedunecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3uO8aWGBcBSeYX5m13qY2VTyjcXXb5y2va6UDR43q_uVUPwV-vNjcA>
    <xmx:3uO8aeO38ZWaGLpvr5HQZe04H3bu6qSfEHtLL5CowgnZrMr5UMiZcw>
    <xmx:3uO8adG-9mxGR-jeOu685Jo6tVwgASUU7KMJdm86ICbWmvI_TTpCfg>
    <xmx:3uO8adMO_qjhm3a6edGC4OCC6jZMwqEQOByFpzIIU7hsH65y8ywOSw>
    <xmx:3uO8adUytf0bFTS3OdaS2p6ErsEmeLT1jV0wgMcoxpWRFhl5h-7JHvMS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 02:06:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
In-Reply-To: <20260320055709.GA35291@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Mar 2026 01:57:09 -0400")
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
	<20260319233546.GA3632561@coredump.intra.peff.net>
	<xmqqcy0zgtmu.fsf@gitster.g>
	<20260320041803.GA18125@coredump.intra.peff.net>
	<xmqq341vgilb.fsf@gitster.g>
	<20260320055709.GA35291@coredump.intra.peff.net>
Date: Thu, 19 Mar 2026 23:06:21 -0700
Message-ID: <xmqqtsubf31e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I haven't measured to see what the exact cost is, but I know that
> looping over a strbuf (with a reset in the loop, or the implied reset
> from a getline call) is a common optimization trick that does have a
> measurable improvement for some cases.

Yeah, that part I missed.  Thanks.
