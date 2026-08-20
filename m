Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385546D0BD
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241593; cv=none; b=iHcZLhGm2goPRZSvDupwK6T3LctFF0MivwFGJD3f9ojeCOhChUEXQcukmAuzXoU0Ez6JQVuZzB7cTk4IqumQUQzVmTk8VjH/ekVul9TIlPQpA3ZLcH3/JJ6VsoQNLzyBqLtgb6S9VOZ5WOqz3fsZdbJd1OCHe7kVK7KDerBI5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241593; c=relaxed/simple;
	bh=JjVwS4xNaEoMJzWa9h+S8CUjtI9Uc6Qi82Ah46r8dz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iOwGW9LTxPyL1+jj5SCwNopIvisXNhhyGdW0xmxKrg6mQt4JawYj8wtrkMzDz00SXg1PyJxMPtIsOZ2ToUYvEA+Njw0xFfvF57xo+TiJCRSshxcTLfuyaOe7FKmC0hOntvDPd9YbZIw0HbxWN71/eXXj4iB1suDXTT+M8+OXvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m3gq8nAj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BetK6ax2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m3gq8nAj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BetK6ax2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E92BF7A0122;
	Thu, 20 Aug 2026 11:59:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787241587; x=1787327987; bh=o8VzqIZ5og
	a30Bv3nIdF3lh5My7gK0k+fdukHC0tYeo=; b=m3gq8nAjWswGyGA5I5nBm75470
	X77FXATe1UaezxRqf2Vt6MWR0s5DLGhE9WugtOSZGBBXgnvfFMx8cHMsy6i825x3
	jf+DDUVRdg0xmd0DUrR5Ulox+GG5+C9N/uDjMixiE7DbiEo6HB4D62kO64+lSPxD
	5wScaT/K++I4O7K4A0LATCJZBhKHRxaQw06cMcHBzr/cJrFRa3DRlDGAKI5ZGgi4
	LEIdM7POe1qO1IxLuhkRSsp2sCfZmSnmztoPTTR3TFM87IX6SWb/R0xaj8g3wuvP
	TxmpLqzdPzB65gui3ziVfgU5Uz8a3E5TkDmoP4A1ulHJiU0SIpBFW8E9yQmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787241587; x=1787327987; bh=o8VzqIZ5oga30Bv3nIdF3lh5My7gK0k+fdu
	kHC0tYeo=; b=BetK6ax2WAl6JLoniiXhL/kSZBdR2yNsg5VAlasHFuk7nu9PbQY
	0FlpKgX1euhsqhZOQq2yl9vb+mtnJFIzs0DLzkLJd9m1vTqK2s52cpZAgPi2MBNn
	2wnqfldAOcl8vkD3F0SOCW5gM05vUf/86wqaeEoTYXkaPH4Qi2BSBR8A4dH2FUk9
	inUq7p8FjGmj+RXIC0SwQzqfzlsnh5Z9a64lFx5Pv77MucOfjMwjlsmqF/PG/1u0
	IuzGj0wvEvNcPvg2I9AG3B3MGAY1noI0Xj5W3tHMGVIoTkJqWGRAem5wgZvhLMk0
	u9MET5lZNxcf4C8eF65ej/B/Cz8AZHewlgw==
X-ME-Sender: <xms:cySHaubFYldS-hChyPflkApcKEnf5RJOjpLKX0QGTCKoV7yz9lTINg>
    <xme:cySHaoTND_I114h7eE3PbbFw9NBkGefE_rzhH18yvJ4PyCQTrGyX2W1iOj25SSBMz
    gxOWIYFMf2SS-Odh1n7oqa5InMBjbMM7lC8m4C0uu4rFHuRpy-Qaw>
X-ME-Received: <xmr:cySHahSsIdTNzCb2aUKqIDUdC0MiOhHeODszClewBbcUZD8OP0um6NzAKEOi7FKjEGHA7GMBjInWmXfKGIyZwVGnwNcd_5J3eA>
X-ME-Proxy-Cause: dmFkZTEVwIp1BrAuacfF4ZysxkmMBAX1d4JSojNNTsiLOjKDtuuy1UgFF6xoWoafNQL0tc
    bijZuibUxQtu7bTdkTpOEyrareHnqxIy11Pex7gaCJJ6JkK9AtoHO6Z2SJ5J7cfAUXNtFd
    CVIdCRH3H8PoaVgDKfrzltodEuceqaXQ8ix4+u+udk5HmoqrTo6eFHXxLVb+mIXo7pfV2l
    0//aMwnFpsCImhNytBA3RvRWIAT0NxtCSY3EdavnNnMEpImBsOBrJIhieu7Z7wo05ZimbD
    DujB/TLqTO00XIKKhvh//8dSM+tDJ8s+vwXgI2kcpCOGPwtiGpUsm61vQBZvvJm6l7NZPf
    185Ls4LucOpKZhB96u+LS9NFpFFcOaHTesMAkrYcTENXmfzR8p+FL1EmcXC4P3wuhJ4DGa
    +diMLuVPWcM9eonSaFXFOEKGrzCr/WUVRA2WCsv84RWH0X9RdcmeDr75hpT9FK5I1hxEMI
    dxkhVoWcs3rTQBmOuww+RH77yPmdwf/hOeDShmvD8aodqZGsGtSXNn1emA/GP5LmVT/wN6
    jW315EQaTbNVHSQcQ2j7E6GnzDRPIsK9N2qKItIWn/K96zEWBwCbomkm3sXRw59UKMEeE1
    slkKcgp8kijzis6ed+528XZ3nqEmz3BZOrAPsYlx756IWurfTOUu+6TqjN3w
