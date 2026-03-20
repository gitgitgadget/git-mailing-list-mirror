Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BD3328E3
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992142; cv=none; b=SkzUWad9P90+yn/fkiNlHGUOZ2nELAvDuw2pTDHwyC6wOeVq6//1MKm4E3iXA7xarg8WB53VG5dc6eJhJpv7W/+YdTHMprSF52fZPGRxzOfFWrlgISAU0X/R8X8gn5+JQ76p69REglxMjYQ5/l+XNlKvZwlAPjiUVmLj/0Ms2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992142; c=relaxed/simple;
	bh=pV7ZKiaZGS6y26Ohn9kVNJIkXLoKHRAvdJA8avd6HnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+jNYRZo8TVieccaWPfvg4kpNOP889zDy1ZccmF6tjYgqjlEGy8YJtgNUyRTcvODD6dSL8fHaOlML0dCSXVLzIMCm+LamkwO+sGF1eDjFe+ZXLmG90aPXNozhILDKsRtrMRGqsr9P5Nj7yhs7YspVX2R22eyWjGzPBMQUqqoJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S4mnuhkc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEbc3644; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S4mnuhkc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEbc3644"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 81A25EC01AF;
	Fri, 20 Mar 2026 03:35:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 03:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773992140; x=1774078540; bh=baB1WsMpTc
	qCed4hbyI0B3I1aNswrfW5ETRjrCm6a/E=; b=S4mnuhkcnsRW6u1OUOKi4OnZbV
	AiF0PS5BwAuN8kR5L1vJvYjKzezpLATkUHwLNOulX+ut2jRakv2VMwaAkPkB3Muc
	CCdiGjeL8bu6N5MJzy7W16SCyWLO4vcPDZYVsyBDey3Z1cNlq3CaTALUiglEYh9U
	gb+8FPbhCEqu8f5ElY2KJsEO1mN6+8LkbHz8ULBFKPFFoXralQ4i/5mVjh+CC1TH
	L0aBm7Y3z9BAw1fBw+KFeCHFGXMh+7vJphLGO64OZa2L3cvUUQCIYHVCou6Ic7VA
	vn9j1XVgUpZU2s8HMS1oWWNEEgSQUzz8jcYzdslog92UzoKeKA59i56ZzOpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773992140; x=1774078540; bh=baB1WsMpTcqCed4hbyI0B3I1aNswrfW5ETR
	jrCm6a/E=; b=UEbc3644zCaV8xZMLwkBxt3IFpEh4eNiUDoTuVjKgzJjZ0R/Ons
	TwXztN9LeWHmG2t+thV/0r0TDMkzZqSDqbOuf8jhZN3+cvvxW8OghCrnS7meSkCg
	wvDk82ZjWuMzVQLhpT6lr/zAJKNFTtHxudADbKzbCMJna4gEW94E4lUJT12l1eWF
	iXu5M3HfjhnL/A3qdrsoc5PbNJ2G653Zn0FNWrDOLHh7Ri1ktQj0UDfHBRJ1uVbv
	nmFYhmL7Mh8pVqrXx+neM1/yr+uY091FRDDbCb2KV0muRCR6wAQCMm0suTDXLtyA
	2Xb3XpE9+ISqh2M1DxPf7EaukInm+mrw1Ww==
X-ME-Sender: <xms:zPi8aSyRuFnm1PSQvXEvTXVPZiGUkKEWi0njQSNnUaDkuMO4KZHz_w>
    <xme:zPi8aVQYwmWif2EGTY5_GrZmNLdsM4g7eq9PoeNSIc6lCL6CxHFq0lyT7y7F93mf7
    ImvMEVODpo5HjDFqrve0evoWEiz_WMZjNvMDP164GA7qmOjIlLtfw>
X-ME-Received: <xmr:zPi8aZXh2WhG_ypzVme3tfaBCFyR8jdvc_NFuZL2jANBwqzLf-IiNf8qfGzDPW5rEkeFPVrUWOWyUixRj0YapBWwcAYGat5ScxOhaYsQHerg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zPi8aXb47GnBcy8OB7R9STk_JIMeCqVAWDgd6empvPDEllci8mn8Yw>
    <xmx:zPi8af0DKQ9NQL1jXEUY2wquRQCPc-DFmZQJ7FF9PlHBvxA5q7t7MQ>
    <xmx:zPi8aZhO3q89-EW3yrPdxV4DVOmNdBCve1W2BCi6SP_ZlQgW3i05sw>
    <xmx:zPi8aTYaT2he5w-bzL-oxBU3-8RS37ft5vQnUGqaGETwXVcsUZHP8w>
    <xmx:zPi8aQ30Wbn2u5bbCbvo4iWkuqk04fIOhzg669zSmFVxKp_JsXzZn5Bc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:35:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23ac6bf9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:35:37 +0000 (UTC)
Date: Fri, 20 Mar 2026 08:35:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/5] backfill: accept revision arguments
Message-ID: <abz4xiIxx4crr6al@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <abvH29wYAFzk6V0F@pks.im>
 <29ec9e5f-ad14-4a87-92f9-a3ffa4077f69@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ec9e5f-ad14-4a87-92f9-a3ffa4077f69@gmail.com>

On Thu, Mar 19, 2026 at 08:59:01AM -0400, Derrick Stolee wrote:
> On 3/19/2026 5:54 AM, Patrick Steinhardt wrote:
> > I think especially blaming is a bit of a sore spot -- downloading blobs
> > one by one simply doesn't cut it there. I wonder whether we can easily
> > use the backfill mechanism to fetch blobs automatically in git-blame(1)
> > so that the user doesn't need to know about git-backfill(1) at all?
> 
> I've thought about this a bit, and I'm not sure that we want to run
> 'git backfill' directly. Instead, it would be nice if we did a "staged"
> algorithm for 'git blame':
> 
> 1. Walk commits according to the pathspec to collect the commits that
>    changed the path.
> 
> 2. Collect the list of blob OIDs that will be needed for computing diffs
>    for the line-tracking algorithm.
> 
> 3. In batches, download groups of missing blobs and then process them
>    for line-tracking diffs. (Stop if all lines are blamed; continue to
>    next batch if more lines are needed.)
> 
> This would be a significant rewrite of the blame algorithm, though. I
> briefly considered this approach about a year ago and decided it would
> be easier to start with 'git backfill' and see whether that satisfies
> most needs.
> 
> The biggest reason to maybe avoid 'git backfill HEAD -- <path>' before
> _every_ blame operation is that this will add overhead on repeated
> calls that may be obnoxious in its own way. Maybe doing an opt-in
> 'git blame --backfill <path>' would make it easier for users to opt-in
> when they want to.

That's fair. I fully agree that just blindly doing this would be likely
be inefficient. Ideally, the batching logic would only kick in whenever
we see a missing object.

Anyway, this definitely doesn't have to be part of this series, I was
mostly wondering how hard it is to do.

Thanks!

Patrick
