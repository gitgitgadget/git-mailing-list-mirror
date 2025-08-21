Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16730EF9B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790942; cv=none; b=Wfuf0xByzyfmysOWCMr8YQznfl4BiRoclKvWlLbvFe4hjemNLKtaTmscePI616bkx2/Z6ceEYWNWFP2g8tSfjIg93XG5f+oP54uW6oOl/eBkdfL+hpmZjWxxPayzEejViTjmAMYxLXG2uFDBmeaLArCVQJ+EEIrTAATpZmsk8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790942; c=relaxed/simple;
	bh=uyBdzd0nBOdlEKUlWqd38VHwhU+GPUeBgLwt3+oWx1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BoJJbCRy+ALv9nzUhnO+fJGaK98EHIPeK9K6X/PKITG1puDjZWSoYUvFdoD5hpwl5rGnZlrKxxOvXC+oxiX1f96bQ69J08mU8goEd19u0x2hSXcXQq04xwYOMvYdFgE+Hm1YA3ZsPol+rm7O9eHgFoI1oyK3nBA/exIqJ+cOq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WPXuVg5i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dMfzVqJk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WPXuVg5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dMfzVqJk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CC6651D00170;
	Thu, 21 Aug 2025 11:42:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 21 Aug 2025 11:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755790939; x=1755877339; bh=uyBdzd0nBO
	dlEKUlWqd38VHwhU+GPUeBgLwt3+oWx1I=; b=WPXuVg5iF72bo5B2zNbMs5PCYD
	PFRM1tP37RBVD02fzwC6SRKBlHFdx8ZuO6xNUIJPRmMGk4H0DBEQYyLuRapizyHw
	jBf+MPDc1071cDO4tLFFRZia0z1ZW8/4tql/B8Fw4l7qn550hdzk8I7+pybO7Mu4
	diOqLPQso19NnhugXopD6+vMv4z7ejf7cBh+zgtTHCgSn+ctWuCtcV3IA193Dk47
	XhXduYR2/gp/KWvRYUU3GaAP+Df/4+HqNlYUyeWZVu/IyW32U2OhS5l2yxXUxukO
	dIZyo1Ke1q3Am2veU0KNyjJomAQ1mAhU4es2BkXAtJQHG9eDXjIZg8ngoQUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755790939; x=1755877339; bh=uyBdzd0nBOdlEKUlWqd38VHwhU+GPUeBgLw
	t3+oWx1I=; b=dMfzVqJku+TUWCEPGzjd5xNSM7wDfWRkGMLKCKn8GNtjm87CAfU
	Remk5BX93zTzW3xz4xO3pWC+SZ79yYHmLczG75TMkQX5IqNg/q7yC+c5rMw/2ZA5
	l6NWPNyHprBn9nrpRs1FtvmT8st4GJoSpU9MpSmexWpkkq04mQ/TEJoYxDmPHrF8
	B4xO0Zb0n3GpzaKzzRL1VMcGO9zQUEj0s0ZN67nFD9VsFnOCpLil9oeQXcwXKwtl
	IllNYBHYHnB4iM4uPDFC4BHYr3X68yG+vuwbCRx0lKrqLfgcBMhqu2s5yjHsG9m/
	p/wRzff91Vm7v08fy3ux8LQaL7v09vFqe1Q==
X-ME-Sender: <xms:Wz6naNrHwgrPXpyxHkcYrNFi5CqW7H0JRoyEyM7Ywfuaal5taeg7Xg>
    <xme:Wz6naJEptoqvthvBeUu_En3Zba-7dHBg2SH15oizjL9m0FSIjfamxjYyKaGaHAyaw
    77C_thGXlBldVhcKg>
X-ME-Received: <xmr:Wz6naJxGKhfw-u7ChYHTNJDctPEreMqSTj3z90Kd4sh6ivDJ-7-dcyHf8EYb6v_ldXYZDoRZ4u29lHEpRpZgcYALwLvjeEZMpLj33m0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hishgrrggtohhstggrrheslhhivhgvrdgtohhmrdgruhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Wz6naOpLK8BPQpfZ-hjAWOaEAxMQ-XkkTBmEw3Kg_BySsyUpix_ABg>
    <xmx:Wz6naDh1iLsnMQR8pf4rpTfo59uqjFSN_QWVN6AWSkRm-wzz-lo61w>
    <xmx:Wz6naLjLHLWL80eGhxJ3DruxUMXi5L6MduXexjzCV4GiJb_dsvNAnQ>
    <xmx:Wz6naJg3i98Ef4rvm0KeNv_arQE_NVxzM52UpEWDXXGHDTsOpsoFkA>
    <xmx:Wz6naESlpUBfclYXDxtbqKigPpqD3uhWd1VaJ2rD9NbiGDfSE2hlblgQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 11:42:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] add-interactive: manually fall back color config to
 color.ui
In-Reply-To: <20250821072224.GC1839835@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Aug 2025 03:22:24 -0400")
References: <20250821070740.GA3356411@coredump.intra.peff.net>
	<20250821072224.GC1839835@coredump.intra.peff.net>
Date: Thu, 21 Aug 2025 08:42:17 -0700
Message-ID: <xmqqh5y04r6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Instead, let's do that lookup in the add-interactive setup code. We're
> already demand-loading other color config there, which is probably fine
> (even in a plumbing command like "git reset", the interactive mode is
> inherently porcelain-ish). That catches all commands that use the
> interactive code, whether they were calling git_color_config()
> themselves or not.

A very good design decision I can agree with.
Nice.
