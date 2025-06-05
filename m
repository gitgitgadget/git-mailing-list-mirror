Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306518A6AE
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148188; cv=none; b=WRMar3XG8Sz2vada3AQ9LjAaui6KOUYORdBEYA4hEO5U2Knh5ti0ZYbnVEbrcmVHSfG5GsbD9Rb3zNUrWTA4BVJKZX595r0hWlObNrM7dyWzmr9ZRibdXeOefq7dafO1oosjG2c0s4Oftm0Dhkc6UfloeIVhw5mG8YStdodDp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148188; c=relaxed/simple;
	bh=BlYmbqFXWz13Of+ZqTy/eAE/rJ4jpXF/MbiTBkZQELI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktqjMqh6OZ4augxhm1F7e6WZYtQjTIROIxJ1DKjqw21H76QpMWJsrWAvWqbzBMluZnaqN2VfIXeI8z2anygJTqDkmvJAtQQglEePcN2kTPjCEel9jPXKAFk/CV9XAJbAhV6WHpv8VzvfvrUYk4NbXPzLNFtWoGgZczk0CwDwN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CE0P7emw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbOdS5h8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CE0P7emw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbOdS5h8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D967C1140130;
	Thu,  5 Jun 2025 14:29:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 05 Jun 2025 14:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749148184;
	 x=1749234584; bh=rU530IMxtK81QOZg2OUtN43kXOWxPPW+ac02wVzk2yw=; b=
	CE0P7emw34csr6w/FdYdgKG4gNGTXYk5wMaSlQaoyDVFa4STREiNgrZm750iiEMv
	FgYaKZXc35KTn+Ovxms6XqPxUx4gL2ZEIyEu1tyNoEy9xDjG8UyeQPMZL/G8nLOo
	14UnQJonxOXppxCr3hI1Ib5blElAHPcOfXvelWdgk9nfC3SBZwSM/JSRMH7yBdlj
	ELKl6bUELooftQT32ME1OXzG8YXFB4h7B6ZOz6Qq0RZWR47RGjwUlYCw3C0wgJSR
	KfF/MqHM+rQ70tSEOC0nIXmOJiZ1FG+dSveoY6KuxO8k9xmf3Trat12fhI+s4y90
	rtvWXFfpElKIYM4ITuO/gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749148184; x=
	1749234584; bh=rU530IMxtK81QOZg2OUtN43kXOWxPPW+ac02wVzk2yw=; b=g
	bOdS5h8kTBI5E91vARvls8gjJoamv5nkgiTowQudU4EWUTzXGc4lQ6A8U60Alli5
	SKvsSQkNtITipickQyPKQMOWInY4dFXy0jz57xHSW2eypk01gAJOlhTbPQ/vRcrr
	rLiyxwEbWvESf+Yk2tUM/UncpkeQshBZblHy4WaXDaAVNHQvB9XrKBrvm54PXWh0
	P/3aoNBgkGJy24s/bPykWbeVeLgSbOS1SWe9e09ImPQAwTCH7/1tiC8apKqXAGJe
	kWMjA+YAry0GlefHHP4OKc796X0XQGU/LJI5n1k89OGbV/ETrNLIqRZrCGG6Jo7J
	1KcYxaB3WXF5c9OlBOBkQ==
X-ME-Sender: <xms:GOJBaHSGYrwhSWjOlfWGZHx96688nWMcb203a5PTa6-DdCYMkZXURA>
    <xme:GOJBaIyTpY0O_gJ_mHuLwKcSEzhVqwRjz2T6ggDZeKcgZI70b5BIIyjI6Wogmeok1
    6ZoWQB0U3CS_l3POQ>
X-ME-Received: <xmr:GOJBaM3yf3aostMT8bSb5QiQhIG-kNakPJQ0ww5zzeLQtglOHe-O-z2TAYTgBOvPvWDoLKT47go-XxcJu-_4oJul9fV83rraidfz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghvrhgrihhphh
    hilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:GOJBaHD7fUgrgxdVaEaFMnR_kGrkQn9o2hzKMNqkZyk5bWNnLsRIMw>
    <xmx:GOJBaAhzDjUOuYmSPnPoGNMyRr--1h46hw-NmH1LsABTX5mecQyoPw>
    <xmx:GOJBaLrGxg4QvhCFICGjGc0CXkQe-XYhTIYHaOgEN7vQxqjYJ-ls1w>
    <xmx:GOJBaLhKQ9MnC6hfAJT3kL1oUooleJAGySnGOHCIh5zA8cx-H6UzDg>
    <xmx:GOJBaEdmzBfFFfv5K-Gb8x4MDsp0qksVlAh60jEfqoR7HXlP6F04O2y2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 14:29:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
In-Reply-To: <642C61F8-FF74-4012-912F-51D364D1B2F6@gmail.com> (Philippe
	Blain's message of "Thu, 5 Jun 2025 11:10:02 -0400")
References: <xmqqzfem9ws6.fsf@gitster.g>
	<642C61F8-FF74-4012-912F-51D364D1B2F6@gmail.com>
Date: Thu, 05 Jun 2025 11:29:42 -0700
Message-ID: <xmqq8qm682jt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Yes, I got pretty busy (I’m on parental leave!)
>
> Feel free to drop it and I’ll resubmit a new version in the coming months. 
>
> Philippe. 

Thanks.  Enjoy your time-off (and your new family member, of
course).
