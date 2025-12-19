Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2CB42049
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125571; cv=none; b=Ds9M7VWVccTGwKX1LWFA1BOZhTviHvp9geJAdoWv41fw3D8iYg5xummvy3FgbUoyyNcZqMwYFKXo2UDORDjLcT3uCCuzxLzR+MSDmtgdWAS5Cl6+fim4emKMj37jvaJUbfk0Niq9lHBjyLn7WlXH8jBoYV9BVRv/T9YJD1uxp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125571; c=relaxed/simple;
	bh=V2nXNBdoaDXKsnk5C7fiqXpMgLLHhrjGb+wvjLp2eYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCNEuTWXiv6K6OI/uSIOjmMSq6QLy/n1fH3EvE0hoOcsl+8yCtCwDnBg75lZs7aKf19MjZmj5lpuxuGqci9pKzkCWFK0hEbuSSVUHrpGjfGvZbnRAi75QC7JAinODvWwnM643QsBhNSUweeUWXXI1q+BhUI1YFBJ6SyRaG9a6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m/Cjwu3X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z05a7unU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m/Cjwu3X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z05a7unU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 22F651D00169;
	Fri, 19 Dec 2025 01:26:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 19 Dec 2025 01:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766125563; x=1766211963; bh=Re6WHnSk0G
	3yZF9+0VnY2HnWnyWv5vO8ARx0BahiVNk=; b=m/Cjwu3XTE4jMheDonnr9yKtew
	LZ8mijiOb2HctoHeBP9TFaozfvNyMqQS7tm0x8TchQpIf0UALYjKZFiK48GnFUk+
	fU7JdkRoxCKZbZCnTGilxDqeGkGN3bPAvZsJXhIg3EyFpIpGifXvjiGABvPH3gDX
	S8mIwvKc92EF+kPAWIebrMr4Vs2xUYtNK6jbfKkvh9inbhqtH3M7RffMDSfGjf0u
	5nLgfA5uLj3XZ4lRH8JeV5bqItrnDQ2/tUx+IFwBic5lvsb7DKZw/T4L6vYrDuQy
	mINxWJnV/sOrDiLIBpGIczUEd9YpRJKLP2tsFCqFlDchVsShsegsAr59Fczw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766125563; x=1766211963; bh=Re6WHnSk0G3yZF9+0VnY2HnWnyWv5vO8ARx
	0BahiVNk=; b=Z05a7unU8kKwES/ByAIJGlSsFhnxxEwcUnGzkXl6d1DFJuseTFc
	xGzTus8AQi/z5BYVx5idhDyjt2Zgy2JdAGb4ng/ZfX610Hm5DL2Y7naYZtpE9ng3
	vOAW1HkcJXzpbE49xyRkl7JjNQkl/+VTi9Ir/wyXYcPKEYxNksVqVLio3Jog/HdK
	PUH3W4A6ncqXuRj0ri5VyhVkP4Y3DCZPFjieQHccl0ebtBpkcbra8yD4rts8Fa9A
	or34GPttKCNLJEiixScvIlQRM0vkV/5/P4VLiGZh33S0QSQLZbia9SXNQxWVQIUz
	LGJDylg7i/rozNnj8yiEUPAnkkY3+WRuuoA==
X-ME-Sender: <xms:--9Eaf9ym9muyh4i3lV9k2hOIO5-tpFE61JxOMzjifVrfN-OxBn4qw>
    <xme:--9EaSvRw9jWbDc44vXXI5YYdzkmmIjwPnHZ5kx2jN0T5cRDkyHw8o3MNCbS_axQL
    vuWJZerw9zfi--koNoG14WBF8CqDQEWnHTj7TbrFyq5HlSB5tmyEA>
X-ME-Received: <xmr:--9EaSC_2sSActNPmdNVKHPfciN815sww5NpfkkG36WfraO9Uu_6Kpug0fKKm2R9yTm41TbdMXxJijuyeJjQx3_E-nsb8rnAOH5qm1XN1ABlZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:--9EaaUueiO7CSsQwiVyPvplVnwa2H73Q-PNrQzeyyxJsprzaM2ONQ>
    <xmx:--9EaQBQS6THOxPTDL-AVIMvHGBzlC5zU_rpTBHkkx38EGM_ZFdCXg>
    <xmx:--9Ead9dh6wd3EIKBZcEM2gFduMQFDbjnmgcsPSXBXXTikvs_TNVnw>
    <xmx:--9EaXFleIfJ9UsCX4VxP4V9ks7JbFgm_1pfyj8OTIR0poHevkI_xg>
    <xmx:--9EaVgNmEFtzyOgmeVjSYDO2dPJn_tAXkLqgTxs4JTYTu8KOZ-qNB_Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 01:26:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c09816ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 06:26:01 +0000 (UTC)
Date: Fri, 19 Dec 2025 07:25:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] builtin/repack: avoid rewriting up-to-date MIDX
Message-ID: <aUTv9g9QxJ3aSGuL@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
 <xmqqsedhe78q.fsf@gitster.g>
 <aTvFOlhtPHgWQC5L@pks.im>
 <aURvuLcIVpBSIhiE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aURvuLcIVpBSIhiE@nand.local>

On Thu, Dec 18, 2025 at 04:18:48PM -0500, Taylor Blau wrote:
> Thanks, both. The new version of these patches looks good to me. FYI I
> am going out of office beginning tomorrow through the end of the year.
> In case it's easier to queue, it's fine to drop my 3.2 patches from
> 'seen' and take Patrick's v2 as-is.
> 
> I plan on sending a new round of 3.2 in the first week of the new year
> and don't mind it being dropped in the meantime, especially if it makes
> things easier for the maintainer.

Thanks for your review!

> Enjoy the holidays everyone!

Likewise, enjoy your holidays and see you next year!

Patrick
