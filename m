Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CC33A015
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876199; cv=none; b=OX7XLOYfeZYCmnvJO+xCTAHuC4YxV4TMF0DlI9BYHkNOIPtH49Xo3a+YPZilPIB1dNC/MGeVkiYeUhNB3tyc/lLHUVToxGT552i/CnlmKSPNkLUZu9miOjnbvitinsxjmjRHsNjPGuyVBbbEOXWjRHaIQFndkpM0uA6rkrUHDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876199; c=relaxed/simple;
	bh=Wr79nHR7Yx0WZO7QCEXmAHy8t/WVb1hTSWA9z4Vx8c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3S8JrvivfCYc60T5a1fCvmcZfY3EPzrx1m2+EWpAOVb8Sb6R7WLdmT+0+l7l8yVbvGXJhXL52uVVjo3FWghKo+p0Nr11Io6tmC1pf7T2SI61/9X9NBpKgWc5u8JVfF3hOwi/5A2OPFIqqj7kThq1QhhbCyrTdW2/wVaxRrw6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v0wSDlWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZgrnPtg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v0wSDlWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZgrnPtg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7570A1D000FA;
	Tue, 16 Dec 2025 04:09:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 16 Dec 2025 04:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765876194; x=1765962594; bh=Wr79nHR7Yx
	0WZO7QCEXmAHy8t/WVb1hTSWA9z4Vx8c0=; b=v0wSDlWA91H79g6D3vQJN5iz2k
	AtQyt+dxhgFbkzU0CJMsLRtM6ePw3MeTnOQRn/IVJ235e3+s0S9ESaXRyBcZS2fo
	IMyKB3Y8VIc8sOPfgnceWGt3btwmWN2g0YMVxVRszVPKBoaNbZATJs2iBztIS35G
	dz7HAz/GtTcDTD4GW0K4h3w8CufXbNHX/77Qy2mO44v51WgKN07saDIAZqTIlL5t
	LpCFLcFQLK47ufTHihf1e30hizYQWiWZqrgxn5zqQrkzq4LGvmC1xrgNOJOavbJG
	uAZuzunXVnD79vCv+u0wBaEa2wJbG5Hct1DU0KjwLp3Wn7Og1baiVQV+Lpjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765876194; x=1765962594; bh=Wr79nHR7Yx0WZO7QCEXmAHy8t/WVb1hTSWA
	9z4Vx8c0=; b=MZgrnPtgNb7YSjZRYonnmQcUSJNg9D8kQuHeVluBnCOYqqmreu2
	mpdqsTgyjJV88xETW9LdBfL1j0xzV2M1ak9pVRWHmq8H8REHgdAXYp6uInah3Iyz
	8RMc1tXUQ3MROaJYijkiV+Lwkvh2pdf9crWS23hQXNveBYCWcVThVY1ZKiHhFGlp
	2MAGLKQ8hNg3cX/ct7zBbh2JvFsFR03Ysn35aaU3aP9FrLVhpQhRRERJmkZEYiCY
	1IkHP/dVx40g8QzdDzHIxgG3a8yx9CgqsqO+MAlicUzWutqzd/lDTJhjmBwRvRtw
	qlBOEK4Bim6ncFo0IwUGwhkIprrYcGrzicw==
X-ME-Sender: <xms:4iFBachKKJAvusIQ06OZas59e6pKH_ZW1DQ8JFKX1J1ogP-VFxbLag>
    <xme:4iFBadOXKbcTTZYqM-ukNrvOE2-s06Cb3DB8p9Ju7L3H3AtOglxdGpXKhwtDa0suc
    mFO9lQCbar7taOY56w3sRPFRWprK6lJHQdvKio46pejNVOhdza7>
X-ME-Received: <xmr:4iFBafr4G9W_q62cO05LWHDjFNtIAfp_7B-Ij06b0RNPeqZTgKHcfIxsxRDJOXAuryyRvUPoGuKtlMiAaKrgusP-y4mw24pk6lz2bnN36g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefledvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehruggrmhgriihioh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegrrghr
    ohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:4iFBaX4kipN9y_mxqlxJw0Ynf1ler4QYkUSuIwXuYH17CkMcgEoaFQ>
    <xmx:4iFBaVgBEc7RJBOXt5AAlAe__cgjip6RCYL1PJIyaAy2n8doLOx8wA>
    <xmx:4iFBaV51d4ho4uqkJCWP-TrXl_alJWNcGgRIqIrT_9yzjKNfCDRLSg>
    <xmx:4iFBaSGIwvQMk_pV2MpSK1US9Z4xJ_KqCUGLPraidzM76hJxzVdrSQ>
    <xmx:4iFBaVRrWNMFGXFv5EuiZeq_pLaHNjyHo1E28GHT0bmXF36mIqnA7Q6z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 04:09:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e08c1fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 09:09:52 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:09:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 05/10] submodule: allow runtime enabling
 extensions.submodulePathConfig
Message-ID: <aUEh3X7Vy4yhOC4B@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213080817.347922-6-adrian.ratiu@collabora.com>

On Sat, Dec 13, 2025 at 10:08:11AM +0200, Adrian Ratiu wrote:
> This adds the ability to enable the new extension via a runtime
> config to avoid having to enable it in each repo configuration.

I think this doesn't quite match what Junio and I suggested.

As far as I understand, this new runtime option will default-enable the
repository extension in _all_ repositories. But this isn't really
something that we should be doing, as it means that Git may now respect
the gitconfig even though the extension isn't enabled. Other
implementations of Git that don't understand the global configuration
will thus start to misbehave in that case.

The second issue is that the option will cause all existing repositories
that have submodules to be broken, as we don't have the "gitdir" config
key yet.

My suggestion was thus to have a global configuration that causes both
git-init(1) and git-clone(1) to automatically set the repository
extension for _new_ repositories. This allows developers not worry about
this in the future anymore, but it means that they will have to migrate
existing repositories, at least if they care about the extension. Which
I think is a fair tradeoff.

Patrick
