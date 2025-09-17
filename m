Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3026A0C6
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088726; cv=none; b=jtkt+2SXZPTOOZWIQ8AkYD9aKhMIxtXrh0H0JbyESq4ZhPINeL0cdcdmL3cgjtdx7q9L9SRnZ4HtRWJ0ktlN7O1lBgWqg20TYUoSfMj7LHKRFex3Pn4Nm8WQWwjwj6ZmCymIv84MVw6Xnn9db+lSwU50eEuWy7UNCuL6qrU+Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088726; c=relaxed/simple;
	bh=eatTuSiSldaJTUikxDb07TKhDRTcCjCPg4IiDsP00Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1oLvGH9OZwG8HNxrttHzg7/TYnQF8Fhz1F3bpfpVN/QS9lER/vJwJwzb77m+iY5i0/9bb5cwZBcoXHH9ffYZ4pfhmlMj/b0e4XUhtOztYoaW6YgPB3NplBOZgl+iSh4pXSaculdAbqY5RwtuwN02pSQEEnnZK84xN9g4BGIZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XRG0pYRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLcL67U7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XRG0pYRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLcL67U7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBDA814000D5;
	Wed, 17 Sep 2025 01:58:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 17 Sep 2025 01:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758088722; x=1758175122; bh=lhLPrMloDa
	YDItWJIRnmWvhaZfIA84FG92NaSVIzIaY=; b=XRG0pYRwBwl5W3kpDt2D34CWAl
	4JZNZ6WG7+StVuvtsEHN3ap3nSELHWS8wRJ1oEQMWY3Vz5mKw54Y39qg4L4rsOKp
	Mu8h8+lSPVhoWNavZgS6VW0uZ8ibRDU6Fm91Hk2vr3e5PIPOZpsAFGw1ususOPdl
	vXvaWGk9HUxaUUSNQR5rLxzS9iHI6tpP7AeiZk0HfFhqM2NiWQJtHpPpW0IL/ffd
	Ibj+YeuNNK1t+UPXGIEHclUVy5M64TKFxGmOsn7rGIhG3gVWY2ayRgwW7ks8m0Tv
	EcOB6X6volEqOZYmDpN1RXxmdjDjvq7AYU0lQw7yJ/cvNCW8qcpmn5rLv0jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758088722; x=1758175122; bh=lhLPrMloDaYDItWJIRnmWvhaZfIA84FG92N
	aSVIzIaY=; b=SLcL67U7vG5YirtIAxRzLvo4zOTWcXivVW/TunIPcwcXU4xpby3
	h2CL/sCxPu//Y/RScoS8Nu/oN5Pu/+qvxHPhPe3kql0/jR9kqGT2c0K0w6+0T0zh
	R62aF5yDB4ZaL4yK5Qg2p6TnGMiJXEoQQUY1nnpe7R2v7P7BSj2cYuaMHyAVtbHQ
	XlRDYzebXGBeR45qv6DeT6rggrq4xu1APyszXvbM1bD3EWCJZFLvfY1NwuyvZeUJ
	Y9kTP5wR6y+Cu6u9IMZwn/g265D9re9Ez8c/QDlA63ni8AcpyYFZQoEvQO4sVFdh
	zOKTMKg6/HV8HnKR+n4IQZ8W9QrvZFT2Qhw==
X-ME-Sender: <xms:Ek7KaGol4nPkQ99n_4QMWwarqbjaaOcuGJx7e_5qVv1Cc1tPSeX6qA>
    <xme:Ek7KaH4yHSPSfALCCSo2nOL2uishaYZAmkZnOD_ARDaAHCrqr7uV9z7PkkrHwiTx6
    ZpyIhaBHap76xNxJA>
X-ME-Received: <xmr:Ek7KaEo3vucsSpUzbJHGD015RpUpBr5dBJBFee2t7AdFkc7Q-IdVr799SSpzRIJJ3fTFyNUI14dXcG2VRVSl2NZYmmKc7prZ-qDVQHVydoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eivdehleehuefhleevgedvkeegtdeufefhgfehveelgffhudeugeduhffghefhieenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:Ek7KaBiCQyA6m3ruxG_tke3T6nF0NE7Q-odujr0rWip-3TGfVExB-g>
    <xmx:Ek7KaGJ1USyPdqN3YA2-Wg5gw70qQO5VyZtvumVpbxdSIIYSOIvNTw>
    <xmx:Ek7KaJAQUK4NsSXU2ERmX9bHiJNW6ogl7Sa2H7jcaKHHwRC6JWLxSQ>
    <xmx:Ek7KaOgt565bFUpvLLwHE1VCMDaCYrMTZQP5HT_cgEEnIa-mHLia1g>
    <xmx:Ek7KaI3kCqLFujCU_8_4ZC5tJwjxh9v73q1IEjbSkqVHbQbM4DLg7oap>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 01:58:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a721cef (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 17 Sep 2025 05:58:39 +0000 (UTC)
Date: Wed, 17 Sep 2025 07:58:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
Message-ID: <aMpODEpyaaVhFMO0@pks.im>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>

On Wed, Sep 17, 2025 at 01:16:20AM +0000, Ezekiel Newren via GitGitGadget wrote:
> This is a continuation of
> https://lore.kernel.org/git/pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com/,
> but I am removing the RFC label.
> 
> Suggestions on changes that I could make to this series is appreciated.
> 
> Changes in v2: High level overview:
> 
>  * patch 1: cleanup: rename variables that collide with Rust primitive type
>    names
>  * patches 2-4: Makefile now produces libgit.a correctly
>  * patches 5,6: Documentation from Brian and Patrick
>  * patches 7,8: Introduce Rust
>  * patches 9-11: github workflows
>  * patches 12-14: introduce crates build-helper, and cbindgen
>  * patches 15-18: varint test balloon
> 
> I would like feed back in two categories: big changes, and little changes.
> Is my patch series even going in the right direction, and what are the
> little details that I've missed? I know Brian asked for cbindgen and it made
> the series several commits longer, but I think it's a great idea to have. I
> am not happy with every choice that I made, but I currently don't see a
> better way or at least an easier alternative to my approach in bringing Rust
> to Git.
> 
> Build results for these changes:
> https://github.com/git/git/actions/runs/17783386212?pr=2043. Some of these
> are failing.

Given that this isn't yet ready and given that this patch series is way
bigger than the one I have in flight that focusses on introducing the
policy [1]: how about we first merge that one down and then rebase your
patches on top of it to iterate? It would reduce the scope of your patch
series and allow us to make smaller steps towards our goal.

To be clear: I very much think that most of the steps here are quite
sensible. We definitely want to introduce cbindgen, we obviously need to
introduce support on Windows, and I guess having multiple different
workspaces is also something that could provide benefit.

But there is no reason to have that all at once, so hence my suggestion
to build out the infra one step at a time.

What do you think?

Patrick

[1]: https://lore.kernel.org/git/20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im/
