Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEB272908
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315403; cv=none; b=EFl093Yg0dSFb4Kbirt6N6tcL65yQ20xzAsXdeiwRbP8F66kFwsGcBIEZObMmA2oNAInvmajHKZPbt7BS6PXf36N+2WeRL6aTaA3olX3CgZnao1uJ17egFSlh+PU2MS9cgGM23qhXvSLji9ldkhzf/i54HJYDh4ZWtrVD3/6YGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315403; c=relaxed/simple;
	bh=fs0OOBlWO+0uYdbKf5z50hjGL5a/YMbr6aJl9G46FLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAYnZW/TxEfSyQz122jwZwk55WNrOmSlXylNSitwyIb7+qL8b94cHYVSkdfGch7W2NJAQeZ+dCYh0altrLFl2YII6SLwLDfA41Ml29NeQuE2tk74f+3AB79HkEaHkw/a2qYbGNhHLJ18RV80Xww6RFe0UeTYsU1uqjvdHmSqWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tr7RnE+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4MtnQnA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tr7RnE+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4MtnQnA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5132211401BA;
	Tue, 11 Feb 2025 18:10:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 11 Feb 2025 18:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739315400; x=1739401800; bh=UNV/dexLil
	fQWG+deGPtqOz1+Mm0OXaig/eQzoUsvfM=; b=Tr7RnE+HlX5si9V4n3y2k+SIle
	xD/s1LTrx9d1lx9J8k74Vk0r3Y3e3UK7QBGX4V93LH9VPS4xjnNof4eV3ZdGJb9O
	O45egeqdRKDL7L06NJUYt52DR3zDzHZA38QvmaJoKimAy/YTOFTiIAg8ilTWtBeI
	6nCzrBvWky8iqHc4qASavOFCR/YKDC3m0Gl8ZuEPH2NiHRBtCzwivlXtTcJxzh1c
	IXZqC45wrmrAJwe5yQndyoW7dRSdlmNlWDpSW7QTL1vf/YWxeGfgLL+tnbEh4pVe
	134Ppjbl9voTERRVzqpKxvHaocUESTERncOc8x54tDcekh4cSC0OIBw890sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739315400; x=1739401800; bh=UNV/dexLilfQWG+deGPtqOz1+Mm0OXaig/e
	QzoUsvfM=; b=B4MtnQnAJUs7Qc9vC0yAZprcZFCgvwVLLm9ZkBbjcQEvzgCHokI
	VE+Orc1aAZ/0kHp/bv3YDQ8BewKVYB8jj4eOs3vELxLY2xisy2XQcGuGRlYQvgMr
	eynoqRJZN8e2BZkPSue3L1/D9cxReA/+BGS78oaPMts67jo3ZYxoAAv918U9sL0Q
	d99Uo+DzARIAbezwOiOdnjaLNrZLinkpCC52FGErdqM9DuAD6A6cp743gNCpWZH0
	+kvySYA3wT77KrxhKkpzt2MNCzLhiiqRJg7Phkh8wwOKNUrm3KdIWt1fOancSZvI
	sp6NkVUBRCgZ3Q7J/mC8BgGkAcmgrhf6/zQ==
X-ME-Sender: <xms:x9irZ23vBjHfk0RtRXy5F9CW-oomqjkNOoaqZy5YFjtSMPl_R9jbSw>
    <xme:x9irZ5H7gaGNu_053XEFgLOrA-rV3ob9b2_WQ8uWxhzT3N7PVoL96wtLm-Nv89sdW
    bx8ICqoKSOIk1V9lA>
X-ME-Received: <xmr:x9irZ-66aCt889IiYTqLXTGPMC1NxsFvtoU_IH5YZ2aAX8XmPuADWhgQ_GtmnpdCUzDXWKopck3cW1nxogKQNu7ysXBBjOn711plJHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehfohhrihhvrghllhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x9irZ33X1I8OqT58dFzW6aMCMDDIM_sIYbdpF1iyHI3ou2eANN5FAA>
    <xmx:x9irZ5HSucBiCqn2ieq8TK1zjsEnF4o8L6fX4flb3d0t11O1t-jt1A>
    <xmx:x9irZw-K317dSqFfs7r2T73ocqBho6tplrdWhU1HcNYXORxE-Ez1vg>
    <xmx:x9irZ-nTqPVu9CbWaD5VgrDhouY5EOfRLTnedMfG39uuddrOMSMrLA>
    <xmx:yNirZ-4Jc4lm06OUbG9KGzQd0wVGRGoyiUdOe3mA7bbpMcqlF2ooYvG6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 18:09:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Emily M Klassen <forivall@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
In-Reply-To: <20250211212909.GA3113114@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Feb 2025 16:29:09 -0500")
References: <20250208061702.88469-1-forivall@gmail.com>
	<Z6sCeYmljrqWRFnS@pks.im>
	<CALnO6CDHZerHKaWwGc-9CmwEMiFVY+Ds5-GNWYKUi1yO7=U_Rg@mail.gmail.com>
	<CALnO6CDdJ4abqxZKMaevPO+aCzSqriM98JuVOX068gQrxWZt5Q@mail.gmail.com>
	<20250211212909.GA3113114@coredump.intra.peff.net>
Date: Tue, 11 Feb 2025 15:09:58 -0800
Message-ID: <xmqqmsesw01l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Doing that shows that v2.37.0 is actually bad. And bisecting shows that
> it has been broken since 087c745833 (log: add a --no-graph option,
> 2022-02-11), which is not too surprising.

Yeah, broken from its beginning is usually how these kinds of bugs
turn out to be.

> I've also run into non-determinism when bisecting like this, because my
> test command depends on the value of HEAD. The best solution here is to
> just feed a stable tip to git-log. I bisected on:
>
>   git log --graph --no-graph --patch origin >/dev/null
>
> (I didn't need "-2" because good commits failed with "unrecognized
> argument" and bad ones were killed by ASan immediately ;) ).

Thanks for sharing a good tip.
