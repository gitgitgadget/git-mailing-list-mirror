Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914F48820F
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846474; cv=none; b=XMZK5RlVQ1HU5MG3NIpjHwQ2bKQ+UVTESb9TLi+gUBEhHo1h7mAfcavFzl4sVkZa6OnmVMuetF37InnodSTVr3361wmd13amU5vyTvje0YJXYUvnMPgROmkn6OpHa0d5lmlD1iqRsShxo8OUNd/nXK7G9gBUqPYngJK2EMv/upM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846474; c=relaxed/simple;
	bh=kXVfemNBZ1Z/lwLYnmHpS7XsYy7SzdCElGxwLA0PTqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VsAYNyQ3YPE2ZbhJR4r/w1XaM1H7e8zoZv5if5k4PxUNKKvMi2kneHYZnyOVTHVwG/sfTLHjZBYew5LEQwkD/2wkN79oDZZ8/jtts5KYW5Gk8PJNuERZ0hOLBGTFT8hzeZoxWmGEI7vQsPZ22pFzmd6i3xVo+3+uxn/9pmKYri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kBisUTUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BzhS62xJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kBisUTUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzhS62xJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2E1D1400166;
	Thu, 27 Aug 2026 12:01:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 12:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787846470;
	 x=1787932870; bh=EvnAlmQCediRDIHiAf8WDzGgFRrujtsG8yaOL0BYlsw=; b=
	kBisUTUBy0sF7M6kQ2X+PqFLNYvOQni2+gM6pmMB4c/dD2DA9svKWqDbNEJO8dp+
	nWhcl0JpIngXuG0WB+pgADdPK+XGIjH4WolfyaP0qASOm/8s1xvMuOi/aytICk5L
	GcsPVW3UahF6z72qTtCePbvwf1Vdq0t1y6ePAtAx0XbeoiHVFnv0ejmpi8IUw2qJ
	sq5MQ/J8OA1DL5HCweZa5mRqLtLkdeGaTyUP9Voiq7WKglW9OBHrU9np2l1JWY2o
	HTJ2yoAZ/3s8c+jaX1Q1bg6rvV8XyzZWPAVFVt45fWHxeeBod+QkRp1ZE9Tt9eBU
	3M8NE3ZS8NeLSJsjzNzaQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787846470; x=
	1787932870; bh=EvnAlmQCediRDIHiAf8WDzGgFRrujtsG8yaOL0BYlsw=; b=B
	zhS62xJLfVgLyq7Pigk6J053uSU7aclSqkSwzoZF0RtgeejO7SyBB9XfMrEsJCS1
	Xjqfq7SR79aI6d/FiJwdinW/qAqnzmkVWft6XmtQKHbyMqmzLKoN2dKlCDuYGyes
	rAJJ5iQzE92sFlhR7KTkOWt0ZNSkknjR0Yp54gclRMhgsHnyUKX31Qa3AEnFFkkF
	1SURmUCqXXFwvTDPe+9SprRY/AoU3e1UgZuQ25joNOhzJDbRqQAnsD3EVPD+92rR
	EDq6VXYu9k+0Xj79WZ5U6WWwyDxTzDpmaEhBxQf65U7dhUf2wUOlwOIlIh0Ne7Tl
	WdrgeLDauBVg1PqSBWRUg==
X-ME-Sender: <xms:Rl-Qap-CViSryaS27myGH25acRRnqQETkDv0EDyvyRDxDNhZJVqrGQ>
    <xme:Rl-Qakle8Zn6L7kuJRmRWfaqn_QGyatvzCIbO3x41nLjrrQ1HHhXgxQoV-TlMlBdQ
    bYtNN9kFKWPkdqsd0PkvpHPjbTK5AUjVjmoAL3GIny4B4RF0UC8Kw>
