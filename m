Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3433932F0
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187864; cv=none; b=cvdamVyWfhNwlq+TFV8wSuW6F/0WahTB9ysHDFoqhJMfr3tVLXRWLTRh+cfdl7eOZdYBaL8PL3VXYI652hFVLAqP/+aMSzOAHet96JoJ4U7iEBg4aAZndB4DetqhH/B5dxhb2QrRri4dC1Zgj7/QZ43qcLjiR5LWVpMr4cdAvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187864; c=relaxed/simple;
	bh=3whTvkR538Y+mT6bafm+sHjLA+u8mRKyolMd+tMq0dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSjQLmQL3Bhfw9ZuGZZrB6PerlM1fkUS6kMmrWQ+ahsy/8IR7uuOxoh0nv3aEY+nt8m6Rx92zTMvRA/jwnw75v6Hzs7fJ/z1MsGk9vb1kFuBvdEE+pJ9a5fUcV+4TtlQVO7OuwtotGRAbXjZRyIuL1FIc02T5rcduVUikD+gJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oy7bMhQt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6Bq3XSD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oy7bMhQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6Bq3XSD"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D8DC01D00199;
	Mon, 31 Aug 2026 10:51:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 10:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788187861; x=1788274261; bh=qM+n4GiZDH
	ilJngLOASAgfMS42UdEoMV55CSSmgNjD4=; b=oy7bMhQtL9UoS2D6j99qQssbO3
	s7NUh+VWUC0caXPV0a63Xu2PapY0XZa4FTfBIWLCzXFpJHmJxsRwaxQ4R6pA23E8
	fC0s909iRVPZXt1NEjC3ftFOaALPsj7BD7GUdaJ9UDYe9fqykEouBH5l6B8B28PB
	1t/esqfCWJjFUS9Aj7ODWGTnuiONGB3EVsP2LYG0a/PoLRKCSsXqCI3gxMQWx+ZQ
	zVHiEj/RE194cccLuFKicocY6oIIolcPm8yCnW7kpLMlbi8tXgERnxWnxJngm+cV
	SpfSOYpd+uUPuAhUgZoI/omeS7Ot316BSmQYikH56BAx7CNVPNY/Pn10rEFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788187861; x=1788274261; bh=qM+n4GiZDHilJngLOASAgfMS42UdEoMV55C
	SSmgNjD4=; b=Y6Bq3XSDRNdy1nBF7xivmAQJERXzYoJfOICwOpMk/kAQf3Sej8R
	ZN/n0aZETDQfDJNw39qV7W1Pf+g+m5ZMAwXWy70LlGWLFGeoV+5qxHSbH3FZknhg
	Y8Cz4ivYFEts1chfyX2knYOkXROPMGO0ZottWgBctwWsG4pkcnIg+Fkz3DrgpmrC
	32ZpJHDmg5nm4ZdHiyaqbHtu74CjhTwUaQJdzJGN3T7OSgaAILR+fvfN7UYyCXx5
	i/4N6vXrnRsSIc4oSr4Y38Yv1UXnd/oJrXseLd13h0ZgizrP2DvohYy8jEXdu1AZ
	bhHSo9uAx2MBcY05nuJMY0qxc4ujkE/jTwQ==
X-ME-Sender: <xms:1ZSVagHG8lXlZ1bEP4OKpPe2dYGXH3rxD3WsyJHwQ68EmTUglqEgeQ>
    <xme:1ZSVagMbXDjrprZlG3zY53cvj8xY8Zs8eg6NXmepGxbZEMtg2K3O07TKvd_eq1mbK
    UIN4gvRUptKVndU6B86dzUzlcCZQW9ZN1AypzWvSUpos_2mbvTx7mM>
X-ME-Received: <xmr:1ZSVaifFUuMy-41spzRhUmvz7kNGMqY6Zt85d1zm_VkekrHGGtml4hrN7mC3JzialWV8SvA_Kcw8M27v2WqZonC8uKp8BdTqDw>
X-ME-Proxy-Cause: dmFkZTErQx9FaKpd4P3miIGnfHneEAtzC5HFjhD2T1rKu+TRVcjKyXitlSbT2WfcQ8KBWp
    zK8Mv3OoMCB4KKO5r6FCq95jpyV1aJQsXmMF3szzJopPzhedDnTKci1OU3e6bO8Uw+5Q2U
    XIeAGTrKLjcLZDWqta1sleXy51hrfmfM/IVVnX08EZZIXe7D2ey+GNPY2xHnK5o/tZk9VX
    rF++2sChs0Ibtbp8enfBGHaP/UxLF5+WxkjUG5b0dU3BbizT5R+2lVX5NynLX7p4xXe9Dg
    6HmAq8uvsqQ4EoYk4+U//VNoUcF9Cs1PNfgaqaszwMMtmY1eXXaI7em5MHFyFhGen1tpuE
    m6tNk4eL7/gZ4i2vSnCtE6Dq11pna0eJjnlz1cr+hvYiia3I7HeVeY0nCvT6KK6qvy312S
    A8uJ685WRCVs9KldqL/WfKkk5Orh/O8NmXfInSrLXdrwsdSaXf7On0x8q9WwPSlfNNDgwo
    zJT4GJ3cLNKLyfrRRsJTp2vBoHmDQDl8l69zHEWmUV3+HNCQLagEP4UuUtow/JRz42kqBk
    V6BeBZq1G1taavFniUa7za06sucvrzbsLYWT0OtuXsj7HgClzOgilrMYvn7BQVuhnW63WM
    HEs2P/bGzliQdNbCNV9gzo123p00kP1xZnkBi2tZ2jOGs34B9mJJ9XOz5v3A
