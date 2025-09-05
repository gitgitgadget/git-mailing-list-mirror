Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B712FE579
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060631; cv=none; b=eonxKUhOVtFJ+o4LpACFH0+YDgfAGipVFfBOlW3BfIcrBQYAGaARPbkGraxmO/qwLmJmu06R2O+rsbPLI0NNJh514xT9bu7iZgZeeTNuWMqL18Y78KbV3M5oa5VreUQ0HmN8DaLuU3XJlOAYiwjrAKCczXyZDlBCZB7AJzjYFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060631; c=relaxed/simple;
	bh=hxEYOzvMWexK38JIu2AFUvT10nCbWx/rHPIA+kV6PT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8p+K8ix+FrTWoHpevkz7NRNzjTA5Z0BuBrOW6B6ptshbRTNzMMx8YyNiTrYnpeo3NF9rAZAodaP09EdjA01qy3TvNOsgRCjDImkfb/DHqyHzskmyFVgbuJHufUmyjTEgjqqRf35l0DB8qB76RONmSWXC5V+xCO4UHpd2NyqqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FQbjtWHe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1BXhPc8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FQbjtWHe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1BXhPc8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEADE7A03CF;
	Fri,  5 Sep 2025 04:23:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 04:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757060628; x=1757147028; bh=KSQ7hEv5g7
	lgbQJXMFXVIirOyXpJpqHtHGdCJMp4gps=; b=FQbjtWHeowWhX8q2PP3BYZU1+h
	UUAqd1y6dPEl/J3zO5q4ZZJpCmTbj7Jn/RZ6wd6yo9X5Kl+BnYkfqTAyXIJQiBuz
	wjdzVL1rEgcDvQsuKDwBJ9o+HCEcZAbsY7q2CeJevhIbkKqqcryIDkiCc6uvwqc9
	MqDu67XKljbOJql6cOFyuuOv+v7Lhm5OgqiHdytBPoyKcdkAvVkSkYE9FafKEpKt
	w/KBbbqkp6na2k4w17E4I9xWVuAc7RMLquEKfSBmDhs38+UjE2K09WxYmSPJr8kD
	rBwZguzjlBQh3tllEbgqK4uOHxXm6spYgiQ+hTQejzoqcykfbYO/UzZhL5iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757060628; x=1757147028; bh=KSQ7hEv5g7lgbQJXMFXVIirOyXpJpqHtHGd
	CJMp4gps=; b=Z1BXhPc8OhWbBBs2Xxd8Qu2tfPs5Z74VrWNFnFYkoAZJLN0KYvI
	azoBiR+ynhpR7xjZJ2ReEpma5EfVxlbyJ2oQRwd0JMq7tvi39ZVKBKfW6B5rJkqd
	9AJC2FD7pCr/lEOeM8qlmibRE61UB2z7misQuqnw/j+GtccqpsYpGTzxu01X3s3Q
	sIvs871LeXzip4jgTFVsfXzCVWqoYrHHt+CQ9vGsOalnlTONyDUYG/JE2pzvSrXa
	QGJeTLXg6Cctz6na4yBQlvhDDvLfQqKOZ6mUlBunmt+n3+Q3y9LXiVuiuWWpm+kY
	uIIKpg++k5QQzSStDNK5M+mSdFFEcv+4aLA==
X-ME-Sender: <xms:E566aGPZhGdOc2AM3TXdHUwkKSmnupvGuCxJU6hB78gS81orMQHOng>
    <xme:E566aGmI7MUxUBaTTlkVI0MoErJJJLMrwZRawV1j4tWjJUZoSTIxnUY-tycIWXDB2
    o_wZFKVkJO3j8afog>
X-ME-Received: <xmr:E566aBVQ0v2k1AZzd6JagluACGiY4fHPGd5naW1Mp4EZKCVHD0NEpCkFZNOkbBd4-JNuGqwPIulujTm__1uEBt4p709A6Em_sWdVkt_ipuxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmhhgrudelleefsehlihhvvgdruggvpdhrtghpthhtoheprhhssggvtghkvghrsehnvg
    igsghrihgughgvrdgtohhmpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdp
    rhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtoh
    hsmhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorh
    hg
X-ME-Proxy: <xmx:E566aNKd7NW1-FfcGN7ZUuIMAF6iiNNIc64gZApHx1BsI7CR1DZ2hg>
    <xmx:E566aNZ6HBOJBdpFfHtM_XwaZqTaLnZpZW2FIflV_P3WfJmSLgWUGQ>
    <xmx:E566aJSEFY04A75D_ddVaEwXr_U4Q3OV8rW34OFLFEmaT1jztn2_hQ>
    <xmx:E566aNh74k-AnWTUFS1Z9QH0qVSi6FwoBoVrsHSxNXcl5L1JnN-Wkg>
    <xmx:FJ66aCa1rY_S7-VIs-v1qsJd3JAy9c8zYFEgD9jd6hGHIdwQgAD3QIDl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 04:23:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08f2dc4b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 08:23:42 +0000 (UTC)
Date: Fri, 5 Sep 2025 10:23:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLqeCy9aKgDk6DyT@pks.im>
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <xmqqms7bchln.fsf@gitster.g>
 <aLlzj-FxXCmBXTQz@pks.im>
 <xmqqbjnqb4qz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjnqb4qz.fsf@gitster.g>

On Thu, Sep 04, 2025 at 08:45:56AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > If we cannot find anything, an alternative could also be to take a very
> > simple subsystem that doesn't see a lot of changes and convert that to
> > Rust. We'd retain both implementations in that case, which I mentioned
> > is painful because we now have to keep both in sync. But if we say that
> > this is a testballoon, only, and that we don't continue to convert other
> > code until Git 3.0, then that might be fine.
> >
> > "varint.c" could be a good match. It's trivial, only 30 lines of code,
> > and completely standalone.
> 
> I am afraid that it is a bit too trivial.  I didn't mention this
> possibility of maintaining parallel implementations, but the
> quiescent area I had in mind was patch-delta.c (no, I am not that
> ambitious to suggest diff-delta.c as the first example).

Oh, it certainly is very trivial. I think for the initial infra this is
a good trait though, as it means that we don't yet have to care about
interop between different parts of Git and can rather focus on the
bigger topic, which is the process for how to introduce Rust in the
first place.

But I agree, once we have the initial Rust infra landed we should then
also gain familiarity with more involved subsystems that _do_ require us
to hook into other subsystems so that we are forced to extend our build
systems as needed.

Patrick
