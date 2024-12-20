Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB7218AD6
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709844; cv=none; b=mDpAPsB4N32eVQ6lPrdyMWk+H0nHr0xMl9R5VZNLPKPL7acuqBya/6LzWZm7HSKnpz9qD5XDd9wK75vGV9psw/OBqWgv3GQMVRo4HIBv+le1Xs8ssDuvVD33vegDRiRTMHLoiEIogjo+NRD7Qngei5qlLtY2LZdGCTeK3EjDsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709844; c=relaxed/simple;
	bh=g4mLHn8cVQ1PfQ5P7uEj8MXecDvvewIifkLjjaphxds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ciXG7u++dD3DE8l/3bux866CE2JoVhxK9qRAaOvZXL1ACyFi+rBOaJYij8sYo0MnouQPtbo+Dh6S5ea95qIo8kKSVlZ9XquLhBHPgFnWcfFr0M2FwriBEwVsWjhN1ZFKhoCL2SFpCBO35n0hEDGMDg9i/qwYZXXjYzOPT+WVnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s4w5NJuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0sDW9DU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s4w5NJuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0sDW9DU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2247D11401EB;
	Fri, 20 Dec 2024 10:50:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 10:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734709841; x=1734796241; bh=FrLAPNC9Hq
	8N4zr95IQlTKMmM9V3PEnW70IHY7LEDiE=; b=s4w5NJuPSBy7NTTpeq5vwaAnzh
	uHSrM6JUCMmxfKQKdl1OnTwMLOd36CVZkvNCqy2CaNBEZfiIOWmFCCX5m9pCS/3I
	pyl0NwxzPHBOGPEiv0/LMHoOOFVCMoxu1Bhm/Oxzeq7KbsL53u3h+hDqb6o4pw58
	69dn3YtWYMyQ+t+Zz1KK3zx3Lb1D6vutT6B40hG09khlKib86VG3PTjEB1H1kRBB
	srr5BU5YFo9quZh8uaplZujY+Pkmn0auQuBhHmeaQca//TLbpaIoI1Q24y/XBW0Z
	mWvtLLOOQnzP7trzTJnWKMZnDtr2mKLeCStfkbaov0CvTYo1TXoVqbubXRGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734709841; x=1734796241; bh=FrLAPNC9Hq8N4zr95IQlTKMmM9V3PEnW70I
	HY7LEDiE=; b=Z0sDW9DUAr/lQDw0F2I0S0rAYDNRIWO50McueIBZcpSMJMWNRS2
	1VLKLlP99Py6R+aqKlaFDFEux9971fD2bjvNBBPYWwY2stYr8h4PO0VUgCTPW0HQ
	Ptshm07Lm5ni/iAotMWY9Y0SIDlNnT/A+l1HoZ01JevHxoaPCRr1sOS92RRz++1a
	LEO6536E9DysQc8/+Oz1BzLC72v+favtiOR5qvgq+obvnDGNnwMngHVWXkKqzIe8
	hgrIQNCLzP7FdjxldyGdVt/QLl/8tlkCODzyrioR9+/h+CSBfiiKUSRDXSZGSJz+
	wQpfoqFcM3ejngXEgXKiPOp6Oh50xDTNIoQ==
X-ME-Sender: <xms:UZJlZ3AJshmoQu6DaMdmjjJuejsmsQ44T8vdyMAFinRFhoMBc_pFbw>
    <xme:UZJlZ9jAfgAa7hyPz54gIVJoXEqAw6-ruVWvc-y5WYadjWHzlfcRF89-ibVjhbJt4
    Zua5t7ZWoi-B1F50w>
X-ME-Received: <xmr:UZJlZymEuiVWxexRRfb13IihJEWBEJ6fFzl_-i7mfdZDMQKo-w11HMPHnqFLdn6kSpf6EFskjNT5MMcYqyhZemekk3Jvbj5vTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggrnhhivghlrdgvnhhgsggvrhhgrdhlihhsthhssehphihrvghtrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UZJlZ5yH1kuGJ3sVtDpMXlBmdDZJoiIYIo2uuIvFIjWD9QY40SybTw>
    <xmx:UZJlZ8SpQZB6-6Fd6ZmI27Duz6_ktw6R7-I0-Gr-CzyOUeUUblBgVw>
    <xmx:UZJlZ8b8EWTIzQ8e5Ft2qIphewfYnPrUboozvXm_W3Tf3zORDknACg>
    <xmx:UZJlZ9QV6PFR2Rh1XNAnGj9nzy0qia1J--YsxbQNStA_ezw2PbmrAA>
    <xmx:UZJlZyMLD32Z9YevMjG4xP605HvKYIEZZgaFfSto4HRHtFLNmZIq3wS2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:50:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Daniel Engberg <daniel.engberg.lists@pyret.net>
Subject: Re: [PATCH] meson: skip gitweb build when Perl is disabled
In-Reply-To: <Z2WKnAh2BVWr063E@pks.im> (Patrick Steinhardt's message of "Fri,
	20 Dec 2024 16:18:01 +0100")
References: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
	<xmqq4j2ygzwk.fsf@gitster.g> <Z2WKnAh2BVWr063E@pks.im>
Date: Fri, 20 Dec 2024 07:50:40 -0800
Message-ID: <xmqq4j2yfj5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I don't think it's incorrect. The Perl features are those that the Git
> distribution itself uses, including all the Perl modules in "perl/". The
> gitweb subsystem, as far as I can see, uses none of those functions and
> thus the data we configure in case `perl_features_enabled` is true is
> irrelevant for gitweb.

Ah, now that makes sense to me why these things are laid out that
way.  Thanks.
