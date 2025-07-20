Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BE4C62
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752972069; cv=none; b=GDuG+WqE0kTaGFbwYVlN3PJFz89dVULQmKK/wztpkPlf+Zy4Nua4Uaneb/YALHshoJPR6VmmL0OSxLnEu/fOgMq3bOzb79JYK74iYyv+upBBTAcAHrK0DCj2aBbGD4D3cBNxiDCfxcI/wkLxjK++AGiHLfIg+VML5RAUz5H3epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752972069; c=relaxed/simple;
	bh=tXSnF6W0zm9WYpvZ1BjmD1dEOn8vlmqYv+5yRcP24fE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WkyqoCp/20HpMHiLSO0nQUOeCIhS+Kly4vx6i7WdTCZ2pfRMgJk0LNwloTfDwGoWYrkCy9cOYLzYDJUVhO8GwpUMUOKquRNiJsFNdulCNBVVzmZ1tBJ3K5qlFfocgqb5V26cOWTXuXdjjfnOlPKX/VzdYD8xa3Pk7HKvMgop1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sJZSnrn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fGdRgXAc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sJZSnrn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fGdRgXAc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA2191400218;
	Sat, 19 Jul 2025 20:41:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 19 Jul 2025 20:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752972065;
	 x=1753058465; bh=2/TLA1tM2a/oSS3WBBvoX1W6SnxgBB7tGZc4TqRSKVk=; b=
	sJZSnrn+Mf6IjqyFQru33+mqZypLi8DZTC9hlU2yp7idsKDU6LfVoQ7HAByJaDlf
	h/d9uNFT+C4+ONdSs7QMUZTofrVVoye6qsGTiFVh5ZybN2A4IGk813S9CTE/5dAg
	0TitNLt9/IsKx8rRNUNvKLB/+jRBeUh3Ek5519Cuz5BS/cuV4ix5/hhHiaj1mETZ
	dLBUa1ZYAovpjIVaANBwrgNfih4EKaSnMs/t+2k5Nv7+EPNGscyboviSDoB0sY3b
	mpzPdOS20NiALqv8+TP4o9ipE2dZcyvnXUbflUz9J4OPCJXcLZJNMU2pA0XuYPIU
	UfM5qoOt1LWVsdG7Yd7Y0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752972065; x=
	1753058465; bh=2/TLA1tM2a/oSS3WBBvoX1W6SnxgBB7tGZc4TqRSKVk=; b=f
	GdRgXAcCI8STbQXptj4dkg+4JZbLR7lYdzg9G31Ej0Jzrh4bOID6JLQNvhf7GbIA
	fmOeZd2GOXESo6z3rK07iCViDHIBWH7NP1MM+M0UmBlOHPzuBUdvyhqfLhrIW21/
	ehd55BMkaSoL4gBYcPGMiUBIOvJojQQc0mGbupa73miaxP8+TWiFeJUSzwkbElNy
	LlNEVFU5R51T4hXToXn/kwO+6NA2pOKkksuoLsWsBXGpePCwfc/ZcKgjATzdnD44
	u/640A9ozAMUbrpgVz7Ic26FZFIT8CzcBjwPuGN4noR0uRo+aHKuLPi9qAxclRoU
	qdr/kt0JPP4zs06dpVfLA==
X-ME-Sender: <xms:ITt8aGDrgQfa7Ip64z-qJw1nY9wRlaWg_ujldLItnUslkxiw_1e8Ig>
    <xme:ITt8aLGFM5b-eeXnNFhgJb2slhRbGA5i6OOZXy8zLC59k_wfOeTFK9U1LQ8QOppY_
    Pw-GNer2oyli4eypg>
X-ME-Received: <xmr:ITt8aGIAWdR-J6kg1Eciq8P6176Rt8Kj3uln34c3eV744RDEjXfK8_7DjQbObF9TR18zPUdrsAtnfnFb-VobcaLpuHY3F9AyNFdzq5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeijeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ITt8aHlr1mPRoU4m9KxJIM51RiWlAYLkvjiJGt5xZu9au_H60LTi7Q>
    <xmx:ITt8aGTG_HaseN2cZCMVtc7gEwtejTrFoWarLaAB2ZriYPEcf31PTg>
    <xmx:ITt8aBJk-ecvDRrwMok4Cifl9Ee8HouwqqlJTRYR47LE-o2o6ATVVQ>
    <xmx:ITt8aECu3MzwOmDdZlveJDqfB30rfkKbjH2KWl3M3fk5oyNKhCjMxQ>
    <xmx:ITt8aExUpILHz32VEdFupFkxcla4yZw-97X3UrU0R9hvG3KEFnqdUONW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Jul 2025 20:41:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] rev-list: make "struct rev_list_info" static to the
 only user
In-Reply-To: <fc4da804-37ed-4425-8dda-14cfcb607906@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 19 Jul 2025 14:36:04 +0200")
References: <xmqqa551127o.fsf@gitster.g>
	<20250719063551.GA705356@coredump.intra.peff.net>
	<fc4da804-37ed-4425-8dda-14cfcb607906@web.de>
Date: Sat, 19 Jul 2025 17:41:04 -0700
Message-ID: <xmqq4iv71yov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>>>  	 * NEEDSWORK: These loops that attempt to find presence of
>>> -	 * options without understanding that the options they are
>>> +	 * options without understanding the options they are
>>>  	 * skipping are broken (e.g., it would not know "--grep
>>>  	 * --exclude-promisor-objects" is not triggering
>>>  	 * "--exclude-promisor-objects" option).  We really need
>> 
>> This tacked-on bit seems funny to me. Isn't the original more correct?
>> The loops do not understand that the options are broken.
>
> No, the options are fine, but the loops are broken -- they cannot tell
> what they are looking at is an option or an argument of a preceding
> option, yet they ignore that latter possibility.  So the word "that"
> is best left out.

Or "... understanding the options, which they are skipping, are
broken", perhaps.

> I also don't see a connection to the struct move,
> though.

True, this has nothing to do with the main theme of the patch.
