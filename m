Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C02FE054
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643026; cv=none; b=Pe76YmkkEd9GJgdD28x4qAjtZUn7Of2I9iTL7h5ZgVwHvf5q1DTVWI3PlRYzSSP9qIy8UYH2aL8AAe3UBhBmWkUJJ/2bZdko9QAJHarj5UQMmZ3w+YMD1qrOAT4Nq+e47aPQa5uUy2hqNIbJ1Cgs6iTD6ggRdwXuIzLC3Of4zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643026; c=relaxed/simple;
	bh=+Wx4/g1iEMzJFf+FCmA/zBhJGGWcAndtrix9XVEgxEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNOVSjvIggKD/FCmmF1aJxJov2QBJ9Ck8Au1HQ9OZTAtEmCNgDIzfccBvP2K1mgjblIvF3TSjkuIBG5CaLaGCPg/Q5cbikKWVYjwTw4A1DS3tVIdvSYb4BL045grE/MZp1uwFOTVjrmcXgMdNcTT4a0boLZ5KWUZkbcyQxndOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MS3zjGnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/KstqZN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MS3zjGnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/KstqZN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2717214002E3;
	Tue, 28 Oct 2025 05:17:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 05:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643023; x=1761729423; bh=/lTDI+GxVm
	rCv+CDJw+Ly9t8mN191gAxmHA2coALi7o=; b=MS3zjGnnwP67zSrwklVuLXMsJ8
	vAoS3QsT2tWDQCZWWKF28IZxKysQqwyzmmBfyimU6hgwsyaqUsxAWVdTij4j23k4
	K5jMLkcsvjQYY2U/1JddgUyUhIAZjuGmnN5i9vByZtYBOYUVioScPhDpHWVdZ66k
	hEX04dHR6fNGxzU2wKdWfzoCskBUfhsykgjPCbPoL0QgdaPT/Up430FJOzkSRQp7
	ZoVCTc54Sb6aCwm5cOz1/7u3fNjQp+PpbiPZxWS3Rt4SKGnbPzfj7/E8I7615ATJ
	AqbJhIX/KQubHUrGFsiaPnuxCuf/XuIN2DMkRFhYcVAkVv0iP4rSmjlYovQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643023; x=1761729423; bh=/lTDI+GxVmrCv+CDJw+Ly9t8mN191gAxmHA
	2coALi7o=; b=H/KstqZNXeerrJiH2jMAG60FXILQjB6hiqNmKJcRwsCW0gr7Vo3
	dKACmyjlVTdQm0i+HzgW6mzCwhUoXGIsRdHUyH9DcFlLAHGivsGrMqqHkBN5Z9Gf
	kyEuN9Y7yhfibJwJ2XAkdOE7UrT0LMOmhrubHlsWe3m/g5yfoUpxel/qOqGPuKca
	pgL8ESa7kaYzlrfeUA4seVzKhmsC6fQyZRaCkOxBU0mihi+2hPA/lczC0hLhDry7
	FBY4W9qllGNeiD6jiU0g5Q2IKcZqL3lc69ljqdBxorbrYiXs+OHtvuSeMu40T2Cs
	5iUVV4W9nr04VXVyOFpbvKm+OnqIVWK64mA==
X-ME-Sender: <xms:DooAacdXzX_Dj6TOYicehhpbGhtOf6cJuAXFvLr45kXQWgRmPIEIKQ>
    <xme:DooAaVPq7cekEv-dyzmflZvnX6H2xS7PwBIScEjq3a5YIPotP0WhFL82j6VERiVVp
    NiQznjmdGC0JjmSGZopcPQD4KM4uS-6K_q8_IYBg-lvfqScckDJ>
X-ME-Received: <xmr:DooAaShlQU195PkY4NhKRGhcIo75ekPaOZDcAf7GHRH0yuhjbit0lBGwxnMAbQOEGLSBjKrnBIUnGZeYVEq9mdBbnXbdwsgGvW7BXwMLlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:DooAaQ0Qum_xV_7lI0OO9dqi289nHvkACFj6WnPC5MVxDZVYjw6FrA>
    <xmx:DooAaUi54XvMSxJUWgCYIh09m63KDFDUqljLxeeW3Wcq9MHnESMFvQ>
    <xmx:DooAaYfhiBi3MaMWDwiiXcBrmT7KDP-492PaEsJfnLSyaArJxuYW_Q>
    <xmx:DooAafljRu95wG_-CHhU2k87i2B6_vsBkl-oyo7zUbaQB1wPFHfG1A>
    <xmx:D4oAadl7Cgy4vPe6DKi3gKE_i0uoXkJKPDPN88PQ4B5G8kxToPWSX-_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:17:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86f531b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:17:01 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:16:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
Message-ID: <aQCKCfuaEKBArD-g@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-4-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:43:53AM +0000, brian m. carlson wrote:
> We currently use an int for this value, but we'll define this structure
> from Rust in a future commit and we want to ensure that our data types
> are exactly identical.  To make that possible, use a uint32_t for the
> hash algorithm.

An alternative would be to introduce an enum and set up bindgen so that
we can pull this enum into Rust. I'd personally favor that over using an
uint32_t as it conveys way more meaning. Have you considered this?

Patrick
