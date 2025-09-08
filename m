Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E5189F5C
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306356; cv=none; b=jRev1rdvBfbdVkHrLCYownwU44WoBhNnDFgR2wjlMM3fHCo2PSsmqgBW0JwLhrsPzDAes8vqbLClubOEmjWKypqnj8h20qvziETMQi+dvr+OITvnp/QoL/Q4K+msALlI8zwvSyjBS47qsg8zcfyGeqmDRfeGiGyQqSyBHzPbrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306356; c=relaxed/simple;
	bh=tH6ov12f0kMFqlq+QsBTVR11xHYdyhWUwQXywfXWvhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7xWtTTQEj06cGIfWy2s/bzYtzcYgvObDzqj28YOgXZwU5DdRJKWNzddkmhKtHhaEKuvBf1h6mt3v/EG4S9EO0NMIbTeguFvl45FoQxOPeMK4KUhbfsnypQNNWVmrHTazIw7lQFMMeSDEL6HifrNiCnRe7wvuaXG1qZSJWYl/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x6FK7z01; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5ISaX3M; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x6FK7z01";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5ISaX3M"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E0328EC0179;
	Mon,  8 Sep 2025 00:39:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 00:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757306351; x=1757392751; bh=AaUyAd/XZR
	xlHGHtuNUZBxYhhLitWm833fnVXn6uc3g=; b=x6FK7z01GUem+x3PHzhbj8P96q
	JWpFZYJCYp2syHtT3gx7zS/B/QLlwQptKTxKM1ckhfASAbEyrIYbZbWjKWPbLuHT
	GH84YI4RLsVDLN3PsM6pKmu9aAKt680WweuAFvV9OcK6yT4/yeNwCGbZSLCnPc+4
	whyzLoV1DeZBFOlRJHmpewJsVGPJqtp/nBwkPzAh+GZeVpROommQF5zaCI1AAbhE
	wn4GRlXnOQchGOwsQxm/VPlx3RgqKSWBKbZLisPnBMX2XGngdo2KoWd8pk8LUhRs
	yJJG16E60YCQsp9qtgip3P4XpObGNO1DV2ZIqrciXPZgzNrDjjot9Yfo0HIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757306351; x=1757392751; bh=AaUyAd/XZRxlHGHtuNUZBxYhhLitWm833fn
	VXn6uc3g=; b=b5ISaX3MMJA/+/3iBw9DzAhydodX3fUjJinZhqugLI4TvAVQ1Jl
	jYALR39JTclj0iUfDNUWKeJwNaAjua+z7yvSBuqrSYnXqkQASQOHRqqT/RLV1x6D
	XBqaRKprUE/BWYSlxOZM43BGm0RE+dQGikmkO1ezgo9ELeR8SKMHSTAMcEoyk/sk
	ZUx8eWLUyEL6tL7pb+svmxAOBILl0qNg8blMMnNvJDMeibzwqTN3L/8HO0+FPv6J
	XUk5vK21NZ9ydk3m386i7SbKZkBGFbmUlROjNRyQ2TvXJpq65tb8gECUCpSJs2Em
	iRkMWDW61373BXzAEnfARwSrgJ56xyFokqg==
X-ME-Sender: <xms:7l2-aFkI8jfq3mZ3sepDgrTaguM-miRPaq8AeFKqD1bWOzU-ebMS_w>
    <xme:7l2-aIZTK3zJhWc7sjY3Parmlew8MsQXp8wte76eWGixycN0FeXjnUIOyvuYulaP6
    2PFfDqJL2a3KzbmUw>
