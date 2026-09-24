Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F79359A70
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224236; cv=none; b=oaNH4S33yfoA4EJuVhKJq62tPGZXz6frpuquM1J+kVL1Xj8fUb7vOpeCSZuqCKUTS/bB1jMX7dx3Y4lwBqGHaorhtcymogBfIO5pgfhB+nhOr8w4SLgbX5lvsuZJAvUjveC3ztffMFx02La3+oiAuKJ2UgjyLV2ZmGilT9Ndjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224236; c=relaxed/simple;
	bh=SEDrEuY5NrYFnl5jQxJTMZi8vKaNjHypUKZafAOO3so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AP/UQVa7ZXl/vqBzxGG7sm/QK+p9B+STWH9NE/71Ut1ZzKxdbH3lznziXdM1vWqYs3ckeN39E9f+Rqd9cPgpW4Y0Qu5DmLn2wwXPR7kd/C22qpGq0er02hSkgsxxo2lWyUjlZ1aNFWoq8+bV0Jp9dp6712WvGfuYpIsuEm9AeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rPXI1+ed; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xa1uhqnc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rPXI1+ed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xa1uhqnc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B878EC00A0;
	Thu, 24 Sep 2026 00:30:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 24 Sep 2026 00:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790224234; x=1790310634; bh=qlp81ix+7v
	SfKfotWoEoqCbRBm/4km3cuCeFdZbRGGU=; b=rPXI1+ed1wLZegRnZfAmUzf5h5
	fGDWGe0WMw6JMdQmqm6oH1EW8RFghmgqMlKDFtho42RyoYKThaf0Y4k4wl4tArck
	+gvOvqlA1AqDwwH+0iTaXFlJG1cLqYDtTfGFV2cClTj36dLQexc4UpTCyZSymkhE
	xzTFwtB1dY6BKeU/6hbzz1BNHEEK0jWGh5IIfaEE6XZ7EepulaQDPiGUuh61TkSB
	S/99gaXNdJb8cjcGWDn3fs54WWYh3j7DMk5VrD+Qy571yGE3viXjABelvdO7QnIv
	iPbjgesMCjW2I01PaY4qSuJlp+eLcSIaFNET6TJM6ijinz7085QDhz9sKFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790224234; x=1790310634; bh=qlp81ix+7vSfKfotWoEoqCbRBm/4km3cuCe
	FdZbRGGU=; b=Xa1uhqncBqCdTaoFhCpo67jjOgbJqfzH1BvUwbjHYnMykl7fSVn
	vy4vSF+riojbsLLGrG5OOpP/Rx7m9cY1N+VHSaSj4YM+QiXBO1QZ4vxqgq3Cljwi
	iNhRdyad4FP4yX/SXTmPJFwTZ7T1a7uCphrdnkM1Jw0WNev5ojRrSi2lvpwT29jx
	kOAKS++KlvwlffhObV7d1/AI8JEV3vL+AfZb7QlxtW2qV57SNEsEbaFLUemvJgGK
	tJ16dl7IBqIXcUPHi4KjqcmR086oC73ukQpmXGoz7GcJv6AUqpJWndyehdHXTlP8
	HJwbReg1xFXuvpMxd3lUjeLsB6Rs5LORCjA==
X-ME-Sender: <xms:aqe0aggT8V6iCTIqXxd8kQkwI6FYuFeZLG3EyBDhX8-KIyRtyP6MIQ>
    <xme:aqe0agdC8DC7YEMurCNl8wZ2Ru_5lz6lHN1QdvCqzcdU09kpB1WCUQtDdpMt7UWeK
    kqV888upqiIKVifXJxISxjiN52ZJYnCVg_UkqThCboEN9xPzcqZ4AM>
