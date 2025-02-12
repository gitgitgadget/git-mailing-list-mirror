Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B520C49B
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379508; cv=none; b=Kknr9A+wlEAvNQnqRPfv+3ImW0TG1XXZCZQ9JOJtjo1IB6adcyjLX211BVXsut2IKHiHQVvtCI3hVbei8NIcTwc5JkbNr6DsXEhA1rQ4sSEhEVS22f8l2E9fdO9PXipiY2Ce5XhsACmlJf88hpc0NvADSvUPYCytbItJl5Argws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379508; c=relaxed/simple;
	bh=7hVVSjebXqY4R6zLORjyKoHRUhZWb1piXPpTiMIWWII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yb0EjYh8zvy6SmIwH3hUsWIcnnqZsZHjIqOmTYd2h4V18Pj1tZXpEMpHGA18uIyz3ytMjWHrSHcTGfqnP2FzLdA+58gg4MS1aTJ/PYbgorEsq0eZpIzGEHJZExg9BqW6We5UQkH3obwHaNXpj3aVdsHTKKpcVAHyO0ii1qmkuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v7GmzYuq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ceqWd/ps; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v7GmzYuq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ceqWd/ps"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13CEC11401B8;
	Wed, 12 Feb 2025 11:58:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 12 Feb 2025 11:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739379506; x=1739465906; bh=9ZEwJHQ21j
	ZbpcSzS+qC9djfwG8iZ2ipxwlpa4Q7+7I=; b=v7GmzYuqSM6tB352gj8iEa9oOY
	JpUJGB3GfwdqZe04LVf/Ij0g6Va9eKxq7XgwufBRTnBiuPe68/rengVRcBb9h0BX
	ZgbRLRw45CvXsiJDC0FtT+L6wK3xBsRBa9ffmb97CYwH+mXur+qZ8scE8ABjVr+I
	8iVnsIX3BPbrTNiNTi4/kOajCVO6c14H2D2vdRRIFofQvvBg/pxahTLBMOrhq1vI
	rUKnABaf+E6rdh952zcMtQmyCvn6ssfQbZiCmdrDx9QURuyWCNyXrizCiJxP+rNS
	lI4l6x7GvEzgDpLhCD2DqF1gmcMXy7Cr+6rY9XxG1uPRl/7UhvBra86WcVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739379506; x=1739465906; bh=9ZEwJHQ21jZbpcSzS+qC9djfwG8iZ2ipxwl
	pa4Q7+7I=; b=ceqWd/ps6Df9rahrHaQpx+1nmxTqew33T7T4irbklMGBFeDClaU
	1tdPoDH4Z2rAU7eC4/JkwuQUH5D/g72tL78L0zypUl+363MHaIjip5IeyMYksQyK
	jdB+/Az3UjCJKVYbr0mwgCTyBjnxhy9cjqv5tmCxz9x16FGtYLeHRb5Rd0AlI5UI
	APSJqoY3gC80c4pS2smeDCbuRNtl79Ad7W+tEZ92WlLHq0bnTrUfQkMWtCNjTHoy
	p4b5Iy5T7jl3N8PUQpPxGazDr9A2USW5nNUa5CbARPcI38b5HHnnqM66IDKvw4w9
	x6q8VBBmEc6uxDd4kDmRvjVz5F8filgxZYg==
X-ME-Sender: <xms:MdOsZ2xuM3UvgMGFaLOdHAWxPV4c5SoQHSgGFU76he9SlUEn7Q6Vbg>
    <xme:MdOsZyQoodd12fSWc0AYbNyraGO4-i7ko3QuUp33Punmc-j-NfCR0AkkvXcP4R_Bm
    xI_E_sAmHwQCKmcpw>
X-ME-Received: <xmr:MdOsZ4XHPsoLahA5aBGfv76YESYkZBZJcU0J2PX1zRFjNAe32HeGBdwpORNHeW0qQvHFTBwXGqMj3Vjn-7BzEypFGFyI5eyaR42L7JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhnthgvlhhfgiesihhn
    thgvlhhfgidrnhgrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgihhvghnrhhivgdvgees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MdOsZ8jdew30IJvB_hk-kzKN3unlJz1P58e9Sd4-XSflrA6KsRV1Gg>
    <xmx:MdOsZ4DioieMvOPS8Anw-4NmvsRXQ2P7hkxLLqtLwz6ihe9tLptpvw>
    <xmx:MdOsZ9IMwIai4UyM9kAwmFNgkFCxzodiDDc8J7zBsEirvO34WsLCuQ>
    <xmx:MdOsZ_Cyf0vAJIrJQOe-un3uItydlR1ytN5HatorMoBEYzqVhEc3RQ>
    <xmx:MtOsZ02bclcBv-0O86KftDnBGLP2jKjFUeUQ3VNh9UuIg6pd5g5MhXaE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 11:58:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ivan Shapovalov <intelfx@intelfx.name>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Derrick Stolee
 <stolee@gmail.com>,  Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
In-Reply-To: <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com> (Phillip Wood's
	message of "Wed, 12 Feb 2025 14:26:52 +0000")
References: <20250210191650.316329-1-intelfx@intelfx.name>
	<1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
	<f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
	<5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
Date: Wed, 12 Feb 2025 08:58:23 -0800
Message-ID: <xmqqh64zumkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Maintaining multiple versions of the same branch sounds like a lot of
> work - whats the advantage over merging a single branch into each
> release?

Making a single branch that would merge to each release track
cleanly, with preparing and maintaining semantic fixes necessary for
each track, is probably equally a lot of work, if not more.  I try
to do that for this project only because I am a perfectionist for
these things (and do so for fun), but I can understand if many
others (a pragmatist in me included) consider it not worth the
effort.  After all, it stops mattering once the branch finally gets
merged.
