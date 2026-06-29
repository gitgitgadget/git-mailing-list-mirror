Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D303C9ED6
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769092; cv=none; b=qr5i+Cv3heX9Dcxl3MlUQa4dEIIJdXAOB/vHuoUYFwhhr7ctuRG0mjDXChgjgTKHDWtVAmaEIX0BXR4ejf7yyUSHsqWr+Wvfp6NgQUbfpvhY+3Rhz9dOKlf8wcEMIfKtC4lcyp+0lA4n88JAAk5hCm/o60zQknOhba0g1fwoYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769092; c=relaxed/simple;
	bh=szue9PqeVnpOKdNtinyNwbeUscnlqD1JEXdDnz2/H1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWPAN/3opqISkZIf4gHkbx4d6k9cf/kV6XOJQsyRPDxt6M2nSGPQcAWBxT31f5HjO7AJHgYRKgh32G9n+r3djwlOlllk0+LWjPFMtowmAFtoTtkBvmaO788WltsA2CMasFIOMqolp7JvRGx+jM+T/AapL610QYvS8aEeDEw0hBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qa+z3bB+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGMo+0VT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qa+z3bB+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGMo+0VT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36F2C7A00BF;
	Mon, 29 Jun 2026 17:38:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 17:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782769090; x=1782855490; bh=EAlGkkNz/q
	NJHdpkIZF5954r76ZR4YXXjYDNkzDXN4g=; b=Qa+z3bB+4YbMEkHjwXRpyWj0G3
	llZGv5hXTywTJ/JotAfhJtmBbT8x8h7sHzQ07fD+HOImek369OSO/pbF8yL1pNOe
	dxCvwQHplFufLhi/rShdEri6KAY+stRnRKJO8PmEh+h2iMjYck6BIZRED1TSWKBx
	b0mSo4yCBhqVYwyhhH/ZSxacitnV5SFTePA3PAx3NES/6atzSYnpQp1DMTJ8a1dK
	tMuRfBlO7QCcTpAzdzVLILzzgczE3iJbkjIMiqh70jU82G3qY9/4qIUhDKIV/fIe
	fCpfGEo+UysOBOlxsorRKoL7xT2mZ9pujDqjFODcgax0YHpYjw5Anx5/mBaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782769090; x=1782855490; bh=EAlGkkNz/qNJHdpkIZF5954r76ZR4YXXjYD
	NkzDXN4g=; b=CGMo+0VTucGRwrwa+3i8VHTblv79XGpRniHkI3UHMXux82e+pby
	aQS7C9UQIj7h7U8UWZuYwgFzekIFl24nBvjFqBr/5FEpHMPSzd6O72mEnnG0dT/l
	0MHkvtcFc/1pnDZOk/phiGuEOSfKH757Li4liES9LJ4pdSeQutlhw3AYFFCSvL6a
	RgZikr2oOAxKbf2Mh7P9JKo5Ov0DFw20WKoRbiN0/tOMW9/OgRgHherU3aFhc8ch
	rezOnH03XQpsvmOketx5kP1/79IrbAPlwT4Ei+IiMZpbuTu6h7vlgp4ViGXAo9Y+
	tfhX1CetSARrD0bJC9JBIwECrE8V5oQvRqw==
X-ME-Sender: <xms:weVCaiLr6KLi9kWr39pXCejkBXUCApyQsDPFu5UKofCnvjo7RbElag>
    <xme:weVCaq0XdG6Ke3xg_fI3wXbhrk6b6JhblHjCz8XVfGNpJ3oTYSQyGGmw18a0Ne5aG
    8NbsyMd5Q3g22V4zLZtkNzMWcDfQfdCadkKMHLgA1zYyLvUZi5ogg>