X-ME-Received: <xmr:aqe0aldvkNbXkwXADhw7XRayQjp64C0mFO2V1csh5ldoZV0Q-fSSD7SSi4UYY0x9necUPlQ2NP385LVPK_vjzqh0sFpWhh-UXoEK>
X-ME-Proxy-Cause: dmFkZTGdeIS3IglfR1u1TzMH0kjxLv3JO5wTCc37QuQf92ReZ1SeDiM8XmxMhIblm2FQnI
    YWNYHfmZvasYLvz7NnHcboiLC1uilojPHUwAfzYqyZ4H0dM6s0SuJfsWeiWZ1rIbrJfFgB
    uytGAVui3iYwW9zE5SdA5ETyj4iNgkjWYlvt/wHmzhOoFANrQNFmlbAhQh0fzVi4IFmpPG
    OQ1I4SiIMpWvc5vjQs8ZZANIZFgV7tC+kc+R2PykIw3p/YQJy64NnW+JyAHlVVLDczfav5
    34B5Fm+QdTNTJoLp6A0cHLL26OSFgKlJ+fodi4vIiDyENhOv2LSu3CtSVfL9bj9Ar97Dmt
    WEWHmrF6tQLtzruNgMd/Zo6ajf9wZdsJvHactrkJlVOQAlalfm6ULVI9pEyE3ROqO1xpQi
    xnNLMLUc5Z4EFQ6UqPtnSWVH7LDkNGVmjt6xcNxWN2BObD5fjdc6/dNvxpWkajhdqxFB2F
    DV74phjH5M7YAgeiHJ04uNGVg2HeaLxGlCU2XTabnGfbblIoecSs4eM+WjQk/xWUtRsAWK
    r9OL5KX4deuL9W9jxJmnF6BgTtAswEfH5UvPz2l2exDJXQmQ+vnbXb2pX8B6JMWFNiYxd2
    nQkt8/gMqoEm68GhW1kfsBAGmz6d8zjKoglklOJwxG8J4nPBtrxJVF7Iuw0g
X-ME-Proxy: <xmx:aqe0aq8Vhh4BXpxgJYJ81Se3YZmh4Qru-d4FL1AH681lJRkWl5KG5g>
    <xmx:aqe0ahnxR6B6aRitGX9EMu4lHhreanZjGurHb4ORZGR2p7264QJpsQ>
    <xmx:aqe0as-e29wWeR57qvtI8j2UzEWFJtNL-y5z9JR9zr7hUkVmdWjLdw>
    <xmx:aqe0avmh17BLlZz_z929oG2RFJUWBl9EYaye3vkHZinnXPlyjGIvcQ>
    <xmx:aqe0avBozdB_4ULmneABll9obIiIlNx34Szl1R07yXC7T-WbZLx2eJ3R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 00:30:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <xmqq4iff5ml0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	23 Sep 2026 20:56:27 -0700")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5f34a5a9-9f72-b725-666a-94798895d122@gmx.de>
	<xmqq4iff5ml0.fsf@gitster.g>
Date: Wed, 23 Sep 2026 21:30:32 -0700
Message-ID: <xmqqpky346fr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As I wrote, after the current cycle ends at the end of this month, a
> ...

It was so full of typoes and grammos because I didn't pass it thru
spell checker as usual.  Sorry about that.  Here is a replacement.



As I wrote, after the current cycle ends at the end of this month, a
10-to-12-week cycle including the end-of-year slowness would mean the
next cycle, 2.98, will end at the end of this year.  Extrapolating
from there, 2.99 will be March 2027.

The consensus in the room was that we want to use 2.99 as a signal
that something big is coming, so there needs to be some lead time
between 2.99 and 3.0 for "advertisement".  This lead time between
2.99 and 3.0 does not have to be the usual 8-to-12-week full release
cycle.

I do not think there was a firm agreement on the date for 2.99.1 and
3.0.  Potential factors mentioned in the room included that we may
want to match the LTS release schedule of major distributions.  My
preference would be to give a month after 2.99 to apply only
accumulated bugfixes and nothing else, and tag it as 2.99.1, which
means 2.99.1 would be April 2027.

The contents of 3.0 should be identical to 2.99.1 except that
breaking changes are enabled in 3.0 while they are disabled in
2.99.1.  Volunteers can run the 2.99.x series indefinitely to help
LTS distributions.

At the release engineering level, I am very tempted to keep the
WITH_BREAKING_CHANGES Makefile knob in the 3.0 release in order to
keep the differences between 2.99.1 and 3.0 to an absolute minimum,
and then remove the "dead code" that is used when
WITH_BREAKING_CHANGES is not enabled from the 3.x series at our
leisure.

So the above is what I have in mind, shaped mostly around the
consensus at the Contributors' Summit (or at least how I understand
what the consensus was), with my preference filling in what was not
firmly decided in the room.


