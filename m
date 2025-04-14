Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A3EEC3
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657943; cv=none; b=Ps1iGbRDRxVR1JgtOKgFE1zh1BcbIMw0PhbhoUODMs+8Yc/dX+k3JoegUUwMhljAnyhIQcLhY3d1JDV480mWhxq4jM2oWnj+tmLXiv30AloA5/FzBGLrAsV4Xym6rlJvGGZzjRUs119vSlJR17J2vPgw8GPRS3VqtfDqiUsm9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657943; c=relaxed/simple;
	bh=4mT5iY6s11P07EdoLHpZTOc/8QiAlYRzS/o0lVxpKFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=spkViSWwzMt/hJEMq3TSvcx63VpkF8MQddus2K/2YYSwUjvFkULIf3RyZDYYJ24TlapvyKrGO3Xp3bSMXWNZGuJgbxyBJdiyI/cWggnc7RfJm+i1uIgCDkD+fEKJhudPkIIafvLuz4QA00AM3Q/PP8DiyqMdUquD+99YKpkdrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EG/p0lY8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rz14lK7m; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EG/p0lY8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rz14lK7m"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEFC1114018E;
	Mon, 14 Apr 2025 15:12:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 14 Apr 2025 15:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744657939; x=1744744339; bh=WKkpg3ryha
	bemB07O71Ibu2PzYAhKIzowT/rRkxZyoY=; b=EG/p0lY8xuMIpdnAqjx3O0ZnrA
	XKOS+MP41Z/D5IhAcJ0TEu2Chy4oJ+m9u900EyvK+aU4OouHMJGwpG8LkZdmJ3U8
	C24Zh0N086jvQ64Ladra1XLpaoONsRgFyF4meU56Tt9cLeVQyD4s7nr/4kFnEv+l
	2LAVCUCUfoD2LLzzLNbC3lAZwcjuTxNiBr0xRUnVgryiu0edHib1bLQe4LRarRhJ
	BbE5i4ps9i3Em4EUHmq9d5LXZWmvvJFuecWHT10Ilabt+5Iq+08C5V/2A8NyPeiA
	sE9R+ZHxrvvUfyIwTun9bZjkZ19+heNGvog6pDC4CL5BxkNV/H6R2JB4Lnhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744657939; x=1744744339; bh=WKkpg3ryhabemB07O71Ibu2PzYAhKIzowT/
	rRkxZyoY=; b=Rz14lK7mprLjm4YmCp3PSnoYegSxp6wzYCxSLtJs84EwKcEpa+q
	4XxeIYuQpN08xY1kT7oUfusGA6zQT2iea0HC2E8QNsQ/BjoADWc8VD99CtgyNN5S
	3Kt5E4wJtTAMyE1iW6IATHzPVGhy5wsxa35JDjZoOVlqXlPdR6eIpUMmRmmTu5Vy
	BCAP6KLimZ+Li3S/IjXKnjORuAk5odVt0Ok6GL5jEWY6ZCCSde+pLWNiX9lYOHe/
	OHvPlGM9+IoFpe3hxZmLLkOFbNFJk1aHRJVROabT5ti82NEih8chEZZ9xFdpipHK
	NmqIl9nvKGILKWhFmcTPTeyKVKm4Y5C4CbQ==
X-ME-Sender: <xms:E179Z4yliLCrHTEy1dtgpKwiNGeIlWK8pbWPKlBAkIG3GEsS2PsRbA>
    <xme:E179Z8Rg8Dsmb70oOMwd_w4CZ-7BYIEKOysp8xgjCbi7XMhf9u9rF-cUIc8SEYlPJ
    HegHEL1XQJf1XtP2Q>
X-ME-Received: <xmr:E179Z6WjWaBsPPUuuSwV63KlHWVSoLtNCfuv894yW3HJtUHKMQXJoLvS8p8VtwDDqxEl4lhCqm_puBpLQM6AfjFMQLRJ_SS1N-m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E179Z2hXMAYLUnJSxBHg3kyQWo4r45pNDhbP_sgHf21FvvGkLy-VZg>
    <xmx:E179Z6BrQBFpBswn2SJcup8RezovQyNJXfX7NA5wpJLlYRpx5uNU6Q>
    <xmx:E179Z3IvhrGz94XBB-CAwFAaaP3fKKOlPpNvmNI4DzLG2UE-H-QFFw>
    <xmx:E179ZxAxeDALR9tWLaAgsuyj4WMtWel_niGGp04yLodl77U6Gz85DA>
    <xmx:E179Z84vGS2hPYizblHj8y3T6qhwsRDu5OJ3hRi43J9hNnKK2hkDGR5m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 15:12:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
In-Reply-To: <Z_xAOmQm0e_WE2Dd@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 13 Apr 2025 22:52:42 +0000")
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
	<Z_xAOmQm0e_WE2Dd@tapette.crustytoothpaste.net>
Date: Mon, 14 Apr 2025 12:12:17 -0700
Message-ID: <xmqqa58ir20e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I know that Git definitely does not know how to verify those signatures,
> though, so many people would end up not verifying them.


True that many people would end up not verifying them, but I do not
think Git has much to do with that.

Some contributors seem to send PGP signed patches to this list (and
I once mildly asked them not to, but these days I simply do not
care), and if I had their public keys marked as trusted, my
mail-reading environment would do the verification for me totally
outside Git (as this part of the workflow is not about Git, but
about communicating over authenticated and cryptographically
protected messages, whose contents happen to be patches), and I'll
just "git am" knowing that the patch is from the contributor who has
access to that trusted key.

The "key" (no pun intended) in the above is "if I had" part.  The
overhead of retrieving, validating, and keeping the key for a
contributor becomes worth it only after the contributor turns out to
be very prolific one.  The Web of trust, while was very attractive
as a concept, is not so convenient to maintain well enough to be
relied on as an infrastructure.




