Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901133E36F
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772166216; cv=none; b=svRs5jwz9ttpf/qYb5erA/R2jTladLCo9XhKsonjKyxGgZHgoSrCuUBK1kE7BeoKVVAa5y42sGGqRnKWbVUwWCxaj8MA9oKQQK51Gfp7OQ+9RbNfavseNcJhLbloeCxh7oUFHuaL1WRXvDvdDhTZa3tGWwHv9x2XZAnVoAcYbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772166216; c=relaxed/simple;
	bh=mf0htnP7iqoZIngo5fepUih0wr87e6d+Pxbbl2CQsBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ej6oCG5+tBKhar0hf1DldZpn3y/f6QRfUtR8juI8ZG5H0OK9lEygUvVZTSR7YTQ7EVkUrI56Lrpxz+R5qs4Fc44VE9BfNI0oPbVGWJR7K3cFVBQ9gb5Z+txfq3kiDgqOtbgwTo3eMaKVJo9MwF6XaGBtKDCZlN5xJpMFbuVXkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q1PIwPjh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J1JEJV6m; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q1PIwPjh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1JEJV6m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55FDF140018D;
	Thu, 26 Feb 2026 23:23:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 23:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772166213; x=1772252613; bh=1NZkZK6Wmo
	lpDbrbgCB7vjsL5nownckt2M+CsreRntM=; b=q1PIwPjhCYjNgHOPuNVhBi06pJ
	Bd3w6YFR66mhz7/0WUlqXTvS418GVruKt4bMoUJd40zij2waKjVDcxnqFxrd9jhg
	1NobhmNh9kHl92BTuMU7OYGkzhL7640gjqrLK6MpXX0vsfEKknBjYwNT6R5TkcsI
	2pxbFsJeZTTNKaBrKFIfCk7gk0gp9i49UTKN9iO2TtRVG4q57ztkxO+SREYXgbjM
	JBB4sd5K4NAeIY8H2PneJn3worcl9+VZKLNxF7RN+jx9NFPwWfubJbM/gt7p346A
	COUlIXDvIuxkWjBOOK+9Xg7DR17VkTfz/lYvdOfyiBBo0DRFQMZLm2AbHUpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772166213; x=1772252613; bh=1NZkZK6WmolpDbrbgCB7vjsL5nownckt2M+
	CsreRntM=; b=J1JEJV6mU9QGYiO7E8dE2FrIHMpamUtKMHAFnDmJiO0TUZmQWIb
	lPd8C+80FIfqnxyeTSecqkpZOkns94u+wZierAukkUNT40jmDjSE7jiL+s230kLx
	Nnf/zyKrzqWV9RN1U67Gcl7ilCBcxeX/33+lNxg4+pQZb2tKtmAak75jcnmnoxm0
	1LixS131cwRo3e3W8hlGGoBs3/0GoP4NbgzSinLvB5xSFR9T0+cKVGEzyaGfjr3n
	mEv8h+q+WTNlE6WaXswxbdjWw0z3tGq06iAhI5IyZPgDARrQAGg7Oi/xFouaCdng
	t4wILrfB9Sw6vMDEvPRkz2cobSUeWtnDdFA==
X-ME-Sender: <xms:RRyhaWvMY-UvYPEKqmDc1g6uVxUwcBFwVYVhCEtQAcwnT9q6hjVIcg>
    <xme:RRyhaSfs-PQR4SFCuGE94aKdJOJ0toH_irPZwF8pdM73guPgP6m1qN_VMckjdW_Xc
    e1NCXKefu4QPAjovWRXu4iGmLy7MEZrNDRijeg7itJ2gzIXdhWReA>
X-ME-Received: <xmr:RRyhaWykBeZ-pgytums1SZNKSkYTjly5vlPVFmv7a-AMfua2tHZ15uU8KlsKsy8ioQi_bZW6UiXmz306PFRhRJo-_OK7snc2xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RRyhaQEY0BYeIhlsxTsOTeLcOZuue-KzhceNugGO3lQn_msql3EqLA>
    <xmx:RRyhaSxUWFiBHlIMNuFmTwOB5yRGpr5mtjQbODjJ9RkiYrD5w3UQ8A>
    <xmx:RRyhaZusYQgePoZwy0Kt9Ukd0eOHJw4ZkReXTYEYH8gXdboOBtEzmA>
    <xmx:RRyhaX3TeGN-DD_ND9V3NM1VDqFK0sUitYVD7rT83BBUwpdFKB3qSQ>
    <xmx:RRyhafwnpNPQGxtl_FeUpxjVHe_02vEFvcXv1-OMbNP1Z1pJjSa7rfHB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 23:23:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] format-patch: add ability to use alt cover format
In-Reply-To: <190817fe6ac5199c6df95558a7dee4be3d2fffdd.1772156996.git.mroik@delayed.space>
	(Mirko Faina's message of "Fri, 27 Feb 2026 02:52:38 +0100")
References: <cover.1771925291.git.mroik@delayed.space>
	<cover.1772156996.git.mroik@delayed.space>
	<190817fe6ac5199c6df95558a7dee4be3d2fffdd.1772156996.git.mroik@delayed.space>
Date: Thu, 26 Feb 2026 20:23:31 -0800
Message-ID: <xmqq1pi6vmpo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Example:
>     git format-patch --cover-letter \
>         --cover-letter-format="log:%s (%an)" HEAD~3
>
>     [1/3] this is a commit summary (Mirko Faina)
>     [2/3] this is another commit summary (Mirko Faina)
>     ...

Don't you need to update this example?  I personally find the
%(count)/%(total) thing a bit overengineered, but now we have it,
you'd need to write it in your forrmat string if you want to get the
[N/M] prefix, right?
