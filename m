Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB42E40E
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184631; cv=none; b=m3yxhu5KwTn7b6w+2E2xFHDqkmMUAUJtNdDsdEE3tnt6pMQMZ2J0bcsJZdR5Q81gESx3Q48WmV0IvV11Gr5yCk2nScaSLLaZWRBiQojpnqWYrAeqv4aT5Xa8EPmIlei6bYKgW4HzFP0Zws2h0hgI/TI3ktsd8OxLagNm7gjmElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184631; c=relaxed/simple;
	bh=wH65hpE768ROUxfHBNpEkDU2dIJEfCFLg62bwR3j9T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hak6QxgGlD77TLkU5L9oIV95Nwy1ZAsXTw0um2k+Y7QXpzg+njRTCMPfZOeqim2tHvjzQXF8mVJVlfVuZpCSxMBGLGNpZsonAB4zJB7WbPng9qAyS8/N30Ao6qb4koaXqj/PCRkz/eaNKrJ9p5fmsCBNkIGkjyXiyKMawVnmzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bz6rIn89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzoQ3joZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bz6rIn89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzoQ3joZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6C59140011E;
	Mon, 29 Sep 2025 18:23:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 18:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759184628; x=1759271028; bh=wH65hpE768
	ROUxfHBNpEkDU2dIJEfCFLg62bwR3j9T0=; b=Bz6rIn89EiCnRaJegWORh+6Hfl
	B9/5HNzfuoNiAS5kz9/SovBUfLYXNyaDe5Cy7kLuql+D8D8wR7NdqmdcH+p5h0zM
	U/CM0hJYNVpDc1NFMyWs4IGl5HXwW74nZh3/bmOlKh+tKdUE6hjp5bYXaTOdFQpj
	8uUnIeulaZEoLXgzuf9Ki4VTeahg72zmBWyFFclXukyd3O5WhX89KTj6C1UN+a1C
	f2ApDddHD+Ug/k5o9uczs0hsYt890I2IEQVphdraivuk+vcEuBOxU8nUuadNeU0i
	O8jmtC+cz3fgPmnfbiTS2xlCBvbgGUyUdAEAcfvRaHa0wbZdsaGHW8l/9GGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759184628; x=1759271028; bh=wH65hpE768ROUxfHBNpEkDU2dIJEfCFLg62
	bwR3j9T0=; b=dzoQ3joZ1satutqIEd7ZEk5nSstDXL6xrm9+MegTm2AVdIYVhzB
	6gkdPdabK1UtjmNVZz7V52yFFDEhSjtj8y3gTFj1hLICEZaHMTQE72Dez5kh0oBl
	ME3mpokyBVl902noDece58ZJkQj42/78CeWIZWQwMocG9VWLdrldUiUx44RrdyIy
	XzUQqDlViU+/pb4Os4jYXNTe+zxmulKHRMKYcJoq2W+WO3gJRdBmS3LYTy9NNxrE
	AW+4YtzFf4PWUOrRsDQFKxz7a9Xaf5fXmvPq0FPkUZSZ/niFkoyJFwu9UXigZjaf
	l32uGW3RBX9lYT53vnGU2Yfb2Vh1afEMrcQ==
X-ME-Sender: <xms:9AbbaI1MBJBdhl7gBjQR4YE10lca-LGqgjGO301NjnLA_Bh3PVWUog>
    <xme:9AbbaKg9abgwG1SYu2nvDedBdUUS5edXQR-ZkT89roOmRshAbByeZvKIcly_CR4qf
    af6QLJ8fxCSCMiWq481Qnjmoo-Z1C2DQqCymCyHNV7SEVwUH1lD35U>
X-ME-Received: <xmr:9AbbaOQ4ks3qOMT9ewqJ3FO2m3pIk1tZxQd5-pbctOXz1BT6i_iQuTmTRgQZqF93tONZ9SO1svb3ha7Q2ZvDsN1ekEX_KNJ1tw9Faw5Scug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9AbbaLiUWfm2-BLpXWW1QP40vF1k4DwEfECLQInXQ43V4F6oRVUFWA>
    <xmx:9AbbaO4dw7pUnt2JhvTpuLts3HhsrER2aiXl2UWzoiMT98DC4CBViQ>
    <xmx:9AbbaIAT8dcSonVFxD8SOgz403aPfpxhaJQ34jWkVXKSKkEOxwBN7g>
    <xmx:9AbbaFZX_fAAmmHfYyuXkRGZNfBNbz0iNJ8d7NGIIo2FRCtI3uiSsg>
    <xmx:9AbbaENXdjwgmSu0ki0jQKfx9q-T4LQM6E5t93xCdXGSjmT_-BHGHxyg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 18:23:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4801d08c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 22:23:47 +0000 (UTC)
Date: Tue, 30 Sep 2025 00:23:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNsG8JGvpzui7XJA@pks.im>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNhX9AJ/zq4IYhmW@nand.local>

On Sat, Sep 27, 2025 at 05:32:36PM -0400, Taylor Blau wrote:
> That would leave topics which do not have active reviewers in a lurch,
> but I think that is sort of the point. Contributors should expect to do
> some of the work of making sure their topics get reviewed themselves,
> and that shouldn't fall entirely on the maintainer.

I guess this is a realistic expectation for oldtimers on the mailing
list. And it especially is a possibility for developers that work in a
team, as they can basically tell others to do a review. But newcomers
already have a hard time to contribute to Git, so we should make sure
that we don't put more of the burden on them.

Patrick
