Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29970307AE9
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763236641; cv=none; b=qlQ0EGGcW1YJiN8XFrzExnM1zAfaXlIvo1Kw6OXth0FuXLkmxVFxiX9jR1OW+0Xq7IrrGhrvHBxowLgRb5vp31ZkRAaYMfV5XHyagn/PRDxYXSKS6WeCnXWlpWDrQ7sONoEkTAj3EZx1mTW+VgiTiTjG+Tyx4S26ADJJmeFmBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763236641; c=relaxed/simple;
	bh=h/x1CkxS66F5Z9dapoAeUqu4ML9Wblh5pwPUOhIOtk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eP6kR83aL2IuRA93LIaeiH2LqzLkMDcn76R70yf2dRxyzqeHXnC/TIK4Xp2MjNtlfcJyTpYYdQ3J9FWViaO6xCjW3uLn5GB6JocHdKy46BoyrjI9LK/5Go+juT7p1Ttm/ReWgHz/g+UhI3dqkrDtCgP2+PcKU7Rq1YQQRSDMgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BazfwMNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u2wA9Ufs; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BazfwMNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u2wA9Ufs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 129BB1D00155;
	Sat, 15 Nov 2025 14:57:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 15 Nov 2025 14:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763236638; x=1763323038; bh=uumH9/35Lg
	9DyROA200ZIjfAqRcnBosqB4Qd9zPlL7o=; b=BazfwMNStXEJAvkAnpqa2VAso2
	VEmKO45P1zXNvTYzuWEj0c/T4vfwyu2Wo5AYeBb4XvY5EDtC4EXw6s/ZefCqTBnn
	IW3SMjCL7eLa9NTjEerOIphpHXwQz4V8YFcFu2WU7yPRv9oTouk26W7UlZf3z1Ke
	dN5GxBzMu5tHoX9zHzZMQthQlqEFWQkTXEzN9C1XX/4gqBfoWL1qw461rIwioFPs
	87DGhD0RDgW96fEtpG9Ixg0wT3O6pTEE4IDy1sLNefsWF8reOlK+BraOkcK52vjb
	61fNeuOlLuwYTPLOMlaCX6sGLpdMz4INvuiZzhww5kLUh+3cOEb4mir/9IZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763236638; x=1763323038; bh=uumH9/35Lg9DyROA200ZIjfAqRcnBosqB4Q
	d9zPlL7o=; b=u2wA9UfsTrwWEKmRYrW/qaOx7GFRW0kc0SOlCXiPXIntlrOPKS/
	tojUGQyGDJqBx99lfmETd0mqNp0ZygALtq6zGW65JjudNo5TjhJahMh7IVPRDfmk
	5W5hiw/ETXKKiaaLSwca2Zc8Qo4UJt7AtJ7rymXPjgoEyMeB4nHKab4a6OX0M/53
	aCyNuHMR5pK0Dr2xjsocoJUXnqQxQdDvpmN0eqxbywlsf/Tjm5ZiccSS38WEHA9p
	628B79GZwaGlDHqPTz/2F1g2fAgMm13ivWpzdYD09cgtRAWdduuuVN8S4KI3bpv9
	p8VTWS3kvCEJRYLRateoORPee9rAn0c+MYQ==
X-ME-Sender: <xms:HtsYaZ0DW1v0fzwY5PVUgULt2nR6b3DkO_fa6REkh6X5DheDHggbLQ>
    <xme:HtsYaTzZLB3R2_ds7vn46ebva6sBpOeDSrRW3n-5KiezhpJl9M7SeQmcz_xJB6Zzj
    -3A2JbUxK-dGuMigSoAuVaURl96UdglF8rAPfiDYPaYUQJrjwBG>
X-ME-Received: <xmr:HtsYaTvBV0s4Qjf9mxY69D6CP60DDKDJIkvWtMatOSOanP0NHJZo3GzKD_-Yrb6LdILO48IiaYVgI3B8AJsovhKI4mTIjjJB8f0X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhifihhltghkse
    hsuhhsvgdrtghomhdprhgtphhtthhopegrughrihgrnhesshhushgvrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HtsYady3SRwKcAPO_gFpjuMIZC_QkkaZZaCmCi2Ey_zVfORJH-LWuA>
    <xmx:HtsYaeC_2POQ86Ux5SzF-V2rX-FDOh-o7ab0DBPvHcXmvMkFHie1Sg>
    <xmx:HtsYaTcRXUESIp-DJp-pxpb4-ZVUWuyokLRTGLYZ1HrM2uTvISdpEQ>
    <xmx:HtsYaQk11BD7Md_zoXMyR43isOQkHvkCadI2cwbDe6IBcIebORUp9A>
    <xmx:HtsYaQQ-cI_nMu6jq2Oh4EwmaDFBsIbnv4BbSUM_II4aaXkKpmYsb8oo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 14:57:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>,  Martin Wilck
 <mwilck@suse.com>,  Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH v2 2/2] read-cache: drop submodule check from
 add_to_cache()
In-Reply-To: <20251115005818.2271557-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 15 Nov 2025 00:58:18 +0000")
References: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
	<20251115005818.2271557-1-sandals@crustytoothpaste.net>
	<20251115005818.2271557-2-sandals@crustytoothpaste.net>
Date: Sat, 15 Nov 2025 11:57:17 -0800
Message-ID: <xmqqseefdq76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: Jeff King <peff@peff.net>
>
> In add_to_cache(), we treat any directories as submodules, and complain
> if we can't resolve their HEAD. This call to resolve_gitlink_ref() was
> added by f937bc2f86 (add: error appropriately on repository with no
> commits, 2019-04-09), with the goal of improving the error message for
> empty repositories.
>
> But we already resolve the submodule HEAD in index_path(), which is
> where we find the actual oid we're going to use. Resolving it again here
> introduces some downsides:
>
>   1. It's more work, since we have to open up the submodule repository's
>      files twice.
>
>   2. There are call paths that get to index_path() without going through
>      add_to_cache(). For instance, we'd want a similar informative
>      message if "git diff empty" finds that it can't resolve the
>      submodule's HEAD. (In theory we can also get there through
>      update-index, but AFAICT it refuses to consider directories as
>      submodules at all, and just complains about them).
>
>   3. The resolution in index_path() catches more errors that we don't
>      handle here. In particular, it will validate that the object format
>      for the submodule matches that of the superproject. This isn't a
>      bug, since our call in add_to_cache() throws away the oid it gets
>      without looking at it. But it certainly caused confusion for me
>      when looking at where the object-format check should go.
>
> So instead of resolving the submodule HEAD in add_to_cache(), let's just
> teach the call in index_path() to actually produce an error message
> (which it already does for other cases). That's probably what f937bc2f86
> should have done in the first place, and it gives us a single point of
> resolution when adding a submodule to the index.
>
> The resulting output is slightly more verbose, as we propagate the error
> up the call stack, but I think that's OK (and again, matches many other
> errors we get when indexing fails).
>
> I've left the text of the error message as-is, though it is perhaps
> overly specific.  There are many reasons that resolving the submodule
> HEAD might fail, though outside of corruption or system errors it is
> probably most likely that the submodule HEAD is simply on an unborn
> branch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

A tangent.

You can (!) place your own sign-off after Peff's, as you would want
to certify

c. The contribution was provided directly to me by some other
   person who certified (a), (b) or (c) and I have not modified
   it.

of the DCO, but it seems that it is optional (which I did not know
about---the explanation in SubmittingPatches stops at "Indeed you
are encouraged to do so" without making it a requirement).
