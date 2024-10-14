Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81413C67C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907172; cv=none; b=hqzmzX1K1peD52fnqDlzHSq0hoNxxKopDYGNndpQ7KWllR8kPRZvA9ExtSvqEGTa286r3H5Nwif1URfLRhJ9hk9DB6SzxFE+67/ffFVhIWQaVzkzqfdfB5cm8jZmRwy8re9zt5hqzjCLJpe3eZoUQdzuxYEefgke4kxrB91tkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907172; c=relaxed/simple;
	bh=ZktWZdPhYZcE/OLcs2IUrYTpzEcIg7H1FfAWaKmzRD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH6BKf3mFRW8uCYiIQrUXDgHzvl0Rt+dEPcdNXJMES8U4y9Cb5Lqdu61gkmnkW/bgfkHz+YISSuiUltu1zaeqFDJfZvyVerTBNxHQUDeBSKzDBp6cn+ixVsR0Db0yPc1HqExyf2OusnIFvBlMbyYl8yXxyjnVAcEZn0mjJjaa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDLFhaGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oM14+hPv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDLFhaGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oM14+hPv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 03D311380461;
	Mon, 14 Oct 2024 07:59:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Oct 2024 07:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728907170; x=1728993570; bh=KKb90lLC5Z
	7Ko06oK77oZHPbtcUQIMKTKaIzVp7IpyA=; b=iDLFhaGsB7NiJCzuGksac/bmgh
	A6POSCs01ch6nImYZRHWH9mj5K2SW3keejppsJzzD4T7Dx4OVp73eb/fm/20qtfK
	WLzYR8qxXL0s+kUjSUlSqcKKaT4qOmYI7upxBqRi7GfdW4GVm6Bi9rbkka0blyZR
	ra4ap45rKltf+r0kZ90EE3P9SXr84BvjCEgEHKw8EtslcVtFwfteMRAvQlSVtKwY
	PX/KZVG/DGso2bbXiYqPff+GM5TorxuSUz/+qVxEXLVLxDOkHvoVmiwuCL6qOcK8
	qZJJU+uHgosB/BoRAtjwbXFZVOHnMNeeHLSdYr1HlRS2Hjt4+YMnQwdoBkbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728907170; x=1728993570; bh=KKb90lLC5Z7Ko06oK77oZHPbtcUQ
	IMKTKaIzVp7IpyA=; b=oM14+hPvUJAVhZ5UE0hdb1MLAUQE4ALucXKP0VVZoIY7
	KxJxXH+IHHtbrqrpDAelnRT0l6tb1y4Wl5UDOTCF1QxGWZVjA8R0fm6J65ydPAb5
	BRRgbLCgIHXQablsEH4pXZDb/oqojj2aO6y67HLsOmrZqp3XLgHz5pDLD005sLj6
	Exz5VN/kJc3hRVjdw8GR8cgvRiEBqUFNZQwh4eWRCasrwotWm72ouCZgGGXxXitf
	cMVN2c8eLP4YBYghCdxbdfu30WAENMbqWmIq5rd3yE2cLTkG7Qr0dh7BJ2tr7idw
	/yiakhuOXNGFW5Q9DavFiN39/zCENbx6P7g3URrTgw==
X-ME-Sender: <xms:oQcNZwnQjTTm8XntG0mXZ8MRCa713p5UwqpImV4KA-p1A9OamOqR1w>
    <xme:oQcNZ_3Fi6cWI9HnaxACGR-HiD0GNrXSfzFVO_8C9u5vZ5WeW3YGKjXNIbFW_AesW
    kCkLWJ9FzE4WKc3yw>
X-ME-Received: <xmr:oQcNZ-ryAM1EaamERi9Y0W-uJkYQhqBfJMuMxTeQVOQ8NfPgw85XPrfQE_1J886PkhAPtZFiyLetOXWk7K8wo6pMR7g-GFlbpuyORkExU2iBHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlvghvrhgrihhphhhilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oQcNZ8kVQUQ0LmKl-9vkUdpLqjCJU7Auv9FfNvVYCE5mU-IQtGI4UQ>
    <xmx:oQcNZ-2g2Ci6WPlVdh-6gOvUU0q0QZ8yMAiBJcaC6fZrl53wAHCqPg>
    <xmx:oQcNZzsPNGZ13XZyKYbFzVYyQ7_9EnlBVt3V955pOgWj-Jopne5d7w>
    <xmx:oQcNZ6UP2_BWWajWt467SL6QvOZ64NR20KfjsAQ0NUzq0VddrYL2dA>
    <xmx:oQcNZzwBW0CanmIdA5iFPQcw77d0mcbuz-isVEY-r6yXXhOd4GvUBRfi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 07:59:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3f6c6ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 11:58:14 +0000 (UTC)
Date: Mon, 14 Oct 2024 13:59:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] Makefile: fix dependency for
 $(UNIT_TEST_DIR)/clar/clar.o
Message-ID: <Zw0HmISykehEiC-p@pks.im>
References: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
 <pull.1810.v2.git.1728667787227.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1810.v2.git.1728667787227.gitgitgadget@gmail.com>

On Fri, Oct 11, 2024 at 05:29:47PM +0000, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> The clar source file '$(UNIT_TEST_DIR)/clar/clar.c' includes the
> generated 'clar.suite', but this dependency is not taken into account by
> our Makefile, so that it is possible for a parallel build to fail if
> Make tries to build 'clar.o' before 'clar.suite' is generated.
> 
> Correctly specify the dependency.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>

Thanks, this version looks good to me.

Patrick
