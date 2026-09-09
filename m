Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2D41E6D6
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988045; cv=none; b=X2hWur5EeO5mmqvlyyNb6Lo7IkkHuWJiQG1DNmhj5Zg3OUzNR4Ujp1etcrkiUNxtxw7qkVYphl53zEfeIRWPv4Vnme89nXb0Sk/G+pmUWvYAueHqJHD+eHyGcwD3DvXnV5vXyVZE53hf4/7A4+i9AecXkuBViNg41T8U7opaTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988045; c=relaxed/simple;
	bh=l2qByuezVPOOX5bIBztMc5D7tELHWX73UrDJpxloiMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tWkxwkcRIkw/gBZ6tud0Zb7AQsQwh9Cr7WWd6Lm2LRQFvywfD2p/R/o2ZSE+bmwb9r87+w8r3NrObEDwBavEjTGsTH+pBl5uYcqxWRst7HVMNR3v2lsByLO7E9QT5ZxlZXMlTSi0FGt6STminNvWlg5x1Owt2dK2pJoELbgTGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X3pv3gg5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDDtVx+M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3pv3gg5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDDtVx+M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE0D01400041;
	Wed,  9 Sep 2026 17:07:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 17:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788988042;
	 x=1789074442; bh=F775bzqYUP/wpxrOH5Now9NZ/JrG+g0dmrb7zi92Lao=; b=
	X3pv3gg5jUzJzQ9j+ZDAK9iRURtdBY4lwX1JrES1WAJKqbhw/3uifVteZEfKy9Ma
	8VuCeUptQC0mkWCMHUjj+rprZFdP2mHFnOcAnVrNFGc8oaxC5VBn9HWc0hlCCa0h
	aq+sLJ+xzZq6Q/ZJRkn8pYyRMdUae79loxKjYhggLlS40mEDTcPIYPuOf2iP2cfi
	yaVkbTAluxi9CyqE6IupfYeKaa937pvM2mO5qdfsd0lSDFp3VaAwnTYGhMvcxJr+
	4ELHD3/2A9+DnTfZ4z89CLHOGWCwE5zKCoMPxIZantoFxh9fgtmWMNnZwQRW0WqS
	wwtNb+5b/GXz7/5de69F0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788988042; x=
	1789074442; bh=F775bzqYUP/wpxrOH5Now9NZ/JrG+g0dmrb7zi92Lao=; b=s
	DDtVx+ML4C9EM/ihTOhRbvBlwihhHxiTzS0aH0GIvWFYBWtEqtvuyW2h1Oi3Mtj2
	J5DCxLrlU5Ezky5B6y0X4pn48cf19Z6KfipVoEsyfalQaKftJRlYfB5LyR8JB2lF
	VEGVV9a2056++EnwAU+bwxMHmCCgA1HroMcniMJH0DXi7bbxmqqHjCs5bYpa2Vjj
	gs39HaV/qRHQXINaYhTY7bhBAfl3we+F26qkTRM2WCiOWIo3QddM0DKPRpg1RqVX
	R634syW+l7QB9vP4O9CN6qQmaqU6i+KkiZTqdL4glB2YfdPYBbKVw3TwMFxxCy6b
	C0SG9SYJAs7ooni7Ut7Gg==
X-ME-Sender: <xms:isqhag3eW_YbSlNMKfxYLv83E-tIxE4bVKhymyvNqv8wliTimopXBg>
    <xme:isqhauVBF51-JiljUNo6CXM57FliY1t4ryf1jZLGy9V4pvCRJYVu568QEW-z9oELJ
    0xZQ8s7ivnTdgOiwCidJbK508-jWRkBrW8Z6ruhmLKEyJHxd9Wmg1Y>
