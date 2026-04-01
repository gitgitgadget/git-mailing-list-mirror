Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402F315D53
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081596; cv=none; b=ngVQG3JcGj5PjA0WcB6SQUazsYr0S1I0SRoEH6YGqhuYjOKNLvTsz2GY90GWFbt1Hze4ef1bD6ph/wgx58c5y411N/gLWcjx1zVPqFbK+P8rQR6BX2auClKFL5Uj7D3BX3/h2AdUZ7hukXrgQbV87rtA6OVi+WVWWr3GD9dpTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081596; c=relaxed/simple;
	bh=T7Hdkp5n1IkJUbp2JC6TCsGVItoIymu0+VthCscqiMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uw5uNd46+4HnImWygxsL1AK5lvtLv6BbrMqwhn/kyetT3V3Lk6ErQcVBNZOzWaHa9mbz547pfEvkoDUIQ4nV5/oA3k5Q1EbmTAxOiabeJe0ZjXJCbpDXBABiIdQe5u5zlq1RMIGKXh4aOfvV2DqgN/DIKcwKa/WX74EPgHVMcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q+0hcS1L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EAVUemxq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q+0hcS1L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EAVUemxq"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D96FD1D0016E;
	Wed,  1 Apr 2026 18:13:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 01 Apr 2026 18:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775081593;
	 x=1775167993; bh=NVPWgnMek4akR1HKFhv9LL+Vw/bGTN7Pot+x+VbNeUM=; b=
	q+0hcS1LTq+hqjdinq371afRhmdKZSFxeT2HOrP2YtpUsrDF03mPCBKBytgb+iCO
	6D6pf2cJBjNuJzw/1cCJGcKRt6+lqpyiVO8Hdb3Kxq4j4ea5CulYeKJyQxhamten
	cQKOLOP69EeFRiGxqtc2OK/hm0nFSVNBE7JbjEsuC8v5WgkYndcj/YvAldc6PuBw
	mGoJ23GaliAeY53upqzQRG91Y3Kt/OLDeSdVnF4Uswxuww0mXphZ/ZnFdNxQjVXx
	TATG9ia84M+HvFGi+lnc4zFyuLZOhL+s43ifuY9q0boWGy7rOABEYRa5jIP8iLAq
	dayEFSZF+PcEOb8T+dydwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775081593; x=
	1775167993; bh=NVPWgnMek4akR1HKFhv9LL+Vw/bGTN7Pot+x+VbNeUM=; b=E
	AVUemxqktOXEXT6fNzgSEnrHM0v0No34b6g9svb7k170AYcid77DXTm/SosIIacN
	0z347lKgipH5b/HEkVC9m8HCEwai00k6j3QEbAp/9wM9Z0Yh2fakozq/YNDjYLpa
	QJ5Re3lVXPaqvsR91/Q5z7tWv7o4wQJSFQIfSeKL3MDtwWw7fbdRcoP8g6SznVyS
	fdkCxCmkCRBFSJk6IUiwHVQrXGkyVN85E/grUpiT7369Kgkuxv8jfkYZOWHgXoMt
	M9fozAjy/zr7gyWOCkqv9kYe9nQANh3bZvmXWpeaAVh3VNyofnoALV5lnTSmI+iQ
	6ImGagtdf5aV1uO0xLCHw==
X-ME-Sender: <xms:eZjNaeuORO_rfFKsvefdvsrtW5Uwyq0941LEGDiQ-IE4P2CV06kizQ>
    <xme:eZjNaXI9rfpROHFc7vD-YXkNpGubW5IRjCet-_TRS62_gLoJayLsC7lsnnKx1jClc
    bfVpM97MqWIRj8Lg-Xbyv5moMQwPFDRN1h1sBK69Sg2LKLWmvjy0Q>
X-ME-Received: <xmr:eZjNaTnw0iohLP0rzDMzpEIE-0x2cdgTYLWJPiv6Sb9pc9s9L7kT0rtmK0JFCS_LY7QzvU8un8Al-nukO94j-yZ7jhjGF8H5AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkh
    dusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eZjNaQLuHIapvSsfidsIBKjpaO3KM38Jnqak0YJaK_-9pmuaoktX2g>
    <xmx:eZjNaQ7ydKTIukJVfDWgx3PcLEbkDvZTFCYCMupIWRi9vWspua6AYw>
    <xmx:eZjNac3CW-_swaq-8DcCZvHlbFPBDXGO4tp5cU-ZRhHaz_3d6CGlOA>
    <xmx:eZjNaeeVGsSeA1nKu6F1GmcZn2AjbCilT5HR5GejJl3tn0G8DrfKGA>
    <xmx:eZjNaQLiqnhwUfgRXJ6x3HQemYDheEjz7KNFZirhBxpI3EArSpQotEi7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 18:13:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Collin
 Funk <collin.funk1@gmail.com>,  Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 08/12] skip_prefix(): check const match between in and
 out params
In-Reply-To: <20260401192423.GA2905896@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 1 Apr 2026 15:24:23 -0400")
References: <20260331233856.GA2327197@coredump.intra.peff.net>
	<20260331235017.GH2328529@coredump.intra.peff.net>
	<14a417c6-fc80-4a7e-993d-57fff10896f8@gmail.com>
	<b77be594-83b4-4d9b-9f89-569f1f335d61@gmail.com>
	<20260401192423.GA2905896@coredump.intra.peff.net>
Date: Wed, 01 Apr 2026 15:13:11 -0700
Message-ID: <xmqq8qb6uy6g.fsf@gitster.g>
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

>> > > +#define CONST_OUTPARAM(in, out) \
>> > > +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
>> > > +#define skip_prefix(str, prefix, out) \
>> > > +    skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))
>> > 
>> > This is clever but it changes the behavior of skip_prefix() which is
>> > documented as not touching out if it returns false.
>> 
>> Sorry, I've just realized we always take the other branch so this does not
>> change the behavior and is in fact a nice solution to the problem.
>
> Yeah, exactly. I was curious if the dead branch would be left in place,
> but gcc seems to prune it even at -O0.
>
> I also pondered whether:
>
>   (*out = in,out)
>
> might be a problem, but I think it is OK. The "," is a sequence point,
> so it is well defined (of course we would never run this code anyway,
> but if we have undefined behavior in the code at all, it may cause
> confusing effects).

Yup, the part I like this the most is that this is still well
defined, and the never-taken side of the ternary will not cause us
trouble.

Very nicely done.
