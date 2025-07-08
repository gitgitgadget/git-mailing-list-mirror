Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C190F9E8
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992739; cv=none; b=OOjV/shvNa/hbhVpYlBhGFBOvowo9sgRqeSwFxb3ZdK4ivW2IGzOEwHHDhrdcuSWfFl+uzxy4tOzM/vM/27Zna72G8jpBoXOdOCspreY5XP5XtfJDznFBkge6mQ9L+IkgwvU0eLKY7O4H282CCljQGQ/IJ/j1CFnx0XPqbfwoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992739; c=relaxed/simple;
	bh=AkB+meEP5gGeIjoyvOxgRWzax2uMXdkXRdVwSkBxIH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qUAx+/puzX79AanBqYi71IeVWU9+2LI5+vkRiPlkQPpfPpIHaI6ZKbGPdIRzw8x3YYWI4PGCP5+hbTclJYEy1CZGybaB1jLkjEwkjUx98H9EfhdgfXehTgiG2u/Sb+V3HYOcJoyBRir/h1tnx0cR8huUWEfKMyN2UxlheBR8lhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CprwT3zl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cW0i3LTo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CprwT3zl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cW0i3LTo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C99D7A0275;
	Tue,  8 Jul 2025 12:38:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 08 Jul 2025 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751992736; x=1752079136; bh=Nx2M9AtL2c
	bMHByuwlU4TayAuNBUFiRzc1wM/uUFAoE=; b=CprwT3zlLnuWiu1nAKu/mPPJwC
	86svwtCztB0XniG6a2RdVcqIOqIaqISwyMpj379BQS3Xum7dbzwprpw2MR48e8Kb
	9a3DvZgTQ/kggMszf6Wdz1Sl8LmkReOPxw7DT10T3LjdwrvVRiOwxDmH5LT+cI8z
	JWmnHH6aVTYcmJojoEbV4riMJcqXgR3dKMT7+uV8a2l+cbQtQhI4aTOjupWoA4uP
	8hiIwfDgqHYbnycVOnaPz8xWWOwE1+PXFob/4InKCytLVULRAMAP2AvJgFvR3Ura
	NCvF3EMpkR3t5pDPwwZSSwwXeA3wH8s2axg/GqRrRy7WKK+aovfBbNLj81HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751992736; x=1752079136; bh=Nx2M9AtL2cbMHByuwlU4TayAuNBUFiRzc1w
	M/uUFAoE=; b=cW0i3LToJ41AP6Z+UgqWYxeCuHw3pktc8t1Q3lpXJPluooMy7ha
	dbbDwpFJE1Gaw/x1m4RNVSRzeQKWwWJ/yEurgCjD8ogA5OudNuWt9lqd+xGM/3pR
	fB/MJJh01ADWHejpLUaTmP0MQZKKuFOnzsFz2V0GCWB2VUGY+42veHW8irijCywc
	BrVSInRhPMR/8Q0nw8vedwMuhmIAbfGe9aaulNXFXLzRrHHfIbWsrUpk69Na2+3j
	6E8eJoJu6yyWeRZ73bgV4Vq9J89gmWotGWtb67OFyJQYNPegxwR6GhOxIOoljfxk
	SAO42culQhrguXKHAHA2UFTZX6ywTWDhG5w==
X-ME-Sender: <xms:n0ltaLolBprgL4XFHDfrNLaXxo55maYbKBw96SeIVWJEhMwumTnUiQ>
    <xme:n0ltaCgBGbUXGupSEMMZm-d70SbCI5P7htICUUXjb59E9tNOdd_zw50lIuXiuP667
    9aOKemnQO6shU7FqQ>
X-ME-Received: <xmr:n0ltaH8jHGEktz7G_A3iLH55PUkVS2mDDFuwEaRciQ69TRpW5zMfAcvyxbXNOaUpJHb0Dx0BJIVa_sZT6a0fOww9e3RtVAsGvz0o0aE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:n0ltaOVmc_0i-rGZkAnLFKt3C0tc6gEUs397h810GKxEvZS-FFtXtQ>
    <xmx:n0ltaLBDUhvBSeJ8oq7kTbwEJPessbnAuPpb9LDTEX_63hcjrZwRIQ>
    <xmx:n0ltaDHuHVqJ_1fRPsit7h_QF81SgobCVw7ekuYSkV5LUMhyWYMm7g>
    <xmx:n0ltaM5Xts2zTgQqeMHykvLXjMQU4pQS89ONKro3LNsgsGq4Y40Izw>
    <xmx:oEltaDkPYxEyO7YsyowdmGM1z-0TG4fHJ4j3FUt87U6o6rQerNSJgmhA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 12:38:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
	(Christian Couder's message of "Tue, 8 Jul 2025 13:08:05 +0200")
References: <20250618151821.528627-1-christian.couder@gmail.com>
	<20250619133630.727274-1-christian.couder@gmail.com>
	<xmqqbjpv1ucb.fsf@gitster.g>
	<CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
	<xmqqwm8jxoj3.fsf@gitster.g> <aGy82TiRFcij5V_9@pks.im>
	<CAP8UFD1A+eV9hbmp4P3pC71+oSTrtLgxtWGyt++J8a+bk497qA@mail.gmail.com>
Date: Tue, 08 Jul 2025 09:38:53 -0700
Message-ID: <xmqqbjpuwsbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Also if a contributor comes back with improved patches that try to
> follow closely what a reviewer suggested, then I think it can (and
> should) make a reviewer feel like they have really been heard better
> than just a hollow reply right away followed later by less well
> thought out patches.

That is kind of "better late than never".  I would expect better
than that from more senior prominent contributors ;-)

And I totally agree with you that reviews often deserve very well
reasoned responses, which take time to prepare; a response that
comes as spinal reflex without much thought is often not very
useful.

It really depends on the definition of "fast" in "fast response".

If we need a week to come up with a newer iteration, it would be
fair to expect that we can say something like "I agree, I'll fix",
"I am not convinced because ...", "I am skeptical but let me first
see how it pans out", etc. by day #2 or #3, wouldn't it?  Upon
recieving a response at the same time or soon after an updated
iteration was sent, especially when the response is "no, I do not
think so", what is the reviewer expected to do?  Saying "you may not
think so but here is another point that may make you reconsider"
would be too late, so it would actively discourage continued
discussion.

> It doesn't mean that I think oldtimers should have some kind of
> privilege, and yeah they should also try to give a good example. But
> we should allow people to not always behave in a very formatted way.

Old timers learn from experience how other old timers operate ;-)
and I have learned to ignore the usual signal when anticipating what
your next iteration may look like (in other words, interim responses
or lack thereof is usually a good signal for most developers, but
not for you---you tend to come back with your next iteration without
much interim interactions).  But other contributors shouldn't be
forced to.  That is what we need some community norm for.

>> On our team's handbook page [1] we have the following couple of bullet
>> points regarding how to respond to reviews:
>
> Yeah, I think they are likely to be good for newcomers.

The handbook here is gitlab's team handbook, and it may not apply to
open source Git development community, but "this rule applies only
to newcomers, I am above that rule" is the same thing as saying
"oldtimers like me should have some kind of privilege".  I do not
know what to think about this and what you said above.
