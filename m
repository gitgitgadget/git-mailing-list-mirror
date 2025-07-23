Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8076221714
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292772; cv=none; b=gHcOA/tv2eLn1eBAboOWqc/QcRvekpV0FEXrGbIb//7ziGu4tR95e6nBmFX3PKQuNXoPYk2jXNI8H/UldYdBn+KAvgy91BrykHpQ4OW8y2Rh35hm32KFS/NZC0ZR7iGKZ4Tg3z4J48xSfZ/kIfAWxTRSxJdHizcX9+kbe3y5XoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292772; c=relaxed/simple;
	bh=E/f5PQJORCc6tjhCh6DMyyyVL6cBldFEuRbVQy972Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vA9iVfnMR1Pr8G0AfR7ILuIPG0IJHpxJuahtNbNIp/hkmu4AmOT5KwIvs6s1sOTcqXvGcYij43YyEChHEn5aCSaIGBjrlB8EfXFwbyiIyQyVZUy50moQGEH0YuAKqhaE7K2xtssG6rckYb/udvo1qPjX/OIcLQa89lCA2wLq37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TjrzQnyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8lwG35l; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TjrzQnyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8lwG35l"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2A3414001B3;
	Wed, 23 Jul 2025 13:46:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 13:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753292765; x=1753379165; bh=E/f5PQJORC
	c6tjhCh6DMyyyVL6cBldFEuRbVQy972Jk=; b=TjrzQnydvBd3RD7HEChSKizdjj
	0NC6MHOSEcJB01k9ghCBzqnDh6/DFobt+utQaOAAJTyCifHY1s1BTMu0HQ+Yja4y
	NSflw/ph0avO/SwPf5xv6aAcmIUCzuxfJHJMHEgHMtR3Hk3cgrQRaq4FCux/Fn7j
	yKeGkUu3nmdz6JSa/qXis58FMOJ1paq8plfcUsSR32z7AxGyA5RnEfIx7aXNYIdJ
	zhyQM2GBsv7K5ibNoTTadBOu8OeHruoX2fIzGVds4TalOt1xKQdSuUTCVeAkiDzg
	mF4HjkjDLEIr1xRcRTdGyYDPR0KUVj6Rz05YxphF+ktwEi+jkBk09aFc3orA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753292765; x=1753379165; bh=E/f5PQJORCc6tjhCh6DMyyyVL6cBldFEuRb
	VQy972Jk=; b=Z8lwG35lFHytyHLzztb0c5Bmc0ogPbi4rkXNGxKdfr0aF6GPGZB
	aHnIdsB/yxoraZfdkkUX/qJbOv0/XU5+DOA/6qxO2EtIJf9/z5eOf4TaiglfXXR8
	6vzsTle/LA7nbI9IKcCnactjPOvWr5ogsFUtKAesnyk+l73PU6/9mdMVnP+3Dp8J
	EQH3KGRtFWJ55UjmUkBJ+Gxl72X5SXdJ6DrbbMco90bdAKIBGmV4Q5O2BqYd5PVU
	n8CJWTXHC/ShaSv4qhqHptx1NOwG5XZEQHsutBBo75uhaZsxDMjH0o93mZPOEHNr
	rDLXKOaGyLW4ZjLceG0wP0vj0OOHJeHhkfA==
X-ME-Sender: <xms:3R-BaCfiqnxhH_9dFw2e2rYUxK_nTJqw65nEnlYiK-544yIe6xEnUg>
    <xme:3R-BaJwwKdUB1iVLOxCUjyyTSL-0Z2eDVtPzMKUK8elCyW-hu_bTMEBcWaDmX-osa
    nhdnXu_iCebNLV77Q>
X-ME-Received: <xmr:3R-BaJ9ItWrZZwMAiuOfiipthu15gvliN58JcbXPouC9Ph5JmY4kxjxnw8VAgoBhzVD1xqp1o9T41oceeuDQmmDc5pEfBBOl2vn8uHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3R-BaBiat2p5me6YKJNks4pYNVuv8Eu2LnG4Krtk64lh2mibu3pJMw>
    <xmx:3R-BaAGMC5Vd9Dr2hmY4wSdDU4MwLY2w2-_Xw0OO4N1LzOifq4PVsQ>
    <xmx:3R-BaA_eeThxDi8wWUAD-4skvlZYBKz_cBP-ndb6kGGP8E7IIZbhxA>
    <xmx:3R-BaHwBos-8lSl4v4Ses-wRT_-lf2-Ye0xC-r98m2cschLTgcuRww>
    <xmx:3R-BaFSwt_T2df2ouSG00G6Hm6ZLzuueNRkpOIvmg_73I41xobZCoVos>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:46:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  brian m carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
In-Reply-To: <PN0PR01MB95888028E0BD985DA07B9C60B85FA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Jul 2025 15:45:25 +0000")
References: <PN0PR01MB95888028E0BD985DA07B9C60B85FA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Jul 2025 10:46:03 -0700
Message-ID: <xmqq7bzyol5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> The GitHub actions workflows are failing because CURLOPT_UPLOAD_FLAGS were introduced in v8.13.0 of libcurl, which is just 3 months old, and the CI has an older version.
>
> Not sure if version checks are needed here or not.

Hold onto the patch, without sending it to me or to the list, until
we raise the requirement for libcURL again perhaps in a few years,
at which time we may consider adpoting this feature.

I do not think we want more conditional compilation.

Thanks.
