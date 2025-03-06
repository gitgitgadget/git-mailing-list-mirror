Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A242080CD
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250871; cv=none; b=uvrFcq5X+NbiSruPj7MTmTawajYmUMJfM9kAycQjcouGsSSeVQYxq2AbaWcL6L0EDnDdI4XHWFXOOzfpotfr/KKt/lATd2ddv9xI7v6vWuWusGsHOIE8q4u/XhGkLdGw9WbHtCyhbmmNmU4xU5EgW2AQKJZxrrODnlta++r1jyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250871; c=relaxed/simple;
	bh=pWvUXFj96nEwK8Kf3342aopqeiwJVnrwIl/9sgS7XzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwmrryUt759BWqjJz73DPom7uFEh7ZearaYvsH5mjPUvsDItoLwOiUxwc9htNm6dTux2kCgdarsxd79vuJMIxuyRO2VBVUetteokoIlVW69xJxXi3ihThZ/i6CoFr0rLuqcE/A+xLNEDtmSnFs+2AFaN3JaiNo96KqGlw/dBMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=efzyAbTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2TC/Kh3P; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="efzyAbTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2TC/Kh3P"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3A562540130;
	Thu,  6 Mar 2025 03:47:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 03:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741250866; x=1741337266; bh=Q8YN3qy2kg
	fYNIcYLl6cDkLsNQHgYT1tO7j5AYAw15s=; b=efzyAbTAmsq/mhi4k0iz6oG8Dy
	lmh/9P2utWs4K343dZgK7vVSuUGCdO2aDLaHtR2f40S0VHVYN6BPU2X8aUOM2HHL
	3bmGxEkDAnPi70Pay+pcX0YucEwy8gsSO8N6P2eMoAlILAWQ9Ho4EAdG89yT4ubj
	tNKifJprffAajfaFyWd2vOJwR4vbFSS5Dz+b5rZyH5ekLpz/84qQic7NJcbQdIL1
	A4CGW87oKfpPbn/vAfrFiF0R2hI/VqBl2Kt1xyRZbaIYd3dUvGs7Ac+jO079bYuA
	J7T3DpRlT19qI/J7zUIgYcfGyL4ecaK/zvG+LdxZD8YMLxnZXhI4Qf39Jdbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741250866; x=1741337266; bh=Q8YN3qy2kgfYNIcYLl6cDkLsNQHgYT1tO7j
	5AYAw15s=; b=2TC/Kh3PRfgyUv5877FwBznn38oMonEH8YlaIPhXSy/MrGjMyxI
	lw+mxxfkrEWcocipKmnb+rgdXOxbXWJ45wXcPbUSC4U4rH1VKY4WGnNgvaUePNl4
	O0MqdX1rFaNgu9kHatmYQHp/U0PWEjnz3NSweGH+Tjy/V7uw1LY+uomEYgiVEs+v
	8M7DDBiqNNow7SPFAosSdPkRnZVDTSfHsp5u+/JpCw63TudCWGZGtmaA8FFbCyiA
	Jv3IbbPPma9VyieG+wGpgGe11qGOH3jTC4Rx0YWEuCvTIi8u1L2QCIid81Y4gWj4
	5sahabmtmBrsrTW8ncKvncRRQAKrOOeJdqQ==
X-ME-Sender: <xms:MmHJZ56Nwtur535SKeAhnwIgnQgvI2lNNYgMj0tfz2pUlI3lf2br9g>
    <xme:MmHJZ25csDanhgaEpcJ6r5FxebgzuHNVQuT6t9sJdVXMf0wU0bFoXBH5BQp1aaZJO
    _3N3u9Gw1hpd21RRQ>
