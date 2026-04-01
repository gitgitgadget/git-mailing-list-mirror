Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8B35BDA8
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045640; cv=none; b=Z2Z9sZzIxyXcvo6k4CewAIbVepSEG7BrefiNq5djoKMXupWz0VVbL12eSKpEIIvalwJQia8RIZSOTqjWH4nawDfziPCyrP54uxOz6Y/E6s3vLn5aLivbyytb7EkWdmxGuTVjKWioRW9CZfhcCLnjYrpne6SFAC2G6c0uk43ubjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045640; c=relaxed/simple;
	bh=9gcCi7A5EykUc1ZMqC1FmaXa8Nvbli9XbCXaeDwBX5I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+PNzg2RAQbg0UXZXmDldkz4VLLSkVAZ8ZpybIDSZBwvS9IhMjMGXb26zx4SLKPlfWTSHohSsI2ejj+VcDP1OcsKuOYzw96JN/pjxzcLWdnE8vHjDExjujEGWxgoj64QKyLpAscG2M0on3bKvbUS0UakVpz04s5ePF4u0pxyR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D2Axdo0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcAwwkT8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D2Axdo0m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcAwwkT8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B35D2EC00DB;
	Wed,  1 Apr 2026 08:13:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Apr 2026 08:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775045638;
	 x=1775132038; bh=m/SYcYxQYZ79vXYly+qVdgcdYFq+Xygo7SaSoj5tfno=; b=
	D2Axdo0mlUjnOl2Gc/lrnSoPz5zQX/WSpJcCp52CvlMixCH/gc1sWcWROHOLmhLH
	Cv33BrqcFeUnZPYdbfboDeBaSC9pkSvb1r/mFok/MWHLdjawJBv7+BW85hwdPyHT
	n8URcxDFy8ug2wt6zy19dtbe7gyLUFqQDMktTIDNxxaM2rKf5nnToXiZKOfJTFJ4
	mjptb4s7ijzkkl3pxnE9IR6oTzVXgbbl1sRPW4npyJQbJYmHPIo6YGZKIbMJ+nzU
	tkWpAKSThOLRF+DHf4bdNmW1KAfVrm356+dRl0dZfoIOSaotJLGsFbhaOkiA6DJg
	S4EEaQoUrlTPEMvlq9BUNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775045638; x=1775132038; bh=m
	/SYcYxQYZ79vXYly+qVdgcdYFq+Xygo7SaSoj5tfno=; b=PcAwwkT8NeTq++Lht
	nlqvELiYE2zp8KwjacACANLOueplB5xiRXOElYHA7Y0nqMwGhp6QjuVtteGMRSfg
	6ZooJZzlgPjYLOZmwvAySXCDF7znuZpoc1QneYiuhzMI7DvEbkmEBm8siitlKJfu
	yJYCerzai2ecjhy8/8402QViWSdHI53UrX8F8sNOdrZ2GA4OPQJnbey+0VoNq5j/
	5+fnEvAk5mRGk0TVEgpGSsL8GohaJSJeygEddsa+uTyAARv4xS/X/RgXzxpQii7x
	xFoOrYNmuav2cm0e93a6ZFxDBK2y4kHpKTljP7LYgaYeC1A6Gffb4ikcP89r6dS5
	ZosAA==
X-ME-Sender: <xms:BgzNaUVfM7EopE_VLhsAagtmI6bl_TA7cVVKAV8N4H6Qdgu0t9_VkQ>
    <xme:BgzNaektpxz11uQhheRmezLHbgF5iYayqcVfpgN84vs_UWj03vLmQ2eT-06sb18pa
    bT4aui-yfBib77bdRagqVRuQFdGsdhf6Wk7qlwNEiMw7umKVrIbaQ>
X-ME-Received: <xmr:BgzNaWDYgvvGcgSmBHl-4Ywg_dRDADje-VNaVz7Hz5kxjJNGlEQd0GZfysciDtfr4MnJBfwzdj8DmLydYDJdZomlLUFFSIgCRtmNEP8h8U8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtkeertddttd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeelheffgfegieeufeehieethfegveejvddvjedtue
    duvedvvddtkedtgfegjeffkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:BgzNaeepdoUjOOAqPA2XbCG1nS8aAo3ZNm3i5BGMSM6KTEMp9ApYSg>
    <xmx:BgzNaRJf5kzcWXxks7w7B3gmQfeYt4VoBYDMioWBb59k-5s4J6RNLA>
    <xmx:BgzNaReSsJXn6qRmSyATnBSm0dMC79wd4GuDXhpA3bnWeK4HQsiVsw>
    <xmx:BgzNaY2QN9ouOB8a8WgqPg0Z6cCV7avTjW8yZk4VjSKye3ARCgDOnA>
    <xmx:BgzNadCGxYTAHmiJ20jLmNKi6y02HRCe11-3jPxZgNT91rtbmvdbT2EE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 08:13:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f70aa83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 12:13:56 +0000 (UTC)
Date: Wed, 1 Apr 2026 14:13:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
Message-ID: <ac0MAbnB_vIArxv0@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
 <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
 <acxF0cwfVTbqn-XM@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acxF0cwfVTbqn-XM@fruit.crustytoothpaste.net>

On Tue, Mar 31, 2026 at 10:08:17PM +0000, brian m. carlson wrote:
> On 2026-03-31 at 11:26:47, Patrick Steinhardt wrote:
> > Not every compiler knows about the `inline` annotation for functions.
> > Consequently, Git knows to define `inline` as an empty macro in case
> > it's not available.
> 
> I thought `inline` was in C99, which would mean that it's been required
> in C for over 26 years old—it's older than some of my colleagues.  What
> compilers are people using in 2026 that don't know about `inline`?  Or
> more importantly, what platforms are people using in 2026 that lack a
> usable compiler with at least C99?

Surprisingly there are still projects out there that explicitly use C90,
and libgit2 is one of them. it prouds itself with still compiling on
Amiga OS. Whether it actually does may be a different question though.
I kind of doubt it.

Patrick
