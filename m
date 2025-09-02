Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAC22F16E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830913; cv=none; b=G4ZScGHbHR9Tre24zPzFAQYSdzQxbBya7mDU7BOze+VVFPKh/x96rucbFsCZo29wds2D/ip1UVWWv4lbAC5EEbEsTUQSe7chplXCAXAkUbFG9MvM+5duDFR1h8rYUz7GPd1+pQBWj7TV+n/z5qPE0vUWYjOty8N785T7egBIze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830913; c=relaxed/simple;
	bh=hfpU+GYgoFd223Hc6oFCl6pNOUCEB+A0ZcevaZrauNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRJlWDJD/GkSAt2+0cHDsbQ9KJJAyu4cO6sL7YiOChqB+dSxht4Bdgdn2PUa623+UfcbjZJY7p9aDKi7aKL4D771kaj+siYTgQhzjlrxX3D1LMbZ8jEzLHaWCyocpMCRdRqaYSovz1clGDZz2SDmxNz4w/5hNGM4/YkvI9fqivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EOFn0HY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0Seq87Y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EOFn0HY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0Seq87Y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A544F14001D7;
	Tue,  2 Sep 2025 12:35:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 02 Sep 2025 12:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756830911; x=1756917311; bh=67N2/eLuYV
	HUtt2/cLum7Vgd/pN9354XbyY8ywUCLsk=; b=EOFn0HY3dlGMkB0nMzNC3XaiIg
	SpsWX+KNcPb3AfZv8zfy5cCwmaLzFEwGz2psBiuWGPHu+DnPtFDYWyPovOejuLb5
	53otmxGkUu8Yc7Ic1jdyRbnN12kDELXmdIvUjHDqj7fAy1Mdi7FRdtAbWcDLOBTg
	KO7p8tfaLsZcSay6tIZUVe5DCzM8hUvLFemjylYkgNmFa5autf2lfDNch0HPHtXx
	iw39mynIts+g5dN1aC2CEZPme6sreSqMJ4e7o4+pdatYedii2GeJUZrvgOoR9BvY
	lC99Csh7TuaSHwJUw0mAuHIAAA+vMhKG0WsYgxFr+WpscxQzhKV1bon1BX3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756830911; x=1756917311; bh=67N2/eLuYVHUtt2/cLum7Vgd/pN9354XbyY
	8ywUCLsk=; b=H0Seq87YOGZ3ADD2i6j7BgLKTce87lbq9fB8wom5fR6PYEhCqj+
	4yB57VTflL2WrpatlSfy2VCfSS7PZU2hB3n6DkVQQozM2WIAawK/AS7mw7lrrClH
	irAdCzQwFie5G4931ITCzC7yI0PB8OXBjkdHpg96j50pPIIpvbKVgik5LJy7pre7
	RyYPd9OJwlXWqHL2+mpqGUPpqgns5wqceRKX152Gsux5rqFuTQWklnGhHM/krJmO
	1fOxy3+Lo7VVj/9u7H5uSqYfBviLu4XYT2JLlKQK4ITOOCp5kZqlbvlZJSJtxJR+
	1cFzXKgubpv4s7144aSHMJYZyiG0V8B4K1A==
X-ME-Sender: <xms:vxy3aHNbFN6axK1AAkv2EH2ZVyx2heakV2Le_FdSrXpSmj3L6JgyCA>
    <xme:vxy3aFNKVhVn6Eos-d7MHWT1fpfMpSeNnQp6STb5BlNZS7Mc3xi1WaBgMg2Mvjy2E
    Bj39yROs3_IaHQA2g>
X-ME-Received: <xmr:vxy3aPu60gMJ8zsnOYRHALP1K2O2CJpo7LFrByT1RvHAeJUOTduA66eJ30PEHoeVjtlW_omKVa9UryhBdGAY1x3njBbOqnPsPQXZ1oY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:vxy3aHWafGihcc75yhknf4QpJGBSN0IoCvJcSex_6QXbpsEOaeGiKQ>
    <xmx:vxy3aPtiQFSfa_zPQOIOU01KH-n26jNCYfXKMd6pQwk6CTk55W-iCg>
    <xmx:vxy3aLWwjg9n0ywbuWB06VsZe2DKp3Dd0k235FJ_J9QE1C4_y9OEzg>
    <xmx:vxy3aKmbjhLugv4jDxqSZ-MjE_2fo7jtV71-6cNOZQaE0xNt3PMGVw>
    <xmx:vxy3aMy6BcpxDs7U9jSACu9raW6txuhlarBBLCw0wtBsCtCPokTo8t5n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:35:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: disable realtime monitoring to unbreak
 Windows jobs
In-Reply-To: <20250902-b4-pks-gitlab-ci-windows-defender-v1-1-fcb1f19321aa@pks.im>
	(Patrick Steinhardt's message of "Tue, 02 Sep 2025 12:47:41 +0200")
References: <20250902-b4-pks-gitlab-ci-windows-defender-v1-1-fcb1f19321aa@pks.im>
Date: Tue, 02 Sep 2025 09:35:09 -0700
Message-ID: <xmqq8qiwlsn6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The GitLab CI runners using Windows machines have realtime monitoring
> via Windows Defender enabled by default. This has just now started to
> cause issues in our CI jobs using Microsoft Visual Studio:
>
>     Program 'meson.exe' failed to run: Operation did not complete successfully because the file contains a virus or
>     potentially unwanted softwareAt line:356 char:1
>     + meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcre ...
>     + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.
>     At line:356 char:1
>     + meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcre ...
>     + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         + CategoryInfo          : ResourceUnavailable: (:) [], ApplicationFailedException
>         + FullyQualifiedErrorId : NativeCommandFailed
>
> The detected issue is more likely than not completely bogus, but it
> breaks the jobs.
>
> Fix the issue by disabling realtime monitoring. Besides unbreaking CI,
> it also improves our build times a bit:
>
>   - Building Git goes from 26 to 22 minutes.
>
>   - Executing tests goes from ~1h for one slice of tests to ~30 minutes.

Interesting observation.  I didn't realize that we are shipping
virus or potentially unwanted software.

Does the same issue exist on other forges (like GitHub Actions), I
wonder?

