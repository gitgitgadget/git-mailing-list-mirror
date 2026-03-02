Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340633909B0
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489358; cv=none; b=UPiQsoZy70/XlmyvMFdsJY3e/jqeQIs7+yThAPSorN6yMCX/GL0S6eTpTHUQmWc0pZesHw9KoGdXgrbU0Dzq0+vEcoqrTPB9mLf5XxYD04CLPfm3GYjsbuI6srAqETn/2Yo5hJgbc00OujZpQ/mdOEN4gc28F3nymzmpy8ySjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489358; c=relaxed/simple;
	bh=1aUcUmqxFPmej4yzGWwkfCw+zrk5uyRqucCiy0u5Fg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQdblyvL2BCHg3uvJ4McKHiXCsalLrt1pvMGVLNSuUz+Kk0DCNmadIob4jOAnDsLAcktMrTwt1KH25YtkXwJU++W6+GnNJwTPjZWEau48E2aXHCvB9lmMqSXprF/1GFTT8UVaI+BmIoVhvGZqJOL5a7ZfhbcBlGGgI+SWPq9IQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AwoxaEQs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JfzpN0ht; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AwoxaEQs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JfzpN0ht"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 70C3FEC00AF;
	Mon,  2 Mar 2026 17:09:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 17:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772489356; x=1772575756; bh=mD8NSMr7vs
	BlxxedeGeqgnJwSxrN7l9PGV6l8oFb4Qk=; b=AwoxaEQsDgOEEPKLo4xGY05MF5
	pKy4sXWebmM3+e2jSfpOL5EH3CbqXLpfvvoc/IGVwC9cRIAUywW89PnTWws8b8cj
	NnPWe47Drb4EhlspBKekKEcz9LDszGFHnAAf0+Ds+xHHtGu8SRTnHrxnRmkzX4kX
	t1SNOTwPuGlu3G9ZtkS9+8w6ViAaQ3icrOrM5aY26P1qBk9T0d0ADbMt695IgrW6
	4XkRCIiDIWmEqC0W6EkOcTKiy8UJOQhd2RboRbzLab6Q6WOYrrAO/Z9pvXUhad9/
	F6j4VtOL6nAyTOa7VZqzgjHmFIHV00CAbeffLjqc5VFHgI9CanoqfdZxyeyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772489356; x=1772575756; bh=mD8NSMr7vsBlxxedeGeqgnJwSxrN7l9PGV6
	l8oFb4Qk=; b=JfzpN0ht7yR6UXySgdjnZiPymifZib30w2b57+PtTDITkJIGeSj
	fPsWNCqPCEbiuYObWljJ9xdxE0vrNWvLB617cKm2zsuR/Gh0F5quXiIkUmPnWBTl
	TzuUqmOAGDOpU30cQLm/2NTtUrDRRAmR6VZjv16m08T2XRM4TG7i254mToeLxIIt
	pd6KYdgMOoMITezZILcG0vW9JB9Jh6wMTqLWJalnrCcaIiKORSnKVRoaP7qYnKOU
	O3lWReZByoF30OB/IAWKLveQHdjU6mRtvZPNfyx1PSolUouah/VBgmf/LalZQV+p
	iPtQNYRfOHu8o48oLltxE+FPm+X5JRdRwiw==
X-ME-Sender: <xms:jAqmaVIUiqQuHzpfZbTds6Kssxy9Q3zP5-A0qUnB6KYDaE7REcN3kQ>
    <xme:jAqmaU2UFez78-cz6s7VLdaD9IKYzAv3eHrpdzpF4akM986JyR6B3bPd-9ho8lpLM
    bMjuYrQr4CRaxVf4Y-0AW0i9yOjKMZaS3xM-2ZlGK4lDvw8wXTRaw>
X-ME-Received: <xmr:jAqmaXitLK5_2WRa8SJSJQzunqD7XQERy4FxWxbBMWItA8BkSOLuNKxvQ6bLJxWWQq6AKF9MGQ0_FQ_DK-EYVRGgZkdaN4AqfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jAqmadUbbSus8ViCYdn03IWNJ4_m-dwWHfXr7LgMW8N7BMiDKCeqoA>
    <xmx:jAqmaeUGSEkaKHBvZsCq3D0ClVRlamv0ZBcUJJWJ6c2iJjvkTbEzfw>
    <xmx:jAqmaVjMKGqHXbQfgxWvMq0u-U9lgzoK5-DPnoO9gv1FFlBVkA4ncA>
    <xmx:jAqmaRaIHppAlkIC6Y95RykezGz4mSzl5_4HmwYnR0itpltenfvyvA>
    <xmx:jAqmaUtbxGXDh7vHj38bXnvxRrUzxhFgXcCVJRJv13qu-HOD85w2EO03>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:09:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  kristofferhaugsbakk@fastmail.com,
  lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 0/6] builtin/repo: include largest object information
In-Reply-To: <20260302214526.2034279-1-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 2 Mar 2026 15:45:20 -0600")
References: <20260223174120.2356504-1-jltobler@gmail.com>
	<20260302214526.2034279-1-jltobler@gmail.com>
Date: Mon, 02 Mar 2026 14:09:14 -0800
Message-ID: <xmqqqzq1yjcl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes from V2:
> - When checking for largest objects, zero valued objects were not
>   recorded even if they were the "largest" object. In this version, if
>   an object ID has not been recorded yet, it is always added even if its
>   value is zero.
> - Added some helper functions for printing keyvalue info to cut down on
>   duplicate code and hopefully make it a bit easier on the eyes.
> - Moved the for-each loop that printed table OID annoations inside the
>   preceding if-block making it a bit easier to reason about.

The changes I see in the diff relative to the previous iteration all
look sane to me.  Will replace.  Thanks.
