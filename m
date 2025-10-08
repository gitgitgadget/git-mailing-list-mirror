Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355F2ED153
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921537; cv=none; b=e6wyVmGkpEFQbS5S8aUHIUB/Rvx8GhLLPXFvWpqVoHnygUsZR56d5LhgJkmrdpYdFMxb55vvfnmfCXbpXguQjmjiSvG+MtpBzhyu7/EJyTzKetmGYTOr961UJC75BF2jrxj93/+28gMbunNn+VGafmxTufbt/fwljovW4JrEXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921537; c=relaxed/simple;
	bh=TjZkGwNIbeJsuT27sC+azc9lnmrwIEgJR3b9tY3/53I=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YZHfRVpDxIplvdG7EJATHPcEOP6DMFjSKkH9J3QR2JsXkieeAvqZztzhTfGBfvH7pZZe0/pupKciHS2b8qqXHqkUI3urgfRp0aZO7HeOTL5oOysVicTlll+Ti2yKkcIUJQml2Z15e1kh5xKMqktpJAaxqUYKeG0zxrg0rpQZVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gl5LdRoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B023hhL2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gl5LdRoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B023hhL2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BC277A003C;
	Wed,  8 Oct 2025 07:05:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 07:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759921534;
	 x=1760007934; bh=TjZkGwNIbeJsuT27sC+azc9lnmrwIEgJR3b9tY3/53I=; b=
	gl5LdRoMD0CUZ+lgwq1DYzqSxINAX2EqaqZ1Cjw/EiEVcdcSWwyA0rra4bSI70bi
	AzrgSbK+LSsmscv1n42NBRLJkBNX1RDbjBXbdBg4l4j4CPP6/FSLTlf0i81PDJVh
	i5TDdzsgAGGzhGkUE5lNms/UjHWlLqZh4RFzeOIV/Rot0eC9YkZ04lkn0JXQ5gPb
	wfuC8cjaMKKOMR6meuYhsA+rzWTOp4usjdE0nJKqjo2s2oQl9HLGiZLZqutfV/9U
	DnpZm/PTUgn1Rpzc1Jn9cdqlkOxyt2mO8ABBpV6ZqJ1g/IXqTo4ogoYHlPMLECMG
	bHpI5rWRZECrQs7mhzJ8wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759921534; x=1760007934; bh=T
	jZkGwNIbeJsuT27sC+azc9lnmrwIEgJR3b9tY3/53I=; b=B023hhL2Ij4R35BDX
	hPYzZC7owUxVqLB5oc2DcvdVBit94VI1d3fXs3+IHvZ04OD1uJbnOGZPqBjtfFZX
	4IO0aR5HEnrwMKhaz7MrCSjPRSvAO5Q2CJ0VYTW+rDfvJZC19tFox1c88g39166m
	4gt5AUjceKozOjUpQB3qHwMvAWcYZEdw90n2EsMC5iV6qFzhwc2HCAVIO0PStwdu
	Wl+U+Wx0O1T6DaVZUHovrz1HLdtf4B2L2YotvXyzx0t0ZKaICdNrQK/iWKjrwECd
	zXU7HZwAuPe0b/x/ctJ3LlAWGBWhQ7zKdvmakjJn1AGJ9XO0qMhsQi4lcNp4uaMY
	Tj5OQ==
X-ME-Sender: <xms:fkXmaMslhayEPZovkQw0Wf9ajiUjOF3vku9khxMm_vYT7S8LF_Tz-eM>
    <xme:fkXmaERNWNHIGR7gP4alIrrgZOohC7zvsBP5CnFtHeExGHMj48WDJSYyibVWZ0r5e
    B5PpvLH78V-90hFhIkElyMLwqn1aAUSGfDgwpo9aHOb_rmvkies>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fkXmaLaVYBPdUIdM3IAftX47CHSarx8YjIcVltgZ-GxBNC7hKVu-5A>
    <xmx:fkXmaIWLQwYslJbXzb1Jhloeof_Pkkm-2rVo8xwYNLrvee9aAhQ92Q>
    <xmx:fkXmaFhjfjiQ6ApMOEetigPO0UpVjPS-zF2mcIlkc2KZ-aiOIE5qXA>
    <xmx:fkXmaOVHyR32CAyn5EIWZYlOh77uU5FzDHNqQB97cR89pdt2c86-bg>
    <xmx:fkXmaGBekQYQuHPnCdbUp5oQbomWqdRYNJbvOHOWjn6q19_MX05Yc4MD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 220361EA0062; Wed,  8 Oct 2025 07:05:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQzWF4D0ixTk
Date: Wed, 08 Oct 2025 13:05:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <6e622432-12bd-42ab-95c9-6360fde75377@app.fastmail.com>
In-Reply-To: 
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-13-916cc7c6886b@pks.im>
References: 
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-13-916cc7c6886b@pks.im>
Subject: Re: [PATCH 13/13] ref-filter: parse objects on demand
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 7, 2025, at 12:58, Patrick Steinhardt wrote:
> When formatting an arbitray object we parse that object regardless of

s/arbitray/arbitrary/

> whether or not we actually need any parsed data. In fact, many of the
> atoms we have don't require any.
>
>[snip]