X-ME-Received: <xmr:7l2-aLT-rxl3ZNwsKqPeNhro2jaUuOgtFgOG19YAVLXOsa7c7VcRhamFemzpGBhvwPrlx0bFtcs9vJsEhjIs7Wfd6GPdnYJBQeWbrfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmh
    gvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7l2-aCWKaKjZLWqK4bMJyUkVMgsT5TlzHvPdTIGLtCYLI1fdtf6UbA>
    <xmx:7l2-aKaXDSXoRb13hQqSV0ulriCH7Evnij0J0AoO2t3q4T7AmGVkxw>
    <xmx:7l2-aL7zlp1B-2qlZJScIibt9boOZICw4elqBIZlTiTM7sbSPZ_G2A>
    <xmx:7l2-aLyXZqWT0oB-SAHSFrx6r9X6y-sgUhdBbKxImelr9TXaQRuaoQ>
    <xmx:712-aE6mTtA91phoMleElVgZfgO2u8y7z16nCIaw4oeN1yNMbTJBbNk0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 00:39:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Christian Brabandt <cb@256bit.org>,
  Collin Funk <collin.funk1@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  Sam James
 <sam@gentoo.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
In-Reply-To: <8A7DBC60-286A-48FE-A3D3-CAFC11FD3AEA@gmail.com> (Ben Knoble's
	message of "Sun, 7 Sep 2025 16:07:17 -0400")
References: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
	<8A7DBC60-286A-48FE-A3D3-CAFC11FD3AEA@gmail.com>
Date: Sun, 07 Sep 2025 21:39:08 -0700
Message-ID: <xmqq8qipzhg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> +#[no_mangle]
>> +pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
>> +    let mut buf = *bufp;
>> +    let mut c = *buf;
>> +    let mut val = usize::from(c & 127);
>> +
>> +    buf = buf.add(1);
>> +
>> +    while (c & 128) != 0 {
>> +        val += 1;
>> +        if val == 0 || val.leading_zeros() < 7 {
>> +            return 0; // overflow
>
> Hm. I thought overflows panic in debug builds, in which case
> checking afterwards is too late? Does unsafe change that?

This code is a very faithful conversion from C so if somebody does
not read Rust well, they can safely refer to the original in C.

In either variant, the leading zero's check asks "can we shift val
by 7 bits to the left?" _before_ it actually shifts val (and or'es
in the lower bits of c), so the "overflow" check is "if we processed
any more data we _would_ overflow, so we stop before overflowing".

IOW, the code _is_ avoiding the "too late" condition.

This is a tangent, but as many people pointed out, calling this a
test balloon is misreading.  This is quite different from what we
traditionally called a test balloon, where 

 - we were already fairly sure that the construct is safe, but
   wanted to be extra careful to smoke out anybody who has trouble
   with it;

 - hence we use the construct in question in a place where nobody
   can compile it out, hoping that anybody with a system incapable
   of handling the construct in question would be broken badly,
   reporting the breakage to us;

 - this is done with an understanding that even a single "the
   compiler on this this platform with more than dozen thousands
   users cannot groke it" would automatically stop us, causing us to
   revert that test balloon code for _everybody_, refraining from
   using that construct for _everybody_ until the situation changes.

This thing is different at all points.  We are not "fairlu sure that
Rust is safe to use for everybody"  Far from it.  We are confident
that requiring Rust would break known people.  We are doing this not
because we intend to stop once we know of folks who would be broken.
Far from it.

It would really be nice to find a niche that can be a new optional
feature that is not essential to the functioning of the system
implemented in an already modularized part of the system (e.g., an
optional merge strategy, diff algorithm, built-in textconv filter, a
new ref backend, etc.).  Then we can introduce Rust, knowing that
some Rust-challenged systems will not be able to use these optional
features.  What Brian mentioned about two-hash interop feature,
being only available on Rust-capable systems, could be such an
optional feature, and if it can be done that way, that would be very
welcome.  If we can have Rust goodness soon enough without making it
mandatory in too short a timeframe, that would be ideal.

I already said that I find 6 months advance notice to folks on
Rust-challenged systems is way too short to be any good.  If the
only reason we give advance notice is because we want to make an
excuse of cutting them off sooner while being able to say that we
gave them advance notice, that may be sufficient.  But if we truly
want to help them by giving enough time to them so that they can
help their platform themselves, by lobbying, fundraising, or
otherwise campaigning to have usable Rust on their system, I really
do not think it is sufficient.

Thanks.