X-ME-Received: <xmr:weVCag5X5HW0UmfHIzn9GruFYtVMY2gkgEl4Kcf9vi-Ve2qckLc0hkYpEyChcAVPYoZ15og0y4gKgce8sz-N-L3ElkDFiZVjNJkQi1w>
X-ME-Proxy-Cause: dmFkZTEtNLtceQoTR6YK/buyBMwQNc1kXHTMF9qDfEIcShQvHCEEViO22eTVnwlKqRdTMI
    xumst4QvRPwPtY9nh2IMU38aD0LHsSEms6vtuRTYK2/zA6JYXAV8svn8w372qL8vYUV+Dh
    ULjXXm9kXu6Cf/mLMcRrrLxceJ/Y9xBudkBheowU0NYUUjnWfwmy5ovwl3NTIj5qXEnDVJ
    9khG+Rxs355Hbam0aTGFoVWpnjgFKvmF8pq32rBQNpklsjnlPBA3MmozkKcAgIroopv+tb
    DOkbCuxfpGfk2LuboM2VHcrcgUIdx4SMvoOvZoY6IyqwGPl1feB4pIFca84pjSb50vsbhQ
    5I128YCv+JMQykwDhuw9rBStuzUnxnz/7vtnuDV1Tx8/g0s1sufePEe5r2tCopPMVRnPVI
    MTAPGQOO58MOjH4E9AsyGHe8UwXlmvzanymb5KDLuOOZ1yUA8yBOykmuvbkPsEWmJ/66iG
    46DjSBB7dP2qVIfKHtP4majoJ5rSXLm/1sIrBE1cE7+ye2DdLwfudg+pi+Sr0SGhXMgu2S
    SqfpP+AytPhZvcMP9L8WwY228YM1+05JFNcuBZxZ1CQER5k3elo5/1Ksisy0Xs4a8BjsVN
    REmGbZV5yQWvxC8xuCK7wdF9t/w1Pyc7wSQ8jdjIbUrc7cDqsGtJItEx6y9Q
X-ME-Proxy: <xmx:weVCar8EpQ_OnVS7veuTw3675EJkyeJuyjS3d8dX5X6cg7zZnVOZHg>
    <xmx:weVCavX6dGFcOlbdfy9hDamggJPEWo6esXT2XxkJc8wlgnrOyb0fBA>
    <xmx:weVCamrzi_YYQ5EM8dOIYLXTZ6yFxHk9umFhJdhd-Njptvwm93G1CA>
    <xmx:weVCahmejJuSjqRMmkXgWs2MSFMoQ6gkr4gVahnvpjPhYB6z4ugn_Q>
    <xmx:wuVCanG2gu8RBesQxIDN-4_7J-GGpKsS6O_eVTiOTIQ6kFzAtlrK8Gud>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 17:38:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
In-Reply-To: <akIL6oJgUv8J8SB2@pks.im> (Patrick Steinhardt's message of "Mon,
	29 Jun 2026 08:08:42 +0200")
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
	<20260621174934.GC2206349@coredump.intra.peff.net>
	<ajjuoS5Qc3K0nCRl@pks.im>
	<20260628081806.GA3594700@coredump.intra.peff.net>
	<akIL6oJgUv8J8SB2@pks.im>
Date: Mon, 29 Jun 2026 14:38:07 -0700
Message-ID: <xmqqmrwdt4cg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hm. That makes me wonder whether it is the completely wrong approach to
> make this a build option then. If it works on some systems and only on
> some filesystems, then a build option is just too coarse-grained. A
> distro wouldn't really be able to ever enable the option, unless it knew
> that repositories will only ever exist on a filesystem that works. Which
> I guess is an assumption that no distro can make.

Yes and no.  Build options are not only for distro packagers who aim
for widest audience.  If you know the target box with its
filesystems happen to be OK with the option, flipping the switch to
turn it on is totally a sensible thing to do.  It is true that this
one is much less flexible (because the situation you must be in to
enable it is much narrower).

> So instead, I wonder whether we should treat this the same as for
> example "core.ignoreCase", where we only use nanosecond resolution when
> opted in by the user. Ideally, if we had a way to detect brokenness, we
> could even make git-init(1) set it automatically.

I like the line of thought.

The ignoreCase MUST be set for correct operation if your filesystem
is incapable of case sensitive operation, and if your filesystem is
case sensitive, building with ignoreCase set may limit what you can
do, and give you some performace hits, but also the code can make
assumptions like "ah, we saw 'Makefile' in this directory so there
wouldn't be makefile at the same time" and misbehave).  In other
words, it is not something you set by choice.

On the other hand, nanosecond timestamp does not have to be enabled
even if your filesystem and operating system is capable of keeping
the timestamp always down to nanosecond resolution, even though it
has to be disabled if your filesystem and operating system randomly
loses precision due to buffer cache getting flushed.  So there is a
slight difference between it and the ignoreCase situation.
