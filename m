Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AB1990AB
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388052; cv=none; b=XGUXenMphcIo88sHjH3xdhV4Qy6nrigiTOcSO89CDFXbaJyCWUt4lnaL6/PkNx8c5OPMbyv+AVrgo9la0fS2ZsADIEIDRF7VsL34yXnbqZ1MnSW74ZIXPmsbpFVc56kQjE94rNchQi805OWkns6embM2bIvLJ19wEzX5wVdJ7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388052; c=relaxed/simple;
	bh=iKl9qWTSnyEe6uz2q/HBgRBaBC3uYRr1TL2LoLDUBRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=odVXPrJhEoKZ2plkIFY+7O+Bxk7boIKYbyfIOycFqCOqYd83p0AHBLFqujSnD4p2xgvlryTKnqMxK2icn/27OXjnz3MIcGEKg5vtdYyYTuRI7zTSeXLYNF6eD1TcWEoSRFAJjzEB1hmGnPAj+W2lEkVuyLbWhCrLJyg2uoq9ZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cu13qtFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZrfMxia; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cu13qtFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZrfMxia"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49E6C11401A1;
	Tue, 12 Nov 2024 00:07:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 12 Nov 2024 00:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731388048; x=1731474448; bh=9hnKmx5juT
	SayQbqGXSTmIDHUplaibnl/IJJXaP86GE=; b=Cu13qtFQsLto5E5Pt8n3KlE9KH
	6OV83TcV7QS2zOLhhvT3Sh0Dbdju3l2vi642NcxuN266mxLgvf7jcw6Twmxs8YOs
	EKUqeInUuUiQo0zdm4C2CFyh0TuZx4xj3z5LGymdCWV5BDHfwRKHA1jadNW8WNLT
	+5jNDMMobpBGziKQIpL/llgGovl7tT0+2cwxGsxp+PSsoU2MxEmQzPgIFUqnbJM6
	Kxr/EzPmDQcWaKYpTdwuNlzIzfh3S83jlBFAn5H0LJksq4jWeJ2aRsInIOMhnDi1
	DrJi6sb6ztE//CnJ3r16N+MAscJd6/yoFBfUhpLKLwDKR1wTUmabQj89r8xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731388048; x=1731474448; bh=9hnKmx5juTSayQbqGXSTmIDHUplaibnl/IJ
	JXaP86GE=; b=mZrfMxiaHWa4HbXMi1DXeyAcB34b696nGe9NIV3rLwPEUCE0uk9
	6JqyASVZBaBb4+riB/KbPkTydTFytyaw88iAh1OQJNXyaDreIWVmVYU7l02aKQo7
	2d5UHKwQZQuoEcI7lCxRGzVcsPSu63XUij7BornJjnEjDfuepl0s0R39bSC+inoL
	353ObvUxcHk1e848a7XATy+7QCSRidKiEfQRAH3uai8/ac73cAErfN+W+3UXngIw
	dpvMspweRz3pG9WJHDfrMIOcL1wkDM/hagcIVhQe0DJapXcSQQwqaSMtC9ifObwP
	Nh/n5G7UE0cnLPNtIlWNRmJt+dc9w1T7aNA==
X-ME-Sender: <xms:j-IyZ1J8CZvkNZ7zh7ZFNwR5gnvuBQgeV1R4H9hjkgsCefXUXg5Qog>
    <xme:j-IyZxK3SYiQ5QFG_YE5VCm9rlMUPvjM4vIjd8lz1XpQaSZojjTr0Xy2RjI1Ya19n
    b3zArFBkjBnkeyIrw>
X-ME-Received: <xmr:j-IyZ9t21Zl83FuPM0mGXX51IJ_PhMPv9mPfXwUz38Ro4O5V6NGwiYM7PWvnOHYErpAdu7xc3iMJ8_6it6VFFVV_aJQTLcl5Rsvl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgr
    hiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:j-IyZ2bJcwlGVDCB6-0koBTF_2LKOGcuGU2HUgjgeWhfoaXNAp_bvg>
    <xmx:j-IyZ8YoimfgpwnTPO6ELOfzXqHKZYHnVL3hnhyOfooq6pR17o6-5w>
    <xmx:j-IyZ6Dc4wGIzulP32iVEy95cf1lh1VvhvXQvxNUnbv16mCSH52hMA>
    <xmx:j-IyZ6ZBWhwqHY8Ubw6fmuphog0IAh0AsCujRJLe2K0STWKdMpoKuw>
    <xmx:kOIyZ6kPRu2X43_CrV9mjTTVO8EhKPFyDXvwUp6nhsGhb9t0lJvnQfhk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:07:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eli Schwartz <eschwartz@gentoo.org>,  Patrick Steinhardt <ps@pks.im>,
  Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
In-Reply-To: <20241112045224.GA98197@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Nov 2024 23:52:24 -0500")
References: <Zxv4osnjmuiGzy94@nand.local> <Zyi7PA2m2YX9MpBu@pks.im>
	<ZyjlvNJ4peffmGZ1@nand.local> <ZzHeLlYu8Gwk1FPj@pks.im>
	<20241111210629.GB5019@coredump.intra.peff.net>
	<bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
	<20241111221320.GF5019@coredump.intra.peff.net>
	<f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
	<20241112022104.GA77521@coredump.intra.peff.net>
	<941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
	<20241112045224.GA98197@coredump.intra.peff.net>
Date: Tue, 12 Nov 2024 14:07:25 +0900
Message-ID: <xmqqwmh96nw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> [1] I think my gut feeling is that these are questions that Patrick
>     should be answering if he wants to sell the project on moving away
>     from make. I know we can't expect to be spoon-fed all parts of a
>     transition, but I am starting from the point of view of: I am
>     perfectly happy with make, why do you want me to switch?

Yeah, that is a very fair thing to say.

Even if you personally (or I for that matter) were not 100% happy
with make, it is important for somebody who has sufficiently gained
respect in the project to play devil's advocate to say it, and I am
glad you did. 
