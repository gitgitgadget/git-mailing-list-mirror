Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28660B8A
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269391; cv=none; b=Axrb40VEIh51oqy1Ojfl9qCuatuIJb7oJzqRiLBr9FjraQtczzT+YNclrqPTgrLb0QKw3fP8Jap42QpWQM4lprx6nxSR/8cf/x1PY30zUKbSRq09RTq4tSAlkK2z7BGBV4qMLnMeYxDQgF4bPsRNGk/K78iEbef6VBrG4GJYfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269391; c=relaxed/simple;
	bh=gM4sZkaqlmgRHT2Ny1nGrqX1NWzk4HHmjeIaNU4se8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrffuBQOLqJEftYzWzJTGtg6tmB5Wtgpkomdw3Yk25a/8xixg4vJVmhmJjUjFm7olyy5ergery1Rzs55LkOC5nKoVJxLOs3gBThBxeURG+CxoOdx9qsSPcZl7YXzxeHwY38NzjrAKilfDveC/rnChLEqyeh2Y+e1+9hZS40bbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kj3/V91k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wmr7siYi; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kj3/V91k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wmr7siYi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A7DE254019B;
	Mon, 26 May 2025 10:23:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 May 2025 10:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748269388;
	 x=1748355788; bh=T5Pc3QaqwNJY/qj27pJMRsm/BeI2DR3J1yxuFMLfTs4=; b=
	kj3/V91kvlpArlmh1PSZ2zw6jMf/pozamEdIjbOVNqbh2cohJjUZBTHgA9bhGovT
	Ax+WAxBuCYQRBVPlpTQvWCR3Oc3Pb4/sIz36f+PqsY0KZmTq4nBIHAuISWr9VuC+
	tpyEq0usA8qNG0P7vVfy+xjzFjO+/nusD1Mfdfjr7RRHF9rCkwuKV1snwUIasPvt
	B7lUtVerqDJrZPo9OF+nialStNx0Fwwa58TykthC1gnEcv6uCzZnGrlOcbkXGLMm
	R5cSTrcpVKMI70xTWbsbM+whgXPpxs6BWX2cDBTT45nUQ4l6CP4chROqdmb3SJvV
	wYPebjklb0p8+msnXf5qSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748269388; x=
	1748355788; bh=T5Pc3QaqwNJY/qj27pJMRsm/BeI2DR3J1yxuFMLfTs4=; b=W
	mr7siYiA3LEp5REMj2Orriox3JQ433oDeeqX1cuaW8qYl1Anjs1xiv1fOMntBJtC
	6APYXlbSrS2othjNi53zx5IUUCY3se7zpFgen1ryGqiHSebZwf5ALnr/ZgBIe+CR
	O3Gyuif1zcj1GnIuY5TFuejB5gxWRxfOj5pnJz0tR17ScH0sEjwuu+wPSpB7Zuoo
	0kMJ8lP+5cDU/5uOC91jRx7CJZNmpy0lXwAkExE04jNzzPfuW7n5zwLbe4MMXDC7
	58VCF8knA2WdIYmBU2iq+SrvdTETkZoLyUEQsV/Jlq80zoO+ZxcBWTpFFD2jHqim
	oIcGay0kNRmlci1cBFtww==
X-ME-Sender: <xms:Snk0aGtS4lXUdXXPcVBk818FumxYb9FVxNq0TDCqP2Y-WX72AlxQbw>
    <xme:Snk0aLdVA_Tz9ffs78UtcYCwoJVZp78dz0LZoHJtbjgBVVdF5JtYBoLugCKNE8gRE
    2_luyC2CFL5KyRmuQ>
X-ME-Received: <xmr:Snk0aBxBgpK9fH-x5UQVihz00J3gwAY_-o3xWXqOWdC7QGzTHadA2FofCyZas_hUuoaGu-z6CmEOztOzXzJEp9OzUGudzRMojVC0CYS-UyZHffkPVJ9H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeejheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtudenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruc
    eothhmiiesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieetkeehiefhtdff
    udfguedvfeekgeeijedvgfejfefgvdfgueegvdeliefgveffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:Snk0aBNNqPqmItHdoS1h0MqxJDLwMghe4c7KUGaTxC9AqdheMyrOtQ>
    <xmx:Snk0aG-nr7JgJVzjAglqgez4RcMOJXuRgrdm_WOuhEG-iZ_I3X2oQg>
    <xmx:Snk0aJWgcgL9rhxTgFXu0fskJGQjqpSANVJJFUg7OhjDLoRqqTYWjA>
    <xmx:Snk0aPfODblrdQ7uHdBxrXtnnP7ZRuBCMPPs5lHjDPN57akXqCVA5g>
    <xmx:THk0aEkB4d7VOcVGUNK6CXv0UtEbaaoMOaZpFfJ04ZdUyo-a8ZdfiC2Y>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 10:23:06 -0400 (EDT)
Date: Mon, 26 May 2025 10:23:04 -0400
From: Todd Zullinger <tmz@pobox.com>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aDR5SDrrOEpNFhvv@teonanacatl.net>
References: <aC2xp4Cdb0j6OX-G@pks.im>
 <xmqqcyc2aqy7.fsf@gitster.g>
 <xmqqfrgx8xkw.fsf@gitster.g>
 <aDBH7G-oKKxAXWBp@pks.im>
 <aDCNqRAoGygwnAbq@pks.im>
 <xmqqo6vjz5cn.fsf@gitster.g>
 <57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
 <xmqqwma7w29o.fsf@gitster.g>
 <aDRiLdUCEVQHq26z@pks.im>
 <74c03ad4-b132-4cad-b65d-821324380343@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74c03ad4-b132-4cad-b65d-821324380343@gmail.com>

Phillip Wood wrote:
> On 26/05/2025 13:44, Patrick Steinhardt wrote:
>> 
>> I don't think it's inherently a bad thing to fail on unexpected passes.
>> After all, it shows that our assumption that the test fails is broken,
>> and that we should have a look why that is. But I can see arguments both
>> ways.
> 
> Personally I'd be very happy if our test suite failed on an unexpected pass.
> Currently it is easy to miss, especially if the unexpected pass occurs in a
> CI run. Missing an unexpected pass means we don't change
> 'test_expect_failure' to 'test_expect_pass' and a future regression that
> causes the test to fail again will go unnoticed.

Indeed.  Perhaps related (apologies if it's a wild tangent),
having a way to expose an unexpectedly failed prereq would
be nice.

For example, we currently (well, last time I checked, which
was a month or so ago) fail the GPG2 prereq.  I submitted
small patch series to fix that nearly a year ago¹, but when
I ran the tests in our CI, they turned up some preexisting
failures.

I spent a little time trying to reproduce and resolve the
failures, but was never able to make it work.  These tests
pass when run locally which makes it painful to track down.

It would have been ideal if they failed when added, so that
it could have been worked out during the review period,
while it was fresh in the minds of the folks working in that
area.

We are simply not noticing these failures in our CI, which
feels worse than simply not having test coverage.  It gives
a false of security that t/t1016-compatObjectFormat.sh is
passing.  In reality, the tests might be reporting a real
issue that we've been missing for ages.

¹ <20240703153738.916469-1-tmz@pobox.com>

-- 
Todd
