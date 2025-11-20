Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA0221271
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680486; cv=none; b=TwvIwNRa6wW/i1v7MXI/fMB5yaIYQA4FmwP8KiYenQOsjrkBPwD3d+GBBDPc6mGudSN3PLixc83o6lUGCkIFWOrqo0y9A/mI4kUIRJAzN9fRsAd/Jvuy/MjHpETiP904ZtnhiYNYv9aaDrPgwQ0/EdW4L6jRz1MUIF8f5OPvNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680486; c=relaxed/simple;
	bh=jfapnKrIOWXzN7xyj8bniSNbs82ibDBVnFtam1AXRJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZGSu+7ERfT1DCU9VRoxjOVO8g2/LOJ4bKl/jWYsDCeRsascPOaRvpLYlNi0q0dPQZkr5TcW7eu63+foAhoUp770aTaopUPnw6Yqu1EN4gQAKal6UF/0/gA1ZgjNJ59bimUnUvYbQVHHRyh7XStQsb8wJuv+vji5hk7Si8lEnlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V140741O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sg+EAZ6U; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V140741O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sg+EAZ6U"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1244DEC0362;
	Thu, 20 Nov 2025 18:14:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 18:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763680483;
	 x=1763766883; bh=jfapnKrIOWXzN7xyj8bniSNbs82ibDBVnFtam1AXRJ0=; b=
	V140741Os1Hs5NnKVZIyfyckbEt8vpb79fCRE5SFtcbyEDiPmAUWsoaJOxxl3UZ2
	xC1Cut+JMTJHzULkwmk1TViHmexKk6LZ8HOVZgRhh1kJF3tE3rWDsMSvlUuRxGZo
	3ZFFF6EItlLnaPLYGwlhD++yqMUDHoPQAHKypP//L6hD7o+ZipLWlS+QNgnswhTa
	Iqa9/y30gSByuAPgxwKa54uX+0JASC4QxOdbcH71hC+9wGuTvMWNp5k30uwlFLwQ
	YQRsJprIQ+pVHMUSALwTHGlRQ2ar4Ow45hvsnRNKTxDzCcJGQPSn5RdLoUvRvdYQ
	doQtL5bNO5/abmkeh9NtfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763680483; x=
	1763766883; bh=jfapnKrIOWXzN7xyj8bniSNbs82ibDBVnFtam1AXRJ0=; b=s
	g+EAZ6UFbsjMRha1OCALa0gJD/p9I6jJH71LKyuFC3ww8wceID1LdXOMqunuF+RM
	UWxrmlUFGaM52Oit3HvqEUNLDGkoJYqbAIfD/Wb/AjXEv/ygw2aS7Q9tfTjSvHbz
	cFC4eAEh8Duqb+9rtOPeZ0KyOGO7cvue9zKmRHfEMYG1lSojKmeT3xvYaqRkLCwf
	VqjPAL3jKlhpVBXZ8yBpRA5P6DODOD2BDlfGXOfqANm0YAEk4EA8YrfoC4Cb/NQZ
	8AhskPfkCigNwKN7eoLvdhzsxTfbjXg4bpwgsChvwfeCNXuNyHwwA15ijv1DBIQX
	qrr5nZWceYnv+0CHpWexg==
X-ME-Sender: <xms:4qAfaYfYIos9snigdFO4eucqhYZLGwZNeEOi3sxoRs7lbMqatP_MYQ>
    <xme:4qAfaRFiAFYhTC9b2I4H2qXzIy8upFbwBiyYigNjMEG9v_0m-1HGk_4Qk3uia3VPr
    StrnIzSdbAh2qb0-Y6zINq-2YtWnofFrxjlzQY0aapi7sCD67V2>
X-ME-Received: <xmr:4qAfaR2aA79dSip_Tto2IMdpDgDwGLZIx6P5cvDsCpKxLuvkD9jrvIcziWJXnKzzFNgVjl2-5TerCf-VU5t66wua_GgW__A4n_Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:4qAfaZnWW09Glv0-6oDqASxTBk3X3adrF14TaARd15oNcnA77-Dm6Q>
    <xmx:4qAfaR-SCQUtAxxHwlemPu4Q8hsz7225oMVQrKS4cvGn6ks5rLqjEQ>
    <xmx:4qAfaepq61h7YhCGCXXhDDLKQaBe0ODSGZEXEUTgAE1QUCROYjYiMg>
    <xmx:4qAfaakJPDCj5DO8RnsE9Cy-5Qzu-qdAqapCENa_TN1PySn9ks2BgA>
    <xmx:46AfaaVA0BXvS5EooOZTxSLphYnsRTxrbR1cXvwtimxbQeaIusnTd5SA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 18:14:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <CAH=ZcbAnnakV4RgMJdkJB4hL1HyfbmY07EF-axDbEY_=_tfmFQ@mail.gmail.com>
	(Ezekiel Newren's message of "Thu, 20 Nov 2025 16:11:01 -0700")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<xmqq7bvsjzlx.fsf@gitster.g> <xmqqpl9h9mgo.fsf@gitster.g>
	<aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
	<xmqq4iqsgpu3.fsf@gitster.g>
	<aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
	<CAH=ZcbAmAqWMYXhYT3bX_Q8cEkV0ZcjEtM65YS7DXPJbs-L3Wg@mail.gmail.com>
	<CAH=ZcbDER4OysywLZpCc=-GQ+rweSfVAQ-xj0gNd1rF4-=cPWg@mail.gmail.com>
	<aR-eIooTkjbktsf-@fruit.crustytoothpaste.net>
	<CAH=ZcbAnnakV4RgMJdkJB4hL1HyfbmY07EF-axDbEY_=_tfmFQ@mail.gmail.com>
Date: Thu, 20 Nov 2025 15:14:40 -0800
Message-ID: <xmqqjyzk5man.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Thu, Nov 20, 2025 at 4:03 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> On 2025-11-20 at 19:52:23, Ezekiel Newren wrote:
>> > Checkout my retrospective review [1]. Basically if windows + msvc ->
>> > <crate>.lib else lib<crate>.a, but it was coded as just if windows ->
>> > ...
>> >
>> > In the github ci these are the only windows combos that are tested.
>> > "win build" is windows + gnu + Makefile
>> > "win+Meson build" windows + msvc + Meson
>>
>> So I don't think that fixes the build[0] with this patch:
>
> You are correct. It's part of the whole solution. I'm working on
> ironing out all github ci problems in my cargo-workspace patch series
> (not yet released). Once I've figured that out I'll publish my series
> on the mailing list.

Thanks for working well together.
