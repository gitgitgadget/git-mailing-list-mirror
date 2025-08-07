Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594142222D6
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550467; cv=none; b=TGqBRJfrUOTepbx9zHJR4z2HJjizCkjfJz5pwHCiGGdzEsG3zdLiUjtQW2g413mVB76l5a9hR3bwJFtMiSvudWVHhNMLXn/7e18u1iyyjJaRyd+bUukHVmMWnk70+fZXey1BJKycz+QKx6yDc/i7zAuKZfDFKkxsVrMilKhue3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550467; c=relaxed/simple;
	bh=RevFul3ZrlTBk8Z/tNtpWoXTvEGuvSr+5CALfKlozu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+5UBS4JP5JnAvkq7Squ1B7t3n/UOdccsNcXEvAYEj7qRAR1WOahKmQlMj9gU+O7wxO7xdqVPdOH8sc1tKZ/i1UU0teUy1NCX1gjxo3Gu9zhv7wu+zV+TmqZ22r+TgPoGqIDh82ekehTSGjUS/mZc2WluZIX6GBMpC62jBgmAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MgMMPmlr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOwOhhB7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgMMPmlr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOwOhhB7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D0A8EC0355;
	Thu,  7 Aug 2025 03:07:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 07 Aug 2025 03:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754550464; x=1754636864; bh=Hlxr/yQbNZ
	ZVWg+F2/aCowJvxnyaSvjHgLlQ6/DeEvQ=; b=MgMMPmlrZVkA2Zvf9e+pX3GVSS
	bd5B0UWY8dg5Jb94itwXTBmjAtGshddoU6VDrysjsnUBG1q41pXJj1GQQkDDT8i9
	GaVjhQXCleyqkhh9hHGf4jR0jX24fiTBY391VyMoxDHLQbffocNabn1BcniLfKF3
	vMb7Qmy0RLezIB9X91l6x09WgohUKmb0I4lF9JeeY5Q0XZgm3grFDI4zE50dVTM4
	AXawJAzIA1Exps+093ELY0fyAmO2mKTg9H9SJqgF9c/8AkLHSoAzHb3BlFFEJbJw
	UVTBrLsn50hFLToRahgBXyH0m0+BvWLgzAfu4oZ/KCINSPhy4lntLS/z4npA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754550464; x=1754636864; bh=Hlxr/yQbNZZVWg+F2/aCowJvxnyaSvjHgLl
	Q6/DeEvQ=; b=SOwOhhB7kTEeCKyKE1Hz8lD4mRX1nHVFK4DSbgC74LrBlMyo/ub
	FE0oD+movW2UN2dAF1CLoXJuDOlV2clbW4xvsmpKFY9xwAETxPa3jmkOftqUb/GT
	Q9cLh8ffXdri3ELapcmXmYanR/TPCdWXLmFLb1Z4DKKcuPtzvm8sj/nqyJn000Io
	B7V+pXEFL6BMIVGf5dabJ48rl2s8lTTnKRJY1bIX6xdzCSsLD61JGNgvSX5vONRm
	sO432npm040THqwE09FYEmtw0QiVHb0VYgaofCPNQ82lI1mnHtEIesuhiVH7YnQb
	38UvdsnwbksSmxxKGm+3Mg69L8TgBIwgxaA==
X-ME-Sender: <xms:wFCUaG6u-a2VJPpyzum8kTeg736Ppfb2dTzs0ZD0N0D3rMDjumjbpg>
    <xme:wFCUaLargDob6HgYFe0rB4Ai46FUWU85b5wBTK4QrrJ9ZWNaOLFvc7ADGRodPqqOj
    tE35rdhWekI4iVZ4g>
X-ME-Received: <xmr:wFCUaL7KdyhRQ76o7BbwQtXn89mXMtq22thtUQrXN-spPv3KyD4j5aWZTYpi6ELfy5mtHKnjBgJbqIhGP_f5WRBc-ig9zdg5ywPEaVG3AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrg
    hlugdrsghuugguvghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:wFCUaODDZbv7MtgUh34oeUBHN3ElzgIH4Ox7W75e8D074UpwKSNE-A>
    <xmx:wFCUaBcAzA50iQPgBvYvRjRayGzfOBi5Q67HOmM98Z0TbXHKF78nkQ>
    <xmx:wFCUaNL7XfIFEM21Bg2yH3RNbrp0PxkWEahmizWuaMqtczvhnKjIVw>
    <xmx:wFCUaM0lTNt5op59o8E8zefZ6TGz7ARspWOsY-4Ie6p3QBmuRQhimw>
    <xmx:wFCUaE1AiBPPGZSrUhDTN7i6jtgfXurwwGqkjUXYfaJcf9Le16VqEsWO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 03:07:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10ef038b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 07:07:42 +0000 (UTC)
Date: Thu, 7 Aug 2025 09:07:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/10] commit-graph: fix type for some write options
Message-ID: <aJRQuqzdoiQyYiHe@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
 <20250806-b4-pks-commit-graph-wo-the-repository-v2-3-911bae638e61@pks.im>
 <aJNLxfL5ElFAzNz9@ugly>
 <xmqqa54cwj9r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa54cwj9r.fsf@gitster.g>

On Wed, Aug 06, 2025 at 08:40:32AM -0700, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> 
> > On Wed, Aug 06, 2025 at 02:00:08PM +0200, Patrick Steinhardt wrote:
> >>+		OPT_UNSIGNED(0, "max-commits", &write_opts.max_commits,
> >>
> >>+	size_t max_commits;
> >> 
> > dunno, this really seems to be crying for OPT_SIZE_T being split off.
> 
> Or just use "unsigned int".

We don't need `OPT_SIZE_T` because `OPT_UNSIGNED()` knows to handle
unsigned integers of arbitrary widths. It does a `sizeof()` of the value
and passes that as precision to the parsing code.

> Really, what does NUMBER OF commits we will handle have anything to
> do with how many bytes of core we ask to grab from the system?
> 
> This "we count things in size_t" is a superstition we should stop.

Will adapt to use `unsigned`.

Patrick
