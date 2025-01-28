Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6393207
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022473; cv=none; b=hqRWTF3njn22XomAmoBEdiy8qXN2QVNOHp54xhhI9NBbeE5amSNGtsXuda1V4Agr3G2SMi2YiOBK45nwH+3ddchkS94s/kkjtnnLazXl8fsn2W5kVmoA3yyPmjrSmOX3sY4JXxEQFKqAeZ9DrE4QMmxoRbz3J5bsA+klwC9tTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022473; c=relaxed/simple;
	bh=gIsMyvcfV5IUqxdVxD7Jk3W2lNyQRZVFoEeumg3k37k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPRwumhKh6SqberxkY1mjcJ+JFw2XbWRyWYo70lxErB42BNc5b9I7pF9At3ZXbTHfRbosIWcVnUkqHJHn9JgOCcUUpLB5R4Jw4Jj+cQHYRaADcRJOmGrvFoUX8Chji7geYXdnrGuPGJ6U8Kb9LIN9rTp4wPihCf4C4vL399nQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PjaYNCsw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1HYiLcP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PjaYNCsw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1HYiLcP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 140AC11401C3;
	Mon, 27 Jan 2025 19:01:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 19:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738022469; x=1738108869; bh=DROa9GshCQ
	uASz23enrnVsL5gNKWmk9+ahNfHeQsx60=; b=PjaYNCswW9w2ByC+X0IJGUP3kY
	EoVYzMhT/6ER1eOYk7UsdnqsCBWJzxBjGgumTP3sm/jm3pKiWLFIJt00vEIECA/V
	uBqD4XhVeX4K736Xw7yLxY1jJe1r/Jl29dA91TUjA6A8jNaVq6RYY5Wto2QNVCoW
	B5UkSmIPv6Nb73ZA2wSTD9R++jB228aD4xRMGHlFlG6a3alXoXmyGM03pmvsPAwo
	R7sJtCM6Spr8BxDbrY1XTkA4DUiYx0mY+PcMJ/yN89HDRZvs8CEiwAp9eZRrMSPo
	GSUw4YXSYZmVOO7bao1ZHJWw5KR/Gn8TUTLisCNq4y0Agu1GBKA4d38WcvJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738022469; x=1738108869; bh=DROa9GshCQuASz23enrnVsL5gNKWmk9+ahN
	fHeQsx60=; b=k1HYiLcP0UyNWRxi107yFQAmLp9TT0nJCh9o7aWiZufDinhjWfU
	jJsiFBPKUAHuUEqdJ/s6hi5iivA6otkloXri1DMKKWCIQj9xQ6fZsGv4Z1ono7+0
	WyGWfja3RMH+AMi5PVJtvMHZlFgzGI0TC+ofpA3sl3uoGA5GGytFKPEJ7AuQmWZc
	a2tiE5I9dzSs/sFXW23E/h+JIc3cStfB3ZMTgNlhMDl/P2etXptbB5k4l5puqsfZ
	EiEQe2fTZZr7FqIXqfYGLDxqniZTBQNSI0wdAB4RKvI7OmSgWB8B9oHREF+Inj56
	ZGFu0w4ovmMEqklUDv8pwMCDv59UbPNosPg==
X-ME-Sender: <xms:RB6YZ7zL-69md8n99mqgXTHaBKXBrfHdXPpAW2GvVqPMH9NYOQTgOQ>
    <xme:RB6YZzTDhkgj0OJOaFaOgEgwfGGX6t0_L10UqSkDGOzPymGDkWzATce3gvUaGfkxT
    mUt47wfIFwkaqhskQ>
X-ME-Received: <xmr:RB6YZ1UtEvhxLwdFbe3QznA2sRduBXmurzqlQFWwvuy2VOK6rMPKubMoiPbRlrvhpf5C_SR_rDsLmhpVXGMzUO3TPQ-dwFAwGKs1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghr
    ihgughgvrdgtohhm
X-ME-Proxy: <xmx:RB6YZ1gXt7lZORCHiZIoYypLDAfKo5zWZxjCo_FqnYaVbixrW1of5w>
    <xmx:RB6YZ9DEUaPlCX7u9N95zjQRJJcR5oAYQj5kRKr1GU2s-eIE93rifw>
    <xmx:RB6YZ-JISlHu8KpdUxtNC59MWLNe9gnBAYuHTy1DkTYKVc7fc1imCA>
    <xmx:RB6YZ8ClEfkZHSjjl9zuJioij7G2FYAnuWXl0RRsIAnb6-nTt3vY8g>
    <xmx:RR6YZyJYbD0-KgaY5pjADC9KKc0kUaphZw0EsGAL-kBPJROxic2rDI_E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 19:01:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/6] promisor-remote: check advertised name or URL
In-Reply-To: <xmqqa5bbq0nb.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	27 Jan 2025 15:48:08 -0800")
References: <20241206124248.160494-1-christian.couder@gmail.com>
	<20250127151701.2321341-1-christian.couder@gmail.com>
	<20250127151701.2321341-6-christian.couder@gmail.com>
	<xmqqa5bbq0nb.fsf@gitster.g>
Date: Mon, 27 Jan 2025 16:01:07 -0800
Message-ID: <xmqq5xlzq01o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (!strcasecmp(urls->v[i], remote_url))
>> +		return 1;
>
> This is iffy.  The <schema>://<host>/ part might want to be compared
> case insensitively, but the rest of the URL is generally case
> sensitive (unless the material served is stored on a machine with
> case-insensitive filesystem)?
>
> Given that the existing URL must have come by either cloning from
> this server or another related server or by an earlier
> acceptFromServer behaviour, I do not see a need for being extra lax
> here.  We should be more careful about our use of case-insensitive
> comparison, and I do not see how this URL comparison could be
> something the end users would expect to be done case insensitively.

Note that I am not advocating to compare the earlier part case
insensitively while comparing the remainder case sensitively.

Because we are not comparing URLs that come from random sources, but
we know they come from a only few very controlled sources (i.e., the
original server we cloned from, and the promisor remotes sugggested
by the original server and other promisor remotes whose suggestion
we accepted, recursively), it should be sufficient to compare the
whole string case sensitively.

Thanks.
