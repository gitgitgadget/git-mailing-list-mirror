Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162E35B12D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534089; cv=none; b=GQuhR/dCS7TphTSWrBTQptvcX1nKF1nFG8su9+l9QTNE6QmCSZhNd7+yPDWIE3I7451tN1Aui0MWdDauuBomLyj3HHRrnyQOVmzQKb1yoNJ2ZdLhqhaR+Y+JsfFlBWwMJYW8tNsp/oNzC3OTfA19HMc/elpBq4KQgw4dUm45BuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534089; c=relaxed/simple;
	bh=pdnGglIOENIOls8obg9KxYPptMs65p3yL8vcpqXokkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKdepm3LB7y2d/yE5nPh37PgwK90WyomeQDFjBciFipDfJES2Fbtee9g5pn2epRTk/Ba9KNe1srngiB1pYxSBRqWyGyIVT6TPWJq0uC9f0vcIsoF2ArUaWQhcqtkr++fcQeenrJ9PCXIeg4Jkzvm5mQIutPqXfVGbphq8Pbl9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UEwCZQDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxcdIlNU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UEwCZQDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UxcdIlNU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B8DE1D00221;
	Thu, 26 Mar 2026 10:08:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Mar 2026 10:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774534085; x=1774620485; bh=lhO4GR8wkt
	jCLjTEI6yJJHgWhiWIMvNU1KNcK1lFIBo=; b=UEwCZQDxkMhHKkzXEEPyLDIkKZ
	q0Ww1330gl1yKSngmHrfw+Yxu/0SJqjfAzMP17NPlrlq3NezpeuVPRDw/3cqQ3ly
	Qero24Sy9CHOEUYUWrNCftcITzEee0xgnqo+PzVhunzVFam0vu7OR07yuc7kJe6s
	uajoti3QOefr8UHR7L3z0XHPfrmSnNfo/gVEM3RwSNMpog+VuI7ixM/84YEyp8IP
	bKHVADdooFlpAX0HkA6r6ZVVg+OkC+hipv7UhJKBjHpVCLZqIjJAx3O4+ccOfJb0
	gubUUuo84u7SkdPuVDIxVDyAymoM95sRTvcO3sj+9j3DMLtg9gL+f/Cg/4ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774534085; x=1774620485; bh=lhO4GR8wktjCLjTEI6yJJHgWhiWIMvNU1KN
	cK1lFIBo=; b=UxcdIlNUPc+/pXmXKdnPXXoT/lrh83wsRHkZAdPpRIxC02PX0uy
	agnBUGT7LWIpufg56Z5CdHtqTZFPyHxQjXdlFJnEUm/jT9XAQBXWxWLwKVDTmVvP
	MI1OIGaEeeUWoowV6AzDOjwTo4dCe6mYZGnVRWrTRoPwT/UIeCDzOHZPB7z6aJM2
	D6FVHJMq3TDZuPmq8eAiHNc9CFHUA0Ixs8BIDo2GH5zzRdbjG4vPyIvS7oHzJHUh
	7uAmBK7vnorCowrjEudQ6OsMuUoF3AibxyKVXLzn2lwU3fjFHfqbczpOwk/ZFOY0
	v76vB7GXrQ2aqDeSCmarh3lNgv93LRHRgjQ==
X-ME-Sender: <xms:xD3FaXLuGFz4IbhajngN1KFsLuczWtoQutaxSTpNPbg189-fJ9_ADw>
    <xme:xD3Fae0zYUF-Muo8WJ0OCXIJYShkisB4bBlO6Y8gygiDCufFRgvQMOb3W-E43xy1T
    HluYz96JTv0swM9BLp90PMx7RuA8ni-GXwHMEfPoKkw1wMI4kzwwA>
X-ME-Received: <xmr:xD3FaZhkSdhgeHx6BYe6XglCRgZ_KgslK9ZiUKI2F7jOaMFUA5bAPIjmxRQjAXVVbRFtzh6j2Y09skgJ--a8-6H68DzC6IwhKA1UM5Ubqx7Clw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghhlhgvthdrthgrkhgrshhsrgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xD3FaXXUrXeDbLxcscUEEug0c8Ib5NeiTwys41ynsygHHaVVJELs_w>
    <xmx:xD3FaQVjNtr9uGziV6j-qFai-GVxaGNWmGhs0jV5xk4UAEo7xDW3Zw>
    <xmx:xD3FafjF6vNMue8q2L9z1hGHY_RumcY3ixmVsqFU0NwJmC4xiu9JZQ>
    <xmx:xD3FaTaRe2eyW7HDK2Gzx3-mQFTCKQV8Gl1AmJgltr6c06zyEDEaEA>
    <xmx:xT3FaSbgZVu7nVavTmn-996gCw-G9K5oPSwCm_C1QnMlEHYo-fsZXWT6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 10:08:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26d35e0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 14:08:02 +0000 (UTC)
Date: Thu, 26 Mar 2026 15:07:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mahi Kassa <mahlet.takassa@gmail.com>, git@vger.kernel.org,
	lucasseikioshiro@gmail.com, jltobler@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 2/2] repo: show subcommand-specific help text
Message-ID: <acU9vzLUPx4tlmcD@pks.im>
References: <20260325115148.101867-1-mahlet.takassa@gmail.com>
 <20260325115148.101867-2-mahlet.takassa@gmail.com>
 <xmqqldffvmd5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldffvmd5.fsf@gitster.g>

On Wed, Mar 25, 2026 at 10:40:22AM -0700, Junio C Hamano wrote:
> Looking good.
> 
> Will queue.  Thanks.

Yup, I'm happy with this version, too. Thanks!

Patrick
