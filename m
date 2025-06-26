Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56331DF980
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947333; cv=none; b=akcDqouR6oBqeSPfyc6qEfWLjKF2QaEHEDx5yNjBPj4qNj+t1gU+suVgHZI2qRBWk8iS6Vwt3spBisoUjOm2wVho+tmcVB09/qq/O/VUqACqcwR9YhILG8J2D5BgyN/gkSSGikkiFV/6x+H4p72l2xN3MfKHJa9WNDd5ZlWw0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947333; c=relaxed/simple;
	bh=D7YdSq2GADqLGz1dkLKnaRFwatJnTWeZUPGJEUaB99E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XA55ysTMYEsGwOrkeD0K/rNVPcIUWExZDpgoksek4wQ6OfJ1138rIlfx2iJ33GYcPNdq1yfg6JQ31m92oHCtVBN3rBfrNzoPaly7eh0V2F2XRXapLkd6XAZVNsHD+oF0AYPYoBQ2hDL54wXYaLsvP9a1vP0wFpkTTp6mNG8MmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XLty5RgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KhVLmQg7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XLty5RgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhVLmQg7"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18D6314000DA;
	Thu, 26 Jun 2025 10:15:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 26 Jun 2025 10:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750947330; x=1751033730; bh=D7YdSq2GAD
	qLGz1dkLKnaRFwatJnTWeZUPGJEUaB99E=; b=XLty5RgZsJwoC2T/DI+IbUCQSh
	niDNlUazVsElittjBkwrk3Q+07Ay0NHSUecTZFg+VtA/SUhn6d3kgrZsC67uoL8x
	Lyq07fhzE6z7vktyIqWvjiUeLHbhVsPcdXMwtkECNGtNrftvAMRVtkWxvFkEMfOM
	wO9XyM0bdgcqTuKW0yrjoFOP2rv9HB4MBTJcbHHjgbv7Yf0//jnI/7CSRClU0GPu
	mADn6EHgTYjoeuLrdNq81wC9EaXnBxJPOzZ52yodt8Xi+9PUYxMRghe0Ep6FXnzZ
	GBjf1j7bXv5HY6SWgogmf3JHrK70EiBYSJ8j1FJeRSuGE3krm6U4xPIAO+7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750947330; x=1751033730; bh=D7YdSq2GADqLGz1dkLKnaRFwatJnTWeZUPG
	JEUaB99E=; b=KhVLmQg7RSCHdVRG6EZ9zi5Jl04Wa2AIG9aMC/y0KGVjYTRntq/
	RV2jnBB2RH1z0es8Twref3Tc8VhR5fuPoX2/L49xKgk7cv7xug3YlDmXgPfT2VUf
	taez3GuQuEiO6YAPpZpfl3mCCftwTvo2mtLzFwC4Cb7gGWGUnyGiLRbRPDVfOlfP
	NqIgIqfclaRYtB8nm3Xc49xX38UJGwqL8IhWXl21fnwdq3VfJFsRFs0jbj0SHgox
	D58l2URvBw3aM37Ihj/fpZ8LxgHiG5rrpLuLiDPp7997EQvt7TaK6VY7/FnvwKu5
	ODUNc1M2SECfBNyP2D6e2neYFeJAWs6TD8A==
X-ME-Sender: <xms:AVZdaKCzGjbguuuT9SQ0JKXh6ImvbvbeyeuhBwNGeAqi0JxvISduSA>
    <xme:AVZdaEhXNqbUf3WUxgjwqatun6i9WwnWKaC496B7IrK8W0HEItRLlTX-3KJ7Xy8Hq
    gKTC1Ny7NWMb0Ewjg>
X-ME-Received: <xmr:AVZdaNkxTnWNdxiNHSqR7nOwybf4pb3K2B3-9X_e0dmVGhQK9K1ad1ZyeQ3FjiQw9npSkWPt7T2iT940oC288Z0odIc7XyXpO0l8mrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvg
    guuhdrtghnpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghikhhophhonhgvnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AVZdaIybA5oV7b39UY3hdfrAZMAIGDsa0yJyO5pqQl5OObVQJeXglg>
    <xmx:AVZdaPTGnNoxaWtdC3UVKGm1lBV3w0fhJ2K2nKn5dbSQBnardevPnA>
    <xmx:AVZdaDaKVnHYvCo66qhurEQa-hw7XZk9GIDjW0iNkpKtx4lhzLHHJQ>
    <xmx:AVZdaITuarKzRSz8gOQz5XKooZy2sniDP7UbaweHyll3vlbUjG_eAA>
    <xmx:AlZdaES1BLOZnlPYakHUeD1QricrhqhOm9SUvDhCq_aGtcVIlKpRJMsY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 10:15:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org,  Kai Koponen <kaikoponen@google.com>
Subject: Re: [PATCH 0/2] bloom: use bloom filter given multiple pathspec
In-Reply-To: <691CA448-881F-45BF-9D38-190F189DBB4E@smail.nju.edu.cn> (Lidong
	Yan's message of "Thu, 26 Jun 2025 11:34:38 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<xmqq7c0zviat.fsf@gitster.g>
	<691CA448-881F-45BF-9D38-190F189DBB4E@smail.nju.edu.cn>
Date: Thu, 26 Jun 2025 07:15:26 -0700
Message-ID: <xmqqldper3lt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <502024330056@smail.nju.edu.cn> writes:

> I assume that t4216/test_bloom_filters_used has already verified that
> using bloom filters with multiple pathspec elements produces the same
> results as when bloom filters are not used. But I would love to add more
> test cases to check no false negative happened.

If we are sure we have enough test coverage, then it is great. If
not, it is superb if you can add some test coverage there.

Thanks.

