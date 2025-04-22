Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000CD10A3E
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305374; cv=none; b=PY7fqqKK8j+GNF3m3hC+dAeivT8+CjnqeWsLz+JikoU1HjNez75f1dSRJ5VDAafreUgzUMG4ByhzWBCsLRdn8kcFJiiazeSQhmz3RTxsaJJP6npt/S0YaDK3bqcqfwggBpK2bNrs6j6chasrZ4t9s+63bwdfgiT9jGlehFGn6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305374; c=relaxed/simple;
	bh=GT81iTTkt81GaPRwFcwRfAwDE7j6ol3lfylTbFYq2BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epAuTCjfBxyH8AezbV5QtsOjx/x8WCLfLDpuCKK1HylVdnTqpVX/FLWqHPOU/8LDzrufhCThRtV9rHL8iOhe7IhsbRZdP73RqLu22vn3iC+pFG1FCs/3bY1ZkaLXawTLRYo4w1d/nKU+uJpDaFSFnqAMVoW0bMI15NJtha37v/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qQ+OuSEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=En3d6BnG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qQ+OuSEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="En3d6BnG"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id EAE2B1140195;
	Tue, 22 Apr 2025 03:02:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 22 Apr 2025 03:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745305371; x=1745391771; bh=zP3iSn4fP3
	fmzC8dX3cKXoh7KXKES7hbG375nZGG05Q=; b=qQ+OuSEiizWkrxF4zC/j0I+Dbt
	Gwr5kz+sPd3W8uKDaIhxyODNNUm861usRLpyWiQ+7LpgrcAYCDbmm5h9QJyss0kY
	Qvv4/SvNGFCqadS+AubD8xzzbYjE2LvA2TOoxHiDh1OhbRTp7gADOmrZoCYoSMrG
	GhOlcQLi14JIivv6rGb7Wxxa0/OCJF0i16XsGrt+O7C0NDnJGs3f4jo96kkBoHxJ
	OB5nXdFo/T5+jrk1w/1NPl2QerIZFY7Bv/sBFjujOW29qljAQVv7Tk07GgOrexvZ
	3FmPucYv4PUDnje3zscQGqj/qKDiWbbaazzNy9QlC6YOKfDgs+h9IHCFXmfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745305371; x=1745391771; bh=zP3iSn4fP3fmzC8dX3cKXoh7KXKES7hbG37
	5nZGG05Q=; b=En3d6BnGqL+XOCONRH2K7lKnzLw7cYCGDselO4jR+MNNjkhmZiY
	kijEsNPUk/eSK8szIvoooCKy43KBFmhNP/CZ6okn/eWZgVJt+4Ro4QbYDWQjDGCf
	J0GUPjMJjYY6f8YvNSkiOljQeT4BD6OOB1fHuyD69kQcCitH6L6eLVjVNs1LyOh+
	orMZ5UFZyZNrd3LfbxnIVinylTghIOyyGaCRdVjO+bPfrJevZLMvf2HVhAcBnn0v
	9LUrNSajvpkkP3rLxPBHIeJ/6bqpoxqVJm1qGDxfAdCjMWkfnThPoaDTirW01cqx
	Vs6Y7AYdEAewjEyg9NheDczNE6RFcUd4WEg==
X-ME-Sender: <xms:Gz8HaGF8Tj80XzjesCImBYCATZ-NE4cRfD4R04WSkpgLDySftxBW9g>
    <xme:Gz8HaHU3jIdubWliR9oYCLCu3RgUfYD9m-uR8txDgvsGaJRFqO28CuOuneoe0XU5j
    8698JWru_2evqMrYw>
X-ME-Received: <xmr:Gz8HaAITwz0yml2YGSEXwjadMI_cVygIQT0h4Jl_cIaQEXL-vstS40ZAnrPZ0iqfrY6MZ6dKko8s3WgmdMvnf-7d_fM1z93CDPxEZ-jzwTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkh
    cuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhep
    jeevhfejudehgfffhfehkeeiveduieffkeehfeehveeuheehuedtieevfeffieejnecuff
    homhgrihhnpehgihhthhhusgdrihhopdhgihhthhhusgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhs
    thhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgr
    rhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtsehsfhgtohhnshgvrhhvrghntgihrdhorhhg
    pdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhhhigrmhhthhgrkhhk
    rghrtddtudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Gz8HaAFQ3hX56p9UfB5K35txoZ2fnDiAzqNaCr2na6Cbbhb0gvyg6A>
    <xmx:Gz8HaMW6uOaJuE-MjYx2AMLO0FBBXPrFg_GPZrHAlHjx_ap0cwvvMw>
    <xmx:Gz8HaDMg97hWVAWdJOfTX4sZYQ6hko9PEuVTbvLFOcRH5dUT6ev7VQ>
    <xmx:Gz8HaD0ZyCNw2O6fIlJyyFCTbNJSKwQXTn0Ga300agf_2a5CFEDzoA>
    <xmx:Gz8HaE6vwMRCQSu2PqV0CxWxPiK_fK_45gayKNeOV3NPea0xvvChQr5E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:02:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdc97d79 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:02:47 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:02:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jialuo She <shejialuo@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git at SFC <git@sfconservancy.org>
Subject: Re: AI guidelines for mentoring programs (like GSoC and Outreachy)
Message-ID: <aAc_Fp7HFXydrHkq@pks.im>
References: <CAP8UFD37_qsTjM97GK2EOWHteqoUKdwxjKS-SU629H2LnbTTtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD37_qsTjM97GK2EOWHteqoUKdwxjKS-SU629H2LnbTTtA@mail.gmail.com>

Hi Chris,

On Tue, Apr 15, 2025 at 11:21:53AM +0200, Christian Couder wrote:
> Hi everyone,
> 
> We now have a new "AI guidelines" on
> https://git.github.io/General-Application-Information/ following some
> discussions between GSoC 2025 potential mentors and org admins by
> email and on https://github.com/git/git.github.io/pull/771.
> 
> We came up relatively quickly with these guidelines because this year
> 71 out of 79 proposals we received for the GSoC 2025 were spammy and
> very often AI generated. This is a significant increase compared to
> previous years. I remember that a few years ago there were less than a
> dozen spammy proposals. We also received some AI generated spam
> patches and emails to our personal email addresses.
> 
> Other organizations participating in the GSoC 2025 also received an
> increasing amount of such spam, and organizations which documented
> some guidelines against it said they receive less of it. A large
> amount of discussion has happened on the GSoC mentors list about this.

Yeah, it's been a bit of a pain this year indeed. Thanks for creating
the AI guidelines, let's hope it improves the situation.

> Let us know if you have an opinion about this, or if you think that
> the whole Git project should have AI guidelines.

We (you and I) have discussed this internally and got to the conclusion
that it's not needed for the Git project as a whole at the current point
in time. We haven't yet seen any obvious issues with AI-generated
patches on the mailing list, so it would probably be premature to worry
about it now already. We can and should reevaluate though in case we
ever see an uptick of slop.

I'm of course happy to hear differing opinions.

Patrick
