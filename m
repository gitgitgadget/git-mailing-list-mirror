Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AE801
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100843; cv=none; b=s0T8ADGnOJJ/pv/Ni5p5EiH7fXro3RcaX8AzBs4YRUaKTWj2TSMYqo5w3P+IJzGlY9Mi6te7mvyh60pBOHDltftiFsguu/tjJRXlX9jYVD0Rxsv9yxrnFJ6WOoUM7KFqcxjEOTMSJfx6dw4Rgys/Rn6bpkJG5oAq3kJXfzMkubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100843; c=relaxed/simple;
	bh=bxZrT1e/UASSviaWtw3G32fBHEsb6VioJpBsOltLLZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LO4gKnxcmZrYqBcufcIUCZTqJUpiqHdScKPnxS/5cvJ1KQJB/bRbroaZh8y8R5+pyJs1Ztcwkz0p9pR9N8AXdwEU3ce4Y2Pf0WKr9OSDAjuE+FeOJ6sygnAJ7dg0uYDK7i3Fh6uDzdcj/+xfUPKs6URRyXd6uvILqBHdu1uSSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=saoRsQHd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIBS/mp2; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="saoRsQHd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIBS/mp2"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 309691D00217;
	Wed,  9 Jul 2025 18:40:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 18:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752100840; x=1752187240; bh=lb+xSseMv9
	LomDH8+Z2vdwvA170CX8juPWTbc38wZ7s=; b=saoRsQHd4lh2QQ0So1TLkfo7Lz
	R2i5ulXFKPPJf/UENcFop9526zmV+06LSDgJK4KlQWgbvLAhF1BafWt1tJ65FAtW
	p0BHDiUJr1+zAEJAJUOi8xO3J8qH0Vm1ypf0qjnIE5MZy11LvnGbJI9ruKQFw387
	onhkJjRxsrDNWPTlXghcJcCeXYkuDGBrZuUjsuQYwfAIAkg0Z2OowCkvnEvdttCF
	yMSpPpYcrKiRC99enbJPlXqTkpF2BigOmhXiuz5m+MRO2Sqkfgxy6CWnXkLyhofM
	9Ul2i4oSlcSi/JYpTJRTst+1nb2O/d9vWKN0jXQ2YbVzVtk6Jh96e549SHwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752100840; x=1752187240; bh=lb+xSseMv9LomDH8+Z2vdwvA170CX8juPWT
	bc38wZ7s=; b=LIBS/mp2tpTFXaGSNiAfxzoCLn6S4Fw+dD06hbVtzf2Y2A+uW1v
	MnTooEU9eObz4IBXzZfUvJyc8+SqMESFk9NUKhieelffTXYph0SIr1Xv0+hePJZP
	fyDRvM964BlIoTBLoRd9UDivV8lJbsxASznsXlhQkn1jbVc5vU/SjhCHscAzpshX
	+ySYI6EOSswBONStMxSCKNwniaSvozL8YAg2SGiDxUPWzQY88OMpMQbFppj2BFia
	tMW21JAzn4qShfRsjhZKldwtYGXTf+zBpeUe3Qf/a6/HJRgayQFhdmwju70y0Kg2
	fK29vVz1kXN5SU/NT9070MuF1a2X5iJhSVg==
X-ME-Sender: <xms:5-9uaLhyXb7LzWrSq3JKY0IaPIXvWQ13BNSyj5A_yy4tUQl4JZKboA>
    <xme:5-9uaNO2uXw02i2K3ejdTpMkZf5vIq-dz5jYGBy-VLSa7g9y53bR4EucB1UPXB8Be
    xDs_u7aARB3VvN8Hw>
X-ME-Received: <xmr:5-9uaL9nkFrXJyeg34e0DK-k8Yw-ffAKnIEMm4gH6De4THQVskQBCPbRZaQHY_w8iUU8ee-x3DPz_TEZfpXdNFJpRKh_wz2u_dEKdEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:5-9uaOcWiRW1Y9Osd5Ka5Qeb69w95Vquq1-8EWWU2kznk5E3rU7BuQ>
    <xmx:5-9uaKwqmvfRo6BEJuOyFD5qUFBrVgK0xcyGTEpEyeQU_ZhZjTAL7Q>
    <xmx:5-9uaDKIqPQWZq_baY2ObQMEVDwoOEXmmr8FC9UENzBPljhP1aOTkg>
    <xmx:5-9uaMGew411lHfqvKt8eUCW8CrOR41wXLdGL01iAzULANbi3jLTUw>
    <xmx:6O9uaH7C7v2NFjx098GxF2Z8zfvEHtNZPowUZwZCZnmscUXM6Wau-a66>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 18:40:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  irecca.kun@gmail.com,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/8] meson: stop discovering native version of Python
In-Reply-To: <1664d442-7985-41b7-9391-78f78ece7601@gentoo.org> (Eli Schwartz's
	message of "Wed, 9 Jul 2025 18:22:46 -0400")
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
	<20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
	<xmqqikk1pfiz.fsf@gitster.g>
	<1664d442-7985-41b7-9391-78f78ece7601@gentoo.org>
Date: Wed, 09 Jul 2025 15:40:37 -0700
Message-ID: <xmqqy0sx9ee2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> "python" may be a symlink to python 2.x, or 3.x, or not exist at all. I
> am not aware of *any* scenario where a distributor has re-packaged
> Python, "python" exists on PATH and is a real Python 3.x interpreter,
> but "python3" doesn't exist.
>
> I am not aware of this ever being an existing real world scenario in the
> past, either -- it is not a "we no longer live in the bad old days"
> scenario.

Good.  Thanks.
