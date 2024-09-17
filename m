Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD115886A
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567735; cv=none; b=Xf1pNIKyI0ip6Ho1+wKIXr8zhtNYcdViKJnsGsIRsXxMLWXg4oF7Xtk4S5Da9qr99hDMjAYgXuoo3DSLFfJpuwDIGRxP4oENzS7rC+c7SeBlORZomBM2m4zm06I6z0YllVB6853Nbsg1GWi+Nyd7jUX0sSn/QnxkToJTTZ+1Lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567735; c=relaxed/simple;
	bh=bE/o64rm35tV3eqZRhyCEXCnHXUymRqfAAPrVYTz4A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw8GcDKGDJl8YyBdZw35YkCUmN6mu1gBsHRhCuazuKiTRD8+BgiIrPfT1CmkyR7TmEpL4WefRExSvynHYLdV0HLoYtRHvr8suXhdgltUCGimNFtJOzIM2bByF/GJrrsV5flYWx3sm8WvV7/yEC6iA1NBmNlVf/3lt7o8xlOXbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oX/qcXWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o8GENnba; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oX/qcXWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8GENnba"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C681D1380410;
	Tue, 17 Sep 2024 06:08:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 17 Sep 2024 06:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567732; x=1726654132; bh=zpEs6pNz+m
	hCftEsRB7kaa5u8wDc4f5BnBJdfU+WkAU=; b=oX/qcXWOiqgeKrUutiD85b7RY9
	LwGDg4xYlqCX4KH48H0nHmKarOs4cgeSuU4sFrpd1+/7KBWXnXsERjb6Wht/5NZh
	UK1WMbWhjV8X4t74pjH9LEvdYJcKvBatErX7vhCnGAyZ97u0VawnX+Ncrmr6Q7J1
	C56XLnr2F7V0RP3R2rLdMQlGMRpTV5n487MKaa6PkUt1GubEsDgvMCRW2FhXwEsH
	W8/liMyaVU09pVe2FLy09vQKIx39E9HPB0BOK56c2t6x6EPLMKILtug0/CmUqlDS
	ZXZdCQbEE+1GKcdXjDH+CmlOT/3bpPRUzr5vPv4Bw2lqbVUOqxBdRxUiqrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567732; x=1726654132; bh=zpEs6pNz+mhCftEsRB7kaa5u8wDc
	4f5BnBJdfU+WkAU=; b=o8GENnbauYeQhnS/8JNcsT/lVl7ty7zjkuNj/xAd/MH2
	AavOo5Y8ZLP7Wg7LrC1mHcEqxBqWc9yFIWwDtEeWtXcl9tuW2yryt2HUthCHRS4M
	tj3dq3Q5ffYdoBc/1pD2kt8BzDGjo0aSU1xbOvw2wxX4bdG9Dw736iLY+x6JNjh4
	OQvxQP736tGVerbY5U6XsGyOTtPOE+k8k+JVmRQ53uHEmH1dqBNKmJMC6MLDX5QA
	LRkbqTMMe/5473cWN5c1hoLwCvPKEfX/wvywMYJiHatdZkcd/n6HloLpTcOP8iEq
	tuuDnWeIZNykKAe+PhT7B8DKHZl/LtFVOhTf6zCpaQ==
X-ME-Sender: <xms:NFXpZmymTjqzWR_CAA0mNd0x8VcUm7qiO06-dsrPD_hnS-36P9ovhg>
    <xme:NFXpZiQAiNjeGycspo-4wuTPEur3IuC2pyipTpNajvBvYiWsGJeiGgy7xBpDpeqYJ
    3SKnF9iHsaK_9wKKw>
X-ME-Received: <xmr:NFXpZoW_mLIQI1emZoN0ASSXluT2wycGytUiRYZHoVAZ05JVx__rBhBwGu0W9VZcs60Erwvb1fJWTIrRuQaEen5W_UjDrXtgwFPFw_bnPb2P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NFXpZsh1mnCNxJ4k5L4cYgzz-iB9JaIsldlDKzTrPtrRhoKmFPrM4g>
    <xmx:NFXpZoCaOfg5SLtoLkeL9IBDbMAEpEUCrHY9POxLWkhJexMYcjQsXA>
    <xmx:NFXpZtJkPGBQ2qXi5-nrnBw99ZS9dRHd-8A40WDv8Q4_QRpznWHmEg>
    <xmx:NFXpZvAqgbyFRr42u-CnEtvlE0Sz3uYNq9XXm-GCQW97JWaPv3uFbg>
    <xmx:NFXpZrPSadB0CC5cZQFItFMBhAg1mWMUItTuGvQUNAJmxCeaGvszQA_O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:08:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c8ecf7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:08:32 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:08:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] apply: fix leaking buffer of `struct image`
Message-ID: <ZulVL7oBf2eFRWwu@pks.im>
References: <cover.1726470385.git.ps@pks.im>
 <cover.1726567217.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726567217.git.ps@pks.im>

On Tue, Sep 17, 2024 at 12:07:48PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that refactors lifecycle
> management of `struct image` in "apply.c" to plug a bunch of memory
> leaks.
> 
> Changes compared to v1:
>  
>   - Fix two typos.
> 
>   - Correct the statement that we don't loop around
>     `image_remove_first_line()`. No idea how I missed that loop.
> 
>   - Split up an overly complex line into multiple lines.
> 
> Thanks!

Ugh, sorry. I meant to Cc Junio, not Taylor.

Patrick
