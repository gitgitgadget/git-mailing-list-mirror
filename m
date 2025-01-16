Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E186323
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048486; cv=none; b=EIDrE7e30+/j8mZBYAWfU0YY+mhm/7OfTwazLOWs4Uzsgp75e/exU7cksOXkMxl5OciQPny6IVG3qXy6MjvMEhRW6Hw+YKbofnClyGhioX/fqiqT//9LoK945gYWbaeWc4MWJ9Vd2NuapWGsqTGYmx7dULJRv06MXtiQSpjrNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048486; c=relaxed/simple;
	bh=bWiDzAPleCSKuJ5QJPWFikaaymFaOLyxzRPeEFWcK/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJhNNUf2WwBB0RTRQ/S0I8qVpB2vkyqQxIM4gPI2h9kdHwABXVqykuWdynuN6h/JajfWGx7H7trzAxx0FiVmW+gRkxOwJoaNrbfqOAU/WUoXOgqNt4MaGswORWaQFM5lVT+pC4St63rosE/6qLDUJrKf3hFJLPIPtTxW2yvrDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0PS4GEiy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOfv03p5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0PS4GEiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOfv03p5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C41D811400C4;
	Thu, 16 Jan 2025 12:28:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 12:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737048483; x=1737134883; bh=UoemgpyVG7
	No5fh3ZQaw2LyyAfY5e99QNav/osHTL+A=; b=0PS4GEiyDrBckWoqy2ICcWBnzB
	gKbtj4lVsJ6BCySWOBED5xb51NbPYTWPGJpzQYtJ9237UzOho0uqUBsXn3XUvjDb
	Byb5PS3OmJPYq43fpWKUcRi5eVwPK8T/LOF8bc3Ju+/U3fajkERxnU3Tewuk1nYI
	Sa/5b0jK6vd/yfD/GATbk0gpf1PvM1ZC3DsMWySmgvV+aFC5/VEDSgQaLY6APUI3
	F/eDYFE3T4UkzQq1K4wqsZyhw5Repj2h8E/LrpL2KW6966bUPbg66hmZvZxvIDwI
	whOk5u8n8M4/KchlbCLBu7+Bx8M8eLz3W7pyybIeBjF8RkbcxWuq4OVrCccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737048483; x=1737134883; bh=UoemgpyVG7No5fh3ZQaw2LyyAfY5e99QNav
	/osHTL+A=; b=LOfv03p5bqE95iSq9vKwl+cuZHIn/R7lRKJpY6er2SntsTUhOv8
	moQLicpXT7zIJBkOmjsrKBOke0uHq2Q3ViT4fEiy+5c2/dHzzVvC+8zE690lGHNu
	dZWVL1x9B2pTgTym2JdsctXZlU8E4KIISLxoePCAtk6oBEnZcydHAl6G5Q/KTdH6
	onTqhyFzlzw2SIS0joTYjqD7hjK6od1Hz9VERwfrfLoM7T6SH4Y3VuT2nn5i8dw8
	sxNKUQXL45UYwEYFWiVB7/SboRdsO0NCwlDk0PFhLaOOr2EXqNcm7CyAMoaHDDla
	CpWqWRnE8jAzTEZFJNdNP+c9LNoBsVsIFUw==
X-ME-Sender: <xms:o0GJZ6jsheaHylJrrop4WRHbIfDKpfYh3fAGR8E39vTIlsdW7Rw9gA>
    <xme:o0GJZ7DPepz5BgfIOi6BY9IQrSh8YBw9urTZTBVB8Uu2rpKrEIeOBG8d5YXdl6vZv
    HYB8Z3gr47yR-gONQ>
X-ME-Received: <xmr:o0GJZyHmggQiNtEEmHgOEFq_K5EE7g5kKMinXKAOzdakntyXdF1MAT1a72OErBdWV6aF286LPZRWu5Yt4U_7yEcTqgwt05HV6OBX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:o0GJZzQOzY_P2PEQGs1XEpyiSQlziTWRtxMGWK2HSrgBDKLAvsGUgQ>
    <xmx:o0GJZ3yIReFUBdzhGTgTYedBiE43DO2ma9tKKd5Wv4EsmmwcsmHrFA>
    <xmx:o0GJZx4hcT79arpRLuw38DZBPtXjmThLsgI_9x8LxPw4-JrMrzLXyA>
    <xmx:o0GJZ0yfMThere_Cm5M8Y3ksb0NllN_uxERnIIiSfBzANIy2U761-g>
    <xmx:o0GJZ39MJaFJbmtKl4MgkVGvgKG7YzXAcnYBIP1r4618j90xEmlV-iNZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 12:28:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Send help text from "git cmd -h" to stdout
In-Reply-To: <20250116104612.GE773990@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2025 05:46:12 -0500")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116104612.GE773990@coredump.intra.peff.net>
Date: Thu, 16 Jan 2025 09:28:02 -0800
Message-ID: <xmqq34hiu0rh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> If we want to switch the exit code for this case from 129 to 0, I think
> we could easily do so on top (it would need modifications in three
> places, but now that you've untangled all of the individual builtins,
> that would get all of them).

Yes, I consider it pretty much an orthogonal issue to update the
exit status.

> I guess there may be non-builtins that would need to be handled
> individually, though. We don't have too many of them these days, but
> they are not covered by t0012.

Yes.  We can probably leave them as they are, as we have established
our expectation with this series (i.e. an explicit end user request
for help text should emit to the standard output stream), so any bug
report can be handled without needing any policy discussion.  "Hey,
I noticed 'git cmd -h' writes to stderr, not stdout"---"Thanks, cmd
need to be fixed".
