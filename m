Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8A18F2C3
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774254; cv=none; b=T+4bwTxip7Dt/YqUm375SqxUWz03j8KzyA810WjAJD7CTE+Jp7loU+H2u5E+nHmfEVMiJQGlKYJYiUpFKDNRLF+/u4vY92UDHuVtydIqZoOh20GJw6chdBxAsOPg372X35Xnvb7IjeXAeEVVUGxVTZDwSZbkU1jYPPT6AkWppVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774254; c=relaxed/simple;
	bh=Efnsk7UBiIuD6WpTJwAkYDL8757g+KZGYbQl9VF5n3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDN0iwYhqwXBr8XfuMFudg3FCPUDyMdfEQ36NWxuydI4nNd3Uilgew8ASFXrKcWvGeUaglBNl0H+enqZOlWMU0WDjJMa87eZHU8AmeF18WxfDRgagVe96oVmhFqCB/NjQlciRYJdQq67n7I4bAKpGcGjnk7WxSnvu7mQ6e5PRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sC3kEVYW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=01bUgNSp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sC3kEVYW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="01bUgNSp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DA452540187;
	Mon, 17 Feb 2025 01:37:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Feb 2025 01:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739774250; x=1739860650; bh=6nrFSSmWcW
	zWMiNncXbZiAZZ+xQu3RjzjsD/B8dX95Y=; b=sC3kEVYWR4BgOCRLNNv1ZN/vOE
	oEyOtVrO7s1Yo42JiMT4nlHZmAk0HOH9X5FjFiWeO/Mk7LFYWs7fjCLII23ao9AG
	D+y37WhqSAj1jfxLGwZf4QPSM6Zy7usc1J+blV6gVCMB3bvuJC2Pee9eu9v4Ds9Y
	+NZY+xr6KsGKuUDCu9rZ4U0i0QVQk3g1iYZY29Rr1OQWbfhP0pIjqX7HbZIpb6We
	xks2KO9Gy28MP16E3jSb9cKxJlhjtR7+RBkunVbSj0yiUObD4HlXh2QRKsgrLZKk
	P6uk0D6eBRz7kSaFOC+qejh0i3pAOTnTZmdchiX+gWsv4MG0GyHT7bgPvemQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739774250; x=1739860650; bh=6nrFSSmWcWzWMiNncXbZiAZZ+xQu3RjzjsD
	/B8dX95Y=; b=01bUgNSpdatUdfNdkFKilzjoA/iuMxFKUdh2lvftwZ9u0D43Ki/
	yrzPW1u9Og51eenPWB00mMxHWSXleJAhrGI7R8KLNI/l32cXh3kL7rtdX/K9bVIc
	kS7tZnrM5Fl0ktETSSwd7B2SxbSMyJvhy/jqhociO36AwQSunmS43oD+atTbxEhZ
	g5mLWE4sh4IVFXE2eHpXqHMwczlwQ5as3OJH7BbFNAWvsB8KEOLcs5KPBBJJj0Bc
	yRwZQu02mMuZSIM7iOcn2AWtUYrW+iCeyuhfCkCfplUXEaOQT2UbG4K4xECrook+
	H6DkUfMW4cbpq2IoaKqqbUuq9sIbgf3wD6Q==
X-ME-Sender: <xms:KtmyZ2Ao-GhYgbO34H6HzXhmkX3_MZOIVSDexAQiPQzHrkcCuoIz-g>
    <xme:KtmyZwiNZWZmBA7ViSSoErmiMjftWFSwlXzk6yTL6rC5fh0SPyfhe9b1RuOcVdyg_
    N12jN-dOElyZOIZ6Q>
X-ME-Received: <xmr:KtmyZ5mUssDri9tMmisKPZPAFkWxPKy8PaqYA6ucDcPqBuAkZKYQnBIV1kyrneh3xQrsCH7lBzGmiFy1ll13kMryOtiFWCDfuDLdb0WGhrlthiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegruggrmhesughinhifohhoughivg
    drohhrgh
X-ME-Proxy: <xmx:KtmyZ0wnem3MayzKZ2aWXBDTWNcn7jlSeH3cG0p9I8LWf_KGYgtiJQ>
    <xmx:KtmyZ7THpLpnELkLdKjwMP4kinkP2B2ApLPek_RpiIX4Dc2oipScrA>
    <xmx:KtmyZ_ZbazZaudToOTxKECIwlni42Kg6-7w6bo22mTLbDxuSSnDmew>
    <xmx:KtmyZ0S9ui1FnKesPxV_cXIQo1bTy9sQ0CucGUT_Vk-SzbHHd5ZJdg>
    <xmx:KtmyZ5MwZcyBG_MEIO1KzRO3LfwhhcFD02-aJ7WipPGCawdVk8MlaLih>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 01:37:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 427b1aed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 06:37:28 +0000 (UTC)
Date: Mon, 17 Feb 2025 07:37:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: set default goals in makefiles
Message-ID: <Z7LZJ0tRz3iLPgmx@pks.im>
References: <xmqqy0y8ywc7.fsf@gitster.g>
 <20250215211904.41883-1-adam@dinwoodie.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215211904.41883-1-adam@dinwoodie.org>

On Sat, Feb 15, 2025 at 09:19:03PM +0000, Adam Dinwoodie wrote:
> Explicitly set the default goal at the very top of various makefiles.
> This is already present in some makefiles, but not all of them.
> 
> In particular, this corrects a regression introduced in a38edab7c8
> (Makefile: generate doc versions via GIT-VERSION-GEN, 2024-12-06).  That
> commit added some config files as build targets for the Documentation
> directory, and put the target configuration in a sensible place.
> Unfortunately, that sensible place was above any other build target
> definitions, meaning the default goal changed to being those
> configuration files only, rather than the HTML and man page
> documentation.

Thanks for the fix! The patch looks good to me, and I've double-checked
that preexisting "all:" targets were all converted to "all::".

Patrick
