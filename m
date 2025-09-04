Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A92FF652
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991111; cv=none; b=g8LwpxLfA3JJLgHJkzyJlLbJ7hKcsatqu44T5VApjGKT3G6aTdiyCOSID1j0K+s9TinYtflPizSmQKPKOkqlBusRgEH2gvlb/r+SUvQWnQTuMqN9Rp0yLPMqil5YSEmClgvL5ncR/BaSWccivl+a41NVTAs6WKYekBK/MUvCPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991111; c=relaxed/simple;
	bh=1/wwcDVC+Pt0FVJvzUWJlD9terU97RiD24GcO3HvYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCoZWsFRToinb8xwQlJ2KMgCXodXRIV21XkvF67g68vMSYHra6ZX5omRHh7vFdsWHhX4Ztm53hb6EZpc06oS6QIkGgzwkt9lCvpBuItnzQ8EW39dhYmufMgwH9PTmH8lPi2PkRAN2ihH+A8Isy+MV2+F8jSV4SNh/XJGv/nSMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sEA8Ge04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9qoVBTf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sEA8Ge04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9qoVBTf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 174E87A0396;
	Thu,  4 Sep 2025 09:05:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 09:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756991107; x=1757077507; bh=1/wwcDVC+P
	t0FVJvzUWJlD9terU97RiD24GcO3HvYuU=; b=sEA8Ge04ubRyEypzgLKjlZK7vI
	HdObivsOx4zLnP24ftkbSJTO1S3IS01IaOixKcm5O7Dunl7uOrixt0flkY7kz2Aq
	PkfIxri3twPKy9bqmc1NFEqd0WMCJ7u5y4FVKY49N5/Tc1BEMeHVbOWQ8IGQHM6j
	tjLkan281K6F452TDCSEK3VGgzgfpid/7TuwzepA9W+DOAy0c1a7lQq6Ox21OX6j
	+B9VWapgBB0N3LspU8ePsHe/3jmpXVLElHg+fsSUrBhhWPwG1GQ+fkJNmjzQ3gIh
	hk2iY1iRJnQ7gM4FNOhYYGGTToHmMtx6NDFZc3vDTiq1ZA4AQwXMK2u+iURg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756991107; x=1757077507; bh=1/wwcDVC+Pt0FVJvzUWJlD9terU97RiD24G
	cO3HvYuU=; b=I9qoVBTfm9QVjRIKchn1rzZYdm0p0q6edW2dscDCH+BdAUGvm66
	b7qtJVOJc3oWrJVQE4vtoZd+67JEJIUYCN9z6J9F641ba9/PKHL5qp0v1f0qd4wg
	Zk2OMzwbT1FOzrXc7YhT5gT2FTyPN8K05jwCF5MFVGGsuMfzoZlYHxxLAy4H1CHN
	5Qm+OV4nDG+HJ0UUOBMDGnwNdbeDNQEB618W10wyfNCA0mTXX+vNkljjId15/vbO
	fv+bZNN+x4/B844IKXE4mKsyrisBigC0pqqO0gZBoR6WBjTNF4p5lwb3Vq+nETq+
	UxqzfIL+awLdG6DCrHNEWgy2UvaNk2aMc4A==
X-ME-Sender: <xms:g465aJt_BMVWy7q71ph62-2EbWpekM7b8mworwdZi1d7D82wKS_8Jg>
    <xme:g465aABzt-WGN1dH3F2eDLXryNeX9S9ZVvSjB16v99CY7FK7yDXj_tSIbplveIhWY
    P-n_OpSTYnPwr4h6w>
X-ME-Received: <xmr:g465aDNlHTOevqYdAk0S5e1GG1LPZBquFsHtOkJp4bq7Yp42h7iURbXPo9tmVC3bmrtpBjuMvEZXw4XhPp1YLgetnU24txQ0gzi18f99G5lg5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshhorhhgrghn
    ohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g465aBy9KPn0mq4R9362AApQBG2rvfEOxFlRXNB6AerAiPmfTBdxlQ>
    <xmx:g465aLUMXaB0jZYvqNjYdO0fmwMwMneWGtn12Ffm41D-jplE3XwctQ>
    <xmx:g465aLNivwFy0Pvff0SUuL_ok0aECG85jBMpAzCWCVW9pHR51GZnNw>
    <xmx:g465aFDTlnYXLGJQvTeO2sfvalNHsCe7NBQjJfC-1F3jS_WzT0zGXw>
    <xmx:g465aN73kkFxGdIbPib3wxCgTeXNAjq28YpDsS-kchL63FcSfAgk8UxJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 09:05:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44ea9b06 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 13:05:05 +0000 (UTC)
Date: Thu, 4 Sep 2025 15:05:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 00/16] Introduce git-history(1) command for easy
 history editing
Message-ID: <aLmOfV4WU6RdpdLO@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <CALnO6CC5K81QRxJR3jvqyL+fO6Yec_Ee83EOeeiUEzF6oBV3UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALnO6CC5K81QRxJR3jvqyL+fO6Yec_Ee83EOeeiUEzF6oBV3UA@mail.gmail.com>

On Wed, Sep 03, 2025 at 07:39:58PM -0400, D. Ben Knoble wrote:
> If git-history had a squash or fixup mode, I imagine it would function
> similarly (and could be used as the backend for fugitive's cF/cS with
> new enough Git).

Yup! I definitely do want to introduce a squash command eventually.

Patrick
