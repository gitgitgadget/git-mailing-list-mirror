Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237173563FD
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222971; cv=none; b=D8W1y+H7cVV26AmS6J1fHvMe23aviARTAoACbcCAIAG1Wa6FY8fQ7q7al0Ue/x4z8bxa8xjyjHwXkLo4EgdYZ/M2nRxMhK1JjSVL+E0TuB6ud4lcBQORPa8CyKpsK+2HqMF3g8rwXCVl+isXeJ3zPywV1IaajCdBH+2WMxdFmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222971; c=relaxed/simple;
	bh=uXMBbvuIm/79cXQOOl0CeVzqZRJmK68BJSYZV/xZm1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8nzsU1edkzwbJq/9UTZm3KhO9Ag1yV3/KBUP6MNzFy0Gi4WKJHLAY1XJ5Ax3/fmZkUI6AZ8KK7xec5pAbfbk10irVX2eU6qwfDSfg1seKaGRvn7Plc2kmZGtLBKqt/yzrfWmkQDkdMBta4GIN+9Cnf1phzcB2uRbjPpC8Mmprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LGGAAPZn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w5lPRbvp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LGGAAPZn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w5lPRbvp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 58FAAEC001D;
	Mon, 12 Jan 2026 08:02:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 08:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768222969; x=1768309369; bh=2BpYSNbT7o
	zXT9v2htmg3FpspzoozCSryL0eFoQhr5M=; b=LGGAAPZnZ40FZuNWknfCKw0Yv6
	l7EIKB5GD6hDaN+LcGEXDi/o5TCqr9k9BFu1KSDoGuCGNA8A/2tZzykTXsUADWfh
	6CnQ1347Tj0qo5SfCGmRwNGr0vUajP+Gho85kIKwxtYAHlYfyTZDi7F8vJK4GikF
	5vorq4/Dlsxhak6L2VufTu/CpG/pgIzrRn0sgTAQ5CT07X+w9nlRAt5ctiNRQn3O
	mkNVdO7+YySDV6+Q6IOvZZS5Rvn6+UH89O6ZRVgBFc4el+BKRwkrIhyO6aUFY2RD
	g7V755395HAAUdj7ZNyDdqOPalHZ0dC5CU3vOu3KoN6hHtvBVCr88uL0Ra4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768222969; x=1768309369; bh=2BpYSNbT7ozXT9v2htmg3FpspzoozCSryL0
	eFoQhr5M=; b=w5lPRbvpb9r76r+n+bAclcfDT1gomR1eytoTjg6DJZb56MBhDvM
	Hmv5Vc4eROfdQ9OhL9vqD5hNtbpnbBk2SUXuCDGcWIxQug9hGirnpmUFNz4qU/oB
	405ax6AgFsWnDIujl/TMXr1ZID9l9PaclxfLetSEf2JX22sgfVW+8fPPFkGDzAiL
	djgOjMZ1AMQ9c0H4JxOspolEVApEBkdEBVXgRHl/VmPIlkH3EvJfGIB78CWa1+pB
	aiAMO5js2X5Tv/glukwKW/u89FvV/e+obZq0FCgRHg0GXr7THNYjDV9iWCGBii+L
	dTvtPqyflVpg/sl/CZOqkMztXIYFhNs+pkw==
X-ME-Sender: <xms:-fBkacmEBO8x6lp-ueZSfGIIMEHA768K24SKGCwWyZv0ShT4U2dKBw>
    <xme:-fBkaR2_GGRc9L_A2yvPXgyzhCqpBIvDcja3c0pyTqLr18epLBxeq3wKcF6o-Y3DD
    5rmxDXXpSgJyArdAr8UPzpn4uVIn8FuRWTAARb0CviwjWYd9Sv5iw>
X-ME-Received: <xmr:-fBkaYRjQmM55ipifCMU0n-IJyzSl4dgAiPjJQC_E4fZyqw8hNrbjXpm6E2yeKZAdCmsYlrXkOdr-UD8p9t91DAsGJNI3lvv2PhXA2QmDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-fBkaTtAN0bp9gomSa5EIXVxBsMu5aBDVFdNK3XUYKuC2CiOzV532Q>
    <xmx:-fBkadbYZdMJM40g80ZG_MT144E9eEPk49s4SW_2Cj2Ylng9_gpeeA>
    <xmx:-fBkaYuCDZqRSQv58l1S8xbKqRHuThdwzPx27KXEj6yxpSNv87UD8w>
    <xmx:-fBkafEpwnj81GqaWoBp7TAupHXidy74TWnRBCtgr20w89rrTNcENA>
    <xmx:-fBkaVXk0MIQsv77G-xni_Z7ockeSOidDo2hLzOhL2JoGlJnmyiLPTHx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:02:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48607d88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:02:48 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:02:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Some
Message-ID: <aWTw9Zf9nz4nHxKK@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260111055859.408891-1-newren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111055859.408891-1-newren@gmail.com>

On Sat, Jan 10, 2026 at 09:58:57PM -0800, Elijah Newren wrote:
> I've been waiting for the history series to consolidate before
> upstream some local GitHub changes to replay and adding some others of
> my own.
> 
> So, I figured sending some of my suggestions from my reviews as a
> "SQUASH ME" patch that Patrick could split up and squash into his series
> might be helpful.
> 
> Plus, I noticed a bug (pre-dating his series) with handling of detached
> heads in replay that has propagated with his history stuff, so I added a
> second patch to fix that bug in both replay and history..

Perfect, I'll work these patches into my series. Thanks!

Patrick
