Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7751B175
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702777; cv=none; b=hsBVQT9c57TbNLxmjZTGG/f8K8DzZfqGM678zekrBM/L5/aIIXyNB+uwfIFqgZigCKSJ6jBTS+g5Gu1eC1mTRFMgRTHwWsplF6VSLyFeuhYiuK01eHqN8KYroa3DWTbLnfdvkiLE8lBzCb25t4tQ5tb+4akjHJCsKfrEcKrCqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702777; c=relaxed/simple;
	bh=eV+EOs4aac8Do58mY1nSCxXKheYfeqLibR7bJMTF+X8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIqjPd1lTke4GRCXdl04fi/QGaxsKQgOf7iVmcN+VKInk6+JDq6Aj09c8myk851+r+wT8L9KaEUJUO+s+DCNLQhKChjKCB6Kl5yCS+2OAvDdVb5f7yKqfPy3cLTlMi3EVOmkOaFMsbv5Ki3pa8T4/8FWLCStNPn+tUfizqFViwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nt03o01F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w/dC8TiJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nt03o01F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/dC8TiJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04F6A7A0612;
	Tue, 29 Sep 2026 13:26:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 29 Sep 2026 13:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790702774; x=1790789174; bh=z3ca7JpaSP
	mg3YQqOOdzeNmdmU1YEZP9i2zjL3xLFxc=; b=Nt03o01FvBT0VHN9EgYrZsTy0M
	WDtMXXQ+zWvoKJhT/LlAP/+/stfxCyzSG+hVVzH+kaC6xis+wKbZNFvBOu7hXMvb
	XJgrGw0QDI3hDW8RbV4IMqIOtnohRVIXLPOXJmqPfRf9tIognQrDeWeXi8l/68Np
	NggUwKZp5++gz6jU/zWb19505+2n+MXd6ToIBtbFpneNPJqHU3UCSkB+geEReyb3
	wUIn/hVzIVIochyY/Q/PkFTHU+/Jx97Sufhz1k9HfnWANWVtCtEJ+BHmSS5Luv4x
	AgJbjDApBYAuniQpV51t7ywovXHbzuuauI+/JTSLxs4nwh0oCNUAOO/p9/dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790702774; x=1790789174; bh=z3ca7JpaSPmg3YQqOOdzeNmdmU1YEZP9i2z
	jL3xLFxc=; b=w/dC8TiJ5PCnYPpU6dglLGZappVPtrQ2AarFezxob7aiJ5FcH0O
	CHG3Mz181KWEN/FGgtKV5MSal73JeyFAZZyHoYdR+uHv9EVqGxvojAw4Sw4n4qDv
	hXB9Ar79RaE9v5Ci1Hcz33xUw4VGS9Dp7i3RbBVzirqWM7sYHdU1z+0AVnWvfLR8
	nrV1tRpdB4rEKxIK9q1a3M2+j4hbs1IF+KMzr0rIOkZ9jjsiKrtu/Bqup1Ds6ZZ2
	0CZEYeK7a+hJYJxawn5zmiKdtt1rH+dFcMJAhdpuN7Fdzg6l7SFb8Vi0MIQKyqsr
	p7Gwvc8FyDdbB8cIj4A9MbitWxQWN6SDg4w==
X-ME-Sender: <xms:tvS7anXXfgbtjE9n9c57h1cxjzht9mOWe9hbWrjXWO0UKsc1JRRKQw>
    <xme:tvS7aurV2V28CdosGQnAeOXE-6Ot4wzdR4x3mH9dj40UVYyCEimdhKZmsaCOqx4pv
    2rCNS5HyRmW972rJ4cpk99wkRNJDBAB12XAWjJvhxLjMZsXLvP2-A>