X-ME-Received: <xmr:MmHJZweH6kzsQV6yQ75A-rE0RGmIisLg_U5sBqS2VyQzg8rcSocG0Fv8QrrI_yqYmD36MyhpIOtdeRPOJ6-VCQDapWcL7UF1uqLRRmmcHS-YTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhrrghkkeektdeisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:MmHJZyI0g0ZgC7GWCXeTr2Pt3SMEHqhQ86x3zwuaJByNB6YCfQTo-Q>
    <xmx:MmHJZ9KCT65OwK8L868qBKksVf9f3cEF7dEDpH1dvJrX39lOzqxn6w>
    <xmx:MmHJZ7z74d1RsN8gZ4byOBWFVdJbVZBprYBSvSBGriMLDHQ54Q8G9w>
    <xmx:MmHJZ5KoUA36WdSexoOPp6d2bkL9uhFhfjsu9fqPs5QDdTuqdlKvYg>
    <xmx:MmHJZ1-Whmi_yUk3pSjVXvstQjTjrzJpiYcCzlC5vLu6feohXBzN_3EK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 03:47:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 280c50d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 08:47:42 +0000 (UTC)
Date: Thu, 6 Mar 2025 09:47:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SURA <surak8806@gmail.com>
Subject: Re: [PATCH 2/2] refs.c: unify '--exclude' behavior between files and
 packed backends
Message-ID: <Z8lhKT2KuM3VJ7d-@pks.im>
References: <cover.1741223981.git.me@ttaylorr.com>
 <7e6a5e020bad14b782a8c85518289220579fae64.1741223981.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6a5e020bad14b782a8c85518289220579fae64.1741223981.git.me@ttaylorr.com>

On Wed, Mar 05, 2025 at 08:19:53PM -0500, Taylor Blau wrote:

Nit: I'd reword the commit subject to not only talk about "files" and
"packed" backends. Or maybe not mention the backend at all, as it is the
same bug for every backend that implements excludes. Something like
"refs: stop matching non-directory prefixes in exclude patterns", for
example.

[snip]
> But since the same problem exists in reftable, we can fix both at once
> by performing this pre-processing step one layer up in refs.c at the
> common entrypoint for the two, which is 'refs_ref_iterator_begin()'.
> 
> Since that solution is both the simplest and only requires modification
> in one spot, let's normalize exclude patterns so that they end with a
> trailing slash. This causes us to unify the behavior between all three
> backends.

Nice.

> There is some minor test fallout in the "overlapping excluded regions"
> test, which happens to use 'refs/ba' as an exclude pattern, and expects
> references under the "refs/heads/bar/*" and "refs/heads/baz/*"
> hierarchies to be excluded from the results.

Yup, I noticed that this test is asserting the broken behaviour.

> diff --git a/refs.c b/refs.c
> index 17d3840aff..2d9a1b51f4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1708,7 +1708,11 @@ struct ref_iterator *refs_ref_iterator_begin(
>  			if (!len)
>  				continue;
>  
> -			strvec_push(&normalized_exclude_patterns, pattern);
> +			if (pattern[len - 1] == '/')
> +				strvec_push(&normalized_exclude_patterns, pattern);
> +			else
> +				strvec_pushf(&normalized_exclude_patterns, "%s/",
> +					     pattern);
>  		}
>  
>  		exclude_patterns = normalized_exclude_patterns.v;

This looks exactly as expected.

> diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
> index fd58260a24..d955cf9541 100755
> --- a/t/t1419-exclude-refs.sh
> +++ b/t/t1419-exclude-refs.sh
> @@ -101,7 +101,7 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
>  
>  test_expect_success 'overlapping excluded regions' '
>  	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
> -	for_each_ref refs/heads/foo refs/heads/quux >expect &&
> +	for_each_ref refs/heads/bar refs/heads/foo refs/heads/quux >expect &&
>  
>  	test_cmp expect actual &&
>  	assert_jumps 1 perf

I was wondering whether this still tests the right thing. But the ranges
still are overlapping, as "refs/heads" and "refs/heads/baz" are. So
judging by the test description it seems to still do what's advertised.

Patrick
