Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975627FB2A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668951; cv=none; b=VWdX1t2XjTQyL0tq9uhOLM+pf9uK7Sd0SZ19Lpb5NDYg5dSh6EfNrs9/6Gup6H6YcpfeF0NQ4eoZVaYHR3DNPyISUbTvIoELA1A2AxCG2mfLq75L5Th4eBICPqaUDhPcipZDhj3CaBvhORMnDo1sUACq8lESO2GY5IUcv9UBsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668951; c=relaxed/simple;
	bh=H0DJuTFQY47pD1qBhvRvi5tW3ppeIGEGV0x+NVfgh+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MR8JnLPi/BOqajU9R5j5nEWz2kBfeG0Z5pc/Y70ZsTDIEnntM5hpOtrwX4vSwZt1alZMnslIpaew47NbmF2RhAwn91N+ClqowBGAdeoTa/I/6WMBxTf3ucSJ9Y8k5YdAJtBthSe/hStCouJiEFn+QBr2bCI87M3c6Nen7V0QpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l8TA9KsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpZrCQ8S; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l8TA9KsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpZrCQ8S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 713D9140004B;
	Tue, 23 Sep 2025 19:09:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 19:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758668948; x=1758755348; bh=fsvn53V3YS
	tBEKlPIQZyBNbSUmCapHzUiuEnWVuSR1E=; b=l8TA9KsXZaLe+MOrD/5Pu9JYof
	Y0he47zD92L90JfDeRxGXRJD1NXn2z1qSsdv8h8doL8L+cyZJzj05EvZMp85QSBa
	LGxQZ9Zvtj/1Ei35EFnOHegFFYkORpz8Y7NsAWvYvwI3uUhyGdQKtp9XVrZfl7nJ
	VsGaZNSPPUV3e/ay8qQXUshyPMPz7ttG/3WrNEU5+aUrsP9Xjnp/WhgRb2rt8h+3
	x6aZa2ey0IKNmtvz88pjq+xDuZ+5pTsA1x+IPcAmoKkwFEVNVLjYoxXXvFRGJnPi
	X2xtOVwbs2WCGQc3gMumV6oj9wQC/evs8M2NJnYqPfBIELRbr6AUvqhhREFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758668948; x=1758755348; bh=fsvn53V3YStBEKlPIQZyBNbSUmCapHzUiuE
	nWVuSR1E=; b=JpZrCQ8SbYZBDddj6BNn+SXx0WOh7WRINJ2K6xxiu59QMswXHfR
	s1dA7nGdusIE2TRC8K0x/mnIFvKdk4/VoXbKMWk9evGo11j3p4KZDNWPprRXHMcI
	Nq3D61XFqgxaQURftxQCuzdOC4pd3D2IOzIQLuI9yEHAaxZIL47UtC1qQEb1GyJh
	4gaM+sTMnzjLhh/i2+MlsHQnhaB70tv/pXKVA7lv4G+7xqrVnT3cLMhni4M5DrdG
	gf/KPUFvNBGXkkK+mQip1vYoWe3CB+7C4NQnpH3cTgtRi2XQ2R6dL6fOz4faz95W
	Fadeyr6slNsnSjqUMjz48tL0xgHpN8Hp8zg==
X-ME-Sender: <xms:lCjTaDqL3A4EWbXQsBYQ0JsFcydrmkFYsqqlEVFX9dczhisqsw0ffg>
    <xme:lCjTaBWl5hUZwgiWWNy9gZcJ1hX6i9hXeW4_oAxG17Yn5ve2Vjv81mHexttngJiws
    Z_HFKnfcwzz7JVG5f23z7LmGjOgqvXJbrv0jU6Q9bn54CGPIA8I1w>
X-ME-Received: <xmr:lCjTaKCCpDmMnAYA-34g6G3VFxRv1WqjiL37OExH-01BcVFUH233zp3xzOINCEOhtwLgbrapmQJlyeqXNW3uWLoLMv_VTxEO7UcS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lCjTaN3N1GfonGifcIv5x75I9eUMC9X6Bu-hVf5LF-TXP4a8-Sx7UQ>
    <xmx:lCjTaE0EwjoCdqDIUNTMzVO1UDUGDdpdckG6wn8J_o5nJwq4piP8SQ>
    <xmx:lCjTaKAhpaD4fCpZVwMc-BYIfv9AYOevkJwbOtLIlQjj_i40hMy2wg>
    <xmx:lCjTaL6HDZBY8QoE_5tkbX9qVAnmgW8mEI9_fPTyB40lZeA0Whw6TQ>
    <xmx:lCjTaI4vvzcPJn5Hi7vZQ-24qgyeEPyBEU0z0RFzJCu8rcI7vRBSvNCL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 19:09:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 0/2] doc: git-push: clarify section
In-Reply-To: <2ddab74c-6d42-4ef4-b7b1-783f1631bdba@app.fastmail.com> (Julia
	Evans's message of "Tue, 23 Sep 2025 18:10:09 -0400")
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
	<pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
	<xmqqa52komwf.fsf@gitster.g>
	<2ddab74c-6d42-4ef4-b7b1-783f1631bdba@app.fastmail.com>
Date: Tue, 23 Sep 2025 16:09:06 -0700
Message-ID: <xmqq5xd8ojfx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> It is somewhat awkward to have two outstanding sets of patches to
>> the same file under the same theme from the same author.  How would
>> this relate to the other "git push documentation" topic?
>
> I split this one out because they were logically separate and I was concerned that
> together they were becoming unmanageable. 

Oh as long as they can independently advance and join cleanly, it is
fine.  It would be easier on the reviewers to keep each of them
small.

Thanks.
