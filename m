Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260631DC1A7
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028146; cv=none; b=HX2oYof3afosvHhQMTFZZvEZpwJKFJVM1Nwg6lLHUBseN0HdzDi3KbqnhXdG/FBvBo6Rs3G575oP8CWR2vGCjT2+turTWzPVsfwodj9EmCob0bl5gQvk/nEQ5Cp0VUquGijknKxzf/ZNx48C/aYGqwj7KwA9gkHJETVjvuBzsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028146; c=relaxed/simple;
	bh=4a3Cb289gB8xwkJrX44j+xp7QHifMZWz6c6E8lvx5i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6i1Kbj3rOLrnZND0lacqPIrT5GsPeMhV33pI1vHjnJGrFJrmw/rakFgh+PqZDj0341GBnL8UpHd0qBHm1MX0YSwUGd6B5bYNiAQSMpQmUEDkx0EatuzanXU+B2H5nTLg1C0RqVOB4oNG4D36GsDvxpC84KFsWc5QaI7jSs+INs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k8dn2V7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3gXHF1Q; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k8dn2V7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3gXHF1Q"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D8EE2540146;
	Thu, 16 Jan 2025 06:49:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 06:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737028143; x=1737114543; bh=4a3Cb289gB
	8xwkJrX44j+xp7QHifMZWz6c6E8lvx5i0=; b=k8dn2V7dCrsoLcXoR0RpyVaAFS
	e41Ry3bxJI8EcEjrX+8vhcBUZ+f3sWayDylR/AWX54aFrK8szd+gHC36UdIjY5W1
	YZD/iY2X/8ULR8opv0q6Dew2E7zbadiCDKT/DjkhSyOkes2j4hcKwLC7IjQ7J+ud
	9fiNMQg5VKrrioElmG15OqLASJyMl+Gw5OfYYPY1vjhR7CkWq3RA7X7sf+ILgkml
	8m6qi/ZWs7M7qLOR1K7J0/G9S0PJ2U50AK3omBhMnVNAkb3ZhkJ3a+zx2wVSmCW0
	yGMauVRRODjQA4LG1/rTm1hv/3h4WWniSiRDF9TX4F2hBa8jXrq5mLuzQA0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737028143; x=1737114543; bh=4a3Cb289gB8xwkJrX44j+xp7QHifMZWz6c6
	E8lvx5i0=; b=a3gXHF1QFkHrYOBzzHMEypq0wfF/NCOzipGkgy/anCP+4na1yGw
	d/CA0LU7lgo1jW4bi2sXfeuc2vH7fB2p1G8Zc/36jrtcyTHMD1oqv0YIQ4w9Jr4N
	wPfMr59FLR9ovM+kL6QIIQXbgMrGFoF0FTXVRSokdkz6tifcMAuUNJ2XxpuoVIqm
	TrIpEeNIs7xG2QmzMZhSzkcw5tMX1GdW55s2qajETntvWhxLYpQ++8yUjcc5cfby
	jHFl39kmWNm5PxWYLEqLJ8YeywR7ef7wDnhsG4nnsV0iYCz2lvM6vDiNjHDVNggQ
	pss3sQ9o/EFEprVnYg1XQbj+smGbibf0S+g==
X-ME-Sender: <xms:LvKIZz-9OsvRYCcIApL8WxzxnPHT4JE_A_RU8v5a3OXvh4qwengLUA>
    <xme:LvKIZ_tJE646uuQkYCZ7T_X9kP0VbSBsunp8IPcoN0sHhWHZIVhhM917DYaHYM3HV
    6QuFtHMREH7MrGXUg>
X-ME-Received: <xmr:LvKIZxBackcv4YG_vVoH3pbecNlt5VZGVIQI9JhRlrRjPhQf4EQPVC6EeXjfudi6OblFyQepbKzaWrE0Egp-T58fGih28S8MJ4gamJso5eAJW8Zbqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:LvKIZ_ckPlSAbNezNNe881pjbmKfhXFJLnXx8qoMT-E9K4C6bDxXvw>
    <xmx:LvKIZ4NrozVPNLLAJl_m2X64clWS26UX370kvciNgtCpZH7BN3G09Q>
    <xmx:LvKIZxkV1-Dl2F4ZxkOjUV6W39PKRp6WLBXAz4YNJ9M4PIBoCSOMcQ>
    <xmx:LvKIZysDMowzwmmnFVdrnDE77HxyXwkGi3kvrgX4RoAEIYXfcBCxYA>
    <xmx:L_KIZ300jbUzxceQiRqDAdR-K8h-hCvokufzItQeM6uN71l-jKqM0Zhe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 06:49:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 185ea26b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 11:48:59 +0000 (UTC)
Date: Thu, 16 Jan 2025 12:48:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/8] csum-file: store the hash algorithm as a struct
 field
Message-ID: <Z4jyH4yIXuD0vuqQ@pks.im>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <99cc44895b57cc75fc8f447000817b3595368e4c.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cc44895b57cc75fc8f447000817b3595368e4c.1736363652.git.me@ttaylorr.com>

On Wed, Jan 08, 2025 at 02:14:35PM -0500, Taylor Blau wrote:
> Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
> and call its _usnafe function variants directly.

s/usnafe/unsafe/

> Prepare for a future change where we may use a different 'git_hash_algo'
> pointer (instead of just relying on 'the_hash_algo' throughout) by
> making the 'git_hash_algo' pointer a member of the 'hashfile' structure
> itself.

Makes sense, and it's also a good step for libification. I wonder: does
it mean that we can also get rid of `USE_THE_REPOSITORY_VARIABLE`, or do
we still depend on it in this file? The answer is yes, as we only reduce
the sites where we use `the_hash_algo`, but don't remove it altogether.
That would require the caller to provide the hash algo to us.

Patrick
