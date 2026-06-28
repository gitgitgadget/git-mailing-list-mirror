Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C822370A
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782623450; cv=none; b=QbNc8jhLomBSm5IDfGjI6l2o24bB0VyN06o2JvAJGpHb/HoNQSIqjhznXK6lfPKL7FvzPUj31GkCsLCibX/7lWBvoeGQdCXftOr9xMaML7iNZTwk1Z2yAU/XswVk20Ei5VAWOjUJcAEeh7M3rfSPgaJoGeZzL4xYbibVxbGZ8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782623450; c=relaxed/simple;
	bh=4FT7Vu16YbnqSyguxqToUKlGCygZWpSAZflgf+ti13w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXF7lDaHxEGMJ1Fe0qKvk7hI5PHX+/BZmkwz89yJXktWxubVM7B2Mwj3u0sbvjXXU8N5C4o042oQeWZ5s1qAm5p8fxhTekt5r7oqHa8LbTIHYhKCMBEQHX8Qf84i9P89hJYfjm2R5bt1NHp3wBVvCNo4fqtJ5A7ffMoc4kPTWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N4dJGxN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvHEowNh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4dJGxN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvHEowNh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FA84EC01AA;
	Sun, 28 Jun 2026 01:10:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 28 Jun 2026 01:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782623448; x=1782709848; bh=GCgpYcgzIu
	rDHDvnaJfAFuIPV5POLPJ3l6EqL5lypq8=; b=N4dJGxN2BdgYCel1CRTHCeWJFA
	xVobzAMvTm+2Li1FvCiPDysPrGqm3gt8UyR39naDxfNKSE5pYaaDsxyAqnC/iG00
	hkzskEfXPa+oR+4l0obg/yUGTs3Dd7hIV6WjgSmPs1JjfnNDZ03qQJjRcUkMRkyO
	QMVRY8Ppy+A1shPHFz83eyI+dRjQDJ5W2Bss0OW0a5jPS5qFTayGB3IbSSyO6KWp
	VMnGtmqygX0epMdKg+nCeG7t1FYsdtmM33gYCSaLFdWksPk7H8fPdI6vE2/a1pU+
	WIW03UbwbqykAGAPFP3YNhqbHnjBoE0dIXhLRduu6RhE7gEt52x8ob2uSOMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782623448; x=1782709848; bh=GCgpYcgzIurDHDvnaJfAFuIPV5POLPJ3l6E
	qL5lypq8=; b=ZvHEowNh6XigMcL3G6of8DL1GDgld4UJkIwjBV/cPyXZOigK0KY
	e41eiNiFmVrKOPoWlARqRSMJUsCtOzLxcUOqYPlHHUXolBxwGMTvPapOTD+dlE5l
	suYjCrAdHDzDO59N/iv0RyxeHexaPT3zbH+dfqHNPak7+mECVz1fqtnoFplJbeX6
	GTGK0oGXhM3NskD8upBuYtybZVNGZ1onGDfVJ7emSzDnLJPEoSIf0RUY1fk7Apr9
	jGDUD2rQT9MbxQppHjluIR8xJG4NXQIdC8eH29cW4vzKQqEFjEplDgRPoqicTk/5
	N8Bo3s2rLc43zxtYWezf/ozvzE4YEXFncsg==
X-ME-Sender: <xms:2KxAam6kxF_jqNw60_jVZ5xALWGwKWBKJtw7oa24qxmmq-_1_d4OHA>
    <xme:2KxAamy9CYf8F-JWqy43ql47WuLKsJTluLABBCfN4WhddncUrN_1WxO7ljrioTDuH
    tnINMf649T0MOzZFxLgDY0BG9nfmzoRanYGcttuzORrkF8y2qf9wg>
X-ME-Received: <xmr:2KxAatxB9ynsbuAeloRl6SuqYWxvBbI-6Wy81mzkjfTgQ-0r0_oeDjBVgVVnVJvVCQR-cOVCxsTPG7PJMwLiGsfHT35wXVj2UPNeO1g>
X-ME-Proxy-Cause: dmFkZTFB8+Gp90WssexjFNNNCgtY7O2k/j1ZX6F5WQhS0lHxqV5qMGiNv3cGr7kTDwgzL/
    yAQ+cm5YhcULE8q3ob40RtBWHPePOdyCdg2Wcif5ny00j/bZpKTNkChX/3OTP3wlnu27Uj
    dEEdtrJpNNr+lI9+apJlyoJWaiHmK+oFfM5JOn02qMNJgQ/pMAFZXVYTA8q3mT4RUJzcZR
    TyJPpOIsOWYrogKRD8jgLZaNDykoKZ8X7/tUzItuBUiZs6xLyGV1SgUtptFGqNaVTnR2Eb
    4UYuEMozNFT+18As+FJYumvjsG0E0nL7GDMAFpLDBav8G+wiN3pGsf/I1MrCWjCkzwf+KW
    zFxd4wau24b8xMWo0M79SQ95RB6382K7jd+/Mq8WpV9ExU/7pvIofGyBwAGlIkocy/jo1D
    mIu5F1KbVKuzEYIOolMXR/f3CZh+wQU/BT4APMHtVyZcSWcitl+Go5XQkAnk956qeclrIC
    O7xqIXPRtO1HiThFu4Rabik6QC/RSxxuWZCu+MqjgLMThatpf7dhbNx3l8363P+zxDHMCw
    i+6lU6i/Xh/bDJnIdQqqtjA7MNTtcHGcBxKfhKGqGrqJno8uKEbetIb3ghS2tROAmP0dfA
    8l4SQNwtpcj9IRJr/SjIaOsalWrpxf7Xl5tTCgWwp9gGey7tFyVPYMUNHo8Q
X-ME-Proxy: <xmx:2KxAauzc4wdh-2B2cse1jzvCvYOaojvSVwcXKRgVQ9jLX3L2Uqr-hw>
    <xmx:2KxAanbVJptN69CGARkYMx1phnnRwxpQ726qpLcMGYt-lYxPWHI10A>
    <xmx:2KxAavVAFRRVRVkONCcM9UE0AOBooqT4cKwYmT70usJdUfOMMrz99Q>
    <xmx:2KxAalgOflP6rlK3gF6tWPAK0yQqqdbJF-FRW_fK1BnglrH8JBuRlg>
    <xmx:2KxAalJ5q0m8jzTnNkw1LxMVzFKkvYycMUimI73PJu8-Qv1_U6HlKX_q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 01:10:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aliwoto <aminnimaj@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: accept https:// proxies again
In-Reply-To: <xmqq8q7z4eg3.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jun 2026 18:54:36 -0700")
References: <pull.2161.git.1782580676734.gitgitgadget@gmail.com>
	<xmqq8q7z4eg3.fsf@gitster.g>
Date: Sat, 27 Jun 2026 22:10:46 -0700
Message-ID: <xmqqjyrj2qsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> From this function nothing returns an error anymore, and looking at
> the preimage of 663d7abe (http: reject unsupported proxy URL
> schemes, 2026-05-05) that is the source of the bug, the original did
> not do anything when the corresponding code did not find and set any
> proxy settings, either.
>
> So perhaps it is a better fix to make it just a function that
> returns void with early returns?

Nah, I was being stupid.  Disregard the above.

The whole point of 663d7abe was that we wanted to reject what we did
not recognise, and we cannot do so without returning "good/bad" from
that function.  The bug was that we did recognise https:// but still
returned -1 because of the bug, which the patch in the thread fixed.

Thanks.