X-ME-Received: <xmr:isqhaiVQAQZPwaYnMWNP57Py9BE4mEv-RDQDWmGPemgQ7XtC_iHYT4ejwr8tEnvdfm0-vf8hGAk_I81RnGeOLDQB8-oTqLGZGX5B>
X-ME-Proxy-Cause: dmFkZTFDDcDTBvH6phpNG9fLGNR403s7ECls3VeCbDmzuCsi71kHBiUrDa1KU8dFIUH5lm
    4zpYqQT+2bHE4kwjPELaXSK+DeKbOH8XTd+A9CDqm7c4VnrVnyUNTsejHD4uiVbpKHC7CZ
    b+64YXJ8Dlp9/yjrL0Yu/xO4fF5YZU4x4d/zN1dB1pjWI5cZETszQcYPk3ccQUgkDRLr2z
    legxKw+3nbyo0tuwmDG++ajjQJw/Zp3QtQFuIdQhQZ7k38pE5s+vqPP2DMy8n8rklRPa9u
    skbdEBY2kr1M4JYWwmhayDbLGQmELrB8uTdGoxDPkQanSOcojiUeQXV5jcbyhxLLfvg3mO
    kVmuH0Cr85wX6nplnO+D/ujPCtCkFIP++i2SeNDuMAAZuLJUCw79PDZkPnbvlAg01Fsg1q
    a6EkZ6OcRSHs7cTSttOsg4z8UsuBCYx83JBYUEvT6ONOL/hCCmvWasF9zUizQGdgEE6pqu
    3asc5tt5UkNvdI+dg03EJEUe4rXddpyNfMJmTqkYtg1IQ5ufLHHZtmW6pNJTWGHoCd2Ign
    w86Nhgz46Ae4pjpjZYWvJbwEI4qtZvHlGxPCWiVnmzry1+RXQe+zzOMm7V3tuOot6Rna/S
    tTk26MQJp3JhHAlG/bjy8FJ1S4k8ljV9WIfR12L2HqyKAKlMq29pm1pqkA/A
X-ME-Proxy: <xmx:isqhalfZDR9RjqoXqgBc0e_0MeiqbiWtSHVYA_8C07sJWy92bhGfDg>
    <xmx:isqhajU174KDqQ6qsel2yd9UTt5CzDjAK2KgxjB-LDeRl2-a2XTO8A>
    <xmx:isqhamdPVho1BFyTSBBAaDF4mNt3tpLF8qif2jjWcqCgKaxCOweqRA>
    <xmx:isqhanMZOarUwfO5wcnIWdL6_3ijWAP8tiGdEYlZWN0x4ZirZ3yA0w>
    <xmx:isqhaq8mth-nHd8tnd5QnnCb3RAsgmxRUyCdgRjbcQMJCDMpl11yHUg1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 17:07:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] Makefile: reintroduce REFTABLE_OBJS
In-Reply-To: <20260909195006.2179119-4-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
	message of "Wed, 9 Sep 2026 21:50:05 +0200")
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
	<20260909195006.2179119-4-szeder.dev@gmail.com>
Date: Wed, 09 Sep 2026 14:07:20 -0700
Message-ID: <xmqqmrtqp20n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Object files under "reftable/" used to be listed in the REFTABLE_OBJS
> Makefile variable so we could build a static library from them.  This
> static library was removed in f3b4c89d59 (make: delete REFTABLE_LIB,
> add reftable to LIB_OBJS, 2025-10-02), along with filling
> REFTALBE_OBJS with object files.
>
> However, the reftable source files are kind of special, because the
> reftable implementation is supposed to be easily includable in other
> projects.  Therefore, the reftable source files don't include
> "git-compat-util.h", with the sole exception of the purposefully
> project-specific "reftable/system.c".  Consequently, they shouldn't be
> compiled with our precompiled header, as it does include
> "git-compat-util.h".

This is the first mention of "our precompiled header" in this
series, and the first hint that "our precompiled header" would
include "git-compat-util.h".  It may probably give us a better
organization to state it upfront at the beginning of the proposed
log message of this commit.  It is of secondary importance that once
in the past we used to have REFTABLE_OBJS Makefile variable that
listed some files (but for completely different purposes).  How
about explaining it along this line...

    The ultimate endgame of this series is to use the precompiled
    header facility to speed up compilation, and the plan is to have
    Git specific headers including git-compat-util.h precompiled.

    The reftable sources are largely designed to be independent from
    the Git source proper, and except for reftable/system.c they do
    not include <git-compat-util.h>.

    Move the object files in the subsystem from the LIB_OBJS to the
    REFTABLE_OBJS Makefile variable, so that we can use LIB_OBJS as
    list of files compiled with precompiled header files and others
    without

... or something like that, perhaps?