X-ME-Received: <xmr:tvS7apkONV_HJO-cJbrrxMa3lBhe2skB1XgTSV60EUSaF6sf4AqEdJNtRNqoquR3LtwgllVmBd4aMnUrhKZWrktyD3BDO35-TvIp>
X-ME-Proxy-Cause: dmFkZTFGsTAXrYbU6CoecUL9aNAOvqVxHs7Y2FhclkmGFufEcJ0Lj+aMPNg19+HO7MLG6i
    CrxjCGQ+LWpR+zpeK5BXVi85iYp6XfhD6NOGwakR2usOJZc+6WGxVj+38pdnovWDVeN7j3
    bSkBhh6BP0NC4HYcXHsu3JnAtfk+cEpRMZOeBYv5e6y1fMom+wW+zuQbbpZKZ4v5hL1IJT
    TKzAA3hgyH/MY7hiZSgj7196J23uS8pCw9wU95PBfAx1nPjCpGhODA5eWDr4EIDowhbtrq
    eN0m4BsefnbIL1PV8NyRkEhK7/fvmad/kvrc56Jw6G1myDAlAEhT8jn63GT4H1OGYWQOmu
    Z/iJjsrA8cWEYnfIrRT2f94wG0+Crkca7dBwwGJ31CkQntRpTA67/doTmLFVa1s9ga2vU6
    dgd7MTrBtq3BckWT9KUzSLt/2c3B7okSUGO+xzb6QAHk621Rdj9GBdyuvMljzhnk247EGO
    l9fouMGoDJfPSDK1JJi79g/0T/j2kw8GKi+vjSNTWvrYXPfjV1rGvytRBqVFTJXuGNLKyI
    5Y3FkQ2xLyf5x8+/2Gi+2uZj13J4k0FchBTyr3EY2oEiOXmlJAcHEkMPRO7Ipx1H3/yBUv
    gwtdGM9diKycX5YfD6xtPUJe1VYMH9oZTjAR1hyd44+6tArVKWecAcXLCXDQ
X-ME-Proxy: <xmx:tvS7au3Kqcy6j3tmE0ZCK0nLFblO5Ds4tLyaYFNpvI0qEWiUGNG2TA>
    <xmx:tvS7amTjVnFiu_IwjgwDcvlKZed5XXwhy8CkZ5uKRsajZfXnWAlfsg>
    <xmx:tvS7anynMovbEBp0qVIVRv6BT_k1zsVcBj4Y_o4HPeDWRla1ZqkeyQ>
    <xmx:tvS7amAIHjgQdN6u0a6qvgraWPJbQ2YnV4rBInCCZZZwkXnJw3ZUpw>
    <xmx:tvS7aoZkrPc-H-rfykmRzXH-qamy0-hPl8gypRGCRZmAeu4zEI3cnshT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 13:26:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v4 2/5] setup: extract path_allowlist_apply()
In-Reply-To: <20260928133846.2094261-3-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 28 Sep 2026 15:38:43 +0200")
References: <20260908164129.560396-1-christian.couder@gmail.com>
	<20260928133846.2094261-1-christian.couder@gmail.com>
	<20260928133846.2094261-3-christian.couder@gmail.com>
Date: Tue, 29 Sep 2026 10:26:12 -0700
Message-ID: <xmqqy0ckgea3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +	/*
> +	 * A .gitconfig in $HOME may be shared across different
> +	 * machines and the config variable entries may or may not
> +	 * exist as paths on all of these machines.  In other words,
> +	 * it is not a warning worthy event when there is no such path
> +	 * on this machine---the entry may be useful elsewhere.
> +	 */

This might be a minor point (as not many people may be using the
safe.directory feature that this was moved from), and this dates
back two years, starting with dc0edbb01c (safe.directory: normalize
the configured path, 2024-07-30), but the above design decision cuts
both ways.  If you misspelled a pathname, you would never be told
about it.

I wonder if we want to allow users to explicitly mark that it is OK if
a path does not exist, in much the same way that a pathname-typed
configuration variable can be prefixed with :(optional) to tell the
system "if this path exists on the system, use it, but if not, instead
of warning, pretend that you did not see this specified".

That way, a user can first specify the value normally, and then when
they reuse the .gitconfig file somewhere else that does not have the
path, they see a warning message.  You would help them by giving a
hint, e.g.,

    Specified path foo/bar does not exist.  If you spelled the
    pathname correctly, and the path is allowed to be missing,
    mark it as optional, i.e., ":(optional)foo/bar".

or something along those lines in the warning message and the world
would be a much better place.

In any case, it is outside the scope of this series, beyond leaving
a NEEDSWORK comment here, and/or a #leftoverbits comment in the
review.
