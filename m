Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C242194A60
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735570471; cv=none; b=frrrLxUcCWMHuTL8TN0Usvl2F7kH6CpnF1TeF8gjJXk3d+sRbUDz7in4v72ywpXX8S4dL5HpEEKyWgrlJabfpW7DLMqLmILZpNrByyVeMJizeyGSu4mS+4ZmvBaWLn7Og3eVQLhp8q/wfqA1YYwHENEpjnOxHPEpM7biS1eGOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735570471; c=relaxed/simple;
	bh=eWo575pxLnaqL0UZlw6KIOuWU9Wr20xi9DiSD+bj/2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KiGMYB2h6akqJeyN70xp3LWl8fQyJiNY6i48Z0y+OwhwgcYIjDE3tRy/Zdu9reNrMXPJQDMgwlh7YVYuow07KRMU2hXPt5THk1jl3FTDY4JZ9hf2dZK/qgzy9l5mP5Fy1SzYOzC+JMTM1qorQmmWSXtFG8Dwp7Aju0O0R/vImaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BSgDXsrZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTkXBPSh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BSgDXsrZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTkXBPSh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06CD611401C6;
	Mon, 30 Dec 2024 09:54:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 30 Dec 2024 09:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735570467; x=1735656867; bh=xnvy1todGx
	5wlqra+krVPi9B0CGAh8p1z8cfqPyEWJI=; b=BSgDXsrZSkNmIivWEF2KRLXj9w
	rrUIIhTFIqTVVswmGS9tmwepp1VcO/67QAQhy+a738xxmMJMj0ATHHoKeqcuzgZ/
	IWLF81vgRNpP5xM9Dy+V82pnVQXSN9lsYoKF+vELWuJd2D+mV8009D1lQGwL/9r/
	dS1edS1/MmijAFNHx4VdznTALB4AMvLFMqQFaX/svNm01TPUjKWqwEt1ja3YrOci
	ZJ8+ha0c9Ja7tgRBPX5fbtG3UbrGhOzzdkstv1GaeIKRfw9R56g0o9hYXOT+5Xfh
	z/kicDspfHTCaadxKHT2vo9DjJGXSGodCkk0Wlxufk3K9hPkxhLJDjsyNqeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735570467; x=1735656867; bh=xnvy1todGx5wlqra+krVPi9B0CGAh8p1z8c
	fqPyEWJI=; b=lTkXBPShlF8d8FYFShnf3GAyixABanRdSI/wmod3MauXzL1fvwJ
	2W5JNTvrBvNkCU87uVZu8Fz61LqbvQ0ECkm2hQN64DQYdPnrFWxfczIMwIuHyJQ/
	AF5hIxQsGDgyH9m8Gblhcj7wDuyddmFtnkUhvOQEeq6Le83JT2LG1YkJCnrhUgr9
	oqOA/HYPB8DKtxMNkjYqCUubcoC4oxaRcxsasQg7hJDS18Qp5/xu7PmSGOIDY4n0
	X6/UnCWt1pGTp8HgfQ5Offv4a0Am5WymynyCrIXqUw6nSgCfnqhJFkECeUDKyKCC
	oOg6YhSroiPhyU7xMEhXhELGMwt1XUTaqvA==
X-ME-Sender: <xms:IrRyZ70uiPt_-H5qHqHsM79590Xhvs2TUoCvBCFKNLtFfqLUjpeq-A>
    <xme:IrRyZ6HQK7drmOmCEZCOLX68PGdr9WHyvOsClsoLVp3UXJHC91HxtXbkQ9wtXPbnw
    RkfwUW4qZpABcKo1w>
X-ME-Received: <xmr:IrRyZ77S5ETA7FTEMpkROmCTlowmTVCQPTNUmJFLuTcwnzOpzkCYBMSKCKPbkugw3eRyuEvkRBuzQWlgpwLehCXqSdxD-lGZPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IrRyZw3bzzoXlh9oJD0WDXyFHfne8K-g3ok5niuBnu1pNeji_gPFog>
    <xmx:IrRyZ-G2jTtZ65RX_u4y8e9KCWKANqyoS4wapwrWs2aMcz9QIUulNg>
    <xmx:IrRyZx-g9-OnQ25XfcURdgadSJ5JNWw22njWOh6vNfwS0jUAYv94mg>
    <xmx:IrRyZ7mYfHvKo31vbQ3Ix2M_FU_myRRTV0RfSQyCd5bhLcg8MPq6oA>
    <xmx:IrRyZ7PuMuDH-ZQgqRquQhLv34xTEHh2DhvDVpnKpBJmv4cg0_ghLm43>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:54:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] object-file: fix race in object collision check
In-Reply-To: <Z3KzHJagr_3Fkz67@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Dec 2024 15:50:04 +0100")
References: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
	<xmqqy0zxz11m.fsf@gitster.g> <Z3KzHJagr_3Fkz67@pks.im>
Date: Mon, 30 Dec 2024 06:54:24 -0800
Message-ID: <xmqqseq5z0f3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 30, 2024 at 06:40:53AM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > By definition, two files cannot collide with each other when one of them
>> > has been removed. We can thus trivially fix the issue by ignoring ENOENT
>> > when opening either of the files we're about to check for collision.
>> 
>> Thanks for digging it down to the cause.
>> 
>> It is more like even if these two files collided (i.e. have the same
>> name based on what the hash function says, with different contents),
>> when one of them has been removed, we have no way to check if the
>> collision is benign, and even if it were not, we cannot do anything
>> about it, isn't it?
>
> Depends on what "benign" means in this context, I guess. We can only
> assert the most trivial case of it being "benign", namely that we have
> computed a packfile that actually is the exact same. This is also going
> to be the most common case, as everything else would depend on a
> cryptographic collision of the packfile contents. And in that case... we
> cannot do anything about it, yes.

Yes, the whole point of this collision check is to notice the rare
case where we are under attack with cryptographic collision, so
"most of the time it is OK so not being able to check is fine" is
not an impression we want to give readers.

> The idea would be to only handle ENOENT for the second case. But in the
> end I don't think it's worth the complexity because `check_collision()`
> is used before rename(3p)ing the former into place, and that function
> would already notice ENOENT anyway. So we would eventually just die the
> same.

Thanks for thinking it through.  Queued.