X-ME-Proxy: <xmx:cySHasRmARMVT0LlDCKbHZepV2y2TOtGEa-RsPxcIOo7i0W07uJKJw>
    <xmx:cySHam6WskP-n87X0LRnt5QcOQ-mLb4f2JP-wgSv41JmGlAd2RLpGA>
    <xmx:cySHao06lVuJNrtGMYkQIJM5ofWxTeSOEU8fwuDiIqQAepzgS9NIlA>
    <xmx:cySHahDkWadOX-cuQlzp0lRQLP209C4YyeDSGOnHu9FwCs3FaIlgMg>
    <xmx:cySHakxy64Dcdcch-1TB4kv7svoUJ0G9eStQ4nw1vZJltalRTkTXeIM_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 11:59:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 2/5] odb: decouple source path comparisons from
 `the_repository`
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-2-1115a7e02467@pks.im>
	(Patrick Steinhardt's message of "Mon, 17 Aug 2026 13:09:22 +0200")
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
	<20260817-pks-odb-eagerly-prepare-alternates-v3-2-1115a7e02467@pks.im>
Date: Thu, 20 Aug 2026 08:59:46 -0700
Message-ID: <xmqqmrugsryl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When registering alternates we deduplicate object database sources by
> their path so that the same source won't be added twice. Ever since
> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> this duplicate check is backed by a map keyed by the source's path,
> using `fspathhash()` and `fspatheq()` as hash and equality functions,
> respectively.
>
> These functions are problematic in this context for two reasons:
>
>   - They implicitly depend on `the_repository` instead of the
>     repository that owns the object database.
>
>   - They derive case-sensitivity from `repo_ignore_case()`, which
>     returns a default value in case the repository's configuration has
>     not been parsed yet. Object database sources may be registered
>     before that is the case, so the answer may flip depending on when a
>     source gets registered.

As you later mention, we can always hash case-insensitively with
the downside of additional possibilities of hash collisions.  I
would not be too worried about the hash side, but the above makes
me wonder what should happen in the eq() function when a repository
uses object databases living on separate filesystems, some being
case-insensitive and others being case-sensitive.

In any case, I wonder if 'core.ignoreCase' should even be a part of
the repository configuration.  Do we need to support
configurations where some parts of the repository are backed by a
case-insensitive filesystem while others are not?  And if so,
how?  It almost feels as if each of these object database sources
needs to report "This is the path to my filesystem location, and
the path may have case-different aliases" and "My path is on a
case-sensitive filesystem so you do not have to worry about it
clashing", and we need to compare them accordingly.

> Overall it's quite debatable whether all of this complexity really is
> worth it, out of two reasons:
>
>   - We could linearly search through all sources to find duplicates. But
>     the mentioned commit cares about cases with thousands of alternates,
>     and a linear search would of course regress performance quite a bit.
>     This doesn't really feel like a reasonable case to care about, but I
>     don't feel comfortable regressing it anyway.

Linear or hashed, the issue of what the definition of eq() should be
remains.  Discarding the hash map does not help at all, I suspect.
Am I missing something?

>   - It's dubious whether we should handle "core.ignoreCase" in the first
>     place. The downside would be that we might add the same alternate
>     multiple times with different casing. But this is an edge case, and
>     it's not even fully fixed because we don't resolve symlinks or
>     mountpoints, either.

Do we know if these all come directly from the way the user spelled
these paths?

Unless there is a demon that randomly flips the character case in a
pathname once it is obtained from the user or readdir() before it
gets to this code path, an easy way out may be to tell users "don't
spell the pathnames inconsistently" or its equivalent, "do spell
them exactly the way readdir() would report on your system", with "if
you fail to do so, bad things will happen".  I suspect that the bad
thing in this particular case is merely that a search in the
alternates is made unnecessarily inefficient due to duplicates, so it
may be a reasonable alternative.

Alternatively, we can even say "your repository cannot span
filesystems with different case sensitivities"; I am sure there
would be some users affected by such a declaration, but I do not
know how much we should care.

> +/*
> + * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
> + * _may_ be the same. This requires quite a bit of boilerplate for dubious
> + * benefit:
> + *
> + *   - Duplicating alternates should really only lead to regressed performance.
> + *
> + *   - We don't properly resolve symlinks or mointpoints, so we may still end
> + *     up duplicating alternates.
> + *
> + *   - The value may be lying, in which case we might deduplicate alternates
> + *     that are in fact not mapping to the same directory.
> + *
> + * We should investigate whether we can remove this whole mechanism outright.
> + */
> +static int odb_source_paths_cmp(struct object_database *o,
> +				const char *a, const char *b)
> +{
> +	if (o->source_paths_icase < 0) {
> +		int icase = 0;
> +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);

I suspect accessing o->repo should be safe even in the
initialization sequence, simply because "o->repo = repo" is done as
the first thing in odb_new(), but do we know o->repo->initialized is
true in this code path?  Refraining from making that call and
assuming a case senstivie comparison may be necessary when o->repo
is not yet initialized.

> +		o->source_paths_icase = icase;
> +	}
> +
> +	return o->source_paths_icase ? strcasecmp(a, b) : strcmp(a, b);
> +}
