Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1D3431F5
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383517; cv=none; b=I7+65Wn4Of9X/L3MxNi6BvV8NzH5w2+7a0wHC0bUOGapL0sPNxZ3PG/WZYKPNSnDy0odVLgHbpw0J+zWwyWhiWGS33/qlnNx6a5lyBxFj/Loxgl77lewAhgup8m9eWj5pTaPRbwdPy0NcPceqAjqNqdiJ3iqL4fTNuDN3JYQq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383517; c=relaxed/simple;
	bh=zVJx1CcV716u9krxgZvxTMmf8DZ8bQdVROxtrG1+wd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFO7z6YkUNwvpzhCenoRfDquFWFqE/nt87F7gEeDqXVUZ854tyDboSDdKMfcpvbo7d2d5r7wd0V54UaZ0UHqQKFevl+55GboXAoTD4E3pz9nrHo7VOXd4do0gaR+xQnDlmt7sWrgcCVKP4xMcm7qIP/t41lCLK2HiIf0pi0ijhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UslH5ota; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2YFIYVI2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UslH5ota";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2YFIYVI2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CEA51D00060;
	Fri, 13 Mar 2026 02:31:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 02:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773383513; x=1773469913; bh=547flZacMh
	Sk7S+WwYVus9F5LCWFMVOIhDvgytLCmfc=; b=UslH5otayedDV2WM0gfhXspcDq
	E76f5KsW2zSlQd3A++/C7pbUj5VkRKLFJy0o+OZSwrVtDaPKM/AhXHTS0hGDTM08
	6uvc3POG+Jx+v4VZu5arU1EwaTttzVmAY+x4wSOWKSBNWZ4waylvP8kNEBQxpJK+
	DOaucpFG1netCPVuQLKbLwR0IqDNQQ/QHcyugcC4/z2JGvCeuf5g8jN4Mx7uAK5D
	MghScoMptYGbbpAm8R8ET9f/c5m+DUfJlcG5RVgaNTDI+4Y063cBSr+ByvGCFAFa
	l1Vdq/jdo0riEdBXZmTiHRNZMBtEfu/XxQy4GhBJ4XdRpQQ0bSgi2VKj6RUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773383513; x=1773469913; bh=547flZacMhSk7S+WwYVus9F5LCWFMVOIhDv
	gytLCmfc=; b=2YFIYVI21R4/Yl49CfTGlhX7g0OJQWcYXX8TveZmIIGcfgVfAS4
	JiRWVZxgI1UFeNGb0pP5ObtzzuqobyDOQsyN8rCCJOVosd7jEjx5c2hxUqSs3Xmz
	LI4LWkXx6u7Tn1wy7KNiWHBsJfnrrEWPIZDKJNT287SylVeqLlxEn2ZKtfrtAn8J
	2sux1/DsDn52Z/fa13imWlZ3PwZD/A3YaTJ2YrUNoHOJmXTDU71ZMJ4/k56FagsR
	TOLKFse7l6unzTgNL8PG7WG1tNzRZyTg/hLK+7eswhjYPjoMa4HWcB9DWXyR+DJA
	04nJOEFW4sclKKoeudntAZZkCd4XSSNI9gQ==
X-ME-Sender: <xms:Wa-zab-_8pAkvirg96a5Ri0jhiyjCHxakMxZWQkGddV4SjFk3EJRbA>
    <xme:Wa-zabZ_Ji2Z4PaTfL5P3CvzJHX08QP6xojsFH4H6BM7XLo39IFGC5pt5aUPENa-w
    jHljHaQZLny-Kznv4Qm9GZZF1v5pPDqjG9RRCDwFDbmxjYFRg6KHg>
X-ME-Received: <xmr:Wa-zaS0_rahyUX_bxeA6meLWZlscGThb1rPZhaAccGwmH1ONRCejSrXgN3KgO5SiB0swX2rjRXibJQiuKO9pgB-2b0gFhCqz5HC71ZM3Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Wa-zaebD75-_gN9g_gw4lc6pHpw99csM2oWX0QK__cooetmDXZZ6mQ>
    <xmx:Wa-zaSLclPWk-iJFPCnEWb_bDoA4iO6yyXQPP0lz7lt8V2_GPdR85A>
    <xmx:Wa-zaVFlsEi23oJXCxQzr50CNASrrR0MvH7Co453fshXxuAdzKlpSg>
    <xmx:Wa-zaRtg1iABXUDm7CgsPgrrbUL_EBgxBoJQhmTPUY9Kc75IoqScGA>
    <xmx:Wa-zaZuLtGROds83I8vkuW1YJG5N34oPK2kgkRbXOxXY40SO9If1wqa2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:31:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e86b8b26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:31:50 +0000 (UTC)
Date: Fri, 13 Mar 2026 07:31:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v6 2/3] gpg-interface: allow sign_buffer() to use default
 signing key
Message-ID: <abOvUyHiMO9leA9O@pks.im>
References: <20260312192228.481134-1-jltobler@gmail.com>
 <20260313013938.2742124-1-jltobler@gmail.com>
 <20260313013938.2742124-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313013938.2742124-3-jltobler@gmail.com>

On Thu, Mar 12, 2026 at 08:39:37PM -0500, Justin Tobler wrote:
> The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
> logic to get the default configured signing key when a key is not
> provided and handles generating the commit signature accordingly. This
> signing operation is not really specific to commits as any arbitrary
> buffer can be signed. Also, in a subsequent commit, this same logic is
> reused by git-fast-import(1) when signing commits with invalid
> signatures.
> 
> Remove the `sign_commit_to_strbuf()` helper from "commit.c" and extend
> `sign_buffer()` in "gpg-interface.c" to support using the default key as
> a fallback when the `SIGN_BUFFER_USE_DEFAULT_KEY` flag is provided. Call
> sites are updated accordingly.

Thanks, this looks much nicer to me now.

Patrick
