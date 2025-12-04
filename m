Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AC22DF99
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764828971; cv=none; b=DwDBUbR1lEojw5AMx0X7kXVnIVrWMN6AS9KU0ivooTgc9ComT76PdiA2qUQt+H72Hfs+vWg2yZz7Tw6XAD8uW9iLmiAGwLd5U0qyFbWRIHN8mTAHiql8DfYe8MaN4qcE21xfNIngSZOuhCyj9fQ2NkkcbkjQ24iFUjtkVOuZGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764828971; c=relaxed/simple;
	bh=aqaWsLDKA1AHrHobfb2Gi3fJjjznqZ9TeRp+ii5ljL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9HT7bWYtbkJ2JU9sxmojEQuMBAL/DgIwRgyu1hugFYoH0A5WsKT2K8uzGhen/AlJ3JQFIicVKG0rXFVFkD5M73vCJeF/2Y2Ke+FQOiXPTI6SbAKLyFkx+hzviPriQ+aIAAsxZZSoPRr7Gf41Z7SRbWwMq2WWc2HoRUorpA0qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T9TnHhKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPxgsHcI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T9TnHhKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPxgsHcI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A9028EC04AA;
	Thu,  4 Dec 2025 01:16:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 04 Dec 2025 01:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764828966; x=1764915366; bh=71nNZJAP7u
	b3DZ1FUReEZ5n1age7y3hfk3oyzO8FXA8=; b=T9TnHhKMrA1HusQ9vQ9yBarQd/
	m8QWY5w0onkOBtqG5OJoOmntBbrgF7iirleW1I1flrJeViWi9/Nv2nj8MQofscmM
	PuvodyFFM2ABOUSaTAfSd1POyY/zUbNEE5hfa4szN+Yisso0/wPJz5HAkZVjhw2l
	lhmuXUEmlK6TXpMsdATD+mX1DQdfEubRKXxtfcLm+c/KhDI79x93mn5SFjKDMufF
	qe0rUOsvqoHyMewFvRaEnm5HnZQ2Bk/u9VnINeSbLK+/wc196JnIJPI1Xl1jIpRf
	VJiT8XZf1okJjlUD5jWKiN7UeA97CXDwwVtg20nVczZ8Vld1QpEM++YfFnZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764828966; x=1764915366; bh=71nNZJAP7ub3DZ1FUReEZ5n1age7y3hfk3o
	yzO8FXA8=; b=CPxgsHcILSoxGlOOc0P76tk3o4Rx5KqV5Inp5P500Yw7cnC61LL
	IWnUukI0RB8eO7CAGMdoHBHCkLVA1xs8/7ZNCJxNJ7ltKBnjBednpkELJrmmenJ8
	glm61/vfqKOc3ByARtfME32uFZEvRId7L2/yqGjB448gOBf3qnTvVokCDSytRBBY
	BHm4F6ePJeWd1ffMm+kix3uVNa8ph8VZlb37KyZOI5ntsUxwKX1mU35TOIfCfuxX
	mQ8En1kIhFv3d4Zduk6ptREnkbRcLYd7ZeVOlLELwRR/PtX6TnZ66wsbPlh+2YL4
	bCRtWCLBq8MU47UPRwgJFN+cOlGXaOIU04Q==
X-ME-Sender: <xms:JicxaRZrRQm-kvpGlZ5wXjxyxOwsmsTau97DvzqD2oas0qg7JW9G8w>
    <xme:Jicxaeb7n_VuGnZ5P5CnPxrqHfiPgWW8gYX8NBV7Ix9pzOe6uqtl3m9kTiA-nVFr2
    TY_a0N8HXbvuMX06S0fLjepkkh-VBVPuiviMPDxYcYRoQSuDWuUvQ>
X-ME-Received: <xmr:JicxaRnbvzHLzVF_dMvPVexleeVoREehbawC5xUIM0oUJzg36usIszre0HBGOGfQjSqPPbA6F8XuzzjWcTMNpS39x9MGRADpAAvSYPGbgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:JicxaawIb17CYrsWSKaiTMxdQiaGNmywy6IbbBYpzORQJUlnJN02rQ>
    <xmx:JicxafO2ZweOIKR6WyzGdiOgobZonZFyth-aBLnjkc5bAijBKOFpkA>
    <xmx:JicxaeQiI1UUl1r18ywWhlP1PJT0xlNxkFGnJ_QNwdbcxEYx0A8t3w>
    <xmx:JicxadZlE4-Ce-IMDuleRlB_M8KP6yjfYx1rcGKrZnzl3XeJ8N8JiA>
    <xmx:JicxaUy8Cz5C8-YJgMayTsGHeLDGHYOX4_RhKR1Df8RXGPnIUVWf8oA_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 01:16:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53e09aa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Dec 2025 06:16:03 +0000 (UTC)
Date: Thu, 4 Dec 2025 07:16:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/2] meson: use is_cross_build() where possible
Message-ID: <aTEnIOjhi_XtHdX8@pks.im>
References: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
 <20251203145331.621529-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203145331.621529-1-toon@iotcl.com>

On Wed, Dec 03, 2025 at 03:53:31PM +0100, Toon Claes wrote:
> In previous commit the first use of meson.can_run_host_binaries() was
> introduced. This is a guard around compiler.run() to ensure it's
> actually possible to execute the provided.
> 
> In other places we've been having the same issue, but here `not
> meson.is_cross_build()` is used as guard. This does the trick, but it
> also prevents the code from running even when an exe_wrapper is
> configured.
> 
> Switch to using meson.can_run_host_binaries() here as well.
> 
> There is another place left that still uses `not
> meson.is_cross_build()`, but here it's a guard around fs.exists(). That
> function will always run on the build machine, so checking for
> cross-compilation is still in place here.

Thanks! This series looks good to me, including this patch.

Patrick
