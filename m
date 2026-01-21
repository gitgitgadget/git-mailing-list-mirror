Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1F423A72
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029789; cv=none; b=usp/fftM7fAZvEcW8z03WST5Jgyf8NvRcPxM0Qb7JSpvfzpCRsGrRHvSzxZMc7OAujNSVe2iErNQY1kXjseEJr5CXkVkpnkKfm6e2q7/TMTbX5Bu8nE56kFBaxZZn1jxJJjrOC3vitJudw80hXphQgm2F1w3k+fnL+Hqq5NkfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029789; c=relaxed/simple;
	bh=SEGXBYREDphGKcivHpT327geGTvzMiM9Hm1j8jCidjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1XOTDUskz3w2OYGnrZQ6ECr0ePlCh029RxrYdEslURA4DLj+pYbuteUppAewGDQXPYXPmczyJQh+eLJmhVlSk/rSDxHF7CSd+38qzyhZcVVq0fMl9zom0N9+WCBH1kBONLjatXgUSo8RWYfOPgTkw3Bw8OLrmfpnwD9jVEHCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zl/wiezV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVxnRjxg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zl/wiezV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVxnRjxg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E433C7A00DC;
	Wed, 21 Jan 2026 16:09:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 16:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769029779;
	 x=1769116179; bh=Pqos1RC5StIGzncGoGsUze+XO8pp2JyVvfQdL2cx0Fg=; b=
	Zl/wiezVX2IylOw7JS9pQoveA7CusaeSET8j+TvJHPVuu6jlHJ7KJxDWjkzPfZh4
	hTPehWmjCcKYcH5vuG5XWDA01DqDhXoopUOeza2pkdfxdrnGl0C5C9MFo/9VUJWE
	cSBB/lvSdo8QaR4cLM8RYTwYsD22Api56mznn7tnTbqRBv5dQkTJB4Opd4sJaagl
	pipOEjmKCc1lT1dflubb02y3pWnAXUUP4XCkP4S62q5pYlaAXsbwpjiYoJg4zrCQ
	rwx+m/r17htJIgj8PxRyjbh0PemIEyskJsNK0ZBzFNE+WurUBlQ3Wkir6ZxfMnBk
	87dQ1Ej31Lv6CfjaeNLvDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769029779; x=
	1769116179; bh=Pqos1RC5StIGzncGoGsUze+XO8pp2JyVvfQdL2cx0Fg=; b=H
	VxnRjxgMozO6OJVfbs1pblzUfZxEloQ77iTwKFqdaTvK9fdvHeR6Ef+DuWVJpC6w
	S8sK0PPEJJFDbTb8QNnxmf/N9vYMHe+I4yyQz5k1AQ3z8wGGL9rDyjC9IvfqNQWo
	3ePrOx30dsdIRNqM7HyaX4CMqyl1XIvirdMR7c3h1e1pUu7QiCmgdpMcYNrtp2hn
	fEdHLGW8uB4a4rUq44Uu0dbX9AqKKqzpSpJAcuVYPHE8LTMGLYf5kkQt6tIdyyml
	N4jDXkrvYs0nrmgEVFQJW8cUPJZdzcseAxkf1LoOPM899po9U7JWowDBiO9y24mY
	Yxw738I8JXhWmODzF7uoA==
X-ME-Sender: <xms:k0BxadkMZQi19f5Yhdcd0MDcY_b5TqF0OsbC6U-a9NGSYE-CtQX2Hw>
    <xme:k0BxaftUyn2t2yBZV4m5C0vQgTxnED7-PB_U1OgBoFpw1PEGuNwE1Hdp83z2ufiEt
    -5uhrM4TzHk7o3P4Nd0ImNjZ7L8lR4yOExosARNFY9jAZCrjpgucg>
X-ME-Received: <xmr:k0Bxab9D9vtvg5PAr822Q3cvOvOoYqi4BGD4gkBuOzCgpRSB3sGq8FTIaaDPK7fClgaujtI9h1AEXIjnVHVHM9LldVYgCAzTzs8tBtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgt
    phhtthhopegrlhhfrdgtlhgvmhgvnhhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:k0BxaZOcbSR7MfDQWw7hxCPByowAI9quY-Jz0LYNz1ugVW5nIEjHsQ>
    <xmx:k0BxaZF58QNV0C8irnfTsBaWDzjACV7lrlVwDg7FAq9-NXHYHICrJg>
    <xmx:k0BxaXRisXSvAxq9ABRN9Alwr4HxSO5zwGIrWxQZmWsqTTQ2Uw5UGQ>
    <xmx:k0BxaWtrJL8FMqj-DCM8mjNV2ysXdZ6Ew_jx1_whrKtUsIHoAv9HcQ>
    <xmx:k0BxabsDzAutOZw-DvfrJfuUUJTL-3SWDpdVHufUDgzZ7DAiKm-nwqMq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 16:09:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
  "alf.clement@gmail.com" <alf.clement@gmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: .gitignore issue
In-Reply-To: <20260121210312.GA723458@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 21 Jan 2026 16:03:12 -0500")
References: <SL2P216MB1885CE309BDBA65860D8762FA296A@SL2P216MB1885.KORP216.PROD.OUTLOOK.COM>
	<20260121210312.GA723458@coredump.intra.peff.net>
Date: Wed, 21 Jan 2026 13:09:37 -0800
Message-ID: <xmqq343ysmem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> On Wed, Jan 21, 2026 at 06:51:02PM +0000, Pushkar Singh wrote:
>
>> This is expected behavior.
>> When a directory matches an ignore rule, Git stops descending into it entirely. The pattern
>> 
>>         backup_STOCKS*/
>> 
>> matches directories starting with backup_STOCKS, and once Git prunes traversal at that level, similarly prefixed paths can disappear from git status, which is why backups/ no longer shows up.
>> 
>> This isn’t a bug, but a result of how ignore patterns and directory pruning work.
>
> I found this explanation confusing: surely we would never match
> "backups/" itself via a pattern like "backup_STOCKS*". And I'm not sure
> what you mean by "similarly prefixed paths".

Great minds think alike.  I was writing almost identical response
about backups/ being full of backups/backup_STOCKS_{1,2,3,4} and
nothing unignored in there.

> We can't know for certain this is what's going on because Alf didn't
> show us what's in the backups/ directory, but one imagines it is also
> full of backup_STOCKS_* directories.

Thanks.
