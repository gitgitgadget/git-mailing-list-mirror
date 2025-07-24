Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76422083
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376469; cv=none; b=oF8DYbptCaZNHH1jxfpgMbLE7eem6BIqrqGEC/K+TBGyvq59eCTwS0DZWP05jeuzea3ndHq2mTm95/6rVRTJaisb/E+IaH57ceZNpbM4ctkARIscHr8/LPfimVy3OhHCJeCma8wc4aIteG7bDBWrfRvjEdeQvzjMYIdTVEupxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376469; c=relaxed/simple;
	bh=saafg8xRxwZfRCcci/ojnEnpWC7Z8O+GmzxpcoJQOxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGbGDq91FbCpf5V+3oZsT3lyjXcmIH40TjtzR8DOHAY3bwkDnd7ugn627jiw/MWt5oOcNlTGQqqgg2Aj6hheu265AGKeueXWVUPRr4dwyd1LOmT1bpEA2p/ZoYWqEHFId+rU11E/8DHFbbAty1PO4ClleZ/Q2SJjhVPXHWrwL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gpwR6NoU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8mxg5Um; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpwR6NoU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8mxg5Um"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABEAD7A0A4C;
	Thu, 24 Jul 2025 13:01:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 13:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753376466; x=1753462866; bh=U6rk6J2io/
	Y33X2IKrjt/1Ko/xrrH5h7RlSkF6A7ZXM=; b=gpwR6NoUyrkzcTwOPivfmUhgAJ
	+8Rym6gWG3j/L0q8KSkhXcNszWsCBiH6yWCVnShY28ZXf+n/SAPuL00ziH3U9L0i
	at2qU5LVm57fHfvLrtffL042aTig2jEa/Tll6K+VqSNZXnKdFDi5BbEH3ZzVjYIP
	kIHFuVce06KaxwZOyeygysAXljYd7srHdYxwi6zzYPZyEDlWe6u9oS2DAaA7/TVP
	ubnhHtoooa+segMIuLfNeosV7/OvD0JJwi7t8l5TO4H+UywT4Dy+1Aa+aBfHUhc1
	kTi5gVuyYRkbuaNnLUalQA3JamYlAlMlc1RWm/+yUTLJyM0WHgqKlhSnVMVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753376466; x=1753462866; bh=U6rk6J2io/Y33X2IKrjt/1Ko/xrrH5h7RlS
	kF6A7ZXM=; b=i8mxg5Umjriyapo1rWcZt5Om6cREkpkPjLh9xPtw7ea4tZaDwGS
	arPPcgsa4HEz5K6dn8MBVksukCHhrF7egsRyMWsOG7ot9gF7BN98QR+J385UC6x/
	o6qhIfGunEy990qOwEt2awqBO9UwWWMsg/wAvhRCRzx+oU94Xg9Rc10H7qaAEXTM
	bA9VjTdoHC4bfe2DF+XOvwfHYLLRn4Z5d4DnB9sD1J78HjlK3x9hMDP1IwKSIGvK
	iNZftT00HcIgRFEMktgB8LFT31V5+CgfpxWSxtnFChTwIEHkHSYzX/yBP6RlzW1O
	3HQJgZqCWBsdfNnlgl/hl5xnc+CMVXOpsBA==
X-ME-Sender: <xms:0WaCaO8KYdvevSlr_WpQCNBv-OmnWS4zaW71PiZcBmR7WS3YbWkshQ>
    <xme:0WaCaLk2lnWShLb3gx-YqkmEHkprVKdDY4JRy4F3RxdOFE4qEcYc265FcjIj9EjH5
    WIL4v5E44s8G0I5vA>
X-ME-Received: <xmr:0WaCaDw4OPQZCqOTa2G5ASEkNyEo93WGj3_ahGzDe44GvLpQSP-772AgRGyeSB4KwyNwcRSoka7ewdUEImZoyQNRPZ5DA6R66zUlfMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0WaCaF4JRt8BRRHMa2YVOOt9lhzNEizWOrZJqIjeK_ALABLiUt4ufw>
    <xmx:0WaCaDUnhjXFJnweGmlJt3IM9iyg1A78jVX2eU9xhwpc9SaotdE63w>
    <xmx:0WaCaNJLOzXwMVvbjsSGNF7Rior6p8-0ABA_jjTlTcfE-RPY7i3m7A>
    <xmx:0WaCaFvbwWkH0yOym1MJbzxncO2Q2A-DsVHnTGM6IpjHUYDHw6tKpA>
    <xmx:0maCaMo2LuB6m9oAy-0OpUjDfjCGczMhb_c4suUQGFPqALC7e1PY5TC3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 13:01:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  schwab@linux-m68k.org,
  phillip.wood123@gmail.com,  Christian Couder <chriscool@tuxfamily.org>,
  Kyle Lippincott <spectral@google.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] ref-iterator-seek: correctly initialize the
 prefix_state for a new level
In-Reply-To: <CAOLa=ZRr4fpF0E8EM3nL37aSYzcHyCNnv5HzBzisM4C0UQUx8Q@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 24 Jul 2025 04:12:21 -0400")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	<xmqqldoelgnd.fsf_-_@gitster.g>
	<CAOLa=ZRr4fpF0E8EM3nL37aSYzcHyCNnv5HzBzisM4C0UQUx8Q@mail.gmail.com>
Date: Thu, 24 Jul 2025 10:01:03 -0700
Message-ID: <xmqqbjp9ikvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>  * I had this as "fixup!" on top of your topic for quite a while and
>>    forgot to ask you to send in an official fix.  As Kyle's
>>    discovery was after the topic hit 'next' (understandable, as
>>    their internal edition of Git is based on 'next'), we need a
>>    separate fix on top.
>>
>>    To prepare for merging down the whole thing to 'master', I wrote
>>    the proposed log message to help expedite the process.  Comments?
>>
>
> I had a set of patches locally, I just didn't get around to sending it.
> Will send the others, omitting this. Thanks for doing it!

I do not mind discarding what I sent out at all.  I actually prefer
if it came from you.

Thanks.
