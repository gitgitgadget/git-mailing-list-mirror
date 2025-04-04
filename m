Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F51A2630
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758354; cv=none; b=BAsaSB6zDuTwDLrf/EkwBGit7VNurNrcoDY/L8pqjaZTMXduVFdd6bAke++uq9Z22DG3K0uwAIxEedzAwKk+VJRC5DOdJEOnoagsXs+KVUVuqgagg1YILKNPBNkm/cmlRJGONPXVg/Ktt4jXzKq7/VOdLYTrd19ra6EGiny9xaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758354; c=relaxed/simple;
	bh=DuJ7Is+9w0vOqnNhioRjcqK4gIkiJQDo1YTEtZBgTTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUg2npsAHYEwko6VbloP3ogrHBIap/vwuN4lN/l/79G5zdlYQBw/8xyk0UWsewjAcLlQ1TRKAIvxMo1J6ZnGJz0zBZhtZ277C/HzOKf3wsU8YfR6G3fa2VP6yRDHl1M+j0WiUBxUSSR854Lw8dWu7CZ9HO3lnh0SnwLYhOLQ4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IYVat9ur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMwt/j/S; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IYVat9ur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMwt/j/S"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D08B2540178;
	Fri,  4 Apr 2025 05:19:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 04 Apr 2025 05:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743758349; x=1743844749; bh=nKZUNbVK0+
	hOvYaCECqnYNLlfpHKx+OFti+DLy/XYMA=; b=IYVat9urb5JZFM6jP75Rvqx7gT
	TUV/aCA86dZsthdlsSsudaNz0kv3Chc8WHDkJgbue9wiaKXOz9hnVLhj0IeTTFgx
	Z88SvB/2TAnL1PXh8FmqLxloBJZWnJ7ehEjHQQ0+P33l6Yj/+S4z3Fu2/0YjmOIK
	S6KPtV2OPX7iL8yyfT8nP09ctzeVTjRF/2rYxZzxvTaGeM6KSJxH9n/G+ou3lNfw
	Ehd5iRH9d/lGfsgQmyby6M6J7pXd2TQ6pQSk3iitbB5iIItPAKZKwpS8YlUbpUDj
	i4R1VcUsig+2oHNEQ/J1McR9VExDv6VDhFAyoD7NLpzzrLye6rGqbK1cpK7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743758349; x=1743844749; bh=nKZUNbVK0+hOvYaCECqnYNLlfpHKx+OFti+
	DLy/XYMA=; b=iMwt/j/SbdTs+8RHup6FUdCpyVc41ER/yo75vAOqC7VnIs6NNAv
	LA/wTKEXfvRSf+/QLlsVXJuPx3lD+R9IW6ViBl7/q8XGcM7rgHebA9NamVGOo3Gg
	yYaHGVH5ou2fNChei3/laiSH+KSWnBHvV5QNa0s/b3idJFPeOdZFhmYiUwQTOGNa
	lDWm/XOI/LBi+kVQUWBOx4YqDQuxcTclvsSfGpdE3zuU6M6sjujyoR5Wkk4QjOlw
	rKZAKe1rkuw6/LITker0vDgXx00DgtKEyCeS9lpLUz7Ew5OUndPHENvixQnYbELr
	A2W8UC0H3A7XNPKx2A95EN0aixo5vKPe5uA==
X-ME-Sender: <xms:DaTvZwOaMvBv-T8Is1i5g2D3yZcrueXF-AJ65p59pXBJ-5MIAds5Kw>
    <xme:DaTvZ29hpJge5vz4KxKlGTiru3gRvL8Ic7bGKXpIUuDKHy5HrEfA7AbZkVo5kTlIE
    bTmWdgQ-o0hxXtBxw>
X-ME-Received: <xmr:DaTvZ3SOO7kXEuKO6CeUrO3JYZGIpvmAEWrO3gpkO1G0HuzrndBW53kkeeXOR8lHRntUneVv3UnpR8_K9jcck0jVepGCy14thM43Ojaz4MEl3Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledutdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DaTvZ4tLK5B5hDcWRYW6gMcSv5NTTKjHw13BVy8dNSpXXYWnDtecMQ>
    <xmx:DaTvZ4fQtbJcBDC3YzrmrKMoxxcLuq0c8gr9uEAyLSjf4PNvNw0HEQ>
    <xmx:DaTvZ82vHUAbw_u9kuplvr5RDq3T9uIV6gCfaINq9aHa3hWh2TBwlA>
    <xmx:DaTvZ8-ZL0LGIvaRSl0syxyyEeu45rN5gQoqJl-E9w4yoIleDShLPQ>
    <xmx:DaTvZ_4XByngBgATpKEA6LYkRVLA71Vwobf7NvJpnAmQvS-G9DSxiRiD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:19:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb640fbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:19:07 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:19:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PROPOSAL v1] =?utf-8?Q?Refactori?=
 =?utf-8?Q?ng_in_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <Z--kCrCnl3Zw4YG7@pks.im>
References: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>
 <Z-5b6INZXiXbEuU2@pks.im>
 <bcdeb3cf-33a1-4553-897d-0bc09dc6a78d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdeb3cf-33a1-4553-897d-0bc09dc6a78d@gmail.com>

On Thu, Apr 03, 2025 at 08:56:45PM +0530, Arnav Bhate wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Apr 02, 2025 at 11:44:12PM +0530, Arnav Bhate wrote:
> >> ### Timeline
> >>
> >> #### Pre-GSoC (Until May 8)
> >>
> >> - Explore the codebase, identifying global variables and how they are
> >>   used.
> >>
> >> - Start to identify suitable locations for global variables.
> >>
> >> #### Community Bonding Period (May 8 - June 1)
> >>
> >> - Interact with mentor, discussing best ways to refactor various
> >>   variables and make a plan based on that.
> >>
> >> - If time is left, start coding early, as my summer break will have
> >>   started.
> >>
> >> #### Coding Period (June 2 - August 25)
> >>
> >> - Modify functions to add an `struct repository` argument where they
> >>   depend on `the_repository` and replace all occurences of it.
> >>
> >> - Move global variables to their new locations in various structs,
> >>   and refactor functions that depend on them to use their new locations.
> > 
> > In large-scale projects like these it typically makes sense to work in
> > batches. Instead of having three separate phases to "define the
> > problem", "develop the solution" and "deploy the improvement" I would
> > strongly encourage you to define and tie together smaller batches of
> > work.
> 
> What I meant is, before coding started, I want to finalise all the new
> locations for the global variables with my mentor, then I would actually
> modify the code in batches, struct-by-struct. Are you suggesting that
> the new locations not be finalised beforehand, or are we misinterpreting
> each other?

The problem I see is that you only have one large "Coding Period". What
we would like to see though is that you define smaller, self-contained
batches of work that you can try to land individually, as well as an
estimation around how long each of these batches will take you to both
developend and land in Git itself.

Patrick
