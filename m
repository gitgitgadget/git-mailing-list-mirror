Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BCB1DED5C
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397434; cv=none; b=Uv6GQiFaqpp3N1VeYfHdASqffqZmRepYL9j5O6wCCRB1rilgIXeF5ghnlSQ62J/jp6gL7xR2mpANvvEfiSkFH7ZRzYtBOEVoE3ePE4ttThI15LVK1rdDJNr80m3vmk308fNN7icOH6dJt3jIji29a6k9uihczDZ7KQxjwl3dOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397434; c=relaxed/simple;
	bh=obglxt9Z/hOgmmtXnBhnPjq+KiUvWK1dktk32shWJEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrcR2uMtEGpxPTyeV0MDLmo0o3LyHpmyRz9KUuWTaf1aFMaeFOoGnkbLU6GHXh9kPuzCqFPLPv1fDwp6ljHZrI7mjqXaZouRq0ApZ3t2neKpJ7buFUht9wAhTWAVuZhVlw31YLbjm+xePwG/6FJ+EZoKmVZ17mFo6MexO8huVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z96CrW3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLTAlgHB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z96CrW3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLTAlgHB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 826D213802F6;
	Tue,  8 Oct 2024 10:23:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 08 Oct 2024 10:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728397431; x=1728483831; bh=S5/Bdx4KAD
	QiAozUtlMFn5h0qBXjLLhKMgWvEFN+HC0=; b=Z96CrW3Yiw0TIsGQ15d9EMmI1j
	eXvtq1Fy8ui9JlhmlRFLm/dPKnsvXCrWP8d0jO/tXlLm+X3U2q6hoCtzZt6m61JC
	vBlmIro6f/W+mH5MG0zlRHP1Weuj6edLHISw/MvVRcZPOKGPpKwwrjKtKiqCFWEU
	4sxVpJX1XBwYcc5lZZik2Uts9faFgtM0n5VIGkYLVOdejjbeaYgyKSfohjSQUImL
	2v9ZdMp6T3yZsrSqAF24dIJ1Cs07zgY08OGBwEvpJ0LcVTS2NDbBQZX1qSw9oXKO
	75Mw6+OQcXXSGBdmp907hiVudW0iVFZvt9XyeLa+Ojuf5scwwAC70UOWvGKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728397431; x=1728483831; bh=S5/Bdx4KADQiAozUtlMFn5h0qBXj
	LLhKMgWvEFN+HC0=; b=OLTAlgHB04kEtT7/Jc8BG7wMGAzCHpo7ZpDMJ+f5Sy9e
	71H7fSPZ1IVcViyxwL/1bFtTCFa2vvvFHkwcENeGRwz4MUXyMOz8hk4TuCRhMpVH
	6VPPh+xCtvRYRigATQYksCa8w1tpgoYSBrBZwhax4dbADb2nzuYq9MAkdKId+szT
	nvPdTHA0U0CbU8N6jEOjmqCFAVnOl1/HWoczX8OavaBsHAxDNsehfuxStErLtsK5
	wQusV2gyLM2LG2DZ306iZUSpKx7bkR0HrLiA+xx+DUbvV4HlDLiJZRw06Isdy7Sa
	1qenHF64CS2+vrzEtcoexYlGe/NPpOR4IXZuPpYvdQ==
X-ME-Sender: <xms:d0AFZ_aPZBA9Q3_zaroZUeUeYUyLerf7Y9-I31ANr5fNtuOJJC7HPw>
    <xme:d0AFZ-Zr5qab6iydqgwUgnu0KKmiiO2mSDPEz5qgTcVJwLixmKy2j9h-rh0t7HJSd
    j_oO9YWRTWZFSf3Bw>
X-ME-Received: <xmr:d0AFZx_tdPgHhjo_J99OD2ZtgASHntIdNjvF4A-DATBDwoNfDufGfXd5svOV6A7py13x_rT315OKx8xQWSfgtLLbkK7P8Z9V5kJjWyuPXnPWQs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:d0AFZ1o8Spa5WszDIc0vVxn7lLJeBj6Xn0SeS-Q-90w9EFtxojns-Q>
    <xmx:d0AFZ6pSEJtkxlI9_LlXODgAvQOBQoKeGYeyabr2ir9b_xkV4z4Ztw>
    <xmx:d0AFZ7SK1tHPiF4WMTnfuInxAS0iWUH40qTIHHuCBjLM6rGa49nIQg>
    <xmx:d0AFZypYhIFht4H3ptBLdM9TeEzV2uVldaF5jzjfLoKLZF0Cw0Y6-A>
    <xmx:d0AFZ9USegoZmDtiHDnP4MqPld4LGnEHJVC9GNGzeFJBH_TEkPp9J2KV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:23:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23e9ec64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 14:22:49 +0000 (UTC)
Date: Tue, 8 Oct 2024 16:23:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 00/21] Modernize the build system
Message-ID: <ZwVAcuPrt2vMftrH@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <76540dc2-a65b-4d8c-a577-4ff5c188c347@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76540dc2-a65b-4d8c-a577-4ff5c188c347@gmail.com>

On Tue, Oct 08, 2024 at 03:11:35PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 02/10/2024 16:15, Patrick Steinhardt wrote:
> > 
> >    - Patches 2 to 9 fix various different bugs I have found while working
> >      on many different platforms. They can likely go into the tree
> >      separately, and I'm happy to split these out into a separate patch
> >      series if we want to.
> 
> These all look like useful improvements in their own right, splitting them
> out would make sense to me.

For now I'll reorder them such that they are all up front. Like that it
should be easy enough to just merge the first X commits while keeping
the overall series together. The reviewers don't have to go through all
commits.

If that's creating problems though I'll split this out into a standalone
series.

> >    - Patches 10 to 20 refactor parts of our preexisting build systems and
> >      testing infrastructure to provide better support for out-of-tree
> >      builds. While we already have CMake build instructions in our tree,
> >      they do not currently have "proper" out-of-tree builds as they still
> >      end up writing data into the source directory. So while these
> >      patches are written with Meson in mind, they should also help CMake.
> >      As a result of these patches, Meson builds and test runs are fully
> >      self-contained.
> 
> Patches 14-16 and 18 look useful in their own right even if we don't adopt
> Meson. The others all look sensible in the context of supporting multiple
> build systems and might be worth doing anyway especially if they simplify
> the existing CMakeLists.txt.
> 
> I've skipped patches 1 and 21 for now, I'll have a look at those later in
> the week.

I'll also send an updated version soonish that includes support for
MSVC, likely tomorrow. So you may want to hold off reviewing them for
now.

Thanks for your review!

Patrick
