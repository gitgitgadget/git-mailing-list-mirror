Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEA19EEC2
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382913; cv=none; b=dWieKSHsdkbBnSsuTi7OjFfHUqqBnpcmHSYLsmyZEzaa0I0D8wO4ZmHSK57yisGCBj2R3WrDPG+XZGZf5AvShELKfumC+WgqIK86Tv4n1Z9vU7fgnxEJXTV1LPz8w1QTzCcK0lweat+T0rVf5KaSnPP1/hX+Oz0c42YOEuGvcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382913; c=relaxed/simple;
	bh=TsslV+KaCi+ellY8ZDZVl63UafyNPrRWNs0ixnPvZoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LrBjHc+33rgzb05SqkwXiY1oaJEp7AOczsSG9/AnVqeWUKh7aWcz5V/8Gndey7vj/FOjvpX64IlJNTMVMLFnAPmjUqK4H3slZPwyuYb+Pcy7a+TJzSqfVXzAHL/gBozYag9M4opncrAvCBPJ5y0ue+gzZKga0GJaFKucKwazIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EsurcRu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eHC24Tm6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EsurcRu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eHC24Tm6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74B3B1400104;
	Thu, 24 Jul 2025 14:48:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 14:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753382910; x=1753469310; bh=oXnL10Bofo
	/VL5B9yRza2c7q7Lmij/66BNSeE2YAGPo=; b=EsurcRu9JsEAUBkALZhImophSy
	9v5TtY+PI+GehYBrTJYBpV/CPKHvbYLnVl1Q6BHXBPB5CENUygMMHSSp15gjGOUb
	q+lmIst225ZyKMcvtVMUzeLRMTUDQJ5U48j7oMFYnddFIXh4iJFxeVdAFF770eTg
	zWpw9Du0ARij9b58DiJto84QYNnygbDbExuwtO4VsXjQEvT6I6wjzf/ikR3Myyee
	lb6v+CzM1n4wPPdmHvm5l3SAbR+JXg17IH/iTAc8tJ7LW9AuWsNq8+n7erR+sQW7
	wnCU22TLcSdQNNoJ36nEtz8KOfCmWPJE1Mx//aJJlLqfpqmXct4hgRpi5gnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753382910; x=1753469310; bh=oXnL10Bofo/VL5B9yRza2c7q7Lmij/66BNS
	eE2YAGPo=; b=eHC24Tm6TFhDVubdp1KMcbsO3FdEYTA7Wv9fv7mW3DYm7xN5wfy
	6OHSmbh3IRvHFoJLIjArM2dBj2N5qLf4j5ZS3N2hIDNhsU07o73mW3D0mWBiNOTR
	Wz61DwdQWkB6lHtc4Z29peFRifY6ISqXOkQWQfIwphVaPdAZZLZ14QviaCTAog2m
	QeFhHg1DTbZiJZItAVv65AKOQpe7613YKe9DJV5nLCFA3djtKvEetgzluQFbnc/j
	YGww+8VMvjV49hCVSUfQfJNQQLLxnFTlbBgy/SV8L8/nbx5xsn5Jge3Cq9EcnTev
	V7UehryHB9fLr/Rter2DqSeFkMk+SRxztqw==
X-ME-Sender: <xms:_X-CaMZwJuG3wvSrU9sye-9D8A2MDsU9r762Q7tUWXXdF7_jvax0kw>
    <xme:_X-CaEilTUbRHSpPl7KBLM0jMszODyAlWyM2ZYw8MvwSHejnCbbci5n5e-XWXhiSC
    CW1A8vfi7hV2IjOqg>
X-ME-Received: <xmr:_X-CaF9p6oMQUhWzAEWRfNEtofhdBHHDE5twS3LFHyM9BP1NfL-KMjP1EpP8Qz0bAKHrAPUYTG3ON5XZEnzIZmgKgjzX5pySY7oqz8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhhufhhorh
    hijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_X-CaHp_R6E7Fke7Sv-VIXoYNw4b7LW8Cu-jxv7-Z3L26LVoC_bVWg>
    <xmx:_X-CaFUk4i_rUB2P_PSgQRMl2hJ6InhvZ3xVXfjRQPrjV9Zxk9xiSQ>
    <xmx:_X-CaOAwDQ3kNonYrKDP8d7ZEJZiDUk9zLmoJOHFmCEVIPhnYsh2BQ>
    <xmx:_X-CaB1_9Jq66ZVl8311ryQciMLXhA32LihorCXZPzkaw858MXVcTQ>
    <xmx:_n-CaAGvRx6zUDgwNtuNabdigJr4arge689OrN8g93nKxkfQQowQrTYu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 14:48:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Kufoiji <kuforiji98@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 00/10] t/unit-tests: convert unit-tests to use clar
In-Reply-To: <aIJGNGxhkz9CESFu@pks.im> (Patrick Steinhardt's message of "Thu,
	24 Jul 2025 16:41:56 +0200")
References: <20250605140644.239199-1-kuforiji98@gmail.com>
	<20250724142837.67149-1-kuforiji98@gmail.com>
	<aIJGNGxhkz9CESFu@pks.im>
Date: Thu, 24 Jul 2025 11:48:27 -0700
Message-ID: <xmqq34alh1c4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Something here went wrong. :) But the remainder of the range-diff looks
> exactly like I'd expect it to:
>
>   - The Meson change gets moved to the correct commit.
>
>   - The missing newline got fixed up.
>
> Thanks!

Looking good.

Let's mark the topic for 'next'.

Thanks, both of you.
