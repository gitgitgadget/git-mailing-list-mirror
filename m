Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DE33067F
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831699; cv=none; b=tz6J3r/YhYiPAR6584d7NoAqcJh1UGCwVghzgMUMfPl6QWDUmtv5v12lxykYp3zHZxenzLG4GbrFwov0jgJ61J/GgSXP2veMQgUzm2Id6/NM07zY0Si0kRGtlCin3G9LSKJWrJRLZhTW0hsMmFgGvw6qHXSVUmeT1wAyvEFdMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831699; c=relaxed/simple;
	bh=XidP9VfpEkaiSpsfdiG6WY9qWPLPvIBv6Xy5ZRAspz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aHZPMEKKBkHOF0jiwNBzV94Mz2ZIiofpnq8QoKOXJ5CWce+j5zdZJ3P/5PYJXPL/BU1DEex0DJ40Oaj3TSb0R3eq0bRZInzeKns9mhTEC55p8TAswpUtMAOPrsp7G9AeVCKMVihaBzogoXQMfJj0bMEgeNgGsGnfU3bDEp+x7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WSU+5zwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=inZGilG/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WSU+5zwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="inZGilG/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7242140017A;
	Wed, 11 Feb 2026 12:41:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 12:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770831697;
	 x=1770918097; bh=XidP9VfpEkaiSpsfdiG6WY9qWPLPvIBv6Xy5ZRAspz4=; b=
	WSU+5zwC5/NiLue+U4u6UHEQonSumo7BNd5WXxk8x5cFcLqOPbgxiRNQE2tXzc9X
	qvDY/Uh0zAWYvrfomo76NLzzSuKdDeNMpw7cMeIjV4F0anFBk/yNIX+HKzu+3kIY
	91tTf3konJ2TvxgMDS2EN+uHyBiXD4KztQs91jQBZTb0omhKKS4MOHVH0KRZUVmR
	aS5Mq/4qr0LV+2BqNeI5nBIuVVGf2Oh9wzqZup5EsYtnSYB/BVGTb8/WChPS9HGq
	ZljF4OoWlONBPx/FmQ1OlDe3z6Ueq4vgae7MaeOXG8miFxRIkR1JbIfrd0rd9rAd
	PXRaI4UxGgl6htVeyKu1MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770831697; x=
	1770918097; bh=XidP9VfpEkaiSpsfdiG6WY9qWPLPvIBv6Xy5ZRAspz4=; b=i
	nZGilG/fFb7rdUVPhR8GaFLB6nKu72xwo8/sEUlvRjTzJUA3z0np1ll55tPpKAX5
	r+Mb0YMDIqvoiFltAwBJQ0+rPIs1Sc5zAbSiVHlczvuLBc9O/ypQRQJei1JCJymo
	UQa8RyLxxEecggdBh/BhSOxSZ773XR1f/ERB1o65WouqGPqSXWJ/HSezxOdCC4P/
	lRHBVPJlvjp81p3Ln8wcyjTbeusOQNWEIhesacKeewGJ/m2h6GlCWcMPHfkjJEbS
	LASK5sozSva+CxZ4kL+POH3nSNHkeLZw4SneVtKmOoOhR+AnPlZUEc5zXXvetDbF
	m8ri1KOjsbIqSD5iu1etA==
X-ME-Sender: <xms:UL-MaX3mWrwiybrGu1ZtOLKei00xAFjvZ0PFJxJQtvXOH_Wn5j5qfA>
    <xme:UL-MaXqusvGaaSjEIEq7QjyxMnUeu52S_NJT8pZk29XstjWGfbhEmeMPAkmTSXEHI
    3bUuj8s9M2PQcRcAwGJm28YyPYmW0lHgG0MCDPJ37EymRxID52i>
X-ME-Received: <xmr:UL-MaXJ82FxJtuqRvDQuDLn9nmz9ENH6R29gdwabGlMIcL2j__0qDUDHQUMFX29iMvCJs8DuFU-KMkDaR5OlKde5ZTUy0JrjKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:UL-MaTQ6EsgFEIAvUvHjOe3W7HPFgikhP90loYy-EiuXHEeY4SUyGQ>
    <xmx:UL-MafONlhnnSAv49ZclGSvETIGXEq7nc5TWDRxCjq-knhWL79HlzQ>
    <xmx:UL-MaQVBERG3d21P_zYl2PLhI95za4rDUXiZE5xKTWIdAgKlt7NOAA>
    <xmx:UL-MaahOT4h_pdXuHY8hZI6jNvlgPO4Rt2PtgXGBmz08hs1GAcOpig>
    <xmx:Ub-MaRqgt-LEq9l2v4GGE1s2F8VbE9mXlwa9hkjnd2FOXwl16uwd2Cj->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:41:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Toon Claes" <toon@iotcl.com>,  "Siddharth Asthana"
 <siddharthasthana31@gmail.com>,  git@vger.kernel.org,  "Christian Couder"
 <christian.couder@gmail.com>,  "Elijah Newren" <newren@gmail.com>,
  "Phillip Wood" <phillip.wood123@gmail.com>,  "Phillip Wood"
 <phillip.wood@dunelm.org.uk>,  "Karthik Nayak" <karthik.188@gmail.com>,
  "Johannes Schindelin" <johannes.schindelin@gmx.de>,  "Patrick Steinhardt"
 <ps@pks.im>
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting
 into shared function
In-Reply-To: <a4117ddd-1cd1-46d6-978b-b946f0199ef1@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 11 Feb 2026 16:23:22 +0100")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251202201611.22137-1-siddharthasthana31@gmail.com>
	<20251202201611.22137-2-siddharthasthana31@gmail.com>
	<aTLDA11AKs0jlxFJ@pks.im>
	<ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
	<aTZ5RrjnwJ2ZnT7A@pks.im> <87bjhvqvol.fsf@iotcl.com>
	<a4117ddd-1cd1-46d6-978b-b946f0199ef1@app.fastmail.com>
Date: Wed, 11 Feb 2026 09:41:35 -0800
Message-ID: <xmqqjywjuqi8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> I don’t understand the position on plumbing commands. Should plumbing
> commands ignore user configs so that results don’t change based on that?
> Or should implementers that use this command set the config files to
> `/dev/null` in order to opt out of the behavior?

The former.
