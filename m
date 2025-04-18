Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C9213E6A
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991075; cv=none; b=J5m1rukbCXa60DXsrSeH4MwuCaj9spVRyNfRM4C0MtoohNCnudkhsJAQMXJ+RClXDa/YjhLrFL+r2cQHAQUtdxq2lounnGbTP/rFUGol7ZXps7LRhBk4aXD+8pse+a8r+j9QYj4cH1ZYcW+FpKLkhqVicRg5K54E2CuO/6SqZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991075; c=relaxed/simple;
	bh=fGXXtPGmAXbf84yGBrvM8X1SDQtiwKEBqCzQsepxuNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pf0eZTxgTQB3ekNu4QotzaQUp7CMHuTDAfjMO1EAXjv3RLSAWg824EW2PQYos/NUyzrrE7J+XFUGJ5Qx+xyMvlnfMlEwtNe1rdSUs2a/9ak+E492ImaGxSSBDGoonnUIf95TgtuvH1L0+ZsTd2PnKGLaa316HgYkimijW14k91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mMRjrwPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvPirddd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMRjrwPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvPirddd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91D9F114010D;
	Fri, 18 Apr 2025 11:44:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 18 Apr 2025 11:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744991071; x=1745077471; bh=iDuXVbeGiU
	IUuA23WDBBj7gEXUFMeVrdfn0OEU7HWLk=; b=mMRjrwPnQ053Mp1w/B9W5Z5K3U
	pVdb3nAAHbwqmoqT52RUnL3al9fpcQUpNrbj5FlLLGoWUDJxZMLn90hkmUYatjz0
	T2y4Y1aYxQ/wY6mTK84Pktjakur6a6g2L+T435UMTnJr7W/76to4zOq1d+n7X1E+
	hxT8/BLfnRrC6ntTllULEjo9tSPIdrhckJHtPYuU41zuqm3m+bdO/WsE4/OWlkvc
	9OM/OGyGZ3g4pnv4vZqr3Ls/B1Upz7rdWv+8PTtsGovyYGQb8lrLg6aXsDdYK6+l
	Yz8j+j85wpRitscyU2xEQbbHeUnA0CXsgZQ7XVD/S64Wy76vfPZ+IZ7Rh28A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744991071; x=1745077471; bh=iDuXVbeGiUIUuA23WDBBj7gEXUFMeVrdfn0
	OEU7HWLk=; b=bvPirdddlG7eYIStPHpsaHbQoqaoJhdH4PfbKXumbyDrPxK31tb
	/bGNygszgN9Kr8fd/Qt1N6LJnqOrGYwTxKNvjQ47xWd1yUf0vT9qvqS5QIbWjwBO
	WOX6pLOJLPxEuBwRua11Y1HObqkDhrMGu/YeZJ8Kr3rY7BCFhvopU3nUc2Sml3yi
	c3/qgO/6dP1Ox2wotaM9C+vk35NhSOymKbY7e/WjhfjAu3nspLlWdrBhTrEP99qR
	qeqzSp707qHJmzsJKZ4ru04Fb2xTdVIi40ZFK9b6MtigcI9xCd10o6xtpziCqyG4
	t4vG+OLOXijoi3GacT4N+mrAvTVAXnIZ/8w==
X-ME-Sender: <xms:X3MCaOEfvlXF7hQ-GmpLPyFd0K_aIiuGqkrW061mOzaKWvfVzitBaQ>
    <xme:X3MCaPXU-Rv2AYhNNdrEKBfOLYF4rd4XOabODyced9WOCaY1nEV4Fi-QJ-cMbk-I1
    3cB3qFkcnNJvrXBYg>
X-ME-Received: <xmr:X3MCaIIi8B3719Oga25RwD7dXJmE1RmPQESQjlwjdPLcOs04GAYUfEes7Ray3ouq6oY2Pk5he8Odp7ByH8QWtazNiXX2fefIDP0R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X3MCaIHp-k4jTlmOalAxzbyS2fjJi2Xe9rQn1Ca2opEk5b3QaG5tQw>
    <xmx:X3MCaEUWz2sC28ltsUABOdNxQs3ztYnWQtARzvYacK1OycOCbD_Qxw>
    <xmx:X3MCaLMVsdNPWO4UPNIgU3YqivVrxRF6TX_cUItAfX6RWQeP2s4Z4g>
    <xmx:X3MCaL2ghumqj-q-LHsKEsICsBgPTVN5aKqxAb9AxVWrBwp4J3_lpA>
    <xmx:X3MCaOZM-UqdB-mHaH9hMRg_HMvLXqSSxE1lNi0KOoJo2fyZWfPcorUN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 11:44:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/4] pack-bitmap: write lookup table extension by default
In-Reply-To: <20250418093335.GB10441@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 18 Apr 2025 05:33:35 -0400")
References: <cover.1744924321.git.me@ttaylorr.com>
	<b7cfb1267fdd7f50f414c9f79377cb338a0c1ab0.1744924321.git.me@ttaylorr.com>
	<xmqqmscee97z.fsf@gitster.g>
	<20250418093335.GB10441@coredump.intra.peff.net>
Date: Fri, 18 Apr 2025 08:44:29 -0700
Message-ID: <xmqqr01pbhk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> They're not technically required to be in sync. It is OK for the midx
> bitmaps to have different options than the ones we make for packs. And
> in theory they could intentionally diverge, though in practice I don't
> think we (yet) have any extensions or options that would be more
> appropriate for one or the other.
>
> So if we did want to join them, I think it would make sense to still be
> able to use different flags for each situation, but initialize them from
> a common definition.

Thanks for great explanation---I guess it is not worth pursuing,
then.  It is not like it would make the system misbehave when two
are set differently.