X-ME-Received: <xmr:Rl-QavVN2ULjBY8dPkly7BIL5kaGWuXGkzoqCiY5cYgmiNlGldl6HZXFuIx7sYeT41dcTYxhf6MFhvhXf3AsjpEgv780M-gq5A>
X-ME-Proxy-Cause: dmFkZTGdaVrGWUrPqivybVsqg1ixMvmBiUt8IXaNDYzGG8qfFH91fBaww5pUx/b/MfBhTC
    3GFCD/CtuCqm0c/vDTknz86Hsrty1FeZkY958Wvf6lnf+1PZ2TrVzvz+gGR+0b83Ir19N+
    AITHYsJgJR1uOL3CJRM0UMCKR2VRpLKi/suKO06ObEvw+e8JjKyeHZ5fOgCtP/JSNZX4pH
    HFYrGzMFTdRJMNp4xn4aBkIITm19gXSa7/0QdeucuvoPEi3ltRNI7eNxEm2DG8j9qWe8kL
    qEPGTfKE5g4t7XHRSmFXdjp1ILlMjqzcaUIsOdBW7RfcfZuilmBB9MF4K8S/OI2BIAvLnD
    x0JoeAC2oyHN4uUe0xeNEBX1dH3+0sRp2bSdOCvwUy3jjyLuAl4THX7pR98+bhhmosDHf8
    +IvnBpHbqZndNy/T2QC62Yel2k6ggWFESZP2UF5iWw2j/FTiqkvKkLygSZla6p4PS5AWck
    uUDdzs1DygKqYkNziNCAaZzuXoCR7ELE4kak4XTKXdBHyJV214Ibg4jCjOnDH2tF/a8f17
    GdB0CX5bbIPoh9x48yAm5i0aarlRyhMvhOmdtFWncOGFyVUupV5vIVozWmHD3zWDhKLe09
    P3+rGzrjB229zrsODH0Eck/5j3wKMRaqY5y35TTgH7mEJAlCr6F8BrT4Z4tg
X-ME-Proxy: <xmx:Rl-QapF5DYwetnnGKE9UWmTcY_rrMcesyzWXyGU7RQgmq8Qq-IM89A>
    <xmx:Rl-QarfFtsHdyZksWKZi1O8cCwFV_UPrEAFqaDSpGB2FaD2XH9Pf2A>
    <xmx:Rl-QaqLyJKvKY4sdfogOR9e7DWXVc0NCxEmSs5BqN760VUixwKQccQ>
    <xmx:Rl-QagEjSpD39Qzdb0yK6ErHPYKCuECCbqBHYXBpDAeP5RvQUQM23g>
    <xmx:Rl-QagUb_NpWyl0V832lIz_Kea5TTeyF-rumVQi_NVgLkx3YDmJ30cOJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 12:01:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Michael Montalbo" <mmontalbo@gmail.com>,  "Elijah
 Newren" <newren@gmail.com>
Subject: Re: [PATCH v2] you_still_use_that(): reword the instructions
In-Reply-To: <cd741511-b457-4464-aab0-56d8554bf763@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 27 Aug 2026 08:49:27 +0200")
References: <xmqqo6epj6is.fsf@gitster.g> <xmqqjypchixe.fsf@gitster.g>
	<cd741511-b457-4464-aab0-56d8554bf763@app.fastmail.com>
Date: Thu, 27 Aug 2026 09:01:08 -0700
Message-ID: <xmqqecfjbliz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> I was thinking that maybe the final bullet point could say something
> like
>
>      ... and don’t send a message voting for it to come back because the
>      decision has already been made
>
> But it *could* be mentioned here instead. “The decision is final ...”
> ...
> And I also bring this up because the commit message says:
>
>      and [the message] is not offering to reconsider a decision that has
>      already taken effect.

I forgot to respond to this part.  Yes, we could be more blunt and
explicitly state that bringing the issue back to the discussion
stage is way too late and unwelcome.

However, offering advice only on finding a replacement should be a
sufficient hint for any reasonably clueful person to understand that
it is far too late to suggest a reversal.  There will always be
those who demand that we revisit our decisions regardless of what we
tell them, and those people are unsalvageable.
