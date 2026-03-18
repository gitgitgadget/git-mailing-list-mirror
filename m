Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF4331218
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862829; cv=none; b=j/J9xtD1P3L2guMyL+YOaWGqR3cLEeH2Vu4EaGF3Hgbk4HWKmxFPdmpvwDQkFUQJKRmSUIYFES+R0ym3k7ekLZkASgzOWVSFbNngKRQA81wnIaTIhSNcUvLQ581lVbEMW5bWbXSeoqMjf+kX0LtgM9XbUtfu452Ig7zaJNnAPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862829; c=relaxed/simple;
	bh=2SDbiSik7dSln7d2pdr8TmbqiAY0602tBcdYIejSFr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Faz368JCVMWF+ZtByeM7UsBLqqZ/9F7z11daJiZjEpbr3GJBtWJeY4ZtrDEP0ZUs5ad2vYLFrA4D+iFRWKOofGrqhva5dLvXOrI7ySMkNrcBv/x35tDl19OTA4a9NUrD9SZJ+fa49CQ+SY1Wwr0tw9S4qgYqadD8+lm2xaCGUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5Cxsk6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdX5x2LZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5Cxsk6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdX5x2LZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 52EBD1D001A9;
	Wed, 18 Mar 2026 15:40:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 15:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773862825;
	 x=1773949225; bh=SDJ9xoVFakd4JOrr4R4vmnH/9lMxRFxXcooq3dcdtNs=; b=
	B5Cxsk6lFgKHGtKEHvSg3DJBvguUG3DJBkMwA2uhhpHdIpKZGwEwdqelUzb/XEz4
	QTkeobiyvJ2zY396entI55j9vHzQ/KHnXdwcG85VXhP1vPstrNqFewRHhYDN4XOL
	UQh2pSWuUcf6NeQpF8KPUF8uewYSwHbLAUi1ZwzYzD9Gwl6zvwGw6Kg1Amy1L4bs
	1tP6cZWpvC/kG8ba8jrXdQkblk4N22BgdzsWAQ0y6TJTySWKsulYGSMkZyBl53Dt
	IkmhhJoFKJM2PAQ8k/0B+6RxYetnThLN+yFTK8rYA6W8DKvus6P4CRGxSgvkxPiC
	r3kSzHsD91Yzr8vK4jckYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773862825; x=
	1773949225; bh=SDJ9xoVFakd4JOrr4R4vmnH/9lMxRFxXcooq3dcdtNs=; b=r
	dX5x2LZrLdE6btvAhtTg6jD6NmQicVb+9Tqky3/njoJhX5JybmY3FwZG4VlZOM/v
	sIvLM7ak5M0AQ17fbq7rVPnElR1TEOw6Rqpl9njtAbT/LJEzVWYUAb4Tcsjsm2gi
	bNFirRz+r4L7X1m78TverGADc4YNYIPaAhagVEccqdBvB0lwvfQqaV4MTUfKdYjD
	HfYF3wWfOuUY64S+ZoDCtKAi+36fizW2J88zSp/k6bPIDZXpc6KMDFyRuDUDj5No
	yIZAb0uwvGBLSbN5MEipx6aZzSb+pUKnOfPi7g9AbsOD2eFr7mF8W6PiuqR08Zk7
	9a3SSDSYbxTL+WbvDcgQA==
X-ME-Sender: <xms:qP-6aZca4pvVwVwhzzjU1ubbtXfAYJYfQQu1GrFsmPDNxtua5h8ZDg>
    <xme:qP-6adNzX9Fzz9QEuGMyOhxfgx_USFY_j-9umYpiw2jOpbsUnCHYUiZ7Ku_uIPHUw
    aHp0dERbFKBQ5eOfUeNTyhBotvWtRJbQUDtTBiyuIZpzrT1MDyemQ>
X-ME-Received: <xmr:qP-6adVL-Du1MXaFl7whZxoQMalHewyWqozQ8Uy95rCHOA47yj6FRlGCY-hCg4gnHUrNs-JmeN7eT7Lu4gl4RRPeIm2Rag1qVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhesghhithdrshhtrhhovhgrrdgu
    khdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    rghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qP-6aVy4p_2yUDd5mLAl-7WZMCJWOg7QZTk3CmvNUBri0JZdSqC1rA>
    <xmx:qP-6aU_pVvZKGQdrWuxxSIrkl2Co46ojGvlV55uZBUpU91zelAK7sA>
    <xmx:qP-6aa_W6vHWn_NERMaKZgRANEc29FaogDYal7Iy5LBTbTQ3tS_56g>
    <xmx:qP-6aTXmgKAUZHEgiRQDk4-AF5fsbaww4uAfhpSOfRRd1uCt6ms0bA>
    <xmx:qf-6aTbSMT3mMr3ErMkU9Qydn4zu2Bgtm87YAo2J7JRbOQ50fXREES9R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 15:40:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Mathias Rav" <m@git.strova.dk>,  "Phillip Wood"
 <phillip.wood@dunelm.org.uk>,  "John Cai" <johncai86@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  "brian
 m. carlson"
 <sandals@crustytoothpaste.net>,  "Patrick Steinhardt" <ps@pks.im>,
  git@vger.kernel.org,  "Karthik Nayak" <karthik.188@gmail.com>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a
 worktree
In-Reply-To: <4b2a192e-240a-45d2-92a5-7ab669f481a9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 11 Mar 2026 21:16:13 +0100")
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
	<abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
	<c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
	<bcbbdcb3-9c4b-4eb8-9e70-3eb0bd19b32c@app.fastmail.com>
	<xmqq5x72qnu6.fsf@gitster.g>
	<4b2a192e-240a-45d2-92a5-7ab669f481a9@app.fastmail.com>
Date: Wed, 18 Mar 2026 12:40:22 -0700
Message-ID: <xmqq341xq63d.fsf@gitster.g>
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

>> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
>> index e270ccbe85..fad0b41af0 100644
>> --- c/Documentation/SubmittingPatches
>> +++ w/Documentation/SubmittingPatches
>> @@ -335,7 +335,7 @@ date)", like this:
>>  ....
>>
>>  The "Copy commit reference" command of gitk can be used to obtain this
>> -format (with the subject enclosed in a pair of double-quotes), or this
>
> And now I see for the first time that the doc points out the difference
> already... I’m really paying attention it turns out.
>
>> +format (but with the subject enclosed in an extra pair of double-quotes), or this
>
> I think replacing “with” with “but” is good. But why “extra” pairs? It’s
> just a pair of double quotes.

Because they can exist but they do not have to be there to be
understandable?

