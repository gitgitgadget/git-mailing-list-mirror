Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573F265CA4
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541724; cv=none; b=ZDEIxw3IFGHFsvEFewty+Pv/XoNH/xCaR2iVzzw06UUjOLBqHJjC2b3LkK7n6/lAiN+FZagNnTh8PllnEiKHcgmq8+YO2kMw7fWlK4SJpXAs1xAzy98H3cFhw/iz5l5qFCaPNTpGN3AfW90ACSiqQt06HnPKrT1H6QTww0hcJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541724; c=relaxed/simple;
	bh=MVq8tU+Zzk7uZvVNYNA80lHQc3C5ODQ2lIk98dXpSGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FCIGxJFqeOySB6Wc/cGDbfVCXUwn0oHrb+loRiQgvyRxt7YFXmBw84T1v/2QHc6mu/D+g6bvbPB8t4SFwXsCY5/TPZnt2w4R8MG1aeKXVmPMcDjRyDtWyIKb2yYRR3+X/rWKpicFOJpIOq8CkfRAvLHcZ8Wsd3kpDYokXgWafyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8GPi0nF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oaBJ8erl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8GPi0nF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oaBJ8erl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E6332EC0122;
	Wed, 15 Oct 2025 11:21:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 15 Oct 2025 11:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760541719; x=1760628119; bh=MVq8tU+Zzk
	7uZvVNYNA80lHQc3C5ODQ2lIk98dXpSGc=; b=M8GPi0nFKSwzx8uWPE1zu0UPpF
	vhygz5Ru4eUaqHEyLZSSnBU8MEChbi18GfrfmJZFOOWPc+fI1T9wjL9Dck4/yfqH
	B2aijeZzNFEBLJO5vd8qk2tWNzXWuUf6ItUb+m/ipaWOA90/Zyxt60Xqo7UyKxQ7
	v2ieQKMfxeom9WgOvwJW3YygIyBfDm++tnnlz+ZGkZ6tcKAMURyU9xVA+C024gD7
	3BQYOv4g1sumzwWbEWxvmVe4JbKpZVhon8QCwBgj+ASi2KZ/YbwnogLoaaQH1I4B
	Hn+CseHPK9lI+7pZYGLE2OihQTo5OJLf4GEmlL9vET5PjcO4dB8+rsrMrLUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760541719; x=1760628119; bh=MVq8tU+Zzk7uZvVNYNA80lHQc3C5ODQ2lIk
	98dXpSGc=; b=oaBJ8erlxmR5NceRVhI3s7Py/uvIrOQXj/vmD8oqC6LAVWVn9G9
	GHg3j1NmWwv7Ym0KjjZX8wJWUQ7jhSopyMfCWyhdTHZW0wOJhZAKFdsaoBYVV2jk
	yfAnTfOA9rJDgdbHq8xv0BrYxSF/OTkWD2Qljzgu+SHFINTvRGSJ+R4hK0U1z305
	rwyryIj8PJBZKfz3FHJzmrPyeailJZB/aLGfMtPSW8H8/GGe2A1h6wNbP2l+Wdnb
	DzCYd8C46MAsbKFAkb1mloGOPIOjnb/3He4H1CKhA/6QGvaOuI6FHQl/b0OiZCJH
	Utrv+wGkivi8chSKKAIJxuBJdZKSO5KKZKA==
X-ME-Sender: <xms:F7zvaKvfs82XQuQ7Sb12Tt12ODxcmFlBAvh6lX6N_S2gCCkavRvP4A>
    <xme:F7zvaCC-4d5qujmQeyY5sNea0vgCCNt6ADzhIeI9UkWCT_0sDkjoEhaCYJTbgZdaB
    cpG1QHAfzwB9VEAMStfsJdLJs9-KVY8mc07SgnGxTC01SvJhckQ16o>
X-ME-Received: <xmr:F7zvaJaIjEN7211XVCah2Q0-pUwyz6U1-ZRMVgERKsq4p09MgfoDN5IEpP4tov3C-Z4nfx9JD-K3cYdvvn1JQQy2hVAbvk6BbfSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepvghrihgtshhunhhshhhinhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F7zvaFWhYRGqgO6HkJLNY6sW0POezsaPcYhne0uGOjZUgP45ePpqJw>
    <xmx:F7zvaAM_YA9RxbQpikwdPQ99__z4eDh0IdMjQkYrl2BqXnBrkficfg>
    <xmx:F7zvaHY8_cYX_xi3n9j7KFhC2zbLRk9qCB2A1Prx3L03imErPinYxw>
    <xmx:F7zvaH--8xdsfz4ErAC2ogkMAyX35M9hTTi1e9OawsMFnKwEktoB-Q>
    <xmx:F7zvaHc3Qmy6jKYRcQH70gZk47Q0mWodDjkIpPSCGMNRU1xNGtArev45>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:21:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>,  "brian
 m. carlson" <sandals@crustytoothpaste.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <ericsunshine@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] ci: improvements to our Rust infrastructure
In-Reply-To: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im> (Patrick
	Steinhardt's message of "Wed, 15 Oct 2025 08:04:04 +0200")
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
	<20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
Date: Wed, 15 Oct 2025 08:21:57 -0700
Message-ID: <xmqqy0pcur56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this small patch series introduces some improvements for our Rust
> infrastructure. Most importantly, it introduces a couple of static
> analysis checks to verify consistent formatting, use Clippy for linting
> and to verify our minimum supported Rust version.
>
> Furthermore, this series also introduces support for building with Rust
> enabled on Windows.

The updated structure is definite improvement (although I have no
idea on the Windows part, but presumably that has been written for
and tested on a real Windows box).

Will replace.