X-ME-Proxy: <xmx:1ZSVatsl9D5iW1Vy4K4mIVl_fWQQe9BvbLXyjXgly1RZOpHg1HD1QQ>
    <xmx:1ZSVajmd8CwfDOSuqSxpcFjHpqfm6cDAco7c5e6A0ecr5K-_5TnyxA>
    <xmx:1ZSVavyAPLK4xt7M7N5dKw5mTYrD2fmzsIhwqbDZRNgh0tKeU4cyng>
    <xmx:1ZSValObLgYhfp5ox3LIeV9-AeTA1Lc-__dGGzvPNZ0k4TJGRRlk3g>
    <xmx:1ZSVas9HzwEM79NPaA989TMogn4RpemBiuP5dlVx_tOw7qIHKohe1GvZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 10:51:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 2/3] t/lib-httpd: make http-429 first-request check
 atomic
In-Reply-To: <apUqs8N3EnTFngyQ@pks.im> (Patrick Steinhardt's message of "Mon,
	31 Aug 2026 09:18:11 +0200")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
	<8ed22c02a192e10ab46c7df61e92a3669faaf25a.1786583137.git.gitgitgadget@gmail.com>
	<apUqs8N3EnTFngyQ@pks.im>
Date: Mon, 31 Aug 2026 07:50:59 -0700
Message-ID: <xmqq33vuz6lo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 13, 2026 at 01:05:35AM +0000, Michael Montalbo via GitGitGadget wrote:
>> From: Michael Montalbo <mmontalbo@gmail.com>
>> 
>> http-429.sh returns 429 to the first request for an endpoint and
>> forwards later ones to git-http-backend so the retry succeeds. It
>> remembers that it has already answered 429 by checking for a shared
>> state file with "test -f" and creating it with "touch".
>> 
>> That "check-and-set" is not atomic. Apache runs the CGI for several
>> requests at once, so two of them can pass the "test -f" before either
>> "touch"es the file, and both then answer as the first request. The
>> retry flow is mostly sequential, so this has not been observed to fail,
>> but the race is latent. Replace the check and the "touch" with a single
>> atomic "mkdir", which fails if the directory already exists, so exactly
>> one of the concurrent requests is rate-limited and the rest are
>> forwarded.
>> 
>> The "permanent" mode needs one extra step, for correctness rather than
>> tidiness. The marker means "429 already served, now forward", so it must
>> never be visible to a request that must itself return 429. Since
>> "permanent" returns 429 to every request, it must leave no marker. The
>> original did not manage this. It ran the "touch" unconditionally and
>> removed the file with "rm -f" in the "permanent" case, and that
>> "create-then-remove" has the same racy window: a concurrent "permanent"
>> request can see the marker before the "rm -f" and be wrongly forwarded.
>> Skipping the "mkdir" entirely for "permanent" (the "!= permanent" guard)
>> leaves no marker at all, so every "permanent" request rate-limits.
>> 
>> There is no regression test. The check and the set are adjacent commands
>> with nothing in between to synchronize on, so the overlap cannot be
>> forced deterministically, only reproduced by chance; the fix is
>> preventive.
>
> A lot of AI-fluff in this message that could have otherwise been much
> briefer, but okay.

I too find it disturbing it that the messages from this author tends
to contain material that triggers "it may not be wrong, but is it
relevant?" reactions.  More does not mean better.

The above made me curious enough to ask a near-by Gemini to distill
it down to quarter of the original length without losing essense of
the original.

    http-429.sh marks that a 429 response was served by creating a
    state file with "test -f" and "touch".  This check-and-set
    sequence is not atomic and can race under concurrent Apache
    requests, causing multiple requests to claim first-arrival
    status.

    Replace the check and "touch" with an atomic "mkdir", which
    fails if the directory already exists.  In "permanent" mode,
    skip the "mkdir" entirely so no state marker is ever created.

    Omit a regression test, as this concurrency window cannot be
    forced deterministically without artificial synchronization
    points.

This seems readable enough to me, but may still need some manual
clean-up, but this experiment told me that "A lot of AI-fluff" is
not something users cannot avoid without some extra work.

Thanks.

