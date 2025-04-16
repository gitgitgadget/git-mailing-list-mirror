Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA71C27
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809124; cv=none; b=W17Dc2ml5uTGpQVliVfN++gxD8cLRpvs7+7Oy7ymfILJweYJ8kd60K/3nHawaO80WyXA6SpgcQN/h2O5p+vWdu3kObbqF0Zjntk0X8xsOk5iN0d3X9BEL7Vpg+Ks/xus36v4mmaCaw/C4dVfxgTEDIddA+ZMrfHY2gc07+2zUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809124; c=relaxed/simple;
	bh=8cRXK62n67lVMk30HEQpWQh+iojCUGEWTepA3gkxSkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvxJUnrXilStwGn76OSrfIeNWQmYrdRbko5R4DXrxRxmrz2guydeUMSqd7epQKmXOaaxcHCEG0/C7k+Ipzm4ijn4vBmw5QMaInxB71Z8KRN7wip+jgpRlyUbCPCZcWsd9OBUXuczOZhi0BiRjXAlHucXDsuRA0ih6C1BfQi7PBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OFC+aTkg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gpiDb949; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OFC+aTkg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gpiDb949"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D819D138017A;
	Wed, 16 Apr 2025 09:12:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 09:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744809121; x=1744895521; bh=ySVDo3rAka
	E8Tfi/IkXDrW0oUZ0AgSHJL5FTymIHSic=; b=OFC+aTkg6/wopGOvbasfoqqgAr
	T39ODSAJId7EHe1NdzjeJrPlto1bVkT3xYf91q1ABYYQKaLtyqcS0JMok+rHd9rb
	RLkLQah75T5ZcONWeOO67j7wJRhuBCBM/0Q3NGmKDhFcZj9n9LV6QA49n7l/trZv
	RjyBjgymuCGE6SDaoCAxctm9v16d8yP8gBan9yUHNggudxh5YAWrqzmedEIZlC7B
	parhTknaxtESYUYTeXmojI3hzh5vQrCv6DS7gA5DIaKHMv6PaU2u5+93QISJ1ive
	N0GbrOtcUV18yaB8IhkpGhEDOysRJ8D4K5IzEmVKEgtRspdRr5rUUY1SHP1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744809121; x=1744895521; bh=ySVDo3rAkaE8Tfi/IkXDrW0oUZ0AgSHJL5F
	TymIHSic=; b=gpiDb949iYypu8voHYeG724WDoqvEavgEwfSc5RPvZy1vxnNOnn
	3kXPpmCQ7mAchUEr58b1qwgQ7YgsSXu7v3hAC4aHluZXkAoIhGZLJMR6hi591pBW
	5kqfO10QnQ5iOo9U7lVo2P+Coo+Ma+gOXF8Z4jfE4wpu0UNONuan0uU+Y9s+EQFL
	EOUCLGRV2psK3QaAZrtSRtOvceW00fkdKnKXxaVjCYSz7tgAca4/ulqzfI2pyXSN
	8RxgEj8S+GnTWA1WfG+JX8eXy291tTXy+vfaoHTNxsQJombsqHwaENFdkjL8X3u2
	g7WjpxoNNwVR0VGjktL7nly/lMlJ9p/0rKw==
X-ME-Sender: <xms:oaz_Z48UJrl46BhRKoA7yEZ27wVMtL7XBxa_T3Dtj6ht0u0TwawfYw>
    <xme:oaz_ZwtXeUleJSgDKGGmUO-n-m6CkVnObK6nKi6AahjniqQ9Zq0F38tvR6Mp0L6nZ
    HTs1pEMYPSKjQG60A>
X-ME-Received: <xmr:oaz_Z-BJYgyaahhloII2c3rtloY2Z2Rf7TZM9_QHaChgbLuBuLLH4vJoYCBhzPcYv_GBc3rRIplKcwalpCrvEcCN4B3YQ9ok9L_u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhiohhtrhhs
    ihhuphgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:oaz_Z4cgnDNwZCe5FKOe0cyBKf3TjN2lE86gebXKm6bpHTAlUuufWA>
    <xmx:oaz_Z9Pnaol9RIuhZWc3DbnF58YC-RTuamexoZxVQhAM0hRsZY9HIA>
    <xmx:oaz_ZynjNsDtVLFGqxTBxf0Uqtp0aOLrKpL31ZQV4WzNby7qM7VEtA>
    <xmx:oaz_Z_sf35GtNxV8uIr2T3rbNtaD4e3P36WxCuI2eXY2UiK7DVKcfw>
    <xmx:oaz_ZwYLaqYng3g2Tq7MBWWBG7NxPEpNZ98thWiFOsw62t-EAHNwusw4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 09:12:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  peff@peff.net,  piotrsiupa@gmail.com
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
In-Reply-To: <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Wed, 16 Apr 2025 07:26:26 +0530")
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
	<20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
	<Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net>
	<CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
Date: Wed, 16 Apr 2025 06:11:59 -0700
Message-ID: <xmqqa58gjlnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> I think something like git commit "*" -m "Test" also would be a great test
> or even git rm command.

Yes, there are things other than "git add" that  take pathspec (even
"git ls-files" does so), and demonstrating the blast radious of the
existing "bug" you fixed, with how they behave differently and
better with your fix, would be a good thing to do.

But make sure you follow "dashed options first, then other args"
convention.  I do not offhand know (and *MORE* *IMPORTANTLY*, I do
not want anybody to depend on) what the current command line parser
happens to do to

        git commit "*" -m "Test"

If you meant to say that a pathspec with glob, always write it the
right way:

	git commit -m "Test" -- "*"

> About the windows question, I think I will see if there is any common
> ground I could find
> But until then I think prereq is a great option.

The FUNNYNAMES prereq was invented to mark tests that rely on
filesystem being able to handle certain letters, so that may be a
good thing to use.
