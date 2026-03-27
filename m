Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F336AB46
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598713; cv=none; b=UIPd1QXOK4B7nmbVR9RkETBv3kzmvBTEUf6loyrqvt0v0iNPmxGP4ipixkR205a406w8Qkzq3mMBkLuu19Ot2+PdqwlUCcUv74IUG9MlrYkSTZn9ecIMUEXPTz7GXHVdqLWBo7O/aJoya/DdIRyzBQaXcNGEziauc9ON0dZLDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598713; c=relaxed/simple;
	bh=UzPLQz66P0gfrl8roA1PVP3jQNpRgWUu9L3Z13Xr6Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoaOBAwkUbNxTZqskS02pEjMIlfqQ8+ppi7qT/Jy8aTAczimGvToky9cXVxrqfvkBWuht5t+kKsGW/WOhhtSffuiryJOrxThk04AtqMwIXvbBRKTvWKjG6x17XeMye3l6iVIPtSl/pKa9XG5Lcj0F2lBO9/vJsHJXdXx/ZJCxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S8vwWdJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTDlZ1he; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S8vwWdJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTDlZ1he"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D195EC027D;
	Fri, 27 Mar 2026 04:05:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 27 Mar 2026 04:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774598706; x=1774685106; bh=UzPLQz66P0
	gfrl8roA1PVP3jQNpRgWUu9L3Z13Xr6Y4=; b=S8vwWdJ/BkWieeOJTCfDcUBe2/
	aLLQ5n3HfgM+clAK5GJNDwn82KNqj6/XrhM6SrGVPPJCqWPh7QQWQkg60Qre1GgJ
	LJruwEHadJV9yCscWHk0QHO7yeRHwIsNL58xRtyoaT44tWpjjO3ZSId7k6R0ZxY/
	30HD0rTbLA5x+Hvm6cPdaY7wd3RoXPmcFXd7Znk+mtZZ8MMV+KXi8sBBpl4W2vzK
	vbTxzPYIz8Tq4MBgn/qEYM15cKJiiIjjyfwZKt7Jd1qFj/NVYdc+GLi20hzqWkk8
	d6bZoRpSztGBtGLUPEHjct1syuMq0ykx52/EDsYn1tgAMAQMarkBFtwOXNwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774598706; x=1774685106; bh=UzPLQz66P0gfrl8roA1PVP3jQNpRgWUu9L3
	Z13Xr6Y4=; b=vTDlZ1he6phzSMJoHvT9r8nnI8ppKYlVG3kp0/PqXuEc1W9JVQL
	LFaycJlDfuNovwPP5K53YxmPFnr72qc7yfl0DgaDp8wv7K14nvme8yyo8i+HEWx2
	BbH3yLpzvPfHffTPEi1niKhUeu2w4ro9VOhKoaiKCqBPPqr7h/ZRGbQCzwtj0tLB
	Oe/31iXUUZLgCxkd7rL+zJwyDS72qigdYKKyQqzQSNJMW9+sAmCQQBUcyU5qOddu
	C41DzN0WJGvGFd5TwXNHUFzPGnasVNoZ66qaCsU7TeAzr2GKKTDkByrVw3h9B9EM
	w6fr1IcDUmxKF7ssOpKMe5SAib7fhRnQhBw==
X-ME-Sender: <xms:MjrGaf6mzKGZJI0VLIjT9RxJQvsV3ZDQX7CG5P7voFmu7zQ0LW3Uow>
    <xme:MjrGabw0gBOTwDjqJgbvlf_V3i7fIEFhgMQyf_w0s077ozLCHVx_yhWkERycpbchu
    sH9bw0ICjLM0Ogp-Qz2FDJCsboVBZu6KZiVJBJOZD6EtUWTbuZ3EuM>
X-ME-Received: <xmr:MjrGaezuWcVwPYkUH_8Y5xwmLAV4mWJZfA0sDzjLdA38VqtV3pKfGypqk8I9W4fYkgUYxHkridWXr_XJg-Xwm7SAP4QXCGgDCu05ERhniw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomh
X-ME-Proxy: <xmx:MjrGabzsI0Ns5HGaHjf5O_cAXR1_zkn5_LrMEreGSqnd1iZtrmIw6Q>
    <xmx:MjrGaQZxYlddO61wxsh1Rsp-ddivKfz1vbVWdKp86l6wMpbFaubi5g>
    <xmx:MjrGaUXd-Q-mhjX3-V9n39pcgJOfjvw8jRV3WdL_xpjNkd3DJRPSnw>
    <xmx:MjrGaWh8BHJ4CNnFq666Yjk4nics9dfMQktTOtk1QQgjihxto2zVkw>
    <xmx:MjrGaZlYPl5pPXcRrmHz0d8zOneD90y8Eb46ygNA2MdLdiIXP6IbyrBt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 04:05:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 860b4cc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 08:05:01 +0000 (UTC)
Date: Fri, 27 Mar 2026 09:04:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 00/12] config-hook cleanups and three small git-hook
 features
Message-ID: <acY6KtREkGcf6dyp@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>

On Wed, Mar 25, 2026 at 09:54:51PM +0200, Adrian Ratiu wrote:
> Changes in v3:
> * New commit: properly initialize strbuf in receive-pack.c (Patrick)
> * New commit: add a check which prevents unknown hooks with git-hook(1) (Patrick)
> * Removed duplicated function doc comment between .h and .c files (Patrick)
> * Extended `git hook list` test to also include a hook from the hookdir (Patrick)
> * Converted unsigned int disabled:1 to proper bool (Patrick)
> * Minor commit rewording, header sorting, blank line fixes (Patrick)

Thanks, I'm happy with this version!

Patrick
